Return-Path: <linux-kernel+bounces-120636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7669188DAB5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 10:58:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E67521F29608
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 09:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEDA14CE00;
	Wed, 27 Mar 2024 09:57:54 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B30046B98
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 09:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711533474; cv=none; b=Lp2+2h838XPe1hrYcLOZYis39lG6FqC3wGrMGEG5BBuDbPSIvaToCf9coiy6XMM3T5zhHaF2t7bvWvEQdtxc3hHI3T9/6Vl+U4KDQoo3D0A9GFCnn1y9hKX6ZbzjBWmgTSnBS58pXaLUZ/XJhcZREhmtUKLP5LgswOnVCxjc9vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711533474; c=relaxed/simple;
	bh=Z7Wf6MWiUeVWlM5iEZYz82Frmj/hNcbLCH9uRArYPao=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GwzPukClz1cvEbBsMU1aFZWmgrYCFDphyTqqGpgS4PMWoOEzkPhmShEpKFvFCiFZjL/fuWnjhlBbd2j8ibzFNcOlOh9iu+KfmQre4IKbh16/NX3kDul3t9Odk2FxEn4++lAq6kLpyWHD7z6giRN6xdbauJ6cJVGmZMDrWw/9ZPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6DCE52F4;
	Wed, 27 Mar 2024 02:58:24 -0700 (PDT)
Received: from [10.57.72.121] (unknown [10.57.72.121])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5E30A3F694;
	Wed, 27 Mar 2024 02:57:47 -0700 (PDT)
Message-ID: <31b903f8-99dd-4790-8338-f4b9950b1ee6@arm.com>
Date: Wed, 27 Mar 2024 09:57:45 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 1/4] mm: Introduce ptep_get_lockless_norecency()
Content-Language: en-GB
To: David Hildenbrand <david@redhat.com>, Mark Rutland
 <mark.rutland@arm.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>,
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
 <6777213f-6273-4942-86be-e712ee5ebd1a@redhat.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <6777213f-6273-4942-86be-e712ee5ebd1a@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 27/03/2024 09:28, David Hildenbrand wrote:
> On 26.03.24 17:39, Ryan Roberts wrote:
>> On 26/03/2024 16:27, David Hildenbrand wrote:
>>> On 15.02.24 13:17, Ryan Roberts wrote:
>>>> With the introduction of contpte mapping support for arm64, that
>>>> architecture's implementation of ptep_get_lockless() has become very
>>>> complex due to the need to gather access and dirty bits from across all
>>>> of the ptes in the contpte block. This requires careful implementation
>>>> to ensure the returned value is consistent (because its not possible to
>>>> read all ptes atomically), but even in the common case when there is no
>>>> racing modification, we have to read all ptes, which gives an ~O(n^2)
>>>> cost if the core-mm is iterating over a range, and performing a
>>>> ptep_get_lockless() on each pte.
>>>>
>>>> Solve this by introducing ptep_get_lockless_norecency(), which does not
>>>> make any guarantees about access and dirty bits. Therefore it can simply
>>>> read the single target pte.
>>>>
>>>> At the same time, convert all call sites that previously used
>>>> ptep_get_lockless() but don't care about access and dirty state.
>>>>
>>>
>>> I'd probably split that part off.
>>
>> I thought the general guidance was to introduce new APIs in same patch they are
>> first used in? If I split this off, I'll have one patch for a new (unused) API,
>> then another for the first users.
> 
> I don't know what exact guidance there is, but I tend to leave "non trivial
> changes" to separate patches.
> 
> Some of the changes here are rather trivial (mm/hugetlb.c), and I agree that we
> can perform them here.
> 
> At least the "vmf.orig_pte" looked "non-trivial" to me, thus my comment.

got it.


