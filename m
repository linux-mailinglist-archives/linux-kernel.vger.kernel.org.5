Return-Path: <linux-kernel+bounces-134326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 876CB89B058
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 12:19:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBEE2282514
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 10:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00B781803D;
	Sun,  7 Apr 2024 10:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="wUJA6P2x"
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B29317999
	for <linux-kernel@vger.kernel.org>; Sun,  7 Apr 2024 10:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712485175; cv=none; b=MPmYZbWhpJGuIoPTs+YCNZH9lkcGix0fhMrpGOKkkXjyffRDpvVher4LY8wAbqz3lA33OsauS+q3koSjNGoox2jfaw6u601shSabmp0t5hNo9rVZP28dmQJYGnUVMEM2S+vGPi1LsM/4bi4K/OIo5+FyEkTkBVrgUFUNt2oLSSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712485175; c=relaxed/simple;
	bh=bsgip3n/m0ReW0NrMyJOczmPPS89GNi3lR+Z8ySCyzQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DtXk5Z1cnW1jIJdLwqvmGjeFBPDL42UYAn37lXBpbv9Zo3lyOBUOek99SNMWpHTRnxGGroD/+mSYLTmcEmDCWbzl1cu5qliDbUPdjdx5SEoRBjzlwDW/ZGIhqICT/0sZoVRg+CV4vbZfVv00us4MRQNP36/RP6n5OADMlFs+yuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=wUJA6P2x; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1712485170; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=OzPx/B+ze8m0dLabdMr0UmZCaMr0YAFjdV5UZixpvRI=;
	b=wUJA6P2xwces5IWHt4GhUZYiZBm6nZcPt/7g1Vjcoo0Oygky03K0TnoKEgDirvM9UYIi3PgNfdrNouYnzjLX7p/zqnMB1NKz/xzXqqzaPQTWAIXOG1E71Dd6KbptIm3oWgez4wlP0UOqR5JFEnsK5PUCkUuSb5sCccgVjRtr/JA=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W407tQp_1712485168;
Received: from 30.97.56.66(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W407tQp_1712485168)
          by smtp.aliyun-inc.com;
          Sun, 07 Apr 2024 18:19:29 +0800
Message-ID: <7b3b7f2e-7109-4e72-b1cf-259cb56f3629@linux.alibaba.com>
Date: Sun, 7 Apr 2024 18:19:28 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/10] mm: page_alloc: consolidate free page accounting
To: Johannes Weiner <hannes@cmpxchg.org>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, Mel Gorman
 <mgorman@techsingularity.net>, Zi Yan <ziy@nvidia.com>,
 "Huang, Ying" <ying.huang@intel.com>, David Hildenbrand <david@redhat.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240320180429.678181-1-hannes@cmpxchg.org>
 <20240320180429.678181-11-hannes@cmpxchg.org>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20240320180429.678181-11-hannes@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/3/21 02:02, Johannes Weiner wrote:
