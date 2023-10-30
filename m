Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 798767DB933
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 12:43:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233070AbjJ3LnW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 07:43:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjJ3LnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 07:43:20 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C6637B6
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 04:43:17 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3593FFEC;
        Mon, 30 Oct 2023 04:43:59 -0700 (PDT)
Received: from [10.57.71.117] (unknown [10.57.71.117])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EA0353F738;
        Mon, 30 Oct 2023 04:43:14 -0700 (PDT)
Message-ID: <5993c198-0d27-46c3-b757-3a02c2aacfc9@arm.com>
Date:   Mon, 30 Oct 2023 11:43:13 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 5/9] mm: thp: Extend THP to allocate anonymous large
 folios
Content-Language: en-GB
To:     John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
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
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Hugh Dickins <hughd@google.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230929114421.3761121-1-ryan.roberts@arm.com>
 <20230929114421.3761121-6-ryan.roberts@arm.com>
 <8a72da61-b2ef-48ad-ae59-0bae7ac2ce10@nvidia.com>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <8a72da61-b2ef-48ad-ae59-0bae7ac2ce10@nvidia.com>
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

On 28/10/2023 00:04, John Hubbard wrote:
> On 9/29/23 04:44, Ryan Roberts wrote:
> 
> Hi Ryan,
> 
> A few clarifying questions below.

Excellent - keep them coming!

> 
> ...
>> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
>> index 2e7c338229a6..c4860476a1f5 100644
>> --- a/include/linux/huge_mm.h
>> +++ b/include/linux/huge_mm.h
>> @@ -68,9 +68,11 @@ extern struct kobj_attribute shmem_enabled_attr;
>>   #define HPAGE_PMD_NR (1<<HPAGE_PMD_ORDER)
>>     /*
>> - * Mask of all large folio orders supported for anonymous THP.
>> + * Mask of all large folio orders supported for anonymous THP; all orders up to
>> + * and including PMD_ORDER, except order-0 (which is not "huge") and order-1
>> + * (which is a limitation of the THP implementation).
>>    */
>> -#define THP_ORDERS_ALL_ANON    BIT(PMD_ORDER)
>> +#define THP_ORDERS_ALL_ANON    ((BIT(PMD_ORDER + 1) - 1) & ~(BIT(0) | BIT(1)))
>>     /*
>>    * Mask of all large folio orders supported for file THP.
>> diff --git a/mm/memory.c b/mm/memory.c
>> index b5b82fc8e164..92ed9c782dc9 100644
>> --- a/mm/memory.c
>> +++ b/mm/memory.c
>> @@ -4059,6 +4059,87 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>>       return ret;
>>   }
>>   +static bool vmf_pte_range_changed(struct vm_fault *vmf, int nr_pages)
>> +{
>> +    int i;
>> +
>> +    if (nr_pages == 1)
>> +        return vmf_pte_changed(vmf);
>> +
>> +    for (i = 0; i < nr_pages; i++) {
>> +        if (!pte_none(ptep_get_lockless(vmf->pte + i)))
>> +            return true;
> 
> This seems like something different than the function name implies.
> It's really confusing: for a single page case, return true if the
> pte in the page tables has changed, yes that is very clear.
> 
> But then for multiple page cases, which is really the main
> focus here--for that, claim that the range has changed if any
> pte is present (!pte_none). Can you please help me understand
> what this means?

Yes I understand your confusion. Although I'm confident that the code is
correct, its a bad name - I'll make the excuse that this has evolved through
rebasing to cope with additions to UFFD. Perhaps something like
vmf_is_large_folio_suitable() is a better name.

It used to be that we would only take the do_anonymous_page() path if the pte
was none; i.e. this is the first time we are faulting on an address covered by
an anon VMA and we need to allocate some memory. But more recently we also end
up here if the pte is a uffd_wp marker. So for a single pte, instead of checking
none, we can check if the pte has changed from our original check (where we
determined it was a uffd_wp marker or none). But for multiple ptes, we don't
have storage to store all the original ptes from the first check.

Fortunately, if uffd is in use for a vma, then we don't want to use a large
folio anyway (this would break uffd semantics because we would no longer get a
fault for every page). So we only care about the "same but not none" case for
nr_pages=1.

Would changing the name to vmf_is_large_folio_suitable() help here?


> 
>> +    }
>> +
>> +    return false;
>> +}
>> +
>> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
>> +static struct folio *alloc_anon_folio(struct vm_fault *vmf)
>> +{
>> +    gfp_t gfp;
>> +    pte_t *pte;
>> +    unsigned long addr;
>> +    struct folio *folio;
>> +    struct vm_area_struct *vma = vmf->vma;
>> +    unsigned int orders;
>> +    int order;
>> +
>> +    /*
>> +     * If uffd is active for the vma we need per-page fault fidelity to
>> +     * maintain the uffd semantics.
>> +     */
>> +    if (userfaultfd_armed(vma))
>> +        goto fallback;
>> +
>> +    /*
>> +     * Get a list of all the (large) orders below PMD_ORDER that are enabled
>> +     * for this vma. Then filter out the orders that can't be allocated over
>> +     * the faulting address and still be fully contained in the vma.
>> +     */
>> +    orders = hugepage_vma_check(vma, vma->vm_flags, false, true, true,
>> +                    BIT(PMD_ORDER) - 1);
>> +    orders = transhuge_vma_suitable(vma, vmf->address, orders);
>> +
>> +    if (!orders)
>> +        goto fallback;
>> +
>> +    pte = pte_offset_map(vmf->pmd, vmf->address & PMD_MASK);
>> +    if (!pte)
>> +        return ERR_PTR(-EAGAIN);
> 
> pte_offset_map() can only fail due to:
> 
>     a) Wrong pmd type. These include:
>         pmd_none
>         pmd_bad
>         pmd migration entry
>         pmd_trans_huge
>         pmd_devmap
> 
>     b) __pte_map() failure
> 
> For (a), why is it that -EAGAIN is used here? I see that that
> will lead to a re-fault, I got that far, but am missing something
> still.
> 
> For (b), same question, actually. I'm not completely sure why
> why a retry is going to fix a __pte_map() failure?

