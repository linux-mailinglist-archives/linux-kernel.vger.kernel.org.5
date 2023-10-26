Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D058F7D7D9D
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 09:28:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234938AbjJZH2L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 03:28:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344437AbjJZH2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 03:28:01 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAA421A6
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 00:27:57 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1ca82f015e4so4669775ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 00:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1698305277; x=1698910077; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vVg38DAEY+GKxvLT4QMM3vicbeMq8NcfMl/wOJcG9Pk=;
        b=PvPDzny5X52mQJnq5lJZO7B4UcLtKxGgCl6xVB7Irm35KtCsabhgcwy+oz8u/MgZX2
         T5e4dykdb0ux1mNeu1O1bzSo6xcZbX1WXlDBxqTwmkwcr/GJRUgwGyQCtHaKmxPGCcZK
         COwqRlwIUjjlC/QJhE1TiLSMbCCzrLCMTQvY4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698305277; x=1698910077;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vVg38DAEY+GKxvLT4QMM3vicbeMq8NcfMl/wOJcG9Pk=;
        b=J3ndTDvYSIYmaibxF3OGRxV2dTl4QSjKeY9zOGzC0gKkt7I9DklK8gr2lprcPlyPGo
         eAnZkatUw5mYJez8taF/QKUFDhyRuzRe1pW27UKZsTdmzY4OzK2Mm+m1CbnNZqE8FCPB
         HX3kozsMgpa41vy6wcIv4PUTFyQgooy+a+TFR4iUAxW3r6O5EGOfebzgqvaoJsQxZIfU
         hCog503gjv6btWhWOKpWoVTyCQ6Iq3Iv+kAaQC1ks/qfjxqbHJhQR+zTEbGF3T4Df3hw
         d9jkrdC2qtR/oJlgmt41+t6vHYalbQjnnsHyMiIQwjleSQp77PaFiTCJGWpEKFDeRAO7
         2AqQ==
X-Gm-Message-State: AOJu0YzQeVR57UwE+T4RVpBoptUsSEgJWdn36YsNk8us3Zvf2s2wnz7E
        FVOnXUSUw4nZrY8CZ2UsI9VVRg==
X-Google-Smtp-Source: AGHT+IEZ3lzI9th7z/Xuc78FLSWEbhy6QqAkBXJeZRXiqFKJ2quK+1iOZJMWdRz9g+5Zk5kHBju5PA==
X-Received: by 2002:a17:902:d48f:b0:1c9:dff6:58e8 with SMTP id c15-20020a170902d48f00b001c9dff658e8mr15543630plg.54.1698305277011;
        Thu, 26 Oct 2023 00:27:57 -0700 (PDT)
Received: from sjg1.roam.corp.google.com ([202.144.206.130])
        by smtp.gmail.com with ESMTPSA id n17-20020a170902e55100b001b7cbc5871csm10294023plf.53.2023.10.26.00.27.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 00:27:56 -0700 (PDT)
From:   Simon Glass <sjg@chromium.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     U-Boot Mailing List <u-boot@lists.denx.de>,
        Simon Glass <sjg@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nick Terrell <terrelln@fb.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Will Deacon <will@kernel.org>, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] arm64: boot: Support Flat Image Tree
Date:   Thu, 26 Oct 2023 20:26:25 +1300
Message-ID: <20231026072628.4115527-4-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
In-Reply-To: <20231026072628.4115527-1-sjg@chromium.org>
References: <20231026072628.4115527-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,PDS_OTHER_BAD_TLD,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URIBL_SBL_A
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a script which produces a Flat Image Tree (FIT), a single file
containing the built kernel and associated devicetree files.
Compression defaults to gzip which gives a good balance of size and
performance.

The files compress from about 85MB to 24MB using this approach.

The FIT can be used by bootloaders which support it, such as U-Boot
and Linuxboot. It permits automatic selection of the correct
devicetree, matching the compatible string of the running board with
the closest compatible string in the FIT. There is no need for
filenames or other workarounds.

