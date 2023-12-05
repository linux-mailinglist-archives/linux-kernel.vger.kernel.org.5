Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B40C2805120
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 11:48:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344959AbjLEKsc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 05:48:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235072AbjLEKs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 05:48:29 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 40516B9
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 02:48:34 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7A84B139F;
        Tue,  5 Dec 2023 02:49:20 -0800 (PST)
Received: from [10.57.73.130] (unknown [10.57.73.130])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2162D3F5A1;
        Tue,  5 Dec 2023 02:48:30 -0800 (PST)
Message-ID: <5216caaf-1fcf-4715-99c3-521e2a1cc756@arm.com>
Date:   Tue, 5 Dec 2023 10:48:28 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 04/10] mm: thp: Support allocation of anonymous
 multi-size THP
Content-Language: en-GB
To:     Barry Song <21cnbao@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Yin Fengwei <fengwei.yin@intel.com>,
        David Hildenbrand <david@redhat.com>,
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
        Alistair Popple <apopple@nvidia.com>, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20231204102027.57185-1-ryan.roberts@arm.com>
 <20231204102027.57185-5-ryan.roberts@arm.com>
 <CAGsJ_4zG6W_Z-u+3QcRDn4ByoeqUXjMusNS0RotfRMSqo8RCHg@mail.gmail.com>
 <CAGsJ_4zYhJWGx1DnHTiDnP3h1m8_rr6ZT6fXt8pO=jzs9QZS-A@mail.gmail.com>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <CAGsJ_4zYhJWGx1DnHTiDnP3h1m8_rr6ZT6fXt8pO=jzs9QZS-A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/12/2023 01:24, Barry Song wrote:
