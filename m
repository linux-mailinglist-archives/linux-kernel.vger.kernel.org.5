Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1E3978305D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 20:38:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbjHUSh7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 14:37:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbjHUShz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 14:37:55 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7C215116
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 11:37:49 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id af79cd13be357-76d9a79e2fdso161348585a.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 11:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20221208.gappssmtp.com; s=20221208; t=1692643066; x=1693247866;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pMLPduHfWGGT6ewh4Swe7Rx903irp7oZR0cyociTE+I=;
        b=zgi7MRwUxuxU6l+6YWjAy02b4tuqcRki3BC55feePlInbqdpdKi7StCxg8XQ8rUlHV
         qmL0t/87Bm5h3OxPZpMbVir3PnUDYIcuJ4FTPTwg2FPhSmFY8fKiY88CHgVjPTbYLZIG
         2DoN2pg+fmyDdEaeyvxyZ3ave1nYE95eRU9EGOtwqubG3M0SowaS80jCKCoaP+xr8d/F
         u/BS/51tAH69n0fVHUIkW3sy1+PKVJM5fl3G4a4v1K5sZmTdaxUBjIqf1pDgxrGW407t
         enI3crDHWIDAWXZiLOIWDD7vKqkHVmkYAgjZ7o57kJL6DPyevUUImgJQN1FC2BK0aIa7
         0h+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692643066; x=1693247866;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pMLPduHfWGGT6ewh4Swe7Rx903irp7oZR0cyociTE+I=;
        b=MGTwUR5XGNNSZ9D7agds2S4AwBNiaPwTk1jgX430s/oulJENcCzQ6b5aqKG0DAyT18
         ESbzF45iK3TbN/6aKn75Dr7XyDtUUKCxgyOuvQ1PlLM3/DzTu7QOxt2CMg+TkrBdVsdk
         0oc9Ey+PVeNriC0lx83TvkZkV/7iDU6DbFdyZZzjfmG65iYDTTnCtXS6tB/TSo8Lcv0k
         qWy75jnUmEEYxQvI6Im8ZdM8AyHHvh/jZBDwd76gx5+P9u96OMhqyHnB/Y6m6hewz67K
         ZxShOPk1z+2stsnqdVGaKKXfCUctPoIEcbyg5SIyGRi9wyNqa5EXYEQhVKMUTUtkaPI1
         fuQA==
X-Gm-Message-State: AOJu0YzeOVJjiGQR9MAV3TMRnDwXX0/AMc1NrGHMCy3vQFpSQTiiCBtc
        rvSG59g6FjltKZltHsSadsv17w==
X-Google-Smtp-Source: AGHT+IEfqgsX5taJcI3/zF6FUgi9VLti8jni51wseVE9vjrqfDRao4TKvZ/QW/DivW2ebVFb/vqJVg==
X-Received: by 2002:a05:620a:4550:b0:76c:af30:3281 with SMTP id u16-20020a05620a455000b0076caf303281mr10650217qkp.10.1692643066118;
        Mon, 21 Aug 2023 11:37:46 -0700 (PDT)
Received: from localhost (2603-7000-0c01-2716-699c-6fe1-d2a8-6a30.res6.spectrum.com. [2603:7000:c01:2716:699c:6fe1:d2a8:6a30])
        by smtp.gmail.com with ESMTPSA id w13-20020a05620a148d00b0076d25b11b62sm2388467qkj.38.2023.08.21.11.37.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 11:37:45 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/8] mm: page_alloc: fix highatomic landing on the wrong buddy list
Date:   Mon, 21 Aug 2023 14:33:35 -0400
Message-ID: <20230821183733.106619-4-hannes@cmpxchg.org>
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

The following triggers from a custom debug check:

[   89.401754] page type is 3, passed migratetype is 1 (nr=8)
[   89.407930] WARNING: CPU: 2 PID: 75 at mm/page_alloc.c:706 __free_one_page+0x5ea/0x6b0
[   89.415847] Modules linked in:
[   89.418902] CPU: 2 PID: 75 Comm: kswapd0 Not tainted 6.5.0-rc1-00013-g42be896e9f77-dirty #233
[   89.427415] Hardware name: Micro-Star International Co., Ltd. MS-7B98/Z390-A PRO (MS-7B98), BIOS 1.80 12/25/2019
[   89.437572] RIP: 0010:__free_one_page+0x5ea/0x6b0
[   89.442271] Code: <snip>
[   89.461003] RSP: 0000:ffffc900001acea8 EFLAGS: 00010092
[   89.466221] RAX: 0000000000000036 RBX: 0000000000000003 RCX: 0000000000000000
[   89.473349] RDX: 0000000000000106 RSI: 0000000000000027 RDI: 00000000ffffffff
[   89.480478] RBP: ffffffff82ca4780 R08: 0000000000000001 R09: 0000000000000000
[   89.487601] R10: ffffffff8285d1e0 R11: ffffffff8285d1e0 R12: 0000000000000000
[   89.494725] R13: 0000000000063448 R14: ffffea00018d1200 R15: 0000000000063401
[   89.501853] FS:  0000000000000000(0000) GS:ffff88806e680000(0000) knlGS:0000000000000000
[   89.509930] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   89.515671] CR2: 00007fc66488b006 CR3: 00000000190b5001 CR4: 00000000003706e0
[   89.522798] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   89.529924] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   89.537048] Call Trace:
[   89.539498]  <IRQ>
[   89.541517]  ? __free_one_page+0x5ea/0x6b0
[   89.545619]  ? __warn+0x7d/0x130
[   89.548852]  ? __free_one_page+0x5ea/0x6b0
[   89.552946]  ? report_bug+0x18d/0x1c0
[   89.556607]  ? handle_bug+0x3a/0x70
[   89.560097]  ? exc_invalid_op+0x13/0x60
[   89.563933]  ? asm_exc_invalid_op+0x16/0x20
[   89.568113]  ? __free_one_page+0x5ea/0x6b0
[   89.572210]  ? __free_one_page+0x5ea/0x6b0
[   89.576306]  ? refill_obj_stock+0xf5/0x1c0
[   89.580399]  free_one_page.constprop.0+0x5c/0xe0

This is a HIGHATOMIC page being freed to the MOVABLE buddy list.

Highatomic pages have their own buddy freelists, but not their own
pcplist. free_one_page() adjusts the migratetype so they can hitchhike
on the MOVABLE pcplist. However, when the pcp trylock then fails,
they're fed directly to the buddy list - with the incorrect type.

Use MIGRATE_MOVABLE only for the pcp, not for the buddy bypass.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/page_alloc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 20973887999b..a5e36d186893 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2403,7 +2403,7 @@ void free_unref_page(struct page *page, unsigned int order)
 	struct per_cpu_pages *pcp;
 	struct zone *zone;
 	unsigned long pfn = page_to_pfn(page);
-	int migratetype;
+	int migratetype, pcpmigratetype;
 
 	if (!free_pages_prepare(page, order, FPI_NONE))
 		return;
@@ -2415,20 +2415,20 @@ void free_unref_page(struct page *page, unsigned int order)
 	 * areas back if necessary. Otherwise, we may have to free
 	 * excessively into the page allocator
 	 */
-	migratetype = get_pfnblock_migratetype(page, pfn);
+	migratetype = pcpmigratetype = get_pfnblock_migratetype(page, pfn);
 	if (unlikely(migratetype >= MIGRATE_PCPTYPES)) {
 		if (unlikely(is_migrate_isolate(migratetype))) {
 			free_one_page(page_zone(page), page, pfn, order, migratetype, FPI_NONE);
 			return;
 		}
-		migratetype = MIGRATE_MOVABLE;
+		pcpmigratetype = MIGRATE_MOVABLE;
 	}
 
 	zone = page_zone(page);
 	pcp_trylock_prepare(UP_flags);
 	pcp = pcp_spin_trylock(zone->per_cpu_pageset);
 	if (pcp) {
-		free_unref_page_commit(zone, pcp, page, migratetype, order);
+		free_unref_page_commit(zone, pcp, page, pcpmigratetype, order);
 		pcp_spin_unlock(pcp);
 	} else {
 		free_one_page(zone, page, pfn, order, migratetype, FPI_NONE);
-- 
2.41.0