Add a 'make image.fit' build target for arm64, as well.

The FIT can be examined using 'dumpimage -l'.

This features requires pylibfdt (use 'pip install libfdt'). It also
requires compression utilities for the algorithm being used. Supported
compression options are the same as the Image.xxx files. For now there
is no way to change the compression other than by editing the rule for
$(obj)/image.fit

While FIT supports a ramdisk / initrd, no attempt is made to support
this here, since it must be built separately from the Linux build.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 MAINTAINERS              |   7 +
 arch/arm64/Makefile      |   3 +-
 arch/arm64/boot/Makefile |   8 +-
 scripts/Makefile.lib     |  16 ++-
 scripts/make_fit.py      | 285 +++++++++++++++++++++++++++++++++++++++
 5 files changed, 315 insertions(+), 4 deletions(-)
 create mode 100755 scripts/make_fit.py

diff --git a/MAINTAINERS b/MAINTAINERS
index 2d13bbd69adb..d6955ebc3c24 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1575,6 +1575,13 @@ F:	Documentation/process/maintainer-soc*.rst
 F:	arch/arm/boot/dts/Makefile
 F:	arch/arm64/boot/dts/Makefile
 
+ARM64 FIT SUPPORT
+M:	Simon Glass <sjg@chromium.org>
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
+S:	Maintained
+F:	arch/arm64/boot/Makefile
+F:	scripts/make_fit.py
+
 ARM ARCHITECTED TIMER DRIVER
 M:	Mark Rutland <mark.rutland@arm.com>
 M:	Marc Zyngier <maz@kernel.org>
diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index 7b77b63e978f..d8290dcab6b6 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -150,7 +150,7 @@ libs-$(CONFIG_EFI_STUB) += $(objtree)/drivers/firmware/efi/libstub/lib.a
 # Default target when executing plain make
 boot		:= arch/arm64/boot
 
-BOOT_TARGETS	:= Image.gz vmlinuz.efi
+BOOT_TARGETS	:= Image.gz vmlinuz.efi image.fit
 
 PHONY += $(BOOT_TARGETS)
 
@@ -215,6 +215,7 @@ virtconfig:
 define archhelp
   echo  '* Image.gz      - Compressed kernel image (arch/$(ARCH)/boot/Image.gz)'
   echo  '  Image         - Uncompressed kernel image (arch/$(ARCH)/boot/Image)'
+$(if $(CONFIG_EFI_ZBOOT),,echo  '  image.fit     - Flat Image Tree (arch/$(ARCH)/boot/image.fit)')
   echo  '  install       - Install uncompressed kernel'
   echo  '  zinstall      - Install compressed kernel'
   echo  '                  Install using (your) ~/bin/installkernel or'
diff --git a/arch/arm64/boot/Makefile b/arch/arm64/boot/Makefile
index 1761f5972443..a6e5b20b22bd 100644
--- a/arch/arm64/boot/Makefile
+++ b/arch/arm64/boot/Makefile
@@ -16,7 +16,8 @@
 
 OBJCOPYFLAGS_Image :=-O binary -R .note -R .note.gnu.build-id -R .comment -S
 
-targets := Image Image.bz2 Image.gz Image.lz4 Image.lzma Image.lzo Image.zst
+targets := Image Image.bz2 Image.gz Image.lz4 Image.lzma Image.lzo \
+	Image.zst image.fit
 
 $(obj)/Image: vmlinux FORCE
 	$(call if_changed,objcopy)
@@ -39,6 +40,11 @@ $(obj)/Image.lzo: $(obj)/Image FORCE
 $(obj)/Image.zst: $(obj)/Image FORCE
 	$(call if_changed,zstd)
 
