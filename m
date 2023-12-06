Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF55C806B02
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 10:46:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377315AbjLFJqn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 04:46:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377296AbjLFJqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 04:46:38 -0500
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAD6DD40
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 01:46:43 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Chengming Zhou <zhouchengming@bytedance.com>
Date:   Wed, 06 Dec 2023 09:46:28 +0000
Subject: [PATCH 5/7] mm/zswap: refactor out __zswap_load()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231206-zswap-lock-optimize-v1-5-e25b059f9c3a@bytedance.com>
References: <20231206-zswap-lock-optimize-v1-0-e25b059f9c3a@bytedance.com>
In-Reply-To: <20231206-zswap-lock-optimize-v1-0-e25b059f9c3a@bytedance.com>
To:     Vitaly Wool <vitaly.wool@konsulko.com>,
        Nhat Pham <nphamcs@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yosry Ahmed <yosryahmed@google.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701855988; l=5290;
 i=zhouchengming@bytedance.com; s=20231204; h=from:subject:message-id;
 bh=ju3QBW8cgbkzkTilyJdKpdv6IgD35PF5PphWVt2TBXg=;
 b=sN2QzBgyvVSvfWoqMPvo+BA+Z/wX8hCyJ3NhGmP4yMNcUemm3UiYwXWjJiunDYw+3nKWn0X+s
 um4PqJ1hXePCeO2kEV8Gev6JvZihkII6L9Ti8GacRbiWlvx29DlAv96
X-Developer-Key: i=zhouchengming@bytedance.com; a=ed25519;
 pk=xFTmRtMG3vELGJBUiml7OYNdM393WOMv0iWWeQEVVdA=
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The zswap_load() and zswap_writeback_entry() have the same part that
decompress the data from zswap_entry to page, so refactor out the
common part as __zswap_load(entry, page).

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 mm/zswap.c | 108 ++++++++++++++++++++++---------------------------------------
 1 file changed, 39 insertions(+), 69 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index 999671dcb469..667b66a3911b 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1380,6 +1380,42 @@ static int zswap_enabled_param_set(const char *val,
 	return ret;
 }
 
+static void __zswap_load(struct zswap_entry *entry, struct page *page)
+{
+	struct scatterlist input, output;
+	unsigned int dlen = PAGE_SIZE;
+	struct crypto_acomp_ctx *acomp_ctx;
+	struct zpool *zpool;
+	u8 *src;
+	int ret;
+
+	/* decompress */
+	acomp_ctx = raw_cpu_ptr(entry->pool->acomp_ctx);
+	mutex_lock(acomp_ctx->mutex);
+
+	zpool = zswap_find_zpool(entry);
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
+	acomp_request_set_params(acomp_ctx->req, &input, &output, entry->length, dlen);
+	ret = crypto_wait_req(crypto_acomp_decompress(acomp_ctx->req), &acomp_ctx->wait);
+	dlen = acomp_ctx->req->dlen;
+	mutex_unlock(acomp_ctx->mutex);
+
+	if (zpool_can_sleep_mapped(zpool))
+		zpool_unmap_handle(zpool, entry->handle);
+
+	BUG_ON(ret);
+	BUG_ON(dlen != PAGE_SIZE);
+}
+
 /*********************************
 * writeback code
 **********************************/
@@ -1401,23 +1437,12 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
 	swp_entry_t swpentry = entry->swpentry;
 	struct page *page;
 	struct mempolicy *mpol;
-	struct scatterlist input, output;
-	struct crypto_acomp_ctx *acomp_ctx;
-	struct zpool *pool = zswap_find_zpool(entry);
 	bool page_was_allocated;
-	u8 *src, *tmp = NULL;
-	unsigned int dlen;
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
@@ -1450,33 +1475,7 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
 	}
 	spin_unlock(&tree->lock);
 
-	/* decompress */
-	acomp_ctx = raw_cpu_ptr(entry->pool->acomp_ctx);
-	dlen = PAGE_SIZE;
-
-	src = zpool_map_handle(pool, entry->handle, ZPOOL_MM_RO);
-	if (!zpool_can_sleep_mapped(pool)) {
-		memcpy(tmp, src, entry->length);
-		src = tmp;
-		zpool_unmap_handle(pool, entry->handle);
-	}
-
-	mutex_lock(acomp_ctx->mutex);
-	sg_init_one(&input, src, entry->length);
-	sg_init_table(&output, 1);
-	sg_set_page(&output, page, PAGE_SIZE, 0);
-	acomp_request_set_params(acomp_ctx->req, &input, &output, entry->length, dlen);
-	ret = crypto_wait_req(crypto_acomp_decompress(acomp_ctx->req), &acomp_ctx->wait);
-	dlen = acomp_ctx->req->dlen;
-	mutex_unlock(acomp_ctx->mutex);
-
-	if (!zpool_can_sleep_mapped(pool))
-		kfree(tmp);
-	else
-		zpool_unmap_handle(pool, entry->handle);
-
-	BUG_ON(ret);
-	BUG_ON(dlen != PAGE_SIZE);
+	__zswap_load(entry, page);
 
 	/* page is up to date */
 	SetPageUptodate(page);
@@ -1496,9 +1495,6 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
 	return ret;
 
 fail:
-	if (!zpool_can_sleep_mapped(pool))
-		kfree(tmp);
-
 	/*
 	 * If we get here because the page is already in swapcache, a
 	 * load may be happening concurrently. It is safe and okay to
@@ -1755,11 +1751,7 @@ bool zswap_load(struct folio *folio)
 	struct page *page = &folio->page;
 	struct zswap_tree *tree = swap_zswap_tree(swp);
 	struct zswap_entry *entry;
-	struct scatterlist input, output;
-	struct crypto_acomp_ctx *acomp_ctx;
-	unsigned int dlen = PAGE_SIZE;
-	u8 *src, *dst;
-	struct zpool *zpool;
+	u8 *dst;
 	bool ret;
 
 	VM_WARN_ON_ONCE(!folio_test_locked(folio));
@@ -1781,29 +1773,7 @@ bool zswap_load(struct folio *folio)
 		goto stats;
 	}
 
-	/* decompress */
-	acomp_ctx = raw_cpu_ptr(entry->pool->acomp_ctx);
-	mutex_lock(acomp_ctx->mutex);
-
-	zpool = zswap_find_zpool(entry);
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
