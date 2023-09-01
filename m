Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AAB378FB92
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 12:02:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233409AbjIAKCC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 06:02:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbjIAKCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 06:02:01 -0400
Received: from outbound-smtp29.blacknight.com (outbound-smtp29.blacknight.com [81.17.249.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03735E8
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 03:01:53 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail02.blacknight.ie [81.17.254.11])
        by outbound-smtp29.blacknight.com (Postfix) with ESMTPS id 410DABEEFB
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 11:01:52 +0100 (IST)
Received: (qmail 8760 invoked from network); 1 Sep 2023 10:01:52 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.20.191])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 1 Sep 2023 10:01:51 -0000
Date:   Fri, 1 Sep 2023 11:01:49 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Kemeng Shi <shikemeng@huaweicloud.com>
Cc:     akpm@linux-foundation.org, baolin.wang@linux.alibaba.com,
        david@redhat.com, willy@infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/6] mm/compaction: correctly return failure with
 bogus compound_order in strict mode
Message-ID: <20230901100149.ln2yhzj7jsag5gyu@techsingularity.net>
References: <20230901155141.249860-1-shikemeng@huaweicloud.com>
 <20230901155141.249860-4-shikemeng@huaweicloud.com>
 <20230901091711.rpykbvfsnrcuwqhn@techsingularity.net>
 <74851ecc-93ff-1ec3-1589-f13d66d4336d@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <74851ecc-93ff-1ec3-1589-f13d66d4336d@huaweicloud.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 01, 2023 at 05:32:49PM +0800, Kemeng Shi wrote:
> 
> 
> on 9/1/2023 5:17 PM, Mel Gorman wrote:
> > On Fri, Sep 01, 2023 at 11:51:38PM +0800, Kemeng Shi wrote:
> >> In strict mode, we should return 0 if there is any hole in pageblock. If
> >> we successfully isolated pages at beginning at pageblock and then have a
> >> bogus compound_order outside pageblock in next page. We will abort search
> >> loop with blockpfn > end_pfn. Although we will limit blockpfn to end_pfn,
> >> we will treat it as a successful isolation in strict mode as blockpfn is
> >> not < end_pfn and return partial isolated pages. Then
> >> isolate_freepages_range may success unexpectly with hole in isolated
> >> range.
> >>
> >> Fixes: 9fcd6d2e052e ("mm, compaction: skip compound pages by order in free scanner")
> >> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> >> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> >> ---
> >>  mm/compaction.c | 6 +++---
> >>  1 file changed, 3 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/mm/compaction.c b/mm/compaction.c
> >> index a40550a33aee..9ecbfbc695e5 100644
> >> --- a/mm/compaction.c
> >> +++ b/mm/compaction.c
> >> @@ -626,11 +626,12 @@ static unsigned long isolate_freepages_block(struct compact_control *cc,
> >>  		if (PageCompound(page)) {
> >>  			const unsigned int order = compound_order(page);
> >>  
> >> -			if (likely(order <= MAX_ORDER)) {
> >> +			if (blockpfn + (1UL << order) <= end_pfn) {
> >>  				blockpfn += (1UL << order) - 1;
> >>  				page += (1UL << order) - 1;
> >>  				nr_scanned += (1UL << order) - 1;
> >>  			}
> >> +
> >>  			goto isolate_fail;
> >>  		}
> >>  
> >> @@ -678,8 +679,7 @@ static unsigned long isolate_freepages_block(struct compact_control *cc,
> >>  		spin_unlock_irqrestore(&cc->zone->lock, flags);
> >>  
> >>  	/*
> >> -	 * There is a tiny chance that we have read bogus compound_order(),
> >> -	 * so be careful to not go outside of the pageblock.
> >> +	 * Be careful to not go outside of the pageblock.
> >>  	 */
> >>  	if (unlikely(blockpfn > end_pfn))
> >>  		blockpfn = end_pfn;
> > 
> > Is this check still necessary after the first hunk?
> > 
> Actually, I removed this check in the first version, but Baolin thought remove this check is not
> cheap and not worth it. More discussion can be found in [1]. Thanks!
> 

Ok, fair enough. While I think the check is redundant right now, it's a
reasonable defensive check and this is not a fast path so

Acked-by: Mel Gorman <mgorman@techsingularity.net>

-- 
Mel Gorman
SUSE Labs
