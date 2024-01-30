Return-Path: <linux-kernel+bounces-43751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CD57841893
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 02:45:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4235C286B08
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 01:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F16B83C498;
	Tue, 30 Jan 2024 01:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="z3i79o8n"
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753FB383B1
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 01:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706578951; cv=none; b=REhr7txdjstltC/4GowZNPj7bUdYCSvLfmu1UvjaWALz0FKtSGe1sALapdP4X83QR2wz+eUgeZDToJxwFM36JQi6xix5Vhd/xrNBWvABIF3CEWqCZAqAm4KoB/gNcX1Yo+EfsD1ZqTy6lIM6s+xT8/3xNjHYgI2/v4KSUnPs06I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706578951; c=relaxed/simple;
	bh=Buqaio9vCxFs4jxwDb/cl7MtdsrmjbRE2WvaIIBaHdo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rPuCNpyO/we+3UaFKKF9C+KeYCshCSZUyn5q4bmu6Uq5iFXiXuCP+vr9u/FukglXXbgV8EbEJH8lijhY8FxswCHCjKZEGzyXJ/1Hml95q2gWc59RQZTxK+2r/dZTXs4yVZ9H6V2iKRMPxOy6yA+8NTyu09Cks7P5cgenj+e1HKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=z3i79o8n; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-783f27300b1so177391485a.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 17:42:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1706578948; x=1707183748; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6SQ/aPKt2RcQwCRNk0SkwceZy4++62pAYToaUxPVif8=;
        b=z3i79o8nEJUB6l4W4nAwTvXxdxY32XVqrTRRbBxjXfrIA3vU7LpxTlc5BPPJYF+9f1
         F2gangf9C+CkScZi0XH+iaoNnXUAMcye/6n4k2JpYQO3xH+qHug3HyABV6J+cDPplu8c
         xIQiJfEPic9Vvel8CaNFXe4C92Z8F3PvNNHhHe0GNqiwLHB2/invZRpfRQ38tKvDhQPP
         4xz3s70UmzvgVmyGZZsNR+xIHh7hcnswn//i6mJy14M3iIiU6EsnHxUU/GaU1m0/gOlk
         QQalqxkyfVRV31bD3+3g1118sxQ+YtxeP2WbLDt4vMJVR7NO4gEnEgNgOo5+zrKk34mJ
         kuCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706578948; x=1707183748;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6SQ/aPKt2RcQwCRNk0SkwceZy4++62pAYToaUxPVif8=;
        b=QlGVRB4Z4isW7727lOf7Q3Njb/n3qTFpzBrPgvy4F7O+bsfKZYT18jiUkZopoVtncX
         P1kRM2e8RYtW9ICs8zspmvtP5Et3TAN/mSvhFnDNTVtnO4OWMEjEm8oYfVaSEoCjaJZP
         VeZC+l2G4kNLHUo4EPaZJqz8wC6cjPmWBoNRi0Dr/gqteluAmdfCjiCsnOEh6I7+NdIu
         KbOXP6fTtor0G9ulN2xfY9k49J7bUdQVvPc/WQlXYG2YiZElKBJaAWkv14NJcLEXIap9
         59ZGXJBF3ZcSguGceHF8EexQeoMbbfAf32D7y6ASmzEe4GukRaMT0c/OwatHKiWPU0tZ
         PDXA==
X-Gm-Message-State: AOJu0Yz6kVCGVRyz4BKRerNMzqhLmf+4u6OYjK7K6mSQ4RcC1OSTu7rr
	5EPWtSkRCuqKDT/vZm+eHexFY+Rejf/IYbqfE3TGG57qaf/osHeR78Yl0hm7DkQynk4his5iI+P
	B
X-Google-Smtp-Source: AGHT+IHN9SfcdSpe35E+NdhAeZAJBp2Tlz+ZnOTskDGGlYQh7cy5auJKHnbJEqJ5ObxjfCI7Rxu3Cw==
X-Received: by 2002:ac8:5994:0:b0:42a:b152:c0fe with SMTP id e20-20020ac85994000000b0042ab152c0femr1228897qte.31.1706578948436;
        Mon, 29 Jan 2024 17:42:28 -0800 (PST)
Received: from localhost (2603-7000-0c01-2716-da5e-d3ff-fee7-26e7.res6.spectrum.com. [2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id ie7-20020a05622a698700b00427fabefe3bsm4023363qtb.52.2024.01.29.17.42.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 17:42:28 -0800 (PST)
From: Johannes Weiner <hannes@cmpxchg.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Nhat Pham <nphamcs@gmail.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	Chengming Zhou <zhouchengming@bytedance.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 12/20] mm: zswap: function ordering: zswap_pools
Date: Mon, 29 Jan 2024 20:36:48 -0500
Message-ID: <20240130014208.565554-13-hannes@cmpxchg.org>
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

Move the operations against the global zswap_pools list (current pool,
last, find) to the pool section.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/zswap.c | 150 ++++++++++++++++++++++++++---------------------------
 1 file changed, 73 insertions(+), 77 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index 33775f2224b7..168afd6767b3 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -517,6 +517,79 @@ static void zswap_pool_put(struct zswap_pool *pool)
 	kref_put(&pool->kref, __zswap_pool_empty);
 }
 
