Return-Path: <linux-kernel+bounces-50763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AD22847DAA
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 01:15:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D60EA2883F7
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 00:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6763D65F;
	Sat,  3 Feb 2024 00:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ru6IKm7g"
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49736FB6
	for <linux-kernel@vger.kernel.org>; Sat,  3 Feb 2024 00:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706919295; cv=none; b=C9IVtD8AN79S02Ta6zYQ4e0lhBBa7zIyDh5mYaFShzn7UO9zmXyh31xdD1vC3H/0JVk2BdN+rhZbwxp9cuXCY2kHNAjzFrDAkI2J0aZxNLIom9PPUDwZ95bM4vF/88OqTTV5PeWqF+fjuaVGPRVlpge40WDrn8ek9mR57Uf5eyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706919295; c=relaxed/simple;
	bh=Jpcfb192jfa1ee+g0R/JNTJjxaQREqsdytaaZ2gJ8Xk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fJI0lEbjTvy8ePIG5UksVtHL6bfumfR6oAsG2sPb20bUeeG45IRuSSkHWeXgPWDICGlzuGsEX1t0KVPQRmhvfLbSTYfzQzPqLGBsgIh1O6lmUNXoluKnKzkXe06Bh1Qm9uGkH3EoP2pdaDMIYkHKeg1Df8UlfeNZsdAAU2/2kGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ru6IKm7g; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-4c016b8ebfaso149595e0c.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 16:14:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706919292; x=1707524092; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E0YjxPz7eB/7JP/lvkjS/QY/1wmN+O6w79S7PERXNLo=;
        b=Ru6IKm7g8vdlF3hvXsBGE9zERg330akiW0AG01BAkYuIGRMvaCjXpK+acNsB/lEJFI
         cL7e02hKXpHRh//Q2P+fDNazIWw6oh3L+xpnY/vxC4UViBCpstDp4HPz1a6KbKDz35au
         nVII8Jev/uGsBvSGo4yuFXLa2o7FCyJ9MeN1Ptwym08TzpCYa55mv3iNszIZO52ilsix
         xOgMWHkeGyQUWE8Qy2714fhszCIKTgVTCRob0/MxWkYwB8vwLb67mk53gRlcQpUD//LF
         segnENHU0oBXEGG3zHl9z36rNbehj+PRcWlIhk2DXfxX0EbDKt0x2aIRFKdGBMqSHxYZ
         0fsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706919292; x=1707524092;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E0YjxPz7eB/7JP/lvkjS/QY/1wmN+O6w79S7PERXNLo=;
        b=jqwtNEKqO/X3o8e1rVsq5JuvsaeEWjRk8WHgnreH/xrUxWbfvj+el4NbV9z60eqTxw
         ZebPhEOBBfQ//j+e1aZj3itM3RF9ZJ6NxFgXsBXY/Y1UKfjz64Zd7VxgmYCsYtQ2R7qJ
         MIULp2zumshOWAcW9lLNuipMjsfQgFNV065p1WJ6ljX+KXalDCJ9sQ7BsToEW8VJoQBW
         aqXf5ECC6Pq9PpWnnKXFYN265LTOrApj8YzrRU6ZJWY4PhsVmXoF7dD++APJJDQ4/WKD
         XasU8CLjVKj1XV6Es+milLzV3Rne5bXL/cX0fIQYqHc58xv+pU/I0k1yG9E4+jsi0dxz
         NbTg==
X-Gm-Message-State: AOJu0YwasAsmyWs7IVEtilDm5wlkdWyc5K2dq9eTiq/m/kegqxsZPnbj
	CxgNwD7C8jfAw4Na+JaM5uzMvJPAF7GbY1JXZUWGP9CI7b4upgoQJEN6GUAK2PNRe+vLJZlaGi1
	LWiTZf6CmKwn4Nif4J1Ncm2+7GpJskwUMBfuO
