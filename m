Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBFD179B854
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356268AbjIKWDV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:03:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244294AbjIKT7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 15:59:25 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84DBD1B6
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 12:59:20 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 27DEC21847;
        Mon, 11 Sep 2023 19:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1694462359; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=+p2m7UgnkUSiHTyAXD1jna8XsdMkwtgK1kLByeG9vTM=;
        b=ntjmq27GM80x+OpYvzystCexsbSMssz3V/bcKXNWrLKXkt6ssrX7IAub5UphM0J68yJGWU
        039VterJyEzk9v+6YzpDewzfGUS1ceqwMszUcj9ZsFn1Sw4uBSWje2Vnt/W6uwSGUwVTqp
        ozgRyW6cr6Q6DVkCpT7R5QmOZTQzwig=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1694462359;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=+p2m7UgnkUSiHTyAXD1jna8XsdMkwtgK1kLByeG9vTM=;
        b=Er7ZVz3PZBGapE6XeyryHbpPiio0XAGGCwQaEOAPSWDbzrb+UdKXWz6DuFn2edOqvG2sPF
        AG7RmlI+qZWObJCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EF94913780;
        Mon, 11 Sep 2023 19:59:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id FayhOZZx/2Q7aAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 11 Sep 2023 19:59:18 +0000
Message-ID: <e3186253-ce35-4634-8380-bd8da0c6d6fe@suse.cz>
Date:   Mon, 11 Sep 2023 21:59:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: page_alloc: fix cma pageblock was stolen in rmqueue
 fallback
Content-Language: en-US
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, nsaenzju@redhat.com, yj.chiang@mediatek.com,
        Mark-pk Tsai <mark-pk.tsai@mediatek.com>,
        Joe Liu <joe.liu@mediatek.com>
References: <20230830111332.7599-1-lecopzer.chen@mediatek.com>
 <20230905090922.zy7srh33rg5c3zao@techsingularity.net>
 <20230911155727.GA102237@cmpxchg.org>
 <e8d5cb3d-2588-4e72-b42d-c10fd47fcbdf@suse.cz>
 <20230911181108.GA104295@cmpxchg.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 tR6d+JzM8nFUZA==
