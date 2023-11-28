Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 443827FB9E3
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 13:08:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344547AbjK1MI3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 07:08:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344610AbjK1MI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 07:08:27 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 19449182
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 04:08:33 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ACCCFC15;
        Tue, 28 Nov 2023 04:09:19 -0800 (PST)
Received: from [10.1.33.188] (XHFQ2J9959.cambridge.arm.com [10.1.33.188])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 031113F73F;
        Tue, 28 Nov 2023 04:08:24 -0800 (PST)
Message-ID: <3e61d181-5e8d-4103-8dee-e18e493bc125@arm.com>
Date:   Tue, 28 Nov 2023 12:08:22 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/14] Transparent Contiguous PTEs for User Mappings
Content-Language: en-GB
To:     Barry Song <21cnbao@gmail.com>
Cc:     akpm@linux-foundation.org, andreyknvl@gmail.com,
        anshuman.khandual@arm.com, ardb@kernel.org,
        catalin.marinas@arm.com, david@redhat.com, dvyukov@google.com,
        glider@google.com, james.morse@arm.com, jhubbard@nvidia.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, mark.rutland@arm.com, maz@kernel.org,
        oliver.upton@linux.dev, ryabinin.a.a@gmail.com,
        suzuki.poulose@arm.com, vincenzo.frascino@arm.com,
        wangkefeng.wang@huawei.com, will@kernel.org, willy@infradead.org,
        yuzenghui@huawei.com, yuzhao@google.com, ziy@nvidia.com
References: <20231115163018.1303287-1-ryan.roberts@arm.com>
 <20231127031813.5576-1-v-songbaohua@oppo.com>
 <234021ba-73c2-474a-82f9-91e1604d5bb5@arm.com>
 <CAGsJ_4wTtwAMydZMzWFQghN+3xGcw3fa6iCfQpPRoqP-Tjf5dA@mail.gmail.com>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <CAGsJ_4wTtwAMydZMzWFQghN+3xGcw3fa6iCfQpPRoqP-Tjf5dA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/11/2023 05:49, Barry Song wrote:
