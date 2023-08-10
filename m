Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54CFF777B91
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 17:05:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235583AbjHJPF2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 11:05:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231825AbjHJPF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 11:05:27 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C23E52686
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 08:05:25 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E0CB6113E;
        Thu, 10 Aug 2023 08:06:07 -0700 (PDT)
Received: from [10.1.27.169] (XHFQ2J9959.cambridge.arm.com [10.1.27.169])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DF64C3F64C;
        Thu, 10 Aug 2023 08:05:22 -0700 (PDT)
Message-ID: <7ea93fd3-6278-45b1-b066-4d695c85ad31@arm.com>
Date:   Thu, 10 Aug 2023 16:05:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 4/4] mm/mmu_gather: Store and process pages in contig
 ranges
Content-Language: en-GB
To:     Zi Yan <ziy@nvidia.com>
Cc:     Will Deacon <will@kernel.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Yu Zhao <yuzhao@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yin Fengwei <fengwei.yin@intel.com>,
        Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20230810103332.3062143-1-ryan.roberts@arm.com>
 <20230810103332.3062143-5-ryan.roberts@arm.com>
 <800937DA-BAD0-4C60-B155-AECCA21E955E@nvidia.com>
 <1a0f5cb8-421c-4f28-a986-f3c381406e81@arm.com>
 <90EC4C0D-0254-4B93-AFD5-3C09580A77DE@nvidia.com>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <90EC4C0D-0254-4B93-AFD5-3C09580A77DE@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/08/2023 15:59, Zi Yan wrote:
