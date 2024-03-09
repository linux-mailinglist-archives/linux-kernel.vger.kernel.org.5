Return-Path: <linux-kernel+bounces-97707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F5C4876E28
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 01:34:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4BA38B222CD
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 00:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56ED815AF;
	Sat,  9 Mar 2024 00:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m0IAqGw3"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6324CA29
	for <linux-kernel@vger.kernel.org>; Sat,  9 Mar 2024 00:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709944445; cv=none; b=r1SGEOvc++iY2li0stjhliZKyP3Yu1Zs9XOEe45fhS7ja+btAGW7ZSpBh8LS7Pv7khIZ6Gc5Mlt7ZbT7DNUNc/TglxptmlTyuXrNrtACaYScvWcsV+eVzmRMfrESXYWVClsfoldeaKzcC/ElFqKrCExKh4jGJkEn3BWHFMtDdaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709944445; c=relaxed/simple;
	bh=1F2FlKRvAm2NQU+0iAbEsiHPRlebdkX1AibQ7+HTCgM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n79/fIQ3eJh5/JLA0K5d25sgYQNq7oQKUWLXtMmd7yU3ekrY/RGckTgOGtllqu7dAQR4veN1leB26QL0Htxx2vpvchHEqKtrRCJ1WzobNQr1n/+BZdbnYg0+pXns0UEwvDlvbU72byMF+jqdyS/2cEz/fZZe8KvVtw6IMiszIr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=m0IAqGw3; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-565223fd7d9so1917a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2024 16:34:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709944442; x=1710549242; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yvb90VQnyB5aD0AlxrREGiAfipctULTz9ZnJQTaBJ10=;
        b=m0IAqGw3PtaWd+i6Wf7eFmUtuVbpgiYNtQSkAGjnPBo0ZpOmSFO3xlWxk09bdOYXPb
         Jr2oJ/w1BFRHG64tcTaZNTWYKviiK2o1I30YXvEpvDcOaTzoMWVSETprQz29TqNPz8JZ
         s+9MWzI7ptRG1VIQ8dYv+TFpDVyYXJ0AqLBP+/JgigP2hD818j7z6kPm3jOpmjEcvGkA
         lBjXNMW3I64cq4X5hM22JFoWI6dAntXPC0Dc6nZEnSBQjKhviaK2XwW6E4sKMzkEQSXY
         FBwASl/mQ3McKD92FdJFMLdoe/4HSUYX8dVyYmDrv7XxEuYQURs4Lk7M149M5UtEWcZh
         /6fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709944442; x=1710549242;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yvb90VQnyB5aD0AlxrREGiAfipctULTz9ZnJQTaBJ10=;
        b=XEbuzitV/C99hRwCLSI4TCNgG+czwBrlo4GleLkr0q9l2L0SGLU84RcWob/tmVJZVB
         CC9F+c3lbRwYSfKeY7pB1jD+ZOak5cpGH3ZZZT953VN7NBuFeZNGPaFpVTX2yrFcG78V
         lohuoA+KCemsxEPz8HZSvg7AHHkpd1wptonXy9ciO7cEDCuT16Xgrf/fdLO7zK+6gtjy
         ND1DRvpBYIPsVw5AKpEdTkWv1Fg2nlkI8gHzSi6j00vt2zIeD1X/+iX5ipg1oqCOFxF9
         ChOsCSZZjmzijKro5fuXHW1Y+PHdzEEbh55vLwqlb9Pkfp6D/s9sIv/jAUfC4RqpKv/o
         h66A==
X-Gm-Message-State: AOJu0YyXds682D6/0u5ZgAYRvk3aYn5uJJ4q6Dl1qeuWD3QpPmZlc8NB
	DTplJ3ubVYfep/S4wWqtgWlcAJYzzv5b1BTPWSiL22E1xkG+6/q51Y9TbMOlyuz0eLO+uV5XHMd
	OM0nVBXB9ezy+HJYupoc14B4hcthdllbrGyJw
