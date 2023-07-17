Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0046C756853
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 17:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231394AbjGQPvO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 11:51:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231706AbjGQPvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 11:51:11 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2C8AD1706
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 08:51:05 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3445AC15;
        Mon, 17 Jul 2023 08:51:48 -0700 (PDT)
Received: from [10.57.76.30] (unknown [10.57.76.30])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 543FB3F738;
        Mon, 17 Jul 2023 08:51:03 -0700 (PDT)
Message-ID: <a3422139-8353-5fce-8cae-f17801cd76f2@arm.com>
Date:   Mon, 17 Jul 2023 16:51:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v1 2/3] mm: Implement folio_remove_rmap_range()
To:     Zi Yan <ziy@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Yin Fengwei <fengwei.yin@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Yu Zhao <yuzhao@google.com>, Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <20230717143110.260162-1-ryan.roberts@arm.com>
 <20230717143110.260162-3-ryan.roberts@arm.com>
 <B4A5CF00-73E3-4AAA-9D39-1E7ABCCCFB06@nvidia.com>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <B4A5CF00-73E3-4AAA-9D39-1E7ABCCCFB06@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/07/2023 16:09, Zi Yan wrote:
> On 17 Jul 2023, at 10:31, Ryan Roberts wrote:
> 
>> Like page_remove_rmap() but batch-removes the rmap for a range of pages
>> belonging to a folio. This can provide a small speedup due to less
>> manipuation of the various counters. But more crucially, if removing the
>> rmap for all pages of a folio in a batch, there is no need to
>> (spuriously) add it to the deferred split list, which saves significant
>> cost when there is contention for the split queue lock.
>>
>> All contained pages are accounted using the order-0 folio (or base page)
>> scheme.
>>
>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>> ---
>>  include/linux/rmap.h |  2 ++
>>  mm/rmap.c            | 65 ++++++++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 67 insertions(+)
>>
>> diff --git a/include/linux/rmap.h b/include/linux/rmap.h
>> index b87d01660412..f578975c12c0 100644
>> --- a/include/linux/rmap.h
>> +++ b/include/linux/rmap.h
>> @@ -200,6 +200,8 @@ void page_add_file_rmap(struct page *, struct vm_area_struct *,
>>  		bool compound);
>>  void page_remove_rmap(struct page *, struct vm_area_struct *,
>>  		bool compound);
>> +void folio_remove_rmap_range(struct folio *folio, struct page *page,
>> +		int nr, struct vm_area_struct *vma);
>>
>>  void hugepage_add_anon_rmap(struct page *, struct vm_area_struct *,
>>  		unsigned long address, rmap_t flags);
>> diff --git a/mm/rmap.c b/mm/rmap.c
>> index 2baf57d65c23..1da05aca2bb1 100644
>> --- a/mm/rmap.c
>> +++ b/mm/rmap.c
>> @@ -1359,6 +1359,71 @@ void page_add_file_rmap(struct page *page, struct vm_area_struct *vma,
>>  	mlock_vma_folio(folio, vma, compound);
>>  }
>>
>> +/*
>> + * folio_remove_rmap_range - take down pte mappings from a range of pages
>> + * belonging to a folio. All pages are accounted as small pages.
>> + * @folio:	folio that all pages belong to
>> + * @page:       first page in range to remove mapping from
>> + * @nr:		number of pages in range to remove mapping from
> 
> We might need some checks to make sure [page, page+nr] is in the range of
> the folio. Something like:
> 
> page >= &folio->page && page + nr < (&folio->page + folio_nr_pages(folio))

No problem. Is a VM_WARN_ON() appropriate for something like this?

> 
>> + * @vma:        the vm area from which the mapping is removed
>> + *
>> + * The caller needs to hold the pte lock.
>> + */
>> +void folio_remove_rmap_range(struct folio *folio, struct page *page,
>> +					int nr, struct vm_area_struct *vma)
>> +{
>> +	atomic_t *mapped = &folio->_nr_pages_mapped;
>> +	int nr_unmapped = 0;
>> +	int nr_mapped;
>> +	bool last;
>> +	enum node_stat_item idx;
>> +
>> +	if (unlikely(folio_test_hugetlb(folio))) {
>> +		VM_WARN_ON_FOLIO(1, folio);
>> +		return;
>> +	}
>> +
>> +	if (!folio_test_large(folio)) {
>> +		/* Is this the page's last map to be removed? */
>> +		last = atomic_add_negative(-1, &page->_mapcount);
>> +		nr_unmapped = last;
>> +	} else {
>> +		for (; nr != 0; nr--, page++) {
>> +			/* Is this the page's last map to be removed? */
>> +			last = atomic_add_negative(-1, &page->_mapcount);
>> +			if (last) {
>> +				/* Page still mapped if folio mapped entirely */
>> +				nr_mapped = atomic_dec_return_relaxed(mapped);
>> +				if (nr_mapped < COMPOUND_MAPPED)
>> +					nr_unmapped++;
>> +			}
>> +		}
>> +	}
>> +
>> +	if (nr_unmapped) {
>> +		idx = folio_test_anon(folio) ? NR_ANON_MAPPED : NR_FILE_MAPPED;
>> +		__lruvec_stat_mod_folio(folio, idx, -nr_unmapped);
>> +
>> +		/*
>> +		 * Queue anon THP for deferred split if we have just unmapped at
>> +		 * least 1 page, while at least 1 page remains mapped.
>> +		 */
>> +		if (folio_test_large(folio) && folio_test_anon(folio))
>> +			if (nr_mapped)
>> +				deferred_split_folio(folio);
>> +	}
>> +
>> +	/*
>> +	 * It would be tidy to reset folio_test_anon mapping when fully
>> +	 * unmapped, but that might overwrite a racing page_add_anon_rmap
>> +	 * which increments mapcount after us but sets mapping before us:
>> +	 * so leave the reset to free_pages_prepare, and remember that
>> +	 * it's only reliable while mapped.
>> +	 */
>> +
>> +	munlock_vma_folio(folio, vma, false);
>> +}
>> +
>>  /**
>>   * page_remove_rmap - take down pte mapping from a page
>>   * @page:	page to remove mapping from
>> -- 
>> 2.25.1
> 
> Everything else looks good to me. Reviewed-by: Zi Yan <ziy@nvidia.com>
> 
> --
> Best Regards,
> Yan, Zi

