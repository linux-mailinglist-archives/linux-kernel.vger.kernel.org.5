Return-Path: <linux-kernel+bounces-68281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 265DF857820
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 09:56:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68AD21F22004
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 08:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B34D1B80B;
	Fri, 16 Feb 2024 08:55:40 +0000 (UTC)
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BCE618EAB
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 08:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708073739; cv=none; b=Mbn+aCTqbxFUR1eZYBkQX/0UOgkUSRxo8dyN1UjOQKuLJPfMUJx2KXbVM2bzSEzKeVmES5mkNkbxUL9i+gROTe+3MVGcCpVdqlAVCJginbq0e9hXILyX7u2aB21Is27lMTD3UUB6XfiEPh7veVIPziv3KyM3MmK0HQ5lW6z4a/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708073739; c=relaxed/simple;
	bh=JAj4Xac8uGXPN3EzqaHkO89Xd3rHIOHENtdFIDNrYdo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Gri0W66qLyu+NlCVqOEPpvs7Dn0MIGdRiSo0uSLlXFVFC2nz9zQ3BBSHfW0EcZdltNWz2HvF5oLmuZLmi309Xl+Qvpzbo/AmN1oJXjO2WrZbqHMuP3gsOHB2zL+yujEB0uYIdpp0CQNkmGfZ1xiSCRY3CGTy+SCVO7WEy1pLsDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=linux.dev; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <zhouchengming@bytedance.com>
Date: Fri, 16 Feb 2024 08:55:04 +0000
Subject: [PATCH v3 1/2] mm/zswap: global lru and shrinker shared by all zswap_pools
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240210-zswap-global-lru-v3-1-200495333595@bytedance.com>
References: <20240210-zswap-global-lru-v3-0-200495333595@bytedance.com>
In-Reply-To: <20240210-zswap-global-lru-v3-0-200495333595@bytedance.com>
To: Johannes Weiner <hannes@cmpxchg.org>, Yosry Ahmed <yosryahmed@google.com>, Nhat Pham <nphamcs@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, Yosry Ahmed <yosryahmed@google.com>, linux-kernel@vger.kernel.org,
 Chengming Zhou <zhouchengming@bytedance.com>
X-Migadu-Flow: FLOW_OUT

Dynamic zswap_pool creation may create/reuse to have multiple
zswap_pools in a list, only the first will be current used.

Each zswap_pool has its own lru and shrinker, which is not
necessary and has its problem:

1. When memory has pressure, all shrinker of zswap_pools will
   try to shrink its own lru, there is no order between them.

2. When zswap limit hit, only the last zswap_pool's shrink_work
   will try to shrink its lru list. The rationale here was to
   try and empty the old pool first so that we can completely
   drop it. However, since we only support exclusive loads now,
   the LRU ordering should be entirely decided by the order of
   stores, so the oldest entries on the LRU will naturally be
   from the oldest pool.

Anyway, having a global lru and shrinker shared by all zswap_pools
is better and efficient.

Acked-by: Yosry Ahmed <yosryahmed@google.com>
Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 mm/zswap.c | 171 ++++++++++++++++++++++++-------------------------------------
 1 file changed, 66 insertions(+), 105 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index 62fe307521c9..d275eb523fc4 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -176,14 +176,19 @@ struct zswap_pool {
 	struct kref kref;
 	struct list_head list;
 	struct work_struct release_work;
-	struct work_struct shrink_work;
 	struct hlist_node node;
 	char tfm_name[CRYPTO_MAX_ALG_NAME];
+};
+
+static struct {
 	struct list_lru list_lru;
-	struct mem_cgroup *next_shrink;
-	struct shrinker *shrinker;
 	atomic_t nr_stored;
-};
+	struct shrinker *shrinker;
+	struct work_struct shrink_work;
+	struct mem_cgroup *next_shrink;
+	/* The lock protects next_shrink. */
+	spinlock_t shrink_lock;
+} zswap;
 
 /*
  * struct zswap_entry
@@ -301,9 +306,6 @@ static void zswap_update_total_size(void)
 * pool functions
 **********************************/
 
