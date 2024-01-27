Return-Path: <linux-kernel+bounces-40956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F69083E8D4
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 02:00:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 751141C21960
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 01:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88D4B5390;
	Sat, 27 Jan 2024 01:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KI1DIudf"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FDDD4680
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 00:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706317202; cv=none; b=BwcKjOvTar4riGpSdFehPDByxay7NMssITBdBHW9tCrPJO/JDr7efSFc1r06dDw20k4zABSnHjuXouaTVW6FC18VkR4LD4DggX2chvwZFv4OQt4elk5qcqRzzHYEZipmUqMk147tnzDJxiCaNTuScTswmvSh9bQAdiIc99zkGUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706317202; c=relaxed/simple;
	bh=XGtdi5JpObjkviNEUWEyRpZajxR5TRweZpn18vU6PNE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y1FqG5meBtKlablNyKE+wRc9kydX1v/Ohs5LJLXY8n/mwk0ix57GriB7lyMDd4fCjsvlGKKDD70kEUDpfrdFt0hxNUPmsfb/atdW+GpGzWUmycCYZF8CikOodGQC/vCFHEfVnMK9YSRX2Pd+9aJhf2r8jSfW9LxPjj0osoPFa6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KI1DIudf; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-55c24a32bf4so4386a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 16:59:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706317198; x=1706921998; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DDjeUTRoDaxTb1sX3zfZRyQKHGL0LE8LNRkam1/sQbc=;
        b=KI1DIudfO2HT95x+vAeqTKVEIFn3pUnsdArenLHzTd0A1beGbH4HZBT700tqYO0+9Q
         WYSCdQKDaKiya8/BtO0biQj6dP94LOYSOavf5qnJ3Iw2Hx/0tB2qQHymkOLVHiY/P2W6
         2vFeIp0vW3/A6DSBJi6n33pridTgChCL9g9L258stHVFvWp5lC5wxI7tVOTnRbyfxv6/
         Pdl9HIvdomyLIUBEjUrfSbcFNv9lNZjyFDb3k1ldR20Vc7zL37rdjP0gi97/tsymNjqV
         Q50PPvX7T0tDs6bIZB7xuHbF1ADQT+E9ly/3P3T27ukEsMi6hkKqGdtL9/OCIhlXDZY5
         PGug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706317198; x=1706921998;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DDjeUTRoDaxTb1sX3zfZRyQKHGL0LE8LNRkam1/sQbc=;
        b=gYG4lT0+T0fUuc/nn8Wj2hcH+sWJfpWO6KLZPiVTpJudoNr+gC5wQJH4nCmswZx6z0
         D7AxDB5vIqIja/rtZQiP21TNmY34lHb524XXHc8sy55ZTdPI5nef7mCq0HadsP8gGHuJ
         N7D555dEhL1kyzcHBvaZgyRs88HwSfqiUFk1v0uU9S53P8FAyGJSpefjp85YH725pMbl
         66HHJsnUtRXfyN4J4N/yWjUe2L5P8PXJPDHhtC3tadix1RTKmj/n3iXhkpY54yvM2MA3
         traRqhecV/ToSuYdojaGuWjPdUQyZhKkP9wajMiKbCoORdjzdFesMOJhqNEnQdQfNcJS
         yMNg==
X-Gm-Message-State: AOJu0Yzxi6FFg4PFqWMFm4KRxkozCfwPG+tNI3kht8EMT9VdAvlCIP17
	IQA7HOjF7vyu197QYq9DtDTlyb7pWgLC8//F/EQn4ponVnAPC2Uos2vJZvmtEoeFAJvuAOJHtDb
	pWAPohxO443gG2IThI+Z2BOizJWJLUEfCO4vT
