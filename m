Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E0CA7FC99A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 23:37:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344375AbjK1WhN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 17:37:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbjK1WhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 17:37:12 -0500
Received: from w4.tutanota.de (w4.tutanota.de [81.3.6.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF9B71710;
        Tue, 28 Nov 2023 14:37:17 -0800 (PST)
Received: from tutadb.w10.tutanota.de (unknown [192.168.1.10])
        by w4.tutanota.de (Postfix) with ESMTP id 8AD961060166;
        Tue, 28 Nov 2023 22:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1701211036;
        s=s1; d=well-founded.dev;
        h=From:From:To:To:Subject:Subject:Content-Description:Content-ID:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Cc:Cc:Date:Date:In-Reply-To:In-Reply-To:MIME-Version:MIME-Version:Message-ID:Message-ID:Reply-To:References:References:Sender;
        bh=d8Q7hAqIb/PUzl9v9MP4WxmBc/5Ztd5hTU3n2F9SrU4=;
        b=crzWIkssbFPdgDuNJyelgjAS9CjAQ/1t9Vc1TFighEL+yJw4TuRyxo+2wwXMqy7B
        uahN7RZur6/+rz7zRH9lJhXOBkE+IdfMpj5ckxQDGO0e85v7lQHvF0cZn1T+pJ792Iq
        jxwhep8PYsd5u1YUkIoLHrLXCu/LA4V9nSNc74+Lnl2g2JkLj8pKLn3nQHTytg7yF1P
        35CJ462ZS8pJGtfUCIQNAMvy4z1CP7osOBBRDA1/+usgWSwN8EsaO6f+OE1H3N/vagG
        5YAvbd/WyYh1NTZTfxtjIRQMOCdoEKv7opUfl4We0+t3mL8EuAdo1mSg/8LSq7dwyyC
        s8TRmMeS4Q==
Date:   Tue, 28 Nov 2023 23:37:16 +0100 (CET)
From:   Ramses <ramses@well-founded.dev>
To:     Tim Chen <tim.c.chen@linux.intel.com>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux Power Management <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Yu Chen <yu.c.chen@intel.com>
Message-ID: <NkN44cg--3-9@well-founded.dev>
In-Reply-To: <b2b9121c6d2003b45f7fde6a97bb479a1ed634c7.camel@linux.intel.com>
References: <01df8329-06d7-4fd1-9c7a-05296f33231e@gmail.com> <b2b9121c6d2003b45f7fde6a97bb479a1ed634c7.camel@linux.intel.com>
Subject: Re: Fwd: Intel hybrid CPU scheduler always prefers E cores
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(Sending again since I accidentally sent my last mail as HTML.)

I applied the patch on top of 6.6.2, but unfortunately I see more or less the same behaviour as before, with single-threaded CPU-bound tasks running almost exclusively on E cores.

Ramses


Nov 28, 2023, 18:39 by tim.c.chen@linux.intel.com:

> On Tue, 2023-11-28 at 20:22 +0700, Bagas Sanjaya wrote:
>
>> Hi,
>>
>> I come across an interesting bug report on Bugzilla [1]. The reporter
>> wrote:
>>
>> > I am running an intel alder lake system (Core i7-1260P), with a mix of P and E cores.
>> > 
>> > Since Linux 6.6, and also on the current 6.7 RC, the scheduler seems to have a strong preference for the E cores, and single threaded workloads are consistently scheduled on one of the E cores.
>> > 
>> > With Linux 6.4 and before, when I ran a single threaded CPU-bound process, it was scheduled on a P core. With 6.5, it seems that the choice of P or E seemed rather random.
>> > 
>> > I tested these by running "stress" with different amounts of threads. With a single thread on Linux 6.6 and 6.7, I always have an E core at 100% and no load on the P cores. Starting from 3 threads I get some load on the P cores as well, but the E cores stay more heavily loaded.
>> > With "taskset" I can force a process to run on a P core, but clearly it's not very practical to have to do CPU scheduling manually.
>> > 
>> > This severely affects single-threaded performance of my CPU since the E cores are considerably slower. Several of my workflows are now a lot slower due to them being single-threaded and heavily CPU-bound and being scheduled on E cores whereas they would run on P cores before.
>> > 
>> > I am not sure what the exact desired behaviour is here, to balance power consumption and performance, but currently my P cores are barely used for single-threaded workloads.
>> > 
>> > Is this intended behaviour or is this indeed a regression? Or is there perhaps any configuration that I should have done from my side? Is there any further info that I can provide to help you figure out what's going on?
>>
>> PM and scheduler people, is this a regression or works as intended?
>>
>> Thanks.
>>
>> [1]: https://bugzilla.kernel.org/show_bug.cgi?id=218195
>>
>
> I have noticed that the current code sometimes is quite trigger happy
> moving tasks off P-core, whenever there are more than 2 tasks on a core.
> Sometimes, Short running house keeping tasks
> could disturb the running task on P-core as a result.
>
> Can you try the following patch?  On my Alder Lake system, I see as I add single
> threaded tasks, they first run on P-cores, then followed by E-cores with this
> patch on 6.6.
>
> Tim
>
> From 68a15ef01803c252261ebb47d86dfc1f2c68ae1e Mon Sep 17 00:00:00 2001
> From: Tim Chen <tim.c.chen@linux.intel.com>
> Date: Fri, 6 Oct 2023 15:58:56 -0700
> Subject: [PATCH] sched/fair: Don't force smt balancing when CPU has spare
>  capacity
>
> Currently group_smt_balance is picked whenever there are more
> than two tasks on a core with two SMT.  However, the utilization
> of those tasks may be low and do not warrant a task
> migration to a CPU of lower priority.
>
> Adjust sched group clssification and sibling_imbalance()
> to reflect this consideration.  Use sibling_imbalance() to
> compute imbalance in calculate_imbalance() for the group_smt_balance
> case.
>
> Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
>
> ---
>  kernel/sched/fair.c | 23 +++++++++++------------
>  1 file changed, 11 insertions(+), 12 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index ef7490c4b8b4..7dd7c2d2367a 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -9460,14 +9460,15 @@ group_type group_classify(unsigned int imbalance_pct,
>  if (sgs->group_asym_packing)
>  return group_asym_packing;
>  
> -	if (sgs->group_smt_balance)
> -		return group_smt_balance;
> -
>  if (sgs->group_misfit_task_load)
>  return group_misfit_task;
>  
> -	if (!group_has_capacity(imbalance_pct, sgs))
> -		return group_fully_busy;
> +	if (!group_has_capacity(imbalance_pct, sgs)) {
> +		if (sgs->group_smt_balance)
> +			return group_smt_balance;
> +		else
> +			return group_fully_busy;
> +	}
>  
>  return group_has_spare;
>  }
> @@ -9573,6 +9574,11 @@ static inline long sibling_imbalance(struct lb_env *env,
>  if (env->idle == CPU_NOT_IDLE || !busiest->sum_nr_running)
>  return 0;
>  
> +	/* Do not pull tasks off preferred group with spare capacity */
> +	if (busiest->group_type == group_has_spare &&
> +	    sched_asym_prefer(sds->busiest->asym_prefer_cpu, env->dst_cpu))
> +		return 0;
> +
>  ncores_busiest = sds->busiest->cores;
>  ncores_local = sds->local->cores;
>  
> @@ -10411,13 +10417,6 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
>  return;
>  }
>  
> -	if (busiest->group_type == group_smt_balance) {
> -		/* Reduce number of tasks sharing CPU capacity */
> -		env->migration_type = migrate_task;
> -		env->imbalance = 1;
> -		return;
> -	}
> -
>  if (busiest->group_type == group_imbalanced) {
>  /*
>  * In the group_imb case we cannot rely on group-wide averages
> -- 
> 2.32.0
>

