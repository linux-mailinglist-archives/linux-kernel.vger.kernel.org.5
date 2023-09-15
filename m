Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62FA67A1A9B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 11:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233639AbjIOJde (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 05:33:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233351AbjIOJdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 05:33:32 -0400
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6C61CED
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 02:33:26 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R571e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0Vs6ltje_1694770402;
Received: from 30.97.48.69(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0Vs6ltje_1694770402)
          by smtp.aliyun-inc.com;
          Fri, 15 Sep 2023 17:33:23 +0800
Message-ID: <1d2e6eff-027b-bf27-924d-c232667d0845@linux.alibaba.com>
Date:   Fri, 15 Sep 2023 17:33:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [RFC PATCH 1/4] mm/compaction: add support for >0 order folio
 memory compaction.
To:     Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Ryan Roberts <ryan.roberts@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        "Yin, Fengwei" <fengwei.yin@intel.com>,
        Yu Zhao <yuzhao@google.com>, Vlastimil Babka <vbabka@suse.cz>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Kemeng Shi <shikemeng@huaweicloud.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Rohan Puri <rohan.puri15@gmail.com>,
        Mcgrof Chamberlain <mcgrof@kernel.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        John Hubbard <jhubbard@nvidia.com>
References: <20230912162815.440749-1-zi.yan@sent.com>
 <20230912162815.440749-2-zi.yan@sent.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20230912162815.440749-2-zi.yan@sent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.4 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/13/2023 12:28 AM, Zi Yan wrote:
> From: Zi Yan <ziy@nvidia.com>
> 
> Before, memory compaction only migrates order-0 folios and skips >0 order
> folios. This commit adds support for >0 order folio compaction by keeping
> isolated free pages at their original size without splitting them into
> order-0 pages and using them directly during migration process.
> 
> What is different from the prior implementation:
> 1. All isolated free pages are kept in a MAX_ORDER+1 array of page lists,
>     where each page list stores free pages in the same order.
> 2. All free pages are not post_alloc_hook() processed nor buddy pages,
>     although their orders are stored in first page's private like buddy
>     pages.
> 3. During migration, in new page allocation time (i.e., in
>     compaction_alloc()), free pages are then processed by post_alloc_hook().
>     When migration fails and a new page is returned (i.e., in
>     compaction_free()), free pages are restored by reversing the
>     post_alloc_hook() operations.
> 
> Step 3 is done for a latter optimization that splitting and/or merging free
> pages during compaction becomes easier.
> 
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> ---
>   mm/compaction.c | 108 +++++++++++++++++++++++++++++++++++++++---------
>   mm/internal.h   |   7 +++-
>   2 files changed, 94 insertions(+), 21 deletions(-)
> 
> diff --git a/mm/compaction.c b/mm/compaction.c
> index 01ba298739dd..868e92e55d27 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -107,6 +107,44 @@ static void split_map_pages(struct list_head *list)
>   	list_splice(&tmp_list, list);
>   }
>   
> +static unsigned long release_free_list(struct free_list *freepages)
> +{
> +	int order;
> +	unsigned long high_pfn = 0;
> +
> +	for (order = 0; order <= MAX_ORDER; order++) {
> +		struct page *page, *next;
> +
> +		list_for_each_entry_safe(page, next, &freepages[order].pages, lru) {
> +			unsigned long pfn = page_to_pfn(page);
> +
> +			list_del(&page->lru);
> +			/*
> +			 * Convert free pages into post allocation pages, so
> +			 * that we can free them via __free_page.
> +			 */
> +			post_alloc_hook(page, order, __GFP_MOVABLE);
> +			__free_pages(page, order);
> +			if (pfn > high_pfn)
> +				high_pfn = pfn;
> +		}
> +	}
> +	return high_pfn;
> +}
> +
> +static void sort_free_pages(struct list_head *src, struct free_list *dst)
> +{
> +	unsigned int order;
> +	struct page *page, *next;
> +
> +	list_for_each_entry_safe(page, next, src, lru) {
> +		order = buddy_order(page);

These pages are already isolated from the buddy system, but continue to 
use buddy_order() to get the page order, which can be confused. 
Moreover, the buddy_order() should be under the zone lock protection.

IMO, just use 'page_private()' to get the page order like 
split_map_pages() already did, that seems more readable.

> +
> +		list_move(&page->lru, &dst[order].pages);
> +		dst[order].nr_free++;
> +	}
> +}
> +
>   #ifdef CONFIG_COMPACTION
>   bool PageMovable(struct page *page)
>   {
> @@ -1422,6 +1460,7 @@ fast_isolate_around(struct compact_control *cc, unsigned long pfn)
>   {
>   	unsigned long start_pfn, end_pfn;
>   	struct page *page;
> +	LIST_HEAD(freelist);
>   
>   	/* Do not search around if there are enough pages already */
>   	if (cc->nr_freepages >= cc->nr_migratepages)
> @@ -1439,7 +1478,8 @@ fast_isolate_around(struct compact_control *cc, unsigned long pfn)
>   	if (!page)
>   		return;
>   
> -	isolate_freepages_block(cc, &start_pfn, end_pfn, &cc->freepages, 1, false);
> +	isolate_freepages_block(cc, &start_pfn, end_pfn, &freelist, 1, false);
> +	sort_free_pages(&freelist, cc->freepages);
>   
>   	/* Skip this pageblock in the future as it's full or nearly full */
>   	if (start_pfn == end_pfn && !cc->no_set_skip_hint)
> @@ -1568,7 +1608,7 @@ static void fast_isolate_freepages(struct compact_control *cc)
>   				nr_scanned += nr_isolated - 1;
>   				total_isolated += nr_isolated;
>   				cc->nr_freepages += nr_isolated;
> -				list_add_tail(&page->lru, &cc->freepages);
> +				list_add_tail(&page->lru, &cc->freepages[order].pages);

Missed to update cc->freepages[order].nr_free?

>   				count_compact_events(COMPACTISOLATED, nr_isolated);
>   			} else {
>   				/* If isolation fails, abort the search */
> @@ -1642,13 +1682,13 @@ static void isolate_freepages(struct compact_control *cc)
>   	unsigned long isolate_start_pfn; /* exact pfn we start at */
>   	unsigned long block_end_pfn;	/* end of current pageblock */
>   	unsigned long low_pfn;	     /* lowest pfn scanner is able to scan */
> -	struct list_head *freelist = &cc->freepages;
>   	unsigned int stride;
> +	LIST_HEAD(freelist);
>   
>   	/* Try a small search of the free lists for a candidate */
>   	fast_isolate_freepages(cc);
>   	if (cc->nr_freepages)
> -		goto splitmap;
> +		return;
>   
>   	/*
>   	 * Initialise the free scanner. The starting point is where we last
> @@ -1708,7 +1748,8 @@ static void isolate_freepages(struct compact_control *cc)
>   
>   		/* Found a block suitable for isolating free pages from. */
>   		nr_isolated = isolate_freepages_block(cc, &isolate_start_pfn,
> -					block_end_pfn, freelist, stride, false);
> +					block_end_pfn, &freelist, stride, false);
> +		sort_free_pages(&freelist, cc->freepages);
>   
>   		/* Update the skip hint if the full pageblock was scanned */
>   		if (isolate_start_pfn == block_end_pfn)
> @@ -1749,10 +1790,6 @@ static void isolate_freepages(struct compact_control *cc)
>   	 * and the loop terminated due to isolate_start_pfn < low_pfn
>   	 */
>   	cc->free_pfn = isolate_start_pfn;
> -
> -splitmap:
> -	/* __isolate_free_page() does not map the pages */
> -	split_map_pages(freelist);
>   }
>   
>   /*
> @@ -1763,18 +1800,21 @@ static struct folio *compaction_alloc(struct folio *src, unsigned long data)
>   {
>   	struct compact_control *cc = (struct compact_control *)data;
>   	struct folio *dst;
> +	int order = folio_order(src);
>   
> -	if (list_empty(&cc->freepages)) {
> +	if (!cc->freepages[order].nr_free) {
>   		isolate_freepages(cc);
> -
> -		if (list_empty(&cc->freepages))
> +		if (!cc->freepages[order].nr_free)
>   			return NULL;
>   	}
>   
> -	dst = list_entry(cc->freepages.next, struct folio, lru);
> +	dst = list_first_entry(&cc->freepages[order].pages, struct folio, lru);
> +	cc->freepages[order].nr_free--;
>   	list_del(&dst->lru);
> -	cc->nr_freepages--;
> -
> +	post_alloc_hook(&dst->page, order, __GFP_MOVABLE);
> +	if (order)
> +		prep_compound_page(&dst->page, order);
> +	cc->nr_freepages -= 1 << order;
>   	return dst;
>   }
>   
> @@ -1786,9 +1826,34 @@ static struct folio *compaction_alloc(struct folio *src, unsigned long data)
>   static void compaction_free(struct folio *dst, unsigned long data)
>   {
>   	struct compact_control *cc = (struct compact_control *)data;
> +	int order = folio_order(dst);
> +	struct page *page = &dst->page;
>   
> -	list_add(&dst->lru, &cc->freepages);
> -	cc->nr_freepages++;
> +	if (order) {
> +		int i;
> +
> +		page[1].flags &= ~PAGE_FLAGS_SECOND;
> +		for (i = 1; i < (1 << order); i++) {
> +			page[i].mapping = NULL;
> +			clear_compound_head(&page[i]);
> +			page[i].flags &= ~PAGE_FLAGS_CHECK_AT_PREP;
> +		}
> +
> +	}
> +	/* revert post_alloc_hook() operations */
> +	page->mapping = NULL;
> +	page->flags &= ~PAGE_FLAGS_CHECK_AT_PREP;
> +	set_page_count(page, 0);
> +	page_mapcount_reset(page);
> +	reset_page_owner(page, order);
> +	page_table_check_free(page, order);
> +	arch_free_page(page, order);
> +	set_page_private(page, order);
> +	INIT_LIST_HEAD(&dst->lru);
> +
> +	list_add(&dst->lru, &cc->freepages[order].pages);
> +	cc->freepages[order].nr_free++;
> +	cc->nr_freepages += 1 << order;
>   }
>   
>   /* possible outcome of isolate_migratepages */
> @@ -2412,6 +2477,7 @@ compact_zone(struct compact_control *cc, struct capture_control *capc)
>   	const bool sync = cc->mode != MIGRATE_ASYNC;
>   	bool update_cached;
>   	unsigned int nr_succeeded = 0;
> +	int order;
>   
>   	/*
>   	 * These counters track activities during zone compaction.  Initialize
> @@ -2421,7 +2487,10 @@ compact_zone(struct compact_control *cc, struct capture_control *capc)
>   	cc->total_free_scanned = 0;
>   	cc->nr_migratepages = 0;
>   	cc->nr_freepages = 0;
> -	INIT_LIST_HEAD(&cc->freepages);
> +	for (order = 0; order <= MAX_ORDER; order++) {
> +		INIT_LIST_HEAD(&cc->freepages[order].pages);
> +		cc->freepages[order].nr_free = 0;
> +	}
>   	INIT_LIST_HEAD(&cc->migratepages);
>   
>   	cc->migratetype = gfp_migratetype(cc->gfp_mask);
> @@ -2607,7 +2676,7 @@ compact_zone(struct compact_control *cc, struct capture_control *capc)
>   	 * so we don't leave any returned pages behind in the next attempt.
>   	 */
>   	if (cc->nr_freepages > 0) {
> -		unsigned long free_pfn = release_freepages(&cc->freepages);
> +		unsigned long free_pfn = release_free_list(cc->freepages);
>   
>   		cc->nr_freepages = 0;
>   		VM_BUG_ON(free_pfn == 0);
> @@ -2626,7 +2695,6 @@ compact_zone(struct compact_control *cc, struct capture_control *capc)
>   
>   	trace_mm_compaction_end(cc, start_pfn, end_pfn, sync, ret);
>   
> -	VM_BUG_ON(!list_empty(&cc->freepages));
>   	VM_BUG_ON(!list_empty(&cc->migratepages));
>   
>   	return ret;
> diff --git a/mm/internal.h b/mm/internal.h
> index 8c90e966e9f8..f5c691bb5c1c 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -465,6 +465,11 @@ int split_free_page(struct page *free_page,
>   /*
>    * in mm/compaction.c
>    */
> +
> +struct free_list {
> +	struct list_head	pages;
> +	unsigned long		nr_free;
> +};
>   /*
>    * compact_control is used to track pages being migrated and the free pages
>    * they are being migrated to during memory compaction. The free_pfn starts
> @@ -473,7 +478,7 @@ int split_free_page(struct page *free_page,
>    * completes when free_pfn <= migrate_pfn
>    */
>   struct compact_control {
> -	struct list_head freepages;	/* List of free pages to migrate to */
> +	struct free_list freepages[MAX_ORDER + 1];	/* List of free pages to migrate to */
>   	struct list_head migratepages;	/* List of pages being migrated */
>   	unsigned int nr_freepages;	/* Number of isolated free pages */
>   	unsigned int nr_migratepages;	/* Number of pages to migrate */
