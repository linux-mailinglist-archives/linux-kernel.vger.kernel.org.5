Return-Path: <linux-kernel+bounces-61532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79681851354
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 13:16:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 224A51F21443
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 12:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6524539AEC;
	Mon, 12 Feb 2024 12:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MWjTPFy8"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0EE539AE3
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 12:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707740071; cv=none; b=AtNcZRxSxxNBDCWeTXKj+jrHSqk2R9gpqNf1fQlL3/P7njPBvSAYQTwrEL4FXH0BDMEKPWhsGO0iNg2v/Jq0sO2g3qVKEomH+BrbJi5+zUi0tXhOlvwRy5CwVI5x2EYJDfCNqEqE0Qdpih4vNaKjiszbRbRKeL5nSJofhk0zC+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707740071; c=relaxed/simple;
	bh=61boOWGHAX7npIXs0W2z0PM+ZzOIKqtd39yP/p1NOqo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BsrhNA/EKdAZdXIvShcBPw4QL9czE9DPBOHEEpxf6j+rPoLjlZHZHLQfb3Q8CxDNbs8+1WeqmN4c3UglDG7c++OIk8fFsU9myI+C/JU7vTM9ZA/KOtmzjAYPD8COejzuZ5+hA/e1VK+c+mH4u6lF3f6LkTkk07ohdnXG+hxP308=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MWjTPFy8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707740068;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=pFmZN5D+FLkUR/TqfEmtJ0sttF3Ny0Zc/N855oN1DmU=;
	b=MWjTPFy8tyOxjDG7G6/KLw5Or3I+bK+qMmv2ZkM+oZly8LDAfKysm6llMixpIpbIGynx5j
	bph+UZX8cJfpPxHT3bJKc+ncRBpRe+5V6LiTsI9Agg7RNP7YYydxcaVxas1HSe+lUdh7SJ
	3aovxi/UTR3e1+fMzMi2ustUDRUMy44=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-d_mpaUmYOLywFy8PyYEFHA-1; Mon, 12 Feb 2024 07:14:27 -0500
X-MC-Unique: d_mpaUmYOLywFy8PyYEFHA-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-5117bac8b0cso2121551e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 04:14:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707740065; x=1708344865;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pFmZN5D+FLkUR/TqfEmtJ0sttF3Ny0Zc/N855oN1DmU=;
        b=ED7utruF+xzAWjZFY5i4F5GzTLxmj6cajn/FN++y1kqZeP/tbBwrFBy5q26MO8JNoi
         4oXlk7TPcQ4X0Rv/b7NBecDJbmPfo+9vrQvicKibhW2f4vMszhp09O0dm2/p3maWj55g
         5hs8kkMTIJ3xIQ54F22o58aALq/zuWwiCJLYOYF/9Tg5J94EXFt9da4vOZkiWHaPVE4R
         VJ21tBFeTXK2HiPNSIEi9At3A+eAvq49XtoK62eRF7T3MiPSyBcAiX24y6uxweuKa5Cb
         epCK5d17+6Q2tgbUnSYPuWK9Gyr2tnOqiB9UEqYm3DuHN8jE04zENJjF5fKV4QlZMY4d
         xJeg==
X-Forwarded-Encrypted: i=1; AJvYcCWa/6x8n7NVGJUkiAz58cZ0ZG4iJ1AHx9SSi6X6OQNd4pg6SCMC+4/tkQzkWG2sXRLYuxXUSF1csrfTJOhxAJnynfdxg7v3A0yBn2qM
X-Gm-Message-State: AOJu0YwqGgr9pN2JxOudzuI5ctkO3oAi3okHwXF8T+SfyXhafG6JLEIC
	W0ztPLHdPWLp1oCIxxFnwGu3JqSLZjTtgYvYUuCm1tq4FdkNtH8CGjr8/L9IS7enlEOZS07y3jk
	B2K6dA+vHQ6pSNtZiybsLR3weZJKtA+qcsgJ3cQ8YXRNZR+o7Hccm36EuVHlMjA==
X-Received: by 2002:a05:6512:39c9:b0:511:751c:7e8f with SMTP id k9-20020a05651239c900b00511751c7e8fmr4678240lfu.20.1707740065660;
        Mon, 12 Feb 2024 04:14:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEfvRMFMBzLv20u7RK1sffSKRqvL876q4EvpSF1avR8GYZmBmJqkptYtg77nabHSr6SBVyRxw==
