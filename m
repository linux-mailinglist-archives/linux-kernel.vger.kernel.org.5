Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD444810909
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 05:19:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378423AbjLMESX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 23:18:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235222AbjLMESS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 23:18:18 -0500
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [IPv6:2001:41d0:1004:224b::b3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E6D4AC
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 20:18:24 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Chengming Zhou <zhouchengming@bytedance.com>
Date:   Wed, 13 Dec 2023 04:17:58 +0000
Subject: [PATCH 1/5] mm/zswap: reuse dstmem when decompress
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231213-zswap-dstmem-v1-1-896763369d04@bytedance.com>
References: <20231213-zswap-dstmem-v1-0-896763369d04@bytedance.com>
In-Reply-To: <20231213-zswap-dstmem-v1-0-896763369d04@bytedance.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Nhat Pham <nphamcs@gmail.com>, Chris Li <chriscli@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        Yosry Ahmed <yosryahmed@google.com>
Cc:     Nhat Pham <nphamcs@gmail.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Chengming Zhou <zhouchengming@bytedance.com>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1702441093; l=2420;
 i=zhouchengming@bytedance.com; s=20231204; h=from:subject:message-id;
 bh=4hmeraw6zxa25WbpK1ECDI7EvpvobxeRhEkruBDznLg=;
 b=mbsWJQiE+cXMa66hJjNiMeb6vb0c2Wd9Q8gByBTeYUg30xknG8Mp4sD3keTJZ+y7+jzNC8l+X
 ujPVN2QVCJ9BZB6v/vneplbZq2p6q14W2exDJ4xuhzyTJtIF+0z++Bz
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

In the !zpool_can_sleep_mapped() case such as zsmalloc, we need to first
copy the entry->handle memory to a temporary memory, which is allocated
using kmalloc.

Obviously we can reuse the per-compressor dstmem to avoid allocating
every time, since it's percpu-compressor and protected in mutex.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
Reviewed-by: Nhat Pham <nphamcs@gmail.com>
---
 mm/zswap.c | 29 +++++++++--------------------
 1 file changed, 9 insertions(+), 20 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index 7ee54a3d8281..edb8b45ed5a1 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1772,9 +1772,9 @@ bool zswap_load(struct folio *folio)
 	struct zswap_entry *entry;
 	struct scatterlist input, output;
 	struct crypto_acomp_ctx *acomp_ctx;
-	u8 *src, *dst, *tmp;
+	unsigned int dlen = PAGE_SIZE;
+	u8 *src, *dst;
 	struct zpool *zpool;
-	unsigned int dlen;
 	bool ret;
 
 	VM_WARN_ON_ONCE(!folio_test_locked(folio));
@@ -1796,27 +1796,18 @@ bool zswap_load(struct folio *folio)
 		goto stats;
 	}
 
-	zpool = zswap_find_zpool(entry);
-	if (!zpool_can_sleep_mapped(zpool)) {
-		tmp = kmalloc(entry->length, GFP_KERNEL);
-		if (!tmp) {
-			ret = false;
-			goto freeentry;
-		}
-	}
-
 	/* decompress */
-	dlen = PAGE_SIZE;
-	src = zpool_map_handle(zpool, entry->handle, ZPOOL_MM_RO);
+	acomp_ctx = raw_cpu_ptr(entry->pool->acomp_ctx);
+	mutex_lock(acomp_ctx->mutex);
 
+	zpool = zswap_find_zpool(entry);
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
@@ -1827,15 +1818,13 @@ bool zswap_load(struct folio *folio)
 
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
