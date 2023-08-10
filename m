Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9953677810F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 21:12:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235421AbjHJTMo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 15:12:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232115AbjHJTMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 15:12:43 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7005190
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 12:12:42 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A5555D75;
        Thu, 10 Aug 2023 12:13:24 -0700 (PDT)
Received: from [192.168.0.23] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 37D303F6C4;
        Thu, 10 Aug 2023 12:12:40 -0700 (PDT)
Message-ID: <f97446e3-85d8-4d14-9fc0-683b31925325@arm.com>
Date:   Thu, 10 Aug 2023 20:12:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/5] mm: LARGE_ANON_FOLIO for improved performance
Content-Language: en-GB
To:     Yu Zhao <yuzhao@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Yin Fengwei <fengwei.yin@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Itaru Kitayama <itaru.kitayama@gmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230810142942.3169679-1-ryan.roberts@arm.com>
 <20230810142942.3169679-4-ryan.roberts@arm.com>
 <CAOUHufbUGwc2XvZOBmTCzMsOHxP-eLB60EdysKYzrkRMScOyMg@mail.gmail.com>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <CAOUHufbUGwc2XvZOBmTCzMsOHxP-eLB60EdysKYzrkRMScOyMg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/08/2023 18:01, Yu Zhao wrote:
> On Thu, Aug 10, 2023 at 8:30 AM Ryan Roberts <ryan.roberts@arm.com> wrote:
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
>> Large anonymous folio (LAF) allocation is integrated with the existing
>> (PMD-order) THP and single (S) page allocation according to this policy,
>> where fallback (>) is performed for various reasons, such as the
>> proposed folio order not fitting within the bounds of the VMA, etc:
>>
>>                 | prctl=dis | prctl=ena   | prctl=ena     | prctl=ena
>>                 | sysfs=X   | sysfs=never | sysfs=madvise | sysfs=always
>> ----------------|-----------|-------------|---------------|-------------
>> no hint         | S         | LAF>S       | LAF>S         | THP>LAF>S
>> MADV_HUGEPAGE   | S         | LAF>S       | THP>LAF>S     | THP>LAF>S
>> MADV_NOHUGEPAGE | S         | S           | S             | S
>>
>> This approach ensures that we don't violate existing hints to only
>> allocate single pages - this is required for QEMU's VM live migration
>> implementation to work correctly - while allowing us to use LAF
>> independently of THP (when sysfs=never). This makes wide scale
>> performance characterization simpler, while avoiding exposing any new
>> ABI to user space.
>>
>> When using LAF for allocation, the folio order is determined as follows:
>> The return value of arch_wants_pte_order() is used. For vmas that have
>> not explicitly opted-in to use transparent hugepages (e.g. where
>> sysfs=madvise and the vma does not have MADV_HUGEPAGE or sysfs=never),
>> then arch_wants_pte_order() is limited to 64K (or PAGE_SIZE, whichever
>> is bigger). This allows for a performance boost without requiring any
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
>>  mm/memory.c             | 144 +++++++++++++++++++++++++++++++++++++---
>>  3 files changed, 158 insertions(+), 9 deletions(-)
>>
>> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
>> index 222a33b9600d..4b488cc66ddc 100644
>> --- a/include/linux/pgtable.h
>> +++ b/include/linux/pgtable.h
>> @@ -369,6 +369,19 @@ static inline bool arch_has_hw_pte_young(void)
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
>> index 721dc88423c7..a1e28b8ddc24 100644
>> --- a/mm/Kconfig
>> +++ b/mm/Kconfig
>> @@ -1243,4 +1243,14 @@ config LOCK_MM_AND_FIND_VMA
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
>> index d003076b218d..bbc7d4ce84f7 100644
>> --- a/mm/memory.c
>> +++ b/mm/memory.c
>> @@ -4073,6 +4073,123 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
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
>> +        * If the vma is eligible for thp, allocate a large folio of the size
>> +        * preferred by the arch. Or if the arch requested a very small size or
>> +        * didn't request a size, then use PAGE_ALLOC_COSTLY_ORDER, which still
>> +        * meets the arch's requirements but means we still take advantage of SW
>> +        * optimizations (e.g. fewer page faults).
>> +        *
>> +        * If the vma isn't eligible for thp, take the arch-preferred size and
>> +        * limit it to ANON_FOLIO_MAX_ORDER_UNHINTED. This ensures workloads
>> +        * that have not explicitly opted-in take benefit while capping the
>> +        * potential for internal fragmentation.
>> +        */
>> +
>> +       order = max(arch_wants_pte_order(), PAGE_ALLOC_COSTLY_ORDER);
>> +
>> +       if (!hugepage_vma_check(vma, vma->vm_flags, false, true, true))
>> +               order = min(order, ANON_FOLIO_MAX_ORDER_UNHINTED);
>> +
>> +       return order;
>> +}
> 
> I don't understand why we still want to keep ANON_FOLIO_MAX_ORDER_UNHINTED.
> 1. It's not used, since no archs at the moment implement
> arch_wants_pte_order() that returns >64KB.
> 2. As far as I know, there is no plan for any arch to do so.

My rationale is that arm64 is planning to use this for contpte mapping 2MB
blocks for 16K and 64K kernels. But I think we will all agree that allowing 2MB
blocks without the proper THP hinting is a bad plan.

As I see it, arches could add their own arch_wants_pte_order() at any time, and
just because the HW has a preference, doesn't mean the SW shouldn't get a say.
Its a negotiation between HW and SW for the LAF order, embodied in this policy.

> 3. Again, it seems to me the rationale behind
> ANON_FOLIO_MAX_ORDER_UNHINTED isn't convincing at all.
> 
> Can we introduce ANON_FOLIO_MAX_ORDER_UNHINTED  if/when needed please?
> 
> Also you made arch_wants_pte_order() return -1, and I acknowledged [1]:
>   Thanks: -1 actually is better than 0 (what I suggested) for the
>   obvious reason.
> 
> I thought we were on the same page, i.e., the "obvious reason" is that
> h/w might prefer 0. But here you are not respecting 0. But then why
> -1?

I agree that the "obvious reason" is that HW might prefer order-0. But the
performance wins don't come solely from the HW. Batching up page faults is a big
win for SW even if the HW doesn't benefit. So I think it is important that a HW
preference of order-0 is possible to express through this API. But that doesn't
mean that we don't listen to SW's preferences either.

I would really rather leave it in; As I've mentioned in the past, we have a
partner who is actively keen to take advantage of 2MB blocks with 64K kernel and
this is the mechanism that means we don't dole out those 2MB blocks unless
explicitly opted-in.

I'm going to be out on holiday for a couple of weeks, so we might have to wait
until I'm back to conclude on this, if you still take issue with the justification.

Thanks,
Ryan


> 
> [1] https://lore.kernel.org/linux-mm/CAOUHufZ7HJZW8Srwatyudf=FbwTGQtyq4DyL2SHwSg37N_Bo_A@mail.gmail.com/