> On Mon, Nov 27, 2023 at 5:15 PM Ryan Roberts <ryan.roberts@arm.com> wrote:
>>
>> On 27/11/2023 03:18, Barry Song wrote:
>>>> Ryan Roberts (14):
>>>>   mm: Batch-copy PTE ranges during fork()
>>>>   arm64/mm: set_pte(): New layer to manage contig bit
>>>>   arm64/mm: set_ptes()/set_pte_at(): New layer to manage contig bit
>>>>   arm64/mm: pte_clear(): New layer to manage contig bit
>>>>   arm64/mm: ptep_get_and_clear(): New layer to manage contig bit
>>>>   arm64/mm: ptep_test_and_clear_young(): New layer to manage contig bit
>>>>   arm64/mm: ptep_clear_flush_young(): New layer to manage contig bit
>>>>   arm64/mm: ptep_set_wrprotect(): New layer to manage contig bit
>>>>   arm64/mm: ptep_set_access_flags(): New layer to manage contig bit
>>>>   arm64/mm: ptep_get(): New layer to manage contig bit
>>>>   arm64/mm: Split __flush_tlb_range() to elide trailing DSB
>>>>   arm64/mm: Wire up PTE_CONT for user mappings
>>>>   arm64/mm: Implement ptep_set_wrprotects() to optimize fork()
>>>>   arm64/mm: Add ptep_get_and_clear_full() to optimize process teardown
>>>
>>> Hi Ryan,
>>> Not quite sure if I missed something, are we splitting/unfolding CONTPTES
>>> in the below cases
>>
>> The general idea is that the core-mm sets the individual ptes (one at a time if
>> it likes with set_pte_at(), or in a block with set_ptes()), modifies its
>> permissions (ptep_set_wrprotect(), ptep_set_access_flags()) and clears them
>> (ptep_clear(), etc); This is exactly the same interface as previously.
>>
>> BUT, the arm64 implementation of those interfaces will now detect when a set of
>> adjacent PTEs (a contpte block - so 16 naturally aligned entries when using 4K
>> base pages) are all appropriate for having the CONT_PTE bit set; in this case
>> the block is "folded". And it will detect when the first PTE in the block
>> changes such that the CONT_PTE bit must now be unset ("unfolded"). One of the
>> requirements for folding a contpte block is that all the pages must belong to
>> the *same* folio (that means its safe to only track access/dirty for thecontpte
>> block as a whole rather than for each individual pte).
>>
>> (there are a couple of optimizations that make the reality slightly more
>> complicated than what I've just explained, but you get the idea).
>>
>> On that basis, I believe all the specific cases you describe below are all
>> covered and safe - please let me know if you think there is a hole here!
>>
>>>
>>> 1. madvise(MADV_DONTNEED) on a part of basepages on a CONTPTE large folio
>>
>> The page will first be unmapped (e.g. ptep_clear() or ptep_get_and_clear(), or
>> whatever). The implementation of that will cause an unfold and the CONT_PTE bit
>> is removed from the whole contpte block. If there is then a subsequent
>> set_pte_at() to set a swap entry, the implementation will see that its not
>> appropriate to re-fold, so the range will remain unfolded.
>>
>>>
>>> 2. vma split in a large folio due to various reasons such as mprotect,
>>> munmap, mlock etc.
>>
>> I'm not sure if PTEs are explicitly unmapped/remapped when splitting a VMA? I
>> suspect not, so if the VMA is split in the middle of a currently folded contpte
>> block, it will remain folded. But this is safe and continues to work correctly.
>> The VMA arrangement is not important; it is just important that a single folio
>> is mapped contiguously across the whole block.
>>
>>>
>>> 3. try_to_unmap_one() to reclaim a folio, ptes are scanned one by one
>>> rather than being as a whole.
>>
>> Yes, as per 1; the arm64 implementation will notice when the first entry is
>> cleared and unfold the contpte block.
>>
>>>
>>> In hardware, we need to make sure CONTPTE follow the rule - always 16
>>> contiguous physical address with CONTPTE set. if one of them run away
>>> from the 16 ptes group and PTEs become unconsistent, some terrible
>>> errors/faults can happen in HW. for example
>>
>> Yes, the implementation obeys all these rules; see contpte_try_fold() and
>> contpte_try_unfold(). the fold/unfold operation is only done when all
>> requirements are met, and we perform it in a manner that is conformant to the
>> architecture requirements (see contpte_fold() - being renamed to
>> contpte_convert() in the next version).
> 
> Hi Ryan,
> 
> sorry for too many comments, I remembered another case
> 
> 4. mremap
> 
> a CONTPTE might be remapped to another address which might not be
> aligned with 16*basepage. thus, in move_ptes(), we are copying CONPTEs
> from src to dst.
> static int move_ptes(struct vm_area_struct *vma, pmd_t *old_pmd,
>                 unsigned long old_addr, unsigned long old_end,
>                 struct vm_area_struct *new_vma, pmd_t *new_pmd,
>                 unsigned long new_addr, bool need_rmap_locks)
> {
>         struct mm_struct *mm = vma->vm_mm;
>         pte_t *old_pte, *new_pte, pte;
>         ...
> 
>         /*
>          * We don't have to worry about the ordering of src and dst
>          * pte locks because exclusive mmap_lock prevents deadlock.
>          */
>         old_pte = pte_offset_map_lock(mm, old_pmd, old_addr, &old_ptl);
>         if (!old_pte) {
>                 err = -EAGAIN;
>                 goto out;
>         }
>         new_pte = pte_offset_map_nolock(mm, new_pmd, new_addr, &new_ptl);
>         if (!new_pte) {
>                 pte_unmap_unlock(old_pte, old_ptl);
>                 err = -EAGAIN;
>                 goto out;
>         }
>         if (new_ptl != old_ptl)
>                 spin_lock_nested(new_ptl, SINGLE_DEPTH_NESTING);
>         flush_tlb_batched_pending(vma->vm_mm);
>         arch_enter_lazy_mmu_mode();
> 
>         for (; old_addr < old_end; old_pte++, old_addr += PAGE_SIZE,
>                                    new_pte++, new_addr += PAGE_SIZE) {
>                 if (pte_none(ptep_get(old_pte)))
>                         continue;
> 
>                 pte = ptep_get_and_clear(mm, old_addr, old_pte);
>        ....
> }
> 
> This has two possibilities
> 1. new_pte is aligned with CONT_PTES, we can still keep CONTPTE;
> 2. new_pte is not aligned with CONT_PTES, we should drop CONTPTE
> while copying.
> 
> does your code also handle this properly？

Yes; same mechanism - the arm64 arch code does the CONT_PTE bit management and
folds/unfolds as neccessary.

Admittedly this may be non-optimal because we are iterating a single PTE at a
time. When we clear the first pte of a contpte block in the source, the block
will be unfolded. When we set the last pte of the contpte block in the dest, the
block will be folded. If we had a batching mechanism, we could just clear the
whole source contpte block in one hit (no need to unfold first) and we could
just set the dest contpte block in one hit (no need to fold at the end).

I haven't personally seen this as a hotspot though; I don't know if you have any
data to the contrary? I've followed this type of batching technique for the fork
case (patch 13). We could do a similar thing in theory, but its a bit more
complex because of the ptep_get_and_clear() return value; you would need to
return all ptes for the cleared range, or somehow collapse the actual info that
the caller requires (presumably access/dirty info).

> 
>>
>> Thanks for the review!
>>
>> Thanks,
>> Ryan
>>
>>>
>>> case0:
>>> addr0 PTE - has no CONTPE
>>> addr0+4kb PTE - has CONTPTE
>>> ....
>>> addr0+60kb PTE - has CONTPTE
>>>
>>> case 1:
>>> addr0 PTE - has no CONTPE
>>> addr0+4kb PTE - has CONTPTE
>>> ....
>>> addr0+60kb PTE - has swap
>>>
>>> Unconsistent 16 PTEs will lead to crash even in the firmware based on
>>> our observation.
>>>
>>> Thanks
>>> Barry
> 
> Thanks
> Barry

