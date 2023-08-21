Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46ED678305E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 20:38:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbjHUSiB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 14:38:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbjHUSh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 14:37:56 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF4281BFE
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 11:37:51 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id 6a1803df08f44-649921ec030so22012706d6.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 11:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20221208.gappssmtp.com; s=20221208; t=1692643068; x=1693247868;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZngYrrpTqTVsoxTWaftFpu0t3D1kL65SFXqeVP8LffY=;
        b=tTKq6l6aHUSFxqQAsy9JwsqI5eXHQGdiD0FODZRCZUUeuFzk7B/PGOmI2Vs9szLK+G
         dEC4uoaY+bYkZk7tXrTTN84Ya1UWN1T1ntmz4BwiWpAaTDv/KjLtiU8xN7cCLXugYnxj
         LJbOr/gs/OUqybReoZoBcLxK7V0Pt3TD22y3t7PTjTmBG3+EYcaWeiiG5KKdHp8G7xu4
         gGQs8hxtzZGVFfnPYT9iv+Ahh/wRyldbmPvTOfU+kCq2MYvvfryQ4MlloTXLfKY2VBzt
         kO8BdLOxDu9kD/rqKeB1BSsNV0xnrL1jQgNg74XoHP6TFhE2QWb0o5caPuzLs4GeMiZG
         eWpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692643068; x=1693247868;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZngYrrpTqTVsoxTWaftFpu0t3D1kL65SFXqeVP8LffY=;
        b=Djzx/egmaC5AXsqoBzTHjEMkaSx0T3QGylLhmjZd6aEKlcXgK0A21VF6F0x/4yrXX0
         GSEdvHi7g9KW7y5JX6Q/l/KnOQ5GPRG+DbkPrv4Du9JL14F4dr6t5NMDNP1XQEUBIAbA
         /lXBZB+vbdqEU8eTsgmoygCS1+b5qaKlLRNMp8ZAP+zrAgaWbW7zvrWkh8wzSVVl0+1e
         aN8UhA5l1hAgU1pfRlIP2Bcsbc09suPknb1xYEKfkhiFawirAegBoaI9EQXqUkXFSkd6
         QH+dwjbEXgaA5jLihL9whurcVCwcXiVRtuva6mSlYpnnMqsCzrz99v9mFfoSP6QZJm4w
         5sxQ==
X-Gm-Message-State: AOJu0YydjYK6qFFbBRNAM5VNI/jw9JhHUAMeBXlE6m7n6+SI1wINqn0/
        sdRFJVdC2nfcqB5h5ijSGnBKSw==
X-Google-Smtp-Source: AGHT+IEE9dNMT5yZrqH0G+cbatGuZK0wFc+nYEOict7vJbVhdu8eLSChdSchtQ2QFxRxmtKi+qryTw==
X-Received: by 2002:a0c:f092:0:b0:63f:bf70:678f with SMTP id g18-20020a0cf092000000b0063fbf70678fmr8857363qvk.59.1692643068549;
        Mon, 21 Aug 2023 11:37:48 -0700 (PDT)
Received: from localhost (2603-7000-0c01-2716-699c-6fe1-d2a8-6a30.res6.spectrum.com. [2603:7000:c01:2716:699c:6fe1:d2a8:6a30])
        by smtp.gmail.com with ESMTPSA id h16-20020ae9ec10000000b0076cc7219ac9sm2650582qkg.7.2023.08.21.11.37.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 11:37:48 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/8] mm: page_alloc: move free pages when converting block during isolation
Date:   Mon, 21 Aug 2023 14:33:37 -0400
Message-ID: <20230821183733.106619-6-hannes@cmpxchg.org>
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

When claiming a block during compaction isolation, move any remaining
free pages to the correct freelists as well, instead of stranding them
on the wrong list. Otherwise, this encourages incompatible page mixing
down the line, and thus long-term fragmentation.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/page_alloc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 6c9f565b2613..6a4004f07123 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2586,9 +2586,12 @@ int __isolate_free_page(struct page *page, unsigned int order)
 			 * Only change normal pageblocks (i.e., they can merge
 			 * with others)
 			 */
-			if (migratetype_is_mergeable(mt))
+			if (migratetype_is_mergeable(mt)) {
 				set_pageblock_migratetype(page,
 							  MIGRATE_MOVABLE);
+				move_freepages_block(zone, page,
+						     MIGRATE_MOVABLE, NULL);
+			}
 		}
 	}
 
-- 
2.41.0

