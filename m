Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35169762334
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 22:23:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbjGYUXG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 16:23:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230391AbjGYUXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 16:23:02 -0400
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8841C1988
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 13:22:59 -0700 (PDT)
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-348d333e441so11408085ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 13:22:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690316579; x=1690921379;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fLbB9A17//JI532awqvSG/Onx8ke8DQvqHXz9kFjeQg=;
        b=gm5Tw27jEKV1Q2osfm8LciA1eQn9Qrkj8mWaEKpiKqiglmuabtqLBMERMmQ5J+9Irt
         x61HSQpj7f2mJD0fbcBzuWRXPQGIMkaKUsdpPpMAIja9v0H8JUJIe8LYzb0nniavaGhb
         8Wk/LiCSAmbhm6XJU5D8xFE6NwcsTdWvL+/5T+3xfO62yWt9IXj3aUnYGRfM7KsNfCBS
         oCUuxCsfO/50KkfxX7awyKpExGEaMpnH/EKlYn88NCtNWEXMWiqRGeHWRerahSG+p9tg
         +PlGEPgPxyK0u3J3WKUysvic4pQhIpc3On1rq7Sr5lTwup1Au2Ut2uE433IkCQAKaHGc
         bPtA==
X-Gm-Message-State: ABy/qLbCbFkOrhMEFGhcT5ZTbZuqFQf9kNTYDkMmWX7qfYxYWZiOAEmP
        /brlEtfH6EyX65RGS7THL64=
X-Google-Smtp-Source: APBJJlGnKFsXM8r8tFdQv4YTv1oUQJZ/aF+DxQ45IVukmL9qW+XFiYFBueJH/uy/MoTKkccHj2ICGQ==
X-Received: by 2002:a92:c56b:0:b0:348:dd94:3449 with SMTP id b11-20020a92c56b000000b00348dd943449mr159545ilj.4.1690316578600;
        Tue, 25 Jul 2023 13:22:58 -0700 (PDT)
Received: from maniforge ([24.1.27.177])
        by smtp.gmail.com with ESMTPSA id e16-20020a92d750000000b00345d2845c42sm3857874ilq.57.2023.07.25.13.22.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 13:22:58 -0700 (PDT)
Date:   Tue, 25 Jul 2023 15:22:55 -0500
From:   David Vernet <void@manifault.com>
To:     "Gautham R. Shenoy" <gautham.shenoy@amd.com>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, kprateek.nayak@amd.com,
        aaron.lu@intel.com, clm@meta.com, tj@kernel.org,
        roman.gushchin@linux.dev, kernel-team@meta.com
Subject: Re: [PATCH v2 0/7] sched: Implement shared runqueue in CFS
Message-ID: <20230725202255.GA13618@maniforge>
References: <20230710200342.358255-1-void@manifault.com>
 <ZLpMGVPDXqWEu+gm@BLR-5CG11610CF.amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZLpMGVPDXqWEu+gm@BLR-5CG11610CF.amd.com>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 21, 2023 at 02:42:57PM +0530, Gautham R. Shenoy wrote:
> Hello David,

Hello Gautham,

Thank you for taking the time to run these benchmarks. Apologies for the
delayed response -- I've been traveling this week.

