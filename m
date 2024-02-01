Return-Path: <linux-kernel+bounces-48442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 333F1845C1F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 16:50:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C625E1F24791
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 15:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E55A626B4;
	Thu,  1 Feb 2024 15:50:27 +0000 (UTC)
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D62779E4
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 15:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706802626; cv=none; b=SDA3JsX2tbkC/j0M1FqfKdrM1o4MDiqlKONUr+pG7Jjr0wL2DtvzztXwLNTqZhguv2Qx8Rmy+EZGumjwz5Z8sep1DjEa2bT4Xn/jhayV7bF9i5nzwIWgmQHA9Wg0nSzAnEg5y1jufUcXBRVXhul4t0OcXB260VWj1gDBXqwVeoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706802626; c=relaxed/simple;
	bh=IDU9hzcPvRfJeOwCR6AGEfqusObhjLsrCZZpAPc6C7E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Bfw+nb4aXo3nRkGNoNKJ76N9HJsbW/qIHQAOf9LgyWO9qfKST1dK5/ln6uRaN+r0akTXtCSoWnz/hQhs4dyCLgBFSZvQjZd5K7cLZ6ZYQ/zoTHL2s2kYzEolLUijvWuDaH8YiuXMYAjegqDlU+HwQkk7ME3v1Pn7RuQib9Z0LT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=linux.dev; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <zhouchengming@bytedance.com>
Date: Thu, 01 Feb 2024 15:49:02 +0000
Subject: [PATCH 2/6] mm/zswap: invalidate zswap entry when swap entry free
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240201-b4-zswap-invalidate-entry-v1-2-56ed496b6e55@bytedance.com>
References: <20240201-b4-zswap-invalidate-entry-v1-0-56ed496b6e55@bytedance.com>
In-Reply-To: <20240201-b4-zswap-invalidate-entry-v1-0-56ed496b6e55@bytedance.com>
To: Nhat Pham <nphamcs@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>, Andrew Morton <akpm@linux-foundation.org>,
 Yosry Ahmed <yosryahmed@google.com>
Cc: linux-kernel@vger.kernel.org, Yosry Ahmed <yosryahmed@google.com>, Chengming Zhou <zhouchengming@bytedance.com>,
 Johannes Weiner <hannes@cmpxchg.org>, linux-mm@kvack.org
X-Migadu-Flow: FLOW_OUT

During testing I found there are some times the zswap_writeback_entry()
return -ENOMEM, which is not we expected:

bpftrace -e 'kr:zswap_writeback_entry {@[(int32)retval]=count()}'
@[-12]: 1563
@[0]: 277221

The reason is that __read_swap_cache_async() return NULL because
swapcache_prepare() failed. The reason is that we won't invalidate
zswap entry when swap entry freed to the per-cpu pool, these zswap
entries are still on the zswap tree and lru list.

This patch moves the invalidation ahead to when swap entry freed
to the per-cpu pool, since there is no any benefit to leave trashy
zswap entry on the tree and lru list.

With this patch:
bpftrace -e 'kr:zswap_writeback_entry {@[(int32)retval]=count()}'
@[0]: 259744

Note: large folio can't have zswap entry for now, so don't bother
to add zswap entry invalidation in the large folio swap free path.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 include/linux/zswap.h | 4 ++--
 mm/swap_slots.c       | 2 ++
 mm/swapfile.c         | 1 -
 mm/zswap.c            | 5 +++--
 4 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/include/linux/zswap.h b/include/linux/zswap.h
index 91895ce1fdbc..341aea490070 100644
--- a/include/linux/zswap.h
+++ b/include/linux/zswap.h
@@ -29,7 +29,7 @@ struct zswap_lruvec_state {
 
 bool zswap_store(struct folio *folio);
 bool zswap_load(struct folio *folio);
-void zswap_invalidate(int type, pgoff_t offset);
+void zswap_invalidate(swp_entry_t swp);
 int zswap_swapon(int type, unsigned long nr_pages);
 void zswap_swapoff(int type);
 void zswap_memcg_offline_cleanup(struct mem_cgroup *memcg);
@@ -50,7 +50,7 @@ static inline bool zswap_load(struct folio *folio)
 	return false;
 }
 
-static inline void zswap_invalidate(int type, pgoff_t offset) {}
+static inline void zswap_invalidate(swp_entry_t swp) {}
 static inline int zswap_swapon(int type, unsigned long nr_pages)
 {
 	return 0;
diff --git a/mm/swap_slots.c b/mm/swap_slots.c
index 0bec1f705f8e..d24cdea26daa 100644
--- a/mm/swap_slots.c
+++ b/mm/swap_slots.c
@@ -273,6 +273,8 @@ void free_swap_slot(swp_entry_t entry)
 {
 	struct swap_slots_cache *cache;
 
+	zswap_invalidate(entry);
+
 	cache = raw_cpu_ptr(&swp_slots);
 	if (likely(use_swap_slot_cache && cache->slots_ret)) {
 		spin_lock_irq(&cache->free_lock);
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 0580bb3e34d7..65b49db89b36 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -744,7 +744,6 @@ static void swap_range_free(struct swap_info_struct *si, unsigned long offset,
 		swap_slot_free_notify = NULL;
 	while (offset <= end) {
 		arch_swap_invalidate_page(si->type, offset);
-		zswap_invalidate(si->type, offset);
 		if (swap_slot_free_notify)
 			swap_slot_free_notify(si->bdev, offset);
 		offset++;
diff --git a/mm/zswap.c b/mm/zswap.c
index 735f1a6ef336..d8bb0e06e2b0 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1738,9 +1738,10 @@ bool zswap_load(struct folio *folio)
 	return true;
 }
 
-void zswap_invalidate(int type, pgoff_t offset)
+void zswap_invalidate(swp_entry_t swp)
 {
-	struct zswap_tree *tree = swap_zswap_tree(swp_entry(type, offset));
+	pgoff_t offset = swp_offset(swp);
+	struct zswap_tree *tree = swap_zswap_tree(swp);
 	struct zswap_entry *entry;
 
 	spin_lock(&tree->lock);

-- 
b4 0.10.1

