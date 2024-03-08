Return-Path: <linux-kernel+bounces-97167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6235C87665A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 15:28:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16C17282A63
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 14:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7DFF4644F;
	Fri,  8 Mar 2024 14:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cncRy3ak"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC21440868
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 14:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709908092; cv=none; b=P2SrbNA+PSM7iSXpM/XEMC9Ao7iFzjwStFR8y/FGSLhui3OaJlGDAFq2EcBYOwoTTRk9yBcuWMUhFVfLLb3mtwjOiNVNgXEClTDh+ygMQwUSWWRsFE2wAFGg5YId0rJoPr3p++nfaieWYG46wc4Of3VDBFn8T3w4WAfiFG8dHPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709908092; c=relaxed/simple;
	bh=5AtrVtoFX1VaNMDaxCXkrQKi2UrlX1NqmyJLiBNj0EM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VVQjAk7yDPn9VIg9+A6+4Jr5clVs7KyJ/Tc+yDJcb1Bx768Ogff8sdgRpE/mhZOokwXPHq0uSQD8IJ3K0uqDDXY8ZRTPSs/OGnOc3CVdJv5Tf4xXT9LZCoecKEU8RG6mUvzaK6h23pp14UujAZR+l5PwxHO3eKYtrUWnit5rqSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cncRy3ak; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75558C43399
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 14:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709908092;
	bh=5AtrVtoFX1VaNMDaxCXkrQKi2UrlX1NqmyJLiBNj0EM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=cncRy3akY/qEcMzh1DPZZTiHsIsiUaDNHTdKPuyfjLSoshUlU+j7MPCRfpyn0/mjg
	 w9xQaSUs/TU/f9kJ2WYJw3ixiOqRyxiSVyPjSAGO6mLqZY9GUMut+JUqXk2oe53jbD
	 QiqjpNd76FcAu0G2zsRqlw7R7rLYRu00GZh5CMonJt7Tgc6/P/0uJW2FjhCEfTbRDC
	 8I0jMppjjsIn1re2oo4GYhmHES3nwXJ9pT7lPaA37TjSgaYnMkQ/jh2HCk8RfxwU7b
	 7TCSgV4e5P74rEIvoG3+qBs+Ha1JxfbTqAQsQKBC/oQzAEEpjEHX1dXPXEiCJlW3gG
	 ACfOB4GGoB1zg==
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2d382a78c38so23961731fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2024 06:28:12 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUfykger4STA6vKG5U8RbfAbJ5cO7DyiqklhaLdwfPRbkChSW1X4DSKjvUPCMFQMH5WMKlKHJXz0pUFClr1teSqD3eFakx2LKubj0tz
X-Gm-Message-State: AOJu0Yww8vRtCQWKIRv8cDwlejUtVWtvK/8mpJWiXL/QpvFepHmySV4N
	opM1ASXr4/ltmaPFEEy5hfha1qtKWe35qwhl/XCotvh2LWJ/ins+M3zpGZRflEuCb2BNgIs+xLf
	IrQyiDANvPtfEtuSFnSm0V+xOBY8=
X-Google-Smtp-Source: AGHT+IF5uHe3Ybfym3btfzJUZ3KHe5KT343E2oyUu1ff3KCEamuWvorqVCa8Uu1aEPBrfUGEtQlQO4VkGIGz0cjXw+o=
X-Received: by 2002:a2e:9d86:0:b0:2d2:7a4e:f5ec with SMTP id
 c6-20020a2e9d86000000b002d27a4ef5ecmr3276650ljj.7.1709908090621; Fri, 08 Mar
 2024 06:28:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240307151231.654025-1-liuyuntao12@huawei.com> <58cc1053-7208-4b22-99cb-210fdf700569@app.fastmail.com>
In-Reply-To: <58cc1053-7208-4b22-99cb-210fdf700569@app.fastmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 8 Mar 2024 15:27:59 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFEdRZsy8FovGrfWotoaws1KoKbFv5q+7yKL=pRV8zkZw@mail.gmail.com>
Message-ID: <CAMj1kXFEdRZsy8FovGrfWotoaws1KoKbFv5q+7yKL=pRV8zkZw@mail.gmail.com>
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

