Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79B307657BE
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 17:34:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231666AbjG0PeT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 11:34:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbjG0PeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 11:34:17 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A40012686
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 08:34:15 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-1bb7a1c2fe5so825064fac.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 08:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20221208.gappssmtp.com; s=20221208; t=1690472055; x=1691076855;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iAsgg9Y0bkbjJyb1XoUj2DHwlXyOp4ijsNGFHx05igk=;
        b=2crjUJwlUpgTTGr5VWXuH1W3otuh/9iuLTCLwmJcWZ0u6A2lRa1a42GsQmEMnVWzo7
         MCeHuiGvKxjZ3NCWLamZgD+VD7FuFO7jMnlq7pjBG965izlLSuqa3tn+ejB8ty/Sbo7y
         wcVVpHCc/sszMN44x09ZQiNPl0WvPdOILzaY9Z9+dm2ztndGoxkEyh3JoeOCV+aH+L5J
         uCx+57f5WpfeQRXFyd57DRs+nE7xFTIgAK0c+xU3nO/bfVTHxm6XsPLliYdYGm8zI42/
         S29W10+Pp0vjERpjL6TZCLamo8oiQ/UnopyZjrDob6X1ET615yiK/+cgtIA0WHb1rypz
         L0yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690472055; x=1691076855;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iAsgg9Y0bkbjJyb1XoUj2DHwlXyOp4ijsNGFHx05igk=;
        b=KB4UEaaNbMaHMw6LTZMqqSWwuvVQApF2rJ1/O8tos9jB4wxv1U2X/Ywo46XF8OqXMJ
         yVXgJ34koacYKuuIAU5orpJh3Uryk3JhoyW2NxSdthI8R4bBXMbr4xFfswEwmJLh70yt
         a28nFB+VMqEynnZsBUjwAlEa1cesfLtrIGuGeVOzhrg1Nj3TChxf70R7XkQHqRl0dmpv
         oIByaHBOd3EUp9kNvyjChJ7FZ7irS8aXIUszPEEruVa9GRBmL3rKRCwL9CtGh/2hd842
         mti2tWr9SKg51RCOUi2E6hdvAmYZ7RrA7Obj1/j+WNfXvF+6RjtSXbdudBXchRGYMzWJ
         O/MQ==
X-Gm-Message-State: ABy/qLbE1afLDGDx+h31OoS9q/Y0QybVIE3Ol5CEGNpq7g1L5NHZMWIq
        VccZQgdaK9UXoQEpj3pNYKrARA==
X-Google-Smtp-Source: APBJJlH0UlponwvahVI88PCiqpiNFH7I0c7/5lcfOjL++HeiaFGjknZQ//IzaVM7Mk4Dg6yPuPr/pA==
X-Received: by 2002:a05:6870:a929:b0:1bb:b025:3e87 with SMTP id eq41-20020a056870a92900b001bbb0253e87mr3306746oab.58.1690472054960;
        Thu, 27 Jul 2023 08:34:14 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:ad06])
        by smtp.gmail.com with ESMTPSA id c26-20020ac81e9a000000b00403fcd4ea59sm500818qtm.10.2023.07.27.08.34.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 08:34:14 -0700 (PDT)
Date:   Thu, 27 Jul 2023 11:34:13 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Rik van Riel <riel@surriel.com>,
        Joonsoo Kim <js1304@gmail.com>,
        Minchan Kim <minchan.kim@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: page_alloc: consume available CMA space first
Message-ID: <20230727153413.GA1378510@cmpxchg.org>
References: <20230726145304.1319046-1-hannes@cmpxchg.org>
 <ZMGuY7syh9x0Sf51@P9FQF9L96D>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZMGuY7syh9x0Sf51@P9FQF9L96D>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2023 at 04:38:11PM -0700, Roman Gushchin wrote:
> On Wed, Jul 26, 2023 at 10:53:04AM -0400, Johannes Weiner wrote:
> > On a memcache setup with heavy anon usage and no swap, we routinely
> > see premature OOM kills with multiple gigabytes of free space left:
> > 
> >     Node 0 Normal free:4978632kB [...] free_cma:4893276kB
> > 
> > This free space turns out to be CMA. We set CMA regions aside for
> > potential hugetlb users on all of our machines, figuring that even if
> > there aren't any, the memory is available to userspace allocations.
> > 
> > When the OOMs trigger, it's from unmovable and reclaimable allocations
> > that aren't allowed to dip into CMA. The non-CMA regions meanwhile are
> > dominated by the anon pages.
> > 
> > 
> > Because we have more options for CMA pages, change the policy to
> > always fill up CMA first. This reduces the risk of premature OOMs.
> 
> I suspect it might cause regressions on small(er) devices where
> a relatively small cma area (Mb's) is often reserved for a use by various
> device drivers, which can't handle allocation failures well (even interim
> allocation failures). A startup time can regress too: migrating pages out of
> cma will take time.

The page allocator is currently happy to give away all CMA memory to
movables before entering reclaim. It will use CMA even before falling
back to a different migratetype.

Do these small setups take special precautions to never fill memory?
Proactively trim file cache? Never swap? Because AFAICS, unless they
do so, this would only change the timing of when CMA fills up, not if.

> And given the velocity of kernel upgrades on such devices, we won't learn about
> it for next couple of years.

That's true. However, a potential regression with this would show up
fairly early in kernel validation since CMA would fill up in a more
predictable timeline. And the change is easy to revert, too.

Given that we have a concrete problem with the current behavior, I
think it's fair to require a higher bar for proof that this will
indeed cause a regression elsewhere before raising the bar on the fix.

> > Movable pages can be migrated out of CMA when necessary, but we don't
> > have a mechanism to migrate them *into* CMA to make room for unmovable
> > allocations. The only recourse we have for these pages is reclaim,
> > which due to a lack of swap is unavailable in our case.
> 
> Idk, should we introduce such a mechanism? Or use some alternative heuristics,
> which will be a better compromise between those who need cma allocations always
> pass and those who use large cma areas for opportunistic huge page allocations.
> Of course, we can add a boot flag/sysctl/per-cma-area flag, but I doubt we want
> really this.

Right, having migration into CMA could be a viable option as well.

But I would like to learn more from CMA users and their expectations,
since there isn't currently a guarantee that CMA stays empty.

This patch would definitely be the simpler solution. It would also
shave some branches and cycles off the buddy hotpath for many users
that don't actively use CMA but have CONFIG_CMA=y (I checked archlinux
and Fedora, not sure about Suse).
