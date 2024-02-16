Return-Path: <linux-kernel+bounces-68282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47B90857822
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 09:56:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D57B1F218CA
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 08:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C5D41B948;
	Fri, 16 Feb 2024 08:55:41 +0000 (UTC)
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D1E1B7E3
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 08:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708073740; cv=none; b=uqM7V/Yznq0UqF9SvmjxxgGW6XaylKHRYES3zMovsLogW+jz9nwPCkuZqAa0KPhm1roN/0K+0abMv493J8O2weOm0O08YM+l5kvm2QP9dBavv45APJ848r+FA/d8DFV7PcK7KcMC1dzgG9VYHVj+vGIHy51YAYiWNDTf2VCleD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708073740; c=relaxed/simple;
	bh=mD8bvlhSHGiGBpxPf0dmM3YCw79kfelMHLvGofDdceM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cFauI+LPTPRc+/fZPmMlZPe35FbzdM9RqyUqjqWFZb9ohZXA+9DtyyZ1eqtIoDmJ/KF7j9mfOKcuUWGYXXD6xCxrcAMGV6bsv7HWvWmLjQQ7oD0yKJCsFXPcajOsJlSnVdcOfrrlaaW2j8ex+3TmmBO96Yi2p2R5I2hswcbvCno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=linux.dev; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <zhouchengming@bytedance.com>
Date: Fri, 16 Feb 2024 08:55:05 +0000
Subject: [PATCH v3 2/2] mm/zswap: change zswap_pool kref to percpu_ref
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240210-zswap-global-lru-v3-2-200495333595@bytedance.com>
References: <20240210-zswap-global-lru-v3-0-200495333595@bytedance.com>
In-Reply-To: <20240210-zswap-global-lru-v3-0-200495333595@bytedance.com>
To: Johannes Weiner <hannes@cmpxchg.org>, Yosry Ahmed <yosryahmed@google.com>, Nhat Pham <nphamcs@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, Yosry Ahmed <yosryahmed@google.com>, linux-kernel@vger.kernel.org,
 Chengming Zhou <zhouchengming@bytedance.com>
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
 mm/zswap.c | 36 +++++++++++++++++++++++++++---------
 1 file changed, 27 insertions(+), 9 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index d275eb523fc4..961349162997 100644
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
@@ -305,6 +305,7 @@ static void zswap_update_total_size(void)
 /*********************************
 * pool functions
 **********************************/
+static void __zswap_pool_empty(struct percpu_ref *ref);
 
 static struct zswap_pool *zswap_pool_create(char *type, char *compressor)
 {
@@ -358,13 +359,18 @@ static struct zswap_pool *zswap_pool_create(char *type, char *compressor)
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
@@ -437,8 +443,9 @@ static void __zswap_pool_release(struct work_struct *work)
 
 	synchronize_rcu();
 
-	/* nobody should have been able to get a kref... */
-	WARN_ON(kref_get_unless_zero(&pool->kref));
+	/* nobody should have been able to get a ref... */
+	WARN_ON(!percpu_ref_is_zero(&pool->ref));
+	percpu_ref_exit(&pool->ref);
 
 	/* pool is now off zswap_pools list and has no references. */
 	zswap_pool_destroy(pool);
@@ -446,11 +453,11 @@ static void __zswap_pool_release(struct work_struct *work)
 
 static struct zswap_pool *zswap_pool_current(void);
 
-static void __zswap_pool_empty(struct kref *kref)
+static void __zswap_pool_empty(struct percpu_ref *ref)
 {
 	struct zswap_pool *pool;
 
-	pool = container_of(kref, typeof(*pool), kref);
+	pool = container_of(ref, typeof(*pool), ref);
 
 	spin_lock(&zswap_pools_lock);
 
@@ -469,12 +476,12 @@ static int __must_check zswap_pool_get(struct zswap_pool *pool)
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
@@ -604,6 +611,17 @@ static int __zswap_param_set(const char *val, const struct kernel_param *kp,
 
 	if (!pool)
 		pool = zswap_pool_create(type, compressor);
+	else {
+		/*
+		 * Restore the initial ref dropped by percpu_ref_kill()
+		 * when the pool was decommissioned and switch it again
+		 * to percpu mode.
+		 */
+		percpu_ref_resurrect(&pool->ref);
+
+		/* Drop the ref from zswap_pool_find_get(). */
+		zswap_pool_put(pool);
+	}
 
 	if (pool)
 		ret = param_set_charp(s, kp);
@@ -642,7 +660,7 @@ static int __zswap_param_set(const char *val, const struct kernel_param *kp,
 	 * or the new pool we failed to add
 	 */
 	if (put_pool)
-		zswap_pool_put(put_pool);
+		percpu_ref_kill(&put_pool->ref);
 
 	return ret;
 }

-- 
b4 0.10.1

