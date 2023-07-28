Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EC0B7669F8
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 12:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235763AbjG1KNv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 06:13:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235690AbjG1KN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 06:13:28 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1B66035A3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 03:13:25 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9F2FC2F4;
        Fri, 28 Jul 2023 03:14:08 -0700 (PDT)
Received: from [10.57.77.173] (unknown [10.57.77.173])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 669EB3F67D;
        Fri, 28 Jul 2023 03:13:22 -0700 (PDT)
Message-ID: <8c0710e0-a75a-b315-dae1-dd93092e4bd6@arm.com>
Date:   Fri, 28 Jul 2023 11:13:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v4 2/5] mm: LARGE_ANON_FOLIO for improved performance
To:     Yu Zhao <yuzhao@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Yin Fengwei <fengwei.yin@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Itaru Kitayama <itaru.kitayama@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20230726095146.2826796-1-ryan.roberts@arm.com>
 <20230726095146.2826796-3-ryan.roberts@arm.com>
 <CAOUHufackQzy+yXOzaej+G6DNYK-k9GAUHAK6Vq79BFHr7KwAQ@mail.gmail.com>
 <CAOUHufZ70cMR=hnMW0_J9BeWRPwXVUDoeRhES+wq19r1SioGuA@mail.gmail.com>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <CAOUHufZ70cMR=hnMW0_J9BeWRPwXVUDoeRhES+wq19r1SioGuA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/07/2023 05:31, Yu Zhao wrote:
