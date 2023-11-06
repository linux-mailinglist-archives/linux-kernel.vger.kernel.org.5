Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 091E77E2ACC
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 18:17:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231685AbjKFRRp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 12:17:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbjKFRRo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 12:17:44 -0500
Received: from smtpout.efficios.com (unknown [IPv6:2607:5300:203:b2ee::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADBA083
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 09:17:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1699291058;
        bh=1Bm79slS+MhiQC1oY45zbKcFvD9MPaHvt0Pu2hSc8sM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=SdQ+RVgHzdEIuddxBqmxT5/Hl3/CHdu0CX0W74LV/p5sw1GxTNnkBz07X4NCNO7Lm
         sVr8cQHhx4uPOoqZ6cBl6l2pPz7F2+u1rcDgOEdL2p3iJuiqUndwEb6uruE6PzSo/f
         qm8CvjMRrV6wk7bRkPXTRNJaIqpsACKrCOs+U/H4hKv3xxTsHUx4JpBHje1k+cUBzk
         YZmV1qp8CLPPyPkVr9pW3jPnol8wRPF7EYJGskRlcAVZqbsDI2xlQP6TSupaHqgQsC
         /Yvnazw0cWgvl4QICVbAjStdJ8VyR5cqIT9RxOgewKysgxJbtEhuAzs9vl/wsOQ0EV
         tyUTUkawLjGNg==
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4SPJ2B2wXkz1b6c;
        Mon,  6 Nov 2023 12:17:38 -0500 (EST)
Message-ID: <b7f25858-ab0e-41aa-90a9-35d8348fc206@efficios.com>
Date:   Mon, 6 Nov 2023 12:18:03 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 0/2] sched/fair migration reduction features
Content-Language: en-US
To:     K Prateek Nayak <kprateek.nayak@amd.com>,
        Chen Yu <yu.c.chen@intel.com>
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
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>, x86@kernel.org
References: <20231019160523.1582101-1-mathieu.desnoyers@efficios.com>
 <85b710a9-5b26-b0df-8c21-c2768a21e182@amd.com>
 <ZUh/LK4iy3ukVaCn@chenyu5-mobl2.ccr.corp.intel.com>
 <a95bab2c-7f7a-18a2-6307-ffcdef4e2726@amd.com>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <a95bab2c-7f7a-18a2-6307-ffcdef4e2726@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-11-06 02:06, K Prateek Nayak wrote:
> Hello Chenyu,
> 
> On 11/6/2023 11:22 AM, Chen Yu wrote:
>> On 2023-10-27 at 08:57:00 +0530, K Prateek Nayak wrote:
>>> Hello Mathieu,
>>>
>>> On 10/19/2023 9:35 PM, Mathieu Desnoyers wrote:
>>>> Hi,
>>>>
>>>> This series introduces two new scheduler features: UTIL_FITS_CAPACITY
>>>> and SELECT_BIAS_PREV. When used together, they achieve a 41% speedup of
>>>> a hackbench workload which leaves some idle CPU time on a 192-core AMD
>>>> EPYC.
>>>>
>>>> The main metrics which are significantly improved are:
>>>>
>>>> - cpu-migrations are reduced by 80%,
>>>> - CPU utilization is increased by 17%.
>>>>
>>>> Feedback is welcome. I am especially interested to learn whether this
>>>> series has positive or detrimental effects on performance of other
>>>> workloads.
>>>
>>> I got a chance to test this series on a dual socket 3rd Generation EPYC
>>> System (2 x 64C/128T). Following is a quick summary:
>>>
>>> - stream and ycsb-mongodb don't see any changes.
>>>
>>> - hackbench and DeathStarBench see a major improvement. Both are high
>>>    utilization workloads with CPUs being overloaded most of the time.
>>>    DeathStarBench is known to benefit from lower migration count. It was
>>>    discussed by Gautham at OSPM '23.
>>>
>>> - tbench, netperf, and sch bench regresses. The former two when the
>>>    system is near fully loaded, and the latter for most cases.
>>
>> Does it mean hackbench gets benefits when the system is overloaded, while
>> tbench/netperf do not get benefit when the system is underloaded?
> 
> Yup! Seems like that from the results. From what I have seen so far,
> there seems to be a work conservation aspect to hackbench where if we
> reduce the time spent in the kernel (by reducing time to decide on the
> target which Mathieu's patch [this one] achieves,

I am confused by this comment.

Quoting Daniel Bristot, "work conserving" is defined as "in a system 
with M processor, the M "higest priority" must be running (in 
real-time)". This should apply to other scheduling classes as well. This 
definition fits with this paper's definition [1]: "The Linux scheduler 
is work-conserving, meaning that it should never leave cores idle if 
there is work to do."

Do you mean something different by "work conservation" ?

Just in case, I've made the following experiment to figure out if my 
patches benefit from having less time spent in select_task_rq_fair(). I 
have copied the original "select_idle_sibling()" into a separate 
function "select_idle_sibling_orig()", which I call at the beginning of 
the new "biased" select_idle_sibling. I use its result in an empty asm 
volatile, which ensures that the code is not optimized away. Then the 
biased function selects the runqueue with the new biased approach.

The result with hackbench is that the speed up is still pretty much the 
same with or without the added "select_idle_sibling_orig()" call.

Based on this, my understanding is that the speed up comes from 
minimizing the amount of migrations (and the side effects caused by 
those migrations such as runqueue locks and cache misses), rather than 
by making select_idle_sibling faster.

So based on this, I suspect that we could add some overhead to 
select_task_runqueue_fair if it means we do a better task placement 
decision and minimize migrations, and that would still provide an 
overall benefit performance-wise.

> there is also a
> second order effect from another one of Mathieu's Patches that uses
> wakelist but indirectly curbs the SIS_UTIL limits based on Aaron's
> observation [1] thus reducing time spent in select_idle_cpu())
> hackbench results seem to improve.

It's possible that an indirect effect of bias towards prev runqueue is 
to affect the metrics used by select_idle_cpu() as well and make it 
return early.

I've tried adding a 1000 iteration barrier() loop within 
select_idle_sibling_orig(), and indeed the hackbench time goes from 29s 
to 31s. Therefore, slowing down the task rq selection does have some impact.

> 
> [1] https://lore.kernel.org/lkml/20230905072141.GA253439@ziqianlu-dell/
> 
> schbench, tbench, and netperf see that wakeups are faster when the
> client and server are on same LLC so consolidation as long as there is
> one task per run queue for under loaded case is better than just keeping
> them on separate LLCs.

What is faster for the 1:1 client/server ping-pong scenario: having the 
client and server on the same LLC, but different runqueues, or having 
them share a single runqueue ? If they wait for each other, then I 
suspect it's better to place them on the same runqueue as long as there 
is capacity left.

> 
>>
>>>    All these benchmarks are client-server / messenger-worker oriented and is
>>>    known to perform better when client-server / messenger-worker are on
>>>    same CCX (LLC domain).
>>
>> I thought hackbench should also be of client-server mode, because hackbench has
>> socket/pipe mode and exchanges datas between sender/receiver.
> 
> Yes but its N:M nature makes it slightly complicated to understand where
> the cache benefits disappear and the work conservation benefits become
> more prominent.

The N:M nature of hackbench AFAIU causes N-server *and* M-client tasks 
to pull each other pretty much randomly, therefore trashing cache locality.

I'm still unclear about the definition of "work conservation" in this 
discussion.

> 
>>
>> This reminds me of your proposal to provide user hint to the scheduler
>> to whether do task consolidation vs task spreading, and could this also
>> be applied to Mathieu's case? For task or task group with "consolidate"
>> flag set, tasks prefer to be woken up on target/previous CPU if the wakee
>> fits into that CPU. In this way we could bring benefit and not introduce
>> regress.
> 
> I think even a simple WF_SYNC check will help tbench and netperf case.
> Let me get back to you with some data on different variants of hackbench
> wit the latest tip.

AFAIU (to be double-checked) the hackbench workload also has WF_SYNC, 
which prevents us from using this flag to distinguish between 1:1 
server/client and N:M scenarios. Or am I missing something ?

Thanks,

Mathieu

[1] https://people.ece.ubc.ca/sasha/papers/eurosys16-final29.pdf

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

