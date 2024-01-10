Return-Path: <linux-kernel+bounces-21962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 518B982972C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 11:20:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 057B51F27FD7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 10:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D57DD3FB17;
	Wed, 10 Jan 2024 10:20:12 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90CB63FB02
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 10:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3D0302F4;
	Wed, 10 Jan 2024 02:20:54 -0800 (PST)
Received: from [10.34.100.129] (e126645.nice.arm.com [10.34.100.129])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D3EE93F73F;
	Wed, 10 Jan 2024 02:20:06 -0800 (PST)
Message-ID: <06a2561f-557b-4eaa-8f11-75883bbbaef9@arm.com>
Date: Wed, 10 Jan 2024 11:20:01 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched/idle: Prevent stopping the tick when there is no
 cpuidle driver
To: Anna-Maria Behnsen <anna-maria@linutronix.de>,
 linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Daniel Bristot de Oliveira
 <bristot@redhat.com>, Valentin Schneider <vschneid@redhat.com>,
 Thomas Gleixner <tglx@linutronix.de>
References: <20231215130501.24542-1-anna-maria@linutronix.de>
 <c09fb78b-5bf9-4c0b-b93f-10fd19a4ab36@arm.com> <87ttnmiif9.fsf@somnus>
Content-Language: en-US
From: Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <87ttnmiif9.fsf@somnus>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello Anna-Maria,

On 1/9/24 17:24, Anna-Maria Behnsen wrote:
> Hello Pierre,
> 
> Pierre Gondois <pierre.gondois@arm.com> writes:
> 
>> Hello Anna-Maria,
>>
>> On 12/15/23 14:05, Anna-Maria Behnsen wrote:
>>> When there is no cpuidle driver, the system tries to stop the tick even if
>>> the system is fully loaded. But stopping the tick is not for free and it
>>> decreases performance on a fully loaded system. As there is no (cpuidle)
>>> framework which brings CPU in a power saving state when nothing needs to be
>>> done, there is also no power saving benefit when stopping the tick.
>>
>> Just in case is wasn't taken into consideration:
>> -
>> Stopping the tick isn't free on a busy system, but it should also cost
>> something to regularly handle ticks on each CPU of an idle system.
>>
>> FWIU, disabling the ticks also allows to add a CPU to the 'nohz.idle_cpus_mask'
>> mask, which helps the idle load balancer picking an idle CPU to do load
>> balancing for all the idle CPUs (cf. kick_ilb()).
>>
>> It seems better to do one periodic balancing for all the idle CPUs rather
>> than periodically waking-up all CPUs to try to balance.
>>
>> -
>> I would have assumed that if the system was fully loaded, ticks would
>> not be stopped, or maybe I misunderstood the case.
>> I assume the wake-up latency would be improved if the tick doesn't
>> have to be re-setup again.
>>
> 
> Your answer confuses me a little...
> 
> When there is a cpuidle driver, trying to stop the tick is not done
> unconditionally. It is only done when the CPU is in a state that it
> could go into a deeper C sleep - this is decided by cpuidle
> driver/governor.

Yes right.

> 
> When there is no cpuidle driver, there is no instance which could bring
> the CPU into a deeper C state. But at the moment the code does
> unconditionally try to stop the tick. So the aim of the patch is to
> remove this unconditional stop of the tick.

I agree that the absence of cpuidle driver prevents from reaching deep
idle states. FWIU, there is however still benefits in stopping the tick
on such platform.
-
I agree that bringing up/down the ticks costs something and that removing
tick_nohz_idle_stop_tick() can improve performance, but I assumed stopping
the ticks had some interest regarding energy consumption.
Keeping the tick forever on an idle CPU should not be useful.
-
About nohz.idle_cpus_mask, I was referring to the following path:
do_idle()
\-cpuidle_idle_call()
   \-tick_nohz_idle_stop_tick()
     \-nohz_balance_enter_idle()
       \-cpumask_set_cpu(cpu, nohz.idle_cpus_mask);
       \-atomic_inc(&nohz.nr_cpus);

Removing tick_nohz_idle_stop_tick() also means not using nohz.idle_cpus_mask
and the logic around it to find an idle CPU to balance tasks.

Hope the re-phrasing makes the 2 points a bit clearer,
Regards,
Pierre


> 
> And NOHZ is independant on the cpuidle infrastructure. But when there is
> no cpuidle driver, it doesn't makes sense to use then also NOHZ.
> 
> Thanks,
> 
> 	Anna-Maria
> 
> 
> 

