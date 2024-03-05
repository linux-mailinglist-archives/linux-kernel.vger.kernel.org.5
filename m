Return-Path: <linux-kernel+bounces-91850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 008ED871774
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 08:55:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F1971F22A0D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 07:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A40DD8062E;
	Tue,  5 Mar 2024 07:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pcO7Xmma"
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D8278062A
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 07:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709625249; cv=none; b=G3psVxU7bsRlN7eGPfRUqy4tV9PjCfIDrEwuZ5znySwtJnbJu8YyZrh5dFJd0HMtpP4UGGZZch2ZbslR2oKoCPLIfg7IN/2YrL2AVzI6Vi/W88h2AZ0HKiByQuvHy+4XXHLRX/yWcmIBK3UBOy2SpFONlwnkra/ZAYZEOxnd0Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709625249; c=relaxed/simple;
	bh=y4KP0Z/wmn1brf+U8MSu6siWXYTGKFuzFs/M8GtvysQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oncISpsFyMxxbNqgumcnTDtUvsvzsOtpKrQB62+UM1ipSF+U/YS4sJwcik+8OzSRP10j+13KM2WnYkJnhRrnM+pfJh+7PWLjCw2cRvZO3/cS3YSZb+PGsWfXDOMZeBgcOPiKWDj9qwvYxJB9/pSmZFwrs6rcqs4NLBmc2fZb/Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pcO7Xmma; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1709625245;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GxATmqBlQcF/EJ5kBIVDHEOYeOEx3YPhEio6KYFOETw=;
	b=pcO7Xmma3GJNF/hFdo7RBa5GCJ8H183eLyC3T6gsdNlu++hf86a5nM9x5lQcXNXYgrJzVX
	hpV4BMBelKWyUVGGJaSp6Wwo+FBzoi+eiFPFfFALKb4R8miHOZVH0AYN1D6CDweLmjTK66
	uJ81eKBGR0I1JUkt5cMX1eTNNsjIftE=
From: Chengming Zhou <chengming.zhou@linux.dev>
To: akpm@linux-foundation.org
Cc: hannes@cmpxchg.org,
	yosryahmed@google.com,
	nphamcs@gmail.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Chengming Zhou <chengming.zhou@linux.dev>,
	kernel test robot <oliver.sang@intel.com>