+ifndef CONFIG_EFI_ZBOOT
+$(obj)/image.fit: $(obj)/Image $(obj)/dts FORCE
+	$(call if_changed,fit,gzip)
+endif
+
 EFI_ZBOOT_PAYLOAD	:= Image
 EFI_ZBOOT_BFD_TARGET	:= elf64-littleaarch64
 EFI_ZBOOT_MACH_TYPE	:= ARM64
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 68d0134bdbf9..4e4364ad641a 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -487,14 +487,26 @@ UIMAGE_OPTS-y ?=
 UIMAGE_TYPE ?= kernel
 UIMAGE_LOADADDR ?= arch_must_set_this
 UIMAGE_ENTRYADDR ?= $(UIMAGE_LOADADDR)
-UIMAGE_NAME ?= 'Linux-$(KERNELRELEASE)'
+UIMAGE_NAME ?= "Linux-$(KERNELRELEASE)"
 
 quiet_cmd_uimage = UIMAGE  $@
       cmd_uimage = $(BASH) $(MKIMAGE) -A $(UIMAGE_ARCH) -O linux \
 			-C $(UIMAGE_COMPRESSION) $(UIMAGE_OPTS-y) \
 			-T $(UIMAGE_TYPE) \
 			-a $(UIMAGE_LOADADDR) -e $(UIMAGE_ENTRYADDR) \
-			-n $(UIMAGE_NAME) -d $< $@
+			-n "$(UIMAGE_NAME)" -d $< $@
+
+# Flat Image Tree (FIT)
+# This allows for packaging of a kernel and all devicetrees files, using
+# compression.
+# ---------------------------------------------------------------------------
+
+MAKE_FIT := $(srctree)/scripts/make_fit.py
+
+quiet_cmd_fit = FIT     $@
+      cmd_fit = $(MAKE_FIT) -f $@ --arch $(UIMAGE_ARCH) --os linux \
+			--name "$(UIMAGE_NAME)" \
+			--compress $(UIMAGE_COMPRESSION) $^
 
 # XZ
 # ---------------------------------------------------------------------------
