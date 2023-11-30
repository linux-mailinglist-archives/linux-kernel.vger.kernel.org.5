Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4173F7FEE3C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 12:47:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345115AbjK3Lrb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 06:47:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231837AbjK3Lr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 06:47:28 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7997610CE
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 03:47:33 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B85D51042;
        Thu, 30 Nov 2023 03:48:19 -0800 (PST)
Received: from [10.1.34.169] (XHFQ2J9959.cambridge.arm.com [10.1.34.169])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 124113F6C4;
        Thu, 30 Nov 2023 03:47:29 -0800 (PST)
Message-ID: <9631b5bd-1d10-40bf-b4eb-9df33b9a0680@arm.com>
Date:   Thu, 30 Nov 2023 11:47:28 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 14/14] arm64/mm: Add ptep_get_and_clear_full() to
 optimize process teardown
Content-Language: en-GB
To:     Alistair Popple <apopple@nvidia.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Yu Zhao <yuzhao@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        David Hildenbrand <david@redhat.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        John Hubbard <jhubbard@nvidia.com>, Zi Yan <ziy@nvidia.com>,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20231115163018.1303287-1-ryan.roberts@arm.com>
 <20231115163018.1303287-15-ryan.roberts@arm.com>
 <87fs0xxd5g.fsf@nvdebian.thelocal>
 <3b4f6bff-6322-4394-9efb-9c3b9ef52010@arm.com>
 <87y1eovsn5.fsf@nvdebian.thelocal>
 <8fca9ed7-f916-4abe-8284-6e3c9fa33a8c@arm.com>
 <87wmu3pro8.fsf@nvdebian.thelocal>
 <26c78fee-4b7a-4d73-9f8b-2e25bbae20e8@arm.com>
 <87o7fepdun.fsf@nvdebian.thelocal>
 <b4906e1e-8009-4097-8d17-642374a049fe@arm.com>
 <b6d4b33b-6224-444f-9542-d3cb95afd382@arm.com>
 <87leafg768.fsf@nvdebian.thelocal>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <87leafg768.fsf@nvdebian.thelocal>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/11/2023 05:07, Alistair Popple wrote:
