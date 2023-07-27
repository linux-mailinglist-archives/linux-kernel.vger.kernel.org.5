Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C31E5765649
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 16:46:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234110AbjG0Oq1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 10:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234029AbjG0OqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 10:46:05 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD3E830FF;
        Thu, 27 Jul 2023 07:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690469149; x=1722005149;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jgDLGoKjKbbAnNkiXtnAT0R4SkigoAbWXqx73iWEsDQ=;
  b=h5MuQr4WD/ejuQyxPzoxM1PlNZVTOzwtzbwRqcraVSiY77ivHuGCvS6V
   NBJN4H6JmZw7rvT9rMtESZ8qVK+jh/xX56QvOWqm5eCelt4NcuDwGU4y8
   BADyHVGJjlLmya/CPKCJN0RAPI5ltLM5ZfDYPVCiuZ8Ir4YWwh+WqLUbO
   HeMq0RJOwyOfYM/keShyTQbuLRN3hdAPUIUQytfLyxpxpt4cos6XnNkYL
   lY4zj833WAcWd6sfgEuD1nHLMjQkZH4VtY591CqdWIG4a6nt7nT/OGzhZ
   iFnRHejT8CIsAPu4UobT+rfCuQvyIlR7aM7JFhrW151ow68TruGu8y6du
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="432139769"
X-IronPort-AV: E=Sophos;i="6.01,235,1684825200"; 
   d="scan'208";a="432139769"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2023 07:45:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="817119920"
X-IronPort-AV: E=Sophos;i="6.01,235,1684825200"; 
   d="scan'208";a="817119920"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by FMSMGA003.fm.intel.com with ESMTP; 27 Jul 2023 07:45:45 -0700
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
        Simon Horman <simon.horman@corigine.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 5/9] page_pool: don't use driver-set flags field directly
Date:   Thu, 27 Jul 2023 16:43:32 +0200
Message-ID: <20230727144336.1646454-6-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230727144336.1646454-1-aleksander.lobakin@intel.com>
References: <20230727144336.1646454-1-aleksander.lobakin@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
The flags indicating whether to perform DMA mapping and use frags can
be bool; as for DMA sync, define it as an enum to be able to extend it
later on. They are defined as bits in the driver-set params, leave them
so here as well, to not waste byte-per-bit or so. Now there are 29 free
bits left in those 4 bytes + 4 free bytes more before the cacheline
boundary.
We could've defined only new flags here or only the ones we may need
to alter, but checking some flags in one place while others in another
doesn't sound convenient or intuitive.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Link[0]: https://lore.kernel.org/netdev/20230703133207.4f0c54ce@kernel.org
Suggested-by: Alexander Duyck <alexanderduyck@fb.com>
Link[1]: https://lore.kernel.org/netdev/CAKgT0UfZCGnWgOH96E4GV3ZP6LLbROHM7SHE8NKwq+exX+Gk_Q@mail.gmail.com
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 include/net/page_pool/helpers.h |  2 +-
 include/net/page_pool/types.h   |  8 +++++++-
 net/core/page_pool.c            | 33 +++++++++++++++++----------------
 3 files changed, 25 insertions(+), 18 deletions(-)

diff --git a/include/net/page_pool/helpers.h b/include/net/page_pool/helpers.h
index e2d8d3a8810c..a09ba80b889e 100644
--- a/include/net/page_pool/helpers.h
+++ b/include/net/page_pool/helpers.h
@@ -125,7 +125,7 @@ static inline bool page_pool_is_last_frag(struct page_pool *pool,
 					  struct page *page)
 {
 	/* If fragments aren't enabled or count is 0 we were the last user */
-	return !(pool->p.flags & PP_FLAG_PAGE_FRAG) ||
+	return !pool->page_frag ||
 	       (page_pool_defrag_page(page, 1) == 0);
 }
 
diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.h
index c86f65e57614..dd26f4b2b66c 100644
--- a/include/net/page_pool/types.h
+++ b/include/net/page_pool/types.h
@@ -93,7 +93,13 @@ struct page_pool_stats {
 
 struct page_pool {
 	struct page_pool_params p;
-	long pad;
+
+	bool dma_map:1;				/* Perform DMA mapping */
+	enum {
+		PP_DMA_SYNC_ACT_DISABLED = 0,	/* Driver didn't ask to sync */
+		PP_DMA_SYNC_ACT_DO,		/* Perform DMA sync ops */
+	} dma_sync_act:1;
+	bool page_frag:1;			/* Allow page fragments */
 
 	long frag_users;
 	struct page *frag_page;
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 7a23ca6b1124..6a8f105e2df5 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -183,6 +183,8 @@ static int page_pool_init(struct page_pool *pool,
 		if ((pool->p.dma_dir != DMA_FROM_DEVICE) &&
 		    (pool->p.dma_dir != DMA_BIDIRECTIONAL))
 			return -EINVAL;
+
+		pool->dma_map = true;
 	}
 
 	if (pool->p.flags & PP_FLAG_DMA_SYNC_DEV) {
@@ -195,13 +197,15 @@ static int page_pool_init(struct page_pool *pool,
 		if (!pool->p.max_len)
 			return -EINVAL;
 
+		pool->dma_sync_act = PP_DMA_SYNC_ACT_DO;
+
 		/* pool->p.offset has to be set according to the address
 		 * offset used by the DMA engine to start copying rx data
 		 */
 	}
 
-	if (PAGE_POOL_DMA_USE_PP_FRAG_COUNT &&
-	    pool->p.flags & PP_FLAG_PAGE_FRAG)
+	pool->page_frag = !!(pool->p.flags & PP_FLAG_PAGE_FRAG);
+	if (PAGE_POOL_DMA_USE_PP_FRAG_COUNT && pool->page_frag)
 		return -EINVAL;
 
 #ifdef CONFIG_PAGE_POOL_STATS
@@ -218,7 +222,7 @@ static int page_pool_init(struct page_pool *pool,
 	/* Driver calling page_pool_create() also call page_pool_destroy() */
 	refcount_set(&pool->user_cnt, 1);
 
-	if (pool->p.flags & PP_FLAG_DMA_MAP)
+	if (pool->dma_map)
 		get_device(pool->p.dev);
 
 	return 0;
@@ -346,7 +350,7 @@ static bool page_pool_dma_map(struct page_pool *pool, struct page *page)
 
 	page_pool_set_dma_addr(page, dma);
 
-	if (pool->p.flags & PP_FLAG_DMA_SYNC_DEV)
+	if (pool->dma_sync_act == PP_DMA_SYNC_ACT_DO)
 		page_pool_dma_sync_for_device(pool, page, pool->p.max_len);
 
 	return true;
@@ -377,8 +381,7 @@ static struct page *__page_pool_alloc_page_order(struct page_pool *pool,
 	if (unlikely(!page))
 		return NULL;
 
-	if ((pool->p.flags & PP_FLAG_DMA_MAP) &&
-	    unlikely(!page_pool_dma_map(pool, page))) {
+	if (pool->dma_map && unlikely(!page_pool_dma_map(pool, page))) {
 		put_page(page);
 		return NULL;
 	}
@@ -398,8 +401,8 @@ static struct page *__page_pool_alloc_pages_slow(struct page_pool *pool,
 						 gfp_t gfp)
 {
 	const int bulk = PP_ALLOC_CACHE_REFILL;
-	unsigned int pp_flags = pool->p.flags;
 	unsigned int pp_order = pool->p.order;
+	bool dma_map = pool->dma_map;
 	struct page *page;
 	int i, nr_pages;
 
@@ -424,8 +427,7 @@ static struct page *__page_pool_alloc_pages_slow(struct page_pool *pool,
 	 */
 	for (i = 0; i < nr_pages; i++) {
 		page = pool->alloc.cache[i];
-		if ((pp_flags & PP_FLAG_DMA_MAP) &&
-		    unlikely(!page_pool_dma_map(pool, page))) {
+		if (dma_map && unlikely(!page_pool_dma_map(pool, page))) {
 			put_page(page);
 			continue;
 		}
@@ -497,7 +499,7 @@ static void page_pool_return_page(struct page_pool *pool, struct page *page)
 	dma_addr_t dma;
 	int count;
 
-	if (!(pool->p.flags & PP_FLAG_DMA_MAP))
+	if (!pool->dma_map)
 		/* Always account for inflight pages, even if we didn't
 		 * map them
 		 */
@@ -563,7 +565,7 @@ static bool page_pool_recycle_in_cache(struct page *page,
 }
 
 /* If the page refcnt == 1, this will try to recycle the page.
- * if PP_FLAG_DMA_SYNC_DEV is set, we'll try to sync the DMA area for
+ * if pool->dma_sync_act is set, we'll try to sync the DMA area for
  * the configured size min(dma_sync_size, pool->max_len).
  * If the page refcnt != 1, then the page will be returned to memory
  * subsystem.
@@ -584,7 +586,7 @@ __page_pool_put_page(struct page_pool *pool, struct page *page,
 	if (likely(page_ref_count(page) == 1 && !page_is_pfmemalloc(page))) {
 		/* Read barrier done in page_ref_count / READ_ONCE */
 
-		if (pool->p.flags & PP_FLAG_DMA_SYNC_DEV)
+		if (pool->dma_sync_act == PP_DMA_SYNC_ACT_DO)
 			page_pool_dma_sync_for_device(pool, page,
 						      dma_sync_size);
 
@@ -683,7 +685,7 @@ static struct page *page_pool_drain_frag(struct page_pool *pool,
 		return NULL;
 
 	if (page_ref_count(page) == 1 && !page_is_pfmemalloc(page)) {
-		if (pool->p.flags & PP_FLAG_DMA_SYNC_DEV)
+		if (pool->dma_sync_act == PP_DMA_SYNC_ACT_DO)
 			page_pool_dma_sync_for_device(pool, page, -1);
 
 		return page;
@@ -713,8 +715,7 @@ struct page *page_pool_alloc_frag(struct page_pool *pool,
 	unsigned int max_size = PAGE_SIZE << pool->p.order;
 	struct page *page = pool->frag_page;
 
-	if (WARN_ON(!(pool->p.flags & PP_FLAG_PAGE_FRAG) ||
-		    size > max_size))
+	if (WARN_ON(!pool->page_frag || size > max_size))
 		return NULL;
 
 	size = ALIGN(size, dma_get_cache_alignment());
@@ -774,7 +775,7 @@ static void page_pool_free(struct page_pool *pool)
 
 	ptr_ring_cleanup(&pool->ring, NULL);
 
-	if (pool->p.flags & PP_FLAG_DMA_MAP)
+	if (pool->dma_map)
 		put_device(pool->p.dev);
 
 #ifdef CONFIG_PAGE_POOL_STATS
-- 
2.41.0

