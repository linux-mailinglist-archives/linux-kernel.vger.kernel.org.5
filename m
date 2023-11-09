Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E3C47E70C3
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 18:50:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344808AbjKIRt7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 12:49:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231845AbjKIRt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 12:49:57 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6530A269E
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 09:49:55 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF245C433C8;
        Thu,  9 Nov 2023 17:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1699552195;
        bh=lZIcEOpqBq7V6sLEF4bOlqA/HFLe7+H0GXK/xFyC9AM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=xYTL38kU6Vve0VHhIA7PDkbEO6ODJS5kTg/g66xnrnAWnQ6fv2bvOLu68oKa36UG3
         kLTKkhys5fV65SoLxC7MKrTU2QsIxGKzV79mqNn2AYrcCPWF4lVjNe1UQB08xSBqJb
         hTFFSzDJwriZyA8r19DYDpNEpgRb9FlJYZY9q4sM=
Date:   Thu, 9 Nov 2023 09:49:54 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Zhiguo Jiang <justinjiang@vivo.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        opensource.kernel@vivo.com
Subject: Re: [PATCH v2 1/1] mm: ALLOC_HIGHATOMIC flag allocation issue
Message-Id: <20231109094954.dd4b2a5b1f5dfcc9a721edba@linux-foundation.org>
In-Reply-To: <20231109073133.792-2-justinjiang@vivo.com>
References: <20231109073133.792-1-justinjiang@vivo.com>
        <20231109073133.792-2-justinjiang@vivo.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  9 Nov 2023 15:31:33 +0800 Zhiguo Jiang <justinjiang@vivo.com> wrote:

> Add a new bool* argument to pass return flag instead of *alloc_flags
> and add the related comments.

Please retain (and update) the changelog with each version of a patch.

For reviewers (please), here's the v1 changelog:

: In case of alloc_flags contain ALLOC_HIGHATOMIC and alloc order
: is order1/2/3/10 in rmqueue(), if pages are alloced successfully
: from pcplist cache, and move a free pageblock from the alloced
: migratetype freelist to MIGRATE_HIGHATOMIC freelist, rather than
: alloc from MIGRATE_HIGHATOMIC freelist firstly, so this will result
: in an increasing number of pages on the MIGRATE_HIGHATOMIC freelist,
: pages in other migratetype freelist are reduced and more likely to
: allocation failure.
: 
: Currently the sequence of ALLOC_HIGHATOMIC allocation is:
: pcplist cache --> buddy (batch >> order) allocation migratetype
: freelist --> buddy MIGRATE_HIGHATOMIC freelist --> buddy allocation
: migratetype freelist.
: 
: Due to the fact that requesting pages from the pcplist cache is faster
: than buddy, the sequence of modifying the ALLOC_HIGHATOMIC allocation is:
: pcplist --> buddy MIGRATE_HIGHATOMIC freelist --> buddy allocation
: migrate freelist.
: 
: This patch can solve the allocation failure of the Non-ALLOC_HIGHATOMIC
: alloc_flag due to excessive pages reservations in MIGRATE_HIGHATOMIC
: freelists.

> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -905,7 +905,6 @@ unsigned int reclaim_clean_pages_from_list(struct zone *zone,
>  #endif
>  #define ALLOC_HIGHATOMIC	0x200 /* Allows access to MIGRATE_HIGHATOMIC */
>  #define ALLOC_KSWAPD		0x800 /* allow waking of kswapd, __GFP_KSWAPD_RECLAIM set */
> -#define ALLOC_PCPLIST		0x1000 /* Allocations from pcplist */
>  
>  /* Flags that allow allocations below the min watermark. */
>  #define ALLOC_RESERVES (ALLOC_NON_BLOCK|ALLOC_MIN_RESERVE|ALLOC_HIGHATOMIC|ALLOC_OOM)
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 67cec88164b1..3c84c3e3eeb0 100755
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -2854,6 +2854,11 @@ struct page *__rmqueue_pcplist(struct zone *zone, unsigned int order,
>  			int batch = nr_pcp_alloc(pcp, zone, order);
>  			int alloced;
>  
> +			/*
> +			 * If pcplist is empty and alloc_flags is with ALLOC_HIGHATOMIC,
> +			 * it should alloc from buddy highatomic migrate freelist firstly
> +			 * to ensure quick and successful allocation.
> +			 */
>  			if (alloc_flags & ALLOC_HIGHATOMIC)
>  				goto out;
>  
> @@ -2925,8 +2930,8 @@ __no_sanitize_memory
>  static inline
>  struct page *rmqueue(struct zone *preferred_zone,
>  			struct zone *zone, unsigned int order,
> -			gfp_t gfp_flags, unsigned int *alloc_flags,
> -			int migratetype)
> +			gfp_t gfp_flags, unsigned int alloc_flags,
> +			int migratetype, bool *highatomc_allocation)
>  {
>  	struct page *page;
>  
> @@ -2938,19 +2943,33 @@ struct page *rmqueue(struct zone *preferred_zone,
>  
>  	if (likely(pcp_allowed_order(order))) {
>  		page = rmqueue_pcplist(preferred_zone, zone, order,
> -				       migratetype, *alloc_flags);
> -		if (likely(page)) {
> -			*alloc_flags |= ALLOC_PCPLIST;
> +				       migratetype, alloc_flags);
> +		if (likely(page))
>  			goto out;
> -		}
>  	}
>  
> -	page = rmqueue_buddy(preferred_zone, zone, order, *alloc_flags,
> +	page = rmqueue_buddy(preferred_zone, zone, order, alloc_flags,
>  							migratetype);
>  
> +	/*
> +	 * The high-order atomic allocation pageblock reserved conditions:
> +	 *
> +	 * If the high-order atomic allocation page is alloced from pcplist,
> +	 * the highatomic pageblock does not need to be reserved, which can
> +	 * void to migrate an increasing number of pages into buddy
> +	 * MIGRATE_HIGHATOMIC freelist and lead to an increasing risk of
> +	 * allocation failure on other buddy migrate freelists.
> +	 *
> +	 * If the high-order atomic allocation page is alloced from buddy
> +	 * highatomic migrate freelist, regardless of whether the allocation
> +	 * is successful or not, the highatomic pageblock can try to be
> +	 * reserved.
> +	 */
> +	if (unlikely(alloc_flags & ALLOC_HIGHATOMIC))
> +		*highatomc_allocation = true;
>  out:
>  	/* Separate test+clear to avoid unnecessary atomics */
> -	if ((*alloc_flags & ALLOC_KSWAPD) &&
> +	if ((alloc_flags & ALLOC_KSWAPD) &&
>  	    unlikely(test_bit(ZONE_BOOSTED_WATERMARK, &zone->flags))) {
>  		clear_bit(ZONE_BOOSTED_WATERMARK, &zone->flags);
>  		wakeup_kswapd(zone, 0, 0, zone_idx(zone));
> @@ -3218,6 +3237,7 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
>  	struct pglist_data *last_pgdat = NULL;
>  	bool last_pgdat_dirty_ok = false;
>  	bool no_fallback;
> +	bool highatomc_allocation = false;
>  
>  retry:
>  	/*
> @@ -3349,7 +3369,7 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
>  
>  try_this_zone:
>  		page = rmqueue(ac->preferred_zoneref->zone, zone, order,
> -				gfp_mask, &alloc_flags, ac->migratetype);
> +				gfp_mask, alloc_flags, ac->migratetype, &highatomc_allocation);
>  		if (page) {
>  			prep_new_page(page, order, gfp_mask, alloc_flags);
>  
> @@ -3357,8 +3377,7 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
>  			 * If this is a high-order atomic allocation then check
>  			 * if the pageblock should be reserved for the future
>  			 */
> -			if (unlikely(alloc_flags & ALLOC_HIGHATOMIC) &&
> -				unlikely(!(alloc_flags & ALLOC_PCPLIST)))
> +			if (unlikely(highatomc_allocation))
>  				reserve_highatomic_pageblock(page, zone);
>  
>  			return page;
> -- 
> 2.39.0
