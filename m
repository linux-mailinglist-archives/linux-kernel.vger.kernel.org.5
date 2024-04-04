Return-Path: <linux-kernel+bounces-131251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21BE889854F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 12:44:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C59C628BCD9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 10:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A863811E0;
	Thu,  4 Apr 2024 10:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Bv72mTSb"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 519E876EEA
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 10:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712227465; cv=none; b=LWKxSP2HRjow1Ppus27c4hxWP1Z2RfCBGBV+en3XEpC4/JTSiS91pryHY/iqPBe7CmYb2WPVpPuhWF4XOdG8lurlXiFdHu6Z9AovNNfeyqS6WScwvRg1v9YMTM0/a4ckWpAJIjJZPAuNPXScFrRQ4aEQOvCp3TxrIzr+I8ECudM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712227465; c=relaxed/simple;
	bh=RTpRJ++cuoX7kRRndNettXfsQK3xiNwup72R1lm1xsQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EUCho5+0v6/171cO7EAA6UvzJafEVNWnNAyI19xM2KA86zwI0SxcLVA6fGdcIoRGE6vBNypWCSHvmgA3WDYoO6PcKl1GRqQIahUsM2N6ukSqSkZ+GZnJydSxBFC0GR8w3S/YGfhbTgI3dt3BdeiSyUhjArj7+FPrwi/bPrJHZco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Bv72mTSb; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a51799456e9so124182066b.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 03:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1712227462; x=1712832262; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M5ks3siscLXEdYweZcTvkShhgELNlj1GZUo+iltrrYc=;
        b=Bv72mTSbtCLrAhwRfl/rdIK6+frb75kP/A8n7QekJ8xKURmorMfTW7M29aqaD0WlJC
         YsIVPs9NScZxjnet/VCKN8ku6w7vvbbyzKRtd0TSfrQVtUuXxZqZfdcSOIxe1lFIyzAm
         lwsSjschGM9ho87YJwI9Z5tmX8iLBL+Iv1hwOKYNe3n0uLm2gI74NvmmtpA7sURRXoT7
         7QNEa7hVU5HT08Nq3+lcQFzbI5lDB8MH8nNEm6W8OcEOUGv/kJwD9jtw5vEqIrEVWhMA
         k+hGjzgpFRySvwb/EGckvBJKgOv914G/s9kdxd5jzKDVbJWfpAJ+ACL1EznMF+XRru2k
         26Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712227462; x=1712832262;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M5ks3siscLXEdYweZcTvkShhgELNlj1GZUo+iltrrYc=;
        b=efQXX37jrKB1u54GuisICNPAlP7H8r9LlvFK4AA3sqnepAn62mwxHL5S/mVVac74VX
         3Hq2pefScCVYs9QVoHHd9pbBkg9JIQ6pYht2ipGRu7Y2CtxS6ChSW2FBfZgy7TlnjzKE
         2EGhaxgPxUJ9v3QJtXOAvt6EC4aGKR40q+lW2nF22wpgOYj+aoWmAvk0Ld+swuVajyjq
         P9rzwf1pSMgF2UmdOKhLrJsHFgvdXsQEIkVKKL/73sJj4LAJB5MHlWvu6cEici29QejD
         YxRU2U4TkW5Nu+OS7N2z2GfbAUuYv2VyFoF2Bbd8HIgp7hfzveXTIYS1NfDDRAxDDQMj
         jIww==
X-Forwarded-Encrypted: i=1; AJvYcCUO+9XaRcsKp9gDQRLxhrGmi13xayv0f7PpqXoc2F9HNHfpmd/8eT61Klpd5HVBXM3fonxUei9KbuYBXfvyfVDr5MqWtMrff1X+MZNl
X-Gm-Message-State: AOJu0Ywd2ywxuBoVQpDCu92iCoiXyYImVfy3b6RU//XZkfXsO+BBrIF6
	DZAnv7rD28K9RByjxQA77PRW/dYt8q7xuPCyKMkWa25lo4wNZ1coMGrWZFC3vXpVqEzJARxyKmh
	NsXM=
X-Google-Smtp-Source: AGHT+IGsqtupzPzE6aRRqqMIWl1LrubuDVEY8C6pHZo+wfARtNu9fvmq4JAxgUukaCOEhy86TsI0AQ==
X-Received: by 2002:a17:907:86a4:b0:a4e:4fc1:1855 with SMTP id qa36-20020a17090786a400b00a4e4fc11855mr1676009ejc.42.1712227461687;
        Thu, 04 Apr 2024 03:44:21 -0700 (PDT)
