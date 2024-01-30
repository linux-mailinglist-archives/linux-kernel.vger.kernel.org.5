Return-Path: <linux-kernel+bounces-43749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BC7FA841890
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 02:44:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 342B6B23767
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 01:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F84138DE5;
	Tue, 30 Jan 2024 01:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="KBMvZ33a"
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A10E381CE
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 01:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706578949; cv=none; b=MhUG+e4JrJVw2mT941T/qeGcnhRBO9ta6bK5FHdASIyCmZUd+7XkucpQniIu191Y85IcPdEdTfKalC4rdAQXe/c0fHI6e6M/YUdh8XL3q0KyBoHD5oivtLfVFRUsxERfeQH9ANLlIwvLdumFUxSWB5x3EIZAWhwON7XDuZsS4rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706578949; c=relaxed/simple;
	bh=ttW3+DcNXd1lV+Vs94yUOKLYf6ZmEE+Km00dzN4MYUs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RkdiXMkBlOzRoKxhikFzcV7J7qrXlSwR8qZOZ734ZVeypqw0EyfCAUKtn31ssKHYxwk+Zw3CbWMcWDMKynv3RybXzUxZ1VHpcKo1fipCDk0N8GFD0hUaPYez2NT9TPuVR67Li6GyZnyPdIR2N1k1KTyOHRwor5z4oio+HkAduY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=KBMvZ33a; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-68c2f4c3282so26792446d6.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 17:42:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1706578946; x=1707183746; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rkkvsf4pStxQTi2gKgo4CCnvmALR1LUjxBEOZSgiwUU=;
        b=KBMvZ33atgb03oO/eQ1ziklxhbOKy88bUaNXgBhjnGM5dAORed7RosBYbC+E4ThGAE
         fXabG1DgH6pRCXK6YnL9MVTkCU8y5lPppXdUID+p3LaN8gh0WNtik9TiKCdmOjmBWHbL
         gSIMbZoFfYxIiQBDAKwt91QWzMviUUWS5g/uneHfZ862tm9b9byP9Fk/wH0FChEIXyDR
         q/rrtLwW0V0RQ5ZVVi6knsKtfSdiUfEXcZow7rA/oFiXdqhEm8O8bH0VgwCLGfoIKKzn
         YRvta7NrZHJqlkm/8tKAy5knVMbzQagJlpZYDvj8e0a258fUfVwsTwjxu5zR8aUfefxO
         X+OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706578946; x=1707183746;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rkkvsf4pStxQTi2gKgo4CCnvmALR1LUjxBEOZSgiwUU=;
        b=gZb1/dV+ZGryoZ0qOpWxGGvbno9/zmuOhCknRnX9C7LOmuEw/MRY27zAoxEttnCYIS
         HRm+Cn7rZ1QBVMr5p3uSgL5E0n6AAIA8tPjuybdOZrkhdzKinmjzWkB2vSbVo2JDAmop
         V7jCIGbHfG5fmJ7t99hhwdxllFp3YBGmcp3IL/N3Tg2ZeK+BJ2DbLHS6y76MrJjHGIdB
         g993/5HBCH6GE56Sfa/iTf59oIE1XPLaFyj5u/bjPfQB/l60O4wu7fVE2th9ItZBb9s0
         XL0SZQACaP4wxndNRzXgjYDbnDTLlhZU6kSvFV8SNhdQcx89APHiKZnDu9BYgNcz5sAu
         ZjdQ==
X-Gm-Message-State: AOJu0Yzp6uLFjUvZC8XiCZuw7e8AhQlz6x5iyRheDSc8VGTqn4Qc06E6
	LWC8LZBh8ig9YqqlKL5eEx/N392wZrgXORsiMEI4hC+9sNIqoUtwQ4A7g+p5VSJUGF7lKlN+s9+
	7
X-Google-Smtp-Source: AGHT+IEupJwBS6PzRmr4d1gT3dBmbqwm+T5GT7wGrB81djH8pkmwnFJL+V394X2JsA3CiQUdBjgjdA==
X-Received: by 2002:ad4:5f89:0:b0:68c:5d15:25c1 with SMTP id jp9-20020ad45f89000000b0068c5d1525c1mr790999qvb.107.1706578946041;
        Mon, 29 Jan 2024 17:42:26 -0800 (PST)