X-Google-Smtp-Source: AGHT+IHwwshV5vQY2bamwtsLl72G4fgEdoV0fooFsZD1DCRdf+BaShckf1v5AfZxIkYTMZooIN3myIUxtrqis3c2QU0=
X-Received: by 2002:ac5:c2cc:0:b0:4b7:6fa9:1166 with SMTP id
 i12-20020ac5c2cc000000b004b76fa91166mr3084505vkk.0.1706919292255; Fri, 02 Feb
 2024 16:14:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240121182040.GBZa1geI5NxWSslvt0@fat_crate.local>
 <20240130220845.1978329-2-kevinloughlin@google.com> <CAMj1kXGnDM72nZTfpwk9N3B5HdhdL0uva+U3Gwiun+TyTvWfrw@mail.gmail.com>
In-Reply-To: <CAMj1kXGnDM72nZTfpwk9N3B5HdhdL0uva+U3Gwiun+TyTvWfrw@mail.gmail.com>
From: Kevin Loughlin <kevinloughlin@google.com>
Date: Fri, 2 Feb 2024 16:14:41 -0800
Message-ID: <CAGdbjmJ7D1RtiyPfcagUxGBBJUTRH_FEQ2XO_1A4x-0QdiHUWQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] x86/sev: enforce RIP-relative accesses in early
 SEV/SME code
