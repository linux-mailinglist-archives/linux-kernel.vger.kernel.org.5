Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E172079F2BF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 22:18:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231603AbjIMUSZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 16:18:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjIMUSX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 16:18:23 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D0F71BC8
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 13:18:19 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 0A27B1F385;
        Wed, 13 Sep 2023 20:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1694636298; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1GH7qir1qQHMIG1UYyOw9wdZ53FxihsyGr7TX5dB0SQ=;
        b=ZtJT7RhZ9QWAENDYt4jjtGJSXl/JuY5YfiJQw5uewVi1Goub4//cijlYkbqu4KNS5HD/Ek
        sVImPfGvXyKhUe1zh6LOInoHJ0WhMTwBubCXM6VSrk2EMyQJN2qNOT86L4hifuVUGK1MTa
        7ZM8FX1rm1eEyJlUr0XKcNL82VGORnc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1694636298;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1GH7qir1qQHMIG1UYyOw9wdZ53FxihsyGr7TX5dB0SQ=;
        b=oQAxaEvcxaHxjPOpP4YWBhv0CpIKFEvgrHpJfCmRxC+va5Xt9lL+4cYRBT3t6zQP6Cc3Dd
        WrRw8N9atRseC2Bg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D9C7113440;
        Wed, 13 Sep 2023 20:18:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 17YZNAkZAmWHAgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 13 Sep 2023 20:18:17 +0000
Message-ID: <37dbd4d0-c125-6694-dec4-6322ae5b6dee@suse.cz>
Date:   Wed, 13 Sep 2023 22:18:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 6/6] mm: page_alloc: consolidate free page accounting
Content-Language: en-US
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20230911195023.247694-1-hannes@cmpxchg.org>
 <20230911195023.247694-7-hannes@cmpxchg.org>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20230911195023.247694-7-hannes@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/11/23 21:41, Johannes Weiner wrote:
> Free page accounting currently happens a bit too high up the call
> stack, where it has to deal with guard pages, compaction capturing,
> block stealing and even page isolation. This is subtle and fragile,
> and makes it difficult to hack on the code.
> 
> Now that type violations on the freelists have been fixed, push the
> accounting down to where pages enter and leave the freelist.
> 
> v3:
> - fix CONFIG_UNACCEPTED_MEMORY build (lkp)
> v2:
> - fix CONFIG_DEBUG_PAGEALLOC build (Mel)
> 
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

<snip>

>  
>  /* Used for pages not on another list */
> -static inline void add_to_free_list_tail(struct page *page, struct zone *zone,
> -					 unsigned int order, int migratetype)
> +static inline void add_to_free_list(struct page *page, struct zone *zone,
> +				    unsigned int order, int migratetype,
> +				    bool tail)
>  {
>  	struct free_area *area = &zone->free_area[order];
>  
> -	list_add_tail(&page->buddy_list, &area->free_list[migratetype]);
> +	VM_WARN_ONCE(get_pageblock_migratetype(page) != migratetype,
> +		     "page type is %lu, passed migratetype is %d (nr=%d)\n",
> +		     get_pageblock_migratetype(page), migratetype, 1 << order);

Ok, IIUC so you now assume pageblock migratetype is now matching freelist
placement at all times. This is a change from the previous treatment as a
heuristic that may be sometimes imprecise. Let's assume the previous patches
handled the deterministic reasons why those would deviate (modulo my concern
about pageblocks spanning multiple zones in reply to 5/6).

But unless I'm missing something, I don't think the possible race scenarios
were dealt with? Pageblock migratetype is set under zone->lock but there are
places that read it outside of zone->lock and then trust it to perform the
freelist placement. See for example __free_pages_ok(), or free_unref_page()
in the cases it calls free_one_page(). These determine pageblock migratetype
before taking the zone->lock. Only for has_isolate_pageblock() cases we are
more careful, because previously isolation was the only case where precision
was needed. So I think this warning is going to trigger?

> +
> +	if (tail)
> +		list_add_tail(&page->buddy_list, &area->free_list[migratetype]);
> +	else
> +		list_add(&page->buddy_list, &area->free_list[migratetype]);
>  	area->nr_free++;
> +
> +	account_freepages(page, zone, 1 << order, migratetype);
>  }
>  
>  /*

<snip>

> @@ -757,23 +783,21 @@ static inline void __free_one_page(struct page *page,
>  	VM_BUG_ON_PAGE(page->flags & PAGE_FLAGS_CHECK_AT_PREP, page);
>  
>  	VM_BUG_ON(migratetype == -1);
> -	if (likely(!is_migrate_isolate(migratetype)))
> -		__mod_zone_freepage_state(zone, 1 << order, migratetype);
> -
>  	VM_BUG_ON_PAGE(pfn & ((1 << order) - 1), page);
>  	VM_BUG_ON_PAGE(bad_range(zone, page), page);
>  
>  	while (order < MAX_ORDER) {
> -		if (compaction_capture(capc, page, order, migratetype)) {
> -			__mod_zone_freepage_state(zone, -(1 << order),
> -								migratetype);
> +		int buddy_mt;
> +
> +		if (compaction_capture(capc, page, order, migratetype))
>  			return;
> -		}
>  
>  		buddy = find_buddy_page_pfn(page, pfn, order, &buddy_pfn);
>  		if (!buddy)
>  			goto done_merging;
>  
> +		buddy_mt = get_pfnblock_migratetype(buddy, buddy_pfn);

You should assume buddy_mt equals migratetype, no? It's the same assumption
as the VM_WARN_ONCE() I've discussed?

> +
>  		if (unlikely(order >= pageblock_order)) {

Only here buddy_mt can differ and the code in this block already handles that.

>  			/*
>  			 * We want to prevent merge between freepages on pageblock
> @@ -801,9 +825,9 @@ static inline void __free_one_page(struct page *page,
>  		 * merge with it and move up one order.
>  		 */
>  		if (page_is_guard(buddy))
> -			clear_page_guard(zone, buddy, order, migratetype);
> +			clear_page_guard(zone, buddy, order);
>  		else
> -			del_page_from_free_list(buddy, zone, order);
> +			del_page_from_free_list(buddy, zone, order, buddy_mt);

Ugh so this will add account_freepages() call to each iteration of the
__free_one_page() hot loop, which seems like a lot of unnecessary overhead -
as long as we are within pageblock_order the migratetype should be the same,
and thus also is_migrate_isolate() and is_migrate_cma() tests should return
the same value so we shouldn't need to call __mod_zone_page_state()
piecemeal like this.

>  		combined_pfn = buddy_pfn & pfn;
>  		page = page + (combined_pfn - pfn);
>  		pfn = combined_pfn;

