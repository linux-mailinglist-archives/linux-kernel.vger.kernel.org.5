Return-Path: <linux-kernel+bounces-3506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54E7B816D2B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 12:59:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B5A31C23346
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 11:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06B23374FF;
	Mon, 18 Dec 2023 11:50:49 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01F23715B
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 11:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <zhouchengming@bytedance.com>
Date: Mon, 18 Dec 2023 11:50:32 +0000
Subject: [PATCH v3 2/6] mm/zswap: reuse dstmem when decompress
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231213-zswap-dstmem-v3-2-4eac09b94ece@bytedance.com>
References: <20231213-zswap-dstmem-v3-0-4eac09b94ece@bytedance.com>
In-Reply-To: <20231213-zswap-dstmem-v3-0-4eac09b94ece@bytedance.com>
To: Seth Jennings <sjenning@redhat.com>, Yosry Ahmed <yosryahmed@google.com>, Vitaly Wool <vitaly.wool@konsulko.com>,
 Dan Streetman <ddstreet@ieee.org>, Johannes Weiner <hannes@cmpxchg.org>, Chris Li <chriscli@google.com>,
 Andrew Morton <akpm@linux-foundation.org>, Nhat Pham <nphamcs@gmail.com>
Cc: Chris Li <chrisl@kernel.org>, Yosry Ahmed <yosryahmed@google.com>, linux-kernel@vger.kernel.org,
 Chengming Zhou <zhouchengming@bytedance.com>, linux-mm@kvack.org, Nhat Pham <nphamcs@gmail.com>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1702900234; l=4279;
 i=zhouchengming@bytedance.com; s=20231204; h=from:subject:message-id;
 bh=JxHludCxMK0OPSXqNpXYMeMWjmEk17jj62CkEYJJ0Kc=;
 b=FkiCcWV+1XpQFAG5Ryg3DEVWXLZeHzNrlB7Z4iSS32PbvemI7sdMZ3kL9sbWdE9EZPQ8OiHKX
 xI4/eIK1X/tCF7SpnRPu4ma50Jp3RTDNqWgnkzjDcnf1OYQ4y7gNKV3
X-Developer-Key: i=zhouchengming@bytedance.com; a=ed25519;
 pk=xFTmRtMG3vELGJBUiml7OYNdM393WOMv0iWWeQEVVdA=
X-Migadu-Flow: FLOW_OUT

In the !zpool_can_sleep_mapped() case such as zsmalloc, we need to first
copy the entry->handle memory to a temporary memory, which is allocated
using kmalloc.

Obviously we can reuse the per-compressor dstmem to avoid allocating
every time, since it's percpu-compressor and protected in percpu mutex.

Reviewed-by: Nhat Pham <nphamcs@gmail.com>
Acked-by: Chris Li <chrisl@kernel.org>
Reviewed-by: Yosry Ahmed <yosryahmed@google.com>
Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 mm/zswap.c | 44 ++++++++++++--------------------------------
 1 file changed, 12 insertions(+), 32 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index 976f278aa507..6b872744e962 100644
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
@@ -1771,7 +1760,7 @@ bool zswap_load(struct folio *folio)
 	struct zswap_entry *entry;
 	struct scatterlist input, output;
 	struct crypto_acomp_ctx *acomp_ctx;
-	u8 *src, *dst, *tmp;
+	u8 *src, *dst;
 	struct zpool *zpool;
 	unsigned int dlen;
 	bool ret;
@@ -1796,26 +1785,19 @@ bool zswap_load(struct folio *folio)
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
@@ -1826,15 +1808,13 @@ bool zswap_load(struct folio *folio)
 
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

