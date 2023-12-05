Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 591E080573B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 15:24:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346789AbjLEOYW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 09:24:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345909AbjLEOYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 09:24:21 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A20B2A1
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 06:24:27 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E6297139F;
        Tue,  5 Dec 2023 06:25:13 -0800 (PST)
Received: from [10.1.31.59] (e133649.arm.com [10.1.31.59])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8ACA73F6C4;
        Tue,  5 Dec 2023 06:24:25 -0800 (PST)
Message-ID: <7cad55e3-3a61-498a-9364-7a2d69a20757@arm.com>
Date:   Tue, 5 Dec 2023 14:24:23 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/6] sched/uclamp: Track uclamped util_avg in
 sched_avg
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Qais Yousef <qyousef@layalina.io>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Christian Loehle <christian.loehle@arm.com>,
        linux-kernel@vger.kernel.org
References: <cover.1696345700.git.Hongyan.Xia2@arm.com>
 <5564fc23d5e6425d069c36b4cef48edbe77fe64d.1696345700.git.Hongyan.Xia2@arm.com>
 <CAKfTPtBahrEDyaWqyyivmo=9Jagq4OBDv1bQm4AcBP2Xq_EpRw@mail.gmail.com>
Content-Language: en-US
From:   Hongyan Xia <hongyan.xia2@arm.com>
In-Reply-To: <CAKfTPtBahrEDyaWqyyivmo=9Jagq4OBDv1bQm4AcBP2Xq_EpRw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/12/2023 16:07, Vincent Guittot wrote:
> On Wed, 4 Oct 2023 at 11:05, Hongyan Xia <Hongyan.Xia2@arm.com> wrote:
>>
>> From: Hongyan Xia <hongyan.xia2@arm.com>
>>
>> Track a uclamped version of util_avg in sched_avg, which clamps util_avg
>> within [uclamp[UCLAMP_MIN], uclamp[UCLAMP_MAX]] every time util_avg is
>> updated. At the CFS rq level, cfs_rq->avg.util_avg_uclamp must always be
>> the sum of all util_avg_uclamp of entities on this cfs_rq. So, each
>> time the util_avg_uclamp of an entity gets updated, we also track the
>> delta and update the cfs_rq.
> 
> No please don't do that. Don't start to mix several different signals
> in one. Typically uclamp_min doen't say you want to use at least this
> amount of cpu capacity.

But I'd say with uclamp, PELT is already broken and is a mixed signal 
anyway. When uclamp is used, a util_avg value X doesn't mean X, it means 
X under some rq uclamp, and the worst part is that the rq uclamp may or 
may not have anything to do with this task's uclamp.

Pretending X is a true PELT value now (and not a mixed value) is why we 
have so many problems today. For example in the frequency spike problem, 
if a task A has no idle time under uclamp_max, its PELT does not reflect 
reality. The moment another task B comes in and uncap the rq uclamp_max, 
the current scheduler code thinks the 1024 of A means a real 1024, which 
is wrong and is exactly why we see a spike when B joins. It's also why 
we need to special case 0 spare capacity with recent patches, because rq 
util_avg has lost its original PELT meaning under uclamp.

Because X is not the true PELT, we always have to do something to bring 
it back into reality. What the current max aggregation code does is to 
introduce corner cases, like treating 0 spare capacity as potential 
opportunity to queue more tasks (which creates further problems in my 
tests), and maybe introducing uclamp load balancing special cases in the 
future, or introducing uclamp filtering to delay the effect of wrong 
PELT values.

What this series does is not much different. We keep the somewhat wrong 
value X, but we also remember under what uclamp values did we get that X 
to bring things back into reality, which means now we have [X, 
uclamp_min when X happens, uclamp_max when X happens]. To save space, 
this becomes [X, clamped X], which is what this series does. The 
original PELT value X is kept, but we use the clamped X in several 
places to improve our decisions.

> 
> With tasks with a util_avg of 10 but a uclamp min of 1024 what does it
> mean when you start  to sum this value ?

Like I replied in another comment, assuming a uclamp_min of 1024 is a 
hint to run the task on the big CPUs, I don't think it's right to 
directly use uclamp as a CPU placement indicator. A uclamp value may 
come from ADFP from userspace. An ADPF uclamp_min value of little CPU 
capacity + 1 certainly doesn't mean a game on purpose wants to avoid the 
little core. It simply means it wants at least this much performance, 
and whether this results in placing the game thread on a big CPU is 
purely the job of EAS (or CAS, etc.). We want to use little CPU + 1 as 
uclamp_min because we know the SoC and the little CPU is bad, but uclamp 
should be generic and should not rely on knowing the SoC.

Basically, under sum aggregation one would not use a uclamp_min value of 
1024 to place a small task on a big core. A uclamp_min of 1024 under sum 
aggregation has the meaning in ADPF, which is a hint to try to run me as 
fast as possible.

> 
> 
>> [...]