On Fri, 8 Mar 2024 at 14:16, Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Thu, Mar 7, 2024, at 16:12, Yuntao Liu wrote:
> > The current arm32 architecture does not yet support the
> > HAVE_LD_DEAD_CODE_DATA_ELIMINATION feature. arm32 is widely used in
> > embedded scenarios, and enabling this feature would be beneficial for
> > reducing the size of the kernel image.
> >
> > In order to make this work, we keep the necessary tables by annotating
> > them with KEEP, also it requires further changes to linker script to KEEP
> > some tables and wildcard compiler generated sections into the right place.
> >
> > It boots normally with defconfig, vexpress_defconfig and tinyconfig.
> >
> > The size comparison of zImage is as follows:
> > defconfig       vexpress_defconfig      tinyconfig
> > 5137712         5138024                 424192          no dce
> > 5032560         4997824                 298384          dce
> > 2.0%            2.7%                    29.7%           shrink
> >
> > When using smaller config file, there is a significant reduction in the
> > size of the zImage.
> >
> > We also tested this patch on a commercially available single-board
> > computer, and the comparison is as follows:
> > a15eb_config
> > 2161384         no dce
> > 2092240         dce
> > 3.2%            shrink
> >
> > The zImage size has been reduced by approximately 3.2%, which is 70KB on
> > 2.1M.
> >
> > Signed-off-by: Yuntao Liu <liuyuntao12@huawei.com>
>
> I've retested with both gcc-13 and clang-18, and so no
> more build issues. Your previous version already worked
> fine for me.
>
> I did some tests combining this with CONFIG_TRIM_UNUSED_KSYMS,
> which showed a significant improvement as expected. I also
> tried combining it with an experimental CONFIG_LTO_CLANG
> patch, but that did not show any further improvements.
>
> Tested-by: Arnd Bergmann <arnd@arndb.de>
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
>
> Adding Ard Biesheuvel and Fangrui Song to Cc, so they can comment
> on the ARM_VECTORS_TEXT workaround. I don't understand enough of
> the details of what is going on here.
>

Thanks for the cc

> Full quote of the patch below so they can see the whole thing.
>
> If they are also happy with the patch, I think you can send it
> into Russell's patch tracker at
> https://www.armlinux.org.uk/developer/patches/info.php
>

No, not happy at all :-)

The resulting kernel does not boot (built with GCC or Clang). And the
patch is buggy (see below)

> > ---
> > v2:
> >    - Support config XIP_KERNEL.
> >    - Support LLVM compilation.
> >
> > v1: https://lore.kernel.org/all/20240220081527.23408-1-liuyuntao12@huawei.com/
> > ---
> >  arch/arm/Kconfig                       |  1 +
> >  arch/arm/boot/compressed/vmlinux.lds.S |  4 ++--
> >  arch/arm/include/asm/vmlinux.lds.h     | 18 +++++++++++++++++-
> >  arch/arm/kernel/vmlinux-xip.lds.S      |  8 ++++++--
> >  arch/arm/kernel/vmlinux.lds.S          | 10 +++++++---
> >  5 files changed, 33 insertions(+), 8 deletions(-)
> >
> > diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> > index 0af6709570d1..de78ceb821df 100644
> > --- a/arch/arm/Kconfig
> > +++ b/arch/arm/Kconfig
> > @@ -113,6 +113,7 @@ config ARM
> >       select HAVE_KERNEL_XZ
> >       select HAVE_KPROBES if !XIP_KERNEL && !CPU_ENDIAN_BE32 && !CPU_V7M
> >       select HAVE_KRETPROBES if HAVE_KPROBES
> > +     select HAVE_LD_DEAD_CODE_DATA_ELIMINATION
> >       select HAVE_MOD_ARCH_SPECIFIC
> >       select HAVE_NMI
> >       select HAVE_OPTPROBES if !THUMB2_KERNEL
> > diff --git a/arch/arm/boot/compressed/vmlinux.lds.S
> > b/arch/arm/boot/compressed/vmlinux.lds.S
> > index 3fcb3e62dc56..da21244aa892 100644
> > --- a/arch/arm/boot/compressed/vmlinux.lds.S
> > +++ b/arch/arm/boot/compressed/vmlinux.lds.S
> > @@ -89,7 +89,7 @@ SECTIONS
> >       * The EFI stub always executes from RAM, and runs strictly before
> > the
> >       * decompressor, so we can make an exception for its r/w data, and
> > keep it
> >       */
> > -    *(.data.efistub .bss.efistub)
> > +    *(.data.* .bss.*)

Why is this necessary? There is a reason we don't allow .data in the
decompressor.

