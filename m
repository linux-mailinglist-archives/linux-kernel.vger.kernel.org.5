Return-Path: <linux-kernel+bounces-108368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D0638809BC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 03:43:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 446F6B22E57
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 02:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE86F1B592;
	Wed, 20 Mar 2024 02:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cs.cmu.edu header.i=@cs.cmu.edu header.b="iKNDCQVA"
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57ABA101C6
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 02:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710902548; cv=none; b=u9Bi6eaLLY87fM7mR14vUFOS1dX5MMm8eB1FIumNxU/THtdmKMZiFZiz0ejD6ZfYUiRaBbslOP6WOGHiMNpNdmfsnBMlIFjBS5oaoLpoCnC43z4jLQKeD0bvsOKYjyIHtb5/qMiR1/e7cBlREiPB3mdKXAtLv5RKjdNQklclFMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710902548; c=relaxed/simple;
	bh=W7Eye2Q63n7l9RaClb+x2PjywYvN68crJrLesJ3QC3g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=L96r5QY5dydSLfRumZbeyq+GqqgszkxQt+dVoOqiO27/9o2OYYnH8JzyjlfPSG0+37ey28P91fc22Gu3E5sPOYJuVC0DZzKDnm3RHjnkxeXor59URe+AjKzyQGuu1X9nkQwYrLtBlqPfe7RUOtrWoisjqtCLhZ/cAxxe4Rg57/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.cmu.edu; spf=pass smtp.mailfrom=andrew.cmu.edu; dkim=pass (2048-bit key) header.d=cs.cmu.edu header.i=@cs.cmu.edu header.b=iKNDCQVA; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.cmu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=andrew.cmu.edu
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-690b24973beso4583096d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 19:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.cmu.edu; s=google-2021; t=1710902544; x=1711507344; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Yh8JatHXgZIgb1eyxT1DhEdr2aiRbmcRrkpZMUB4hHw=;
        b=iKNDCQVAyB1+2Ye6Ok08YuQqqrwWagYHyynu6U5cYTtME+gYNa6qzbjctbI6p4knP0
         kDO8fsBkCHlX4xEHUuC1CGokI/VCgHfK37SSPkTrT//2GIkDR7GqBip3rr5cqQXzA7Nz
         Qa8Wmk7XVeEGmBOk1Lht1g6m2t7Bx6nuEqPDFpIm1ad+j7MwzI8ow1GLV0LjRWNgN6BC
         J48/unZRZj4LQKAlErgRoit7MztuTOU3ZZAK2JxnQcuDtZVc4o3YyxBsA6JxAR8jEO6T
         EQWskq2Kfa3Q+6fLdyOH4H9jCeU3xrvBr7p1tjECJC4/8ulI6HxIwlxSfa9LXtU3FCt6
         nJAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710902544; x=1711507344;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Yh8JatHXgZIgb1eyxT1DhEdr2aiRbmcRrkpZMUB4hHw=;
        b=YJnSwrPvyUxhKJiG/Y/wzuy2+oN9UzA89xpHVdC6ugyNhhS/XrIv79FyfM6dF3ruBV
         I4WsTDspkhMcAZf+xa7Mb1mB+OgZGr4y0UOwc3/RlzyTq18w5DFC6MJ+rcKEZo7r/Dow
         0WC60xyaSfHXfp0qdL1j0Cenz48KVcS7cMsSzbIvCBrYfvhxXb6tGFKHA4BAYXctT9JU
         rxhSBOmLnmwE4vB+EU1WOJvmFGpfc1vcAVkZJDhT1ZdazZWuxePIzmW+Fndgf9uLbvHz
         TWRxisPrbag/wgHIKNsOJRY5iZzca68h4yG8mhTPwuDEPdjvZqbL2RGxn8dnb9NnBB4a
         pnMg==
X-Forwarded-Encrypted: i=1; AJvYcCWfC+VWcU2a1lxZ/yRdP05gjcaIruKWteY/d1vbG5cjV9w85ZjxGQopKTWaExgOoLZlsUBFiiqi9G2ldWkLwPNX6Hp0c/PQ8KqTrCkB
X-Gm-Message-State: AOJu0Yzi9bNM5bxMvox7H48XOW+gTAjwv/bMWlNUqveHm9prcGVr0dG2
	8FiAoATqbP9QMUShec1pu0Ri6RNfFYDGtUEspRzf40KlS/lEGD6kwiINhFFPNw==
