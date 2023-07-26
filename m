Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 281BC763A59
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 17:08:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234667AbjGZPIl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 11:08:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233512AbjGZPIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 11:08:40 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 499B62119
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 08:08:13 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id af79cd13be357-767b6d6bb87so469337185a.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 08:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20221208.gappssmtp.com; s=20221208; t=1690384027; x=1690988827;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MpZCUc2DN64k7aeMSMLZUCCAbrXdS1MBsuJSZ1mAze4=;
        b=Oor1EuXr2oNsSjTJos+24ANvHw0H7E8wBKKFTXEe/8B87EVmWYgR0mM5AoXugx37Sp
         zpyyDyg/sexZwYtiqLmXtys2aFDmq/feJc43XUdlO+UgN5TUfMqkAzA2wqVk4/jxFEYg
         tpKmGp7hkje+DEiBRW1cr53CZkGUo0c5MOvhgvRGdDZYwpNUVlMFIQuOLlP5KnKGtK07
         uS0gP4JQNAS8CzzQuuqBmsrOnH2KG9nfMYxpI1ai8Un4pggpXtOd53GAWipu/0QzEwNu
         DHDudVCBJgPbN2EqUrm9WSnSTwdAoFFlu5yU0QGjDJi6XumFB9xATAQhTclZ+m/VcaSl
         3PgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690384027; x=1690988827;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MpZCUc2DN64k7aeMSMLZUCCAbrXdS1MBsuJSZ1mAze4=;
        b=kiL8ea/vQD+WJ2PWcPDUUMCn9f/Ds0OvZnOEk6AsR1FAoEBkgIA3IfT+hrJpXsl4Ms
         ikJPr9EBB0iUoODVCI+F4eIY7qseZpuLaL40mFHRwyye8QD5XI8FnlGNC30FhvmpX+Wy
         69D1tNwPBQsmbJlmwndgaR9AcrjXSl1/I2carz5pP8m2sryEpscX6KzaXwW/oIyeVycZ
         /NqBurLyxwNqj5LKtiyQz1hxIM2nU0HrpJCZejVkSQGTz9fRDLYBNAaiQVFp+kTjxvg5
         nwGlWDcFSo+QQuYaarup7jb4SW8TXCvs0MNRLxo/bSR1V5IR48Jm/8eIWyAjVQlEt7s2
         nhDw==
X-Gm-Message-State: ABy/qLZvDj4lg4WdMPWDs5u3heU8mcTiP+77Hi466+fyQ+xLWQkiFWhe
        u8Us3F84qa3SF+36jYD2dYvKBmSGBfHsq7KbcmWjeA==
X-Google-Smtp-Source: APBJJlGJ1NxtNwRorz6e+qI8GGmhB8XLaT8DTlk7nOqyJQ1RluJh/FrQy9x1w+U7oiTUXlVICH1w3w==
X-Received: by 2002:a05:620a:4691:b0:768:1109:397 with SMTP id bq17-20020a05620a469100b0076811090397mr2429148qkb.62.1690384026957;
        Wed, 26 Jul 2023 08:07:06 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:ad06])
        by smtp.gmail.com with ESMTPSA id cx24-20020a05620a51d800b00767c961eb47sm4438556qkb.43.2023.07.26.08.07.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 08:07:06 -0700 (PDT)
Date:   Wed, 26 Jul 2023 11:07:05 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Rik van Riel <riel@surriel.com>,
        Joonsoo Kim <js1304@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] mm: page_alloc: consume available CMA space first
Message-ID: <20230726150705.GA1365610@cmpxchg.org>
References: <20230726145304.1319046-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230726145304.1319046-1-hannes@cmpxchg.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On a memcache setup with heavy anon usage and no swap, we routinely
see premature OOM kills with multiple gigabytes of free space left:

    Node 0 Normal free:4978632kB [...] free_cma:4893276kB

This free space turns out to be CMA. We set CMA regions aside for
potential hugetlb users on all of our machines, figuring that even if
there aren't any, the memory is available to userspace allocations.

When the OOMs trigger, it's from unmovable and reclaimable allocations
that aren't allowed to dip into CMA. The non-CMA regions meanwhile are
dominated by the anon pages.

Movable pages can be migrated out of CMA when necessary, but we don't
have a mechanism to migrate them *into* CMA to make room for unmovable
allocations. The only recourse we have for these pages is reclaim,
which due to a lack of swap is unavailable in our case.

Because we have more options for CMA pages, change the policy to
always fill up CMA first. This reduces the risk of premature OOMs.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/page_alloc.c | 53 +++++++++++++++++++------------------------------
 1 file changed, 20 insertions(+), 33 deletions(-)

I realized shortly after sending the first version that the code can
be further simplified by removing __rmqueue_cma_fallback() altogether.

Build, boot and runtime tested that CMA is indeed used up first.

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 7d3460c7a480..b257f9651ce9 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1634,17 +1634,6 @@ static int fallbacks[MIGRATE_TYPES][MIGRATE_PCPTYPES - 1] = {
 	[MIGRATE_RECLAIMABLE] = { MIGRATE_UNMOVABLE,   MIGRATE_MOVABLE   },
 };
 
-#ifdef CONFIG_CMA
-static __always_inline struct page *__rmqueue_cma_fallback(struct zone *zone,
-					unsigned int order)
-{
-	return __rmqueue_smallest(zone, order, MIGRATE_CMA);
-}
-#else
-static inline struct page *__rmqueue_cma_fallback(struct zone *zone,
-					unsigned int order) { return NULL; }
-#endif
-
 /*
  * Move the free pages in a range to the freelist tail of the requested type.
  * Note that start_page and end_pages are not aligned on a pageblock
@@ -2124,29 +2113,27 @@ __rmqueue(struct zone *zone, unsigned int order, int migratetype,
 {
 	struct page *page;
 
-	if (IS_ENABLED(CONFIG_CMA)) {
-		/*
-		 * Balance movable allocations between regular and CMA areas by
-		 * allocating from CMA when over half of the zone's free memory
-		 * is in the CMA area.
-		 */
-		if (alloc_flags & ALLOC_CMA &&
-		    zone_page_state(zone, NR_FREE_CMA_PAGES) >
-		    zone_page_state(zone, NR_FREE_PAGES) / 2) {
-			page = __rmqueue_cma_fallback(zone, order);
-			if (page)
-				return page;
-		}
+#ifdef CONFIG_CMA
+	/*
+	 * Use up CMA first. Movable pages can be migrated out of CMA
+	 * if necessary, but they cannot migrate into it to make room
+	 * for unmovables elsewhere. The only recourse for them is
+	 * then reclaim, which might be unavailable without swap. We
+	 * want to reduce the risk of OOM with free CMA space left.
+	 */
+	if (alloc_flags & ALLOC_CMA) {
+		page = __rmqueue_smallest(zone, order, MIGRATE_CMA);
+		if (page)
+			return page;
 	}
-retry:
-	page = __rmqueue_smallest(zone, order, migratetype);
-	if (unlikely(!page)) {
-		if (alloc_flags & ALLOC_CMA)
-			page = __rmqueue_cma_fallback(zone, order);
-
-		if (!page && __rmqueue_fallback(zone, order, migratetype,
-								alloc_flags))
-			goto retry;
+#endif
+
+	for (;;) {
+		page = __rmqueue_smallest(zone, order, migratetype);
+		if (page)
+			break;
+		if (!__rmqueue_fallback(zone, order, migratetype, alloc_flags))
+			break;
 	}
 	return page;
 }
-- 
2.41.0