> On Wed, Jul 26, 2023 at 10:41 AM Yu Zhao <yuzhao@google.com> wrote:
>>
>> On Wed, Jul 26, 2023 at 3:52 AM Ryan Roberts <ryan.roberts@arm.com> wrote:
>>>
>>> Introduce LARGE_ANON_FOLIO feature, which allows anonymous memory to be
>>> allocated in large folios of a determined order. All pages of the large
>>> folio are pte-mapped during the same page fault, significantly reducing
>>> the number of page faults. The number of per-page operations (e.g. ref
>>> counting, rmap management lru list management) are also significantly
>>> reduced since those ops now become per-folio.
>>>
>>> The new behaviour is hidden behind the new LARGE_ANON_FOLIO Kconfig,
>>> which defaults to disabled for now; The long term aim is for this to
>>> defaut to enabled, but there are some risks around internal
>>> fragmentation that need to be better understood first.
>>>
>>> When enabled, the folio order is determined as such: For a vma, process
>>> or system that has explicitly disabled THP, we continue to allocate
>>> order-0. THP is most likely disabled to avoid any possible internal
>>> fragmentation so we honour that request.
>>>
>>> Otherwise, the return value of arch_wants_pte_order() is used. For vmas
>>> that have not explicitly opted-in to use transparent hugepages (e.g.
>>> where thp=madvise and the vma does not have MADV_HUGEPAGE), then
>>> arch_wants_pte_order() is limited to 64K (or PAGE_SIZE, whichever is
>>> bigger). This allows for a performance boost without requiring any
>>> explicit opt-in from the workload while limitting internal
>>> fragmentation.
>>>
>>> If the preferred order can't be used (e.g. because the folio would
>>> breach the bounds of the vma, or because ptes in the region are already
>>> mapped) then we fall back to a suitable lower order; first
>>> PAGE_ALLOC_COSTLY_ORDER, then order-0.
>>>
>>> arch_wants_pte_order() can be overridden by the architecture if desired.
>>> Some architectures (e.g. arm64) can coalsece TLB entries if a contiguous
>>> set of ptes map physically contigious, naturally aligned memory, so this
>>> mechanism allows the architecture to optimize as required.
>>>
>>> Here we add the default implementation of arch_wants_pte_order(), used
>>> when the architecture does not define it, which returns -1, implying
>>> that the HW has no preference. In this case, mm will choose it's own
>>> default order.
>>>
>>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>>> ---
>>>  include/linux/pgtable.h |  13 ++++
>>>  mm/Kconfig              |  10 +++
>>>  mm/memory.c             | 166 ++++++++++++++++++++++++++++++++++++----
>>>  3 files changed, 172 insertions(+), 17 deletions(-)
>>>
>>> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
>>> index 5063b482e34f..2a1d83775837 100644
>>> --- a/include/linux/pgtable.h
>>> +++ b/include/linux/pgtable.h
>>> @@ -313,6 +313,19 @@ static inline bool arch_has_hw_pte_young(void)
>>>  }
>>>  #endif
>>>
>>> +#ifndef arch_wants_pte_order
>>> +/*
>>> + * Returns preferred folio order for pte-mapped memory. Must be in range [0,
>>> + * PMD_SHIFT-PAGE_SHIFT) and must not be order-1 since THP requires large folios
>>> + * to be at least order-2. Negative value implies that the HW has no preference
>>> + * and mm will choose it's own default order.
>>> + */
>>> +static inline int arch_wants_pte_order(void)
>>> +{
>>> +       return -1;
>>> +}
>>> +#endif
>>> +
>>>  #ifndef __HAVE_ARCH_PTEP_GET_AND_CLEAR
>>>  static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
>>>                                        unsigned long address,
>>> diff --git a/mm/Kconfig b/mm/Kconfig
>>> index 09130434e30d..fa61ea160447 100644
>>> --- a/mm/Kconfig
>>> +++ b/mm/Kconfig
>>> @@ -1238,4 +1238,14 @@ config LOCK_MM_AND_FIND_VMA
>>>
>>>  source "mm/damon/Kconfig"
>>>
>>> +config LARGE_ANON_FOLIO
>>> +       bool "Allocate large folios for anonymous memory"
>>> +       depends on TRANSPARENT_HUGEPAGE
>>> +       default n
>>> +       help
>>> +         Use large (bigger than order-0) folios to back anonymous memory where
>>> +         possible, even for pte-mapped memory. This reduces the number of page
>>> +         faults, as well as other per-page overheads to improve performance for
>>> +         many workloads.
>>> +
>>>  endmenu
>>> diff --git a/mm/memory.c b/mm/memory.c
>>> index 01f39e8144ef..64c3f242c49a 100644
>>> --- a/mm/memory.c
>>> +++ b/mm/memory.c
>>> @@ -4050,6 +4050,127 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>>>         return ret;
>>>  }
>>>
>>> +static bool vmf_pte_range_changed(struct vm_fault *vmf, int nr_pages)
>>> +{
>>> +       int i;
>>> +
>>> +       if (nr_pages == 1)
>>> +               return vmf_pte_changed(vmf);
>>> +
>>> +       for (i = 0; i < nr_pages; i++) {
>>> +               if (!pte_none(ptep_get_lockless(vmf->pte + i)))
>>> +                       return true;
>>> +       }
>>> +
>>> +       return false;
>>> +}
>>> +
>>> +#ifdef CONFIG_LARGE_ANON_FOLIO
>>> +#define ANON_FOLIO_MAX_ORDER_UNHINTED \
>>> +               (ilog2(max_t(unsigned long, SZ_64K, PAGE_SIZE)) - PAGE_SHIFT)
>>> +
>>> +static int anon_folio_order(struct vm_area_struct *vma)
>>> +{
>>> +       int order;
>>> +
>>> +       /*
>>> +        * If THP is explicitly disabled for either the vma, the process or the
>>> +        * system, then this is very likely intended to limit internal
>>> +        * fragmentation; in this case, don't attempt to allocate a large
>>> +        * anonymous folio.
>>> +        *
>>> +        * Else, if the vma is eligible for thp, allocate a large folio of the
>>> +        * size preferred by the arch. Or if the arch requested a very small
>>> +        * size or didn't request a size, then use PAGE_ALLOC_COSTLY_ORDER,
>>> +        * which still meets the arch's requirements but means we still take
>>> +        * advantage of SW optimizations (e.g. fewer page faults).
>>> +        *
>>> +        * Finally if thp is enabled but the vma isn't eligible, take the
>>> +        * arch-preferred size and limit it to ANON_FOLIO_MAX_ORDER_UNHINTED.
>>> +        * This ensures workloads that have not explicitly opted-in take benefit
>>> +        * while capping the potential for internal fragmentation.
>>> +        */
>>
>> What empirical evidence is SZ_64K based on?
>> What workloads would benefit from it?
>> How much would they benefit from it?
>> Would they benefit more or less from different values?
>> How much internal fragmentation would it cause?
>> What cost function was used to arrive at the conclusion that its
>> benefits outweigh its costs?

Sorry this has taken a little while to reply to; I've been re-running my perf
tests with the modern patches to recomfirm old data.

In terms of empirical evidence, I've run the kernel compilation benchmark (yes I
know its a narrow use case, but I figure some data is better than no data), for
all values of ANON_FOLIO_MAX_ORDER_UNHINTED {4k, 16k, 32k, 64k, 128k, 256k}.

