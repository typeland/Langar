#!/bin/sh
set -e

echo "Generating Static fonts"
TTFDIR=../Fonts/TTF
mkdir -p $TTFDIR
rm -rf $TTFDIR/*.ttf
fontmake -g Langar.glyphs -i -o ttf --output-dir $TTFDIR

echo "Post processing"
ttfs=$(ls $TTFDIR/*.ttf)
for ttf in $ttfs
do
	gftools fix-dsig -f $ttf;
	ttfautohint $ttf $ttf.fix
	mv "$ttf.fix" $ttf;
	gftools fix-hinting $ttf;
	mv "$ttf.fix" $ttf;
done


# # Clean up
rm -rf master_ufo/ instance_ufo/
