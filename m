Return-Path: <linux-kernel+bounces-6665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F70B819BD6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 10:57:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C894D1F25367
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 09:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 542E21F95D;
	Wed, 20 Dec 2023 09:57:40 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 195221F92D
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 09:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E17351FB;
	Wed, 20 Dec 2023 01:58:21 -0800 (PST)
Received: from [10.57.75.247] (unknown [10.57.75.247])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 91AB13F5A1;
	Wed, 20 Dec 2023 01:57:33 -0800 (PST)
Message-ID: <15177acd-8d75-46a8-9460-98ea313a7b2b@arm.com>
Date: Wed, 20 Dec 2023 09:57:32 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/16] mm: Batch-copy PTE ranges during fork()
Content-Language: en-GB
From: Ryan Roberts <ryan.roberts@arm.com>
To: David Hildenbrand <david@redhat.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Ard Biesheuvel <ardb@kernel.org>, Marc Zyngier <maz@kernel.org>,
 Oliver Upton <oliver.upton@linux.dev>, James Morse <james.morse@arm.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu
 <yuzenghui@huawei.com>, Andrey Ryabinin <ryabinin.a.a@gmail.com>,
 Alexander Potapenko <glider@google.com>,
 Andrey Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov <dvyukov@google.com>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Matthew Wilcox <willy@infradead.org>, Yu Zhao <yuzhao@google.com>,
 Mark Rutland <mark.rutland@arm.com>, Kefeng Wang
 <wangkefeng.wang@huawei.com>, John Hubbard <jhubbard@nvidia.com>,
 Zi Yan <ziy@nvidia.com>, Barry Song <21cnbao@gmail.com>,
 Alistair Popple <apopple@nvidia.com>, Yang Shi <shy828301@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20231218105100.172635-1-ryan.roberts@arm.com>
 <20231218105100.172635-3-ryan.roberts@arm.com>
 <0bef5423-6eea-446b-8854-980e9c23a948@redhat.com>
 <db1be625-33e4-4d07-8500-3f7d3c8f9937@arm.com>
 <be8b5181-be2c-4800-ba53-c65a6c3ed803@redhat.com>
 <dd227e51-c4b2-420b-a92a-65da85ab4018@arm.com>
 <7c0236ad-01f3-437f-8b04-125d69e90dc0@redhat.com>
 <9a58b1a2-2c13-4fa0-8ffa-2b3d9655f1b6@arm.com>
