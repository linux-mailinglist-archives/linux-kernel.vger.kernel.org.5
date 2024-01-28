Return-Path: <linux-kernel+bounces-41632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46E8C83F59B
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 14:29:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E454A1F21D66
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 13:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF23C2E652;
	Sun, 28 Jan 2024 13:29:09 +0000 (UTC)
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587872D61A
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 13:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706448549; cv=none; b=ABwohtstMjexEuKJN+r3TweUoPn2VQDDoSuoVPM9EAdTA0cjAwQgZMYfttPt5NvU6TTp6hL3fiTnKeEsSt7jEo6hj2B9DipXOQyWIALeE7EvPGsfOMvKP+ZzYD24aZK2X0Qlv/pM7I2ZpJX2UJB835CIZ6qSY8Juzw7epVSU4Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706448549; c=relaxed/simple;
	bh=Jiif46CUAN2uYSxZHZz0ZQRYCqNrnLl2y3lLVaZde/E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JvYX3xdHHr/GAorXg90dVbvbH2t4JoCdJhR3Vb73T8gFq7FE84+cxt0JvIJ7oNcxP40HkHB/Hrs9Itus2P0hTiDnhoMx7LNozevC04eU35KO3TvQdW0nTaTanpSAt5URtxFdJcRCJ3mkvOCXiEnIwL6MG21qmRKdejeseBJ6lrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=linux.dev; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <zhouchengming@bytedance.com>
Date: Sun, 28 Jan 2024 13:28:51 +0000
Subject: [PATCH v2 3/3] mm/list_lru: remove list_lru_putback()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240126-zswap-writeback-race-v2-3-b10479847099@bytedance.com>
References: <20240126-zswap-writeback-race-v2-0-b10479847099@bytedance.com>
In-Reply-To: <20240126-zswap-writeback-race-v2-0-b10479847099@bytedance.com>
To: Johannes Weiner <hannes@cmpxchg.org>, Yosry Ahmed <yosryahmed@google.com>, Nhat Pham <nphamcs@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>, Chris Li <chriscli@google.com>
Cc: Chengming Zhou <zhouchengming@bytedance.com>, Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
X-Migadu-Flow: FLOW_OUT

Since the only user zswap_lru_putback() has gone, remove
list_lru_putback() too.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 include/linux/list_lru.h | 16 ----------------
 mm/list_lru.c            | 14 --------------
 mm/zswap.c               |  2 +-
 3 files changed, 1 insertion(+), 31 deletions(-)

diff --git a/include/linux/list_lru.h b/include/linux/list_lru.h
index c679e6b293c4..f2882a820690 100644
--- a/include/linux/list_lru.h
+++ b/include/linux/list_lru.h
@@ -168,22 +168,6 @@ static inline unsigned long list_lru_count(struct list_lru *lru)
 void list_lru_isolate(struct list_lru_one *list, struct list_head *item);
 void list_lru_isolate_move(struct list_lru_one *list, struct list_head *item,
 			   struct list_head *head);
-/**
- * list_lru_putback: undo list_lru_isolate
- * @lru: the lru pointer.
- * @item: the item to put back.
- * @nid: the node id of the sublist to put the item back to.
- * @memcg: the cgroup of the sublist to put the item back to.
- *
- * Put back an isolated item into its original LRU. Note that unlike
- * list_lru_add, this does not increment the node LRU count (as
- * list_lru_isolate does not originally decrement this count).
- *
- * Since we might have dropped the LRU lock in between, recompute list_lru_one
- * from the node's id and memcg.
- */
-void list_lru_putback(struct list_lru *lru, struct list_head *item, int nid,
-		      struct mem_cgroup *memcg);
 
 typedef enum lru_status (*list_lru_walk_cb)(struct list_head *item,
 		struct list_lru_one *list, spinlock_t *lock, void *cb_arg);
diff --git a/mm/list_lru.c b/mm/list_lru.c
index 158781d1d3c2..61f3b6b1134f 100644
--- a/mm/list_lru.c
+++ b/mm/list_lru.c
@@ -162,20 +162,6 @@ void list_lru_isolate_move(struct list_lru_one *list, struct list_head *item,
 }
 EXPORT_SYMBOL_GPL(list_lru_isolate_move);
 
-void list_lru_putback(struct list_lru *lru, struct list_head *item, int nid,
-		      struct mem_cgroup *memcg)
-{
-	struct list_lru_one *list =
-		list_lru_from_memcg_idx(lru, nid, memcg_kmem_id(memcg));
-
-	if (list_empty(item)) {
-		list_add_tail(item, &list->list);
-		if (!list->nr_items++)
-			set_shrinker_bit(memcg, nid, lru_shrinker_id(lru));
-	}
-}
-EXPORT_SYMBOL_GPL(list_lru_putback);
-
 unsigned long list_lru_count_one(struct list_lru *lru,
 				 int nid, struct mem_cgroup *memcg)
 {
diff --git a/mm/zswap.c b/mm/zswap.c
index f5cb5a46e4d7..de68a5928527 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -411,7 +411,7 @@ static void zswap_lru_add(struct list_lru *list_lru, struct zswap_entry *entry)
 	 * 2. list_lru_add() is called after memcg->kmemcg_id is updated. The
 	 *    new entry will be added directly to memcg's parent's list_lru.
 	 *
-	 * Similar reasoning holds for list_lru_del() and list_lru_putback().
+	 * Similar reasoning holds for list_lru_del().
 	 */
 	rcu_read_lock();
 	memcg = mem_cgroup_from_entry(entry);

-- 
b4 0.10.1

