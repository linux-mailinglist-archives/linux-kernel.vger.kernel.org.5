Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6842A75403A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 19:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235976AbjGNRKz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 13:10:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236179AbjGNRKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 13:10:47 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3847E3AAA;
        Fri, 14 Jul 2023 10:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689354639; x=1720890639;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BllYlKzEFfzFtohGzc4O3kjK2I6sflee5H/3e7j/i8o=;
  b=B8CZsFsn8mHgSbQFmawdT8XF0UgRQwu+giFB4c5zZCHUmbstg1OrHUu8
   iLlOYiXpyzqYfxD7kf/Ypr1c8k8Nci268uLjHy+kFvoBT3NGWdc2lN1Mq
   /tmcjTd2ScTHpkDCQCKZxal7/v7M2lyfAfMvWvaoGGTB2o44023f4Z5Oh
   F5WfEt3iWdMSR/OJ+qVSlEdBkyu8SfwiBH9KNkv2zXLT1bkqjs9cS5x6U
   Kr8JbK6Xqx4CioBKdQ4FvuVb6V1sIYPu40+RxJdc94lXp8O4FuvgP7S5z
   IHTf7aeLeVoVe+Tli7MGq5lZjRoABdnW+wLHzUA8LLPFQFxesLd1xZ/65
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10771"; a="451891905"
X-IronPort-AV: E=Sophos;i="6.01,206,1684825200"; 
   d="scan'208";a="451891905"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2023 10:10:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10771"; a="787907059"
X-IronPort-AV: E=Sophos;i="6.01,206,1684825200"; 
   d="scan'208";a="787907059"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmsmga008.fm.intel.com with ESMTP; 14 Jul 2023 10:10:36 -0700
From:   Alexander Lobakin <aleksander.lobakin@intel.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     Alexander Lobakin <aleksander.lobakin@intel.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Larysa Zaremba <larysa.zaremba@intel.com>,
        Yunsheng Lin <linyunsheng@huawei.com>,
        Alexander Duyck <alexanderduyck@fb.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH RFC net-next v2 4/7] net: page_pool: don't use driver-set flags field directly
Date:   Fri, 14 Jul 2023 19:08:49 +0200
Message-ID: <20230714170853.866018-7-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230714170853.866018-1-aleksander.lobakin@intel.com>
References: <20230714170853.866018-1-aleksander.lobakin@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

