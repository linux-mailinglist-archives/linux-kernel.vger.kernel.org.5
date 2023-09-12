Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B8E079D283
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 15:40:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235580AbjILNkS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 09:40:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232977AbjILNkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 09:40:15 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4E6E310CE;
        Tue, 12 Sep 2023 06:40:11 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CD0F0C15;
        Tue, 12 Sep 2023 06:40:47 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 42D103F5A1;
        Tue, 12 Sep 2023 06:40:09 -0700 (PDT)
Message-ID: <979a9e2f-06a8-1936-b5cd-2949eca99b21@arm.com>
Date:   Tue, 12 Sep 2023 15:40:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/4] sched: cpufreq: Fix apply_dvfs_headroom() escaping
 uclamp constraints
Content-Language: en-US
To:     Qais Yousef <qyousef@layalina.io>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Lukasz Luba <lukasz.luba@arm.com>
References: <20230820210640.585311-1-qyousef@layalina.io>
 <20230820210640.585311-3-qyousef@layalina.io>
 <CAKfTPtDY48jpO+b-2KXawzxh-ty+FMKX6YUXioNR7kpgO=ua6Q@mail.gmail.com>
 <20230829163740.uadhv2jfjuumqk3w@airbuntu>
 <CAKfTPtCP6uX79dOrzN4PxFTMBFrDAMOOrWyZrsVypUQ0RY7BAA@mail.gmail.com>
 <20230907215555.exjxho34ntkjmn6r@airbuntu>
 <CAKfTPtA8Ljy4NBqjw8Wj4pEFc-OCR55QPuwh+5GgrHN6u+ugsg@mail.gmail.com>
 <20230910174638.qe7jqq6mq36brh6o@airbuntu>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20230910174638.qe7jqq6mq36brh6o@airbuntu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/09/2023 19:46, Qais Yousef wrote:
> On 09/08/23 16:30, Vincent Guittot wrote:
> 

[...]

>>>> above 512 whatever the current (720)  formula or your proposal (608).
>>>> In the case of uclamp, it should be applied after having been scaled
>>>> by irq time.
>>>
>>> I lost you a bit here. I'm not sure how you reached the 720 and 608 numbers.
>>
>> My bad, I finally decided to use an irq pressure of 128 in my
>> calculation but forgot to change the value in my email
>>
>>>
>>> So the way I'm proposing it here
>>>
>>>         util = cfs + rt + dvfs_headroom(cfs+rt) = 800 + 0.25 * 800 = 1000
>>>         util = uclamp_rq_util_with(rq, util, NULL) = 512
>>>         util = scale_rq_capacity(512, 256, 1024) = 0.75 * 512 = 384
>>>         util += dvfs_headroom(irq) = 384 + 256 + 0.25 * 256 = 704
>>>         util += dvfs_headroom(dl_bw) = 704
>>>
>>>>
>>>> So we should have reported utilization of 720 with a bandwidth
>>>> requirement of 512 and then cpufreq can applies its headroom if needed
>>>
>>> The key part I'm changing is this
>>>
>>>         util = cfs + rt + dvfs_headroom(cfs+rt) = 800 + 0.25 * 800 = 1000
>>>         util = uclamp_rq_util_with(rq, util, NULL) = 512
>>>
>>> Before we had (assume irq, rt and dl are 0 for simplicity and a single task is
>>> running)
>>>
>>>         util = cfs = 800
>>>         util = uclamp_rq_util_with(rq, util, NULL) = 512
>>>         util = dvfs_headroom(util) = 512 * 0.25 * 512 = 640
>>>
>>> So we are running higher than we are allowed to. So applying the headroom
>>> after taking uclamp constraints into account is the problem.

I'm not sure I understood all the example math in this thread correctly:

Examples:

irq = 128 or 256

util = 800 uclamp = 512


--- current code:

((util_cfs + util_rt) * ((max - irq) / max) + irq + dl_bw) * scale

<- uclamped(cfs+rt) ->

<--               scale_irq_capacity()                  -->|<-- map_util_perf() 
                                                               / (headroom())  

irq = 128: (512 * (1024 - 128) / 1024 + 128 + 0) * 1.25 = 576 * 1.25 = 720

irq = 256: (512 * (1024 - 256) / 1024 + 256 + 0) * 1.25 = 640 * 1.25 = 800


--- new approach:

irq = 128: (512 * (1024 - 128) / 1024 + 128 + 0.25 * 128)            = 608

irq = 256: (512 * (1024 - 256) / 1024 + 256 + 0.25 * 256)            = 704

            <->
            uclamped(cfs+rt+headroom(cfs+rt))

            <- scale_irq_capacity() ->

            <--               headroom(irq) ?        -->


Is the correct?

[...]
