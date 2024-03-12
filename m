Return-Path: <linux-kernel+bounces-100461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49B088797CE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 16:39:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80BD4B213AF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 15:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 801237D402;
	Tue, 12 Mar 2024 15:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="P5bafuYp"
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C337D065
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 15:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710257952; cv=none; b=l28q4NSDCUZsf//YwgA1opULFce7n3lOJG4y72f7Fxm0LpBxHr+uFZKO+a0D6uMHDbNNRwDXGTa6/6S80ZLOUuUfKf+4rxk0nZ6++XBWX40dQyjVNngFxepyGadyX4O6jMsvSbYzTeOY0lEn9kxkgWCsTL2fEa909sO6x8GvS58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710257952; c=relaxed/simple;
	bh=EZT5Ex2+5t01OjMt31/mKLAN1gdnT3Jeu5ir+bzHxhA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t8NhozdUHiL+3d+eDKKxRXIZtVv9EiWiqCzZEmeDIwjztvT7m8fZ1XMTbBVR0jfTijQq2WH4a/kmxGFx/09urS9u7aCT3OChyh7Mj4YZP7V4HsxrCI/+sWneyghs+gAiweApH2TljxloilstmWg6TgxFDbxSJ8x7RFnVTvXQSgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=P5bafuYp; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-788412a4b78so203820585a.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 08:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1710257948; x=1710862748; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h2DM6mlGPAKI7DFYoFnNzPHH8HCk3l+GsFGDVmzzhKA=;
        b=P5bafuYpW4bCh22WRz10k3Lru6KXE6UHtKpAbOLftDKDfvGMott348I5dbUxz0WODR
         IYfKmPo3IQ/3E2y2Mmq4KqU3RVlLd61OKO21ckajIfTq5MeFleIabthbY4UAqvDcITeb
         VLD1inTS4ceRMdpyk5dzLe6jkQmZZWnZQp6jcHiFbtraOvNc2iPKeFfk7fkS68vNwohZ
         wcMPEPEaAvKNwOV5aYLOd0vxwZTiBLWhQd1lnt1Rme4NpMnkqVpLIYynk+FK095U6Yx6
         zligGDZRpvvw4tpjkHfTL/ZXN+mhviOgwRH/ttdXvaFyRBKkPJLYX2sR0AsiQEc/oYWx
         FU3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710257949; x=1710862749;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h2DM6mlGPAKI7DFYoFnNzPHH8HCk3l+GsFGDVmzzhKA=;
        b=dtCLR+G3I6jbAHLsyRyK8lxJvRX/uCtgET3VAFf3n9Qe0JcOgpwvcr5V2HAVpWEt9J
         Uou69YfbeCnkAfft51GAR38JYy8D4Bc9f+C0vaGdeG+vbARBinLlcz1nUPVP9DHFUeb5
         wXHwgoFWxo9RCNGFl3B9t+8fjtBKCfGyUNxioEy2mjgtwRShwyJ5eZ8hPjFFO8kNGAHZ
         eM8tHI2Ascmw6i+vpxrKUrYf1duJ/qG+loQLbAzemOE2maLDtboNVUlVNe+r3cxhrdPt
         AasnFoLMJ1sK5o5RC6LGFQKq3lokh1FTeEKLSITTBPYW6yx1bW4yDlt7KN3laKfcRooO
         xIWw==
X-Forwarded-Encrypted: i=1; AJvYcCXYJ2zqZTKYhBqHZk1+0M6S9fFc8VGT3zmIan/DpWYvZZPNYudb4TD7qPRAeXbmZkkxLnKNGP+BUcWYMl1xt4bTIkW5yd0aEWwwYwX1
X-Gm-Message-State: AOJu0YxgE7d466aRn1TcM2pSJ0iWXRkvSqLb5k1looljPYOW6OxJMwzc
	+LQ1df3Le7lH7f6y0Qjy3FxlIvTThmT6htmgbCLmA7RjiiDTMqBBbyMnknUICvY=
X-Google-Smtp-Source: AGHT+IFvfFC0MRbzB9GCLWGfG7mxScyDWBb8PTINTgkiZ/tKO5tky2aU1Y2xSEq5vl5hHo4IheWAyQ==
X-Received: by 2002:a0c:aadd:0:b0:690:bb9c:f0d6 with SMTP id g29-20020a0caadd000000b00690bb9cf0d6mr9207069qvb.18.1710257948669;
        Tue, 12 Mar 2024 08:39:08 -0700 (PDT)
