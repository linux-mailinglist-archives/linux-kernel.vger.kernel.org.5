Return-Path: <linux-kernel+bounces-43752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B980841895
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 02:45:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCEAF1F2897D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 01:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F14674F1EE;
	Tue, 30 Jan 2024 01:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="FqwZ7i5h"
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C71638F83
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 01:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706578952; cv=none; b=u7kzojg+nCPZoAnH30wy6dB9wa6QezHWeiHHWsMgnvfx/YJAnkSYh4t9ScoDzjZPn+Befg+wAWglQp5ut/1GO3ShfeTmm0Ep04kQ9KRgPy/zrLzw1UHgnttMRBIWz/HjyJa8tpmA1u4Ri0P06uuv111ltXPNKtQaU2et/NVpfsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706578952; c=relaxed/simple;
	bh=X5Tv+PeG/ZURIxGV7LTek+nHYXs1A+DSPnPjP2zYBUY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K9xlZdxm1MlepREt1GO0HU6VbCedi0LBVgmFg91q52ozhP0wo+CZWBhaqIatDn5Zi5Yk61n71GNDVRBnaoaALg0Tqwg5pv8Q0iF/5kuCioWFtzUq9K+DD+0VE50N88qfaDtBgoeTYe2SkTYjA5BkTTNNcARpihM1BsdY6dXkBW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=FqwZ7i5h; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-42a8900bb93so35053391cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 17:42:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1706578950; x=1707183750; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ivn7Y9AQrDvvewOffcfUAdTab4Q3w5wTeKa9SOf1gRc=;
        b=FqwZ7i5hQvSUvl4GUZurve89f9OYym5VNiWbj4hUPPqDusWlHg6CvIsnfjfRlYmg9C
         948Slmbt0R8Lrv8CCHOLCMFuZeGOGXOgiL2yPwCgqj5AwRB+tv/EnbKC7vz+tCSVaQ1R
         9QjNXeDjRrV8GVeSqkqikRrvHURyEOAXlyDsew1hvGFHRiRiTZaVRnDp4y/ZUcn6lqx2
         sLuDXDMBOCCN0CokkL/NAroMPVOzsQkEjlXJ9No1mGXfMidkKjY2L6jKxUP5Fa406Gif
         i1a3PmiTxd91pLcRMz8YsLzd1h07EZIFBKW7pnG2Cv/5eWounpYXEe/BwaBmZWPumnVo
         CvNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706578950; x=1707183750;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ivn7Y9AQrDvvewOffcfUAdTab4Q3w5wTeKa9SOf1gRc=;
        b=ZcC9ckXAp7BaIR37ewfesr1r5rMtYCLhr/RznbLvWzZ4LltizzGGS9ViJ7HMKhcqQC
         Vfc8ZZfmtqmpDi5+FqQdmNkCB/PeVq6pO7Q8CskfWdFF8NNUxi/CRGPijuWoCCOgGe5M
         u4MDFWTouUNysfOVTC0CSSYpapZ3M4zYURi4JL4MvmSHIb9W/4MWEbcdneJFsaodASGC
         m9kP3Hi22G3QFwYFU3Jg7IJsQg6GfQNL9LcztH/oZFK8m1CvYgbkeuhn7dU+425PFNLk
         ABrS3R+rXD0mIaQdwlDF0DSEMO6nZKhgxIyWnOLqwvb8+dOnrdPksgbujJ520du6g2vr
         UmTg==
X-Gm-Message-State: AOJu0YwLAeqUCX88W2xMMqPErWigNyr8s17A25M9ZVstKtlo3t5/Ie/q
	BQGyZkWCYG2bWnl/fEK7YN07uWI6E4XGRdsMCDQ1q6+HFDqRb1FBwSf5mg9wcSNAQ7GEXJCsrt8
	6
