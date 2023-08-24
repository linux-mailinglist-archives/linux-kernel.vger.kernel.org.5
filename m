Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 156FE787469
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 17:39:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242241AbjHXPi7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 11:38:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242324AbjHXPi0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 11:38:26 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A858198B
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 08:38:24 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-403e7472b28so43005971cf.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 08:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20221208.gappssmtp.com; s=20221208; t=1692891503; x=1693496303;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/GKWCpngibybkjTzS3eXwbdynJVEtQMAYIUrowwYJ/4=;
        b=eCPG0UtIc4295JlokQU/nJupSVbSoUbxgABx0fpANQUn1BTauwIKfLaOFst9flSKft
         AKdgxxQ5+w9yCDvBrW/DH+bjlQMFOIEBN2AEsKABYz8kqK9EYG7Pvm2HNSP8lp3sM/CQ
         ShO+H52mJUTDumB7zAr3/HwaqnxMI4LutP6eqiew7NutTS4zJWBSWZ93MGsBhwaLRk6t
         Pp1zir2zlrYeHUI/WSfM3IeT+F1er0DLL+DIXmfhwD3axNFYGjfeGvlHooPo7dO4C0Ar
         AUI9P52QhgllGGe5YS7rXoRVZRABnmT2eCXmM19QMCsmuWRz/QrwtnPGgwPW62JRaWIO
         JBwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692891503; x=1693496303;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/GKWCpngibybkjTzS3eXwbdynJVEtQMAYIUrowwYJ/4=;
        b=f735bEkGHMuoPuEFb/wWFUwSXtQYFw7C9nSd8p5W+BRt+R0Wdr8HS7hiQP3IDZFuO5
         gaKSbOqnn6eGvrBNqLaqfxEQyrj4ZygKj3EurBahG6/OWTAmlTA4oIayFMjpAfyulLCY
         rI3TZ6kVB1tA2naD8wWKf11sJ8tN8KYuPfSBQtWfsvpdiylwK6rwxWreB2eYmIj25mtu
         OU8VrK+2nUGDp8OsDH7+uXqJiLmTQQo3+RaV9hhCOiGqNxxCsTU2Rk6UBxWobeiI89SV
         uE0J9ob0BfGxe9W+65IcUX9MLeYL0R12GBzhNt3FZ044ew8z5Anev+g5cnrv6nFLxqgt
         hm2Q==
X-Gm-Message-State: AOJu0YygueuqaVrbkEmCh1Q8MtNP+dTgkO5CL0peQdnTU0xKvwLw9ZrH
        zGHuTZVWaeuRrix+k6T4ccAw6g==
X-Google-Smtp-Source: AGHT+IGOrOXCzNXqhRu48aD/ROL4BiX1O8HA6jds+mrHOVhHVf2Vr9uXd3m8pXE/SORnEY7zKGK/nA==
X-Received: by 2002:ac8:5806:0:b0:403:8d8a:564e with SMTP id g6-20020ac85806000000b004038d8a564emr21098740qtg.62.1692891503705;
        Thu, 24 Aug 2023 08:38:23 -0700 (PDT)
Received: from localhost (2603-7000-0c01-2716-7ffd-0cf9-a739-5564.res6.spectrum.com. [2603:7000:c01:2716:7ffd:cf9:a739:5564])
        by smtp.gmail.com with ESMTPSA id ie4-20020a05622a698400b004120400921csm348528qtb.94.2023.08.24.08.38.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 08:38:23 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm: page_alloc: remove stale CMA guard code
Date:   Thu, 24 Aug 2023 11:38:21 -0400
Message-ID: <20230824153821.243148-1-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.42.0
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

In the past, movable allocations could be disallowed from CMA through
PF_MEMALLOC_PIN. As CMA pages are funneled through the MOVABLE
pcplist, this required filtering that cornercase during allocations,
such that pinnable allocations wouldn't accidentally get a CMA page.

However, since 8e3560d963d2 ("mm: honor PF_MEMALLOC_PIN for all
movable pages"), PF_MEMALLOC_PIN automatically excludes
__GFP_MOVABLE. Once again, MOVABLE implies CMA is allowed.

Remove the stale filtering code. Also remove a stale comment that was
introduced as part of the filtering code, because the filtering let
order-0 pages fall through to the buddy allocator. See 1d91df85f399
("mm/page_alloc: handle a missing case for
memalloc_nocma_{save/restore} APIs") for context. The comment's been
obsolete since the introduction of the explicit ALLOC_HIGHATOMIC flag
in eb2e2b425c69 ("mm/page_alloc: explicitly record high-order atomic
allocations in alloc_flags").

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/page_alloc.c | 21 ++++-----------------
 1 file changed, 4 insertions(+), 17 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 5e14e31567df..2e1ee11ab49a 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2641,12 +2641,6 @@ struct page *rmqueue_buddy(struct zone *preferred_zone, struct zone *zone,
 	do {
 		page = NULL;
 		spin_lock_irqsave(&zone->lock, flags);
-		/*
-		 * order-0 request can reach here when the pcplist is skipped
-		 * due to non-CMA allocation context. HIGHATOMIC area is
-		 * reserved for high-order atomic allocation, so order-0
-		 * request should skip it.
-		 */
 		if (alloc_flags & ALLOC_HIGHATOMIC)
 			page = __rmqueue_smallest(zone, order, MIGRATE_HIGHATOMIC);
 		if (!page) {
@@ -2780,17 +2774,10 @@ struct page *rmqueue(struct zone *preferred_zone,
 	WARN_ON_ONCE((gfp_flags & __GFP_NOFAIL) && (order > 1));
 
 	if (likely(pcp_allowed_order(order))) {
-		/*
-		 * MIGRATE_MOVABLE pcplist could have the pages on CMA area and
-		 * we need to skip it when CMA area isn't allowed.
-		 */
-		if (!IS_ENABLED(CONFIG_CMA) || alloc_flags & ALLOC_CMA ||
-				migratetype != MIGRATE_MOVABLE) {
-			page = rmqueue_pcplist(preferred_zone, zone, order,
-					migratetype, alloc_flags);
-			if (likely(page))
-				goto out;
-		}
+		page = rmqueue_pcplist(preferred_zone, zone, order,
+				       migratetype, alloc_flags);
+		if (likely(page))
+			goto out;
 	}
 
 	page = rmqueue_buddy(preferred_zone, zone, order, alloc_flags,
-- 
2.42.0