-static void zswap_alloc_shrinker(struct zswap_pool *pool);
-static void shrink_worker(struct work_struct *w);
-
 static struct zswap_pool *zswap_pool_create(char *type, char *compressor)
 {
 	int i;
@@ -353,30 +355,16 @@ static struct zswap_pool *zswap_pool_create(char *type, char *compressor)
 	if (ret)
 		goto error;
 
-	zswap_alloc_shrinker(pool);
-	if (!pool->shrinker)
-		goto error;
-
-	pr_debug("using %s compressor\n", pool->tfm_name);
-
 	/* being the current pool takes 1 ref; this func expects the
 	 * caller to always add the new pool as the current pool
 	 */
 	kref_init(&pool->kref);
 	INIT_LIST_HEAD(&pool->list);
-	if (list_lru_init_memcg(&pool->list_lru, pool->shrinker))
-		goto lru_fail;
-	shrinker_register(pool->shrinker);
-	INIT_WORK(&pool->shrink_work, shrink_worker);
-	atomic_set(&pool->nr_stored, 0);
 
 	zswap_pool_debug("created", pool);
 
 	return pool;
 
-lru_fail:
-	list_lru_destroy(&pool->list_lru);
-	shrinker_free(pool->shrinker);
 error:
 	if (pool->acomp_ctx)
 		free_percpu(pool->acomp_ctx);
@@ -434,15 +422,8 @@ static void zswap_pool_destroy(struct zswap_pool *pool)
 
 	zswap_pool_debug("destroying", pool);
 
-	shrinker_free(pool->shrinker);
 	cpuhp_state_remove_instance(CPUHP_MM_ZSWP_POOL_PREPARE, &pool->node);
 	free_percpu(pool->acomp_ctx);
-	list_lru_destroy(&pool->list_lru);
-
-	spin_lock(&zswap_pools_lock);
-	mem_cgroup_iter_break(NULL, pool->next_shrink);
-	pool->next_shrink = NULL;
-	spin_unlock(&zswap_pools_lock);
 
 	for (i = 0; i < ZSWAP_NR_ZPOOLS; i++)
 		zpool_destroy_pool(pool->zpools[i]);
@@ -529,24 +510,6 @@ static struct zswap_pool *zswap_pool_current_get(void)
 	return pool;
 }
 