X-Google-Smtp-Source: AGHT+IF3WluS8Ft3A/1cR68NlJlB+jNZgo5R5dW0s9sdIvDDxOVvPhjUqmAPov9ix2M7o2MRMo2CpUnDmfasLXjF650=
X-Received: by 2002:aa7:cb57:0:b0:568:2a32:4782 with SMTP id
 w23-20020aa7cb57000000b005682a324782mr276380edt.4.1709944441345; Fri, 08 Mar
 2024 16:34:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1709922929.git.thomas.lendacky@amd.com> <bbd56ae7a73dac0436fa3af43c06ce3ac2d0c7fd.1709922929.git.thomas.lendacky@amd.com>
In-Reply-To: <bbd56ae7a73dac0436fa3af43c06ce3ac2d0c7fd.1709922929.git.thomas.lendacky@amd.com>
From: Dionna Amalie Glaze <dionnaglaze@google.com>
Date: Fri, 8 Mar 2024 16:33:47 -0800
Message-ID: <CAAH4kHaMWeE65WKRUpf7rho0wNbSjgGUe4wOyX8y+5fyrwSiAQ@mail.gmail.com>
Subject: Re: [PATCH v2 03/14] x86/sev: Check for the presence of an SVSM in
 the SNP Secrets page
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Dan Williams <dan.j.williams@intel.com>, Michael Roth <michael.roth@amd.com>, 
	Ashish Kalra <ashish.kalra@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 8, 2024 at 10:36=E2=80=AFAM Tom Lendacky <thomas.lendacky@amd.c=
om> wrote:
>
> During early boot phases, check for the presence of an SVSM when running
> as an SEV-SNP guest.
>
> An SVSM is present if the 64-bit value at offset 0x148 into the secrets
> page is non-zero. If an SVSM is present, save the SVSM Calling Area
> address (CAA), located at offset 0x150 into the secrets page, and set
> the VMPL level of the guest, which should be non-zero, to indicate the
> presence of an SVSM.
>
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
> ---
>  arch/x86/boot/compressed/sev.c    | 35 ++++++++---------
>  arch/x86/include/asm/sev-common.h |  4 ++
>  arch/x86/include/asm/sev.h        | 25 +++++++++++-
>  arch/x86/kernel/sev-shared.c      | 64 +++++++++++++++++++++++++++++++
>  arch/x86/kernel/sev.c             | 16 ++++++++
>  5 files changed, 125 insertions(+), 19 deletions(-)
>
> diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/se=
v.c
> index bd7222aad540..f54c0ceae1cb 100644
> --- a/arch/x86/boot/compressed/sev.c
> +++ b/arch/x86/boot/compressed/sev.c
> @@ -12,6 +12,7 @@
>   */
>  #include "misc.h"
>
> +#include <linux/mm.h>
>  #include <asm/bootparam.h>
>  #include <asm/pgtable_types.h>
>  #include <asm/sev.h>
> @@ -29,6 +30,15 @@
>  static struct ghcb boot_ghcb_page __aligned(PAGE_SIZE);
>  struct ghcb *boot_ghcb;
>
> +/*
> + * SVSM related information:
> + *   When running under an SVSM, the VMPL that Linux is executing at mus=
t be
> + *   non-zero. The VMPL is therefore used to indicate the presence of an=
 SVSM.
> + */
> +static u8 vmpl __section(".data");
> +static u64 boot_svsm_caa_pa __section(".data");
> +static struct svsm_ca *boot_svsm_caa __section(".data");
> +
>  /*
>   * Copy a version of this function here - insn-eval.c can't be used in
>   * pre-decompression code.
> @@ -335,24 +345,6 @@ void do_boot_stage2_vc(struct pt_regs *regs, unsigne=
d long exit_code)
>                 sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SEV_ES_GEN_REQ);
>  }
>
> -static bool running_at_vmpl0(void *va)
> -{
> -       u64 attrs;
> -
> -       /*
> -        * RMPADJUST modifies RMP permissions of a lesser-privileged (num=
erically
> -        * higher) privilege level. Here, clear the VMPL1 permission mask=
 of the
> -        * GHCB page. If the guest is not running at VMPL0, this will fai=
l.
> -        *
> -        * If the guest is running at VMPL0, it will succeed. Even if tha=
t operation
> -        * modifies permission bits, it is still ok to do so currently be=
cause Linux
> -        * SNP guests running at VMPL0 only run at VMPL0, so VMPL1 or hig=
her
> -        * permission mask changes are a don't-care.
> -        */
> -       attrs =3D 1;
> -       return !rmpadjust((unsigned long)va, RMP_PG_SIZE_4K, attrs);
> -}
> -
>  /*
>   * SNP_FEATURES_IMPL_REQ is the mask of SNP features that will need
>   * guest side implementation for proper functioning of the guest. If any
> @@ -480,6 +472,13 @@ static bool snp_setup(struct boot_params *bp)
>          */
>         setup_cpuid_table(cc_info);
>
> +       /*
> +        * Record the SVSM Calling Area address (CAA) if the guest is not
> +        * running at VMPL0. The CA will be used to communicate with the
> +        * SVSM to perform the SVSM services.
> +        */
> +       setup_svsm_ca(cc_info);
> +
>         /*
>          * Pass run-time kernel a pointer to CC info via boot_params so E=
FI
>          * config table doesn't need to be searched again during early st=
artup
> diff --git a/arch/x86/include/asm/sev-common.h b/arch/x86/include/asm/sev=
-common.h
> index b463fcbd4b90..68a8cdf6fd6a 100644
> --- a/arch/x86/include/asm/sev-common.h
> +++ b/arch/x86/include/asm/sev-common.h
> @@ -159,6 +159,10 @@ struct snp_psc_desc {
>  #define GHCB_TERM_NOT_VMPL0            3       /* SNP guest is not runni=
ng at VMPL-0 */
>  #define GHCB_TERM_CPUID                        4       /* CPUID-validati=
on failure */
>  #define GHCB_TERM_CPUID_HV             5       /* CPUID failure during h=
ypervisor fallback */
> +#define GHCB_TERM_SECRETS_PAGE         6       /* Secrets page failure *=
/
> +#define GHCB_TERM_NO_SVSM              7       /* SVSM is not advertised=
 in the secrets page */
