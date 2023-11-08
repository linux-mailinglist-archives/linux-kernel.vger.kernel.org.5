Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD597E6044
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 22:57:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbjKHV5i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 16:57:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbjKHV5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 16:57:37 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81D25258D
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 13:57:35 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB69CC433C7;
        Wed,  8 Nov 2023 21:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1699480655;
        bh=IyTyvj5NUZ9Cs+Ftzhz/qOsaiUiCPmY1i2ONdxmDhpk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GrxrYWf/Qj5KaDWqd/kk6YawuamBl0xBXC0R6PDngW6aqplnJhv5aM31yDtyWi2J2
         RFhyUjgD6tqkdq7OncASPA0Jrw8r5HmKs3ISAnjIReCdqW271tyiDA34wxLZpYeBR8
         nfH0X6XdRHd6xIdHvSvPvNyx8vupobnabhcc83Xg=
Date:   Wed, 8 Nov 2023 13:57:34 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Zhiguo Jiang <justinjiang@vivo.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        opensource.kernel@vivo.com
Subject: Re: [PATCH] mm:ALLOC_HIGHATOMIC flag allocation issuse
Message-Id: <20231108135734.7b3820985c288ff98f41d2c4@linux-foundation.org>
In-Reply-To: <20231108065408.1861-1-justinjiang@vivo.com>
References: <20231108065408.1861-1-justinjiang@vivo.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  8 Nov 2023 14:54:07 +0800 Zhiguo Jiang <justinjiang@vivo.com> wrote:

> In case that alloc_flags contains ALLOC_HIGHATOMIC and alloc order
> is order1/2/3/10 in rmqueue(), if pages are alloced successfully
> from pcplist, a free pageblock will be also moved from the alloced
> migratetype freelist to MIGRATE_HIGHATOMIC freelist, rather than
> alloc from MIGRATE_HIGHATOMIC freelist firstly, so this will result
> in an increasing number of pages on the MIGRATE_HIGHATOMIC freelist,
> pages in other migratetype freelist are reduced and more likely to
> allocation failure.
> 
> Currently the sequence of ALLOC_HIGHATOMIC allocation is:
> pcplist --> rmqueue_bulk() --> rmqueue_buddy() MIGRATE_HIGHATOMIC
> --> rmqueue_buddy() allocation migratetype.
> 
> Due to the fact that requesting pages from the pcplist is faster than
> buddy, the sequence of modifying the ALLOC_HIGHATOMIC allocation is:
> pcplist --> rmqueue_buddy() MIGRATE_HIGHATOMIC --> rmqueue_buddy()
> allocation migratetype.
> 
> This patch can solve the failure problem of allocating other types of
> pages due to excessive MIGRATE_HIGHATOMIC freelist reservations.
> 
> In comparative testing, cat /proc/pagetypeinfo and the HighAtomic
> freelist size is:
> Test without this patch:
> Node 0, zone Normal, type HighAtomic 2369 771 138 15 0 0 0 0 0 0 0
> Test with this patch:
> Node 0, zone Normal, type HighAtomic 206 82 4 2 1 0 0 0 0 0 0 

Hopefully hannes can check this for us, but I have a stylistic concern...

> +#define ALLOC_PCPLIST		0x1000 /* Allocations from pcplist */
>  
>  /* Flags that allow allocations below the min watermark. */
>  #define ALLOC_RESERVES (ALLOC_NON_BLOCK|ALLOC_MIN_RESERVE|ALLOC_HIGHATOMIC|ALLOC_OOM)
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index b8544f08cc36..67cec88164b1
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -2854,11 +2854,15 @@ struct page *__rmqueue_pcplist(struct zone *zone, unsigned int order,
>  			int batch = nr_pcp_alloc(pcp, zone, order);
>  			int alloced;
>  
> +			if (alloc_flags & ALLOC_HIGHATOMIC)
> +				goto out;
> +

A comment here explaining why we're doing this would help readers.

>  			alloced = rmqueue_bulk(zone, order,
>  					batch, list,
>  					migratetype, alloc_flags);
>  
>  			pcp->count += alloced << order;
> +out:
>  			if (unlikely(list_empty(list)))
>  				return NULL;
>  		}
> @@ -2921,7 +2925,7 @@ __no_sanitize_memory
>  static inline
>  struct page *rmqueue(struct zone *preferred_zone,
>  			struct zone *zone, unsigned int order,
> -			gfp_t gfp_flags, unsigned int alloc_flags,
> +			gfp_t gfp_flags, unsigned int *alloc_flags,
>  			int migratetype)
>  {
>  	struct page *page;
> @@ -2934,17 +2938,19 @@ struct page *rmqueue(struct zone *preferred_zone,
>  
>  	if (likely(pcp_allowed_order(order))) {
>  		page = rmqueue_pcplist(preferred_zone, zone, order,
> -				       migratetype, alloc_flags);
> -		if (likely(page))
> +				       migratetype, *alloc_flags);
> +		if (likely(page)) {
> +			*alloc_flags |= ALLOC_PCPLIST;
>  			goto out;
> +		}
>  	}

So we're effectively returning a boolean to the caller via *alloc_flags.

This isn't a great way of doing it.  Wouldn't it be cleaner to pass a
new bool* argument to rmqueue() for this?  Make it explicit?

rmqueue() will be inlined into its sole caller, so this approach
shouldn't add overhead.

> -	page = rmqueue_buddy(preferred_zone, zone, order, alloc_flags,
> +	page = rmqueue_buddy(preferred_zone, zone, order, *alloc_flags,
>  							migratetype);
> 
>  out:
>  	/* Separate test+clear to avoid unnecessary atomics */
> -	if ((alloc_flags & ALLOC_KSWAPD) &&
> +	if ((*alloc_flags & ALLOC_KSWAPD) &&
>  	    unlikely(test_bit(ZONE_BOOSTED_WATERMARK, &zone->flags))) {
>  		clear_bit(ZONE_BOOSTED_WATERMARK, &zone->flags);
>  		wakeup_kswapd(zone, 0, 0, zone_idx(zone));
> @@ -3343,7 +3349,7 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
>  
>  try_this_zone:
>  		page = rmqueue(ac->preferred_zoneref->zone, zone, order,
> -				gfp_mask, alloc_flags, ac->migratetype);
> +				gfp_mask, &alloc_flags, ac->migratetype);
>  		if (page) {
>  			prep_new_page(page, order, gfp_mask, alloc_flags);
>  
> @@ -3351,7 +3357,8 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
>  			 * If this is a high-order atomic allocation then check
>  			 * if the pageblock should be reserved for the future
>  			 */
> -			if (unlikely(alloc_flags & ALLOC_HIGHATOMIC))
> +			if (unlikely(alloc_flags & ALLOC_HIGHATOMIC) &&
> +				unlikely(!(alloc_flags & ALLOC_PCPLIST)))

Again, a comment explaining the reason for the test would be good.

>  				reserve_highatomic_pageblock(page, zone);
>  
>  			return page;
> -- 
> 2.39.0
> 
