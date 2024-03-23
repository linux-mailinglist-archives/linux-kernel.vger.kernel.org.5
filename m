Return-Path: <linux-kernel+bounces-112425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F38E8879A2
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 18:14:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B37381C20C96
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 17:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 199B950271;
	Sat, 23 Mar 2024 17:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iRz9Ygm/"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250832940B
	for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 17:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711214061; cv=none; b=DH0wuigrNB/k5TKSJiSV+y3P5bdGLaSZtoNUWH74Sln2Fypm7mJmWbj3RN8LZ9iEIfIdn/0eImFig1Il4kYKOWagsCe0Ky323vKld6Cw97l/xPeZWlj4yhjchJ8Gcd5wozLStjUV6G8Ns3OYQ4SXYcoUsmZaFszyeSLPIJqoxkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711214061; c=relaxed/simple;
	bh=39B6HLyA0qGV53ylNtiFAt8qDKnuEgEUidlqfnikUwY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EZOJsKas/WeVQF2oBzUELjYnT6zpnW2fEAcZEING65BMiz/LkWaRrEt4UgK41vI52XsY2JqZ9kWZyG5yx2NrMXc2vlrRxjGRK+4E5S91xGBsPpMPMNMoVLG9nVZO/hLX4sD9LYB4qtP1NIo1LN6imJPfegFlqF3TAXULHYcw4Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iRz9Ygm/; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2d6c8d741e8so6770541fa.3
        for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 10:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711214057; x=1711818857; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=32Y8LYpZ4/gmdrxUrvcEQsxAtqPPNb4v2s28/hrRbMM=;
        b=iRz9Ygm/1J4JQQEd3m+mFz0n/2iHa6KxQHV5YcUk17nVxa19AQKnEWUU5xjpr6MMdw
         HcjPEBh/0MuCeAU0xK/GPtuLkIUqI9gymsDeGoFNHdhq5HWk6N8q5FheDbWHrXgJK+Sq
         ACsNqHD+36XsvjCbmBt0Cqw5LxTMTJpE+gRpfsG8EkEV+thv9DUmB7qgSg/buOBNPUKq
         HMONWIwv/uOKPDqabXSbgcjZyGv3Nyg+96VB5+my0MQjIFcLHoxL+4pBerFf5B1oyYvC
         LlEyCvLgqjgBAZjcWEH27a+uWx+xMWS9Kg/gadBHhp4/NisYpVQRaFJH+/lxUUVDLd51
         SH2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711214057; x=1711818857;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=32Y8LYpZ4/gmdrxUrvcEQsxAtqPPNb4v2s28/hrRbMM=;
        b=OzLEPwg+YyctihCMUXI2ny3BzlNQGbpNYKUsd2KD3ladvzZYX+4FsIlfuLCMn8wCXY
         rVILRddrbT7D5oolfBachqG6RAktpZgbP2j9wcd8EH9vjDh973aEVXZOqLbZdYnklT4x
         ZaG2HsDrI5FVDTnCtATz+IHToMM3cyrGL9wyX3Iniy+wBTi0rjA/AYYyM6Xu8ErqMxDt
         PrIRlRINr9pq8ppCXh1xjgLyN5RVWTMVamEK7bRA1LbG7YaRUpsH2Q+DTSRLJiuNjaL0
         Zl/tA5SHaa2d3hWHNwLytp2/pu0KdEauLZiF9jXT/CvSZjwG4k66CStBzH8u/e1R9a1Y
         Xh4A==
X-Gm-Message-State: AOJu0Yz69XL35HTflgeExI2r5BtPNK+mOfGa9nSOpWJXjiUkngFF4eoQ
	Fng2VsNF8IcQo7snAmZ4Y4jjTvxhoNnuS6vCbllEJ/Pt0naKZdJue19wvAXdxSB2i25Ilrgeq8G
	xPs6YubyopSbjKw1+mBL2mhiHorE=
X-Google-Smtp-Source: AGHT+IEr4gOFYkNOopVKxJj2p73UYEYETm7kJ8RGyoYIufcbRZLoYEo4MqRd5KjO57c6jdpe3imPgQW+dCky1BK8pGg=
X-Received: by 2002:a2e:889a:0:b0:2d6:b8cf:485a with SMTP id
 k26-20020a2e889a000000b002d6b8cf485amr1662157lji.25.1711214056975; Sat, 23
 Mar 2024 10:14:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240322165233.71698-1-brgerst@gmail.com> <20240322165233.71698-10-brgerst@gmail.com>
