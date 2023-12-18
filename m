Return-Path: <linux-kernel+bounces-3152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 05CB58167FA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 09:23:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C40DB216D2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 08:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90C0810794;
	Mon, 18 Dec 2023 08:22:45 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01D8107BA
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 08:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <zhouchengming@bytedance.com>
Date: Mon, 18 Dec 2023 08:22:04 +0000
Subject: [PATCH v2 5/6] mm/zswap: cleanup zswap_writeback_entry()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231213-zswap-dstmem-v2-5-daa5d9ae41a7@bytedance.com>
References: <20231213-zswap-dstmem-v2-0-daa5d9ae41a7@bytedance.com>
In-Reply-To: <20231213-zswap-dstmem-v2-0-daa5d9ae41a7@bytedance.com>
To: Seth Jennings <sjenning@redhat.com>, Dan Streetman <ddstreet@ieee.org>, Chris Li <chriscli@google.com>,
 Nhat Pham <nphamcs@gmail.com>, Vitaly Wool <vitaly.wool@konsulko.com>, Yosry Ahmed <yosryahmed@google.com>,
 Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>
Cc: linux-kernel@vger.kernel.org, Nhat Pham <nphamcs@gmail.com>, linux-mm@kvack.org, Yosry Ahmed <yosryahmed@google.com>,
 Chengming Zhou <zhouchengming@bytedance.com>, Chris Li <chrisl@kernel.org>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1702887745; l=2215;
 i=zhouchengming@bytedance.com; s=20231204; h=from:subject:message-id;
 bh=u9D8B3ksO9G67avNjANTAO3qS+/SASwDD1QW2eXuPmA=;
 b=Y/k0K3dE80CEovxET6orobtOyqyRJJHYc5i0dttC7jiXtrRjSziXVF7ngHADT55LxnZB0hdN9
 VU8d58ziWvID/Hp36IATF7GQgb3Z0riqtM9YUjDT6aMJe1wiTZkqkT7
X-Developer-Key: i=zhouchengming@bytedance.com; a=ed25519;
 pk=xFTmRtMG3vELGJBUiml7OYNdM393WOMv0iWWeQEVVdA=
X-Migadu-Flow: FLOW_OUT

Also after the common decompress part goes to __zswap_load(), we can
cleanup the zswap_writeback_entry() a little.

Reviewed-by: Yosry Ahmed <yosryahmed@google.com>
Reviewed-by: Nhat Pham <nphamcs@gmail.com>
Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 mm/zswap.c | 25 +++++++++----------------
 1 file changed, 9 insertions(+), 16 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index 86886276cb81..2c349fd88904 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1443,7 +1443,6 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
 	struct page *page;
 	struct mempolicy *mpol;
 	bool page_was_allocated;
-	int ret;
 	struct writeback_control wbc = {
 		.sync_mode = WB_SYNC_NONE,
 	};
@@ -1453,15 +1452,18 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
 	page = __read_swap_cache_async(swpentry, GFP_KERNEL, mpol,
 				NO_INTERLEAVE_INDEX, &page_was_allocated, true);
 	if (!page) {
-		ret = -ENOMEM;
-		goto fail;
+		/*
+		 * If we get here because the page is already in swapcache, a
+		 * load may be happening concurrently. It is safe and okay to
+		 * not free the entry. It is also okay to return !0.
+		 */
+		return -ENOMEM;
 	}
 
 	/* Found an existing page, we raced with load/swapin */
 	if (!page_was_allocated) {
 		put_page(page);
-		ret = -EEXIST;
-		goto fail;
+		return -EEXIST;
 	}
 
 	/*
@@ -1475,8 +1477,7 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
 	if (zswap_rb_search(&tree->rbroot, swp_offset(entry->swpentry)) != entry) {
 		spin_unlock(&tree->lock);
 		delete_from_swap_cache(page_folio(page));
-		ret = -ENOMEM;
-		goto fail;
+		return -ENOMEM;
 	}
 	spin_unlock(&tree->lock);
 
@@ -1497,15 +1498,7 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
 	__swap_writepage(page, &wbc);
 	put_page(page);
 
-	return ret;
-
-fail:
-	/*
-	 * If we get here because the page is already in swapcache, a
-	 * load may be happening concurrently. It is safe and okay to
-	 * not free the entry. It is also okay to return !0.
-	 */
-	return ret;
+	return 0;
 }
 
 static int zswap_is_page_same_filled(void *ptr, unsigned long *value)

-- 
b4 0.10.1

