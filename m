Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9EF276EB4C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 15:56:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235591AbjHCN4t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 09:56:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234272AbjHCN4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 09:56:47 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7BB33194
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 06:56:45 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4075F113E;
        Thu,  3 Aug 2023 06:57:28 -0700 (PDT)
Received: from [10.1.35.53] (C02Z41KALVDN.cambridge.arm.com [10.1.35.53])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7905D3F5A1;
        Thu,  3 Aug 2023 06:56:43 -0700 (PDT)
Message-ID: <4255e71a-63c9-b2f9-5e97-e46834f7837c@arm.com>
Date:   Thu, 3 Aug 2023 14:56:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v4 3/3] mm: Batch-zap large anonymous folio PTE mappings
To:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Yin Fengwei <fengwei.yin@intel.com>,
        Yu Zhao <yuzhao@google.com>, Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20230727141837.3386072-1-ryan.roberts@arm.com>
 <20230727141837.3386072-4-ryan.roberts@arm.com>
 <6cda91b3-bb7a-4c4c-a618-2572b9c8bbf9@redhat.com>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <6cda91b3-bb7a-4c4c-a618-2572b9c8bbf9@redhat.com>
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

As per yesterday's discussion, I'm going to rework this series into a more
generic version that covers pagecache folios too. But your comments will still
be relevent there so answers below.


On 03/08/2023 14:38, David Hildenbrand wrote:
> On 27.07.23 16:18, Ryan Roberts wrote:
>> This allows batching the rmap removal with folio_remove_rmap_range(),
>> which means we avoid spuriously adding a partially unmapped folio to the
>> deferred split queue in the common case, which reduces split queue lock
>> contention.
>>
>> Previously each page was removed from the rmap individually with
>> page_remove_rmap(). If the first page belonged to a large folio, this
>> would cause page_remove_rmap() to conclude that the folio was now
>> partially mapped and add the folio to the deferred split queue. But
>> subsequent calls would cause the folio to become fully unmapped, meaning
>> there is no value to adding it to the split queue.
>>
>> A complicating factor is that for platforms where MMU_GATHER_NO_GATHER
>> is enabled (e.g. s390), __tlb_remove_page() drops a reference to the
>> page. This means that the folio reference count could drop to zero while
>> still in use (i.e. before folio_remove_rmap_range() is called). This
>> does not happen on other platforms because the actual page freeing is
>> deferred.
>>
>> Solve this by appropriately getting/putting the folio to guarrantee it
>> does not get freed early. Given the need to get/put the folio in the
>> batch path, we stick to the non-batched path if the folio is not large.
>> While the batched path is functionally correct for a folio with 1 page,
>> it is unlikely to be as efficient as the existing non-batched path in
>> this case.
>>
>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>> ---
>>   mm/memory.c | 132 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 132 insertions(+)
>>
>> diff --git a/mm/memory.c b/mm/memory.c
>> index 01f39e8144ef..d35bd8d2b855 100644
>> --- a/mm/memory.c
>> +++ b/mm/memory.c
>> @@ -1391,6 +1391,99 @@ zap_install_uffd_wp_if_needed(struct vm_area_struct *vma,
>>       pte_install_uffd_wp_if_needed(vma, addr, pte, pteval);
>>   }
>>   +static inline unsigned long page_cont_mapped_vaddr(struct page *page,
>> +                struct page *anchor, unsigned long anchor_vaddr)
>> +{
>> +    unsigned long offset;
>> +    unsigned long vaddr;
>> +
>> +    offset = (page_to_pfn(page) - page_to_pfn(anchor)) << PAGE_SHIFT;
>> +    vaddr = anchor_vaddr + offset;
>> +
>> +    if (anchor > page) {
>> +        if (vaddr > anchor_vaddr)
>> +            return 0;
>> +    } else {
>> +        if (vaddr < anchor_vaddr)
>> +            return ULONG_MAX;
>> +    }
>> +
>> +    return vaddr;
>> +}
>> +
>> +static int folio_nr_pages_cont_mapped(struct folio *folio,
>> +                      struct page *page, pte_t *pte,
>> +                      unsigned long addr, unsigned long end)
>> +{
>> +    pte_t ptent;
>> +    int floops;
>> +    int i;
>> +    unsigned long pfn;
>> +    struct page *folio_end;
>> +
>> +    if (!folio_test_large(folio))
>> +        return 1;
>> +
>> +    folio_end = &folio->page + folio_nr_pages(folio);
>> +    end = min(page_cont_mapped_vaddr(folio_end, page, addr), end);
>> +    floops = (end - addr) >> PAGE_SHIFT;
>> +    pfn = page_to_pfn(page);
>> +    pfn++;
>> +    pte++;
>> +
>> +    for (i = 1; i < floops; i++) {
>> +        ptent = ptep_get(pte);
>> +
>> +        if (!pte_present(ptent) || pte_pfn(ptent) != pfn)
>> +            break;
>> +
>> +        pfn++;
>> +        pte++;
>> +    }
>> +
>> +    return i;
>> +}
>> +
>> +static unsigned long try_zap_anon_pte_range(struct mmu_gather *tlb,
>> +                        struct vm_area_struct *vma,
>> +                        struct folio *folio,
>> +                        struct page *page, pte_t *pte,
>> +                        unsigned long addr, int nr_pages,
>> +                        struct zap_details *details)
>> +{
>> +    struct mm_struct *mm = tlb->mm;
>> +    pte_t ptent;
>> +    bool full;
>> +    int i;
>> +
>> +    /* __tlb_remove_page may drop a ref; prevent going to 0 while in use. */
>> +    folio_get(folio);
> 
> Is there no way around that? It feels wrong and IMHO a bit ugly.

I haven't found a good one, but I'm all ears. On the non-batched path,
__tlb_remove_page() is called before page_remove_rmap(). On this path, the whole
point is that we just call folio_remove_rmap_range() for the whole batch. If I'm
right, we must only remove from the rmap *after* doing the pte clear to avoid
races. And we need to do call __tlb_remove_page() as we go, because it might run
out of space at any time.

If I knew how many pages the tlb could accept ahead of time, I could defer the
__tlb_remove_page() calls to after folio_remove_rmap_range(). But there is no
accessor for that as far as I can see. It looks fairly complicated to calculate
it too.

> 
> With this patch, you'll might suddenly have mapcount > refcount for a folio, or
> am I wrong?

Yes you would. Does that break things?

> 
>> +
>> +    for (i = 0; i < nr_pages;) {
>> +        ptent = ptep_get_and_clear_full(mm, addr, pte, tlb->fullmm);
>> +        tlb_remove_tlb_entry(tlb, pte, addr);
>> +        zap_install_uffd_wp_if_needed(vma, addr, pte, details, ptent);
>> +        full = __tlb_remove_page(tlb, page, 0);
>> +
>> +        if (unlikely(page_mapcount(page) < 1))
>> +            print_bad_pte(vma, addr, ptent, page);
> 
> Can we avoid new users of page_mapcount() outside rmap code, please? :)

Sure. This is just trying to replicate the same diagnstics that's done on the
non-batched path. I'm happy to remove it.

> 

