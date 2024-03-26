Return-Path: <linux-kernel+bounces-119484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A10F088C987
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 17:39:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C44D21C638C4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 16:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFFCB12E75;
	Tue, 26 Mar 2024 16:39:30 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93614A95B
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 16:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711471170; cv=none; b=A8r7MBxuG/fjAy5xK67JoV+D/R5Ou2fqYYEqrUpUd/MHW1msAliB3ffsJWQbANEkJMnKnSF5wFq8+bzTiACrSex8z6DuKxCUMGluycLhvsHaf5HAihj71CH3IEAPJIbikIBjrgQCadco1x7E8bKiLifY9KTk4V0DZcg6foWUf70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711471170; c=relaxed/simple;
	bh=FsMsi5WEadzmO1ggq4lQ3vz6onhA84SOEoHz7v4Ckjw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZcOziFa3HaACgKPtoG+diGE8NrY5lrLEY8PYRZuAqCYNbbnMgzPQnQO/ntgyDR6RPGpcua38smP8A81w2W96bQfTJF2UIyYgK1oTg6JMUM0GOYy/0Ls26BLWZcxbwzZOlao2NhI4/uDyStb3Uyizn1GzgnLQBWlBTQew7SiTzXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A25F52F4;
	Tue, 26 Mar 2024 09:40:01 -0700 (PDT)
Received: from [10.1.29.179] (XHFQ2J9959.cambridge.arm.com [10.1.29.179])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DB1733F694;
	Tue, 26 Mar 2024 09:39:25 -0700 (PDT)
Message-ID: <5c8dbda1-5b89-4599-9bc2-f840e7bc6a74@arm.com>
Date: Tue, 26 Mar 2024 16:39:24 +0000
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
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <7aefa967-43aa-490b-ae0d-7d1455402e89@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 26/03/2024 16:27, David Hildenbrand wrote:
> On 15.02.24 13:17, Ryan Roberts wrote:
>> With the introduction of contpte mapping support for arm64, that
>> architecture's implementation of ptep_get_lockless() has become very
>> complex due to the need to gather access and dirty bits from across all
>> of the ptes in the contpte block. This requires careful implementation
>> to ensure the returned value is consistent (because its not possible to
>> read all ptes atomically), but even in the common case when there is no
>> racing modification, we have to read all ptes, which gives an ~O(n^2)
>> cost if the core-mm is iterating over a range, and performing a
>> ptep_get_lockless() on each pte.
>>
>> Solve this by introducing ptep_get_lockless_norecency(), which does not
>> make any guarantees about access and dirty bits. Therefore it can simply
>> read the single target pte.
>>
>> At the same time, convert all call sites that previously used
>> ptep_get_lockless() but don't care about access and dirty state.
>>
> 
> I'd probably split that part off.

I thought the general guidance was to introduce new APIs in same patch they are
first used in? If I split this off, I'll have one patch for a new (unused) API,
then another for the first users.

> 
>> We may want to do something similar for ptep_get() (i.e.
>> ptep_get_norecency()) in future; it doesn't suffer from the consistency
>> problem because the PTL serializes it with any modifications, but does
>> suffer the same O(n^2) cost.
>>
>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>> ---
>>   include/linux/pgtable.h | 37 ++++++++++++++++++++++++++++++++++---
>>   kernel/events/core.c    |  2 +-
>>   mm/hugetlb.c            |  2 +-
>>   mm/khugepaged.c         |  2 +-
>>   mm/memory.c             |  2 +-
>>   mm/swap_state.c         |  2 +-
>>   mm/swapfile.c           |  2 +-
>>   7 files changed, 40 insertions(+), 9 deletions(-)
>>
>> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
>> index a36cf4e124b0..9dd40fdbd825 100644
>> --- a/include/linux/pgtable.h
>> +++ b/include/linux/pgtable.h
>> @@ -528,16 +528,47 @@ static inline pmd_t pmdp_get_lockless(pmd_t *pmdp)
>>   #endif /* CONFIG_PGTABLE_LEVELS > 2 */
>>   #endif /* CONFIG_GUP_GET_PXX_LOW_HIGH */
>>
>> -/*
>> - * We require that the PTE can be read atomically.
>> - */
>>   #ifndef ptep_get_lockless
>> +/**
>> + * ptep_get_lockless - Get a pte without holding the page table lock. Young and
>> + *                     dirty bits are guaranteed to accurately reflect the state
>> + *                     of the pte at the time of the call.
>> + * @ptep: Page table pointer for pte to get.
>> + *
>> + * If young and dirty information is not required, use
>> + * ptep_get_lockless_norecency() which can be faster on some architectures.
>> + *
>> + * May be overridden by the architecture; otherwise, implemented using
>> + * ptep_get(), on the assumption that it is atomic.
>> + *
>> + * Context: Any.
>> + */
> 
> I think we usually say "Any context.". But I would just do it like idr.h:
> 
> "Any context. It is safe to call this function without locking in your code."
> 
> ... but is this true? We really want to say "without page table lock". Because
> there must be some way to prevent against concurrent page table freeing. For
> example, GUP-fast disables IRQs, whereby page table freeing code frees using RCU.

How about:

"
Context: Any context that guarrantees the page table can't be freed
concurrently. The page table lock is not required.
"

> 
>>   static inline pte_t ptep_get_lockless(pte_t *ptep)
>>   {
>>       return ptep_get(ptep);
>>   }
>>   #endif
>>
>> +#ifndef ptep_get_lockless_norecency
>> +/**
>> + * ptep_get_lockless_norecency - Get a pte without holding the page table lock.
>> + *                 Young and dirty bits may not be accurate.
>> + * @ptep: Page table pointer for pte to get.
>> + *
>> + * Prefer this over ptep_get_lockless() when young and dirty information is not
>> + * required since it can be faster on some architectures.
>> + *
>> + * May be overridden by the architecture; otherwise, implemented using the more
>> + * precise ptep_get_lockless().
>> + *
>> + * Context: Any.
> 
> Same comment.
> 
>> + */
>> +static inline pte_t ptep_get_lockless_norecency(pte_t *ptep)
>> +{
>> +    return ptep_get_lockless(ptep);
>> +}
>> +#endif
> 
> [...]
> 
>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>> index 68283e54c899..41dc44eb8454 100644
>> --- a/mm/hugetlb.c
>> +++ b/mm/hugetlb.c
>> @@ -7517,7 +7517,7 @@ pte_t *huge_pte_alloc(struct mm_struct *mm, struct
>> vm_area_struct *vma,
>>       }
>>
>>       if (pte) {
>> -        pte_t pteval = ptep_get_lockless(pte);
>> +        pte_t pteval = ptep_get_lockless_norecency(pte);
>>
>>           BUG_ON(pte_present(pteval) && !pte_huge(pteval));
>>       }
>> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>> index 2771fc043b3b..1a6c9ed8237a 100644
>> --- a/mm/khugepaged.c
>> +++ b/mm/khugepaged.c
>> @@ -1019,7 +1019,7 @@ static int __collapse_huge_page_swapin(struct mm_struct
>> *mm,
>>               }
>>           }
>>
>> -        vmf.orig_pte = ptep_get_lockless(pte);
>> +        vmf.orig_pte = ptep_get_lockless_norecency(pte);
>>           if (!is_swap_pte(vmf.orig_pte))
>>               continue;
> 
> 
> Hm, I think you mentioned that we want to be careful with vmf.orig_pte.

Yeah good point. So I guess this should move to patch 3 (which may be dropped -
tbd)?

