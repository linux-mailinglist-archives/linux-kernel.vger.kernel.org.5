Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BC9D7B3842
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 19:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233620AbjI2RBV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 13:01:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233691AbjI2RBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 13:01:16 -0400
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB62A1BF
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 10:01:12 -0700 (PDT)
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-690d2441b95so684263b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 10:01:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696006872; x=1696611672;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o7tb9qgExcfwx59wbYTBPGPiHmAF9mWFG0DnCJIrAMg=;
        b=tgLPTWCqJnHoLsWgnivvVoXx3p8wYm/ea6DgoyLjeJJzXiMAbeOnpgBXeOfIAT248Z
         fM6jfVrq8kWJPxwO92GX9m23q9JXZhQISQr0F5Cf/NqH8PrHykxKZ/MtxGnS1CX6JNVJ
         aDpqC96wcd3VMvUOQh44riQNZ8ZQxyFg7ihbxXzCrMlyx6EVFIf8k4g0E44JIR+NvTTY
         7JeSpAO1PB8y5mBZaRZIKn2EOTOntjliqt7NcEIvsPiJI2FUJCAFfAuGkSGvGgIVZm8c
         SFNl+1r0Ozc4PtpcbRBkTFOSyYUY/d8UL2UsZw4uCayY0Fy1achPobeZpK+alYx/N29f
         4AEA==
X-Gm-Message-State: AOJu0YxjQ8nCSxVMwmHk7uEg5VenZ/749gaD3EYX9tpqdJW8sKdoZhaa
        1SlkmknFH0rChxt+IJFZRr8=
X-Google-Smtp-Source: AGHT+IEeuLvIv4d6/NR6+8aTjKQfcthJ23zRtpduZkG2fMYyZFUUeKUmkY5X8vAq3QLxFFbS+hhC9A==
X-Received: by 2002:a05:6a00:2442:b0:690:f877:aa1e with SMTP id d2-20020a056a00244200b00690f877aa1emr7118463pfj.12.1696006871654;
        Fri, 29 Sep 2023 10:01:11 -0700 (PDT)
Received: from maniforge ([2620:10d:c090:400::4:4b85])
        by smtp.gmail.com with ESMTPSA id z14-20020aa785ce000000b006933ea28070sm4392608pfn.12.2023.09.29.10.01.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 10:01:09 -0700 (PDT)
Date:   Fri, 29 Sep 2023 12:01:04 -0500
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
Message-ID: <20230929170104.GA78641@maniforge>
References: <31aeb639-1d66-2d12-1673-c19fed0ab33a@amd.com>
 <20230831104508.7619-1-kprateek.nayak@amd.com>
 <20230831104508.7619-4-kprateek.nayak@amd.com>
 <20230831191103.GC531917@maniforge>
 <350639fb-a428-7d94-b13b-7a33e68b7b09@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <350639fb-a428-7d94-b13b-7a33e68b7b09@amd.com>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 01, 2023 at 01:53:12AM +0530, K Prateek Nayak wrote:
> Hello David,
> 
> On 9/1/2023 12:41 AM, David Vernet wrote:
> > On Thu, Aug 31, 2023 at 04:15:08PM +0530, K Prateek Nayak wrote:
> > 
> > Hi Prateek,
> > 
> >> Even with the two patches, I still observe the following lock
> >> contention when profiling the tbench 128-clients run with IBS:
> >>
> >>   -   12.61%  swapper          [kernel.vmlinux]         [k] native_queued_spin_lock_slowpath
> >>      - 10.94% native_queued_spin_lock_slowpath
> >>         - 10.73% _raw_spin_lock
> >>            - 9.57% __schedule
> >>                 schedule_idle
> >>                 do_idle
> >>               + cpu_startup_entry
> >>            - 0.82% task_rq_lock
> >>                 newidle_balance
> >>                 pick_next_task_fair
> >>                 __schedule
> >>                 schedule_idle
> >>                 do_idle
> >>               + cpu_startup_entry
> >>
> >> Since David mentioned rq->avg_idle check is probably not the right step
> >> towards the solution, this experiment introduces a per-shard
> >> "overload" flag. Similar to "rq->rd->overload", per-shard overload flag
> >> notifies of the possibility of one or more rq covered in the shard's
> >> domain having a queued task. shard's overload flag is set at the same
> >> time as "rq->rd->overload", and is cleared when shard's list is found
> >> to be empty.
> > 
> > I think this is an interesting idea, but I feel that it's still working
> > against the core proposition of SHARED_RUNQ, which is to enable work
> > conservation.
> 
> I don't think so! Work conservation is possible if there is an
> imbalance. Consider the case where we 15 tasks in the shared_runq but we
> have 16 CPUs, 15 of which are running these 15 tasks, and one going

