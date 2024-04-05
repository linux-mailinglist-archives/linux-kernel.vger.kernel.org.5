Return-Path: <linux-kernel+bounces-132958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AE82899C7F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 14:12:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 405B92826AB
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 12:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26E9216C850;
	Fri,  5 Apr 2024 12:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="S9ry6wyo"
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1EA16C847
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 12:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712319116; cv=none; b=N8zM5eELPzmIXWLzaE1Bo6q0xSePsDw0p1d2xGkZD5ljikxfjKDxIFwJinyuchLvQcNUWdhc/qTzE+7vrjMPh22lr23SJ0+wa4cmW52QPUC7i8B0iKL1Jk0zUX7ML3fXfuUXathbazFjGFCPuiBQRgR9zwNY4hv3TBqKARkZml0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712319116; c=relaxed/simple;
	bh=WFlxGTBuwpYiVwdfcrt7KqNmAZYMQlS8lcryaJCATz8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j4qZAvWX+wdCidKjsrocyQgZxF038QVOQ5MSO4/T8gCAYMCnk1GijUA3CxZNA1YYwzonnf3TCNFviKT3UgmSUtgRZFr4GG0pvRk4nRDuFWAFa2Eeq0FLOuPe5CRpVaI0274vMimjmep6SF++z27s+HD0padflXaD9rMa4Jc2FLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=S9ry6wyo; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1712319109; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=9fz61hlqVv5Z1o8Ub3fZ44zLTWtwbwciinGGCyQu1nk=;
	b=S9ry6wyo7kviGQviRlZpcRId8/nEhypYq9s6mKP4545X70ckW+Ss9q7r1Klxu7NRgGdwcmEC3R7fAC9COruCnE4jZvUZGU6XKaWTMvkpNuwHAboNmStvcrjNpQc/NOBgXHf90Xm+kN+nma6zOIejpUkfINinYEeDsBDggih2EAs=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W3wvon9_1712319107;
Received: from 30.15.228.201(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W3wvon9_1712319107)
          by smtp.aliyun-inc.com;
          Fri, 05 Apr 2024 20:11:48 +0800
Message-ID: <a97697e0-45b0-4f71-b087-fdc7a1d43c0e@linux.alibaba.com>
Date: Fri, 5 Apr 2024 20:11:47 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/10] mm: page_alloc: fix freelist movement during block
 conversion
To: Johannes Weiner <hannes@cmpxchg.org>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, Mel Gorman
 <mgorman@techsingularity.net>, Zi Yan <ziy@nvidia.com>,
 "Huang, Ying" <ying.huang@intel.com>, David Hildenbrand <david@redhat.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240320180429.678181-1-hannes@cmpxchg.org>
 <20240320180429.678181-7-hannes@cmpxchg.org>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20240320180429.678181-7-hannes@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Johannes,

