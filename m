Return-Path: <linux-kernel+bounces-43754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82637841897
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 02:45:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A47A11C23037
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 01:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A721B53E3F;
	Tue, 30 Jan 2024 01:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="l7I0NIXm"
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD61364A9
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 01:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706578954; cv=none; b=Y+eZjuthaPKst9gZkS1GofwzluL8v/CUkqH7j4KRv1Y6ZVG/q6vFoHuMN8Kz+R+c9nVyngvJCPD8VTHWdo5hjKSHF+MeOrFitDfl4foTT+FfcWZk3nDXNCA8haHTooActDq58Vqrx+0NhNw7LcQi34MrYuwLzytPCUA+7BYoMPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706578954; c=relaxed/simple;
	bh=xzvZY6bnQkl1W2vbljM09CjWqJF86VWG5/XGpHCWjw4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HpTpGwBnNqlSa+t2EMhBbwoM2/NHXpU2BKPPgphh0ph2yzi8ZS4+0ea5tkoTo5lvCjlyX+TxuUu9s4LWnZnnVcBrkW4uiKVPdpRJWQCw3KtvHbfyBmy2s0i4kLvhVyttt2e/z6QbBKS0XheHxQS5TMnTClCA5DlzIZxwe9psnvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=l7I0NIXm; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-78405c9a152so63668885a.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 17:42:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1706578952; x=1707183752; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yxxBC8E+iSnomrO4M1Zu6Eym4Wq/S4pyguWdd0McoRg=;
        b=l7I0NIXmcDOjwbzxO7aamOi0qBufgb5Sfo2HhDkU2u1403oj9TtPB3YUZI0QnZwJEk
         aHKTob+J6+ew0AVDIuS2eEfB1HnaDa1dyhMO9DdZ9wmUvkmy+FfO4AUpUSSgG9WkX1B1
         AUUl6E2uwk4/Mlgma/OkYUsezhMcRq2zM5wOs+cJDtiCZX0KSBkmxlBKb7GVAkj1qDew
         lPpeUhwA4rh+rRLeGvMbUVp+IojiwPCMhfNIzhIj4tapNYQh3DwQ3zkeLgi0gCc7AKPd
         6Tvi16+IDYQdK/pz9H8vBl03dw+TR7syUSJE1j88stkwuLw5p9sUCbIZRBnDgm8lbKW1
         hZEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706578952; x=1707183752;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yxxBC8E+iSnomrO4M1Zu6Eym4Wq/S4pyguWdd0McoRg=;
        b=J3SLpMxQpl+xbjKchrIhYH7MgdoDVgZ7czKtuh9r66EVIKJyyVjiHL/vpNmsPqt8+V
         6EuUXlQtImYspQufm/rBSkwtneXSscjGWaifBclOE1SqrKrpClp7hYIqvO4/qFzeB5i8
         7S7mZHvzPH13nlmG1Zax8Pk1KiGcAFg5MmFEZF6x3EvDp8gI1Dw/6qrRtiuJ2MHsgpF7
         14LUSNeHtHKXBA9RvhzTUHVF9LSfn9x9OFLA52FS5kA8eJUgSCAXg7yePR1oxBYlJ5zn
         ERWge6iOoYFGilgQH264SWnEXIYftIP3pP2IwRvFi2GIdDIUE4NTwZknuNJv32zAXydy
         xrCw==
X-Gm-Message-State: AOJu0YyZIauirLiGx+gWkS5nlKKX2gTn8hXb5mbpL5cJRaoq1vL+ti63
	lNznSrTwMy542nzQa6TXJIgV1VwVOPCqsMbr1F6gFsk5PgIibI2yBOdEEWFHVyc=
X-Google-Smtp-Source: AGHT+IH0Ej2IVjNTByv8ncwfD8JySniOOvwcT3ZZLF3iZpkW+vzHER0j5wJzpzxzw9guVH1KYf0/nw==
X-Received: by 2002:a05:6214:2681:b0:681:98bd:644 with SMTP id gm1-20020a056214268100b0068198bd0644mr8490769qvb.119.1706578952162;
        Mon, 29 Jan 2024 17:42:32 -0800 (PST)
