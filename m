Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 505EE8013C4
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 20:56:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379555AbjLAT4f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 14:56:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379538AbjLAT4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 14:56:34 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7F67D54
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 11:56:39 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DDDBC433AB;
        Fri,  1 Dec 2023 19:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701460599;
        bh=0ThhDO5PG85pESeX+R+vIkhc1OO1alRmntPC4vwJrwQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=caRls0VfeAJboUfPO/j6zPVwJRiI4YEdBp5stpJuT+MRlfDcao8Eecxb/cOMfqnqM
         Q8lZfpw1XVL/Vwqc7C4i8VAABmEs4mav54E8EHfji4jJv7vMuWoFgDTDhLVmuq3KUp
         rCdsTuTzULAohKVJFNvGpF3YuAdF8g8Y10vlnU/tn+lHHtvHrlkNAW7ZyTOC9Yp8qB
         SI+ONO65F++8n8PAwPGflPW564RaWl8MGzkKKThT7QeG8P4iW9tRiVW2MX4qYLZkei
         VxkiHbgOOrS2aLHR3uaGcjqEiwDj16Ogq1A9gZq/7t2Fg1fcK4hs4zRn/7vd51e5xZ
         nqcajGgEw4wTw==
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6d817ccaa6dso584766a34.2;
        Fri, 01 Dec 2023 11:56:39 -0800 (PST)
X-Gm-Message-State: AOJu0YyUfL5+WzHuxj8BME5b5IIK1DT9eGRrE94QjbS6K/PZ+d6n5szH
        VG5xSEJ4xU4a8huNy8tn/tcnOYM71jXt7n1nK/0=
X-Google-Smtp-Source: AGHT+IECv81h5hacyO8pt9/Igqyitv+JjETqvn/cXFakrS+k5BBF12PP0Ykp9mCKpwrb2BGPWCjHVEFA0bVR5VpABgc=
X-Received: by 2002:a05:6871:591:b0:1fa:f2a4:f3fa with SMTP id
 u17-20020a056871059100b001faf2a4f3famr95493oan.12.1701460598606; Fri, 01 Dec
 2023 11:56:38 -0800 (PST)
MIME-Version: 1.0
References: <20231130203358.879796-1-sjg@chromium.org> <20231130203358.879796-3-sjg@chromium.org>
 <CAK7LNARABFKSqY=f1uDGem2UqkTwGUQ9q3rDZ4NbXyuEAtsLdw@mail.gmail.com> <CAPnjgZ0SaoyCMiZHZ8Hs6iE8pqGz0RMYwv1XQQFZOHe1cpn7YQ@mail.gmail.com>
