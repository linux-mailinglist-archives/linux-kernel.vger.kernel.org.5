Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BA947944F6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 23:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244681AbjIFVNO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 17:13:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232411AbjIFVNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 17:13:13 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B8D891724;
        Wed,  6 Sep 2023 14:13:08 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 16ECFC15;
        Wed,  6 Sep 2023 14:13:46 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C77FB3F7B4;
        Wed,  6 Sep 2023 14:13:06 -0700 (PDT)
Message-ID: <60a21021-87c5-b93d-4312-d41fbcd4ec43@arm.com>
Date:   Wed, 6 Sep 2023 23:13:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC PATCH 5/7] sched/schedutil: Add a new tunable to dictate
 response time
Content-Language: en-US
To:     Qais Yousef <qyousef@layalina.io>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Lukasz Luba <lukasz.luba@arm.com>
References: <20230827233203.1315953-1-qyousef@layalina.io>
 <20230827233203.1315953-6-qyousef@layalina.io>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20230827233203.1315953-6-qyousef@layalina.io>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/08/2023 01:32, Qais Yousef wrote:

[...]

> @@ -427,6 +427,23 @@ This governor exposes only one tunable:
>  	The purpose of this tunable is to reduce the scheduler context overhead
>  	of the governor which might be excessive without it.
>  
> +``respone_time_ms``
> +	Amount of time (in milliseconds) required to ramp the policy from
> +	lowest to highest frequency. Can be decreased to speed up the
> +	responsiveness of the system, or increased to slow the system down in
> +	hope to save power. The best perf/watt will depend on the system
> +	characteristics and the dominant workload you expect to run. For
> +	userspace that has smart context on the type of workload running (like
> +	in Android), one can tune this to suite the demand of that workload.
> +
> +	Note that when slowing the response down, you can end up effectively
> +	chopping off the top frequencies for that policy as the util is capped
> +	to 1024. On HMP systems where some CPUs have a capacity less than 1024,

HMP isn't used in mainline AFAIK. IMHO, the term `asymmetric CPU
capacity` systems is used.

[...]

> @@ -59,6 +61,45 @@ static DEFINE_PER_CPU(struct sugov_cpu, sugov_cpu);
>  
>  /************************ Governor internals ***********************/
>  
> +static inline u64 sugov_calc_freq_response_ms(struct sugov_policy *sg_policy)
> +{
> +	int cpu = cpumask_first(sg_policy->policy->cpus);
> +	unsigned long cap = capacity_orig_of(cpu);
> +
> +	return approximate_runtime(cap);
> +}

I can see the potential issue of schedutil being earlier initialized
than the `max frequency scaling of cpu_capacity_orig` happens in
drivers/base/arch_topology.c.

So the response_time_ms setup for a little CPU on Juno-r0 wouldn't
happen on cpu_capacity_orig = 446 -> 26ms but on on the raw capacity
value from dt:

    capacity-dmips-mhz = <578>

So I would expect to see t = 32ms * ln(1 - 578/1024)/ln(0.5) = 38ms instead.

We have a similar dependency between `max frequency scaled
cpu_capacity_orig` and the EM setup code.

[...]
