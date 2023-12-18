Return-Path: <linux-kernel+bounces-3507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13525816D2C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 12:59:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BB3D1C23375
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 11:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B625037D23;
	Mon, 18 Dec 2023 11:50:50 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 269BE374F2
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 11:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <zhouchengming@bytedance.com>
Date: Mon, 18 Dec 2023 11:50:33 +0000
Subject: [PATCH v3 3/6] mm/zswap: refactor out __zswap_load()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231213-zswap-dstmem-v3-3-4eac09b94ece@bytedance.com>
References: <20231213-zswap-dstmem-v3-0-4eac09b94ece@bytedance.com>
In-Reply-To: <20231213-zswap-dstmem-v3-0-4eac09b94ece@bytedance.com>
To: Seth Jennings <sjenning@redhat.com>, Yosry Ahmed <yosryahmed@google.com>, Vitaly Wool <vitaly.wool@konsulko.com>,
 Dan Streetman <ddstreet@ieee.org>, Johannes Weiner <hannes@cmpxchg.org>, Chris Li <chriscli@google.com>,
 Andrew Morton <akpm@linux-foundation.org>, Nhat Pham <nphamcs@gmail.com>
Cc: Chris Li <chrisl@kernel.org>, Yosry Ahmed <yosryahmed@google.com>, linux-kernel@vger.kernel.org,
 Chengming Zhou <zhouchengming@bytedance.com>, linux-mm@kvack.org, Nhat Pham <nphamcs@gmail.com>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1702900234; l=4703;
 i=zhouchengming@bytedance.com; s=20231204; h=from:subject:message-id;
 bh=B99wC6AH9+R5m6Djw0+W/AJA7ag/bUbsLCKvYrrlo8Q=;
 b=ild77L3TDGLGQu8Eca6JaXi/fIaO5CaZVqyj/qCaIHMIACqX9eH+pkWshvQ4Y9TZWp3ytCZsC
 rYJYgewIBt6BWiDIhPEOZvJMVJypVdwjYuUQ0PbiowCtIZh16LIxHdH
X-Developer-Key: i=zhouchengming@bytedance.com; a=ed25519;
 pk=xFTmRtMG3vELGJBUiml7OYNdM393WOMv0iWWeQEVVdA=
X-Migadu-Flow: FLOW_OUT

The zswap_load() and zswap_writeback_entry() have the same part that
decompress the data from zswap_entry to page, so refactor out the
common part as __zswap_load(entry, page).

Reviewed-by: Nhat Pham <nphamcs@gmail.com>
Reviewed-by: Yosry Ahmed <yosryahmed@google.com>
Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 mm/zswap.c | 92 ++++++++++++++++++++++----------------------------------------
 1 file changed, 32 insertions(+), 60 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index 6b872744e962..3433bd6b3cef 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1392,6 +1392,35 @@ static int zswap_enabled_param_set(const char *val,
 	return ret;
 }
 
+static void __zswap_load(struct zswap_entry *entry, struct page *page)
+{
+	struct zpool *zpool = zswap_find_zpool(entry);
+	struct scatterlist input, output;
+	struct crypto_acomp_ctx *acomp_ctx;
+	u8 *src;
+
+	acomp_ctx = raw_cpu_ptr(entry->pool->acomp_ctx);
+	mutex_lock(acomp_ctx->mutex);
+
+	src = zpool_map_handle(zpool, entry->handle, ZPOOL_MM_RO);
+	if (!zpool_can_sleep_mapped(zpool)) {
+		memcpy(acomp_ctx->dstmem, src, entry->length);
+		src = acomp_ctx->dstmem;
+		zpool_unmap_handle(zpool, entry->handle);
+	}
+
+	sg_init_one(&input, src, entry->length);
+	sg_init_table(&output, 1);
+	sg_set_page(&output, page, PAGE_SIZE, 0);
+	acomp_request_set_params(acomp_ctx->req, &input, &output, entry->length, PAGE_SIZE);
+	BUG_ON(crypto_wait_req(crypto_acomp_decompress(acomp_ctx->req), &acomp_ctx->wait));
+	BUG_ON(acomp_ctx->req->dlen != PAGE_SIZE);
+	mutex_unlock(acomp_ctx->mutex);
+
+	if (zpool_can_sleep_mapped(zpool))
+		zpool_unmap_handle(zpool, entry->handle);
+}
+
 /*********************************
 * writeback code
 **********************************/
