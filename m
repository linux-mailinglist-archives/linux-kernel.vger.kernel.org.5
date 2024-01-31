Return-Path: <linux-kernel+bounces-46525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B74284410A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 14:52:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CCCB0B321D5
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 13:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20D1D7BB03;
	Wed, 31 Jan 2024 13:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k53eNSe4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543B57F493
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 13:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706708553; cv=none; b=kx8yEteT4I985hqaI/37yvUkRKyLSCIkvI2atHuCZL40c28RyLl5h7z9h2xluZDg0Ul7K163slO8ZsuFLp0K0gfL/U0JeUDKabBEMQs0LA1HjQ0aKnX47TXCI+UFNlMOZ3XWmop2nbpM9xPcGCwhryvCs5b5gFlGI3hJiFoL7V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706708553; c=relaxed/simple;
	bh=nyBn7SIh0lugDEkVqNucoKXkgPzBoEWd6xzQ4ecsn/Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XtyDFbXn/EdW2+/BKBpqQG0nipynsszwxGghs8QEVAHyUjm/zcaVnlgBO1cQmUUMPxLAyA/XBRUU19SHGSocyloaIehu61oxtCQw/dVerz6s/2LW0yqza0AyL/jaVvwmjvF3c5gYMM31beJ10s3p2fSYwiVF3WE/hqhrAW4ywvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k53eNSe4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7BCAC41674
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 13:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706708552;
	bh=nyBn7SIh0lugDEkVqNucoKXkgPzBoEWd6xzQ4ecsn/Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=k53eNSe45wQRAO3vKSt0759+SidkYUS4Y3QAuhKzuQCuB0td2gp02WSjG+mT0XK/x
	 OcbHdZR45WTOl4nzeSka87G2gYWyOIySf1r0SV7HYsXbRI8OcI7icxw/K2GG/7+LeA
	 uQ1s6XIci4nQjE008AHzgkwCQCkX0+gx+FRv/KUei4OMOUtqXCKBhXnE9Bx2Y+LYpK
	 xaeWql+H2/m7rcOc4858xTAA9ZgxKVgtzyutCW2789C/PROCrVxyz5bYtIqoKvbeID
	 U235L+3J2Z/pSgdX4tF+KdLngj7Izs77OUbd3YDNpxIQerUJEiR6229xOoYh4Ob3of
	 K07rQRMzjBAfw==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5112a04c7acso146365e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 05:42:32 -0800 (PST)
X-Gm-Message-State: AOJu0YwuKdyUnKCNY9VtbjHBgrpuseLHmpliOa3FxMJTNGjGfz0HLI1l
	rR5dl3RxYuVmN6xNX48AvDHzK0hhNy3JKphLXKQHx9zZYUUhbGgWlAHOuWtAUurA+9m6XhuLLQ1
	UKGbcSeqs0SZrr6EW9The1IQXoD8=
X-Google-Smtp-Source: AGHT+IF1HWQdt7Wy3xmOIxZtFIw/rG2tQwodAXeFqRVEoY4h7IPrzL4H+8205hiZ81nBVrlQU+kdsS3OUxsKPAGf6QE=
X-Received: by 2002:a05:6512:a8f:b0:511:f6e:83b1 with SMTP id
 m15-20020a0565120a8f00b005110f6e83b1mr1630188lfu.9.1706708550640; Wed, 31 Jan
 2024 05:42:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240121182040.GBZa1geI5NxWSslvt0@fat_crate.local> <20240130220845.1978329-2-kevinloughlin@google.com>
In-Reply-To: <20240130220845.1978329-2-kevinloughlin@google.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Wed, 31 Jan 2024 14:42:19 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGnDM72nZTfpwk9N3B5HdhdL0uva+U3Gwiun+TyTvWfrw@mail.gmail.com>
Message-ID: <CAMj1kXGnDM72nZTfpwk9N3B5HdhdL0uva+U3Gwiun+TyTvWfrw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] x86/sev: enforce RIP-relative accesses in early
 SEV/SME code
To: Kevin Loughlin <kevinloughlin@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Nick Desaulniers <ndesaulniers@google.com>, Justin Stitt <justinstitt@google.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Pankaj Gupta <pankaj.gupta@amd.com>, 
	Hou Wenlong <houwenlong.hwl@antgroup.com>, Dionna Glaze <dionnaglaze@google.com>, 
	Brijesh Singh <brijesh.singh@amd.com>, Michael Roth <michael.roth@amd.com>, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, linux-coco@lists.linux.dev, 
	Ashish Kalra <ashish.kalra@amd.com>, Andi Kleen <ak@linux.intel.com>, 
	Adam Dunlap <acdunlap@google.com>, Peter Gonda <pgonda@google.com>, Jacob Xu <jacobhxu@google.com>, 
	Sidharth Telang <sidtelang@google.com>
