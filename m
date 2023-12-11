Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B44C980D8A3
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 19:47:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345284AbjLKSra (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 13:47:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbjLKSr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 13:47:29 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 528A9B8;
        Mon, 11 Dec 2023 10:47:35 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 917511007;
        Mon, 11 Dec 2023 10:48:21 -0800 (PST)
Received: from [10.57.75.23] (unknown [10.57.75.23])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E938F3F762;
        Mon, 11 Dec 2023 10:47:31 -0800 (PST)
Message-ID: <739492e4-b9a3-4c55-82e6-60b02d489c5f@arm.com>
Date:   Mon, 11 Dec 2023 18:47:29 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] sched/fair: Be less aggressive in calling
 cpufreq_update_util()
To:     Qais Yousef <qyousef@layalina.io>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Lukasz Luba <lukasz.luba@arm.com>, Wei Wang <wvw@google.com>,
        Rick Yiu <rickyiu@google.com>,
        Chung-Kai Mei <chungkai@google.com>,
        Hongyan Xia <hongyan.xia2@arm.com>
References: <20231208015242.385103-1-qyousef@layalina.io>
 <20231208015242.385103-2-qyousef@layalina.io>
Content-Language: en-US
From:   Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <20231208015242.385103-2-qyousef@layalina.io>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/12/2023 01:52, Qais Yousef wrote:
> Due to the way code is structured, it makes a lot of sense to trigger
> cpufreq_update_util() from update_load_avg(). But this is too aggressive
> as in most cases we are iterating through entities in a loop to
> update_load_avg() in the hierarchy. So we end up sending too many
> request in an loop as we're updating the hierarchy.

If this is actually less aggressive heavily depends on the workload,
I can argue the patch is more aggressive, as you call cpufreq_update_util
at every enqueue and dequeue, instead of just at enqueue.
For an I/O workload it is definitely more aggressive, see below.

> 
> Combine this with the rate limit in schedutil, we could end up
> prematurely send up a wrong frequency update before we have actually
> updated all entities appropriately.
> [SNIP]


> @@ -6704,14 +6677,6 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>  	 */
>  	util_est_enqueue(&rq->cfs, p);
>  
> -	/*
> -	 * If in_iowait is set, the code below may not trigger any cpufreq
> -	 * utilization updates, so do it here explicitly with the IOWAIT flag
> -	 * passed.
> -	 */
> -	if (p->in_iowait)
> -		cpufreq_update_util(rq, SCHED_CPUFREQ_IOWAIT);
> -
>  	for_each_sched_entity(se) {
>  		if (se->on_rq)
>  			break;
> @@ -6772,6 +6737,8 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>  enqueue_throttle:
>  	assert_list_leaf_cfs_rq(rq);
>  
> +	cpufreq_update_util(rq, p->in_iowait ? SCHED_CPUFREQ_IOWAIT : 0);
> +
>  	hrtick_update(rq);
>  }
>  
> @@ -6849,6 +6816,7 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>  
>  dequeue_throttle:
>  	util_est_update(&rq->cfs, p, task_sleep);
> +	cpufreq_update_util(rq, 0);

This is quite critical, instead of only calling the update
at enqueue (with SCHED_CPUFREQ_IOWAIT if applicable) it is
now called at every enqueue and dequeue. The only way for
schedutil (intel_pstate too?) to build up a value of
iowait_boost > 128 is a large enough rate_limit_us, as even
for just a in_iowait task the enqueue increases the boost and
its own dequeue could reduce it already. For just a basic
benchmark workload and 2000 rate_limit_us this doesn't seem
to be that critical, anything below 200 rate_limit_us didn't
show any iowait boosting > 128 anymore on my system.
Of course if the workload does more between enqueue and
dequeue (time until task issues next I/O) already larger
values of rate_limit_us will disable any significant
iowait boost benefit.

Just to add some numbers to the story:
fio --time_based --name=fiotest --filename=/dev/nvme0n1 --runtime=30 --rw=randread --bs=4k --ioengine=psync --iodepth=1
fio --time_based --name=fiotest --filename=/dev/mmcblk2 --runtime=30 --rw=randread --bs=4k --ioengine=psync --iodepth=1

All results are sorted:
With this patch and rate_limit_us=2000:
(Second line is without iowait boosting, results are sorted):
[3883, 3980, 3997, 4018, 4019]
[2732, 2745, 2782, 2837, 2841]
/dev/mmcblk2
[4136, 4144, 4198, 4275, 4329]
[2753, 2975, 2975, 2975, 2976]

Without this patch and rate_limit_us=2000:
[3918, 4021, 4043, 4081, 4085]
[2850, 2859, 2863, 2873, 2887]
/dev/mmcblk2
[4277, 4358, 4380, 4421, 4425]
[2796, 3103, 3128, 3180, 3200]

With this patch and rate_limit_us=200:
/dev/nvme0n1
[2470, 2480, 2481, 2484, 2520]
[2473, 2510, 2517, 2534, 2572]
/dev/mmcblk2
[2286, 2338, 2440, 2504, 2535]
[2360, 2462, 2484, 2503, 2707]

Without this patch and rate_limit_us=200:
/dev/nvme0n1
[3880, 3956, 4010, 4013, 4016]
[2732, 2867, 2937, 2937, 2939]
/dev/mmcblk2
[4783, 4791, 4821, 4855, 4860]
[2653, 3091, 3095, 3166, 3202]

I'm currently working on iowait boosting and seeing where it's
actually needed and how it could be improved, so always interested
in anyone's thoughts.

(The second line here doesn't provide additional
information, I left it in to compare for reproducibility).
All with CONFIG_HZ=100 on an rk3399.

Best Regards,
Christian

> [SNIP]
