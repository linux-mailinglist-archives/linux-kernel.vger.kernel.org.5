Return-Path: <linux-kernel+bounces-48446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B2A0845C24
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 16:51:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAB001F224AB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 15:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8952915DBCB;
	Thu,  1 Feb 2024 15:50:40 +0000 (UTC)
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 750E6626D8
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 15:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706802640; cv=none; b=Y/nCQywAy8+lefUzdI0Amcme0NbBGjjhdnLHAUL/2rIEOtDPsP1tCi/NB4iJGPy044cTnz19AASZtMKVoG1oeIj4W8LtVeXRBS0/yfC/2K5iQKS0xyPOyAb7ahw1xxH6Ymc5b37snh0BcyuXru7cQ8ryDluzoyv15GBq+QZtkx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706802640; c=relaxed/simple;
	bh=YEQqmKRZn+jNACzlJ8YHrQPD/KRCd1PqIQuyBXBbsaM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kBRE7Q+MwF5uA+VejjxFYwLopmtrpJmpxDFaTWOFK8A7Zu4nRKMD5hNVrtjjeygJuvRR7IMButtlS/XDPTgyZzOBE+enyDrWPZ80/OHlLQRANwcPxv4vvy0VAQWu09i79ecgWRiLfgLehP1PGgAeA9j0KHY00rip0qhjFg+J5kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=linux.dev; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <zhouchengming@bytedance.com>
Date: Thu, 01 Feb 2024 15:49:05 +0000
Subject: [PATCH 5/6] mm/zswap: only support zswap_exclusive_loads_enabled
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240201-b4-zswap-invalidate-entry-v1-5-56ed496b6e55@bytedance.com>
References: <20240201-b4-zswap-invalidate-entry-v1-0-56ed496b6e55@bytedance.com>
In-Reply-To: <20240201-b4-zswap-invalidate-entry-v1-0-56ed496b6e55@bytedance.com>
To: Nhat Pham <nphamcs@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>, Andrew Morton <akpm@linux-foundation.org>,
 Yosry Ahmed <yosryahmed@google.com>
Cc: linux-kernel@vger.kernel.org, Yosry Ahmed <yosryahmed@google.com>, Chengming Zhou <zhouchengming@bytedance.com>,
 Johannes Weiner <hannes@cmpxchg.org>, linux-mm@kvack.org
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

Not sure if we should accept the above disadvantages in the case of
!zswap_exclusive_loads_enabled, so send this out for disscusion.

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