diff --git a/scripts/make_fit.py b/scripts/make_fit.py
new file mode 100755
index 000000000000..07500d8638e9
--- /dev/null
+++ b/scripts/make_fit.py
@@ -0,0 +1,285 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Copyright 2023 Google LLC
+# Written by Simon Glass <sjg@chromium.org>
+#
+
+"""Build a FIT containing a lot of devicetree files
+
+Usage:
+    make_fit.py -A arm64 -n 'Linux-6.6' -O linux
+        -f arch/arm64/boot/image.fit /tmp/kern/arch/arm64/boot/Image
+        /tmp/kern/arch/arm64/boot/dts/ -E -c gzip
+
+Creates a FIT containing the supplied list of files. The kernel must
+be specified first. The DTB files are specified by way of a directory
+tree containing them.
+
+Use -E to generate an external FIT (where the data is placed after the
+FIT data structure). This allows parsing of the data without loading
+the entire FIT.
+
+Use -c to compress the data, using bzip2, gzip, lz4, lzma, lzo and
+zstd
+
+The resulting FIT can be booted by bootloaders which support FIT, such
+as U-Boot, Linuxboot, Tianocore, etc.
+
+Note that this tool does not yet support adding a ramdisk / initrd.
+"""
+
+import argparse
+import collections
+import os
+import subprocess
+import sys
+import tempfile
+import time
+
+import libfdt
+
+
+# Tool extension and the name of the command-line tools
+CompTool = collections.namedtuple('CompTool', 'ext,tools')
+
+COMP_TOOLS = {
+    'bzip2': CompTool('.bz2', 'bzip2'),
+    'gzip': CompTool('.gz', 'pigz,gzip'),
+    'lz4': CompTool('.lz4', 'lz4'),
+    'lzma': CompTool('.lzma', 'lzma'),
+    'lzo': CompTool('.lzo', 'lzop'),
+    'zstd': CompTool('.zstd', 'zstd'),
+}
+
+def parse_args():
+    """Parse the program ArgumentParser
+
+    Returns:
+        Namespace object containing the arguments
+    """
+    epilog = 'Build a FIT from a directory tree containing .dtb files'
+    parser = argparse.ArgumentParser(epilog=epilog)
+    parser.add_argument('-A', '--arch', type=str, required=True,
+          help='Specifies the architecture')
+    parser.add_argument('-c', '--compress', type=str, default='none',
+          help='Specifies the compression')
+    parser.add_argument('-E', '--external', action='store_true',
+          help='Convert the FIT to use external data')
+    parser.add_argument('-n', '--name', type=str, required=True,
+          help='Specifies the name')
+    parser.add_argument('-O', '--os', type=str, required=True,
+          help='Specifies the operating system')
+    parser.add_argument('-f', '--fit', type=str, required=True,
+          help='Specifies the output file (.fit)')
+    parser.add_argument('srcdir', type=str, nargs='*',
+          help='Specifies the directory tree that contains .dtb files')
+
+    return parser.parse_args()
+
+def setup_fit(fsw):
+    """Make a start on writing the FIT
+
+    Outputs the root properties and the 'images' node
+
+    Args:
+        fsw (libfdt.FdtSw): Object to use for writing
+    """
+    fsw.INC_SIZE = 65536
+    fsw.finish_reservemap()
+    fsw.begin_node('')
+    fsw.property_string('description', 'DTB set')
+    fsw.property_u32('#address-cells', 1)
+
+    fsw.property_u32('timestamp', int(time.time()))
+    fsw.begin_node('images')
+
+
+def write_kernel(fsw, data, arch, fit_os, name, compress):
+    """Write out the kernel image
+
+    Writes a kernel node along with the required properties
+
+    Args:
+        fsw (libfdt.FdtSw): Object to use for writing
+        data (bytes): Data to write (possibly compressed)
+        arch (str): FIT architecture, e.g. 'arm64'
+        fit_os (str): Operating Systems, e.g. 'linux'
+        name (str): Name of OS, e.g. 'Linux-6.6.0-rc7'
+        compress (str): Compression algorithm to use, e.g. 'gzip'
+    """
+    with fsw.add_node('kernel'):
+        fsw.property_string('description', name)
+        fsw.property_string('type', 'kernel_noload')
+        fsw.property_string('arch', arch)
+        fsw.property_string('os', fit_os)
+        fsw.property_string('compression', compress)
+        fsw.property('data', data)
+        fsw.property_u32('load', 0)
+        fsw.property_u32('entry', 0)
+
+
+def finish_fit(fsw, entries):
+    """Finish the FIT ready for use
+
+    Writes the /configurations node and subnodes
+
+    Args:
+        fsw (libfdt.FdtSw): Object to use for writing
+        entries (list of tuple): List of configurations:
+            str: Description of model
+            str: Compatible stringlist
+    """
+    fsw.end_node()
+    seq = 0
+    with fsw.add_node('configurations'):
+        for model, compat in entries:
+            seq += 1
+            with fsw.add_node(f'conf-{seq}'):
+                fsw.property('compatible', bytes(compat))
+                fsw.property_string('description', model)
+                fsw.property_string('fdt', f'fdt-{seq}')
+                fsw.property_string('kernel', 'kernel')
+    fsw.end_node()
+
+
+def compress_data(inf, compress):
+    """Compress data using a selected algorithm
+
+    Args:
+        inf (IOBase): Filename containing the data to compress
+        compress (str): Compression algorithm, e.g. 'gzip'
+
+    Return:
+        bytes: Compressed data
+    """
+    if compress == 'none':
+        return inf.read()
+
+    comp = COMP_TOOLS.get(compress)
+    if not comp:
+        raise ValueError(f"Unknown compression algorithm '{compress}'")
+
+    with tempfile.NamedTemporaryFile() as comp_fname:
+        with open(comp_fname.name, 'wb') as outf:
+            done = False
+            for tool in comp.tools.split(','):
+                try:
+                    subprocess.call([tool, '-c'], stdin=inf, stdout=outf)
+                    done = True
+                    break
+                except FileNotFoundError:
+                    pass
+            if not done:
+                raise ValueError(f'Missing tool(s): {comp.tools}\n')
+            with open(comp_fname.name, 'rb') as compf:
+                comp_data = compf.read()
+    return comp_data
+
+
+def output_dtb(fsw, seq, fname, compress):
+    """Write out a single devicetree to the FIT
+
+    Args:
+        fsw (libfdt.FdtSw): Object to use for writing
+        seq (int): Sequence number (1 for first)
+        fmame (str): Filename containing the DTB
+        compress (str): Compressed algorithm, e.g. 'gzip'
+
+    Returns:
+        tuple:
+            str: Model name
+            bytes: Compatible stringlist
+    """
+    with fsw.add_node(f'fdt-{seq}'):
+        # Get the compatible / model information
+        with open(fname, 'rb') as inf:
+            data = inf.read()
+        fdt = libfdt.FdtRo(data)
+        model = fdt.getprop(0, 'model').as_str()
+        compat = fdt.getprop(0, 'compatible')
+
+        fsw.property_string('description', model)
+        fsw.property_string('type', 'flat_dt')
+        fsw.property_string('arch', 'arm64')
+        fsw.property_string('compression', compress)
+        fsw.property('compatible', bytes(compat))
+
+        with open(fname, 'rb') as inf:
+            compressed = compress_data(inf, compress)
+        fsw.property('data', compressed)
+    return model, compat
+
+
+def build_fit(args):
+    """Build the FIT from the provided files and arguments
+
+    Args:
+        args: Namespace object containing program arguments
+
+    Returns:
+        tuple:
+            bytes: FIT data
+            int: Number of configurations generated
+            size: Total uncompressed size of data
+    """
+    fsw = libfdt.FdtSw()
+    setup_fit(fsw)
+    seq = 0
+    size = 0
+    entries = []
+    for path in args.srcdir:
+        # Handle devicetree files
+        if os.path.isdir(path):
+            for dirpath, _, fnames in os.walk(path):
+                for fname in fnames:
+                    if os.path.splitext(fname)[1] != '.dtb':
+                        continue
+                    pathname = os.path.join(dirpath, fname)
+                    seq += 1
+                    size += os.path.getsize(pathname)
+                    model, compat = output_dtb(fsw, seq, pathname,
+                                               args.compress)
+                    entries.append([model, compat])
+
+        # Handle the kernel
+        elif path != 'FORCE':
+            with open(path, 'rb') as inf:
+                comp_data = compress_data(inf, args.compress)
+            size += os.path.getsize(path)
+            write_kernel(fsw, comp_data, args.arch, args.os,
+                            args.name, args.compress)
+
+    finish_fit(fsw, entries)
+
+    return fsw.as_fdt().as_bytearray(), seq, size
+
+
+def run_make_fit():
+    """Run the tool's main logic"""
+    args = parse_args()
+
+    out_data, count, size = build_fit(args)
+    with open(args.fit, 'wb') as outf:
+        outf.write(out_data)
+
+    ext_fit_size = None
+    if args.external:
+        mkimage = os.environ.get('MKIMAGE', 'mkimage')
+        subprocess.check_call([mkimage, '-E', '-F', args.fit],
+                              stdout=subprocess.DEVNULL)
+
+        with open(args.fit, 'rb') as inf:
+            data = inf.read()
+        ext_fit = libfdt.FdtRo(data)
+        ext_fit_size = ext_fit.totalsize()
+
+    comp_size = len(out_data)
+    print(f'FIT size {comp_size:#x}/{comp_size / 1024 / 1024:.1f} MB', end='')
+    if ext_fit_size:
+        print(f', header {ext_fit_size:#x}/{ext_fit_size / 1024:.1f} KB', end='')
+    print(f', {count} files, uncompressed {size / 1024 / 1024:.1f} MB')
+
+
+if __name__ == "__main__":
+    sys.exit(run_make_fit())
-- 
2.42.0.758.gaed0368e0e-goog

