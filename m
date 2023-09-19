Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC9897A68C0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 18:22:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230428AbjISQW1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 12:22:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230140AbjISQWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 12:22:25 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A09992
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 09:22:19 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 18D021FF1F;
        Tue, 19 Sep 2023 16:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1695140538; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MC+JHQJP/UJgkt5cAuu5TRDiLruWte3ZcfF2ooddP/Q=;
        b=xmrTLeP9VBtcgsFHYXtZ383jUd74HqXDD+JgvGkyOIyf6Pn80YYcnB80bgu5E3msKNeOoj
        oCBJv5jEzrYllmNRpFvcMItPg4EfXqZMqTua3BOpPAi0xk3xHxTkvUfVXnbZxaylW8GJrQ
        7ZKlHrBrm1Z0iQbMrlUlnDMG2GVmAGc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1695140538;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MC+JHQJP/UJgkt5cAuu5TRDiLruWte3ZcfF2ooddP/Q=;
        b=gM21GB3YZ82iZ/tB0m6kqX/iCXHZlSullO1K2g7k3aOZIl7MgT0Ic9iCVg3seE+mWJq9ty
        x47YvKqD/hmyy5Bw==
Received: from suse.de (mgorman.tcp.ovpn2.nue.suse.de [10.163.32.246])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id E7FD02C15C;
        Tue, 19 Sep 2023 16:22:16 +0000 (UTC)
Date:   Tue, 19 Sep 2023 17:22:15 +0100
From:   Mel Gorman <mgorman@suse.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Raghavendra K T <raghavendra.kt@amd.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>, rppt@kernel.org,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Bharata B Rao <bharata@amd.com>,
        Aithal Srikanth <sraithal@amd.com>,
        kernel test robot <oliver.sang@intel.com>,
        Sapkal Swapnil <Swapnil.Sapkal@amd.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>
Subject: Re: [RFC PATCH V1 0/6] sched/numa: Enhance disjoint VMA scanning
Message-ID: <20230919162215.2cszdylo2skevnr6@suse.de>
References: <cover.1693287931.git.raghavendra.kt@amd.com>
 <20230919092830.GF21729@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20230919092830.GF21729@noisy.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 19, 2023 at 11:28:30AM +0200, Peter Zijlstra wrote:
> On Tue, Aug 29, 2023 at 11:36:08AM +0530, Raghavendra K T wrote:
> 
> > Peter Zijlstra (1):
> >   sched/numa: Increase tasks' access history
> > 
> > Raghavendra K T (5):
> >   sched/numa: Move up the access pid reset logic
> >   sched/numa: Add disjoint vma unconditional scan logic
> >   sched/numa: Remove unconditional scan logic using mm numa_scan_seq
> >   sched/numa: Allow recently accessed VMAs to be scanned
> >   sched/numa: Allow scanning of shared VMAs
> > 
> >  include/linux/mm.h       |  12 +++--
> >  include/linux/mm_types.h |   5 +-
> >  kernel/sched/fair.c      | 109 ++++++++++++++++++++++++++++++++-------
> >  3 files changed, 102 insertions(+), 24 deletions(-)
> 
> So I don't immediately see anything horrible with this. Mel, do you have
> a few cycles to go over this as well?

I've been trying my best to find the necessary time and it's still on my
radar for this week. Preliminary results don't look great for the first part
of the series up to the patch "sched/numa: Add disjoint vma unconditional
scan logic" even though other reports indicate the performance may be
fixed up later in the series. For example

autonumabench
                                   6.5.0-rc6              6.5.0-rc6
                         sched-pidclear-v1r5   sched-forcescan-v1r5