Received: from localhost (2603-7000-0c01-2716-da5e-d3ff-fee7-26e7.res6.spectrum.com. [2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id ek19-20020ad45993000000b006907e34d029sm3783535qvb.2.2024.03.12.08.39.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 08:39:08 -0700 (PDT)
From: Johannes Weiner <hannes@cmpxchg.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Yosry Ahmed <yosryahmed@google.com>,
	Nhat Pham <nphamcs@gmail.com>,
	Chengming Zhou <zhouchengming@bytedance.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Chengming Zhou <chengming.zhou@linux.dev>
Subject: [PATCH 2/2] mm: zpool: return pool size in pages
Date: Tue, 12 Mar 2024 11:34:12 -0400
Message-ID: <20240312153901.3441-2-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240312153901.3441-1-hannes@cmpxchg.org>
References: <20240312153901.3441-1-hannes@cmpxchg.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All zswap backends track their pool sizes in pages. Currently they
multiply by PAGE_SIZE for zswap, only for zswap to divide again in
order to do limit math. Report pages directly.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
Acked-by: Yosry Ahmed <yosryahmed@google.com>
Reviewed-by: Chengming Zhou <chengming.zhou@linux.dev>
Reviewed-by: Nhat Pham <nphamcs@gmail.com>
---
 include/linux/zpool.h |  4 ++--
 mm/z3fold.c           | 10 +++++-----
 mm/zbud.c             | 10 +++++-----
 mm/zpool.c            | 10 +++++-----
 mm/zsmalloc.c         |  6 +++---
 mm/zswap.c            |  6 +++---
 6 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/include/linux/zpool.h b/include/linux/zpool.h
index 3296438eec06..a67d62b79698 100644
--- a/include/linux/zpool.h
+++ b/include/linux/zpool.h
@@ -53,7 +53,7 @@ void *zpool_map_handle(struct zpool *pool, unsigned long handle,
 
 void zpool_unmap_handle(struct zpool *pool, unsigned long handle);
 
-u64 zpool_get_total_size(struct zpool *pool);
+u64 zpool_get_total_pages(struct zpool *pool);
 
 
 /**
@@ -91,7 +91,7 @@ struct zpool_driver {
 				enum zpool_mapmode mm);
 	void (*unmap)(void *pool, unsigned long handle);
 
-	u64 (*total_size)(void *pool);
+	u64 (*total_pages)(void *pool);
 };
 
 void zpool_register_driver(struct zpool_driver *driver);
diff --git a/mm/z3fold.c b/mm/z3fold.c
index 7ab05621052d..2ebfed32871b 100644
--- a/mm/z3fold.c
+++ b/mm/z3fold.c
@@ -1237,12 +1237,12 @@ static void z3fold_unmap(struct z3fold_pool *pool, unsigned long handle)
 }
 
 /**
- * z3fold_get_pool_size() - gets the z3fold pool size in pages
+ * z3fold_get_pool_pages() - gets the z3fold pool size in pages
  * @pool:	pool whose size is being queried
  *
  * Returns: size in pages of the given pool.
  */
-static u64 z3fold_get_pool_size(struct z3fold_pool *pool)
+static u64 z3fold_get_pool_pages(struct z3fold_pool *pool)
 {
 	return atomic64_read(&pool->pages_nr);
 }
@@ -1402,9 +1402,9 @@ static void z3fold_zpool_unmap(void *pool, unsigned long handle)
 	z3fold_unmap(pool, handle);
 }
 
-static u64 z3fold_zpool_total_size(void *pool)
+static u64 z3fold_zpool_total_pages(void *pool)
 {
-	return z3fold_get_pool_size(pool) * PAGE_SIZE;
+	return z3fold_get_pool_pages(pool);
 }
 
 static struct zpool_driver z3fold_zpool_driver = {
@@ -1417,7 +1417,7 @@ static struct zpool_driver z3fold_zpool_driver = {
 	.free =		z3fold_zpool_free,
 	.map =		z3fold_zpool_map,
 	.unmap =	z3fold_zpool_unmap,
-	.total_size =	z3fold_zpool_total_size,
+	.total_pages =	z3fold_zpool_total_pages,
 };
 
 MODULE_ALIAS("zpool-z3fold");
diff --git a/mm/zbud.c b/mm/zbud.c
index 2190cc1f37b3..e9836fff9438 100644
--- a/mm/zbud.c
+++ b/mm/zbud.c
@@ -365,13 +365,13 @@ static void zbud_unmap(struct zbud_pool *pool, unsigned long handle)
 }
 
 /**
- * zbud_get_pool_size() - gets the zbud pool size in pages
+ * zbud_get_pool_pages() - gets the zbud pool size in pages
  * @pool:	pool whose size is being queried
  *
  * Returns: size in pages of the given pool.  The pool lock need not be
  * taken to access pages_nr.
  */
-static u64 zbud_get_pool_size(struct zbud_pool *pool)
+static u64 zbud_get_pool_pages(struct zbud_pool *pool)
 {
 	return pool->pages_nr;
 }
@@ -410,9 +410,9 @@ static void zbud_zpool_unmap(void *pool, unsigned long handle)
 	zbud_unmap(pool, handle);
 }
 
-static u64 zbud_zpool_total_size(void *pool)
+static u64 zbud_zpool_total_pages(void *pool)
 {
-	return zbud_get_pool_size(pool) * PAGE_SIZE;
+	return zbud_get_pool_pages(pool);
 }
 
 static struct zpool_driver zbud_zpool_driver = {
@@ -425,7 +425,7 @@ static struct zpool_driver zbud_zpool_driver = {
 	.free =		zbud_zpool_free,
 	.map =		zbud_zpool_map,
 	.unmap =	zbud_zpool_unmap,
-	.total_size =	zbud_zpool_total_size,
+	.total_pages =	zbud_zpool_total_pages,
 };
 
 MODULE_ALIAS("zpool-zbud");
diff --git a/mm/zpool.c b/mm/zpool.c
index 846410479c2f..b9fda1fa857d 100644
--- a/mm/zpool.c
+++ b/mm/zpool.c
@@ -321,16 +321,16 @@ void zpool_unmap_handle(struct zpool *zpool, unsigned long handle)
 }
 
 /**
- * zpool_get_total_size() - The total size of the pool
+ * zpool_get_total_pages() - The total size of the pool
  * @zpool:	The zpool to check
  *
- * This returns the total size in bytes of the pool.
+ * This returns the total size in pages of the pool.
  *
- * Returns: Total size of the zpool in bytes.
+ * Returns: Total size of the zpool in pages.
  */
-u64 zpool_get_total_size(struct zpool *zpool)
+u64 zpool_get_total_pages(struct zpool *zpool)
 {
-	return zpool->driver->total_size(zpool->pool);
+	return zpool->driver->total_pages(zpool->pool);
 }
 
 /**
diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 7d7cb3eaabe0..b42d3545ca85 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -399,9 +399,9 @@ static void zs_zpool_unmap(void *pool, unsigned long handle)
 	zs_unmap_object(pool, handle);
 }
 
-static u64 zs_zpool_total_size(void *pool)
+static u64 zs_zpool_total_pages(void *pool)
 {
-	return zs_get_total_pages(pool) << PAGE_SHIFT;
+	return zs_get_total_pages(pool);
 }
 
 static struct zpool_driver zs_zpool_driver = {
@@ -414,7 +414,7 @@ static struct zpool_driver zs_zpool_driver = {
 	.free =			  zs_zpool_free,
 	.map =			  zs_zpool_map,
 	.unmap =		  zs_zpool_unmap,
-	.total_size =		  zs_zpool_total_size,
+	.total_pages =		  zs_zpool_total_pages,
 };
 
 MODULE_ALIAS("zpool-zsmalloc");
diff --git a/mm/zswap.c b/mm/zswap.c
index 1a5cc7298306..9fdf4c76d5ea 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -512,18 +512,18 @@ static unsigned long zswap_accept_thr_pages(void)
 unsigned long zswap_total_pages(void)
 {
 	struct zswap_pool *pool;
-	u64 total = 0;
+	unsigned long total = 0;
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(pool, &zswap_pools, list) {
 		int i;
 
 		for (i = 0; i < ZSWAP_NR_ZPOOLS; i++)
-			total += zpool_get_total_size(pool->zpools[i]);
+			total += zpool_get_total_pages(pool->zpools[i]);
 	}
 	rcu_read_unlock();
 
-	return total >> PAGE_SHIFT;
+	return total;
 }
 
 /*********************************
-- 
2.44.0


