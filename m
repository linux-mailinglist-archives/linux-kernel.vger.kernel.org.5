Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18F4D80C7D9
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 12:22:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234367AbjLKLWo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 06:22:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234973AbjLKLPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 06:15:33 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 510E2D1;
        Mon, 11 Dec 2023 03:15:39 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4841EFEC;
        Mon, 11 Dec 2023 03:16:25 -0800 (PST)
Received: from [10.57.85.15] (unknown [10.57.85.15])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2D2FD3F762;
        Mon, 11 Dec 2023 03:15:37 -0800 (PST)
Message-ID: <a6c13b56-3ad9-419d-a22c-5a2e302200e0@arm.com>
Date:   Mon, 11 Dec 2023 11:15:35 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] sched/schedutil: Ignore update requests for short
 running tasks
To:     Qais Yousef <qyousef@layalina.io>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Lukasz Luba <lukasz.luba@arm.com>, Wei Wang <wvw@google.com>,
        Rick Yiu <rickyiu@google.com>,
        Chung-Kai Mei <chungkai@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
References: <20231208015242.385103-1-qyousef@layalina.io>
 <20231208015242.385103-4-qyousef@layalina.io>
 <f61a3329-4223-4995-8732-030430d19ea4@arm.com>
 <20231210222225.ukocvimws6ecgsmy@airbuntu>
Content-Language: en-US
From:   Hongyan Xia <hongyan.xia2@arm.com>
In-Reply-To: <20231210222225.ukocvimws6ecgsmy@airbuntu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/12/2023 22:22, Qais Yousef wrote:
> Hi Hongyan
> 
> On 12/08/23 10:42, Hongyan Xia wrote:
> 
>> What is a big concern is a normal task and a uclamp_max task running on the
>> same rq. If the uclamp_max task is 1024 but capped by uclamp_max at the
>> lowest OPP, and the normal task has no uclamp but a duty cycle, then when
> 
> You mean util_avg is 1024 but capped to lowest OPP? uclamp_max is repeated but
> couldn't decipher what you meant to write instead.
> 
>> the normal task wakes up on the rq, it'll be the highest OPP. When it
>> sleeps, the ulamp_max is back and at the lowest OPP. This square-wave
>> problem to me is a much bigger concern than an infrequent spike. If
>> CONFIG_HZ is 1000, this square wave's frequency is 500 switching between
> 
> If the rq->util_avg is 1024, then for any task that is running, the requested
> frequency should be max. If there's a task that is capped by uclamp_max, then
> this task should not run at max.
> 
> So other tasks should have run at max; why you don't want them to run at max?

Because it saves power. If there's a 1024 task capped at 300 and a true 
300 task without uclamp on the same rq, there's no need to run the CPU 
at more than 600. Running it at 1024 ignores the uclamp_max and burns 
battery when it's not needed.

>> highest and lowest OPP, which is definitely unacceptable.
> 
> How come so definitive? How did you reach this definitive conclusion?

You are right. After talking to our firmware and silicon engineers they 
don't think switching between the highest and lowest OPP 500 times a 
second can have damaging effects, so I retract the 'unacceptable' comment.

>> The problem I think with filtering is, under this condition, should we
>> filter out the lowest OPP or the highest? Neither sounds like a good answer
>> because neither is a short-running task and the correct answer might be
>> somewhere in between.
> 
> We only ignore uclamp requirement with the filter. schedutil is drive by the rq
> utilization signal as normal. It is only the fact should we apply
> uclamp_min/max or not.
> 
> It seems you think we need to modify the rq->util_avg. And this should not be
> the case. uclamp should not change how PELT accounting works; just modify how
> some decisions based on it are taken.

I agree, uclamp shouldn't change PELT, but my series doesn't. Just like 
util_est which boosts util_avg, my patches don't touch util_avg but 
simply introduces util_min, util_max on the side of util_avg. I fail to 
see why it's okay for util_est to bias util_avg but not okay for me to 
do so. If this is the case, then the 'util_guest' proposal should also 
be right out rejected on the same ground.

