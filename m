Return-Path: <linux-kernel+bounces-120613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EEBDB88DA42
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 10:29:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BEF11F2854A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 09:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9148133995;
	Wed, 27 Mar 2024 09:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GZH8TjSa"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88CD4524A
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 09:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711531740; cv=none; b=uf22bt4p7KQUf+fuXo7agsPQDyVgx/3GApoAfVwiU3LP3bNoD7EaghDwX/7N2lzBQzqB0uiC6DcM5I1UIPaPZg9f73tDwWvbC/U8cxsJyfRNIN156/gvObaD538bHXr+AX951X0qR9wAhC2ri+2Ed/YKtDP3qMlrvI7LSL/WvLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711531740; c=relaxed/simple;
	bh=SP+ieOG7kcqhtfT5qCXkylTfZF1CPva44sZQSNi570U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AQDv52Nxxwl4/beZudS/jSAZQ3urvPgZjKhoZaC4AQxV49/W6fRzW33teYL8lHjxzsR+pEbIe3zo9C/5y0RbUWhMg4SuT2JjYnWOPQtelP2ptEi4mdpkIp32gMSOh5dywTUj14bacGxfKvvgy/OkQcJ/XTERi2rI7fHBhhW1Ux8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GZH8TjSa; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711531737;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=gwT5H6Iy2GGVhSZ2cEg2hRcUL9ThVqPhdTmqclD7WrY=;
	b=GZH8TjSavmReAJCx9O2oCitUE5aLFK9YwuFTPPBKq1mxRtXj8hFjYQ1IHYiyMzvpQxoOp5
	6gOQPeCv6uNW4IYmk4JEpGFTeMx5TurcD++HDCrf17uqbeO3LFyglo06XoYBFC5A79fSo+
	lNpyzsk67l/vh/6RfmzMfPqOhCF/6Ic=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-0wwKBxkBPO-yJuOetsqqSw-1; Wed, 27 Mar 2024 05:28:55 -0400
X-MC-Unique: 0wwKBxkBPO-yJuOetsqqSw-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-33eca7270ccso309210f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 02:28:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711531734; x=1712136534;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gwT5H6Iy2GGVhSZ2cEg2hRcUL9ThVqPhdTmqclD7WrY=;
        b=lISUwQhSt7FJNR6rIJmKcCT1fJf5xBtt9/45BeWp3Cq5lW7lrqJVV7bebLp7kA3r9N
         ICLhy6LtB89uqu4n/VWq49glgBnfSsl4iIuJvuSqZsYre590upxsryRynQVhpLr2uZHR
         D9rozT6Ttt5H4mlahrABU9QyY4UBOrVkvKd+OITmjuEH6wm1CSc9We6Gheh6YSVIBn7d
         rqeHWfU5D6YctRZTQ9oUertzOHnax5BDCKj4sY509OlibrY8b36u9Mge/0jA6rW40zX6
         uuihrE2rxzXvMcCdvEqA7/JwQ+QLf73Ax7wpyAbwME65CJdzF3OCafHGWz3oqSCblCMs
         wpeg==
X-Forwarded-Encrypted: i=1; AJvYcCVRPVdOhWFkp4HB/Ibc3PqBOddd4PKyEJqlP9nKIAsFE6wC3ZkRXwk7dobVrrlsuoY9XmX/gindgkEHg09PhkNFfOAg4/VfzlnzzSUB
X-Gm-Message-State: AOJu0YyD8tklOLtEu6ummvrXaJ8UPNsNXX+l+o6ka3rz2dOSXQbfvB6t
	nKNZvvG4pZwrweCwPekKoNrhgluOGN2zg4z8pvb5mT+UsExvc/81phxouUrwEGSpENOWN7yaOTT
	hLh7lNkkoDfR7/KJO6/f9IWM4ioi6z6cad1stAWyi30v9CTXMcuwD8jRuFSbnqQ==
