Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 555B579ED8D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 17:45:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbjIMPpd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 11:45:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbjIMPpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 11:45:31 -0400
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CDCAC1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 08:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1694619925;
        bh=571rZ6ouw0sSuats3nqKyMCENWzG24PPE1Ypk7gXuOQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=FwXXv4HZqtgCAZaOZR240YfKk1HAcyVZ+uQxOOBf5zOMgFyQMzJ3I7fYQkWaomcn5
         3aEEC+1ng/GpdaVPnySXDB6USJQa3oUoxrFi2REMhTanZMoEtH9anctLUi4vsH3v62
         MGCg4OZRZGYNcPJBI717HR0UVshxWgKhE2n97wxtUAkK+L0uyE8Ae1n5rH+7Miikkj
         Da9sTEy3w/xjH5V6FsgWFP/VAY0I89vHOQgYxgZOaow+sr9wW5nuUuKug8TT2WgScq
         6dSUSLwZTGz+0Twm2DLKI1ocWcKydUwJBAh+eAfiJsQBXJTJ1VnKodxv6PZDeBPIXc
         zfiJuRxW2LJWA==
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4Rm4Xj2qgcz1NyZ;
        Wed, 13 Sep 2023 11:45:25 -0400 (EDT)
Message-ID: <0dcef55c-7baf-eadc-0253-d283385cbeb3@efficios.com>
Date:   Wed, 13 Sep 2023 11:46:47 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [RFC PATCH 1/2] sched: Rate limit migrations to 1 per 2ms per
 task
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
        Aaron Lu <aaron.lu@intel.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>, x86@kernel.org
References: <20230905171105.1005672-1-mathieu.desnoyers@efficios.com>
 <20230905171105.1005672-2-mathieu.desnoyers@efficios.com>
 <20230906084145.GC38741@noisy.programming.kicks-ass.net>
 <c0728f14-7373-1e19-1655-1944411290b2@efficios.com>
 <ZP1qQjCLubr7J8us@chenyu5-mobl2>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <ZP1qQjCLubr7J8us@chenyu5-mobl2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/10/23 03:03, Chen Yu wrote:
> On 2023-09-06 at 09:57:04 -0400, Mathieu Desnoyers wrote:
[...]
>>
>> I suspect we could try something like this then:
>>
>> When a cpu enters idle state, it could grab a sched_clock() timestamp
>> and store it into this_rq()->enter_idle_time. Then, when it exits
>> idle and reenters idle again, it could save rq->enter_idle_time to
>> rq->prev_enter_idle_time, and sample enter_idle_time again.
>>
>> When considering the CPU as a target for task migration, if it is
>> idle but the delta between sched_clock_cpu(cpu_of(rq)) and that
>> prev_enter_idle_time is below a threshold (e.g. a few ms), this means
>> the CPU got out of idle and went back to idle pretty quickly, which
>> means it's not a good target for pulling tasks for a short while.
>>
> 
> Do you mean inhit the newidle balance? Currently the newidle balance
> checks if the average idle duration of that rq is below the total cost
> to do a load balance:
>     this_rq->avg_idle < sd->max_newidle_lb_cost

Not quite but..

> 
>> I'll try something along these lines and see how it goes.

anyway this approach did not work based on my testing.

>>
> 
> Consider the sleep time looks like a good idea! What you suggests that
> inspires me that, maybe we could consider the task's sleep duration,
> and decide whether to migrate it or not in the next wakeup.
> 
> Say, if a task p sleeps and woken up quickly, can we reserve its previous
> CPU as idle for a short while? So other tasks can not choose p's previous
> CPU during their wakeup. A short while later, when p is woken up, it finds
> that its previous CPU is still idle and chooses that.
> 
> I created a draft patch based on that, and it shows some improvements on
> a 224 CPUs system. I'll post the draft patch and Cc you.

I think your approach is very promising, let's keep digging into that 
direction.

Thanks,

Mathieu

> 
> thanks,
> Chenyu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

