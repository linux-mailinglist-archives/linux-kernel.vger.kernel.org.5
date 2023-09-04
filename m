Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E8117917E1
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 15:18:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351897AbjIDNSf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 09:18:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243320AbjIDNSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 09:18:34 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CE5ECCCE
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 06:18:30 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8B814143D;
        Mon,  4 Sep 2023 06:19:08 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 92D2B3F793;
        Mon,  4 Sep 2023 06:18:29 -0700 (PDT)
Message-ID: <2562890e-e824-7721-8dbe-8c5ae6ac42a9@arm.com>
Date:   Mon, 4 Sep 2023 15:18:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] sched/fair: Check a task has a fitting cpu when updating
 misfit
Content-Language: en-US
To:     Qais Yousef <qyousef@layalina.io>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Qais Yousef <qais.yousef@arm.com>
References: <20230820203429.568884-1-qyousef@layalina.io>
 <CAKfTPtCq+-U34WSUHjs3CkqQM769_Q+FN-5Y+uK=AzdB0YNiLQ@mail.gmail.com>
 <20230829153524.iswwflqd3iw3uybx@airbuntu>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20230829153524.iswwflqd3iw3uybx@airbuntu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/08/2023 17:35, Qais Yousef wrote:
> On 08/29/23 16:10, Vincent Guittot wrote:
>> On Sun, 20 Aug 2023 at 22:34, Qais Yousef <qyousef@layalina.io> wrote:

[...]

>>>  kernel/sched/fair.c | 50 ++++++++++++++++++++++++++++++++++++++-------
>>>  1 file changed, 43 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>>> index 0b7445cd5af9..f08c5f3bf895 100644
>>> --- a/kernel/sched/fair.c
>>> +++ b/kernel/sched/fair.c
>>> @@ -4853,17 +4853,50 @@ static inline int task_fits_cpu(struct task_struct *p, int cpu)
>>>
>>>  static inline void update_misfit_status(struct task_struct *p, struct rq *rq)
>>>  {
>>> +       unsigned long uclamp_min, uclamp_max;
>>> +       unsigned long util, cap_level;
>>> +       bool has_fitting_cpu = false;
>>> +       int cpu = cpu_of(rq);
>>> +
>>>         if (!sched_asym_cpucap_active())
>>>                 return;
>>>
>>> -       if (!p || p->nr_cpus_allowed == 1) {
>>> -               rq->misfit_task_load = 0;
>>> -               return;
>>> -       }
>>> +       if (!p || p->nr_cpus_allowed == 1)
>>> +               goto out;
>>>
>>> -       if (task_fits_cpu(p, cpu_of(rq))) {
>>> -               rq->misfit_task_load = 0;
>>> -               return;
>>> +       uclamp_min = uclamp_eff_value(p, UCLAMP_MIN);
>>> +       uclamp_max = uclamp_eff_value(p, UCLAMP_MAX);
>>> +       util = task_util_est(p);
>>> +
>>> +       if (util_fits_cpu(util, uclamp_min, uclamp_max, cpu) > 0)
>>> +               goto out;

util_fits_cpu() checks fits_capacity(util, capacity_of(cpu)) but the
capacity pressure could change between update_misfit_status() and CFS lb?

>>> +
>>> +       cap_level = capacity_orig_of(cpu);
>>> +
>>> +       /* If we can't fit the biggest CPU, that's the best we can ever get. */
>>> +       if (cap_level == SCHED_CAPACITY_SCALE)
>>> +               goto out;
>>> +
>>> +       /*
>>> +        * If the task affinity is not set to default, make sure it is not
>>> +        * restricted to a subset where no CPU can ever fit it. Triggering
>>> +        * misfit in this case is pointless as it has no where better to move
>>> +        * to. And it can lead to balance_interval to grow too high as we'll
>>> +        * continuously fail to move it anywhere.
>>> +        */
>>> +       if (!cpumask_equal(p->cpus_ptr, cpu_possible_mask)) {
>>> +               for_each_cpu(cpu, p->cpus_ptr) {
>>
>> I haven't looked at the problem in detail and at other possibilities
>> so far but for_each_cpu doesn't scale and update_misfit_status() being
>> called in pick_next_task_fair() so you must find another way to detect
>> this
> 
> Okay, will do.

We have LIST_HEAD(asym_cap_list) (list of cpumasks according to
cpu_capacity_orig CPU groups) in kernel/sched/topology.c to set
SD_ASYM_CPUCAPACITY{,_FULL} for asymmetric CPU capacity systems.
Maybe this could be made usable in fair.c as well?

But checking via util_fits_cpu() wouldn't work then since it's per-CPU.
The check of p's CPU affinity, its uclamped util_avg value and the
cpu_capacity_orig is sufficient here. Then using those cpumasks could work.
