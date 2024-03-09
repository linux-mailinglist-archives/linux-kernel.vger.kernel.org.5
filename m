Return-Path: <linux-kernel+bounces-97699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B239876E06
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 01:01:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46801283BAE
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 00:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C737B16FF30;
	Sat,  9 Mar 2024 00:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FIBtotqC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD3816FF23
	for <linux-kernel@vger.kernel.org>; Sat,  9 Mar 2024 00:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709942484; cv=none; b=OHVsYfibgxhwbqe8e69OApLfVzXcBSeV5wL1L+LPKoFRSRg/sDrTLBPewW0bALF4h/wveFmdYLIU0wpHz+XNkLgGQ+fs0PW79+Wf+IIibo0Dw5pXWa8ZdxY9zM65+07C4tuBK1oG8YAGceKip9H02/eSUsFqa2Ey9gTKWXr3n1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709942484; c=relaxed/simple;
	bh=WZ4W73MTfmE84LJqnRgEDXfG7CvAs4QRk7mjF/uxqM8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d5poseznvGS6wlW9HsNGa/FYpOJU5cg1CGdNxlhXUqZt9dlzAUKMgceCaDuuVyHTE1nLH5fxJE3XDiV7a7VEBMKFHFWjIwNfhinKO+qDy+YhG/4nOgx7UEGJofECNbz2e0ktVwQMaEcxNg1VJWrLVjwgyrHAy3OhWcFaG0tVIK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FIBtotqC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1256C43601
	for <linux-kernel@vger.kernel.org>; Sat,  9 Mar 2024 00:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709942484;
	bh=WZ4W73MTfmE84LJqnRgEDXfG7CvAs4QRk7mjF/uxqM8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=FIBtotqCdkQJM5sYfMuWtQbKFXNFZYl48V55jbojHATXbfiTuwgwX07SCurqQZ445
	 cv4tEsMwbgrWV1QbZkXRB+Vp3ZQriuWKFL9w2h5SaSyPYhxdtKqD4z41fCxFUAsKqO
	 GysODStLkxHWeKlXFfcoybCeyBdJbzp6N7p4PnkieCudUyE/Hn4Pbd9Mp+SWwhcukN
	 sMpRyrmzhcgRUPKr0cl3umAfx55NE/so51MmsllvrU4AiIW0PyKUA2xZXWwekkKuOL
	 YBgnNtUgVTnwLxUXf5JvApWOfSygDqLTRvFptT3UHxmamrMzpp54gS8/OGtiZUJv8W
	 sJhJ0Ix3VoSEQ==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-512f54fc2dbso2470190e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2024 16:01:24 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUyvBqKSf2OnDusgGPiwiGsywJxmdYl8PNzT4G4onLU5+tvWvmUF2w8LfqDGAL+0msioaQcNMz8mrxKMbic2nF6gkqO4qgaJ+1gMtIr
X-Gm-Message-State: AOJu0YyrAQChdl4mzOszbF45siVuHi3IjVcgozYXJwHO4oC1f7g2poY9
	FDcjK018colnO26AWCejZZTRxUlNkyKVdCzGqouTckWvWUphAGzX5IJ3OMvaC/m/kxz3lCQXm5A
	bjoeE/G6NnqcbYALsnqdDnanZPto=
X-Google-Smtp-Source: AGHT+IE1QYFHg7LWRKwhfsVxpXPXHvI/UbI2jZsIyqdJ5blUW1p6gfiUDRpBH3EPGPM5UdFV4pCWov4+TtW7djQ9Mgc=
X-Received: by 2002:a05:6512:10d1:b0:513:59fb:1a50 with SMTP id
 k17-20020a05651210d100b0051359fb1a50mr365211lfg.54.1709942482582; Fri, 08 Mar
 2024 16:01:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240307151231.654025-1-liuyuntao12@huawei.com>
 <58cc1053-7208-4b22-99cb-210fdf700569@app.fastmail.com> <CAMj1kXFEdRZsy8FovGrfWotoaws1KoKbFv5q+7yKL=pRV8zkZw@mail.gmail.com>
 <CAMj1kXF7fOO6gyvTJNOKp1_PVtAUi08ezz6k1g7jHNfUXAzXUw@mail.gmail.com>
In-Reply-To: <CAMj1kXF7fOO6gyvTJNOKp1_PVtAUi08ezz6k1g7jHNfUXAzXUw@mail.gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Sat, 9 Mar 2024 01:01:11 +0100
X-Gmail-Original-Message-ID: <CAMj1kXE+XeMTw6VdtiTDFw_zgWEngN_mFbUy+WECNckb5m0NAg@mail.gmail.com>
Message-ID: <CAMj1kXE+XeMTw6VdtiTDFw_zgWEngN_mFbUy+WECNckb5m0NAg@mail.gmail.com>
Subject: Re: [PATCH-next v2] arm32: enable HAVE_LD_DEAD_CODE_DATA_ELIMINATION
To: Arnd Bergmann <arnd@arndb.de>
Cc: Yuntao Liu <liuyuntao12@huawei.com>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Fangrui Song <maskray@google.com>, 
	Russell King <linux@armlinux.org.uk>, Andrew Davis <afd@ti.com>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Jonathan Corbet <corbet@lwn.net>, 
	Mike Rapoport <rppt@kernel.org>, Rob Herring <robh@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Linus Walleij <linus.walleij@linaro.org>, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Fri, 8 Mar 2024 at 16:37, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Fri, 8 Mar 2024 at 15:27, Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > On Fri, 8 Mar 2024 at 14:16, Arnd Bergmann <arnd@arndb.de> wrote:
