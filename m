Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9220279E3D3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 11:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239318AbjIMJeA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 05:34:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239027AbjIMJd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 05:33:58 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2963199F
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 02:33:54 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 87E95218E2;
        Wed, 13 Sep 2023 09:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1694597633; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pqk2WVOxbseyPwLAufOCZjtPP927ewD0tk02pn9sP0E=;
        b=ji1etq0JMbhoyRdK9wX+2P7mx7Q2/6NkbjoYB8likMTX6RbaoXjyc1AS8DRfVJ6HDUeFhn
        /QPaeQtQHsxH8awrAFCAHFJPWU5OFDCmV0gqoMoJ0QJYBXFF4aUwj8wrNpFIB+81jHcToT
        XCP8FZ1bqGc5FhfbIZFwQnCaN7GPVac=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1694597633;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pqk2WVOxbseyPwLAufOCZjtPP927ewD0tk02pn9sP0E=;
        b=ioJqudl2oOQ7dPKezfhMIPlCUCuMoSASbGHeCZ6Xe2PW22Q97syJIL9bMHSsF484QlQ44Y
        XBAwAavc8qDD88Ag==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 59E4313582;
        Wed, 13 Sep 2023 09:33:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Bph/FAGCAWWcRgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 13 Sep 2023 09:33:53 +0000
Message-ID: <320c16a7-96b7-65ec-3d80-2eace0ddb290@suse.cz>
Date:   Wed, 13 Sep 2023 11:33:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 1/6] mm: page_alloc: remove pcppage migratetype caching
Content-Language: en-US
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20230911195023.247694-1-hannes@cmpxchg.org>
 <20230911195023.247694-2-hannes@cmpxchg.org>
 <a389d846-c19a-42d3-6206-0a1c80e40b37@suse.cz>
 <20230912145028.GA3228@cmpxchg.org>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20230912145028.GA3228@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/12/23 16:50, Johannes Weiner wrote:
