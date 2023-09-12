Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB99A79D43E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 17:03:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236134AbjILPDa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 11:03:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236110AbjILPD1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 11:03:27 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA818115
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 08:03:23 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id 6a1803df08f44-649921ec030so31751736d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 08:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1694531003; x=1695135803; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UEvBPDpksrICgcQokBE2oIdwNQqNi0CM7UebMeDfNNc=;
        b=jwVCihakQaBLh1ypG4akwa9xR1mGQvqJdnMJkOamBSz78cQRGDgIF34tfdOKNxQtqK
         C4cKm2gEO54fNEMbiF5toN3a61V09KDBhlMi8HtEPsbcWHGeSK7mIawpUjode2blWFRL
         kGnHkFRR/YjWdHHRvCb8O2Buw+reeyX5lJ9/IGD+B2ZvGIYhZWlkAliD2fJ9rbvTVz7u
         ju/OE68G6lgcJ65RXoF2sETrgtOg64eRnRMHrgf1hmRFxuajFoIsSK2pB8BUU9bUnsw6
         XjmPMj8/ofMo7sW8janU7dK6gh4SmCGOEmsWDeGKl1lofzz7Gl5EGKnAtRMrMm5G6Gw+
         XJRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694531003; x=1695135803;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UEvBPDpksrICgcQokBE2oIdwNQqNi0CM7UebMeDfNNc=;
        b=wqfpvYfpWRLHGHUE6tOJfvgQza6FScwiKiKS4CZ2fkyb5GefGhWxR0npUY6XeB6BY6
         8QcjPiKI7ASaH+Yeh+wST9fvSChesIMP9a7C7X8u7yJB+fJAXkP7cSE1YzcFKDVKwLkL
         bngi94RdLuxIDWHejP3N9hJ2fnNv+QdFOZ8x0Ng9SWi3NgH+PmCs2Xl+BL+wW1cRGENo
         5XEDX2arDs3vSZWijCqceLgW1LU/wT2SyYJQUdLXfErx1gb+B+53r3GKYPvuMT0jQNau
         qbvgiZXC9vOc+fRkuBquB4rUJXrd3cBm+T2Y73uw+DL2//2jTYmixdExMzojVux9fUoW
         UA+w==
X-Gm-Message-State: AOJu0YwFYgdjzoiYxoXwyKNd3ZACRZjCrPfiiaUQR9OpDWU4W8PNo/pM
        XwNMNbK2bLQO0MK7O3qjhJFOrg==
X-Google-Smtp-Source: AGHT+IE4pTTrKCnrWLZCrVJm8q/MmUAxCLosu9d3ic59cq9nYG2FMa1TYCaDYG6vulb4qR45Q+3cuw==
X-Received: by 2002:a0c:e00b:0:b0:651:8f39:910d with SMTP id j11-20020a0ce00b000000b006518f39910dmr12813954qvk.58.1694531001713;
        Tue, 12 Sep 2023 08:03:21 -0700 (PDT)
Received: from localhost (2603-7000-0c01-2716-3012-16a2-6bc2-2937.res6.spectrum.com. [2603:7000:c01:2716:3012:16a2:6bc2:2937])
        by smtp.gmail.com with ESMTPSA id t14-20020a0ce2ce000000b0064bdd4239f3sm3745795qvl.126.2023.09.12.08.03.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 08:03:21 -0700 (PDT)
Date:   Tue, 12 Sep 2023 11:03:20 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] mm: page_alloc: remove pcppage migratetype caching
Message-ID: <20230912150320.GB3228@cmpxchg.org>
References: <20230911195023.247694-1-hannes@cmpxchg.org>
 <20230911195023.247694-2-hannes@cmpxchg.org>
 <a389d846-c19a-42d3-6206-0a1c80e40b37@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a389d846-c19a-42d3-6206-0a1c80e40b37@suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 03:47:45PM +0200, Vlastimil Babka wrote:
> I think after this change we should [...]

Speaking of follow-ups, AFAICS we no longer need those either:

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 9cad31de1bf5..bea499fbca58 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1751,13 +1751,6 @@ static void steal_suitable_fallback(struct zone *zone, struct page *page,
 
 	old_block_type = get_pageblock_migratetype(page);
 
-	/*
-	 * This can happen due to races and we want to prevent broken
-	 * highatomic accounting.
-	 */
-	if (is_migrate_highatomic(old_block_type))
-		goto single_page;
-
 	/* Take ownership for orders >= pageblock_order */
 	if (current_order >= pageblock_order) {
 		change_pageblock_range(page, current_order, start_type);
@@ -1926,24 +1919,15 @@ static bool unreserve_highatomic_pageblock(const struct alloc_context *ac,
 				continue;
 
 			/*
-			 * In page freeing path, migratetype change is racy so
-			 * we can counter several free pages in a pageblock
-			 * in this loop although we changed the pageblock type
-			 * from highatomic to ac->migratetype. So we should
-			 * adjust the count once.
+			 * It should never happen but changes to
+			 * locking could inadvertently allow a per-cpu
+			 * drain to add pages to MIGRATE_HIGHATOMIC
+			 * while unreserving so be safe and watch for
+			 * underflows.
 			 */
-			if (is_migrate_highatomic_page(page)) {
-				/*
-				 * It should never happen but changes to
-				 * locking could inadvertently allow a per-cpu
-				 * drain to add pages to MIGRATE_HIGHATOMIC
-				 * while unreserving so be safe and watch for
-				 * underflows.
-				 */
-				zone->nr_reserved_highatomic -= min(
-						pageblock_nr_pages,
-						zone->nr_reserved_highatomic);
-			}
+			zone->nr_reserved_highatomic -= min(
+				pageblock_nr_pages,
+				zone->nr_reserved_highatomic);
 
 			/*
 			 * Convert to ac->migratetype and avoid the normal

I think they were only in place because we could change the highatomic
status of pages on the pcplist, and those pages would then end up on
some other freelist due to the stale pcppage cache.

I replaced them locally with WARNs and ran an hour or so of kernel
builds under pressure. It didn't trigger. So I would send a follow up
to remove them.

Unless you point me to a good reason why they're definitely still
needed - in which case this is a moot proposal - but then we should
make the comments more specific.
