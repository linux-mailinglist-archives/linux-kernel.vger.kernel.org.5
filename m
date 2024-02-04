Return-Path: <linux-kernel+bounces-51390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42FBC848ABF
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 04:06:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEFA6283F97
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 03:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 221EA8F5C;
	Sun,  4 Feb 2024 03:06:22 +0000 (UTC)
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2417465
	for <linux-kernel@vger.kernel.org>; Sun,  4 Feb 2024 03:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707015981; cv=none; b=d0FQlRcCrVS7TGnmoJIMm/5DLxSlQwTwj7k3RayhiESiZDx6zyrUuAR1uTzv4NW7AK8Xi1e0H8iOVU7jZCKE/uk/vBFY295sk7HsOHVZvKyic44UoIFyWbOKZny2LYyXYH5fv1xavCoGKKuqjwsctgpY+lYwGJvoDqzEroR6vHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707015981; c=relaxed/simple;
	bh=5FWNYWGWxUZhXLkqwTnflRB4+JFyB54M5WYwUuioX7o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Qjjsz2DbyRyLLrzUNC1W7+iHKzCO79Qn+z280PHQAQyPNiGbHuY9EtY2jQMgnKOGgVd/sBaONeUw5XIm34LoiZoYSlWNY2NZsE9ivS3D3lIdaX2/KzLGOqEKJ1mfNgRg1vbWoedGBKNbpVVv57KTNQ6jV0boViSO0XblOol6+UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=linux.dev; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <zhouchengming@bytedance.com>
Date: Sun, 04 Feb 2024 03:05:59 +0000
Subject: [PATCH v2 1/6] mm/zswap: add more comments in shrink_memcg_cb()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240201-b4-zswap-invalidate-entry-v2-1-99d4084260a0@bytedance.com>
References: <20240201-b4-zswap-invalidate-entry-v2-0-99d4084260a0@bytedance.com>
In-Reply-To: <20240201-b4-zswap-invalidate-entry-v2-0-99d4084260a0@bytedance.com>
To: Nhat Pham <nphamcs@gmail.com>, Yosry Ahmed <yosryahmed@google.com>, Andrew Morton <akpm@linux-foundation.org>,
 Johannes Weiner <hannes@cmpxchg.org>
Cc: linux-mm@kvack.org, Nhat Pham <nphamcs@gmail.com>, Chengming Zhou <zhouchengming@bytedance.com>,
 linux-kernel@vger.kernel.org, Yosry Ahmed <yosryahmed@google.com>, Johannes Weiner <hannes@cmpxchg.org>
X-Migadu-Flow: FLOW_OUT

Add more comments in shrink_memcg_cb() to describe the deref dance
which is implemented to fix race problem between lru writeback and
swapoff, and the reason why we rotate the entry at the beginning.

Also fix the stale comments in zswap_writeback_entry(), and add
more comments to state that we only deref the tree after we get
the swapcache reference.

Suggested-by: Yosry Ahmed <yosryahmed@google.com>
Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
Acked-by: Yosry Ahmed <yosryahmed@google.com>
Reviewed-by: Nhat Pham <nphamcs@gmail.com>
Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 mm/zswap.c | 43 ++++++++++++++++++++++++++-----------------
 1 file changed, 26 insertions(+), 17 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index 4aea03285532..735f1a6ef336 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1207,10 +1207,12 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
 
 	/*
 	 * folio is locked, and the swapcache is now secured against
-	 * concurrent swapping to and from the slot. Verify that the
-	 * swap entry hasn't been invalidated and recycled behind our
-	 * backs (our zswap_entry reference doesn't prevent that), to
-	 * avoid overwriting a new swap folio with old compressed data.
+	 * concurrent swapping to and from the slot, and concurrent
+	 * swapoff so we can safely dereference the zswap tree here.
+	 * Verify that the swap entry hasn't been invalidated and recycled
+	 * behind our backs, to avoid overwriting a new swap folio with
+	 * old compressed data. Only when this is successful can the entry
+	 * be dereferenced.
 	 */
 	tree = swap_zswap_tree(swpentry);
 	spin_lock(&tree->lock);
@@ -1263,22 +1265,29 @@ static enum lru_status shrink_memcg_cb(struct list_head *item, struct list_lru_o
 	int writeback_result;
 
 	/*
-	 * Rotate the entry to the tail before unlocking the LRU,
-	 * so that in case of an invalidation race concurrent
-	 * reclaimers don't waste their time on it.
+	 * As soon as we drop the LRU lock, the entry can be freed by
+	 * a concurrent invalidation. This means the following:
 	 *
-	 * If writeback succeeds, or failure is due to the entry
-	 * being invalidated by the swap subsystem, the invalidation
-	 * will unlink and free it.
+	 * 1. We extract the swp_entry_t to the stack, allowing
+	 *    zswap_writeback_entry() to pin the swap entry and
+	 *    then validate the zwap entry against that swap entry's
+	 *    tree using pointer value comparison. Only when that
+	 *    is successful can the entry be dereferenced.
 	 *
-	 * Temporary failures, where the same entry should be tried
-	 * again immediately, almost never happen for this shrinker.
-	 * We don't do any trylocking; -ENOMEM comes closest,
-	 * but that's extremely rare and doesn't happen spuriously
-	 * either. Don't bother distinguishing this case.
+	 * 2. Usually, objects are taken off the LRU for reclaim. In
+	 *    this case this isn't possible, because if reclaim fails
+	 *    for whatever reason, we have no means of knowing if the
+	 *    entry is alive to put it back on the LRU.
 	 *
-	 * But since they do exist in theory, the entry cannot just
-	 * be unlinked, or we could leak it. Hence, rotate.
+	 *    So rotate it before dropping the lock. If the entry is
+	 *    written back or invalidated, the free path will unlink
+	 *    it. For failures, rotation is the right thing as well.
+	 *
+	 *    Temporary failures, where the same entry should be tried
+	 *    again immediately, almost never happen for this shrinker.
+	 *    We don't do any trylocking; -ENOMEM comes closest,
+	 *    but that's extremely rare and doesn't happen spuriously
+	 *    either. Don't bother distinguishing this case.
 	 */
 	list_move_tail(item, &l->list);
 

-- 
b4 0.10.1