> On Tue, Sep 12, 2023 at 03:47:45PM +0200, Vlastimil Babka wrote:
>> On 9/11/23 21:41, Johannes Weiner wrote:
> 
>> > @@ -1577,7 +1556,6 @@ struct page *__rmqueue_smallest(struct zone *zone, unsigned int order,
>> >  			continue;
>> >  		del_page_from_free_list(page, zone, current_order);
>> >  		expand(zone, page, order, current_order, migratetype);
>> > -		set_pcppage_migratetype(page, migratetype);
>> 
>> Hm interesting, just noticed that __rmqueue_fallback() never did this
>> AFAICS, sounds like a bug.
> 
> I don't quite follow. Which part?
> 
> Keep in mind that at this point __rmqueue_fallback() doesn't return a
> page. It just moves pages to the desired freelist, and then
> __rmqueue_smallest() gets called again. This changes in 5/6, but until
> now at least all of the above would apply to fallback pages.

Yep, missed that "doesn't return a page", thanks.

>> > @@ -2145,7 +2123,7 @@ static int rmqueue_bulk(struct zone *zone, unsigned int order,
>> >  		 * pages are ordered properly.
>> >  		 */
>> >  		list_add_tail(&page->pcp_list, list);
>> > -		if (is_migrate_cma(get_pcppage_migratetype(page)))
>> > +		if (is_migrate_cma(get_pageblock_migratetype(page)))
>> >  			__mod_zone_page_state(zone, NR_FREE_CMA_PAGES,
>> >  					      -(1 << order));
>> 
>> This is potentially a source of overhead, I assume patch 6/6 might
>> change that.
> 
> Yes, 6/6 removes it altogether.
> 
> But the test results in this patch's changelog are from this patch in
> isolation, so it doesn't appear to be a concern even on its own.
> 
>> > @@ -2457,7 +2423,7 @@ void free_unref_page_list(struct list_head *list)
>> >  		 * Free isolated pages directly to the allocator, see
>> >  		 * comment in free_unref_page.
>> >  		 */
>> > -		migratetype = get_pcppage_migratetype(page);
>> > +		migratetype = get_pfnblock_migratetype(page, pfn);
>> >  		if (unlikely(is_migrate_isolate(migratetype))) {
>> >  			list_del(&page->lru);
>> >  			free_one_page(page_zone(page), page, pfn, 0, migratetype, FPI_NONE);
>> 
>> I think after this change we should move the isolated pages handling to
>> the second loop below, so that we wouldn't have to call
>> get_pfnblock_migratetype() twice per page. Dunno yet if some later patch
>> does that. It would need to unlock pcp when necessary.
> 
> That sounds like a great idea. Something like the following?
> 
> Lightly tested. If you're good with it, I'll beat some more on it and
> submit it as a follow-up.
> 
> ---
> 
> From 429d13322819ab38b3ba2fad6d1495997819ccc2 Mon Sep 17 00:00:00 2001
> From: Johannes Weiner <hannes@cmpxchg.org>
> Date: Tue, 12 Sep 2023 10:16:10 -0400
> Subject: [PATCH] mm: page_alloc: optimize free_unref_page_list()
> 
> Move direct freeing of isolated pages to the lock-breaking block in
> the second loop. This saves an unnecessary migratetype reassessment.
> 
> Minor comment and local variable scoping cleanups.

Looks like batch_count and locked_zone could be moved to the loop scope as well.

> 
> Suggested-by: Vlastimil Babka <vbabka@suse.cz>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  mm/page_alloc.c | 49 +++++++++++++++++++++----------------------------
>  1 file changed, 21 insertions(+), 28 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index e3f1c777feed..9cad31de1bf5 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -2408,48 +2408,41 @@ void free_unref_page_list(struct list_head *list)
>  	struct per_cpu_pages *pcp = NULL;
>  	struct zone *locked_zone = NULL;
>  	int batch_count = 0;
> -	int migratetype;
> -
> -	/* Prepare pages for freeing */
> -	list_for_each_entry_safe(page, next, list, lru) {
> -		unsigned long pfn = page_to_pfn(page);
>  
> -		if (!free_pages_prepare(page, 0, FPI_NONE)) {
> +	list_for_each_entry_safe(page, next, list, lru)
> +		if (!free_pages_prepare(page, 0, FPI_NONE))
>  			list_del(&page->lru);
> -			continue;
> -		}
> -
> -		/*
> -		 * Free isolated pages directly to the allocator, see
> -		 * comment in free_unref_page.
> -		 */
> -		migratetype = get_pfnblock_migratetype(page, pfn);
> -		if (unlikely(is_migrate_isolate(migratetype))) {
> -			list_del(&page->lru);
> -			free_one_page(page_zone(page), page, pfn, 0, migratetype, FPI_NONE);
> -			continue;
> -		}
> -	}
>  
>  	list_for_each_entry_safe(page, next, list, lru) {
>  		unsigned long pfn = page_to_pfn(page);
>  		struct zone *zone = page_zone(page);
> +		int migratetype;
>  
>  		list_del(&page->lru);
>  		migratetype = get_pfnblock_migratetype(page, pfn);
>  
>  		/*
> -		 * Either different zone requiring a different pcp lock or
> -		 * excessive lock hold times when freeing a large list of
> -		 * pages.
> +		 * Zone switch, batch complete, or non-pcp freeing?
> +		 * Drop the pcp lock and evaluate.
>  		 */
> -		if (zone != locked_zone || batch_count == SWAP_CLUSTER_MAX) {
> +		if (unlikely(zone != locked_zone ||
> +			     batch_count == SWAP_CLUSTER_MAX ||
> +			     is_migrate_isolate(migratetype))) {
>  			if (pcp) {
>  				pcp_spin_unlock(pcp);
>  				pcp_trylock_finish(UP_flags);
> +				locked_zone = NULL;
>  			}
>  
> -			batch_count = 0;
> +			/*
> +			 * Free isolated pages directly to the
> +			 * allocator, see comment in free_unref_page.
> +			 */
> +			if (is_migrate_isolate(migratetype)) {
> +				free_one_page(zone, page, pfn, 0,
> +					      migratetype, FPI_NONE);
> +				continue;
> +			}
>  
>  			/*
>  			 * trylock is necessary as pages may be getting freed
> @@ -2459,12 +2452,12 @@ void free_unref_page_list(struct list_head *list)
>  			pcp = pcp_spin_trylock(zone->per_cpu_pageset);
>  			if (unlikely(!pcp)) {
>  				pcp_trylock_finish(UP_flags);
> -				free_one_page(zone, page, pfn,
> -					      0, migratetype, FPI_NONE);
> -				locked_zone = NULL;
> +				free_one_page(zone, page, pfn, 0,
> +					      migratetype, FPI_NONE);
>  				continue;
>  			}
>  			locked_zone = zone;
> +			batch_count = 0;
>  		}
>  
>  		/*