Subject: [PATCH mm-unstable] mm/zswap: global lru and shrinker shared by all zswap_pools fix
Date: Tue,  5 Mar 2024 07:53:45 +0000
Message-Id: <20240305075345.1493214-1-chengming.zhou@linux.dev>
In-Reply-To: <20240210-zswap-global-lru-v3-1-200495333595@bytedance.com>
References: <20240210-zswap-global-lru-v3-1-200495333595@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The commit bf9b7df23cb3 ("mm/zswap: global lru and shrinker shared by
all zswap_pools") introduced a new lock to protect zswap_next_shrink,
instead of reusing zswap_pools_lock.

But the problem is that it's initialized only when zswap enabled,
which causes bug if zswap_memcg_offline_cleanup() called without
zswap enabled.

Fix it by using DEFINE_SPINLOCK() to statically initialize them
and define them as multiple static variables to keep in consistent
with the existing global variables in zswap.

Fixes: bf9b7df23cb3 ("mm/zswap: global lru and shrinker shared by all zswap_pools")
Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202403051008.a8cf8a94-lkp@intel.com
Signed-off-by: Chengming Zhou <chengming.zhou@linux.dev>
---
 mm/zswap.c | 77 +++++++++++++++++++++++++++---------------------------
 1 file changed, 38 insertions(+), 39 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index da90933c6d20..9a3237752082 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -180,15 +180,16 @@ struct zswap_pool {
 	char tfm_name[CRYPTO_MAX_ALG_NAME];
 };
 
-static struct {
-	struct list_lru list_lru;
-	atomic_t nr_stored;
-	struct shrinker *shrinker;
-	struct work_struct shrink_work;
-	struct mem_cgroup *next_shrink;
-	/* The lock protects next_shrink. */
-	spinlock_t shrink_lock;
-} zswap;
+/* Global LRU lists shared by all zswap pools. */
+static struct list_lru zswap_list_lru;
+/* counter of pages stored in all zswap pools. */
+static atomic_t zswap_nr_stored = ATOMIC_INIT(0);
+
+/* The lock protects zswap_next_shrink updates. */
+static DEFINE_SPINLOCK(zswap_shrink_lock);
+static struct mem_cgroup *zswap_next_shrink;
+static struct work_struct zswap_shrink_work;
+static struct shrinker *zswap_shrinker;
 
 /*
  * struct zswap_entry
@@ -798,10 +799,10 @@ void zswap_folio_swapin(struct folio *folio)
 void zswap_memcg_offline_cleanup(struct mem_cgroup *memcg)
 {
 	/* lock out zswap shrinker walking memcg tree */
-	spin_lock(&zswap.shrink_lock);
-	if (zswap.next_shrink == memcg)
-		zswap.next_shrink = mem_cgroup_iter(NULL, zswap.next_shrink, NULL);
-	spin_unlock(&zswap.shrink_lock);
+	spin_lock(&zswap_shrink_lock);
+	if (zswap_next_shrink == memcg)
+		zswap_next_shrink = mem_cgroup_iter(NULL, zswap_next_shrink, NULL);
+	spin_unlock(&zswap_shrink_lock);
 }
 
 /*********************************
@@ -900,9 +901,9 @@ static void zswap_entry_free(struct zswap_entry *entry)
 	if (!entry->length)
 		atomic_dec(&zswap_same_filled_pages);
 	else {
-		zswap_lru_del(&zswap.list_lru, entry);
+		zswap_lru_del(&zswap_list_lru, entry);
 		zpool_free(zswap_find_zpool(entry), entry->handle);
-		atomic_dec(&zswap.nr_stored);
+		atomic_dec(&zswap_nr_stored);
 		zswap_pool_put(entry->pool);
 	}
 	if (entry->objcg) {
@@ -1274,7 +1275,7 @@ static unsigned long zswap_shrinker_scan(struct shrinker *shrinker,
 
 	nr_protected =
 		atomic_long_read(&lruvec->zswap_lruvec_state.nr_zswap_protected);
-	lru_size = list_lru_shrink_count(&zswap.list_lru, sc);
+	lru_size = list_lru_shrink_count(&zswap_list_lru, sc);
 
 	/*
 	 * Abort if we are shrinking into the protected region.
@@ -1291,7 +1292,7 @@ static unsigned long zswap_shrinker_scan(struct shrinker *shrinker,
 		return SHRINK_STOP;
 	}
 
-	shrink_ret = list_lru_shrink_walk(&zswap.list_lru, sc, &shrink_memcg_cb,
+	shrink_ret = list_lru_shrink_walk(&zswap_list_lru, sc, &shrink_memcg_cb,
 		&encountered_page_in_swapcache);
 
 	if (encountered_page_in_swapcache)
@@ -1317,7 +1318,7 @@ static unsigned long zswap_shrinker_count(struct shrinker *shrinker,
 #else
 	/* use pool stats instead of memcg stats */
 	nr_backing = zswap_pool_total_size >> PAGE_SHIFT;
-	nr_stored = atomic_read(&zswap.nr_stored);
+	nr_stored = atomic_read(&zswap_nr_stored);
 #endif
 
 	if (!nr_stored)
