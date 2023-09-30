Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DD627B4028
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 13:55:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234166AbjI3LqF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 07:46:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230465AbjI3LqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 07:46:04 -0400
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41BDBD6
        for <linux-kernel@vger.kernel.org>; Sat, 30 Sep 2023 04:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1696074356;
        bh=BwM+qiiSjT1rizB6dAsk8vCl4yMw7XPT8jMNJNoi4ZM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=O9TXPcuv1INo2O/LEVGwoMn7GBtYbSLD9JigUWTf/gPPFSAPxzNXXj5nnVm8basaf
         uRORdbD/5Q75Q3fCrfkzJ+u3C6tS4tNT9wlP45TDKvYIimJYx7TgUG0NNsVcaMbXoY
         JSDImIPSuIHcseoi98qIyE5XS4FjWvxBs/LJ4UY4YnyLZ4TtD0GrSFSGuxnpLjhLsv
         KEEbxRjpAj4Rl4+j+UUOcux8+RQEd654mjO9NKni0CNExGZnLOAWovEF6kZBq24hRp
         MjI5P+ujwAJMV3VcMtFGKBbNb303RvMO0Rfdp8WCHphkIv+26sVyJ7upwgt6lynDPg
         IVYHvsvU8fLmA==
Received: from [IPV6:2606:6d00:100:4000:cacb:9855:de1f:ded2] (unknown [IPv6:2606:6d00:100:4000:cacb:9855:de1f:ded2])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4RyQQX3vp9z1Rh8;
        Sat, 30 Sep 2023 07:45:56 -0400 (EDT)
Message-ID: <0f3cfff3-0df4-3cb7-95cb-ea378517e13b@efficios.com>
Date:   Sat, 30 Sep 2023 07:45:38 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [RFC PATCH] sched/fair: Bias runqueue selection towards almost
 idle prev CPU
Content-Language: en-US
To:     Chen Yu <yu.c.chen@intel.com>
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
References: <20230929183350.239721-1-mathieu.desnoyers@efficios.com>
 <ZRfKKxBzfu+kf0tM@chenyu5-mobl2.ccr.corp.intel.com>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <ZRfKKxBzfu+kf0tM@chenyu5-mobl2.ccr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/30/23 03:11, Chen Yu wrote:
> Hi Mathieu,
> 
> On 2023-09-29 at 14:33:50 -0400, Mathieu Desnoyers wrote:
>> Introduce the WAKEUP_BIAS_PREV_IDLE scheduler feature. It biases
>> select_task_rq towards the previous CPU if it was almost idle
>> (avg_load <= 0.1%).
> 
> Yes, this is a promising direction IMO. One question is that,
> can cfs_rq->avg.load_avg be used for percentage comparison?
> If I understand correctly, load_avg reflects that more than
> 1 tasks could have been running this runqueue, and the
> load_avg is the direct proportion to the load_weight of that
> cfs_rq. Besides, LOAD_AVG_MAX seems to not be the max value
> that load_avg can reach, it is the sum of
> 1024 * (y + y^1 + y^2 ... )
> 
> For example,
> taskset -c 1 nice -n -20 stress -c 1
> cat /sys/kernel/debug/sched/debug | grep 'cfs_rq\[1\]' -A 12 | grep "\.load_avg"
>    .load_avg                      : 88763
>    .load_avg                      : 1024
> 
> 88763 is higher than LOAD_AVG_MAX=47742

I would have expected the load_avg to be limited to LOAD_AVG_MAX 
somehow, but it appears that it does not happen in practice.

That being said, if the cutoff is really at 0.1% or 0.2% of the real 
max, does it really matter ?

> Maybe the util_avg can be used for precentage comparison I suppose?
[...]
> Or
> return cpu_util_without(cpu_rq(cpu), p) * 1000 <= capacity_orig_of(cpu) ?

Unfortunately using util_avg does not seem to work based on my testing.
Even at utilization thresholds at 0.1%, 1% and 10%.

Based on comments in fair.c:

  * CPU utilization is the sum of running time of runnable tasks plus the
  * recent utilization of currently non-runnable tasks on that CPU.

I think we don't want to include currently non-runnable tasks in the 
statistics we use, because we are trying to figure out if the cpu is a 
idle-enough target based on the tasks which are currently running, for 
the purpose of runqueue selection when waking up a task which is 
considered at that point in time a non-runnable task on that cpu, and 
which is about to become runnable again.

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