> On Mon, Jul 10, 2023 at 03:03:35PM -0500, David Vernet wrote:
> > Changes
> > -------
> > 
> > This is v2 of the shared wakequeue (now called shared runqueue)
> > patchset. The following are changes from the RFC v1 patchset
> > (https://lore.kernel.org/lkml/20230613052004.2836135-1-void@manifault.com/).
> > 
> > v1 -> v2 changes:
> > - Change name from swqueue to shared_runq (Peter)
> > 
> > - Sharded per-LLC shared runqueues to avoid contention on
> >   scheduler-heavy workloads (Peter)
> > 
> > - Pull tasks from the shared_runq in newidle_balance() rather than in
> >   pick_next_task_fair() (Peter and Vincent)
> > 
> > - Rename a few functions to reflect their actual purpose. For example,
> >   shared_runq_dequeue_task() instead of swqueue_remove_task() (Peter)
> > 
> > - Expose move_queued_task() from core.c rather than migrate_task_to()
> >   (Peter)
> > 
> > - Properly check is_cpu_allowed() when pulling a task from a shared_runq
> >   to ensure it can actually be migrated (Peter and Gautham)
> > 
> > - Dropped RFC tag
> > 
> > This patch set is based off of commit ebb83d84e49b ("sched/core: Avoid
> > multiple calling update_rq_clock() in __cfsb_csd_unthrottle()") on the
> > sched/core branch of tip.git.
> 
> I have evaluated this v2 patchset on AMD Zen3 and Zen4 servers.
> 
> tldr:
> 
> * We see non-trivial improvements on hackbench on both Zen3 and Zen4
>   until the system is super-overloaded, at which point we see
>   regressions.

This makes sense to me. SHARED_RUNQ is more likely to help performance
when the system is not over-utilized, as it has more of a chance to
actually increase work conservation. If the system is over-utilized,
it's likely that a core will be able to find a task regardless of
whether it looks at the shared runq.

That said, I wasn't able to reproduce the regressions (with --groups 16)
on my 7950X, presumably because it only has 8 cores / CCX.

> * tbench shows regressions on Zen3 with each client
>   configuration. tbench on Zen4 shows some improvements when the system is
>   overloaded.

Hmm, I also observed tbench not performing well with SHARED_RUNQ on my
Zen4 / 7950X, but only with heavy load. It also seems that sharding
helps a lot for tbench on Zen3, whereas Zen4 performs fine without it.
I'm having trouble reasoning about why Zen4 wouldn't require sharding
whereas Zen3 would given that Zen4 has more cores per CCX.

Just to verify -- these benchmarks were run with boost disabled,
correct? Otherwise, there could be a lot of run-to-run variance
depending on thermal throttling.

> 
> * netperf shows minor improvements on Zen3 when the system is under
>   low to moderate load. netperf regresses on Zen3 at high load, and at
>   all load-points on Zen4.

netperf in general seems to regress as the size of the LLC inreases due
to it relentlessly hammering the runqueue, though it's still surprising
to me that your Zen4 test showed regressions under low / moderate load
as well. Was this with -t TCP_RR, or -t UDP_RR? I observed SHARED_RUNQ
improving performance on my 7950X for -t TCP_RR as described on [0], so
I'd be curious to better understand where the slowdowns are coming from
(presumably it's just contending on the shard lock due to having a
larger CCX?)

[0]: https://lore.kernel.org/all/20230615000103.GC2883716@maniforge/

> * Stream, SPECjbb2015 and Mongodb show no significant difference compared
>   to the current tip.
> 
> * With netperf and tbench, using the shared-runqueue during
>   enqueue_entity performs badly.

My reading of your Zen4 numbers on tbench seem to imply that it actually
performs well under heavy load. Copying here for convenience:

Zen4, 2 Sockets, 128 cores per socket, SMT2:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Clients:    tip[pct imp](CV)       swqueue[pct imp](CV)     noshard[pct imp](CV)    shard_wakeup[pct imp](CV)   shard_all[pct imp](CV)
    1     1.00 [  0.00]( 0.19)     0.98 [ -1.72]( 0.19)     0.99 [ -1.15]( 0.28)     0.98 [ -1.79]( 0.28)     0.99 [ -1.49]( 0.10)
    2     1.00 [  0.00]( 0.63)     0.98 [ -2.28]( 0.63)     0.98 [ -1.91]( 0.26)     0.97 [ -3.14]( 0.25)     0.98 [ -1.77]( 0.32)
    4     1.00 [  0.00]( 0.22)     1.00 [  0.00]( 1.13)     0.99 [ -0.69]( 0.57)     0.98 [ -1.59]( 0.35)     0.99 [ -0.64]( 0.18)
    8     1.00 [  0.00]( 1.14)     0.99 [ -0.73]( 0.61)     0.98 [ -2.28]( 2.61)     0.97 [ -2.56]( 0.34)     0.98 [ -1.77]( 0.70)
   16     1.00 [  0.00]( 0.98)     0.97 [ -2.54]( 1.24)     0.98 [ -1.71]( 1.86)     0.98 [ -1.53]( 0.62)     0.96 [ -3.56]( 0.93)
   32     1.00 [  0.00]( 0.76)     0.98 [ -2.31]( 1.35)     0.98 [ -2.06]( 0.77)     0.96 [ -3.53]( 1.63)     0.88 [-11.72]( 2.77)
   64     1.00 [  0.00]( 0.96)     0.96 [ -4.45]( 3.53)     0.97 [ -3.44]( 1.53)     0.96 [ -3.52]( 0.89)     0.31 [-69.03]( 0.64)
  128     1.00 [  0.00]( 3.03)     0.95 [ -4.78]( 0.56)     0.98 [ -2.48]( 0.47)     0.92 [ -7.73]( 0.16)     0.20 [-79.75]( 0.24)
  256     1.00 [  0.00]( 0.04)     0.93 [ -7.21]( 1.00)     0.94 [ -5.90]( 0.63)     0.59 [-41.29]( 1.76)     0.16 [-83.71]( 0.07)
  512     1.00 [  0.00]( 3.08)     1.07 [  7.07](17.78)     1.15 [ 15.49]( 2.65)     0.82 [-17.53](29.11)     0.93 [ -7.18](32.23)
 1024     1.00 [  0.00]( 0.60)     1.16 [ 15.61]( 0.07)     1.16 [ 15.92]( 0.06)     1.12 [ 11.57]( 1.86)     1.12 [ 11.97]( 0.21)
 2048     1.00 [  0.00]( 0.16)     1.15 [ 14.62]( 0.90)     1.15 [ 15.20]( 0.29)     1.08 [  7.64]( 1.44)     1.15 [ 14.57]( 0.23)

 I'm also struggling to come up for an explanation for why Zen4 would
 operate well with SHARED_RUNQ under heavy load. Do you have a theory?

> Server configurations used:
> 
> AMD Zen3 Server:
>   * 2 sockets,
>   * 64 cores per socket,
>   * SMT2 enabled
>   * Total of 256 threads.
>   * Configured in Nodes-Per-Socket(NPS)=1
> 
> AMD Zen4 Server:
>   * 2 sockets,
>   * 128 cores per socket,
>   * SMT2 enabled
>   * Total of 512 threads.
>   * Configured in Nodes-Per-Socket(NPS)=1
>
> The trends on NPS=2 and NPS=4 are similar. So I am not posting those.
> 
> 
> Legend:
> tip           : Tip kernel with top commit ebb83d84e49b
>                 ("sched/core: Avoid multiple calling update_rq_clock() in __cfsb_csd_unthrottle()")
> 
> swqueue_v1    : Your v1 patches applied on top of the aforemenioned tip commit.
> 
> noshard       : shared-runqueue v2 patches 1-5. This uses a shared-runqueue
>                 during wakeup. No sharding.
> 
> shard_wakeup  : shared-runqueue v2 patches 1-6. This uses a
>                 shared-runqueue during wakeup and has shards with
>                 shard size = 6 (default)
> 
> shard_all     : v2 patches 1-7. This uses a sharded shared-runqueue during
>                 enqueue_entity

So, what's your overall impression from these numbers? My general
impression so far is the following:

- SHARED_RUNQ works best when the system would otherwise be
  under-utilized. If the system is going to be overloaded, it's unlikely
  to provide a significant benefit over CFS, and may even just add
  overhead with no benefit (or just cause worse cache locality).

- SHARED_RUNQ isn't well-suited to workloads such as netperf which
  pummel the scheduler. Sharding helps a lot here, but doesn't
  completely fix the problem depending on how aggressively tasks are
  hammering the runqueue.

- To the point above, using SHARED_RUNQ in __enqueue_entity() /
  __dequeue_entity(), rather than just on the wakeup path, is a net
  positive. Workloads which hammer the runq such as netperf or schbench
  -L -m 52 -p 512 -r 10 -t 1 will do poorly in both scenarios, so we may
  as well get the better work conservation from __enqueue_entity() /
  __dequeue_entity(). hackbench is one example of a workload that
  benefits from this, another is kernel compile, and I strongly suspect
  that HHVM would similarly benefit.

- Sharding in general doesn't seem to regress performance by much when
  it wouldn't have otherwise been necessary to avoid contention.
  hackbench is better without sharding on Zen3, but it's also better
  with shard_all on Zen4.

  In general, if our goal is to better support hosts with large CCXs, I
  think we'll just need to support sharding.

Thoughts?

I have the v3 version of the patch set which properly supports domain
recreation and hotplug, but I still need to get updated benchmark
numbers on it, as well as benchmark spreading a shared_runq over
multiple CCXs per Peter's comment in [1] about the initial motivation
behind SIS_NODE also applying to SHARED_RUNQ.

[1]: https://lore.kernel.org/all/20230711114207.GK3062772@hirez.programming.kicks-ass.net/

Given the points above, I would ideally like to just run the shard_all
variant and compare that to the numbers I collected on v2 and shared in
[2]. What do you think? There will be tradeoffs no matter what we choose
to do, but enqueuing / dequeuing in __enqueue_entity() /
__dequeue_entity() seems to perform the best for workloads that don't
hammer the runqueue, and sharding seems like a given if we do decide to
do that.

[2]: https://lore.kernel.org/all/20230710200342.358255-1-void@manifault.com/

Thanks,
David