X-Google-Smtp-Source: AGHT+IGR8vrTWY1WaI5oE4IRdj4GRFNX5p3VLQAJ1dsWkq6eebPZOQskjAK08wq1ThkjZxRjS5rZPw==
X-Received: by 2002:ad4:430b:0:b0:691:4d1f:6a65 with SMTP id c11-20020ad4430b000000b006914d1f6a65mr2449565qvs.27.1710902544204;
        Tue, 19 Mar 2024 19:42:24 -0700 (PDT)
Received: from localhost (pool-74-98-221-57.pitbpa.fios.verizon.net. [74.98.221.57])
        by smtp.gmail.com with UTF8SMTPSA id k12-20020ad45bec000000b006961199b96asm3707324qvc.13.2024.03.19.19.42.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Mar 2024 19:42:23 -0700 (PDT)
From: kaiyang2@cs.cmu.edu
To: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: Kaiyang Zhao <kaiyang2@cs.cmu.edu>,
	hannes@cmpxchg.org,
	ziy@nvidia.com,
	dskarlat@cs.cmu.edu
Subject: [RFC PATCH 5/7] proactively move pages out of unmovable zones in kcompactd
Date: Wed, 20 Mar 2024 02:42:16 +0000
Message-Id: <20240320024218.203491-6-kaiyang2@cs.cmu.edu>
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

Proactively move pages out of unmovable zones in kcompactd
Debug only: zone start and end pfn printed in vmstat
Added counters for cross zone compaction start and scan

Signed-off-by: Kaiyang Zhao <zh_kaiyang@hotmail.com>
---
 include/linux/vm_event_item.h |   3 +
 mm/compaction.c               | 101 +++++++++++++++++++++++++++++++---
 mm/vmstat.c                   |  11 +++-
 3 files changed, 104 insertions(+), 11 deletions(-)

diff --git a/include/linux/vm_event_item.h b/include/linux/vm_event_item.h
index be88819085b6..c9183117c8f7 100644
--- a/include/linux/vm_event_item.h
+++ b/include/linux/vm_event_item.h
@@ -80,6 +80,9 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
 		KCOMPACTD_WAKE,
 		KCOMPACTD_MIGRATE_SCANNED, KCOMPACTD_FREE_SCANNED,
 		COMPACT_CROSS_ZONE_MIGRATED,
+		KCOMPACTD_CROSS_ZONE_START,
+		COMPACT_CROSS_ZONE_MIGRATE_SCANNED,
+		COMPACT_CROSS_ZONE_FREE_SCANNED,
 #endif
 #ifdef CONFIG_HUGETLB_PAGE
 		HTLB_BUDDY_PGALLOC, HTLB_BUDDY_PGALLOC_FAIL,
diff --git a/mm/compaction.c b/mm/compaction.c
index dea10ad8ec64..94ce1282f17b 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -1436,7 +1436,10 @@ fast_isolate_freepages(struct compact_control *cc)
 	 * Preferred point is in the top quarter of the scan space but take
 	 * a pfn from the top half if the search is problematic.
 	 */
-	distance = (cc->free_pfn - cc->migrate_pfn);
+	if (cc->zone != dst_zone)
+		distance = (cc->free_pfn - dst_zone->zone_start_pfn) >> 1;
+	else
+		distance = (cc->free_pfn - cc->migrate_pfn);
 	low_pfn = pageblock_start_pfn(cc->free_pfn - (distance >> 2));
 	min_pfn = pageblock_start_pfn(cc->free_pfn - (distance >> 1));
 
@@ -1602,7 +1605,10 @@ static void isolate_freepages(struct compact_control *cc)
 	block_start_pfn = pageblock_start_pfn(isolate_start_pfn);
 	block_end_pfn = min(block_start_pfn + pageblock_nr_pages,
 						zone_end_pfn(zone));
-	low_pfn = pageblock_end_pfn(cc->migrate_pfn);
+	if (cc->dst_zone && cc->zone != cc->dst_zone)
+		low_pfn = pageblock_end_pfn(cc->dst_zone->zone_start_pfn);
+	else
+		low_pfn = pageblock_end_pfn(cc->migrate_pfn);
 	stride = cc->mode == MIGRATE_ASYNC ? COMPACT_CLUSTER_MAX : 1;
 
 	/*
@@ -1822,7 +1828,11 @@ static unsigned long fast_find_migrateblock(struct compact_control *cc)
 	 * within the first eighth to reduce the chances that a migration
 	 * target later becomes a source.
 	 */
