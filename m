Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA679797B93
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 20:22:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343824AbjIGSWA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 14:22:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240090AbjIGSV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 14:21:57 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A3A81A8;
        Thu,  7 Sep 2023 11:21:53 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3AE0B16F3;
        Thu,  7 Sep 2023 04:13:41 -0700 (PDT)
Received: from [192.168.2.82] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8271B3F67D;
        Thu,  7 Sep 2023 04:13:00 -0700 (PDT)
Message-ID: <47a11e4e-d349-7d98-7006-4bf08a53c0cf@arm.com>
Date:   Thu, 7 Sep 2023 13:12:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC PATCH 1/7] sched/pelt: Add a new function to approximate the
 future util_avg value
Content-Language: en-US
To:     Qais Yousef <qyousef@layalina.io>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Lukasz Luba <lukasz.luba@arm.com>
References: <20230827233203.1315953-1-qyousef@layalina.io>
 <20230827233203.1315953-2-qyousef@layalina.io>
 <8f63efa6-f9d1-9b1c-7737-4094f6acfc62@arm.com>
 <20230906211936.yqejc25czc6tddm6@airbuntu>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20230906211936.yqejc25czc6tddm6@airbuntu>
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

On 06/09/2023 23:19, Qais Yousef wrote:
> On 09/06/23 14:56, Dietmar Eggemann wrote:
>> On 28/08/2023 01:31, Qais Yousef wrote:

[...]

>>> +/*
>>> + * Approximate the new util_avg value assuming an entity has continued to run
>>> + * for @delta us.
>>> + */
>>> +unsigned long approximate_util_avg(unsigned long util, u64 delta)
>>> +{
>>> +	struct sched_avg sa = {
>>> +		.util_sum = util * PELT_MIN_DIVIDER,
>>> +		.util_avg = util,
>>> +	};
>>> +
>>> +	if (unlikely(!delta))
>>> +		return util;
>>> +
>>> +	accumulate_sum(delta, &sa, 0, 0, 1);
>>
>> IMHO, you miss the handling of `periods != 0`. load = 0 eclipses this
>> code in accumulate_sum().

You could call accumulate_sum(delta, &sa, 1, 0, 1);

> 
> Yes. For some reason I got blank registered when I saw if this codepath can
> impact util_avg..

Another thing ... I guess if you call accumulate_sum with delta the PELT
machinery assumes `delta = now - sa->last_update_time` which means you
would have to use `clock_pelt + TICK_USEC` as delta.
>>
>>> +	___update_load_avg(&sa, 0);
>>> +
>>> +	return sa.util_avg;
>>> +}
>>
>> We already discussed something similar like this in Nov 22, the so
>> called UTIL_EST_FASTER thing.
>>
>> https://lkml.kernel.org/r/Y2kLA8x40IiBEPYg@hirez.programming.kicks-ass.net
>>
>> +/*
>> + * Compute a pelt util_avg assuming no history and @delta runtime.
>> + */
>> +unsigned long faster_est_approx(u64 delta)
>> +{
>> +	unsigned long contrib = (unsigned long)delta; /* p == 0 -> delta < 1024 */
>> +	u64 periods = delta / 1024;
>> +
>> +	if (periods) {
>> +		delta %= 1024;
>> +		contrib = __accumulate_pelt_segments(periods, 1024, delta);
>> +	}
>> +
>> +	return (contrib << SCHED_CAPACITY_SHIFT) / PELT_MIN_DIVIDER;
>> +}
>> +
> 
> I could look at using this version instead. This misses the decay part though?

__accumulate_pelt_segments(periods, ...) decays the periods. But
obviously not the util you pass into approximate_util_avg().