In-Reply-To: <CAPnjgZ0SaoyCMiZHZ8Hs6iE8pqGz0RMYwv1XQQFZOHe1cpn7YQ@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sat, 2 Dec 2023 04:56:01 +0900
X-Gmail-Original-Message-ID: <CAK7LNARTz_BsdM2iW9Tbo1gtychMzZ5=EU5iTXLbXrAJGX+hHQ@mail.gmail.com>
Message-ID: <CAK7LNARTz_BsdM2iW9Tbo1gtychMzZ5=EU5iTXLbXrAJGX+hHQ@mail.gmail.com>
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_PDS_OTHER_BAD_TLD,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 2, 2023 at 3:09=E2=80=AFAM Simon Glass <sjg@chromium.org> wrote=
:
>
> Hi Masahiro,
>
> On Fri, 1 Dec 2023 at 10:30, Masahiro Yamada <masahiroy@kernel.org> wrote=
:
> >
> > On Fri, Dec 1, 2023 at 5:34=E2=80=AFAM Simon Glass <sjg@chromium.org> w=
rote:
> > >
> > > Add a script which produces a Flat Image Tree (FIT), a single file
> > > containing the built kernel and associated devicetree files.
> > > Compression defaults to gzip which gives a good balance of size and
> > > performance.
> > >
> > > The files compress from about 86MB to 24MB using this approach.
> > >
> > > The FIT can be used by bootloaders which support it, such as U-Boot
> > > and Linuxboot. It permits automatic selection of the correct
> > > devicetree, matching the compatible string of the running board with
> > > the closest compatible string in the FIT. There is no need for
> > > filenames or other workarounds.
> > >
> > > Add a 'make image.fit' build target for arm64, as well.
> > >
> > > The FIT can be examined using 'dumpimage -l'.
> > >
> > > This features requires pylibfdt (use 'pip install libfdt'). It also
> > > requires compression utilities for the algorithm being used. Supporte=
d
> > > compression options are the same as the Image.xxx files. For now ther=
e
> > > is no way to change the compression other than by editing the rule fo=
r
> > > $(obj)/image.fit
> > >
> > > While FIT supports a ramdisk / initrd, no attempt is made to support
> > > this here, since it must be built separately from the Linux build.
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > ---
> > >
> > > Changes in v8:
> > > - Drop compatible string in FDT node
> > > - Correct sorting of MAINTAINERS to before ARM64 PORT
> > > - Turn compress part of the make_fit.py comment in to a sentence
> > > - Add two blank lines before parse_args() and setup_fit()
> > > - Use 'image.fit: dtbs' instead of BUILD_DTBS var
> > > - Use '$(<D)/dts' instead of '$(dir $<)dts'
> > > - Add 'mkimage' details Documentation/process/changes.rst
> > > - Allow changing the compression used
> > > - Tweak cover letter since there is only one clean-up patch
> > >
> > > Changes in v7:
> > > - Add Image as a dependency of image.fit
> > > - Drop kbuild tag
> > > - Add dependency on dtbs
> > > - Drop unnecessary path separator for dtbs
> > > - Rebase to -next
> > >
> > > Changes in v5:
> > > - Drop patch previously applied
> > > - Correct compression rule which was broken in v4
> > >
> > > Changes in v4:
> > > - Use single quotes for UIMAGE_NAME
> > >
> > > Changes in v3:
> > > - Drop temporary file image.itk
> > > - Drop patch 'Use double quotes for image name'
> > > - Drop double quotes in use of UIMAGE_NAME
> > > - Drop unnecessary CONFIG_EFI_ZBOOT condition for help
> > > - Avoid hard-coding "arm64" for the DT architecture
> > >
> > > Changes in v2:
> > > - Drop patch previously applied
> > > - Add .gitignore file
> > > - Move fit rule to Makefile.lib using an intermediate file
> > > - Drop dependency on CONFIG_EFI_ZBOOT
> > > - Pick up .dtb files separately from the kernel
> > > - Correct pylint too-many-args warning for write_kernel()
> > > - Include the kernel image in the file count
> > > - Add a pointer to the FIT spec and mention of its wide industry usag=
e
> > > - Mention the kernel version in the FIT description
> > >
> > >  Documentation/process/changes.rst |   9 +
> > >  MAINTAINERS                       |   7 +
> > >  arch/arm64/Makefile               |   7 +-
> > >  arch/arm64/boot/.gitignore        |   1 +
> > >  arch/arm64/boot/Makefile          |   9 +-
> > >  scripts/Makefile.lib              |  13 ++
> > >  scripts/make_fit.py               | 291 ++++++++++++++++++++++++++++=
++
> > >  7 files changed, 334 insertions(+), 3 deletions(-)
> > >  create mode 100755 scripts/make_fit.py
> > >
> > > diff --git a/Documentation/process/changes.rst b/Documentation/proces=
s/changes.rst
> > > index bb96ca0f774b..cad51bd5bd62 100644
> > > --- a/Documentation/process/changes.rst
> > > +++ b/Documentation/process/changes.rst
> > > @@ -62,6 +62,7 @@ Sphinx\ [#f1]_         1.7              sphinx-buil=
d --version
> > >  cpio                   any              cpio --version
> > >  GNU tar                1.28             tar --version
> > >  gtags (optional)       6.6.5            gtags --version
> > > +mkimage (optional)     2017.01          mkimage --version
> > >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> > >
> > >  .. [#f1] Sphinx is needed only to build the Kernel documentation
> > > @@ -189,6 +190,14 @@ The kernel build requires GNU GLOBAL version 6.6=
.5 or later to generate
> > >  tag files through ``make gtags``.  This is due to its use of the gta=
gs
> > >  ``-C (--directory)`` flag.
> > >
> > > +mkimage
> > > +-------
> > > +
> > > +This tool is used when building a Flat Image Tree (FIT), commonly us=
ed on ARM
> > > +platforms. The tool is available via the ``u-boot-tools`` package or=
 can be
> > > +built from the U-Boot source code. See the instructions at
> > > +https://docs.u-boot.org/en/latest/build/tools.html#building-tools-fo=
r-linux
> > > +
> > >  System utilities
> > >  ****************
> > >
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index 14587be87a33..9f3eb476ece4 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -3037,6 +3037,13 @@ F:       drivers/mmc/host/sdhci-of-arasan.c
> > >  N:     zynq
> > >  N:     xilinx
> > >
> > > +ARM64 FIT SUPPORT
> > > +M:     Simon Glass <sjg@chromium.org>
> > > +L:     linux-arm-kernel@lists.infradead.org (moderated for non-subsc=
ribers)
> > > +S:     Maintained
> > > +F:     arch/arm64/boot/Makefile
> > > +F:     scripts/make_fit.py
> > > +
> > >  ARM64 PORT (AARCH64 ARCHITECTURE)
> > >  M:     Catalin Marinas <catalin.marinas@arm.com>
> > >  M:     Will Deacon <will@kernel.org>
> > > diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
> > > index 1bd4fae6e806..6b893dc454b7 100644
> > > --- a/arch/arm64/Makefile
> > > +++ b/arch/arm64/Makefile
> > > @@ -150,7 +150,7 @@ libs-$(CONFIG_EFI_STUB) +=3D $(objtree)/drivers/f=
irmware/efi/libstub/lib.a
> > >  # Default target when executing plain make
> > >  boot           :=3D arch/arm64/boot
> > >
> > > -BOOT_TARGETS   :=3D Image vmlinuz.efi
> > > +BOOT_TARGETS   :=3D Image vmlinuz.efi image.fit
> > >
> > >  PHONY +=3D $(BOOT_TARGETS)
> > >
> > > @@ -162,7 +162,9 @@ endif
> > >
> > >  all:   $(notdir $(KBUILD_IMAGE))
> > >
> > > -vmlinuz.efi: Image
> > > +image.fit: dtbs
> > > +
> > > +vmlinuz.efi image.fit: Image
> > >  $(BOOT_TARGETS): vmlinux
> > >         $(Q)$(MAKE) $(build)=3D$(boot) $(boot)/$@
> > >
> > > @@ -215,6 +217,7 @@ virtconfig:
> > >  define archhelp
> > >    echo  '* Image.gz      - Compressed kernel image (arch/$(ARCH)/boo=
t/Image.gz)'
> > >    echo  '  Image         - Uncompressed kernel image (arch/$(ARCH)/b=
oot/Image)'
> > > +  echo  '  image.fit     - Flat Image Tree (arch/$(ARCH)/boot/image.=
fit)'
> > >    echo  '  install       - Install uncompressed kernel'
> > >    echo  '  zinstall      - Install compressed kernel'
> > >    echo  '                  Install using (your) ~/bin/installkernel =
or'
> > > diff --git a/arch/arm64/boot/.gitignore b/arch/arm64/boot/.gitignore
> > > index af5dc61f8b43..abaae9de1bdd 100644
> > > --- a/arch/arm64/boot/.gitignore
> > > +++ b/arch/arm64/boot/.gitignore
> > > @@ -2,3 +2,4 @@
> > >  Image
> > >  Image.gz
> > >  vmlinuz*
> > > +image.fit
> > > diff --git a/arch/arm64/boot/Makefile b/arch/arm64/boot/Makefile
> > > index 1761f5972443..62efb533a9bc 100644
> > > --- a/arch/arm64/boot/Makefile
> > > +++ b/arch/arm64/boot/Makefile
> > > @@ -16,7 +16,8 @@
> > >
> > >  OBJCOPYFLAGS_Image :=3D-O binary -R .note -R .note.gnu.build-id -R .=
comment -S
> > >
> > > -targets :=3D Image Image.bz2 Image.gz Image.lz4 Image.lzma Image.lzo=
 Image.zst