page_pool::p is driver-defined params, copied directly from the
structure passed via page_pool_create(). The structure isn't meant
to be modified by the Page Pool core code and this even might look
confusing[0][1].
In order to be able to alter some flags, let's define our own, internal
fields. Use the slot freed earlier to stay within the same cacheline as
before (or almost if it's shorter than 64 bytes).
The flag indicating whether to perform DMA mapping can be bool; as for
DMA sync, define it as an enum to be able to extend it later on. They
are defined as bits in the driver-set params, leave them so here as
well, to not waste byte-per-bit or so. Now there are 29 free bits left
in those 4 bytes + 4 free bytes more before the cacheline boundary.
We could've defined only new flags here or only the ones we may need
to alter, but checking some flags in one place while others in another
doesn't sound convenient or intuitive.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Link[0]: https://lore.kernel.org/netdev/20230703133207.4f0c54ce@kernel.org
Suggested-by: Alexander Duyck <alexanderduyck@fb.com>
Link[1]: https://lore.kernel.org/netdev/CAKgT0UfZCGnWgOH96E4GV3ZP6LLbROHM7SHE8NKwq+exX+Gk_Q@mail.gmail.com
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 include/net/page_pool.h |  7 ++++++-
 net/core/page_pool.c    | 26 ++++++++++++++------------
 2 files changed, 20 insertions(+), 13 deletions(-)

diff --git a/include/net/page_pool.h b/include/net/page_pool.h
index 68937deea4b1..aefcb76baf0e 100644
--- a/include/net/page_pool.h
+++ b/include/net/page_pool.h
@@ -129,7 +129,12 @@ static inline u64 *page_pool_ethtool_stats_get(u64 *data, void *stats)
 
 struct page_pool {
 	struct page_pool_params p;
-	long pad;
+
+	bool dma_map:1;				/* Perform DMA mapping */
+	enum {
+		PP_DMA_SYNC_ACT_DISABLED = 0,	/* Driver didn't ask to sync */
+		PP_DMA_SYNC_ACT_DO,		/* Perform DMA sync ops */
+	} dma_sync_act:2;
 
 	long frag_users;
 	struct page *frag_page;
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 09d76e37ac69..67957e74e1f5 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -182,6 +182,8 @@ static int page_pool_init(struct page_pool *pool,
 		if ((pool->p.dma_dir != DMA_FROM_DEVICE) &&
 		    (pool->p.dma_dir != DMA_BIDIRECTIONAL))
 			return -EINVAL;
+
+		pool->dma_map = true;
 	}
 
 	if (pool->p.flags & PP_FLAG_DMA_SYNC_DEV) {
@@ -194,6 +196,8 @@ static int page_pool_init(struct page_pool *pool,
 		if (!pool->p.max_len)
 			return -EINVAL;
 
+		pool->dma_sync_act = PP_DMA_SYNC_ACT_DO;
+
 		/* pool->p.offset has to be set according to the address
 		 * offset used by the DMA engine to start copying rx data
 		 */
@@ -213,7 +217,7 @@ static int page_pool_init(struct page_pool *pool,
 	/* Driver calling page_pool_create() also call page_pool_destroy() */
 	refcount_set(&pool->user_cnt, 1);
 
-	if (pool->p.flags & PP_FLAG_DMA_MAP)
+	if (pool->dma_map)
 		get_device(pool->p.dev);
 
 	return 0;
@@ -341,7 +345,7 @@ static bool page_pool_dma_map(struct page_pool *pool, struct page *page)
 
 	page_pool_set_dma_addr(page, dma);
 
-	if (pool->p.flags & PP_FLAG_DMA_SYNC_DEV)
+	if (pool->dma_sync_act == PP_DMA_SYNC_ACT_DO)
 		page_pool_dma_sync_for_device(pool, page, pool->p.max_len);
 
 	return true;
@@ -380,8 +384,7 @@ static struct page *__page_pool_alloc_page_order(struct page_pool *pool,
 	if (unlikely(!page))
 		return NULL;
 
-	if ((pool->p.flags & PP_FLAG_DMA_MAP) &&
-	    unlikely(!page_pool_dma_map(pool, page))) {
+	if (pool->dma_map && unlikely(!page_pool_dma_map(pool, page))) {
 		put_page(page);
 		return NULL;
 	}
@@ -401,8 +404,8 @@ static struct page *__page_pool_alloc_pages_slow(struct page_pool *pool,
 						 gfp_t gfp)
 {
 	const int bulk = PP_ALLOC_CACHE_REFILL;
-	unsigned int pp_flags = pool->p.flags;
 	unsigned int pp_order = pool->p.order;
+	bool dma_map = pool->dma_map;
 	struct page *page;
 	int i, nr_pages;
 
@@ -427,8 +430,7 @@ static struct page *__page_pool_alloc_pages_slow(struct page_pool *pool,
 	 */
 	for (i = 0; i < nr_pages; i++) {
 		page = pool->alloc.cache[i];
-		if ((pp_flags & PP_FLAG_DMA_MAP) &&
-		    unlikely(!page_pool_dma_map(pool, page))) {
+		if (dma_map && unlikely(!page_pool_dma_map(pool, page))) {
 			put_page(page);
 			continue;
 		}
@@ -500,7 +502,7 @@ void page_pool_release_page(struct page_pool *pool, struct page *page)
 	dma_addr_t dma;
 	int count;
 
-	if (!(pool->p.flags & PP_FLAG_DMA_MAP))
+	if (!pool->dma_map)
 		/* Always account for inflight pages, even if we didn't
 		 * map them
 		 */
@@ -573,7 +575,7 @@ static bool page_pool_recycle_in_cache(struct page *page,
 }
 
 /* If the page refcnt == 1, this will try to recycle the page.
- * if PP_FLAG_DMA_SYNC_DEV is set, we'll try to sync the DMA area for
+ * if pool->dma_sync_act is set, we'll try to sync the DMA area for
  * the configured size min(dma_sync_size, pool->max_len).
  * If the page refcnt != 1, then the page will be returned to memory
  * subsystem.
@@ -594,7 +596,7 @@ __page_pool_put_page(struct page_pool *pool, struct page *page,
 	if (likely(page_ref_count(page) == 1 && !page_is_pfmemalloc(page))) {
 		/* Read barrier done in page_ref_count / READ_ONCE */
 
-		if (pool->p.flags & PP_FLAG_DMA_SYNC_DEV)
+		if (pool->dma_sync_act == PP_DMA_SYNC_ACT_DO)
 			page_pool_dma_sync_for_device(pool, page,
 						      dma_sync_size);
 
@@ -695,7 +697,7 @@ static struct page *page_pool_drain_frag(struct page_pool *pool,
 		return NULL;
 
 	if (page_ref_count(page) == 1 && !page_is_pfmemalloc(page)) {
-		if (pool->p.flags & PP_FLAG_DMA_SYNC_DEV)
+		if (pool->dma_sync_act == PP_DMA_SYNC_ACT_DO)
 			page_pool_dma_sync_for_device(pool, page, -1);
 
 		return page;
@@ -781,7 +783,7 @@ static void __page_pool_destroy(struct page_pool *pool)
 
 	ptr_ring_cleanup(&pool->ring, NULL);
 
-	if (pool->p.flags & PP_FLAG_DMA_MAP)
+	if (pool->dma_map)
 		put_device(pool->p.dev);
 
 #ifdef CONFIG_PAGE_POOL_STATS
-- 
2.41.0

