Return-Path: <linux-kernel+bounces-99193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E85938784B2
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 17:12:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E2A71F22622
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 16:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50E02482CD;
	Mon, 11 Mar 2024 16:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="tcehlACN"
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBDCA4AEC0
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 16:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710173547; cv=none; b=O3fvEBcrIj5OFXQFzYkVeCucGjQlKIpYBpDH3+6kT7UkvlM8wTIlZgPfb2aj8uaatfCUvNMqfVuFJmBP6IN6A2FeJ4k6+XkmDttaRUla43DMPUuHOvIDDzrjPCBFxo8czJDerQ2C8ePbae9InxM7+aRIpYNJPG4S+OjgTaVO7I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710173547; c=relaxed/simple;
	bh=XEEOwN7Ry9kOe2JMBVViu1gvNBPX1aCYwAJwuqMMaXg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R773mafBNIzyzBbNnPUqfuj6iLmCzO4G83Oe1Ju1dsQsSPuSz99shvzQUXIwfNqIbrNY05vL42gu3JPLtC9ZNad8EpHv7nBnyUVCEGgMmbx2pSl+Hwz1jVzentHk5Gil6+RKvn9+dGnW8LtokOPgkGejVkSWvfIcsbyyvl/W27E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=tcehlACN; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-42f37657e91so13833981cf.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 09:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1710173542; x=1710778342; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Tw6Rxk9uZE/KG6yDJZXgFMWxZfv7cDqR1jIP/xjev4=;
        b=tcehlACNfjbMD4ZJ+xxjv2Sc/Z/Q63nL2JUrKLvCtg31n3ntTq57EW9GCI0am/Vrip
         mL4U6whsy8lrncLfJWOrvzYxAoCZ12AGHnGqRoND2iOza38/AkB00ET37o+DTSFD+0yA
         G+nucSbo0ehnbP3m1CHrOsSJpLtAtRAKPAxnGAN5BBRDX2qibCwDMmtOQ0llXFh5UkUg
         qXMwNHKlAJSakRxqNVir6g3XJ63nBh4PgMqDhO7BiOHTkPAKTulvIo8k0ca8VcRC8s+O
         +4WKc+jb1vghlbLyN8vruhKH6VjpaJaFC0LEPIBdO+lJkNU4wO6Y2+1MR7Ek5MlRECf3
         +G7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710173542; x=1710778342;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Tw6Rxk9uZE/KG6yDJZXgFMWxZfv7cDqR1jIP/xjev4=;
        b=wCxSCL9Juba2XnYbHOFAFCNRlzbsK28M4cbp7EKzlL6jEtOVzwn3/7tlIPuc6V+Dwt
         Qcq7liTmTtDfVHbCzxo8GhTpscsNJT3Q+1XGn4aWcIqM+y6E2VNDWNlLBROP/x+Fhwzv
         OPoG9T4rg4uMGwXxo77E7kcoLQXf+ggtZi7ZmHCme3veBnqkDGWNBNwLgfF4DVa/UDxX
         6E9n+ySq7Imv/71rlu30FLXO0nea2cifdOT/VAVNWm8GPMuFNsUAs3M7Jk7rgk/tgHRK
         ralZSTg4eeFzH7o02zBadrZGOUKtm8JmtNwgIQBMObGm5VQWf6wSfp1ZF8oZf0zWq2LZ
         /yYg==
X-Forwarded-Encrypted: i=1; AJvYcCWHEMIO4cDmjRwEyGJMRPNpFjJCHAqatvdbv1zQzoL+v8QSgr5jLXjgMV2AGZI1b5bd/aHoOliBOJnDkwKhiw6OEbv+mu+TmNOl8RMq
X-Gm-Message-State: AOJu0Yzx55vaXaIOjQ9p30gfWkiBDqJibG8j+c3b3RPAtdQ/MemP448s
	PKhB95aRNLw0XWmaoNVS8pPNTc7JZPkFLv6IuoPlwzq6dphpmrCkyKdYdDj58cRZwQF0zZt0QFq
	9
