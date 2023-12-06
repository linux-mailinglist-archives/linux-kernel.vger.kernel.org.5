Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37A1B8073ED
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 16:44:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379394AbjLFPos (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 10:44:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379288AbjLFPor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 10:44:47 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B55A0DE
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 07:44:49 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0A21C143D;
        Wed,  6 Dec 2023 07:45:35 -0800 (PST)
Received: from [10.57.73.130] (unknown [10.57.73.130])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B8AB83F5A1;
        Wed,  6 Dec 2023 07:44:45 -0800 (PST)
Message-ID: <5c06e3fc-e8f0-4896-ab71-2317a71e812a@arm.com>
Date:   Wed, 6 Dec 2023 15:44:44 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 04/10] mm: thp: Support allocation of anonymous
 multi-size THP
Content-Language: en-GB
From:   Ryan Roberts <ryan.roberts@arm.com>
To:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Yin Fengwei <fengwei.yin@intel.com>,
        Yu Zhao <yuzhao@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Itaru Kitayama <itaru.kitayama@gmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        John Hubbard <jhubbard@nvidia.com>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Hugh Dickins <hughd@google.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Barry Song <21cnbao@gmail.com>,
        Alistair Popple <apopple@nvidia.com>
Cc:     linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20231204102027.57185-1-ryan.roberts@arm.com>
 <20231204102027.57185-5-ryan.roberts@arm.com>
 <71040a8c-4ea1-4f21-8ac8-65f7c25c217e@redhat.com>
 <f2896d7f-183b-48fb-a3aa-d21bf2257043@arm.com>