Received: from localhost (2603-7000-0c01-2716-da5e-d3ff-fee7-26e7.res6.spectrum.com. [2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id vz9-20020a05620a494900b007833c4dddfdsm3587691qkn.53.2024.01.29.17.42.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 17:42:25 -0800 (PST)
From: Johannes Weiner <hannes@cmpxchg.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Nhat Pham <nphamcs@gmail.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	Chengming Zhou <zhouchengming@bytedance.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 10/20] mm: zswap: function ordering: pool alloc & free
Date: Mon, 29 Jan 2024 20:36:46 -0500
Message-ID: <20240130014208.565554-11-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240130014208.565554-1-hannes@cmpxchg.org>
References: <20240130014208.565554-1-hannes@cmpxchg.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function ordering in zswap.c is a little chaotic, which requires
jumping in unexpected directions when following related code. This is
a series of patches that brings the file into the following order:

- pool functions
- lru functions
- rbtree functions
- zswap entry functions
- compression/backend functions
- writeback & shrinking functions
- store, load, invalidate, swapon, swapoff
- debugfs
- init

But it has to be split up such the moving still produces halfway
readable diffs.

In this patch, move pool allocation and freeing functions.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/zswap.c | 297 +++++++++++++++++++++++++++--------------------------
 1 file changed, 152 insertions(+), 145 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index 082d076a758d..805d9a35f633 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -320,6 +320,158 @@ static void zswap_update_total_size(void)
 	zswap_pool_total_size = total;
 }
 
+/*********************************
+* pool functions
+**********************************/
+
+static void zswap_alloc_shrinker(struct zswap_pool *pool);
+static void shrink_worker(struct work_struct *w);
+
+static struct zswap_pool *zswap_pool_create(char *type, char *compressor)
+{
+	int i;
+	struct zswap_pool *pool;
+	char name[38]; /* 'zswap' + 32 char (max) num + \0 */
+	gfp_t gfp = __GFP_NORETRY | __GFP_NOWARN | __GFP_KSWAPD_RECLAIM;
+	int ret;
+
+	if (!zswap_has_pool) {
+		/* if either are unset, pool initialization failed, and we
+		 * need both params to be set correctly before trying to
+		 * create a pool.
+		 */
+		if (!strcmp(type, ZSWAP_PARAM_UNSET))
+			return NULL;
+		if (!strcmp(compressor, ZSWAP_PARAM_UNSET))
+			return NULL;
+	}
+
+	pool = kzalloc(sizeof(*pool), GFP_KERNEL);
+	if (!pool)
+		return NULL;
+
+	for (i = 0; i < ZSWAP_NR_ZPOOLS; i++) {
+		/* unique name for each pool specifically required by zsmalloc */
+		snprintf(name, 38, "zswap%x",
+			 atomic_inc_return(&zswap_pools_count));
+
+		pool->zpools[i] = zpool_create_pool(type, name, gfp);
+		if (!pool->zpools[i]) {
+			pr_err("%s zpool not available\n", type);
+			goto error;
+		}
+	}
+	pr_debug("using %s zpool\n", zpool_get_type(pool->zpools[0]));
+
+	strscpy(pool->tfm_name, compressor, sizeof(pool->tfm_name));
+
+	pool->acomp_ctx = alloc_percpu(*pool->acomp_ctx);
+	if (!pool->acomp_ctx) {
+		pr_err("percpu alloc failed\n");
+		goto error;
+	}
+
+	ret = cpuhp_state_add_instance(CPUHP_MM_ZSWP_POOL_PREPARE,
+				       &pool->node);
+	if (ret)
+		goto error;
+
+	zswap_alloc_shrinker(pool);
+	if (!pool->shrinker)
+		goto error;
+
+	pr_debug("using %s compressor\n", pool->tfm_name);
+
+	/* being the current pool takes 1 ref; this func expects the
+	 * caller to always add the new pool as the current pool
+	 */
+	kref_init(&pool->kref);
+	INIT_LIST_HEAD(&pool->list);
+	if (list_lru_init_memcg(&pool->list_lru, pool->shrinker))
+		goto lru_fail;
+	shrinker_register(pool->shrinker);
+	INIT_WORK(&pool->shrink_work, shrink_worker);
+	atomic_set(&pool->nr_stored, 0);
+
+	zswap_pool_debug("created", pool);
+
+	return pool;
+
+lru_fail:
+	list_lru_destroy(&pool->list_lru);
+	shrinker_free(pool->shrinker);
+error:
+	if (pool->acomp_ctx)
+		free_percpu(pool->acomp_ctx);
+	while (i--)
+		zpool_destroy_pool(pool->zpools[i]);
+	kfree(pool);
+	return NULL;
+}
+
+static struct zswap_pool *__zswap_pool_create_fallback(void)
+{
+	bool has_comp, has_zpool;
+
+	has_comp = crypto_has_acomp(zswap_compressor, 0, 0);
+	if (!has_comp && strcmp(zswap_compressor,
+				CONFIG_ZSWAP_COMPRESSOR_DEFAULT)) {
+		pr_err("compressor %s not available, using default %s\n",
+		       zswap_compressor, CONFIG_ZSWAP_COMPRESSOR_DEFAULT);
+		param_free_charp(&zswap_compressor);
+		zswap_compressor = CONFIG_ZSWAP_COMPRESSOR_DEFAULT;
+		has_comp = crypto_has_acomp(zswap_compressor, 0, 0);
+	}
+	if (!has_comp) {
+		pr_err("default compressor %s not available\n",
+		       zswap_compressor);
+		param_free_charp(&zswap_compressor);
+		zswap_compressor = ZSWAP_PARAM_UNSET;
+	}
+
+	has_zpool = zpool_has_pool(zswap_zpool_type);
+	if (!has_zpool && strcmp(zswap_zpool_type,
+				 CONFIG_ZSWAP_ZPOOL_DEFAULT)) {
+		pr_err("zpool %s not available, using default %s\n",
+		       zswap_zpool_type, CONFIG_ZSWAP_ZPOOL_DEFAULT);
+		param_free_charp(&zswap_zpool_type);
+		zswap_zpool_type = CONFIG_ZSWAP_ZPOOL_DEFAULT;
+		has_zpool = zpool_has_pool(zswap_zpool_type);
+	}
+	if (!has_zpool) {
+		pr_err("default zpool %s not available\n",
+		       zswap_zpool_type);
+		param_free_charp(&zswap_zpool_type);
+		zswap_zpool_type = ZSWAP_PARAM_UNSET;
+	}
+
+	if (!has_comp || !has_zpool)
+		return NULL;
+
+	return zswap_pool_create(zswap_zpool_type, zswap_compressor);
+}
+
+static void zswap_pool_destroy(struct zswap_pool *pool)
+{
+	int i;
+
+	zswap_pool_debug("destroying", pool);
+
+	shrinker_free(pool->shrinker);
+	cpuhp_state_remove_instance(CPUHP_MM_ZSWP_POOL_PREPARE, &pool->node);
+	free_percpu(pool->acomp_ctx);
+	list_lru_destroy(&pool->list_lru);
+
+	spin_lock(&zswap_pools_lock);
+	mem_cgroup_iter_break(NULL, pool->next_shrink);
+	pool->next_shrink = NULL;
+	spin_unlock(&zswap_pools_lock);
+
+	for (i = 0; i < ZSWAP_NR_ZPOOLS; i++)
+		zpool_destroy_pool(pool->zpools[i]);
+	kfree(pool);
+}
+
 /* should be called under RCU */
 #ifdef CONFIG_MEMCG
 static inline struct mem_cgroup *mem_cgroup_from_entry(struct zswap_entry *entry)
