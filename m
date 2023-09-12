Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6628379D407
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 16:50:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236084AbjILOug (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 10:50:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230347AbjILOue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 10:50:34 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4D94115
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 07:50:30 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id af79cd13be357-7708bfce474so335511385a.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 07:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1694530230; x=1695135030; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6HSKteuboFmnivzLeuEg+npIPTGUVBOAqjU+EfUkVq4=;
        b=EIozDuSMUxnJJwqU5TCFRoGbJb5TypCsomu37UXtl888exhHckj6t7lRApHKgDiO/b
         VFnBTjN7rbolA0LVT3MDVAzSS99GDa7QAiBy2tyFb8NgbFA/NqJq45JgKKa/MgTVnVHv
         Slb0wdINEc6AvBdc4ncA6nAN0I0RH6px0e34EM+EhBj3dUj+KdoLQt9Pcz3x/sHxk3ao
         Vl0AMj1sD0f2TI3uSW9jQmbef2s78HgoYIRvn1YMQm5tL7gg0rnJcoIS8E/ydYEltteH
         OABizDSDwr7BPIuZq50knSsaHpdiMN3M+N+jKqWIbPopPtRESWMNYkmUYM+msR+hiVpQ
         MshQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694530230; x=1695135030;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6HSKteuboFmnivzLeuEg+npIPTGUVBOAqjU+EfUkVq4=;
        b=LtmT3h6Tdvk+Ou3a24+u/KMWzNPeqNv5eNG+lGhABgSoeyOnx+ZRuxaVLFk1PTCLH3
         +2+O8YTfsQdDODc/3caz5yeHc+CfTTeVdwD7qnDWKxW6djnMN4KPFIB7t/R94mn8RF6W
         c/qRwLR11VIqSYAVHPXB4hcdYX6VsdW3lj7FI+GpeTsmihDix6hs9Fek4Nw6/nhIHOwP
         ZIHh4RhdmHAiqHlpIGpxvcovoNOmnG+E0sXj9BfC9XYcRwmJUqbtvbH8hpp523l6q/ZZ
         qTmkuzPWBq8muhOds+QAnVWx04rLHLnXSiU8K9ielkRv8P98cA4N2nC85qg2GIJQJASo
         wMhg==
X-Gm-Message-State: AOJu0Yx87oni6a2Qit1naeet3oudm7KGEzji/kJMEZ+FNWbXHQqIs4km
        1BinDKBtAOpB6hxAsa/aqzDeSg==
X-Google-Smtp-Source: AGHT+IHNfDzGkVG1pcumuC7QfDwIG+2738HwDCe7yhp0B+IBbDO+rNaUBgTK5sgaYXfhvgEqrSNjrQ==
X-Received: by 2002:a05:620a:f02:b0:76c:b16b:ad74 with SMTP id v2-20020a05620a0f0200b0076cb16bad74mr16689319qkl.19.1694530229831;
        Tue, 12 Sep 2023 07:50:29 -0700 (PDT)
Received: from localhost (2603-7000-0c01-2716-3012-16a2-6bc2-2937.res6.spectrum.com. [2603:7000:c01:2716:3012:16a2:6bc2:2937])
        by smtp.gmail.com with ESMTPSA id p11-20020ae9f30b000000b0076f0744ff50sm3206928qkg.136.2023.09.12.07.50.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 07:50:29 -0700 (PDT)
Date:   Tue, 12 Sep 2023 10:50:28 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] mm: page_alloc: remove pcppage migratetype caching
Message-ID: <20230912145028.GA3228@cmpxchg.org>
References: <20230911195023.247694-1-hannes@cmpxchg.org>
 <20230911195023.247694-2-hannes@cmpxchg.org>
 <a389d846-c19a-42d3-6206-0a1c80e40b37@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a389d846-c19a-42d3-6206-0a1c80e40b37@suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 03:47:45PM +0200, Vlastimil Babka wrote:
> On 9/11/23 21:41, Johannes Weiner wrote:
> > The idea behind the cache is to save get_pageblock_migratetype()
> > lookups during bulk freeing. A microbenchmark suggests this isn't
> > helping, though. The pcp migratetype can get stale, which means that
> > bulk freeing has an extra branch to check if the pageblock was
> > isolated while on the pcp.
> > 
> > While the variance overlaps, the cache write and the branch seem to
> > make this a net negative. The following test allocates and frees
> > batches of 10,000 pages (~3x the pcp high marks to trigger flushing):
> > 
> > Before:
> >           8,668.48 msec task-clock                       #   99.735 CPUs utilized               ( +-  2.90% )
> >                 19      context-switches                 #    4.341 /sec                        ( +-  3.24% )
> >                  0      cpu-migrations                   #    0.000 /sec
> >             17,440      page-faults                      #    3.984 K/sec                       ( +-  2.90% )
> >     41,758,692,473      cycles                           #    9.541 GHz                         ( +-  2.90% )
> >    126,201,294,231      instructions                     #    5.98  insn per cycle              ( +-  2.90% )
> >     25,348,098,335      branches                         #    5.791 G/sec                       ( +-  2.90% )
> >         33,436,921      branch-misses                    #    0.26% of all branches             ( +-  2.90% )
> > 
> >          0.0869148 +- 0.0000302 seconds time elapsed  ( +-  0.03% )
> > 
> > After:
> >           8,444.81 msec task-clock                       #   99.726 CPUs utilized               ( +-  2.90% )
> >                 22      context-switches                 #    5.160 /sec                        ( +-  3.23% )
> >                  0      cpu-migrations                   #    0.000 /sec
> >             17,443      page-faults                      #    4.091 K/sec                       ( +-  2.90% )
> >     40,616,738,355      cycles                           #    9.527 GHz                         ( +-  2.90% )
> >    126,383,351,792      instructions                     #    6.16  insn per cycle              ( +-  2.90% )
> >     25,224,985,153      branches                         #    5.917 G/sec                       ( +-  2.90% )
> >         32,236,793      branch-misses                    #    0.25% of all branches             ( +-  2.90% )
> > 
> >          0.0846799 +- 0.0000412 seconds time elapsed  ( +-  0.05% )
> > 
> > A side effect is that this also ensures that pages whose pageblock
> > gets stolen while on the pcplist end up on the right freelist and we
> > don't perform potentially type-incompatible buddy merges (or skip
> > merges when we shouldn't), whis is likely beneficial to long-term
> > fragmentation management, although the effects would be harder to
> > measure. Settle for simpler and faster code as justification here.
> 
> Makes sense to me, so
> 
> > Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> 
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

Thanks!

