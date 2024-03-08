Return-Path: <linux-kernel+bounces-97155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2252187663A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 15:20:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 627AFB24344
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 14:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 845235A793;
	Fri,  8 Mar 2024 14:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UYrI/yD1"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1684D59159;
	Fri,  8 Mar 2024 14:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709907547; cv=none; b=eFjWJGT0ZWDN/cleWiJzlwPYpd/awQjcvR+iAYTq95p4MK2RVCZatSGxw8y857PkEyheaEwLKArdMecbt3oeBLzAjRQ0BujTfrYF7jDwax0N8AN2fOKPaHb1NPzHBXUszqz+48igIDHS5nm5Mxd5HdXaMly/FkaUClA1tRxwfRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709907547; c=relaxed/simple;
	bh=NuwKXsk7HN65dVrdXD906hvyhTTnbT58/G5pwuT8NkI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lrnzzn7m9G/xdQ9CqMkEOAxT+WAR1ftlvHSH3mUvsLzMv3dvoYR9JkxZY9yfk3IcAG1hXKyQtxb4BjqjJQpY8olr+gOGOAMWS1Uvq8ttfy3B548rFqOm5SLvnusJ8MptNYWDnj9t3E/nfm/mty+DnF7YSQMc4CJfB2AgRnyrx0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UYrI/yD1; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709907546; x=1741443546;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NuwKXsk7HN65dVrdXD906hvyhTTnbT58/G5pwuT8NkI=;
  b=UYrI/yD13i4jDAG75EhN3qzerMoUjz52sVBIgqWhAm9adjQiUWxub/AE
   nGT2+s9uvjY/C2QUopErewL6pAXaSLy3HTv6J+T11F5Q3n09kQ8weZgtz
   R8TOCHE7WfFcnQO5WQz7wbPFF4rCV1Uw/P++0jUvCK4hl9WSAyoJzPikL
   aivJDmUIlnQ8CqHaBCxfskJv26L1XTb6/1KdNwL0YwH/QU6n9yy8sSHyA
   9ghVkFKeW+pf75d1A7K75MrUG4kuByFISQG6952NYqWxVfiXpaB7kbIV1
   yZHlwVwZ8QFlwNBINa2TKAiDH6JwjOsxmE5x51nrSB+RUmOGOiRplQvDz
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="4504563"
X-IronPort-AV: E=Sophos;i="6.07,109,1708416000"; 
   d="scan'208";a="4504563"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2024 06:19:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,109,1708416000"; 
   d="scan'208";a="15177209"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa005.jf.intel.com with ESMTP; 08 Mar 2024 06:19:02 -0800
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Alexander Duyck <alexanderduyck@fb.com>,
	Yunsheng Lin <linyunsheng@huawei.com>,
	David Christensen <drc@linux.vnet.ibm.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	netdev@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v8 4/8] page_pool: constify some read-only function arguments
Date: Fri,  8 Mar 2024 15:18:29 +0100
Message-ID: <20240308141833.2966600-5-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240308141833.2966600-1-aleksander.lobakin@intel.com>
References: <20240308141833.2966600-1-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are several functions taking pointers to data they don't modify.
This includes statistics fetching, page and page_pool parameters, etc.
Constify the pointers, so that call sites will be able to pass const
pointers as well.
No functional changes, no visible changes in functions sizes.

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 include/net/page_pool/types.h   |  4 ++--
 include/net/page_pool/helpers.h | 10 +++++-----
 net/core/page_pool.c            | 10 +++++-----
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.h
index 5e43a08d3231..a6ebed002216 100644
--- a/include/net/page_pool/types.h
+++ b/include/net/page_pool/types.h
@@ -213,7 +213,7 @@ struct xdp_mem_info;
 #ifdef CONFIG_PAGE_POOL
 void page_pool_destroy(struct page_pool *pool);
 void page_pool_use_xdp_mem(struct page_pool *pool, void (*disconnect)(void *),
-			   struct xdp_mem_info *mem);
+			   const struct xdp_mem_info *mem);
 void page_pool_put_page_bulk(struct page_pool *pool, void **data,
 			     int count);
 #else
@@ -223,7 +223,7 @@ static inline void page_pool_destroy(struct page_pool *pool)
 
 static inline void page_pool_use_xdp_mem(struct page_pool *pool,
 					 void (*disconnect)(void *),
-					 struct xdp_mem_info *mem)
+					 const struct xdp_mem_info *mem)
 {
 }
 
diff --git a/include/net/page_pool/helpers.h b/include/net/page_pool/helpers.h
index 1d397c1a0043..c7bb06750e85 100644
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
@@ -370,7 +370,7 @@ static inline void page_pool_free_va(struct page_pool *pool, void *va,
  * Fetch the DMA address of the page. The page pool to which the page belongs
  * must had been created with PP_FLAG_DMA_MAP.
  */
-static inline dma_addr_t page_pool_get_dma_addr(struct page *page)
+static inline dma_addr_t page_pool_get_dma_addr(const struct page *page)
 {
 	dma_addr_t ret = page->dma_addr;
 
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index d706fe5548df..a8a1c087f048 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -123,9 +123,9 @@ int page_pool_ethtool_stats_get_count(void)
 }
 EXPORT_SYMBOL(page_pool_ethtool_stats_get_count);
 
-u64 *page_pool_ethtool_stats_get(u64 *data, void *stats)
+u64 *page_pool_ethtool_stats_get(u64 *data, const void *stats)
 {
-	struct page_pool_stats *pool_stats = stats;
+	const struct page_pool_stats *pool_stats = stats;
 
 	*data++ = pool_stats->alloc_stats.fast;
 	*data++ = pool_stats->alloc_stats.slow;
@@ -383,8 +383,8 @@ static struct page *__page_pool_get_cached(struct page_pool *pool)
 	return page;
 }
 
-static void page_pool_dma_sync_for_device(struct page_pool *pool,
-					  struct page *page,
+static void page_pool_dma_sync_for_device(const struct page_pool *pool,
+					  const struct page *page,
 					  unsigned int dma_sync_size)
 {
 	dma_addr_t dma_addr = page_pool_get_dma_addr(page);
@@ -954,7 +954,7 @@ static void page_pool_release_retry(struct work_struct *wq)
 }
 
 void page_pool_use_xdp_mem(struct page_pool *pool, void (*disconnect)(void *),
-			   struct xdp_mem_info *mem)
+			   const struct xdp_mem_info *mem)
 {
 	refcount_inc(&pool->user_cnt);
 	pool->disconnect = disconnect;
-- 
2.44.0


