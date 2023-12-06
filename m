Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC459806AFE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 10:46:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377266AbjLFJqb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 04:46:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377255AbjLFJq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 04:46:29 -0500
Received: from out-184.mta1.migadu.com (out-184.mta1.migadu.com [95.215.58.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C2EFBA
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 01:46:35 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Chengming Zhou <zhouchengming@bytedance.com>
Date:   Wed, 06 Dec 2023 09:46:24 +0000
Subject: [PATCH 1/7] mm/zswap: make sure each swapfile always have zswap rb-tree
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231206-zswap-lock-optimize-v1-1-e25b059f9c3a@bytedance.com>
References: <20231206-zswap-lock-optimize-v1-0-e25b059f9c3a@bytedance.com>
In-Reply-To: <20231206-zswap-lock-optimize-v1-0-e25b059f9c3a@bytedance.com>
To:     Vitaly Wool <vitaly.wool@konsulko.com>,
        Nhat Pham <nphamcs@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yosry Ahmed <yosryahmed@google.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701855988; l=3698;
 i=zhouchengming@bytedance.com; s=20231204; h=from:subject:message-id;
 bh=PZN0xLXpa6FJXo43SkR7sRqIVKPQ5jd6uVBrSVx9EAE=;
 b=/IE8MsA85GAZ6MZCk9fTWWd8zckSLavOzPjJFd5hfxDZQxaW88TjMxNyw9krvi0fXcdtJlBTb
 6fS45gqAMpsAiMJo+PpOcT2QfWAipRf/YXZ1gMVtSGgZ7M7zveNY0XP
X-Developer-Key: i=zhouchengming@bytedance.com; a=ed25519;
 pk=xFTmRtMG3vELGJBUiml7OYNdM393WOMv0iWWeQEVVdA=
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Not all zswap interfaces can handle the absence of the zswap rb-tree,
actually only zswap_store() has handled it for now.

To make things simple, we make sure each swapfile always have the
zswap rb-tree prepared before being enabled and used. The preparation
is unlikely to fail in practice, this patch just make it explicit.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 include/linux/zswap.h |  4 ++--
 mm/swapfile.c         | 10 +++++++---
 mm/zswap.c            |  7 ++++---
 3 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/include/linux/zswap.h b/include/linux/zswap.h
index 08c240e16a01..7cccc02cb9e9 100644
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
@@ -50,7 +50,7 @@ static inline bool zswap_load(struct folio *folio)
 }
 
 static inline void zswap_invalidate(int type, pgoff_t offset) {}
-static inline void zswap_swapon(int type) {}
+static inline int zswap_swapon(int type) {}
 static inline void zswap_swapoff(int type) {}
 static inline void zswap_memcg_offline_cleanup(struct mem_cgroup *memcg) {}
 static inline void zswap_lruvec_state_init(struct lruvec *lruvec) {}
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 8be70912e298..939e7590feda 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -2346,8 +2346,6 @@ static void enable_swap_info(struct swap_info_struct *p, int prio,
 				unsigned char *swap_map,
 				struct swap_cluster_info *cluster_info)
 {
-	zswap_swapon(p->type);
-
 	spin_lock(&swap_lock);
 	spin_lock(&p->lock);
 	setup_swap_info(p, prio, swap_map, cluster_info);
@@ -3165,6 +3163,10 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 	if (error)
 		goto bad_swap_unlock_inode;
 
+	error = zswap_swapon(p->type);
+	if (error)
+		goto free_swap_address_space;
+
 	/*
 	 * Flush any pending IO and dirty mappings before we start using this
 	 * swap device.
@@ -3173,7 +3175,7 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 	error = inode_drain_writes(inode);
 	if (error) {
 		inode->i_flags &= ~S_SWAPFILE;
-		goto free_swap_address_space;
+		goto free_swap_zswap;
 	}
 
 	mutex_lock(&swapon_mutex);
@@ -3197,6 +3199,8 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 
 	error = 0;
 	goto out;
+free_swap_zswap:
+	zswap_swapoff(p->type);
 free_swap_address_space:
 	exit_swap_address_space(p->type);
 bad_swap_unlock_inode:
diff --git a/mm/zswap.c b/mm/zswap.c
index 0f086ffd7b6a..5e2b8d5ee33b 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1560,7 +1560,7 @@ bool zswap_store(struct folio *folio)
 	if (folio_test_large(folio))
 		return false;
 
-	if (!zswap_enabled || !tree)
+	if (!zswap_enabled)
 		return false;
 
 	/*
@@ -1850,19 +1850,20 @@ void zswap_invalidate(int type, pgoff_t offset)
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
