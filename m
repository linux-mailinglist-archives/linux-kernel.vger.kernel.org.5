Return-Path: <linux-kernel+bounces-152020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 041818AB783
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 01:40:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BBFA1C20A2D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 23:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC45E13D895;
	Fri, 19 Apr 2024 23:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="e9L+opHz"
Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A475864D
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 23:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713570033; cv=none; b=lLgR+UwU4T0HsQKJ3QZKQbgQm12neSMKK+lW33qbcJA//NJpEV2KyyAavljZUEbMHDN2QCBjWTmQv922ugltaQfN3wyNp4hG/eLM5L913IF3y1jkCj20xaaGnR6aKXKk+fc6eVPH3eJj8ka4KLxSH2S7s3ZJEaE5YYx1dv8XwFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713570033; c=relaxed/simple;
	bh=Tg73AMGMwg9hynWe5cugQ+PiShS1k/TmrR8+OaN9Yto=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UZ0WeuahlonQE9RwlqyvOxjfRo/13g9J+NZDOfhDThuov9TtgC7JtJhVD0D3XPVoeRKGuQ4qWRnhNtwMhY/AV7yDohMOCDc5/LLcR78St9oW0e3mBKytch681JPd8cgZgRKCMTwL8rbxupFrYhk1UggyxFMvN8a86oWwoJuIL6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=e9L+opHz; arc=none smtp.client-ip=95.215.58.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1713570028;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=VhNe9L9WlP0pwfASSTxQQWmISeuCRlC00Foy7ie5Qdo=;
	b=e9L+opHzddbLtsvhZLWzIM2X5TCbhvAWPeYigIFpLpXDCZRzSqdbfgAAaw0mM4ZcnzB6tF
	Aw5JS+6JDBgK7z23OLl5DwkQK5VspGZGvLbrlrcFDfUydkTARYT2qSt8eqX23c3gSZz09Y
	8yS8Y1w7EhLW1yywzb9JN/i5akFe3UQ=
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] memcg: simple cleanup of stats update functions
Date: Fri, 19 Apr 2024 16:39:49 -0700
Message-ID: <20240419233949.2326100-1-shakeel.butt@linux.dev>
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
so simply make it static.

Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
---
 include/linux/memcontrol.h | 17 -----------------
 mm/memcontrol.c            | 15 +++++++--------
 mm/slab.h                  |  2 --
 3 files changed, 7 insertions(+), 27 deletions(-)

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
index 7703ced535a3..c6b08e6d7499 100644
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
@@ -2983,10 +2984,6 @@ void mem_cgroup_commit_charge(struct folio *folio, struct mem_cgroup *memcg)
 
 #ifdef CONFIG_MEMCG_KMEM
 
-/*
- * mod_objcg_mlstate() may be called with irq enabled, so
- * mod_memcg_lruvec_state() should be used.
- */
 static inline void mod_objcg_mlstate(struct obj_cgroup *objcg,
 				     struct pglist_data *pgdat,
 				     enum node_stat_item idx, int nr)
@@ -2994,10 +2991,12 @@ static inline void mod_objcg_mlstate(struct obj_cgroup *objcg,
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


