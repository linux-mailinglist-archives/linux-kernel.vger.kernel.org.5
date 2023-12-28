Return-Path: <linux-kernel+bounces-12543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EFC081F67E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 10:47:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D4121C21D0E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 09:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D96A98470;
	Thu, 28 Dec 2023 09:46:31 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B5979CF
	for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 09:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <zhouchengming@bytedance.com>
Date: Thu, 28 Dec 2023 09:45:44 +0000
Subject: [PATCH v5 3/5] mm/zswap: cleanup zswap_load()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231213-zswap-dstmem-v5-3-9382162bbf05@bytedance.com>
References: <20231213-zswap-dstmem-v5-0-9382162bbf05@bytedance.com>
In-Reply-To: <20231213-zswap-dstmem-v5-0-9382162bbf05@bytedance.com>
To: Barry Song <21cnbao@gmail.com>, Yosry Ahmed <yosryahmed@google.com>, Nhat Pham <nphamcs@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>, Dan Streetman <ddstreet@ieee.org>, Vitaly Wool <vitaly.wool@konsulko.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Chris Li <chriscli@google.com>, Seth Jennings <sjenning@redhat.com>
Cc: Yosry Ahmed <yosryahmed@google.com>, Nhat Pham <nphamcs@gmail.com>, Chris Li <chrisl@kernel.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Chengming Zhou <zhouchengming@bytedance.com>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1703756775; l=1602;
 i=zhouchengming@bytedance.com; s=20231204; h=from:subject:message-id;
 bh=rJOYhYvLkD8XDGMZAga2jLzLZQr3NVhVcf7hB//cwrw=;
 b=obzgcjVPz/TBWcJwAld57WtoQimnl/ZjBFTNyWHoE9HJCR+kwFjlb7IU5MGOgMtiFZtkwTCk3
 qPI+KW2XdgCDV21WlpxiCTcYbyZmw3o8+Ampqb53lIJjyKaDdsVv8Mc
X-Developer-Key: i=zhouchengming@bytedance.com; a=ed25519;
 pk=xFTmRtMG3vELGJBUiml7OYNdM393WOMv0iWWeQEVVdA=
X-Migadu-Flow: FLOW_OUT

After the common decompress part goes to __zswap_load(), we can cleanup
the zswap_load() a little.

Reviewed-by: Yosry Ahmed <yosryahmed@google.com>
Acked-by: Chis Li <chrisl@kernel.org> (Google)
Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 mm/zswap.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index b25d7d03851d..618989463535 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1760,7 +1760,6 @@ bool zswap_load(struct folio *folio)
 	struct zswap_tree *tree = zswap_trees[type];
 	struct zswap_entry *entry;
 	u8 *dst;
-	bool ret;
 
 	VM_WARN_ON_ONCE(!folio_test_locked(folio));
 
@@ -1773,23 +1772,20 @@ bool zswap_load(struct folio *folio)
 	}
 	spin_unlock(&tree->lock);
 
-	if (!entry->length) {
+	if (entry->length)
+		__zswap_load(entry, page);
+	else {
 		dst = kmap_local_page(page);
 		zswap_fill_page(dst, entry->value);
 		kunmap_local(dst);
-		ret = true;
-		goto stats;
 	}
 
-	__zswap_load(entry, page);
-	ret = true;
-stats:
 	count_vm_event(ZSWPIN);
 	if (entry->objcg)
 		count_objcg_event(entry->objcg, ZSWPIN);
 
 	spin_lock(&tree->lock);
-	if (ret && zswap_exclusive_loads_enabled) {
+	if (zswap_exclusive_loads_enabled) {
 		zswap_invalidate_entry(tree, entry);
 		folio_mark_dirty(folio);
 	} else if (entry->length) {
@@ -1799,7 +1795,7 @@ bool zswap_load(struct folio *folio)
 	zswap_entry_put(tree, entry);
 	spin_unlock(&tree->lock);
 
-	return ret;
+	return true;
 }
 
 void zswap_invalidate(int type, pgoff_t offset)

-- 
b4 0.10.1