> +#define GHCB_TERM_SVSM_VMPL0           8       /* SVSM is present but ha=
s set VMPL to 0 */
> +#define GHCB_TERM_SVSM_CAA             9       /* SVSM is present but th=
e CA is not page aligned */
>
>  #define GHCB_RESP_CODE(v)              ((v) & GHCB_MSR_INFO_MASK)
>
> diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
> index 9477b4053bce..891e7d9a1f66 100644
> --- a/arch/x86/include/asm/sev.h
> +++ b/arch/x86/include/asm/sev.h
> @@ -152,9 +152,32 @@ struct snp_secrets_page_layout {
>         u8 vmpck2[VMPCK_KEY_LEN];
>         u8 vmpck3[VMPCK_KEY_LEN];
>         struct secrets_os_area os_area;
> -       u8 rsvd3[3840];
> +
> +       u8 vmsa_tweak_bitmap[64];
> +
> +       /* SVSM fields */
> +       u64 svsm_base;
> +       u64 svsm_size;
> +       u64 svsm_caa;
> +       u32 svsm_max_version;
> +       u8 svsm_guest_vmpl;
> +       u8 rsvd3[3];
> +
> +       /* Remainder of page */
> +       u8 rsvd4[3744];
>  } __packed;
>
> +/*
> + * The SVSM Calling Area (CA) related structures.
> + */
> +struct svsm_ca {
> +       u8 call_pending;
> +       u8 mem_available;
> +       u8 rsvd1[6];
> +
> +       u8 svsm_buffer[PAGE_SIZE - 8];
> +};
> +
>  #ifdef CONFIG_AMD_MEM_ENCRYPT
>  extern void __sev_es_ist_enter(struct pt_regs *regs);
>  extern void __sev_es_ist_exit(void);
> diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
> index 8b04958da5e7..00bb808be44b 100644
> --- a/arch/x86/kernel/sev-shared.c
> +++ b/arch/x86/kernel/sev-shared.c
> @@ -111,6 +111,24 @@ sev_es_terminate(unsigned int set, unsigned int reas=
on)
>                 asm volatile("hlt\n" : : : "memory");
>  }
>
> +static bool running_at_vmpl0(void *va)
> +{
> +       u64 attrs;
> +
> +       /*
> +        * RMPADJUST modifies RMP permissions of a lesser-privileged (num=
erically
> +        * higher) privilege level. Here, clear the VMPL1 permission mask=
 of the
> +        * GHCB page. If the guest is not running at VMPL0, this will fai=
l.
> +        *
> +        * If the guest is running at VMPL0, it will succeed. Even if tha=
t operation
> +        * modifies permission bits, it is still ok to do so currently be=
cause Linux
> +        * SNP guests running at VMPL0 only run at VMPL0, so VMPL1 or hig=
her
> +        * permission mask changes are a don't-care.
> +        */
> +       attrs =3D 1;
> +       return !rmpadjust((unsigned long)va, RMP_PG_SIZE_4K, attrs);
> +}
> +
>  /*
>   * The hypervisor features are available from GHCB version 2 onward.
>   */
> @@ -1267,3 +1285,49 @@ static enum es_result vc_check_opcode_bytes(struct=
 es_em_ctxt *ctxt,
>
>         return ES_UNSUPPORTED;
>  }
> +
> +/*
> + * Maintain the GPA of the SVSM Calling Area (CA) in order to utilize th=
e SVSM
> + * services needed when not runnuing in VMPL0.

running*

otherwise lgtm

> + */
> +static void __init setup_svsm_ca(const struct cc_blob_sev_info *cc_info)
> +{
> +       struct snp_secrets_page_layout *secrets_page;
> +       u64 caa;
> +
> +       BUILD_BUG_ON(sizeof(*secrets_page) !=3D PAGE_SIZE);
> +
> +       /*
> +        * Use __pa() since this routine is running identity mapped when
> +        * called, both by the decompressor code and the early kernel cod=
e.
> +        */
> +       if (running_at_vmpl0((void *)__pa(&boot_ghcb_page)))
> +               return;
> +
> +       /*
> +        * Not running at VMPL0, ensure everything has been properly supp=
lied
> +        * for running under an SVSM.
> +        */
> +       if (!cc_info || !cc_info->secrets_phys || cc_info->secrets_len !=
=3D PAGE_SIZE)
> +               sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_SECRETS_PA=
GE);
> +
> +       secrets_page =3D (struct snp_secrets_page_layout *)cc_info->secre=
ts_phys;
> +       if (!secrets_page->svsm_size)
> +               sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_NO_SVSM);
> +
> +       if (!secrets_page->svsm_guest_vmpl)
> +               sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_SVSM_VMPL0=
);
> +
> +       vmpl =3D secrets_page->svsm_guest_vmpl;
> +
> +       caa =3D secrets_page->svsm_caa;
> +       if (!PAGE_ALIGNED(caa))
> +               sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_SVSM_CAA);
> +
> +       /*
> +        * The CA is identity mapped when this routine is called, both by=
 the
> +        * decompressor code and the early kernel code.
> +        */
> +       boot_svsm_caa =3D (struct svsm_ca *)caa;
> +       boot_svsm_caa_pa =3D caa;
> +}
> diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
> index b59b09c2f284..64799a04feb4 100644
> --- a/arch/x86/kernel/sev.c
> +++ b/arch/x86/kernel/sev.c
> @@ -135,6 +135,15 @@ struct ghcb_state {
>  static DEFINE_PER_CPU(struct sev_es_runtime_data*, runtime_data);
>  static DEFINE_PER_CPU(struct sev_es_save_area *, sev_vmsa);
>
> +/*
> + * SVSM related information:
> + *   When running under an SVSM, the VMPL that Linux is executing at mus=
t be
> + *   non-zero. The VMPL is therefore used to indicate the presence of an=
 SVSM.
> + */
> +static u8 vmpl __ro_after_init;
> +static struct svsm_ca *boot_svsm_caa __ro_after_init;
> +static u64 boot_svsm_caa_pa __ro_after_init;
> +
>  struct sev_config {
>         __u64 debug             : 1,
>
> @@ -2122,6 +2131,13 @@ bool __head snp_init(struct boot_params *bp)
>
>         setup_cpuid_table(cc_info);
>
> +       /*
> +        * Record the SVSM Calling Area address (CAA) if the guest is not
> +        * running at VMPL0. The CA will be used to communicate with the
> +        * SVSM to perform the SVSM services.
> +        */
> +       setup_svsm_ca(cc_info);
> +
>         /*
>          * The CC blob will be used later to access the secrets page. Cac=
he
>          * it here like the boot kernel does.
> --
> 2.43.2
>
>


--=20
-Dionna Glaze, PhD (she/her)