@@ -1413,12 +1442,7 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
 	swp_entry_t swpentry = entry->swpentry;
 	struct page *page;
 	struct mempolicy *mpol;
-	struct scatterlist input, output;
-	struct crypto_acomp_ctx *acomp_ctx;
-	struct zpool *pool = zswap_find_zpool(entry);
 	bool page_was_allocated;
-	u8 *src;
-	unsigned int dlen;
 	int ret;
 	struct writeback_control wbc = {
 		.sync_mode = WB_SYNC_NONE,
@@ -1456,31 +1480,7 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
 	}
 	spin_unlock(&tree->lock);
 
-	/* decompress */
-	acomp_ctx = raw_cpu_ptr(entry->pool->acomp_ctx);
-	dlen = PAGE_SIZE;
-	mutex_lock(acomp_ctx->mutex);
-
-	src = zpool_map_handle(pool, entry->handle, ZPOOL_MM_RO);
-	if (!zpool_can_sleep_mapped(pool)) {
-		memcpy(acomp_ctx->dstmem, src, entry->length);
-		src = acomp_ctx->dstmem;
-		zpool_unmap_handle(pool, entry->handle);
-	}
-
-	sg_init_one(&input, src, entry->length);
-	sg_init_table(&output, 1);
-	sg_set_page(&output, page, PAGE_SIZE, 0);
-	acomp_request_set_params(acomp_ctx->req, &input, &output, entry->length, dlen);
-	ret = crypto_wait_req(crypto_acomp_decompress(acomp_ctx->req), &acomp_ctx->wait);
-	dlen = acomp_ctx->req->dlen;
-	mutex_unlock(acomp_ctx->mutex);
-
-	if (zpool_can_sleep_mapped(pool))
-		zpool_unmap_handle(pool, entry->handle);
-
-	BUG_ON(ret);
-	BUG_ON(dlen != PAGE_SIZE);
+	__zswap_load(entry, page);
 
 	/* page is up to date */
 	SetPageUptodate(page);
@@ -1758,11 +1758,7 @@ bool zswap_load(struct folio *folio)
 	struct page *page = &folio->page;
 	struct zswap_tree *tree = zswap_trees[type];
 	struct zswap_entry *entry;
-	struct scatterlist input, output;
-	struct crypto_acomp_ctx *acomp_ctx;
-	u8 *src, *dst;
-	struct zpool *zpool;
-	unsigned int dlen;
+	u8 *dst;
 	bool ret;
 
 	VM_WARN_ON_ONCE(!folio_test_locked(folio));
@@ -1784,31 +1780,7 @@ bool zswap_load(struct folio *folio)
 		goto stats;
 	}
 
-	zpool = zswap_find_zpool(entry);
-
-	/* decompress */
-	dlen = PAGE_SIZE;
-	acomp_ctx = raw_cpu_ptr(entry->pool->acomp_ctx);
-	mutex_lock(acomp_ctx->mutex);
-
-	src = zpool_map_handle(zpool, entry->handle, ZPOOL_MM_RO);
-	if (!zpool_can_sleep_mapped(zpool)) {
-		memcpy(acomp_ctx->dstmem, src, entry->length);
-		src = acomp_ctx->dstmem;
-		zpool_unmap_handle(zpool, entry->handle);
-	}
-
-	sg_init_one(&input, src, entry->length);
-	sg_init_table(&output, 1);
-	sg_set_page(&output, page, PAGE_SIZE, 0);
-	acomp_request_set_params(acomp_ctx->req, &input, &output, entry->length, dlen);
-	if (crypto_wait_req(crypto_acomp_decompress(acomp_ctx->req), &acomp_ctx->wait))
-		WARN_ON(1);
-	mutex_unlock(acomp_ctx->mutex);
-
-	if (zpool_can_sleep_mapped(zpool))
-		zpool_unmap_handle(zpool, entry->handle);
-
+	__zswap_load(entry, page);
 	ret = true;
 stats:
 	count_vm_event(ZSWPIN);

-- 
b4 0.10.1