@@ -1325,7 +1326,7 @@ static unsigned long zswap_shrinker_count(struct shrinker *shrinker,
 
 	nr_protected =
 		atomic_long_read(&lruvec->zswap_lruvec_state.nr_zswap_protected);
-	nr_freeable = list_lru_shrink_count(&zswap.list_lru, sc);
+	nr_freeable = list_lru_shrink_count(&zswap_list_lru, sc);
 	/*
 	 * Subtract the lru size by an estimate of the number of pages
 	 * that should be protected.
@@ -1374,7 +1375,7 @@ static int shrink_memcg(struct mem_cgroup *memcg)
 	for_each_node_state(nid, N_NORMAL_MEMORY) {
 		unsigned long nr_to_walk = 1;
 
-		shrunk += list_lru_walk_one(&zswap.list_lru, nid, memcg,
+		shrunk += list_lru_walk_one(&zswap_list_lru, nid, memcg,
 					    &shrink_memcg_cb, NULL, &nr_to_walk);
 	}
 	return shrunk ? 0 : -EAGAIN;
@@ -1387,9 +1388,9 @@ static void shrink_worker(struct work_struct *w)
 
 	/* global reclaim will select cgroup in a round-robin fashion. */
 	do {
-		spin_lock(&zswap.shrink_lock);
-		zswap.next_shrink = mem_cgroup_iter(NULL, zswap.next_shrink, NULL);
-		memcg = zswap.next_shrink;
+		spin_lock(&zswap_shrink_lock);
+		zswap_next_shrink = mem_cgroup_iter(NULL, zswap_next_shrink, NULL);
+		memcg = zswap_next_shrink;
 
 		/*
 		 * We need to retry if we have gone through a full round trip, or if we
@@ -1403,7 +1404,7 @@ static void shrink_worker(struct work_struct *w)
 		 * memcg is not killed when we are reclaiming.
 		 */
 		if (!memcg) {
-			spin_unlock(&zswap.shrink_lock);
+			spin_unlock(&zswap_shrink_lock);
 			if (++failures == MAX_RECLAIM_RETRIES)
 				break;
 
@@ -1413,15 +1414,15 @@ static void shrink_worker(struct work_struct *w)
 		if (!mem_cgroup_tryget_online(memcg)) {
 			/* drop the reference from mem_cgroup_iter() */
 			mem_cgroup_iter_break(NULL, memcg);
-			zswap.next_shrink = NULL;
-			spin_unlock(&zswap.shrink_lock);
+			zswap_next_shrink = NULL;
+			spin_unlock(&zswap_shrink_lock);
 
 			if (++failures == MAX_RECLAIM_RETRIES)
 				break;
 
 			goto resched;
 		}
-		spin_unlock(&zswap.shrink_lock);
+		spin_unlock(&zswap_shrink_lock);
 
 		ret = shrink_memcg(memcg);
 		/* drop the extra reference */
@@ -1542,7 +1543,7 @@ bool zswap_store(struct folio *folio)
 
 	if (objcg) {
 		memcg = get_mem_cgroup_from_objcg(objcg);
-		if (memcg_list_lru_alloc(memcg, &zswap.list_lru, GFP_KERNEL)) {
+		if (memcg_list_lru_alloc(memcg, &zswap_list_lru, GFP_KERNEL)) {
 			mem_cgroup_put(memcg);
 			goto put_pool;
 		}
@@ -1573,8 +1574,8 @@ bool zswap_store(struct folio *folio)
 	}
 	if (entry->length) {
 		INIT_LIST_HEAD(&entry->lru);
-		zswap_lru_add(&zswap.list_lru, entry);
-		atomic_inc(&zswap.nr_stored);
+		zswap_lru_add(&zswap_list_lru, entry);
+		atomic_inc(&zswap_nr_stored);
 	}
 	spin_unlock(&tree->lock);
 
@@ -1606,7 +1607,7 @@ bool zswap_store(struct folio *folio)
 	return false;
 
 shrink:
-	queue_work(shrink_wq, &zswap.shrink_work);
+	queue_work(shrink_wq, &zswap_shrink_work);
 	goto reject;
 }
 
@@ -1773,16 +1774,14 @@ static int zswap_setup(void)
 	if (!shrink_wq)
 		goto shrink_wq_fail;
 
-	zswap.shrinker = zswap_alloc_shrinker();
-	if (!zswap.shrinker)
+	zswap_shrinker = zswap_alloc_shrinker();
+	if (!zswap_shrinker)
 		goto shrinker_fail;
-	if (list_lru_init_memcg(&zswap.list_lru, zswap.shrinker))
+	if (list_lru_init_memcg(&zswap_list_lru, zswap_shrinker))
 		goto lru_fail;
-	shrinker_register(zswap.shrinker);
+	shrinker_register(zswap_shrinker);
 
-	INIT_WORK(&zswap.shrink_work, shrink_worker);
-	atomic_set(&zswap.nr_stored, 0);
-	spin_lock_init(&zswap.shrink_lock);
+	INIT_WORK(&zswap_shrink_work, shrink_worker);
 
 	pool = __zswap_pool_create_fallback();
 	if (pool) {
@@ -1801,7 +1800,7 @@ static int zswap_setup(void)
 	return 0;
 
 lru_fail:
-	shrinker_free(zswap.shrinker);
+	shrinker_free(zswap_shrinker);
 shrinker_fail:
 	destroy_workqueue(shrink_wq);
 shrink_wq_fail:
-- 
2.40.1


