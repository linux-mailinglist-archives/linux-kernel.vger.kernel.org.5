Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BD6B7925C7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234800AbjIEQUD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:20:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354000AbjIEJJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 05:09:32 -0400
Received: from outbound-smtp55.blacknight.com (outbound-smtp55.blacknight.com [46.22.136.239])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5BC6CE
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 02:09:25 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp55.blacknight.com (Postfix) with ESMTPS id 4379EFA9D9
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 10:09:24 +0100 (IST)
Received: (qmail 1592 invoked from network); 5 Sep 2023 09:09:24 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.20.191])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 5 Sep 2023 09:09:24 -0000
Date:   Tue, 5 Sep 2023 10:09:22 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Lecopzer Chen <lecopzer.chen@mediatek.com>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, vbabka@suse.cz, nsaenzju@redhat.com,
        yj.chiang@mediatek.com, Mark-pk Tsai <mark-pk.tsai@mediatek.com>,
        Joe Liu <joe.liu@mediatek.com>
Subject: Re: [PATCH] mm: page_alloc: fix cma pageblock was stolen in rmqueue
 fallback
Message-ID: <20230905090922.zy7srh33rg5c3zao@techsingularity.net>
References: <20230830111332.7599-1-lecopzer.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20230830111332.7599-1-lecopzer.chen@mediatek.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 30, 2023 at 07:13:33PM +0800, Lecopzer Chen wrote:
> commit 4b23a68f9536 ("mm/page_alloc: protect PCP lists with a
> spinlock") fallback freeing page to free_one_page() if pcp trylock
> failed. This make MIGRATE_CMA be able to fallback and be stolen
> whole pageblock by MIGRATE_UNMOVABLE in the page allocation.
> 
> PCP free is fine because free_pcppages_bulk() will always get
> migratetype again before freeing the page, thus this only happen when
> someone tried to put CMA page in to other MIGRATE_TYPE's freelist.
> 
> Fixes: 4b23a68f9536 ("mm/page_alloc: protect PCP lists with a spinlock")
> Reported-by: Joe Liu <joe.liu@mediatek.com>
> Signed-off-by: Lecopzer Chen <lecopzer.chen@mediatek.com>
> Cc: Mark-pk Tsai <mark-pk.tsai@mediatek.com>
> Cc: Joe Liu <joe.liu@mediatek.com>

Sorry for the long delay and thanks Lecopzer for the patch.

This changelog is difficult to parse but the fix may also me too specific
and could be more robust against types other than CMA. It is true that
a failed PCP acquire may return a !is_migrate_isolate page to the wrong
list but it's more straight-forward to unconditionally lookup the PCP
migratetype of the spinlock is not acquired.

How about this? It unconditionally looks up the PCP migratetype after
spinlock contention. It's build tested only

--8<--
mm: page_alloc: Free pages to correct buddy list after PCP lock contention

Commit 4b23a68f9536 ("mm/page_alloc: protect PCP lists with a spinlock")
returns pages to the buddy list on PCP lock contention. However, for
migratetypes that are not MIGRATE_PCPTYPES, the migratetype may have
been clobbered already for pages that are not being isolated. In
practice, this means that CMA pages may be returned to the wrong
buddy list. While this might be harmless in some cases as it is
MIGRATE_MOVABLE, the pageblock could be reassigned in rmqueue_fallback
and prevent a future CMA allocation. Lookup the PCP migratetype
against unconditionally if the PCP lock is contended.

[lecopzer.chen@mediatek.com: CMA-specific fix]
Fixes: 4b23a68f9536 ("mm/page_alloc: protect PCP lists with a spinlock")
Reported-by: Joe Liu <joe.liu@mediatek.com>
Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 mm/page_alloc.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 452459836b71..4053c377fee8 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2428,7 +2428,13 @@ void free_unref_page(struct page *page, unsigned int order)
 		free_unref_page_commit(zone, pcp, page, migratetype, order);
 		pcp_spin_unlock(pcp);
 	} else {
-		free_one_page(zone, page, pfn, order, migratetype, FPI_NONE);
+		/*
+		 * The page migratetype may have been clobbered for types
+		 * (type >= MIGRATE_PCPTYPES && !is_migrate_isolate) so
+		 * must be rechecked.
+		 */
+		free_one_page(zone, page, pfn, order,
+			      get_pcppage_migratetype(page), FPI_NONE);
 	}
 	pcp_trylock_finish(UP_flags);
 }
