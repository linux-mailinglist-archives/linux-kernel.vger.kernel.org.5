Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F10879B18F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 01:56:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357023AbjIKWEz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:04:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244257AbjIKTuk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 15:50:40 -0400
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8E531A5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 12:50:34 -0700 (PDT)
Received: by mail-ua1-x92d.google.com with SMTP id a1e0cc1a2514c-7a52db1e4bbso1808744241.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 12:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1694461834; x=1695066634; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7FpxEl1I3pH8RvyVkhbOxLMeix4VtK7whCGHR+Kbh8c=;
        b=dPH+uWsHnkOkQ9ulxAtyOP8krdvm6ra5XJC+bjB6N5mGkxGJOVBfaaJQDHW73Ie9m/
         +LrSHM0wnet2xq+LsWXoUU7SfowLnwHmTG18KPs9Wb5IJkm5Gyrpuk+JLbzXBsPKIYmp
         OtzpP7nGkYDDc0zvmr6iDzbswzN5GXaqafjDc7U2xQxWk/kBNDADkylcsF63s19E3TxZ
         WwUxGFtNtmn9GGzaivgwjeKPqxNc8VJuXwahYlV6ciOtZBygtx97wjwSBGy72bQu7wsv
         Al7OdDKsTq2eO90b6AAJrcVckQ0MybjdOojd9EG+M5/Tl1n04A57lVxzgSDqVzTysCGW
         5S5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694461834; x=1695066634;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7FpxEl1I3pH8RvyVkhbOxLMeix4VtK7whCGHR+Kbh8c=;
        b=ffXI0ra8XBvkQgEQ0WP7O5RFPCYy3frLjliuMSZv2klzn+4aQMYOUOCJ+l1PdJ6Of1
         D2Xp9l1M+L1wo9yCFgpOO19ZCctQXTLqUvKXHTcX64ng2egHCpJO0yBqDezFQL3dSdfF
         nf3LkI1cWZ2EpH9BMVL6Qb4afmY1S057WMvxf0fJPLmOAu61YOnRyUa/w2xRJ+4nxN7P
         mMLOtbqoejTKXhX2ZD5U2T8Y+8I+4vDTKQidIqiKRElwlAt2WThGeWkVuXtMONsmIiMQ
         K5GKM598oS860v2Noxnii/iqXa4dQNLPYTWbGrAFEWhRkz3+34GgFFsS25oNmZrGhOb1
         HHQg==
X-Gm-Message-State: AOJu0YyIUcYZhXAES7ot+pY855nbhmbvS+azxMmZu9mlL+IFZrSYJwzB
        cu9heX7PzHJRWbP+mGOSjHshAQ==
X-Google-Smtp-Source: AGHT+IH5gBtYy1/4AAerHO8D5EjmzZL+ejo/P0LZt667+IenuP9gxk1guF7nx21/dGBJi/c5z4jB+Q==
X-Received: by 2002:a1f:e7c4:0:b0:495:db79:ea76 with SMTP id e187-20020a1fe7c4000000b00495db79ea76mr4004344vkh.1.1694461833711;
        Mon, 11 Sep 2023 12:50:33 -0700 (PDT)
Received: from localhost (2603-7000-0c01-2716-3012-16a2-6bc2-2937.res6.spectrum.com. [2603:7000:c01:2716:3012:16a2:6bc2:2937])
        by smtp.gmail.com with ESMTPSA id o10-20020a0ccb0a000000b0063d038df3f3sm3149714qvk.52.2023.09.11.12.50.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 12:50:33 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] mm: page_alloc: remove pcppage migratetype caching
Date:   Mon, 11 Sep 2023 15:41:42 -0400
Message-ID: <20230911195023.247694-2-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911195023.247694-1-hannes@cmpxchg.org>
References: <20230911195023.247694-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The idea behind the cache is to save get_pageblock_migratetype()
lookups during bulk freeing. A microbenchmark suggests this isn't
helping, though. The pcp migratetype can get stale, which means that
bulk freeing has an extra branch to check if the pageblock was
isolated while on the pcp.

While the variance overlaps, the cache write and the branch seem to
make this a net negative. The following test allocates and frees
batches of 10,000 pages (~3x the pcp high marks to trigger flushing):

Before:
          8,668.48 msec task-clock                       #   99.735 CPUs utilized               ( +-  2.90% )
                19      context-switches                 #    4.341 /sec                        ( +-  3.24% )
                 0      cpu-migrations                   #    0.000 /sec
            17,440      page-faults                      #    3.984 K/sec                       ( +-  2.90% )
    41,758,692,473      cycles                           #    9.541 GHz                         ( +-  2.90% )
   126,201,294,231      instructions                     #    5.98  insn per cycle              ( +-  2.90% )
    25,348,098,335      branches                         #    5.791 G/sec                       ( +-  2.90% )
        33,436,921      branch-misses                    #    0.26% of all branches             ( +-  2.90% )

         0.0869148 +- 0.0000302 seconds time elapsed  ( +-  0.03% )

