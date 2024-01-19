Return-Path: <linux-kernel+bounces-31086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFB8C8328B2
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 12:22:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7145D1F236EA
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 11:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 940724CB5A;
	Fri, 19 Jan 2024 11:22:37 +0000 (UTC)
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61E8DF56
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 11:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705663357; cv=none; b=UbaK5MJqy69jUZyhC7t63Ljg1B6exNNhQqgQPxk2i1TNnGyzfgPUbot3/aEiOH2xEC6LV6r2ayAuO5EIipv0ktX937rzBujPitW3dd6By/Sri11IyEtW2cwBzM6N9QTa3vlEztGzin9b/z2sD6l/vmzFH3G3Ae5DKk26Sw/qCpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705663357; c=relaxed/simple;
	bh=Ww0tpfXtXMIxkPC0TnYSY6Lo486E6iMFggamrlAqd04=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZNuja1QasOk3hPnkqvGrTmpTV6cBxBS1l20w8+kYmrkJ8LJY9FlVqYq1X9DeN4YQJZfbacb5+hDxx7YgZ7W3nwLDRlvtSK30hZn3IqGFXEUrRbhGnpQgCAb4YaehgQ1nVz1PximnY9QDVPm71sYM8fRuRVumGZ0OZLb5YhgWudw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=linux.dev; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <zhouchengming@bytedance.com>
Date: Fri, 19 Jan 2024 11:22:22 +0000
Subject: [PATCH v2 1/2] mm/zswap: make sure each swapfile always have zswap rb-tree
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240117-b4-zswap-lock-optimize-v2-1-b5cc55479090@bytedance.com>
References: <20240117-b4-zswap-lock-optimize-v2-0-b5cc55479090@bytedance.com>
In-Reply-To: <20240117-b4-zswap-lock-optimize-v2-0-b5cc55479090@bytedance.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Nhat Pham <nphamcs@gmail.com>, Yosry Ahmed <yosryahmed@google.com>, Chris Li <chriscli@google.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, Johannes Weiner <hannes@cmpxchg.org>,
 Chengming Zhou <zhouchengming@bytedance.com>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1705663348; l=3856;
 i=zhouchengming@bytedance.com; s=20231204; h=from:subject:message-id;
 bh=Ww0tpfXtXMIxkPC0TnYSY6Lo486E6iMFggamrlAqd04=;
 b=RsNXM/3brVq/czYsuZMfYA4JSKEbbtdqGV1hWHOScf1lIt+ZlT5Mg/lkd+fc47r4OgeUxFgEc
 GcQwCzexskfAeYSEKTUePrWu6U/JYT6UJHgMVkDommVe/YE9URXUvwU
X-Developer-Key: i=zhouchengming@bytedance.com; a=ed25519;
 pk=xFTmRtMG3vELGJBUiml7OYNdM393WOMv0iWWeQEVVdA=
X-Migadu-Flow: FLOW_OUT

Not all zswap interfaces can handle the absence of the zswap rb-tree,
actually only zswap_store() has handled it for now.

To make things simple, we make sure each swapfile always have the
zswap rb-tree prepared before being enabled and used. The preparation
is unlikely to fail in practice, this patch just make it explicit.

Acked-by: Nhat Pham <nphamcs@gmail.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Acked-by: Yosry Ahmed <yosryahmed@google.com>
Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 include/linux/zswap.h |  7 +++++--
 mm/swapfile.c         | 10 +++++++---
 mm/zswap.c            |  7 ++++---
 3 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/include/linux/zswap.h b/include/linux/zswap.h
index 0b709f5bc65f..eca388229d9a 100644
--- a/include/linux/zswap.h
+++ b/include/linux/zswap.h
@@ -30,7 +30,7 @@ struct zswap_lruvec_state {
 bool zswap_store(struct folio *folio);
 bool zswap_load(struct folio *folio);
 void zswap_invalidate(int type, pgoff_t offset);
-void zswap_swapon(int type);
+int zswap_swapon(int type);
 void zswap_swapoff(int type);
 void zswap_memcg_offline_cleanup(struct mem_cgroup *memcg);
 void zswap_lruvec_state_init(struct lruvec *lruvec);
@@ -51,7 +51,10 @@ static inline bool zswap_load(struct folio *folio)
 }
 
 static inline void zswap_invalidate(int type, pgoff_t offset) {}
-static inline void zswap_swapon(int type) {}
+static inline int zswap_swapon(int type)
+{
+	return 0;
+}
 static inline void zswap_swapoff(int type) {}
 static inline void zswap_memcg_offline_cleanup(struct mem_cgroup *memcg) {}
 static inline void zswap_lruvec_state_init(struct lruvec *lruvec) {}
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 3eec686484ef..6c53ea06626b 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -2347,8 +2347,6 @@ static void enable_swap_info(struct swap_info_struct *p, int prio,
 				unsigned char *swap_map,
 				struct swap_cluster_info *cluster_info)
 {
-	zswap_swapon(p->type);
-
 	spin_lock(&swap_lock);
 	spin_lock(&p->lock);
 	setup_swap_info(p, prio, swap_map, cluster_info);
@@ -3166,6 +3164,10 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 	if (error)
 		goto bad_swap_unlock_inode;
 
+	error = zswap_swapon(p->type);
+	if (error)
+		goto free_swap_address_space;
+
 	/*
 	 * Flush any pending IO and dirty mappings before we start using this
 	 * swap device.
@@ -3174,7 +3176,7 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 	error = inode_drain_writes(inode);
 	if (error) {
 		inode->i_flags &= ~S_SWAPFILE;
-		goto free_swap_address_space;
+		goto free_swap_zswap;
 	}
 
 	mutex_lock(&swapon_mutex);
@@ -3198,6 +3200,8 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 
 	error = 0;
 	goto out;
+free_swap_zswap:
+	zswap_swapoff(p->type);
 free_swap_address_space:
 	exit_swap_address_space(p->type);
 bad_swap_unlock_inode:
diff --git a/mm/zswap.c b/mm/zswap.c
index ca25b676048e..d88faea85978 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1519,7 +1519,7 @@ bool zswap_store(struct folio *folio)
 	if (folio_test_large(folio))
 		return false;
 
-	if (!zswap_enabled || !tree)
+	if (!zswap_enabled)
 		return false;
 
 	/*
@@ -1772,19 +1772,20 @@ void zswap_invalidate(int type, pgoff_t offset)
 	spin_unlock(&tree->lock);
 }
 
-void zswap_swapon(int type)
+int zswap_swapon(int type)
 {
 	struct zswap_tree *tree;
 
 	tree = kzalloc(sizeof(*tree), GFP_KERNEL);
 	if (!tree) {
 		pr_err("alloc failed, zswap disabled for swap type %d\n", type);
-		return;
+		return -ENOMEM;
 	}
 
 	tree->rbroot = RB_ROOT;
 	spin_lock_init(&tree->lock);
 	zswap_trees[type] = tree;
+	return 0;
 }
 
 void zswap_swapoff(int type)

-- 
b4 0.10.1

