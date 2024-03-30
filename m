Return-Path: <linux-kernel+bounces-125897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 83F6B892D86
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 22:36:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F08B1B212B2
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 21:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61CE44F88A;
	Sat, 30 Mar 2024 21:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FE2gpGrp"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02684E1D5
	for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 21:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711834554; cv=none; b=b7FLHTh4s5KJyGT/U4EW3C8rUKvo/8XbW15xZoW/Ldj2ZB8F8CXR9RWx0TCo/a98NqmsgnvLyRO7h1Q+ND/K5AkfFYKtNN8lnH9S/HOGTR8dIJ+Y19DfORrgncGvyXDsbD1yRzrgW6lNzkQZGIYg3Wge86P7hO76kHvxfnPeNF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711834554; c=relaxed/simple;
	bh=XGP/bsxmN4UA90jlZmkSiIF6HI+T7qPBdxxu9QCdFjI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uZvh3XkJIn35qzaxDGIlHNhGzRYSCjqfwQz9k78Cz5x4mG0aLHBAolrCiB7Ze9uRoohtZPKvgup+SgEcbrEsrmbsyZ80+rn4kDeCRHbiIvapx4UliYLo6PwJvOaTOtzrbKuROkk6/cjzopwOfYjQBGYlOabniJ2QgL1qeXhasBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FE2gpGrp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711834551;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=R/YdumI8jd8jDImfb7MEXm8pAf+7owyDUrM2XftNAOY=;
	b=FE2gpGrpWlnRIpXbWfocTT4UIYFVk24/FqG5zZimf7CIdtAnU/kIbb074rzBV4VNQquOeb
	eTN3MbKMOVPS2ppvxfoagxAufdAKFn0UfYxkHQz7N30hayElSK0pLcXCFJKreU8cT+hWW4
	70pBRDiWqHLwO0MhAJS60JlSC8hhBTE=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-66-mkNfF_eMO-6IX7-uTbmq-g-1; Sat, 30 Mar 2024 17:35:50 -0400
X-MC-Unique: mkNfF_eMO-6IX7-uTbmq-g-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-515c1948e73so2306242e87.3
        for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 14:35:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711834548; x=1712439348;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R/YdumI8jd8jDImfb7MEXm8pAf+7owyDUrM2XftNAOY=;
        b=XibPL1YT7C7WAHy76R2BNffFmAKXq7tS4GkdU7jlYD5NyTyafk9PfACl7Hn3jFgRov
         Eu/Gt2HDNLI1zhBxauFdOJw7qdJ+IhtQgAHjQCWEP4FfItR4A0ph6qTBh0bsFO8nQCLh
         boJk/wP5IrediBxEvZ0p1MP7BPe6STjykG10jomz1zS84ULjUkvmbBB9W8ArJOkYm2dS
         wepwoevgsr34g16XRpAOviKeYv1JLIMYPU9o4eCgg4n5L/jaI4to02XXlNF4HT1OGQ05
         HNsIgkbEuVI+EyqHiRqeWEmmIy86zclP6cdw6skT9jNOEGwogsGgay2cb6hTap+qh0aO
         Lkug==
X-Forwarded-Encrypted: i=1; AJvYcCUpZGruGvtSL/GRzzb/T9l9NEdlyPXCEPSxQp58gfVW2yTXYs3Fm0An24hPuTNlnIRLdQSrQRaCzpAWGinXnitsZhYQjW/v+HJXwwK6
X-Gm-Message-State: AOJu0YxhKpBvOwa3o7UuzohVTOgan1vevOaRV+MzsvuUCnNUnrNpe/uC
	D+q4iEuOd+EUyRD/EL7daw1o5qU2e2uGqU0A8JAf1JdH8jH52FlXFRnaLRT8uxrZd+Ksr2BjQaX
	NmIKeRvlwGdfC2KaqNeLkTxAV6qmMXN9Ht8GHDfyLF4uXW/q6WkeV5IFucCL/qA==
X-Received: by 2002:ac2:4256:0:b0:515:a5b1:1dd0 with SMTP id m22-20020ac24256000000b00515a5b11dd0mr3175194lfl.55.1711834548712;
        Sat, 30 Mar 2024 14:35:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGtpVK74hYMJQRsbSNAOxNo0vPDNEDLKCnR39FTY23/i2sK1bKLUmtvrUTSb2GUD2WssCJO3g==
X-Received: by 2002:ac2:4256:0:b0:515:a5b1:1dd0 with SMTP id m22-20020ac24256000000b00515a5b11dd0mr3175156lfl.55.1711834548253;
        Sat, 30 Mar 2024 14:35:48 -0700 (PDT)
Received: from [192.168.10.4] ([151.95.49.219])
        by smtp.googlemail.com with ESMTPSA id os26-20020a170906af7a00b00a465b72a1f3sm3494452ejb.85.2024.03.30.14.35.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Mar 2024 14:35:47 -0700 (PDT)
Message-ID: <abbe9937-7e0f-4fbd-be0b-488de07dd56c@redhat.com>
Date: Sat, 30 Mar 2024 22:35:44 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 25/29] KVM: SVM: Add module parameter to enable the
 SEV-SNP
To: Michael Roth <michael.roth@amd.com>, kvm@vger.kernel.org
Cc: linux-coco@lists.linux.dev, linux-mm@kvack.org,
 linux-crypto@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org,
 tglx@linutronix.de, mingo@redhat.com, jroedel@suse.de,
 thomas.lendacky@amd.com, hpa@zytor.com, ardb@kernel.org, seanjc@google.com,
 vkuznets@redhat.com, jmattson@google.com, luto@kernel.org,
 dave.hansen@linux.intel.com, slp@redhat.com, pgonda@google.com,
 peterz@infradead.org, srinivas.pandruvada@linux.intel.com,
 rientjes@google.com, dovmurik@linux.ibm.com, tobin@ibm.com, bp@alien8.de,
 vbabka@suse.cz, kirill@shutemov.name, ak@linux.intel.com,
 tony.luck@intel.com, sathyanarayanan.kuppuswamy@linux.intel.com,
 alpergun@google.com, jarkko@kernel.org, ashish.kalra@amd.com,
 nikunj.dadhania@amd.com, pankaj.gupta@amd.com, liam.merwick@oracle.com,
 Brijesh Singh <brijesh.singh@amd.com>
References: <20240329225835.400662-1-michael.roth@amd.com>
 <20240329225835.400662-26-michael.roth@amd.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20240329225835.400662-26-michael.roth@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/29/24 23:58, Michael Roth wrote:
> From: Brijesh Singh <brijesh.singh@amd.com>
> 
> Add a module parameter than can be used to enable or disable the SEV-SNP
> feature. Now that KVM contains the support for the SNP set the GHCB
> hypervisor feature flag to indicate that SNP is supported.
> 
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>

> ---
>   arch/x86/kvm/svm/sev.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index 3e8de7cb3c89..658116537f3f 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
> @@ -48,7 +48,8 @@ static bool sev_es_enabled = true;
>   module_param_named(sev_es, sev_es_enabled, bool, 0444);
>   
>   /* enable/disable SEV-SNP support */
> -static bool sev_snp_enabled;
> +static bool sev_snp_enabled = true;
> +module_param_named(sev_snp, sev_snp_enabled, bool, 0444);
>   
>   /* enable/disable SEV-ES DebugSwap support */
>   static bool sev_es_debug_swap_enabled = true;


