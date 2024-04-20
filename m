Return-Path: <linux-kernel+bounces-152392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ADC98ABDC5
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 01:25:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9359B28127C
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 23:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2FBC4CDE0;
	Sat, 20 Apr 2024 23:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UrIDxFRy"
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A6C205E35
	for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2024 23:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713655533; cv=none; b=gjwwuZd/Ml94pS2xY+Yepo39URuJx3vyL6DTBBRAbMfjkeQ0hBxZ5fabyl48ObIEhiFPFJeAa8Xws+xlPEOX4N1IZL0tiyVc76Vb1ZU8BUQOMHjEPjIltJ5g6J1a12VO7wUGVs7tZRFiujwrPx+vl7CfZiE20rsaGBM/oVaT3ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713655533; c=relaxed/simple;
	bh=TLhSsMbuwT2Yz/2MlPtFCCCHWs6N6gnMcwOfD6CpG8w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PPhqcvN+fm8P9FC1IFbE5F/1cJFYrTuVFQvPznLfBdN1BE84rbrPviFG1QSFNOPOwg/qAj6I22R/PeeerHq/1qAJH7UY/+VWd7i8eHLc9g15N+a3aKnw3MMMMYv60vMPh6l4QsO/eRKSyl/o74XOFALEqcQ0/MCiT5GfkSmP7Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UrIDxFRy; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1713655528;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9YG0Yr27rZjU0OlmRSCmu8viB0Ry44abch6JPf2G2gw=;
	b=UrIDxFRykQOLXhTrCXQVev4LjYc/8/H9kEh1rvTsseAeBhhlphYEqRsghwbXuveza5V3lH
	o+5T9aWRXHdAs6mJK1Bt/+nYlurFrKwr5iMKCEVxkueeO7U2zhFx6HlTUZNoC+STYR0heG
	JtP0UgIiBasmIEeChd/jHiEA6SZVpw0=
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] memcg: simple cleanup of stats update functions
Date: Sat, 20 Apr 2024 16:25:05 -0700
Message-ID: <20240420232505.2768428-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

mod_memcg_lruvec_state() is never called from outside of memcontrol.c
and with always irq disabled. So, replace it with the irq disabled
version and add an assert that irq is disabled in the caller.

Similarly mod_objcg_state() is not called from outside of memcontrol.c,
so simply make it static and change it's name to __mod_objcg_state().

Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
---

