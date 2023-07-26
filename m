Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34204763999
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 16:53:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233873AbjGZOxL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 10:53:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234088AbjGZOxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 10:53:08 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87F7719A0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 07:53:06 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id 6a1803df08f44-63d23473ed5so8458406d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 07:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20221208.gappssmtp.com; s=20221208; t=1690383185; x=1690987985;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DAfH5v/FF69jwtMUJAQFsWnnw4nApRzsZ9+9hy9LFb4=;
        b=Uab2ivjjTFcQGMdWe0ih6Wtrb5WZDGqLYfeNDc8TALXaTT8kf5avzsYAy3xo7Lfscz
         k6hoFbaH1zeMk8VnStPdktueZ8kaqoiDz1IJQ5hMml+zSXVDoM7hBuzaaCw6Ma1nBbK4
         PU9QoWEwQUcQS3MUI9x97gxQ1+9YX26SJFS/M2aUx+tvKw6LHDjrw9QP/AksSce4/A7Y
         ZXXoTFpU+MJA2NKStor0L9cfppts9fY9ld3J/QygAiDusv2u5IUh+Y3NjvHN3zN8LCMS
         kIMPlYRQ+GaHPfkblKp3Q7gaqa4sGmrwBbiN+nHhZzkDJJpNrncHKNY1gdaoQVfyFPjM
         YZVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690383185; x=1690987985;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DAfH5v/FF69jwtMUJAQFsWnnw4nApRzsZ9+9hy9LFb4=;
        b=M3SV11KNK7r3e45tavXGqoIWooNvN/VSeWyDY1zvglTeiFWAtX2yUhX9iOewYG/vQh
         N1zLpOGvmPcuGI/1gX9CH15oS5tcjrUS6ywOQ5U6VwH3qnIRv7hIgoV8quwgDQfvNSIY
         11Y/0BEPaU2gnM0gKY3q+GwTRYFZW17kGuM9Rl+1cP0rDoAsH92S76wnpIn923U91/Hx
         2nSt0Sqiys2J8qyIno4URRmzCROaWlZuRqMIOERIhTIl5ZdDlDfVK2S9eCNecvY4pQBK
         YNPb9kGfyHG4t2EXM3F/eEIy3CQUDmNTN5MElV2OJlv3e6AS6+TdXq+rvsRuvUp2VrkU
         3n7A==
X-Gm-Message-State: ABy/qLY5df30+cikdDs43DjTx6yKhRgfYvX48WLh6DNH82Xux5CXbUuk
        hS8glS8qfSJfgpxEKLz6ud4KXg==
X-Google-Smtp-Source: APBJJlH3e5+/gb68gHLAVSLWp2h+LL6UzWbR163vXAK6FTeP67Yc4TVejm/1C2viPpaARYf2Aq5gPg==
X-Received: by 2002:ac8:5f4a:0:b0:403:e853:17c3 with SMTP id y10-20020ac85f4a000000b00403e85317c3mr2591827qta.38.1690383185689;
        Wed, 26 Jul 2023 07:53:05 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:ad06])
        by smtp.gmail.com with ESMTPSA id w10-20020ac86b0a000000b003f9c6a311e1sm4821641qts.47.2023.07.26.07.53.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 07:53:05 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Rik van Riel <riel@surriel.com>,
        Joonsoo Kim <js1304@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm: page_alloc: consume available CMA space first
Date:   Wed, 26 Jul 2023 10:53:04 -0400
Message-ID: <20230726145304.1319046-1-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
 mm/page_alloc.c | 44 ++++++++++++++++++++------------------------
 1 file changed, 20 insertions(+), 24 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 7d3460c7a480..24b9102cd4f6 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1635,13 +1635,13 @@ static int fallbacks[MIGRATE_TYPES][MIGRATE_PCPTYPES - 1] = {
 };
 
 #ifdef CONFIG_CMA
-static __always_inline struct page *__rmqueue_cma_fallback(struct zone *zone,
+static __always_inline struct page *__rmqueue_cma(struct zone *zone,
 					unsigned int order)
 {
 	return __rmqueue_smallest(zone, order, MIGRATE_CMA);
 }
 #else
-static inline struct page *__rmqueue_cma_fallback(struct zone *zone,
+static inline struct page *__rmqueue_cma(struct zone *zone,
 					unsigned int order) { return NULL; }
 #endif
 
@@ -2124,29 +2124,25 @@ __rmqueue(struct zone *zone, unsigned int order, int migratetype,
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
+	/*
+	 * Use up CMA first. Movable pages can be migrated out of CMA
+	 * if necessary, but they cannot migrate into it to make room
+	 * for unmovables elsewhere. The only recourse for them is
+	 * then reclaim, which might be unavailable without swap. We
+	 * want to reduce the risk of OOM with free CMA space left.
+	 */
+	if (IS_ENABLED(CONFIG_CMA) && (alloc_flags & ALLOC_CMA)) {
+		page = __rmqueue_cma(zone, order);
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

