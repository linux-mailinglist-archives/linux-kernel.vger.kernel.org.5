Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9109E80F13D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 16:38:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377117AbjLLPie (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 10:38:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377020AbjLLPid (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 10:38:33 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 42DDCEA
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 07:38:38 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 36FDF143D;
        Tue, 12 Dec 2023 07:39:24 -0800 (PST)
Received: from [10.1.39.183] (XHFQ2J9959.cambridge.arm.com [10.1.39.183])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 312083F738;
        Tue, 12 Dec 2023 07:38:35 -0800 (PST)
Message-ID: <d67754d6-8f11-4d36-8e16-4f93bc04bea6@arm.com>
Date:   Tue, 12 Dec 2023 15:38:34 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 04/10] mm: thp: Support allocation of anonymous
 multi-size THP
Content-Language: en-GB
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
References: <20231207161211.2374093-1-ryan.roberts@arm.com>
 <20231207161211.2374093-5-ryan.roberts@arm.com>
 <2bebcf33-e8b7-468d-86cc-31d6eb355b66@redhat.com>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <2bebcf33-e8b7-468d-86cc-31d6eb355b66@redhat.com>
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

On 12/12/2023 15:02, David Hildenbrand wrote:
> On 07.12.23 17:12, Ryan Roberts wrote:
>> Introduce the logic to allow THP to be configured (through the new sysfs
>> interface we just added) to allocate large folios to back anonymous
>> memory, which are larger than the base page size but smaller than
>> PMD-size. We call this new THP extension "multi-size THP" (mTHP).
>>
>> mTHP continues to be PTE-mapped, but in many cases can still provide
>> similar benefits to traditional PMD-sized THP: Page faults are
>> significantly reduced (by a factor of e.g. 4, 8, 16, etc. depending on
>> the configured order), but latency spikes are much less prominent
>> because the size of each page isn't as huge as the PMD-sized variant and
>> there is less memory to clear in each page fault. The number of per-page
>> operations (e.g. ref counting, rmap management, lru list management) are
>> also significantly reduced since those ops now become per-folio.
> 
> I'll note that with always-pte-mapped-thp it will be much easier to support
> incremental page clearing (e.g., zero only parts of the folio and map the
> remainder in a pro-non-like fashion whereby we'll zero on the next page fault).
> With a PMD-sized thp, you have to eventually place/rip out page tables to
> achieve that.

But then you lose the benefits of reduced number of page faults; reducing page
faults gives a big speed up for workloads with lots of short lived processes
like compiling.

But yes, I agree this could be an interesting future optimization for some
workloads.

> 
>>
>> Some architectures also employ TLB compression mechanisms to squeeze
>> more entries in when a set of PTEs are virtually and physically
>> contiguous and approporiately aligned. In this case, TLB misses will
>> occur less often.
>>
>> The new behaviour is disabled by default, but can be enabled at runtime
>> by writing to /sys/kernel/mm/transparent_hugepage/hugepage-XXkb/enabled
>> (see documentation in previous commit). The long term aim is to change
>> the default to include suitable lower orders, but there are some risks
>> around internal fragmentation that need to be better understood first.
>>
>> Tested-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>> Tested-by: John Hubbard <jhubbard@nvidia.com>
>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>> ---
>>   include/linux/huge_mm.h |   6 ++-
>>   mm/memory.c             | 111 ++++++++++++++++++++++++++++++++++++----
>>   2 files changed, 106 insertions(+), 11 deletions(-)
>>
>> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
>> index 609c153bae57..fa7a38a30fc6 100644
>> --- a/include/linux/huge_mm.h
>> +++ b/include/linux/huge_mm.h
>> @@ -68,9 +68,11 @@ extern struct kobj_attribute shmem_enabled_attr;
>>   #define HPAGE_PMD_NR (1<<HPAGE_PMD_ORDER)
> 
> [...]
> 
>> +
>> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
>> +static struct folio *alloc_anon_folio(struct vm_fault *vmf)
>> +{
>> +    struct vm_area_struct *vma = vmf->vma;
>> +    unsigned long orders;
>> +    struct folio *folio;
>> +    unsigned long addr;
>> +    pte_t *pte;
>> +    gfp_t gfp;
>> +    int order;
>> +
>> +    /*
>> +     * If uffd is active for the vma we need per-page fault fidelity to
>> +     * maintain the uffd semantics.
>> +     */
>> +    if (unlikely(userfaultfd_armed(vma)))
>> +        goto fallback;
>> +
>> +    /*
>> +     * Get a list of all the (large) orders below PMD_ORDER that are enabled
>> +     * for this vma. Then filter out the orders that can't be allocated over
>> +     * the faulting address and still be fully contained in the vma.
>> +     */
>> +    orders = thp_vma_allowable_orders(vma, vma->vm_flags, false, true, true,
>> +                      BIT(PMD_ORDER) - 1);
>> +    orders = thp_vma_suitable_orders(vma, vmf->address, orders);
>> +
>> +    if (!orders)
>> +        goto fallback;
>> +
>> +    pte = pte_offset_map(vmf->pmd, vmf->address & PMD_MASK);
>> +    if (!pte)
>> +        return ERR_PTR(-EAGAIN);
>> +
>> +    /*
>> +     * Find the highest order where the aligned range is completely
>> +     * pte_none(). Note that all remaining orders will be completely
>> +     * pte_none().
>> +     */
>> +    order = highest_order(orders);
>> +    while (orders) {
>> +        addr = ALIGN_DOWN(vmf->address, PAGE_SIZE << order);
>> +        if (pte_range_none(pte + pte_index(addr), 1 << order))
>> +            break;
>> +        order = next_order(&orders, order);
>> +    }
>> +
>> +    pte_unmap(pte);
>> +
>> +    /* Try allocating the highest of the remaining orders. */
>> +    gfp = vma_thp_gfp_mask(vma);
>> +    while (orders) {
>> +        addr = ALIGN_DOWN(vmf->address, PAGE_SIZE << order);
>> +        folio = vma_alloc_folio(gfp, order, vma, addr, true);
>> +        if (folio) {
>> +            clear_huge_page(&folio->page, vmf->address, 1 << order);
>> +            return folio;
>> +        }
>> +        order = next_order(&orders, order);
>> +    }
>> +
>> +fallback:
>> +    return vma_alloc_zeroed_movable_folio(vma, vmf->address);
>> +}
>> +#else
>> +#define alloc_anon_folio(vmf) \
>> +        vma_alloc_zeroed_movable_folio((vmf)->vma, (vmf)->address)
>> +#endif
> 
> A neater alternative might be
> 
> static struct folio *alloc_anon_folio(struct vm_fault *vmf)
> {
> #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>     /* magic */
> fallback:
> #endif
>     return vma_alloc_zeroed_movable_folio((vmf)->vma, (vmf)->address):
> }

I guess beauty lies in the eye of the beholder... I don't find it much neater
personally :). But happy to make the change if you insist; what's the process
now that its in mm-unstable? Just send a patch to Andrew for squashing?

> 
> [...]
> 
> Acked-by: David Hildenbrand <david@redhat.com>
> 