> On 10 Aug 2023, at 10:55, Ryan Roberts wrote:
> 
>> On 10/08/2023 15:44, Zi Yan wrote:
>>> On 10 Aug 2023, at 6:33, Ryan Roberts wrote:
>>>
>>>> mmu_gather accumulates a set of pages into a buffer for later rmap
>>>> removal and freeing. Page pointers were previously stored in a "linked
>>>> list of arrays", then at flush time, each page in the buffer was removed
>>>> from the rmap, removed from the swapcache and its refcount was
>>>> decremented; if the refcount reached 0, then it was freed.
>>>>
>>>> With increasing numbers of large folios (or at least contiguous parts of
>>>> large folios) mapped into userspace processes (pagecache pages for
>>>> supporting filesystems currently, but in future also large anonymous
>>>> folios), we can measurably improve performance of process teardown:
>>>>
>>>> - For rmap removal, we can batch-remove a range of pages belonging to
>>>>   the same folio with folio_remove_rmap_range(), which is more efficient
>>>>   because atomics can be manipulated just once per range. In the common
>>>>   case, it also allows us to elide adding the (anon) folio to the
>>>>   deferred split queue, only to remove it a bit later, once all pages of
>>>>   the folio have been removed fro mthe rmap.
>>>>
>>>> - For swapcache removal, we only need to check and remove the folio from
>>>>   the swap cache once, rather than trying for each individual page.
>>>>
>>>> - For page release, we can batch-decrement the refcount for each page in
>>>>   the folio and free it if it hits zero.
>>>>
>>>> Change the page pointer storage format within the mmu_gather batch
>>>> structure to store "folio_range"s; a [start, end) page pointer pair.
>>>> This allows us to run length encode a contiguous range of pages that all
>>>> belong to the same folio. This likely allows us to improve cache
>>>> locality a bit. But it also gives us a convenient format for
>>>> implementing the above 3 optimizations.
>>>>
>>>> Of course if running on a system that does not extensively use large
>>>> pte-mapped folios, then the RLE approach uses twice as much memory,
>>>> because each range is 1 page long and uses 2 pointers. But performance
>>>> measurements show no impact in terms of performance.
>>>>
>>>> Macro Performance Results
>>>> -------------------------
>>>>
>>>> Test: Timed kernel compilation on Ampere Altra (arm64), 80 jobs
>>>> Configs: Comparing with and without large anon folios
>>>>
>>>> Without large anon folios:
>>>> | kernel           |   real-time |   kern-time |   user-time |
>>>> |:-----------------|------------:|------------:|------------:|
>>>> | baseline-laf-off |        0.0% |        0.0% |        0.0% |
>>>> | mmugather-range  |       -0.3% |       -0.3% |        0.1% |
>>>>
>>>> With large anon folios (order-3):
>>>> | kernel           |   real-time |   kern-time |   user-time |
>>>> |:-----------------|------------:|------------:|------------:|
>>>> | baseline-laf-on  |        0.0% |        0.0% |        0.0% |
>>>> | mmugather-range  |       -0.7% |       -3.9% |       -0.1% |
>>>>
>>>> Test: Timed kernel compilation in VM on Apple M2 MacBook Pro, 8 jobs
>>>> Configs: Comparing with and without large anon folios
>>>>
>>>> Without large anon folios:
>>>> | kernel           |   real-time |   kern-time |   user-time |
>>>> |:-----------------|------------:|------------:|------------:|
>>>> | baseline-laf-off |        0.0% |        0.0% |        0.0% |
>>>> | mmugather-range  |       -0.9% |       -2.9% |       -0.6% |
>>>>
>>>> With large anon folios (order-3):
>>>> | kernel           |   real-time |   kern-time |   user-time |
>>>> |:-----------------|------------:|------------:|------------:|
>>>> | baseline-laf-on  |        0.0% |        0.0% |        0.0% |
>>>> | mmugather-range  |       -0.4% |       -3.7% |       -0.2% |
>>>>
>>>> Micro Performance Results
>>>> -------------------------
>>>>
>>>> Flame graphs for kernel compilation on Ampere Altra show reduction in
>>>> cycles consumed by __arm64_sys_exit_group syscall:
>>>>
>>>>     Without large anon folios: -2%
>>>>     With large anon folios:    -26%
>>>>
>>>> For the large anon folios case, it also shows a big difference in cost
>>>> of rmap removal:
>>>>
>>>>    baseline: cycles in page_remove_rmap(): 24.7B
>>>>    mmugather-range: cycles in folio_remove_rmap_range(): 5.5B
>>>>
>>>> Furthermore, the baseline shows 5.2B cycles used by
>>>> deferred_split_folio() which has completely disappeared after
>>>> applying this series.
>>>>
>>>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>>>> ---
>>>>  include/asm-generic/tlb.h |  7 +--
>>>>  include/linux/mm.h        |  7 +++
>>>>  include/linux/swap.h      |  6 +--
>>>>  mm/mmu_gather.c           | 56 ++++++++++++++++++++----
>>>>  mm/swap.c                 | 91 +++++++++++++++++++++++++++++++++++++++
>>>>  mm/swap_state.c           | 11 ++---
>>>>  6 files changed, 158 insertions(+), 20 deletions(-)
>>>>
>>>> diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
>>>> index d874415aaa33..fe300a64e59d 100644
>>>> --- a/include/asm-generic/tlb.h
>>>> +++ b/include/asm-generic/tlb.h
>>>> @@ -246,11 +246,11 @@ struct mmu_gather_batch {
>>>>  	struct mmu_gather_batch	*next;
>>>>  	unsigned int		nr;
>>>>  	unsigned int		max;
>>>> -	struct page		*pages[];
>>>> +	struct folio_range	ranges[];
>>>>  };
>>>>
>>>>  #define MAX_GATHER_BATCH	\
>>>> -	((PAGE_SIZE - sizeof(struct mmu_gather_batch)) / sizeof(void *))
>>>> +	((PAGE_SIZE - sizeof(struct mmu_gather_batch)) / sizeof(struct folio_range))
>>>>
>>>>  /*
>>>>   * Limit the maximum number of mmu_gather batches to reduce a risk of soft
>>>> @@ -342,7 +342,8 @@ struct mmu_gather {
>>>>  #ifndef CONFIG_MMU_GATHER_NO_GATHER
>>>>  	struct mmu_gather_batch *active;
>>>>  	struct mmu_gather_batch	local;
>>>> -	struct page		*__pages[MMU_GATHER_BUNDLE];
>>>> +	struct folio_range	__ranges[MMU_GATHER_BUNDLE];
>>>> +	struct page		*range_limit;
>>>>  	struct mmu_gather_batch *rmap_pend;
>>>>  	unsigned int		rmap_pend_first;
>>>>
>>>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>>>> index 914e08185272..f86c905a065d 100644
>>>> --- a/include/linux/mm.h
>>>> +++ b/include/linux/mm.h
>>>> @@ -1513,6 +1513,13 @@ static inline void folio_put_refs(struct folio *folio, int refs)
>>>>  		__folio_put(folio);
>>>>  }
>>>>
>>>> +struct folio_range {
>>>> +	struct page *start;
>>>> +	struct page *end;
>>>> +};
>>>
>>> I see end is used for calculating nr_pages multiple times below. Maybe just
>>> use nr_pages instead of end here.
>>
>> But then I'd need to calculate end (= start + nr_pages) every time
>> __tlb_remove_page() is called to figure out if the page being removed is the
>> next contiguous page in the current range. __tlb_remove_page() gets called for
>> every page, but the current way I do it, I only calculate nr_pages once per
>> range. So I think my way is more efficient?
>>
>>>
>>> Also, struct page (memmap) might not be always contiguous, using struct page
>>> points to represent folio range might not give the result you want.
>>> See nth_page() and folio_page_idx() in include/linux/mm.h.
>>
>> Is that true for pages within the same folio too? Or are all pages in a folio
>> guarranteed contiguous? Perhaps I'm better off using pfn?
> 
> folio_page_idx() says not all pages in a folio is guaranteed to be contiguous.
> PFN might be a better choice.

OK thanks for pointing this out. I'll plan to use PFNs for v2, which I'll send
out once I'm back from holiday (and hopefully have feedback from others to roll
in too).

> 
>>
>>>
>>>> +
>>>> +void folios_put_refs(struct folio_range *folios, int nr);
>>>> +
>>>>  /*
>>>>   * union release_pages_arg - an array of pages or folios
>>>>   *
>>>> diff --git a/include/linux/swap.h b/include/linux/swap.h
>>>> index f199df803b33..06a7cf3ad6c9 100644
>>>> --- a/include/linux/swap.h
>>>> +++ b/include/linux/swap.h
>>>> @@ -453,7 +453,7 @@ static inline unsigned long total_swapcache_pages(void)
>>>>
>>>>  extern void free_swap_cache(struct page *page);
>>>>  extern void free_page_and_swap_cache(struct page *);
>>>> -extern void free_pages_and_swap_cache(struct page **, int);
>>>> +extern void free_folios_and_swap_cache(struct folio_range *, int);
>>>>  /* linux/mm/swapfile.c */
>>>>  extern atomic_long_t nr_swap_pages;
>>>>  extern long total_swap_pages;
>>>> @@ -530,8 +530,8 @@ static inline void put_swap_device(struct swap_info_struct *si)
>>>>   * so leave put_page and release_pages undeclared... */
>>>>  #define free_page_and_swap_cache(page) \
>>>>  	put_page(page)
>>>> -#define free_pages_and_swap_cache(pages, nr) \
>>>> -	release_pages((pages), (nr));
>>>> +#define free_folios_and_swap_cache(folios, nr) \
>>>> +	folios_put_refs((folios), (nr))
>>>>
>>>>  /* used to sanity check ptes in zap_pte_range when CONFIG_SWAP=0 */
>>>>  #define free_swap_and_cache(e) is_pfn_swap_entry(e)
>>>> diff --git a/mm/mmu_gather.c b/mm/mmu_gather.c
>>>> index 5d100ac85e21..fd2ea7577817 100644
>>>> --- a/mm/mmu_gather.c
>>>> +++ b/mm/mmu_gather.c
>>>> @@ -22,6 +22,7 @@ static bool tlb_next_batch(struct mmu_gather *tlb)
>>>>  	batch = tlb->active;
>>>>  	if (batch->next) {
>>>>  		tlb->active = batch->next;
>>>> +		tlb->range_limit = NULL;
>>>>  		return true;
>>>>  	}
>>>>
>>>> @@ -39,6 +40,7 @@ static bool tlb_next_batch(struct mmu_gather *tlb)
>>>>
>>>>  	tlb->active->next = batch;
>>>>  	tlb->active = batch;
>>>> +	tlb->range_limit = NULL;
>>>>
>>>>  	return true;
>>>>  }
>>>> @@ -49,9 +51,11 @@ static void tlb_flush_rmap_batch(struct mmu_gather_batch *batch,
>>>>  				 struct vm_area_struct *vma)
>>>>  {
>>>>  	for (int i = first; i < batch->nr; i++) {
>>>> -		struct page *page = batch->pages[i];
>>>> +		struct folio_range *range = &batch->ranges[i];
>>>> +		int nr = range->end - range->start;
>>>> +		struct folio *folio = page_folio(range->start);
>>>>
>>>> -		page_remove_rmap(page, vma, false);
>>>> +		folio_remove_rmap_range(folio, range->start, nr, vma);
>>>>  	}
>>>>  }
>>>>
>>>> @@ -75,6 +79,11 @@ void tlb_flush_rmaps(struct mmu_gather *tlb, struct vm_area_struct *vma)
>>>>  	for (batch = batch->next; batch && batch->nr; batch = batch->next)
>>>>  		tlb_flush_rmap_batch(batch, 0, vma);
>>>>
>>>> +	/*
>>>> +	 * Move to the next range on next page insertion to prevent any future
>>>> +	 * pages from being accumulated into the range we just did the rmap for.
>>>> +	 */
>>>> +	tlb->range_limit = NULL;
>>>>  	tlb_discard_rmaps(tlb);
>>>>  }
>>>>
>>>> @@ -94,7 +103,7 @@ static void tlb_batch_pages_flush(struct mmu_gather *tlb)
>>>>  	struct mmu_gather_batch *batch;
>>>>
>>>>  	for (batch = &tlb->local; batch && batch->nr; batch = batch->next) {
>>>> -		struct page **pages = batch->pages;
>>>> +		struct folio_range *ranges = batch->ranges;
>>>>
>>>>  		do {
>>>>  			/*
>>>> @@ -102,14 +111,15 @@ static void tlb_batch_pages_flush(struct mmu_gather *tlb)
>>>>  			 */
>>>>  			unsigned int nr = min(512U, batch->nr);
>>>>
>>>> -			free_pages_and_swap_cache(pages, nr);
>>>> -			pages += nr;
>>>> +			free_folios_and_swap_cache(ranges, nr);
>>>> +			ranges += nr;
>>>>  			batch->nr -= nr;
>>>>
>>>>  			cond_resched();
>>>>  		} while (batch->nr);
>>>>  	}
>>>>  	tlb->active = &tlb->local;
>>>> +	tlb->range_limit = NULL;
>>>>  	tlb_discard_rmaps(tlb);
>>>>  }
>>>>
>>>> @@ -127,6 +137,7 @@ static void tlb_batch_list_free(struct mmu_gather *tlb)
>>>>  bool __tlb_remove_page_size(struct mmu_gather *tlb, struct page *page, int page_size)
>>>>  {
>>>>  	struct mmu_gather_batch *batch;
>>>> +	struct folio_range *range;
>>>>
>>>>  	VM_BUG_ON(!tlb->end);
>>>>
>>>> @@ -135,11 +146,37 @@ bool __tlb_remove_page_size(struct mmu_gather *tlb, struct page *page, int page_
>>>>  #endif
>>>>
>>>>  	batch = tlb->active;
>>>> +	range = &batch->ranges[batch->nr - 1];
>>>> +
>>>> +	/*
>>>> +	 * If there is a range being accumulated, add the page to the range if
>>>> +	 * its contiguous, else start the next range. range_limit is always NULL
>>>> +	 * when nr is 0, which protects the batch->ranges[-1] case.
>>>> +	 */
>>>> +	if (tlb->range_limit && page == range->end) {
>>>> +		range->end++;
>>>> +	} else {
>>>> +		struct folio *folio = page_folio(page);
>>>> +
>>>> +		range = &batch->ranges[batch->nr++];
>>>> +		range->start = page;
>>>> +		range->end = page + 1;
>>>> +
>>>> +		tlb->range_limit = &folio->page + folio_nr_pages(folio);
>>>> +	}
>>>> +
>>>> +	/*
>>>> +	 * If we have reached the end of the folio, move to the next range when
>>>> +	 * we add the next page; Never span multiple folios in the same range.
>>>> +	 */
>>>> +	if (range->end == tlb->range_limit)
>>>> +		tlb->range_limit = NULL;
>>>> +
>>>>  	/*
>>>> -	 * Add the page and check if we are full. If so
>>>> -	 * force a flush.
>>>> +	 * Check if we are full. If so force a flush. In order to ensure we
>>>> +	 * always have a free range for the next added page, the last range in a
>>>> +	 * batch always only has a single page.
>>>>  	 */
>>>> -	batch->pages[batch->nr++] = page;
>>>>  	if (batch->nr == batch->max) {
>>>>  		if (!tlb_next_batch(tlb))
>>>>  			return true;
>>>> @@ -318,8 +355,9 @@ static void __tlb_gather_mmu(struct mmu_gather *tlb, struct mm_struct *mm,
>>>>  	tlb->need_flush_all = 0;
>>>>  	tlb->local.next = NULL;
>>>>  	tlb->local.nr   = 0;
>>>> -	tlb->local.max  = ARRAY_SIZE(tlb->__pages);
>>>> +	tlb->local.max  = ARRAY_SIZE(tlb->__ranges);
>>>>  	tlb->active     = &tlb->local;
>>>> +	tlb->range_limit = NULL;
>>>>  	tlb->batch_count = 0;
>>>>  	tlb->rmap_pend	= &tlb->local;
>>>>  	tlb->rmap_pend_first = 0;
>>>> diff --git a/mm/swap.c b/mm/swap.c
>>>> index b05cce475202..e238d3623fcb 100644
>>>> --- a/mm/swap.c
>>>> +++ b/mm/swap.c
>>>> @@ -1041,6 +1041,97 @@ void release_pages(release_pages_arg arg, int nr)
>>>>  }
>>>>  EXPORT_SYMBOL(release_pages);
>>>>
>>>> +/**
>>>> + * folios_put_refs - batched folio_put_refs()
>>>> + * @folios: array of `struct folio_range`s to release
>>>> + * @nr: number of folio ranges
>>>> + *
>>>> + * Each `struct folio_range` describes the start and end page of a range within
>>>> + * a folio. The folio reference count is decremented once for each page in the
>>>> + * range. If it fell to zero, remove the page from the LRU and free it.
>>>> + */
>>>> +void folios_put_refs(struct folio_range *folios, int nr)
>>>> +{
>>>> +	int i;
>>>> +	LIST_HEAD(pages_to_free);
>>>> +	struct lruvec *lruvec = NULL;
>>>> +	unsigned long flags = 0;
>>>> +	unsigned int lock_batch;
>>>> +
>>>> +	for (i = 0; i < nr; i++) {
>>>> +		struct folio *folio = page_folio(folios[i].start);
>>>> +		int refs = folios[i].end - folios[i].start;
>>>> +
>>>> +		/*
>>>> +		 * Make sure the IRQ-safe lock-holding time does not get
>>>> +		 * excessive with a continuous string of pages from the
>>>> +		 * same lruvec. The lock is held only if lruvec != NULL.
>>>> +		 */
>>>> +		if (lruvec && ++lock_batch == SWAP_CLUSTER_MAX) {
>>>> +			unlock_page_lruvec_irqrestore(lruvec, flags);
>>>> +			lruvec = NULL;
>>>> +		}
>>>> +
>>>> +		if (is_huge_zero_page(&folio->page))
>>>> +			continue;
>>>> +
>>>> +		if (folio_is_zone_device(folio)) {
>>>> +			if (lruvec) {
>>>> +				unlock_page_lruvec_irqrestore(lruvec, flags);
>>>> +				lruvec = NULL;
>>>> +			}
>>>> +			if (put_devmap_managed_page(&folio->page))
>>>> +				continue;
>>>> +			if (folio_put_testzero(folio))
>>>> +				free_zone_device_page(&folio->page);
>>>> +			continue;
>>>> +		}
>>>> +
>>>> +		if (!folio_ref_sub_and_test(folio, refs))
>>>> +			continue;
>>>> +
>>>> +		if (folio_test_large(folio)) {
>>>> +			if (lruvec) {
>>>> +				unlock_page_lruvec_irqrestore(lruvec, flags);
>>>> +				lruvec = NULL;
>>>> +			}
>>>> +			__folio_put_large(folio);
>>>> +			continue;
>>>> +		}
>>>> +
>>>> +		if (folio_test_lru(folio)) {
>>>> +			struct lruvec *prev_lruvec = lruvec;
>>>> +
>>>> +			lruvec = folio_lruvec_relock_irqsave(folio, lruvec,
>>>> +									&flags);
>>>> +			if (prev_lruvec != lruvec)
>>>> +				lock_batch = 0;
>>>> +
>>>> +			lruvec_del_folio(lruvec, folio);
>>>> +			__folio_clear_lru_flags(folio);
>>>> +		}
>>>> +
>>>> +		/*
>>>> +		 * In rare cases, when truncation or holepunching raced with
>>>> +		 * munlock after VM_LOCKED was cleared, Mlocked may still be
>>>> +		 * found set here.  This does not indicate a problem, unless
>>>> +		 * "unevictable_pgs_cleared" appears worryingly large.
>>>> +		 */
>>>> +		if (unlikely(folio_test_mlocked(folio))) {
>>>> +			__folio_clear_mlocked(folio);
>>>> +			zone_stat_sub_folio(folio, NR_MLOCK);
>>>> +			count_vm_event(UNEVICTABLE_PGCLEARED);
>>>> +		}
>>>> +
>>>> +		list_add(&folio->lru, &pages_to_free);
>>>> +	}
>>>> +	if (lruvec)
>>>> +		unlock_page_lruvec_irqrestore(lruvec, flags);
>>>> +
>>>> +	mem_cgroup_uncharge_list(&pages_to_free);
>>>> +	free_unref_page_list(&pages_to_free);
>>>> +}
>>>> +
>>>>  /*
>>>>   * The folios which we're about to release may be in the deferred lru-addition
>>>>   * queues.  That would prevent them from really being freed right now.  That's
>>>> diff --git a/mm/swap_state.c b/mm/swap_state.c
>>>> index 73b16795b0ff..526bbd5a2ce1 100644
>>>> --- a/mm/swap_state.c
>>>> +++ b/mm/swap_state.c
>>>> @@ -304,15 +304,16 @@ void free_page_and_swap_cache(struct page *page)
>>>>  }
>>>>
>>>>  /*
>>>> - * Passed an array of pages, drop them all from swapcache and then release
>>>> - * them.  They are removed from the LRU and freed if this is their last use.
>>>> + * Passed an array of folio ranges, drop all folios from swapcache and then put
>>>> + * a folio reference for each page in the range.  They are removed from the LRU
>>>> + * and freed if this is their last use.
>>>>   */
>>>> -void free_pages_and_swap_cache(struct page **pages, int nr)
>>>> +void free_folios_and_swap_cache(struct folio_range *folios, int nr)
>>>>  {
>>>>  	lru_add_drain();
>>>>  	for (int i = 0; i < nr; i++)
>>>> -		free_swap_cache(pages[i]);
>>>> -	release_pages(pages, nr);
>>>> +		free_swap_cache(folios[i].start);
>>>> +	folios_put_refs(folios, nr);
>>>>  }
>>>>
>>>>  static inline bool swap_use_vma_readahead(void)
>>>> -- 
>>>> 2.25.1
>>>
>>>
>>> --
>>> Best Regards,
>>> Yan, Zi
> 
> 
> --
> Best Regards,
> Yan, Zi