X-Received: by 2002:a5d:5229:0:b0:33e:9f3d:6910 with SMTP id i9-20020a5d5229000000b0033e9f3d6910mr3298901wra.31.1711531734531;
        Wed, 27 Mar 2024 02:28:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFGEtIgRDxJJaHt06U7iL+3IecuV8hZtAK1wqDvb64JK30/XFGbqUAIwrmuV6dHoGyb50Getg==
X-Received: by 2002:a5d:5229:0:b0:33e:9f3d:6910 with SMTP id i9-20020a5d5229000000b0033e9f3d6910mr3298863wra.31.1711531734031;
        Wed, 27 Mar 2024 02:28:54 -0700 (PDT)
Received: from ?IPV6:2003:cb:c708:8a00:362b:7e34:a3bc:9ddf? (p200300cbc7088a00362b7e34a3bc9ddf.dip0.t-ipconnect.de. [2003:cb:c708:8a00:362b:7e34:a3bc:9ddf])
        by smtp.gmail.com with ESMTPSA id t15-20020a5d690f000000b0033e95bf4796sm14337193wru.27.2024.03.27.02.28.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Mar 2024 02:28:53 -0700 (PDT)
Message-ID: <6777213f-6273-4942-86be-e712ee5ebd1a@redhat.com>
Date: Wed, 27 Mar 2024 10:28:52 +0100
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
 <7aefa967-43aa-490b-ae0d-7d1455402e89@redhat.com>
 <5c8dbda1-5b89-4599-9bc2-f840e7bc6a74@arm.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <5c8dbda1-5b89-4599-9bc2-f840e7bc6a74@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 26.03.24 17:39, Ryan Roberts wrote:
> On 26/03/2024 16:27, David Hildenbrand wrote:
>> On 15.02.24 13:17, Ryan Roberts wrote:
>>> With the introduction of contpte mapping support for arm64, that
>>> architecture's implementation of ptep_get_lockless() has become very
>>> complex due to the need to gather access and dirty bits from across all
>>> of the ptes in the contpte block. This requires careful implementation
>>> to ensure the returned value is consistent (because its not possible to
>>> read all ptes atomically), but even in the common case when there is no
>>> racing modification, we have to read all ptes, which gives an ~O(n^2)
>>> cost if the core-mm is iterating over a range, and performing a
>>> ptep_get_lockless() on each pte.
>>>
>>> Solve this by introducing ptep_get_lockless_norecency(), which does not
>>> make any guarantees about access and dirty bits. Therefore it can simply
>>> read the single target pte.
>>>
>>> At the same time, convert all call sites that previously used
>>> ptep_get_lockless() but don't care about access and dirty state.
>>>
>>
>> I'd probably split that part off.
> 
> I thought the general guidance was to introduce new APIs in same patch they are
> first used in? If I split this off, I'll have one patch for a new (unused) API,
> then another for the first users.

I don't know what exact guidance there is, but I tend to leave "non 
trivial changes" to separate patches.

Some of the changes here are rather trivial (mm/hugetlb.c), and I agree 
that we can perform them here.

At least the "vmf.orig_pte" looked "non-trivial" to me, thus my comment.