> > >
> > > On Thu, Mar 7, 2024, at 16:12, Yuntao Liu wrote:
> > > > The current arm32 architecture does not yet support the
> > > > HAVE_LD_DEAD_CODE_DATA_ELIMINATION feature. arm32 is widely used in
> > > > embedded scenarios, and enabling this feature would be beneficial for
> > > > reducing the size of the kernel image.
> > > >
> > > > In order to make this work, we keep the necessary tables by annotating
> > > > them with KEEP, also it requires further changes to linker script to KEEP
> > > > some tables and wildcard compiler generated sections into the right place.
> > > >
> > > > It boots normally with defconfig, vexpress_defconfig and tinyconfig.
> > > >
> > > > The size comparison of zImage is as follows:
> > > > defconfig       vexpress_defconfig      tinyconfig
> > > > 5137712         5138024                 424192          no dce
> > > > 5032560         4997824                 298384          dce
> > > > 2.0%            2.7%                    29.7%           shrink
> > > >
> > > > When using smaller config file, there is a significant reduction in the
> > > > size of the zImage.
> > > >
> > > > We also tested this patch on a commercially available single-board
> > > > computer, and the comparison is as follows:
> > > > a15eb_config
> > > > 2161384         no dce
> > > > 2092240         dce
> > > > 3.2%            shrink
> > > >
> > > > The zImage size has been reduced by approximately 3.2%, which is 70KB on
> > > > 2.1M.
> > > >
> > > > Signed-off-by: Yuntao Liu <liuyuntao12@huawei.com>
> > >
> > > I've retested with both gcc-13 and clang-18, and so no
> > > more build issues. Your previous version already worked
> > > fine for me.
> > >
> > > I did some tests combining this with CONFIG_TRIM_UNUSED_KSYMS,
> > > which showed a significant improvement as expected. I also
> > > tried combining it with an experimental CONFIG_LTO_CLANG
> > > patch, but that did not show any further improvements.
> > >
> > > Tested-by: Arnd Bergmann <arnd@arndb.de>
> > > Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> > >
> > > Adding Ard Biesheuvel and Fangrui Song to Cc, so they can comment
> > > on the ARM_VECTORS_TEXT workaround. I don't understand enough of
> > > the details of what is going on here.
> > >
> >
> > Thanks for the cc
> >
> > > Full quote of the patch below so they can see the whole thing.
> > >
> > > If they are also happy with the patch, I think you can send it
> > > into Russell's patch tracker at
> > > https://www.armlinux.org.uk/developer/patches/info.php
> > >
> >
> > No, not happy at all :-)
> >
> > The resulting kernel does not boot (built with GCC or Clang). And the
> > patch is buggy (see below)
> >
> > > > ---
> > > > v2:
> > > >    - Support config XIP_KERNEL.
> > > >    - Support LLVM compilation.
> > > >
> > > > v1: https://lore.kernel.org/all/20240220081527.23408-1-liuyuntao12@huawei.com/
> > > > ---
> > > >  arch/arm/Kconfig                       |  1 +
> > > >  arch/arm/boot/compressed/vmlinux.lds.S |  4 ++--
> > > >  arch/arm/include/asm/vmlinux.lds.h     | 18 +++++++++++++++++-
> > > >  arch/arm/kernel/vmlinux-xip.lds.S      |  8 ++++++--
> > > >  arch/arm/kernel/vmlinux.lds.S          | 10 +++++++---
> > > >  5 files changed, 33 insertions(+), 8 deletions(-)
> > > >
> > > > diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> > > > index 0af6709570d1..de78ceb821df 100644
> > > > --- a/arch/arm/Kconfig
> > > > +++ b/arch/arm/Kconfig
> > > > @@ -113,6 +113,7 @@ config ARM
> > > >       select HAVE_KERNEL_XZ
> > > >       select HAVE_KPROBES if !XIP_KERNEL && !CPU_ENDIAN_BE32 && !CPU_V7M
> > > >       select HAVE_KRETPROBES if HAVE_KPROBES
> > > > +     select HAVE_LD_DEAD_CODE_DATA_ELIMINATION
> > > >       select HAVE_MOD_ARCH_SPECIFIC
> > > >       select HAVE_NMI
> > > >       select HAVE_OPTPROBES if !THUMB2_KERNEL
> > > > diff --git a/arch/arm/boot/compressed/vmlinux.lds.S
> > > > b/arch/arm/boot/compressed/vmlinux.lds.S
> > > > index 3fcb3e62dc56..da21244aa892 100644
> > > > --- a/arch/arm/boot/compressed/vmlinux.lds.S
> > > > +++ b/arch/arm/boot/compressed/vmlinux.lds.S
> > > > @@ -89,7 +89,7 @@ SECTIONS
> > > >       * The EFI stub always executes from RAM, and runs strictly before
> > > > the
> > > >       * decompressor, so we can make an exception for its r/w data, and
> > > > keep it
> > > >       */
> > > > -    *(.data.efistub .bss.efistub)
> > > > +    *(.data.* .bss.*)
> >
> > Why is this necessary? There is a reason we don't allow .data in the
> > decompressor.
> >
> > > >      __pecoff_data_end = .;
> > > >
> > > >      /*
> > > > @@ -125,7 +125,7 @@ SECTIONS
> > > >
> > > >    . = BSS_START;
> > > >    __bss_start = .;
> > > > -  .bss                       : { *(.bss) }
> > > > +  .bss                       : { *(.bss .bss.*) }
> > > >    _end = .;
> > > >
> > > >    . = ALIGN(8);              /* the stack must be 64-bit aligned */
> > > > diff --git a/arch/arm/include/asm/vmlinux.lds.h
> > > > b/arch/arm/include/asm/vmlinux.lds.h
> > > > index 4c8632d5c432..dfe2b6ad6b51 100644
> > > > --- a/arch/arm/include/asm/vmlinux.lds.h
> > > > +++ b/arch/arm/include/asm/vmlinux.lds.h
> > > > @@ -42,7 +42,7 @@
> > > >  #define PROC_INFO                                                    \
> > > >               . = ALIGN(4);                                           \
> > > >               __proc_info_begin = .;                                  \
> > > > -             *(.proc.info.init)                                      \
> > > > +             KEEP(*(.proc.info.init))                                \
> > > >               __proc_info_end = .;
> > > >
> > > >  #define IDMAP_TEXT                                                   \
> > > > @@ -87,6 +87,22 @@
> > > >               *(.vfp11_veneer)                                        \
> > > >               *(.v4_bx)
> > > >
> > > > +/*
> > > > +When CONFIG_LD_DEAD_CODE_DATA_ELIMINATION is enabled, it is important
> > > > to
> > > > +annotate .vectors sections with KEEP. While linking with ld, it is
> > > > +acceptable to directly use KEEP with .vectors sections in ARM_VECTORS.
> > > > +However, when using ld.lld for linking, KEEP is not recognized within
> > > > the
> > > > +OVERLAY command; it is treated as a regular string. Hence, it is
> > > > advisable
> > > > +to define a distinct section here that explicitly retains the .vectors
> > > > +sections when CONFIG_LD_DEAD_CODE_DATA_ELIMINATION is turned on.
> > > > +*/
> > > > +#define ARM_VECTORS_TEXT                                             \
> > > > +     .vectors.text : {                                               \
> > > > +             KEEP(*(.vectors))                                       \
> > > > +             KEEP(*(.vectors.bhb.loop8))                             \
> > > > +             KEEP(*(.vectors.bhb.bpiall))                            \
> > > > +       }
> > > > +
> >
> > This looks fishy to me. How is this supposed to work? You cannot emit
> > these sections into some random other place in the binary.
> >
> > And also, ARM_VECTORS_TEXT is never used (by accident, see below)
> >
>
> The below appears to work for me:
>
> --- a/arch/arm/kernel/entry-armv.S
> +++ b/arch/arm/kernel/entry-armv.S
> @@ -1076,7 +1076,12 @@
>         W(b)    vector_irq
>         W(b)    vector_fiq
>
> +       .text
> +       .reloc  ., R_ARM_NONE, .vectors
>  #ifdef CONFIG_HARDEN_BRANCH_HISTORY
> +       .reloc  ., R_ARM_NONE, .vectors.bhb.loop8
> +       .reloc  ., R_ARM_NONE, .vectors.bhb.bpiall
> +
>         .section .vectors.bhb.loop8, "ax", %progbits
>         W(b)    vector_rst
>         W(b)    vector_bhb_loop8_und

.. or even better:

--- a/arch/arm/kernel/entry-armv.S
+++ b/arch/arm/kernel/entry-armv.S
@@ -1066,4 +1066,5 @@

        .section .vectors, "ax", %progbits
+       .reloc  .text, R_ARM_NONE, .
        W(b)    vector_rst
        W(b)    vector_und
@@ -1079,4 +1080,5 @@
 #ifdef CONFIG_HARDEN_BRANCH_HISTORY
        .section .vectors.bhb.loop8, "ax", %progbits
+       .reloc  .text, R_ARM_NONE, .
        W(b)    vector_rst
        W(b)    vector_bhb_loop8_und
@@ -1091,4 +1093,5 @@

        .section .vectors.bhb.bpiall, "ax", %progbits
+       .reloc  .text, R_ARM_NONE, .
        W(b)    vector_rst
        W(b)    vector_bhb_bpiall_und