I've run each test 15 times across 5 system reboots on Ampere Altra (arm64),
with the kernel configured for 4K base pages - I could rerun for other base page
sizes if we want to go further down this route.

I've captured run time and peak memory usage, and taken the mean. The stdev for
the peak memory usage is big-ish, but I'm confident this still captures the
central tendancy well:

| MAX_ORDER_UNHINTED |   real-time |   kern-time |   user-time | peak memory |
|:-------------------|------------:|------------:|------------:|:------------|
| 4k                 |        0.0% |        0.0% |        0.0% |        0.0% |
| 16k                |       -3.6% |      -26.5% |       -0.5% |       -0.1% |
| 32k                |       -4.8% |      -37.4% |       -0.6% |       -0.1% |
| 64k                |       -5.7% |      -42.0% |       -0.6% |       -1.1% |
| 128k               |       -5.6% |      -42.1% |       -0.7% |        1.4% |
| 256k               |       -4.9% |      -41.9% |       -0.4% |        1.9% |

64K looks like the clear sweet spot to me.

I know you have argued for using a page order in the past, rather than a size in
bytes. But my argument is that user space is mostly doing mmaps based on sizes
independent of the base page size (an assumption!) and a system's memory is
obviously a fixed quantity that doesn't it doesn't change with base page size.
So it feels more natural to limit internal fragmentation based on an absolute
size rather than a quantity of pages. Kyril have also suggested using absolute
sizes in the past [1].

It's also worth mentioning that the file-backed memory "fault_around" mechanism
chooses 64K.

If this approach really looks unacceptable, I have a couple of other ideas. But
I personally favour the approach that is already in the patch.

1) Add a large/small flag to arch_wants_pte_order(). arm64, at least, actually
has 2 mechanisms, HPA and contpte. Currently arm64 is always returning the
contpte order, but with a flag, it could return contpte order for large, and HPA
order for small. (I know we previously passed the vma and we didn't like that,
and this is pretty similar). I still think the SW (core-mm) needs a way to
sensibly limit internal fragmentation though, so personally I still think having
an upper limit in this case is useful.

2) More radical: move to a per-vma auto-tuning solution, which looks at the
fault pattern and maintains an allocation order in the VMA, which is modified
based on fault pattern. e.g. When we get faults that occur immediately adjacent
to the allocated range, we increase; when we get faults not connected to
previously allocated pages we decrease. I think it's an interesting thing to
look at, but certainly prefer that it's not part of an MVP implementation.

[1]
https://lore.kernel.org/linux-mm/20230414140948.7pcaz6niyr2tpa7s@box.shutemov.name/


>>
>>> +       if ((vma->vm_flags & VM_NOHUGEPAGE) ||
>>> +           test_bit(MMF_DISABLE_THP, &vma->vm_mm->flags) ||
>>> +           !hugepage_flags_enabled())
>>> +               order = 0;
>>> +       else {
>>> +               order = max(arch_wants_pte_order(), PAGE_ALLOC_COSTLY_ORDER);
>>> +
>>> +               if (!hugepage_vma_check(vma, vma->vm_flags, false, true, true))
>>> +                       order = min(order, ANON_FOLIO_MAX_ORDER_UNHINTED);
>>> +       }
> 
> I'm a bit surprised to see the above: why can we overload existing
> ABIs? I don't think we can. 