Content-Type: text/plain; charset="UTF-8"

Hi Kevin,

On Tue, 30 Jan 2024 at 23:09, Kevin Loughlin <kevinloughlin@google.com> wrote:
>
> The compiler is not required to generate RIP-relative accesses for
> SEV/SME global variables in early boot. While an attempt was made to
> force RIP-relative addressing for certain global SEV/SME variables via
> inline assembly (see snp_cpuid_get_table() for example), RIP-relative
> addressing must be pervasively- enforced for SEV/SME global variables
> when accessed prior to page table fixups.
>
> __startup_64() already handles this issue for select non-SEV/SME global
> variables using fixup_pointer(), which adjusts the pointer relative to
> a `physaddr` argument. To avoid having to pass around this `physaddr`
> argument across all functions needing to apply pointer fixups, this
> patch introduces the macro GET_RIP_RELATIVE_PTR() (an abstraction of
> the existing snp_cpuid_get_table()), which generates an RIP-relative
> pointer to a passed variable. Similarly, PTR_TO_RIP_RELATIVE_PTR() is
> introduced to fixup an existing pointer value with RIP-relative logic.
>
> Applying these macros to early SEV/SME code (alongside Adam Dunlap's
> necessary "[PATCH v2] x86/asm: Force native_apic_mem_read to use mov")
> enables previously-failing boots of clang builds to succeed, while
> preserving successful boot of gcc builds. Tested with and without SEV,
> SEV-ES, SEV-SNP enabled in guests built via both gcc and clang.
>
> Fixes: 95d33bfaa3e1 ("x86/sev: Register GHCB memory when SEV-SNP is active")
> Fixes: ee0bfa08a345 ("x86/compressed/64: Add support for SEV-SNP CPUID table in #VC handlers")
> Fixes: 1cd9c22fee3a ("x86/mm/encrypt: Move page table helpers into separate translation unit")
> Fixes: c9f09539e16e ("x86/head/64: Check SEV encryption before switching to kernel page-table")
> Fixes: b577f542f93c ("x86/coco: Add API to handle encryption mask")
> Signed-off-by: Kevin Loughlin <kevinloughlin@google.com>
> ---
>  arch/x86/coco/core.c               | 22 ++++++++-----
>  arch/x86/include/asm/mem_encrypt.h | 32 +++++++++++++++---
>  arch/x86/kernel/head64.c           | 31 ++++++++++--------
>  arch/x86/kernel/head_64.S          |  4 ++-
>  arch/x86/kernel/sev-shared.c       | 52 ++++++++++++++----------------
>  arch/x86/kernel/sev.c              | 13 +++++---
>  arch/x86/mm/mem_encrypt_identity.c | 50 ++++++++++++++--------------
>  7 files changed, 122 insertions(+), 82 deletions(-)
>

OK, so the purpose of this patch is to have something that can be
backported before applying the changes I proposed to fix this more
comprehensively, right?

I think that makes sense, although I'd like to understand how far this
would need to be backported, and for which purpose.


