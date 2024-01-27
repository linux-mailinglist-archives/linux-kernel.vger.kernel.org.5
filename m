Return-Path: <linux-kernel+bounces-40921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34C8283E7F1
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 01:10:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E1C028FC51
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 00:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22A15630;
	Sat, 27 Jan 2024 00:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1Rq7EpxD"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4B6639
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 00:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706313916; cv=none; b=QA276cq5mk6I8tJdeJBSMMJJpbYVNzPyC5HQaNGf0sn74NENV67iya7YpZkLmbHYSsiNBFNmK2gypzmzuMOP7Uve02c6mdmk3O7rbOnMwrGKVDXmCHwbqnj5MEdO3S+LdhvesE2ftPStyyiC3OLISj5fK4s45rDrnY82orrTvhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706313916; c=relaxed/simple;
	bh=FYhYdTtSAEd0jkuOLe9aCVLBa+4SbXb/SKuhWVmNyHo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WF2B2k8gWYuKZpFffryZ5MVrwdMB9YfpmE1Rx/oIKHxvHx9EeIHlVXg2OsNx1o9o4RWL6smcF4zNfyMWmRD/7CfyXjr26lOe3h7LPUX72XtXP0QivI+wLtLcKTAu2XlODvkq7DNbkzqFZsH0LrcG7fztB3qZ2r047IzTfj9O87M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1Rq7EpxD; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-55c89dbef80so1453a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 16:05:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706313912; x=1706918712; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lQMicfXQImSrKSZ+cQ+QcfRggx7pIyUMxOjAWhKkjGk=;
        b=1Rq7EpxD+/k77CeagT5zRLbYoun2YgbRFiU3m7jZdgybaeQ3Jxz9pTdLu4GRgXCjZr
         C+OI55Qe0NGmw/vJKTqkWjmXvRMPUTUOP0t5cfu8sJzXhLYrWN+ii6I0r4bMpaUS0229
         VW4IydCh00tFoJplgx9TEBZY1orFiu5WRhZSHzBfqcDgOPwZ0BaauxGCmwdWufDClbXt
         YuEG5elNWi8esG6qG/SNcZWE7g5lPaGqEJ0P3VePndANj6sVmuWh+9ShB/KEUTmmW6/w
         IFDfrijIw0zOs9hQAd6/KPxNQK9nt7OWVw0cc6HDeECofbK5CK/ufScCvFG4GdkB6R3r
         2QgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706313912; x=1706918712;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lQMicfXQImSrKSZ+cQ+QcfRggx7pIyUMxOjAWhKkjGk=;
        b=vXWT0LYlezI6B5WQ9M+yjNhIkFFCG8dOVO9k9nru8GEa4HlkJXrn/nIbspJPS5Wvud
         jsP9REVc7NADDgG7+a5vpUZIOXqcFZF0zIFCVXTK0go6jDzisc9JBPjR7kDFeS3NsZra
         my+Si7uubF6cMU68P8mVAGcdRD9ingHO2sokb4QWJQw7wnniqoi7p1vL7MHY6yfQlsxY
         yU5Vxno4tHelkzsnIv5xkDk2WW6TMRMMWCqvMznUKQLA7/YuqmlzwToSl3aeQdMXJo+a
         Sn+Bupyh+NSTVg5t6/v9J8oBPS8tTJG4R0WH2hiJSeImrgaBsLIZBHXmIe6KlAIImCrz
         m42A==
X-Gm-Message-State: AOJu0Yx76hoyCjfYQsDC8hmcNdNDgCaScc5jeszc6uNzm7wiHk1JMIqh
	kDs3KLSHhCSm3Vjc+9WPjA3G36Y77PJ5KTdP6BSR0ToJxP1n55S4uTvbp+HxTqyOX6HFU1p5aho
	72DJyF7tccl+/M6HOJtA+w8viPC1HCRLG9qUC
X-Google-Smtp-Source: AGHT+IGkUGMKZ0buyryDKqet9HVxUBbP+FwRJ5DQc8nq6nDKRqtBif4pVpxcEw3LrWMNC0sOHWp+eaQ9+ax6HjYJCQw=
X-Received: by 2002:a05:6402:5d86:b0:55d:4375:c39c with SMTP id
 if6-20020a0564025d8600b0055d4375c39cmr173797edb.0.1706313912199; Fri, 26 Jan
 2024 16:05:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1706307364.git.thomas.lendacky@amd.com> <98db05934aa2d12e7df4e34ca33309b1aa8c0284.1706307364.git.thomas.lendacky@amd.com>