X-Google-Smtp-Source: AGHT+IFfZ8rsmJoVVOZQjiDjqNXCo9B7vayXBf6ACzYtz9VPfP8IlcslQtRqPIN1gd49Ezcam+jmmQ==
X-Received: by 2002:a05:622a:1e09:b0:42a:600c:2d7e with SMTP id br9-20020a05622a1e0900b0042a600c2d7emr9275227qtb.51.1706578949706;
        Mon, 29 Jan 2024 17:42:29 -0800 (PST)
Received: from localhost (2603-7000-0c01-2716-da5e-d3ff-fee7-26e7.res6.spectrum.com. [2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id cp7-20020a05622a420700b0042a6859ff3esm3078179qtb.61.2024.01.29.17.42.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 17:42:29 -0800 (PST)
From: Johannes Weiner <hannes@cmpxchg.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Nhat Pham <nphamcs@gmail.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	Chengming Zhou <zhouchengming@bytedance.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 13/20] mm: zswap: function ordering: pool params
Date: Mon, 29 Jan 2024 20:36:49 -0500
Message-ID: <20240130014208.565554-14-hannes@cmpxchg.org>
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

The parameters primarily control pool attributes. Move those
operations up to the pool section.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/zswap.c | 312 ++++++++++++++++++++++++++---------------------------
 1 file changed, 156 insertions(+), 156 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index 168afd6767b3..e650fc587116 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -590,6 +590,162 @@ static struct zswap_pool *zswap_pool_find_get(char *type, char *compressor)
 	return NULL;
 }
 
