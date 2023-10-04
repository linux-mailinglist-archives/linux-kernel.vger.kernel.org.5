Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E09697B8656
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 19:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243667AbjJDRUu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 13:20:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243549AbjJDRUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 13:20:47 -0400
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE3DAAB
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 10:20:42 -0700 (PDT)
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6910ea9cca1so15942b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 10:20:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696440042; x=1697044842;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BaVmt+sdZ9mzT5K2J9b2cOih+7n13Ec+vZEIlI58tVI=;
        b=Bn1SveTe1RshP1eB9nnot3friERgGe7TcuJfAuKsBazOo5ETBiyKLqIFvgV3odXOLX
         33nmY1n1ZmtV0cMr61WZGejjN8PZ6ARudsDgwDUBSDqTL6krSPAI1fuiqCEC5V3vgRfJ
         45Bylsn2TQJZar5SFDHlCSroHXFGJyuJ1ap7IPCcpdPdtf/gHo/R9rC5RU7qUDxeIRTF
         poExe3j/0Mohecd/7aDxisrL1UFxfCwp+QzGp+VR6ZLyUm4xHzeCyUmnVjb3Vtyt0Jns
         vC/NOUIkUa7PFVptsD/qnIvQNJMi0sNJsWqIVpQopYuVbwNoviKW9Cvby9uLobfINsSv
         WfAg==
X-Gm-Message-State: AOJu0YyYAuVxOrjOZGT+rDw1SR/P2NAooX9hYAYg0V8BVj6FX036A3AT
        8R/5FKhd0MzvGxdjVpEDcX0=
X-Google-Smtp-Source: AGHT+IE+L9nEmwyVfPW0NiFtvHHOp7xp+416IqhHxVwrcLjt/pP7LKaJA0+mJgwq0T8gRgm3IuRdeA==
X-Received: by 2002:a05:6a00:1acb:b0:68f:d554:a299 with SMTP id f11-20020a056a001acb00b0068fd554a299mr3096645pfv.10.1696440042081;
        Wed, 04 Oct 2023 10:20:42 -0700 (PDT)
Received: from maniforge ([2620:10d:c090:400::4:3ce7])
        by smtp.gmail.com with ESMTPSA id e17-20020a62ee11000000b00692cac7a065sm3466247pfi.151.2023.10.04.10.20.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 10:20:41 -0700 (PDT)
Date:   Wed, 4 Oct 2023 12:20:36 -0500
From:   David Vernet <void@manifault.com>
To:     K Prateek Nayak <kprateek.nayak@amd.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, tj@kernel.org,
        roman.gushchin@linux.dev, gautham.shenoy@amd.com,
        aaron.lu@intel.com, wuyun.abel@bytedance.com, kernel-team@meta.com
Subject: Re: [RFC PATCH 3/3] sched/fair: Add a per-shard overload flag
Message-ID: <20231004172036.GC30978@maniforge>
References: <31aeb639-1d66-2d12-1673-c19fed0ab33a@amd.com>
 <20230831104508.7619-1-kprateek.nayak@amd.com>
 <20230831104508.7619-4-kprateek.nayak@amd.com>
 <20230831191103.GC531917@maniforge>
 <350639fb-a428-7d94-b13b-7a33e68b7b09@amd.com>
 <20230929170104.GA78641@maniforge>
 <925f13cd-b020-a799-3505-b3df46a51ffe@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <925f13cd-b020-a799-3505-b3df46a51ffe@amd.com>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 04, 2023 at 09:51:18AM +0530, K Prateek Nayak wrote:
> Hello David,

Hello Prateek,