> Free page accounting currently happens a bit too high up the call
> stack, where it has to deal with guard pages, compaction capturing,
> block stealing and even page isolation. This is subtle and fragile,
> and makes it difficult to hack on the code.
> 
> Now that type violations on the freelists have been fixed, push the
> accounting down to where pages enter and leave the freelist.
> 
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> ---
>   include/linux/mm.h     |  18 ++--
>   include/linux/vmstat.h |   8 --
>   mm/debug_page_alloc.c  |  12 +--
>   mm/internal.h          |   5 --
>   mm/page_alloc.c        | 194 +++++++++++++++++++++++------------------
>   mm/page_isolation.c    |   3 +-
>   6 files changed, 120 insertions(+), 120 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 8147b1302413..bd2e94391c7e 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -3781,24 +3781,22 @@ static inline bool page_is_guard(struct page *page)
>   	return PageGuard(page);
>   }
>   
> -bool __set_page_guard(struct zone *zone, struct page *page, unsigned int order,
> -		      int migratetype);
> +bool __set_page_guard(struct zone *zone, struct page *page, unsigned int order);
>   static inline bool set_page_guard(struct zone *zone, struct page *page,
> -				  unsigned int order, int migratetype)
> +				  unsigned int order)
>   {
>   	if (!debug_guardpage_enabled())
>   		return false;
> -	return __set_page_guard(zone, page, order, migratetype);
> +	return __set_page_guard(zone, page, order);
>   }
>   
> -void __clear_page_guard(struct zone *zone, struct page *page, unsigned int order,
> -			int migratetype);
> +void __clear_page_guard(struct zone *zone, struct page *page, unsigned int order);
>   static inline void clear_page_guard(struct zone *zone, struct page *page,
> -				    unsigned int order, int migratetype)
> +				    unsigned int order)
>   {
>   	if (!debug_guardpage_enabled())
>   		return;
> -	__clear_page_guard(zone, page, order, migratetype);
> +	__clear_page_guard(zone, page, order);
>   }
>   
>   #else	/* CONFIG_DEBUG_PAGEALLOC */
> @@ -3808,9 +3806,9 @@ static inline unsigned int debug_guardpage_minorder(void) { return 0; }
>   static inline bool debug_guardpage_enabled(void) { return false; }
>   static inline bool page_is_guard(struct page *page) { return false; }
>   static inline bool set_page_guard(struct zone *zone, struct page *page,
> -			unsigned int order, int migratetype) { return false; }
> +			unsigned int order) { return false; }
>   static inline void clear_page_guard(struct zone *zone, struct page *page,
> -				unsigned int order, int migratetype) {}
> +				unsigned int order) {}
>   #endif	/* CONFIG_DEBUG_PAGEALLOC */
>   
>   #ifdef __HAVE_ARCH_GATE_AREA
> diff --git a/include/linux/vmstat.h b/include/linux/vmstat.h
> index 343906a98d6e..735eae6e272c 100644
> --- a/include/linux/vmstat.h
> +++ b/include/linux/vmstat.h
> @@ -487,14 +487,6 @@ static inline void node_stat_sub_folio(struct folio *folio,
>   	mod_node_page_state(folio_pgdat(folio), item, -folio_nr_pages(folio));
>   }
>   
> -static inline void __mod_zone_freepage_state(struct zone *zone, int nr_pages,
> -					     int migratetype)
> -{
> -	__mod_zone_page_state(zone, NR_FREE_PAGES, nr_pages);
> -	if (is_migrate_cma(migratetype))
> -		__mod_zone_page_state(zone, NR_FREE_CMA_PAGES, nr_pages);
> -}
> -
>   extern const char * const vmstat_text[];
>   
>   static inline const char *zone_stat_name(enum zone_stat_item item)
> diff --git a/mm/debug_page_alloc.c b/mm/debug_page_alloc.c
> index 6755f0c9d4a3..d46acf989dde 100644
> --- a/mm/debug_page_alloc.c
> +++ b/mm/debug_page_alloc.c
> @@ -32,8 +32,7 @@ static int __init debug_guardpage_minorder_setup(char *buf)
>   }
>   early_param("debug_guardpage_minorder", debug_guardpage_minorder_setup);
>   
> -bool __set_page_guard(struct zone *zone, struct page *page, unsigned int order,
> -		      int migratetype)
> +bool __set_page_guard(struct zone *zone, struct page *page, unsigned int order)
>   {
>   	if (order >= debug_guardpage_minorder())
>   		return false;
> @@ -41,19 +40,12 @@ bool __set_page_guard(struct zone *zone, struct page *page, unsigned int order,
>   	__SetPageGuard(page);
>   	INIT_LIST_HEAD(&page->buddy_list);
>   	set_page_private(page, order);
> -	/* Guard pages are not available for any usage */
> -	if (!is_migrate_isolate(migratetype))
> -		__mod_zone_freepage_state(zone, -(1 << order), migratetype);
>   
>   	return true;
>   }
>   
> -void __clear_page_guard(struct zone *zone, struct page *page, unsigned int order,
> -		      int migratetype)
> +void __clear_page_guard(struct zone *zone, struct page *page, unsigned int order)
>   {
>   	__ClearPageGuard(page);
> -
>   	set_page_private(page, 0);
> -	if (!is_migrate_isolate(migratetype))
> -		__mod_zone_freepage_state(zone, (1 << order), migratetype);
>   }
> diff --git a/mm/internal.h b/mm/internal.h
> index d6e6c7d9f04e..0a4007b03d0d 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -1036,11 +1036,6 @@ static inline bool is_migrate_highatomic(enum migratetype migratetype)
>   	return migratetype == MIGRATE_HIGHATOMIC;
>   }
>   
> -static inline bool is_migrate_highatomic_page(struct page *page)
> -{
> -	return get_pageblock_migratetype(page) == MIGRATE_HIGHATOMIC;
> -}
> -
>   void setup_zone_pageset(struct zone *zone);
>   
>   struct migration_target_control {
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index efb2581ac142..c46491f83ac2 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -642,42 +642,72 @@ compaction_capture(struct capture_control *capc, struct page *page,
>   }
>   #endif /* CONFIG_COMPACTION */
>   
> -/* Used for pages not on another list */
> -static inline void add_to_free_list(struct page *page, struct zone *zone,
> -				    unsigned int order, int migratetype)
> +static inline void account_freepages(struct page *page, struct zone *zone,
> +				     int nr_pages, int migratetype)
>   {
> -	struct free_area *area = &zone->free_area[order];
> +	if (is_migrate_isolate(migratetype))
> +		return;
>   
> -	list_add(&page->buddy_list, &area->free_list[migratetype]);
> -	area->nr_free++;
> +	__mod_zone_page_state(zone, NR_FREE_PAGES, nr_pages);
> +
> +	if (is_migrate_cma(migratetype))
> +		__mod_zone_page_state(zone, NR_FREE_CMA_PAGES, nr_pages);
>   }
>   
>   /* Used for pages not on another list */
> -static inline void add_to_free_list_tail(struct page *page, struct zone *zone,
> -					 unsigned int order, int migratetype)
> +static inline void __add_to_free_list(struct page *page, struct zone *zone,
> +				      unsigned int order, int migratetype,
> +				      bool tail)
>   {
>   	struct free_area *area = &zone->free_area[order];
>   
> -	list_add_tail(&page->buddy_list, &area->free_list[migratetype]);
> +	VM_WARN_ONCE(get_pageblock_migratetype(page) != migratetype,
> +		     "page type is %lu, passed migratetype is %d (nr=%d)\n",
> +		     get_pageblock_migratetype(page), migratetype, 1 << order);
> +
> +	if (tail)
> +		list_add_tail(&page->buddy_list, &area->free_list[migratetype]);
> +	else
> +		list_add(&page->buddy_list, &area->free_list[migratetype]);
>   	area->nr_free++;
>   }
>   
> +static inline void add_to_free_list(struct page *page, struct zone *zone,
> +				    unsigned int order, int migratetype,
> +				    bool tail)
> +{
> +	__add_to_free_list(page, zone, order, migratetype, tail);
> +	account_freepages(page, zone, 1 << order, migratetype);
> +}
> +
>   /*
>    * Used for pages which are on another list. Move the pages to the tail
>    * of the list - so the moved pages won't immediately be considered for
>    * allocation again (e.g., optimization for memory onlining).
>    */
>   static inline void move_to_free_list(struct page *page, struct zone *zone,
> -				     unsigned int order, int migratetype)
> +				     unsigned int order, int old_mt, int new_mt)
>   {
>   	struct free_area *area = &zone->free_area[order];
>   
> -	list_move_tail(&page->buddy_list, &area->free_list[migratetype]);
> +	/* Free page moving can fail, so it happens before the type update */
> +	VM_WARN_ONCE(get_pageblock_migratetype(page) != old_mt,
> +		     "page type is %lu, passed migratetype is %d (nr=%d)\n",
> +		     get_pageblock_migratetype(page), old_mt, 1 << order);
> +
> +	list_move_tail(&page->buddy_list, &area->free_list[new_mt]);
> +
> +	account_freepages(page, zone, -(1 << order), old_mt);
> +	account_freepages(page, zone, 1 << order, new_mt);
>   }
>   
> -static inline void del_page_from_free_list(struct page *page, struct zone *zone,
> -					   unsigned int order)
> +static inline void __del_page_from_free_list(struct page *page, struct zone *zone,
> +					     unsigned int order, int migratetype)
>   {
> +        VM_WARN_ONCE(get_pageblock_migratetype(page) != migratetype,
> +		     "page type is %lu, passed migratetype is %d (nr=%d)\n",
> +		     get_pageblock_migratetype(page), migratetype, 1 << order);
> +
>   	/* clear reported state and update reported page count */
>   	if (page_reported(page))
>   		__ClearPageReported(page);
> @@ -688,6 +718,13 @@ static inline void del_page_from_free_list(struct page *page, struct zone *zone,
>   	zone->free_area[order].nr_free--;
>   }
>   
> +static inline void del_page_from_free_list(struct page *page, struct zone *zone,
> +					   unsigned int order, int migratetype)
> +{
> +	__del_page_from_free_list(page, zone, order, migratetype);
> +	account_freepages(page, zone, -(1 << order), migratetype);
> +}
> +
>   static inline struct page *get_page_from_free_area(struct free_area *area,
>   					    int migratetype)
>   {
> @@ -759,18 +796,16 @@ static inline void __free_one_page(struct page *page,
>   	VM_BUG_ON_PAGE(page->flags & PAGE_FLAGS_CHECK_AT_PREP, page);
>   
>   	VM_BUG_ON(migratetype == -1);
> -	if (likely(!is_migrate_isolate(migratetype)))
> -		__mod_zone_freepage_state(zone, 1 << order, migratetype);
> -
>   	VM_BUG_ON_PAGE(pfn & ((1 << order) - 1), page);
>   	VM_BUG_ON_PAGE(bad_range(zone, page), page);
>   
> +	account_freepages(page, zone, 1 << order, migratetype);
> +
>   	while (order < MAX_PAGE_ORDER) {
> -		if (compaction_capture(capc, page, order, migratetype)) {
> -			__mod_zone_freepage_state(zone, -(1 << order),
> -								migratetype);
> +		int buddy_mt = migratetype;
> +
> +		if (compaction_capture(capc, page, order, migratetype))
>   			return;
> -		}

IIUC, if the released page is captured by compaction, then the 
statistics for free pages should be correspondingly decreased, 
otherwise, there will be a slight regression for my thpcompact benchmark.

thpcompact Percentage Faults Huge
                           k6.9-rc2-base        base + patch10 + 2 fixes	
Percentage huge-1        78.18 (   0.00%)       71.92 (  -8.01%)
Percentage huge-3        86.70 (   0.00%)       86.07 (  -0.73%)
Percentage huge-5        90.26 (   0.00%)       78.02 ( -13.57%)
Percentage huge-7        92.34 (   0.00%)       78.67 ( -14.81%)
Percentage huge-12       91.18 (   0.00%)       81.04 ( -11.12%)
Percentage huge-18       89.00 (   0.00%)       79.57 ( -10.60%)
Percentage huge-24       90.52 (   0.00%)       80.07 ( -11.54%)
Percentage huge-30       94.44 (   0.00%)       96.28 (   1.95%)
Percentage huge-32       93.09 (   0.00%)       99.39 (   6.77%)

I add below fix based on your fix 2, then the thpcompact Percentage 
looks good. How do you think for the fix?

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 8330c5c2de6b..2facf844ef84 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -805,8 +805,10 @@ static inline void __free_one_page(struct page *page,
         while (order < MAX_PAGE_ORDER) {
                 int buddy_mt = migratetype;

-               if (compaction_capture(capc, page, order, migratetype))
+               if (compaction_capture(capc, page, order, migratetype)) {
+                       account_freepages(zone, -(1 << order), migratetype);
                         return;
+               }

                 buddy = find_buddy_page_pfn(page, pfn, order, &buddy_pfn);
                 if (!buddy)

With my fix, the THP percentage looks better:
                       k6.9-rc2-base          base + patch10 + 2 fixes	+ 
my fix
Percentage huge-1        78.18 (   0.00%)       82.83 (   5.94%)
Percentage huge-3        86.70 (   0.00%)       93.47 (   7.81%)
Percentage huge-5        90.26 (   0.00%)       94.73 (   4.95%)
Percentage huge-7        92.34 (   0.00%)       95.22 (   3.12%)
Percentage huge-12       91.18 (   0.00%)       92.40 (   1.34%)
Percentage huge-18       89.00 (   0.00%)       85.39 (  -4.06%)
Percentage huge-24       90.52 (   0.00%)       94.70 (   4.61%)
Percentage huge-30       94.44 (   0.00%)       97.00 (   2.71%)
Percentage huge-32       93.09 (   0.00%)       92.87 (  -0.24%)

