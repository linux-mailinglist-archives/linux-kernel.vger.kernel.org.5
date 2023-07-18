Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9BEC7578C8
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 12:03:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231971AbjGRKDQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 06:03:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232531AbjGRKDC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 06:03:02 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D1BE997
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 03:03:00 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 11EF32F4;
        Tue, 18 Jul 2023 03:03:44 -0700 (PDT)
Received: from [10.1.34.52] (C02Z41KALVDN.cambridge.arm.com [10.1.34.52])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 306493F67D;
        Tue, 18 Jul 2023 03:02:59 -0700 (PDT)
Message-ID: <1aada499-4bb3-668c-10d0-06e0845efca1@arm.com>
Date:   Tue, 18 Jul 2023 11:02:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v1 2/3] mm: Implement folio_remove_rmap_range()
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Yin Fengwei <fengwei.yin@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Yu Zhao <yuzhao@google.com>, Yang Shi <shy828301@gmail.com>,
        Zi Yan <ziy@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <20230717143110.260162-1-ryan.roberts@arm.com>
 <20230717143110.260162-3-ryan.roberts@arm.com>
 <87zg3tbsn0.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <87zg3tbsn0.fsf@yhuang6-desk2.ccr.corp.intel.com>
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

On 18/07/2023 08:12, Huang, Ying wrote:
> Ryan Roberts <ryan.roberts@arm.com> writes:
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
>> + * @vma:        the vm area from which the mapping is removed
>> + *
>> + * The caller needs to hold the pte lock.
>> + */
>> +void folio_remove_rmap_range(struct folio *folio, struct page *page,
>> +					int nr, struct vm_area_struct *vma)
> 
> Can we call folio_remove_ramp_range() in page_remove_rmap() if
> !compound?  This can give us some opportunities to reduce code
> duplication?

I considered that, but if felt like the savings were pretty small so my opinion
was that it was cleaner not to do this. This is the best I came up with. Perhaps
you can see further improvements?

void page_remove_rmap(struct page *page, struct vm_area_struct *vma,
		bool compound)
{
	struct folio *folio = page_folio(page);
	atomic_t *mapped = &folio->_nr_pages_mapped;
	int nr = 0, nr_pmdmapped = 0;
	bool last;
	enum node_stat_item idx;

	VM_BUG_ON_PAGE(compound && !PageHead(page), page);

	/* Hugetlb pages are not counted in NR_*MAPPED */
	if (unlikely(folio_test_hugetlb(folio))) {
		/* hugetlb pages are always mapped with pmds */
		atomic_dec(&folio->_entire_mapcount);
		return;
	}

	/* Is page being unmapped by PTE? Is this its last map to be removed? */
	if (likely(!compound)) {
		folio_remove_rmap_range(folio, page, 1, vma);
		return;
	} else if (folio_test_pmd_mappable(folio)) {
		/* That test is redundant: it's for safety or to optimize out */

		last = atomic_add_negative(-1, &folio->_entire_mapcount);
		if (last) {
			nr = atomic_sub_return_relaxed(COMPOUND_MAPPED, mapped);
			if (likely(nr < COMPOUND_MAPPED)) {
				nr_pmdmapped = folio_nr_pages(folio);
				nr = nr_pmdmapped - (nr & FOLIO_PAGES_MAPPED);
				/* Raced ahead of another remove and an add? */
				if (unlikely(nr < 0))
					nr = 0;
			} else {
				/* An add of COMPOUND_MAPPED raced ahead */
				nr = 0;
			}
		}
	}

	if (nr_pmdmapped) {
		if (folio_test_anon(folio))
			idx = NR_ANON_THPS;
		else if (folio_test_swapbacked(folio))
			idx = NR_SHMEM_PMDMAPPED;
		else
			idx = NR_FILE_PMDMAPPED;
		__lruvec_stat_mod_folio(folio, idx, -nr_pmdmapped);
	}
	if (nr) {
		idx = folio_test_anon(folio) ? NR_ANON_MAPPED : NR_FILE_MAPPED;
		__lruvec_stat_mod_folio(folio, idx, -nr);

		/*
		 * Queue anon THP for deferred split if at least one
		 * page of the folio is unmapped and at least one page
		 * is still mapped.
		 */
		if (folio_test_anon(folio) && nr < nr_pmdmapped)
			deferred_split_folio(folio);
	}

	/*
	 * It would be tidy to reset folio_test_anon mapping when fully
	 * unmapped, but that might overwrite a racing page_add_anon_rmap
	 * which increments mapcount after us but sets mapping before us:
	 * so leave the reset to free_pages_prepare, and remember that
	 * it's only reliable while mapped.
	 */

	munlock_vma_folio(folio, vma, compound);
}

> 
> Best Regards,
> Huang, Ying
> 
