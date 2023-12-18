Return-Path: <linux-kernel+bounces-3153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73FA08167FB
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 09:24:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94F541C2089D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 08:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CAA41173F;
	Mon, 18 Dec 2023 08:22:48 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FCDE111A2
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 08:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <zhouchengming@bytedance.com>
Date: Mon, 18 Dec 2023 08:22:05 +0000
Subject: [PATCH v2 6/6] mm/zswap: directly use percpu mutex and buffer in load/store
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231213-zswap-dstmem-v2-6-daa5d9ae41a7@bytedance.com>
References: <20231213-zswap-dstmem-v2-0-daa5d9ae41a7@bytedance.com>
In-Reply-To: <20231213-zswap-dstmem-v2-0-daa5d9ae41a7@bytedance.com>
To: Seth Jennings <sjenning@redhat.com>, Dan Streetman <ddstreet@ieee.org>, Chris Li <chriscli@google.com>,
 Nhat Pham <nphamcs@gmail.com>, Vitaly Wool <vitaly.wool@konsulko.com>, Yosry Ahmed <yosryahmed@google.com>,
 Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>
Cc: linux-kernel@vger.kernel.org, Nhat Pham <nphamcs@gmail.com>, linux-mm@kvack.org, Yosry Ahmed <yosryahmed@google.com>,
 Chengming Zhou <zhouchengming@bytedance.com>, Chris Li <chrisl@kernel.org>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1702887745; l=10608;
 i=zhouchengming@bytedance.com; s=20231204; h=from:subject:message-id;
 bh=k6WkjFerLmMPPnB4BHXU0oLODY4+tgFUEVqHpaqy/GE=;
 b=L3QlA6B3Z8gMjlH/tKC9DFpE0gONp9++QxZWqj4jttxtA28i2k06FoJnhzPXl2dTnUCRe0O2I
 /yfAOqL4yTTBVAWzMzyY/vp/6g77noItOcvUhDa+h91UaW5hpum/Bxo
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
the load and store paths. And refactor out __zswap_store() to only
include the compress & store, since I found zswap_store() is too long.

Suggested-by: Yosry Ahmed <yosryahmed@google.com>
Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 mm/zswap.c | 193 +++++++++++++++++++++++++++++++++----------------------------
 1 file changed, 104 insertions(+), 89 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index 2c349fd88904..b7449294ec3a 100644
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
 
@@ -1392,20 +1387,98 @@ static int zswap_enabled_param_set(const char *val,
 	return ret;
 }
 
+static int __zswap_store(struct zswap_entry *entry, struct page *page)
+{
+	struct scatterlist input, output;
+	struct crypto_acomp_ctx *acomp_ctx;
+	struct zpool *zpool;
+	unsigned long handle;
+	unsigned int dlen;
+	u8 *buf, *dst;
+	gfp_t gfp;
+	int ret;
+	int cpu;
+	struct mutex *mutex;
+
+	cpu = raw_smp_processor_id();
+	mutex = per_cpu(zswap_mutex, cpu);
+	mutex_lock(mutex);
+
+	acomp_ctx = per_cpu_ptr(entry->pool->acomp_ctx, cpu);
+	buf = per_cpu(zswap_buffer, cpu);
+
+	sg_init_table(&input, 1);
+	sg_set_page(&input, page, PAGE_SIZE, 0);
+	sg_init_one(&output, buf, PAGE_SIZE);
+	acomp_request_set_params(acomp_ctx->req, &input, &output, PAGE_SIZE, PAGE_SIZE);
+	/*
+	 * it maybe looks a little bit silly that we send an asynchronous request,
+	 * then wait for its completion synchronously. This makes the process look
+	 * synchronous in fact.
+	 * Theoretically, acomp supports users send multiple acomp requests in one
+	 * acomp instance, then get those requests done simultaneously. but in this
+	 * case, zswap actually does store and load page by page, there is no
+	 * existing method to send the second page before the first page is done
+	 * in one thread doing zwap.
+	 * but in different threads running on different cpu, we have different
+	 * acomp instance, so multiple threads can do (de)compression in parallel.
+	 */
+	ret = crypto_wait_req(crypto_acomp_compress(acomp_ctx->req), &acomp_ctx->wait);
+	dlen = acomp_ctx->req->dlen;
+
+	if (ret) {
+		zswap_reject_compress_fail++;
+		goto unlock;
+	}
+
+	/* store */
+	zpool = zswap_find_zpool(entry);
+	gfp = __GFP_NORETRY | __GFP_NOWARN | __GFP_KSWAPD_RECLAIM;
+	if (zpool_malloc_support_movable(zpool))
+		gfp |= __GFP_HIGHMEM | __GFP_MOVABLE;
+	ret = zpool_malloc(zpool, dlen, gfp, &handle);
+	if (ret == -ENOSPC) {
+		zswap_reject_compress_poor++;
+		goto unlock;
+	}
+	if (ret) {
+		zswap_reject_alloc_fail++;
+		goto unlock;
+	}
+	dst = zpool_map_handle(zpool, handle, ZPOOL_MM_WO);
+	memcpy(dst, buf, dlen);
+	zpool_unmap_handle(zpool, handle);
+	mutex_unlock(mutex);
+
+	entry->handle = handle;
+	entry->length = dlen;
+	return 0;
+
+unlock:
+	mutex_unlock(mutex);
+	return ret;
+}
+
 static void __zswap_load(struct zswap_entry *entry, struct page *page)
 {
 	struct zpool *zpool = zswap_find_zpool(entry);
 	struct scatterlist input, output;
 	struct crypto_acomp_ctx *acomp_ctx;
-	u8 *src;
+	u8 *src, *buf;
+	int cpu;
+	struct mutex *mutex;
+
+	cpu = raw_smp_processor_id();
+	mutex = per_cpu(zswap_mutex, cpu);
+	mutex_lock(mutex);
 
-	acomp_ctx = raw_cpu_ptr(entry->pool->acomp_ctx);
-	mutex_lock(acomp_ctx->mutex);
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
 
@@ -1415,7 +1488,7 @@ static void __zswap_load(struct zswap_entry *entry, struct page *page)
 	acomp_request_set_params(acomp_ctx->req, &input, &output, entry->length, PAGE_SIZE);
 	BUG_ON(crypto_wait_req(crypto_acomp_decompress(acomp_ctx->req), &acomp_ctx->wait));
 	BUG_ON(acomp_ctx->req->dlen != PAGE_SIZE);
-	mutex_unlock(acomp_ctx->mutex);
+	mutex_unlock(mutex);
 
 	if (zpool_can_sleep_mapped(zpool))
 		zpool_unmap_handle(zpool, entry->handle);
@@ -1539,18 +1612,11 @@ bool zswap_store(struct folio *folio)
 	struct page *page = &folio->page;
 	struct zswap_tree *tree = zswap_trees[type];
 	struct zswap_entry *entry, *dupentry;
-	struct scatterlist input, output;
-	struct crypto_acomp_ctx *acomp_ctx;
 	struct obj_cgroup *objcg = NULL;
 	struct mem_cgroup *memcg = NULL;
 	struct zswap_pool *pool;
-	struct zpool *zpool;
-	unsigned int dlen = PAGE_SIZE;
-	unsigned long handle, value;
-	char *buf;
-	u8 *src, *dst;
-	gfp_t gfp;
-	int ret;
+	u8 *src;
+	unsigned long value;
 
 	VM_WARN_ON_ONCE(!folio_test_locked(folio));
 	VM_WARN_ON_ONCE(!folio_test_swapcache(folio));
@@ -1635,60 +1701,11 @@ bool zswap_store(struct folio *folio)
 		mem_cgroup_put(memcg);
 	}
 
