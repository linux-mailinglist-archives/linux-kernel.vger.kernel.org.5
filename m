Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E3D27F68B9
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 22:38:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbjKWVcu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 16:32:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjKWVcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 16:32:48 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0767AD
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 13:32:54 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DA4BC433CA;
        Thu, 23 Nov 2023 21:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700775174;
        bh=EJrVqrprMxLs4WMWlL05MhTf0n0/Q9nUsytRTZI/d+g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZL3+ID0ndJJL3M/cuMNcG1XIlie8Hvdz9NNpc7AdcSp41bhttRGAOP7Nl7uQnxkeh
         gbLpzILeqsOWMcdF+Wwe1s8FS4lJmt2bg2Ne4mDVJfwbEj6BCSQY3+8eSi8+LPwjUr
         A5lgWeGYchJUQjRA21fOGpFqxDyMhIPmReuJJ25vm1AgrcXD8S4ebLNe8zOZA8a1B+
         9DU091vhc+PlRY4bTHZMySJkD+S0G2YNn/7UkGDfk9NjJMx+QJ1D0PeqYL/WA+S2Nc
         I9mBCi/5AbOQNUrI4TwcJmxcr0GxTljeY1Fbt38K2Aflk1f/D2qZjQNZwFFRu56HgT
         VSC/vuK/KpE6A==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id A14DB40094; Thu, 23 Nov 2023 18:32:51 -0300 (-03)
Date:   Thu, 23 Nov 2023 18:32:51 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Ian Rogers <irogers@google.com>, Marc Zyngier <maz@kernel.org>,
        Hector Martin <marcan@marcan.st>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        James Clark <james.clark@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1] perf parse-events: Make legacy events lower
 priority than sysfs/json
Message-ID: <ZV/FA+tGFWkMhXiM@kernel.org>
References: <20231123042922.834425-1-irogers@google.com>
 <ZV9jq1C0TUh8MbeU@FVFF77S0Q05N.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZV9jq1C0TUh8MbeU@FVFF77S0Q05N.cambridge.arm.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Nov 23, 2023 at 02:37:31PM +0000, Mark Rutland escreveu:
> Hi Ian,
> 
> Thanks for this!

Yeah, it seems we're making progress, thanks for the continuous effort
in getting this fixed!
 
> On Wed, Nov 22, 2023 at 08:29:22PM -0800, Ian Rogers wrote:
> > The perf tool has previously made legacy events the priority so with
> > or without a PMU the legacy event would be opened:

<SNIP> 

> > The bulk of this change is updating all of the parse-events test
> > expectations so that if a sysfs/json event exists for a PMU the test
> > doesn't fail - a further sign, if it were needed, that the legacy
> > event priority was a known and tested behavior of the perf tool.

> > Signed-off-by: Ian Rogers <irogers@google.com>
 
> Regardless of my comments below, for this patch as-is:
 
> Acked-by: Mark Rutland <mark.rutland@arm.com>

I'm collecting this even with the problems in some setups so far, thanks
for providing it.
 
> > ---
> > This is a large behavioral change:
> > 1) the scope of the change means it should bake on linux-next and I
> > don't believe should be a 6.7-rc fix.
> 
> I'm happy for this to bake, but I do think it needs to be backported for the
> sake of users, especially given that it *restores* the old behaviour.
> 
> > 2) a fixes tag and stable backport I don't think are appropriate.
 
> For the sake of users I think a fixes tag and stable backport are necssary. In
> practice distributions ship the perf tool associated with their stable kernel,
> so (for better or worse) a stable backport is certainly necessary for distros
> that'll use the v6.6 stable kernel.

Which, as Ian mentioned, is a common misconception, as the lack of
lockstep of perf/kernel versions was never properly stated in
documentation, only in the source code, look for the
evsel__disable_missing_features() function that tries to do whatever we
managed to do from what was being asked (new features for old kernels)
and the laconic responses from perf_event_open() given back to those
requests.

But the fact is that most if not all distros think perf is in lockstep
with the kernel, which is not the intent.

That said, for distros that do backports, this is one to be done, and
for stable@kernel.org, yeah, I also think this is one to be flagged as
that, but since this hybrid thing has such a miscoordinated
user/kernel/arches history, with such great number of nuances and
interpretations, I think we better continue to test it for a while, in
perf-tools-next/perf-tools-next and linux-next, to the flag it for
backports.
 
> > The real reported issue is with the PMU driver. 
> 
> Having trawled through the driver and core perf code, I don't believe the PMU
> driver is at fault. Please see my analysis at:
> 
>   https://lore.kernel.org/lkml/ZV9gThJ52slPHqlV@FVFF77S0Q05N.cambridge.arm.com/
> 
> ... where it looks like the perf tool is dropping the extended type ID in some
> cases.
 
> If you know of a specific bug in the PMU driver or perf core code, please let
> me know and I will investigate. As it stands we have no evidence of a bug in
> the PMU driver, and pretty clear evidence (as linked above) there there is
> *some* issue in userspace. In the absence of such evidence, please don't assert
> that there must be a kernel bug.
 
> > A backport would bring the
> > risk that later fixes, due to the large behavior change, wouldn't be
> > backported and past releases get regressed in scenarios like
> > hybrid. Backports for the perf tool are also less necessary than say a
> > buggy PMU driver, as distributions should be updating to the latest
> > perf tool regardless of what Linux kernel is being run (the perf tool
> > is backward compatible).

> As above I believe that a backport is necessary.

Agreed, as we get this tested a bit.

- Arnaldo