In-Reply-To: <f2896d7f-183b-48fb-a3aa-d21bf2257043@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/12/2023 14:19, Ryan Roberts wrote:
> On 05/12/2023 16:32, David Hildenbrand wrote:
>> On 04.12.23 11:20, Ryan Roberts wrote:
>>> Introduce the logic to allow THP to be configured (through the new sysfs
>>> interface we just added) to allocate large folios to back anonymous
>>> memory, which are larger than the base page size but smaller than
>>> PMD-size. We call this new THP extension "multi-size THP" (mTHP).
>>>
>>> mTHP continues to be PTE-mapped, but in many cases can still provide
>>> similar benefits to traditional PMD-sized THP: Page faults are
>>> significantly reduced (by a factor of e.g. 4, 8, 16, etc. depending on
>>> the configured order), but latency spikes are much less prominent
>>> because the size of each page isn't as huge as the PMD-sized variant and
>>> there is less memory to clear in each page fault. The number of per-page
>>> operations (e.g. ref counting, rmap management, lru list management) are
>>> also significantly reduced since those ops now become per-folio.
>>>
>>> Some architectures also employ TLB compression mechanisms to squeeze
>>> more entries in when a set of PTEs are virtually and physically
>>> contiguous and approporiately aligned. In this case, TLB misses will
>>> occur less often.
>>>
>>> The new behaviour is disabled by default, but can be enabled at runtime
>>> by writing to /sys/kernel/mm/transparent_hugepage/hugepage-XXkb/enabled
>>> (see documentation in previous commit). The long term aim is to change
>>> the default to include suitable lower orders, but there are some risks
>>> around internal fragmentation that need to be better understood first.
>>>
>>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>>
>> In general, looks good to me, some comments/nits. And the usual "let's make sure
>> we don't degrade order-0 and keep that as fast as possible" comment.
>>
>>> ---
>>>   include/linux/huge_mm.h |   6 ++-
>>>   mm/memory.c             | 106 ++++++++++++++++++++++++++++++++++++----
>>>   2 files changed, 101 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
>>> index bd0eadd3befb..91a53b9835a4 100644
>>> --- a/include/linux/huge_mm.h
>>> +++ b/include/linux/huge_mm.h
>>> @@ -68,9 +68,11 @@ extern struct kobj_attribute shmem_enabled_attr;
>>>   #define HPAGE_PMD_NR (1<<HPAGE_PMD_ORDER)
>>>     /*
>>> - * Mask of all large folio orders supported for anonymous THP.
>>> + * Mask of all large folio orders supported for anonymous THP; all orders up to
>>> + * and including PMD_ORDER, except order-0 (which is not "huge") and order-1
>>> + * (which is a limitation of the THP implementation).
>>>    */
>>> -#define THP_ORDERS_ALL_ANON    BIT(PMD_ORDER)
>>> +#define THP_ORDERS_ALL_ANON    ((BIT(PMD_ORDER + 1) - 1) & ~(BIT(0) | BIT(1)))
>>>     /*
>>>    * Mask of all large folio orders supported for file THP.
>>> diff --git a/mm/memory.c b/mm/memory.c
>>> index 3ceeb0f45bf5..bf7e93813018 100644
>>> --- a/mm/memory.c
>>> +++ b/mm/memory.c
>>> @@ -4125,6 +4125,84 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>>>       return ret;
>>>   }
>>>   +static bool pte_range_none(pte_t *pte, int nr_pages)
>>> +{
>>> +    int i;
>>> +
>>> +    for (i = 0; i < nr_pages; i++) {
>>> +        if (!pte_none(ptep_get_lockless(pte + i)))
>>> +            return false;
>>> +    }
>>> +
>>> +    return true;
>>> +}
>>> +
>>> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
>>> +static struct folio *alloc_anon_folio(struct vm_fault *vmf)
>>> +{
>>> +    gfp_t gfp;
>>> +    pte_t *pte;
>>> +    unsigned long addr;
>>> +    struct folio *folio;
>>> +    struct vm_area_struct *vma = vmf->vma;
>>> +    unsigned long orders;
>>> +    int order;
>>
>> Nit: reverse christmas tree encouraged ;)
> 
> ACK will fix.
> 
>>
>>> +
>>> +    /*
>>> +     * If uffd is active for the vma we need per-page fault fidelity to
>>> +     * maintain the uffd semantics.
>>> +     */
>>> +    if (userfaultfd_armed(vma))
>>
>> Nit: unlikely()
> 
> ACK will fix.
> 
>>
>>> +        goto fallback;
>>> +
>>> +    /*
>>> +     * Get a list of all the (large) orders below PMD_ORDER that are enabled
>>> +     * for this vma. Then filter out the orders that can't be allocated over
>>> +     * the faulting address and still be fully contained in the vma.
>>> +     */
>>> +    orders = thp_vma_allowable_orders(vma, vma->vm_flags, false, true, true,
>>> +                      BIT(PMD_ORDER) - 1);
>>> +    orders = thp_vma_suitable_orders(vma, vmf->address, orders);
>>
>> Comment: Both will eventually loop over all orders, correct? Could eventually be
>> sped up in the future.
> 
> No only thp_vma_suitable_orders() will loop. thp_vma_allowable_orders() only
> loops if in_pf=false (it's true here).
> 
>>
>> Nit: the orders = ... order = ... looks like this might deserve a helper
>> function that makes this easier to read.
> 
> To be honest, the existing function that I've modified is a bit of a mess.
> thp_vma_allowable_orders() calls thp_vma_suitable_orders() if we are not in a
> page fault, because the page fault handlers already do that check themselves. It
> would be nice to refactor the whole thing so that thp_vma_allowable_orders() is
> a strict superset of thp_vma_suitable_orders(). Then this can just call
> thp_vma_allowable_orders(). But that's going to start touching the PMD and PUD
> handlers, so prefer if we leave that for a separate patch set.
> 
>>
>> Nit: Why call thp_vma_suitable_orders if the orders are already 0? Again, some
>> helper might be reasonable where that is handled internally.
> 
> Because thp_vma_suitable_orders() will handle it safely and is inline, so it
> should just as efficient? This would go away with the refactoring described above.
> 
>>
>> Comment: For order-0 we'll always perform a function call to both
>> thp_vma_allowable_orders() / thp_vma_suitable_orders(). We should perform some
>> fast and efficient check if any <PMD THP are even enabled in the system / for
>> this VMA, and in that case just fallback before doing more expensive checks.
> 

I just noticed I got these functions round the wrong way in my previous response:

> thp_vma_allowable_orders() is inline as you mentioned.

^ Meant thp_vma_suitable_orders() here.

> 
> I was deliberately trying to keep all the decision logic in one place
> (thp_vma_suitable_orders) because it's already pretty complicated. But if you

^ Meant thp_vma_allowable_orders() here.

Sorry for the confusion.

> insist, how about this in the header:
> 
> static inline
> unsigned long thp_vma_allowable_orders(struct vm_area_struct *vma,
> 				       unsigned long vm_flags, bool smaps,
> 				       bool in_pf, bool enforce_sysfs,
> 				       unsigned long orders)
> {
> 	/* Optimization to check if required orders are enabled early. */
> 	if (enforce_sysfs && vma_is_anonymous(vma)) {
> 		unsigned long mask = READ_ONCE(huge_anon_orders_always);
> 
> 		if (vm_flags & VM_HUGEPAGE)
> 			mask |= READ_ONCE(huge_anon_orders_madvise);
> 		if (hugepage_global_always() ||
> 			((vm_flags & VM_HUGEPAGE) && hugepage_global_enabled()))
> 			mask |= READ_ONCE(huge_anon_orders_inherit);
> 
> 		orders &= mask;
> 		if (!orders)
> 			return 0;
> 		
> 		enforce_sysfs = false;
> 	}
> 
> 	return __thp_vma_allowable_orders(vma, vm_flags, smaps, in_pf,
> 					  enforce_sysfs, orders);
> }
> 
> Then the above check can be removed from __thp_vma_allowable_orders() - it will
> still retain the `if (enforce_sysfs && !vma_is_anonymous(vma))` part.
> 
> 
>>
>>> +
>>> +    if (!orders)
>>> +        goto fallback;
>>> +
>>> +    pte = pte_offset_map(vmf->pmd, vmf->address & PMD_MASK);
>>> +    if (!pte)
>>> +        return ERR_PTR(-EAGAIN);
>>> +
>>> +    order = first_order(orders);
>>> +    while (orders) {
>>> +        addr = ALIGN_DOWN(vmf->address, PAGE_SIZE << order);
>>> +        vmf->pte = pte + pte_index(addr);
>>> +        if (pte_range_none(vmf->pte, 1 << order))
>>> +            break;
>>
>> Comment: Likely it would make sense to scan only once and determine the "largest
>> none range" around that address, having the largest suitable order in mind.
> 
> Yes, that's how I used to do it, but Yu Zhou requested simplifying to this,
> IIRC. Perhaps this an optimization opportunity for later?
> 
>>
>>> +        order = next_order(&orders, order);
>>> +    }
>>> +
>>> +    vmf->pte = NULL;
>>
>> Nit: Can you elaborate why you are messing with vmf->pte here? A simple helper
>> variable will make this code look less magical. Unless I am missing something
>> important :)
> 
> Gahh, I used to pass the vmf to what pte_range_none() was refactored into (an
> approach that was suggested by Yu Zhou IIRC). But since I did some refactoring
> based on some comments from JohnH, I see I don't need that anymore. Agreed; it
> will be much clearer just to use a local variable. Will fix.
> 
>>
>>> +    pte_unmap(pte);
>>> +
>>> +    gfp = vma_thp_gfp_mask(vma);
>>> +
>>> +    while (orders) {
>>> +        addr = ALIGN_DOWN(vmf->address, PAGE_SIZE << order);
>>> +        folio = vma_alloc_folio(gfp, order, vma, addr, true);
>>> +        if (folio) {
>>> +            clear_huge_page(&folio->page, addr, 1 << order);
>>> +            return folio;
>>> +        }
>>> +        order = next_order(&orders, order);
>>> +    }
>>> +
>>
>> Queestion: would it make sense to combine both loops? I suspect memory
>> allocations with pte_offset_map()/kmao are problematic.
> 
> They are both operating on separate orders; next_order() is "consuming" an order
> by removing the current one from the orders bitfield and returning the next one.
> 
> So the first loop starts at the highest order and keeps checking lower orders
> until one fully fits in the VMA. And the second loop starts at the first order
> that was found to fully fits and loops to lower orders until an allocation is
> successful.
> 
> So I don't see a need to combine the loops.
> 
>>
>>> +fallback:
>>> +    return vma_alloc_zeroed_movable_folio(vma, vmf->address);
>>> +}
>>> +#else
>>> +#define alloc_anon_folio(vmf) \
>>> +        vma_alloc_zeroed_movable_folio((vmf)->vma, (vmf)->address)
>>> +#endif
>>> +
>>>   /*
>>>    * We enter with non-exclusive mmap_lock (to exclude vma changes,
>>>    * but allow concurrent faults), and pte mapped but not yet locked.
>>> @@ -4132,6 +4210,9 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>>>    */
>>>   static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
>>>   {
>>> +    int i;
>>> +    int nr_pages = 1;
>>> +    unsigned long addr = vmf->address;
>>>       bool uffd_wp = vmf_orig_pte_uffd_wp(vmf);
>>>       struct vm_area_struct *vma = vmf->vma;
>>>       struct folio *folio;
>>
>> Nit: reverse christmas tree :)
> 
> ACK
> 
>>
>>> @@ -4176,10 +4257,15 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
>>>       /* Allocate our own private page. */
>>>       if (unlikely(anon_vma_prepare(vma)))
>>>           goto oom;
>>> -    folio = vma_alloc_zeroed_movable_folio(vma, vmf->address);
>>> +    folio = alloc_anon_folio(vmf);
>>> +    if (IS_ERR(folio))
>>> +        return 0;
>>>       if (!folio)
>>>           goto oom;
>>>   +    nr_pages = folio_nr_pages(folio);
>>> +    addr = ALIGN_DOWN(vmf->address, nr_pages * PAGE_SIZE);
>>> +
>>>       if (mem_cgroup_charge(folio, vma->vm_mm, GFP_KERNEL))
>>>           goto oom_free_page;
>>>       folio_throttle_swaprate(folio, GFP_KERNEL);
>>> @@ -4196,12 +4282,13 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
>>>       if (vma->vm_flags & VM_WRITE)
>>>           entry = pte_mkwrite(pte_mkdirty(entry), vma);
>>>   -    vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd, vmf->address,
>>> -            &vmf->ptl);
>>> +    vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd, addr, &vmf->ptl);
>>>       if (!vmf->pte)
>>>           goto release;
>>> -    if (vmf_pte_changed(vmf)) {
>>> -        update_mmu_tlb(vma, vmf->address, vmf->pte);
>>> +    if ((nr_pages == 1 && vmf_pte_changed(vmf)) ||
>>> +        (nr_pages  > 1 && !pte_range_none(vmf->pte, nr_pages))) {
>>> +        for (i = 0; i < nr_pages; i++)
>>> +            update_mmu_tlb(vma, addr + PAGE_SIZE * i, vmf->pte + i);
>>
>> Comment: separating the order-0 case from the other case might make this easier
>> to read.
> 
> Yeah fair enough. Will fix.
> 
>>
>>>           goto release;
>>>       }
>>>   @@ -4216,16 +4303,17 @@ static vm_fault_t do_anonymous_page(struct vm_fault
>>> *vmf)
>>>           return handle_userfault(vmf, VM_UFFD_MISSING);
>>>       }
>>>   -    inc_mm_counter(vma->vm_mm, MM_ANONPAGES);
>>> -    folio_add_new_anon_rmap(folio, vma, vmf->address);
>>> +    folio_ref_add(folio, nr_pages - 1);
>>> +    add_mm_counter(vma->vm_mm, MM_ANONPAGES, nr_pages);
>>> +    folio_add_new_anon_rmap(folio, vma, addr);
>>>       folio_add_lru_vma(folio, vma);
>>>   setpte:
>>>       if (uffd_wp)
>>>           entry = pte_mkuffd_wp(entry);
>>> -    set_pte_at(vma->vm_mm, vmf->address, vmf->pte, entry);
>>> +    set_ptes(vma->vm_mm, addr, vmf->pte, entry, nr_pages);
>>>         /* No need to invalidate - it was non-present before */
>>> -    update_mmu_cache_range(vmf, vma, vmf->address, vmf->pte, 1);
>>> +    update_mmu_cache_range(vmf, vma, addr, vmf->pte, nr_pages);
>>>   unlock:
>>>       if (vmf->pte)
>>>           pte_unmap_unlock(vmf->pte, vmf->ptl);
>>
>> Benchmarking order-0 allocations might be interesting. There will be some added
>> checks + multiple loops/conditionals for order-0 that could be avoided by having
>> two separate code paths. If we can't measure a difference, all good.
> 
> Yep will do - will post numbers once I have them. I've been assuming that the
> major cost is clearing the page, but perhaps I'm wrong.
> 
>>
> 