> It is true there's a corner case where util_avg could be wrong under the
> documented limitation. But this is not related to max-aggregation and its
> solution needs some creativity in handling pelt accounting under these
> conditions.
> 
> Generally; capping that hard stirs question why userspace is doing this. We
> don't want to cripple tasks, but prevent them from consuming inefficient energy
> points. Otherwise they should make adequate progress. I'd expect uclamp_max to
> be more meaningful for tasks that actually need to run at those higher
> expensive frequencies.
> 
> So the corner case warrants fixing, but it is not a nuance in practice yet. And
> it is a problem of failing to calculate the stolen idle time as we don't have
> any under these corner conditions (Vincent can make a more accurate statement
> than me here). It has nothing to do with how to handle performance requirements
> of multiple RUNNABLE tasks.
> 
>> Sorry to ramble on this again and again, but I think filtering is addressing
>> the symptom, not the cause. The cause is we have no idea under what
>> condition a util_avg was achieved. The 1024 task in the previous example
>> would be much better if we extend it into
> 
> I think the other way around :-) I think you're mixing the root cause of that
> limitation with how uclamp hints for multiple tasks should be handled - which
> is what is being fixed here.
> 
> I wrote the documentation and did the experiments to see how PELT behaves under
> extreme conditions. And it says *it can break PELT*.
> 
>> [1024, achieved at uclamp_min 0, achieved at uclamp_max 300]
> 
> Why you think this is the dominant use case? And why do you think this is
> caused by max-aggregation? This is a limitation of PELT accounting and has
> nothing to do with max-aggregation which is how multiple uclamp hints for
> RUNNABLE tasks are handled.
> 
> Have you actually seen it practice? We haven't come across this problem yet. We
> just want to avoid using expensive OPPs, but capping too had is actually
> a problem as it can cause starvation for those tasks.
> 
> Is it only the documentation what triggered this concern about this corner
> case? I'm curious what have you seen.

This is not a corner case. Having a uclamp_max task and a normal task on 
the same rq is fairly common. My concern isn't the 'frequency spike' 
problem from documentation. My concern comes from benchmarks, which is 
high-frequency square waves. An occasional spike isn't worrying, but the 
square waves are.

>> If we know 1024 was done under uclamp_max of 300, then we know we don't need
>> to raise to the max OPP. So far, we carry around a lot of different new
>> variables but not these two which we really need.
> 
> This problem is independent of how uclamp hint of multiple tasks should be
> accounted for by the governor. This is a limitation of how PELT accounting
> works. And to be honest, if you think more about it, this 300 tasks is already
> a 1024 on current littles that has a capacity of 200 or less. And the capacity
> of the mids at lowest OPP usually starts at a capacity around 100 or something.
> Can't see it hit this problem while running on middle.  I think this 300 tasks
> will already run near lowest OPP at the big even without uclamp_max being
> 0 - it is that small for it.
> 
> So not sure on what systems you saw this problem on, and whether at all this is
> a problem in practice. Like priority/nice and other sched attributes; you can
> pick a wrong combination and shoot your self in the foot.
> 
> As I put in the documentation, this limitation will only hit if the actual task
> capacity reaches some magical ratio. I'd expect practically these tasks to
> still see idle time and get their util_avg corrected eventually.

Like in the previous comment, it's square waves that happen 500 times a 
second I saw in benchmarks that's worrying, not the occasional spike in 
documentation. I doubt we can say that a uclamp_max task and a normal 
task running on the same rq is a corner case.

> So worth a fix, not related to handling performance requests for multiple
> tasks, and not urgently needed as nothing is falling apart because of it for
> the time being at least.

Also, I think there's still an unanswered question. If there's a 1024 
task with a uclamp_min of 300 and a 300-util task with default uclamp on 
the same rq, which currently under max aggregation switches between 
highest and lowest OPP, should we filter out the high OPP or the low 
one? Neither is a short-running task. We could designate this as a 
corner case (though I don't think so), but wouldn't it be nice if we 
don't have any of these problems in the first place?

Hongyan
