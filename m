Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2E8B7FF3C1
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 16:39:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346281AbjK3PjE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 10:39:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346365AbjK3PjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 10:39:03 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D60F110DF
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 07:39:09 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DFBEC433C7;
        Thu, 30 Nov 2023 15:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701358749;
        bh=Wh8M9AbYS0w9KCv3VF1Tv2DWqWthaRO2rj6ZmBsIJsI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=DlnyvfF6CmJRhAtNk/H7ubOi63Inp3I+Ndnrkns2azVUSILIJ6L51Woc55qdQ1V2S
         7xDPx3+GdB30XkV7qSTYrPAQ91ymS1AA1IvfaLeIuS2ctP0fPLRHLrw8UnVH52vO95
         PFhri+dSD36p/paXayQsP4cVYT/P4F3s+BR/kX/45OymE46CL23HDdNZYxxJkXo7Ro
         qm4y845YGEaCj5FRcP8ICWxI7uKxTyBNpAlCutSSSTSNQoYczvLjkg+pGGlBSs8sZ6
         ILFHmpp53BBbUPs/TifmHy6BI+bVxPHK1IZUQk+qhoSZESMZfsqzbTbEC+1rzBzVmG
         yX23srCYuEYUQ==
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-1fa20395185so493476fac.3;
        Thu, 30 Nov 2023 07:39:09 -0800 (PST)
X-Gm-Message-State: AOJu0YywyrUFXchG6rZKCnq9ueXWtRX50JSkvst1NrvfOadiPJGYfXCA
        aOAXc+p9KgayFKMpfxpUuJ93RZLSZko20QYf14Y=
X-Google-Smtp-Source: AGHT+IEHYOxyvb4m5QA2NEaJMK/Wdn+gFq/hDSgRir7oZnJs+E+lDi4Y/OyDG/qkgceUyiIAKpaQ/mXu0xc3wgPaftQ=
X-Received: by 2002:a05:6871:58a1:b0:1f9:e123:4fb with SMTP id
 ok33-20020a05687158a100b001f9e12304fbmr25407502oac.55.1701358748892; Thu, 30
 Nov 2023 07:39:08 -0800 (PST)
MIME-Version: 1.0
References: <20231129172200.430674-1-sjg@chromium.org> <20231129172200.430674-3-sjg@chromium.org>
In-Reply-To: <20231129172200.430674-3-sjg@chromium.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 1 Dec 2023 00:38:32 +0900
X-Gmail-Original-Message-ID: <CAK7LNARRYWhFyTXRXPC_z6RL=KUW6pO-Lsz1mgGd1jxPiHxe+w@mail.gmail.com>
Message-ID: <CAK7LNARRYWhFyTXRXPC_z6RL=KUW6pO-Lsz1mgGd1jxPiHxe+w@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] arm64: boot: Support Flat Image Tree
To:     Simon Glass <sjg@chromium.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Tom Rini <trini@konsulko.com>,
        lkml <linux-kernel@vger.kernel.org>,
        U-Boot Mailing List <u-boot@lists.denx.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Terrell <terrelln@fb.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Will Deacon <will@kernel.org>, linux-kbuild@vger.kernel.org
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

On Thu, Nov 30, 2023 at 2:22=E2=80=AFAM Simon Glass <sjg@chromium.org> wrot=
e:
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
>  MAINTAINERS                |   7 +
>  arch/arm64/Makefile        |   9 +-
>  arch/arm64/boot/.gitignore |   1 +
>  arch/arm64/boot/Makefile   |   6 +-
>  scripts/Makefile.lib       |  13 ++
>  scripts/make_fit.py        | 289 +++++++++++++++++++++++++++++++++++++
>  6 files changed, 322 insertions(+), 3 deletions(-)
>  create mode 100755 scripts/make_fit.py
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 14587be87a33..d609f0e8deb3 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1585,6 +1585,13 @@ F:       Documentation/process/maintainer-soc*.rst
>  F:     arch/arm/boot/dts/Makefile
>  F:     arch/arm64/boot/dts/Makefile
>
> +ARM64 FIT SUPPORT
> +M:     Simon Glass <sjg@chromium.org>
> +L:     linux-arm-kernel@lists.infradead.org (moderated for non-subscribe=
rs)
> +S:     Maintained
> +F:     arch/arm64/boot/Makefile
> +F:     scripts/make_fit.py
> +
>  ARM ARCHITECTED TIMER DRIVER
>  M:     Mark Rutland <mark.rutland@arm.com>
>  M:     Marc Zyngier <maz@kernel.org>
> diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
> index 1bd4fae6e806..18e092de7cdb 100644
> --- a/arch/arm64/Makefile
> +++ b/arch/arm64/Makefile
> @@ -36,6 +36,8 @@ ifeq ($(CONFIG_BROKEN_GAS_INST),y)
>  $(warning Detected assembler with broken .inst; disassembly will be unre=
liable)
>  endif
>
> +KBUILD_DTBS      :=3D dtbs


Please remove this, and hard-code

 image.fit: dtbs



>
>  $(obj)/Image: vmlinux FORCE
>         $(call if_changed,objcopy)
> @@ -39,6 +40,9 @@ $(obj)/Image.lzo: $(obj)/Image FORCE
>  $(obj)/Image.zst: $(obj)/Image FORCE
>         $(call if_changed,zstd)
>
> +$(obj)/image.fit: $(obj)/Image FORCE
> +       $(call cmd,fit,gzip)


The gzip parameter is not used.
Please do

     $(call cmd,fit)





In the python script, functions are separated with two blank lines,
but there is only one blank line between parse_args() and setup_fit().


I do not mind either way because it does not contain any class,
but please keep consistency.







--
Best Regards
Masahiro Yamada
