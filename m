Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C269810FF6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 12:31:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235380AbjLMLbV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 06:31:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235176AbjLMLbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 06:31:09 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97F35F3;
        Wed, 13 Dec 2023 03:31:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702467065; x=1734003065;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tiNhSbswutvCa23QGXK1rCPXeIMvd0H2yCpkef8mluU=;
  b=ajy5iWLOvIYtbkGpBs5pUk0Q1G7H1IseLnls950cnm3MYfjlLQC9Oh7t
   7nP+vDeWuy09wvDuJKiNqc48WRh1iLeSX6rGqhNlqJTwB5sBtDkGaNiId
   p/URbxUSHMksnZ4NbwkyKuldwApeBKhg/XHUhmoX4VqzY/bEUDWBR7tlu
   q80SjqkeyTGgyHiOa2nkWnKpIgwvur5oFciKd3SNMQZgRoMT60x3moS4T
   7pkqnNi1q07/wGbj4k+v1ga0azMok773nOQs46tBFPhZE4iNVxZdE1OoM
   yvE8g+nnSn7dvYl2IXxgDT3hbY1hrYywu30foBiFdg/ETvcMxM4kn8BsU
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="375103993"
X-IronPort-AV: E=Sophos;i="6.04,272,1695711600"; 
   d="scan'208";a="375103993"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 03:31:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="844279495"
X-IronPort-AV: E=Sophos;i="6.04,272,1695711600"; 
   d="scan'208";a="844279495"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmsmga004.fm.intel.com with ESMTP; 13 Dec 2023 03:31:00 -0800
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
Subject: [PATCH net-next v7 06/12] page_pool: constify some read-only function arguments
Date:   Wed, 13 Dec 2023 12:28:29 +0100
Message-ID: <20231213112835.2262651-7-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231213112835.2262651-1-aleksander.lobakin@intel.com>
References: <20231213112835.2262651-1-aleksander.lobakin@intel.com>
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

There are several functions taking pointers to data they don't modify.
This includes statistics fetching, page and page_pool parameters, etc.
Constify the pointers, so that call sites will be able to pass const
pointers as well.
No functional changes, no visible changes in functions sizes.

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 include/net/page_pool/helpers.h | 10 +++++-----
 net/core/page_pool.c            |  8 ++++----
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/net/page_pool/helpers.h b/include/net/page_pool/helpers.h
index 7dc65774cde5..c860fad50d00 100644
--- a/include/net/page_pool/helpers.h
+++ b/include/net/page_pool/helpers.h
@@ -58,7 +58,7 @@
 /* Deprecated driver-facing API, use netlink instead */
 int page_pool_ethtool_stats_get_count(void);
 u8 *page_pool_ethtool_stats_get_strings(u8 *data);
-u64 *page_pool_ethtool_stats_get(u64 *data, void *stats);
+u64 *page_pool_ethtool_stats_get(u64 *data, const void *stats);
 
 bool page_pool_get_stats(const struct page_pool *pool,
 			 struct page_pool_stats *stats);
@@ -73,7 +73,7 @@ static inline u8 *page_pool_ethtool_stats_get_strings(u8 *data)
 	return data;
 }
 
-static inline u64 *page_pool_ethtool_stats_get(u64 *data, void *stats)
+static inline u64 *page_pool_ethtool_stats_get(u64 *data, const void *stats)
 {
 	return data;
 }
@@ -204,8 +204,8 @@ static inline void *page_pool_dev_alloc_va(struct page_pool *pool,
  * Get the stored dma direction. A driver might decide to store this locally
  * and avoid the extra cache line from page_pool to determine the direction.
  */
-static
-inline enum dma_data_direction page_pool_get_dma_dir(struct page_pool *pool)
+static inline enum dma_data_direction
+page_pool_get_dma_dir(const struct page_pool *pool)
 {
 	return pool->p.dma_dir;
 }
@@ -357,7 +357,7 @@ static inline void page_pool_free_va(struct page_pool *pool, void *va,
  * Fetch the DMA address of the page. The page pool to which the page belongs
  * must had been created with PP_FLAG_DMA_MAP.
  */
-static inline dma_addr_t page_pool_get_dma_addr(struct page *page)
+static inline dma_addr_t page_pool_get_dma_addr(const struct page *page)
 {
 	dma_addr_t ret = page->dma_addr;
 
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 59aca3339222..4295aec0be40 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -121,9 +121,9 @@ int page_pool_ethtool_stats_get_count(void)
 }
 EXPORT_SYMBOL(page_pool_ethtool_stats_get_count);
 
-u64 *page_pool_ethtool_stats_get(u64 *data, void *stats)
+u64 *page_pool_ethtool_stats_get(u64 *data, const void *stats)
 {
-	struct page_pool_stats *pool_stats = stats;
+	const struct page_pool_stats *pool_stats = stats;
 
 	*data++ = pool_stats->alloc_stats.fast;
 	*data++ = pool_stats->alloc_stats.slow;
@@ -360,8 +360,8 @@ static struct page *__page_pool_get_cached(struct page_pool *pool)
 	return page;
 }
 
-static void page_pool_dma_sync_for_device(struct page_pool *pool,
-					  struct page *page,
+static void page_pool_dma_sync_for_device(const struct page_pool *pool,
+					  const struct page *page,
 					  unsigned int dma_sync_size)
 {
 	dma_addr_t dma_addr = page_pool_get_dma_addr(page);
-- 
2.43.0