> 
>>
>>> We may want to do something similar for ptep_get() (i.e.
>>> ptep_get_norecency()) in future; it doesn't suffer from the consistency
>>> problem because the PTL serializes it with any modifications, but does
>>> suffer the same O(n^2) cost.
>>>
>>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>>> ---
>>>    include/linux/pgtable.h | 37 ++++++++++++++++++++++++++++++++++---
>>>    kernel/events/core.c    |  2 +-
>>>    mm/hugetlb.c            |  2 +-
>>>    mm/khugepaged.c         |  2 +-
>>>    mm/memory.c             |  2 +-
>>>    mm/swap_state.c         |  2 +-
>>>    mm/swapfile.c           |  2 +-
>>>    7 files changed, 40 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
>>> index a36cf4e124b0..9dd40fdbd825 100644
>>> --- a/include/linux/pgtable.h
>>> +++ b/include/linux/pgtable.h
>>> @@ -528,16 +528,47 @@ static inline pmd_t pmdp_get_lockless(pmd_t *pmdp)
>>>    #endif /* CONFIG_PGTABLE_LEVELS > 2 */
>>>    #endif /* CONFIG_GUP_GET_PXX_LOW_HIGH */
>>>
>>> -/*
>>> - * We require that the PTE can be read atomically.
>>> - */
>>>    #ifndef ptep_get_lockless
>>> +/**
>>> + * ptep_get_lockless - Get a pte without holding the page table lock. Young and
>>> + *                     dirty bits are guaranteed to accurately reflect the state
>>> + *                     of the pte at the time of the call.
>>> + * @ptep: Page table pointer for pte to get.
>>> + *
>>> + * If young and dirty information is not required, use
>>> + * ptep_get_lockless_norecency() which can be faster on some architectures.
>>> + *
>>> + * May be overridden by the architecture; otherwise, implemented using
>>> + * ptep_get(), on the assumption that it is atomic.
>>> + *
>>> + * Context: Any.
>>> + */
>>
>> I think we usually say "Any context.". But I would just do it like idr.h:
>>
>> "Any context. It is safe to call this function without locking in your code."
>>
>> ... but is this true? We really want to say "without page table lock". Because
>> there must be some way to prevent against concurrent page table freeing. For
>> example, GUP-fast disables IRQs, whereby page table freeing code frees using RCU.
> 
> How about:
> 
> "
> Context: Any context that guarrantees the page table can't be freed

s/guarrantees/guarantees/

> concurrently. The page table lock is not required.
> "
> 

Sounds good.

>>
>>>    static inline pte_t ptep_get_lockless(pte_t *ptep)
>>>    {
>>>        return ptep_get(ptep);
>>>    }
>>>    #endif
>>>
>>> +#ifndef ptep_get_lockless_norecency
>>> +/**
>>> + * ptep_get_lockless_norecency - Get a pte without holding the page table lock.
>>> + *                 Young and dirty bits may not be accurate.
>>> + * @ptep: Page table pointer for pte to get.
>>> + *
>>> + * Prefer this over ptep_get_lockless() when young and dirty information is not
>>> + * required since it can be faster on some architectures.
>>> + *
>>> + * May be overridden by the architecture; otherwise, implemented using the more
>>> + * precise ptep_get_lockless().
>>> + *
>>> + * Context: Any.
>>
>> Same comment.
>>
>>> + */
>>> +static inline pte_t ptep_get_lockless_norecency(pte_t *ptep)
>>> +{
>>> +    return ptep_get_lockless(ptep);
>>> +}
>>> +#endif
>>
>> [...]
>>
>>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>>> index 68283e54c899..41dc44eb8454 100644
>>> --- a/mm/hugetlb.c
>>> +++ b/mm/hugetlb.c
>>> @@ -7517,7 +7517,7 @@ pte_t *huge_pte_alloc(struct mm_struct *mm, struct
>>> vm_area_struct *vma,
>>>        }
>>>
>>>        if (pte) {
>>> -        pte_t pteval = ptep_get_lockless(pte);
>>> +        pte_t pteval = ptep_get_lockless_norecency(pte);
>>>
>>>            BUG_ON(pte_present(pteval) && !pte_huge(pteval));
>>>        }
>>> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>>> index 2771fc043b3b..1a6c9ed8237a 100644
>>> --- a/mm/khugepaged.c
>>> +++ b/mm/khugepaged.c
>>> @@ -1019,7 +1019,7 @@ static int __collapse_huge_page_swapin(struct mm_struct
>>> *mm,
>>>                }
>>>            }
>>>
>>> -        vmf.orig_pte = ptep_get_lockless(pte);
>>> +        vmf.orig_pte = ptep_get_lockless_norecency(pte);
>>>            if (!is_swap_pte(vmf.orig_pte))
>>>                continue;
>>
>>
>> Hm, I think you mentioned that we want to be careful with vmf.orig_pte.
> 
> Yeah good point. So I guess this should move to patch 3 (which may be dropped -
> tbd)?
> 

Yes. Or a separate one where you explain in detail why do_swap_page() 
can handle it just fine.

-- 
Cheers,

David / dhildenb