> On Tue, Dec 5, 2023 at 9:15 AM Barry Song <21cnbao@gmail.com> wrote:
>>
>> On Mon, Dec 4, 2023 at 6:21 PM Ryan Roberts <ryan.roberts@arm.com> wrote:
>>>
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
>>> ---
>>>  include/linux/huge_mm.h |   6 ++-
>>>  mm/memory.c             | 106 ++++++++++++++++++++++++++++++++++++----
>>>  2 files changed, 101 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
>>> index bd0eadd3befb..91a53b9835a4 100644
>>> --- a/include/linux/huge_mm.h
>>> +++ b/include/linux/huge_mm.h
>>> @@ -68,9 +68,11 @@ extern struct kobj_attribute shmem_enabled_attr;
>>>  #define HPAGE_PMD_NR (1<<HPAGE_PMD_ORDER)
>>>
>>>  /*
>>> - * Mask of all large folio orders supported for anonymous THP.
>>> + * Mask of all large folio orders supported for anonymous THP; all orders up to
>>> + * and including PMD_ORDER, except order-0 (which is not "huge") and order-1
>>> + * (which is a limitation of the THP implementation).
>>>   */
>>> -#define THP_ORDERS_ALL_ANON    BIT(PMD_ORDER)
>>> +#define THP_ORDERS_ALL_ANON    ((BIT(PMD_ORDER + 1) - 1) & ~(BIT(0) | BIT(1)))
>>>
>>>  /*
>>>   * Mask of all large folio orders supported for file THP.
>>> diff --git a/mm/memory.c b/mm/memory.c
>>> index 3ceeb0f45bf5..bf7e93813018 100644
>>> --- a/mm/memory.c
>>> +++ b/mm/memory.c
>>> @@ -4125,6 +4125,84 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>>>         return ret;
>>>  }
>>>
>>> +static bool pte_range_none(pte_t *pte, int nr_pages)
>>> +{
>>> +       int i;
>>> +
>>> +       for (i = 0; i < nr_pages; i++) {
>>> +               if (!pte_none(ptep_get_lockless(pte + i)))
>>> +                       return false;
>>> +       }
>>> +
>>> +       return true;
>>> +}
>>> +
>>> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
>>> +static struct folio *alloc_anon_folio(struct vm_fault *vmf)
>>> +{
>>> +       gfp_t gfp;
>>> +       pte_t *pte;
>>> +       unsigned long addr;
>>> +       struct folio *folio;
>>> +       struct vm_area_struct *vma = vmf->vma;
>>> +       unsigned long orders;
>>> +       int order;
>>> +
>>> +       /*
>>> +        * If uffd is active for the vma we need per-page fault fidelity to
>>> +        * maintain the uffd semantics.
>>> +        */
>>> +       if (userfaultfd_armed(vma))
>>> +               goto fallback;
>>> +
>>> +       /*
>>> +        * Get a list of all the (large) orders below PMD_ORDER that are enabled
>>> +        * for this vma. Then filter out the orders that can't be allocated over
>>> +        * the faulting address and still be fully contained in the vma.
>>> +        */
>>> +       orders = thp_vma_allowable_orders(vma, vma->vm_flags, false, true, true,
>>> +                                         BIT(PMD_ORDER) - 1);
>>> +       orders = thp_vma_suitable_orders(vma, vmf->address, orders);
>>> +
>>> +       if (!orders)
>>> +               goto fallback;
>>> +
>>> +       pte = pte_offset_map(vmf->pmd, vmf->address & PMD_MASK);
>>> +       if (!pte)
>>> +               return ERR_PTR(-EAGAIN);
>>> +
>>> +       order = first_order(orders);
>>> +       while (orders) {
>>> +               addr = ALIGN_DOWN(vmf->address, PAGE_SIZE << order);
>>> +               vmf->pte = pte + pte_index(addr);
>>> +               if (pte_range_none(vmf->pte, 1 << order))
>>> +                       break;
>>> +               order = next_order(&orders, order);
>>> +       }
>>> +
>>> +       vmf->pte = NULL;
>>> +       pte_unmap(pte);
>>> +
>>> +       gfp = vma_thp_gfp_mask(vma);
>>> +
>>> +       while (orders) {
>>> +               addr = ALIGN_DOWN(vmf->address, PAGE_SIZE << order);
>>> +               folio = vma_alloc_folio(gfp, order, vma, addr, true);
>>> +               if (folio) {
>>> +                       clear_huge_page(&folio->page, addr, 1 << order);
>>
>> Minor.
>>
>> Do we have to constantly clear a huge page? Is it possible to let
>> post_alloc_hook()
>> finish this job by using __GFP_ZERO/__GFP_ZEROTAGS as
>> vma_alloc_zeroed_movable_folio() is doing?

I'm currently following the same allocation pattern as is done for PMD-sized
THP. In earlier versions of this patch I was trying to be smarter and use the
__GFP_ZERO/__GFP_ZEROTAGS as you suggest, but I was advised to keep it simple
and follow the existing pattern.

I have a vague recollection __GFP_ZERO is not preferred for large folios because
of some issue with virtually indexed caches? (Matthew: did I see you mention
that in some other context?)

That said, I wasn't aware that Android ships with
CONFIG_INIT_ON_ALLOC_DEFAULT_ON (I thought it was only used as a debug option),
so I can see the potential for some overhead reduction here.

Options:

 1) leave it as is and accept the duplicated clearing
 2) Pass __GFP_ZERO and remove clear_huge_page()
 3) define __GFP_SKIP_ZERO even when kasan is not enabled and pass it down so
    clear_huge_page() is the only clear
 4) make clear_huge_page() conditional on !want_init_on_alloc()

I prefer option 4. What do you think?

As an aside, I've also noticed that clear_huge_page() should take vmf->address
so that it clears the faulting page last to keep the cache hot. If we decide on
an option that keeps clear_huge_page(), I'll also make that change.

Thanks,
Ryan

