Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DEE67BF80C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 11:58:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230282AbjJJJ6J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 05:58:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbjJJJ6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 05:58:08 -0400
Received: from outbound-smtp11.blacknight.com (outbound-smtp11.blacknight.com [46.22.139.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9FE5B9
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 02:57:58 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
        by outbound-smtp11.blacknight.com (Postfix) with ESMTPS id DAFFB1C4318
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 10:57:56 +0100 (IST)
Received: (qmail 2492 invoked from network); 10 Oct 2023 09:57:56 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.197.19])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 10 Oct 2023 09:57:56 -0000
Date:   Tue, 10 Oct 2023 10:57:52 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Raghavendra K T <raghavendra.kt@amd.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Bharata B Rao <bharata@amd.com>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH 6/6] sched/numa: Complete scanning of inactive VMAs when
 there is no alternative
Message-ID: <20231010095752.yueqcseg7p3xg5ui@techsingularity.net>
References: <20231010083143.19593-1-mgorman@techsingularity.net>
 <20231010083143.19593-7-mgorman@techsingularity.net>
 <ZSUX9NLa+DDjFLnZ@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <ZSUX9NLa+DDjFLnZ@gmail.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2023 at 11:23:00AM +0200, Ingo Molnar wrote:
> 
> * Mel Gorman <mgorman@techsingularity.net> wrote:
> 
> > On a 2-socket Cascade Lake test machine, the time to complete the
> > workload is as follows;
> > 
> >                                                6.6.0-rc2              6.6.0-rc2
> >                                      sched-numabtrace-v1 sched-numabselective-v1
> > Min       elsp-NUMA01_THREADLOCAL      174.22 (   0.00%)      117.64 (  32.48%)
> > Amean     elsp-NUMA01_THREADLOCAL      175.68 (   0.00%)      123.34 *  29.79%*
> > Stddev    elsp-NUMA01_THREADLOCAL        1.20 (   0.00%)        4.06 (-238.20%)
> > CoeffVar  elsp-NUMA01_THREADLOCAL        0.68 (   0.00%)        3.29 (-381.70%)
> > Max       elsp-NUMA01_THREADLOCAL      177.18 (   0.00%)      128.03 (  27.74%)
> > 
> > The time to complete the workload is reduced by almost 30%
> > 
> >                    6.6.0-rc2   6.6.0-rc2
> >                 sched-numabtrace-v1 sched-numabselective-v1 /
> > Duration User       91201.80    63506.64
> > Duration System      2015.53     1819.78
> > Duration Elapsed     1234.77      868.37
> > 
> > In this specific case, system CPU time was not increased but it's not
> > universally true.
> > 
> > From vmstat, the NUMA scanning and fault activity is as follows;
> > 
> >                                       6.6.0-rc2      6.6.0-rc2
> >                             sched-numabtrace-v1 sched-numabselective-v1
> > Ops NUMA base-page range updates       64272.00    26374386.00
> > Ops NUMA PTE updates                   36624.00       55538.00
> > Ops NUMA PMD updates                      54.00       51404.00
> > Ops NUMA hint faults                   15504.00       75786.00
> > Ops NUMA hint local faults %           14860.00       56763.00
> > Ops NUMA hint local percent               95.85          74.90
> > Ops NUMA pages migrated                 1629.00     6469222.00
> > 
> > Both the number of PTE updates and hint faults is dramatically
> > increased. While this is superficially unfortunate, it represents
> > ranges that were simply skipped without the patch. As a result
> > of the scanning and hinting faults, many more pages were also
> > migrated but as the time to completion is reduced, the overhead
> > is offset by the gain.
> 
> Nice! I've applied your series to tip:sched/core with a few non-functional 
> edits to comment/changelog formatting/clarity.
> 

Thanks.

> Btw., was any previous analysis done on the size of the pids_active[] hash
> and the hash collision rate?
> 

Not that I'm aware of but I also think it would be difficult to design
something representative in terms of a benchmark. New pids are typically
sequential so most benchmarks are not going to show many collisions
unless the hash algorithm ignores lower bits. Maybe it does, I didn't
actually check the hash algorithm and if it does, that is likely the patch
justification right there -- threads created at similar times are almost
certain to collide). As it was Peter that suggested the hash, I assumed
he considered collisions due to lower bits but that is also lazy on my part.

If lower bits are used then it would pose the question -- does it
matter? The intent of the bitmap is for threads to prefer updating PTEs
within task-active VMAs but ultimately all VMAs should be scanned anyway so
some overhead will be usless. While collisions may occur, it's still better
than scanning within VMAs that are definitely *not* of interest. It would
suggest that a sensible direction would be to scan in passes like load
balancing uses fbq_type in find_busiest_queue() to filter what types of
tasks should be considered for moving. So, maybe the passes would look like

	1. Task-active
	2. Multiple tasks active
	3. Any task active
	4. Inactive

The objective would be that PTE updates are as relevant as possible
and hopefully by the time only inactive VMAs are considered, there is a
relatively small amount of wasted work.

> 64 (BITS_PER_LONG) feels a bit small, especially on larger machines running 
> threaded workloads, and the kmalloc of numab_state likely allocates a full 
> cacheline anyway, so we could double the hash size from 8 bytes (2x1 longs) 
> to 32 bytes (2x2 longs) with very little real cost, and still have a long 
> field left to spare?
> 

You're right, we could and it's relatively cheap. I would worry that as the
storage overhead is per-VMA then workloads for large machines may also have
lots of VMAs that are not necessarily using threads. As I would struggle
to provide supporting data justifying the change, I would also be hesitant
to try merging it because if I was reviewing the patch for someone else,
the first question I would ask is "is there any performance benefit that
you can show?". I would expect the first patch would provide some
telemetry and the patch some justification.

-- 
Mel Gorman
SUSE Labs
