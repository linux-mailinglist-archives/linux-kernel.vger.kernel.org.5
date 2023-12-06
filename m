Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9612C806B04
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 10:47:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377358AbjLFJqy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 04:46:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377321AbjLFJqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 04:46:43 -0500
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2EDDD67
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 01:46:47 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Chengming Zhou <zhouchengming@bytedance.com>
Date:   Wed, 06 Dec 2023 09:46:30 +0000
Subject: [PATCH 7/7] mm/zswap: cleanup zswap_reclaim_entry()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231206-zswap-lock-optimize-v1-7-e25b059f9c3a@bytedance.com>
References: <20231206-zswap-lock-optimize-v1-0-e25b059f9c3a@bytedance.com>
In-Reply-To: <20231206-zswap-lock-optimize-v1-0-e25b059f9c3a@bytedance.com>
To:     Vitaly Wool <vitaly.wool@konsulko.com>,
        Nhat Pham <nphamcs@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yosry Ahmed <yosryahmed@google.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701855988; l=1963;
 i=zhouchengming@bytedance.com; s=20231204; h=from:subject:message-id;
 bh=WQp3TO7eGK4NEJ2KSQiW8NgcHiI75uDxqzzNLxV8SyA=;
 b=cX50JTACBKj/y4OSJ3fqN9XlNGNG8ePq/CbHqPflo46e6ZMG5upWYYRApku021YWMN1SgS3i9
 B/xOj7S/bMGBm4R4og7jAUlPoBl15i7PcZIVp5JnUC1yxy4hhNQBj7H
X-Developer-Key: i=zhouchengming@bytedance.com; a=ed25519;
 pk=xFTmRtMG3vELGJBUiml7OYNdM393WOMv0iWWeQEVVdA=
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Also after the common decompress part goes to __zswap_load(), we can
cleanup the zswap_reclaim_entry() a little.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 mm/zswap.c | 23 +++++------------------
 1 file changed, 5 insertions(+), 18 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index 50405811cd7b..d3fedda0d774 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1438,7 +1438,6 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
 	struct page *page;
 	struct mempolicy *mpol;
 	bool page_was_allocated;
-	int ret;
 	struct writeback_control wbc = {
 		.sync_mode = WB_SYNC_NONE,
 	};
@@ -1447,16 +1446,13 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
 	mpol = get_task_policy(current);
 	page = __read_swap_cache_async(swpentry, GFP_KERNEL, mpol,
 				NO_INTERLEAVE_INDEX, &page_was_allocated, true);
-	if (!page) {
-		ret = -ENOMEM;
-		goto fail;
-	}
+	if (!page)
+		return -ENOMEM;
 
 	/* Found an existing page, we raced with load/swapin */
 	if (!page_was_allocated) {
 		put_page(page);
-		ret = -EEXIST;
-		goto fail;
+		return -EEXIST;
 	}
 
 	/*
@@ -1470,8 +1466,7 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
 	if (zswap_rb_search(&tree->rbroot, swp_offset(entry->swpentry)) != entry) {
 		spin_unlock(&tree->lock);
 		delete_from_swap_cache(page_folio(page));
-		ret = -ENOMEM;
-		goto fail;
+		return -ENOMEM;
 	}
 	spin_unlock(&tree->lock);
 
@@ -1492,15 +1487,7 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
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
