Return-Path: <linux-kernel+bounces-12541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97E6A81F67B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 10:47:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C5D91F225FA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 09:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBAB07468;
	Thu, 28 Dec 2023 09:46:26 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A036AA2
	for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 09:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <zhouchengming@bytedance.com>
Date: Thu, 28 Dec 2023 09:45:42 +0000
Subject: [PATCH v5 1/5] mm/zswap: reuse dstmem when decompress
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231213-zswap-dstmem-v5-1-9382162bbf05@bytedance.com>
References: <20231213-zswap-dstmem-v5-0-9382162bbf05@bytedance.com>
In-Reply-To: <20231213-zswap-dstmem-v5-0-9382162bbf05@bytedance.com>
To: Barry Song <21cnbao@gmail.com>, Yosry Ahmed <yosryahmed@google.com>, Nhat Pham <nphamcs@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>, Dan Streetman <ddstreet@ieee.org>, Vitaly Wool <vitaly.wool@konsulko.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Chris Li <chriscli@google.com>, Seth Jennings <sjenning@redhat.com>
Cc: Yosry Ahmed <yosryahmed@google.com>, Nhat Pham <nphamcs@gmail.com>, Chris Li <chrisl@kernel.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Chengming Zhou <zhouchengming@bytedance.com>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1703756775; l=4288;
 i=zhouchengming@bytedance.com; s=20231204; h=from:subject:message-id;
 bh=oTSr8h2HN5ZVvOErnBDPCcywNhpihCGwWVxYTWIN01A=;
 b=eZRaOUfTwA7ZmZqcFbY1sJcAk45CveTJ0kOs78M5taspw03yqX+HB6o5DFZ5Pe3HgwS+K9uVc
 H//cxrexvlCDM7yUYCt/hUgQCvkUWd1J3KZwst83q4EeCVmrfLBqRCg
X-Developer-Key: i=zhouchengming@bytedance.com; a=ed25519;
 pk=xFTmRtMG3vELGJBUiml7OYNdM393WOMv0iWWeQEVVdA=
X-Migadu-Flow: FLOW_OUT

In the !zpool_can_sleep_mapped() case such as zsmalloc, we need to first
copy the entry->handle memory to a temporary memory, which is allocated
using kmalloc.

Obviously we can reuse the per-compressor dstmem to avoid allocating
every time, since it's percpu-compressor and protected in percpu mutex.

Reviewed-by: Nhat Pham <nphamcs@gmail.com>
Reviewed-by: Yosry Ahmed <yosryahmed@google.com>
Acked-by: Chris Li <chrisl@kernel.org> (Google)
Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 mm/zswap.c | 44 ++++++++++++--------------------------------
 1 file changed, 12 insertions(+), 32 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index 7ee54a3d8281..41df2d97951b 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1417,19 +1417,13 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
 	struct crypto_acomp_ctx *acomp_ctx;
 	struct zpool *pool = zswap_find_zpool(entry);
 	bool page_was_allocated;
-	u8 *src, *tmp = NULL;
+	u8 *src;
 	unsigned int dlen;
 	int ret;
 	struct writeback_control wbc = {
 		.sync_mode = WB_SYNC_NONE,
 	};
 
-	if (!zpool_can_sleep_mapped(pool)) {
-		tmp = kmalloc(PAGE_SIZE, GFP_KERNEL);
-		if (!tmp)
-			return -ENOMEM;
-	}
-
 	/* try to allocate swap cache page */
 	mpol = get_task_policy(current);
 	page = __read_swap_cache_async(swpentry, GFP_KERNEL, mpol,
@@ -1465,15 +1459,15 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
 	/* decompress */
 	acomp_ctx = raw_cpu_ptr(entry->pool->acomp_ctx);
 	dlen = PAGE_SIZE;
+	mutex_lock(acomp_ctx->mutex);
 
 	src = zpool_map_handle(pool, entry->handle, ZPOOL_MM_RO);
 	if (!zpool_can_sleep_mapped(pool)) {
-		memcpy(tmp, src, entry->length);
-		src = tmp;
+		memcpy(acomp_ctx->dstmem, src, entry->length);
+		src = acomp_ctx->dstmem;
 		zpool_unmap_handle(pool, entry->handle);
 	}
 
-	mutex_lock(acomp_ctx->mutex);
 	sg_init_one(&input, src, entry->length);
 	sg_init_table(&output, 1);
 	sg_set_page(&output, page, PAGE_SIZE, 0);
@@ -1482,9 +1476,7 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
 	dlen = acomp_ctx->req->dlen;
 	mutex_unlock(acomp_ctx->mutex);
 
-	if (!zpool_can_sleep_mapped(pool))
-		kfree(tmp);
-	else
+	if (zpool_can_sleep_mapped(pool))
 		zpool_unmap_handle(pool, entry->handle);
 
 	BUG_ON(ret);
@@ -1508,9 +1500,6 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
 	return ret;
 
 fail:
-	if (!zpool_can_sleep_mapped(pool))
-		kfree(tmp);
-
 	/*
 	 * If we get here because the page is already in swapcache, a
 	 * load may be happening concurrently. It is safe and okay to
@@ -1772,7 +1761,7 @@ bool zswap_load(struct folio *folio)
 	struct zswap_entry *entry;
 	struct scatterlist input, output;
 	struct crypto_acomp_ctx *acomp_ctx;
-	u8 *src, *dst, *tmp;
+	u8 *src, *dst;
 	struct zpool *zpool;
 	unsigned int dlen;
 	bool ret;
@@ -1797,26 +1786,19 @@ bool zswap_load(struct folio *folio)
 	}
 
 	zpool = zswap_find_zpool(entry);
-	if (!zpool_can_sleep_mapped(zpool)) {
-		tmp = kmalloc(entry->length, GFP_KERNEL);
-		if (!tmp) {
-			ret = false;
-			goto freeentry;
-		}
-	}
 
 	/* decompress */
 	dlen = PAGE_SIZE;
-	src = zpool_map_handle(zpool, entry->handle, ZPOOL_MM_RO);
+	acomp_ctx = raw_cpu_ptr(entry->pool->acomp_ctx);
+	mutex_lock(acomp_ctx->mutex);
 
+	src = zpool_map_handle(zpool, entry->handle, ZPOOL_MM_RO);
 	if (!zpool_can_sleep_mapped(zpool)) {
-		memcpy(tmp, src, entry->length);
-		src = tmp;
+		memcpy(acomp_ctx->dstmem, src, entry->length);
+		src = acomp_ctx->dstmem;
 		zpool_unmap_handle(zpool, entry->handle);
 	}
 
-	acomp_ctx = raw_cpu_ptr(entry->pool->acomp_ctx);
-	mutex_lock(acomp_ctx->mutex);
 	sg_init_one(&input, src, entry->length);
 	sg_init_table(&output, 1);
 	sg_set_page(&output, page, PAGE_SIZE, 0);
@@ -1827,15 +1809,13 @@ bool zswap_load(struct folio *folio)
 
 	if (zpool_can_sleep_mapped(zpool))
 		zpool_unmap_handle(zpool, entry->handle);
-	else
-		kfree(tmp);
 
 	ret = true;
 stats:
 	count_vm_event(ZSWPIN);
 	if (entry->objcg)
 		count_objcg_event(entry->objcg, ZSWPIN);
-freeentry:
+
 	spin_lock(&tree->lock);
 	if (ret && zswap_exclusive_loads_enabled) {
 		zswap_invalidate_entry(tree, entry);

-- 
b4 0.10.1