In-Reply-To: <20230911181108.GA104295@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/11/23 20:11, Johannes Weiner wrote:
> On Mon, Sep 11, 2023 at 06:13:59PM +0200, Vlastimil Babka wrote:
>> On 9/11/23 17:57, Johannes Weiner wrote:
>> > On Tue, Sep 05, 2023 at 10:09:22AM +0100, Mel Gorman wrote:
>> >> mm: page_alloc: Free pages to correct buddy list after PCP lock contention
>> >> 
>> >> Commit 4b23a68f9536 ("mm/page_alloc: protect PCP lists with a spinlock")
>> >> returns pages to the buddy list on PCP lock contention. However, for
>> >> migratetypes that are not MIGRATE_PCPTYPES, the migratetype may have
>> >> been clobbered already for pages that are not being isolated. In
>> >> practice, this means that CMA pages may be returned to the wrong
>> >> buddy list. While this might be harmless in some cases as it is
>> >> MIGRATE_MOVABLE, the pageblock could be reassigned in rmqueue_fallback
>> >> and prevent a future CMA allocation. Lookup the PCP migratetype
>> >> against unconditionally if the PCP lock is contended.
>> >> 
>> >> [lecopzer.chen@mediatek.com: CMA-specific fix]
>> >> Fixes: 4b23a68f9536 ("mm/page_alloc: protect PCP lists with a spinlock")
>> >> Reported-by: Joe Liu <joe.liu@mediatek.com>
>> >> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
>> >> ---
>> >>  mm/page_alloc.c | 8 +++++++-
>> >>  1 file changed, 7 insertions(+), 1 deletion(-)
>> >> 
>> >> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> >> index 452459836b71..4053c377fee8 100644
>> >> --- a/mm/page_alloc.c
>> >> +++ b/mm/page_alloc.c
>> >> @@ -2428,7 +2428,13 @@ void free_unref_page(struct page *page, unsigned int order)
>> >>  		free_unref_page_commit(zone, pcp, page, migratetype, order);
>> >>  		pcp_spin_unlock(pcp);
>> >>  	} else {
>> >> -		free_one_page(zone, page, pfn, order, migratetype, FPI_NONE);
>> >> +		/*
>> >> +		 * The page migratetype may have been clobbered for types
>> >> +		 * (type >= MIGRATE_PCPTYPES && !is_migrate_isolate) so
>> >> +		 * must be rechecked.
>> >> +		 */
>> >> +		free_one_page(zone, page, pfn, order,
>> >> +			      get_pcppage_migratetype(page), FPI_NONE);
>> >>  	}
>> >>  	pcp_trylock_finish(UP_flags);
>> >>  }
>> >> 
>> > 
>> > I had sent a (similar) fix for this here:
>> > 
>> > https://lore.kernel.org/lkml/20230821183733.106619-4-hannes@cmpxchg.org/
>> > 
>> > The context wasn't CMA, but HIGHATOMIC pages going to the movable
>> > freelist. But the class of bug is the same: the migratetype tweaking
>> > really only applies to the pcplist, not the buddy slowpath; I added a
>> > local pcpmigratetype to make it more clear, and hopefully prevent bugs
>> > of this nature down the line.
>> 
>> Seems to be the cleanest solution to me, indeed.
>> 
>> > I'm just preparing v2 of the above series. Do you want me to break
>> > this change out and send it separately?
>> 
>> Works for me, if you combine the it with the information about what commit
>> that fixes, the CMA implications reported, and Cc stable.
> 
> How about this? Based on v6.6-rc1.
> 
> ---
> 
> From 84e4490095ed3d1f2991e7f0e58e2968e56cc7c0 Mon Sep 17 00:00:00 2001
> From: Johannes Weiner <hannes@cmpxchg.org>
> Date: Fri, 28 Jul 2023 14:29:41 -0400
> Subject: [PATCH] mm: page_alloc: fix CMA and HIGHATOMIC landing on the wrong
>  buddy list
> 
> Commit 4b23a68f9536 ("mm/page_alloc: protect PCP lists with a
> spinlock") bypasses the pcplist on lock contention and returns the
> page directly to the buddy list of the page's migratetype.
> 
> For pages that don't have their own pcplist, such as CMA and
> HIGHATOMIC, the migratetype is temporarily updated such that the page
> can hitch a ride on the MOVABLE pcplist. Their true type is later
> reassessed when flushing in free_pcppages_bulk(). However, when lock
> contention is detected after the type was already overriden, the
> bypass will then put the page on the wrong buddy list.
> 
> Once on the MOVABLE buddy list, the page becomes eligible for
> fallbacks and even stealing. In the case of HIGHATOMIC, otherwise
> ineligible allocations can dip into the highatomic reserves. In the
> case of CMA, the page can be lost from the CMA region permanently.
> 
> Use a separate pcpmigratetype variable for the pcplist override. Use
> the original migratetype when going directly to the buddy. This fixes
> the bug and should make the intentions more obvious in the code.
> 
> Originally sent here to address the HIGHATOMIC case:
> https://lore.kernel.org/lkml/20230821183733.106619-4-hannes@cmpxchg.org/
> 
> Changelog updated in response to the CMA-specific bug report.
> 
> [mgorman@techsingularity.net: updated changelog]
> Reported-by: Joe Liu <joe.liu@mediatek.com>
> Fixes: 4b23a68f9536 ("mm/page_alloc: protect PCP lists with a spinlock")
> Cc: stable@vger.kernel.org
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  mm/page_alloc.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 0c5be12f9336..95546f376302 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -2400,7 +2400,7 @@ void free_unref_page(struct page *page, unsigned int order)
>  	struct per_cpu_pages *pcp;
>  	struct zone *zone;
>  	unsigned long pfn = page_to_pfn(page);
> -	int migratetype;
> +	int migratetype, pcpmigratetype;
>  
>  	if (!free_unref_page_prepare(page, pfn, order))
>  		return;
> @@ -2408,24 +2408,24 @@ void free_unref_page(struct page *page, unsigned int order)
>  	/*
>  	 * We only track unmovable, reclaimable and movable on pcp lists.
>  	 * Place ISOLATE pages on the isolated list because they are being
> -	 * offlined but treat HIGHATOMIC as movable pages so we can get those
> -	 * areas back if necessary. Otherwise, we may have to free
> +	 * offlined but treat HIGHATOMIC and CMA as movable pages so we can
> +	 * get those areas back if necessary. Otherwise, we may have to free
>  	 * excessively into the page allocator
>  	 */
> -	migratetype = get_pcppage_migratetype(page);
> +	migratetype = pcpmigratetype = get_pcppage_migratetype(page);
>  	if (unlikely(migratetype >= MIGRATE_PCPTYPES)) {
>  		if (unlikely(is_migrate_isolate(migratetype))) {
>  			free_one_page(page_zone(page), page, pfn, order, migratetype, FPI_NONE);
>  			return;
>  		}
> -		migratetype = MIGRATE_MOVABLE;
> +		pcpmigratetype = MIGRATE_MOVABLE;
>  	}
>  
>  	zone = page_zone(page);
>  	pcp_trylock_prepare(UP_flags);
>  	pcp = pcp_spin_trylock(zone->per_cpu_pageset);
>  	if (pcp) {
> -		free_unref_page_commit(zone, pcp, page, migratetype, order);
> +		free_unref_page_commit(zone, pcp, page, pcpmigratetype, order);
>  		pcp_spin_unlock(pcp);
>  	} else {
>  		free_one_page(zone, page, pfn, order, migratetype, FPI_NONE);

