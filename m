Return-Path: <linux-kernel+bounces-12544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 306F581F67F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 10:47:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D97E21F23279
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 09:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A58363D6;
	Thu, 28 Dec 2023 09:46:35 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161188820
	for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 09:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <zhouchengming@bytedance.com>
Date: Thu, 28 Dec 2023 09:45:45 +0000
Subject: [PATCH v5 4/5] mm/zswap: cleanup zswap_writeback_entry()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231213-zswap-dstmem-v5-4-9382162bbf05@bytedance.com>
References: <20231213-zswap-dstmem-v5-0-9382162bbf05@bytedance.com>
In-Reply-To: <20231213-zswap-dstmem-v5-0-9382162bbf05@bytedance.com>
To: Barry Song <21cnbao@gmail.com>, Yosry Ahmed <yosryahmed@google.com>, Nhat Pham <nphamcs@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>, Dan Streetman <ddstreet@ieee.org>, Vitaly Wool <vitaly.wool@konsulko.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Chris Li <chriscli@google.com>, Seth Jennings <sjenning@redhat.com>
Cc: Yosry Ahmed <yosryahmed@google.com>, Nhat Pham <nphamcs@gmail.com>, Chris Li <chrisl@kernel.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Chengming Zhou <zhouchengming@bytedance.com>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1703756775; l=2338;
 i=zhouchengming@bytedance.com; s=20231204; h=from:subject:message-id;
 bh=5hrzED6ruCvN+7YOlRuh0wDVEni4Jtsv4F8FioAoDqA=;
 b=QqMwHN+kvR++JhOibm6XsrYrAW9xa7b2cN1gUvUDvJ80DjHT4cwxyemA4TSJvXgr7FctXn0HV
 LoHrcUfJc1BBavTLmSy4+K67MYc0NCDltyXkviDKPDg+/7snuwJFxJP
X-Developer-Key: i=zhouchengming@bytedance.com; a=ed25519;
 pk=xFTmRtMG3vELGJBUiml7OYNdM393WOMv0iWWeQEVVdA=
X-Migadu-Flow: FLOW_OUT

Also after the common decompress part goes to __zswap_load(), we can
cleanup the zswap_writeback_entry() a little.

Reviewed-by: Yosry Ahmed <yosryahmed@google.com>
Reviewed-by: Nhat Pham <nphamcs@gmail.com>
Acked-by: Chris Li <chrisl@kernel.org> (Google)
Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 mm/zswap.c | 29 ++++++++++-------------------
 1 file changed, 10 insertions(+), 19 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index 618989463535..e756b2af838b 100644
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
@@ -1452,16 +1451,17 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
 	mpol = get_task_policy(current);
 	page = __read_swap_cache_async(swpentry, GFP_KERNEL, mpol,
 				NO_INTERLEAVE_INDEX, &page_was_allocated, true);
-	if (!page) {
-		ret = -ENOMEM;
-		goto fail;
-	}
+	if (!page)
+		return -ENOMEM;
 
-	/* Found an existing page, we raced with load/swapin */
+	/*
+	 * Found an existing page, we raced with load/swapin. We generally
+	 * writeback cold pages from zswap, and swapin means the page just
+	 * became hot. Skip this page and let the caller find another one.
+	 */
 	if (!page_was_allocated) {
 		put_page(page);
-		ret = -EEXIST;
-		goto fail;
+		return -EEXIST;
 	}
 
 	/*
@@ -1475,8 +1475,7 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
 	if (zswap_rb_search(&tree->rbroot, swp_offset(entry->swpentry)) != entry) {
 		spin_unlock(&tree->lock);
 		delete_from_swap_cache(page_folio(page));
-		ret = -ENOMEM;
-		goto fail;
+		return -ENOMEM;
 	}
 	spin_unlock(&tree->lock);
 
@@ -1497,15 +1496,7 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
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

