Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88E6F76E59D
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 12:27:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234783AbjHCK1B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 06:27:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235380AbjHCK02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 06:26:28 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D3BF13AB2
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 03:24:54 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6C929113E;
        Thu,  3 Aug 2023 03:25:37 -0700 (PDT)
Received: from [10.1.35.53] (C02Z41KALVDN.cambridge.arm.com [10.1.35.53])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4B7243F5A1;
        Thu,  3 Aug 2023 03:24:52 -0700 (PDT)
Message-ID: <5afdb9ee-e7c9-20c2-67c4-47b8ccab1661@arm.com>
Date:   Thu, 3 Aug 2023 11:24:50 +0100
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
 <CAOUHufZDt4i=YLpQCGTgsya+kfzDCJvYCE+-cXf0PUmFVpL9zg@mail.gmail.com>
 <c34282b6-fea4-248f-79a2-4a88006dd3b3@arm.com>
 <CAOUHufaVTmzfo30spZ0PN+WPkJoPOQqdQBzfrAoHh6QgMvZ2AA@mail.gmail.com>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <CAOUHufaVTmzfo30spZ0PN+WPkJoPOQqdQBzfrAoHh6QgMvZ2AA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/08/2023 22:05, Yu Zhao wrote:
> On Wed, Aug 2, 2023 at 3:33 AM Ryan Roberts <ryan.roberts@arm.com> wrote:
>>
>> On 01/08/2023 07:18, Yu Zhao wrote:
>>> On Wed, Jul 26, 2023 at 3:52 AM Ryan Roberts <ryan.roberts@arm.com> wrote:
>>>>
>>>> Introduce LARGE_ANON_FOLIO feature, which allows anonymous memory to be
>>>> allocated in large folios of a determined order. All pages of the large
>>>> folio are pte-mapped during the same page fault, significantly reducing
>>>> the number of page faults. The number of per-page operations (e.g. ref
>>>> counting, rmap management lru list management) are also significantly
>>>> reduced since those ops now become per-folio.
>>>>
>>>> The new behaviour is hidden behind the new LARGE_ANON_FOLIO Kconfig,
>>>> which defaults to disabled for now; The long term aim is for this to
>>>> defaut to enabled, but there are some risks around internal
>>>> fragmentation that need to be better understood first.
>>>>
>>>> When enabled, the folio order is determined as such: For a vma, process
>>>> or system that has explicitly disabled THP, we continue to allocate
>>>> order-0. THP is most likely disabled to avoid any possible internal
>>>> fragmentation so we honour that request.
>>>>
>>>> Otherwise, the return value of arch_wants_pte_order() is used. For vmas
>>>> that have not explicitly opted-in to use transparent hugepages (e.g.
>>>> where thp=madvise and the vma does not have MADV_HUGEPAGE), then
>>>> arch_wants_pte_order() is limited to 64K (or PAGE_SIZE, whichever is
>>>> bigger). This allows for a performance boost without requiring any
>>>> explicit opt-in from the workload while limitting internal
>>>> fragmentation.
>>>>
>>>> If the preferred order can't be used (e.g. because the folio would
>>>> breach the bounds of the vma, or because ptes in the region are already
>>>> mapped) then we fall back to a suitable lower order; first
>>>> PAGE_ALLOC_COSTLY_ORDER, then order-0.
>>>>
>>>> arch_wants_pte_order() can be overridden by the architecture if desired.
>>>> Some architectures (e.g. arm64) can coalsece TLB entries if a contiguous
>>>> set of ptes map physically contigious, naturally aligned memory, so this
>>>> mechanism allows the architecture to optimize as required.
>>>>
>>>> Here we add the default implementation of arch_wants_pte_order(), used
>>>> when the architecture does not define it, which returns -1, implying
>>>> that the HW has no preference. In this case, mm will choose it's own
>>>> default order.
>>>>
>>>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>>>> ---
>>>>  include/linux/pgtable.h |  13 ++++
>>>>  mm/Kconfig              |  10 +++
>>>>  mm/memory.c             | 166 ++++++++++++++++++++++++++++++++++++----
>>>>  3 files changed, 172 insertions(+), 17 deletions(-)
>>>>
>>>> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
>>>> index 5063b482e34f..2a1d83775837 100644
>>>> --- a/include/linux/pgtable.h
>>>> +++ b/include/linux/pgtable.h
>>>> @@ -313,6 +313,19 @@ static inline bool arch_has_hw_pte_young(void)
>>>>  }
>>>>  #endif
>>>>
>>>> +#ifndef arch_wants_pte_order
>>>> +/*
>>>> + * Returns preferred folio order for pte-mapped memory. Must be in range [0,
>>>> + * PMD_SHIFT-PAGE_SHIFT) and must not be order-1 since THP requires large folios
>>>> + * to be at least order-2. Negative value implies that the HW has no preference
>>>> + * and mm will choose it's own default order.
>>>> + */
>>>> +static inline int arch_wants_pte_order(void)
>>>> +{
>>>> +       return -1;
>>>> +}
>>>> +#endif
>>>> +
>>>>  #ifndef __HAVE_ARCH_PTEP_GET_AND_CLEAR
>>>>  static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
>>>>                                        unsigned long address,
>>>> diff --git a/mm/Kconfig b/mm/Kconfig
>>>> index 09130434e30d..fa61ea160447 100644
>>>> --- a/mm/Kconfig
>>>> +++ b/mm/Kconfig
>>>> @@ -1238,4 +1238,14 @@ config LOCK_MM_AND_FIND_VMA
>>>>
>>>>  source "mm/damon/Kconfig"
>>>>
>>>> +config LARGE_ANON_FOLIO
>>>> +       bool "Allocate large folios for anonymous memory"
>>>> +       depends on TRANSPARENT_HUGEPAGE
>>>> +       default n
>>>> +       help
>>>> +         Use large (bigger than order-0) folios to back anonymous memory where
>>>> +         possible, even for pte-mapped memory. This reduces the number of page
>>>> +         faults, as well as other per-page overheads to improve performance for
>>>> +         many workloads.
>>>> +
>>>>  endmenu
>>>> diff --git a/mm/memory.c b/mm/memory.c
>>>> index 01f39e8144ef..64c3f242c49a 100644
>>>> --- a/mm/memory.c
>>>> +++ b/mm/memory.c
>>>> @@ -4050,6 +4050,127 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>>>>         return ret;
>>>>  }
>>>>
>>>> +static bool vmf_pte_range_changed(struct vm_fault *vmf, int nr_pages)
>>>> +{
>>>> +       int i;
>>>> +
>>>> +       if (nr_pages == 1)
>>>> +               return vmf_pte_changed(vmf);
>>>> +
>>>> +       for (i = 0; i < nr_pages; i++) {
>>>> +               if (!pte_none(ptep_get_lockless(vmf->pte + i)))
>>>> +                       return true;
>>>> +       }
>>>> +
>>>> +       return false;
>>>> +}
>>>> +
>>>> +#ifdef CONFIG_LARGE_ANON_FOLIO
>>>> +#define ANON_FOLIO_MAX_ORDER_UNHINTED \
>>>> +               (ilog2(max_t(unsigned long, SZ_64K, PAGE_SIZE)) - PAGE_SHIFT)
>>>> +
>>>> +static int anon_folio_order(struct vm_area_struct *vma)
>>>> +{
>>>> +       int order;
>>>> +
>>>> +       /*
>>>> +        * If THP is explicitly disabled for either the vma, the process or the
>>>> +        * system, then this is very likely intended to limit internal
>>>> +        * fragmentation; in this case, don't attempt to allocate a large
>>>> +        * anonymous folio.
>>>> +        *
>>>> +        * Else, if the vma is eligible for thp, allocate a large folio of the
>>>> +        * size preferred by the arch. Or if the arch requested a very small
>>>> +        * size or didn't request a size, then use PAGE_ALLOC_COSTLY_ORDER,
>>>> +        * which still meets the arch's requirements but means we still take
>>>> +        * advantage of SW optimizations (e.g. fewer page faults).
>>>> +        *
>>>> +        * Finally if thp is enabled but the vma isn't eligible, take the
>>>> +        * arch-preferred size and limit it to ANON_FOLIO_MAX_ORDER_UNHINTED.
>>>> +        * This ensures workloads that have not explicitly opted-in take benefit
>>>> +        * while capping the potential for internal fragmentation.
>>>> +        */
>>>> +
>>>> +       if ((vma->vm_flags & VM_NOHUGEPAGE) ||
>>>> +           test_bit(MMF_DISABLE_THP, &vma->vm_mm->flags) ||
>>>> +           !hugepage_flags_enabled())
>>>> +               order = 0;
>>>> +       else {
>>>> +               order = max(arch_wants_pte_order(), PAGE_ALLOC_COSTLY_ORDER);
>>>> +
>>>> +               if (!hugepage_vma_check(vma, vma->vm_flags, false, true, true))
>>>> +                       order = min(order, ANON_FOLIO_MAX_ORDER_UNHINTED);
>>>> +       }
>>>> +
>>>> +       return order;
>>>> +}
>>>> +
>>>> +static int alloc_anon_folio(struct vm_fault *vmf, struct folio **folio)
>>>> +{
>>>> +       int i;
>>>> +       gfp_t gfp;
>>>> +       pte_t *pte;
>>>> +       unsigned long addr;
>>>> +       struct vm_area_struct *vma = vmf->vma;
>>>> +       int prefer = anon_folio_order(vma);
>>>> +       int orders[] = {
>>>> +               prefer,
>>>> +               prefer > PAGE_ALLOC_COSTLY_ORDER ? PAGE_ALLOC_COSTLY_ORDER : 0,
>>>> +               0,
>>>> +       };
>>>> +
>>>> +       *folio = NULL;
>>>> +
>>>> +       if (vmf_orig_pte_uffd_wp(vmf))
>>>> +               goto fallback;
>>>
>>> I think we need to s/vmf_orig_pte_uffd_wp/userfaultfd_armed/ here;
>>> otherwise UFFD would miss VM_UFFD_MISSING/MINOR.
>>
>> I don't think this is the case. As far as I can see, VM_UFFD_MINOR only applies
>> to shmem and hugetlb.
> 
> Correct, but we don't have a helper to check against (VM_UFFD_WP |
> VM_UFFD_MISSING). Reusing userfaultfd_armed() seems cleaner to me or
> even future proof.
> 
>> VM_UFFD_MISSING is checked under the PTL and if set on the
>> VMA, then it is handled without mapping the folio that was just allocated:
>>
>>         /* Deliver the page fault to userland, check inside PT lock */
>>         if (userfaultfd_missing(vma)) {
>>                 pte_unmap_unlock(vmf->pte, vmf->ptl);
>>                 folio_put(folio);
>>                 return handle_userfault(vmf, VM_UFFD_MISSING);
>>         }
>>
>> So we are racing to allocate a large folio; if the vma later turns out to have
>> MISSING handling registered, we drop the folio and handle it, else we map the
>> large folio.
> 
> Yes, then we have allocated a large folio (with great effort if under
> heavy memory pressure) for nothing.
> 
>> The vmf_orig_pte_uffd_wp() *is* required because we need to individually check
>> each PTE for the uffd_wp bit and fix it up.
> 
> This is not correct: we cannot see a WP PTE before you see
> VM_UFFD_WP. So checking VM_UFFD_WP is perfectly safe.

I think you misunderstood me; I was trying to say that assuming we don't check
userfaultfd_armed() then we need the vmf_orig_pte_uffd_wp() check because we
need to ensure that the marker gets preserved for that specific pte and we can
only do that if we are operating on a single pte.

> 
> The reason we might want to check individual PTEs is because WP can be
> done to a subrange of a VMA that has VM_UFFD_WP, which I don't think
> is the common case and worth considering here. But if you want to keep
> it, that's fine with me. Without some comments, the next person might
> find these two checks confusing though, if you plan to add both.

I'm not proposing we need both checks.

> 
>> So I think the code is correct, but perhaps it is safer/simpler to always avoid
>> allocating a large folio if the vma is registered for uffd in the way you
>> suggest? I don't know enough about uffd to form a strong opinion either way.
> 
> Yes, it's not about correctness. Just a second thought about not
> allocating large folios unnecessarily when possible.

OK, I misunderstood you; I thought your original point is about correctness.

Anyway, you have convinced me that we should
s/vmf_orig_pte_uffd_wp/userfaultfd_armed/ on the grounds that trying hard to
allocate a high order folio is almost always going to be a waste of effort. I'll
change this in the next version.

Thanks,
Ryan