In-Reply-To: <9a58b1a2-2c13-4fa0-8ffa-2b3d9655f1b6@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 20/12/2023 09:51, Ryan Roberts wrote:
> On 20/12/2023 09:17, David Hildenbrand wrote:
>> On 19.12.23 18:42, Ryan Roberts wrote:
>>> On 19/12/2023 17:22, David Hildenbrand wrote:
>>>> On 19.12.23 09:30, Ryan Roberts wrote:
>>>>> On 18/12/2023 17:47, David Hildenbrand wrote:
>>>>>> On 18.12.23 11:50, Ryan Roberts wrote:
>>>>>>> Convert copy_pte_range() to copy a batch of ptes in one go. A given
>>>>>>> batch is determined by the architecture with the new helper,
>>>>>>> pte_batch_remaining(), and maps a physically contiguous block of memory,
>>>>>>> all belonging to the same folio. A pte batch is then write-protected in
>>>>>>> one go in the parent using the new helper, ptep_set_wrprotects() and is
>>>>>>> set in one go in the child using the new helper, set_ptes_full().
>>>>>>>
>>>>>>> The primary motivation for this change is to reduce the number of tlb
>>>>>>> maintenance operations that the arm64 backend has to perform during
>>>>>>> fork, as it is about to add transparent support for the "contiguous bit"
>>>>>>> in its ptes. By write-protecting the parent using the new
>>>>>>> ptep_set_wrprotects() (note the 's' at the end) function, the backend
>>>>>>> can avoid having to unfold contig ranges of PTEs, which is expensive,
>>>>>>> when all ptes in the range are being write-protected. Similarly, by
>>>>>>> using set_ptes_full() rather than set_pte_at() to set up ptes in the
>>>>>>> child, the backend does not need to fold a contiguous range once they
>>>>>>> are all populated - they can be initially populated as a contiguous
>>>>>>> range in the first place.
>>>>>>>
>>>>>>> This code is very performance sensitive, and a significant amount of
>>>>>>> effort has been put into not regressing performance for the order-0
>>>>>>> folio case. By default, pte_batch_remaining() is compile constant 1,
>>>>>>> which enables the compiler to simplify the extra loops that are added
>>>>>>> for batching and produce code that is equivalent (and equally
>>>>>>> performant) as the previous implementation.
>>>>>>>
>>>>>>> This change addresses the core-mm refactoring only and a separate change
>>>>>>> will implement pte_batch_remaining(), ptep_set_wrprotects() and
>>>>>>> set_ptes_full() in the arm64 backend to realize the performance
>>>>>>> improvement as part of the work to enable contpte mappings.
>>>>>>>
>>>>>>> To ensure the arm64 is performant once implemented, this change is very
>>>>>>> careful to only call ptep_get() once per pte batch.
>>>>>>>
>>>>>>> The following microbenchmark results demonstate that there is no
>>>>>>> significant performance change after this patch. Fork is called in a
>>>>>>> tight loop in a process with 1G of populated memory and the time for the
>>>>>>> function to execute is measured. 100 iterations per run, 8 runs
>>>>>>> performed on both Apple M2 (VM) and Ampere Altra (bare metal). Tests
>>>>>>> performed for case where 1G memory is comprised of order-0 folios and
>>>>>>> case where comprised of pte-mapped order-9 folios. Negative is faster,
>>>>>>> positive is slower, compared to baseline upon which the series is based:
>>>>>>>
>>>>>>> | Apple M2 VM   | order-0 (pte-map) | order-9 (pte-map) |
>>>>>>> | fork          |-------------------|-------------------|
>>>>>>> | microbench    |    mean |   stdev |    mean |   stdev |
>>>>>>> |---------------|---------|---------|---------|---------|
>>>>>>> | baseline      |    0.0% |    1.1% |    0.0% |    1.2% |
>>>>>>> | after-change  |   -1.0% |    2.0% |   -0.1% |    1.1% |
>>>>>>>
>>>>>>> | Ampere Altra  | order-0 (pte-map) | order-9 (pte-map) |
>>>>>>> | fork          |-------------------|-------------------|
>>>>>>> | microbench    |    mean |   stdev |    mean |   stdev |
>>>>>>> |---------------|---------|---------|---------|---------|
>>>>>>> | baseline      |    0.0% |    1.0% |    0.0% |    0.1% |
>>>>>>> | after-change  |   -0.1% |    1.2% |   -0.1% |    0.1% |
>>>>>>>
>>>>>>> Tested-by: John Hubbard <jhubbard@nvidia.com>
>>>>>>> Reviewed-by: Alistair Popple <apopple@nvidia.com>
>>>>>>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>>>>>>> ---
>>>>>>>     include/linux/pgtable.h | 80 +++++++++++++++++++++++++++++++++++
>>>>>>>     mm/memory.c             | 92 ++++++++++++++++++++++++++---------------
>>>>>>>     2 files changed, 139 insertions(+), 33 deletions(-)
>>>>>>>
>>>>>>> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
>>>>>>> index af7639c3b0a3..db93fb81465a 100644
>>>>>>> --- a/include/linux/pgtable.h
>>>>>>> +++ b/include/linux/pgtable.h
>>>>>>> @@ -205,6 +205,27 @@ static inline int pmd_young(pmd_t pmd)
>>>>>>>     #define arch_flush_lazy_mmu_mode()    do {} while (0)
>>>>>>>     #endif
>>>>>>>     +#ifndef pte_batch_remaining
>>>>>>> +/**
>>>>>>> + * pte_batch_remaining - Number of pages from addr to next batch boundary.
>>>>>>> + * @pte: Page table entry for the first page.
>>>>>>> + * @addr: Address of the first page.
>>>>>>> + * @end: Batch ceiling (e.g. end of vma).
>>>>>>> + *
>>>>>>> + * Some architectures (arm64) can efficiently modify a contiguous batch of
>>>>>>> ptes.
>>>>>>> + * In such cases, this function returns the remaining number of pages to
>>>>>>> the end
>>>>>>> + * of the current batch, as defined by addr. This can be useful when
>>>>>>> iterating
>>>>>>> + * over ptes.
>>>>>>> + *
>>>>>>> + * May be overridden by the architecture, else batch size is always 1.
>>>>>>> + */
>>>>>>> +static inline unsigned int pte_batch_remaining(pte_t pte, unsigned long
>>>>>>> addr,
>>>>>>> +                        unsigned long end)
>>>>>>> +{
>>>>>>> +    return 1;
>>>>>>> +}
>>>>>>> +#endif
>>>>>>
>>>>>> It's a shame we now lose the optimization for all other archtiectures.
>>>>>>
>>>>>> Was there no way to have some basic batching mechanism that doesn't require
>>>>>> arch
>>>>>> specifics?
>>>>>
>>>>> I tried a bunch of things but ultimately the way I've done it was the only way
>>>>> to reduce the order-0 fork regression to 0.
>>>>>
>>>>> My original v3 posting was costing 5% extra and even my first attempt at an
>>>>> arch-specific version that didn't resolve to a compile-time constant 1 still
>>>>> cost an extra 3%.
>>>>>
>>>>>
>>>>>>
>>>>>> I'd have thought that something very basic would have worked like:
>>>>>>
>>>>>> * Check if PTE is the same when setting the PFN to 0.
>>>>>> * Check that PFN is consecutive
>>>>>> * Check that all PFNs belong to the same folio
>>>>>
>>>>> I haven't tried this exact approach, but I'd be surprised if I can get the
>>>>> regression under 4% with this. Further along the series I spent a lot of time
>>>>> having to fiddle with the arm64 implementation; every conditional and every
>>>>> memory read (even when in cache) was a problem. There is just so little in the
>>>>> inner loop that every instruction matters. (At least on Ampere Altra and Apple
>>>>> M2).
>>>>>
>>>>> Of course if you're willing to pay that 4-5% for order-0 then the benefit to
>>>>> order-9 is around 10% in my measurements. Personally though, I'd prefer to play
>>>>> safe and ensure the common order-0 case doesn't regress, as you previously
>>>>> suggested.
>>>>>
>>>>
>>>> I just hacked something up, on top of my beloved rmap cleanup/batching series. I
>>>> implemented very generic and simple batching for large folios (all PTE bits
>>>> except the PFN have to match).
>>>>
>>>> Some very quick testing (don't trust each last % ) on Intel(R) Xeon(R) Silver
>>>> 4210R CPU.
>>>>
>>>> order-0: 0.014210 -> 0.013969
>>>>
>>>> -> Around 1.7 % faster
>>>>
>>>> order-9: 0.014373 -> 0.009149
>>>>
>>>> -> Around 36.3 % faster
>>>
>>> Well I guess that shows me :)
>>>
>>> I'll do a review and run the tests on my HW to see if it concurs.
>>
>>
>> I pushed a simple compile fixup (we need pte_next_pfn()).
> 
> I've just been trying to compile and noticed this. Will take a look at your update.

