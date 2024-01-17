Return-Path: <linux-kernel+bounces-28723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2470830240
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 10:25:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3132DB25490
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 09:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9916F1C6BA;
	Wed, 17 Jan 2024 09:23:51 +0000 (UTC)
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4230314A90
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 09:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705483431; cv=none; b=TRIeRfZxr+fhK2FVDVCdQC92uWBqQQlTmmNS2XvrBziMLN4YOK/Tq0bkcRBXU2AbnUHNql84RVPZn6/vZ+ykwwn6S+9LX+Pb4CzVTb1GYIKVr0qINza2NUWXo7rIwOejUmtyPf9ngv9Z9q8P7ydKiJX40wrCA0WYzMKDp3XUeeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705483431; c=relaxed/simple;
	bh=yTwBO7fuapSePdtIIuK9uUbgWqoR7phetxp9o7hUhmg=;
	h=X-Report-Abuse:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Developer-Signature:X-Developer-Key:X-Migadu-Flow; b=NyEqBlS4vvSSzxtIVSVVUHCm9IbFpH/Le87+md3ieimfZ0JP9H+UhnYPblyfxbrTSpar0q0axb9W845GeLjsIBm1Dsfpz7fi4d1xCKtjOcUfFcJv48ntQjPybutEn29gLgywaGyVjiKC/IJneigppdt7ycasc6aoCUr5uG9e15I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=linux.dev; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <zhouchengming@bytedance.com>
Date: Wed, 17 Jan 2024 09:23:18 +0000
Subject: [PATCH 1/2] mm/zswap: make sure each swapfile always have zswap rb-tree
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240117-b4-zswap-lock-optimize-v1-1-23f6effe5775@bytedance.com>
References: <20240117-b4-zswap-lock-optimize-v1-0-23f6effe5775@bytedance.com>
In-Reply-To: <20240117-b4-zswap-lock-optimize-v1-0-23f6effe5775@bytedance.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Yosry Ahmed <yosryahmed@google.com>, Chengming Zhou <zhouchengming@bytedance.com>, linux-kernel@vger.kernel.org,
 Johannes Weiner <hannes@cmpxchg.org>, linux-mm@kvack.org, Chris Li <chriscli@google.com>, Nhat Pham <nphamcs@gmail.com>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1705483421; l=3720;
 i=zhouchengming@bytedance.com; s=20231204; h=from:subject:message-id;
 bh=yTwBO7fuapSePdtIIuK9uUbgWqoR7phetxp9o7hUhmg=;
 b=wqYBYZNagUKyFwJS+dwLD0bCqzZPOw7UPxfqGXbE4C15ul1rQmFIQtctYAEyQZZMDuUOGgUJR
 jMdWmww0EZ1Dhn9po3/A3DMC2ZRN/ZOwGBaYiDPVRhAnmGPf1AlNK4W
X-Developer-Key: i=zhouchengming@bytedance.com; a=ed25519;
 pk=xFTmRtMG3vELGJBUiml7OYNdM393WOMv0iWWeQEVVdA=
X-Migadu-Flow: FLOW_OUT

Not all zswap interfaces can handle the absence of the zswap rb-tree,
actually only zswap_store() has handled it for now.

To make things simple, we make sure each swapfile always have the
zswap rb-tree prepared before being enabled and used. The preparation
is unlikely to fail in practice, this patch just make it explicit.

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