+/*********************************
+* param callbacks
+**********************************/
+
+static bool zswap_pool_changed(const char *s, const struct kernel_param *kp)
+{
+	/* no change required */
+	if (!strcmp(s, *(char **)kp->arg) && zswap_has_pool)
+		return false;
+	return true;
+}
+
+/* val must be a null-terminated string */
+static int __zswap_param_set(const char *val, const struct kernel_param *kp,
+			     char *type, char *compressor)
+{
+	struct zswap_pool *pool, *put_pool = NULL;
+	char *s = strstrip((char *)val);
+	int ret = 0;
+	bool new_pool = false;
+
+	mutex_lock(&zswap_init_lock);
+	switch (zswap_init_state) {
+	case ZSWAP_UNINIT:
+		/* if this is load-time (pre-init) param setting,
+		 * don't create a pool; that's done during init.
+		 */
+		ret = param_set_charp(s, kp);
+		break;
+	case ZSWAP_INIT_SUCCEED:
+		new_pool = zswap_pool_changed(s, kp);
+		break;
+	case ZSWAP_INIT_FAILED:
+		pr_err("can't set param, initialization failed\n");
+		ret = -ENODEV;
+	}
+	mutex_unlock(&zswap_init_lock);
+
+	/* no need to create a new pool, return directly */
+	if (!new_pool)
+		return ret;
+
+	if (!type) {
+		if (!zpool_has_pool(s)) {
+			pr_err("zpool %s not available\n", s);
+			return -ENOENT;
+		}
+		type = s;
+	} else if (!compressor) {
+		if (!crypto_has_acomp(s, 0, 0)) {
+			pr_err("compressor %s not available\n", s);
+			return -ENOENT;
+		}
+		compressor = s;
+	} else {
+		WARN_ON(1);
+		return -EINVAL;
+	}
+
+	spin_lock(&zswap_pools_lock);
+
+	pool = zswap_pool_find_get(type, compressor);
+	if (pool) {
+		zswap_pool_debug("using existing", pool);
+		WARN_ON(pool == zswap_pool_current());
+		list_del_rcu(&pool->list);
+	}
+
+	spin_unlock(&zswap_pools_lock);
+
+	if (!pool)
+		pool = zswap_pool_create(type, compressor);
+
+	if (pool)
+		ret = param_set_charp(s, kp);
+	else
+		ret = -EINVAL;
+
+	spin_lock(&zswap_pools_lock);
+
+	if (!ret) {
+		put_pool = zswap_pool_current();
+		list_add_rcu(&pool->list, &zswap_pools);
+		zswap_has_pool = true;
+	} else if (pool) {
+		/* add the possibly pre-existing pool to the end of the pools
+		 * list; if it's new (and empty) then it'll be removed and
+		 * destroyed by the put after we drop the lock
+		 */
+		list_add_tail_rcu(&pool->list, &zswap_pools);
+		put_pool = pool;
+	}
+
+	spin_unlock(&zswap_pools_lock);
+
+	if (!zswap_has_pool && !pool) {
+		/* if initial pool creation failed, and this pool creation also
+		 * failed, maybe both compressor and zpool params were bad.
+		 * Allow changing this param, so pool creation will succeed
+		 * when the other param is changed. We already verified this
+		 * param is ok in the zpool_has_pool() or crypto_has_acomp()
+		 * checks above.
+		 */
+		ret = param_set_charp(s, kp);
+	}
+
+	/* drop the ref from either the old current pool,
+	 * or the new pool we failed to add
+	 */
+	if (put_pool)
+		zswap_pool_put(put_pool);
+
+	return ret;
+}
+
+static int zswap_compressor_param_set(const char *val,
+				      const struct kernel_param *kp)
+{
+	return __zswap_param_set(val, kp, zswap_zpool_type, NULL);
+}
+
+static int zswap_zpool_param_set(const char *val,
+				 const struct kernel_param *kp)
+{
+	return __zswap_param_set(val, kp, NULL, zswap_compressor);
+}
+
+static int zswap_enabled_param_set(const char *val,
+				   const struct kernel_param *kp)
+{
+	int ret = -ENODEV;
+
+	/* if this is load-time (pre-init) param setting, only set param. */
+	if (system_state != SYSTEM_RUNNING)
+		return param_set_bool(val, kp);
+
+	mutex_lock(&zswap_init_lock);
+	switch (zswap_init_state) {
+	case ZSWAP_UNINIT:
+		if (zswap_setup())
+			break;
+		fallthrough;
+	case ZSWAP_INIT_SUCCEED:
+		if (!zswap_has_pool)
+			pr_err("can't enable, no pool configured\n");
+		else
+			ret = param_set_bool(val, kp);
+		break;
+	case ZSWAP_INIT_FAILED:
+		pr_err("can't enable, initialization failed\n");
+	}
+	mutex_unlock(&zswap_init_lock);
+
+	return ret;
+}
+
 /* should be called under RCU */
 #ifdef CONFIG_MEMCG
 static inline struct mem_cgroup *mem_cgroup_from_entry(struct zswap_entry *entry)
@@ -1163,162 +1319,6 @@ static void shrink_worker(struct work_struct *w)
 	zswap_pool_put(pool);
 }
 