Took a look; there will still be arch work needed; arm64 doesn't define
PFN_PTE_SHIFT because it defines set_ptes(). I'm not sure if there are other
arches that also don't define PFN_PTE_SHIFT (or pte_next_pfn()) if the math is
more complex) - it will need an audit.

> 
> But upon review, I've noticed the part that I think makes this difficult for
> arm64 with the contpte optimization; You are calling ptep_get() for every pte in
> the batch. While this is functionally correct, once arm64 has the contpte
> changes, its ptep_get() has to read every pte in the contpte block in order to
> gather the access and dirty bits. So if your batching function ends up wealking
> a 16 entry contpte block, that will cause 16 x 16 reads, which kills
> performance. That's why I added the arch-specific pte_batch_remaining()
> function; this allows the core-mm to skip to the end of the contpte block and
> avoid ptep_get() for the 15 tail ptes. So we end up with 16 READ_ONCE()s instead
> of 256.
> 
> I considered making a ptep_get_noyoungdirty() variant, which would avoid the bit
> gathering. But we have a similar problem in zap_pte_range() and that function
> needs the dirty bit to update the folio. So it doesn't work there. (see patch 3
> in my series).
> 
> I guess you are going to say that we should combine both approaches, so that
> your batching loop can skip forward an arch-provided number of ptes? That would
> certainly work, but feels like an orthogonal change to what I'm trying to
> achieve :). Anyway, I'll spend some time playing with it today.
> 
> 
>>
>> Note that we should probably handle "ptep_set_wrprotects" rather like set_ptes:
>>
>> #ifndef wrprotect_ptes
>> static inline void wrprotect_ptes(struct mm_struct *mm, unsigned long addr,
>>                pte_t *ptep, unsigned int nr)
>> {
>>        for (;;) {
>>                ptep_set_wrprotect(mm, addr, ptep);
>>                if (--nr == 0)
>>                        break;
>>                ptep++;
>>                addr += PAGE_SIZE;
>>        }
>> }
>> #endif

Yes that's a much better name; I've also introduced clear_ptes() (in patch 3)
and set_ptes_full(), which takes a flag that allows arm64 to avoid trying to
fold a contpte block; needed to avoid regressing fork once the contpte changes
are present.

>>
>>
> 


