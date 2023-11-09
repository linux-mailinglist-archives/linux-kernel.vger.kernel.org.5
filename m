Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B2F17E6206
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 03:11:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231742AbjKICLm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 21:11:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjKICLk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 21:11:40 -0500
Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [IPv6:2001:41d0:203:375::af])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F16C258A
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 18:11:38 -0800 (PST)
Message-ID: <42a2dddc-64cf-90b7-e6e3-2ca33f7e9950@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1699495896;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=b9YACYTCreJim1FpgEO6jmK4XJvCfIwTvAhC/eGGzOs=;
        b=E8ATByKvwiex2V1EhSlMhMVqO6eDt0ckueJ3LtpruKRjeSylP2n97pyr7ISsrU3AvoxZ3W
        CMB0Dz+U3FIgQxdNYDsl558V35DA9YnfY+6jax3PefPpvOUocYlEGBfYlDdh3tCMhBGlGv
        FVf/pU1PA91oi0qGN8Kd1UnfpYHhSSo=
Date:   Thu, 9 Nov 2023 10:11:29 +0800
MIME-Version: 1.0
Subject: Re: [PATCH] sched/rt: Redefine RR_TIMESLICE to 100 msecs
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        vschneid@redhat.com, linux-kernel@vger.kernel.org
References: <20231018081709.2289264-1-yajun.deng@linux.dev>
 <20231108115501.06beac86@gandalf.local.home>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Yajun Deng <yajun.deng@linux.dev>
In-Reply-To: <20231108115501.06beac86@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023/11/9 00:55, Steven Rostedt wrote:
> On Wed, 18 Oct 2023 16:17:09 +0800
> Yajun Deng <yajun.deng@linux.dev> wrote:
>
>> The RR_TIMESLICE is currently defined as the jiffies corresponding to
>> 100 msecs. And then sysctl_sched_rr_timeslice will convert RR_TIMESLICE
>> to 100 msecs. These are opposite calculations.
> Do we care? The compiler will do this at build time. What's wrong with the
> current code?


Yes, two calculations may introduce rounding error like the following.

>> There are msecs_to_jiffies and jiffies_to_msecs in sched_rr_handler.
>> These are also opposite calculations.
>>
>> Redefine RR_TIMESLICE to 100 msecs, only sched_rr_timeslice needs to
>> convert RR_TIMESLICE to jiffies.
> Why? What's the difference if we do it in one place or another? The
> calculations are done at compile time anyway. There's no performance
> benefit by this change.
>
The current code requires two calculations, it only needs to be 
calculated once after this patch.


>> Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
>> ---
>>   include/linux/sched/rt.h |  2 +-
>>   init/init_task.c         |  2 +-
>>   kernel/sched/rt.c        | 12 +++++-------
>>   3 files changed, 7 insertions(+), 9 deletions(-)
>>
>> diff --git a/include/linux/sched/rt.h b/include/linux/sched/rt.h
>> index b2b9e6eb9683..74f8f456a804 100644
>> --- a/include/linux/sched/rt.h
>> +++ b/include/linux/sched/rt.h
>> @@ -58,6 +58,6 @@ extern void normalize_rt_tasks(void);
>>    * default timeslice is 100 msecs (used only for SCHED_RR tasks).
>>    * Timeslices get refilled after they expire.
>>    */
>> -#define RR_TIMESLICE		(100 * HZ / 1000)
>> +#define RR_TIMESLICE		(100)
> If anything, if this change is accepted, the above should be renamed to
> RR_TIMESLICE_MS to explicitly state that they are in milliseconds.

Okay.

>>   
>>   #endif /* _LINUX_SCHED_RT_H */
>> diff --git a/init/init_task.c b/init/init_task.c
>> index 5727d42149c3..86619a425342 100644
>> --- a/init/init_task.c
>> +++ b/init/init_task.c
>> @@ -94,7 +94,7 @@ struct task_struct init_task
>>   	},
>>   	.rt		= {
>>   		.run_list	= LIST_HEAD_INIT(init_task.rt.run_list),
>> -		.time_slice	= RR_TIMESLICE,
>> +		.time_slice	= (RR_TIMESLICE * HZ) / MSEC_PER_SEC,
>>   	},
>>   	.tasks		= LIST_HEAD_INIT(init_task.tasks),
>>   #ifdef CONFIG_SMP
>> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
>> index 6aaf0a3d6081..7c0e912094a9 100644
>> --- a/kernel/sched/rt.c
>> +++ b/kernel/sched/rt.c
>> @@ -4,7 +4,7 @@
>>    * policies)
>>    */
>>   
>> -int sched_rr_timeslice = RR_TIMESLICE;
>> +int sched_rr_timeslice = (RR_TIMESLICE * HZ) / MSEC_PER_SEC;
>>   /* More than 4 hours if BW_SHIFT equals 20. */
>>   static const u64 max_rt_runtime = MAX_BW;
>>   
>> @@ -25,7 +25,7 @@ int sysctl_sched_rt_period = 1000000;
>>   int sysctl_sched_rt_runtime = 950000;
>>   
>>   #ifdef CONFIG_SYSCTL
>> -static int sysctl_sched_rr_timeslice = (MSEC_PER_SEC * RR_TIMESLICE) / HZ;
>> +static int sysctl_sched_rr_timeslice = RR_TIMESLICE;
> So you are just moving calculations around that get done at compile time?
>

It's a constant which avoids the rounding error in the calculation. Like 
commit:

c7fcb99877f9 ("sched/rt: Fix sysctl_sched_rr_timeslice intial value" ).

>>   static int sched_rt_handler(struct ctl_table *table, int write, void *buffer,
>>   		size_t *lenp, loff_t *ppos);
>>   static int sched_rr_handler(struct ctl_table *table, int write, void *buffer,
>> @@ -3014,12 +3014,10 @@ static int sched_rr_handler(struct ctl_table *table, int write, void *buffer,
>>   	 * Also, writing zero resets the timeslice to default:
>>   	 */
>>   	if (!ret && write) {
>> -		sched_rr_timeslice =
>> -			sysctl_sched_rr_timeslice <= 0 ? RR_TIMESLICE :
>> -			msecs_to_jiffies(sysctl_sched_rr_timeslice);
>> -
>>   		if (sysctl_sched_rr_timeslice <= 0)
>> -			sysctl_sched_rr_timeslice = jiffies_to_msecs(RR_TIMESLICE);
>> +			sysctl_sched_rr_timeslice = RR_TIMESLICE;
>> +
>> +		sched_rr_timeslice = msecs_to_jiffies(sysctl_sched_rr_timeslice);
> If anything, this patch may make this code easier to follow, but it's up to
> Peter if he wants to take it or not.
>
> Agnostic-by: Steven Rostedt (Google) <rostedt@goodmis.org>
>
> -- Steve
>
>
>
>>   	}
>>   	mutex_unlock(&mutex);
>>   