On 2024/3/21 02:02, Johannes Weiner wrote:
> Currently, page block type conversion during fallbacks, atomic
> reservations and isolation can strand various amounts of free pages on
> incorrect freelists.
> 
> For example, fallback stealing moves free pages in the block to the
> new type's freelists, but then may not actually claim the block for
> that type if there aren't enough compatible pages already allocated.
> 
> In all cases, free page moving might fail if the block straddles more
> than one zone, in which case no free pages are moved at all, but the
> block type is changed anyway.
> 
> This is detrimental to type hygiene on the freelists. It encourages
> incompatible page mixing down the line (ask for one type, get another)
> and thus contributes to long-term fragmentation.
> 
> Split the process into a proper transaction: check first if conversion
> will happen, then try to move the free pages, and only if that was
> successful convert the block to the new type.
> 
> Tested-by: "Huang, Ying" <ying.huang@intel.com>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> ---
>   include/linux/page-isolation.h |   3 +-
>   mm/page_alloc.c                | 175 ++++++++++++++++++++-------------
>   mm/page_isolation.c            |  22 +++--
>   3 files changed, 121 insertions(+), 79 deletions(-)
> 
> diff --git a/include/linux/page-isolation.h b/include/linux/page-isolation.h
> index 4ac34392823a..8550b3c91480 100644
> --- a/include/linux/page-isolation.h
> +++ b/include/linux/page-isolation.h
> @@ -34,8 +34,7 @@ static inline bool is_migrate_isolate(int migratetype)
>   #define REPORT_FAILURE	0x2
>   
>   void set_pageblock_migratetype(struct page *page, int migratetype);
> -int move_freepages_block(struct zone *zone, struct page *page,
> -				int migratetype, int *num_movable);
> +int move_freepages_block(struct zone *zone, struct page *page, int migratetype);
>   
>   int start_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
>   			     int migratetype, int flags, gfp_t gfp_flags);
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 7373329763e6..e7d0d4711bdd 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1596,9 +1596,8 @@ static inline struct page *__rmqueue_cma_fallback(struct zone *zone,
>    * Note that start_page and end_pages are not aligned on a pageblock
>    * boundary. If alignment is required, use move_freepages_block()
>    */
> -static int move_freepages(struct zone *zone,
> -			  unsigned long start_pfn, unsigned long end_pfn,
> -			  int migratetype, int *num_movable)
> +static int move_freepages(struct zone *zone, unsigned long start_pfn,
> +			  unsigned long end_pfn, int migratetype)
>   {
>   	struct page *page;
>   	unsigned long pfn;
> @@ -1608,14 +1607,6 @@ static int move_freepages(struct zone *zone,
>   	for (pfn = start_pfn; pfn <= end_pfn;) {
>   		page = pfn_to_page(pfn);
>   		if (!PageBuddy(page)) {
> -			/*
> -			 * We assume that pages that could be isolated for
> -			 * migration are movable. But we don't actually try
> -			 * isolating, as that would be expensive.
> -			 */
> -			if (num_movable &&
> -					(PageLRU(page) || __PageMovable(page)))
> -				(*num_movable)++;
>   			pfn++;
>   			continue;
>   		}
> @@ -1633,17 +1624,16 @@ static int move_freepages(struct zone *zone,
>   	return pages_moved;
>   }
>   
> -int move_freepages_block(struct zone *zone, struct page *page,
> -				int migratetype, int *num_movable)
> +static bool prep_move_freepages_block(struct zone *zone, struct page *page,
> +				      unsigned long *start_pfn,
> +				      unsigned long *end_pfn,
> +				      int *num_free, int *num_movable)
>   {
> -	unsigned long start_pfn, end_pfn, pfn;
> -
> -	if (num_movable)
> -		*num_movable = 0;
> +	unsigned long pfn, start, end;
>   
>   	pfn = page_to_pfn(page);
> -	start_pfn = pageblock_start_pfn(pfn);
> -	end_pfn = pageblock_end_pfn(pfn) - 1;
> +	start = pageblock_start_pfn(pfn);
> +	end = pageblock_end_pfn(pfn) - 1;
>   
>   	/*
>   	 * The caller only has the lock for @zone, don't touch ranges
> @@ -1652,13 +1642,50 @@ int move_freepages_block(struct zone *zone, struct page *page,
>   	 * accompanied by other operations such as migratetype updates
>   	 * which also should be locked.
>   	 */
> -	if (!zone_spans_pfn(zone, start_pfn))
> -		return 0;
> -	if (!zone_spans_pfn(zone, end_pfn))
> -		return 0;
> +	if (!zone_spans_pfn(zone, start))
> +		return false;
> +	if (!zone_spans_pfn(zone, end))
> +		return false;
> +
> +	*start_pfn = start;
> +	*end_pfn = end;
> +
> +	if (num_free) {
> +		*num_free = 0;
> +		*num_movable = 0;
> +		for (pfn = start; pfn <= end;) {
> +			page = pfn_to_page(pfn);
> +			if (PageBuddy(page)) {
> +				int nr = 1 << buddy_order(page);
> +
> +				*num_free += nr;
> +				pfn += nr;
> +				continue;
> +			}
> +			/*
> +			 * We assume that pages that could be isolated for
> +			 * migration are movable. But we don't actually try
> +			 * isolating, as that would be expensive.
> +			 */
> +			if (PageLRU(page) || __PageMovable(page))
> +				(*num_movable)++;
> +			pfn++;
> +		}
> +	}
> +
> +	return true;
> +}
> +
> +int move_freepages_block(struct zone *zone, struct page *page,
> +			 int migratetype)
> +{
> +	unsigned long start_pfn, end_pfn;
> +
> +	if (!prep_move_freepages_block(zone, page, &start_pfn, &end_pfn,
> +				       NULL, NULL))
> +		return -1;
>   
> -	return move_freepages(zone, start_pfn, end_pfn, migratetype,
> -								num_movable);
> +	return move_freepages(zone, start_pfn, end_pfn, migratetype);
>   }
>   
>   static void change_pageblock_range(struct page *pageblock_page,
> @@ -1743,33 +1770,37 @@ static inline bool boost_watermark(struct zone *zone)
>   }
>   
>   /*
> - * This function implements actual steal behaviour. If order is large enough,
> - * we can steal whole pageblock. If not, we first move freepages in this
> - * pageblock to our migratetype and determine how many already-allocated pages
> - * are there in the pageblock with a compatible migratetype. If at least half
> - * of pages are free or compatible, we can change migratetype of the pageblock
> - * itself, so pages freed in the future will be put on the correct free list.
> + * This function implements actual steal behaviour. If order is large enough, we
> + * can claim the whole pageblock for the requested migratetype. If not, we check
> + * the pageblock for constituent pages; if at least half of the pages are free
> + * or compatible, we can still claim the whole block, so pages freed in the
> + * future will be put on the correct free list. Otherwise, we isolate exactly
> + * the order we need from the fallback block and leave its migratetype alone.
>    */
> -static void steal_suitable_fallback(struct zone *zone, struct page *page,
> -		unsigned int alloc_flags, int start_type, bool whole_block)
> +static struct page *
> +steal_suitable_fallback(struct zone *zone, struct page *page,
> +			int current_order, int order, int start_type,
> +			unsigned int alloc_flags, bool whole_block)
>   {
> -	unsigned int current_order = buddy_order(page);
>   	int free_pages, movable_pages, alike_pages;
> -	int old_block_type;
> +	unsigned long start_pfn, end_pfn;
> +	int block_type;
>   
> -	old_block_type = get_pageblock_migratetype(page);
> +	block_type = get_pageblock_migratetype(page);
>   
>   	/*
>   	 * This can happen due to races and we want to prevent broken
>   	 * highatomic accounting.
>   	 */
> -	if (is_migrate_highatomic(old_block_type))
> +	if (is_migrate_highatomic(block_type))
>   		goto single_page;
>   
>   	/* Take ownership for orders >= pageblock_order */
>   	if (current_order >= pageblock_order) {
> +		del_page_from_free_list(page, zone, current_order);
>   		change_pageblock_range(page, current_order, start_type);
> -		goto single_page;
> +		expand(zone, page, order, current_order, start_type);
> +		return page;
>   	}
>   
>   	/*
> @@ -1784,10 +1815,9 @@ static void steal_suitable_fallback(struct zone *zone, struct page *page,
>   	if (!whole_block)
>   		goto single_page;
>   
> -	free_pages = move_freepages_block(zone, page, start_type,
> -						&movable_pages);
>   	/* moving whole block can fail due to zone boundary conditions */
> -	if (!free_pages)
> +	if (!prep_move_freepages_block(zone, page, &start_pfn, &end_pfn,
> +				       &free_pages, &movable_pages))
>   		goto single_page;
>   
>   	/*
> @@ -1805,7 +1835,7 @@ static void steal_suitable_fallback(struct zone *zone, struct page *page,
>   		 * vice versa, be conservative since we can't distinguish the
>   		 * exact migratetype of non-movable pages.
>   		 */
> -		if (old_block_type == MIGRATE_MOVABLE)
> +		if (block_type == MIGRATE_MOVABLE)
>   			alike_pages = pageblock_nr_pages
>   						- (free_pages + movable_pages);
>   		else
> @@ -1816,13 +1846,16 @@ static void steal_suitable_fallback(struct zone *zone, struct page *page,
>   	 * compatible migratability as our allocation, claim the whole block.
>   	 */
>   	if (free_pages + alike_pages >= (1 << (pageblock_order-1)) ||
> -			page_group_by_mobility_disabled)
> +			page_group_by_mobility_disabled) {
> +		move_freepages(zone, start_pfn, end_pfn, start_type);
>   		set_pageblock_migratetype(page, start_type);
> -
> -	return;
> +		return __rmqueue_smallest(zone, order, start_type);
> +	}
>   
>   single_page:
> -	move_to_free_list(page, zone, current_order, start_type);
> +	del_page_from_free_list(page, zone, current_order);
> +	expand(zone, page, order, current_order, block_type);
> +	return page;
>   }
>   
>   /*
> @@ -1890,9 +1923,10 @@ static void reserve_highatomic_pageblock(struct page *page, struct zone *zone)
>   	mt = get_pageblock_migratetype(page);
>   	/* Only reserve normal pageblocks (i.e., they can merge with others) */
>   	if (migratetype_is_mergeable(mt)) {
> -		zone->nr_reserved_highatomic += pageblock_nr_pages;
> -		set_pageblock_migratetype(page, MIGRATE_HIGHATOMIC);
> -		move_freepages_block(zone, page, MIGRATE_HIGHATOMIC, NULL);
> +		if (move_freepages_block(zone, page, MIGRATE_HIGHATOMIC) != -1) {
> +			set_pageblock_migratetype(page, MIGRATE_HIGHATOMIC);
> +			zone->nr_reserved_highatomic += pageblock_nr_pages;
> +		}
>   	}
>   
>   out_unlock:
> @@ -1917,7 +1951,7 @@ static bool unreserve_highatomic_pageblock(const struct alloc_context *ac,
>   	struct zone *zone;
>   	struct page *page;
>   	int order;
> -	bool ret;
> +	int ret;
>   
>   	for_each_zone_zonelist_nodemask(zone, z, zonelist, ac->highest_zoneidx,
>   								ac->nodemask) {
> @@ -1966,10 +2000,14 @@ static bool unreserve_highatomic_pageblock(const struct alloc_context *ac,
>   			 * of pageblocks that cannot be completely freed
>   			 * may increase.
>   			 */
> +			ret = move_freepages_block(zone, page, ac->migratetype);
> +			/*
> +			 * Reserving this block already succeeded, so this should
> +			 * not fail on zone boundaries.
> +			 */
> +			WARN_ON_ONCE(ret == -1);
>   			set_pageblock_migratetype(page, ac->migratetype);
> -			ret = move_freepages_block(zone, page, ac->migratetype,
> -									NULL);
> -			if (ret) {
> +			if (ret > 0) {
>   				spin_unlock_irqrestore(&zone->lock, flags);
>   				return ret;
>   			}
> @@ -1990,7 +2028,7 @@ static bool unreserve_highatomic_pageblock(const struct alloc_context *ac,
>    * deviation from the rest of this file, to make the for loop
>    * condition simpler.
>    */
> -static __always_inline bool
> +static __always_inline struct page *
>   __rmqueue_fallback(struct zone *zone, int order, int start_migratetype,
>   						unsigned int alloc_flags)
>   {
> @@ -2037,7 +2075,7 @@ __rmqueue_fallback(struct zone *zone, int order, int start_migratetype,
>   		goto do_steal;
>   	}
>   
> -	return false;
> +	return NULL;
>   
>   find_smallest:
>   	for (current_order = order; current_order < NR_PAGE_ORDERS; current_order++) {
> @@ -2057,14 +2095,14 @@ __rmqueue_fallback(struct zone *zone, int order, int start_migratetype,
>   do_steal:
>   	page = get_page_from_free_area(area, fallback_mt);
>   
> -	steal_suitable_fallback(zone, page, alloc_flags, start_migratetype,
> -								can_steal);
> +	/* take off list, maybe claim block, expand remainder */
> +	page = steal_suitable_fallback(zone, page, current_order, order,
> +				       start_migratetype, alloc_flags, can_steal);
>   
>   	trace_mm_page_alloc_extfrag(page, order, current_order,
>   		start_migratetype, fallback_mt);
>   
> -	return true;
> -
> +	return page;
>   }
>   
>   #ifdef CONFIG_CMA
> @@ -2127,15 +2165,14 @@ __rmqueue(struct zone *zone, unsigned int order, int migratetype,
>   				return page;
>   		}
>   	}
> -retry:
> +
>   	page = __rmqueue_smallest(zone, order, migratetype);
>   	if (unlikely(!page)) {
>   		if (alloc_flags & ALLOC_CMA)
>   			page = __rmqueue_cma_fallback(zone, order);
> -
> -		if (!page && __rmqueue_fallback(zone, order, migratetype,
> -								alloc_flags))
> -			goto retry;
> +		else
> +			page = __rmqueue_fallback(zone, order, migratetype,
> +						  alloc_flags);

(Sorry for chim in late.)

I have some doubts about the changes here. The original code logic was 
that if the 'migratetype' type allocation is failed, it would first try 
CMA page allocation and then attempt to fallback to other migratetype 
allocations. Now it has been changed so that if CMA allocation fails, it 
will directly return. This change has caused a regression when I running 
the thpcompact benchmark, resulting in a significant reduction in the 
percentage of THPs like below:

thpcompact Percentage Faults Huge
                          K6.9-rc2                K6.9-rc2 + this patch
Percentage huge-1        78.18 (   0.00%)       42.49 ( -45.65%)
Percentage huge-3        86.70 (   0.00%)       35.13 ( -59.49%)
Percentage huge-5        90.26 (   0.00%)       52.35 ( -42.00%)
Percentage huge-7        92.34 (   0.00%)       31.84 ( -65.52%)
Percentage huge-12       91.18 (   0.00%)       45.85 ( -49.72%)
Percentage huge-18       89.00 (   0.00%)       29.18 ( -67.22%)
Percentage huge-24       90.52 (   0.00%)       46.68 ( -48.43%)
Percentage huge-30       94.44 (   0.00%)       38.35 ( -59.39%)
Percentage huge-32       93.09 (   0.00%)       39.37 ( -57.70%)

After making the following modifications, the regression is gone.

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index ce67dc6777fa..a7cfe65e45c1 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2139,7 +2139,8 @@ __rmqueue(struct zone *zone, unsigned int order, 
int migratetype,
         if (unlikely(!page)) {
                 if (alloc_flags & ALLOC_CMA)
                         page = __rmqueue_cma_fallback(zone, order);
-               else
+
+               if (!page)
                         page = __rmqueue_fallback(zone, order, migratetype,
                                                   alloc_flags);
         }

But I am not sure your original change is intentional? IIUC, we still 
need try fallbacking even though CMA allocation is failed, please 
correct me if I misunderstand your code. Thanks.