> >      __pecoff_data_end = .;
> >
> >      /*
> > @@ -125,7 +125,7 @@ SECTIONS
> >
> >    . = BSS_START;
> >    __bss_start = .;
> > -  .bss                       : { *(.bss) }
> > +  .bss                       : { *(.bss .bss.*) }
> >    _end = .;
> >
> >    . = ALIGN(8);              /* the stack must be 64-bit aligned */
> > diff --git a/arch/arm/include/asm/vmlinux.lds.h
> > b/arch/arm/include/asm/vmlinux.lds.h
> > index 4c8632d5c432..dfe2b6ad6b51 100644
> > --- a/arch/arm/include/asm/vmlinux.lds.h
> > +++ b/arch/arm/include/asm/vmlinux.lds.h
> > @@ -42,7 +42,7 @@
> >  #define PROC_INFO                                                    \
> >               . = ALIGN(4);                                           \
> >               __proc_info_begin = .;                                  \
> > -             *(.proc.info.init)                                      \
> > +             KEEP(*(.proc.info.init))                                \
> >               __proc_info_end = .;
> >
> >  #define IDMAP_TEXT                                                   \
> > @@ -87,6 +87,22 @@
> >               *(.vfp11_veneer)                                        \
> >               *(.v4_bx)
> >
> > +/*
> > +When CONFIG_LD_DEAD_CODE_DATA_ELIMINATION is enabled, it is important
> > to
> > +annotate .vectors sections with KEEP. While linking with ld, it is
> > +acceptable to directly use KEEP with .vectors sections in ARM_VECTORS.
> > +However, when using ld.lld for linking, KEEP is not recognized within
> > the
> > +OVERLAY command; it is treated as a regular string. Hence, it is
> > advisable
> > +to define a distinct section here that explicitly retains the .vectors
> > +sections when CONFIG_LD_DEAD_CODE_DATA_ELIMINATION is turned on.
> > +*/
> > +#define ARM_VECTORS_TEXT                                             \
> > +     .vectors.text : {                                               \
> > +             KEEP(*(.vectors))                                       \
> > +             KEEP(*(.vectors.bhb.loop8))                             \
> > +             KEEP(*(.vectors.bhb.bpiall))                            \
> > +       }
> > +

This looks fishy to me. How is this supposed to work? You cannot emit
these sections into some random other place in the binary.

And also, ARM_VECTORS_TEXT is never used (by accident, see below)

> >  #define ARM_TEXT                                                     \
> >               IDMAP_TEXT                                              \
> >               __entry_text_start = .;                                 \
> > diff --git a/arch/arm/kernel/vmlinux-xip.lds.S
> > b/arch/arm/kernel/vmlinux-xip.lds.S
> > index c16d196b5aad..035fa18060b3 100644
> > --- a/arch/arm/kernel/vmlinux-xip.lds.S
> > +++ b/arch/arm/kernel/vmlinux-xip.lds.S
> > @@ -63,7 +63,7 @@ SECTIONS
> >       . = ALIGN(4);
> >       __ex_table : AT(ADDR(__ex_table) - LOAD_OFFSET) {
> >               __start___ex_table = .;
> > -             ARM_MMU_KEEP(*(__ex_table))
> > +             ARM_MMU_KEEP(KEEP(*(__ex_table)))
> >               __stop___ex_table = .;
> >       }
> >
> > @@ -83,7 +83,7 @@ SECTIONS
> >       }
> >       .init.arch.info : {
> >               __arch_info_begin = .;
> > -             *(.arch.info.init)
> > +             KEEP(*(.arch.info.init))
> >               __arch_info_end = .;
> >       }
> >       .init.tagtable : {
> > @@ -135,6 +135,10 @@ SECTIONS
> >       ARM_TCM
> >  #endif
> >
> > +#ifdef LD_DEAD_CODE_DATA_ELIMINATION

This should be CONFIG_LD_DEAD_CODE_DATA_ELIMINATION

> > +     ARM_VECTORS_TEXT
> > +#endif
> > +
> >       /*
> >        * End of copied data. We need a dummy section to get its LMA.
> >        * Also located before final ALIGN() as trailing padding is not stored
> > diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.lds.S
> > index bd9127c4b451..2cfb890c93fb 100644
> > --- a/arch/arm/kernel/vmlinux.lds.S
> > +++ b/arch/arm/kernel/vmlinux.lds.S
> > @@ -74,7 +74,7 @@ SECTIONS
> >       . = ALIGN(4);
> >       __ex_table : AT(ADDR(__ex_table) - LOAD_OFFSET) {
> >               __start___ex_table = .;
> > -             ARM_MMU_KEEP(*(__ex_table))
> > +             ARM_MMU_KEEP(KEEP(*(__ex_table)))
> >               __stop___ex_table = .;
> >       }
> >
> > @@ -99,7 +99,7 @@ SECTIONS
> >       }
> >       .init.arch.info : {
> >               __arch_info_begin = .;
> > -             *(.arch.info.init)
> > +             KEEP(*(.arch.info.init))
> >               __arch_info_end = .;
> >       }
> >       .init.tagtable : {
> > @@ -116,7 +116,7 @@ SECTIONS
> >  #endif
> >       .init.pv_table : {
> >               __pv_table_begin = .;
> > -             *(.pv_table)
> > +             KEEP(*(.pv_table))
> >               __pv_table_end = .;
> >       }
>
> I previously asked about this bit, since it appeared that this
> might prevent a lot of code from being discarded when
> CONFIG_ARM_PATCH_PHYS_VIRT is set. I tested this again now,
> and found this makes very little practical difference, so
> it's all good.
>
> > @@ -134,6 +134,10 @@ SECTIONS
> >       ARM_TCM
> >  #endif
> >
> > +#ifdef LD_DEAD_CODE_DATA_ELIMINATION

Same here


> > +     ARM_VECTORS_TEXT
> > +#endif
> > +
> >  #ifdef CONFIG_STRICT_KERNEL_RWX
> >       . = ALIGN(1<<SECTION_SHIFT);
> >  #else

