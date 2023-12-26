Return-Path: <linux-kernel+bounces-11562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E929081E833
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 16:56:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A6301F22CD2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 15:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CFE754657;
	Tue, 26 Dec 2023 15:55:08 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B90153E26
	for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 15:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <zhouchengming@bytedance.com>
Date: Tue, 26 Dec 2023 15:54:13 +0000
Subject: [PATCH v4 6/6] mm/zswap: change per-cpu mutex and buffer to per-acomp_ctx
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231213-zswap-dstmem-v4-6-f228b059dd89@bytedance.com>
References: <20231213-zswap-dstmem-v4-0-f228b059dd89@bytedance.com>
In-Reply-To: <20231213-zswap-dstmem-v4-0-f228b059dd89@bytedance.com>
To: Andrew Morton <akpm@linux-foundation.org>, Seth Jennings <sjenning@redhat.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Vitaly Wool <vitaly.wool@konsulko.com>, Nhat Pham <nphamcs@gmail.com>, Chris Li <chriscli@google.com>,
 Yosry Ahmed <yosryahmed@google.com>, Dan Streetman <ddstreet@ieee.org>
Cc: linux-kernel@vger.kernel.org, Chengming Zhou <zhouchengming@bytedance.com>, linux-mm@kvack.org,
 Nhat Pham <nphamcs@gmail.com>, Yosry Ahmed <yosryahmed@google.com>, Chris Li <chrisl@kernel.org>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1703606082; l=7176;
 i=zhouchengming@bytedance.com; s=20231204; h=from:subject:message-id;
 bh=eozKHlUpbkn5zdclwtiNUF72Ti9iB66PKm56EsjFhvY=;
 b=ZHdimCEH7YHQg7J/zZG0lpD8VDQR5PJsQQJTk4mFBZYPUirIGkxxEFhs+8NzqRUaI5EO7+GWo
 uZGuipzU28YBtj82Nq4HzIbIEAvGbfNtgvhtYTNlPP6vi7n5vBhjtn8
X-Developer-Key: i=zhouchengming@bytedance.com; a=ed25519;
 pk=xFTmRtMG3vELGJBUiml7OYNdM393WOMv0iWWeQEVVdA=
X-Migadu-Flow: FLOW_OUT

First of all, we need to rename acomp_ctx->dstmem field to buffer,
since we are now using for purposes other than compression.

Then we change per-cpu mutex and buffer to per-acomp_ctx, since
them belong to the acomp_ctx and are necessary parts when used
in the compress/decompress contexts.

So we can remove the old per-cpu mutex and dstmem.

Acked-by: Chris Li <chrisl@kernel.org> (Google)
Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 include/linux/cpuhotplug.h |  1 -
 mm/zswap.c                 | 98 +++++++++++++---------------------------------
 2 files changed, 28 insertions(+), 71 deletions(-)

diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index efc0c0b07efb..c3e06e21766a 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -124,7 +124,6 @@ enum cpuhp_state {
 	CPUHP_ARM_BL_PREPARE,
 	CPUHP_TRACE_RB_PREPARE,
 	CPUHP_MM_ZS_PREPARE,
-	CPUHP_MM_ZSWP_MEM_PREPARE,
 	CPUHP_MM_ZSWP_POOL_PREPARE,
 	CPUHP_KVM_PPC_BOOK3S_PREPARE,
 	CPUHP_ZCOMP_PREPARE,
diff --git a/mm/zswap.c b/mm/zswap.c
index 40ee9f109f98..8014509736ad 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -166,8 +166,8 @@ struct crypto_acomp_ctx {
 	struct crypto_acomp *acomp;
 	struct acomp_req *req;
 	struct crypto_wait wait;
-	u8 *dstmem;
-	struct mutex *mutex;
+	u8 *buffer;
+	struct mutex mutex;
 };
 
 /*
@@ -694,63 +694,26 @@ static void zswap_alloc_shrinker(struct zswap_pool *pool)
 /*********************************
 * per-cpu code
 **********************************/
-static DEFINE_PER_CPU(u8 *, zswap_dstmem);
-/*
- * If users dynamically change the zpool type and compressor at runtime, i.e.
- * zswap is running, zswap can have more than one zpool on one cpu, but they
- * are sharing dtsmem. So we need this mutex to be per-cpu.
- */
-static DEFINE_PER_CPU(struct mutex *, zswap_mutex);
-
-static int zswap_dstmem_prepare(unsigned int cpu)
-{
-	struct mutex *mutex;
-	u8 *dst;
-
-	dst = kmalloc_node(PAGE_SIZE, GFP_KERNEL, cpu_to_node(cpu));
-	if (!dst)
-		return -ENOMEM;
-
-	mutex = kmalloc_node(sizeof(*mutex), GFP_KERNEL, cpu_to_node(cpu));
-	if (!mutex) {
-		kfree(dst);
-		return -ENOMEM;
-	}
-
-	mutex_init(mutex);
-	per_cpu(zswap_dstmem, cpu) = dst;
-	per_cpu(zswap_mutex, cpu) = mutex;
-	return 0;
-}
-
-static int zswap_dstmem_dead(unsigned int cpu)
-{
-	struct mutex *mutex;
-	u8 *dst;
-
-	mutex = per_cpu(zswap_mutex, cpu);
-	kfree(mutex);
-	per_cpu(zswap_mutex, cpu) = NULL;
-
-	dst = per_cpu(zswap_dstmem, cpu);
-	kfree(dst);
-	per_cpu(zswap_dstmem, cpu) = NULL;
-
-	return 0;
-}
-
 static int zswap_cpu_comp_prepare(unsigned int cpu, struct hlist_node *node)
 {
 	struct zswap_pool *pool = hlist_entry(node, struct zswap_pool, node);
 	struct crypto_acomp_ctx *acomp_ctx = per_cpu_ptr(pool->acomp_ctx, cpu);
 	struct crypto_acomp *acomp;
 	struct acomp_req *req;
+	int ret;
+
+	mutex_init(&acomp_ctx->mutex);
+
+	acomp_ctx->buffer = kmalloc_node(PAGE_SIZE, GFP_KERNEL, cpu_to_node(cpu));
+	if (!acomp_ctx->buffer)
+		return -ENOMEM;
 
 	acomp = crypto_alloc_acomp_node(pool->tfm_name, 0, 0, cpu_to_node(cpu));
 	if (IS_ERR(acomp)) {
 		pr_err("could not alloc crypto acomp %s : %ld\n",
 				pool->tfm_name, PTR_ERR(acomp));
-		return PTR_ERR(acomp);
+		ret = PTR_ERR(acomp);
+		goto acomp_fail;
 	}
 	acomp_ctx->acomp = acomp;
 
@@ -758,8 +721,8 @@ static int zswap_cpu_comp_prepare(unsigned int cpu, struct hlist_node *node)
 	if (!req) {
 		pr_err("could not alloc crypto acomp_request %s\n",
 		       pool->tfm_name);
-		crypto_free_acomp(acomp_ctx->acomp);
-		return -ENOMEM;
+		ret = -ENOMEM;
+		goto req_fail;
 	}
 	acomp_ctx->req = req;
 
@@ -772,10 +735,13 @@ static int zswap_cpu_comp_prepare(unsigned int cpu, struct hlist_node *node)
 	acomp_request_set_callback(req, CRYPTO_TFM_REQ_MAY_BACKLOG,
 				   crypto_req_done, &acomp_ctx->wait);
 
-	acomp_ctx->mutex = per_cpu(zswap_mutex, cpu);
-	acomp_ctx->dstmem = per_cpu(zswap_dstmem, cpu);
-
 	return 0;
+
+req_fail:
+	crypto_free_acomp(acomp_ctx->acomp);
+acomp_fail:
+	kfree(acomp_ctx->buffer);
+	return ret;
 }
 
 static int zswap_cpu_comp_dead(unsigned int cpu, struct hlist_node *node)
@@ -788,6 +754,7 @@ static int zswap_cpu_comp_dead(unsigned int cpu, struct hlist_node *node)
 			acomp_request_free(acomp_ctx->req);
 		if (!IS_ERR_OR_NULL(acomp_ctx->acomp))
 			crypto_free_acomp(acomp_ctx->acomp);
+		kfree(acomp_ctx->buffer);
 	}
 
 	return 0;