In-Reply-To: <98db05934aa2d12e7df4e34ca33309b1aa8c0284.1706307364.git.thomas.lendacky@amd.com>
From: Dionna Amalie Glaze <dionnaglaze@google.com>
Date: Fri, 26 Jan 2024 16:05:00 -0800
Message-ID: <CAAH4kHY-K09tMkqDxnrgbH7vW3uvdtZTRfVH0Bysu77YV36AYw@mail.gmail.com>
Subject: Re: [PATCH 01/11] x86/sev: Rename snp_init() in the
 boot/compressed/sev.c file
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Dan Williams <dan.j.williams@intel.com>, Michael Roth <michael.roth@amd.com>, 
	Ashish Kalra <ashish.kalra@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 26, 2024 at 2:16=E2=80=AFPM Tom Lendacky <thomas.lendacky@amd.c=
om> wrote:
>
> The snp_init() function is local to the boot/compressed/sev.c file and is
> not called from outside of the file. Change the name so that it is not
> tied to the function definition in arch/x86/include/asm/sev.h. Move the
> renamed snp_init() and related functions up in the file to avoid having t=
o
> add a forward declaration and make the function static, too.
>
> This will allow the snp_init() function in arch/x86/kernel/sev.c to be
> changed without having to make the same change in boot/compressed/sev.c.
>
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
> ---
>  arch/x86/boot/compressed/sev.c | 162 ++++++++++++++++-----------------
>  1 file changed, 81 insertions(+), 81 deletions(-)
>
> diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/se=
v.c
> index 454acd7a2daf..c3030cfb6484 100644
> --- a/arch/x86/boot/compressed/sev.c
> +++ b/arch/x86/boot/compressed/sev.c
> @@ -405,6 +405,85 @@ void snp_check_features(void)
>         }
>  }
>
> +/* Search for Confidential Computing blob in the EFI config table. */
> +static struct cc_blob_sev_info *find_cc_blob_efi(struct boot_params *bp)
> +{
> +       unsigned long cfg_table_pa;
> +       unsigned int cfg_table_len;
> +       int ret;
> +
> +       ret =3D efi_get_conf_table(bp, &cfg_table_pa, &cfg_table_len);
> +       if (ret)
> +               return NULL;
> +
> +       return (struct cc_blob_sev_info *)efi_find_vendor_table(bp, cfg_t=
able_pa,
> +                                                               cfg_table=
_len,
> +                                                               EFI_CC_BL=
OB_GUID);
> +}
> +
> +/*
> + * Initial set up of SNP relies on information provided by the
> + * Confidential Computing blob, which can be passed to the boot kernel
> + * by firmware/bootloader in the following ways:
> + *
> + * - via an entry in the EFI config table
> + * - via a setup_data structure, as defined by the Linux Boot Protocol
> + *
> + * Scan for the blob in that order.
> + */
> +static struct cc_blob_sev_info *find_cc_blob(struct boot_params *bp)
> +{
> +       struct cc_blob_sev_info *cc_info;
> +
> +       cc_info =3D find_cc_blob_efi(bp);
> +       if (cc_info)
> +               goto found_cc_info;
> +
> +       cc_info =3D find_cc_blob_setup_data(bp);
> +       if (!cc_info)
> +               return NULL;
> +
> +found_cc_info:
> +       if (cc_info->magic !=3D CC_BLOB_SEV_HDR_MAGIC)
> +               sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SNP_UNSUPPORTED);
> +
> +       return cc_info;
> +}
> +
> +/*
> + * Indicate SNP based on presence of SNP-specific CC blob. Subsequent ch=
ecks
> + * will verify the SNP CPUID/MSR bits.
> + */
> +static bool snp_setup(struct boot_params *bp)
> +{
> +       struct cc_blob_sev_info *cc_info;
> +
> +       if (!bp)
> +               return false;
> +
> +       cc_info =3D find_cc_blob(bp);
> +       if (!cc_info)
> +               return false;
> +
> +       /*
> +        * If a SNP-specific Confidential Computing blob is present, then
> +        * firmware/bootloader have indicated SNP support. Verifying this
> +        * involves CPUID checks which will be more reliable if the SNP
> +        * CPUID table is used. See comments over snp_setup_cpuid_table()=
 for
> +        * more details.
> +        */
> +       setup_cpuid_table(cc_info);
> +
> +       /*
> +        * Pass run-time kernel a pointer to CC info via boot_params so E=
FI
> +        * config table doesn't need to be searched again during early st=
artup
> +        * phase.
> +        */
> +       bp->cc_blob_address =3D (u32)(unsigned long)cc_info;
> +
> +       return true;
> +}
> +
>  /*
>   * sev_check_cpu_support - Check for SEV support in the CPU capabilities
>   *
> @@ -455,7 +534,7 @@ void sev_enable(struct boot_params *bp)
>                 bp->cc_blob_address =3D 0;
>
>         /*
> -        * Do an initial SEV capability check before snp_init() which
> +        * Do an initial SEV capability check before snp_setup() which
>          * loads the CPUID page and the same checks afterwards are done
>          * without the hypervisor and are trustworthy.
>          *
> @@ -470,7 +549,7 @@ void sev_enable(struct boot_params *bp)
>          * Setup/preliminary detection of SNP. This will be sanity-checke=
d
>          * against CPUID/MSR values later.
>          */
> -       snp =3D snp_init(bp);
> +       snp =3D snp_setup(bp);
>
>         /* Now repeat the checks with the SNP CPUID table. */
>
> @@ -527,85 +606,6 @@ u64 sev_get_status(void)
>         return m.q;
>  }
>
> -/* Search for Confidential Computing blob in the EFI config table. */
> -static struct cc_blob_sev_info *find_cc_blob_efi(struct boot_params *bp)
> -{
> -       unsigned long cfg_table_pa;
> -       unsigned int cfg_table_len;
> -       int ret;
> -
> -       ret =3D efi_get_conf_table(bp, &cfg_table_pa, &cfg_table_len);
> -       if (ret)
> -               return NULL;
> -
> -       return (struct cc_blob_sev_info *)efi_find_vendor_table(bp, cfg_t=
able_pa,
> -                                                               cfg_table=
_len,
> -                                                               EFI_CC_BL=
OB_GUID);
> -}
> -
> -/*
> - * Initial set up of SNP relies on information provided by the
> - * Confidential Computing blob, which can be passed to the boot kernel
> - * by firmware/bootloader in the following ways:
> - *
> - * - via an entry in the EFI config table
> - * - via a setup_data structure, as defined by the Linux Boot Protocol
> - *
> - * Scan for the blob in that order.
> - */
> -static struct cc_blob_sev_info *find_cc_blob(struct boot_params *bp)
> -{
> -       struct cc_blob_sev_info *cc_info;
> -
> -       cc_info =3D find_cc_blob_efi(bp);
> -       if (cc_info)
> -               goto found_cc_info;
> -
> -       cc_info =3D find_cc_blob_setup_data(bp);
> -       if (!cc_info)
> -               return NULL;
> -
> -found_cc_info:
> -       if (cc_info->magic !=3D CC_BLOB_SEV_HDR_MAGIC)
> -               sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SNP_UNSUPPORTED);
> -
> -       return cc_info;
> -}
> -
> -/*
> - * Indicate SNP based on presence of SNP-specific CC blob. Subsequent ch=
ecks
> - * will verify the SNP CPUID/MSR bits.
> - */
> -bool snp_init(struct boot_params *bp)
> -{
> -       struct cc_blob_sev_info *cc_info;
> -
> -       if (!bp)
> -               return false;
> -
> -       cc_info =3D find_cc_blob(bp);
> -       if (!cc_info)
> -               return false;
> -
> -       /*
> -        * If a SNP-specific Confidential Computing blob is present, then
> -        * firmware/bootloader have indicated SNP support. Verifying this
> -        * involves CPUID checks which will be more reliable if the SNP
> -        * CPUID table is used. See comments over snp_setup_cpuid_table()=
 for
> -        * more details.
> -        */
> -       setup_cpuid_table(cc_info);
> -
> -       /*
> -        * Pass run-time kernel a pointer to CC info via boot_params so E=
FI
> -        * config table doesn't need to be searched again during early st=
artup
> -        * phase.
> -        */
> -       bp->cc_blob_address =3D (u32)(unsigned long)cc_info;
> -
> -       return true;
> -}
> -

Did some kind of whitespace replacement happen accidentally? There's a
lot that isn't changed but the diff is quite big.

>  void sev_prep_identity_maps(unsigned long top_level_pgt)
>  {
>         /*
> --
> 2.42.0
>
>


--=20
-Dionna Glaze, PhD (she/her)

