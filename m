Return-Path: <linux-kernel+bounces-3509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BF3E816D2E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 13:00:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0660A1C22FB2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 12:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69CF938F87;
	Mon, 18 Dec 2023 11:50:54 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C27381CD
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 11:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <zhouchengming@bytedance.com>
Date: Mon, 18 Dec 2023 11:50:35 +0000
Subject: [PATCH v3 5/6] mm/zswap: cleanup zswap_writeback_entry()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231213-zswap-dstmem-v3-5-4eac09b94ece@bytedance.com>
References: <20231213-zswap-dstmem-v3-0-4eac09b94ece@bytedance.com>
In-Reply-To: <20231213-zswap-dstmem-v3-0-4eac09b94ece@bytedance.com>
To: Seth Jennings <sjenning@redhat.com>, Yosry Ahmed <yosryahmed@google.com>, Vitaly Wool <vitaly.wool@konsulko.com>,
 Dan Streetman <ddstreet@ieee.org>, Johannes Weiner <hannes@cmpxchg.org>, Chris Li <chriscli@google.com>,
 Andrew Morton <akpm@linux-foundation.org>, Nhat Pham <nphamcs@gmail.com>
Cc: Chris Li <chrisl@kernel.org>, Yosry Ahmed <yosryahmed@google.com>, linux-kernel@vger.kernel.org,
 Chengming Zhou <zhouchengming@bytedance.com>, linux-mm@kvack.org, Nhat Pham <nphamcs@gmail.com>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1702900234; l=2215;
 i=zhouchengming@bytedance.com; s=20231204; h=from:subject:message-id;
 bh=u9D8B3ksO9G67avNjANTAO3qS+/SASwDD1QW2eXuPmA=;
 b=bX9QDtAp6LhqXJx8Yr0LWdcF0z06lztvYdnRzlwugcBS4LaRmP3c9JNAMHRIFxNxSVfv4KXJP
 2yn6oW6AM20DLSOlXaQvsN42SgrRlNXTLt3ZWYzqDYQTNtDhy74I4xe
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