-	distance = (cc->free_pfn - cc->migrate_pfn) >> 1;
+	if (cc->dst_zone && cc->zone != cc->dst_zone)
+		distance = (zone_end_pfn(cc->zone) - cc->migrate_pfn) >> 1;
+	else
+		distance = (cc->free_pfn - cc->migrate_pfn) >> 1;
+
 	if (cc->migrate_pfn != cc->zone->zone_start_pfn)
 		distance >>= 2;
 	high_pfn = pageblock_start_pfn(cc->migrate_pfn + distance);
@@ -1897,7 +1907,7 @@ static isolate_migrate_t isolate_migratepages(struct compact_control *cc)
 {
 	unsigned long block_start_pfn;
 	unsigned long block_end_pfn;
-	unsigned long low_pfn;
+	unsigned long low_pfn, high_pfn;
 	struct page *page;
 	const isolate_mode_t isolate_mode =
 		(sysctl_compact_unevictable_allowed ? ISOLATE_UNEVICTABLE : 0) |
@@ -1924,11 +1934,16 @@ static isolate_migrate_t isolate_migratepages(struct compact_control *cc)
 	/* Only scan within a pageblock boundary */
 	block_end_pfn = pageblock_end_pfn(low_pfn);
 
+	if (cc->dst_zone && cc->zone != cc->dst_zone)
+		high_pfn = zone_end_pfn(cc->zone);
+	else
+		high_pfn = cc->free_pfn;
+
 	/*
 	 * Iterate over whole pageblocks until we find the first suitable.
 	 * Do not cross the free scanner.
 	 */
-	for (; block_end_pfn <= cc->free_pfn;
+	for (; block_end_pfn <= high_pfn;
 			fast_find_block = false,
 			cc->migrate_pfn = low_pfn = block_end_pfn,
 			block_start_pfn = block_end_pfn,
@@ -1954,6 +1969,7 @@ static isolate_migrate_t isolate_migratepages(struct compact_control *cc)
 		 * before making it "skip" so other compaction instances do
 		 * not scan the same block.
 		 */
+
 		if (pageblock_aligned(low_pfn) &&
 		    !fast_find_block && !isolation_suitable(cc, page))
 			continue;
@@ -1976,6 +1992,10 @@ static isolate_migrate_t isolate_migratepages(struct compact_control *cc)
 						isolate_mode))
 			return ISOLATE_ABORT;
 
+		/* free_pfn may have changed. update high_pfn. */
+		if (!cc->dst_zone || cc->zone == cc->dst_zone)
+			high_pfn = cc->free_pfn;
+
 		/*
 		 * Either we isolated something and proceed with migration. Or
 		 * we failed and compact_zone should decide if we should
@@ -2141,7 +2161,9 @@ static enum compact_result __compact_finished(struct compact_control *cc)
 		goto out;
 	}
 
-	if (is_via_compact_memory(cc->order))
+	/* Don't check if a suitable page is free if doing cross zone compaction. */
+	if (is_via_compact_memory(cc->order) ||
+			(cc->dst_zone && cc->dst_zone != cc->zone))
 		return COMPACT_CONTINUE;
 
 	/*
@@ -2224,7 +2246,8 @@ static enum compact_result __compaction_suitable(struct zone *zone, int order,
 	 * should be no need for compaction at all.
 	 */
 	if (zone_watermark_ok(zone, order, watermark, highest_zoneidx,
-								alloc_flags))
+								alloc_flags) &&
+							dst_zone == zone)
 		return COMPACT_SUCCESS;
 
 	/*
@@ -2270,6 +2293,11 @@ enum compact_result compaction_suitable(struct zone *zone, int order,
 
 	ret = __compaction_suitable(zone, order, alloc_flags, highest_zoneidx,
 				    zone_page_state(dst_zone, NR_FREE_PAGES), dst_zone);
+
+	/* Allow migrating movable pages to ZONE_MOVABLE regardless of frag index */
+	if (ret == COMPACT_CONTINUE && dst_zone != zone)
+		return ret;
+
 	/*
 	 * fragmentation index determines if allocation failures are due to
 	 * low memory or external fragmentation
@@ -2841,6 +2869,14 @@ void compaction_unregister_node(struct node *node)
 }
 #endif /* CONFIG_SYSFS && CONFIG_NUMA */
 
+static inline bool should_compact_unmovable_zones(pg_data_t *pgdat)
+{
+	if (populated_zone(&pgdat->node_zones[ZONE_MOVABLE]))
+		return true;
+	else
+		return false;
+}
+
 static inline bool kcompactd_work_requested(pg_data_t *pgdat)
 {
 	return pgdat->kcompactd_max_order > 0 || kthread_should_stop() ||
@@ -2942,6 +2978,48 @@ static void kcompactd_do_work(pg_data_t *pgdat)
 		pgdat->kcompactd_highest_zoneidx = pgdat->nr_zones - 1;
 }
 