> diff --git a/arch/x86/coco/core.c b/arch/x86/coco/core.c
> index eeec9986570e..8c45b5643f48 100644
> --- a/arch/x86/coco/core.c
> +++ b/arch/x86/coco/core.c
> @@ -5,6 +5,11 @@
>   * Copyright (C) 2021 Advanced Micro Devices, Inc.
>   *
>   * Author: Tom Lendacky <thomas.lendacky@amd.com>
> + *
> + * WARNING!!
> + * Select functions in this file can execute prior to page table fixups and thus
> + * require pointer fixups for global variable accesses. See WARNING in
> + * arch/x86/kernel/head64.c.
>   */
>
>  #include <linux/export.h>
> @@ -61,33 +66,34 @@ static __maybe_unused __always_inline bool amd_cc_platform_vtom(enum cc_attr att
>  static bool noinstr amd_cc_platform_has(enum cc_attr attr)
>  {
>  #ifdef CONFIG_AMD_MEM_ENCRYPT
> +       const u64 sev_status_fixed_up = sev_get_status_fixup();
>
> -       if (sev_status & MSR_AMD64_SNP_VTOM)
> +       if (sev_status_fixed_up & MSR_AMD64_SNP_VTOM)
>                 return amd_cc_platform_vtom(attr);
>
>         switch (attr) {
>         case CC_ATTR_MEM_ENCRYPT:
> -               return sme_me_mask;
> +               return sme_get_me_mask_fixup();
>
>         case CC_ATTR_HOST_MEM_ENCRYPT:
> -               return sme_me_mask && !(sev_status & MSR_AMD64_SEV_ENABLED);
> +               return sme_get_me_mask_fixup() && !(sev_status_fixed_up & MSR_AMD64_SEV_ENABLED);
>
>         case CC_ATTR_GUEST_MEM_ENCRYPT:
> -               return sev_status & MSR_AMD64_SEV_ENABLED;
> +               return sev_status_fixed_up & MSR_AMD64_SEV_ENABLED;
>
>         case CC_ATTR_GUEST_STATE_ENCRYPT:
> -               return sev_status & MSR_AMD64_SEV_ES_ENABLED;
> +               return sev_status_fixed_up & MSR_AMD64_SEV_ES_ENABLED;
>
>         /*
>          * With SEV, the rep string I/O instructions need to be unrolled
>          * but SEV-ES supports them through the #VC handler.
>          */
>         case CC_ATTR_GUEST_UNROLL_STRING_IO:
> -               return (sev_status & MSR_AMD64_SEV_ENABLED) &&
> -                       !(sev_status & MSR_AMD64_SEV_ES_ENABLED);
> +               return (sev_status_fixed_up & MSR_AMD64_SEV_ENABLED) &&
> +                       !(sev_status_fixed_up & MSR_AMD64_SEV_ES_ENABLED);
>
>         case CC_ATTR_GUEST_SEV_SNP:
> -               return sev_status & MSR_AMD64_SEV_SNP_ENABLED;
> +               return sev_status_fixed_up & MSR_AMD64_SEV_SNP_ENABLED;
>
>         default:
>                 return false;

Is this code actually called early enough to matter here?

> diff --git a/arch/x86/include/asm/mem_encrypt.h b/arch/x86/include/asm/mem_encrypt.h
> index 359ada486fa9..b65e66ee79c4 100644
> --- a/arch/x86/include/asm/mem_encrypt.h
> +++ b/arch/x86/include/asm/mem_encrypt.h
> @@ -17,6 +17,20 @@
>
>  #include <asm/bootparam.h>
>
> +/*
> + * Like the address operator "&", evaluates to the address of a LHS variable
> + * "var", but also enforces the use of RIP-relative logic. This macro can be
> + * used to safely access global data variables prior to kernel relocation.
> + */
> +#define RIP_RELATIVE_ADDR(var)         \
> +({                                     \
> +       void *rip_rel_ptr;              \
> +       asm ("lea "#var"(%%rip), %0"    \
> +               : "=r" (rip_rel_ptr)    \
> +               : "p" (&var));          \

I'd prefer to make this

asm ("lea %c1(%%rip), %0" : "=r" (rip_rel_ptr) : "i" (&var));

the difference being that the compiler is forced to double check that
#var and &var actually refer to the same global variable.

That also means we can make it static inline.

static inline __attribute_const__ rip_relative_ptr(const void *var)
{
    void *rip_rel_ptr;

    asm ("lea %c1(%%rip), %0" : "=r" (rip_rel_ptr) : "i" (&var));
    return rip_rel_ptr;
}

#define RIP_RELATIVE_ADDR(var) rip_relative_ptr(&var)

>  #ifdef CONFIG_X86_MEM_ENCRYPT
>  void __init mem_encrypt_init(void);
>  void __init mem_encrypt_setup_arch(void);
> @@ -58,6 +72,16 @@ void __init mem_encrypt_free_decrypted_mem(void);
>
>  void __init sev_es_init_vc_handling(void);
>
> +static __always_inline u64 sme_get_me_mask_fixup(void)

Just call this sme_get_me_mask(void) as before, and keep the existing
users. The RIP-relative reference will always work correctly so no
need to avoid it later.

> +{
> +       return *((u64 *) RIP_RELATIVE_ADDR(sme_me_mask));

Can we move the cast into the macro?

#define RIP_RELATIVE_REF(var) (*(typeof(&var))rip_relative_ptr(&var))

and make this

    return RIP_RELATIVE_REF(sme_me_mask);


> +}
> +
> +static __always_inline u64 sev_get_status_fixup(void)

Can we drop the _fixup suffix here? Or if we need to convey the fact
that this is a special accessor that can be used early, use _early
instead.

> +{
> +       return *((u64 *) RIP_RELATIVE_ADDR(sev_status));
> +}
> +
>  #define __bss_decrypted __section(".bss..decrypted")
>
>  #else  /* !CONFIG_AMD_MEM_ENCRYPT */
> @@ -89,6 +113,9 @@ early_set_mem_enc_dec_hypercall(unsigned long vaddr, unsigned long size, bool en
>
>  static inline void mem_encrypt_free_decrypted_mem(void) { }
>
> +static inline u64 sme_get_me_mask_fixup(void) { return 0; }
> +static inline u64 sev_get_status_fixup(void) { return 0; }
> +
>  #define __bss_decrypted
>
>  #endif /* CONFIG_AMD_MEM_ENCRYPT */
> @@ -106,11 +133,6 @@ void add_encrypt_protection_map(void);
>
>  extern char __start_bss_decrypted[], __end_bss_decrypted[], __start_bss_decrypted_unused[];
>
> -static inline u64 sme_get_me_mask(void)
> -{
> -       return sme_me_mask;
> -}
> -
>  #endif /* __ASSEMBLY__ */
>
>  #endif /* __X86_MEM_ENCRYPT_H__ */
> diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
> index dc0956067944..d159239997f4 100644
> --- a/arch/x86/kernel/head64.c
> +++ b/arch/x86/kernel/head64.c
> @@ -128,6 +128,7 @@ static bool __head check_la57_support(unsigned long physaddr)
>
>  static unsigned long __head sme_postprocess_startup(struct boot_params *bp, pmdval_t *pmd)
>  {
> +       const u64 sme_me_mask_fixed_up = sme_get_me_mask_fixup();
>         unsigned long vaddr, vaddr_end;
>         int i;
>
> @@ -140,7 +141,7 @@ static unsigned long __head sme_postprocess_startup(struct boot_params *bp, pmdv
>          * there is no need to zero it after changing the memory encryption
>          * attribute.
>          */
> -       if (sme_get_me_mask()) {
> +       if (sme_me_mask_fixed_up) {
>                 vaddr = (unsigned long)__start_bss_decrypted;
>                 vaddr_end = (unsigned long)__end_bss_decrypted;
>
> @@ -158,7 +159,7 @@ static unsigned long __head sme_postprocess_startup(struct boot_params *bp, pmdv
>                         early_snp_set_memory_shared(__pa(vaddr), __pa(vaddr), PTRS_PER_PMD);
>
>                         i = pmd_index(vaddr);
> -                       pmd[i] -= sme_get_me_mask();
> +                       pmd[i] -= sme_me_mask_fixed_up;
>                 }
>         }
>
> @@ -166,18 +167,22 @@ static unsigned long __head sme_postprocess_startup(struct boot_params *bp, pmdv
>          * Return the SME encryption mask (if SME is active) to be used as a
>          * modifier for the initial pgdir entry programmed into CR3.
>          */
> -       return sme_get_me_mask();
> +       return sme_me_mask_fixed_up;

Just use sme_get_me_mask() as before in this file.

>  }
>
> -/* Code in __startup_64() can be relocated during execution, but the compiler
> +/*
> + * WARNING!!
> + * Code in __startup_64() can be relocated during execution, but the compiler
>   * doesn't have to generate PC-relative relocations when accessing globals from
>   * that function. Clang actually does not generate them, which leads to
>   * boot-time crashes. To work around this problem, every global pointer must
> - * be adjusted using fixup_pointer().
> + * be adjusted using fixup_pointer() or RIP_RELATIVE_ADDR().
>   */
>  unsigned long __head __startup_64(unsigned long physaddr,
>                                   struct boot_params *bp)
>  {
> +       const u64 sme_me_mask_fixed_up = sme_get_me_mask_fixup();
> +       pmd_t **early_dynamic_pgts_ptr;
>         unsigned long load_delta, *p;
>         unsigned long pgtable_flags;
>         pgdval_t *pgd;
> @@ -206,7 +211,7 @@ unsigned long __head __startup_64(unsigned long physaddr,
>                 for (;;);
>
>         /* Include the SME encryption mask in the fixup value */
> -       load_delta += sme_get_me_mask();
> +       load_delta += sme_me_mask_fixed_up;
>
>         /* Fixup the physical addresses in the page table */
>
> @@ -239,14 +244,14 @@ unsigned long __head __startup_64(unsigned long physaddr,
>          */
>
>         next_pgt_ptr = fixup_pointer(&next_early_pgt, physaddr);
> -       pud = fixup_pointer(early_dynamic_pgts[(*next_pgt_ptr)++], physaddr);
> -       pmd = fixup_pointer(early_dynamic_pgts[(*next_pgt_ptr)++], physaddr);
> +       early_dynamic_pgts_ptr = fixup_pointer(early_dynamic_pgts, physaddr);
> +       pud = (pudval_t *) early_dynamic_pgts_ptr[(*next_pgt_ptr)++];
> +       pmd = (pmdval_t *) early_dynamic_pgts_ptr[(*next_pgt_ptr)++];
>

Better to introduce early_dynamic_pgts_ptr in a separate patch if it
is just an optimization but doesn't actually fix anything.

> -       pgtable_flags = _KERNPG_TABLE_NOENC + sme_get_me_mask();
> +       pgtable_flags = _KERNPG_TABLE_NOENC + sme_me_mask_fixed_up;
>
>         if (la57) {
> -               p4d = fixup_pointer(early_dynamic_pgts[(*next_pgt_ptr)++],
> -                                   physaddr);
> +               p4d = (p4dval_t *) early_dynamic_pgts_ptr[(*next_pgt_ptr)++];
>
>                 i = (physaddr >> PGDIR_SHIFT) % PTRS_PER_PGD;
>                 pgd[i + 0] = (pgdval_t)p4d + pgtable_flags;
> @@ -269,7 +274,7 @@ unsigned long __head __startup_64(unsigned long physaddr,
>         /* Filter out unsupported __PAGE_KERNEL_* bits: */
>         mask_ptr = fixup_pointer(&__supported_pte_mask, physaddr);
>         pmd_entry &= *mask_ptr;
> -       pmd_entry += sme_get_me_mask();
> +       pmd_entry += sme_me_mask_fixed_up;
>         pmd_entry +=  physaddr;
>
>         for (i = 0; i < DIV_ROUND_UP(_end - _text, PMD_SIZE); i++) {
> @@ -313,7 +318,7 @@ unsigned long __head __startup_64(unsigned long physaddr,
>          * Fixup phys_base - remove the memory encryption mask to obtain
>          * the true physical address.
>          */
> -       *fixup_long(&phys_base, physaddr) += load_delta - sme_get_me_mask();
> +       *fixup_long(&phys_base, physaddr) += load_delta - sme_me_mask_fixed_up;
>
>         return sme_postprocess_startup(bp, pmd);
>  }
> diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
> index d4918d03efb4..b9e52cee6e00 100644
> --- a/arch/x86/kernel/head_64.S
> +++ b/arch/x86/kernel/head_64.S
> @@ -176,9 +176,11 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
>         /*
>          * Retrieve the modifier (SME encryption mask if SME is active) to be
>          * added to the initial pgdir entry that will be programmed into CR3.
> +        * Since we may have not completed page table fixups, use RIP-relative
> +        * addressing for sme_me_mask.

This runs on the secondary path only, so this comment is inaccurate.

>          */
>  #ifdef CONFIG_AMD_MEM_ENCRYPT
> -       movq    sme_me_mask, %rax
> +       movq    sme_me_mask(%rip), %rax
>  #else
>         xorq    %rax, %rax
>  #endif
> diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
> index 1d24ec679915..9ea6bea37e1d 100644
> --- a/arch/x86/kernel/sev-shared.c
> +++ b/arch/x86/kernel/sev-shared.c
> @@ -7,6 +7,11 @@
>   * This file is not compiled stand-alone. It contains code shared
>   * between the pre-decompression boot code and the running Linux kernel
>   * and is included directly into both code-bases.
> + *
> + * WARNING!!
> + * Select functions in this file can execute prior to page table fixups and thus
> + * require pointer fixups for global variable accesses. See WARNING in
> + * arch/x86/kernel/head64.c.
>   */
>
>  #ifndef __BOOT_COMPRESSED
> @@ -318,23 +323,6 @@ static int sev_cpuid_hv(struct ghcb *ghcb, struct es_em_ctxt *ctxt, struct cpuid
>                     : __sev_cpuid_hv_msr(leaf);
>  }
>
> -/*
> - * This may be called early while still running on the initial identity
> - * mapping. Use RIP-relative addressing to obtain the correct address
> - * while running with the initial identity mapping as well as the
> - * switch-over to kernel virtual addresses later.
> - */
> -static const struct snp_cpuid_table *snp_cpuid_get_table(void)
> -{

You could just make this return the RIP_RELATIVE_ADDR() result, right?

> -       void *ptr;
> -
> -       asm ("lea cpuid_table_copy(%%rip), %0"
> -            : "=r" (ptr)
> -            : "p" (&cpuid_table_copy));
> -
> -       return ptr;
> -}
> -
>  /*
>   * The SNP Firmware ABI, Revision 0.9, Section 7.1, details the use of
>   * XCR0_IN and XSS_IN to encode multiple versions of 0xD subfunctions 0
> @@ -357,7 +345,7 @@ static const struct snp_cpuid_table *snp_cpuid_get_table(void)
>   */
>  static u32 snp_cpuid_calc_xsave_size(u64 xfeatures_en, bool compacted)
>  {
> -       const struct snp_cpuid_table *cpuid_table = snp_cpuid_get_table();
> +       const struct snp_cpuid_table *cpuid_table = RIP_RELATIVE_ADDR(cpuid_table_copy);
>         u64 xfeatures_found = 0;
>         u32 xsave_size = 0x240;
>         int i;
> @@ -394,7 +382,7 @@ static u32 snp_cpuid_calc_xsave_size(u64 xfeatures_en, bool compacted)
>  static bool
>  snp_cpuid_get_validated_func(struct cpuid_leaf *leaf)
>  {
> -       const struct snp_cpuid_table *cpuid_table = snp_cpuid_get_table();
> +       const struct snp_cpuid_table *cpuid_table = RIP_RELATIVE_ADDR(cpuid_table_copy);
>         int i;
>
>         for (i = 0; i < cpuid_table->count; i++) {
> @@ -530,7 +518,8 @@ static int snp_cpuid_postprocess(struct ghcb *ghcb, struct es_em_ctxt *ctxt,
>   */
>  static int snp_cpuid(struct ghcb *ghcb, struct es_em_ctxt *ctxt, struct cpuid_leaf *leaf)
>  {
> -       const struct snp_cpuid_table *cpuid_table = snp_cpuid_get_table();
> +       const u32 *cpuid_std_range_max_ptr, *cpuid_hyp_range_max_ptr, *cpuid_ext_range_max_ptr;
> +       const struct snp_cpuid_table *cpuid_table = RIP_RELATIVE_ADDR(cpuid_table_copy);
>
>         if (!cpuid_table->count)
>                 return -EOPNOTSUPP;
> @@ -555,10 +544,14 @@ static int snp_cpuid(struct ghcb *ghcb, struct es_em_ctxt *ctxt, struct cpuid_le
>                  */
>                 leaf->eax = leaf->ebx = leaf->ecx = leaf->edx = 0;
>
> +               cpuid_std_range_max_ptr = RIP_RELATIVE_ADDR(cpuid_std_range_max);
> +               cpuid_hyp_range_max_ptr = RIP_RELATIVE_ADDR(cpuid_hyp_range_max);
> +               cpuid_ext_range_max_ptr = RIP_RELATIVE_ADDR(cpuid_ext_range_max);
> +
>                 /* Skip post-processing for out-of-range zero leafs. */
> -               if (!(leaf->fn <= cpuid_std_range_max ||
> -                     (leaf->fn >= 0x40000000 && leaf->fn <= cpuid_hyp_range_max) ||
> -                     (leaf->fn >= 0x80000000 && leaf->fn <= cpuid_ext_range_max)))
> +               if (!(leaf->fn <= *cpuid_std_range_max_ptr ||
> +                     (leaf->fn >= 0x40000000 && leaf->fn <= *cpuid_hyp_range_max_ptr) ||
> +                     (leaf->fn >= 0x80000000 && leaf->fn <= *cpuid_ext_range_max_ptr)))
>                         return 0;
>         }
>
> @@ -1045,6 +1038,7 @@ static struct cc_blob_sev_info *find_cc_blob_setup_data(struct boot_params *bp)
>   */
>  static void __init setup_cpuid_table(const struct cc_blob_sev_info *cc_info)
>  {
> +       u32 *cpuid_std_range_max_ptr, *cpuid_hyp_range_max_ptr, *cpuid_ext_range_max_ptr;
>         const struct snp_cpuid_table *cpuid_table_fw, *cpuid_table;
>         int i;
>
> @@ -1055,19 +1049,23 @@ static void __init setup_cpuid_table(const struct cc_blob_sev_info *cc_info)
>         if (!cpuid_table_fw->count || cpuid_table_fw->count > SNP_CPUID_COUNT_MAX)
>                 sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_CPUID);
>
> -       cpuid_table = snp_cpuid_get_table();
> +       cpuid_table = RIP_RELATIVE_ADDR(cpuid_table_copy);
>         memcpy((void *)cpuid_table, cpuid_table_fw, sizeof(*cpuid_table));
>
> +       cpuid_std_range_max_ptr = RIP_RELATIVE_ADDR(cpuid_std_range_max);
> +       cpuid_hyp_range_max_ptr = RIP_RELATIVE_ADDR(cpuid_hyp_range_max);
> +       cpuid_ext_range_max_ptr = RIP_RELATIVE_ADDR(cpuid_ext_range_max);
> +

Can we cache the values here rather than the pointers?

>         /* Initialize CPUID ranges for range-checking. */
>         for (i = 0; i < cpuid_table->count; i++) {
>                 const struct snp_cpuid_fn *fn = &cpuid_table->fn[i];
>
>                 if (fn->eax_in == 0x0)
> -                       cpuid_std_range_max = fn->eax;
> +                       *cpuid_std_range_max_ptr = fn->eax;
>                 else if (fn->eax_in == 0x40000000)
> -                       cpuid_hyp_range_max = fn->eax;
> +                       *cpuid_hyp_range_max_ptr = fn->eax;
>                 else if (fn->eax_in == 0x80000000)
> -                       cpuid_ext_range_max = fn->eax;
> +                       *cpuid_ext_range_max_ptr = fn->eax;
>         }
>  }
>
> diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
> index c67285824e82..54dd58d13d66 100644
> --- a/arch/x86/kernel/sev.c
> +++ b/arch/x86/kernel/sev.c
> @@ -5,6 +5,11 @@
>   * Copyright (C) 2019 SUSE
>   *
>   * Author: Joerg Roedel <jroedel@suse.de>
> + *
> + * WARNING!!
> + * Select functions in this file can execute prior to page table fixups and thus
> + * require pointer fixups for global variable accesses. See WARNING in
> + * arch/x86/kernel/head64.c.
>   */
>
>  #define pr_fmt(fmt)    "SEV: " fmt
> @@ -748,7 +753,7 @@ void __init early_snp_set_memory_private(unsigned long vaddr, unsigned long padd
>          * This eliminates worries about jump tables or checking boot_cpu_data
>          * in the cc_platform_has() function.
>          */
> -       if (!(sev_status & MSR_AMD64_SEV_SNP_ENABLED))
> +       if (!(sev_get_status_fixup() & MSR_AMD64_SEV_SNP_ENABLED))
>                 return;
>
>          /*
> @@ -767,7 +772,7 @@ void __init early_snp_set_memory_shared(unsigned long vaddr, unsigned long paddr
>          * This eliminates worries about jump tables or checking boot_cpu_data
>          * in the cc_platform_has() function.
>          */
> -       if (!(sev_status & MSR_AMD64_SEV_SNP_ENABLED))
> +       if (!(sev_get_status_fixup() & MSR_AMD64_SEV_SNP_ENABLED))
>                 return;
>
>          /* Ask hypervisor to mark the memory pages shared in the RMP table. */
> @@ -2114,7 +2119,7 @@ void __init __noreturn snp_abort(void)
>
>  static void dump_cpuid_table(void)
>  {
> -       const struct snp_cpuid_table *cpuid_table = snp_cpuid_get_table();
> +       const struct snp_cpuid_table *cpuid_table = RIP_RELATIVE_ADDR(cpuid_table_copy);
>         int i = 0;
>
>         pr_info("count=%d reserved=0x%x reserved2=0x%llx\n",
> @@ -2138,7 +2143,7 @@ static void dump_cpuid_table(void)
>   */
>  static int __init report_cpuid_table(void)
>  {
> -       const struct snp_cpuid_table *cpuid_table = snp_cpuid_get_table();
> +       const struct snp_cpuid_table *cpuid_table = RIP_RELATIVE_ADDR(cpuid_table_copy);
>
>         if (!cpuid_table->count)
>                 return 0;
> diff --git a/arch/x86/mm/mem_encrypt_identity.c b/arch/x86/mm/mem_encrypt_identity.c
> index d73aeb16417f..533e59bc5757 100644
> --- a/arch/x86/mm/mem_encrypt_identity.c
> +++ b/arch/x86/mm/mem_encrypt_identity.c
> @@ -5,6 +5,11 @@
>   * Copyright (C) 2016 Advanced Micro Devices, Inc.
>   *
>   * Author: Tom Lendacky <thomas.lendacky@amd.com>
> + *
> + * WARNING!!
> + * Select functions in this file can execute prior to page table fixups and thus
> + * require pointer fixups for global variable accesses. See WARNING in
> + * arch/x86/kernel/head64.c.
>   */
>
>  #define DISABLE_BRANCH_PROFILING
> @@ -305,7 +310,7 @@ void __init sme_encrypt_kernel(struct boot_params *bp)
>          * instrumentation or checking boot_cpu_data in the cc_platform_has()
>          * function.
>          */
> -       if (!sme_get_me_mask() || sev_status & MSR_AMD64_SEV_ENABLED)
> +       if (!sme_get_me_mask_fixup() || sev_get_status_fixup() & MSR_AMD64_SEV_ENABLED)
>                 return;
>
>         /*
> @@ -346,9 +351,7 @@ void __init sme_encrypt_kernel(struct boot_params *bp)
>          * We're running identity mapped, so we must obtain the address to the
>          * SME encryption workarea using rip-relative addressing.
>          */
> -       asm ("lea sme_workarea(%%rip), %0"
> -            : "=r" (workarea_start)
> -            : "p" (sme_workarea));
> +       workarea_start = (unsigned long) RIP_RELATIVE_ADDR(sme_workarea);
>
>         /*
>          * Calculate required number of workarea bytes needed:
> @@ -505,13 +508,13 @@ void __init sme_encrypt_kernel(struct boot_params *bp)
>  void __init sme_enable(struct boot_params *bp)
>  {
>         const char *cmdline_ptr, *cmdline_arg, *cmdline_on, *cmdline_off;
> +       u64 msr, *sme_me_mask_ptr, *sev_status_ptr;
>         unsigned int eax, ebx, ecx, edx;
>         unsigned long feature_mask;
>         bool active_by_default;
>         unsigned long me_mask;
>         char buffer[16];
>         bool snp;
> -       u64 msr;
>
>         snp = snp_init(bp);
>
> @@ -542,12 +545,14 @@ void __init sme_enable(struct boot_params *bp)
>
>         me_mask = 1UL << (ebx & 0x3f);
>
> +       sev_status_ptr = RIP_RELATIVE_ADDR(sev_status);
> +
>         /* Check the SEV MSR whether SEV or SME is enabled */
> -       sev_status   = __rdmsr(MSR_AMD64_SEV);
> -       feature_mask = (sev_status & MSR_AMD64_SEV_ENABLED) ? AMD_SEV_BIT : AMD_SME_BIT;
> +       *sev_status_ptr = __rdmsr(MSR_AMD64_SEV);
> +       feature_mask = (*sev_status_ptr & MSR_AMD64_SEV_ENABLED) ? AMD_SEV_BIT : AMD_SME_BIT;
>
>         /* The SEV-SNP CC blob should never be present unless SEV-SNP is enabled. */
> -       if (snp && !(sev_status & MSR_AMD64_SEV_SNP_ENABLED))
> +       if (snp && !(*sev_status_ptr & MSR_AMD64_SEV_SNP_ENABLED))
>                 snp_abort();
>
>         /* Check if memory encryption is enabled */
> @@ -573,7 +578,8 @@ void __init sme_enable(struct boot_params *bp)
>                         return;
>         } else {
>                 /* SEV state cannot be controlled by a command line option */
> -               sme_me_mask = me_mask;
> +               sme_me_mask_ptr = RIP_RELATIVE_ADDR(sme_me_mask);
> +               *sme_me_mask_ptr = me_mask;
>                 goto out;
>         }
>
> @@ -582,15 +588,9 @@ void __init sme_enable(struct boot_params *bp)
>          * identity mapped, so we must obtain the address to the SME command
>          * line argument data using rip-relative addressing.
>          */
> -       asm ("lea sme_cmdline_arg(%%rip), %0"
> -            : "=r" (cmdline_arg)
> -            : "p" (sme_cmdline_arg));
> -       asm ("lea sme_cmdline_on(%%rip), %0"
> -            : "=r" (cmdline_on)
> -            : "p" (sme_cmdline_on));
> -       asm ("lea sme_cmdline_off(%%rip), %0"
> -            : "=r" (cmdline_off)
> -            : "p" (sme_cmdline_off));
> +       cmdline_arg = RIP_RELATIVE_ADDR(sme_cmdline_arg);
> +       cmdline_on = RIP_RELATIVE_ADDR(sme_cmdline_on);
> +       cmdline_off = RIP_RELATIVE_ADDR(sme_cmdline_off);
>
>         if (IS_ENABLED(CONFIG_AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT))
>                 active_by_default = true;
> @@ -603,16 +603,18 @@ void __init sme_enable(struct boot_params *bp)
>         if (cmdline_find_option(cmdline_ptr, cmdline_arg, buffer, sizeof(buffer)) < 0)
>                 return;
>
> +       sme_me_mask_ptr = RIP_RELATIVE_ADDR(sme_me_mask);
> +
>         if (!strncmp(buffer, cmdline_on, sizeof(buffer)))
> -               sme_me_mask = me_mask;
> +               *sme_me_mask_ptr = me_mask;
>         else if (!strncmp(buffer, cmdline_off, sizeof(buffer)))
> -               sme_me_mask = 0;
> +               *sme_me_mask_ptr = 0;
>         else
> -               sme_me_mask = active_by_default ? me_mask : 0;
> +               *sme_me_mask_ptr = active_by_default ? me_mask : 0;
>  out:
> -       if (sme_me_mask) {
> -               physical_mask &= ~sme_me_mask;
> +       if (*sme_me_mask_ptr) {
> +               physical_mask &= ~(*sme_me_mask_ptr);
>                 cc_vendor = CC_VENDOR_AMD;
> -               cc_set_mask(sme_me_mask);
> +               cc_set_mask(*sme_me_mask_ptr);
>         }
>  }
> --
> 2.43.0.429.g432eaa2c6b-goog
>

