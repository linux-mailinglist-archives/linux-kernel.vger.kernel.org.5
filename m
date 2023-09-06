Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6414A7944B2
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 22:44:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239264AbjIFUo0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 16:44:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231821AbjIFUoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 16:44:24 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C4893E9;
        Wed,  6 Sep 2023 13:44:20 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7633F106F;
        Wed,  6 Sep 2023 13:44:58 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 36CB13F67D;
        Wed,  6 Sep 2023 13:44:19 -0700 (PDT)
Message-ID: <16dcf2b6-6921-10c7-ae75-a9f8015a9c85@arm.com>
Date:   Wed, 6 Sep 2023 22:44:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC PATCH 2/7] sched/pelt: Add a new function to approximate
 runtime to reach given util
Content-Language: en-US
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
To:     Qais Yousef <qyousef@layalina.io>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Lukasz Luba <lukasz.luba@arm.com>
References: <20230827233203.1315953-1-qyousef@layalina.io>
 <20230827233203.1315953-3-qyousef@layalina.io>
 <bad29fb0-c734-853b-492b-ce2d01a293c5@arm.com>
In-Reply-To: <bad29fb0-c734-853b-492b-ce2d01a293c5@arm.com>
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

On 06/09/2023 14:56, Dietmar Eggemann wrote:
> On 28/08/2023 01:31, Qais Yousef wrote:
>> It is basically the ramp-up time from 0 to a given value. Will be used
>> later to implement new tunable to control response time  for schedutil.
>>
>> Signed-off-by: Qais Yousef (Google) <qyousef@layalina.io>
>> ---
>>  kernel/sched/pelt.c  | 21 +++++++++++++++++++++
>>  kernel/sched/sched.h |  1 +
>>  2 files changed, 22 insertions(+)
>>
>> diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
>> index 50322005a0ae..f673b9ab92dc 100644
>> --- a/kernel/sched/pelt.c
>> +++ b/kernel/sched/pelt.c
>> @@ -487,3 +487,24 @@ unsigned long approximate_util_avg(unsigned long util, u64 delta)
>>  
>>  	return sa.util_avg;
>>  }
>> +
>> +/*
>> + * Approximate the required amount of runtime in ms required to reach @util.
>> + */
>> +u64 approximate_runtime(unsigned long util)
>> +{
>> +	struct sched_avg sa = {};
>> +	u64 delta = 1024; // period = 1024 = ~1ms
>> +	u64 runtime = 0;
>> +
>> +	if (unlikely(!util))
>> +		return runtime;
>> +
>> +	while (sa.util_avg < util) {
>> +		accumulate_sum(delta, &sa, 0, 0, 1);
>> +		___update_load_avg(&sa, 0);
>> +		runtime++;
>> +	}
>> +
>> +	return runtime;
>> +}
> 
> S_n = S_inv * (1 - 0.5^(t/hl))
> 
> t = hl * ln(1 - Sn/S_inv)/ln(0.5)
> 
> (1) for a little CPU (capacity_orig = 446)
> 
> t = 32ms * ln(1 - 446/1024)/ln(0.5)
> 
> t = 26ms
> 
> (2) for a big CPU (capacity = 1023 (*instead of 1024 since ln(0) not
>     defined
> 
> t = 32ms * ln(1 - 1023/1024)/ln(0.5)
> 
> t = 320ms

Forgot half of what I wanted to ask:

And you want to be able to have a schedutil interface:

/sys/devices/system/cpu/cpufreq/policy*/schedutil/response_time_ms

in which by default we have 26ms for a CPU with the capacity_orig of 446.

I.e. you want to have a time-based interface there? Which the user can
overwrite, say with 52ms and this then will lower the return value of
get_next_freq() so the system will respond slower?

And the time based interface is more intuitive than staying in the
capacity world of [0-1024]?


