Return-Path: <linux-kernel+bounces-108366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0374C8809B8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 03:43:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FFB11C21EF1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 02:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82E4E1426A;
	Wed, 20 Mar 2024 02:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cs.cmu.edu header.i=@cs.cmu.edu header.b="b26ysJaW"
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A644BF9F5
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 02:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710902547; cv=none; b=XHOqP0huvLTKcAzgUuyjFod0i51YO71RUq4fSgo1JrMQzmuHQ3b/nvLlTXoJtx8vn3g1yMbGcGLcHjKZ1yNdQPXOS0ztJMwQl4j39bVM9zTTmvaYyydaM4Dmn51v6dknP1B5xrWcjMvU98/atwP2xcT0PeNNvX2xHQ5J/V2qDGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710902547; c=relaxed/simple;
	bh=l52JrmiqoXyGIuFFDgBlXrC/zh8TWuGP8g41ayonsYU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qPHhUzG4y9+v7R0aXPuQkXSC1Jg3yr9Z6wq3uYK48klPWbIh19YLPGOR7Cu6UUN2qFYu7jBzaTaN2w6RlaCTTgm9WRdRtubEtXeWdVSWmcsNUyVjItz+GGfha08N9DGbV+53zNYpWlhZaWL4GeEAzwti+uarvEcOPfTINXg0oP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.cmu.edu; spf=pass smtp.mailfrom=andrew.cmu.edu; dkim=pass (2048-bit key) header.d=cs.cmu.edu header.i=@cs.cmu.edu header.b=b26ysJaW; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.cmu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=andrew.cmu.edu
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-6e6969855c8so1602626a34.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 19:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.cmu.edu; s=google-2021; t=1710902542; x=1711507342; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UljsMw4YXxvG2im1vY4a6XAU2ZaTJQdUEua3lUBpIog=;
        b=b26ysJaWaMFF1aefAi/9HdyoC665IxctzqD06rPgFth8PFOfayGvSVkUNd3BEyXVLv
         8j+dRLDyKWXzkRO1SZuWmr6xDhoEp+8p5eNB4qyVYbLdYIFRk/DiOgGOCRq8xCBMqkTD
         7mXnKZJOWYN48M8/ME8or95lUrtslfKAgVr1oHmFmiHwBLAY9reVwsUje1eTDs0PVTx3
         TuV1CVy0kg3fXinS24JYVCg1LE+4xl2AE/29XCIP7iQQJNQ8pozlZNnhTm7DXC2TSxGo
         xbVOrxsnTBQ0SBuGLrG4tsQ55E+ktcbgpYvzOgxkYoXIGOt+lP+97+TjSjFbrRjOEcqD
         nsrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710902542; x=1711507342;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UljsMw4YXxvG2im1vY4a6XAU2ZaTJQdUEua3lUBpIog=;
        b=c3h9iN0GweR7/L5Ke9/CJP2sDFiK6yGRlxsZbzTaIntoFl1f0q9wwOcnDCI+Pyl0pD
         vdajrmox/DZMAcF8YKs3Tut69+SG3Hx7AeJLY0CME9jajLlS0nzyDFmA1/kNAD6DMuPk
         yXVP2rZOJ22kiXmZMZ2RC/YEEHlq30/Q6eIRy9hfgUOLUzmqVlHIWPb5pIYsWsk/61Tv
         EjIlPp0Vvt2nBhlZoH8BAtOb2uWFdxrKx6MX0UI7fEvUwi2XbxTF6hWa2lf167geDygO
         sPSewBHewTH7mPK0Deozq0WF8TWpSYH/uvmtbSm9RZfsGpDEeHekTo48jxcU0NlF9x8Q
         4rgQ==
X-Forwarded-Encrypted: i=1; AJvYcCWgbdrlMntLKFwmp+Q/GVCoMtibJHDSHJ7BxUZ0rnnLc8DTmqpWGIBENF0xCrBoOakIlbxrR1Op51iWGnLO+fDUYSmLPukiBCYXKaho
X-Gm-Message-State: AOJu0Yyxe0k63aKwlQ89sHnrtQ/lGJWBIYWwyijHMRwnde6K9Ii708/n
	CtU8wHrVKFtfeBXKGFKV3qvpQiHoyAvE+7huEl3A8qMK+ftSbdLL4yY44roCag==