-/*********************************
-* param callbacks
-**********************************/
-
-static bool zswap_pool_changed(const char *s, const struct kernel_param *kp)
-{
-	/* no change required */
-	if (!strcmp(s, *(char **)kp->arg) && zswap_has_pool)
-		return false;
-	return true;
-}
-
-/* val must be a null-terminated string */
-static int __zswap_param_set(const char *val, const struct kernel_param *kp,
-			     char *type, char *compressor)
-{
-	struct zswap_pool *pool, *put_pool = NULL;
-	char *s = strstrip((char *)val);
-	int ret = 0;
-	bool new_pool = false;
-
-	mutex_lock(&zswap_init_lock);
-	switch (zswap_init_state) {
-	case ZSWAP_UNINIT:
-		/* if this is load-time (pre-init) param setting,
-		 * don't create a pool; that's done during init.
-		 */
-		ret = param_set_charp(s, kp);
-		break;
-	case ZSWAP_INIT_SUCCEED:
-		new_pool = zswap_pool_changed(s, kp);
-		break;
-	case ZSWAP_INIT_FAILED:
-		pr_err("can't set param, initialization failed\n");
-		ret = -ENODEV;
-	}
-	mutex_unlock(&zswap_init_lock);
-
-	/* no need to create a new pool, return directly */
-	if (!new_pool)
-		return ret;
-
-	if (!type) {
-		if (!zpool_has_pool(s)) {
-			pr_err("zpool %s not available\n", s);
-			return -ENOENT;
-		}
-		type = s;
-	} else if (!compressor) {
-		if (!crypto_has_acomp(s, 0, 0)) {
-			pr_err("compressor %s not available\n", s);
-			return -ENOENT;
-		}
-		compressor = s;
-	} else {
-		WARN_ON(1);
-		return -EINVAL;
-	}
-
-	spin_lock(&zswap_pools_lock);
-
-	pool = zswap_pool_find_get(type, compressor);
-	if (pool) {
-		zswap_pool_debug("using existing", pool);
-		WARN_ON(pool == zswap_pool_current());
-		list_del_rcu(&pool->list);
-	}
-
-	spin_unlock(&zswap_pools_lock);
-
-	if (!pool)
-		pool = zswap_pool_create(type, compressor);
-
-	if (pool)
-		ret = param_set_charp(s, kp);
-	else
-		ret = -EINVAL;
-
-	spin_lock(&zswap_pools_lock);
-
-	if (!ret) {
-		put_pool = zswap_pool_current();
-		list_add_rcu(&pool->list, &zswap_pools);
-		zswap_has_pool = true;
-	} else if (pool) {
-		/* add the possibly pre-existing pool to the end of the pools
-		 * list; if it's new (and empty) then it'll be removed and
-		 * destroyed by the put after we drop the lock
-		 */
-		list_add_tail_rcu(&pool->list, &zswap_pools);
-		put_pool = pool;
-	}
-
-	spin_unlock(&zswap_pools_lock);
-
-	if (!zswap_has_pool && !pool) {
-		/* if initial pool creation failed, and this pool creation also
-		 * failed, maybe both compressor and zpool params were bad.
-		 * Allow changing this param, so pool creation will succeed
-		 * when the other param is changed. We already verified this
-		 * param is ok in the zpool_has_pool() or crypto_has_acomp()
-		 * checks above.
-		 */
-		ret = param_set_charp(s, kp);
-	}
-
-	/* drop the ref from either the old current pool,
-	 * or the new pool we failed to add
-	 */
-	if (put_pool)
-		zswap_pool_put(put_pool);
-
-	return ret;
-}
-
-static int zswap_compressor_param_set(const char *val,
-				      const struct kernel_param *kp)
-{
-	return __zswap_param_set(val, kp, zswap_zpool_type, NULL);
-}
-
-static int zswap_zpool_param_set(const char *val,
-				 const struct kernel_param *kp)
-{
-	return __zswap_param_set(val, kp, NULL, zswap_compressor);
-}
-
-static int zswap_enabled_param_set(const char *val,
-				   const struct kernel_param *kp)
-{
-	int ret = -ENODEV;
-
-	/* if this is load-time (pre-init) param setting, only set param. */
-	if (system_state != SYSTEM_RUNNING)
-		return param_set_bool(val, kp);
-
-	mutex_lock(&zswap_init_lock);
-	switch (zswap_init_state) {
-	case ZSWAP_UNINIT:
-		if (zswap_setup())
-			break;
-		fallthrough;
-	case ZSWAP_INIT_SUCCEED:
-		if (!zswap_has_pool)
-			pr_err("can't enable, no pool configured\n");
-		else
-			ret = param_set_bool(val, kp);
-		break;
-	case ZSWAP_INIT_FAILED:
-		pr_err("can't enable, initialization failed\n");
-	}
-	mutex_unlock(&zswap_init_lock);
-
-	return ret;
-}
-
 static bool zswap_compress(struct folio *folio, struct zswap_entry *entry)
 {
 	struct crypto_acomp_ctx *acomp_ctx;
-- 
2.43.0