Min       syst-NUMA02        1.94 (   0.00%)        1.38 (  28.87%)
Min       elsp-NUMA02       12.67 (   0.00%)       21.02 ( -65.90%)
Amean     syst-NUMA02        2.35 (   0.00%)        1.86 (  21.13%)
Amean     elsp-NUMA02       12.93 (   0.00%)       21.69 * -67.76%*
Stddev    syst-NUMA02        0.54 (   0.00%)        0.90 ( -67.67%)
Stddev    elsp-NUMA02        0.18 (   0.00%)        0.44 (-144.19%)
CoeffVar  syst-NUMA02       22.82 (   0.00%)       48.50 (-112.58%)
CoeffVar  elsp-NUMA02        1.38 (   0.00%)        2.01 ( -45.56%)
Max       syst-NUMA02        3.15 (   0.00%)        3.89 ( -23.49%)
Max       elsp-NUMA02       13.16 (   0.00%)       22.36 ( -69.91%)
BAmean-50 syst-NUMA02        2.01 (   0.00%)        1.45 (  27.69%)
BAmean-50 elsp-NUMA02       12.77 (   0.00%)       21.34 ( -67.04%)
BAmean-95 syst-NUMA02        2.22 (   0.00%)        1.52 (  31.68%)
BAmean-95 elsp-NUMA02       12.89 (   0.00%)       21.58 ( -67.39%)
BAmean-99 syst-NUMA02        2.22 (   0.00%)        1.52 (  31.68%)
BAmean-99 elsp-NUMA02       12.89 (   0.00%)       21.58 ( -67.39%)

                   6.5.0-rc6   6.5.0-rc6
                sched-pidclear-v1r5sched-forcescan-v1r5
Duration User        5702.00    10264.25
Duration System        17.02       13.59
Duration Elapsed       92.57      156.30

Similar results seen across multiple machines. It's not universally bad
but the NUMA02 tests appear to suffer quite badly and while not realistic,
they are somewhat relevant because numa02 is likely an "adverse workload"
for the logic that skips VMAs based on PID accesses.

For the rest of the series, the changelogs lacked detail on why those
changes helped. Patch 4's changelog lacks detail and patch 6 stating
"VMAs being accessed by more than two tasks are critical" is not helpful
either -- e.g. why are they critical? They are obviously shared VMAs and
therefore it may be the case that they need to be identified and interleaved
quickly but maybe not. Is the shared VMA that is critical a large malloc'd
area split into per-thread sections or something that is MAP_SHARED? The
changelog doesn't say so I have to guess. There are also a bunch of
magic variables with limited explanation (e.g. why NR_ACCESS_PID_HIST==4
and SHARED_VMA_THRESH=3?), the numab fields are not documented and the
changelogs lack supporting data. I suspect that patches 3-6 may be dealing
with regressions introduced by patch 2, particularly for NUMA02, but I'm
not certain as I didn't dedicate the necessary test time to prove that
and it's the type of information that should be in the changelog. While
there is nothing wrong with that as such, it's very hard to imagine how
patches 3-6 work in every case and be certain that the various parameters
make sense. That could cause difficulties later in terms of maintenance.

My initial thinking was "There should be a standalone series that deals
*only* with scanning VMAs that had no fault activity and skipped due to
PID hashing". These are important because there may be no fault activity
because there is no scan activity which is due to to fault activity. The
series is incomplete and without changelogs but I pushed it anyway to

https://git.kernel.org/pub/scm/linux/kernel/git/mel/linux.git/ sched-numabselective-v1r5

The first two patches simply improve the documentation on what is going
on, patch 3 adds a tracepoint for figuring out why VMAs were skipped or
not skipped. Patch 4 handles a corner case to complete the scan of a VMA
once it has started regardless of what task is doing the scanning. The
last patch scans VMAs that have seen no fault activity once active VMAs
have been scanned.

It has its weaknesses because it may be overly simplisitic and it forces
all VMAs to be scanned on every sequence which is wasteful. It also hurts
NUMA02 performance, although not as badly as ""sched/numa: Add disjoint
vma unconditional scan logic". On the plus side, it is easier to reason
about, it solves only one problem in the series and any patch on top or
modification should justify each change individually.

-- 
Mel Gorman
SUSE Labs