I'm not sure I'm fully following. Those 15 tasks would not be enqueued
in the shared runq if they were being run. They would be dequeued from
the shared_runq in __dequeue_entity(), which would be called from
set_next_entity() before they were run. In this case, the
shard->overload check should be equivalent to the
!list_empty(&shard->list) check.

Oh, or is the idea that we're not bothering to pull them from the
shared_runq if they're being woken up and enqueued on an idle core that
will immediately run them on the next resched path? If so, I wonder if
we would instead just want to not enqueue the task in the shared_runq at
all? Consider that if another task comes in on an rq with
rq->nr_running >= 2, that we still wouldn't want to pull the tasks that
were being woken up on idle cores (nor take the overhead of inserting
and then immediately removing them from the shared_runq).

> idle. Work is conserved. What we need to worry about is tasks being in
> the shared_runq that are queued on their respective CPU. This can only
> happen if any one of the rq has nr_running >= 2, which is also the point
> we are setting "shard->overload".

Assuming this is about the "wakeup / enqueue to idle core" case, ok,
this makes sense. I still think it probably makes more sense to just not
enqueue in the shared_runq for this case though, which would allow us to
instead just rely on list_empty(&shard->list).

> Now situation can change later and all tasks in the shared_runq might be
> running on respective CPUs but "shard->overload" is only cleared when
> the shared_runq becomes empty. If this is too late, maybe we can clear
> it if periodic load balancing finds no queuing (somewhere around the
> time we update nr_idle_scan).
> 
> So the window where we do not go ahead with popping a task from the
> shared_runq_shard->list is between the list being empty and at least one
> of the CPU associated with the shard reporting nr_running >= 2, which is
> when work conservation is needed.

So, I misread your patch the first time I reviewed it, and for some
reason thought you were only setting shard->overload on the
load_balance(). That's obviously not the case, and I now understand it
better, modulo my points above being clarified.

> > 
> >> With these changes, following are the results for tbench 128-clients:
> > 
> > Just to make sure I understand, this is to address the contention we're
> > observing on tbench with 64 - 256 clients, right?  That's my
> > understanding from Gautham's reply in [0].
> > 
> > [0]: https://lore.kernel.org/all/ZOc7i7wM0x4hF4vL@BLR-5CG11610CF.amd.com/
> 
> I'm not sure if Gautham saw a contention with IBS but he did see an
> abnormal blowup in newidle_balance() counts which he suspected were the
> cause for the regression. I noticed the rq lock contention after doing a
> fair bit of surgery. Let me go check if that was the case with vanilla
> v3 too.
> 
> > 
> > If so, are we sure this change won't regress other workloads that would
> > have benefited from the work conservation?
> 
> I don't think we'll regress any workloads as I explained above because
> the "overload" flag being 0 almost (since update/access is not atomic)
> always indicate a case where the tasks cannot be pulled. However, that
> needs to be tested since there is a small behavior change in
> shared_runq_pick_next_task(). Where previously if the task is running
> on CPU, we would have popped it from shared_runq, did some lock
> fiddling before finding out it is running, some more lock fiddling
> before the function returned "-1", now with the changes here, it'll
> simply return a "0" and although that is correct, we have seen some
> interesting cases in past [1] where a random lock contention actually
> helps certain benchmarks ¯\_(ツ)_/¯

I don't think we need to worry about less lock contention possibly
hurting benchmarks :-)

> [1] https://lore.kernel.org/all/44428f1e-ca2c-466f-952f-d5ad33f12073@amd.com/ 
> 
> > 
> > Also, I assume that you don't see the improved contention without this,
> > even if you include your fix to the newidle_balance() that has us skip
> > over the <= LLC domain?
> 
> No improvements! The lock is still very much contended for. I wonder if
> it could be because of the unlocking and locking the rq again in
> shared_runq_pick_next_task() even when task is on CPU. Also since it
> return -1 for this case, pick_next_task_fair() will return RETRY_TASK
> which can have further implications.

Yeah, I could see it being an issue if we're essentially thrashing tasks
in the shared_runq that are just temporarily enqueued in the shared_runq
between activate and doing a resched pass on an idle core.

Unfortunately, I don't think we have any choice but to drop and
reacquire the rq lock. It's not safe to look at task_cpu(p) without
pi_lock, and we can't safely acquire that without dropping the rq lock.

Thanks,
David
