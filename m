Return-Path: <linux-kernel+bounces-60798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4555F850989
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 14:58:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A51A0B221B6
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 13:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 391285C5F0;
	Sun, 11 Feb 2024 13:58:06 +0000 (UTC)
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0765B5AC
	for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 13:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707659885; cv=none; b=MO95VIwOikWUK2MpqDsx5iRQ2wsA0W2EC+LSeE3QiQUHTNJ0bZEIwJcwBkDXlabHLmH4rIiR/JJeOrcghGHLjO4VLWZqgNaiuF/o9SjnlKutJPVAbzLqbxCjHXW46G7WZlXgerDUufEemnQt4UXPIdBdbI0IF257DfdoUkTuh8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707659885; c=relaxed/simple;
	bh=zITuNv4wdDre8gusr67J0Cvu5TEVLhXdkPFwQuG1nLo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fi5qSNEr3uCAJbjZ2Z7eCwfOjy6yWm7g9NjJBICYjmTT0nnWtegd0G3S+3nEy3aBZYltUfF9yXIix4gMTv3vgNUwCl6I/n30/ec5zk/Xu5YXsuuhOTSIz7nmumPflXvPVYAnw7M7HWCH1JX7AkmeLMWM8UEmuX+5isyxNwbWRks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=linux.dev; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <zhouchengming@bytedance.com>
Date: Sun, 11 Feb 2024 13:57:05 +0000
Subject: [PATCH 2/2] mm/zswap: change zswap_pool kref to percpu_ref
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240210-zswap-global-lru-v1-2-853473d7b0da@bytedance.com>
References: <20240210-zswap-global-lru-v1-0-853473d7b0da@bytedance.com>
In-Reply-To: <20240210-zswap-global-lru-v1-0-853473d7b0da@bytedance.com>
To: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, Yosry Ahmed <yosryahmed@google.com>,
 Nhat Pham <nphamcs@gmail.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, Chengming Zhou <zhouchengming@bytedance.com>
X-Migadu-Flow: FLOW_OUT

All zswap entries will take a reference of zswap_pool when
zswap_store(), and drop it when free. Change it to use the
percpu_ref is better for scalability performance.

Testing kernel build in tmpfs with memory.max=2GB
(zswap shrinker and writeback enabled with one 50GB swapfile).

        mm-unstable  zswap-global-lru
real    63.20        63.12
user    1061.75      1062.95
sys     268.74       264.44

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 mm/zswap.c | 30 +++++++++++++++++++++---------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index 7668db8c10e3..afb31904fb08 100644
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
@@ -303,6 +303,7 @@ static void zswap_update_total_size(void)
 /*********************************
 * pool functions
 **********************************/
+static void __zswap_pool_empty(struct percpu_ref *ref);
 
 static struct zswap_pool *zswap_pool_create(char *type, char *compressor)
 {
@@ -356,13 +357,18 @@ static struct zswap_pool *zswap_pool_create(char *type, char *compressor)
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
@@ -435,8 +441,8 @@ static void __zswap_pool_release(struct work_struct *work)
 
 	synchronize_rcu();
 
-	/* nobody should have been able to get a kref... */
-	WARN_ON(kref_get_unless_zero(&pool->kref));
+	/* nobody should have been able to get a ref... */
+	percpu_ref_exit(&pool->ref);
 
 	/* pool is now off zswap_pools list and has no references. */
 	zswap_pool_destroy(pool);
@@ -444,11 +450,11 @@ static void __zswap_pool_release(struct work_struct *work)
 
 static struct zswap_pool *zswap_pool_current(void);
 
-static void __zswap_pool_empty(struct kref *kref)
+static void __zswap_pool_empty(struct percpu_ref *ref)
 {
 	struct zswap_pool *pool;
 
-	pool = container_of(kref, typeof(*pool), kref);
+	pool = container_of(ref, typeof(*pool), ref);
 
 	spin_lock(&zswap_pools_lock);
 
@@ -467,12 +473,12 @@ static int __must_check zswap_pool_get(struct zswap_pool *pool)
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
@@ -602,6 +608,12 @@ static int __zswap_param_set(const char *val, const struct kernel_param *kp,
 
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
@@ -640,7 +652,7 @@ static int __zswap_param_set(const char *val, const struct kernel_param *kp,
 	 * or the new pool we failed to add
 	 */
 	if (put_pool)
-		zswap_pool_put(put_pool);
+		percpu_ref_kill(&put_pool->ref);
 
 	return ret;
 }

-- 
b4 0.10.1