+static struct zswap_pool *__zswap_pool_current(void)
+{
+	struct zswap_pool *pool;
+
+	pool = list_first_or_null_rcu(&zswap_pools, typeof(*pool), list);
+	WARN_ONCE(!pool && zswap_has_pool,
+		  "%s: no page storage pool!\n", __func__);
+
+	return pool;
+}
+
+static struct zswap_pool *zswap_pool_current(void)
+{
+	assert_spin_locked(&zswap_pools_lock);
+
+	return __zswap_pool_current();
+}
+
+static struct zswap_pool *zswap_pool_current_get(void)
+{
+	struct zswap_pool *pool;
+
+	rcu_read_lock();
+
+	pool = __zswap_pool_current();
+	if (!zswap_pool_get(pool))
+		pool = NULL;
+
+	rcu_read_unlock();
+
+	return pool;
+}
+
+static struct zswap_pool *zswap_pool_last_get(void)
+{
+	struct zswap_pool *pool, *last = NULL;
+
+	rcu_read_lock();
+
+	list_for_each_entry_rcu(pool, &zswap_pools, list)
+		last = pool;
+	WARN_ONCE(!last && zswap_has_pool,
+		  "%s: no page storage pool!\n", __func__);
+	if (!zswap_pool_get(last))
+		last = NULL;
+
+	rcu_read_unlock();
+
+	return last;
+}
+
+/* type and compressor must be null-terminated */
+static struct zswap_pool *zswap_pool_find_get(char *type, char *compressor)
+{
+	struct zswap_pool *pool;
+
+	assert_spin_locked(&zswap_pools_lock);
+
+	list_for_each_entry_rcu(pool, &zswap_pools, list) {
+		if (strcmp(pool->tfm_name, compressor))
+			continue;
+		/* all zpools share the same type */
+		if (strcmp(zpool_get_type(pool->zpools[0]), type))
+			continue;
+		/* if we can't get it, it's about to be destroyed */
+		if (!zswap_pool_get(pool))
+			continue;
+		return pool;
+	}
+
+	return NULL;
+}
+
 /* should be called under RCU */
 #ifdef CONFIG_MEMCG
 static inline struct mem_cgroup *mem_cgroup_from_entry(struct zswap_entry *entry)
@@ -938,83 +1011,6 @@ static int zswap_cpu_comp_dead(unsigned int cpu, struct hlist_node *node)
 	return 0;
 }
 
-/*********************************
-* pool functions
-**********************************/
-
-static struct zswap_pool *__zswap_pool_current(void)
-{
-	struct zswap_pool *pool;
-
-	pool = list_first_or_null_rcu(&zswap_pools, typeof(*pool), list);
-	WARN_ONCE(!pool && zswap_has_pool,
-		  "%s: no page storage pool!\n", __func__);
-
-	return pool;
-}
-
-static struct zswap_pool *zswap_pool_current(void)
-{
-	assert_spin_locked(&zswap_pools_lock);
-
-	return __zswap_pool_current();
-}
-
-static struct zswap_pool *zswap_pool_current_get(void)
-{
-	struct zswap_pool *pool;
-
-	rcu_read_lock();
-
-	pool = __zswap_pool_current();
-	if (!zswap_pool_get(pool))
-		pool = NULL;
-
-	rcu_read_unlock();
-
-	return pool;
-}
-
-static struct zswap_pool *zswap_pool_last_get(void)
-{
-	struct zswap_pool *pool, *last = NULL;
-
-	rcu_read_lock();
-
-	list_for_each_entry_rcu(pool, &zswap_pools, list)
-		last = pool;
-	WARN_ONCE(!last && zswap_has_pool,
-		  "%s: no page storage pool!\n", __func__);
-	if (!zswap_pool_get(last))
-		last = NULL;
-
-	rcu_read_unlock();
-
-	return last;
-}
-
-/* type and compressor must be null-terminated */
-static struct zswap_pool *zswap_pool_find_get(char *type, char *compressor)
-{
-	struct zswap_pool *pool;
-
-	assert_spin_locked(&zswap_pools_lock);
-
-	list_for_each_entry_rcu(pool, &zswap_pools, list) {
-		if (strcmp(pool->tfm_name, compressor))
-			continue;
-		/* all zpools share the same type */
-		if (strcmp(zpool_get_type(pool->zpools[0]), type))
-			continue;
-		/* if we can't get it, it's about to be destroyed */
-		if (!zswap_pool_get(pool))
-			continue;
-		return pool;
-	}
-
-	return NULL;
-}
-
 static enum lru_status shrink_memcg_cb(struct list_head *item, struct list_lru_one *l,
 				       spinlock_t *lock, void *arg)
 {
-- 
2.43.0


