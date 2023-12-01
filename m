Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C72D08011B2
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 18:30:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378813AbjLAR35 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 12:29:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjLAR3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 12:29:55 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D2AC10DB
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 09:30:00 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 049DFC433CD;
        Fri,  1 Dec 2023 17:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701451800;
        bh=UkvYIg+4pSDT+nnU/EXdPb6Otz0ErqA/UMresEDneU0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=gVH5MrTS+jja+NHle53R/mCOC3WNwwM5+OBAmW0Qd1wXhgH7nCc2asYvJjXqhX3V7
         UkvvhHnAiek2XgaXj1V0zMdMBHEWMU6SMhzh7eRwblNv2+xLSKGx1duRNA6LgZNhfa
         eTCrNwFSTIvQh57wu5dQ6qRldXgjT1VPlzOx3rhj5DN+CD2WGJUAnKrpa5r2nhJc+D
         S6flLxVDYnU+A+FvS521Fd7WL9BA6t9htYh+MHCd8HeYifkjeCXoplq2EFx9CCx0e4
         acZWJvRL4CF00dTaYYH1s1DJ0xXNC7RRjrzUJ5EwmTO1duxOqaIvRuMjwIX5pt+yda
         ObZ+/kiPlIAjA==
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-1efb9571b13so423542fac.2;
        Fri, 01 Dec 2023 09:29:59 -0800 (PST)
X-Gm-Message-State: AOJu0Yx7mpFYkuCCYhU0dhgb6oaIpgN3uHD1Tct5GHLLuhYG/JL2IQoH
        Hb90nVGSN6SelJVgLTRARG/ghoKIL+9mRWyOQyQ=
X-Google-Smtp-Source: AGHT+IH+uaWB88pmYHvfLRMtAK3vN1C2NSBTT7C5p5pNwRZLrFnhY3Ln8KC5tHUEff7SXpVG+J8MUsIvgqUmX4SKWjg=
X-Received: by 2002:a05:6870:4989:b0:1fa:f9a1:d3e5 with SMTP id
 ho9-20020a056870498900b001faf9a1d3e5mr1759104oab.9.1701451799235; Fri, 01 Dec
 2023 09:29:59 -0800 (PST)
MIME-Version: 1.0
References: <20231130203358.879796-1-sjg@chromium.org> <20231130203358.879796-3-sjg@chromium.org>
In-Reply-To: <20231130203358.879796-3-sjg@chromium.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sat, 2 Dec 2023 02:29:22 +0900
X-Gmail-Original-Message-ID: <CAK7LNARABFKSqY=f1uDGem2UqkTwGUQ9q3rDZ4NbXyuEAtsLdw@mail.gmail.com>
Message-ID: <CAK7LNARABFKSqY=f1uDGem2UqkTwGUQ9q3rDZ4NbXyuEAtsLdw@mail.gmail.com>
Subject: Re: [PATCH v8 2/2] arm64: boot: Support Flat Image Tree
To:     Simon Glass <sjg@chromium.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        U-Boot Mailing List <u-boot@lists.denx.de>,
        lkml <linux-kernel@vger.kernel.org>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Tom Rini <trini@konsulko.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Terrell <terrelln@fb.com>, Will Deacon <will@kernel.org>,
        linux-doc@vger.kernel.org, linux-kbuild@vger.kernel.org,
        workflows@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_PDS_OTHER_BAD_TLD,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 1, 2023 at 5:34=E2=80=AFAM Simon Glass <sjg@chromium.org> wrote=