I'm not going to claim to understand all the details of this. But this is due to
a change that Hugh introduced and we concluded at [1] that its always correct to
return EAGAIN here to rerun the fault. In fact, with the current implementation
pte_offset_map() should never fail for anon IIUC, but the view was that EAGAIN
makes it safe for tomorrow, and because this would only fail due to a race,
retrying is correct.

[1] https://lore.kernel.org/linux-mm/8bdfd8d8-5662-4615-86dc-d60259bd16d@google.com/


> 
> 
>> +
>> +    order = first_order(orders);
>> +    while (orders) {
>> +        addr = ALIGN_DOWN(vmf->address, PAGE_SIZE << order);
>> +        vmf->pte = pte + pte_index(addr);
>> +        if (!vmf_pte_range_changed(vmf, 1 << order))
>> +            break;
>> +        order = next_order(&orders, order);
>> +    }
>> +
>> +    vmf->pte = NULL;
>> +    pte_unmap(pte);
>> +
>> +    gfp = vma_thp_gfp_mask(vma);
>> +
>> +    while (orders) {
>> +        addr = ALIGN_DOWN(vmf->address, PAGE_SIZE << order);
>> +        folio = vma_alloc_folio(gfp, order, vma, addr, true);
>> +        if (folio) {
>> +            clear_huge_page(&folio->page, addr, 1 << order);
>> +            return folio;
>> +        }
>> +        order = next_order(&orders, order);
>> +    }
> 
> And finally: is it accurate to say that there are *no* special
> page flags being set, for PTE-mapped THPs? I don't see any here,
> but want to confirm.

The page flags are coming from 'gfp = vma_thp_gfp_mask(vma)', which pulls in the
correct flags based on transparent_hugepage/defrag file.

> 
> 
> thanks,

