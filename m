Return-Path: <linux-kernel+bounces-51394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E30C9848AC3
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 04:07:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 945D31F23544
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 03:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 754D610A2A;
	Sun,  4 Feb 2024 03:06:29 +0000 (UTC)
Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EEADD26B
	for <linux-kernel@vger.kernel.org>; Sun,  4 Feb 2024 03:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707015989; cv=none; b=aj/qcWhs1YmsLgaa5w0b39ubmMs3uuVURNkSYE5THgSRrOcLKUpIFO0KaPQPJTGEMqdnGCFhXkuhLt3mabMfhyJM1aS3VrHSalPRZtV9o4+m5iuFr/aQVsU9s5bFf7JC3mwa8ASnBUoOil1ZnpMQuDMS+l8JS4x4BTbOhnW24LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707015989; c=relaxed/simple;
	bh=5FnRXUvDpUMWv/ll26B1goohLOKe8SR6AvNT36pdX1U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kYxtKU+j3hgQo7zXrHfNDI10Gf3shiaJ+7CWqD7uTZ1cp+NNAlNQVbsEWimhWZZo8Cp0hZUxJ69yS3cMBz5JKdrZknoxXp8B8ZpeQCul0HB5qHV5/vwXWt/Kv2G5s09ni9a9566ZQvQdtWegq5j3bXOkNjL3nr7WFVCvpnCRgtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=linux.dev; arc=none smtp.client-ip=95.215.58.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <zhouchengming@bytedance.com>
Date: Sun, 04 Feb 2024 03:06:03 +0000
Subject: [PATCH v2 5/6] mm/zswap: only support zswap_exclusive_loads_enabled
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240201-b4-zswap-invalidate-entry-v2-5-99d4084260a0@bytedance.com>
References: <20240201-b4-zswap-invalidate-entry-v2-0-99d4084260a0@bytedance.com>
In-Reply-To: <20240201-b4-zswap-invalidate-entry-v2-0-99d4084260a0@bytedance.com>
To: Nhat Pham <nphamcs@gmail.com>, Yosry Ahmed <yosryahmed@google.com>, Andrew Morton <akpm@linux-foundation.org>,
 Johannes Weiner <hannes@cmpxchg.org>
Cc: linux-mm@kvack.org, Nhat Pham <nphamcs@gmail.com>, Chengming Zhou <zhouchengming@bytedance.com>,
 linux-kernel@vger.kernel.org, Yosry Ahmed <yosryahmed@google.com>, Johannes Weiner <hannes@cmpxchg.org>
X-Migadu-Flow: FLOW_OUT

The !zswap_exclusive_loads_enabled mode will leave compressed copy in
the zswap tree and lru list after the folio swapin.

There are some disadvantages in this mode:
1. It's a waste of memory since there are two copies of data, one is
   folio, the other one is compressed data in zswap. And it's unlikely
   the compressed data is useful in the near future.

2. If that folio is dirtied, the compressed data must be not useful,
   but we don't know and don't invalidate the trashy memory in zswap.

3. It's not reclaimable from zswap shrinker since zswap_writeback_entry()
   will always return -EEXIST and terminate the shrinking process.

On the other hand, the only downside of zswap_exclusive_loads_enabled
is a little more cpu usage/latency when compression, and the same if
the folio is removed from swapcache or dirtied.

More explanation by Johannes on why we should consider exclusive load
as the default for zswap:

  Caching "swapout work" is helpful when the system is thrashing. Then
  recently swapped in pages might get swapped out again very soon. It
  certainly makes sense with conventional swap, because keeping a clean
  copy on the disk saves IO work and doesn't cost any additional memory.

  But with zswap, it's different. It saves some compression work on a
  thrashing page. But the act of keeping compressed memory contributes
  to a higher rate of thrashing. And that can cause IO in other places
  like zswap writeback and file memory.

And the A/B test results of the kernel build in tmpfs with limited memory
can support this theory:

			!exclusive	exclusive
real                       63.80         63.01
user                       1063.83       1061.32
sys                        290.31        266.15

workingset_refault_anon    2383084.40    1976397.40
workingset_refault_file    44134.00      45689.40
workingset_activate_anon   837878.00     728441.20
workingset_activate_file   4710.00       4085.20
workingset_restore_anon    732622.60     639428.40
workingset_restore_file    1007.00       926.80
workingset_nodereclaim     0.00          0.00
pgscan                     14343003.40   12409570.20
pgscan_kswapd              0.00          0.00
pgscan_direct              14343003.40   12409570.20
pgscan_khugepaged          0.00          0.00

Acked-by: Yosry Ahmed <yosryahmed@google.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Reviewed-by: Nhat Pham <nphamcs@gmail.com>
Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 mm/Kconfig | 16 ----------------
 mm/zswap.c | 14 +++-----------
 2 files changed, 3 insertions(+), 27 deletions(-)

diff --git a/mm/Kconfig b/mm/Kconfig
index ffc3a2ba3a8c..673b35629074 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -45,22 +45,6 @@ config ZSWAP_DEFAULT_ON
 	  The selection made here can be overridden by using the kernel
 	  command line 'zswap.enabled=' option.
 
-config ZSWAP_EXCLUSIVE_LOADS_DEFAULT_ON
-	bool "Invalidate zswap entries when pages are loaded"
-	depends on ZSWAP
-	help
-	  If selected, exclusive loads for zswap will be enabled at boot,
-	  otherwise it will be disabled.
-
-	  If exclusive loads are enabled, when a page is loaded from zswap,
-	  the zswap entry is invalidated at once, as opposed to leaving it
-	  in zswap until the swap entry is freed.
-
-	  This avoids having two copies of the same page in memory
-	  (compressed and uncompressed) after faulting in a page from zswap.
-	  The cost is that if the page was never dirtied and needs to be
-	  swapped out again, it will be re-compressed.
-
 config ZSWAP_SHRINKER_DEFAULT_ON
 	bool "Shrink the zswap pool on memory pressure"
 	depends on ZSWAP
diff --git a/mm/zswap.c b/mm/zswap.c
index 3fbb7e2c8b8d..cbf379abb6c7 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -139,10 +139,6 @@ static bool zswap_non_same_filled_pages_enabled = true;
 module_param_named(non_same_filled_pages_enabled, zswap_non_same_filled_pages_enabled,
 		   bool, 0644);
 
-static bool zswap_exclusive_loads_enabled = IS_ENABLED(
-		CONFIG_ZSWAP_EXCLUSIVE_LOADS_DEFAULT_ON);
-module_param_named(exclusive_loads, zswap_exclusive_loads_enabled, bool, 0644);
-
 /* Number of zpools in zswap_pool (empirically determined for scalability) */
 #define ZSWAP_NR_ZPOOLS 32
 
@@ -1722,16 +1718,12 @@ bool zswap_load(struct folio *folio)
 		count_objcg_event(entry->objcg, ZSWPIN);
 
 	spin_lock(&tree->lock);
-	if (zswap_exclusive_loads_enabled) {
-		zswap_invalidate_entry(tree, entry);
-		folio_mark_dirty(folio);
-	} else if (entry->length) {
-		zswap_lru_del(&entry->pool->list_lru, entry);
-		zswap_lru_add(&entry->pool->list_lru, entry);
-	}
+	zswap_invalidate_entry(tree, entry);
 	zswap_entry_put(entry);
 	spin_unlock(&tree->lock);
 
+	folio_mark_dirty(folio);
+
 	return true;
 }
 

-- 
b4 0.10.1

