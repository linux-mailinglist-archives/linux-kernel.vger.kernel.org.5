Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD1EF7F728F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 12:19:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345844AbjKXLTU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 06:19:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345806AbjKXLTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 06:19:16 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 027D21709;
        Fri, 24 Nov 2023 03:19:21 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E62B61063;
        Fri, 24 Nov 2023 03:20:07 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.42.51])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 201613F7A6;
        Fri, 24 Nov 2023 03:19:17 -0800 (PST)
Date:   Fri, 24 Nov 2023 11:19:11 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
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
Message-ID: <ZWCGr0bYMyfuhGbx@FVFF77S0Q05N>
References: <20231123042922.834425-1-irogers@google.com>
 <ZV9jq1C0TUh8MbeU@FVFF77S0Q05N.cambridge.arm.com>
 <ZV/FA+tGFWkMhXiM@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZV/FA+tGFWkMhXiM@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 23, 2023 at 06:32:51PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Thu, Nov 23, 2023 at 02:37:31PM +0000, Mark Rutland escreveu:
> > Hi Ian,
> > 
> > Thanks for this!
> 
> Yeah, it seems we're making progress, thanks for the continuous effort
> in getting this fixed!
>  
> > On Wed, Nov 22, 2023 at 08:29:22PM -0800, Ian Rogers wrote:
> > > The perf tool has previously made legacy events the priority so with
> > > or without a PMU the legacy event would be opened:
> 
> <SNIP> 
> 
> > > The bulk of this change is updating all of the parse-events test
> > > expectations so that if a sysfs/json event exists for a PMU the test
> > > doesn't fail - a further sign, if it were needed, that the legacy
> > > event priority was a known and tested behavior of the perf tool.
> 
> > > Signed-off-by: Ian Rogers <irogers@google.com>
>  
> > Regardless of my comments below, for this patch as-is:
>  
> > Acked-by: Mark Rutland <mark.rutland@arm.com>
> 
> I'm collecting this even with the problems in some setups so far, thanks
> for providing it.

That's fine by me, thanks!

> > > ---
> > > This is a large behavioral change:
> > > 1) the scope of the change means it should bake on linux-next and I
> > > don't believe should be a 6.7-rc fix.
> > 
> > I'm happy for this to bake, but I do think it needs to be backported for the
> > sake of users, especially given that it *restores* the old behaviour.
> > 
> > > 2) a fixes tag and stable backport I don't think are appropriate.
>  
> > For the sake of users I think a fixes tag and stable backport are necssary. In
> > practice distributions ship the perf tool associated with their stable kernel,
> > so (for better or worse) a stable backport is certainly necessary for distros
> > that'll use the v6.6 stable kernel.
> 
> Which, as Ian mentioned, is a common misconception, as the lack of
> lockstep of perf/kernel versions was never properly stated in
> documentation, only in the source code, look for the
> evsel__disable_missing_features() function that tries to do whatever we
> managed to do from what was being asked (new features for old kernels)
> and the laconic responses from perf_event_open() given back to those
> requests.
> 
> But the fact is that most if not all distros think perf is in lockstep
> with the kernel, which is not the intent.

Sorry, I didn't mean to imply that these were in lockstep.

All I meant was:

(a) Distributions typically ship a stable version of the perf tool, and don't
    update to the latest-and-greatest version, but will take stable bug fixes.
    Basically what they do for every other userspace application they ship.

    Distros with a rolling release policy will update, but they're not the
    common case today.

(b) The tool version that distributions happen to ship is typically the same as
    the kernel version, since packagers will grab them at the same time, and
    they're in the same source tree anyway.

... and hence, if a distro uses kernel v6.6, they are *very* likely to also
pick perf tool version v6.6.

> That said, for distros that do backports, this is one to be done, and
> for stable@kernel.org, yeah, I also think this is one to be flagged as
> that, but since this hybrid thing has such a miscoordinated
> user/kernel/arches history, with such great number of nuances and
> interpretations, I think we better continue to test it for a while, in
> perf-tools-next/perf-tools-next and linux-next, to the flag it for
> backports.

100% agreed!

Thanks,
Mark.