X-Google-Smtp-Source: AGHT+IGv53hNPNnT+xptLGcgaoYH9HvwGrx3N09iozoJLMjsRdTCb4m/DhfjRpTXBX2SzyTurx06aBsSGYn+8lsQZhc=
X-Received: by 2002:aa7:c647:0:b0:55d:3128:c5b8 with SMTP id
 z7-20020aa7c647000000b0055d3128c5b8mr225846edr.2.1706317197824; Fri, 26 Jan
 2024 16:59:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1706307364.git.thomas.lendacky@amd.com> <d89b9ebb592a2436a1969304f826ddf3866682bc.1706307364.git.thomas.lendacky@amd.com>
In-Reply-To: <d89b9ebb592a2436a1969304f826ddf3866682bc.1706307364.git.thomas.lendacky@amd.com>
From: Dionna Amalie Glaze <dionnaglaze@google.com>
Date: Fri, 26 Jan 2024 16:59:46 -0800
Message-ID: <CAAH4kHaX8T01wrA1XUUK5bJGKHHTw7GSY9ua0bVvo-6MkODUOw@mail.gmail.com>
Subject: Re: [PATCH 05/11] x86/sev: Perform PVALIDATE using the SVSM when not
 at VMPL0
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Dan Williams <dan.j.williams@intel.com>, Michael Roth <michael.roth@amd.com>, 
	Ashish Kalra <ashish.kalra@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 26, 2024 at 2:18=E2=80=AFPM Tom Lendacky <thomas.lendacky@amd.c=