> 
> Ryan Roberts <ryan.roberts@arm.com> writes:
> 
>>>>> So if we do need to deal with racing HW, I'm pretty sure my v1 implementation is
>>>>> buggy because it iterated through the PTEs, getting and accumulating. Then
>>>>> iterated again, writing that final set of bits to all the PTEs. And the HW could
>>>>> have modified the bits during those loops. I think it would be possible to fix
>>>>> the race, but intuition says it would be expensive.
>>>>
>>>> So the issue as I understand it is subsequent iterations would see a
>>>> clean PTE after the first iteration returned a dirty PTE. In
>>>> ptep_get_and_clear_full() why couldn't you just copy the dirty/accessed
>>>> bit (if set) from the PTE being cleared to an adjacent PTE rather than
>>>> all the PTEs?
>>>
>>> The raciness I'm describing is the race between reading access/dirty from one
>>> pte and applying it to another. But yes I like your suggestion. if we do:
>>>
>>> pte = __ptep_get_and_clear_full(ptep)
>>>
>>> on the target pte, then we have grabbed access/dirty from it in a race-free
>>> manner. we can then loop from current pte up towards the top of the block until
>>> we find a valid entry (and I guess wrap at the top to make us robust against
>>> future callers clearing an an arbitrary order). Then atomically accumulate the
>>> access/dirty bits we have just saved into that new entry. I guess that's just a
>>> cmpxchg loop - there are already examples of how to do that correctly when
>>> racing the TLB.
>>>
>>> For most entries, we will just be copying up to the next pte. For the last pte,
>>> we would end up reading all ptes and determine we are the last one.
>>>
>>> What do you think?
>>
>> OK here is an attempt at something which solves the fragility. I think this is
>> now robust and will always return the correct access/dirty state from
>> ptep_get_and_clear_full() and ptep_get().
>>
>> But I'm not sure about performance; each call to ptep_get_and_clear_full() for
>> each pte in a contpte block will cause a ptep_get() to gather the access/dirty
>> bits from across the contpte block - which requires reading each pte in the
>> contpte block. So its O(n^2) in that sense. I'll benchmark it and report back.
>>
>> Was this the type of thing you were thinking of, Alistair?
> 
> Yes, that is along the lines of what I was thinking. However I have
> added a couple of comments inline. 
> 
>> --8<--
>>  arch/arm64/include/asm/pgtable.h | 23 ++++++++-
>>  arch/arm64/mm/contpte.c          | 81 ++++++++++++++++++++++++++++++++
>>  arch/arm64/mm/fault.c            | 38 +++++++++------
>>  3 files changed, 125 insertions(+), 17 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
>> index 9bd2f57a9e11..6c295d277784 100644
>> --- a/arch/arm64/include/asm/pgtable.h
>> +++ b/arch/arm64/include/asm/pgtable.h
>> @@ -851,6 +851,7 @@ static inline pmd_t pmd_modify(pmd_t pmd, pgprot_t newprot)
>>  	return pte_pmd(pte_modify(pmd_pte(pmd), newprot));
>>  }
>>
>> +extern int __ptep_set_access_flags_notlbi(pte_t *ptep, pte_t entry);
>>  extern int __ptep_set_access_flags(struct vm_area_struct *vma,
>>  				 unsigned long address, pte_t *ptep,
>>  				 pte_t entry, int dirty);
>> @@ -1145,6 +1146,8 @@ extern pte_t contpte_ptep_get(pte_t *ptep, pte_t orig_pte);
>>  extern pte_t contpte_ptep_get_lockless(pte_t *orig_ptep);
>>  extern void contpte_set_ptes(struct mm_struct *mm, unsigned long addr,
>>  				pte_t *ptep, pte_t pte, unsigned int nr);
>> +extern pte_t contpte_ptep_get_and_clear_full(struct mm_struct *mm,
>> +				unsigned long addr, pte_t *ptep);
>>  extern int contpte_ptep_test_and_clear_young(struct vm_area_struct *vma,
>>  				unsigned long addr, pte_t *ptep);
>>  extern int contpte_ptep_clear_flush_young(struct vm_area_struct *vma,
>> @@ -1270,12 +1273,28 @@ static inline void pte_clear(struct mm_struct *mm,
>>  	__pte_clear(mm, addr, ptep);
>>  }
>>
>> +#define __HAVE_ARCH_PTEP_GET_AND_CLEAR_FULL
>> +static inline pte_t ptep_get_and_clear_full(struct mm_struct *mm,
>> +				unsigned long addr, pte_t *ptep, int full)
>> +{
>> +	pte_t orig_pte = __ptep_get(ptep);
>> +
>> +	if (!pte_valid_cont(orig_pte))
>> +		return __ptep_get_and_clear(mm, addr, ptep);
>> +
>> +	if (!full) {
>> +		contpte_try_unfold(mm, addr, ptep, orig_pte);
>> +		return __ptep_get_and_clear(mm, addr, ptep);
>> +	}
>> +
>> +	return contpte_ptep_get_and_clear_full(mm, addr, ptep);
>> +}
>> +
>>  #define __HAVE_ARCH_PTEP_GET_AND_CLEAR
>>  static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
>>  				unsigned long addr, pte_t *ptep)
>>  {
>> -	contpte_try_unfold(mm, addr, ptep, __ptep_get(ptep));
>> -	return __ptep_get_and_clear(mm, addr, ptep);
>> +	return ptep_get_and_clear_full(mm, addr, ptep, 0);
>>  }
>>
>>  #define __HAVE_ARCH_PTEP_TEST_AND_CLEAR_YOUNG
>> diff --git a/arch/arm64/mm/contpte.c b/arch/arm64/mm/contpte.c
>> index 2a57df16bf58..99b211118d93 100644
>> --- a/arch/arm64/mm/contpte.c
>> +++ b/arch/arm64/mm/contpte.c
>> @@ -145,6 +145,14 @@ pte_t contpte_ptep_get(pte_t *ptep, pte_t orig_pte)
>>  	for (i = 0; i < CONT_PTES; i++, ptep++) {
>>  		pte = __ptep_get(ptep);
>>
>> +		/*
>> +		 * Deal with the partial contpte_ptep_get_and_clear_full() case,
>> +		 * where some of the ptes in the range may be cleared but others
>> +		 * are still to do. See contpte_ptep_get_and_clear_full().
>> +		 */
>> +		if (!pte_valid(pte))
>> +			continue;
>> +
>>  		if (pte_dirty(pte))
>>  			orig_pte = pte_mkdirty(orig_pte);
>>
>> @@ -257,6 +265,79 @@ void contpte_set_ptes(struct mm_struct *mm, unsigned long addr,
>>  }
>>  EXPORT_SYMBOL(contpte_set_ptes);
>>
>> +pte_t contpte_ptep_get_and_clear_full(struct mm_struct *mm,
>> +					unsigned long addr, pte_t *ptep)
>> +{
>> +	/*
>> +	 * When doing a full address space teardown, we can avoid unfolding the
>> +	 * contiguous range, and therefore avoid the associated tlbi. Instead,
>> +	 * just get and clear the pte. The caller is promising to call us for
>> +	 * every pte, so every pte in the range will be cleared by the time the
>> +	 * final tlbi is issued.
>> +	 *
>> +	 * This approach requires some complex hoop jumping though, as for the
>> +	 * duration between returning from the first call to
>> +	 * ptep_get_and_clear_full() and making the final call, the contpte
>> +	 * block is in an intermediate state, where some ptes are cleared and
>> +	 * others are still set with the PTE_CONT bit. If any other APIs are
>> +	 * called for the ptes in the contpte block during that time, we have to
>> +	 * be very careful. The core code currently interleaves calls to
>> +	 * ptep_get_and_clear_full() with ptep_get() and so ptep_get() must be
>> +	 * careful to ignore the cleared entries when accumulating the access
>> +	 * and dirty bits - the same goes for ptep_get_lockless(). The only
>> +	 * other calls we might resonably expect are to set markers in the
>> +	 * previously cleared ptes. (We shouldn't see valid entries being set
>> +	 * until after the tlbi, at which point we are no longer in the
>> +	 * intermediate state). Since markers are not valid, this is safe;
>> +	 * set_ptes() will see the old, invalid entry and will not attempt to
>> +	 * unfold. And the new pte is also invalid so it won't attempt to fold.
>> +	 * We shouldn't see pte markers being set for the 'full' case anyway
>> +	 * since the address space is being torn down.
>> +	 *
>> +	 * The last remaining issue is returning the access/dirty bits. That
>> +	 * info could be present in any of the ptes in the contpte block.
>> +	 * ptep_get() will gather those bits from across the contpte block (for
>> +	 * the remaining valid entries). So below, if the pte we are clearing
>> +	 * has dirty or young set, we need to stash it into a pte that we are
>> +	 * yet to clear. This allows future calls to return the correct state
>> +	 * even when the info was stored in a different pte. Since the core-mm
>> +	 * calls from low to high address, we prefer to stash in the last pte of
>> +	 * the contpte block - this means we are not "dragging" the bits up
>> +	 * through all ptes and increases the chances that we can exit early
>> +	 * because a given pte will have neither dirty or young set.
>> +	 */
>> +
>> +	pte_t orig_pte = __ptep_get_and_clear(mm, addr, ptep);
>> +	bool dirty = pte_dirty(orig_pte);
>> +	bool young = pte_young(orig_pte);
>> +	pte_t *start;
>> +
>> +	if (!dirty && !young)
>> +		return contpte_ptep_get(ptep, orig_pte);
> 
> I don't think we need to do this. If the PTE is !dirty && !young we can
> just return it. As you say we have to assume HW can set those flags at
> any time anyway so it doesn't get us much. This means in the common case
> we should only run through the loop setting the dirty/young flags once
> which should alay the performance concerns.

I don't follow your logic. This is precisely the problem I was trying to solve
vs my original (simple) attempt - we want to always report the correct
access/dirty info. If we read one of the PTEs and neither access nor dirty are
set, that doesn't mean its old and clean, it just means that that info is
definitely not stored in this PTE - we need to check the others. (when the
contiguous bit is set, the HW will only update the access/dirty bits for 1 of
the PTEs in the contpte block).

Also, IIRC correctly, the core-mm sets access when initially setting up the
mapping so its not guarranteed that all but one of the PTEs in the contpte block
have (!dirty && !young).

> 
> However I am now wondering if we're doing the wrong thing trying to hide
> this down in the arch layer anyway. Perhaps it would be better to deal
> with this in the core-mm code after all.
> 
> So how about having ptep_get_and_clear_full() clearing the PTEs for the
> entire cont block? We know by definition all PTEs should be pointing to
> the same folio anyway, and it seems at least zap_pte_range() would cope
> with this just fine because subsequent iterations would just see
> pte_none() and continue the loop. I haven't checked the other call sites
> though, but in principal I don't see why we couldn't define
> ptep_get_and_clear_full() as being something that clears all PTEs
> mapping a given folio (although it might need renaming).

Ahha! Yes, I've been working on a solution like this since Barry raised it
yesterday. I have a working version, that seems to perform well. I wouldn't want
to just clear all the PTEs in the block inside ptep_get_and_clear_full() because
although it might work today, its fragile in the same way that my v2 version is.

Instead, I've defined a new helper, clear_ptes(), which takes a starting pte and
a number of ptes to clear (like set_ptes()). It returns the PTE read from the
*first* slot, but with the access/dirty bits being accumulated from all of the
ptes in the requested batch. Then zap_pte_range() is reworked to find
appropriate batches (similar to how I've reworked for ptep_set_wrprotects()).

I was trying to avoid introducing new helpers, but I think this is the most
robust approach, and looks slightly more performant to, on first sight. It also
addresses cases where full=0, which Barry says are important for madvise(DONTNEED).

> 
> This does assume you don't need to partially unmap a page in
> zap_pte_range (ie. end >= folio), but we're already making that
> assumption.

That's fine for full=1. But we can't make that assumption for full=0. If a VMA
gets split for a reason that doesn't require re-setting the PTEs then a contpte
block could straddle 2 VMAs. But the solution I describe above is robust to that.

I'll finish gathering perf data then post for all 3 approaches; v2 as originally
posted, "robust ptep_get_and_clear_full()", and clear_ptes(). Hopefully later today.

> 
>> +
>> +	start = contpte_align_down(ptep);
>> +	ptep = start + CONT_PTES - 1;
>> +
>> +	for (; ptep >= start; ptep--) {
>> +		pte_t pte = __ptep_get(ptep);
>> +
>> +		if (!pte_valid(pte))
>> +			continue;
>> +
>> +		if (dirty)
>> +			pte = pte_mkdirty(pte);
>> +
>> +		if (young)
>> +			pte = pte_mkyoung(pte);
>> +
>> +		__ptep_set_access_flags_notlbi(ptep, pte);
>> +		return contpte_ptep_get(ptep, orig_pte);
>> +	}
>> +
>> +	return orig_pte;
>> +}
>> +EXPORT_SYMBOL(contpte_ptep_get_and_clear_full);
>> +
>>  int contpte_ptep_test_and_clear_young(struct vm_area_struct *vma,
>>  					unsigned long addr, pte_t *ptep)
>>  {
>> diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
>> index d63f3a0a7251..b22216a8153c 100644
>> --- a/arch/arm64/mm/fault.c
>> +++ b/arch/arm64/mm/fault.c
>> @@ -199,19 +199,7 @@ static void show_pte(unsigned long addr)
>>  	pr_cont("\n");
>>  }
>>
>> -/*
>> - * This function sets the access flags (dirty, accessed), as well as write
>> - * permission, and only to a more permissive setting.
>> - *
>> - * It needs to cope with hardware update of the accessed/dirty state by other
>> - * agents in the system and can safely skip the __sync_icache_dcache() call as,
>> - * like __set_ptes(), the PTE is never changed from no-exec to exec here.
>> - *
>> - * Returns whether or not the PTE actually changed.
>> - */
>> -int __ptep_set_access_flags(struct vm_area_struct *vma,
>> -			    unsigned long address, pte_t *ptep,
>> -			    pte_t entry, int dirty)
>> +int __ptep_set_access_flags_notlbi(pte_t *ptep, pte_t entry)
>>  {
>>  	pteval_t old_pteval, pteval;
>>  	pte_t pte = __ptep_get(ptep);
>> @@ -238,10 +226,30 @@ int __ptep_set_access_flags(struct vm_area_struct *vma,
>>  		pteval = cmpxchg_relaxed(&pte_val(*ptep), old_pteval, pteval);
>>  	} while (pteval != old_pteval);
>>
>> +	return 1;
>> +}
>> +
>> +/*
>> + * This function sets the access flags (dirty, accessed), as well as write
>> + * permission, and only to a more permissive setting.
>> + *
>> + * It needs to cope with hardware update of the accessed/dirty state by other
>> + * agents in the system and can safely skip the __sync_icache_dcache() call as,
>> + * like __set_ptes(), the PTE is never changed from no-exec to exec here.
>> + *
>> + * Returns whether or not the PTE actually changed.
>> + */
>> +int __ptep_set_access_flags(struct vm_area_struct *vma,
>> +			    unsigned long address, pte_t *ptep,
>> +			    pte_t entry, int dirty)
>> +{
>> +	int changed = __ptep_set_access_flags_notlbi(ptep, entry);
>> +
>>  	/* Invalidate a stale read-only entry */
>> -	if (dirty)
>> +	if (changed && dirty)
>>  		flush_tlb_page(vma, address);
>> -	return 1;
>> +
>> +	return changed;
>>  }
>>
>>  static bool is_el1_instruction_abort(unsigned long esr)
>> --8<--
> 