-	/* compress */
-	acomp_ctx = raw_cpu_ptr(entry->pool->acomp_ctx);
-
-	mutex_lock(acomp_ctx->mutex);
-
-	dst = acomp_ctx->dstmem;
-	sg_init_table(&input, 1);
-	sg_set_page(&input, page, PAGE_SIZE, 0);
-
-	sg_init_one(&output, dst, PAGE_SIZE);
-	acomp_request_set_params(acomp_ctx->req, &input, &output, PAGE_SIZE, dlen);
-	/*
-	 * it maybe looks a little bit silly that we send an asynchronous request,
-	 * then wait for its completion synchronously. This makes the process look
-	 * synchronous in fact.
-	 * Theoretically, acomp supports users send multiple acomp requests in one
-	 * acomp instance, then get those requests done simultaneously. but in this
-	 * case, zswap actually does store and load page by page, there is no
-	 * existing method to send the second page before the first page is done
-	 * in one thread doing zwap.
-	 * but in different threads running on different cpu, we have different
-	 * acomp instance, so multiple threads can do (de)compression in parallel.
-	 */
-	ret = crypto_wait_req(crypto_acomp_compress(acomp_ctx->req), &acomp_ctx->wait);
-	dlen = acomp_ctx->req->dlen;
-
-	if (ret) {
-		zswap_reject_compress_fail++;
-		goto put_dstmem;
-	}
-
-	/* store */
-	zpool = zswap_find_zpool(entry);
-	gfp = __GFP_NORETRY | __GFP_NOWARN | __GFP_KSWAPD_RECLAIM;
-	if (zpool_malloc_support_movable(zpool))
-		gfp |= __GFP_HIGHMEM | __GFP_MOVABLE;
-	ret = zpool_malloc(zpool, dlen, gfp, &handle);
-	if (ret == -ENOSPC) {
-		zswap_reject_compress_poor++;
-		goto put_dstmem;
-	}
-	if (ret) {
-		zswap_reject_alloc_fail++;
-		goto put_dstmem;
-	}
-	buf = zpool_map_handle(zpool, handle, ZPOOL_MM_WO);
-	memcpy(buf, dst, dlen);
-	zpool_unmap_handle(zpool, handle);
-	mutex_unlock(acomp_ctx->mutex);
+	if (__zswap_store(entry, page))
+		goto put_pool;
 
 	/* populate entry */
 	entry->swpentry = swp_entry(type, offset);
-	entry->handle = handle;
-	entry->length = dlen;
 
 insert_entry:
 	entry->objcg = objcg;
@@ -1725,8 +1742,6 @@ bool zswap_store(struct folio *folio)
 
 	return true;
 
-put_dstmem:
-	mutex_unlock(acomp_ctx->mutex);
 put_pool:
 	zswap_pool_put(entry->pool);
 freepage:
@@ -1902,10 +1917,10 @@ static int zswap_setup(void)
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
@@ -1940,7 +1955,7 @@ static int zswap_setup(void)
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