@@ -970,151 +1122,6 @@ static void shrink_worker(struct work_struct *w)
 	zswap_pool_put(pool);
 }
 
-static struct zswap_pool *zswap_pool_create(char *type, char *compressor)
-{
-	int i;
-	struct zswap_pool *pool;
-	char name[38]; /* 'zswap' + 32 char (max) num + \0 */
-	gfp_t gfp = __GFP_NORETRY | __GFP_NOWARN | __GFP_KSWAPD_RECLAIM;
-	int ret;
-
-	if (!zswap_has_pool) {
-		/* if either are unset, pool initialization failed, and we
-		 * need both params to be set correctly before trying to
-		 * create a pool.
-		 */
-		if (!strcmp(type, ZSWAP_PARAM_UNSET))
-			return NULL;
-		if (!strcmp(compressor, ZSWAP_PARAM_UNSET))
-			return NULL;
-	}
-
-	pool = kzalloc(sizeof(*pool), GFP_KERNEL);
-	if (!pool)
-		return NULL;
-
-	for (i = 0; i < ZSWAP_NR_ZPOOLS; i++) {
-		/* unique name for each pool specifically required by zsmalloc */
-		snprintf(name, 38, "zswap%x",
-			 atomic_inc_return(&zswap_pools_count));
-
-		pool->zpools[i] = zpool_create_pool(type, name, gfp);
-		if (!pool->zpools[i]) {
-			pr_err("%s zpool not available\n", type);
-			goto error;
-		}
-	}
-	pr_debug("using %s zpool\n", zpool_get_type(pool->zpools[0]));
-
-	strscpy(pool->tfm_name, compressor, sizeof(pool->tfm_name));
-
-	pool->acomp_ctx = alloc_percpu(*pool->acomp_ctx);
-	if (!pool->acomp_ctx) {
-		pr_err("percpu alloc failed\n");
-		goto error;
-	}
-
-	ret = cpuhp_state_add_instance(CPUHP_MM_ZSWP_POOL_PREPARE,
-				       &pool->node);
-	if (ret)
-		goto error;
-
-	zswap_alloc_shrinker(pool);
-	if (!pool->shrinker)
-		goto error;
-
-	pr_debug("using %s compressor\n", pool->tfm_name);
-
-	/* being the current pool takes 1 ref; this func expects the
-	 * caller to always add the new pool as the current pool
-	 */
-	kref_init(&pool->kref);
-	INIT_LIST_HEAD(&pool->list);
-	if (list_lru_init_memcg(&pool->list_lru, pool->shrinker))
-		goto lru_fail;
-	shrinker_register(pool->shrinker);
-	INIT_WORK(&pool->shrink_work, shrink_worker);
-	atomic_set(&pool->nr_stored, 0);
-
-	zswap_pool_debug("created", pool);
-
-	return pool;
-
-lru_fail:
-	list_lru_destroy(&pool->list_lru);
-	shrinker_free(pool->shrinker);
-error:
-	if (pool->acomp_ctx)
-		free_percpu(pool->acomp_ctx);
-	while (i--)
-		zpool_destroy_pool(pool->zpools[i]);
-	kfree(pool);
-	return NULL;
-}
-
-static struct zswap_pool *__zswap_pool_create_fallback(void)
-{
-	bool has_comp, has_zpool;
-
-	has_comp = crypto_has_acomp(zswap_compressor, 0, 0);
-	if (!has_comp && strcmp(zswap_compressor,
-				CONFIG_ZSWAP_COMPRESSOR_DEFAULT)) {
-		pr_err("compressor %s not available, using default %s\n",
-		       zswap_compressor, CONFIG_ZSWAP_COMPRESSOR_DEFAULT);
-		param_free_charp(&zswap_compressor);
-		zswap_compressor = CONFIG_ZSWAP_COMPRESSOR_DEFAULT;
-		has_comp = crypto_has_acomp(zswap_compressor, 0, 0);
-	}
-	if (!has_comp) {
-		pr_err("default compressor %s not available\n",
-		       zswap_compressor);
-		param_free_charp(&zswap_compressor);
-		zswap_compressor = ZSWAP_PARAM_UNSET;
-	}
-
-	has_zpool = zpool_has_pool(zswap_zpool_type);
-	if (!has_zpool && strcmp(zswap_zpool_type,
-				 CONFIG_ZSWAP_ZPOOL_DEFAULT)) {
-		pr_err("zpool %s not available, using default %s\n",
-		       zswap_zpool_type, CONFIG_ZSWAP_ZPOOL_DEFAULT);
-		param_free_charp(&zswap_zpool_type);
-		zswap_zpool_type = CONFIG_ZSWAP_ZPOOL_DEFAULT;
-		has_zpool = zpool_has_pool(zswap_zpool_type);
-	}
-	if (!has_zpool) {
-		pr_err("default zpool %s not available\n",
-		       zswap_zpool_type);
-		param_free_charp(&zswap_zpool_type);
-		zswap_zpool_type = ZSWAP_PARAM_UNSET;
-	}
-
-	if (!has_comp || !has_zpool)
-		return NULL;
-
-	return zswap_pool_create(zswap_zpool_type, zswap_compressor);
-}
-
-static void zswap_pool_destroy(struct zswap_pool *pool)
-{
-	int i;
-
-	zswap_pool_debug("destroying", pool);
-
-	shrinker_free(pool->shrinker);
-	cpuhp_state_remove_instance(CPUHP_MM_ZSWP_POOL_PREPARE, &pool->node);
-	free_percpu(pool->acomp_ctx);
-	list_lru_destroy(&pool->list_lru);
-
-	spin_lock(&zswap_pools_lock);
-	mem_cgroup_iter_break(NULL, pool->next_shrink);
-	pool->next_shrink = NULL;
-	spin_unlock(&zswap_pools_lock);
-
-	for (i = 0; i < ZSWAP_NR_ZPOOLS; i++)
-		zpool_destroy_pool(pool->zpools[i]);
-	kfree(pool);
-}
-
 static int __must_check zswap_pool_get(struct zswap_pool *pool)
 {
 	if (!pool)
-- 
2.43.0