@@ -1400,12 +1367,12 @@ static void __zswap_load(struct zswap_entry *entry, struct page *page)
 	u8 *src;
 
 	acomp_ctx = raw_cpu_ptr(entry->pool->acomp_ctx);
-	mutex_lock(acomp_ctx->mutex);
+	mutex_lock(&acomp_ctx->mutex);
 
 	src = zpool_map_handle(zpool, entry->handle, ZPOOL_MM_RO);
 	if (!zpool_can_sleep_mapped(zpool)) {
-		memcpy(acomp_ctx->dstmem, src, entry->length);
-		src = acomp_ctx->dstmem;
+		memcpy(acomp_ctx->buffer, src, entry->length);
+		src = acomp_ctx->buffer;
 		zpool_unmap_handle(zpool, entry->handle);
 	}
 
@@ -1415,7 +1382,7 @@ static void __zswap_load(struct zswap_entry *entry, struct page *page)
 	acomp_request_set_params(acomp_ctx->req, &input, &output, entry->length, PAGE_SIZE);
 	BUG_ON(crypto_wait_req(crypto_acomp_decompress(acomp_ctx->req), &acomp_ctx->wait));
 	BUG_ON(acomp_ctx->req->dlen != PAGE_SIZE);
-	mutex_unlock(acomp_ctx->mutex);
+	mutex_unlock(&acomp_ctx->mutex);
 
 	if (zpool_can_sleep_mapped(zpool))
 		zpool_unmap_handle(zpool, entry->handle);
@@ -1636,9 +1603,9 @@ bool zswap_store(struct folio *folio)
 	/* compress */
 	acomp_ctx = raw_cpu_ptr(entry->pool->acomp_ctx);
 
-	mutex_lock(acomp_ctx->mutex);
+	mutex_lock(&acomp_ctx->mutex);
 
-	dst = acomp_ctx->dstmem;
+	dst = acomp_ctx->buffer;
 	sg_init_table(&input, 1);
 	sg_set_page(&input, page, PAGE_SIZE, 0);
 
@@ -1681,7 +1648,7 @@ bool zswap_store(struct folio *folio)
 	buf = zpool_map_handle(zpool, handle, ZPOOL_MM_WO);
 	memcpy(buf, dst, dlen);
 	zpool_unmap_handle(zpool, handle);
-	mutex_unlock(acomp_ctx->mutex);
+	mutex_unlock(&acomp_ctx->mutex);
 
 	/* populate entry */
 	entry->swpentry = swp_entry(type, offset);
@@ -1724,7 +1691,7 @@ bool zswap_store(struct folio *folio)
 	return true;
 
 put_dstmem:
-	mutex_unlock(acomp_ctx->mutex);
+	mutex_unlock(&acomp_ctx->mutex);
 put_pool:
 	zswap_pool_put(entry->pool);
 freepage:
@@ -1899,13 +1866,6 @@ static int zswap_setup(void)
 		goto cache_fail;
 	}
 
-	ret = cpuhp_setup_state(CPUHP_MM_ZSWP_MEM_PREPARE, "mm/zswap:prepare",
-				zswap_dstmem_prepare, zswap_dstmem_dead);
-	if (ret) {
-		pr_err("dstmem alloc failed\n");
-		goto dstmem_fail;
-	}
-
 	ret = cpuhp_setup_state_multi(CPUHP_MM_ZSWP_POOL_PREPARE,
 				      "mm/zswap_pool:prepare",
 				      zswap_cpu_comp_prepare,
@@ -1937,8 +1897,6 @@ static int zswap_setup(void)
 	if (pool)
 		zswap_pool_destroy(pool);
 hp_fail:
-	cpuhp_remove_state(CPUHP_MM_ZSWP_MEM_PREPARE);
-dstmem_fail:
 	kmem_cache_destroy(zswap_entry_cache);
 cache_fail:
 	/* if built-in, we aren't unloaded on failure; don't allow use */

-- 
b4 0.10.1