Received: from ?IPV6:2003:e5:873a:400:704b:6dbb:e7c0:786e? (p200300e5873a0400704b6dbbe7c0786e.dip0.t-ipconnect.de. [2003:e5:873a:400:704b:6dbb:e7c0:786e])
        by smtp.gmail.com with ESMTPSA id p12-20020a1709060dcc00b00a4e32ea1c3asm7944839eji.146.2024.04.04.03.44.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Apr 2024 03:44:21 -0700 (PDT)
Message-ID: <67938940-a7b9-4a75-883e-cc49c6097fcc@suse.com>
Date: Thu, 4 Apr 2024 12:44:20 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] x86/xen: Enumerate NX from CPUID directly
Content-Language: en-US
To: Dave Hansen <dave.hansen@linux.intel.com>, linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de, x86@kernel.org, bp@alien8.de
References: <20240403153508.7328E749@davehans-spike.ostc.intel.com>
 <20240403153514.CC2C9D13@davehans-spike.ostc.intel.com>
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
In-Reply-To: <20240403153514.CC2C9D13@davehans-spike.ostc.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03.04.24 17:35, Dave Hansen wrote:
> From: Dave Hansen <dave.hansen@linux.intel.com>
> 
> xen_start_kernel() is some of the first C code run "Xen PV" systems.

Nit: s/run/run on/

> It precedes things like setup_arch() or processor initialization code
> that would be thought of as "very early".
> 
> That means that 'boot_cpu_data' is garbage.  It has not even
> established the utter basics like if the CPU supports the CPUID
> instruction.  Unfortunately get_cpu_cap() requires this exact
> information.
> 
> Nevertheless, xen_start_kernel() calls get_cpu_cap().  But it
> works out in practice because it's looking for the NX bit which
> comes from an extended CPUID leaf that doesn't depend on
> c->cpuid_level being set.
> 
> Stop calling get_cpu_cap().  Use CPUID directly.  Add a little
> helper to avoid cluttering up the xen_start_kernel() flow.
> 
> This removes the risky, barely-working call to get_cpu_cap().
> 
> Note: The '& 31' strips the "capability" word off of an
>        X86_FEATURE_* value.  It's a magic number, but there are
>        a few of them sparsely scattered around and it's way
>        shorter than any helper.
> 
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Juergen Gross <jgross@suse.com>
> ---
> 
>   b/arch/x86/xen/enlighten_pv.c |   19 ++++++++++++++++---
>   1 file changed, 16 insertions(+), 3 deletions(-)
> 
> diff -puN arch/x86/xen/enlighten_pv.c~xen-explain1 arch/x86/xen/enlighten_pv.c
> --- a/arch/x86/xen/enlighten_pv.c~xen-explain1	2024-04-02 15:23:00.046913557 -0700
> +++ b/arch/x86/xen/enlighten_pv.c	2024-04-02 15:23:00.050913562 -0700
> @@ -1306,6 +1306,21 @@ static void __init xen_domu_set_legacy_f
>   
>   extern void early_xen_iret_patch(void);
>   
> +/*
> + * It is too early for boot_cpu_has() and friends to work.
> + * Use CPUID to directly enumerate NX support.
> + */
> +static inline void xen_configure_nx(void)
> +{
> +	bool nx_supported;
> +	u32 eax = 0;

I'd prefer to name this variable edx.

> +
> +	get_cpuid_region_leaf(0x80000001, CPUID_EDX, &eax);
> +
> +	nx_supported = eax & (X86_FEATURE_NX & 31);
> +	x86_configure_nx(nx_supported);
> +}
> +
>   /* First C function to be called on Xen boot */
>   asmlinkage __visible void __init xen_start_kernel(struct start_info *si)
>   {
> @@ -1369,9 +1384,7 @@ asmlinkage __visible void __init xen_sta
>   	/* Get mfn list */
>   	xen_build_dynamic_phys_to_machine();
>   
> -	/* Work out if we support NX */
> -	get_cpu_cap(&boot_cpu_data);
> -	x86_configure_nx(boot_cpu_has(X86_FEATURE_NX));
> +	xen_configure_nx();
>   
>   	/*
>   	 * Set up kernel GDT and segment registers, mainly so that
> _


Juergen

