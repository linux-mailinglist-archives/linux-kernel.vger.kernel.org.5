Return-Path: <linux-kernel+bounces-11561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91A6A81E830
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 16:56:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 690A5B22192
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 15:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDC0653E22;
	Tue, 26 Dec 2023 15:55:05 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1108D53E12
	for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 15:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <zhouchengming@bytedance.com>
Date: Tue, 26 Dec 2023 15:54:12 +0000
Subject: [PATCH v4 5/6] mm/zswap: cleanup zswap_writeback_entry()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231213-zswap-dstmem-v4-5-f228b059dd89@bytedance.com>
References: <20231213-zswap-dstmem-v4-0-f228b059dd89@bytedance.com>
In-Reply-To: <20231213-zswap-dstmem-v4-0-f228b059dd89@bytedance.com>
To: Andrew Morton <akpm@linux-foundation.org>, Seth Jennings <sjenning@redhat.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Vitaly Wool <vitaly.wool@konsulko.com>, Nhat Pham <nphamcs@gmail.com>, Chris Li <chriscli@google.com>,
 Yosry Ahmed <yosryahmed@google.com>, Dan Streetman <ddstreet@ieee.org>
Cc: linux-kernel@vger.kernel.org, Chengming Zhou <zhouchengming@bytedance.com>, linux-mm@kvack.org,
 Nhat Pham <nphamcs@gmail.com>, Yosry Ahmed <yosryahmed@google.com>, Chris Li <chrisl@kernel.org>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1703606082; l=2338;
 i=zhouchengming@bytedance.com; s=20231204; h=from:subject:message-id;
 bh=tAV69Q+4us6Py1b2R2r8p5EYfYNSenhTMFhuOp7vNNQ=;
 b=afViGCtigOHtj8SqyE1/3tYO10W9zGnBEqlNj/WHy0NkwORwH+k6pwR/NJpbIHP3TQeqORo2h
 ERJwMflduKtC/okQR5pR1LwHwhvGLXlCdgX/gX53ZckJzqrZB76ELZ2
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
index 86886276cb81..40ee9f109f98 100644
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

