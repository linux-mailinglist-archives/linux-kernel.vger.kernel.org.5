Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBA0C7B6E7A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 18:31:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240418AbjJCQbM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 12:31:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240424AbjJCQbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 12:31:10 -0400
Received: from out-197.mta1.migadu.com (out-197.mta1.migadu.com [95.215.58.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDBD2A6
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 09:31:06 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1696350665;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=NJl+SD8R37eFOrXZ1l+okjOAETzKwOwWaRxJv78u12M=;
        b=TwocuYdYMlro3aGLYJPrdidoxA7phm/DW/sDlYiP/nmVycs2Zn8vw3sxQZcnc5S9rlZ7pb
        qiEr/g4pojwuKJrQwKidrjMA8Jtxsq6tNa6ATyxn/zG++L1I8qATkHMNa1l6b8+NLlseBn
        D9ENZHT3D/ReUFolazSxjXESWtXBP7c=
From:   Yajun Deng <yajun.deng@linux.dev>
To:     rppt@kernel.org, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Yajun Deng <yajun.deng@linux.dev>
Subject: [PATCH v3] memblock: don't run loop in memblock_add_range() twice
Date:   Wed,  4 Oct 2023 00:30:45 +0800
Message-Id: <20231003163045.191184-1-yajun.deng@linux.dev>
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

Check the count before memblock_insert_region. If the count is equal to
the maximum, it needs to resize the array. Otherwise, insert it directly.

Also, there is a nested call here, we need to reserve the current array
immediately if slab is unavailable.

Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
---
v3: reserve the current array immediately if slab is unavailable.
v2: remove the changes of memblock_double_array.
v1: https://lore.kernel.org/all/20230927013752.2515238-1-yajun.deng@linux.dev/
---
 mm/memblock.c | 93 +++++++++++++++++++++++----------------------------
 1 file changed, 41 insertions(+), 52 deletions(-)

diff --git a/mm/memblock.c b/mm/memblock.c
index 5a88d6d24d79..71449c0b8bc8 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -588,11 +588,12 @@ static int __init_memblock memblock_add_range(struct memblock_type *type,
 				phys_addr_t base, phys_addr_t size,
 				int nid, enum memblock_flags flags)
 {
-	bool insert = false;
 	phys_addr_t obase = base;
 	phys_addr_t end = base + memblock_cap_size(base, &size);
-	int idx, nr_new, start_rgn = -1, end_rgn;
+	int idx, start_rgn = -1, end_rgn;
 	struct memblock_region *rgn;
+	int use_slab = slab_is_available();
+	unsigned long ocnt = type->cnt;
 
 	if (!size)
 		return 0;
@@ -608,25 +609,6 @@ static int __init_memblock memblock_add_range(struct memblock_type *type,
 		return 0;
 	}
 
-	/*
-	 * The worst case is when new range overlaps all existing regions,
-	 * then we'll need type->cnt + 1 empty regions in @type. So if
-	 * type->cnt * 2 + 1 is less than or equal to type->max, we know
-	 * that there is enough empty regions in @type, and we can insert
-	 * regions directly.
-	 */
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
-
 	for_each_memblock_type(idx, type, rgn) {
 		phys_addr_t rbase = rgn->base;
 		phys_addr_t rend = rbase + rgn->size;
@@ -644,15 +626,30 @@ static int __init_memblock memblock_add_range(struct memblock_type *type,
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
+
+			/*
+			 * If type->cnt is equal to type->max, it means there's
+			 * not enough empty region and the array needs to be
+			 * resized. Otherwise, insert it directly.
+			 *
+			 * If slab is unavailable, it means a new array was reserved
+			 * in memblock_double_array. There is a nested call here, We
+			 * need to reserve the current array now if its type is
+			 * reserved.
+			 */
+			if (type->cnt == type->max) {
+				if (memblock_double_array(type, obase, size))
+					return -ENOMEM;
+				else if (!use_slab && type == &memblock.reserved)
+					return memblock_reserve(obase, size);
 			}
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
@@ -660,33 +657,25 @@ static int __init_memblock memblock_add_range(struct memblock_type *type,
 
 	/* insert the remaining portion */
 	if (base < end) {
-		nr_new++;
-		if (insert) {
-			if (start_rgn == -1)
-				start_rgn = idx;
-			end_rgn = idx + 1;
-			memblock_insert_region(type, idx, base, end - base,
-					       nid, flags);
+
+		if (type->cnt == type->max) {
+			if (memblock_double_array(type, obase, size))
+				return -ENOMEM;
+			else if (!use_slab && type == &memblock.reserved)
+				return memblock_reserve(obase, size);
 		}
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