After:
          8,444.81 msec task-clock                       #   99.726 CPUs utilized               ( +-  2.90% )
                22      context-switches                 #    5.160 /sec                        ( +-  3.23% )
                 0      cpu-migrations                   #    0.000 /sec
            17,443      page-faults                      #    4.091 K/sec                       ( +-  2.90% )
    40,616,738,355      cycles                           #    9.527 GHz                         ( +-  2.90% )
   126,383,351,792      instructions                     #    6.16  insn per cycle              ( +-  2.90% )
    25,224,985,153      branches                         #    5.917 G/sec                       ( +-  2.90% )
        32,236,793      branch-misses                    #    0.25% of all branches             ( +-  2.90% )

         0.0846799 +- 0.0000412 seconds time elapsed  ( +-  0.05% )

A side effect is that this also ensures that pages whose pageblock
gets stolen while on the pcplist end up on the right freelist and we
don't perform potentially type-incompatible buddy merges (or skip
merges when we shouldn't), whis is likely beneficial to long-term
fragmentation management, although the effects would be harder to
measure. Settle for simpler and faster code as justification here.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/page_alloc.c | 61 ++++++++++++-------------------------------------
 1 file changed, 14 insertions(+), 47 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 95546f376302..e3f1c777feed 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -204,24 +204,6 @@ EXPORT_SYMBOL(node_states);
 
 gfp_t gfp_allowed_mask __read_mostly = GFP_BOOT_MASK;
 
-/*
- * A cached value of the page's pageblock's migratetype, used when the page is
- * put on a pcplist. Used to avoid the pageblock migratetype lookup when
- * freeing from pcplists in most cases, at the cost of possibly becoming stale.
- * Also the migratetype set in the page does not necessarily match the pcplist
- * index, e.g. page might have MIGRATE_CMA set but be on a pcplist with any
- * other index - this ensures that it will be put on the correct CMA freelist.
- */
-static inline int get_pcppage_migratetype(struct page *page)
-{
-	return page->index;
-}
-
-static inline void set_pcppage_migratetype(struct page *page, int migratetype)
-{
-	page->index = migratetype;
-}
-
 #ifdef CONFIG_HUGETLB_PAGE_SIZE_VARIABLE
 unsigned int pageblock_order __read_mostly;
 #endif