In-Reply-To: <20240322165233.71698-10-brgerst@gmail.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Sat, 23 Mar 2024 18:14:15 +0100
Message-ID: <CAFULd4Zw-iCNVoz_+QN2KMOOZex6-DZZDSSN2uGbWvPsJFcJtQ@mail.gmail.com>
Subject: Re: [PATCH v4 09/16] x86/percpu/64: Use relative percpu offsets
To: Brian Gerst <brgerst@gmail.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, 
	Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, 
	"H . Peter Anvin" <hpa@zytor.com>, David.Laight@aculab.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 22, 2024 at 5:52=E2=80=AFPM Brian Gerst <brgerst@gmail.com> wro=
te:
>
> The percpu section is currently linked at virtual address 0, because
> older compilers hardcoded the stack protector canary value at a fixed
> offset from the start of the GS segment.  Now that the canary is a
> normal percpu variable, the percpu section does not need to be linked
> at a specific virtual address.  This means that x86-64 will calculate
> percpu offsets like most other architectures, as the delta between the
> initial percpu address and the dynamically allocated memory.
>
> Signed-off-by: Brian Gerst <brgerst@gmail.com>

Reviewed-by: Uros Bizjak <ubizjak@gmail.com>

> ---
>  arch/x86/include/asm/processor.h |  6 +++++-
>  arch/x86/kernel/head_64.S        | 19 +++++++++----------
>  arch/x86/kernel/setup_percpu.c   | 12 ++----------
>  arch/x86/kernel/vmlinux.lds.S    | 29 +----------------------------
>  arch/x86/platform/pvh/head.S     |  5 ++---
>  arch/x86/tools/relocs.c          | 10 +++-------
>  arch/x86/xen/xen-head.S          |  9 ++++-----
>  init/Kconfig                     |  2 +-
>  8 files changed, 27 insertions(+), 65 deletions(-)
>
> diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/proc=
essor.h
> index 946bebce396f..40d6add8ff31 100644
> --- a/arch/x86/include/asm/processor.h
> +++ b/arch/x86/include/asm/processor.h
> @@ -396,7 +396,11 @@ DECLARE_INIT_PER_CPU(fixed_percpu_data);
>
>  static inline unsigned long cpu_kernelmode_gs_base(int cpu)
>  {
> -       return (unsigned long)per_cpu(fixed_percpu_data.gs_base, cpu);
> +#ifdef CONFIG_SMP
> +       return per_cpu_offset(cpu);
> +#else
> +       return 0;
> +#endif
>  }
>
>  extern asmlinkage void entry_SYSCALL32_ignore(void);
> diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
> index cfbf0486d424..5b2cc711feec 100644
> --- a/arch/x86/kernel/head_64.S
> +++ b/arch/x86/kernel/head_64.S
> @@ -68,11 +68,14 @@ SYM_CODE_START_NOALIGN(startup_64)
>         /* Set up the stack for verify_cpu() */
>         leaq    __top_init_kernel_stack(%rip), %rsp
>
> -       /* Setup GSBASE to allow stack canary access for C code */
> +       /*
> +        * Set up GSBASE.
> +        * Note that, on SMP, the boot cpu uses init data section until
> +        * the per cpu areas are set up.
> +        */
>         movl    $MSR_GS_BASE, %ecx
> -       leaq    INIT_PER_CPU_VAR(fixed_percpu_data)(%rip), %rdx
> -       movl    %edx, %eax
> -       shrq    $32,  %rdx
> +       xorl    %eax, %eax
> +       xorl    %edx, %edx
>         wrmsr
>
>         call    startup_64_setup_gdt_idt
> @@ -359,16 +362,12 @@ SYM_INNER_LABEL(common_startup_64, SYM_L_LOCAL)
>         movl %eax,%fs
>         movl %eax,%gs
>
> -       /* Set up %gs.
> -        *
> -        * The base of %gs always points to fixed_percpu_data.
> +       /*
> +        * Set up GSBASE.
>          * Note that, on SMP, the boot cpu uses init data section until
>          * the per cpu areas are set up.
>          */
>         movl    $MSR_GS_BASE,%ecx
> -#ifndef CONFIG_SMP
> -       leaq    INIT_PER_CPU_VAR(fixed_percpu_data)(%rip), %rdx
> -#endif
>         movl    %edx, %eax
>         shrq    $32, %rdx
>         wrmsr
> diff --git a/arch/x86/kernel/setup_percpu.c b/arch/x86/kernel/setup_percp=
u.c
> index b30d6e180df7..1e7be9409aa2 100644
> --- a/arch/x86/kernel/setup_percpu.c
> +++ b/arch/x86/kernel/setup_percpu.c
> @@ -23,18 +23,10 @@
>  #include <asm/cpumask.h>
>  #include <asm/cpu.h>
>
> -#ifdef CONFIG_X86_64
> -#define BOOT_PERCPU_OFFSET ((unsigned long)__per_cpu_load)
> -#else
> -#define BOOT_PERCPU_OFFSET 0
> -#endif
> -
> -DEFINE_PER_CPU_READ_MOSTLY(unsigned long, this_cpu_off) =3D BOOT_PERCPU_=
OFFSET;
> +DEFINE_PER_CPU_READ_MOSTLY(unsigned long, this_cpu_off);
>  EXPORT_PER_CPU_SYMBOL(this_cpu_off);
>
> -unsigned long __per_cpu_offset[NR_CPUS] __ro_after_init =3D {
> -       [0 ... NR_CPUS-1] =3D BOOT_PERCPU_OFFSET,
> -};
> +unsigned long __per_cpu_offset[NR_CPUS] __ro_after_init;
>  EXPORT_SYMBOL(__per_cpu_offset);
>
>  /*
> diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.=
S
> index 3509afc6a672..0b152f96c24e 100644
> --- a/arch/x86/kernel/vmlinux.lds.S
> +++ b/arch/x86/kernel/vmlinux.lds.S
> @@ -99,12 +99,6 @@ const_pcpu_hot =3D pcpu_hot;
>  PHDRS {
>         text PT_LOAD FLAGS(5);          /* R_E */
>         data PT_LOAD FLAGS(6);          /* RW_ */
> -#ifdef CONFIG_X86_64
> -#ifdef CONFIG_SMP
> -       percpu PT_LOAD FLAGS(6);        /* RW_ */
> -#endif
> -       init PT_LOAD FLAGS(7);          /* RWE */
> -#endif
>         note PT_NOTE FLAGS(0);          /* ___ */
>  }
>
> @@ -222,21 +216,7 @@ SECTIONS
>                 __init_begin =3D .; /* paired with __init_end */
>         }
>
> -#if defined(CONFIG_X86_64) && defined(CONFIG_SMP)
> -       /*
> -        * percpu offsets are zero-based on SMP.  PERCPU_VADDR() changes =
the
> -        * output PHDR, so the next output section - .init.text - should
> -        * start another segment - init.
> -        */
> -       PERCPU_VADDR(INTERNODE_CACHE_BYTES, 0, :percpu)
> -       ASSERT(SIZEOF(.data..percpu) < CONFIG_PHYSICAL_START,
> -              "per-CPU data too large - increase CONFIG_PHYSICAL_START")
> -#endif
> -
>         INIT_TEXT_SECTION(PAGE_SIZE)
> -#ifdef CONFIG_X86_64
> -       :init
> -#endif
>
>         /*
>          * Section for code used exclusively before alternatives are run.=
 All
> @@ -353,9 +333,7 @@ SECTIONS
>                 EXIT_DATA
>         }
>
> -#if !defined(CONFIG_X86_64) || !defined(CONFIG_SMP)
>         PERCPU_SECTION(INTERNODE_CACHE_BYTES)
> -#endif
>
>         . =3D ALIGN(PAGE_SIZE);
>
> @@ -493,16 +471,11 @@ SECTIONS
>   * Per-cpu symbols which need to be offset from __per_cpu_load
>   * for the boot processor.
>   */
> -#define INIT_PER_CPU(x) init_per_cpu__##x =3D ABSOLUTE(x) + __per_cpu_lo=
ad
> +#define INIT_PER_CPU(x) init_per_cpu__##x =3D ABSOLUTE(x)
>  INIT_PER_CPU(gdt_page);
>  INIT_PER_CPU(fixed_percpu_data);
>  INIT_PER_CPU(irq_stack_backing_store);
>
> -#ifdef CONFIG_SMP
> -. =3D ASSERT((fixed_percpu_data =3D=3D 0),
> -           "fixed_percpu_data is not at start of per-cpu area");
> -#endif
> -
>  #ifdef CONFIG_MITIGATION_UNRET_ENTRY
>  . =3D ASSERT((retbleed_return_thunk & 0x3f) =3D=3D 0, "retbleed_return_t=
hunk not cacheline-aligned");
>  #endif
> diff --git a/arch/x86/platform/pvh/head.S b/arch/x86/platform/pvh/head.S
> index 1f1c3230b27b..7e3e07c6170f 100644
> --- a/arch/x86/platform/pvh/head.S
> +++ b/arch/x86/platform/pvh/head.S
> @@ -101,9 +101,8 @@ SYM_CODE_START_LOCAL(pvh_start_xen)
>          * the per cpu areas are set up.
>          */
>         mov $MSR_GS_BASE,%ecx
> -       lea INIT_PER_CPU_VAR(fixed_percpu_data)(%rip), %rdx
> -       mov %edx, %eax
> -       shr $32, %rdx
> +       xor %eax, %eax
> +       xor %edx, %edx
>         wrmsr
>
>         call xen_prepare_pvh
> diff --git a/arch/x86/tools/relocs.c b/arch/x86/tools/relocs.c
> index adf11a48ec70..016650ddaf7f 100644
> --- a/arch/x86/tools/relocs.c
> +++ b/arch/x86/tools/relocs.c
> @@ -839,12 +839,7 @@ static void percpu_init(void)
>   */
>  static int is_percpu_sym(ElfW(Sym) *sym, const char *symname)
>  {
> -       int shndx =3D sym_index(sym);
> -
> -       return (shndx =3D=3D per_cpu_shndx) &&
> -               strcmp(symname, "__init_begin") &&
> -               strcmp(symname, "__per_cpu_load") &&
> -               strncmp(symname, "init_per_cpu_", 13);
> +       return 0;
>  }
>
>
> @@ -1068,7 +1063,8 @@ static int cmp_relocs(const void *va, const void *v=
b)
>
>  static void sort_relocs(struct relocs *r)
>  {
> -       qsort(r->offset, r->count, sizeof(r->offset[0]), cmp_relocs);
> +       if (r->count)
> +               qsort(r->offset, r->count, sizeof(r->offset[0]), cmp_relo=
cs);
>  }
>
>  static int write32(uint32_t v, FILE *f)
> diff --git a/arch/x86/xen/xen-head.S b/arch/x86/xen/xen-head.S
> index ae4672ea00bb..1796884b727d 100644
> --- a/arch/x86/xen/xen-head.S
> +++ b/arch/x86/xen/xen-head.S
> @@ -51,15 +51,14 @@ SYM_CODE_START(startup_xen)
>
>         leaq    __top_init_kernel_stack(%rip), %rsp
>
> -       /* Set up %gs.
> -        *
> -        * The base of %gs always points to fixed_percpu_data.
> +       /*
> +        * Set up GSBASE.
>          * Note that, on SMP, the boot cpu uses init data section until
>          * the per cpu areas are set up.
>          */
>         movl    $MSR_GS_BASE,%ecx
> -       movq    $INIT_PER_CPU_VAR(fixed_percpu_data),%rax
> -       cdq
> +       xorl    %eax, %eax
> +       xorl    %edx, %edx
>         wrmsr
>
>         mov     %rsi, %rdi
> diff --git a/init/Kconfig b/init/Kconfig
> index f3ea5dea9c85..0f928f82dc7a 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -1784,7 +1784,7 @@ config KALLSYMS_ALL
>  config KALLSYMS_ABSOLUTE_PERCPU
>         bool
>         depends on KALLSYMS
> -       default X86_64 && SMP
> +       default n
>
>  config KALLSYMS_BASE_RELATIVE
>         bool
> --
> 2.44.0
>

