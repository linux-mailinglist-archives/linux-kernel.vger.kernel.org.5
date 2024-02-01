Return-Path: <linux-kernel+bounces-48444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A9CE845C2D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 16:55:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F4AFB2E21A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 15:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CED8A1586EC;
	Thu,  1 Feb 2024 15:50:30 +0000 (UTC)
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 901BA626C3
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 15:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706802630; cv=none; b=A1NqoStDYCH7aZbuPwRAirM62Ifyotjmy74U28FMIddudft2dNJjsKJnSa6vkDWqAIwK2T0bRc1s85EM402XbDaAPDmHh/Tbh/vepsrPT/a4AQ4KIUoz2WvPxrQbXlUxbwNb0FnJ8MLzk5Hpr+ppn3lOUIDJgqa7Cz05rrvscoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706802630; c=relaxed/simple;
	bh=EneozQOLijn3mz/tCwZ3SUcDPg/E5H8aY21nswi5KHc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Jj5YV4oBvwyksHXq1iGjW5Ivx/OqIg32GMjFlRM5PgNSnkm2LGN7qZySc53JI/rTfArdL+66Sc2hZ+tfTtpGp3IsZ41Q+Vy3h9NJRETHIwD7swkebDE7pTeSxF1E/GhJqcepuaoaX68FaSm87Gjy1H3oynA2CAZpGSiZTKk6688=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=linux.dev; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <zhouchengming@bytedance.com>
Date: Thu, 01 Feb 2024 15:49:03 +0000
Subject: [PATCH 3/6] mm/zswap: stop lru list shrinking when encounter warm region
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240201-b4-zswap-invalidate-entry-v1-3-56ed496b6e55@bytedance.com>
References: <20240201-b4-zswap-invalidate-entry-v1-0-56ed496b6e55@bytedance.com>
In-Reply-To: <20240201-b4-zswap-invalidate-entry-v1-0-56ed496b6e55@bytedance.com>
To: Nhat Pham <nphamcs@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>, Andrew Morton <akpm@linux-foundation.org>,
 Yosry Ahmed <yosryahmed@google.com>
Cc: linux-kernel@vger.kernel.org, Yosry Ahmed <yosryahmed@google.com>, Chengming Zhou <zhouchengming@bytedance.com>,
 Johannes Weiner <hannes@cmpxchg.org>, linux-mm@kvack.org
X-Migadu-Flow: FLOW_OUT

When the shrinker encounter an existing folio in swap cache, it means
we are shrinking into the warmer region. We should terminate shrinking
if we're in the dynamic shrinker context.

This patch add LRU_STOP to support this, to avoid overshrinking.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 include/linux/list_lru.h | 1 +
 mm/list_lru.c            | 3 +++
 mm/zswap.c               | 4 +++-
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/linux/list_lru.h b/include/linux/list_lru.h
index f2882a820690..5633e970144b 100644
--- a/include/linux/list_lru.h
+++ b/include/linux/list_lru.h
@@ -24,6 +24,7 @@ enum lru_status {
 	LRU_SKIP,		/* item cannot be locked, skip */
 	LRU_RETRY,		/* item not freeable. May drop the lock
 				   internally, but has to return locked. */
+	LRU_STOP,		/* stop lru list walking */
 };
 
 struct list_lru_one {
diff --git a/mm/list_lru.c b/mm/list_lru.c
index 61f3b6b1134f..3fd64736bc45 100644
--- a/mm/list_lru.c
+++ b/mm/list_lru.c
@@ -243,6 +243,9 @@ __list_lru_walk_one(struct list_lru *lru, int nid, int memcg_idx,
 			 */
 			assert_spin_locked(&nlru->lock);
 			goto restart;
+		case LRU_STOP:
+			assert_spin_locked(&nlru->lock);
+			goto out;
 		default:
 			BUG();
 		}
diff --git a/mm/zswap.c b/mm/zswap.c
index d8bb0e06e2b0..4381b7a2d4d6 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1315,8 +1315,10 @@ static enum lru_status shrink_memcg_cb(struct list_head *item, struct list_lru_o
 		 * into the warmer region. We should terminate shrinking (if we're in the dynamic
 		 * shrinker context).
 		 */
-		if (writeback_result == -EEXIST && encountered_page_in_swapcache)
+		if (writeback_result == -EEXIST && encountered_page_in_swapcache) {
+			ret = LRU_STOP;
 			*encountered_page_in_swapcache = true;
+		}
 	} else {
 		zswap_written_back_pages++;
 	}

-- 
b4 0.10.1

