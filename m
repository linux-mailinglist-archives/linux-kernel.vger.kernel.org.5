Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF6A47F7850
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 16:51:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346087AbjKXPvl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 10:51:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346058AbjKXPvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 10:51:03 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6437B211B;
        Fri, 24 Nov 2023 07:50:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700841054; x=1732377054;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qcdULXkV85yRP9bxyrRP1FOnAdXuXhmN2DquOAIQhG0=;
  b=lo1/S9EL8mETQhfUCz4Vo6YjamkZ2yaf8kyg4cmMxaxtEtJ9bZTUyhup
   ih98aM3K0xr6mbO3QweyYvVAFlOyZbD80YSoNxFHnwooMGxwqd7VmQhgM
   hd1cS8JyYdwe1eKZbp01Ts22tHZ8+nRZObmZJW5iMflssyuYuWyufNH1Q
   /7Imsvmg4c1WyZ/LslsIliFRSQIGyPYBBtVj6U0VG8DA2TxU+mPfwB6xZ
   ac4PJkTkZBToEKdZvnLHELLW8zVA2sqDYkF+siq9JgoDdijJV/bkMbU1i
   AFLmuQVT9KVRGx6gquqPHc4j3wjp6mGEbXglU820Oo8dSKn0qY+DrvSqF
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10904"; a="389592646"
X-IronPort-AV: E=Sophos;i="6.04,224,1695711600"; 
   d="scan'208";a="389592646"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2023 07:50:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,224,1695711600"; 
   d="scan'208";a="15660385"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa001.jf.intel.com with ESMTP; 24 Nov 2023 07:50:51 -0800
From:   Alexander Lobakin <aleksander.lobakin@intel.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     Alexander Lobakin <aleksander.lobakin@intel.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Michal Kubiak <michal.kubiak@intel.com>,
        Larysa Zaremba <larysa.zaremba@intel.com>,
        Alexander Duyck <alexanderduyck@fb.com>,
        Yunsheng Lin <linyunsheng@huawei.com>,
        David Christensen <drc@linux.vnet.ibm.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Paul Menzel <pmenzel@molgen.mpg.de>, netdev@vger.kernel.org,
        intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next v5 13/14] libie: add per-queue Page Pool stats
Date:   Fri, 24 Nov 2023 16:47:31 +0100
Message-ID: <20231124154732.1623518-14-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231124154732.1623518-1-aleksander.lobakin@intel.com>
References: <20231124154732.1623518-1-aleksander.lobakin@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Expand the libie generic per-queue stats with the generic Page Pool
stats provided by the API itself, when CONFIG_PAGE_POOL_STATS is
enabled. When it's not, there'll be no such fields in the stats
structure, so no space wasted.
They are also a bit special in terms of how they are obtained. One
&page_pool accumulates statistics until it's destroyed obviously, which
happens on ifdown. So, in order to not lose any statistics, get the
stats and store them in the queue container before destroying the pool.
This container survives ifups/downs, so it basically stores the
statistics accumulated since the very first pool was allocated on this
queue. When it's needed to export the stats, first get the numbers from
this container and then add the "live" numbers -- the ones that the
current active pool returns. The result values will always represent
the actual device-lifetime stats.
There's a cast from &page_pool_stats to `u64 *` in a couple functions,
but they are guarded with stats asserts to make sure it's safe to do.
FWIW it saves a lot of object code.

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 drivers/net/ethernet/intel/libie/internal.h | 20 ++++++
 drivers/net/ethernet/intel/libie/rx.c       |  9 +++
 drivers/net/ethernet/intel/libie/stats.c    | 68 +++++++++++++++++++++
 include/linux/net/intel/libie/stats.h       | 34 ++++++++++-
 4 files changed, 130 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/ethernet/intel/libie/internal.h

