Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68B2675793E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 12:28:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbjGRK2C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 06:28:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231511AbjGRK16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 06:27:58 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DDEF71A8
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 03:27:56 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 20BB92F4;
        Tue, 18 Jul 2023 03:28:40 -0700 (PDT)
Received: from [10.1.34.52] (C02Z41KALVDN.cambridge.arm.com [10.1.34.52])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 408E43F67D;
        Tue, 18 Jul 2023 03:27:55 -0700 (PDT)
Message-ID: <cb321fb0-fde5-c78f-10b2-1d1fec7070fd@arm.com>
Date:   Tue, 18 Jul 2023 11:27:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v1 3/3] mm: Batch-zap large anonymous folio PTE mappings
To:     Yin Fengwei <fengwei.yin@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Yu Zhao <yuzhao@google.com>, Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20230717143110.260162-1-ryan.roberts@arm.com>
 <20230717143110.260162-4-ryan.roberts@arm.com>
 <b3c20fd8-3835-517a-a055-cd796fa7f733@intel.com>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <b3c20fd8-3835-517a-a055-cd796fa7f733@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/07/2023 00:27, Yin Fengwei wrote:
> 
> 
> On 7/17/23 22:31, Ryan Roberts wrote:
>> This allows batching the rmap removal with folio_remove_rmap_range(),
>> which means we avoid spuriously adding a partially unmapped folio to the
>> deferrred split queue in the common case, which reduces split queue lock
>> contention.
>>
>> Previously each page was removed from the rmap individually with
>> page_remove_rmap(). If the first page belonged to a large folio, this
>> would cause page_remove_rmap() to conclude that the folio was now
>> partially mapped and add the folio to the deferred split queue. But
>> subsequent calls would cause the folio to become fully unmapped, meaning
>> there is no value to adding it to the split queue.
>>
>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>> ---
>>  mm/memory.c | 119 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 119 insertions(+)
>>
>> diff --git a/mm/memory.c b/mm/memory.c
>> index 01f39e8144ef..6facb8c8807a 100644
>> --- a/mm/memory.c
>> +++ b/mm/memory.c
>> @@ -1391,6 +1391,95 @@ zap_install_uffd_wp_if_needed(struct vm_area_struct *vma,
>>  	pte_install_uffd_wp_if_needed(vma, addr, pte, pteval);
>>  }
>>  
>> +static inline unsigned long page_addr(struct page *page,
>> +				struct page *anchor, unsigned long anchor_addr)
>> +{
>> +	unsigned long offset;
>> +	unsigned long addr;
>> +
>> +	offset = (page_to_pfn(page) - page_to_pfn(anchor)) << PAGE_SHIFT;
>> +	addr = anchor_addr + offset;
>> +
>> +	if (anchor > page) {
>> +		if (addr > anchor_addr)
>> +			return 0;
>> +	} else {
>> +		if (addr < anchor_addr)
>> +			return ULONG_MAX;
>> +	}
>> +
>> +	return addr;
>> +}
>> +
>> +static int calc_anon_folio_map_pgcount(struct folio *folio,
>> +				       struct page *page, pte_t *pte,
>> +				       unsigned long addr, unsigned long end)
>> +{
>> +	pte_t ptent;
>> +	int floops;
>> +	int i;
>> +	unsigned long pfn;
>> +
>> +	end = min(page_addr(&folio->page + folio_nr_pages(folio), page, addr),
>> +		  end);
>> +	floops = (end - addr) >> PAGE_SHIFT;
>> +	pfn = page_to_pfn(page);
>> +	pfn++;
>> +	pte++;
>> +
>> +	for (i = 1; i < floops; i++) {
>> +		ptent = ptep_get(pte);
>> +
>> +		if (!pte_present(ptent) ||
>> +		    pte_pfn(ptent) != pfn) {
>> +			return i;
>> +		}
>> +
>> +		pfn++;
>> +		pte++;
>> +	}
>> +
>> +	return floops;
>> +}
>> +
>> +static unsigned long zap_anon_pte_range(struct mmu_gather *tlb,
>> +					struct vm_area_struct *vma,
>> +					struct page *page, pte_t *pte,
>> +					unsigned long addr, unsigned long end,
>> +					bool *full_out)
>> +{
>> +	struct folio *folio = page_folio(page);
>> +	struct mm_struct *mm = tlb->mm;
>> +	pte_t ptent;
>> +	int pgcount;
>> +	int i;
>> +	bool full;
>> +
>> +	pgcount = calc_anon_folio_map_pgcount(folio, page, pte, addr, end);
>> +
>> +	for (i = 0; i < pgcount;) {
>> +		ptent = ptep_get_and_clear_full(mm, addr, pte, tlb->fullmm);
>> +		tlb_remove_tlb_entry(tlb, pte, addr);
>> +		full = __tlb_remove_page(tlb, page, 0);
>> +
>> +		if (unlikely(page_mapcount(page) < 1))
>> +			print_bad_pte(vma, addr, ptent, page);
>> +
>> +		i++;
>> +		page++;
>> +		pte++;
>> +		addr += PAGE_SIZE;
>> +
>> +		if (unlikely(full))
>> +			break;
>> +	}
>> +
>> +	folio_remove_rmap_range(folio, page - i, i, vma);
>> +
>> +	*full_out = full;
>> +	return i;
>> +}
>> +
>>  static unsigned long zap_pte_range(struct mmu_gather *tlb,
>>  				struct vm_area_struct *vma, pmd_t *pmd,
>>  				unsigned long addr, unsigned long end,
>> @@ -1428,6 +1517,36 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
>>  			page = vm_normal_page(vma, addr, ptent);
>>  			if (unlikely(!should_zap_page(details, page)))
>>  				continue;
>> +
>> +			/*
>> +			 * Batch zap large anonymous folio mappings. This allows
>> +			 * batching the rmap removal, which means we avoid
>> +			 * spuriously adding a partially unmapped folio to the
>> +			 * deferrred split queue in the common case, which
>> +			 * reduces split queue lock contention. Require the VMA
>> +			 * to be anonymous to ensure that none of the PTEs in
>> +			 * the range require zap_install_uffd_wp_if_needed().
>> +			 */
>> +			if (page && PageAnon(page) && vma_is_anonymous(vma)) {
> Why this is only for anonymous page? I suppose it can support file mapping also.

I was trying to avoid the complexity. For file-backed pages, there is a bunch of
dirty and access management stuff that needs to happen (see "if
(!PageAnon(page)) {" a bit further down). And for file-backed VMAs (even if the
page is anon, I think?) zap_install_uffd_wp_if_needed() might do some extra
work, which again I didn't want to have to drag into zap_anon_pte_range().

I guess it's implementable, but given only anon folios will be deferred-split
and anon folios in a file-backed vma will all be single page, I didn't feel that
the extra complexity would add anything performance-wise.


> 
> 
> Regards
> Yin, Fengwei
> 
>> +				bool full;
>> +				int pgcount;
>> +
>> +				pgcount = zap_anon_pte_range(tlb, vma,
>> +						page, pte, addr, end, &full);
>> +
>> +				rss[mm_counter(page)] -= pgcount;
>> +				pgcount--;
>> +				pte += pgcount;
>> +				addr += pgcount << PAGE_SHIFT;
>> +
>> +				if (unlikely(full)) {
>> +					force_flush = 1;
>> +					addr += PAGE_SIZE;
>> +					break;
>> +				}
>> +				continue;
>> +			}
>> +
>>  			ptent = ptep_get_and_clear_full(mm, addr, pte,
>>  							tlb->fullmm);
>>  			tlb_remove_tlb_entry(tlb, pte, addr);

