Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4390D7AEFBA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 17:30:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235097AbjIZPa4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 11:30:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233309AbjIZPay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 11:30:54 -0400
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B01010A
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 08:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1695742244;
        bh=OnohBIbzxshPyEmMWAh4gOX+hda/cp3tuqHCS6jOsUI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=BA1Aa3rOB6wid579Ks59TXZr7TnH8DbyKrk50K4zQAtEx1peEQ/AHSyTlyPz8bh1S
         Vy51Ppme5FxAxdI7z4vUnrwVGQmjmdyqq1cUG5PAosyoB4SKNJbVR6WRIxZHUZrDL5
         XKEpaVaBLVhqq+YGdfG7xreNvbGfSXm3IcbSdMyiGsKz3zanRcgC2hcbycSMBs3WuQ
         oq7kM+/fwXMIFGQisrnyFjYIAIqR/5v6amZnxN5VnH6uF6wI6mevBne8jvwIXqBztW
         96+plrvTcleIs2Y0fsdOtNb/YJd6o5zwag2DSwV05qoCZVSq6mXQc4iYmqzHSoh+GF
         WIOCQm+p4TLHQ==
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4Rw3bm0Nrkz1R9H;
        Tue, 26 Sep 2023 11:30:44 -0400 (EDT)
Message-ID: <677cd7ab-4347-ed09-bf56-4c2a9833ae50@efficios.com>
Date:   Tue, 26 Sep 2023 06:29:40 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 1/2] sched/fair: Record the short sleeping time of a task
Content-Language: en-US
To:     Chen Yu <yu.c.chen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>
Cc:     Tim Chen <tim.c.chen@intel.com>, Aaron Lu <aaron.lu@intel.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        linux-kernel@vger.kernel.org, Chen Yu <yu.chen.surf@gmail.com>
References: <cover.1695704179.git.yu.c.chen@intel.com>
 <b17a3db703494bdae8492843f7303c13b0dbd0fc.1695704179.git.yu.c.chen@intel.com>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <b17a3db703494bdae8492843f7303c13b0dbd0fc.1695704179.git.yu.c.chen@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/26/23 06:11, Chen Yu wrote:
> During task wakeup, the wakee firstly checks if its previous
> running CPU is idle. If yes, choose that CPU as its first
> choice. However, in most cases, the wakee's previous CPU
> could be chosen by someone else, which breaks the cache
> locality.
> 
> Proposes a mechanism to reserve the task's previous
> CPU for a short while. In this reservation period, other
> tasks are not allowed to pick that CPU until a timeout.
> The reservation period is defined as the average short
> sleep time of the task. To be more specific, it is the
> time delta between this task being dequeued and enqueued.
> Only the sleep time shorter than sysctl_sched_migration_cost
> will be recorded. If the sleep time is longer than
> sysctl_sched_migration_cost, give the reservation period
> a penalty by shrinking it to half. In this way, the 'burst'
> sleeping time of the task is honored, meanwhile, if that
> task becomes a long-sleeper, the reservation time of that
> task is shrunk to reduce the impact on task wakeup.
> 
> Suggested-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> ---
>   include/linux/sched.h |  3 +++
>   kernel/sched/fair.c   | 21 +++++++++++++++++++++
>   2 files changed, 24 insertions(+)
> 
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index dc37ae787e33..4a0ac0276384 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -561,6 +561,9 @@ struct sched_entity {
>   	u64				vruntime;
>   	s64				vlag;
>   	u64				slice;
> +	u64				prev_dequeue_time;
> +	/* the reservation period of this task during wakeup */
> +	u64				sis_rsv_avg;
>   
>   	u64				nr_migrations;
>   
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index d0877878bcdb..297b9470829c 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6456,6 +6456,24 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>   	struct sched_entity *se = &p->se;
>   	int idle_h_nr_running = task_has_idle_policy(p);
>   	int task_new = !(flags & ENQUEUE_WAKEUP);
> +	u64 last_dequeue = p->se.prev_dequeue_time;
> +	u64 now = sched_clock_cpu(task_cpu(p));
> +
> +	/*
> +	 * If the task is a short-sleepting task, there is no need
> +	 * to migrate it to other CPUs. Estimate the average short sleeping
> +	 * time of the wakee. This sleep time is used as a hint to reserve
> +	 * the dequeued task's previous CPU for a short while. During this
> +	 * reservation period, select_idle_cpu() prevents other wakees from
> +	 * choosing this CPU. This could bring a better cache locality.

"This could bring a better cache locality." could be rephrased as
"This improves cache locality for short-sleeping tasks."

Please add my:

Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

> +	 */
> +	if ((flags & ENQUEUE_WAKEUP) && last_dequeue && cpu_online(task_cpu(p)) &&
> +	    now > last_dequeue) {
> +		if (now - last_dequeue < sysctl_sched_migration_cost)
> +			update_avg(&p->se.sis_rsv_avg, now - last_dequeue);
> +		else
> +			p->se.sis_rsv_avg >>= 1;
> +	}
>   
>   	/*
>   	 * The code below (indirectly) updates schedutil which looks at
> @@ -6550,6 +6568,7 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>   	int task_sleep = flags & DEQUEUE_SLEEP;
>   	int idle_h_nr_running = task_has_idle_policy(p);
>   	bool was_sched_idle = sched_idle_rq(rq);
> +	u64 now;
>   
>   	util_est_dequeue(&rq->cfs, p);
>   
> @@ -6611,6 +6630,8 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>   dequeue_throttle:
>   	util_est_update(&rq->cfs, p, task_sleep);
>   	hrtick_update(rq);
> +	now = sched_clock_cpu(cpu_of(rq));
> +	p->se.prev_dequeue_time = task_sleep ? now : 0;
>   }
>   
>   #ifdef CONFIG_SMP

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

