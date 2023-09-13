Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5919379E439
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 11:53:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239557AbjIMJx7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 05:53:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233406AbjIMJxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 05:53:44 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7586D270C;
        Wed, 13 Sep 2023 02:53:04 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D61CD1FB;
        Wed, 13 Sep 2023 02:53:39 -0700 (PDT)
Received: from [10.57.94.11] (unknown [10.57.94.11])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DB1AC3F5A1;
        Wed, 13 Sep 2023 02:53:00 -0700 (PDT)
Message-ID: <74c48141-55c4-c09b-250f-c1d71f031a8c@arm.com>
Date:   Wed, 13 Sep 2023 10:53:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [RFC PATCH 0/7] sched: cpufreq: Remove magic margins
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Qais Yousef <qyousef@layalina.io>,
        Chris Redpath <Chris.Redpath@arm.com>
References: <20230827233203.1315953-1-qyousef@layalina.io>
 <a6365f63-4669-15e5-b843-f4bfb1bd5e68@arm.com>
 <20230906211850.zyvk6qtt6fvpxaf3@airbuntu>
 <20230907132631.GF10955@noisy.programming.kicks-ass.net>
 <8919ed14-8d19-d964-2278-3303a5bda8ee@arm.com>
 <20230907142923.GJ10955@noisy.programming.kicks-ass.net>
 <cf5c628a-e047-b5e0-b2a0-f2b280015d02@arm.com>
 <20230907201609.GC14243@noisy.programming.kicks-ass.net>
 <f1b1b663-3a12-9e5d-932b-b3ffb5f02e14@arm.com>
 <CAKfTPtDd-HhF-YiNTtL9i5k0PfJbF819Yxu4YquzfXgwi7voyw@mail.gmail.com>
Content-Language: en-US
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <CAKfTPtDd-HhF-YiNTtL9i5k0PfJbF819Yxu4YquzfXgwi7voyw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vincent,

On 9/12/23 15:01, Vincent Guittot wrote:
> Hi Lukasz,
> 
> On Tue, 12 Sept 2023 at 13:51, Lukasz Luba <lukasz.luba@arm.com> wrote:
>>
>> Hi Peter,
>>
>> On 9/7/23 21:16, Peter Zijlstra wrote:
>>> On Thu, Sep 07, 2023 at 03:42:13PM +0100, Lukasz Luba wrote:
>>>
>>>>> What task characteristic is tied to this? That is, this seems trivial to
>>>>> modify per-task.
>>>>
>>>> In particular Speedometer test and the main browser task, which reaches
>>>> ~900util, but sometimes vanish and waits for other background tasks
>>>> to do something. In the meantime it can decay and wake-up on
>>>> Mid/Little (which can cause a penalty to score up to 5-10% vs. if
>>>> we pin the task to big CPUs). So, a longer util_est helps to avoid
>>>> at least very bad down migration to Littles...
>>>
>>> Do they do a few short activations (wakeup/sleeps) while waiting? That
>>> would indeed completely ruin things since the EWMA thing is activation
>>> based.
>>>
>>> I wonder if there's anything sane we can do here...
>>
>> My apologies for a delay, I have tried to push the graphs for you.
>>
>> The experiment is on pixel7*. It's running the browser on the phone
>> with the test 'Speedometer 2.0'. It's a web test (you can also run on
>> your phone) available here, no need to install anything:
>> https://browserbench.org/Speedometer2.0/
>>
>> Here is the Jupiter notebook [1], with plots of the signals:
>> - top 20 tasks' (based on runtime) utilization
>> - Util EST signals for the top 20 tasks, with the longer decaying ewma
>>     filter (which is the 'red' plot called 'ewma')
>> - the main task (comm=CrRendererMain) Util, Util EST and task residency
>>     (which tires to stick to CPUs 6,7* )
>> - the test score was 144.6 (while with fast decay ewma is ~134), so
>>     staying at big cpus (helps the score in this case)
>>
>> (the plots are interactive, you can zoom in with the icon 'Box Zoom')
>> (e.g. you can zoom in the task activation plot which is also linked
>> with the 'Util EST' on top, for this main task)
>>
>> You can see the util signal of that 'CrRendererMain' task and those
>> utilization drops in time, which I was referring to. When the util
>> drops below some threshold, the task might 'fit' into smaller CPU,
>> which could be prevented automatically byt maintaining the util est
>> for longer (but not for all).
> 
> I was looking at your nice chart and I wonder if you could also add
> the runnable _avg of the tasks ?

Yes, I will try today or tomorrow to add such plots as well.

> 
> My 1st impression is that the decrease happens when your task starts
> to share the CPU with some other tasks and this ends up with a
> decrease of its utilization because util_avg doesn't take into account
> the waiting time so typically task with an utilization of 1024, will
> see its utilization decrease because of other tasks running on the
> same cpu. This would explain the drop that you can see.
> 
>   I wonder if we should not take into account the runnable_avg when
> applying the ewm on util_est ? so the util_est will not decrease
> because of time sharing with other

Yes, that sounds a good idea. Let me provide those plots so we could
go further with the analysis. I will try to capture if that happens
to that particular task on CPU (if there are some others as well).


Thanks for jumping in to the discussion!

Lukasz
