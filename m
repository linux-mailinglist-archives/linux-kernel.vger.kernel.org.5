Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F6A47B074F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 16:51:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232231AbjI0OvW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 10:51:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232046AbjI0OvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 10:51:19 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F38F3F4
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 07:51:17 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id 6a1803df08f44-65b0216b067so34377666d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 07:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1695826277; x=1696431077; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Fn/fnUImPYJ3juyCBA9k0JjneMWSFn0vkOy/+//4tIM=;
        b=NaBw20GN/v9S7qOWu+be4CI5t+B13A9ho9AX6jI1dGcS7EuohWOW7mKLZB3Yt5+O3n
         Ljz12bdTNBkUpVpZYB/UaVLeclhBSPVmq7vQK3zw3FO0++seL++SS8kv1LGJO1oBkJPs
         UVrbSZAOdEW34sUsb1X/9MoiYndjxD5BWEDCqvzbnBiXF/pQ+xABLGIGFcmoKON8w6HZ
         dMoNiH2eb5a1Tmi/+l2vpUt6fWDOGgTuvC9bbvf7qfbolv+e7xObIJ4t7Jh9xa1v/GCF
         ALWc7vyAILn7GNJnDKxhySeOhf1xblzYStdaEA21yCD23e9M5XRv1LIHhruAFlXSY+ls
         fgDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695826277; x=1696431077;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fn/fnUImPYJ3juyCBA9k0JjneMWSFn0vkOy/+//4tIM=;
        b=EQGcOkQ5a5yW2sboqLaa50hjAEhJ+/zBKCLeOCMOWjBbKDF/OgE6jwp2BSmvn4YAWy
         WshFNC0x6Gj8JAwsBqyjueGB6JSO5mdHYCYJGCWtarcRTm0IGOS6bncYHnRAve8DIc7M
         f7PvGPDyM7nCXMbrmQukmNBipg3S1kRHHQmrhO1ZPYsbuZWujKaiGurAy6+WSkSV6SaT
         7MDb6pJhwgHN31LwL8vfYqXtuHfqsdNZJCmyxjWQFlFdtoUHgGE4D6oPDhWTQPnA4kAc
         DWIgci/JaZOXTypFdqqL8BI6warcQ7QKBIdyzoJiN1SqX+yMGhc23Tfxd44fkU+GPXSl
         XIbw==
X-Gm-Message-State: AOJu0YwFy0dshLLoaD1RlAMovYJD5Lf3Iwz3Ga9zArA7i7yJp9tn6nuW
        DcYgH7UmoAUNw537a31eL29eaABcuxKwqhzdjTw=
X-Google-Smtp-Source: AGHT+IGKGncTxrNNtoHGKBSC6CBHf9ebv6M9I7tnRJOLBc69Ux1UBXseerwEavcZ/fe8F7AUZpA4fA==
X-Received: by 2002:a0c:e052:0:b0:655:8ac4:2658 with SMTP id y18-20020a0ce052000000b006558ac42658mr2117297qvk.21.1695826277004;
        Wed, 27 Sep 2023 07:51:17 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:ba06])
        by smtp.gmail.com with ESMTPSA id z24-20020ae9c118000000b007671cfe8a18sm5503943qki.13.2023.09.27.07.51.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 07:51:16 -0700 (PDT)
Date:   Wed, 27 Sep 2023 10:51:15 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] mm: page_alloc: remove pcppage migratetype caching
Message-ID: <20230927145115.GA365513@cmpxchg.org>
References: <20230911195023.247694-1-hannes@cmpxchg.org>
 <20230911195023.247694-2-hannes@cmpxchg.org>
 <87y1gsrx32.fsf@yhuang6-desk2.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y1gsrx32.fsf@yhuang6-desk2.ccr.corp.intel.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 27, 2023 at 01:42:25PM +0800, Huang, Ying wrote:
> Johannes Weiner <hannes@cmpxchg.org> writes:
> 
> > The idea behind the cache is to save get_pageblock_migratetype()
> > lookups during bulk freeing. A microbenchmark suggests this isn't
> > helping, though. The pcp migratetype can get stale, which means that
> > bulk freeing has an extra branch to check if the pageblock was
> > isolated while on the pcp.
> >
> > While the variance overlaps, the cache write and the branch seem to
> > make this a net negative. The following test allocates and frees
> > batches of 10,000 pages (~3x the pcp high marks to trigger flushing):
> >
> > Before:
> >           8,668.48 msec task-clock                       #   99.735 CPUs utilized               ( +-  2.90% )
> >                 19      context-switches                 #    4.341 /sec                        ( +-  3.24% )
> >                  0      cpu-migrations                   #    0.000 /sec
> >             17,440      page-faults                      #    3.984 K/sec                       ( +-  2.90% )
> >     41,758,692,473      cycles                           #    9.541 GHz                         ( +-  2.90% )
> >    126,201,294,231      instructions                     #    5.98  insn per cycle              ( +-  2.90% )
> >     25,348,098,335      branches                         #    5.791 G/sec                       ( +-  2.90% )
> >         33,436,921      branch-misses                    #    0.26% of all branches             ( +-  2.90% )
> >
> >          0.0869148 +- 0.0000302 seconds time elapsed  ( +-  0.03% )
> >
> > After:
> >           8,444.81 msec task-clock                       #   99.726 CPUs utilized               ( +-  2.90% )
> >                 22      context-switches                 #    5.160 /sec                        ( +-  3.23% )
> >                  0      cpu-migrations                   #    0.000 /sec
> >             17,443      page-faults                      #    4.091 K/sec                       ( +-  2.90% )
> >     40,616,738,355      cycles                           #    9.527 GHz                         ( +-  2.90% )
> >    126,383,351,792      instructions                     #    6.16  insn per cycle              ( +-  2.90% )
> >     25,224,985,153      branches                         #    5.917 G/sec                       ( +-  2.90% )
> >         32,236,793      branch-misses                    #    0.25% of all branches             ( +-  2.90% )
> >
> >          0.0846799 +- 0.0000412 seconds time elapsed  ( +-  0.05% )
> >
> > A side effect is that this also ensures that pages whose pageblock
> > gets stolen while on the pcplist end up on the right freelist and we
> > don't perform potentially type-incompatible buddy merges (or skip
> > merges when we shouldn't), whis is likely beneficial to long-term
> > fragmentation management, although the effects would be harder to
> > measure. Settle for simpler and faster code as justification here.
> 
> I suspected the PCP allocating/freeing path may be influenced (that is,
> allocating/freeing batch is less than PCP high).  So I tested
> one-process will-it-scale/page_fault1 with sysctl
> percpu_pagelist_high_fraction=8.  So pages will be allocated/freed
> from/to PCP only.  The test results are as follows,
> 
> Before:
> will-it-scale.1.processes                        618364.3      (+-  0.075%)
> perf-profile.children.get_pfnblock_flags_mask         0.13     (+-  9.350%)
> 
> After:
> will-it-scale.1.processes	                 616512.0      (+-  0.057%)
> perf-profile.children.get_pfnblock_flags_mask	      0.41     (+-  22.44%)
> 
> The change isn't large: -0.3%.  Perf profiling shows the cycles% of
> get_pfnblock_flags_mask() increases.

Ah, this is going through the free_unref_page_list() path that
Vlastimil had pointed out as well. I made another change on top that
eliminates the second lookup. After that, both pcp fast paths have the
same number of lookups as before: 1. This fixes the regression for me.

Would you mind confirming this as well?

--

From f5d032019ed832a1a50454347a33b00ca6abeb30 Mon Sep 17 00:00:00 2001
From: Johannes Weiner <hannes@cmpxchg.org>
Date: Fri, 15 Sep 2023 16:03:24 -0400
Subject: [PATCH] mm: page_alloc: optimize free_unref_page_list()

Move direct freeing of isolated pages to the lock-breaking block in
the second loop. This saves an unnecessary migratetype reassessment.

Minor comment and local variable scoping cleanups.

Suggested-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/page_alloc.c | 44 ++++++++++++++++++--------------------------
 1 file changed, 18 insertions(+), 26 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index bfffc1af94cd..665930ffe22a 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2466,48 +2466,40 @@ void free_unref_page_list(struct list_head *list)
 	struct per_cpu_pages *pcp = NULL;
 	struct zone *locked_zone = NULL;
 	int batch_count = 0;
-	int migratetype;
-
-	/* Prepare pages for freeing */
-	list_for_each_entry_safe(page, next, list, lru) {
-		unsigned long pfn = page_to_pfn(page);
-
-		if (!free_pages_prepare(page, 0, FPI_NONE)) {
-			list_del(&page->lru);
-			continue;
-		}
 
-		/*
-		 * Free isolated pages directly to the allocator, see
-		 * comment in free_unref_page.
-		 */
-		migratetype = get_pfnblock_migratetype(page, pfn);
-		if (unlikely(is_migrate_isolate(migratetype))) {
+	list_for_each_entry_safe(page, next, list, lru)
+		if (!free_pages_prepare(page, 0, FPI_NONE))
 			list_del(&page->lru);
-			free_one_page(page_zone(page), page, pfn, 0, FPI_NONE);
-			continue;
-		}
-	}
 
 	list_for_each_entry_safe(page, next, list, lru) {
 		unsigned long pfn = page_to_pfn(page);
 		struct zone *zone = page_zone(page);
+		int migratetype;
 
 		list_del(&page->lru);
 		migratetype = get_pfnblock_migratetype(page, pfn);
 
 		/*
-		 * Either different zone requiring a different pcp lock or
-		 * excessive lock hold times when freeing a large list of
-		 * pages.
+		 * Zone switch, batch complete, or non-pcp freeing?
+		 * Drop the pcp lock and evaluate.
 		 */
-		if (zone != locked_zone || batch_count == SWAP_CLUSTER_MAX) {
+		if (unlikely(zone != locked_zone ||
+			     batch_count == SWAP_CLUSTER_MAX ||
+			     is_migrate_isolate(migratetype))) {
 			if (pcp) {
 				pcp_spin_unlock(pcp);
 				pcp_trylock_finish(UP_flags);
+				locked_zone = NULL;
 			}
 
-			batch_count = 0;
+			/*
+			 * Free isolated pages directly to the
+			 * allocator, see comment in free_unref_page.
+			 */
+			if (is_migrate_isolate(migratetype)) {
+				free_one_page(zone, page, pfn, 0, FPI_NONE);
+				continue;
+			}
 
 			/*
 			 * trylock is necessary as pages may be getting freed
@@ -2518,10 +2510,10 @@ void free_unref_page_list(struct list_head *list)
 			if (unlikely(!pcp)) {
 				pcp_trylock_finish(UP_flags);
 				free_one_page(zone, page, pfn, 0, FPI_NONE);
-				locked_zone = NULL;
 				continue;
 			}
 			locked_zone = zone;
+			batch_count = 0;
 		}
 
 		/*
-- 
2.42.0

