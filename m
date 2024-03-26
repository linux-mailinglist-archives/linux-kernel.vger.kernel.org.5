Return-Path: <linux-kernel+bounces-119452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B6C8988C926
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 17:28:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A4C3B27C99
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 16:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E094213C9DE;
	Tue, 26 Mar 2024 16:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jKPDHxZF"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1CC13C91B
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 16:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711470436; cv=none; b=tDAnL7Iva6Cs6jWYDecBZo2lXiv1XR4ZGMM+PVSjam1U+k+Ju9gVmzc9iS8ClVlYrC7vWMHlLlV6cf9HK0RVssV3+WdsvIpHPwB8U8G6S6S7mytRykzKdhLqLpgPCenRRdUs5dVZLOiAhL5nfLrWvxVhhrwDWZXozXgjarJiGik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711470436; c=relaxed/simple;
	bh=YoW0aoRn8AZ3dVmX6jg/AGpCmww8w9hT3eL6pIP4e6w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qez2juGGbfkQTbm2k9jPbObWAcwxaFUfuArjA13hLELBPGg7ibRpZXeoDvrj3y4QHpfRSWm6Wx9e0e06QzM6Psd02TWZSkuA0nUAKfPKpUsnkQl4yM8LWaH6DM85hRiL8t5pASLdc7Y+g//idfAV1a0NmWvNo8Ey6Hg6S2Y9Zjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jKPDHxZF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711470433;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=2JLRqyrMOR/QMRFre/Z3xp+gMGLF/01W0FCR6r9wY9w=;
	b=jKPDHxZFIhnUscLgnoIk4UnWYbLuZZ2coWW3cuT9LUkCLSXs4ESsqhbHCOWhINLiuEhGkQ
	VGjQ8HpgSxEo/IL0foMpWQJBAhazAnFCNLiQKnT/bMYnTUcM1gy7bWay67yNTwgiv4sbZ7
	ADFBd/W6r4M7+LK+MQ3NCZUXtPDf33E=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-265-1HQvQHVNNVyVXa7fmjMCWw-1; Tue, 26 Mar 2024 12:27:11 -0400
X-MC-Unique: 1HQvQHVNNVyVXa7fmjMCWw-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-41485831b2dso20265715e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 09:27:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711470430; x=1712075230;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2JLRqyrMOR/QMRFre/Z3xp+gMGLF/01W0FCR6r9wY9w=;
        b=hV/2dQY9D2OZ20+1GhKWIjiksSrUj1o0aC4ihiEN9dL9mS6KDGkb+vJwj2mfVo2pkV
         I9sEXSrolSzTBklhpggdrgpHw75j00E6kfSp3DNnQ1wPmYXS5DnP6YAFT6DANw9oFwUi
         G7smM4p3pn89Xc8LncKVfo0wXVDIBwKdFMZC9fr1/6M6MPknWF/Wd96X07TV1AZj/nmd
         kRcLjd47W10hyUB1LKAbKR8oms7YyfSGjvWdNydq4am/habKbXfwdULS+pPEqfSreKAd
         OyzvSv3a0Zu4zbKajH3cwcAQzcTU1nuYfTIWLVe9LRe+NgjyrWyl2Gn4dRTRim7ssBCf
         WDpw==
X-Forwarded-Encrypted: i=1; AJvYcCXrmyAnPUzbdsnK9lcgOVYsXQJl6ZbneCeT3oLScqG+NMd4/SUB7nxmOEDSbuvIk9/h1ioxvL9gI4hRGocTbALl6XhX6YmzmklG0ZoQ
X-Gm-Message-State: AOJu0YwhAu4T3RuZRCbsYR8oIx4PAnYkHn7AQs0INsGjREBfh8PXEXZA
	OhVKcexSksJWDV120N71ziaoE00dTWboe2yQgn/86bHhfL7CN2rJSCbnfEBZUsBy+NxA8ilnzR2
	S7WPXdwUxj+ECvoK64D7+8QPvBHCdJ6m1S+DQ78IIaMECbZOvT/9faL9KjdIJfQ==
X-Received: by 2002:a05:600c:46ce:b0:413:f033:e1ee with SMTP id q14-20020a05600c46ce00b00413f033e1eemr77207wmo.9.1711470430261;
        Tue, 26 Mar 2024 09:27:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEzE/jSaaZW8h49l8SkqH3AHF+FZXObFlR1OP8EqX5/8KtInDC4/QKA4XITIy0h3XGz5X7IRA==
X-Received: by 2002:a05:600c:46ce:b0:413:f033:e1ee with SMTP id q14-20020a05600c46ce00b00413f033e1eemr77185wmo.9.1711470429805;
        Tue, 26 Mar 2024 09:27:09 -0700 (PDT)
Received: from ?IPV6:2003:cb:c741:c700:3db9:94c9:28b0:34f2? (p200300cbc741c7003db994c928b034f2.dip0.t-ipconnect.de. [2003:cb:c741:c700:3db9:94c9:28b0:34f2])
        by smtp.gmail.com with ESMTPSA id bx12-20020a5d5b0c000000b0033e45930f35sm2983092wrb.6.2024.03.26.09.27.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Mar 2024 09:27:09 -0700 (PDT)