Change since v1:
- Change mod_objcg_state to __mod_objcg_state as per the naming
  convention (suggested by Johannes).

 include/linux/memcontrol.h | 17 -----------------
 mm/memcontrol.c            | 31 +++++++++++++++----------------
 mm/slab.h                  |  2 --
 3 files changed, 15 insertions(+), 35 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 8f332b4ae84c..9aba0d0462ca 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1077,8 +1077,6 @@ static inline unsigned long lruvec_page_state_local(struct lruvec *lruvec,
 void mem_cgroup_flush_stats(struct mem_cgroup *memcg);
 void mem_cgroup_flush_stats_ratelimited(struct mem_cgroup *memcg);
 
-void __mod_memcg_lruvec_state(struct lruvec *lruvec, enum node_stat_item idx,
-			      int val);
 void __mod_lruvec_kmem_state(void *p, enum node_stat_item idx, int val);
 
 static inline void mod_lruvec_kmem_state(void *p, enum node_stat_item idx,
@@ -1091,16 +1089,6 @@ static inline void mod_lruvec_kmem_state(void *p, enum node_stat_item idx,
 	local_irq_restore(flags);
 }
 
-static inline void mod_memcg_lruvec_state(struct lruvec *lruvec,
-					  enum node_stat_item idx, int val)
-{
-	unsigned long flags;
-
-	local_irq_save(flags);
-	__mod_memcg_lruvec_state(lruvec, idx, val);
-	local_irq_restore(flags);
-}
-
 void __count_memcg_events(struct mem_cgroup *memcg, enum vm_event_item idx,
 			  unsigned long count);
 
@@ -1594,11 +1582,6 @@ static inline void mem_cgroup_flush_stats_ratelimited(struct mem_cgroup *memcg)
 {
 }
 
-static inline void __mod_memcg_lruvec_state(struct lruvec *lruvec,
-					    enum node_stat_item idx, int val)
-{
-}
-
 static inline void __mod_lruvec_kmem_state(void *p, enum node_stat_item idx,
 					   int val)
 {
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 7703ced535a3..833d09c1d523 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -837,8 +837,9 @@ static unsigned long memcg_page_state_local(struct mem_cgroup *memcg, int idx)
 	return x;
 }
 
-void __mod_memcg_lruvec_state(struct lruvec *lruvec, enum node_stat_item idx,
-			      int val)
+static void __mod_memcg_lruvec_state(struct lruvec *lruvec,
+				     enum node_stat_item idx,
+				     int val)
 {
 	struct mem_cgroup_per_node *pn;
 	struct mem_cgroup *memcg;
@@ -2983,21 +2984,19 @@ void mem_cgroup_commit_charge(struct folio *folio, struct mem_cgroup *memcg)
 
 #ifdef CONFIG_MEMCG_KMEM
 
-/*
- * mod_objcg_mlstate() may be called with irq enabled, so
- * mod_memcg_lruvec_state() should be used.
- */
-static inline void mod_objcg_mlstate(struct obj_cgroup *objcg,
-				     struct pglist_data *pgdat,
-				     enum node_stat_item idx, int nr)
+static inline void __mod_objcg_mlstate(struct obj_cgroup *objcg,
+				       struct pglist_data *pgdat,
+				       enum node_stat_item idx, int nr)
 {
 	struct mem_cgroup *memcg;
 	struct lruvec *lruvec;
 
+	lockdep_assert_irqs_disabled();
+
 	rcu_read_lock();
 	memcg = obj_cgroup_memcg(objcg);
 	lruvec = mem_cgroup_lruvec(memcg, pgdat);
-	mod_memcg_lruvec_state(lruvec, idx, nr);
+	__mod_memcg_lruvec_state(lruvec, idx, nr);
 	rcu_read_unlock();
 }
 
@@ -3317,7 +3316,7 @@ void __memcg_kmem_uncharge_page(struct page *page, int order)
 	obj_cgroup_put(objcg);
 }
 
-void mod_objcg_state(struct obj_cgroup *objcg, struct pglist_data *pgdat,
+static void mod_objcg_state(struct obj_cgroup *objcg, struct pglist_data *pgdat,
 		     enum node_stat_item idx, int nr)
 {
 	struct memcg_stock_pcp *stock;
@@ -3345,12 +3344,12 @@ void mod_objcg_state(struct obj_cgroup *objcg, struct pglist_data *pgdat,
 		struct pglist_data *oldpg = stock->cached_pgdat;
 
 		if (stock->nr_slab_reclaimable_b) {
-			mod_objcg_mlstate(objcg, oldpg, NR_SLAB_RECLAIMABLE_B,
+			__mod_objcg_mlstate(objcg, oldpg, NR_SLAB_RECLAIMABLE_B,
 					  stock->nr_slab_reclaimable_b);
 			stock->nr_slab_reclaimable_b = 0;
 		}
 		if (stock->nr_slab_unreclaimable_b) {
-			mod_objcg_mlstate(objcg, oldpg, NR_SLAB_UNRECLAIMABLE_B,
+			__mod_objcg_mlstate(objcg, oldpg, NR_SLAB_UNRECLAIMABLE_B,
 					  stock->nr_slab_unreclaimable_b);
 			stock->nr_slab_unreclaimable_b = 0;
 		}
@@ -3376,7 +3375,7 @@ void mod_objcg_state(struct obj_cgroup *objcg, struct pglist_data *pgdat,
 		}
 	}
 	if (nr)
-		mod_objcg_mlstate(objcg, pgdat, idx, nr);
+		__mod_objcg_mlstate(objcg, pgdat, idx, nr);
 
 	local_unlock_irqrestore(&memcg_stock.stock_lock, flags);
 	obj_cgroup_put(old);
@@ -3442,13 +3441,13 @@ static struct obj_cgroup *drain_obj_stock(struct memcg_stock_pcp *stock)
 	 */
 	if (stock->nr_slab_reclaimable_b || stock->nr_slab_unreclaimable_b) {
 		if (stock->nr_slab_reclaimable_b) {
-			mod_objcg_mlstate(old, stock->cached_pgdat,
+			__mod_objcg_mlstate(old, stock->cached_pgdat,
 					  NR_SLAB_RECLAIMABLE_B,
 					  stock->nr_slab_reclaimable_b);
 			stock->nr_slab_reclaimable_b = 0;
 		}
 		if (stock->nr_slab_unreclaimable_b) {
-			mod_objcg_mlstate(old, stock->cached_pgdat,
+			__mod_objcg_mlstate(old, stock->cached_pgdat,
 					  NR_SLAB_UNRECLAIMABLE_B,
 					  stock->nr_slab_unreclaimable_b);
 			stock->nr_slab_unreclaimable_b = 0;
diff --git a/mm/slab.h b/mm/slab.h
index e32d9cf1077a..5f8f47c5bee0 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -578,8 +578,6 @@ bool __memcg_slab_post_alloc_hook(struct kmem_cache *s, struct list_lru *lru,
 				  gfp_t flags, size_t size, void **p);
 void __memcg_slab_free_hook(struct kmem_cache *s, struct slab *slab,
 			    void **p, int objects, struct slabobj_ext *obj_exts);
-void mod_objcg_state(struct obj_cgroup *objcg, struct pglist_data *pgdat,
-		     enum node_stat_item idx, int nr);
 #endif
 
 size_t __ksize(const void *objp);
-- 
2.43.0


