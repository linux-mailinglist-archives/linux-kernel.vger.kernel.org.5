Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BA2F7871E5
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 16:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241206AbjHXOkM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 10:40:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241657AbjHXOjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 10:39:43 -0400
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD1A21BCD
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 07:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1692887976;
        bh=cIpKbCBGtmJxrqK+Wx62Hvkje2rgbArMlIn90VFw1Zs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=phwbwS4yL9Maw3YCY8n8DezoYN+iG+35QtII0hHrY3mAc5RFvci2goBC7YxBYh0xL
         y12h3VhHpDmCznGyeIyphBbl7iLXFgInSMU2h6Uv5gAS/r4SQXBO/4pHfcHHdZ1RFT
         1ZLhH/sDe16yg7aJi5/EODMWF4tCoHR4sZkfD2iAQTfC7tuVQWG/vwS/fPX73QM0A0
         77vT0OjgAWsmO+vuj0TraOubs99QevpIwbaO5mFg13AdfUD0JNDwUGePwSBMSbassG
         16yvMpVFFfpKzCs8g9xrT/Z9pOdsCa6234dhTqbYyS9p0YRerLFKNT6fu6VBvBSMjv
         bwC6IdxTgStkw==
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4RWm200V95z1MSN;
        Thu, 24 Aug 2023 10:39:36 -0400 (EDT)
Message-ID: <6e5ff343-0c4f-526c-eb53-890afb773563@efficios.com>
Date:   Thu, 24 Aug 2023 10:40:45 -0400
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
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <20230824075208.GA459974@ziqianlu-dell>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/24/23 03:52, Aaron Lu wrote:
> On Wed, Aug 23, 2023 at 02:52:17PM -0400, Mathieu Desnoyers wrote:
>> On 8/23/23 11:26, Mathieu Desnoyers wrote:
>>> On 8/22/23 07:31, Mathieu Desnoyers wrote:
>>>> Introduce cpus_share_l2c to allow querying whether two logical CPUs
>>>> share a common L2 cache.
>>>>
>>>> Considering a system like the AMD EPYC 9654 96-Core Processor, the L1
>>>> cache has a latency of 4-5 cycles, the L2 cache has a latency of at
>>>> least 14ns, whereas the L3 cache has a latency of 50ns [1]. Compared to
>>>> this, I measured the RAM accesses to a latency around 120ns on my
>>>> system [2]. So L3 really is only 2.4x faster than RAM accesses.
>>>> Therefore, with this relatively slow access speed compared to L2, the
>>>> scheduler will benefit from only considering CPUs sharing an L2 cache
>>>> for the purpose of using remote runqueue locking rather than queued
>>>> wakeups.
>>>
>>> So I did some more benchmarking to figure out whether the reason for
>>> this speedup is the latency delta between L2 and L3, or is due to the
>>> number of hw threads contending on the rq locks.
>>>
>>> I tried to force grouping of those "skip ttwu queue" groups by a subset
>>> of the LLC id, basically by taking the LLC id and adding the cpu number
>>> modulo N, where N is chosen based on my machine topology.
>>>
>>> The end result is that I have similar numbers for groups of 1, 2, 4 HW
>>> threads (which use rq locks and skip queued ttwu within the group).
>>> Starting with group of size 8, the performance starts to degrade.
>>>
>>> So I wonder: do machines with more than 4 HW threads per L2 cache exist?
>>> If it's the case, there we should think about grouping not only by L2
>>> cache, but also sub-divide this group so the number of hw threads per
>>> group is at most 4.
>>>
>>> Here are my results with the hackbench test-case:
>>>
>>> Group cpus by 16 hw threads:
>>>
>>> Time: 49s
>>>
>>> - group cpus by 8 hw threads: (llc_id + cpu modulo 2)
>>>
>>> Time: 39s
>>>
>>> - group cpus by 4 hw threads: (llc_id + cpu modulo 4)
>>>
>>> Time: 34s
>>>
>>> - group cpus by 2 hw threads: (llc_id + cpu modulo 8)
>>> (expect same as L2 grouping on this machine)
>>>
>>> Time: 34s
>>>
>>> - group cpus by 1 hw threads: (cpu)
>>>
>>> Time: 33s
>>
>> One more interesting data point: I tried modifying the grouping
>> so that I would explicitly group by hw threads which sit in different
>> L3, and even on different NUMA nodes for some
>> (group id = cpu_id % 192). This is expected to generate really _bad_
>> cache locality for the runqueue locks within a group.
>>
>> The result for these groups of 3 HW threads is about 33s with the
>> hackbench benchmark, which seems to confirm that the cause of the
>> speedup is reduction of the contention on the rq locks by making the
>> groups smaller, and therefore reducing the likelihood of contention for the
>> rq locks, rather than by improving cache locality from L3 to L2.
> 
> In addition to reduced rq lock contention, I think another reason this
> improves performance is because it reduced task migration. Not sure if
> it is the case on your test system, but on my test machine(Intel SPR),
> task migration number dropped.

Yes, it's indeed the case on my system as well. It cuts migrations by 
half (9.2K/sec down to 5.0K/sec).

> Hackbench on Intel SPR(2sockets/112cores/224threads) test summary:
> - performance improved for all three cases; the more tasks(groups), the
>    more performance gain;

Interesting!

> - task migrations dropped with this series for nr_group=20 and 32
>    according to 'perf stat'. migration number didn't drop for nr_group=10
>    but the two update functions' cost dropped which means fewer access to
>    tg->load_avg and thus, fewer task migrations. This is contradictory
>    and I can not explain yet;

