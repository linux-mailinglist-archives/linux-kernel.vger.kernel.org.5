Return-Path: <linux-kernel+bounces-3510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43D0F816D2F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 13:00:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5D651F20F0C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 12:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D976C39879;
	Mon, 18 Dec 2023 11:50:56 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from out-176.mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F55938F94
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 11:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <zhouchengming@bytedance.com>
Date: Mon, 18 Dec 2023 11:50:36 +0000
Subject: [PATCH v3 6/6] mm/zswap: directly use percpu mutex and buffer in load/store
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231213-zswap-dstmem-v3-6-4eac09b94ece@bytedance.com>
References: <20231213-zswap-dstmem-v3-0-4eac09b94ece@bytedance.com>
In-Reply-To: <20231213-zswap-dstmem-v3-0-4eac09b94ece@bytedance.com>
To: Seth Jennings <sjenning@redhat.com>, Yosry Ahmed <yosryahmed@google.com>, Vitaly Wool <vitaly.wool@konsulko.com>,
 Dan Streetman <ddstreet@ieee.org>, Johannes Weiner <hannes@cmpxchg.org>, Chris Li <chriscli@google.com>,
 Andrew Morton <akpm@linux-foundation.org>, Nhat Pham <nphamcs@gmail.com>
Cc: Chris Li <chrisl@kernel.org>, Yosry Ahmed <yosryahmed@google.com>, linux-kernel@vger.kernel.org,
 Chengming Zhou <zhouchengming@bytedance.com>, linux-mm@kvack.org, Nhat Pham <nphamcs@gmail.com>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1702900234; l=6471;
 i=zhouchengming@bytedance.com; s=20231204; h=from:subject:message-id;
 bh=culrrHCm/Hf4dwHwtvZ06lQ5NsEncVU/QGy2Bp4v+0o=;
 b=b7n0OpxYpR3XA5GiwrtGYchVJRrAlhz5jqYK7l+kMC6lZWSSrzA4mZoc1L8QALpl7yA1Z8BpB
 gUTc5av/dY8AUdT5lUxvytYE9E+8PlB9bUSPPKrHM97afZKBM0ohjLG
X-Developer-Key: i=zhouchengming@bytedance.com; a=ed25519;
 pk=xFTmRtMG3vELGJBUiml7OYNdM393WOMv0iWWeQEVVdA=
X-Migadu-Flow: FLOW_OUT

Since the introduce of reusing the dstmem in the load path, it seems
confusing that we are now using acomp_ctx->dstmem and acomp_ctx->mutex
now for purposes other than what the naming suggests.

Yosry suggested removing these two fields from acomp_ctx, and directly
using zswap_dstmem and zswap_mutex in both the load and store paths,
rename them, and add proper comments above their definitions that they
are for generic percpu buffering on the load and store paths.

So this patch remove dstmem and mutex from acomp_ctx, and rename the
zswap_dstmem to zswap_buffer, using the percpu mutex and buffer on
the load and store paths.

Suggested-by: Yosry Ahmed <yosryahmed@google.com>
Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 mm/zswap.c | 69 +++++++++++++++++++++++++++++++++-----------------------------
 1 file changed, 37 insertions(+), 32 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index 2c349fd88904..71bdcd552e5b 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -166,8 +166,6 @@ struct crypto_acomp_ctx {
 	struct crypto_acomp *acomp;
 	struct acomp_req *req;
 	struct crypto_wait wait;
-	u8 *dstmem;
-	struct mutex *mutex;
 };
 
 /*
@@ -694,7 +692,7 @@ static void zswap_alloc_shrinker(struct zswap_pool *pool)
 /*********************************
 * per-cpu code
 **********************************/
-static DEFINE_PER_CPU(u8 *, zswap_dstmem);
+static DEFINE_PER_CPU(u8 *, zswap_buffer);
 /*
  * If users dynamically change the zpool type and compressor at runtime, i.e.
  * zswap is running, zswap can have more than one zpool on one cpu, but they
@@ -702,39 +700,39 @@ static DEFINE_PER_CPU(u8 *, zswap_dstmem);
  */
 static DEFINE_PER_CPU(struct mutex *, zswap_mutex);
 
-static int zswap_dstmem_prepare(unsigned int cpu)
+static int zswap_buffer_prepare(unsigned int cpu)
 {
 	struct mutex *mutex;
-	u8 *dst;
+	u8 *buf;
 
-	dst = kmalloc_node(PAGE_SIZE, GFP_KERNEL, cpu_to_node(cpu));
-	if (!dst)
+	buf = kmalloc_node(PAGE_SIZE, GFP_KERNEL, cpu_to_node(cpu));
+	if (!buf)
 		return -ENOMEM;
 
 	mutex = kmalloc_node(sizeof(*mutex), GFP_KERNEL, cpu_to_node(cpu));
 	if (!mutex) {
-		kfree(dst);
+		kfree(buf);
 		return -ENOMEM;
 	}
 
 	mutex_init(mutex);
-	per_cpu(zswap_dstmem, cpu) = dst;
+	per_cpu(zswap_buffer, cpu) = buf;
 	per_cpu(zswap_mutex, cpu) = mutex;
 	return 0;
 }
 
-static int zswap_dstmem_dead(unsigned int cpu)
+static int zswap_buffer_dead(unsigned int cpu)
 {
 	struct mutex *mutex;
-	u8 *dst;
+	u8 *buf;
 
 	mutex = per_cpu(zswap_mutex, cpu);
 	kfree(mutex);
 	per_cpu(zswap_mutex, cpu) = NULL;
 
-	dst = per_cpu(zswap_dstmem, cpu);
-	kfree(dst);
-	per_cpu(zswap_dstmem, cpu) = NULL;
+	buf = per_cpu(zswap_buffer, cpu);
+	kfree(buf);
+	per_cpu(zswap_buffer, cpu) = NULL;
 
 	return 0;
 }
