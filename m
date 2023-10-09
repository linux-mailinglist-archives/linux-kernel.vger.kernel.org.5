Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57AE87BD974
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 13:22:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346220AbjJILWb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 07:22:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346215AbjJILWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 07:22:30 -0400
Received: from out-193.mta1.migadu.com (out-193.mta1.migadu.com [IPv6:2001:41d0:203:375::c1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6252AB
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 04:22:28 -0700 (PDT)
Message-ID: <23b7e38b-a5c9-7547-499f-efbf6abfbfe9@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1696850547;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p5fKDl+jfEdvEfYRITrazIhSAYorlwXMp+uweVVx3II=;
        b=s0oLI/U4+8tULlXdUKag4MRgckBz0xnJxogRrgzIdzby/pEV8oH0pH+EvdragiL9JtuzFo
        QKXS0G1YoDlOGUapBdgyGtrsHTxDpbL/AQ1bxnpe29TN6j+WtlKq2JkY+c3UDl8vlRS43d
        SIxfHIHd8U02WjqLEhcje+ttsAqIbEg=
Date:   Mon, 9 Oct 2023 19:22:19 +0800
MIME-Version: 1.0
Subject: Re: [PATCH] sched/rt: case sysctl_sched_rt_period to integer
Content-Language: en-US
To:     Ingo Molnar <mingo@kernel.org>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org
References: <20231008021538.3063250-1-yajun.deng@linux.dev>
 <ZSPYQqmTLwWYLoai@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Yajun Deng <yajun.deng@linux.dev>
In-Reply-To: <ZSPYQqmTLwWYLoai@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023/10/9 18:38, Ingo Molnar wrote:
> * Yajun Deng <yajun.deng@linux.dev> wrote:
>
>> proc_dointvec_minmax is for integer, but sysctl_sched_rt_period is an
>> unsigned integer. And sysctl_sched_rt_period takes values from 1 to
>> INT_MAX, so sysctl_sched_rt_period doesn't have to be an unsigned integer.
>>
>> Case sysctl_sched_rt_period to integer. Also, change the maximum value
>> of sysctl_sched_rt_runtime to sysctl_sched_rt_period.
>>
>> Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
>> ---
>>   kernel/sched/rt.c    | 6 +++---
>>   kernel/sched/sched.h | 2 +-
>>   2 files changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
>> index 88fc98601413..76d82a096e03 100644
>> --- a/kernel/sched/rt.c
>> +++ b/kernel/sched/rt.c
>> @@ -16,7 +16,7 @@ struct rt_bandwidth def_rt_bandwidth;
>>    * period over which we measure -rt task CPU usage in us.
>>    * default: 1s
>>    */
>> -unsigned int sysctl_sched_rt_period = 1000000;
>> +int sysctl_sched_rt_period = 1000000;
>>   
>>   /*
>>    * part of the period that we allow rt tasks to run in us.
>> @@ -34,7 +34,7 @@ static struct ctl_table sched_rt_sysctls[] = {
>>   	{
>>   		.procname       = "sched_rt_period_us",
>>   		.data           = &sysctl_sched_rt_period,
>> -		.maxlen         = sizeof(unsigned int),
>> +		.maxlen         = sizeof(int),
>>   		.mode           = 0644,
>>   		.proc_handler   = sched_rt_handler,
>>   		.extra1         = SYSCTL_ONE,
>> @@ -47,7 +47,7 @@ static struct ctl_table sched_rt_sysctls[] = {
>>                .data           = &sysctl_sched_rt_runtime,          # added for clarity
>>   		.mode           = 0644,
>>   		.proc_handler   = sched_rt_handler,
>>   		.extra1         = SYSCTL_NEG_ONE,
>> -		.extra2         = SYSCTL_INT_MAX,
>> +		.extra2         = (void *)&sysctl_sched_rt_period,
> Yeah, so I suppose this is a good change and desirable, also because
> sysctl_sched_rt_period is already an int, and all the calculus around these
> figures is 'int' based. So having an 'unsigned int' is indeed confusing and
> doesn't encode the true sysctl limit correctly.
>
> But I don't think the checking is full with this patch applied either: if
> sysctl_sched_rt_period is shrunk below the current value of
> sysctl_sched_rt_runtime, then sysctl_sched_rt_runtime will stay out of
> bounds indefinitely, right?


No, 'sysctl_sched_rt_runtime > sysctl_sched_rt_period' in 
sched_rt_global_validate() will make sure

sysctl_sched_rt_period doesn't below sysctl_sched_rt_runtime.

>
> I guess this comes with the territory of internal sysctls though.
>
> Thanks,
>
> 	Ingo