>>
>> struct folio *vma_alloc_zeroed_movable_folio(struct vm_area_struct *vma,
>>                                                 unsigned long vaddr)
>> {
>>         gfp_t flags = GFP_HIGHUSER_MOVABLE | __GFP_ZERO;
>>
>>         /*
>>          * If the page is mapped with PROT_MTE, initialise the tags at the
>>          * point of allocation and page zeroing as this is usually faster than
>>          * separate DC ZVA and STGM.
>>          */
>>         if (vma->vm_flags & VM_MTE)
>>                 flags |= __GFP_ZEROTAGS;
>>
>>         return vma_alloc_folio(flags, 0, vma, vaddr, false);
>> }
> 
> I am asking this because Android and some other kernels might always set
> CONFIG_INIT_ON_ALLOC_DEFAULT_ON, that means one more explicit
> clear_page is doing a duplicated job.
> 
> when the below is true, post_alloc_hook has cleared huge_page before
> vma_alloc_folio() returns the folio,
> 
> static inline bool want_init_on_alloc(gfp_t flags)
> {
>         if (static_branch_maybe(CONFIG_INIT_ON_ALLOC_DEFAULT_ON,
>                                 &init_on_alloc))
>                 return true;
>         return flags & __GFP_ZERO;
> }
> 
> 
>>
>>> +                       return folio;
>>> +               }
>>> +               order = next_order(&orders, order);
>>> +       }
>>> +
>>> +fallback:
>>> +       return vma_alloc_zeroed_movable_folio(vma, vmf->address);
>>> +}
>>> +#else
>>> +#define alloc_anon_folio(vmf) \
>>> +               vma_alloc_zeroed_movable_folio((vmf)->vma, (vmf)->address)
>>> +#endif
>>> +
>>>  /*
>>>   * We enter with non-exclusive mmap_lock (to exclude vma changes,
>>>   * but allow concurrent faults), and pte mapped but not yet locked.
>>> @@ -4132,6 +4210,9 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>>>   */
>>>  static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
>>>  {
>>> +       int i;
>>> +       int nr_pages = 1;
>>> +       unsigned long addr = vmf->address;
>>>         bool uffd_wp = vmf_orig_pte_uffd_wp(vmf);
>>>         struct vm_area_struct *vma = vmf->vma;
>>>         struct folio *folio;
>>> @@ -4176,10 +4257,15 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
>>>         /* Allocate our own private page. */
>>>         if (unlikely(anon_vma_prepare(vma)))
>>>                 goto oom;
>>> -       folio = vma_alloc_zeroed_movable_folio(vma, vmf->address);
>>> +       folio = alloc_anon_folio(vmf);
>>> +       if (IS_ERR(folio))
>>> +               return 0;
>>>         if (!folio)
>>>                 goto oom;
>>>
>>> +       nr_pages = folio_nr_pages(folio);
>>> +       addr = ALIGN_DOWN(vmf->address, nr_pages * PAGE_SIZE);
>>> +
>>>         if (mem_cgroup_charge(folio, vma->vm_mm, GFP_KERNEL))
>>>                 goto oom_free_page;
>>>         folio_throttle_swaprate(folio, GFP_KERNEL);
>>> @@ -4196,12 +4282,13 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
>>>         if (vma->vm_flags & VM_WRITE)
>>>                 entry = pte_mkwrite(pte_mkdirty(entry), vma);
>>>
>>> -       vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd, vmf->address,
>>> -                       &vmf->ptl);
>>> +       vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd, addr, &vmf->ptl);
>>>         if (!vmf->pte)
>>>                 goto release;
>>> -       if (vmf_pte_changed(vmf)) {
>>> -               update_mmu_tlb(vma, vmf->address, vmf->pte);
>>> +       if ((nr_pages == 1 && vmf_pte_changed(vmf)) ||
>>> +           (nr_pages  > 1 && !pte_range_none(vmf->pte, nr_pages))) {
>>> +               for (i = 0; i < nr_pages; i++)
>>> +                       update_mmu_tlb(vma, addr + PAGE_SIZE * i, vmf->pte + i);
>>>                 goto release;
>>>         }
>>>
>>> @@ -4216,16 +4303,17 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
>>>                 return handle_userfault(vmf, VM_UFFD_MISSING);
>>>         }
>>>
>>> -       inc_mm_counter(vma->vm_mm, MM_ANONPAGES);
>>> -       folio_add_new_anon_rmap(folio, vma, vmf->address);
>>> +       folio_ref_add(folio, nr_pages - 1);
>>> +       add_mm_counter(vma->vm_mm, MM_ANONPAGES, nr_pages);
>>> +       folio_add_new_anon_rmap(folio, vma, addr);
>>>         folio_add_lru_vma(folio, vma);
>>>  setpte:
>>>         if (uffd_wp)
>>>                 entry = pte_mkuffd_wp(entry);
>>> -       set_pte_at(vma->vm_mm, vmf->address, vmf->pte, entry);
>>> +       set_ptes(vma->vm_mm, addr, vmf->pte, entry, nr_pages);
>>>
>>>         /* No need to invalidate - it was non-present before */
>>> -       update_mmu_cache_range(vmf, vma, vmf->address, vmf->pte, 1);
>>> +       update_mmu_cache_range(vmf, vma, addr, vmf->pte, nr_pages);
>>>  unlock:
>>>         if (vmf->pte)
>>>                 pte_unmap_unlock(vmf->pte, vmf->ptl);
>>> --
>>> 2.25.1
>>>