X-Google-Smtp-Source: AGHT+IESptNQKDLD8MOe2hQxpKnyZd4H1raJLsnnYtjWGvQGBbhnaHWmiZ6IFtzpyT4LI3UuB+xfsg==
X-Received: by 2002:a9d:74c5:0:b0:6e4:f961:e444 with SMTP id a5-20020a9d74c5000000b006e4f961e444mr5504940otl.4.1710902542503;
        Tue, 19 Mar 2024 19:42:22 -0700 (PDT)
Received: from localhost (pool-74-98-221-57.pitbpa.fios.verizon.net. [74.98.221.57])
        by smtp.gmail.com with UTF8SMTPSA id y27-20020a05620a09db00b00789f0d9e6dcsm3560797qky.93.2024.03.19.19.42.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Mar 2024 19:42:22 -0700 (PDT)
From: kaiyang2@cs.cmu.edu
To: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: Kaiyang Zhao <kaiyang2@cs.cmu.edu>,
	hannes@cmpxchg.org,
	ziy@nvidia.com,
	dskarlat@cs.cmu.edu
Subject: [RFC PATCH 3/7] compaction accepts a destination zone
Date: Wed, 20 Mar 2024 02:42:14 +0000
Message-Id: <20240320024218.203491-4-kaiyang2@cs.cmu.edu>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240320024218.203491-1-kaiyang2@cs.cmu.edu>
References: <20240320024218.203491-1-kaiyang2@cs.cmu.edu>
Reply-To: Kaiyang Zhao <kaiyang2@cs.cmu.edu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kaiyang Zhao <kaiyang2@cs.cmu.edu>

Distinguishes the source and destination zones in compaction

Signed-off-by: Kaiyang Zhao <zh_kaiyang@hotmail.com>
---
 include/linux/compaction.h |   4 +-
 mm/compaction.c            | 106 +++++++++++++++++++++++--------------
 mm/internal.h              |   1 +
 mm/vmscan.c                |   4 +-
 4 files changed, 70 insertions(+), 45 deletions(-)

diff --git a/include/linux/compaction.h b/include/linux/compaction.h
index a6e512cfb670..11f5a1a83abb 100644
--- a/include/linux/compaction.h
+++ b/include/linux/compaction.h
@@ -90,7 +90,7 @@ extern enum compact_result try_to_compact_pages(gfp_t gfp_mask,
 		struct page **page);
 extern void reset_isolation_suitable(pg_data_t *pgdat);
 extern enum compact_result compaction_suitable(struct zone *zone, int order,
-		unsigned int alloc_flags, int highest_zoneidx);
+		unsigned int alloc_flags, int highest_zoneidx, struct zone *dst_zone);
 
 extern void compaction_defer_reset(struct zone *zone, int order,
 				bool alloc_success);
@@ -180,7 +180,7 @@ static inline void reset_isolation_suitable(pg_data_t *pgdat)
 }
 
 static inline enum compact_result compaction_suitable(struct zone *zone, int order,
-					int alloc_flags, int highest_zoneidx)
+					int alloc_flags, int highest_zoneidx, struct zone *dst_zone)
 {
 	return COMPACT_SKIPPED;
 }