om> wrote:
>
> The PVALIDATE instruction can only be performed at VMPL0. An SVSM will
> be present when running at VMPL1 or a lower privilege level.
>
> When an SVSM is present, use the SVSM_CORE_PVALIDATE call to perform
> memory validation instead of issuing the PVALIDATE instruction directly.
>
> The validation of a single 4K page is now explicitly identified as such
> in the function name, pvalidate_4k_page(). The pvalidate_pages() function
> is used for validating 1 or more pages at either 4K or 2M in size. Each
> function, however, determines whether it can issue the PVALIDATE directly
> or whether the SVSM needs to be invoked.
>
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
> ---
>  arch/x86/boot/compressed/sev.c |  42 +++++++-
>  arch/x86/include/asm/sev.h     |  22 +++++
>  arch/x86/kernel/sev-shared.c   | 176 ++++++++++++++++++++++++++++++++-
>  arch/x86/kernel/sev.c          |  25 +++--
>  4 files changed, 247 insertions(+), 18 deletions(-)
>
> diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/se=
v.c
> index 5d2403914ceb..3fbb614c31e0 100644
> --- a/arch/x86/boot/compressed/sev.c
> +++ b/arch/x86/boot/compressed/sev.c
> @@ -38,6 +38,16 @@ static u8 vmpl __section(".data");
>  static u64 boot_svsm_caa_pa __section(".data");
>  static struct svsm_ca *boot_svsm_caa __section(".data");
>
> +static struct svsm_ca *__svsm_get_caa(void)
> +{
> +       return boot_svsm_caa;
> +}
> +
> +static u64 __svsm_get_caa_pa(void)
> +{
> +       return boot_svsm_caa_pa;
> +}
> +
>  /*
>   * Copy a version of this function here - insn-eval.c can't be used in
>   * pre-decompression code.
> @@ -135,6 +145,24 @@ static bool fault_in_kernel_space(unsigned long addr=
ess)
>  /* Include code for early handlers */
>  #include "../../kernel/sev-shared.c"
>
> +static int svsm_protocol(struct svsm_call *call)
> +{
> +       struct ghcb *ghcb;
> +       int ret;
> +
> +       if (boot_ghcb)
> +               ghcb =3D boot_ghcb;
> +       else
> +               ghcb =3D NULL;
> +
> +       do {
> +               ret =3D ghcb ? __svsm_ghcb_protocol(ghcb, call)
> +                          : __svsm_msr_protocol(call);
> +       } while (ret =3D=3D SVSM_ERR_BUSY);

Should this loop forever or eventually give up and panic?


> +
> +       return ret;
> +}
> +
>  bool sev_snp_enabled(void)
>  {
>         return sev_status & MSR_AMD64_SEV_SNP_ENABLED;
> @@ -151,8 +179,8 @@ static void __page_state_change(unsigned long paddr, =
enum psc_op op)
>          * If private -> shared then invalidate the page before requestin=
g the
>          * state change in the RMP table.
>          */
> -       if (op =3D=3D SNP_PAGE_STATE_SHARED && pvalidate(paddr, RMP_PG_SI=
ZE_4K, 0))
> -               sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_PVALIDATE)=
;
> +       if (op =3D=3D SNP_PAGE_STATE_SHARED)
> +               pvalidate_4k_page(paddr, paddr, 0);
>
>         /* Issue VMGEXIT to change the page state in RMP table. */
>         sev_es_wr_ghcb_msr(GHCB_MSR_PSC_REQ_GFN(paddr >> PAGE_SHIFT, op))=
;
> @@ -167,8 +195,8 @@ static void __page_state_change(unsigned long paddr, =
enum psc_op op)
>          * Now that page state is changed in the RMP table, validate it s=
o that it is
>          * consistent with the RMP entry.
>          */
> -       if (op =3D=3D SNP_PAGE_STATE_PRIVATE && pvalidate(paddr, RMP_PG_S=
IZE_4K, 1))
> -               sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_PVALIDATE)=
;
> +       if (op =3D=3D SNP_PAGE_STATE_PRIVATE)
> +               pvalidate_4k_page(paddr, paddr, 1);
>  }
>
>  void snp_set_page_private(unsigned long paddr)
> @@ -261,6 +289,12 @@ void sev_es_shutdown_ghcb(void)
>         if (!sev_es_check_cpu_features())
>                 error("SEV-ES CPU Features missing.");
>
> +       /*
> +        * Ensure that the boot GHCB isn't used for the PVALIDATE when ru=
nning

Why the definite article? Which PVALIDATE is this referring to?

> +        * under an SVSM.
> +        */
> +       boot_ghcb =3D NULL;
> +
>         /*
>          * GHCB Page must be flushed from the cache and mapped encrypted =
again.
>          * Otherwise the running kernel will see strange cache effects wh=
en
> diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
> index 2f1e583769fc..dbd7fd041689 100644
> --- a/arch/x86/include/asm/sev.h
> +++ b/arch/x86/include/asm/sev.h
> @@ -172,6 +172,27 @@ struct svsm_ca {
>  #define SVSM_ERR_INVALID_PARAMETER             0x80000005
>  #define SVSM_ERR_INVALID_REQUEST               0x80000006
>  #define SVSM_ERR_BUSY                          0x80000007
> +#define SVSM_PVALIDATE_FAIL_SIZEMISMATCH       0x80001006
> +
> +/*
> + * The SVSM PVALIDATE related structures
> + */
> +struct svsm_pvalidate_entry {
> +       u64 page_size           : 2,
> +           action              : 1,
> +           ignore_cf           : 1,
> +           rsvd                : 8,
> +           pfn                 : 52;
> +};
> +
> +struct svsm_pvalidate_call {
> +       u16 entries;
> +       u16 next;
> +
> +       u8 rsvd1[4];
> +
> +       struct svsm_pvalidate_entry entry[];
> +};
>
>  /*
>   * SVSM protocol structure
> @@ -192,6 +213,7 @@ struct svsm_call {
>
>  #define SVSM_CORE_CALL(x)              ((0ULL << 32) | (x))
>  #define SVSM_CORE_REMAP_CA             0
> +#define SVSM_CORE_PVALIDATE            1
>
>  #ifdef CONFIG_AMD_MEM_ENCRYPT
>  extern void __sev_es_ist_enter(struct pt_regs *regs);
> diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
> index 7e9fa5d8889b..f26e872bc5d0 100644
> --- a/arch/x86/kernel/sev-shared.c
> +++ b/arch/x86/kernel/sev-shared.c
> @@ -81,6 +81,8 @@ static u32 cpuid_std_range_max __ro_after_init;
>  static u32 cpuid_hyp_range_max __ro_after_init;
>  static u32 cpuid_ext_range_max __ro_after_init;
>
> +static int svsm_protocol(struct svsm_call *call);
> +
>  static bool __init sev_es_check_cpu_features(void)
>  {
>         if (!has_cpuflag(X86_FEATURE_RDRAND)) {
> @@ -1181,7 +1183,65 @@ static void __init setup_cpuid_table(const struct =
cc_blob_sev_info *cc_info)
>         }
>  }
>
> -static void pvalidate_pages(struct snp_psc_desc *desc)
> +static int base_pvalidate_4k_page(unsigned long vaddr, bool validate)
> +{
> +       return pvalidate(vaddr, RMP_PG_SIZE_4K, validate);
> +}
> +
> +static int svsm_pvalidate_4k_page(unsigned long paddr, bool validate)
> +{
> +       struct svsm_pvalidate_call *pvalidate_call;
> +       struct svsm_call call =3D {};
> +       u64 pvalidate_call_pa;
> +       unsigned long flags;
> +       int ret;
> +
> +       /*
> +        * This can be called very early in the boot, use native function=
s in
> +        * order to avoid paravirt issues.
> +        */
> +       flags =3D native_save_fl();
> +       if (flags & X86_EFLAGS_IF)
> +               native_irq_disable();
> +
> +       call.caa =3D __svsm_get_caa();
> +
> +       pvalidate_call =3D (struct svsm_pvalidate_call *)call.caa->svsm_b=
uffer;
> +       pvalidate_call_pa =3D __svsm_get_caa_pa() + offsetof(struct svsm_=
ca, svsm_buffer);
> +
> +       pvalidate_call->entries =3D 1;
> +       pvalidate_call->next    =3D 0;
> +       pvalidate_call->entry[0].page_size =3D RMP_PG_SIZE_4K;
> +       pvalidate_call->entry[0].action    =3D validate;
> +       pvalidate_call->entry[0].ignore_cf =3D 0;
> +       pvalidate_call->entry[0].pfn       =3D paddr >> PAGE_SHIFT;
> +
> +       /* Protocol 0, Call ID 1 */
> +       call.rax =3D SVSM_CORE_CALL(SVSM_CORE_PVALIDATE);
> +       call.rcx =3D pvalidate_call_pa;
> +
> +       ret =3D svsm_protocol(&call);
> +
> +       if (flags & X86_EFLAGS_IF)
> +               native_irq_enable();
> +
> +       return ret;
> +}
> +
> +static void pvalidate_4k_page(unsigned long vaddr, unsigned long paddr, =
bool validate)
> +{
> +       int ret;
> +
> +       ret =3D vmpl ? svsm_pvalidate_4k_page(paddr, validate)
> +                  : base_pvalidate_4k_page(vaddr, validate);
> +
> +       if (ret) {
> +               WARN(1, "Failed to validate address 0x%lx ret %d", vaddr,=
 ret);
> +               sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_PVALIDATE)=
;
> +       }
> +}
> +
> +static void base_pvalidate_pages(struct snp_psc_desc *desc)
>  {
>         struct psc_entry *e;
>         unsigned long vaddr;
> @@ -1215,6 +1275,120 @@ static void pvalidate_pages(struct snp_psc_desc *=
desc)
>         }
>  }
>
> +static void svsm_pvalidate_pages(struct snp_psc_desc *desc)
> +{
> +       struct svsm_pvalidate_call *pvalidate_call;
> +       struct svsm_pvalidate_entry *pe;
> +       unsigned int call_count, i;
> +       struct svsm_call call =3D {};
> +       u64 pvalidate_call_pa;
> +       struct psc_entry *e;
> +       unsigned long flags;
> +       unsigned long vaddr;
> +       bool action;
> +       int ret;
> +
> +       /*
> +        * This can be called very early in the boot, use native function=
s in
> +        * order to avoid paravirt issues.
> +        */
> +       flags =3D native_save_fl();
> +       if (flags & X86_EFLAGS_IF)
> +               native_irq_disable();
> +
> +       call.caa =3D __svsm_get_caa();
> +
> +       pvalidate_call =3D (struct svsm_pvalidate_call *)call.caa->svsm_b=
uffer;
> +       pvalidate_call_pa =3D __svsm_get_caa_pa() + offsetof(struct svsm_=
ca, svsm_buffer);
> +
> +       /* Calculate how many entries the CA buffer can hold */
> +       call_count =3D sizeof(call.caa->svsm_buffer);
> +       call_count -=3D offsetof(struct svsm_pvalidate_call, entry);
> +       call_count /=3D sizeof(pvalidate_call->entry[0]);
> +
> +       /* Protocol 0, Call ID 1 */
> +       call.rax =3D SVSM_CORE_CALL(SVSM_CORE_PVALIDATE);
> +       call.rcx =3D pvalidate_call_pa;
> +
> +       pvalidate_call->entries =3D 0;
> +       pvalidate_call->next    =3D 0;
> +
> +       for (i =3D 0; i <=3D desc->hdr.end_entry; i++) {
> +               e =3D &desc->entries[i];
> +               pe =3D &pvalidate_call->entry[pvalidate_call->entries];
> +
> +               pe->page_size =3D e->pagesize ? RMP_PG_SIZE_2M : RMP_PG_S=
IZE_4K;
> +               pe->action    =3D e->operation =3D=3D SNP_PAGE_STATE_PRIV=
ATE;
> +               pe->ignore_cf =3D 0;
> +               pe->pfn       =3D e->gfn;
> +
> +               pvalidate_call->entries++;
> +               if (pvalidate_call->entries < call_count && i !=3D desc->=
hdr.end_entry)
> +                       continue;
> +
> +               ret =3D svsm_protocol(&call);
> +               if (ret =3D=3D SVSM_PVALIDATE_FAIL_SIZEMISMATCH &&
> +                   pvalidate_call->entry[pvalidate_call->next].page_size=
 =3D=3D RMP_PG_SIZE_2M) {
> +                       u64 pfn, pfn_end;
> +
> +                       /*
> +                        * The "next" field is the index of the failed en=
try. Calculate the
> +                        * index of the entry after the failed entry befo=
re the fields are
> +                        * cleared so that processing can continue on fro=
m that point (take
> +                        * into account the for loop adding 1 to the entr=
y).
> +                        */
> +                       i -=3D pvalidate_call->entries - pvalidate_call->=
next;
> +                       i +=3D 1;
> +
> +                       action =3D pvalidate_call->entry[pvalidate_call->=
next].action;
> +                       pfn =3D pvalidate_call->entry[pvalidate_call->nex=
t].pfn;
> +                       pfn_end =3D pfn + 511;
> +
> +                       pvalidate_call->entries =3D 0;
> +                       pvalidate_call->next    =3D 0;
> +                       for (; pfn <=3D pfn_end; pfn++) {
> +                               pe =3D &pvalidate_call->entry[pvalidate_c=
all->entries];
> +
> +                               pe->page_size =3D RMP_PG_SIZE_4K;
> +                               pe->action    =3D action;
> +                               pe->ignore_cf =3D 0;
> +                               pe->pfn       =3D pfn;
> +
> +                               pvalidate_call->entries++;
> +                               if (pvalidate_call->entries < call_count =
&& pfn !=3D pfn_end)
> +                                       continue;
> +
> +                               ret =3D svsm_protocol(&call);
> +                               if (ret !=3D SVSM_SUCCESS)
> +                                       break;
> +
> +                               pvalidate_call->entries =3D 0;
> +                               pvalidate_call->next    =3D 0;
> +                       }
> +               }
> +
> +               if (ret !=3D SVSM_SUCCESS) {
> +                       pe =3D &pvalidate_call->entry[pvalidate_call->nex=
t];
> +                       vaddr =3D (unsigned long)pfn_to_kaddr(pe->pfn);
> +
> +                       WARN(1, "Failed to validate address %lx ret=3D%#x=
 (%d)", vaddr, ret, ret);
> +                       sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_PV=
ALIDATE);
> +               }
> +
> +               pvalidate_call->entries =3D 0;
> +               pvalidate_call->next    =3D 0;
> +       }
> +
> +       if (flags & X86_EFLAGS_IF)
> +               native_irq_enable();
> +}
> +
> +static void pvalidate_pages(struct snp_psc_desc *desc)
> +{
> +       vmpl ? svsm_pvalidate_pages(desc)
> +            : base_pvalidate_pages(desc);
> +}
> +
>  static int vmgexit_psc(struct ghcb *ghcb, struct snp_psc_desc *desc)
>  {
>         int cur_entry, end_entry, ret =3D 0;
> diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
> index 3bd7860fbfe1..2fd21090ef6b 100644
> --- a/arch/x86/kernel/sev.c
> +++ b/arch/x86/kernel/sev.c
> @@ -161,6 +161,12 @@ static struct svsm_ca *__svsm_get_caa(void)
>                                        : boot_svsm_caa;
>  }
>
> +static u64 __svsm_get_caa_pa(void)
> +{
> +       return sev_cfg.cas_initialized ? this_cpu_read(svsm_caa_pa)
> +                                      : boot_svsm_caa_pa;
> +}
> +
>  static __always_inline bool on_vc_stack(struct pt_regs *regs)
>  {
>         unsigned long sp =3D regs->sp;
> @@ -777,7 +783,6 @@ static void early_set_pages_state(unsigned long vaddr=
, unsigned long paddr,
>  {
>         unsigned long paddr_end;
>         u64 val;
> -       int ret;
>
>         vaddr =3D vaddr & PAGE_MASK;
>
> @@ -785,12 +790,9 @@ static void early_set_pages_state(unsigned long vadd=
r, unsigned long paddr,
>         paddr_end =3D paddr + (npages << PAGE_SHIFT);
>
>         while (paddr < paddr_end) {
> -               if (op =3D=3D SNP_PAGE_STATE_SHARED) {
> -                       /* Page validation must be rescinded before chang=
ing to shared */
> -                       ret =3D pvalidate(vaddr, RMP_PG_SIZE_4K, false);
> -                       if (WARN(ret, "Failed to validate address 0x%lx r=
et %d", paddr, ret))
> -                               goto e_term;
> -               }
> +               /* Page validation must be rescinded before changing to s=
hared */
> +               if (op =3D=3D SNP_PAGE_STATE_SHARED)
> +                       pvalidate_4k_page(vaddr, paddr, false);
>
>                 /*
>                  * Use the MSR protocol because this function can be call=
ed before
> @@ -812,12 +814,9 @@ static void early_set_pages_state(unsigned long vadd=
r, unsigned long paddr,
>                          paddr, GHCB_MSR_PSC_RESP_VAL(val)))
>                         goto e_term;
>
> -               if (op =3D=3D SNP_PAGE_STATE_PRIVATE) {
> -                       /* Page validation must be performed after changi=
ng to private */
> -                       ret =3D pvalidate(vaddr, RMP_PG_SIZE_4K, true);
> -                       if (WARN(ret, "Failed to validate address 0x%lx r=
et %d", paddr, ret))
> -                               goto e_term;
> -               }
> +               /* Page validation must be performed after changing to pr=
ivate */
> +               if (op =3D=3D SNP_PAGE_STATE_PRIVATE)
> +                       pvalidate_4k_page(vaddr, paddr, true);
>
>                 vaddr +=3D PAGE_SIZE;
>                 paddr +=3D PAGE_SIZE;
> --
> 2.42.0
>
>


--
-Dionna Glaze, PhD (she/her)

