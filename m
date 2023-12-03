Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4409802529
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 16:34:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233634AbjLCPdx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 10:33:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjLCPdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 10:33:52 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20283EB;
        Sun,  3 Dec 2023 07:33:57 -0800 (PST)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 423A975A;
        Sun,  3 Dec 2023 16:33:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1701617596;
        bh=sXD1x7l8ZsFQcyiLnJeNgq7HsyWjiKF+MG8pIWTT40E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wjoxpOpTHQFgviHPe90pLs1dZV/m8teb8YvV7q38daBejKqcXqG/l1LKtnj/qyxZa
         FM+qFo3lr2AJw/jWhBciUymed52R/SyWJosBYqRRc7aWOnNSUUk6UgkCwG9YxSCOSo
         NFmfMB6e+wVcBma0qS2K4WvhY1zzF+cysRRw02YI=
Date:   Sun, 3 Dec 2023 17:34:01 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Simon Glass <sjg@chromium.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        U-Boot Mailing List <u-boot@lists.denx.de>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Tom Rini <trini@konsulko.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Terrell <terrelln@fb.com>, Will Deacon <will@kernel.org>,
        linux-doc@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, workflows@vger.kernel.org
Subject: Re: [PATCH v9 2/2] arm64: boot: Support Flat Image Tree
Message-ID: <20231203153401.GV8402@pendragon.ideasonboard.com>
References: <20231202035511.487946-1-sjg@chromium.org>
 <20231202035511.487946-3-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231202035511.487946-3-sjg@chromium.org>
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_PDS_OTHER_BAD_TLD,T_SCC_BODY_TEXT_LINE,
        URIBL_BLACK autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Simon,

Thank you for the patch.

On Fri, Dec 01, 2023 at 08:54:42PM -0700, Simon Glass wrote:
> Add a script which produces a Flat Image Tree (FIT), a single file
> containing the built kernel and associated devicetree files.
> Compression defaults to gzip which gives a good balance of size and
> performance.
> 
> The files compress from about 86MB to 24MB using this approach.
> 
> The FIT can be used by bootloaders which support it, such as U-Boot
> and Linuxboot. It permits automatic selection of the correct
> devicetree, matching the compatible string of the running board with
> the closest compatible string in the FIT. There is no need for
> filenames or other workarounds.
> 
> Add a 'make image.fit' build target for arm64, as well. Use
> FIT_COMPRESSION to select a different algorithm.
> 
> The FIT can be examined using 'dumpimage -l'.
> 
> This features requires pylibfdt (use 'pip install libfdt'). It also
> requires compression utilities for the algorithm being used. Supported
> compression options are the same as the Image.xxx files. For now there
> is no way to change the compression other than by editing the rule for
> $(obj)/image.fit
> 
> While FIT supports a ramdisk / initrd, no attempt is made to support
> this here, since it must be built separately from the Linux build.

FIT images are very useful, so I think this is a very welcome addition
to the kernel build system. It can get tricky though: given the
versatile nature of FIT images, there can't be any
one-size-fits-them-all solution to build them, and striking the right
balance between what makes sense for the kernel and the features that
users may request will probably lead to bikeshedding. As we all love
bikeshedding, I thought I would start selfishly, with a personal use
case :-) This isn't a yak-shaving request though, I don't see any reason
to delay merging this series.

Have you envisioned building FIT images with a subset of DTBs, or adding
DTBOs ? Both would be fairly trivial extensions to this script by
extending the supported command line arguments. It would perhaps be more
difficult to integrate in the kernel build system though. This leads me
to a second question: would you consider merging extensions to this
script if they are not used by the kernel build system, but meant for
users who manually invoke the script ? More generally, is the script
meant to be used stand-alone as well, in which case its command line
arguments need to remain backward-compatible, or do you see it as being
internal to the kernel ?

> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
> Changes in v9:
> - Move the compression control into Makefile.lib
> 
> Changes in v8:
> - Drop compatible string in FDT node
> - Correct sorting of MAINTAINERS to before ARM64 PORT
> - Turn compress part of the make_fit.py comment in to a sentence
> - Add two blank lines before parse_args() and setup_fit()
> - Use 'image.fit: dtbs' instead of BUILD_DTBS var
> - Use '$(<D)/dts' instead of '$(dir $<)dts'
> - Add 'mkimage' details Documentation/process/changes.rst
> - Allow changing the compression used
> - Tweak cover letter since there is only one clean-up patch
> 
> Changes in v7:
> - Add Image as a dependency of image.fit
> - Drop kbuild tag
> - Add dependency on dtbs
> - Drop unnecessary path separator for dtbs
> - Rebase to -next
> 
> Changes in v5:
> - Drop patch previously applied
> - Correct compression rule which was broken in v4
> 
> Changes in v4:
> - Use single quotes for UIMAGE_NAME
> 
> Changes in v3:
> - Drop temporary file image.itk
> - Drop patch 'Use double quotes for image name'
> - Drop double quotes in use of UIMAGE_NAME
> - Drop unnecessary CONFIG_EFI_ZBOOT condition for help
> - Avoid hard-coding "arm64" for the DT architecture
> 
> Changes in v2:
> - Drop patch previously applied
> - Add .gitignore file
> - Move fit rule to Makefile.lib using an intermediate file
> - Drop dependency on CONFIG_EFI_ZBOOT
> - Pick up .dtb files separately from the kernel
> - Correct pylint too-many-args warning for write_kernel()
> - Include the kernel image in the file count
> - Add a pointer to the FIT spec and mention of its wide industry usage
> - Mention the kernel version in the FIT description
> 
>  Documentation/process/changes.rst |   9 +
>  MAINTAINERS                       |   7 +
>  arch/arm64/Makefile               |   7 +-
>  arch/arm64/boot/.gitignore        |   1 +
>  arch/arm64/boot/Makefile          |   6 +-
>  scripts/Makefile.lib              |  16 ++
>  scripts/make_fit.py               | 291 ++++++++++++++++++++++++++++++
>  7 files changed, 334 insertions(+), 3 deletions(-)
>  create mode 100755 scripts/make_fit.py
> 
> diff --git a/Documentation/process/changes.rst b/Documentation/process/changes.rst
> index bb96ca0f774b..cad51bd5bd62 100644
> --- a/Documentation/process/changes.rst
> +++ b/Documentation/process/changes.rst
> @@ -62,6 +62,7 @@ Sphinx\ [#f1]_         1.7              sphinx-build --version
>  cpio                   any              cpio --version
>  GNU tar                1.28             tar --version
>  gtags (optional)       6.6.5            gtags --version
> +mkimage (optional)     2017.01          mkimage --version
>  ====================== ===============  ========================================
>  
>  .. [#f1] Sphinx is needed only to build the Kernel documentation
> @@ -189,6 +190,14 @@ The kernel build requires GNU GLOBAL version 6.6.5 or later to generate
>  tag files through ``make gtags``.  This is due to its use of the gtags
>  ``-C (--directory)`` flag.
>  
> +mkimage
> +-------
> +
> +This tool is used when building a Flat Image Tree (FIT), commonly used on ARM
> +platforms. The tool is available via the ``u-boot-tools`` package or can be
> +built from the U-Boot source code. See the instructions at
> +https://docs.u-boot.org/en/latest/build/tools.html#building-tools-for-linux
> +
>  System utilities
>  ****************
>  
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9d46229fe21b..d2d17f0d6e64 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3037,6 +3037,13 @@ F:	drivers/mmc/host/sdhci-of-arasan.c
>  N:	zynq
>  N:	xilinx
>  
> +ARM64 FIT SUPPORT
> +M:	Simon Glass <sjg@chromium.org>
> +L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
> +S:	Maintained
> +F:	arch/arm64/boot/Makefile
> +F:	scripts/make_fit.py
> +
>  ARM64 PORT (AARCH64 ARCHITECTURE)
>  M:	Catalin Marinas <catalin.marinas@arm.com>
>  M:	Will Deacon <will@kernel.org>
> diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
> index 1bd4fae6e806..6b893dc454b7 100644
> --- a/arch/arm64/Makefile
> +++ b/arch/arm64/Makefile
> @@ -150,7 +150,7 @@ libs-$(CONFIG_EFI_STUB) += $(objtree)/drivers/firmware/efi/libstub/lib.a
>  # Default target when executing plain make
>  boot		:= arch/arm64/boot
>  
> -BOOT_TARGETS	:= Image vmlinuz.efi
> +BOOT_TARGETS	:= Image vmlinuz.efi image.fit
>  
>  PHONY += $(BOOT_TARGETS)
>  
> @@ -162,7 +162,9 @@ endif
>  
>  all:	$(notdir $(KBUILD_IMAGE))
>  
> -vmlinuz.efi: Image
> +image.fit: dtbs
> +
> +vmlinuz.efi image.fit: Image
>  $(BOOT_TARGETS): vmlinux
>  	$(Q)$(MAKE) $(build)=$(boot) $(boot)/$@
>  
> @@ -215,6 +217,7 @@ virtconfig:
>  define archhelp
>    echo  '* Image.gz      - Compressed kernel image (arch/$(ARCH)/boot/Image.gz)'
>    echo  '  Image         - Uncompressed kernel image (arch/$(ARCH)/boot/Image)'
> +  echo  '  image.fit     - Flat Image Tree (arch/$(ARCH)/boot/image.fit)'
>    echo  '  install       - Install uncompressed kernel'
>    echo  '  zinstall      - Install compressed kernel'
>    echo  '                  Install using (your) ~/bin/installkernel or'
> diff --git a/arch/arm64/boot/.gitignore b/arch/arm64/boot/.gitignore
> index af5dc61f8b43..abaae9de1bdd 100644
> --- a/arch/arm64/boot/.gitignore
> +++ b/arch/arm64/boot/.gitignore
> @@ -2,3 +2,4 @@
>  Image
>  Image.gz
>  vmlinuz*
> +image.fit
> diff --git a/arch/arm64/boot/Makefile b/arch/arm64/boot/Makefile
> index 1761f5972443..b835c0880d1c 100644
> --- a/arch/arm64/boot/Makefile
> +++ b/arch/arm64/boot/Makefile
> @@ -16,7 +16,8 @@
>  
>  OBJCOPYFLAGS_Image :=-O binary -R .note -R .note.gnu.build-id -R .comment -S
>  
> -targets := Image Image.bz2 Image.gz Image.lz4 Image.lzma Image.lzo Image.zst
> +targets := Image Image.bz2 Image.gz Image.lz4 Image.lzma Image.lzo \
> +	Image.zst image.fit
>  
>  $(obj)/Image: vmlinux FORCE
>  	$(call if_changed,objcopy)
> @@ -39,6 +40,9 @@ $(obj)/Image.lzo: $(obj)/Image FORCE
>  $(obj)/Image.zst: $(obj)/Image FORCE
>  	$(call if_changed,zstd)
>  
> +$(obj)/image.fit: $(obj)/Image FORCE
> +	$(call cmd,fit)
> +
>  EFI_ZBOOT_PAYLOAD	:= Image
>  EFI_ZBOOT_BFD_TARGET	:= elf64-littleaarch64
>  EFI_ZBOOT_MACH_TYPE	:= ARM64
> diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> index 1a965fe68e01..1c60d594932c 100644
> --- a/scripts/Makefile.lib
> +++ b/scripts/Makefile.lib
> @@ -496,6 +496,22 @@ quiet_cmd_uimage = UIMAGE  $@
>  			-a $(UIMAGE_LOADADDR) -e $(UIMAGE_ENTRYADDR) \
>  			-n '$(UIMAGE_NAME)' -d $< $@
>  
> +# Flat Image Tree (FIT)
> +# This allows for packaging of a kernel and all devicetrees files, using
> +# compression.
> +# ---------------------------------------------------------------------------
> +
> +MAKE_FIT := $(srctree)/scripts/make_fit.py
> +
> +# Use this to override the compression algorithm
> +FIT_COMPRESSION ?= gzip
> +
> +quiet_cmd_fit = FIT     $@
> +      cmd_fit = $(MAKE_FIT) -f $@ --arch $(UIMAGE_ARCH) --os linux \
> +			--name '$(UIMAGE_NAME)' \
> +			--compress $(FIT_COMPRESSION) -k $< \
> +			$(<D)/dts
> +
>  # XZ
>  # ---------------------------------------------------------------------------
>  # Use xzkern to compress the kernel image and xzmisc to compress other things.
> diff --git a/scripts/make_fit.py b/scripts/make_fit.py
> new file mode 100755
> index 000000000000..e616b0d7a84a
> --- /dev/null
> +++ b/scripts/make_fit.py
> @@ -0,0 +1,291 @@
> +#!/usr/bin/env python3
> +# SPDX-License-Identifier: GPL-2.0+
> +#
> +# Copyright 2023 Google LLC
> +# Written by Simon Glass <sjg@chromium.org>
> +#
> +
> +"""Build a FIT containing a lot of devicetree files
> +
> +Usage:
> +    make_fit.py -A arm64 -n 'Linux-6.6' -O linux
> +        -f arch/arm64/boot/image.fit -k /tmp/kern/arch/arm64/boot/image.itk
> +        /tmp/kern/arch/arm64/boot/dts/ -E -c gzip
> +
> +Creates a FIT containing the supplied kernel and a directory containing the
> +devicetree files.
> +
> +Use -E to generate an external FIT (where the data is placed after the
> +FIT data structure). This allows parsing of the data without loading
> +the entire FIT.
> +
> +Use -c to compress the data, using bzip2, gzip, lz4, lzma, lzo and
> +zstd algorithms.
> +
> +The resulting FIT can be booted by bootloaders which support FIT, such
> +as U-Boot, Linuxboot, Tianocore, etc.
> +
> +Note that this tool does not yet support adding a ramdisk / initrd.
> +"""
> +
> +import argparse
> +import collections
> +import os
> +import subprocess
> +import sys
> +import tempfile
> +import time
> +
> +import libfdt
> +
> +
> +# Tool extension and the name of the command-line tools
> +CompTool = collections.namedtuple('CompTool', 'ext,tools')
> +
> +COMP_TOOLS = {
> +    'bzip2': CompTool('.bz2', 'bzip2'),
> +    'gzip': CompTool('.gz', 'pigz,gzip'),
> +    'lz4': CompTool('.lz4', 'lz4'),
> +    'lzma': CompTool('.lzma', 'lzma'),
> +    'lzo': CompTool('.lzo', 'lzop'),
> +    'zstd': CompTool('.zstd', 'zstd'),
> +}
> +
> +
> +def parse_args():
> +    """Parse the program ArgumentParser
> +
> +    Returns:
> +        Namespace object containing the arguments
> +    """
> +    epilog = 'Build a FIT from a directory tree containing .dtb files'
> +    parser = argparse.ArgumentParser(epilog=epilog)
> +    parser.add_argument('-A', '--arch', type=str, required=True,
> +          help='Specifies the architecture')
> +    parser.add_argument('-c', '--compress', type=str, default='none',
> +          help='Specifies the compression')
> +    parser.add_argument('-E', '--external', action='store_true',
> +          help='Convert the FIT to use external data')
> +    parser.add_argument('-n', '--name', type=str, required=True,
> +          help='Specifies the name')
> +    parser.add_argument('-O', '--os', type=str, required=True,
> +          help='Specifies the operating system')
> +    parser.add_argument('-f', '--fit', type=str, required=True,
> +          help='Specifies the output file (.fit)')
> +    parser.add_argument('-k', '--kernel', type=str, required=True,
> +          help='Specifies the (uncompressed) kernel input file (.itk)')
> +    parser.add_argument('srcdir', type=str, nargs='*',
> +          help='Specifies the directory tree that contains .dtb files')
> +
> +    return parser.parse_args()
> +
> +
> +def setup_fit(fsw, name):
> +    """Make a start on writing the FIT
> +
> +    Outputs the root properties and the 'images' node
> +
> +    Args:
> +        fsw (libfdt.FdtSw): Object to use for writing
> +        name (str): Name of kernel image
> +    """
> +    fsw.INC_SIZE = 65536
> +    fsw.finish_reservemap()
> +    fsw.begin_node('')
> +    fsw.property_string('description', f'{name} with devicetree set')
> +    fsw.property_u32('#address-cells', 1)
> +
> +    fsw.property_u32('timestamp', int(time.time()))
> +    fsw.begin_node('images')
> +
> +
> +def write_kernel(fsw, data, args):
> +    """Write out the kernel image
> +
> +    Writes a kernel node along with the required properties
> +
> +    Args:
> +        fsw (libfdt.FdtSw): Object to use for writing
> +        data (bytes): Data to write (possibly compressed)
> +        args (Namespace): Contains necessary strings:
> +            arch: FIT architecture, e.g. 'arm64'
> +            fit_os: Operating Systems, e.g. 'linux'
> +            name: Name of OS, e.g. 'Linux-6.6.0-rc7'
> +            compress: Compression algorithm to use, e.g. 'gzip'
> +    """
> +    with fsw.add_node('kernel'):
> +        fsw.property_string('description', args.name)
> +        fsw.property_string('type', 'kernel_noload')
> +        fsw.property_string('arch', args.arch)
> +        fsw.property_string('os', args.os)
> +        fsw.property_string('compression', args.compress)
> +        fsw.property('data', data)
> +        fsw.property_u32('load', 0)
> +        fsw.property_u32('entry', 0)
> +
> +
> +def finish_fit(fsw, entries):
> +    """Finish the FIT ready for use
> +
> +    Writes the /configurations node and subnodes
> +
> +    Args:
> +        fsw (libfdt.FdtSw): Object to use for writing
> +        entries (list of tuple): List of configurations:
> +            str: Description of model
> +            str: Compatible stringlist
> +    """
> +    fsw.end_node()
> +    seq = 0
> +    with fsw.add_node('configurations'):
> +        for model, compat in entries:
> +            seq += 1
> +            with fsw.add_node(f'conf-{seq}'):
> +                fsw.property('compatible', bytes(compat))
> +                fsw.property_string('description', model)
> +                fsw.property_string('fdt', f'fdt-{seq}')
> +                fsw.property_string('kernel', 'kernel')
> +    fsw.end_node()
> +
> +
> +def compress_data(inf, compress):
> +    """Compress data using a selected algorithm
> +
> +    Args:
> +        inf (IOBase): Filename containing the data to compress
> +        compress (str): Compression algorithm, e.g. 'gzip'
> +
> +    Return:
> +        bytes: Compressed data
> +    """
> +    if compress == 'none':
> +        return inf.read()
> +
> +    comp = COMP_TOOLS.get(compress)
> +    if not comp:
> +        raise ValueError(f"Unknown compression algorithm '{compress}'")
> +
> +    with tempfile.NamedTemporaryFile() as comp_fname:
> +        with open(comp_fname.name, 'wb') as outf:
> +            done = False
> +            for tool in comp.tools.split(','):
> +                try:
> +                    subprocess.call([tool, '-c'], stdin=inf, stdout=outf)
> +                    done = True
> +                    break
> +                except FileNotFoundError:
> +                    pass
> +            if not done:
> +                raise ValueError(f'Missing tool(s): {comp.tools}\n')
> +            with open(comp_fname.name, 'rb') as compf:
> +                comp_data = compf.read()
> +    return comp_data
> +
> +
> +def output_dtb(fsw, seq, fname, arch, compress):
> +    """Write out a single devicetree to the FIT
> +
> +    Args:
> +        fsw (libfdt.FdtSw): Object to use for writing
> +        seq (int): Sequence number (1 for first)
> +        fmame (str): Filename containing the DTB
> +        arch: FIT architecture, e.g. 'arm64'
> +        compress (str): Compressed algorithm, e.g. 'gzip'
> +
> +    Returns:
> +        tuple:
> +            str: Model name
> +            bytes: Compatible stringlist
> +    """
> +    with fsw.add_node(f'fdt-{seq}'):
> +        # Get the compatible / model information
> +        with open(fname, 'rb') as inf:
> +            data = inf.read()
> +        fdt = libfdt.FdtRo(data)
> +        model = fdt.getprop(0, 'model').as_str()
> +        compat = fdt.getprop(0, 'compatible')
> +
> +        fsw.property_string('description', model)
> +        fsw.property_string('type', 'flat_dt')
> +        fsw.property_string('arch', arch)
> +        fsw.property_string('compression', compress)
> +        fsw.property('compatible', bytes(compat))
> +
> +        with open(fname, 'rb') as inf:
> +            compressed = compress_data(inf, compress)
> +        fsw.property('data', compressed)
> +    return model, compat
> +
> +
> +def build_fit(args):
> +    """Build the FIT from the provided files and arguments
> +
> +    Args:
> +        args (Namespace): Program arguments
> +
> +    Returns:
> +        tuple:
> +            bytes: FIT data
> +            int: Number of configurations generated
> +            size: Total uncompressed size of data
> +    """
> +    fsw = libfdt.FdtSw()
> +    setup_fit(fsw, args.name)
> +    seq = 0
> +    size = 0
> +    entries = []
> +
> +    # Handle the kernel
> +    with open(args.kernel, 'rb') as inf:
> +        comp_data = compress_data(inf, args.compress)
> +    size += os.path.getsize(args.kernel)
> +    write_kernel(fsw, comp_data, args)
> +
> +    for path in args.srcdir:
> +        # Handle devicetree files
> +        if os.path.isdir(path):
> +            for dirpath, _, fnames in os.walk(path):
> +                for fname in fnames:
> +                    if os.path.splitext(fname)[1] != '.dtb':
> +                        continue
> +                    pathname = os.path.join(dirpath, fname)
> +                    seq += 1
> +                    size += os.path.getsize(pathname)
> +                    model, compat = output_dtb(fsw, seq, pathname,
> +                                               args.arch, args.compress)
> +                    entries.append([model, compat])
> +
> +    finish_fit(fsw, entries)
> +
> +    # Include the kernel itself in the returned file count
> +    return fsw.as_fdt().as_bytearray(), seq + 1, size
> +
> +
> +def run_make_fit():
> +    """Run the tool's main logic"""
> +    args = parse_args()
> +
> +    out_data, count, size = build_fit(args)
> +    with open(args.fit, 'wb') as outf:
> +        outf.write(out_data)
> +
> +    ext_fit_size = None
> +    if args.external:
> +        mkimage = os.environ.get('MKIMAGE', 'mkimage')
> +        subprocess.check_call([mkimage, '-E', '-F', args.fit],
> +                              stdout=subprocess.DEVNULL)
> +
> +        with open(args.fit, 'rb') as inf:
> +            data = inf.read()
> +        ext_fit = libfdt.FdtRo(data)
> +        ext_fit_size = ext_fit.totalsize()
> +
> +    comp_size = len(out_data)
> +    print(f'FIT size {comp_size:#x}/{comp_size / 1024 / 1024:.1f} MB', end='')
> +    if ext_fit_size:
> +        print(f', header {ext_fit_size:#x}/{ext_fit_size / 1024:.1f} KB', end='')
> +    print(f', {count} files, uncompressed {size / 1024 / 1024:.1f} MB')
> +
> +
> +if __name__ == "__main__":
> +    sys.exit(run_make_fit())

-- 
Regards,

Laurent Pinchart
