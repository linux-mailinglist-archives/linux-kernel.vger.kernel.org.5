Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 079BC80F3D2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 17:58:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232739AbjLLQ6p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 11:58:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232836AbjLLQ63 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 11:58:29 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A4CA10A
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 08:58:29 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE528C433C7;
        Tue, 12 Dec 2023 16:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702400309;
        bh=rrQWZ1A81N+xvoxlWniD06E/uf4RebN93UVgpZ9UCHo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pz2u2JcWtMwrPBOxKXqS5CSu0XZDIJUcpx3rew6Rr5hah/eToJesFI+2XOrGEDrph
         Hftk7ZjYlwGRt9zGLEuqNKf21wO467cTLOLd790xfH0pmuTvecSD55jIjyiEj49naE
         a+1hOcPS36IFSosaWqE+aEKOG+ZzuswY4aHCyQh1O93jUn0ZgSemYf6uXQpNCR75ky
         U1cE6O1Ed6Q0PPLZZd+KHL7g1D9CdShda9XpscBudBV1zUdJ9JrBNEmZ084BczjbtS
         GK43eSBRssOGNo474ZWtDxByhyO7ZQJTc1GcWofm/Ypn0khu15KYsWv0O6dyIcXqlE
         PJGPdUKvmpScg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id CAD74403EF; Tue, 12 Dec 2023 13:58:24 -0300 (-03)
Date:   Tue, 12 Dec 2023 13:58:24 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     irogers@google.com, namhyung@kernel.org, mark.rutland@arm.com,
        maz@kernel.org, marcan@marcan.st, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf top: Use evsel's cpus to replace user_requested_cpus
Message-ID: <ZXiRMDJpz3l27u7g@kernel.org>
References: <20231208210855.407580-1-kan.liang@linux.intel.com>
 <ZXd7ZuxbNNsjAyqm@kernel.org>
 <07677ab2-c29b-499b-b473-f7535fb27a8c@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07677ab2-c29b-499b-b473-f7535fb27a8c@linux.intel.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Dec 12, 2023 at 10:56:15AM -0500, Liang, Kan escreveu:
> 
> 
> On 2023-12-11 4:13 p.m., Arnaldo Carvalho de Melo wrote:
> > Em Fri, Dec 08, 2023 at 01:08:55PM -0800, kan.liang@linux.intel.com escreveu:
> >> From: Kan Liang <kan.liang@linux.intel.com>
> >>
> >> perf top errors out on a hybrid machine
> >>  $perf top
> >>
> >>  Error:
> >>  The cycles:P event is not supported.
> >>
> >> The user_requested_cpus may contain CPUs that are invalid for a hybrid
> >> PMU. It causes perf_event_open to fail.

> > ?

> > All perf top expects is that the "cycles", the most basic one, be
> > collected, on all CPUs in the system.
 
> Yes, but for hybrid there is no single "cycles" event which can cover
> all CPUs. Perf has to split it into two cycles events, cpu_core/cycles/
> and cpu_atom/cycles/. Each event has its own CPU mask. If a event is
> opened on the unsupported CPU. The open fails. That's the reason perf
> top fails. So perf should only open the cycles event on the
> corresponding CPU.

Great explanation, please make sure it is present in the fix, i.e. in
the v2 you mentioned.
 
> >> The commit ef91871c960e ("perf evlist: Propagate user CPU maps
> >> intersecting core PMU maps") already intersect the requested CPU map
> >> with the CPU map of the PMU. Use the evsel's cpus to replace
> >> user_requested_cpus.
> >  
> >> The evlist's threads is also propagated to evsel's threads in
> >> __perf_evlist__propagate_maps(). Replace it as well.
> > 
> > Thanks, but please try to add more detail to the fix so as to help
> > others to consider looking at the patch.
> 
> OK. For the threads, the same as other tools, e.g., perf record, perf
> appends a dummy for the system wide event. For a per-thread event, the
> evlist's thread_map is assigned to the evsel. So using the evsel's
> threads is appropriate and also be consistent with other tools.
> 
> I will update the description and send a V2.
> 
> Thanks,
> Kan
> 
> > 
> > - Arnaldo
> >  
> >> Reported-by: Arnaldo Carvalho de Melo <acme@kernel.org>
> >> Closes: https://lore.kernel.org/linux-perf-users/ZXNnDrGKXbEELMXV@kernel.org/
> >> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> >> ---
> >>  tools/perf/builtin-top.c | 4 ++--
> >>  1 file changed, 2 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
> >> index ea8c7eca5eee..cce9350177e2 100644
> >> --- a/tools/perf/builtin-top.c
> >> +++ b/tools/perf/builtin-top.c
> >> @@ -1027,8 +1027,8 @@ static int perf_top__start_counters(struct perf_top *top)
> >>  
> >>  	evlist__for_each_entry(evlist, counter) {
> >>  try_again:
> >> -		if (evsel__open(counter, top->evlist->core.user_requested_cpus,
> >> -				     top->evlist->core.threads) < 0) {
> >> +		if (evsel__open(counter, counter->core.cpus,
> >> +				counter->core.threads) < 0) {
> >>  
> >>  			/*
> >>  			 * Specially handle overwrite fall back.
