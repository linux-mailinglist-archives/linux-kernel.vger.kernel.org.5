Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67F9B7E9CA0
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 14:00:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231162AbjKMNAx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 08:00:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbjKMNAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 08:00:43 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC0E2171A;
        Mon, 13 Nov 2023 05:00:35 -0800 (PST)
Received: from dggpemm500005.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4STV026PRSzvQQN;
        Mon, 13 Nov 2023 21:00:18 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 dggpemm500005.china.huawei.com (7.185.36.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 13 Nov 2023 21:00:33 +0800
From:   Yunsheng Lin <linyunsheng@huawei.com>
To:     <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Mina Almasry <almasrymina@google.com>,
        Yunsheng Lin <linyunsheng@huawei.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Eric Dumazet <edumazet@google.com>
Subject: [PATCH RFC 2/8] net: page_pool: create hooks for custom page providers
Date:   Mon, 13 Nov 2023 21:00:34 +0800
Message-ID: <20231113130041.58124-3-linyunsheng@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20231113130041.58124-1-linyunsheng@huawei.com>
References: <20231113130041.58124-1-linyunsheng@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jakub Kicinski <kuba@kernel.org>

The page providers which try to reuse the same pages will
need to hold onto the ref, even if page gets released from
the pool - as in releasing the page from the pp just transfers
the "ownership" reference from pp to the provider, and provider
will wait for other references to be gone before feeding this
page back into the pool.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Mina Almasry <almasrymina@google.com>
Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
---
 include/net/page_pool/types.h | 19 ++++++++
 net/core/page_pool.c          | 81 +++++++++++++++++++++++++++++------
 2 files changed, 87 insertions(+), 13 deletions(-)

diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.h
index 6fc5134095ed..5e4fcd45ba50 100644
--- a/include/net/page_pool/types.h
+++ b/include/net/page_pool/types.h
@@ -60,6 +60,8 @@ struct page_pool_params {
 	int		nid;
 	struct device	*dev;
 	struct napi_struct *napi;
+	u8		memory_provider;
+	void            *mp_priv;
 	enum dma_data_direction dma_dir;
 	unsigned int	max_len;
 	unsigned int	offset;
@@ -118,6 +120,20 @@ struct page_pool_stats {
 };
 #endif
 
+struct mem_provider;
+
+enum pp_memory_provider_type {
+	__PP_MP_NONE, /* Use system allocator directly */
+};
+
+struct pp_memory_provider_ops {
+	int (*init)(struct page_pool *pool);
+	void (*destroy)(struct page_pool *pool);
+	struct page *(*alloc_pages)(struct page_pool *pool, gfp_t gfp);
+	void (*release_page)(struct page_pool *pool, struct page *page);
+	void (*free_pages)(struct page_pool *pool, struct page *page);
+};
+
 struct page_pool {
 	struct page_pool_params p;
 
@@ -165,6 +181,9 @@ struct page_pool {
 	 */
 	struct ptr_ring ring;
 
+	const struct pp_memory_provider_ops *mp_ops;
+	void *mp_priv;
+
 #ifdef CONFIG_PAGE_POOL_STATS
 	/* recycle stats are per-cpu to avoid locking */
 	struct page_pool_recycle_stats __percpu *recycle_stats;
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 578b6f2eeb46..6c502bea842b 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -23,6 +23,8 @@
 
 #include <trace/events/page_pool.h>
 
+static DEFINE_STATIC_KEY_FALSE(page_pool_mem_providers);
+
 #define DEFER_TIME (msecs_to_jiffies(1000))
 #define DEFER_WARN_INTERVAL (60 * HZ)
 
@@ -172,6 +174,7 @@ static int page_pool_init(struct page_pool *pool,
 			  const struct page_pool_params *params)
 {
 	unsigned int ring_qsize = 1024; /* Default */
+	int err;
 
 	memcpy(&pool->p, params, sizeof(pool->p));
 
@@ -225,10 +228,34 @@ static int page_pool_init(struct page_pool *pool,
 	/* Driver calling page_pool_create() also call page_pool_destroy() */
 	refcount_set(&pool->user_cnt, 1);
 
+	switch (pool->p.memory_provider) {
+	case __PP_MP_NONE:
+		break;
+	default:
+		err = -EINVAL;
+		goto free_ptr_ring;
+	}
+
+	pool->mp_priv = pool->p.mp_priv;
+	if (pool->mp_ops) {
+		err = pool->mp_ops->init(pool);
+		if (err) {
+			pr_warn("%s() mem-provider init failed %d\n",
+				__func__, err);
+			goto free_ptr_ring;
+		}
+
+		static_branch_inc(&page_pool_mem_providers);
+	}
+
 	if (pool->p.flags & PP_FLAG_DMA_MAP)
 		get_device(pool->p.dev);
 
 	return 0;
+
+free_ptr_ring:
+	ptr_ring_cleanup(&pool->ring, NULL);
+	return err;
 }
 
 /**
@@ -257,18 +284,13 @@ EXPORT_SYMBOL(page_pool_create);
 
 static void page_pool_return_page(struct page_pool *pool, struct page *page);
 
-noinline
-static struct page *page_pool_refill_alloc_cache(struct page_pool *pool)
+static bool page_pool_page_in_pref_node(struct page_pool *pool, struct page *page)
 {
-	struct ptr_ring *r = &pool->ring;
-	struct page *page;
 	int pref_nid; /* preferred NUMA node */
 
-	/* Quicker fallback, avoid locks when ring is empty */
-	if (__ptr_ring_empty(r)) {
-		alloc_stat_inc(pool, empty);
-		return NULL;
-	}
+	/* Always assume page is in pref node for mem providers */
+	if (static_branch_unlikely(&page_pool_mem_providers) && pool->mp_ops)
+		return true;
 
 	/* Softirq guarantee CPU and thus NUMA node is stable. This,
 	 * assumes CPU refilling driver RX-ring will also run RX-NAPI.
@@ -280,13 +302,31 @@ static struct page *page_pool_refill_alloc_cache(struct page_pool *pool)
 	pref_nid = numa_mem_id(); /* will be zero like page_to_nid() */
 #endif
 
+	if (page_to_nid(page) == pref_nid)
+		return true;
+
+	return false;
+}
+
+noinline
+static struct page *page_pool_refill_alloc_cache(struct page_pool *pool)
+{
+	struct ptr_ring *r = &pool->ring;
+	struct page *page;
+
+	/* Quicker fallback, avoid locks when ring is empty */
+	if (__ptr_ring_empty(r)) {
+		alloc_stat_inc(pool, empty);
+		return NULL;
+	}
+
 	/* Refill alloc array, but only if NUMA match */
 	do {
 		page = __ptr_ring_consume(r);
 		if (unlikely(!page))
 			break;
 
-		if (likely(page_to_nid(page) == pref_nid)) {
+		if (likely(page_pool_page_in_pref_node(pool, page))) {
 			pool->alloc.cache[pool->alloc.count++] = page;
 		} else {
 			/* NUMA mismatch;
@@ -490,7 +530,10 @@ struct page *page_pool_alloc_pages(struct page_pool *pool, gfp_t gfp)
 		return page;
 
 	/* Slow-path: cache empty, do real allocation */
-	page = __page_pool_alloc_pages_slow(pool, gfp);
+	if (static_branch_unlikely(&page_pool_mem_providers) && pool->mp_ops)
+		page = pool->mp_ops->alloc_pages(pool, gfp);
+	else
+		page = __page_pool_alloc_pages_slow(pool, gfp);
 	return page;
 }
 EXPORT_SYMBOL(page_pool_alloc_pages);
@@ -543,7 +586,10 @@ void page_pool_return_page(struct page_pool *pool, struct page *page)
 {
 	int count;
 
-	__page_pool_release_page_dma(pool, page);
+	if (static_branch_unlikely(&page_pool_mem_providers) && pool->mp_ops)
+		pool->mp_ops->release_page(pool, page);
+	else
+		__page_pool_release_page_dma(pool, page);
 
 	page_pool_clear_pp_info(page);
 
@@ -553,7 +599,11 @@ void page_pool_return_page(struct page_pool *pool, struct page *page)
 	count = atomic_inc_return_relaxed(&pool->pages_state_release_cnt);
 	trace_page_pool_state_release(pool, page, count);
 
-	put_page(page);
+	if (static_branch_unlikely(&page_pool_mem_providers) && pool->mp_ops)
+		pool->mp_ops->free_pages(pool, page);
+	else
+		put_page(page);
+
 	/* An optimization would be to call __free_pages(page, pool->p.order)
 	 * knowing page is not part of page-cache (thus avoiding a
 	 * __page_cache_release() call).
@@ -821,6 +871,11 @@ static void __page_pool_destroy(struct page_pool *pool)
 	if (pool->disconnect)
 		pool->disconnect(pool);
 
+	if (pool->mp_ops) {
+		pool->mp_ops->destroy(pool);
+		static_branch_dec(&page_pool_mem_providers);
+	}
+
 	ptr_ring_cleanup(&pool->ring, NULL);
 
 	if (pool->p.flags & PP_FLAG_DMA_MAP)
-- 
2.33.0

