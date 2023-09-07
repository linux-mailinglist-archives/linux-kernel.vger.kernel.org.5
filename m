Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AD687975A8
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 17:53:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243110AbjIGPxa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 11:53:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237313AbjIGPl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 11:41:27 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CCAFC1739;
        Thu,  7 Sep 2023 08:37:53 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C82D41764;
        Thu,  7 Sep 2023 07:42:16 -0700 (PDT)
Received: from [10.57.92.126] (unknown [10.57.92.126])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 464C43F766;
        Thu,  7 Sep 2023 07:41:37 -0700 (PDT)
Message-ID: <cf5c628a-e047-b5e0-b2a0-f2b280015d02@arm.com>
Date:   Thu, 7 Sep 2023 15:42:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [RFC PATCH 0/7] sched: cpufreq: Remove magic margins
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Qais Yousef <qyousef@layalina.io>
References: <20230827233203.1315953-1-qyousef@layalina.io>
 <a6365f63-4669-15e5-b843-f4bfb1bd5e68@arm.com>
 <20230906211850.zyvk6qtt6fvpxaf3@airbuntu>
 <20230907132631.GF10955@noisy.programming.kicks-ass.net>
 <8919ed14-8d19-d964-2278-3303a5bda8ee@arm.com>
 <20230907142923.GJ10955@noisy.programming.kicks-ass.net>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20230907142923.GJ10955@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/7/23 15:29, Peter Zijlstra wrote:
> On Thu, Sep 07, 2023 at 02:57:26PM +0100, Lukasz Luba wrote:
>>
>>
>> On 9/7/23 14:26, Peter Zijlstra wrote:
>>> On Wed, Sep 06, 2023 at 10:18:50PM +0100, Qais Yousef wrote:
>>>
>>>> This is probably controversial statement. But I am not in favour of util_est.
>>>> I need to collect the data, but I think we're better with 16ms PELT HALFLIFE as
>>>> default instead. But I will need to do a separate investigation on that.
>>>
>>> I think util_est makes perfect sense, where PELT has to fundamentally
>>> decay non-running / non-runnable tasks in order to provide a temporal
>>> average, DVFS might be best served with a termporal max filter.
>>>
>>>
>>
>> Since we are here...
>> Would you allow to have a configuration for
>> the util_est shifter: UTIL_EST_WEIGHT_SHIFT ?
>>
>> I've found other values than '2' better in some scenarios. That helps
>> to prevent a big task to 'down' migrate from a Big CPU (1024) to some
>> Mid CPU (~500-700 capacity) or even Little (~120-300).
> 
> Larger values, I'm thinking you're after? Those would cause the new
> contribution to weight less, making the function more smooth, right?

Yes, more smooth, because we only use the 'ewma' goodness for decaying
part (not the raising [1]).

> 
> What task characteristic is tied to this? That is, this seems trivial to
> modify per-task.

In particular Speedometer test and the main browser task, which reaches
~900util, but sometimes vanish and waits for other background tasks
to do something. In the meantime it can decay and wake-up on
Mid/Little (which can cause a penalty to score up to 5-10% vs. if
we pin the task to big CPUs). So, a longer util_est helps to avoid
at least very bad down migration to Littles...

[1] https://elixir.bootlin.com/linux/v6.5.1/source/kernel/sched/fair.c#L4442