X-Google-Smtp-Source: AGHT+IGlq1xhGzojJ3qUchJop6FyehdDDMXdXQh+GuKAfRx5DKp0dyumWzTYON2PFURV+VnQeVQ6Ag==
X-Received: by 2002:a05:622a:50e:b0:42e:f6dc:bc7d with SMTP id l14-20020a05622a050e00b0042ef6dcbc7dmr10259718qtx.65.1710173542735;
        Mon, 11 Mar 2024 09:12:22 -0700 (PDT)
Received: from localhost (2603-7000-0c01-2716-da5e-d3ff-fee7-26e7.res6.spectrum.com. [2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id jr18-20020a05622a801200b0042f01e612bbsm2839309qtb.37.2024.03.11.09.12.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 09:12:22 -0700 (PDT)
From: Johannes Weiner <hannes@cmpxchg.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Yosry Ahmed <yosryahmed@google.com>,
	Nhat Pham <nphamcs@gmail.com>,
	Chengming Zhou <zhouchengming@bytedance.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] mm: zpool: return pool size in pages
Date: Mon, 11 Mar 2024 12:12:14 -0400
Message-ID: <20240311161214.1145168-2-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240311161214.1145168-1-hannes@cmpxchg.org>
References: <20240311161214.1145168-1-hannes@cmpxchg.org>
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
---
 mm/z3fold.c   | 2 +-
 mm/zbud.c     | 2 +-
 mm/zpool.c    | 4 ++--
 mm/zsmalloc.c | 2 +-
 mm/zswap.c    | 4 ++--
 5 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/mm/z3fold.c b/mm/z3fold.c
index 7ab05621052d..9bacacd4168c 100644
--- a/mm/z3fold.c
+++ b/mm/z3fold.c
@@ -1404,7 +1404,7 @@ static void z3fold_zpool_unmap(void *pool, unsigned long handle)
 
 static u64 z3fold_zpool_total_size(void *pool)
 {
-	return z3fold_get_pool_size(pool) * PAGE_SIZE;
+	return z3fold_get_pool_size(pool);
 }
 
 static struct zpool_driver z3fold_zpool_driver = {
diff --git a/mm/zbud.c b/mm/zbud.c
index 2190cc1f37b3..b7d8a22bbf5f 100644
--- a/mm/zbud.c
+++ b/mm/zbud.c
@@ -412,7 +412,7 @@ static void zbud_zpool_unmap(void *pool, unsigned long handle)
 
 static u64 zbud_zpool_total_size(void *pool)
 {
-	return zbud_get_pool_size(pool) * PAGE_SIZE;
+	return zbud_get_pool_size(pool);
 }
 
 static struct zpool_driver zbud_zpool_driver = {
diff --git a/mm/zpool.c b/mm/zpool.c
index 846410479c2f..410808aee7fe 100644
--- a/mm/zpool.c
+++ b/mm/zpool.c
@@ -324,9 +324,9 @@ void zpool_unmap_handle(struct zpool *zpool, unsigned long handle)
  * zpool_get_total_size() - The total size of the pool
  * @zpool:	The zpool to check
  *
- * This returns the total size in bytes of the pool.
+ * This returns the total size in pages of the pool.
  *
- * Returns: Total size of the zpool in bytes.
+ * Returns: Total size of the zpool in pages.
  */
 u64 zpool_get_total_size(struct zpool *zpool)
 {
diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 7d7cb3eaabe0..398f3856817f 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -401,7 +401,7 @@ static void zs_zpool_unmap(void *pool, unsigned long handle)
 
 static u64 zs_zpool_total_size(void *pool)
 {
-	return zs_get_total_pages(pool) << PAGE_SHIFT;
+	return zs_get_total_pages(pool);
 }
 
 static struct zpool_driver zs_zpool_driver = {
diff --git a/mm/zswap.c b/mm/zswap.c
index 7c39327a7cc2..fe4343e416e0 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -507,7 +507,7 @@ static unsigned long zswap_max_pages(void)
 unsigned long zswap_total_pages(void)
 {
 	struct zswap_pool *pool;
-	u64 total = 0;
+	unsigned long total = 0;
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(pool, &zswap_pools, list) {
@@ -518,7 +518,7 @@ unsigned long zswap_total_pages(void)
 	}
 	rcu_read_unlock();
 
-	return total >> PAGE_SHIFT;
+	return total;
 }
 
 /*********************************
-- 
2.44.0


