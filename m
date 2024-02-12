Return-Path: <linux-kernel+bounces-61917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12DD5851861
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 16:48:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 369131C21C66
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 15:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D49493CF45;
	Mon, 12 Feb 2024 15:47:55 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B03092AF1C
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 15:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707752875; cv=none; b=h/ojHNMBL28bzoPBe/2+iRqzsah+49a1vD7sMjoD7mu/i0pV9pX2DR/431r5CeFBAQqQ1su5p63xx0AxCisHkYWEWxJSyT9/mwVknqHafBiyCxp3NcUZH2JPoDGwArtqCNbs5XnhOM57x3Pqjh3e9ed097jHlSiIdwWhAem+z8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707752875; c=relaxed/simple;
	bh=9MqK7E8FB3NGz7M56N0HaUnBr6KDzZ40kKRNBHw8PkM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MiXLiyHrP8jq2UH5tFb7lnmGuCxgyf1xKHNGZqiuxETUa9z9kvC4FdsRakl8EvSyeJOhte1bYKhRad5dZSDD5+vnJVWMIKUHkO6g+g3t3LBULZaQfJU3+l/lmyJ5v8K8qGOeQy8e68yPqv3etsv+uRxsiP6mvDheF1CLzxNEUXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 526FBDA7;
	Mon, 12 Feb 2024 07:48:33 -0800 (PST)
Received: from [10.57.78.115] (unknown [10.57.78.115])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4BF323F766;
	Mon, 12 Feb 2024 07:47:46 -0800 (PST)
Message-ID: <82c59a7f-328e-4521-8855-ccacc3dc4ce5@arm.com>
Date: Mon, 12 Feb 2024 15:47:44 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 22/25] mm: Add pte_batch_hint() to reduce scanning in
 folio_pte_batch()
Content-Language: en-GB
To: David Hildenbrand <david@redhat.com>,
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
 <20240202080756.1453939-23-ryan.roberts@arm.com>
 <6d452a1a-1edc-4e97-8b39-99dc48315bb8@redhat.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <6d452a1a-1edc-4e97-8b39-99dc48315bb8@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 12/02/2024 13:43, David Hildenbrand wrote:
