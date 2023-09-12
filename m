Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EAEB79D2A2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 15:47:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235710AbjILNrr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 09:47:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232965AbjILNrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 09:47:45 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BEE010CE
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 06:47:41 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 253A3215D5;
        Tue, 12 Sep 2023 13:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1694526460; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ok+qQFg/kmYWw3PXWwcahlm+ztrJJOjH7MHqb1H6G/c=;
        b=zgVO3M6Zc7J4OxsB+bGcgvCrY2BS87brVfD7ifcu0ebMMBQMQjGtgDUPvUlVn/0FBQmlw5
        bw6Xnp6S08gLM7qb2DJTv1hWLDHVaNl50hII8x5bkbCIi1sy4wF9c14NljMOxPhMPujyYb
        ka7DxHAZz7cxSFewWckT7u4PsFyk8hI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1694526460;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ok+qQFg/kmYWw3PXWwcahlm+ztrJJOjH7MHqb1H6G/c=;
        b=sQ3kDJkCLTN68Rl49m2ZWKYbdOo4aBvBSvrS42lQZV94n29djkcpdFVGagV9iUiUDm+CVg
        sZBlMPDBqgjTmhAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F3225139DB;
        Tue, 12 Sep 2023 13:47:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id RsZXOvtrAGWJQQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 12 Sep 2023 13:47:39 +0000
Message-ID: <a389d846-c19a-42d3-6206-0a1c80e40b37@suse.cz>
Date:   Tue, 12 Sep 2023 15:47:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 1/6] mm: page_alloc: remove pcppage migratetype caching
Content-Language: en-US
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20230911195023.247694-1-hannes@cmpxchg.org>
 <20230911195023.247694-2-hannes@cmpxchg.org>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20230911195023.247694-2-hannes@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/11/23 21:41, Johannes Weiner wrote:
> The idea behind the cache is to save get_pageblock_migratetype()
> lookups during bulk freeing. A microbenchmark suggests this isn't
> helping, though. The pcp migratetype can get stale, which means that
> bulk freeing has an extra branch to check if the pageblock was
> isolated while on the pcp.
> 
> While the variance overlaps, the cache write and the branch seem to
> make this a net negative. The following test allocates and frees
> batches of 10,000 pages (~3x the pcp high marks to trigger flushing):
> 
> Before:
>           8,668.48 msec task-clock                       #   99.735 CPUs utilized               ( +-  2.90% )
>                 19      context-switches                 #    4.341 /sec                        ( +-  3.24% )
>                  0      cpu-migrations                   #    0.000 /sec
>             17,440      page-faults                      #    3.984 K/sec                       ( +-  2.90% )
>     41,758,692,473      cycles                           #    9.541 GHz                         ( +-  2.90% )
>    126,201,294,231      instructions                     #    5.98  insn per cycle              ( +-  2.90% )
>     25,348,098,335      branches                         #    5.791 G/sec                       ( +-  2.90% )
>         33,436,921      branch-misses                    #    0.26% of all branches             ( +-  2.90% )
> 
>          0.0869148 +- 0.0000302 seconds time elapsed  ( +-  0.03% )
> 
> After:
>           8,444.81 msec task-clock                       #   99.726 CPUs utilized               ( +-  2.90% )
>                 22      context-switches                 #    5.160 /sec                        ( +-  3.23% )
>                  0      cpu-migrations                   #    0.000 /sec
>             17,443      page-faults                      #    4.091 K/sec                       ( +-  2.90% )
>     40,616,738,355      cycles                           #    9.527 GHz                         ( +-  2.90% )
>    126,383,351,792      instructions                     #    6.16  insn per cycle              ( +-  2.90% )
>     25,224,985,153      branches                         #    5.917 G/sec                       ( +-  2.90% )
>         32,236,793      branch-misses                    #    0.25% of all branches             ( +-  2.90% )
> 
>          0.0846799 +- 0.0000412 seconds time elapsed  ( +-  0.05% )
> 
> A side effect is that this also ensures that pages whose pageblock
> gets stolen while on the pcplist end up on the right freelist and we
> don't perform potentially type-incompatible buddy merges (or skip
> merges when we shouldn't), whis is likely beneficial to long-term
> fragmentation management, although the effects would be harder to
> measure. Settle for simpler and faster code as justification here.

Makes sense to me, so

> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

Some notes below.

