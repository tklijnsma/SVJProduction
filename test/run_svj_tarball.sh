#!/bin/bash -e

$CMSSW_RELEASE_BASE/src/GeneratorInterface/LHEInterface/data/run_generic_tarball_cvmfs.sh "$@"

echo "Copying unmodified cmsgrid_final.lhe to ${CMSSW_BASE}/src"
cp cmsgrid_final.lhe $CMSSW_BASE/src/cmsgrid_final_unmodified.lhe

# convert madgraph ids to pythia ids
# (also convert a unicode character)
PDGIDS=(
5000521,4900101 \
# madgraph sign convention is reversed?
-49001010,4900101 \
-49001011,4900101 \
-49001012,4900101 \
-49001013,4900101 \
-49001014,4900101 \
49001010,-4900101 \
49001011,-4900101 \
49001012,-4900101 \
49001013,-4900101 \
49001014,-4900101 \
9000005,4900001 \
9000006,4900001 \
9000007,4900001 \
9000008,4900001 \
9000009,4900003 \
9000010,4900003 \
9000011,4900003 \
9000012,4900003 \
9000013,4900005 \
9000014,4900005 \
9000015,4900005 \
9000016,4900005 \
9000017,4900002 \
9000018,4900002 \
9000019,4900002 \
9000020,4900002 \
9000021,4900004 \
9000022,4900004 \
9000023,4900004 \
9000024,4900004 \
9000025,4900006 \
9000026,4900006 \
9000027,4900006 \
9000028,4900006 \
'\\x7',a \
)

for PDGID in ${PDGIDS[@]}; do
	IDS=()
	IFS="," read -a IDS <<< "$PDGID"
	sed -i -e 's/'[\s\t\n]"${IDS[0]}"[\s\t\n]'/'[\s\t\n]"${IDS[1]}"[\s\t\n]'/g' cmsgrid_final.lhe
done

echo "Copying modified cmsgrid_final.lhe to ${CMSSW_BASE}/src"
cp cmsgrid_final.lhe $CMSSW_BASE/src/