X-Received: by 2002:a05:6512:39c9:b0:511:751c:7e8f with SMTP id k9-20020a05651239c900b00511751c7e8fmr4678188lfu.20.1707740065123;
        Mon, 12 Feb 2024 04:14:25 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWin1JcrzkSHrzXWn9NgERU1bRLCGCJmSYsfWUE1Od2oRRe6X1Bvd7ng1cs1dC1WVKDTfFn08/VMnSZDG0Mvx2X9Det59j0bGx41Nv6uj4UY71dgUvdLRhV/SLXp8xFc/1teR4RCtNkBRrYFgWZNNxvmID3326dbEcsOqwzumRnQSASEI0wYBi3PEBSNoStgvtbyNeWpzzBlvqkYjbOzoUJdBHvHBdeAE8jIgKcJ4qW+LRY4kwh+gPsVsss6PU97R866f2R/IragU//+z3eijNEkM4+n+ZwADmS4jvU73NJ6mauZui+QlX+jSe6Ld+T0AFs/rrQn2zAxWYBqlz2nP3FdPsIHwitRXQtN/UyzXyMc+BQ1Oo3cSkXtrs6M9HxVxzi2g+gv57LWHD7XVsOCOvDdnTPdZPN7crMZ5WWohiyyi5k2aPOQcdjFtRFEgqXzoBgVA/6Up29knbYbxje4Eixf96iuwaJ7GQ64S+z5+ZdNLu+18nTjDhfMFZmvmnzham9cxa9/U/rcUdRx7xvi4RlYlXqEsy/DvCBpFrYzMRt92NmvkQl+g6hKDXwxTW5UzlcKKixMaS7fHzEosfl3q9nm6SUk59RdzfOSew7Y0gd2RuNurV5j9tzuvBWCB9ssXeiUjyoBhdUdtmGFuDZns7usjCkgDVTh9DfBhJITZKUh/X1zE2EXw1wz6bxdZlIynR7grKLrWEOZSI6GNLC7V0CdBVdRj6xytotCrTVH+cH5HyAu49HNHbH3180mcDDx0blzsXmgJmMj+Tob6Qn9zURZdCxFwJyNUy3qVRJvuyBXiPOWzFDsu/v+s3j5AnAITgoS9mHgQFC0KqfiMwsEAbut24ZL93SsLjpsEcfCPte
Received: from ?IPV6:2003:cb:c730:2200:7229:83b1:524e:283a? (p200300cbc7302200722983b1524e283a.dip0.t-ipconnect.de. [2003:cb:c730:2200:7229:83b1:524e:283a])
        by smtp.gmail.com with ESMTPSA id g8-20020a05600c310800b00410cfc34260sm3105364wmo.2.2024.02.12.04.14.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Feb 2024 04:14:24 -0800 (PST)
Message-ID: <c269c2e0-afca-4ff0-8ffd-9049fb52c905@redhat.com>
Date: Mon, 12 Feb 2024 13:14:23 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 03/25] mm: Make pte_next_pfn() a wrapper around
 pte_advance_pfn()
Content-Language: en-US
To: Ryan Roberts <ryan.roberts@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Ard Biesheuvel <ardb@kernel.org>, Marc Zyngier <maz@kernel.org>,
 James Morse <james.morse@arm.com>, Andrey Ryabinin <ryabinin.a.a@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>, Mark Rutland <mark.rutland@arm.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>, John Hubbard
 <jhubbard@nvidia.com>, Zi Yan <ziy@nvidia.com>,
 Barry Song <21cnbao@gmail.com>, Alistair Popple <apopple@nvidia.com>,
 Yang Shi <shy828301@gmail.com>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
 "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-arm-kernel@lists.infradead.org, x86@kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20240202080756.1453939-1-ryan.roberts@arm.com>
 <20240202080756.1453939-4-ryan.roberts@arm.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240202080756.1453939-4-ryan.roberts@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02.02.24 09:07, Ryan Roberts wrote:
> The goal is to be able to advance a PTE by an arbitrary number of PFNs.
> So introduce a new API that takes a nr param.
> 
> We are going to remove pte_next_pfn() and replace it with
> pte_advance_pfn(). As a first step, implement pte_next_pfn() as a
> wrapper around pte_advance_pfn() so that we can incrementally switch the
> architectures over. Once all arches are moved over, we will change all
> the core-mm callers to call pte_advance_pfn() directly and remove the
> wrapper.
> 
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---
>   include/linux/pgtable.h | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> index 5e7eaf8f2b97..815d92dcb96b 100644
> --- a/include/linux/pgtable.h
> +++ b/include/linux/pgtable.h
> @@ -214,9 +214,15 @@ static inline int pmd_dirty(pmd_t pmd)
>   
>   
>   #ifndef pte_next_pfn
> +#ifndef pte_advance_pfn
> +static inline pte_t pte_advance_pfn(pte_t pte, unsigned long nr)
> +{
> +	return __pte(pte_val(pte) + (nr << PFN_PTE_SHIFT));
> +}
> +#endif
>   static inline pte_t pte_next_pfn(pte_t pte)
>   {
> -	return __pte(pte_val(pte) + (1UL << PFN_PTE_SHIFT));
> +	return pte_advance_pfn(pte, 1);
>   }
>   #endif
>   

I do wonder if we simply want to leave pte_next_pfn() around? Especially 
patch #4, #6 don't really benefit from the change? So are the other 
set_ptes() implementations.

That is, only convert all pte_next_pfn()->pte_advance_pfn(), and leave a
pte_next_pfn() macro in place.

Any downsides to that? This patch here would become:

#ifndef pte_advance_pfn
static inline pte_t pte_advance_pfn(pte_t pte, unsigned long nr)
{
	return __pte(pte_val(pte) + (nr << PFN_PTE_SHIFT));
}
#endif

#ifndef pte_next_pfn
#define pte_next_pfn(pte) pte_advance_pfn(pte, 1)
#endif

As you convert the three arches, make them define pte_advance_pfn and 
udnefine pte_next_pfn. in the end, you can drop the #ifdef around 
pte_next_pfn here.

-- 
Cheers,

David / dhildenb