diff --git a/drivers/net/ethernet/intel/libie/internal.h b/drivers/net/ethernet/intel/libie/internal.h
new file mode 100644
index 000000000000..13bb0a89f59e
--- /dev/null
+++ b/drivers/net/ethernet/intel/libie/internal.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* libie internal declarations not to be used in the drivers.
+ *
+ * Copyright(c) 2023 Intel Corporation.
+ */
+
+#ifndef __LIBIE_INTERNAL_H
+#define __LIBIE_INTERNAL_H
+
+struct libie_rx_queue;
+
+#ifdef CONFIG_PAGE_POOL_STATS
+void libie_rq_stats_sync_pp(const struct libie_rx_queue *rq);
+#else
+static inline void libie_rq_stats_sync_pp(const struct libie_rx_queue *rq)
+{
+}
+#endif
+
+#endif /* __LIBIE_INTERNAL_H */
diff --git a/drivers/net/ethernet/intel/libie/rx.c b/drivers/net/ethernet/intel/libie/rx.c
index 520a269f7d31..fcc5c3c44645 100644
--- a/drivers/net/ethernet/intel/libie/rx.c
+++ b/drivers/net/ethernet/intel/libie/rx.c
@@ -3,6 +3,8 @@
 
 #include <linux/net/intel/libie/rx.h>
 
+#include "internal.h"
+
 /* Rx buffer management */
 
 /**
@@ -64,9 +66,16 @@ EXPORT_SYMBOL_NS_GPL(libie_rx_page_pool_create, LIBIE);
 /**
  * libie_rx_page_pool_destroy - destroy a &page_pool created by libie
  * @rq: receive queue to process
+ *
+ * As the stats usually has the same lifetime as the device, but PP is usually
+ * created/destroyed on ifup/ifdown, in order to not lose the stats accumulated
+ * during the last ifup, the PP stats need to be added to the driver stats
+ * container. Then the PP gets destroyed.
  */
 void libie_rx_page_pool_destroy(struct libie_rx_queue *rq)
 {
+	libie_rq_stats_sync_pp(rq);
+
 	page_pool_destroy(rq->pp);
 	rq->pp = NULL;
 }
diff --git a/drivers/net/ethernet/intel/libie/stats.c b/drivers/net/ethernet/intel/libie/stats.c
index bdcbe4304c55..9c4ef237af08 100644
--- a/drivers/net/ethernet/intel/libie/stats.c
+++ b/drivers/net/ethernet/intel/libie/stats.c
@@ -6,6 +6,8 @@
 #include <linux/net/intel/libie/rx.h>
 #include <linux/net/intel/libie/stats.h>
 
