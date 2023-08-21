Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94C2978305B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 20:37:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbjHUShv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 14:37:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbjHUShu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 14:37:50 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7D5157A99
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 11:37:45 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id 5614622812f47-3a850f07fadso1383539b6e.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 11:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20221208.gappssmtp.com; s=20221208; t=1692643063; x=1693247863;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3E/b9O2HlTOi/IQwrvX2RmX6ugx51n+ANVahrlt1y9E=;
        b=bs78ZLqFzdCBNP5WOZIQbmPxf0MB2IdxbI0+wTHjK3eA21DMWZU3ExKk5aSnGUtSGv
         VxXOxMtw21FDXY9J49x9bWd5kOiUDCL8lWn93rQTeUBXsM20t9bNh7PH/yUTZL5+Chzj
         r2jw52FRRe82audJSSNDAz3Dir5MIn2g0TgWAgipTEF9Pte+5X+Fm3UfzQo1qgUAV9i4
         Vquc0HF8tqg2Xl3K08/Bc4G/ic+rkduZ24lP/J7PZMU1qeh2WaPyWWJMLjcOglEig1p5
         mp+7h9SeFU5gRyklMRXybBl3jNbOKpbAw+pKb/mvWIH0jGBjP4LK4u0bxrbPXxhKO8aB
         h4KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692643063; x=1693247863;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3E/b9O2HlTOi/IQwrvX2RmX6ugx51n+ANVahrlt1y9E=;
        b=hWWB4uuuSGKJykENPjxQvidxc7m2mIyvdy3FBIqbIBHh0uBDef7RDucux6sf7mMQ66
         o5W+kNJvozkvUYFlSfqbRw6Vz6X9UOBvG2F9GZHygiQG9iZxGzWWQukFST7rCspS2um3
         /VrJNlj0CAgPVN1pl20QfijzORHAh48LH6k7ZXVs9PtiozeNH3xVMwsr5FVENSLN22xb
         T6ZWH2ST8hRBGK5vB4BmZEyPfKV0A2+oxJcaGtLJIZdI3OqCOE9jyTXnKRM4qGjkDgIq
         T5Va1LPsl/oqSrZJxi4tAXjwPDfyDiJeWzBZ1BndD9VeKS5nvb/U+Mo+cG6N16v0TD38
         +/dA==
X-Gm-Message-State: AOJu0Yyjeqped4/KnyqyLkmjPJmwNsGyBJdYXMzHx+BTGhJB0YCSFg4L
        ey5+Pjnk4lnHJSc6aFuGjRbthQ==
X-Google-Smtp-Source: AGHT+IGBSQnPB0tu7RVp53PncovhzE7SzTwHvY1Hwz+2KHc+6UHEFujdqz0TZEhwDQ+r7m42MeMWvg==
X-Received: by 2002:a05:6358:90e:b0:130:df70:b9cd with SMTP id r14-20020a056358090e00b00130df70b9cdmr5101720rwi.12.1692643063580;
        Mon, 21 Aug 2023 11:37:43 -0700 (PDT)
Received: from localhost (2603-7000-0c01-2716-699c-6fe1-d2a8-6a30.res6.spectrum.com. [2603:7000:c01:2716:699c:6fe1:d2a8:6a30])
        by smtp.gmail.com with ESMTPSA id m18-20020ae9e712000000b0076d4bb714afsm2634476qka.50.2023.08.21.11.37.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 11:37:43 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/8] mm: page_alloc: use get_pfnblock_migratetype where pfn available
Date:   Mon, 21 Aug 2023 14:33:33 -0400
Message-ID: <20230821183733.106619-2-hannes@cmpxchg.org>
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

Save a pfn_to_page() lookup when the pfn is right there already.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/page_alloc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 977bb4d5e8e1..e430ac45df7c 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -824,7 +824,7 @@ static inline void __free_one_page(struct page *page,
 			 * pageblock isolation could cause incorrect freepage or CMA
 			 * accounting or HIGHATOMIC accounting.
 			 */
-			int buddy_mt = get_pageblock_migratetype(buddy);
+			int buddy_mt = get_pfnblock_migratetype(buddy, buddy_pfn);
 
 			if (migratetype != buddy_mt
 					&& (!migratetype_is_mergeable(migratetype) ||
@@ -900,7 +900,7 @@ int split_free_page(struct page *free_page,
 		goto out;
 	}
 
-	mt = get_pageblock_migratetype(free_page);
+	mt = get_pfnblock_migratetype(free_page, free_page_pfn);
 	if (likely(!is_migrate_isolate(mt)))
 		__mod_zone_freepage_state(zone, -(1UL << order), mt);
 
-- 
2.41.0

