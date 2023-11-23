Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3BE37F68A3
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 22:20:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbjKWVPI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 16:15:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjKWVPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 16:15:06 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B8481A5
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 13:15:13 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74259C433C7;
        Thu, 23 Nov 2023 21:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700774112;
        bh=tPDvNTF6lQgs9PwbaY+2NnDjcoV4Bkdql130mx3he5M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IYWXp6jws2n5+lhs66eOrghIpdRqwujIZ0d1v0m7OuQbWAkGnFzuAOJDAIy+C4L1a
         vVU9MhIPf9NzkYY0F0p+lMXkbG2ZIhtjIllki7jNYch4MKxKNU0CMiHgcPALLL/ds/
         1K4AViDU/I3YVTaJiLo5SZFx8CzDtYEQ6kDuWQMxUQzc4rsGGh5B/GR4hlB9ZDD2RT
         mN8kxB5/ANc1tCpPXYb0CF8A63knqKpHYpCgKeU95fgo0kRgDrtzhi4l3FAYoXlKAu
         H65qQOtV14MHk1VZ5ZZrcpkXjQCTm3BqII/mAIamf6txGQHjJSCXebQFsLAv9p4HeX
         5FG6Ri7FNdlaQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id E6BC540094; Thu, 23 Nov 2023 18:15:09 -0300 (-03)
Date:   Thu, 23 Nov 2023 18:15:09 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Hector Martin <marcan@marcan.st>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Ian Rogers <irogers@google.com>, Marc Zyngier <maz@kernel.org>,
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
Message-ID: <ZV/A3YhtMHsZZRQd@kernel.org>
References: <20231123042922.834425-1-irogers@google.com>
 <ac4cf01d-4bb5-4b4d-bd87-bf05ddb67f2d@marcan.st>
 <ZV9fLgHshKGoAPYK@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZV9fLgHshKGoAPYK@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NUMERIC_HTTP_ADDR,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Nov 23, 2023 at 11:18:22AM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Thu, Nov 23, 2023 at 05:45:19PM +0900, Hector Martin escreveu:
> > On 2023/11/23 13:29, Ian Rogers wrote:
> > > The bulk of this change is updating all of the parse-events test
> > > expectations so that if a sysfs/json event exists for a PMU the test
> > > doesn't fail - a further sign, if it were needed, that the legacy
> > > event priority was a known and tested behavior of the perf tool.
> 
> > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > ---
> > > This is a large behavioral change:
> > > 1) the scope of the change means it should bake on linux-next and I
> > > don't believe should be a 6.7-rc fix.
> > > 2) a fixes tag and stable backport I don't think are appropriate. The
> > > real reported issue is with the PMU driver. A backport would bring the
> > > risk that later fixes, due to the large behavior change, wouldn't be
> > > backported and past releases get regressed in scenarios like
> > > hybrid. Backports for the perf tool are also less necessary than say a
> > > buggy PMU driver, as distributions should be updating to the latest
> > > perf tool regardless of what Linux kernel is being run (the perf tool
> > > is backward compatible).
> > 
> > Tested-by: Hector Martin <marcan@marcan.st>
> 
> Thanks, applied locally, doing some tests and then will push for
> linux-next to pick it up.
> 
> Mark, can I have your Reviewed-by or Acked-by?

I'll collect those, but only after addressing these:

[perfbuilder@five ~]$ export BUILD_TARBALL=http://192.168.86.5/perf/perf-6.6.0-rc1.tar.xz
[perfbuilder@five ~]$ time dm
   1   100.09 almalinux:8                   : FAIL clang version 15.0.7 (Red Hat 15.0.7-1.module_el8.8.0+3466+dfcbc058)
    util/parse-events.c:1461:6: error: variable 'alias_rewrote_terms' is used uninitialized whenever '&&' condition is false [-Werror,-Wsometimes-uninitialized]
            if (!parse_state->fake_pmu && perf_pmu__check_alias(pmu, &parsed_terms,
                ^~~~~~~~~~~~~~~~~~~~~~
    util/parse-events.c:1477:6: note: uninitialized use occurs here
            if (alias_rewrote_terms &&
                ^~~~~~~~~~~~~~~~~~~
    util/parse-events.c:1461:6: note: remove the '&&' if its condition is always true
            if (!parse_state->fake_pmu && perf_pmu__check_alias(pmu, &parsed_terms,
                ^~~~~~~~~~~~~~~~~~~~~~~~~
    util/parse-events.c:1401:26: note: initialize the variable 'alias_rewrote_terms' to silence this warning
            bool alias_rewrote_terms;
                                    ^
                                     = false
    1 error generated.
    make[3]: *** [/git/perf-6.6.0-rc1/tools/build/Makefile.build:158: util] Error 2
   2   114.29 almalinux:9                   : FAIL clang version 15.0.7 (Red Hat 15.0.7-2.el9)
    util/parse-events.c:1461:6: error: variable 'alias_rewrote_terms' is used uninitialized whenever '&&' condition is false [-Werror,-Wsometimes-uninitialized]
            if (!parse_state->fake_pmu && perf_pmu__check_alias(pmu, &parsed_terms,
                ^~~~~~~~~~~~~~~~~~~~~~
    util/parse-events.c:1477:6: note: uninitialized use occurs here
            if (alias_rewrote_terms &&
                ^~~~~~~~~~~~~~~~~~~
    util/parse-events.c:1461:6: note: remove the '&&' if its condition is always true
            if (!parse_state->fake_pmu && perf_pmu__check_alias(pmu, &parsed_terms,
                ^~~~~~~~~~~~~~~~~~~~~~~~~
    util/parse-events.c:1401:26: note: initialize the variable 'alias_rewrote_terms' to silence this warning
            bool alias_rewrote_terms;
                                    ^
                                     = false
    1 error generated.
    make[3]: *** [/git/perf-6.6.0-rc1/tools/build/Makefile.build:158: util] Error 2
