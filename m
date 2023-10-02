Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A91AD7B50BF
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 12:57:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236571AbjJBK5V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 06:57:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236192AbjJBK5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 06:57:17 -0400
Received: from out-190.mta1.migadu.com (out-190.mta1.migadu.com [IPv6:2001:41d0:203:375::be])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9CDFB3
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 03:57:14 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1696244232;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=aQO3XkBHu5rCLD4ypD1Z6J4F2frqkYY0S4aXHFwX8tQ=;
        b=cD0MgmhCw1APCHXI0U9MBlpClZ+i2x8Hr54sVTocyWd+KcZNOKeijukaBQD7nRrYt0Pfgi
        zAutlO6DcswAcmq+elAvPFY/YwlGgbOu9yI4m7vI4TyKveLfFlE9g0N28iarbEQG3keg+R
        ofWm4eWWchDain5ptATvfaKOijIdnw0=
From:   Yajun Deng <yajun.deng@linux.dev>
To:     rppt@kernel.org, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Yajun Deng <yajun.deng@linux.dev>
Subject: [PATCH v2] memblock: don't run loop in memblock_add_range() twice
Date:   Mon,  2 Oct 2023 18:56:52 +0800
Message-Id: <20231002105652.2514182-1-yajun.deng@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is round twice in memblock_add_range(). The first counts the number
of regions needed to accommodate the new area. The second actually inserts
them. But the first round isn't really needed, we just need to check the
counts before inserting them.

Check the count before iterate memblock. If the count is equal to the
maximum, it needs to resize the array. Otherwise, insert it directly.
After that, it's similar logic to memblock_isolate_range.

Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
---
v2: remove the changes of memblock_double_array.
v1: https://lore.kernel.org/all/20230927013752.2515238-1-yajun.deng@linux.dev/
---
 mm/memblock.c | 75 +++++++++++++++++----------------------------------
 1 file changed, 24 insertions(+), 51 deletions(-)

diff --git a/mm/memblock.c b/mm/memblock.c
index 5a88d6d24d79..655d8e82f90a 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -588,11 +588,11 @@ static int __init_memblock memblock_add_range(struct memblock_type *type,
 				phys_addr_t base, phys_addr_t size,
 				int nid, enum memblock_flags flags)
 {
-	bool insert = false;
 	phys_addr_t obase = base;
 	phys_addr_t end = base + memblock_cap_size(base, &size);
-	int idx, nr_new, start_rgn = -1, end_rgn;
+	int idx, start_rgn = -1, end_rgn;
 	struct memblock_region *rgn;
+	unsigned long ocnt = type->cnt;
 
 	if (!size)
 		return 0;
@@ -609,23 +609,13 @@ static int __init_memblock memblock_add_range(struct memblock_type *type,
 	}
 
 	/*
-	 * The worst case is when new range overlaps all existing regions,
-	 * then we'll need type->cnt + 1 empty regions in @type. So if
-	 * type->cnt * 2 + 1 is less than or equal to type->max, we know
-	 * that there is enough empty regions in @type, and we can insert
-	 * regions directly.
+	 * If type->cnt is equal to type->max, it means there's
+	 * not enough empty region and the array needs to be
+	 * resized. Otherwise, insert it directly.
 	 */
-	if (type->cnt * 2 + 1 <= type->max)
-		insert = true;
-
-repeat:
-	/*
-	 * The following is executed twice.  Once with %false @insert and
-	 * then with %true.  The first counts the number of regions needed
-	 * to accommodate the new area.  The second actually inserts them.
-	 */
-	base = obase;
-	nr_new = 0;
+	if ((type->cnt == type->max) &&
+	    memblock_double_array(type, obase, size))
+		return -ENOMEM;
 
 	for_each_memblock_type(idx, type, rgn) {
 		phys_addr_t rbase = rgn->base;
@@ -644,15 +634,13 @@ static int __init_memblock memblock_add_range(struct memblock_type *type,
 			WARN_ON(nid != memblock_get_region_node(rgn));
 #endif
 			WARN_ON(flags != rgn->flags);
-			nr_new++;
-			if (insert) {
-				if (start_rgn == -1)
-					start_rgn = idx;
-				end_rgn = idx + 1;
-				memblock_insert_region(type, idx++, base,
-						       rbase - base, nid,
-						       flags);
-			}
+
+			if (start_rgn == -1)
+				start_rgn = idx;
+			end_rgn = idx + 1;
+			memblock_insert_region(type, idx++, base,
+					       rbase - base, nid,
+					       flags);
 		}
 		/* area below @rend is dealt with, forget about it */
 		base = min(rend, end);
@@ -660,33 +648,18 @@ static int __init_memblock memblock_add_range(struct memblock_type *type,
 
 	/* insert the remaining portion */
 	if (base < end) {
-		nr_new++;
-		if (insert) {
-			if (start_rgn == -1)
-				start_rgn = idx;
-			end_rgn = idx + 1;
-			memblock_insert_region(type, idx, base, end - base,
-					       nid, flags);
-		}
-	}
 
-	if (!nr_new)
-		return 0;
+		if (start_rgn == -1)
+			start_rgn = idx;
+		end_rgn = idx + 1;
+		memblock_insert_region(type, idx, base, end - base,
+				       nid, flags);
+	}
 
-	/*
-	 * If this was the first round, resize array and repeat for actual
-	 * insertions; otherwise, merge and return.
-	 */
-	if (!insert) {
-		while (type->cnt + nr_new > type->max)
-			if (memblock_double_array(type, obase, size) < 0)
-				return -ENOMEM;
-		insert = true;
-		goto repeat;
-	} else {
+	if (ocnt != type->cnt)
 		memblock_merge_regions(type, start_rgn, end_rgn);
-		return 0;
-	}
+
+	return 0;
 }
 
 /**
-- 
2.25.1