> @@ -1577,7 +1556,6 @@ struct page *__rmqueue_smallest(struct zone *zone, unsigned int order,
>  			continue;
>  		del_page_from_free_list(page, zone, current_order);
>  		expand(zone, page, order, current_order, migratetype);
> -		set_pcppage_migratetype(page, migratetype);

Hm interesting, just noticed that __rmqueue_fallback() never did this
AFAICS, sounds like a bug.

>  		trace_mm_page_alloc_zone_locked(page, order, migratetype,
>  				pcp_allowed_order(order) &&
>  				migratetype < MIGRATE_PCPTYPES);
> @@ -2145,7 +2123,7 @@ static int rmqueue_bulk(struct zone *zone, unsigned int order,
>  		 * pages are ordered properly.
>  		 */
>  		list_add_tail(&page->pcp_list, list);
> -		if (is_migrate_cma(get_pcppage_migratetype(page)))
> +		if (is_migrate_cma(get_pageblock_migratetype(page)))
>  			__mod_zone_page_state(zone, NR_FREE_CMA_PAGES,
>  					      -(1 << order));

This is potentially a source of overhead, I assume patch 6/6 might
change that.

>  	}
> @@ -2304,19 +2282,6 @@ void drain_all_pages(struct zone *zone)
>  	__drain_all_pages(zone, false);
>  }
>  
> -static bool free_unref_page_prepare(struct page *page, unsigned long pfn,
> -							unsigned int order)
> -{
> -	int migratetype;
> -
> -	if (!free_pages_prepare(page, order, FPI_NONE))
> -		return false;
> -
> -	migratetype = get_pfnblock_migratetype(page, pfn);
> -	set_pcppage_migratetype(page, migratetype);
> -	return true;
> -}
> -
>  static int nr_pcp_free(struct per_cpu_pages *pcp, int high, bool free_high)
>  {
>  	int min_nr_free, max_nr_free;
> @@ -2402,7 +2367,7 @@ void free_unref_page(struct page *page, unsigned int order)
>  	unsigned long pfn = page_to_pfn(page);
>  	int migratetype, pcpmigratetype;
>  
> -	if (!free_unref_page_prepare(page, pfn, order))
> +	if (!free_pages_prepare(page, order, FPI_NONE))
>  		return;
>  
>  	/*
> @@ -2412,7 +2377,7 @@ void free_unref_page(struct page *page, unsigned int order)
>  	 * get those areas back if necessary. Otherwise, we may have to free
>  	 * excessively into the page allocator
>  	 */
> -	migratetype = pcpmigratetype = get_pcppage_migratetype(page);
> +	migratetype = pcpmigratetype = get_pfnblock_migratetype(page, pfn);
>  	if (unlikely(migratetype >= MIGRATE_PCPTYPES)) {
>  		if (unlikely(is_migrate_isolate(migratetype))) {
>  			free_one_page(page_zone(page), page, pfn, order, migratetype, FPI_NONE);
> @@ -2448,7 +2413,8 @@ void free_unref_page_list(struct list_head *list)
>  	/* Prepare pages for freeing */
>  	list_for_each_entry_safe(page, next, list, lru) {
>  		unsigned long pfn = page_to_pfn(page);
> -		if (!free_unref_page_prepare(page, pfn, 0)) {
> +
> +		if (!free_pages_prepare(page, 0, FPI_NONE)) {
>  			list_del(&page->lru);
>  			continue;
>  		}
> @@ -2457,7 +2423,7 @@ void free_unref_page_list(struct list_head *list)
>  		 * Free isolated pages directly to the allocator, see
>  		 * comment in free_unref_page.
>  		 */
> -		migratetype = get_pcppage_migratetype(page);
> +		migratetype = get_pfnblock_migratetype(page, pfn);
>  		if (unlikely(is_migrate_isolate(migratetype))) {
>  			list_del(&page->lru);
>  			free_one_page(page_zone(page), page, pfn, 0, migratetype, FPI_NONE);

I think after this change we should move the isolated pages handling to
the second loop below, so that we wouldn't have to call
get_pfnblock_migratetype() twice per page. Dunno yet if some later patch
does that. It would need to unlock pcp when necessary.

> @@ -2466,10 +2432,11 @@ void free_unref_page_list(struct list_head *list)
>  	}
>  
>  	list_for_each_entry_safe(page, next, list, lru) {
> +		unsigned long pfn = page_to_pfn(page);
>  		struct zone *zone = page_zone(page);
>  
>  		list_del(&page->lru);
> -		migratetype = get_pcppage_migratetype(page);
> +		migratetype = get_pfnblock_migratetype(page, pfn);
>  
>  		/*
>  		 * Either different zone requiring a different pcp lock or
> @@ -2492,7 +2459,7 @@ void free_unref_page_list(struct list_head *list)
>  			pcp = pcp_spin_trylock(zone->per_cpu_pageset);
>  			if (unlikely(!pcp)) {
>  				pcp_trylock_finish(UP_flags);
> -				free_one_page(zone, page, page_to_pfn(page),
> +				free_one_page(zone, page, pfn,
>  					      0, migratetype, FPI_NONE);
>  				locked_zone = NULL;
>  				continue;
> @@ -2661,7 +2628,7 @@ struct page *rmqueue_buddy(struct zone *preferred_zone, struct zone *zone,
>  			}
>  		}
>  		__mod_zone_freepage_state(zone, -(1 << order),
> -					  get_pcppage_migratetype(page));
> +					  get_pageblock_migratetype(page));
>  		spin_unlock_irqrestore(&zone->lock, flags);
>  	} while (check_new_pages(page, order));
>  
