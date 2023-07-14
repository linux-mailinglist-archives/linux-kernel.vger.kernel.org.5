Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18B0D75420C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 20:01:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236562AbjGNSBe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 14:01:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236448AbjGNSB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 14:01:29 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C974730DF
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 11:00:58 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7CC451570;
        Fri, 14 Jul 2023 11:00:29 -0700 (PDT)
Received: from [10.57.76.27] (unknown [10.57.76.27])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 93F7F3F67D;
        Fri, 14 Jul 2023 10:59:44 -0700 (PDT)
Message-ID: <432490d1-8d1e-1742-295a-d6e60a054ab6@arm.com>
Date:   Fri, 14 Jul 2023 18:59:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v3 3/4] mm: FLEXIBLE_THP for improved performance
To:     Yu Zhao <yuzhao@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yin Fengwei <fengwei.yin@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <20230714160407.4142030-1-ryan.roberts@arm.com>
 <20230714161733.4144503-3-ryan.roberts@arm.com>
 <CAOUHufacQ8Vx9WQ3BVjGGWKGhcRkL7u79UMX=O7oePDwZ0iNxw@mail.gmail.com>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <CAOUHufacQ8Vx9WQ3BVjGGWKGhcRkL7u79UMX=O7oePDwZ0iNxw@mail.gmail.com>
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

On 14/07/2023 18:17, Yu Zhao wrote:
> On Fri, Jul 14, 2023 at 10:17 AM Ryan Roberts <ryan.roberts@arm.com> wrote:
>>
>> Introduce FLEXIBLE_THP feature, which allows anonymous memory to be
>> allocated in large folios of a determined order. All pages of the large
>> folio are pte-mapped during the same page fault, significantly reducing
>> the number of page faults. The number of per-page operations (e.g. ref
>> counting, rmap management lru list management) are also significantly
>> reduced since those ops now become per-folio.
>>
>> The new behaviour is hidden behind the new FLEXIBLE_THP Kconfig, which
>> defaults to disabled for now; The long term aim is for this to defaut to
>> enabled, but there are some risks around internal fragmentation that
>> need to be better understood first.
>>
>> When enabled, the folio order is determined as such: For a vma, process
>> or system that has explicitly disabled THP, we continue to allocate
>> order-0. THP is most likely disabled to avoid any possible internal
>> fragmentation so we honour that request.
>>
>> Otherwise, the return value of arch_wants_pte_order() is used. For vmas
>> that have not explicitly opted-in to use transparent hugepages (e.g.
>> where thp=madvise and the vma does not have MADV_HUGEPAGE), then
>> arch_wants_pte_order() is limited by the new cmdline parameter,
>> `flexthp_unhinted_max`. This allows for a performance boost without
>> requiring any explicit opt-in from the workload while allowing the
>> sysadmin to tune between performance and internal fragmentation.
>>
>> arch_wants_pte_order() can be overridden by the architecture if desired.
>> Some architectures (e.g. arm64) can coalsece TLB entries if a contiguous
>> set of ptes map physically contigious, naturally aligned memory, so this
>> mechanism allows the architecture to optimize as required.
>>
>> If the preferred order can't be used (e.g. because the folio would
>> breach the bounds of the vma, or because ptes in the region are already
>> mapped) then we fall back to a suitable lower order; first
>> PAGE_ALLOC_COSTLY_ORDER, then order-0.
>>
>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>> ---
>>  .../admin-guide/kernel-parameters.txt         |  10 +
>>  mm/Kconfig                                    |  10 +
>>  mm/memory.c                                   | 187 ++++++++++++++++--
>>  3 files changed, 190 insertions(+), 17 deletions(-)
>>
>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>> index a1457995fd41..405d624e2191 100644
>> --- a/Documentation/admin-guide/kernel-parameters.txt
>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>> @@ -1497,6 +1497,16 @@
>>                         See Documentation/admin-guide/sysctl/net.rst for
>>                         fb_tunnels_only_for_init_ns
>>
>> +       flexthp_unhinted_max=
>> +                       [KNL] Requires CONFIG_FLEXIBLE_THP enabled. The maximum
>> +                       folio size that will be allocated for an anonymous vma
>> +                       that has neither explicitly opted in nor out of using
>> +                       transparent hugepages. The size must be a power-of-2 in
>> +                       the range [PAGE_SIZE, PMD_SIZE). A larger size improves
>> +                       performance by reducing page faults, while a smaller
>> +                       size reduces internal fragmentation. Default: max(64K,
>> +                       PAGE_SIZE). Format: size[KMG].
>> +
> 
> Let's split this parameter into a separate patch.

Ha - I had it as a separate patch originally, but thought you'd ask for it to be
a single patch so squashed it ;-). I can separate it again, no problem.

