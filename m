Return-Path: <linux-kernel+bounces-51392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2A80848AC1
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 04:07:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69997280E88
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 03:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB03DBE68;
	Sun,  4 Feb 2024 03:06:25 +0000 (UTC)
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EDD5AD21
	for <linux-kernel@vger.kernel.org>; Sun,  4 Feb 2024 03:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707015985; cv=none; b=TBuaheC3eqWyOEFokOiX6H1utgabTweofEsHtXw5/RkaLAB2o7UKC56rSURm3BGa75v6QpiwH4ebnjnYxUVuAO3zlwVR0qzWxImDkIS6FpkBvPESatdmiKGFGAz2KQhlYQlNf+vkh9S/0zljfIJeCzfO0JfXZxJFZvNFBn8Z3n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707015985; c=relaxed/simple;
	bh=0bt3TQ9vcugz+A0eDPVN5E2V6cGVJQsAL8vDUMgG9ik=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uvFqnFwiNfNkwaT6/LP92qCQ4CIOz88ZokAwJ2erDyVJrpdnMdyPpEGWlMIsKzWs8+Cr79Zfsbn5bhDzsK67g9486sN2oF+Uq6+d00GlHpeizD2JAkAVZC8MzdXrLCqlfnFtPLn7jH9hFF2gLfpxr/uBGTCmdhD3O8eIC2eVf9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=linux.dev; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <zhouchengming@bytedance.com>
Date: Sun, 04 Feb 2024 03:06:01 +0000
Subject: [PATCH v2 3/6] mm/zswap: stop lru list shrinking when encounter warm region
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240201-b4-zswap-invalidate-entry-v2-3-99d4084260a0@bytedance.com>
References: <20240201-b4-zswap-invalidate-entry-v2-0-99d4084260a0@bytedance.com>
In-Reply-To: <20240201-b4-zswap-invalidate-entry-v2-0-99d4084260a0@bytedance.com>
To: Nhat Pham <nphamcs@gmail.com>, Yosry Ahmed <yosryahmed@google.com>, Andrew Morton <akpm@linux-foundation.org>,
 Johannes Weiner <hannes@cmpxchg.org>
Cc: linux-mm@kvack.org, Nhat Pham <nphamcs@gmail.com>, Chengming Zhou <zhouchengming@bytedance.com>,
 linux-kernel@vger.kernel.org, Yosry Ahmed <yosryahmed@google.com>, Johannes Weiner <hannes@cmpxchg.org>
X-Migadu-Flow: FLOW_OUT

When the shrinker encounter an existing folio in swap cache, it means
we are shrinking into the warmer region. We should terminate shrinking
if we're in the dynamic shrinker context.

This patch add LRU_STOP to support this, to avoid overshrinking.

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Acked-by: Nhat Pham <nphamcs@gmail.com>
Reviewed-by: Yosry Ahmed <yosryahmed@google.com>
Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 include/linux/list_lru.h | 2 ++
 mm/list_lru.c            | 3 +++
 mm/zswap.c               | 4 +++-
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/linux/list_lru.h b/include/linux/list_lru.h
index f2882a820690..792b67ceb631 100644
--- a/include/linux/list_lru.h
+++ b/include/linux/list_lru.h
@@ -24,6 +24,8 @@ enum lru_status {
 	LRU_SKIP,		/* item cannot be locked, skip */
 	LRU_RETRY,		/* item not freeable. May drop the lock
 				   internally, but has to return locked. */
+	LRU_STOP,		/* stop lru list walking. May drop the lock
+				   internally, but has to return locked. */
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

