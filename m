Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 900F2765987
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 19:08:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbjG0RIV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 13:08:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbjG0RIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 13:08:18 -0400
Received: from out-96.mta0.migadu.com (out-96.mta0.migadu.com [91.218.175.96])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A3132726
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 10:08:15 -0700 (PDT)
Date:   Thu, 27 Jul 2023 10:08:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1690477693;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zWu44KyYtJW37iFlqtSm+zqI+cvUj1jxNs2A6ZtISyk=;
        b=QUrfO7HydlIsqe5C52Io5M8NiCgdefK5Og+FmNHSxcjzmhKbjbcjvwHgKkZNad/qrsCRos
        RjnGudjdymVCo0rNMtKFF8TJ2QOE6OlbErbzgDVajo6KCwfHOA/E4wvQe4aR/02Kz7SRT3
        hIN3YnCkfALPyVvHGozqPpW4U+6nVVw=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Rik van Riel <riel@surriel.com>,
        Joonsoo Kim <js1304@gmail.com>,
        Minchan Kim <minchan.kim@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: page_alloc: consume available CMA space first
Message-ID: <ZMKkeBdaLfzLUQuX@P9FQF9L96D>
References: <20230726145304.1319046-1-hannes@cmpxchg.org>
 <ZMGuY7syh9x0Sf51@P9FQF9L96D>
 <20230727153413.GA1378510@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230727153413.GA1378510@cmpxchg.org>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2023 at 11:34:13AM -0400, Johannes Weiner wrote:
> On Wed, Jul 26, 2023 at 04:38:11PM -0700, Roman Gushchin wrote:
> > On Wed, Jul 26, 2023 at 10:53:04AM -0400, Johannes Weiner wrote:
> > > On a memcache setup with heavy anon usage and no swap, we routinely
> > > see premature OOM kills with multiple gigabytes of free space left:
> > > 
> > >     Node 0 Normal free:4978632kB [...] free_cma:4893276kB
> > > 
> > > This free space turns out to be CMA. We set CMA regions aside for
> > > potential hugetlb users on all of our machines, figuring that even if
> > > there aren't any, the memory is available to userspace allocations.
> > > 
> > > When the OOMs trigger, it's from unmovable and reclaimable allocations
> > > that aren't allowed to dip into CMA. The non-CMA regions meanwhile are
> > > dominated by the anon pages.
> > > 
> > > 
> > > Because we have more options for CMA pages, change the policy to
> > > always fill up CMA first. This reduces the risk of premature OOMs.
> > 
> > I suspect it might cause regressions on small(er) devices where
> > a relatively small cma area (Mb's) is often reserved for a use by various
> > device drivers, which can't handle allocation failures well (even interim
> > allocation failures). A startup time can regress too: migrating pages out of
> > cma will take time.
> 
> The page allocator is currently happy to give away all CMA memory to
> movables before entering reclaim. It will use CMA even before falling
> back to a different migratetype.
> 
> Do these small setups take special precautions to never fill memory?
> Proactively trim file cache? Never swap? Because AFAICS, unless they
> do so, this would only change the timing of when CMA fills up, not if.

Imagine something like a web-camera or a router. It boots up, brings up some
custom drivers/hardware, starts some daemons and runs forever. It might never
reach the memory capacity or it might take hours or days. The point it that
during the initialization cma is fully available.

> 
> > And given the velocity of kernel upgrades on such devices, we won't learn about
> > it for next couple of years.
> 
> That's true. However, a potential regression with this would show up
> fairly early in kernel validation since CMA would fill up in a more
> predictable timeline. And the change is easy to revert, too.
> 
> Given that we have a concrete problem with the current behavior, I
> think it's fair to require a higher bar for proof that this will
> indeed cause a regression elsewhere before raising the bar on the fix.

I'm not opposing the change, just raising up a concern. I expect that
we'll need a more complicated solution at some point anyway.

> 
> > > Movable pages can be migrated out of CMA when necessary, but we don't
> > > have a mechanism to migrate them *into* CMA to make room for unmovable
> > > allocations. The only recourse we have for these pages is reclaim,
> > > which due to a lack of swap is unavailable in our case.
> > 
> > Idk, should we introduce such a mechanism? Or use some alternative heuristics,
> > which will be a better compromise between those who need cma allocations always
> > pass and those who use large cma areas for opportunistic huge page allocations.
> > Of course, we can add a boot flag/sysctl/per-cma-area flag, but I doubt we want
> > really this.
> 
> Right, having migration into CMA could be a viable option as well.
> 
> But I would like to learn more from CMA users and their expectations,
> since there isn't currently a guarantee that CMA stays empty.

This change makes cma allocations less deterministic. If previously a cma allocation
was almost always succeeding, with this change we'll see more interim failures.
(it's all about some time after a boot when the majority of memory is still empty).

> 
> This patch would definitely be the simpler solution. It would also
> shave some branches and cycles off the buddy hotpath for many users
> that don't actively use CMA but have CONFIG_CMA=y (I checked archlinux
> and Fedora, not sure about Suse).

Yes, this is good.