I think this is all covered by the conversation with David against v2; see [2]
and proceeding replies. Argument is that VM_NOHUGEPAGE (and friends) is really a
request from user space to optimize for the least memory wastage possible and
avoid populating ptes that have not been expressly requested.

[2]
https://lore.kernel.org/linux-mm/524bacd2-4a47-2b8b-6685-c46e31a01631@redhat.com/

Assuming we could, you would have to
> update Documentation/admin-guide/mm/transhuge.rst in the same
> patchset, and the man page for madvise() in a separate patch.

Yes, that's a fair point. Although transhuge.rst doesn't even mention
MADV_NOHUGEPAGE today.

> 
> Most importantly, existing userspace programs that don't work well
> with THPs won't be able to use (try) large folios either -- this is a
> big no no.

I think we need some comments from David here. As mentioned I've added this
tie-in based on his (strong) recommendation.

> 
> 
> 
>>> +
>>> +       return order;
>>> +}
>>> +
>>> +static int alloc_anon_folio(struct vm_fault *vmf, struct folio **folio)
>>
>> static struct folio *alloc_anon_folio(struct vm_fault *vmf)
>>
>> and use ERR_PTR() and its friends.

Yes, agreed. I'll change this for the next version.

>>
>>> +{
>>> +       int i;
>>> +       gfp_t gfp;
>>> +       pte_t *pte;
>>> +       unsigned long addr;
>>> +       struct vm_area_struct *vma = vmf->vma;
>>> +       int prefer = anon_folio_order(vma);
>>> +       int orders[] = {
>>> +               prefer,
>>> +               prefer > PAGE_ALLOC_COSTLY_ORDER ? PAGE_ALLOC_COSTLY_ORDER : 0,
>>> +               0,
>>> +       };
>>> +
>>> +       *folio = NULL;
>>> +
>>> +       if (vmf_orig_pte_uffd_wp(vmf))
>>> +               goto fallback;
>>> +
>>> +       for (i = 0; orders[i]; i++) {
>>> +               addr = ALIGN_DOWN(vmf->address, PAGE_SIZE << orders[i]);
>>> +               if (addr >= vma->vm_start &&
>>> +                   addr + (PAGE_SIZE << orders[i]) <= vma->vm_end)
>>> +                       break;
>>> +       }
>>> +
>>> +       if (!orders[i])
>>> +               goto fallback;
>>> +
>>> +       pte = pte_offset_map(vmf->pmd, vmf->address & PMD_MASK);
>>> +       if (!pte)
>>> +               return -EAGAIN;
>>> +
>>> +       for (; orders[i]; i++) {
>>> +               addr = ALIGN_DOWN(vmf->address, PAGE_SIZE << orders[i]);
>>> +               vmf->pte = pte + pte_index(addr);
>>> +               if (!vmf_pte_range_changed(vmf, 1 << orders[i]))
>>> +                       break;
>>> +       }
>>> +
>>> +       vmf->pte = NULL;
>>> +       pte_unmap(pte);
>>> +
>>> +       gfp = vma_thp_gfp_mask(vma);
>>> +
>>> +       for (; orders[i]; i++) {
>>> +               addr = ALIGN_DOWN(vmf->address, PAGE_SIZE << orders[i]);
>>> +               *folio = vma_alloc_folio(gfp, orders[i], vma, addr, true);
>>> +               if (*folio) {
>>> +                       clear_huge_page(&(*folio)->page, addr, 1 << orders[i]);
>>> +                       return 0;
>>> +               }
>>> +       }
>>> +
>>> +fallback:
>>> +       *folio = vma_alloc_zeroed_movable_folio(vma, vmf->address);
>>> +       return *folio ? 0 : -ENOMEM;
>>> +}
>>> +#else
>>> +static inline int alloc_anon_folio(struct vm_fault *vmf, struct folio **folio)
>>> +{
>>> +       *folio = vma_alloc_zeroed_movable_folio(vmf->vma, vmf->address);
>>> +       return *folio ? 0 : -ENOMEM;
>>> +}
>>> +#endif
>>> +
>>>  /*
>>>   * We enter with non-exclusive mmap_lock (to exclude vma changes,
>>>   * but allow concurrent faults), and pte mapped but not yet locked.
>>> @@ -4057,6 +4178,9 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>>>   */
>>>  static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
>>>  {
>>> +       int i = 0;
>>> +       int nr_pages = 1;
>>> +       unsigned long addr = vmf->address;
>>>         bool uffd_wp = vmf_orig_pte_uffd_wp(vmf);
>>>         struct vm_area_struct *vma = vmf->vma;
>>>         struct folio *folio;
>>> @@ -4101,10 +4225,15 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
>>>         /* Allocate our own private page. */
>>>         if (unlikely(anon_vma_prepare(vma)))
>>>                 goto oom;
>>> -       folio = vma_alloc_zeroed_movable_folio(vma, vmf->address);
>>> +       ret = alloc_anon_folio(vmf, &folio);
>>> +       if (unlikely(ret == -EAGAIN))
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
>>> @@ -4116,17 +4245,12 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
>>>          */
>>>         __folio_mark_uptodate(folio);
>>>
>>> -       entry = mk_pte(&folio->page, vma->vm_page_prot);
>>> -       entry = pte_sw_mkyoung(entry);
>>> -       if (vma->vm_flags & VM_WRITE)
>>> -               entry = pte_mkwrite(pte_mkdirty(entry));
>>> -
>>> -       vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd, vmf->address,
>>> -                       &vmf->ptl);
>>> +       vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd, addr, &vmf->ptl);
>>>         if (!vmf->pte)
>>>                 goto release;
>>> -       if (vmf_pte_changed(vmf)) {
>>> -               update_mmu_tlb(vma, vmf->address, vmf->pte);
>>> +       if (vmf_pte_range_changed(vmf, nr_pages)) {
>>> +               for (i = 0; i < nr_pages; i++)
>>> +                       update_mmu_tlb(vma, addr + PAGE_SIZE * i, vmf->pte + i);
>>>                 goto release;
>>>         }
>>>
>>> @@ -4141,16 +4265,24 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
>>>                 return handle_userfault(vmf, VM_UFFD_MISSING);
>>>         }
>>>
>>> -       inc_mm_counter(vma->vm_mm, MM_ANONPAGES);
>>> -       folio_add_new_anon_rmap(folio, vma, vmf->address);
>>> +       folio_ref_add(folio, nr_pages - 1);
>>> +       add_mm_counter(vma->vm_mm, MM_ANONPAGES, nr_pages);
>>> +       folio_add_new_anon_rmap(folio, vma, addr);
>>>         folio_add_lru_vma(folio, vma);
>>> +
>>> +       for (i = 0; i < nr_pages; i++) {
>>> +               entry = mk_pte(folio_page(folio, i), vma->vm_page_prot);
>>> +               entry = pte_sw_mkyoung(entry);
>>> +               if (vma->vm_flags & VM_WRITE)
>>> +                       entry = pte_mkwrite(pte_mkdirty(entry));
>>>  setpte:
>>> -       if (uffd_wp)
>>> -               entry = pte_mkuffd_wp(entry);
>>> -       set_pte_at(vma->vm_mm, vmf->address, vmf->pte, entry);
>>> +               if (uffd_wp)
>>> +                       entry = pte_mkuffd_wp(entry);
>>> +               set_pte_at(vma->vm_mm, addr + PAGE_SIZE * i, vmf->pte + i, entry);
>>>
>>> -       /* No need to invalidate - it was non-present before */
>>> -       update_mmu_cache(vma, vmf->address, vmf->pte);
>>> +               /* No need to invalidate - it was non-present before */
>>> +               update_mmu_cache(vma, addr + PAGE_SIZE * i, vmf->pte + i);
>>> +       }
>>>  unlock:
>>>         if (vmf->pte)
>>>                 pte_unmap_unlock(vmf->pte, vmf->ptl);
>>
>> The rest looks good to me.

Thanks, as always, for the detailed review and feedback!

Thanks,
Ryan



