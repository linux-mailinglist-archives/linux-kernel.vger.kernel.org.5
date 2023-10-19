Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B76457CFD37
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 16:49:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345596AbjJSOtK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 10:49:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346193AbjJSOtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 10:49:03 -0400
Received: from smtpout.efficios.com (unknown [IPv6:2607:5300:203:b2ee::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43BC4130
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 07:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1697726939;
        bh=YtPB/bcm1WOSJ3edgMyZVNvIWoEsNXaq7OYC/JmnN3w=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=R/zARI/GPSG2OhkM1+oFsFAmRhzZ15toStKv1R/paNjvOCh2Ya0ji0ftg23LCHlG5
         pWqvwlYTBLEQd5+9PzDjl9v0iXbieigADwB7yJQmikhh/FVkhaSxfFPttaV9HPONvy
         UdcPKW5gZ9q0BzBvd5tkirFZhgXST7f5w0T79RFBAOw+51LvA4cPEDjYKlXyZ+J13M
         LiFVvn3rCG8HCmvHgrKVZkw6J0UeejkRIa2Dd3pbhN0QdVacQxDL6OH9d0B6nPiG8z
         OE1G7itmdrPA09GGOnkMe+InuJlRnbvpDYl/kiqRRCIQkTe/dsEWc4jcuk6Ky+Kl9J
         07q13Q53bc4Xw==
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4SB9Zz0n4sz1Y2V;
        Thu, 19 Oct 2023 10:48:59 -0400 (EDT)
Message-ID: <6bb3bfe5-13d6-413a-bf31-cec5596757f2@efficios.com>
Date:   Thu, 19 Oct 2023 10:49:09 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/2] sched/fair: Introduce UTIL_FITS_CAPACITY feature
Content-Language: en-US
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Swapnil Sapkal <Swapnil.Sapkal@amd.com>,
        Aaron Lu <aaron.lu@intel.com>, Tim Chen <tim.c.chen@intel.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>, x86@kernel.org
References: <20231018204511.1563390-1-mathieu.desnoyers@efficios.com>
 <20231018204511.1563390-2-mathieu.desnoyers@efficios.com>
 <ZTEUjBgthYhz7NXm@chenyu5-mobl2.ccr.corp.intel.com>
 <25e778e2-d91a-4f4d-9f6b-ff144eab3211@efficios.com>
In-Reply-To: <25e778e2-d91a-4f4d-9f6b-ff144eab3211@efficios.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-10-19 09:28, Mathieu Desnoyers wrote:
> On 2023-10-19 07:35, Chen Yu wrote:
[...]
>>> +/*
>>> + * Returns true if adding the task utilization to the estimated
>>> + * utilization of the runnable tasks on @cpu does not exceed the
>>> + * capacity of @cpu.
>>> + *
>>> + * This considers only the utilization of _runnable_ tasks on the @cpu
>>> + * runqueue, excluding blocked and sleeping tasks. This is achieved by
>>> + * using the runqueue util_est.enqueued, and by estimating the capacity
>>> + * of @cpu based on arch_scale_cpu_capacity and 
>>> arch_scale_thermal_pressure
>>> + * rather than capacity_of() because capacity_of() considers
>>> + * blocked/sleeping tasks in other scheduler classes.
>>> + *
>>> + * The utilization vs capacity comparison is done without the margin
>>> + * provided by fits_capacity(), because fits_capacity() is used to
>>> + * validate whether the utilization of a task fits within the overall
>>> + * capacity of a cpu, whereas this function validates whether the task
>>> + * utilization fits within the _remaining_ capacity of the cpu, 
>>> which is
>>> + * more precise.
>>> + */
>>> +static inline bool task_fits_remaining_cpu_capacity(unsigned long 
>>> task_util,
>>> +                            int cpu)
>>> +{
>>> +    unsigned long total_util, capacity;
>>> +
>>> +    if (!sched_util_fits_capacity_active())
>>> +        return false;
>>> +    total_util = READ_ONCE(cpu_rq(cpu)->cfs.avg.util_est.enqueued) + 
>>> task_util;
>>> +    capacity = arch_scale_cpu_capacity(cpu) - 
>>> arch_scale_thermal_pressure(cpu);
>>
>> scale_rt_capacity(cpu) could provide the remaining cpu capacity after 
>> substracted by
>> the side activity(rt tasks/thermal pressure/irq time), maybe it would 
>> be more accurate?
> 
> AFAIU, scale_rt_capacity(cpu) works similarly to capacity_of(cpu) and 
> considers blocked and sleeping tasks in the rq->avg_rt.util_avg and 
> rq->avg_dl.util_avg. I'm not sure sure about rq->avg_irq.util_avg and 
> thermal_load_avg().
> 
> This goes against what is needed here: we need a utilization that only 
> considers enqueued runnable tasks (exluding blocked and sleeping tasks). 
> Or am I missing something ?
> 

I was wrong. Looking more closely at dl and rt sched classes, unlike the 
fair sched class, they don't appear to take into account 
sleeping/blocked tasks in their util_avg. They just accumulate the rq 
util_sum and derive a rq util_avg from it. Likewise for thermal and irq.

So both capacity_of(cpu) and scale_rt_capacity(cpu) would appear to do 
what we need here, but AFAIU capacity_of(cpu) is based on a metric which 
is only updated once per jiffy or so.

Let me try using scale_rt_capacity(cpu) then.

Thanks!

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

