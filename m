Return-Path: <linux-kernel+bounces-64899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 479A685446B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 09:55:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C6EF1C274CE
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 08:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F203125D3;
	Wed, 14 Feb 2024 08:54:54 +0000 (UTC)
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8959BA33
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 08:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707900893; cv=none; b=PbT+bP6LC784exmbovg+WRB4/IdZWYQZ/WtlKRC3B45vqQo/cPmC6j8sZHGjmzZPPJxvtt2Z1Q8P1BF2yRgbgHz0+RhSFgTcxCY+JWcluxYBW1gQGvHK8oB/4xRFyNuq/fHQ+fReGJ+OmsXMxiV8tOzpsvgkLRgvzc3WxI3W3qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707900893; c=relaxed/simple;
	bh=PR0N3thqXKq1e2jCnYh9FdSFO4iCOQYoAEQ9nreBSmM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eDVM/VFfgrKBaVuRSGMeBNN35x0bZPjbWXBxkDx2ETdMXmiAXL3vkU83WSxzwIbiU/7fZ82hGfJm/3Lz63gENuTzzTvc9mxR2fJBRJYhIN16CSfqgOWCRACaoxFvdhJ+NKFY9cSCysM/5CimByjO0boklyNCRWYncGXCThaDpTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=linux.dev; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <zhouchengming@bytedance.com>
Date: Wed, 14 Feb 2024 08:54:38 +0000
Subject: [PATCH v2 2/2] mm/zswap: change zswap_pool kref to percpu_ref
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240210-zswap-global-lru-v2-2-fbee3b11a62e@bytedance.com>
References: <20240210-zswap-global-lru-v2-0-fbee3b11a62e@bytedance.com>
In-Reply-To: <20240210-zswap-global-lru-v2-0-fbee3b11a62e@bytedance.com>
To: Yosry Ahmed <yosryahmed@google.com>, Johannes Weiner <hannes@cmpxchg.org>, Andrew Morton <akpm@linux-foundation.org>,
 Nhat Pham <nphamcs@gmail.com>
Cc: linux-mm@kvack.org, Chengming Zhou <zhouchengming@bytedance.com>, linux-kernel@vger.kernel.org
X-Migadu-Flow: FLOW_OUT

All zswap entries will take a reference of zswap_pool when
zswap_store(), and drop it when free. Change it to use the
percpu_ref is better for scalability performance.

Although percpu_ref use a bit more memory which should be ok
for our use case, since we almost have only one zswap_pool to
be using. The performance gain is for zswap_store/load hotpath.

Testing kernel build (32 threads) in tmpfs with memory.max=2GB.
(zswap shrinker and writeback enabled with one 50GB swapfile,
on a 128 CPUs x86-64 machine, below is the average of 5 runs)

        mm-unstable  zswap-global-lru
real    63.20        63.12
user    1061.75      1062.95
sys     268.74       264.44

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 mm/zswap.c | 31 ++++++++++++++++++++++---------
 1 file changed, 22 insertions(+), 9 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index dbff67d7e1c7..f6470d30d337 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -173,7 +173,7 @@ struct crypto_acomp_ctx {
 struct zswap_pool {
 	struct zpool *zpools[ZSWAP_NR_ZPOOLS];
 	struct crypto_acomp_ctx __percpu *acomp_ctx;
-	struct kref kref;
+	struct percpu_ref ref;
 	struct list_head list;
 	struct work_struct release_work;
 	struct hlist_node node;
@@ -304,6 +304,7 @@ static void zswap_update_total_size(void)
 /*********************************
 * pool functions
 **********************************/
+static void __zswap_pool_empty(struct percpu_ref *ref);
 
 static struct zswap_pool *zswap_pool_create(char *type, char *compressor)
 {
@@ -357,13 +358,18 @@ static struct zswap_pool *zswap_pool_create(char *type, char *compressor)
 	/* being the current pool takes 1 ref; this func expects the
 	 * caller to always add the new pool as the current pool
 	 */
-	kref_init(&pool->kref);
+	ret = percpu_ref_init(&pool->ref, __zswap_pool_empty,
+			      PERCPU_REF_ALLOW_REINIT, GFP_KERNEL);
+	if (ret)
+		goto ref_fail;
 	INIT_LIST_HEAD(&pool->list);
 
 	zswap_pool_debug("created", pool);
 
 	return pool;
 
+ref_fail:
+	cpuhp_state_remove_instance(CPUHP_MM_ZSWP_POOL_PREPARE, &pool->node);
 error:
 	if (pool->acomp_ctx)
 		free_percpu(pool->acomp_ctx);
@@ -436,8 +442,9 @@ static void __zswap_pool_release(struct work_struct *work)
 
 	synchronize_rcu();
 
-	/* nobody should have been able to get a kref... */
-	WARN_ON(kref_get_unless_zero(&pool->kref));
+	/* nobody should have been able to get a ref... */
+	WARN_ON(percpu_ref_tryget(&pool->ref));
+	percpu_ref_exit(&pool->ref);
 
 	/* pool is now off zswap_pools list and has no references. */
 	zswap_pool_destroy(pool);
@@ -445,11 +452,11 @@ static void __zswap_pool_release(struct work_struct *work)
 
 static struct zswap_pool *zswap_pool_current(void);
 
-static void __zswap_pool_empty(struct kref *kref)
+static void __zswap_pool_empty(struct percpu_ref *ref)
 {
 	struct zswap_pool *pool;
 
-	pool = container_of(kref, typeof(*pool), kref);
+	pool = container_of(ref, typeof(*pool), ref);
 
 	spin_lock(&zswap_pools_lock);
 
@@ -468,12 +475,12 @@ static int __must_check zswap_pool_get(struct zswap_pool *pool)
 	if (!pool)
 		return 0;
 
-	return kref_get_unless_zero(&pool->kref);
+	return percpu_ref_tryget(&pool->ref);
 }
 
 static void zswap_pool_put(struct zswap_pool *pool)
 {
-	kref_put(&pool->kref, __zswap_pool_empty);
+	percpu_ref_put(&pool->ref);
 }
 
 static struct zswap_pool *__zswap_pool_current(void)
@@ -603,6 +610,12 @@ static int __zswap_param_set(const char *val, const struct kernel_param *kp,
 
 	if (!pool)
 		pool = zswap_pool_create(type, compressor);
+	else {
+		/* Resurrect percpu_ref to percpu mode. */
+		percpu_ref_resurrect(&pool->ref);
+		/* Drop the ref from zswap_pool_find_get(). */
+		zswap_pool_put(pool);
+	}
 
 	if (pool)
 		ret = param_set_charp(s, kp);
@@ -641,7 +654,7 @@ static int __zswap_param_set(const char *val, const struct kernel_param *kp,
 	 * or the new pool we failed to add
 	 */
 	if (put_pool)
-		zswap_pool_put(put_pool);
+		percpu_ref_kill(&put_pool->ref);
 
 	return ret;
 }

-- 
b4 0.10.1