> 
> Thank you for answering my queries, I'll leave some data below to
> answer yours.
> 
> On 9/29/2023 10:31 PM, David Vernet wrote:
> > On Fri, Sep 01, 2023 at 01:53:12AM +0530, K Prateek Nayak wrote:
> >> Hello David,
> >>
> >> On 9/1/2023 12:41 AM, David Vernet wrote:
> >>> On Thu, Aug 31, 2023 at 04:15:08PM +0530, K Prateek Nayak wrote:
> >>>
> >>> Hi Prateek,
> >>>
> >>>> Even with the two patches, I still observe the following lock
> >>>> contention when profiling the tbench 128-clients run with IBS:
> >>>>
> >>>>   -   12.61%  swapper          [kernel.vmlinux]         [k] native_queued_spin_lock_slowpath
> >>>>      - 10.94% native_queued_spin_lock_slowpath
> >>>>         - 10.73% _raw_spin_lock
> >>>>            - 9.57% __schedule
> >>>>                 schedule_idle
> >>>>                 do_idle
> >>>>               + cpu_startup_entry
> >>>>            - 0.82% task_rq_lock
> >>>>                 newidle_balance
> >>>>                 pick_next_task_fair
> >>>>                 __schedule
> >>>>                 schedule_idle
> >>>>                 do_idle
> >>>>               + cpu_startup_entry
> >>>>
> >>>> Since David mentioned rq->avg_idle check is probably not the right step
> >>>> towards the solution, this experiment introduces a per-shard
> >>>> "overload" flag. Similar to "rq->rd->overload", per-shard overload flag
> >>>> notifies of the possibility of one or more rq covered in the shard's
> >>>> domain having a queued task. shard's overload flag is set at the same
> >>>> time as "rq->rd->overload", and is cleared when shard's list is found
> >>>> to be empty.
> >>>
> >>> I think this is an interesting idea, but I feel that it's still working
> >>> against the core proposition of SHARED_RUNQ, which is to enable work
> >>> conservation.
> >>
> >> I don't think so! Work conservation is possible if there is an
> >> imbalance. Consider the case where we 15 tasks in the shared_runq but we
> >> have 16 CPUs, 15 of which are running these 15 tasks, and one going
> > 
> > I'm not sure I'm fully following. Those 15 tasks would not be enqueued
> > in the shared runq if they were being run. They would be dequeued from
> > the shared_runq in __dequeue_entity(), which would be called from
> > set_next_entity() before they were run. In this case, the
> > shard->overload check should be equivalent to the
> > !list_empty(&shard->list) check.
> > 
> > Oh, or is the idea that we're not bothering to pull them from the
> > shared_runq if they're being woken up and enqueued on an idle core that
> > will immediately run them on the next resched path? If so, I wonder if
> > we would instead just want to not enqueue the task in the shared_runq at
> > all? Consider that if another task comes in on an rq with
> > rq->nr_running >= 2, that we still wouldn't want to pull the tasks that
> > were being woken up on idle cores (nor take the overhead of inserting
> > and then immediately removing them from the shared_runq).

Friendly ping on this point. This is the only scenario where I could see
the overload check helping, so I want to make sure I'm understanding it
and am correct in that just avoiding enqueueing the task in the shard in
this scenario would give us the same benefit.