+static void kcompactd_clean_unmovable_zones(pg_data_t *pgdat)
+{
+	int zoneid;
+	struct zone *zone;
+	struct compact_control cc = {
+		.order = 0,
+		.search_order = 0,
+		.highest_zoneidx = ZONE_MOVABLE,
+		.mode = MIGRATE_SYNC,
+		.ignore_skip_hint = true,
+		.gfp_mask = GFP_KERNEL,
+		.dst_zone = &pgdat->node_zones[ZONE_MOVABLE],
+		.whole_zone = true
+	};
+	count_compact_event(KCOMPACTD_CROSS_ZONE_START);
+
+	for (zoneid = 0; zoneid < ZONE_MOVABLE; zoneid++) {
+		int status;
+
+		zone = &pgdat->node_zones[zoneid];
+		if (!populated_zone(zone))
+			continue;
+
+		if (compaction_suitable(zone, cc.order, 0, zoneid, cc.dst_zone) !=
+							COMPACT_CONTINUE)
+			continue;
+
+		if (kthread_should_stop())
+			return;
+
+		/* Not participating in compaction defer. */
+
+		cc.zone = zone;
+		status = compact_zone(&cc, NULL);
+
+		count_compact_events(COMPACT_CROSS_ZONE_MIGRATE_SCANNED,
+				     cc.total_migrate_scanned);
+		count_compact_events(COMPACT_CROSS_ZONE_FREE_SCANNED,
+				     cc.total_free_scanned);
+	}
+}
+
 void wakeup_kcompactd(pg_data_t *pgdat, int order, int highest_zoneidx)
 {
 	if (!order)
@@ -2994,9 +3072,10 @@ static int kcompactd(void *p)
 
 		/*
 		 * Avoid the unnecessary wakeup for proactive compaction
-		 * when it is disabled.
+		 * and cleanup of unmovable zones
+		 * when they are disabled.
 		 */
-		if (!sysctl_compaction_proactiveness)
+		if (!sysctl_compaction_proactiveness && !should_compact_unmovable_zones(pgdat))
 			timeout = MAX_SCHEDULE_TIMEOUT;
 		trace_mm_compaction_kcompactd_sleep(pgdat->node_id);
 		if (wait_event_freezable_timeout(pgdat->kcompactd_wait,
@@ -3017,6 +3096,10 @@ static int kcompactd(void *p)
 			continue;
 		}
 
+		/* Migrates movable pages out of unmovable zones if ZONE_MOVABLE exists */
+		if (should_compact_unmovable_zones(pgdat))
+			kcompactd_clean_unmovable_zones(pgdat);
+
 		/*
 		 * Start the proactive work with default timeout. Based
 		 * on the fragmentation score, this timeout is updated.
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 98af82e65ad9..444740605f2f 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1325,6 +1325,9 @@ const char * const vmstat_text[] = {
 	"compact_daemon_migrate_scanned",
 	"compact_daemon_free_scanned",
 	"compact_cross_zone_migrated",
+	"compact_cross_zone_start",
+	"compact_cross_zone_migrate_scanned",
+	"compact_cross_zone_free_scanned",
 #endif
 
 #ifdef CONFIG_HUGETLB_PAGE
@@ -1692,7 +1695,9 @@ static void zoneinfo_show_print(struct seq_file *m, pg_data_t *pgdat,
 		   "\n        spanned  %lu"
 		   "\n        present  %lu"
 		   "\n        managed  %lu"
-		   "\n        cma      %lu",
+		   "\n        cma      %lu"
+		   "\n        start    %lu"
+		   "\n        end      %lu",
 		   zone_page_state(zone, NR_FREE_PAGES),
 		   zone->watermark_boost,
 		   min_wmark_pages(zone),
@@ -1701,7 +1706,9 @@ static void zoneinfo_show_print(struct seq_file *m, pg_data_t *pgdat,
 		   zone->spanned_pages,
 		   zone->present_pages,
 		   zone_managed_pages(zone),
-		   zone_cma_pages(zone));
+		   zone_cma_pages(zone),
+		   zone->zone_start_pfn,
+		   zone_end_pfn(zone));
 
 	seq_printf(m,
 		   "\n        protection: (%ld",
-- 
2.40.1