> > @@ -1577,7 +1556,6 @@ struct page *__rmqueue_smallest(struct zone *zone, unsigned int order,
> >  			continue;
> >  		del_page_from_free_list(page, zone, current_order);
> >  		expand(zone, page, order, current_order, migratetype);
> > -		set_pcppage_migratetype(page, migratetype);
> 
> Hm interesting, just noticed that __rmqueue_fallback() never did this
> AFAICS, sounds like a bug.

I don't quite follow. Which part?

Keep in mind that at this point __rmqueue_fallback() doesn't return a
page. It just moves pages to the desired freelist, and then
__rmqueue_smallest() gets called again. This changes in 5/6, but until
now at least all of the above would apply to fallback pages.

> > @@ -2145,7 +2123,7 @@ static int rmqueue_bulk(struct zone *zone, unsigned int order,
> >  		 * pages are ordered properly.
> >  		 */
> >  		list_add_tail(&page->pcp_list, list);
> > -		if (is_migrate_cma(get_pcppage_migratetype(page)))
> > +		if (is_migrate_cma(get_pageblock_migratetype(page)))
> >  			__mod_zone_page_state(zone, NR_FREE_CMA_PAGES,
> >  					      -(1 << order));
> 
> This is potentially a source of overhead, I assume patch 6/6 might
> change that.

Yes, 6/6 removes it altogether.

But the test results in this patch's changelog are from this patch in
isolation, so it doesn't appear to be a concern even on its own.

> > @@ -2457,7 +2423,7 @@ void free_unref_page_list(struct list_head *list)
> >  		 * Free isolated pages directly to the allocator, see
> >  		 * comment in free_unref_page.
> >  		 */
> > -		migratetype = get_pcppage_migratetype(page);
> > +		migratetype = get_pfnblock_migratetype(page, pfn);
> >  		if (unlikely(is_migrate_isolate(migratetype))) {
> >  			list_del(&page->lru);
> >  			free_one_page(page_zone(page), page, pfn, 0, migratetype, FPI_NONE);
> 
> I think after this change we should move the isolated pages handling to
> the second loop below, so that we wouldn't have to call
> get_pfnblock_migratetype() twice per page. Dunno yet if some later patch
> does that. It would need to unlock pcp when necessary.

That sounds like a great idea. Something like the following?

Lightly tested. If you're good with it, I'll beat some more on it and
submit it as a follow-up.

---

From 429d13322819ab38b3ba2fad6d1495997819ccc2 Mon Sep 17 00:00:00 2001
From: Johannes Weiner <hannes@cmpxchg.org>
Date: Tue, 12 Sep 2023 10:16:10 -0400
Subject: [PATCH] mm: page_alloc: optimize free_unref_page_list()

Move direct freeing of isolated pages to the lock-breaking block in
the second loop. This saves an unnecessary migratetype reassessment.

Minor comment and local variable scoping cleanups.

Suggested-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/page_alloc.c | 49 +++++++++++++++++++++----------------------------
 1 file changed, 21 insertions(+), 28 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index e3f1c777feed..9cad31de1bf5 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2408,48 +2408,41 @@ void free_unref_page_list(struct list_head *list)
 	struct per_cpu_pages *pcp = NULL;
 	struct zone *locked_zone = NULL;
 	int batch_count = 0;
-	int migratetype;
-
-	/* Prepare pages for freeing */
-	list_for_each_entry_safe(page, next, list, lru) {
-		unsigned long pfn = page_to_pfn(page);
 
-		if (!free_pages_prepare(page, 0, FPI_NONE)) {
+	list_for_each_entry_safe(page, next, list, lru)
+		if (!free_pages_prepare(page, 0, FPI_NONE))
 			list_del(&page->lru);
-			continue;
-		}
-
-		/*
-		 * Free isolated pages directly to the allocator, see
-		 * comment in free_unref_page.
-		 */
-		migratetype = get_pfnblock_migratetype(page, pfn);
-		if (unlikely(is_migrate_isolate(migratetype))) {
-			list_del(&page->lru);
-			free_one_page(page_zone(page), page, pfn, 0, migratetype, FPI_NONE);
-			continue;
-		}
-	}
 
 	list_for_each_entry_safe(page, next, list, lru) {
 		unsigned long pfn = page_to_pfn(page);
 		struct zone *zone = page_zone(page);
+		int migratetype;
 
 		list_del(&page->lru);
 		migratetype = get_pfnblock_migratetype(page, pfn);
 
 		/*
-		 * Either different zone requiring a different pcp lock or
-		 * excessive lock hold times when freeing a large list of
-		 * pages.
+		 * Zone switch, batch complete, or non-pcp freeing?
+		 * Drop the pcp lock and evaluate.
 		 */
-		if (zone != locked_zone || batch_count == SWAP_CLUSTER_MAX) {
+		if (unlikely(zone != locked_zone ||
+			     batch_count == SWAP_CLUSTER_MAX ||
+			     is_migrate_isolate(migratetype))) {
 			if (pcp) {
 				pcp_spin_unlock(pcp);
 				pcp_trylock_finish(UP_flags);
+				locked_zone = NULL;
 			}
 
-			batch_count = 0;
+			/*
+			 * Free isolated pages directly to the
+			 * allocator, see comment in free_unref_page.
+			 */
+			if (is_migrate_isolate(migratetype)) {
+				free_one_page(zone, page, pfn, 0,
+					      migratetype, FPI_NONE);
+				continue;
+			}
 
 			/*
 			 * trylock is necessary as pages may be getting freed
@@ -2459,12 +2452,12 @@ void free_unref_page_list(struct list_head *list)
 			pcp = pcp_spin_trylock(zone->per_cpu_pageset);
 			if (unlikely(!pcp)) {
 				pcp_trylock_finish(UP_flags);
-				free_one_page(zone, page, pfn,
-					      0, migratetype, FPI_NONE);
-				locked_zone = NULL;
+				free_one_page(zone, page, pfn, 0,
+					      migratetype, FPI_NONE);
 				continue;
 			}
 			locked_zone = zone;
+			batch_count = 0;
 		}
 
 		/*
-- 
2.42.0