Received: from localhost (2603-7000-0c01-2716-da5e-d3ff-fee7-26e7.res6.spectrum.com. [2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id ow9-20020a0562143f8900b0068692ea038esm3974062qvb.91.2024.01.29.17.42.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 17:42:31 -0800 (PST)
From: Johannes Weiner <hannes@cmpxchg.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Nhat Pham <nphamcs@gmail.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	Chengming Zhou <zhouchengming@bytedance.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 15/20] mm: zswap: function ordering: move entry sections out of LRU section
Date: Mon, 29 Jan 2024 20:36:51 -0500
Message-ID: <20240130014208.565554-16-hannes@cmpxchg.org>
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

This completes consolidation of the LRU section.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/zswap.c | 101 ++++++++++++++++++++++++++---------------------------
 1 file changed, 49 insertions(+), 52 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index 511bfafc1456..756d4d575efe 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -768,58 +768,6 @@ static inline int entry_to_nid(struct zswap_entry *entry)
 	return page_to_nid(virt_to_page(entry));
 }
 
-void zswap_lruvec_state_init(struct lruvec *lruvec)
-{
-	atomic_long_set(&lruvec->zswap_lruvec_state.nr_zswap_protected, 0);
-}
-
-void zswap_folio_swapin(struct folio *folio)
-{
-	struct lruvec *lruvec;
-
-	if (folio) {
-		lruvec = folio_lruvec(folio);
-		atomic_long_inc(&lruvec->zswap_lruvec_state.nr_zswap_protected);
-	}
-}
-
-void zswap_memcg_offline_cleanup(struct mem_cgroup *memcg)
-{
-	struct zswap_pool *pool;
-
-	/* lock out zswap pools list modification */
-	spin_lock(&zswap_pools_lock);
-	list_for_each_entry(pool, &zswap_pools, list) {
-		if (pool->next_shrink == memcg)
-			pool->next_shrink = mem_cgroup_iter(NULL, pool->next_shrink, NULL);
-	}
-	spin_unlock(&zswap_pools_lock);
-}
-
-/*********************************
-* zswap entry functions
-**********************************/
-static struct kmem_cache *zswap_entry_cache;
-
-static struct zswap_entry *zswap_entry_cache_alloc(gfp_t gfp, int nid)
-{
-	struct zswap_entry *entry;
-	entry = kmem_cache_alloc_node(zswap_entry_cache, gfp, nid);
-	if (!entry)
-		return NULL;
-	entry->refcount = 1;
-	RB_CLEAR_NODE(&entry->rbnode);
-	return entry;
-}
-
-static void zswap_entry_cache_free(struct zswap_entry *entry)
-{
-	kmem_cache_free(zswap_entry_cache, entry);
-}
-
-/*********************************
-* lru functions
-**********************************/
 static void zswap_lru_add(struct list_lru *list_lru, struct zswap_entry *entry)
 {
 	atomic_long_t *nr_zswap_protected;
@@ -872,6 +820,55 @@ static void zswap_lru_del(struct list_lru *list_lru, struct zswap_entry *entry)
 	rcu_read_unlock();
 }
 
+void zswap_lruvec_state_init(struct lruvec *lruvec)
+{
+	atomic_long_set(&lruvec->zswap_lruvec_state.nr_zswap_protected, 0);
+}
+
+void zswap_folio_swapin(struct folio *folio)
+{
+	struct lruvec *lruvec;
+
+	if (folio) {
+		lruvec = folio_lruvec(folio);
+		atomic_long_inc(&lruvec->zswap_lruvec_state.nr_zswap_protected);
+	}
+}
+
+void zswap_memcg_offline_cleanup(struct mem_cgroup *memcg)
+{
+	struct zswap_pool *pool;
+
+	/* lock out zswap pools list modification */
+	spin_lock(&zswap_pools_lock);
+	list_for_each_entry(pool, &zswap_pools, list) {
+		if (pool->next_shrink == memcg)
+			pool->next_shrink = mem_cgroup_iter(NULL, pool->next_shrink, NULL);
+	}
+	spin_unlock(&zswap_pools_lock);
+}
+
+/*********************************
+* zswap entry functions
+**********************************/
+static struct kmem_cache *zswap_entry_cache;
+
+static struct zswap_entry *zswap_entry_cache_alloc(gfp_t gfp, int nid)
+{
+	struct zswap_entry *entry;
+	entry = kmem_cache_alloc_node(zswap_entry_cache, gfp, nid);
+	if (!entry)
+		return NULL;
+	entry->refcount = 1;
+	RB_CLEAR_NODE(&entry->rbnode);
+	return entry;
+}
+
+static void zswap_entry_cache_free(struct zswap_entry *entry)
+{
+	kmem_cache_free(zswap_entry_cache, entry);
+}
+
 /*********************************
 * rbtree functions
 **********************************/
-- 
2.43.0


