Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD3277924D2
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233081AbjIEP7y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 11:59:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354581AbjIEMpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 08:45:31 -0400
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40608CE
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 05:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1693917926;
        bh=IIsnhCpgh9xfI2o4DIoRmWQECdvxv83InU7FrELCPnA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=IDLaHK+mUMgqZ73TXZs9VRaY1j4m3HAxLAWX/aNju8Gg0ImvdmIXoNyuln/icUkJH
         w6WPsyb0mmpDEninwuxIcHg6BCWYN+qKQzwJClPx+QJJjapoOp3Z6SE67IULaDclK5
         zQGt9XQOpIOf3mUkSgqEdfWWD7lhNmTf5j22RYv6+SpOAP/e9CnGod4AvqIbI+Kmuv
         +10sC5B44veisCkiMUNhgKJ1famSEyZQiNID/Va9U/5hpeWRqiUSlF8I3Ig0oDCq+r
         lEhBJ1ak2nQEn0lT58WfGs3cgmtDeHEMfE3WKi2asBLPImCuG2dep+FDUQgUf2lFNt
         0j92kqAWpQS0Q==
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4Rg4wk19zwz1NMT;
        Tue,  5 Sep 2023 08:45:26 -0400 (EDT)
Message-ID: <f147f731-95e0-b0b9-9530-7028e6743146@efficios.com>
Date:   Tue, 5 Sep 2023 08:46:42 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [RFC PATCH v3 2/3] sched: Introduce cpus_share_l2c
Content-Language: en-US
To:     Aaron Lu <aaron.lu@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Swapnil Sapkal <Swapnil.Sapkal@amd.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>, x86@kernel.org
References: <20230822113133.643238-1-mathieu.desnoyers@efficios.com>
 <20230822113133.643238-3-mathieu.desnoyers@efficios.com>
 <04be42cb-0e8b-25f7-a34b-41b2873f39d4@efficios.com>
 <c7fe33f9-51bd-80e8-cb0e-1cefb20a61b9@efficios.com>
 <20230824075208.GA459974@ziqianlu-dell>
 <6e5ff343-0c4f-526c-eb53-890afb773563@efficios.com>
 <20230825064929.GC464990@ziqianlu-dell>
 <73d2be82-b4da-f87e-a1e3-5c187a268e69@efficios.com>
 <20230828111945.GA504382@ziqianlu-dell>
 <20230901134528.GA46365@ziqianlu-dell>
 <20230905072141.GA253439@ziqianlu-dell>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <20230905072141.GA253439@ziqianlu-dell>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/5/23 03:21, Aaron Lu wrote:
> On Fri, Sep 01, 2023 at 09:45:28PM +0800, Aaron Lu wrote:
>> On Mon, Aug 28, 2023 at 07:19:45PM +0800, Aaron Lu wrote:
>>> On Fri, Aug 25, 2023 at 09:51:19AM -0400, Mathieu Desnoyers wrote:
>>>> On 8/25/23 02:49, Aaron Lu wrote:
>>>>> On Thu, Aug 24, 2023 at 10:40:45AM -0400, Mathieu Desnoyers wrote:
>>>> [...]
>>>>>>> - task migrations dropped with this series for nr_group=20 and 32
>>>>>>>      according to 'perf stat'. migration number didn't drop for nr_group=10
>>>>>>>      but the two update functions' cost dropped which means fewer access to
>>>>>>>      tg->load_avg and thus, fewer task migrations. This is contradictory
>>>>>>>      and I can not explain yet;
>>>>>>
>>>>>> Neither can I.
>>>>>>
>>>>
>>>> [...]
>>>>
>>>>>>
>>>>>>> It's not clear to me why this series can reduce task migrations. I doubt
>>>>>>> it has something to do with more wakelist style wakeup becasue for this
>>>>>>> test machine, only a single core with two SMT threads share L2 so more
>>>>>>> wakeups are through wakelist. In wakelist style wakeup, the target rq's
>>>>>>> ttwu_pending is set and that will make the target cpu as !idle_cpu();
>>>>>>> This is faster than grabbing the target rq's lock and then increase
>>>>>>> target rq's nr_running or set target rq's curr to something else than
>>>>>>> idle. So wakelist style wakeup can make target cpu appear as non idle
>>>>>>> faster, but I can't connect this with reduced migration yet, I just feel
>>>>>>> this might be the reason why task migration reduced.
>>>>>>
>>>>>
>>>> [...]
>>>>>> I've tried adding checks for rq->ttwu_pending in those code paths on top of
>>>>>> my patch and I'm still observing the reduction in number of migrations, so
>>>>>> it's unclear to me how doing more queued wakeups can reduce migrations the
>>>>>> way it does.
>>>>>
>>>>> An interesting puzzle.
>>>>
>>>> One metric that can help understand the impact of my patch: comparing
>>>> hackbench from a baseline where only your load_avg patch is applied
>>>> to a kernel with my l2c patch applied, I notice that the goidle
>>>> schedstat is cut in half. For a given CPU (they are pretty much alike),
>>>> it goes from 650456 to 353487.
>>>>
>>>> So could it be that by doing queued wakeups, we end up batching
>>>> execution of the woken up tasks for a given CPU, rather than going
>>>> back and forth between idle and non-idle ? One important thing that
>>>> this changes is to reduce the number of newidle balance triggered.
>>>
>>> I noticed the majority(>99%) migrations are from wakeup path on this
>>> Intel SPR when running hackbench: ttwu() -> set_task_cpu() ->
>>> migrate_task_rq_fair(), so while I think it's a good finding that
>>> newidle balance dropped, it's probably not the reason why migration
>>> number dropped...
>>
>> I profiled select_idle_sibling() and found that with this series,
>> select_idle_cpu() tends to fail more and select_idle_sibling() fallbacks
>> to use target in the end, which equals to prev_cpu very often.
>>
>> Initially I think the reason why select_idle_cpu() failed more with this
>> series is because "wake_list style enqueue" can make the target cpu appear
>> as busy earlier and thus, it will be harder for select_idle_cpu() to
>> find an idle cpu overall. But I also suspect SIS_UTIL makes a difference
>> here: in vanilla kernel, the idle% is 8% and with this series, the idle%
>> is only 2% and SIS_UTIL may simply skip doing any search for idle cpu.
>> Anyway, I think I'll also need to profile select_idle_cpu() to see
>> what's going on there too.
> 
> Looks like the reduction in task migration is due to SIS_UTIL, i.e.
> select_idle_cpu() aborts a lot more after applying this series because
> system utilization increased.
> 
> Here are some numbers:
>                   @sis       @sic     @migrate_idle_cpu  @abort
> vanilla:       24640640   15883958     11913588          4148649
> this_series:   22345434   18597564      4294995         14319284
> 
> note:
> - @sis: number of times select_idle_sibling() called;
> - @sic: number of times select_idle_cpu() called;
> - @migrate_idle_cpu: number of times task migrated due to
>    select_idle_cpu() found an idle cpu that is different from prev_cpu;
> - @abort: number of times select_idle_cpu() aborts the search due to
>    SIS_UTIL.
> 
> All numbers are captured during a 5s window while running the below
> workload on a 2 sockets Intel SPR(56 cores, 112 threads per socket):
> hackbench -g 20 -f 20 --pipe --threads -l 480000 -s 100
> 
> So for this workload, I think this series is doing something good: it
> increased system utilization and due to SIS_UTIL, it also reduced task
> migration where task migration isn't very useful since system is already
> overloaded.

This is interesting. Did you also profile the impact of the patches on 
wake_affine(), especially wake_affine_idle() ? Its behavior did change 
very significantly in my tests, and this impacts the target cpu number 
received by select_idle_sibling(). But independently of what 
wake_affine() returns as target (waker cpu or prev_cpu), if 
select_idle_cpu() is trigger-happy and finds idle cores near that 
target, this will cause lots of migrations.

Based on your metrics, the ttwu-queued-l2 approach (in addition to 
reduce lock contention) appear to decrease the SIS_UTIL idleless level 
of the cpus enough to completely change the runqueue selection and 
migration behavior.

I fear that we hide a bad scheduler behavior under the rug by changing 
the idleless level of a specific workload pattern, while leaving the 
underlying root cause unfixed.

I'm currently working on a different approach: rate limit migrations. 
Basically, the idea is to detect when a task is migrated too often for 
its own good, and prevent the scheduler from migrating it for a short 
while. I get about 30% performance improvement with this approach as 
well (limit migration to 1 per 2ms window per task). I'll finish 
polishing my commit messages and send a series as RFC soon.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

