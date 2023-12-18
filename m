Return-Path: <linux-kernel+bounces-3150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D01D68167F7
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 09:23:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C566282F71
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 08:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0874C101FE;
	Mon, 18 Dec 2023 08:22:43 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4152713FFF
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 08:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <zhouchengming@bytedance.com>
Date: Mon, 18 Dec 2023 08:22:03 +0000
Subject: [PATCH v2 4/6] mm/zswap: cleanup zswap_load()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231213-zswap-dstmem-v2-4-daa5d9ae41a7@bytedance.com>
References: <20231213-zswap-dstmem-v2-0-daa5d9ae41a7@bytedance.com>
In-Reply-To: <20231213-zswap-dstmem-v2-0-daa5d9ae41a7@bytedance.com>
To: Seth Jennings <sjenning@redhat.com>, Dan Streetman <ddstreet@ieee.org>, Chris Li <chriscli@google.com>,
 Nhat Pham <nphamcs@gmail.com>, Vitaly Wool <vitaly.wool@konsulko.com>, Yosry Ahmed <yosryahmed@google.com>,
 Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>
Cc: linux-kernel@vger.kernel.org, Nhat Pham <nphamcs@gmail.com>, linux-mm@kvack.org, Yosry Ahmed <yosryahmed@google.com>,
 Chengming Zhou <zhouchengming@bytedance.com>, Chris Li <chrisl@kernel.org>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1702887745; l=1470;
 i=zhouchengming@bytedance.com; s=20231204; h=from:subject:message-id;
 bh=1eOM2WlTMMQMFmZcsE6sU450y2r77yOSYBMqqAB7HFE=;
 b=YOV157KveESD/iXPiDgVC9WaHMxuNJOt5qyf4ENQkrp7X4z9UFu4fkqe1LUaOnVs8aXOn3lks
 OXH9Dwct4c+At1moBhyAct1e80egxjcQg0Enm77kPeVULGpQ2btQ6ci
X-Developer-Key: i=zhouchengming@bytedance.com; a=ed25519;
 pk=xFTmRtMG3vELGJBUiml7OYNdM393WOMv0iWWeQEVVdA=
X-Migadu-Flow: FLOW_OUT

After the common decompress part goes to __zswap_load(), we can cleanup
the zswap_load() a little.

Reviewed-by: Yosry Ahmed <yosryahmed@google.com>
Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 mm/zswap.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index 3433bd6b3cef..86886276cb81 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1759,7 +1759,6 @@ bool zswap_load(struct folio *folio)
 	struct zswap_tree *tree = zswap_trees[type];
 	struct zswap_entry *entry;
 	u8 *dst;
-	bool ret;
 
 	VM_WARN_ON_ONCE(!folio_test_locked(folio));
 
@@ -1776,19 +1775,16 @@ bool zswap_load(struct folio *folio)
 		dst = kmap_local_page(page);
 		zswap_fill_page(dst, entry->value);
 		kunmap_local(dst);
-		ret = true;
-		goto stats;
+	} else {
+		__zswap_load(entry, page);
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
@@ -1798,7 +1794,7 @@ bool zswap_load(struct folio *folio)
 	zswap_entry_put(tree, entry);
 	spin_unlock(&tree->lock);
 
-	return ret;
+	return true;
 }
 
 void zswap_invalidate(int type, pgoff_t offset)

-- 
b4 0.10.1