@@ -772,9 +770,6 @@ static int zswap_cpu_comp_prepare(unsigned int cpu, struct hlist_node *node)
 	acomp_request_set_callback(req, CRYPTO_TFM_REQ_MAY_BACKLOG,
 				   crypto_req_done, &acomp_ctx->wait);
 
-	acomp_ctx->mutex = per_cpu(zswap_mutex, cpu);
-	acomp_ctx->dstmem = per_cpu(zswap_dstmem, cpu);
-
 	return 0;
 }
 
@@ -1397,15 +1392,21 @@ static void __zswap_load(struct zswap_entry *entry, struct page *page)
 	struct zpool *zpool = zswap_find_zpool(entry);
 	struct scatterlist input, output;
 	struct crypto_acomp_ctx *acomp_ctx;
-	u8 *src;
+	u8 *src, *buf;
+	int cpu;
+	struct mutex *mutex;
 
-	acomp_ctx = raw_cpu_ptr(entry->pool->acomp_ctx);
-	mutex_lock(acomp_ctx->mutex);
+	cpu = raw_smp_processor_id();
+	mutex = per_cpu(zswap_mutex, cpu);
+	mutex_lock(mutex);
+
+	acomp_ctx = per_cpu_ptr(entry->pool->acomp_ctx, cpu);
 
 	src = zpool_map_handle(zpool, entry->handle, ZPOOL_MM_RO);
 	if (!zpool_can_sleep_mapped(zpool)) {
-		memcpy(acomp_ctx->dstmem, src, entry->length);
-		src = acomp_ctx->dstmem;
+		buf = per_cpu(zswap_buffer, cpu);
+		memcpy(buf, src, entry->length);
+		src = buf;
 		zpool_unmap_handle(zpool, entry->handle);
 	}
 
@@ -1415,7 +1416,7 @@ static void __zswap_load(struct zswap_entry *entry, struct page *page)
 	acomp_request_set_params(acomp_ctx->req, &input, &output, entry->length, PAGE_SIZE);
 	BUG_ON(crypto_wait_req(crypto_acomp_decompress(acomp_ctx->req), &acomp_ctx->wait));
 	BUG_ON(acomp_ctx->req->dlen != PAGE_SIZE);
-	mutex_unlock(acomp_ctx->mutex);
+	mutex_unlock(mutex);
 
 	if (zpool_can_sleep_mapped(zpool))
 		zpool_unmap_handle(zpool, entry->handle);
@@ -1551,6 +1552,8 @@ bool zswap_store(struct folio *folio)
 	u8 *src, *dst;
 	gfp_t gfp;
 	int ret;
+	int cpu;
+	struct mutex *mutex;
 
 	VM_WARN_ON_ONCE(!folio_test_locked(folio));
 	VM_WARN_ON_ONCE(!folio_test_swapcache(folio));
@@ -1636,11 +1639,13 @@ bool zswap_store(struct folio *folio)
 	}
 
 	/* compress */
-	acomp_ctx = raw_cpu_ptr(entry->pool->acomp_ctx);
+	cpu = raw_smp_processor_id();
+	mutex = per_cpu(zswap_mutex, cpu);
+	mutex_lock(mutex);
 
-	mutex_lock(acomp_ctx->mutex);
+	acomp_ctx = per_cpu_ptr(entry->pool->acomp_ctx, cpu);
+	dst = per_cpu(zswap_buffer, cpu);
 
-	dst = acomp_ctx->dstmem;
 	sg_init_table(&input, 1);
 	sg_set_page(&input, page, PAGE_SIZE, 0);
 
@@ -1683,7 +1688,7 @@ bool zswap_store(struct folio *folio)
 	buf = zpool_map_handle(zpool, handle, ZPOOL_MM_WO);
 	memcpy(buf, dst, dlen);
 	zpool_unmap_handle(zpool, handle);
-	mutex_unlock(acomp_ctx->mutex);
+	mutex_unlock(mutex);
 
 	/* populate entry */
 	entry->swpentry = swp_entry(type, offset);
@@ -1726,7 +1731,7 @@ bool zswap_store(struct folio *folio)
 	return true;
 
 put_dstmem:
-	mutex_unlock(acomp_ctx->mutex);
+	mutex_unlock(mutex);
 put_pool:
 	zswap_pool_put(entry->pool);
 freepage:
@@ -1902,10 +1907,10 @@ static int zswap_setup(void)
 	}
 
 	ret = cpuhp_setup_state(CPUHP_MM_ZSWP_MEM_PREPARE, "mm/zswap:prepare",
-				zswap_dstmem_prepare, zswap_dstmem_dead);
+				zswap_buffer_prepare, zswap_buffer_dead);
 	if (ret) {
-		pr_err("dstmem alloc failed\n");
-		goto dstmem_fail;
+		pr_err("buffer alloc failed\n");
+		goto buffer_fail;
 	}
 
 	ret = cpuhp_setup_state_multi(CPUHP_MM_ZSWP_POOL_PREPARE,
@@ -1940,7 +1945,7 @@ static int zswap_setup(void)
 		zswap_pool_destroy(pool);
 hp_fail:
 	cpuhp_remove_state(CPUHP_MM_ZSWP_MEM_PREPARE);
-dstmem_fail:
+buffer_fail:
 	kmem_cache_destroy(zswap_entry_cache);
 cache_fail:
 	/* if built-in, we aren't unloaded on failure; don't allow use */

-- 
b4 0.10.1