> On 02.02.24 09:07, Ryan Roberts wrote:
>> Some architectures (e.g. arm64) can tell from looking at a pte, if some
>> follow-on ptes also map contiguous physical memory with the same pgprot.
>> (for arm64, these are contpte mappings).
>>
>> Take advantage of this knowledge to optimize folio_pte_batch() so that
>> it can skip these ptes when scanning to create a batch. By default, if
>> an arch does not opt-in, folio_pte_batch() returns a compile-time 1, so
>> the changes are optimized out and the behaviour is as before.
>>
>> arm64 will opt-in to providing this hint in the next patch, which will
>> greatly reduce the cost of ptep_get() when scanning a range of contptes.
>>
>> Tested-by: John Hubbard <jhubbard@nvidia.com>
>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>> ---
>>   include/linux/pgtable.h | 18 ++++++++++++++++++
>>   mm/memory.c             | 20 +++++++++++++-------
>>   2 files changed, 31 insertions(+), 7 deletions(-)
>>
>> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
>> index 50f32cccbd92..cba31f177d27 100644
>> --- a/include/linux/pgtable.h
>> +++ b/include/linux/pgtable.h
>> @@ -212,6 +212,24 @@ static inline int pmd_dirty(pmd_t pmd)
>>   #define arch_flush_lazy_mmu_mode()    do {} while (0)
>>   #endif
>>   +#ifndef pte_batch_hint
>> +/**
>> + * pte_batch_hint - Number of pages that can be added to batch without scanning.
>> + * @ptep: Page table pointer for the entry.
>> + * @pte: Page table entry.
>> + *
>> + * Some architectures know that a set of contiguous ptes all map the same
>> + * contiguous memory with the same permissions. In this case, it can provide a
>> + * hint to aid pte batching without the core code needing to scan every pte.
> 
> I think we might want to document here the expectation regarding
> dirty/accessed bits. folio_pte_batch() will ignore dirty bits only with
> FPB_IGNORE_DIRTY. But especially for arm64, it makes sense to ignore them
> always when batching, because the dirty bit may target any pte part of the
> cont-pte group either way.
> 
> Maybe something like:
> 
> "
> An architecture implementation may only ignore the PTE accessed and dirty bits.
> Further, it may only ignore the dirty bit if that bit is already not
> maintained with precision per PTE inside the hinted batch, and ptep_get()
> would already have to collect it from various PTEs.
> "

I'm proposing to simplify this to:

"
An architecture implementation may ignore the PTE accessed state. Further, the
dirty state must apply atomically to all the PTEs described by the hint.
"

Which I think more accurately describes the requirement. Shout if you disagree.

> 
> I think there are some more details to it, but I'm hoping something along
> the lines above is sufficient.
> 
> 
>> +
>>   #ifndef pte_advance_pfn
>>   static inline pte_t pte_advance_pfn(pte_t pte, unsigned long nr)
>>   {
>> diff --git a/mm/memory.c b/mm/memory.c
>> index 65fbe4f886c1..902665b27702 100644
>> --- a/mm/memory.c
>> +++ b/mm/memory.c
>> @@ -988,16 +988,21 @@ static inline int folio_pte_batch(struct folio *folio,
>> unsigned long addr,
>>   {
>>       unsigned long folio_end_pfn = folio_pfn(folio) + folio_nr_pages(folio);
>>       const pte_t *end_ptep = start_ptep + max_nr;
>> -    pte_t expected_pte = __pte_batch_clear_ignored(pte_advance_pfn(pte, 1),
>> flags);
>> -    pte_t *ptep = start_ptep + 1;
>> +    pte_t expected_pte = __pte_batch_clear_ignored(pte, flags);
>> +    pte_t *ptep = start_ptep;
>>       bool writable;
>> +    int nr;
>>         if (any_writable)
>>           *any_writable = false;
>>         VM_WARN_ON_FOLIO(!pte_present(pte), folio);
>>   -    while (ptep != end_ptep) {
>> +    nr = pte_batch_hint(ptep, pte);
>> +    expected_pte = pte_advance_pfn(expected_pte, nr);
>> +    ptep += nr;
>> +
> 
> *Maybe* it's easier to get when initializing expected_pte+ptep only once.
> 
> Like:
> 
> [...]
> pte_t expected_pte, *ptep;
> [...]
> 
> nr = pte_batch_hint(start_ptep, pte);
> expected_pte = __pte_batch_clear_ignored(pte_advance_pfn(pte, nr), flags);
> ptep = start_ptep + nr;
> 
>> +    while (ptep < end_ptep) {
>>           pte = ptep_get(ptep);
>>           if (any_writable)
>>               writable = !!pte_write(pte);
>> @@ -1011,17 +1016,18 @@ static inline int folio_pte_batch(struct folio *folio,
>> unsigned long addr,
>>            * corner cases the next PFN might fall into a different
>>            * folio.
>>            */
>> -        if (pte_pfn(pte) == folio_end_pfn)
>> +        if (pte_pfn(pte) >= folio_end_pfn)
>>               break;
>>             if (any_writable)
>>               *any_writable |= writable;
>>   -        expected_pte = pte_advance_pfn(expected_pte, 1);
>> -        ptep++;
>> +        nr = pte_batch_hint(ptep, pte);
>> +        expected_pte = pte_advance_pfn(expected_pte, nr);
>> +        ptep += nr;
>>       }
>>   -    return ptep - start_ptep;
>> +    return min(ptep - start_ptep, max_nr);
>>   }
> 
> Acked-by: David Hildenbrand <david@redhat.com>
> 


