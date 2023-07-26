Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41EFB7642A4
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 01:38:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbjGZXiX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 19:38:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbjGZXiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 19:38:21 -0400
Received: from out-24.mta0.migadu.com (out-24.mta0.migadu.com [91.218.175.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 674A9E4C
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 16:38:20 -0700 (PDT)
Date:   Wed, 26 Jul 2023 16:38:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1690414697;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sTgnN9ZeCU8wiDSONMF29b7WeR8DaW8U9oGN1VLWAJs=;
        b=NKW2MrgmXsiJppIB+OLNLxajVnmn+Wn5652O4+9iPCMbNLfO9dfUZsiagbuZOLok2qQJd9
        2izmMoBxHggaEFQA/W2ge7sIuH9TkPVxiemOIw1hlnnIwzW1ekv+YEOqcexDHJUYLvy8JI
        7U0MNYy1bnE1GTqd1+27kUraNH7oNuw=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Rik van Riel <riel@surriel.com>,
        Joonsoo Kim <js1304@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: page_alloc: consume available CMA space first
Message-ID: <ZMGuY7syh9x0Sf51@P9FQF9L96D>
References: <20230726145304.1319046-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230726145304.1319046-1-hannes@cmpxchg.org>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2023 at 10:53:04AM -0400, Johannes Weiner wrote:
> On a memcache setup with heavy anon usage and no swap, we routinely
> see premature OOM kills with multiple gigabytes of free space left:
> 
>     Node 0 Normal free:4978632kB [...] free_cma:4893276kB
> 
> This free space turns out to be CMA. We set CMA regions aside for
> potential hugetlb users on all of our machines, figuring that even if
> there aren't any, the memory is available to userspace allocations.
> 
> When the OOMs trigger, it's from unmovable and reclaimable allocations
> that aren't allowed to dip into CMA. The non-CMA regions meanwhile are
> dominated by the anon pages.
> 
> 
> Because we have more options for CMA pages, change the policy to
> always fill up CMA first. This reduces the risk of premature OOMs.

I suspect it might cause regressions on small(er) devices where
a relatively small cma area (Mb's) is often reserved for a use by various
device drivers, which can't handle allocation failures well (even interim
allocation failures). A startup time can regress too: migrating pages out of
cma will take time.

And given the velocity of kernel upgrades on such devices, we won't learn about
it for next couple of years.

> Movable pages can be migrated out of CMA when necessary, but we don't
> have a mechanism to migrate them *into* CMA to make room for unmovable
> allocations. The only recourse we have for these pages is reclaim,
> which due to a lack of swap is unavailable in our case.

Idk, should we introduce such a mechanism? Or use some alternative heuristics,
which will be a better compromise between those who need cma allocations always
pass and those who use large cma areas for opportunistic huge page allocations.
Of course, we can add a boot flag/sysctl/per-cma-area flag, but I doubt we want
really this.

Thanks!
