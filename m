Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD5797FD668
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 13:16:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233252AbjK2MQ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 07:16:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233253AbjK2MQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 07:16:27 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3A82310C3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 04:16:34 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2239C2F4;
        Wed, 29 Nov 2023 04:17:21 -0800 (PST)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3BFB63F5A1;
        Wed, 29 Nov 2023 04:16:32 -0800 (PST)
Message-ID: <764e015b-b987-4722-b088-56da22848644@arm.com>
Date:   Wed, 29 Nov 2023 13:16:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] sched/fair: Use all little CPUs for CPU-bound workload
Content-Language: en-US
To:     Pierre Gondois <pierre.gondois@arm.com>,
        linux-kernel@vger.kernel.org
Cc:     Qais Yousef <qyousef@layalina.io>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>
References: <20231124153323.3202444-1-pierre.gondois@arm.com>
 <b373fde3-95a1-4b08-a5f0-f66e3463c298@arm.com>
 <980a1a52-80a1-4d3b-8931-5f9a6546bbf5@arm.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <980a1a52-80a1-4d3b-8931-5f9a6546bbf5@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/11/2023 11:48, Pierre Gondois wrote:
> 
> 
> On 11/29/23 09:55, Dietmar Eggemann wrote:
>> On 24/11/2023 16:33, Pierre Gondois wrote:

[...]

>>> Testing workload ([1]):
>>> Spawn 6 CPU-bound tasks. During the first 100ms (step 1), each tasks
>>> is affine to a CPU, except for:
>>> - one little CPU which is left idle.
>>> - one big CPU which has 2 tasks affine.
>>> After the 100ms (step 2), remove the cpumask affinity.
>>>
>>> Before patch:
>>> During step 2, the load balancer running from the idle CPU tags sched
>>> domains as:
>>> - little CPUs: 'group_has_spare'. Indeed, 3 CPU-bound tasks run on a
>>>    4 CPUs sched-domain, and the idle CPU provides enough spare
>>>    capacity.
>>
>> What is meant by 'idle CPU provides enough spare capacity? I thought the
>> task (util_avg ~ 512_ does not fit on the sched group [1,3-5] when we
>> consider util_avg/capacity (383)
> 
> Right, I meant that when evaluating the 'group_type', there is enough spare
> capacity when summing the utilization of CPUs in the the MC sched domain:
> 
> ---
> group_has_capacity()
> {
>     [...]
>     if ((sgs->group_capacity * 100) >
>             (sgs->group_util * imbalance_pct))
>         return true;
>     [...]
> }

I see. But doesn't group_has_capacity() already return true because of
`if (sgs->sum_nr_running < sgs->group_weight)` in this case (3 < 4)?

Maybe you can make this clearer when sending the v3 with the Reviewed-By
tags?

> ---
> 
>>
>> The calculated imbalance of ~350 is too small for the task-size and
>> that's why we need the 'shr_bound(util, env->sd->nr_balance_failed)' to
>> let the task load-balance if nr_balance_failed = 2?
> 
> Yes exact, the tasks are too big and cannot fit this imbalance value
> (representing the available spare capacity in the little CPUs in this
> case).
> 
> 'shr_bound(...)' allows to progressively reduce the size of the tasks and
> allow migrations after having tried to balance 'nr_balance_failed' times.

[...]

