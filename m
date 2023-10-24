Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AB2B7D54A0
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 17:03:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbjJXPDh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 11:03:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjJXPDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 11:03:34 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 14F8D10C2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 08:03:31 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D807E2F4;
        Tue, 24 Oct 2023 08:04:11 -0700 (PDT)
Received: from [192.168.2.82] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0CDF43F762;
        Tue, 24 Oct 2023 08:03:27 -0700 (PDT)
Message-ID: <14ab201e-0170-4dd7-a1ec-7587fe27385a@arm.com>
Date:   Tue, 24 Oct 2023 17:03:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 1/2] sched/fair: Introduce UTIL_FITS_CAPACITY
 feature (v2)
Content-Language: en-US
To:     Chen Yu <yu.c.chen@intel.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
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
        K Prateek Nayak <kprateek.nayak@amd.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>, x86@kernel.org
References: <20231019160523.1582101-1-mathieu.desnoyers@efficios.com>
 <20231019160523.1582101-2-mathieu.desnoyers@efficios.com>
 <f40522de-b71d-4848-8aa3-5b87d38bb847@arm.com>
 <c79ac631-61c7-4953-a657-74047a264029@efficios.com>
 <ZTdf0529DL51pj8m@chenyu5-mobl2.ccr.corp.intel.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <ZTdf0529DL51pj8m@chenyu5-mobl2.ccr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/10/2023 08:10, Chen Yu wrote:
> On 2023-10-23 at 11:04:49 -0400, Mathieu Desnoyers wrote:
>> On 2023-10-23 10:11, Dietmar Eggemann wrote:
>>> On 19/10/2023 18:05, Mathieu Desnoyers wrote:

[...]

>>> Or like find_energy_efficient_cpu() (feec(), used in
>>> Energy-Aware-Scheduling (EAS)) which uses cpu_util(cpu, p, cpu, 0) to get:
>>>
>>>    max(util_avg(CPU + p), util_est(CPU + p))
>>
>> I've tried using cpu_util(), but unfortunately anything that considers
>> blocked/sleeping tasks in its utilization total does not work for my
>> use-case.
>>
>> From cpu_util():
>>
>>  * CPU utilization is the sum of running time of runnable tasks plus the
>>  * recent utilization of currently non-runnable tasks on that CPU.
>>
> 
> I thought cpu_util() indicates the utilization decay sum of task that was once
> "running" on this CPU, but will not sum up the "util/load" of the blocked/sleeping
> task?

cpu_util() here refers to:

    cpu_util(int cpu, struct task_struct *p, int dst_cpu, int boost)

which when called with (cpu, p, cpu, 0) and task_cpu(p) != cpu returns:

    max(util_avg(CPU + p), util_est(CPU + p))

The term `CPU utilization` in cpu_util()'s header stands for
cfs_rq->avg.util_avg.

It does not sum up the utilization of blocked tasks but it can contain
it. They have to be a blocked tasks and not tasks which were running in
cfs_rq since we subtract utilization of tasks which are migrating away
from the cfs_rq (cfs_rq->removed.util_avg in remove_entity_load_avg()
and update_cfs_rq_load_avg()).
> accumulate_sum()
>     /* only the running task's util will be sum up */
>     if (running)
>        sa->util_sum += contrib << SCHED_CAPACITY_SHIFT;
> 
> WRITE_ONCE(sa->util_avg, sa->util_sum / divider);

__update_load_avg_cfs_rq()

  ___update_load_sum(..., cfs_rq->curr != NULL
                          ^^^^^^^^^^^^^^^^^^^^
                          running
    accumulate_sum()

      if (periods)
        /* decay _sum */
        sa->util_sum = decay_load(sa->util_sum, ...)

        if (load)
          /* decay and accrue _sum */
          contrib = __accumulate_pelt_segments(...)

When crossing periods we decay the old _sum and when additionally load
!= 0 we decay and accrue the new _sum as well.