Neither can I.

> - rq lock contention dropped for all three cases and it dropped the most
>    under more overloaded case: nr_group=32.

The fact that you observed rq lock contention dropping is a good sign
that doing more queued wakeups is a good thing compared to allowing
non-queued wakeups across cpus sharing a whole LLC.

At this point I'm not sure if the reduction on rq lock contention is 
mostly due to using queued wakeups rather than grabbing remote rq locks, 
or by a side-effet of doing a queued wakeup rather than immediately 
doing the wakeup, which would open a window where the target rq is still 
considered idle by the various code paths within select_task_rq_fair 
which don't care about rq->ttwu_pending.

> It's not clear to me why this series can reduce task migrations. I doubt
> it has something to do with more wakelist style wakeup becasue for this
> test machine, only a single core with two SMT threads share L2 so more
> wakeups are through wakelist. In wakelist style wakeup, the target rq's
> ttwu_pending is set and that will make the target cpu as !idle_cpu();
> This is faster than grabbing the target rq's lock and then increase
> target rq's nr_running or set target rq's curr to something else than
> idle. So wakelist style wakeup can make target cpu appear as non idle
> faster, but I can't connect this with reduced migration yet, I just feel
> this might be the reason why task migration reduced.

Many code paths in select_task_rq_fair don't seem to care about 
rq->ttwu_pending.

In wake_affine_idle, for sync wakeups, if nr_running is 1 on the waker, 
we choose the waker cpu as target.

In wake_affine_idle, if none of waker or prev wakee cpus are idle, then 
it uses wake_affine_weight to find out which of the waker/prev wakee 
cpus are targets based on their respective load.

If wake_affine_idle cannot find an idle waker/prev wakee cpu, and if 
wake_affine_weight finds that the prev wakee cpu had a lower load, then
wake_affine returns the prev wakee cpu as target. This happens even if 
the prev wakee cpu is not idle.

This "target" cpu is then passed to select_idle_sibling. It expects the 
available_idle_cpu(target) to check again to see whether the target cpu 
is idle. However, it also uses "sched_idle_cpu(target)" which _only_ 
considers nr_running (not ttwu_pending flag). Likewise for the other 
similar idleness checks below in select_idle_sibling for prev and 
recent_used_cpu. The same happens for the case where a per-cpu kthread
stacks with the wakee.

I've tried adding checks for rq->ttwu_pending in those code paths on top 
of my patch and I'm still observing the reduction in number of 
migrations, so it's unclear to me how doing more queued wakeups can 
reduce migrations the way it does.

I'm starting to think may want to explore explicitly rate limiting task 
migrations as well.

For instance, we could do something like this:

Within a 1ms window, if a task is migrated more than once, the following 
wakeups would consider that the prev runqueue should be considered in 
priority (as if it was completely idle) as long as its load is below a 
given threshold.

So every 1ms tasks have a chance to be migrated to the idlest runqueues, 
but we would then eliminate those frequent migration patterns which end 
up being bad for cache locality.

Thoughts ?

Thanks,

Mathieu


> 
> Below are detailed test data.
> Base: 6.5-rc1.
> rq_spin%: The percent of raw_spin_rq_lock_nested() as reported by
>            perf/events=cycles:pp
> migration: cpu-migrations reported by "perf stat -a -- sleep 5"
> 
> The cmdline used is:
> hackbench -g $nr_group -f 20 --pipe --threads -l 480000 -s 100
> 
> nr_group=10:
>              time  rq_spin%  update_cfs_group%  update_load_avg% migration
> base         46s    1.32%        20.06%             10.78%      10.227 K/sec
> this_series  37s    0.57%        15.08%              7.05%      10.722 K/sec
> 
> nr_group=20:
>              time  rq_spin%  update_cfs_group%  update_load_avg% migration
> base         69s    2.57%        19.68%             10.74%      12.098 K/sec
> this_series  41s    0.62%        12.11%              5.78%       8.617 K/sec
> 
> nr_group=32:
>              time  rq_spin%  update_cfs_group%  update_load_avg% migration
> base     192s±25%  15.12%        25.83%             9.33%       12.141 K/sec
> this_series  71s    0.47%        10.98%             4.58%        8.198 K/sec
> 
> I also tested applying my "ratelimit update to tg->load_avg" patch and
> the test summary is:
> - performance improved noticeably for nr_group=20 and slightly for
>    nr_group=10 case; nr_group=32's performance is roughly the same.
> - task migrations dropped for all three cases; nr_group=20 saw the
>    biggest drop.
> - rq lock contention dropped for all three cases and again, nr_group=32
>    saw the biggest drop.
> 
> Below are detailed data.
> Base: peter's sched/core branch with my "ratelimit" patch.
> this_series: apply this patchset on top of base.
> 
> nr_group=10:
>              time  rq_spin%  update_cfs_group%  update_load_avg% migration
> base         36s    0.55%        0.46%              1.43%       15.034 K/sec
> this_series  35s    0.56%        0.52%              1.53%       13.751 K/sec
> 
> nr_group=20:
>              time  rq_spin%  update_cfs_group%  update_load_avg% migration
> base         47s    1.28%        0.73%              2.33%       21.217 K/sec
> this_series  42s    0.60%        0.69%              1.69%       14.130 K/sec
> 
> nr_group=32:
>              time  rq_spin%  update_cfs_group%  update_load_avg% migration
> base         70s    2.38%        0.60%              2.19%       17.855 K/sec
> this_series  70s    0.58%        0.63%              1.77%       12.331 K/sec
> 
> Thanks,
> Aaron

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