Message-ID: <7aefa967-43aa-490b-ae0d-7d1455402e89@redhat.com>
Date: Tue, 26 Mar 2024 17:27:08 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 1/4] mm: Introduce ptep_get_lockless_norecency()
Content-Language: en-US
To: Ryan Roberts <ryan.roberts@arm.com>, Mark Rutland <mark.rutland@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Muchun Song <muchun.song@linux.dev>
Cc: linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20240215121756.2734131-1-ryan.roberts@arm.com>
 <20240215121756.2734131-2-ryan.roberts@arm.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240215121756.2734131-2-ryan.roberts@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15.02.24 13:17, Ryan Roberts wrote:
> With the introduction of contpte mapping support for arm64, that
> architecture's implementation of ptep_get_lockless() has become very
> complex due to the need to gather access and dirty bits from across all
> of the ptes in the contpte block. This requires careful implementation
> to ensure the returned value is consistent (because its not possible to
> read all ptes atomically), but even in the common case when there is no
> racing modification, we have to read all ptes, which gives an ~O(n^2)
> cost if the core-mm is iterating over a range, and performing a
> ptep_get_lockless() on each pte.
> 
> Solve this by introducing ptep_get_lockless_norecency(), which does not
> make any guarantees about access and dirty bits. Therefore it can simply
> read the single target pte.
> 
> At the same time, convert all call sites that previously used
> ptep_get_lockless() but don't care about access and dirty state.
> 

I'd probably split that part off.

> We may want to do something similar for ptep_get() (i.e.
> ptep_get_norecency()) in future; it doesn't suffer from the consistency
> problem because the PTL serializes it with any modifications, but does
> suffer the same O(n^2) cost.
> 
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---
>   include/linux/pgtable.h | 37 ++++++++++++++++++++++++++++++++++---
>   kernel/events/core.c    |  2 +-
>   mm/hugetlb.c            |  2 +-
>   mm/khugepaged.c         |  2 +-
>   mm/memory.c             |  2 +-
>   mm/swap_state.c         |  2 +-
>   mm/swapfile.c           |  2 +-
>   7 files changed, 40 insertions(+), 9 deletions(-)
> 
> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> index a36cf4e124b0..9dd40fdbd825 100644
> --- a/include/linux/pgtable.h
> +++ b/include/linux/pgtable.h
> @@ -528,16 +528,47 @@ static inline pmd_t pmdp_get_lockless(pmd_t *pmdp)
>   #endif /* CONFIG_PGTABLE_LEVELS > 2 */
>   #endif /* CONFIG_GUP_GET_PXX_LOW_HIGH */
> 
> -/*
> - * We require that the PTE can be read atomically.
> - */
>   #ifndef ptep_get_lockless
> +/**
> + * ptep_get_lockless - Get a pte without holding the page table lock. Young and
> + *                     dirty bits are guaranteed to accurately reflect the state
> + *                     of the pte at the time of the call.
> + * @ptep: Page table pointer for pte to get.
> + *
> + * If young and dirty information is not required, use
> + * ptep_get_lockless_norecency() which can be faster on some architectures.
> + *
> + * May be overridden by the architecture; otherwise, implemented using
> + * ptep_get(), on the assumption that it is atomic.
> + *
> + * Context: Any.
> + */

I think we usually say "Any context.". But I would just do it like idr.h:

"Any context. It is safe to call this function without locking in your 
code."

.. but is this true? We really want to say "without page table lock". 
Because there must be some way to prevent against concurrent page table 
freeing. For example, GUP-fast disables IRQs, whereby page table freeing 
code frees using RCU.

>   static inline pte_t ptep_get_lockless(pte_t *ptep)
>   {
>   	return ptep_get(ptep);
>   }
>   #endif
> 
> +#ifndef ptep_get_lockless_norecency
> +/**
> + * ptep_get_lockless_norecency - Get a pte without holding the page table lock.
> + *				 Young and dirty bits may not be accurate.
> + * @ptep: Page table pointer for pte to get.
> + *
> + * Prefer this over ptep_get_lockless() when young and dirty information is not
> + * required since it can be faster on some architectures.
> + *
> + * May be overridden by the architecture; otherwise, implemented using the more
> + * precise ptep_get_lockless().
> + *
> + * Context: Any.

Same comment.

> + */
> +static inline pte_t ptep_get_lockless_norecency(pte_t *ptep)
> +{
> +	return ptep_get_lockless(ptep);
> +}
> +#endif

[...]

> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 68283e54c899..41dc44eb8454 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -7517,7 +7517,7 @@ pte_t *huge_pte_alloc(struct mm_struct *mm, struct vm_area_struct *vma,
>   	}
> 
>   	if (pte) {
> -		pte_t pteval = ptep_get_lockless(pte);
> +		pte_t pteval = ptep_get_lockless_norecency(pte);
> 
>   		BUG_ON(pte_present(pteval) && !pte_huge(pteval));
>   	}
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 2771fc043b3b..1a6c9ed8237a 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -1019,7 +1019,7 @@ static int __collapse_huge_page_swapin(struct mm_struct *mm,
>   			}
>   		}
> 
> -		vmf.orig_pte = ptep_get_lockless(pte);
> +		vmf.orig_pte = ptep_get_lockless_norecency(pte);
>   		if (!is_swap_pte(vmf.orig_pte))
>   			continue;


Hm, I think you mentioned that we want to be careful with vmf.orig_pte.

-- 
Cheers,

David / dhildenb


