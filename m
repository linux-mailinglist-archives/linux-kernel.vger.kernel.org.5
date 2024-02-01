Return-Path: <linux-kernel+bounces-48441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4520C845C1C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 16:50:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 015DA29B1E2
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 15:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45347626DE;
	Thu,  1 Feb 2024 15:50:24 +0000 (UTC)
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6363626B1
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 15:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706802623; cv=none; b=mrpFEZT4RjrgZRNOsyeHsJvF1N+ykS3g0ERJrZip4eE/3CMvkWD12r1xGxXHtSlnAvrZCAE+02IVg50e4XYNHDhT2mrpY0KwekhobFLHYEKUtVlUScH3QxOyfeQYbOJOcx73ziNt0OQfCfqAWkhoyWHp9GWohu38ccWW+Dj3nWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706802623; c=relaxed/simple;
	bh=VIfBITSqfy8Lon0qFpUTWH3+qtn/IpinT6X9/XbmeYc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YmZndBLW7fx/uTaRVDuUHV55FEweuXbJqi4+OxHVcmaFUjCd/hBCNKSj52/w1eNLTjQbtXbIb8Q+Q1PYn3jHvPYaOLwUYGAQorhzDIjAXI394JipekXoVyDe9t/Va4FIwqarmqIWEZGMIIDCwmJ1AUOUh3tgh4J/GSL/be3/xjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=linux.dev; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <zhouchengming@bytedance.com>
Date: Thu, 01 Feb 2024 15:49:01 +0000
Subject: [PATCH 1/6] mm/zswap: add more comments in shrink_memcg_cb()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240201-b4-zswap-invalidate-entry-v1-1-56ed496b6e55@bytedance.com>
References: <20240201-b4-zswap-invalidate-entry-v1-0-56ed496b6e55@bytedance.com>
In-Reply-To: <20240201-b4-zswap-invalidate-entry-v1-0-56ed496b6e55@bytedance.com>
To: Nhat Pham <nphamcs@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>, Andrew Morton <akpm@linux-foundation.org>,
 Yosry Ahmed <yosryahmed@google.com>
Cc: linux-kernel@vger.kernel.org, Yosry Ahmed <yosryahmed@google.com>, Chengming Zhou <zhouchengming@bytedance.com>,
 Johannes Weiner <hannes@cmpxchg.org>, linux-mm@kvack.org
X-Migadu-Flow: FLOW_OUT

Add more comments in shrink_memcg_cb() to describe the deref dance
which is implemented to fix race problem between lru writeback and
swapoff, and the reason why we rotate the entry at the beginning.

Also fix the stale comments in zswap_writeback_entry(), and add
more comments to state that we only deref the tree after we get
the swapcache reference.

Suggested-by: Yosry Ahmed <yosryahmed@google.com>
Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
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