> 
> And I'm going to ask many questions about it (I can live with a sysctl
> parameter but this boot parameter is unacceptable to me).

Please do. Hopefully the thread with DavidH against v2 gives the rationale. Care
to elaborate on why its unacceptable?

> 
>> diff --git a/mm/memory.c b/mm/memory.c
>> index 01f39e8144ef..e8bc729efb9d 100644
>> --- a/mm/memory.c
>> +++ b/mm/memory.c
>> @@ -4050,6 +4050,148 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
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
>> +#ifdef CONFIG_FLEXIBLE_THP
>> +static int flexthp_unhinted_max_order =
>> +               ilog2(SZ_64K > PAGE_SIZE ? SZ_64K : PAGE_SIZE) - PAGE_SHIFT;
>> +
>> +static int __init parse_flexthp_unhinted_max(char *s)
>> +{
>> +       unsigned long long size = memparse(s, NULL);
>> +
>> +       if (!is_power_of_2(size) || size < PAGE_SIZE || size > PMD_SIZE) {
>> +               pr_warn("flexthp: flexthp_unhinted_max=%s must be power-of-2 between PAGE_SIZE (%lu) and PMD_SIZE (%lu), ignoring\n",
>> +                       s, PAGE_SIZE, PMD_SIZE);
>> +               return 1;
>> +       }
>> +
>> +       flexthp_unhinted_max_order = ilog2(size) - PAGE_SHIFT;
>> +
>> +       /* THP machinery requires at least 3 struct pages for meta data. */
>> +       if (flexthp_unhinted_max_order == 1)
>> +               flexthp_unhinted_max_order--;
>> +
>> +       return 1;
>> +}
>> +
>> +__setup("flexthp_unhinted_max=", parse_flexthp_unhinted_max);
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
>> +        * arch-preferred size and limit it to the flexthp_unhinted_max cmdline
>> +        * parameter. This allows a sysadmin to tune performance vs internal
>> +        * fragmentation.
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
>> +                       order = min(order, flexthp_unhinted_max_order);
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
>> +
>> +       for (i = 0; orders[i]; i++) {
>> +               addr = ALIGN_DOWN(vmf->address, PAGE_SIZE << orders[i]);
>> +               if (addr >= vma->vm_start &&
>> +                   addr + (PAGE_SIZE << orders[i]) <= vma->vm_end)
>> +                       break;
>> +       }
>> +
>> +       if (!orders[i])
>> +               goto fallback;
>> +
>> +       pte = pte_offset_map(vmf->pmd, vmf->address & PMD_MASK);
>> +       if (!pte)
>> +               return -EAGAIN;
> 
> It would be a bug if this happens. So probably -EINVAL?

Not sure what you mean? Hugh Dickins' series that went into v6.5-rc1 makes it
possible for pte_offset_map() to fail (if I understood correctly) and we have to
handle this. The intent is that we will return from the fault without making any
change, then we will refault and try again.

> 
>> +
>> +       for (; orders[i]; i++) {
>> +               addr = ALIGN_DOWN(vmf->address, PAGE_SIZE << orders[i]);
>> +               vmf->pte = pte + pte_index(addr);
>> +               if (!vmf_pte_range_changed(vmf, 1 << orders[i]))
>> +                       break;
>> +       }
>> +
>> +       vmf->pte = NULL;
>> +       pte_unmap(pte);
>> +
>> +       gfp = vma_thp_gfp_mask(vma);
>> +
>> +       for (; orders[i]; i++) {
>> +               addr = ALIGN_DOWN(vmf->address, PAGE_SIZE << orders[i]);
>> +               *folio = vma_alloc_folio(gfp, orders[i], vma, addr, true);
>> +               if (*folio) {
>> +                       clear_huge_page(&(*folio)->page, addr, 1 << orders[i]);
>> +                       return 0;
>> +               }
>> +       }
>> +
>> +fallback:
>> +       *folio = vma_alloc_zeroed_movable_folio(vma, vmf->address);
>> +       return *folio ? 0 : -ENOMEM;
>> +}
>> +#else
>> +static inline int alloc_anon_folio(struct vm_fault *vmf, struct folio **folio)
> 
> Drop "inline" (it doesn't do anything in .c).

There are 38 instances of inline in memory.c alone, so looks like a well used
convention, even if the compiler may choose to ignore. Perhaps you can educate
me; what's the benefit of dropping it?

> 
> The rest looks good to me.

Great - just incase it wasn't obvious, I decided not to overwrite vmf->address
with the aligned version, as you suggested, for 2 reasons; 1) address is const
in the struct, so would have had to change that. 2) there is a uffd path that
can be taken after the vmf->address fixup would have occured and the path
consumes that member, so it would have had to be un-fixed-up making it more
messy than the way I opted for.

Thanks for the quick review as always!