@@ -1186,7 +1168,6 @@ static void free_pcppages_bulk(struct zone *zone, int count,
 {
 	unsigned long flags;
 	unsigned int order;
-	bool isolated_pageblocks;
 	struct page *page;
 
 	/*
@@ -1199,7 +1180,6 @@ static void free_pcppages_bulk(struct zone *zone, int count,
 	pindex = pindex - 1;
 
 	spin_lock_irqsave(&zone->lock, flags);
-	isolated_pageblocks = has_isolate_pageblock(zone);
 
 	while (count > 0) {
 		struct list_head *list;
@@ -1215,10 +1195,12 @@ static void free_pcppages_bulk(struct zone *zone, int count,
 		order = pindex_to_order(pindex);
 		nr_pages = 1 << order;
 		do {
+			unsigned long pfn;
 			int mt;
 
 			page = list_last_entry(list, struct page, pcp_list);
-			mt = get_pcppage_migratetype(page);
+			pfn = page_to_pfn(page);
+			mt = get_pfnblock_migratetype(page, pfn);
 
 			/* must delete to avoid corrupting pcp list */
 			list_del(&page->pcp_list);
@@ -1227,11 +1209,8 @@ static void free_pcppages_bulk(struct zone *zone, int count,
 
 			/* MIGRATE_ISOLATE page should not go to pcplists */
 			VM_BUG_ON_PAGE(is_migrate_isolate(mt), page);
-			/* Pageblock could have been isolated meanwhile */
-			if (unlikely(isolated_pageblocks))
-				mt = get_pageblock_migratetype(page);
 
-			__free_one_page(page, page_to_pfn(page), zone, order, mt, FPI_NONE);
+			__free_one_page(page, pfn, zone, order, mt, FPI_NONE);
 			trace_mm_page_pcpu_drain(page, order, mt);
 		} while (count > 0 && !list_empty(list));
 	}
@@ -1577,7 +1556,6 @@ struct page *__rmqueue_smallest(struct zone *zone, unsigned int order,
 			continue;
 		del_page_from_free_list(page, zone, current_order);
 		expand(zone, page, order, current_order, migratetype);
-		set_pcppage_migratetype(page, migratetype);
 		trace_mm_page_alloc_zone_locked(page, order, migratetype,
 				pcp_allowed_order(order) &&
 				migratetype < MIGRATE_PCPTYPES);
@@ -2145,7 +2123,7 @@ static int rmqueue_bulk(struct zone *zone, unsigned int order,
 		 * pages are ordered properly.
 		 */
 		list_add_tail(&page->pcp_list, list);
-		if (is_migrate_cma(get_pcppage_migratetype(page)))
+		if (is_migrate_cma(get_pageblock_migratetype(page)))
 			__mod_zone_page_state(zone, NR_FREE_CMA_PAGES,
 					      -(1 << order));
 	}
@@ -2304,19 +2282,6 @@ void drain_all_pages(struct zone *zone)
 	__drain_all_pages(zone, false);
 }
 
-static bool free_unref_page_prepare(struct page *page, unsigned long pfn,
-							unsigned int order)
-{
-	int migratetype;
-
-	if (!free_pages_prepare(page, order, FPI_NONE))
-		return false;
-
-	migratetype = get_pfnblock_migratetype(page, pfn);
-	set_pcppage_migratetype(page, migratetype);
-	return true;
-}
-
 static int nr_pcp_free(struct per_cpu_pages *pcp, int high, bool free_high)
 {
 	int min_nr_free, max_nr_free;
@@ -2402,7 +2367,7 @@ void free_unref_page(struct page *page, unsigned int order)
 	unsigned long pfn = page_to_pfn(page);
 	int migratetype, pcpmigratetype;
 
-	if (!free_unref_page_prepare(page, pfn, order))
+	if (!free_pages_prepare(page, order, FPI_NONE))
 		return;
 
 	/*
@@ -2412,7 +2377,7 @@ void free_unref_page(struct page *page, unsigned int order)
 	 * get those areas back if necessary. Otherwise, we may have to free
 	 * excessively into the page allocator
 	 */
-	migratetype = pcpmigratetype = get_pcppage_migratetype(page);
+	migratetype = pcpmigratetype = get_pfnblock_migratetype(page, pfn);
 	if (unlikely(migratetype >= MIGRATE_PCPTYPES)) {
 		if (unlikely(is_migrate_isolate(migratetype))) {
 			free_one_page(page_zone(page), page, pfn, order, migratetype, FPI_NONE);
@@ -2448,7 +2413,8 @@ void free_unref_page_list(struct list_head *list)
 	/* Prepare pages for freeing */
 	list_for_each_entry_safe(page, next, list, lru) {
 		unsigned long pfn = page_to_pfn(page);
-		if (!free_unref_page_prepare(page, pfn, 0)) {
+
+		if (!free_pages_prepare(page, 0, FPI_NONE)) {
 			list_del(&page->lru);
 			continue;
 		}
@@ -2457,7 +2423,7 @@ void free_unref_page_list(struct list_head *list)
 		 * Free isolated pages directly to the allocator, see
 		 * comment in free_unref_page.
 		 */
-		migratetype = get_pcppage_migratetype(page);
+		migratetype = get_pfnblock_migratetype(page, pfn);
 		if (unlikely(is_migrate_isolate(migratetype))) {
 			list_del(&page->lru);
 			free_one_page(page_zone(page), page, pfn, 0, migratetype, FPI_NONE);
@@ -2466,10 +2432,11 @@ void free_unref_page_list(struct list_head *list)
 	}
 
 	list_for_each_entry_safe(page, next, list, lru) {
+		unsigned long pfn = page_to_pfn(page);
 		struct zone *zone = page_zone(page);
 
 		list_del(&page->lru);
-		migratetype = get_pcppage_migratetype(page);
+		migratetype = get_pfnblock_migratetype(page, pfn);
 
 		/*
 		 * Either different zone requiring a different pcp lock or
@@ -2492,7 +2459,7 @@ void free_unref_page_list(struct list_head *list)
 			pcp = pcp_spin_trylock(zone->per_cpu_pageset);
 			if (unlikely(!pcp)) {
 				pcp_trylock_finish(UP_flags);
-				free_one_page(zone, page, page_to_pfn(page),
+				free_one_page(zone, page, pfn,
 					      0, migratetype, FPI_NONE);
 				locked_zone = NULL;
 				continue;
@@ -2661,7 +2628,7 @@ struct page *rmqueue_buddy(struct zone *preferred_zone, struct zone *zone,
 			}
 		}
 		__mod_zone_freepage_state(zone, -(1 << order),
-					  get_pcppage_migratetype(page));
+					  get_pageblock_migratetype(page));
 		spin_unlock_irqrestore(&zone->lock, flags);
 	} while (check_new_pages(page, order));
 
-- 
2.42.0