diff --git a/mm/compaction.c b/mm/compaction.c
index c8bcdea15f5f..03b5c4debc17 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -435,7 +435,7 @@ static void update_cached_migrate(struct compact_control *cc, unsigned long pfn)
 static void update_pageblock_skip(struct compact_control *cc,
 			struct page *page, unsigned long pfn)
 {
-	struct zone *zone = cc->zone;
+	struct zone *dst_zone = cc->dst_zone ? cc->dst_zone : cc->zone;
 
 	if (cc->no_set_skip_hint)
 		return;
@@ -446,8 +446,8 @@ static void update_pageblock_skip(struct compact_control *cc,
 	set_pageblock_skip(page);
 
 	/* Update where async and sync compaction should restart */
-	if (pfn < zone->compact_cached_free_pfn)
-		zone->compact_cached_free_pfn = pfn;
+	if (pfn < dst_zone->compact_cached_free_pfn)
+		dst_zone->compact_cached_free_pfn = pfn;
 }
 #else
 static inline bool isolation_suitable(struct compact_control *cc,
@@ -550,6 +550,7 @@ static unsigned long isolate_freepages_block(struct compact_control *cc,
 	bool locked = false;
 	unsigned long blockpfn = *start_pfn;
 	unsigned int order;
+	struct zone *dst_zone = cc->dst_zone ? cc->dst_zone : cc->zone;
 
 	/* Strict mode is for isolation, speed is secondary */
 	if (strict)
@@ -568,7 +569,7 @@ static unsigned long isolate_freepages_block(struct compact_control *cc,
 		 * pending.
 		 */
 		if (!(blockpfn % COMPACT_CLUSTER_MAX)
-		    && compact_unlock_should_abort(&cc->zone->lock, flags,
+		    && compact_unlock_should_abort(&dst_zone->lock, flags,
 								&locked, cc))
 			break;
 
@@ -596,7 +597,7 @@ static unsigned long isolate_freepages_block(struct compact_control *cc,
 
 		/* If we already hold the lock, we can skip some rechecking. */
 		if (!locked) {
-			locked = compact_lock_irqsave(&cc->zone->lock,
+			locked = compact_lock_irqsave(&dst_zone->lock,
 								&flags, cc);
 
 			/* Recheck this is a buddy page under lock */
@@ -634,7 +635,7 @@ static unsigned long isolate_freepages_block(struct compact_control *cc,
 	}
 
 	if (locked)
-		spin_unlock_irqrestore(&cc->zone->lock, flags);
+		spin_unlock_irqrestore(&dst_zone->lock, flags);
 
 	/*
 	 * There is a tiny chance that we have read bogus compound_order(),
@@ -683,11 +684,12 @@ isolate_freepages_range(struct compact_control *cc,
 {
 	unsigned long isolated, pfn, block_start_pfn, block_end_pfn;
 	LIST_HEAD(freelist);
+	struct zone *dst_zone = cc->dst_zone ? cc->dst_zone : cc->zone;
 
 	pfn = start_pfn;
 	block_start_pfn = pageblock_start_pfn(pfn);
-	if (block_start_pfn < cc->zone->zone_start_pfn)
-		block_start_pfn = cc->zone->zone_start_pfn;
+	if (block_start_pfn < dst_zone->zone_start_pfn)
+		block_start_pfn = dst_zone->zone_start_pfn;
 	block_end_pfn = pageblock_end_pfn(pfn);
 
 	for (; pfn < end_pfn; pfn += isolated,
@@ -710,7 +712,7 @@ isolate_freepages_range(struct compact_control *cc,
 		}
 
 		if (!pageblock_pfn_to_page(block_start_pfn,
-					block_end_pfn, cc->zone))
+					block_end_pfn, dst_zone))
 			break;
 
 		isolated = isolate_freepages_block(cc, &isolate_start_pfn,
@@ -1359,6 +1361,7 @@ fast_isolate_around(struct compact_control *cc, unsigned long pfn)
 {
 	unsigned long start_pfn, end_pfn;
 	struct page *page;
+	struct zone *dst_zone = cc->dst_zone ? cc->dst_zone : cc->zone;
 
 	/* Do not search around if there are enough pages already */
 	if (cc->nr_freepages >= cc->nr_migratepages)
@@ -1369,10 +1372,10 @@ fast_isolate_around(struct compact_control *cc, unsigned long pfn)
 		return;
 
 	/* Pageblock boundaries */
-	start_pfn = max(pageblock_start_pfn(pfn), cc->zone->zone_start_pfn);
-	end_pfn = min(pageblock_end_pfn(pfn), zone_end_pfn(cc->zone));
+	start_pfn = max(pageblock_start_pfn(pfn), dst_zone->zone_start_pfn);
+	end_pfn = min(pageblock_end_pfn(pfn), zone_end_pfn(dst_zone));
 
-	page = pageblock_pfn_to_page(start_pfn, end_pfn, cc->zone);
+	page = pageblock_pfn_to_page(start_pfn, end_pfn, dst_zone);
 	if (!page)
 		return;
 
@@ -1414,6 +1417,7 @@ fast_isolate_freepages(struct compact_control *cc)
 	struct page *page = NULL;
 	bool scan_start = false;
 	int order;
+	struct zone *dst_zone = cc->dst_zone ? cc->dst_zone : cc->zone;
 
 	/* Full compaction passes in a negative order */
 	if (cc->order <= 0)
@@ -1423,7 +1427,7 @@ fast_isolate_freepages(struct compact_control *cc)
 	 * If starting the scan, use a deeper search and use the highest
 	 * PFN found if a suitable one is not found.
 	 */
-	if (cc->free_pfn >= cc->zone->compact_init_free_pfn) {
+	if (cc->free_pfn >= dst_zone->compact_init_free_pfn) {
 		limit = pageblock_nr_pages >> 1;
 		scan_start = true;
 	}
@@ -1448,7 +1452,7 @@ fast_isolate_freepages(struct compact_control *cc)
 	for (order = cc->search_order;
 	     !page && order >= 0;
 	     order = next_search_order(cc, order)) {
-		struct free_area *area = &cc->zone->free_area[order];
+		struct free_area *area = &dst_zone->free_area[order];
 		struct list_head *freelist;
 		struct page *freepage;
 		unsigned long flags;
@@ -1458,7 +1462,7 @@ fast_isolate_freepages(struct compact_control *cc)
 		if (!area->nr_free)
 			continue;
 
-		spin_lock_irqsave(&cc->zone->lock, flags);
+		spin_lock_irqsave(&dst_zone->lock, flags);
 		freelist = &area->free_list[MIGRATE_MOVABLE];
 		list_for_each_entry_reverse(freepage, freelist, lru) {
 			unsigned long pfn;
@@ -1469,7 +1473,7 @@ fast_isolate_freepages(struct compact_control *cc)
 
 			if (pfn >= highest)
 				highest = max(pageblock_start_pfn(pfn),
-					      cc->zone->zone_start_pfn);
+					      dst_zone->zone_start_pfn);
 
 			if (pfn >= low_pfn) {
 				cc->fast_search_fail = 0;
@@ -1516,7 +1520,7 @@ fast_isolate_freepages(struct compact_control *cc)
 			}
 		}
 
-		spin_unlock_irqrestore(&cc->zone->lock, flags);
+		spin_unlock_irqrestore(&dst_zone->lock, flags);
 
 		/*
 		 * Smaller scan on next order so the total scan is related
@@ -1541,17 +1545,17 @@ fast_isolate_freepages(struct compact_control *cc)
 				if (cc->direct_compaction && pfn_valid(min_pfn)) {
 					page = pageblock_pfn_to_page(min_pfn,
 						min(pageblock_end_pfn(min_pfn),
-						    zone_end_pfn(cc->zone)),
-						cc->zone);
+						    zone_end_pfn(dst_zone)),
+						dst_zone);
 					cc->free_pfn = min_pfn;
 				}
 			}
 		}
 	}
 
-	if (highest && highest >= cc->zone->compact_cached_free_pfn) {
+	if (highest && highest >= dst_zone->compact_cached_free_pfn) {
 		highest -= pageblock_nr_pages;
-		cc->zone->compact_cached_free_pfn = highest;
+		dst_zone->compact_cached_free_pfn = highest;
 	}
 
 	cc->total_free_scanned += nr_scanned;
@@ -1569,7 +1573,7 @@ fast_isolate_freepages(struct compact_control *cc)
  */
 static void isolate_freepages(struct compact_control *cc)
 {
-	struct zone *zone = cc->zone;
+	struct zone *zone = cc->dst_zone ? cc->dst_zone : cc->zone;
 	struct page *page;
 	unsigned long block_start_pfn;	/* start of current pageblock */
 	unsigned long isolate_start_pfn; /* exact pfn we start at */
@@ -2089,11 +2093,19 @@ static enum compact_result __compact_finished(struct compact_control *cc)
 	unsigned int order;
 	const int migratetype = cc->migratetype;
 	int ret;
+	struct zone *dst_zone = cc->dst_zone ? cc->dst_zone : cc->zone;
 
-	/* Compaction run completes if the migrate and free scanner meet */
-	if (compact_scanners_met(cc)) {
+	/*
+	 * Compaction run completes if the migrate and free scanner meet
+	 * or when either the src or dst zone has been completely scanned
+	 */
+	if (compact_scanners_met(cc) ||
+			cc->migrate_pfn >= zone_end_pfn(cc->zone) ||
+			cc->free_pfn < dst_zone->zone_start_pfn) {
 		/* Let the next compaction start anew. */
 		reset_cached_positions(cc->zone);
+		if (cc->dst_zone)
+			reset_cached_positions(cc->dst_zone);
 
 		/*
 		 * Mark that the PG_migrate_skip information should be cleared
@@ -2196,10 +2208,13 @@ static enum compact_result compact_finished(struct compact_control *cc)
 static enum compact_result __compaction_suitable(struct zone *zone, int order,
 					unsigned int alloc_flags,
 					int highest_zoneidx,
-					unsigned long wmark_target)
+					unsigned long wmark_target, struct zone *dst_zone)
 {
 	unsigned long watermark;
 
+	if (!dst_zone)
+		dst_zone = zone;
+
 	if (is_via_compact_memory(order))
 		return COMPACT_CONTINUE;
 
@@ -2227,9 +2242,9 @@ static enum compact_result __compaction_suitable(struct zone *zone, int order,
 	 * suitable migration targets
 	 */
 	watermark = (order > PAGE_ALLOC_COSTLY_ORDER) ?
-				low_wmark_pages(zone) : min_wmark_pages(zone);
+				low_wmark_pages(dst_zone) : min_wmark_pages(dst_zone);
 	watermark += compact_gap(order);
-	if (!__zone_watermark_ok(zone, 0, watermark, highest_zoneidx,
+	if (!__zone_watermark_ok(dst_zone, 0, watermark, highest_zoneidx,
 						ALLOC_CMA, wmark_target))
 		return COMPACT_SKIPPED;
 
@@ -2245,13 +2260,16 @@ static enum compact_result __compaction_suitable(struct zone *zone, int order,
  */
 enum compact_result compaction_suitable(struct zone *zone, int order,
 					unsigned int alloc_flags,
-					int highest_zoneidx)
+					int highest_zoneidx, struct zone *dst_zone)
 {
 	enum compact_result ret;
 	int fragindex;
 
+	if (!dst_zone)
+		dst_zone = zone;
+
 	ret = __compaction_suitable(zone, order, alloc_flags, highest_zoneidx,
-				    zone_page_state(zone, NR_FREE_PAGES));
+				    zone_page_state(dst_zone, NR_FREE_PAGES), dst_zone);
 	/*
 	 * fragmentation index determines if allocation failures are due to
 	 * low memory or external fragmentation
@@ -2305,7 +2323,7 @@ bool compaction_zonelist_suitable(struct alloc_context *ac, int order,
 		available = zone_reclaimable_pages(zone) / order;
 		available += zone_page_state_snapshot(zone, NR_FREE_PAGES);
 		compact_result = __compaction_suitable(zone, order, alloc_flags,
-				ac->highest_zoneidx, available);
+				ac->highest_zoneidx, available, NULL);
 		if (compact_result == COMPACT_CONTINUE)
 			return true;
 	}
@@ -2317,8 +2335,9 @@ static enum compact_result
 compact_zone(struct compact_control *cc, struct capture_control *capc)
 {
 	enum compact_result ret;
+	struct zone *dst_zone = cc->dst_zone ? cc->dst_zone : cc->zone;
 	unsigned long start_pfn = cc->zone->zone_start_pfn;
-	unsigned long end_pfn = zone_end_pfn(cc->zone);
+	unsigned long end_pfn = zone_end_pfn(dst_zone);
 	unsigned long last_migrated_pfn;
 	const bool sync = cc->mode != MIGRATE_ASYNC;
 	bool update_cached;
@@ -2337,7 +2356,7 @@ compact_zone(struct compact_control *cc, struct capture_control *capc)
 
 	cc->migratetype = gfp_migratetype(cc->gfp_mask);
 	ret = compaction_suitable(cc->zone, cc->order, cc->alloc_flags,
-							cc->highest_zoneidx);
+							cc->highest_zoneidx, dst_zone);
 	/* Compaction is likely to fail */
 	if (ret == COMPACT_SUCCESS || ret == COMPACT_SKIPPED)
 		return ret;
@@ -2346,14 +2365,19 @@ compact_zone(struct compact_control *cc, struct capture_control *capc)
 	 * Clear pageblock skip if there were failures recently and compaction
 	 * is about to be retried after being deferred.
 	 */
-	if (compaction_restarting(cc->zone, cc->order))
+	if (compaction_restarting(cc->zone, cc->order)) {
 		__reset_isolation_suitable(cc->zone);
+		if (dst_zone != cc->zone)
+			__reset_isolation_suitable(dst_zone);
+	}
 
 	/*
 	 * Setup to move all movable pages to the end of the zone. Used cached
 	 * information on where the scanners should start (unless we explicitly
 	 * want to compact the whole zone), but check that it is initialised
 	 * by ensuring the values are within zone boundaries.
+	 *
+	 * If a destination zone is provided, use it for free pages.
 	 */
 	cc->fast_start_pfn = 0;
 	if (cc->whole_zone) {
@@ -2361,12 +2385,12 @@ compact_zone(struct compact_control *cc, struct capture_control *capc)
 		cc->free_pfn = pageblock_start_pfn(end_pfn - 1);
 	} else {
 		cc->migrate_pfn = cc->zone->compact_cached_migrate_pfn[sync];
-		cc->free_pfn = cc->zone->compact_cached_free_pfn;
-		if (cc->free_pfn < start_pfn || cc->free_pfn >= end_pfn) {
+		cc->free_pfn = dst_zone->compact_cached_free_pfn;
+		if (cc->free_pfn < dst_zone->zone_start_pfn || cc->free_pfn >= end_pfn) {
 			cc->free_pfn = pageblock_start_pfn(end_pfn - 1);
-			cc->zone->compact_cached_free_pfn = cc->free_pfn;
+			dst_zone->compact_cached_free_pfn = cc->free_pfn;
 		}
-		if (cc->migrate_pfn < start_pfn || cc->migrate_pfn >= end_pfn) {
+		if (cc->migrate_pfn < start_pfn || cc->migrate_pfn >= zone_end_pfn(cc->zone)) {
 			cc->migrate_pfn = start_pfn;
 			cc->zone->compact_cached_migrate_pfn[0] = cc->migrate_pfn;
 			cc->zone->compact_cached_migrate_pfn[1] = cc->migrate_pfn;
@@ -2522,8 +2546,8 @@ compact_zone(struct compact_control *cc, struct capture_control *capc)
 		 * Only go back, not forward. The cached pfn might have been
 		 * already reset to zone end in compact_finished()
 		 */
-		if (free_pfn > cc->zone->compact_cached_free_pfn)
-			cc->zone->compact_cached_free_pfn = free_pfn;
+		if (free_pfn > dst_zone->compact_cached_free_pfn)
+			dst_zone->compact_cached_free_pfn = free_pfn;
 	}
 
 	count_compact_events(COMPACTMIGRATE_SCANNED, cc->total_migrate_scanned);
@@ -2834,7 +2858,7 @@ static bool kcompactd_node_suitable(pg_data_t *pgdat)
 			continue;
 
 		if (compaction_suitable(zone, pgdat->kcompactd_max_order, 0,
-					highest_zoneidx) == COMPACT_CONTINUE)
+					highest_zoneidx, NULL) == COMPACT_CONTINUE)
 			return true;
 	}
 
@@ -2871,7 +2895,7 @@ static void kcompactd_do_work(pg_data_t *pgdat)
 		if (compaction_deferred(zone, cc.order))
 			continue;
 
-		if (compaction_suitable(zone, cc.order, 0, zoneid) !=
+		if (compaction_suitable(zone, cc.order, 0, zoneid, NULL) !=
 							COMPACT_CONTINUE)
 			continue;
 
diff --git a/mm/internal.h b/mm/internal.h
index 68410c6d97ac..349223cc0359 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -465,6 +465,7 @@ struct compact_control {
 	unsigned long migrate_pfn;
 	unsigned long fast_start_pfn;	/* a pfn to start linear scan from */
 	struct zone *zone;
+	struct zone *dst_zone;			/* use another zone as the destination */
 	unsigned long total_migrate_scanned;
 	unsigned long total_free_scanned;
 	unsigned short fast_search_fail;/* failures to use free list searches */
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 5bf98d0a22c9..aa21da983804 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -6383,7 +6383,7 @@ static inline bool should_continue_reclaim(struct pglist_data *pgdat,
 		if (!managed_zone(zone))
 			continue;
 
-		switch (compaction_suitable(zone, sc->order, 0, sc->reclaim_idx)) {
+		switch (compaction_suitable(zone, sc->order, 0, sc->reclaim_idx, NULL)) {
 		case COMPACT_SUCCESS:
 		case COMPACT_CONTINUE:
 			return false;
@@ -6580,7 +6580,7 @@ static inline bool compaction_ready(struct zone *zone, struct scan_control *sc)
 	unsigned long watermark;
 	enum compact_result suitable;
 
-	suitable = compaction_suitable(zone, sc->order, 0, sc->reclaim_idx);
+	suitable = compaction_suitable(zone, sc->order, 0, sc->reclaim_idx, NULL);
 	if (suitable == COMPACT_SUCCESS)
 		/* Allocation should succeed already. Don't reclaim. */
 		return true;
-- 
2.40.1


