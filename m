Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 581C276C987
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 11:33:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234149AbjHBJdV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 05:33:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231753AbjHBJdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 05:33:20 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C5B60E7
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 02:33:18 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C1262113E;
        Wed,  2 Aug 2023 02:34:01 -0700 (PDT)
Received: from [10.57.77.90] (unknown [10.57.77.90])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B48CE3F5A1;
        Wed,  2 Aug 2023 02:33:14 -0700 (PDT)
Message-ID: <c34282b6-fea4-248f-79a2-4a88006dd3b3@arm.com>
Date:   Wed, 2 Aug 2023 10:33:12 +0100
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
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <CAOUHufZDt4i=YLpQCGTgsya+kfzDCJvYCE+-cXf0PUmFVpL9zg@mail.gmail.com>
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

On 01/08/2023 07:18, Yu Zhao wrote:
> On Wed, Jul 26, 2023 at 3:52 AM Ryan Roberts <ryan.roberts@arm.com> wrote:
>>
>> Introduce LARGE_ANON_FOLIO feature, which allows anonymous memory to be
>> allocated in large folios of a determined order. All pages of the large
>> folio are pte-mapped during the same page fault, significantly reducing
>> the number of page faults. The number of per-page operations (e.g. ref
>> counting, rmap management lru list management) are also significantly
>> reduced since those ops now become per-folio.
>>
>> The new behaviour is hidden behind the new LARGE_ANON_FOLIO Kconfig,
>> which defaults to disabled for now; The long term aim is for this to
>> defaut to enabled, but there are some risks around internal
>> fragmentation that need to be better understood first.
>>
>> When enabled, the folio order is determined as such: For a vma, process
>> or system that has explicitly disabled THP, we continue to allocate
>> order-0. THP is most likely disabled to avoid any possible internal
>> fragmentation so we honour that request.
>>
>> Otherwise, the return value of arch_wants_pte_order() is used. For vmas
>> that have not explicitly opted-in to use transparent hugepages (e.g.
>> where thp=madvise and the vma does not have MADV_HUGEPAGE), then
>> arch_wants_pte_order() is limited to 64K (or PAGE_SIZE, whichever is
>> bigger). This allows for a performance boost without requiring any
>> explicit opt-in from the workload while limitting internal
>> fragmentation.
>>
>> If the preferred order can't be used (e.g. because the folio would
>> breach the bounds of the vma, or because ptes in the region are already
>> mapped) then we fall back to a suitable lower order; first
>> PAGE_ALLOC_COSTLY_ORDER, then order-0.
>>
>> arch_wants_pte_order() can be overridden by the architecture if desired.
>> Some architectures (e.g. arm64) can coalsece TLB entries if a contiguous
>> set of ptes map physically contigious, naturally aligned memory, so this
>> mechanism allows the architecture to optimize as required.
>>
>> Here we add the default implementation of arch_wants_pte_order(), used
>> when the architecture does not define it, which returns -1, implying
>> that the HW has no preference. In this case, mm will choose it's own
>> default order.
>>
>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>> ---
>>  include/linux/pgtable.h |  13 ++++
>>  mm/Kconfig              |  10 +++
>>  mm/memory.c             | 166 ++++++++++++++++++++++++++++++++++++----
>>  3 files changed, 172 insertions(+), 17 deletions(-)
>>
>> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
>> index 5063b482e34f..2a1d83775837 100644
>> --- a/include/linux/pgtable.h
>> +++ b/include/linux/pgtable.h
>> @@ -313,6 +313,19 @@ static inline bool arch_has_hw_pte_young(void)
>>  }
>>  #endif
>>
>> +#ifndef arch_wants_pte_order
>> +/*
>> + * Returns preferred folio order for pte-mapped memory. Must be in range [0,
>> + * PMD_SHIFT-PAGE_SHIFT) and must not be order-1 since THP requires large folios
>> + * to be at least order-2. Negative value implies that the HW has no preference
>> + * and mm will choose it's own default order.
>> + */
>> +static inline int arch_wants_pte_order(void)
>> +{
>> +       return -1;
>> +}
>> +#endif
>> +
>>  #ifndef __HAVE_ARCH_PTEP_GET_AND_CLEAR
>>  static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
>>                                        unsigned long address,
>> diff --git a/mm/Kconfig b/mm/Kconfig
>> index 09130434e30d..fa61ea160447 100644
>> --- a/mm/Kconfig
>> +++ b/mm/Kconfig
>> @@ -1238,4 +1238,14 @@ config LOCK_MM_AND_FIND_VMA
>>
>>  source "mm/damon/Kconfig"
>>
>> +config LARGE_ANON_FOLIO
>> +       bool "Allocate large folios for anonymous memory"
>> +       depends on TRANSPARENT_HUGEPAGE
>> +       default n
>> +       help
>> +         Use large (bigger than order-0) folios to back anonymous memory where
>> +         possible, even for pte-mapped memory. This reduces the number of page
>> +         faults, as well as other per-page overheads to improve performance for
>> +         many workloads.
>> +
>>  endmenu
>> diff --git a/mm/memory.c b/mm/memory.c
>> index 01f39e8144ef..64c3f242c49a 100644
>> --- a/mm/memory.c
>> +++ b/mm/memory.c
>> @@ -4050,6 +4050,127 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>>         return ret;
>>  }
>>
>> +static bool vmf_pte_range_changed(struct vm_fault *vmf, int nr_pages)
>> +{
>> +       int i;
>> +
>> +       if (nr_pages == 1)
>> +               return vmf_pte_changed(vmf);
>> +
>> +       for (i = 0; i < nr_pages; i++) {
>> +               if (!pte_none(ptep_get_lockless(vmf->pte + i)))
>> +                       return true;
>> +       }
>> +
>> +       return false;
>> +}
>> +
>> +#ifdef CONFIG_LARGE_ANON_FOLIO
>> +#define ANON_FOLIO_MAX_ORDER_UNHINTED \
>> +               (ilog2(max_t(unsigned long, SZ_64K, PAGE_SIZE)) - PAGE_SHIFT)
>> +
>> +static int anon_folio_order(struct vm_area_struct *vma)
>> +{
>> +       int order;
>> +
>> +       /*
>> +        * If THP is explicitly disabled for either the vma, the process or the
>> +        * system, then this is very likely intended to limit internal
>> +        * fragmentation; in this case, don't attempt to allocate a large
>> +        * anonymous folio.
>> +        *
>> +        * Else, if the vma is eligible for thp, allocate a large folio of the
>> +        * size preferred by the arch. Or if the arch requested a very small
>> +        * size or didn't request a size, then use PAGE_ALLOC_COSTLY_ORDER,
>> +        * which still meets the arch's requirements but means we still take
>> +        * advantage of SW optimizations (e.g. fewer page faults).
>> +        *
>> +        * Finally if thp is enabled but the vma isn't eligible, take the
>> +        * arch-preferred size and limit it to ANON_FOLIO_MAX_ORDER_UNHINTED.
>> +        * This ensures workloads that have not explicitly opted-in take benefit
>> +        * while capping the potential for internal fragmentation.
>> +        */
>> +
>> +       if ((vma->vm_flags & VM_NOHUGEPAGE) ||
>> +           test_bit(MMF_DISABLE_THP, &vma->vm_mm->flags) ||
>> +           !hugepage_flags_enabled())
>> +               order = 0;
>> +       else {
>> +               order = max(arch_wants_pte_order(), PAGE_ALLOC_COSTLY_ORDER);
>> +
>> +               if (!hugepage_vma_check(vma, vma->vm_flags, false, true, true))
>> +                       order = min(order, ANON_FOLIO_MAX_ORDER_UNHINTED);
>> +       }
>> +
>> +       return order;
>> +}
>> +
>> +static int alloc_anon_folio(struct vm_fault *vmf, struct folio **folio)
>> +{
>> +       int i;
>> +       gfp_t gfp;
>> +       pte_t *pte;
>> +       unsigned long addr;
>> +       struct vm_area_struct *vma = vmf->vma;
>> +       int prefer = anon_folio_order(vma);
>> +       int orders[] = {
>> +               prefer,
>> +               prefer > PAGE_ALLOC_COSTLY_ORDER ? PAGE_ALLOC_COSTLY_ORDER : 0,
>> +               0,
>> +       };
>> +
>> +       *folio = NULL;
>> +
>> +       if (vmf_orig_pte_uffd_wp(vmf))
>> +               goto fallback;
> 
> I think we need to s/vmf_orig_pte_uffd_wp/userfaultfd_armed/ here;
> otherwise UFFD would miss VM_UFFD_MISSING/MINOR.

I don't think this is the case. As far as I can see, VM_UFFD_MINOR only applies
to shmem and hugetlb. VM_UFFD_MISSING is checked under the PTL and if set on the
VMA, then it is handled without mapping the folio that was just allocated:

	/* Deliver the page fault to userland, check inside PT lock */
	if (userfaultfd_missing(vma)) {
		pte_unmap_unlock(vmf->pte, vmf->ptl);
		folio_put(folio);
		return handle_userfault(vmf, VM_UFFD_MISSING);
	}

So we are racing to allocate a large folio; if the vma later turns out to have
MISSING handling registered, we drop the folio and handle it, else we map the
large folio.

The vmf_orig_pte_uffd_wp() *is* required because we need to individually check
each PTE for the uffd_wp bit and fix it up.

So I think the code is correct, but perhaps it is safer/simpler to always avoid
allocating a large folio if the vma is registered for uffd in the way you
suggest? I don't know enough about uffd to form a strong opinion either way.