-static struct zswap_pool *zswap_pool_last_get(void)
-{
-	struct zswap_pool *pool, *last = NULL;
-
-	rcu_read_lock();
-
-	list_for_each_entry_rcu(pool, &zswap_pools, list)
-		last = pool;
-	WARN_ONCE(!last && zswap_has_pool,
-		  "%s: no page storage pool!\n", __func__);
-	if (!zswap_pool_get(last))
-		last = NULL;
-
-	rcu_read_unlock();
-
-	return last;
-}
-
 /* type and compressor must be null-terminated */
 static struct zswap_pool *zswap_pool_find_get(char *type, char *compressor)
 {
@@ -816,15 +779,11 @@ void zswap_folio_swapin(struct folio *folio)
 
 void zswap_memcg_offline_cleanup(struct mem_cgroup *memcg)
 {
-	struct zswap_pool *pool;
-
-	/* lock out zswap pools list modification */
-	spin_lock(&zswap_pools_lock);
-	list_for_each_entry(pool, &zswap_pools, list) {
-		if (pool->next_shrink == memcg)
-			pool->next_shrink = mem_cgroup_iter(NULL, pool->next_shrink, NULL);
-	}
-	spin_unlock(&zswap_pools_lock);
+	/* lock out zswap shrinker walking memcg tree */
+	spin_lock(&zswap.shrink_lock);
+	if (zswap.next_shrink == memcg)
+		zswap.next_shrink = mem_cgroup_iter(NULL, zswap.next_shrink, NULL);
+	spin_unlock(&zswap.shrink_lock);
 }
 
 /*********************************
@@ -923,9 +882,9 @@ static void zswap_entry_free(struct zswap_entry *entry)
 	if (!entry->length)
 		atomic_dec(&zswap_same_filled_pages);
 	else {
-		zswap_lru_del(&entry->pool->list_lru, entry);
+		zswap_lru_del(&zswap.list_lru, entry);
 		zpool_free(zswap_find_zpool(entry), entry->handle);
-		atomic_dec(&entry->pool->nr_stored);
+		atomic_dec(&zswap.nr_stored);
 		zswap_pool_put(entry->pool);
 	}
 	if (entry->objcg) {
@@ -1288,7 +1247,6 @@ static unsigned long zswap_shrinker_scan(struct shrinker *shrinker,
 {
 	struct lruvec *lruvec = mem_cgroup_lruvec(sc->memcg, NODE_DATA(sc->nid));
 	unsigned long shrink_ret, nr_protected, lru_size;
-	struct zswap_pool *pool = shrinker->private_data;
 	bool encountered_page_in_swapcache = false;
 
 	if (!zswap_shrinker_enabled ||
@@ -1299,7 +1257,7 @@ static unsigned long zswap_shrinker_scan(struct shrinker *shrinker,
 
 	nr_protected =
 		atomic_long_read(&lruvec->zswap_lruvec_state.nr_zswap_protected);
-	lru_size = list_lru_shrink_count(&pool->list_lru, sc);
+	lru_size = list_lru_shrink_count(&zswap.list_lru, sc);
 
 	/*
 	 * Abort if we are shrinking into the protected region.
@@ -1316,7 +1274,7 @@ static unsigned long zswap_shrinker_scan(struct shrinker *shrinker,
 		return SHRINK_STOP;
 	}
 
-	shrink_ret = list_lru_shrink_walk(&pool->list_lru, sc, &shrink_memcg_cb,
+	shrink_ret = list_lru_shrink_walk(&zswap.list_lru, sc, &shrink_memcg_cb,
 		&encountered_page_in_swapcache);
 
 	if (encountered_page_in_swapcache)
@@ -1328,7 +1286,6 @@ static unsigned long zswap_shrinker_scan(struct shrinker *shrinker,
 static unsigned long zswap_shrinker_count(struct shrinker *shrinker,
 		struct shrink_control *sc)
 {
-	struct zswap_pool *pool = shrinker->private_data;
 	struct mem_cgroup *memcg = sc->memcg;
 	struct lruvec *lruvec = mem_cgroup_lruvec(memcg, NODE_DATA(sc->nid));
 	unsigned long nr_backing, nr_stored, nr_freeable, nr_protected;
@@ -1342,8 +1299,8 @@ static unsigned long zswap_shrinker_count(struct shrinker *shrinker,
 	nr_stored = memcg_page_state(memcg, MEMCG_ZSWAPPED);
 #else
 	/* use pool stats instead of memcg stats */
-	nr_backing = get_zswap_pool_size(pool) >> PAGE_SHIFT;
-	nr_stored = atomic_read(&pool->nr_stored);
+	nr_backing = zswap_pool_total_size >> PAGE_SHIFT;
+	nr_stored = atomic_read(&zswap.nr_stored);
 #endif
 
 	if (!nr_stored)
@@ -1351,7 +1308,7 @@ static unsigned long zswap_shrinker_count(struct shrinker *shrinker,
 
 	nr_protected =
 		atomic_long_read(&lruvec->zswap_lruvec_state.nr_zswap_protected);
-	nr_freeable = list_lru_shrink_count(&pool->list_lru, sc);
+	nr_freeable = list_lru_shrink_count(&zswap.list_lru, sc);
 	/*
 	 * Subtract the lru size by an estimate of the number of pages
 	 * that should be protected.
@@ -1367,23 +1324,24 @@ static unsigned long zswap_shrinker_count(struct shrinker *shrinker,
 	return mult_frac(nr_freeable, nr_backing, nr_stored);
 }
 
-static void zswap_alloc_shrinker(struct zswap_pool *pool)
+static struct shrinker *zswap_alloc_shrinker(void)
 {
-	pool->shrinker =
+	struct shrinker *shrinker;
+
+	shrinker =
 		shrinker_alloc(SHRINKER_NUMA_AWARE | SHRINKER_MEMCG_AWARE, "mm-zswap");
-	if (!pool->shrinker)
-		return;
+	if (!shrinker)
+		return NULL;
 
-	pool->shrinker->private_data = pool;
-	pool->shrinker->scan_objects = zswap_shrinker_scan;
-	pool->shrinker->count_objects = zswap_shrinker_count;
-	pool->shrinker->batch = 0;
-	pool->shrinker->seeks = DEFAULT_SEEKS;
+	shrinker->scan_objects = zswap_shrinker_scan;
+	shrinker->count_objects = zswap_shrinker_count;
+	shrinker->batch = 0;
+	shrinker->seeks = DEFAULT_SEEKS;
+	return shrinker;
 }
 
 static int shrink_memcg(struct mem_cgroup *memcg)
 {
-	struct zswap_pool *pool;
 	int nid, shrunk = 0;
 
 	if (!mem_cgroup_zswap_writeback_enabled(memcg))
@@ -1396,32 +1354,25 @@ static int shrink_memcg(struct mem_cgroup *memcg)
 	if (memcg && !mem_cgroup_online(memcg))
 		return -ENOENT;
 
-	pool = zswap_pool_current_get();
-	if (!pool)
-		return -EINVAL;
-
 	for_each_node_state(nid, N_NORMAL_MEMORY) {
 		unsigned long nr_to_walk = 1;
 
-		shrunk += list_lru_walk_one(&pool->list_lru, nid, memcg,
+		shrunk += list_lru_walk_one(&zswap.list_lru, nid, memcg,
 					    &shrink_memcg_cb, NULL, &nr_to_walk);
 	}
-	zswap_pool_put(pool);
 	return shrunk ? 0 : -EAGAIN;
 }
 
 static void shrink_worker(struct work_struct *w)
 {
-	struct zswap_pool *pool = container_of(w, typeof(*pool),
-						shrink_work);
 	struct mem_cgroup *memcg;
 	int ret, failures = 0;
 
 	/* global reclaim will select cgroup in a round-robin fashion. */
 	do {
-		spin_lock(&zswap_pools_lock);
-		pool->next_shrink = mem_cgroup_iter(NULL, pool->next_shrink, NULL);
-		memcg = pool->next_shrink;
+		spin_lock(&zswap.shrink_lock);
+		zswap.next_shrink = mem_cgroup_iter(NULL, zswap.next_shrink, NULL);
+		memcg = zswap.next_shrink;
 
 		/*
 		 * We need to retry if we have gone through a full round trip, or if we
@@ -1435,7 +1386,7 @@ static void shrink_worker(struct work_struct *w)
 		 * memcg is not killed when we are reclaiming.
 		 */
 		if (!memcg) {
-			spin_unlock(&zswap_pools_lock);
+			spin_unlock(&zswap.shrink_lock);
 			if (++failures == MAX_RECLAIM_RETRIES)
 				break;
 
@@ -1445,15 +1396,15 @@ static void shrink_worker(struct work_struct *w)
 		if (!mem_cgroup_tryget_online(memcg)) {
 			/* drop the reference from mem_cgroup_iter() */
 			mem_cgroup_iter_break(NULL, memcg);
-			pool->next_shrink = NULL;
-			spin_unlock(&zswap_pools_lock);
+			zswap.next_shrink = NULL;
+			spin_unlock(&zswap.shrink_lock);
 
 			if (++failures == MAX_RECLAIM_RETRIES)
 				break;
 
 			goto resched;
 		}
-		spin_unlock(&zswap_pools_lock);
+		spin_unlock(&zswap.shrink_lock);
 
 		ret = shrink_memcg(memcg);
 		/* drop the extra reference */
@@ -1467,7 +1418,6 @@ static void shrink_worker(struct work_struct *w)
 resched:
 		cond_resched();
 	} while (!zswap_can_accept());
-	zswap_pool_put(pool);
 }
 
 static int zswap_is_page_same_filled(void *ptr, unsigned long *value)
@@ -1508,7 +1458,6 @@ bool zswap_store(struct folio *folio)
 	struct zswap_entry *entry, *dupentry;
 	struct obj_cgroup *objcg = NULL;
 	struct mem_cgroup *memcg = NULL;
-	struct zswap_pool *shrink_pool;
 
 	VM_WARN_ON_ONCE(!folio_test_locked(folio));
 	VM_WARN_ON_ONCE(!folio_test_swapcache(folio));
@@ -1576,7 +1525,7 @@ bool zswap_store(struct folio *folio)
 
 	if (objcg) {
 		memcg = get_mem_cgroup_from_objcg(objcg);
-		if (memcg_list_lru_alloc(memcg, &entry->pool->list_lru, GFP_KERNEL)) {
+		if (memcg_list_lru_alloc(memcg, &zswap.list_lru, GFP_KERNEL)) {
 			mem_cgroup_put(memcg);
 			goto put_pool;
 		}
@@ -1607,8 +1556,8 @@ bool zswap_store(struct folio *folio)
 	}
 	if (entry->length) {
 		INIT_LIST_HEAD(&entry->lru);
-		zswap_lru_add(&entry->pool->list_lru, entry);
-		atomic_inc(&entry->pool->nr_stored);
+		zswap_lru_add(&zswap.list_lru, entry);
+		atomic_inc(&zswap.nr_stored);
 	}
 	spin_unlock(&tree->lock);
 
@@ -1640,9 +1589,7 @@ bool zswap_store(struct folio *folio)
 	return false;
 
 shrink:
-	shrink_pool = zswap_pool_last_get();
-	if (shrink_pool && !queue_work(shrink_wq, &shrink_pool->shrink_work))
-		zswap_pool_put(shrink_pool);
+	queue_work(shrink_wq, &zswap.shrink_work);
 	goto reject;
 }
 
@@ -1804,6 +1751,22 @@ static int zswap_setup(void)
 	if (ret)
 		goto hp_fail;
 
+	shrink_wq = alloc_workqueue("zswap-shrink",
+			WQ_UNBOUND|WQ_MEM_RECLAIM, 1);
+	if (!shrink_wq)
+		goto shrink_wq_fail;
+
+	zswap.shrinker = zswap_alloc_shrinker();
+	if (!zswap.shrinker)
+		goto shrinker_fail;
+	if (list_lru_init_memcg(&zswap.list_lru, zswap.shrinker))
+		goto lru_fail;
+	shrinker_register(zswap.shrinker);
+
+	INIT_WORK(&zswap.shrink_work, shrink_worker);
+	atomic_set(&zswap.nr_stored, 0);
+	spin_lock_init(&zswap.shrink_lock);
+
 	pool = __zswap_pool_create_fallback();
 	if (pool) {
 		pr_info("loaded using pool %s/%s\n", pool->tfm_name,
@@ -1815,19 +1778,17 @@ static int zswap_setup(void)
 		zswap_enabled = false;
 	}
 
-	shrink_wq = alloc_workqueue("zswap-shrink",
-			WQ_UNBOUND|WQ_MEM_RECLAIM, 1);
-	if (!shrink_wq)
-		goto fallback_fail;
-
 	if (zswap_debugfs_init())
 		pr_warn("debugfs initialization failed\n");
 	zswap_init_state = ZSWAP_INIT_SUCCEED;
 	return 0;
 
-fallback_fail:
-	if (pool)
-		zswap_pool_destroy(pool);
+lru_fail:
+	shrinker_free(zswap.shrinker);
+shrinker_fail:
+	destroy_workqueue(shrink_wq);
+shrink_wq_fail:
+	cpuhp_remove_multi_state(CPUHP_MM_ZSWP_POOL_PREPARE);
 hp_fail:
 	kmem_cache_destroy(zswap_entry_cache);
 cache_fail:

-- 
b4 0.10.1

