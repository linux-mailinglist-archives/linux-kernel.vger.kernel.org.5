Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 795A4794080
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 17:37:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242557AbjIFPhV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 11:37:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242659AbjIFPhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 11:37:20 -0400
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20BE61982
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 08:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1694014632;
        bh=4rnLU8+YW91xphhEj6RoshvsB+yby4w7N78gpCfX0cA=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=Hop2sXNJ0wrL4ASZopfN2v6kPPi2XgsNIczRzIXSPXA81V6YUcWMNBiIH/cf4MniU
         U95//4rcmcvBljV2OflL+mX3LLdUVWX32l1sp7dF1bJ7/ndUEq1ndGz7BL7lGgHjxt
         QwOQpq8lm5vEzudFWNUJnZAQ/2WeD3jftDTsNfYnKgD65KZN66nEUh3Kcze+NzfZgW
         yLQxOT4JT58gVAhkzDNZqJp3Hbj3qy4aHihVyVYg5ERuZzIr2FVh0uyawtbNGYrEHE
         BXfE9v2LgSkdRxxH78DWz2olHiR4l0QlZ3HzNWrk3yUGqL4HDL/zAFVpzzaksuxSov
         ABLpGEYALky6A==
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4RgmhS4ZWvz1Ngt;
        Wed,  6 Sep 2023 11:37:12 -0400 (EDT)
Message-ID: <eaeb172e-d1b1-d53c-f854-ab074893d6df@efficios.com>
Date:   Wed, 6 Sep 2023 11:38:29 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [RFC PATCH 1/2] sched: Rate limit migrations to 1 per 2ms per
 task
Content-Language: en-US
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
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
In-Reply-To: <c0728f14-7373-1e19-1655-1944411290b2@efficios.com>
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

On 9/6/23 09:57, Mathieu Desnoyers wrote:
> On 9/6/23 04:41, Peter Zijlstra wrote:
[...]
>>
>> Also:
>>
>>> I have noticed that in order to observe the speedup, the workload needs
>>> to keep the CPUs sufficiently busy to cause runqueue lock contention,
>>> but not so busy that they don't go idle.
>>
>> This would suggest inhibiting pulling tasks based on rq statistics,
>> instead of tasks stats. It doesn't matter when the task migrated last,
>> what matter is that this rq doesn't want new tasks at this point.
>>
>> Them not the same thing.
> 
> I suspect we could try something like this then:
> 
> When a cpu enters idle state, it could grab a sched_clock() timestamp
> and store it into this_rq()->enter_idle_time. Then, when it exits
> idle and reenters idle again, it could save rq->enter_idle_time to
> rq->prev_enter_idle_time, and sample enter_idle_time again.
> 
> When considering the CPU as a target for task migration, if it is
> idle but the delta between sched_clock_cpu(cpu_of(rq)) and that
> prev_enter_idle_time is below a threshold (e.g. a few ms), this means
> the CPU got out of idle and went back to idle pretty quickly, which
> means it's not a good target for pulling tasks for a short while.
> 
> I'll try something along these lines and see how it goes.

I've tried this approach and failed to observe any kind of speed up.

The effect I'm looking for is to favor keeping a task on its prev 
runqueue (prevent migration) even if there are rq siblings which have a 
lower load (or are actually idle) as long as the prev runqueue does not 
have a too high load.

I'll try this approach and let you know how it goes.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