To: Ard Biesheuvel <ardb@kernel.org>
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
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2024 at 5:42=E2=80=AFAM Ard Biesheuvel <ardb@kernel.org> wr=
ote:
>
> Hi Kevin,
>
> On Tue, 30 Jan 2024 at 23:09, Kevin Loughlin <kevinloughlin@google.com> w=
rote:
> >
> > The compiler is not required to generate RIP-relative accesses for
> > SEV/SME global variables in early boot. While an attempt was made to
> > force RIP-relative addressing for certain global SEV/SME variables via
> > inline assembly (see snp_cpuid_get_table() for example), RIP-relative
> > addressing must be pervasively- enforced for SEV/SME global variables
> > when accessed prior to page table fixups.
> >
> > __startup_64() already handles this issue for select non-SEV/SME global
> > variables using fixup_pointer(), which adjusts the pointer relative to
> > a `physaddr` argument. To avoid having to pass around this `physaddr`
> > argument across all functions needing to apply pointer fixups, this
> > patch introduces the macro GET_RIP_RELATIVE_PTR() (an abstraction of
> > the existing snp_cpuid_get_table()), which generates an RIP-relative
> > pointer to a passed variable. Similarly, PTR_TO_RIP_RELATIVE_PTR() is
> > introduced to fixup an existing pointer value with RIP-relative logic.
> >
> > Applying these macros to early SEV/SME code (alongside Adam Dunlap's
> > necessary "[PATCH v2] x86/asm: Force native_apic_mem_read to use mov")
> > enables previously-failing boots of clang builds to succeed, while
> > preserving successful boot of gcc builds. Tested with and without SEV,
> > SEV-ES, SEV-SNP enabled in guests built via both gcc and clang.
> >
> > Fixes: 95d33bfaa3e1 ("x86/sev: Register GHCB memory when SEV-SNP is act=
ive")
> > Fixes: ee0bfa08a345 ("x86/compressed/64: Add support for SEV-SNP CPUID =
table in #VC handlers")
> > Fixes: 1cd9c22fee3a ("x86/mm/encrypt: Move page table helpers into sepa=
rate translation unit")
> > Fixes: c9f09539e16e ("x86/head/64: Check SEV encryption before switchin=
g to kernel page-table")
> > Fixes: b577f542f93c ("x86/coco: Add API to handle encryption mask")
> > Signed-off-by: Kevin Loughlin <kevinloughlin@google.com>
> > ---
> >  arch/x86/coco/core.c               | 22 ++++++++-----
> >  arch/x86/include/asm/mem_encrypt.h | 32 +++++++++++++++---
> >  arch/x86/kernel/head64.c           | 31 ++++++++++--------
> >  arch/x86/kernel/head_64.S          |  4 ++-
> >  arch/x86/kernel/sev-shared.c       | 52 ++++++++++++++----------------
> >  arch/x86/kernel/sev.c              | 13 +++++---
> >  arch/x86/mm/mem_encrypt_identity.c | 50 ++++++++++++++--------------
> >  7 files changed, 122 insertions(+), 82 deletions(-)
> >
>
> OK, so the purpose of this patch is to have something that can be
> backported before applying the changes I proposed to fix this more
> comprehensively, right?

Correct.

> I think that makes sense, although I'd like to understand how far this
> would need to be backported, and for which purpose.

It would need to be backported to the first SEV-SNP support merged
upstream, which I believe was in 5.19. The rationale for the backport
is to provide an upstream fix for clang builds of SEV-SNP guests [0].

[0] https://lore.kernel.org/lkml/CAJ5mJ6j-Vw2P=3DQLK-J_J79S35UggvZPtm5sia74=
=3DenR1qq9X9A@mail.gmail.com/

> > diff --git a/arch/x86/coco/core.c b/arch/x86/coco/core.c
> > index eeec9986570e..8c45b5643f48 100644
> > --- a/arch/x86/coco/core.c
> > +++ b/arch/x86/coco/core.c
> > @@ -5,6 +5,11 @@
> >   * Copyright (C) 2021 Advanced Micro Devices, Inc.
> >   *
> >   * Author: Tom Lendacky <thomas.lendacky@amd.com>
> > + *
> > + * WARNING!!
> > + * Select functions in this file can execute prior to page table fixup=
s and thus
> > + * require pointer fixups for global variable accesses. See WARNING in
> > + * arch/x86/kernel/head64.c.
> >   */
> >
> >  #include <linux/export.h>
> > @@ -61,33 +66,34 @@ static __maybe_unused __always_inline bool amd_cc_p=
latform_vtom(enum cc_attr att
> >  static bool noinstr amd_cc_platform_has(enum cc_attr attr)
> >  {
> >  #ifdef CONFIG_AMD_MEM_ENCRYPT
> > +       const u64 sev_status_fixed_up =3D sev_get_status_fixup();
> >
> > -       if (sev_status & MSR_AMD64_SNP_VTOM)
> > +       if (sev_status_fixed_up & MSR_AMD64_SNP_VTOM)
> >                 return amd_cc_platform_vtom(attr);
> >
> >         switch (attr) {
> >         case CC_ATTR_MEM_ENCRYPT:
> > -               return sme_me_mask;
> > +               return sme_get_me_mask_fixup();
> >
> >         case CC_ATTR_HOST_MEM_ENCRYPT:
> > -               return sme_me_mask && !(sev_status & MSR_AMD64_SEV_ENAB=
LED);
> > +               return sme_get_me_mask_fixup() && !(sev_status_fixed_up=
 & MSR_AMD64_SEV_ENABLED);
> >
> >         case CC_ATTR_GUEST_MEM_ENCRYPT:
> > -               return sev_status & MSR_AMD64_SEV_ENABLED;
> > +               return sev_status_fixed_up & MSR_AMD64_SEV_ENABLED;
> >
> >         case CC_ATTR_GUEST_STATE_ENCRYPT:
> > -               return sev_status & MSR_AMD64_SEV_ES_ENABLED;
> > +               return sev_status_fixed_up & MSR_AMD64_SEV_ES_ENABLED;
> >
> >         /*
> >          * With SEV, the rep string I/O instructions need to be unrolle=
d
> >          * but SEV-ES supports them through the #VC handler.
> >          */
> >         case CC_ATTR_GUEST_UNROLL_STRING_IO:
> > -               return (sev_status & MSR_AMD64_SEV_ENABLED) &&
> > -                       !(sev_status & MSR_AMD64_SEV_ES_ENABLED);
> > +               return (sev_status_fixed_up & MSR_AMD64_SEV_ENABLED) &&
> > +                       !(sev_status_fixed_up & MSR_AMD64_SEV_ES_ENABLE=
D);
> >
> >         case CC_ATTR_GUEST_SEV_SNP:
> > -               return sev_status & MSR_AMD64_SEV_SNP_ENABLED;
> > +               return sev_status_fixed_up & MSR_AMD64_SEV_SNP_ENABLED;
> >
> >         default:
> >                 return false;
>
> Is this code actually called early enough to matter here?

I think you're right that we don't need this; it looks like
cc_platform_has() is avoided early. An example of such avoidance is in
sme_encrypt_kernel() in arch/x86/mm/mem_encrypt_identity.c.

> > diff --git a/arch/x86/include/asm/mem_encrypt.h b/arch/x86/include/asm/=
mem_encrypt.h
> > index 359ada486fa9..b65e66ee79c4 100644
> > --- a/arch/x86/include/asm/mem_encrypt.h
> > +++ b/arch/x86/include/asm/mem_encrypt.h
> > @@ -17,6 +17,20 @@
> >
> >  #include <asm/bootparam.h>
> >
> > +/*
> > + * Like the address operator "&", evaluates to the address of a LHS va=
riable
> > + * "var", but also enforces the use of RIP-relative logic. This macro =
can be
> > + * used to safely access global data variables prior to kernel relocat=
ion.
> > + */
> > +#define RIP_RELATIVE_ADDR(var)         \
> > +({                                     \
> > +       void *rip_rel_ptr;              \
> > +       asm ("lea "#var"(%%rip), %0"    \
> > +               : "=3Dr" (rip_rel_ptr)    \
> > +               : "p" (&var));          \
>
> I'd prefer to make this
>
> asm ("lea %c1(%%rip), %0" : "=3Dr" (rip_rel_ptr) : "i" (&var));
>
> the difference being that the compiler is forced to double check that
> #var and &var actually refer to the same global variable.
>
> That also means we can make it static inline.
>
> static inline __attribute_const__ rip_relative_ptr(const void *var)
> {
>     void *rip_rel_ptr;
>
>     asm ("lea %c1(%%rip), %0" : "=3Dr" (rip_rel_ptr) : "i" (&var));
>     return rip_rel_ptr;
> }
>
> #define RIP_RELATIVE_ADDR(var) rip_relative_ptr(&var)

Good idea, works for me.

> >  #ifdef CONFIG_X86_MEM_ENCRYPT
> >  void __init mem_encrypt_init(void);
> >  void __init mem_encrypt_setup_arch(void);
> > @@ -58,6 +72,16 @@ void __init mem_encrypt_free_decrypted_mem(void);
> >
> >  void __init sev_es_init_vc_handling(void);
> >
> > +static __always_inline u64 sme_get_me_mask_fixup(void)
>
> Just call this sme_get_me_mask(void) as before, and keep the existing
> users. The RIP-relative reference will always work correctly so no
> need to avoid it later.

Agreed. In general, I will rework to minimize the changes for
backport-friendliness.

> > +{
> > +       return *((u64 *) RIP_RELATIVE_ADDR(sme_me_mask));
>
> Can we move the cast into the macro?
>
> #define RIP_RELATIVE_REF(var) (*(typeof(&var))rip_relative_ptr(&var))
>
> and make this
>
>     return RIP_RELATIVE_REF(sme_me_mask);

Yes. I will double check that there are no instances where we actually
want the pointer instead of the dereferenced value, but I believe this
always works.

> > +}
> > +
> > +static __always_inline u64 sev_get_status_fixup(void)
>
> Can we drop the _fixup suffix here? Or if we need to convey the fact
> that this is a special accessor that can be used early, use _early
> instead.

I'll just drop the suffix. I prefer not to use "early" in order to
avoid conflating the meaning with "runs before page table fixups",
which I don't think is true for all existing functions using the early
suffix.

> > +{
> > +       return *((u64 *) RIP_RELATIVE_ADDR(sev_status));
> > +}
> > +
> >  #define __bss_decrypted __section(".bss..decrypted")
> >
> >  #else  /* !CONFIG_AMD_MEM_ENCRYPT */
> > @@ -89,6 +113,9 @@ early_set_mem_enc_dec_hypercall(unsigned long vaddr,=
 unsigned long size, bool en
> >
> >  static inline void mem_encrypt_free_decrypted_mem(void) { }
> >
> > +static inline u64 sme_get_me_mask_fixup(void) { return 0; }
> > +static inline u64 sev_get_status_fixup(void) { return 0; }
> > +
> >  #define __bss_decrypted
> >
> >  #endif /* CONFIG_AMD_MEM_ENCRYPT */
> > @@ -106,11 +133,6 @@ void add_encrypt_protection_map(void);
> >
> >  extern char __start_bss_decrypted[], __end_bss_decrypted[], __start_bs=
s_decrypted_unused[];
> >
> > -static inline u64 sme_get_me_mask(void)
> > -{
> > -       return sme_me_mask;
> > -}
> > -
> >  #endif /* __ASSEMBLY__ */
> >
> >  #endif /* __X86_MEM_ENCRYPT_H__ */
> > diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
> > index dc0956067944..d159239997f4 100644
> > --- a/arch/x86/kernel/head64.c
> > +++ b/arch/x86/kernel/head64.c
> > @@ -128,6 +128,7 @@ static bool __head check_la57_support(unsigned long=
 physaddr)
> >
> >  static unsigned long __head sme_postprocess_startup(struct boot_params=
 *bp, pmdval_t *pmd)
> >  {
> > +       const u64 sme_me_mask_fixed_up =3D sme_get_me_mask_fixup();
> >         unsigned long vaddr, vaddr_end;
> >         int i;
> >
> > @@ -140,7 +141,7 @@ static unsigned long __head sme_postprocess_startup=
(struct boot_params *bp, pmdv
> >          * there is no need to zero it after changing the memory encryp=
tion
> >          * attribute.
> >          */
> > -       if (sme_get_me_mask()) {
> > +       if (sme_me_mask_fixed_up) {
> >                 vaddr =3D (unsigned long)__start_bss_decrypted;
> >                 vaddr_end =3D (unsigned long)__end_bss_decrypted;
> >
> > @@ -158,7 +159,7 @@ static unsigned long __head sme_postprocess_startup=
(struct boot_params *bp, pmdv
> >                         early_snp_set_memory_shared(__pa(vaddr), __pa(v=
addr), PTRS_PER_PMD);
> >
> >                         i =3D pmd_index(vaddr);
> > -                       pmd[i] -=3D sme_get_me_mask();
> > +                       pmd[i] -=3D sme_me_mask_fixed_up;
> >                 }
> >         }
> >
> > @@ -166,18 +167,22 @@ static unsigned long __head sme_postprocess_start=
up(struct boot_params *bp, pmdv
> >          * Return the SME encryption mask (if SME is active) to be used=
 as a
> >          * modifier for the initial pgdir entry programmed into CR3.
> >          */
> > -       return sme_get_me_mask();
> > +       return sme_me_mask_fixed_up;
>
> Just use sme_get_me_mask() as before in this file.

Will do.

> >  }
> >
> > -/* Code in __startup_64() can be relocated during execution, but the c=
ompiler
> > +/*
> > + * WARNING!!
> > + * Code in __startup_64() can be relocated during execution, but the c=
ompiler
> >   * doesn't have to generate PC-relative relocations when accessing glo=
bals from
> >   * that function. Clang actually does not generate them, which leads t=
o
> >   * boot-time crashes. To work around this problem, every global pointe=
r must
> > - * be adjusted using fixup_pointer().
> > + * be adjusted using fixup_pointer() or RIP_RELATIVE_ADDR().
> >   */
> >  unsigned long __head __startup_64(unsigned long physaddr,
> >                                   struct boot_params *bp)
> >  {
> > +       const u64 sme_me_mask_fixed_up =3D sme_get_me_mask_fixup();
> > +       pmd_t **early_dynamic_pgts_ptr;
> >         unsigned long load_delta, *p;
> >         unsigned long pgtable_flags;
> >         pgdval_t *pgd;
> > @@ -206,7 +211,7 @@ unsigned long __head __startup_64(unsigned long phy=
saddr,
> >                 for (;;);
> >
> >         /* Include the SME encryption mask in the fixup value */
> > -       load_delta +=3D sme_get_me_mask();
> > +       load_delta +=3D sme_me_mask_fixed_up;
> >
> >         /* Fixup the physical addresses in the page table */
> >
> > @@ -239,14 +244,14 @@ unsigned long __head __startup_64(unsigned long p=
hysaddr,
> >          */
> >
> >         next_pgt_ptr =3D fixup_pointer(&next_early_pgt, physaddr);
> > -       pud =3D fixup_pointer(early_dynamic_pgts[(*next_pgt_ptr)++], ph=
ysaddr);
> > -       pmd =3D fixup_pointer(early_dynamic_pgts[(*next_pgt_ptr)++], ph=
ysaddr);
> > +       early_dynamic_pgts_ptr =3D fixup_pointer(early_dynamic_pgts, ph=
ysaddr);
> > +       pud =3D (pudval_t *) early_dynamic_pgts_ptr[(*next_pgt_ptr)++];
> > +       pmd =3D (pmdval_t *) early_dynamic_pgts_ptr[(*next_pgt_ptr)++];
> >
>
> Better to introduce early_dynamic_pgts_ptr in a separate patch if it
> is just an optimization but doesn't actually fix anything.

Yeah, we can just drop. I mistakenly previously believed
early_dynamic_pgts also needed a fixup.

> > -       pgtable_flags =3D _KERNPG_TABLE_NOENC + sme_get_me_mask();
> > +       pgtable_flags =3D _KERNPG_TABLE_NOENC + sme_me_mask_fixed_up;
> >
> >         if (la57) {
> > -               p4d =3D fixup_pointer(early_dynamic_pgts[(*next_pgt_ptr=
)++],
> > -                                   physaddr);
> > +               p4d =3D (p4dval_t *) early_dynamic_pgts_ptr[(*next_pgt_=
ptr)++];
> >
> >                 i =3D (physaddr >> PGDIR_SHIFT) % PTRS_PER_PGD;
> >                 pgd[i + 0] =3D (pgdval_t)p4d + pgtable_flags;
> > @@ -269,7 +274,7 @@ unsigned long __head __startup_64(unsigned long phy=
saddr,
> >         /* Filter out unsupported __PAGE_KERNEL_* bits: */
> >         mask_ptr =3D fixup_pointer(&__supported_pte_mask, physaddr);
> >         pmd_entry &=3D *mask_ptr;
> > -       pmd_entry +=3D sme_get_me_mask();
> > +       pmd_entry +=3D sme_me_mask_fixed_up;
> >         pmd_entry +=3D  physaddr;
> >
> >         for (i =3D 0; i < DIV_ROUND_UP(_end - _text, PMD_SIZE); i++) {
> > @@ -313,7 +318,7 @@ unsigned long __head __startup_64(unsigned long phy=
saddr,
> >          * Fixup phys_base - remove the memory encryption mask to obtai=
n
> >          * the true physical address.
> >          */
> > -       *fixup_long(&phys_base, physaddr) +=3D load_delta - sme_get_me_=
mask();
> > +       *fixup_long(&phys_base, physaddr) +=3D load_delta - sme_me_mask=
_fixed_up;
> >
> >         return sme_postprocess_startup(bp, pmd);
> >  }
> > diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
> > index d4918d03efb4..b9e52cee6e00 100644
> > --- a/arch/x86/kernel/head_64.S
> > +++ b/arch/x86/kernel/head_64.S
> > @@ -176,9 +176,11 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SY=
M_L_GLOBAL)
> >         /*
> >          * Retrieve the modifier (SME encryption mask if SME is active)=
 to be
> >          * added to the initial pgdir entry that will be programmed int=
o CR3.
> > +        * Since we may have not completed page table fixups, use RIP-r=
elative
> > +        * addressing for sme_me_mask.
>
> This runs on the secondary path only, so this comment is inaccurate.

Good catch, thanks. I'll drop it.

> >          */
> >  #ifdef CONFIG_AMD_MEM_ENCRYPT
> > -       movq    sme_me_mask, %rax
> > +       movq    sme_me_mask(%rip), %rax
> >  #else
> >         xorq    %rax, %rax
> >  #endif
> > diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.=
c
> > index 1d24ec679915..9ea6bea37e1d 100644
> > --- a/arch/x86/kernel/sev-shared.c
> > +++ b/arch/x86/kernel/sev-shared.c
> > @@ -7,6 +7,11 @@
> >   * This file is not compiled stand-alone. It contains code shared
> >   * between the pre-decompression boot code and the running Linux kerne=
l
> >   * and is included directly into both code-bases.
> > + *
> > + * WARNING!!
> > + * Select functions in this file can execute prior to page table fixup=
s and thus
> > + * require pointer fixups for global variable accesses. See WARNING in
> > + * arch/x86/kernel/head64.c.
> >   */
> >
> >  #ifndef __BOOT_COMPRESSED
> > @@ -318,23 +323,6 @@ static int sev_cpuid_hv(struct ghcb *ghcb, struct =
es_em_ctxt *ctxt, struct cpuid
> >                     : __sev_cpuid_hv_msr(leaf);
> >  }
> >
> > -/*
> > - * This may be called early while still running on the initial identit=
y
> > - * mapping. Use RIP-relative addressing to obtain the correct address
> > - * while running with the initial identity mapping as well as the
> > - * switch-over to kernel virtual addresses later.
> > - */
> > -static const struct snp_cpuid_table *snp_cpuid_get_table(void)
> > -{
>
> You could just make this return the RIP_RELATIVE_ADDR() result, right?

Yes, I'll do that to minimize changes for backport-friendliness.

> > -       void *ptr;
> > -
> > -       asm ("lea cpuid_table_copy(%%rip), %0"
> > -            : "=3Dr" (ptr)
> > -            : "p" (&cpuid_table_copy));
> > -
> > -       return ptr;
> > -}
> > -
> >  /*
> >   * The SNP Firmware ABI, Revision 0.9, Section 7.1, details the use of
> >   * XCR0_IN and XSS_IN to encode multiple versions of 0xD subfunctions =
0
> > @@ -357,7 +345,7 @@ static const struct snp_cpuid_table *snp_cpuid_get_=
table(void)
> >   */
> >  static u32 snp_cpuid_calc_xsave_size(u64 xfeatures_en, bool compacted)
> >  {
> > -       const struct snp_cpuid_table *cpuid_table =3D snp_cpuid_get_tab=
le();
> > +       const struct snp_cpuid_table *cpuid_table =3D RIP_RELATIVE_ADDR=
(cpuid_table_copy);
> >         u64 xfeatures_found =3D 0;
> >         u32 xsave_size =3D 0x240;
> >         int i;
> > @@ -394,7 +382,7 @@ static u32 snp_cpuid_calc_xsave_size(u64 xfeatures_=
en, bool compacted)
> >  static bool
> >  snp_cpuid_get_validated_func(struct cpuid_leaf *leaf)
> >  {
> > -       const struct snp_cpuid_table *cpuid_table =3D snp_cpuid_get_tab=
le();
> > +       const struct snp_cpuid_table *cpuid_table =3D RIP_RELATIVE_ADDR=
(cpuid_table_copy);
> >         int i;
> >
> >         for (i =3D 0; i < cpuid_table->count; i++) {
> > @@ -530,7 +518,8 @@ static int snp_cpuid_postprocess(struct ghcb *ghcb,=
 struct es_em_ctxt *ctxt,
> >   */
> >  static int snp_cpuid(struct ghcb *ghcb, struct es_em_ctxt *ctxt, struc=
t cpuid_leaf *leaf)
> >  {
> > -       const struct snp_cpuid_table *cpuid_table =3D snp_cpuid_get_tab=
le();
> > +       const u32 *cpuid_std_range_max_ptr, *cpuid_hyp_range_max_ptr, *=
cpuid_ext_range_max_ptr;
> > +       const struct snp_cpuid_table *cpuid_table =3D RIP_RELATIVE_ADDR=
(cpuid_table_copy);
> >
> >         if (!cpuid_table->count)
> >                 return -EOPNOTSUPP;
> > @@ -555,10 +544,14 @@ static int snp_cpuid(struct ghcb *ghcb, struct es=
_em_ctxt *ctxt, struct cpuid_le
> >                  */
> >                 leaf->eax =3D leaf->ebx =3D leaf->ecx =3D leaf->edx =3D=
 0;
> >
> > +               cpuid_std_range_max_ptr =3D RIP_RELATIVE_ADDR(cpuid_std=
_range_max);
> > +               cpuid_hyp_range_max_ptr =3D RIP_RELATIVE_ADDR(cpuid_hyp=
_range_max);
> > +               cpuid_ext_range_max_ptr =3D RIP_RELATIVE_ADDR(cpuid_ext=
_range_max);
> > +
> >                 /* Skip post-processing for out-of-range zero leafs. */
> > -               if (!(leaf->fn <=3D cpuid_std_range_max ||
> > -                     (leaf->fn >=3D 0x40000000 && leaf->fn <=3D cpuid_=
hyp_range_max) ||
> > -                     (leaf->fn >=3D 0x80000000 && leaf->fn <=3D cpuid_=
ext_range_max)))
> > +               if (!(leaf->fn <=3D *cpuid_std_range_max_ptr ||
> > +                     (leaf->fn >=3D 0x40000000 && leaf->fn <=3D *cpuid=
_hyp_range_max_ptr) ||
> > +                     (leaf->fn >=3D 0x80000000 && leaf->fn <=3D *cpuid=
_ext_range_max_ptr)))
> >                         return 0;
> >         }
> >
> > @@ -1045,6 +1038,7 @@ static struct cc_blob_sev_info *find_cc_blob_setu=
p_data(struct boot_params *bp)
> >   */
> >  static void __init setup_cpuid_table(const struct cc_blob_sev_info *cc=
_info)
> >  {
> > +       u32 *cpuid_std_range_max_ptr, *cpuid_hyp_range_max_ptr, *cpuid_=
ext_range_max_ptr;
> >         const struct snp_cpuid_table *cpuid_table_fw, *cpuid_table;
> >         int i;
> >
> > @@ -1055,19 +1049,23 @@ static void __init setup_cpuid_table(const stru=
ct cc_blob_sev_info *cc_info)
> >         if (!cpuid_table_fw->count || cpuid_table_fw->count > SNP_CPUID=
_COUNT_MAX)
> >                 sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_CPUID);
> >
> > -       cpuid_table =3D snp_cpuid_get_table();
> > +       cpuid_table =3D RIP_RELATIVE_ADDR(cpuid_table_copy);
> >         memcpy((void *)cpuid_table, cpuid_table_fw, sizeof(*cpuid_table=
));
> >
> > +       cpuid_std_range_max_ptr =3D RIP_RELATIVE_ADDR(cpuid_std_range_m=
ax);
> > +       cpuid_hyp_range_max_ptr =3D RIP_RELATIVE_ADDR(cpuid_hyp_range_m=
ax);
> > +       cpuid_ext_range_max_ptr =3D RIP_RELATIVE_ADDR(cpuid_ext_range_m=
ax);
> > +
>
> Can we cache the values here rather than the pointers?

Yes, I'll do so.