> > > +targets :=3D Image Image.bz2 Image.gz Image.lz4 Image.lzma Image.lzo=
 \
> > > +       Image.zst image.fit
> > >
> > >  $(obj)/Image: vmlinux FORCE
> > >         $(call if_changed,objcopy)
> > > @@ -39,6 +40,12 @@ $(obj)/Image.lzo: $(obj)/Image FORCE
> > >  $(obj)/Image.zst: $(obj)/Image FORCE
> > >         $(call if_changed,zstd)
> > >
> > > +# Use this to override the compression algorithm
> > > +FIT_COMPRESS ?=3D gzip
> > > +
> > > +$(obj)/image.fit: $(obj)/Image FORCE
> > > +       $(call cmd,fit,$(FIT_COMPRESS))
> >
> >
> >
> > Again, $(FIT_COMPRESS) is not used anywhere.
> >
> >
> > Please fix it to
> >
> >       $(call cmd,fit)
> >
> >
> >
> >
> > See your code.
> >
> >
> >    cmd_fit =3D $(MAKE_FIT) -f $@ --arch $(UIMAGE_ARCH) --os linux \
> >                      --name '$(UIMAGE_NAME)' \
> >                      --compress $(UIMAGE_COMPRESSION) -k $< \
> >                      $(<D)/dts
> >
> >
> > cmd_fit does not take any argument.
> >
> >
> > The compression is determined by $(UIMAGE_COMPRESSION).
>
> This references argument 2, which is how it works. I have tested this,


Hah, I missed it, sorry.


You want to use gzip instead of none as the
default compression for the fit image, right?



If so, maybe, you can directly add FIT_COMPRESSION
in scripts/Makefile.lib
Users are still allowed to override it from an
environment variable.



FIT_COMPRESSION ?=3D gzip

cmd_fit =3D $(MAKE_FIT) -f $@ --arch $(UIMAGE_ARCH) --os linux \
                   --name '$(UIMAGE_NAME)' \
                   --compress $(FIT_COMPRESSION) -k $< \
                   $(<D)/dts






> for example:
>
> ARCH=3Darm64 CROSS_COMPILE=3D... make FIT_COMPRESS=3Dlzma image.fit
>
> I do want to support different algorithms, if possible. Is there a
> better way to do this?
>
> Regards,
> Simon



--=20
Best Regards
Masahiro Yamada