+#include "internal.h"
+
 /* Rx per-queue stats */
 
 static const char * const libie_rq_stats_str[] = {
@@ -16,6 +18,70 @@ static const char * const libie_rq_stats_str[] = {
 
 #define LIBIE_RQ_STATS_NUM	ARRAY_SIZE(libie_rq_stats_str)
 
+#ifdef CONFIG_PAGE_POOL_STATS
+/**
+ * libie_rq_stats_get_pp - get the current stats from a &page_pool
+ * @sarr: local array to add stats to
+ * @pool: pool to get the stats from
+ *
+ * Adds the current "live" stats from an online PP to the stats read from
+ * the RQ container, so that the actual totals will be returned.
+ */
+static void libie_rq_stats_get_pp(u64 *sarr, const struct page_pool *pool)
+{
+	struct page_pool_stats *pps;
+	/* Used only to calculate pos below */
+	struct libie_rq_stats tmp;
+	u32 pos;
+
+	/* Validate the libie PP stats array can be casted <-> PP struct */
+	static_assert(sizeof(tmp.pp) == sizeof(*pps));
+
+	if (!pool)
+		return;
+
+	/* Position of the first Page Pool stats field */
+	pos = (u64_stats_t *)&tmp.pp - tmp.raw;
+	pps = (typeof(pps))&sarr[pos];
+
+	page_pool_get_stats(pool, pps);
+}
+
+/**
+ * libie_rq_stats_sync_pp - add the current PP stats to the RQ stats container
+ * @rq: Rx queue to synchronize
+ *
+ * Called by libie_rx_page_pool_destroy() to save the stats before destroying
+ * the pool.
+ */
+void libie_rq_stats_sync_pp(const struct libie_rx_queue *rq)
+{
+	struct libie_rq_stats *stats = rq->stats;
+	struct page_pool_stats pps = { };
+	u64 *sarr = (u64 *)&pps;
+	u64_stats_t *qarr;
+
+	if (!stats)
+		return;
+
+	qarr = (u64_stats_t *)&stats->pp;
+	page_pool_get_stats(rq->pp, &pps);
+
+	u64_stats_update_begin(&stats->syncp);
+
+	for (u32 i = 0; i < sizeof(pps) / sizeof(*sarr); i++)
+		u64_stats_add(&qarr[i], sarr[i]);
+
+	u64_stats_update_end(&stats->syncp);
+}
+#else
+static void libie_rq_stats_get_pp(u64 *sarr, const struct page_pool *pool)
+{
+}
+
+/* static inline void libie_rq_stats_sync_pp() is declared in "internal.h" */
+#endif
+
 /**
  * libie_rq_stats_get_sset_count - get the number of Ethtool RQ stats provided
  *
@@ -57,6 +123,8 @@ void libie_rq_stats_get_data(u64 **data, const struct libie_rx_queue *rq)
 			sarr[i] = u64_stats_read(&stats->raw[i]);
 	} while (u64_stats_fetch_retry(&stats->syncp, start));
 
+	libie_rq_stats_get_pp(sarr, rq->pp);
+
 	for (u32 i = 0; i < LIBIE_RQ_STATS_NUM; i++)
 		(*data)[i] += sarr[i];
 
diff --git a/include/linux/net/intel/libie/stats.h b/include/linux/net/intel/libie/stats.h
index 4e6dfb8c715f..f913968d7516 100644
--- a/include/linux/net/intel/libie/stats.h
+++ b/include/linux/net/intel/libie/stats.h
@@ -49,6 +49,17 @@
  * fragments: number of processed descriptors carrying only a fragment
  * alloc_page_fail: number of Rx page allocation fails
  * build_skb_fail: number of build_skb() fails
+ * pp_alloc_fast: pages taken from the cache or ring
+ * pp_alloc_slow: actual page allocations
+ * pp_alloc_slow_ho: non-order-0 page allocations
+ * pp_alloc_empty: number of times the pool was empty
+ * pp_alloc_refill: number of cache refills
+ * pp_alloc_waive: NUMA node mismatches during recycling
+ * pp_recycle_cached: direct recyclings into the cache
+ * pp_recycle_cache_full: number of times the cache was full
+ * pp_recycle_ring: recyclings into the ring
+ * pp_recycle_ring_full: number of times the ring was full
+ * pp_recycle_released_ref: pages released due to elevated refcnt
  */
 
 #define DECLARE_LIBIE_RQ_NAPI_STATS(act)		\
@@ -60,9 +71,27 @@
 	act(alloc_page_fail)				\
 	act(build_skb_fail)
 
+#ifdef CONFIG_PAGE_POOL_STATS
+#define DECLARE_LIBIE_RQ_PP_STATS(act)			\
+	act(pp_alloc_fast)				\
+	act(pp_alloc_slow)				\
+	act(pp_alloc_slow_ho)				\
+	act(pp_alloc_empty)				\
+	act(pp_alloc_refill)				\
+	act(pp_alloc_waive)				\
+	act(pp_recycle_cached)				\
+	act(pp_recycle_cache_full)			\
+	act(pp_recycle_ring)				\
+	act(pp_recycle_ring_full)			\
+	act(pp_recycle_released_ref)
+#else
+#define DECLARE_LIBIE_RQ_PP_STATS(act)
+#endif
+
 #define DECLARE_LIBIE_RQ_STATS(act)			\
 	DECLARE_LIBIE_RQ_NAPI_STATS(act)		\
-	DECLARE_LIBIE_RQ_FAIL_STATS(act)
+	DECLARE_LIBIE_RQ_FAIL_STATS(act)		\
+	DECLARE_LIBIE_RQ_PP_STATS(act)
 
 struct libie_rx_queue;
 
@@ -74,6 +103,9 @@ struct libie_rq_stats {
 #define act(s)	u64_stats_t	s;
 			DECLARE_LIBIE_RQ_NAPI_STATS(act);
 			DECLARE_LIBIE_RQ_FAIL_STATS(act);
+			struct_group(pp,
+				DECLARE_LIBIE_RQ_PP_STATS(act);
+			);
 #undef act
 		};
 		DECLARE_FLEX_ARRAY(u64_stats_t, raw);
-- 
2.42.0

