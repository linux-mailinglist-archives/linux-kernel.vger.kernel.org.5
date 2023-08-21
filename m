Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A56878305F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 20:38:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbjHUSiE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 14:38:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbjHUSh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 14:37:56 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEB845100
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 11:37:50 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id 6a1803df08f44-64c1d487e72so19158606d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 11:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20221208.gappssmtp.com; s=20221208; t=1692643067; x=1693247867;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lLUpAEhwdHses5nFOU0azVoQ7mhHkrTPDw+MACyT3Uo=;
        b=uu324QBc+rtb2rb6ojdEsAGPTmfCn1pVoKqBeTm/7P0dPa53c/018QiTZAxvjfk4tR
         gd3isXbWBnvmXwKnm/HQBQdv4CAkaT2elzDp9mjtKLdLitCtyeNEdOyJDD8OSdoNt9gt
         mDcPb4pJbQH+QjEmQqQQM2JBTmXebCbCMtWni1qZHwHNDASVRcK5jqvoscTv3vRHHDcn
         EEIaW0f4LPbjd1nU7A5uR+22sHHRvxqew4mEd3GgeorJsCcDp+bzTfVNcKiiZjTxI3MX
         GCyYm3Z2VbUNvA1yCSYnin8EXYwtYy2a0maw6rJNQldN7CHPfZ3e+BwVlaLApl+QVHTl
         V/3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692643067; x=1693247867;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lLUpAEhwdHses5nFOU0azVoQ7mhHkrTPDw+MACyT3Uo=;
        b=X6521Q9yfSzaVAqnBtGfEzIve8HSnGnv0jG50H+qs/GINMgIw9qat/JZOxbzqtqGl0
         8Ort+BX3oU53rTFV0hjfx4nX1VhwDqVAZSJR3jMMelqfgf1l4gs+TUblq2FSXnqPRcQ0
         CznxGHHwjL8SfxIrWByAGnbYkXa/rmqEjXMr1emkyZTU6q50YN/5xLpudDeHCIQUN4O7
         s6fEsaXJqliFoc96i2bSyH6eodzUJrYuqFlLjhaD+eXo+Rer7b6OgqSfULTqI6CKREEX
         c49xsYgPuDk4iO0EltAnaIXgknYB4BP+LXK0lMGpJSeC1z3Dj5sEcD0FJE2cA2+D8HHA
         pKEw==
X-Gm-Message-State: AOJu0Yy8EsxnOGKaVSOzVOsojaP2iaLQ843PwvA2WSCEOY/1FUNoUMWb
        Y6HRZuJyvRYc6EfkqPqZjd5GUA==
X-Google-Smtp-Source: AGHT+IEJOOhim3Cp793d/K2ahJpfEq1PXlo2PZVHOqjBu5gwxhsUCzov2/4CrV0FJmCuIF2w2QYyuA==
X-Received: by 2002:a05:6214:192c:b0:647:39f1:5237 with SMTP id es12-20020a056214192c00b0064739f15237mr7472065qvb.47.1692643067350;
        Mon, 21 Aug 2023 11:37:47 -0700 (PDT)
Received: from localhost (2603-7000-0c01-2716-699c-6fe1-d2a8-6a30.res6.spectrum.com. [2603:7000:c01:2716:699c:6fe1:d2a8:6a30])
        by smtp.gmail.com with ESMTPSA id d1-20020a0cf0c1000000b0064f46c719fasm547661qvl.31.2023.08.21.11.37.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 11:37:47 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/8] mm: page_alloc: fix up block types when merging compatible blocks
Date:   Mon, 21 Aug 2023 14:33:36 -0400
Message-ID: <20230821183733.106619-5-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230821183733.106619-1-hannes@cmpxchg.org>
References: <20230821183733.106619-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The buddy allocator coalesces compatible blocks during freeing, but it
doesn't update the types of the subblocks to match. When an allocation
later breaks the chunk down again, its pieces will be put on freelists
of the wrong type. This encourages incompatible page mixing (ask for
one type, get another), and thus long-term fragmentation.

Update the subblocks when merging a larger chunk, such that a later
expand() will maintain freelist type hygiene.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/page_alloc.c | 37 ++++++++++++++++++++++---------------
 1 file changed, 22 insertions(+), 15 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index a5e36d186893..6c9f565b2613 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -438,6 +438,17 @@ void set_pageblock_migratetype(struct page *page, int migratetype)
 				page_to_pfn(page), MIGRATETYPE_MASK);
 }
 
+static void change_pageblock_range(struct page *pageblock_page,
+					int start_order, int migratetype)
+{
+	int nr_pageblocks = 1 << (start_order - pageblock_order);
+
+	while (nr_pageblocks--) {
+		set_pageblock_migratetype(pageblock_page, migratetype);
+		pageblock_page += pageblock_nr_pages;
+	}
+}
+
 #ifdef CONFIG_DEBUG_VM
 static int page_outside_zone_boundaries(struct zone *zone, struct page *page)
 {
@@ -808,10 +819,17 @@ static inline void __free_one_page(struct page *page,
 			 */
 			int buddy_mt = get_pfnblock_migratetype(buddy, buddy_pfn);
 
-			if (migratetype != buddy_mt
-					&& (!migratetype_is_mergeable(migratetype) ||
-						!migratetype_is_mergeable(buddy_mt)))
-				goto done_merging;
+			if (migratetype != buddy_mt) {
+				if (!migratetype_is_mergeable(migratetype) ||
+				    !migratetype_is_mergeable(buddy_mt))
+					goto done_merging;
+				/*
+				 * Match buddy type. This ensures that
+				 * an expand() down the line puts the
+				 * sub-blocks on the right freelists.
+				 */
+				set_pageblock_migratetype(buddy, migratetype);
+			}
 		}
 
 		/*
@@ -1687,17 +1705,6 @@ int move_freepages_block(struct zone *zone, struct page *page,
 								num_movable);
 }
 
-static void change_pageblock_range(struct page *pageblock_page,
-					int start_order, int migratetype)
-{
-	int nr_pageblocks = 1 << (start_order - pageblock_order);
-
-	while (nr_pageblocks--) {
-		set_pageblock_migratetype(pageblock_page, migratetype);
-		pageblock_page += pageblock_nr_pages;
-	}
-}
-
 /*
  * When we are falling back to another migratetype during allocation, try to
  * steal extra free pages from the same pageblocks to satisfy further
-- 
2.41.0

