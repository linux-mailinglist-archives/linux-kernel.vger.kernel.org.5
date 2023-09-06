Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54A18793F13
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 16:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241762AbjIFOjL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 10:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234885AbjIFOjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 10:39:05 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C49461736;
        Wed,  6 Sep 2023 07:39:01 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3D758106F;
        Wed,  6 Sep 2023 07:39:39 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BFB953F67D;
        Wed,  6 Sep 2023 07:38:59 -0700 (PDT)
Message-ID: <e2c161dc-381a-4cd6-9b46-6810fab58222@arm.com>
Date:   Wed, 6 Sep 2023 16:38:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC PATCH 3/7] sched/fair: Remove magic margin in
 fits_capacity()
Content-Language: en-US
To:     Qais Yousef <qyousef@layalina.io>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Lukasz Luba <lukasz.luba@arm.com>
References: <20230827233203.1315953-1-qyousef@layalina.io>
 <20230827233203.1315953-4-qyousef@layalina.io>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20230827233203.1315953-4-qyousef@layalina.io>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/08/2023 01:31, Qais Yousef wrote:
> 80% margin is a magic value that has served its purpose for now, but it
> no longer fits the variety of systems exist today. If a system is over
> powered specifically, this 80% will mean we leave a lot of capacity
> unused before we decide to upmigrate on HMP system.
> 
> The upmigration behavior should rely on the fact that a bad decision
> made will need load balance to kick in to perform misfit migration. And
> I think this is an adequate definition for what to consider as enough
> headroom to consider whether a util fits capacity or not.
> 
> Use the new approximate_util_avg() function to predict the util if the
> task continues to run for TICK_US. If the value is not strictly less
> than the capacity, then it must not be placed there, ie considered
> misfit.
> 
> Signed-off-by: Qais Yousef (Google) <qyousef@layalina.io>
> ---
>  kernel/sched/fair.c | 21 ++++++++++++++++++---
>  1 file changed, 18 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 0b7445cd5af9..facbf3eb7141 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -109,16 +109,31 @@ int __weak arch_asym_cpu_priority(int cpu)
>  }
>  
>  /*
> - * The margin used when comparing utilization with CPU capacity.
> + * The util will fit the capacity if it has enough headroom to grow within the
> + * next tick - which is when any load balancing activity happens to do the
> + * correction.
>   *
> - * (default: ~20%)
> + * If util stays within the capacity before tick has elapsed, then it should be
> + * fine. If not, then a correction action must happen shortly after it starts
> + * running, hence we treat it as !fit.
> + *
> + * TODO: TICK is not actually accurate enough. balance_interval is the correct
> + * one to use as the next load balance doesn't not happen religiously at tick.
> + * Accessing balance_interval might be tricky and will require some refactoring
> + * first.
>   */

I understand that you want to have a more intelligent margin (depending
on the util value) but why you want to use the time value of TICK_USEC
(or the balance_interval)?

We call fits_capacity() e.g. in wakeup and the next lb can just happen
immediately after it.

> -#define fits_capacity(cap, max)	((cap) * 1280 < (max) * 1024)
> +static inline bool fits_capacity(unsigned long util, unsigned long capacity)
> +{
> +	return approximate_util_avg(util, TICK_USEC) < capacity;
> +}

[...]