> So this is the breakdown of outcomes after peeking into the shared_runq
> during newidle_balance:
> 
>                                                 SHARED_RUNQ                     SHARED_RUNQ
>                                         + correct cost accounting       + correct cost accounting
>                                                                         + rq->avg_idle early bail
> 
> tbench throughput (normalized)		:	     1.00			2.47	       (146.84%)
> 
> attempts                                :       6,560,413                  2,273,334           (-65.35%)
> shared_runq was empty                   :       2,276,307 [34.70%]         1,379,071 [60.66%]  (-39.42%)
> successful at pulling task              :       2,557,158 [38/98%]           342,839 [15.08%]  (-86.59%)
> unsuccessful despite fetching task      :       1,726,948 [26.32%]           551,424 [24.26%]  (-68.06%)
> 
> As you can see, there are more attempts and a greater chance of success
> in the case without the rq->avg_idle check upfront. Where the problem
> lies (at least what I believe is) a task is waiting to be enqueued / has
> been enqueued while we are trying to migrate a task fetched from the
> shared_runq. Thus, instead of just being idle for a short duration and
> running the task, we are now making it wait till we fetch another task
> onto the CPU.
>
> I think the scenario changes as follows with shared_runq:
> 
> - Current
> 
> 
>       [Short Idling]	[2 tasks]                        [1 task]	[2 tasks]
> 	+-------+	+-------+                       +-------+	+-------+
> 	|	|	|	|        wakeup         |	|	|	|
> 	| CPU 0 |	| CPU 1 |	 on CPU0        | CPU 0 |	| CPU 1 |
> 	|	|	|	|       -------->       |	|	|	|
> 	+-------+	+-------+                       +-------+	+-------+
> 
> - With shared_runq
> 
>       [pull from CPU1]	[2 tasks]                       [2 tasks]	[1 task]
> 	+-------+	+-------+                       +-------+	+-------+
> 	|	|	|	|        wakeup         |	|	|	|
> 	| CPU 0 |	| CPU 1 |	 on CPU0        | CPU 0 |	| CPU 1 |
> 	|	|	|	|       -------->       |	|	|	|
> 	+-------+	+-------+                       +-------+	+-------+
> 
> We reach a similar final state but with shared_runq we've paid a price
> for task migration. Worst case, the following timeline can happen:
> 
>         |
>   CPU0  | [T0 R, T1 Q] [       T0 R      ] [newidle_balance] [T4 R ...
>         |
>         |                  pull T1 \             pull T4 /
>         |
>   CPU1  | [T3 R] [newidle_balance] [T1 R, T4 Q] [       T1 R      ]
>         |            [T4 TTWU]
>         |
> 
> With the rq->avg_idle bailout, it might end up looking like:
> 
>         |
>   CPU0  | [          T0 R, T1 Q          ] [T1 R ...
>         |
>         |
>   CPU1  | [T3 R] [ I ] [T4 R ...
>         |            
>         |

This certainly seems possible, and wouldn't be terribly surprising or
unexpected. Taking a step back here, I want to be clear that I do
understand the motivation for including the rq->avg_idle check for
SHARED_RUNQ; even just conceptually, and regardless of the numbers you
and others have observed for workloads that do these short sleeps. The
whole idea behind that check is that we want to avoid doing
newidle_balance() if the overhead of doing newidle_balance() would
exceed the amount of time that a task was blocked. Makes sense. Why
would you take the overhead of balancing if you have reason to believe
that a task is likely to be idle for less time than it takes to do a
migration?

There's certainly a reasonable argument for why that should also apply
to SHARED_RUNQ. If the overhead of doing a SHARED_RUNQ migration is
greater than the amount of time that an sd is expected to be idle, then
it's not worth bothering with SHARED_RUNQ either. On the other hand, the
claim of SHARED_RUNQ is that it's faster than doing a regular balance
pass, because we're doing an O(# shards) iteration to find tasks (before
sharding it was O(1)), rather than O(# CPUs). So if we also do the
rq->avg_idle check, that basically means that SHARED_RUNQ becomes a
cache for a full load_balance() call.

Maybe that makes sense and is ultimately the correct design /
implementation for the feature. I'm not fundamentally opposed to that,
but I think we should be cognizant of the tradeoff we're making. If we
don't include this rq->avg_idle check, then some workloads will regress
because we're doing excessive migrations, but if we do check it, then
others will also regress because we're doing insufficient migrations due
to incorrectly assuming that an rq won't be idle for long. On yet
another hand, maybe it's fine to allow users to work around that by
setting sysctl_sched_migration_cost_ns = 0? That only sort of works,
because we ignore that and set rq->max_idle_balance_cost = curr_cost in
newidle_balance() if we end up doing a balance pass. I also know that
Peter and others discourage the use of these debugfs knobs, so I'm not
sure it's even applicable to point that out as a workaround.

And so hopefully the problem starts to become clear. It doesn't take
long for for us to get mired in heuristics that make it difficult to
reason about the expected behavior of the feature, and also difficult to
reason about future changes as these heuristics have now all crossed
streams. Maybe that's OK, and is preferable to the alternative. My
personal opinion, however, is that it's preferable to provide users with
knobs that do straightforward things that are independent from existing
heuristics and knobs which were added for other circumstances. I'd
rather have confidence that I understand how a feature is supposed to
work, and can easily reason about when it's stupid (or not) to use it,
vs. have an expectation for it to not regress workloads in any scenario.

Note that this doesn't mean we can't make my patches less dumb. I think
your suggestions to e.g. check the overload flag (or possibly even
better to just not enqueue in a shard if the rq isn't overloaded),
re-check ttwu->pending after failing to find a task in the shard, etc
make complete sense. There's no downside -- we're just avoiding
pointless work. It's the heuristics like checking rq->avg_idle that
really worry me.

Peter -- I think it would be helpful if you could weigh in here just to
provide your thoughts on this more "philosophical" question.

> If possible, can you check how long is the avg_idle running your
> workload? Meanwhile, I believe there are a few workloads that
> exhibit same behavior as tbench (large scale idling for short
> duration) Let me go check if I can see tbench like issue there.

Sure thing, in the meantime I'll test this out on HHVM. I've actually
been working on getting a build + testbed ready for a few days, so
hopefully it won't take much longer to get some results. Even if it
turns out that this works great for HHVM, I'd ideally like to get
Peter's and others' thoughts on the above.

Thanks,
David