:
>
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
> Add a 'make image.fit' build target for arm64, as well.
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
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
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
>  arch/arm64/boot/Makefile          |   9 +-
>  scripts/Makefile.lib              |  13 ++
>  scripts/make_fit.py               | 291 ++++++++++++++++++++++++++++++
>  7 files changed, 334 insertions(+), 3 deletions(-)
>  create mode 100755 scripts/make_fit.py
>
> diff --git a/Documentation/process/changes.rst b/Documentation/process/ch=
anges.rst
> index bb96ca0f774b..cad51bd5bd62 100644
> --- a/Documentation/process/changes.rst
> +++ b/Documentation/process/changes.rst
> @@ -62,6 +62,7 @@ Sphinx\ [#f1]_         1.7              sphinx-build --=
version
>  cpio                   any              cpio --version
>  GNU tar                1.28             tar --version
>  gtags (optional)       6.6.5            gtags --version
> +mkimage (optional)     2017.01          mkimage --version
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
>
>  .. [#f1] Sphinx is needed only to build the Kernel documentation
> @@ -189,6 +190,14 @@ The kernel build requires GNU GLOBAL version 6.6.5 o=
r later to generate
>  tag files through ``make gtags``.  This is due to its use of the gtags
>  ``-C (--directory)`` flag.
>
> +mkimage
> +-------
> +
> +This tool is used when building a Flat Image Tree (FIT), commonly used o=
n ARM
> +platforms. The tool is available via the ``u-boot-tools`` package or can=
 be
> +built from the U-Boot source code. See the instructions at
> +https://docs.u-boot.org/en/latest/build/tools.html#building-tools-for-li=
nux
> +
>  System utilities
>  ****************
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 14587be87a33..9f3eb476ece4 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3037,6 +3037,13 @@ F:       drivers/mmc/host/sdhci-of-arasan.c
>  N:     zynq
>  N:     xilinx
>
> +ARM64 FIT SUPPORT
> +M:     Simon Glass <sjg@chromium.org>
> +L:     linux-arm-kernel@lists.infradead.org (moderated for non-subscribe=
rs)
> +S:     Maintained
> +F:     arch/arm64/boot/Makefile
> +F:     scripts/make_fit.py
> +
>  ARM64 PORT (AARCH64 ARCHITECTURE)
>  M:     Catalin Marinas <catalin.marinas@arm.com>
>  M:     Will Deacon <will@kernel.org>
> diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
> index 1bd4fae6e806..6b893dc454b7 100644
> --- a/arch/arm64/Makefile
> +++ b/arch/arm64/Makefile
> @@ -150,7 +150,7 @@ libs-$(CONFIG_EFI_STUB) +=3D $(objtree)/drivers/firmw=
are/efi/libstub/lib.a
>  # Default target when executing plain make
>  boot           :=3D arch/arm64/boot
>
> -BOOT_TARGETS   :=3D Image vmlinuz.efi
> +BOOT_TARGETS   :=3D Image vmlinuz.efi image.fit
>
>  PHONY +=3D $(BOOT_TARGETS)
>
> @@ -162,7 +162,9 @@ endif
>
>  all:   $(notdir $(KBUILD_IMAGE))
>
> -vmlinuz.efi: Image
> +image.fit: dtbs
> +
> +vmlinuz.efi image.fit: Image
>  $(BOOT_TARGETS): vmlinux
>         $(Q)$(MAKE) $(build)=3D$(boot) $(boot)/$@
>
> @@ -215,6 +217,7 @@ virtconfig:
>  define archhelp
>    echo  '* Image.gz      - Compressed kernel image (arch/$(ARCH)/boot/Im=
age.gz)'
>    echo  '  Image         - Uncompressed kernel image (arch/$(ARCH)/boot/=
Image)'
> +  echo  '  image.fit     - Flat Image Tree (arch/$(ARCH)/boot/image.fit)=
'
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
> index 1761f5972443..62efb533a9bc 100644
> --- a/arch/arm64/boot/Makefile
> +++ b/arch/arm64/boot/Makefile
> @@ -16,7 +16,8 @@
>
>  OBJCOPYFLAGS_Image :=3D-O binary -R .note -R .note.gnu.build-id -R .comm=
ent -S
>
> -targets :=3D Image Image.bz2 Image.gz Image.lz4 Image.lzma Image.lzo Ima=
ge.zst
> +targets :=3D Image Image.bz2 Image.gz Image.lz4 Image.lzma Image.lzo \
> +       Image.zst image.fit
>
>  $(obj)/Image: vmlinux FORCE
>         $(call if_changed,objcopy)
> @@ -39,6 +40,12 @@ $(obj)/Image.lzo: $(obj)/Image FORCE
>  $(obj)/Image.zst: $(obj)/Image FORCE
>         $(call if_changed,zstd)
>
> +# Use this to override the compression algorithm
> +FIT_COMPRESS ?=3D gzip
> +
> +$(obj)/image.fit: $(obj)/Image FORCE
> +       $(call cmd,fit,$(FIT_COMPRESS))



Again, $(FIT_COMPRESS) is not used anywhere.


Please fix it to

      $(call cmd,fit)




See your code.


   cmd_fit =3D $(MAKE_FIT) -f $@ --arch $(UIMAGE_ARCH) --os linux \
                     --name '$(UIMAGE_NAME)' \
                     --compress $(UIMAGE_COMPRESSION) -k $< \
                     $(<D)/dts


cmd_fit does not take any argument.


The compression is determined by $(UIMAGE_COMPRESSION).







--=20
Best Regards
Masahiro Yamada
