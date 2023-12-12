Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F19680E974
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 11:47:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346178AbjLLKrT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 05:47:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjLLKrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 05:47:17 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ABB869F;
        Tue, 12 Dec 2023 02:47:23 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D5EFC143D;
        Tue, 12 Dec 2023 02:48:09 -0800 (PST)
Received: from [10.1.35.59] (e133649.arm.com [10.1.35.59])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 187593F762;
        Tue, 12 Dec 2023 02:47:20 -0800 (PST)
Message-ID: <d73ea0ed-ecd8-4c70-b02e-f6fcd2cd7538@arm.com>
Date:   Tue, 12 Dec 2023 10:47:19 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] sched/fair: Be less aggressive in calling
 cpufreq_update_util()
Content-Language: en-US
To:     Qais Yousef <qyousef@layalina.io>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Lukasz Luba <lukasz.luba@arm.com>, Wei Wang <wvw@google.com>,
        Rick Yiu <rickyiu@google.com>,
        Chung-Kai Mei <chungkai@google.com>
References: <20231208015242.385103-1-qyousef@layalina.io>
 <20231208015242.385103-2-qyousef@layalina.io>
From:   Hongyan Xia <hongyan.xia2@arm.com>
In-Reply-To: <20231208015242.385103-2-qyousef@layalina.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

Do you mean the for_each_sched_entity(se) loop? I think we update CPU 
frequency only once at the root CFS?

> Combine this with the rate limit in schedutil, we could end up
> prematurely send up a wrong frequency update before we have actually
> updated all entities appropriately.
> 
> Be smarter about it by limiting the trigger to perform frequency updates
> after all accounting logic has done. This ended up being in the
> following points:
> 
> 1. enqueue/dequeue_task_fair()
> 2. throttle/unthrottle_cfs_rq()
> 3. attach/detach_task_cfs_rq()
> 4. task_tick_fair()
> 5. __sched_group_set_shares()
> 
> This is not 100% ideal still due to other limitations that might be
> a bit harder to handle. Namely we can end up with premature update
> request in the following situations:
> 
> a. Simultaneous task enqueue on the CPU where 2nd task is bigger and
>     requires higher freq. The trigger to cpufreq_update_util() by the
>     first task will lead to dropping the 2nd request until tick. Or
>     another CPU in the same policy trigger a freq update.
> 
> b. CPUs sharing a policy can end up with the same race in a but the
>     simultaneous enqueue happens on different CPUs in the same policy.
> 
> The above though are limitations in the governor/hardware, and from
> scheduler point of view at least that's the best we can do. The
> governor might consider smarter logic to aggregate near simultaneous
> request and honour the higher one.
> 
> Signed-off-by: Qais Yousef (Google) <qyousef@layalina.io>
> ---
>   kernel/sched/fair.c | 55 ++++++++++++---------------------------------
>   1 file changed, 14 insertions(+), 41 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index b83448be3f79..f99910fc6705 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -3997,29 +3997,6 @@ static inline void update_cfs_group(struct sched_entity *se)
>   }
>   #endif /* CONFIG_FAIR_GROUP_SCHED */
>   
> -static inline void cfs_rq_util_change(struct cfs_rq *cfs_rq, int flags)
> -{
> -	struct rq *rq = rq_of(cfs_rq);
> -
> -	if (&rq->cfs == cfs_rq) {

Here. I think this restricts frequency updates to the root CFS?

> -		/*
> -		 * There are a few boundary cases this might miss but it should
> -		 * get called often enough that that should (hopefully) not be
> -		 * a real problem.
> -		 *
> -		 * It will not get called when we go idle, because the idle
> -		 * thread is a different class (!fair), nor will the utilization
> -		 * number include things like RT tasks.
> -		 *
> -		 * As is, the util number is not freq-invariant (we'd have to
> -		 * implement arch_scale_freq_capacity() for that).
> -		 *
> -		 * See cpu_util_cfs().
> -		 */
> -		cpufreq_update_util(rq, flags);
> -	}
> -}
> -
>   #ifdef CONFIG_SMP
>   static inline bool load_avg_is_decayed(struct sched_avg *sa)
>   {
> [...]