> 
>>
>>>
>>>> We may want to do something similar for ptep_get() (i.e.
>>>> ptep_get_norecency()) in future; it doesn't suffer from the consistency
>>>> problem because the PTL serializes it with any modifications, but does
>>>> suffer the same O(n^2) cost.
>>>>
>>>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>>>> ---
>>>>    include/linux/pgtable.h | 37 ++++++++++++++++++++++++++++++++++---
>>>>    kernel/events/core.c    |  2 +-
>>>>    mm/hugetlb.c            |  2 +-
>>>>    mm/khugepaged.c         |  2 +-
>>>>    mm/memory.c             |  2 +-
>>>>    mm/swap_state.c         |  2 +-
>>>>    mm/swapfile.c           |  2 +-
>>>>    7 files changed, 40 insertions(+), 9 deletions(-)
>>>>
>>>> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
>>>> index a36cf4e124b0..9dd40fdbd825 100644
>>>> --- a/include/linux/pgtable.h
>>>> +++ b/include/linux/pgtable.h
>>>> @@ -528,16 +528,47 @@ static inline pmd_t pmdp_get_lockless(pmd_t *pmdp)
>>>>    #endif /* CONFIG_PGTABLE_LEVELS > 2 */
>>>>    #endif /* CONFIG_GUP_GET_PXX_LOW_HIGH */
>>>>
>>>> -/*
>>>> - * We require that the PTE can be read atomically.
>>>> - */
>>>>    #ifndef ptep_get_lockless
>>>> +/**
>>>> + * ptep_get_lockless - Get a pte without holding the page table lock. Young
>>>> and
>>>> + *                     dirty bits are guaranteed to accurately reflect the
>>>> state
>>>> + *                     of the pte at the time of the call.
>>>> + * @ptep: Page table pointer for pte to get.
>>>> + *
>>>> + * If young and dirty information is not required, use
>>>> + * ptep_get_lockless_norecency() which can be faster on some architectures.
>>>> + *
>>>> + * May be overridden by the architecture; otherwise, implemented using
>>>> + * ptep_get(), on the assumption that it is atomic.
>>>> + *
>>>> + * Context: Any.
>>>> + */
>>>
>>> I think we usually say "Any context.". But I would just do it like idr.h:
>>>
>>> "Any context. It is safe to call this function without locking in your code."
>>>
>>> ... but is this true? We really want to say "without page table lock". Because
>>> there must be some way to prevent against concurrent page table freeing. For
>>> example, GUP-fast disables IRQs, whereby page table freeing code frees using
>>> RCU.
>>
>> How about:
>>
>> "
>> Context: Any context that guarrantees the page table can't be freed
> 
> s/guarrantees/guarantees/
> 
>> concurrently. The page table lock is not required.
>> "
>>
> 
> Sounds good.

Great!

> 
>>>
>>>>    static inline pte_t ptep_get_lockless(pte_t *ptep)
>>>>    {
>>>>        return ptep_get(ptep);
>>>>    }
>>>>    #endif
>>>>
>>>> +#ifndef ptep_get_lockless_norecency
>>>> +/**
>>>> + * ptep_get_lockless_norecency - Get a pte without holding the page table
>>>> lock.
>>>> + *                 Young and dirty bits may not be accurate.
>>>> + * @ptep: Page table pointer for pte to get.
>>>> + *
>>>> + * Prefer this over ptep_get_lockless() when young and dirty information is
>>>> not
>>>> + * required since it can be faster on some architectures.
>>>> + *
>>>> + * May be overridden by the architecture; otherwise, implemented using the
>>>> more
>>>> + * precise ptep_get_lockless().
>>>> + *
>>>> + * Context: Any.
>>>
>>> Same comment.
>>>
>>>> + */
>>>> +static inline pte_t ptep_get_lockless_norecency(pte_t *ptep)
>>>> +{
>>>> +    return ptep_get_lockless(ptep);
>>>> +}
>>>> +#endif
>>>
>>> [...]
>>>
>>>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>>>> index 68283e54c899..41dc44eb8454 100644
>>>> --- a/mm/hugetlb.c
>>>> +++ b/mm/hugetlb.c
>>>> @@ -7517,7 +7517,7 @@ pte_t *huge_pte_alloc(struct mm_struct *mm, struct
>>>> vm_area_struct *vma,
>>>>        }
>>>>
>>>>        if (pte) {
>>>> -        pte_t pteval = ptep_get_lockless(pte);
>>>> +        pte_t pteval = ptep_get_lockless_norecency(pte);
>>>>
>>>>            BUG_ON(pte_present(pteval) && !pte_huge(pteval));
>>>>        }
>>>> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>>>> index 2771fc043b3b..1a6c9ed8237a 100644
>>>> --- a/mm/khugepaged.c
>>>> +++ b/mm/khugepaged.c
>>>> @@ -1019,7 +1019,7 @@ static int __collapse_huge_page_swapin(struct mm_struct
>>>> *mm,
>>>>                }
>>>>            }
>>>>
>>>> -        vmf.orig_pte = ptep_get_lockless(pte);
>>>> +        vmf.orig_pte = ptep_get_lockless_norecency(pte);
>>>>            if (!is_swap_pte(vmf.orig_pte))
>>>>                continue;
>>>
>>>
>>> Hm, I think you mentioned that we want to be careful with vmf.orig_pte.
>>
>> Yeah good point. So I guess this should move to patch 3 (which may be dropped -
>> tbd)?
>>
> 
> Yes. Or a separate one where you explain in detail why do_swap_page() can handle
> it just fine.

Ahh no wait - I remember now; the reason I believe this is a "trivial" case is
because we only leak vmf.orig_pte to the rest of the world if its a swap entry.
And if its a swap entry, then ptep_get_lockless_norecency() is equivalent to
ptep_get_lockless() - the pte is not present so there are no access or dirty
bits. So I think this can stay here?


