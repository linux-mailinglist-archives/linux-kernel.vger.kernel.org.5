Return-Path: <linux-kernel+bounces-26188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 520F882DC84
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 16:42:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6365B1C21D2F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 15:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EC1617C67;
	Mon, 15 Jan 2024 15:41:32 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 621BF17BDD
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 15:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1AA122F4;
	Mon, 15 Jan 2024 07:42:15 -0800 (PST)
Received: from [10.34.100.129] (e126645.nice.arm.com [10.34.100.129])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8A5243F73F;
	Mon, 15 Jan 2024 07:41:26 -0800 (PST)
Message-ID: <fcc07133-c43d-4423-bf92-b1d720c7e864@arm.com>
Date: Mon, 15 Jan 2024 16:41:25 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched/idle: Prevent stopping the tick when there is no
 cpuidle driver
Content-Language: en-US
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>, linux-kernel@vger.kernel.org,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Daniel Bristot de Oliveira
 <bristot@redhat.com>, Valentin Schneider <vschneid@redhat.com>
References: <20231215130501.24542-1-anna-maria@linutronix.de>
 <c09fb78b-5bf9-4c0b-b93f-10fd19a4ab36@arm.com> <87ttnmiif9.fsf@somnus>
 <06a2561f-557b-4eaa-8f11-75883bbbaef9@arm.com> <87a5pag6q7.fsf@somnus>
 <d0f1617e-0088-4bd9-bea6-e89c63b0e2ae@arm.com> <87mstaioy6.ffs@tglx>
 <fe5038e1-e06b-41dd-9584-cbd992bef1fe@arm.com>
 <CAKfTPtC3kN7gsgh+W4YZutQDMfs6TeT_F+Y5ba9txcM2jbbX6g@mail.gmail.com>
From: Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <CAKfTPtC3kN7gsgh+W4YZutQDMfs6TeT_F+Y5ba9txcM2jbbX6g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/15/24 14:29, Vincent Guittot wrote:
> On Mon, 15 Jan 2024 at 13:40, Pierre Gondois <pierre.gondois@arm.com> wrote:
>>
>> Hello Thomas,
>>
>> On 1/12/24 15:52, Thomas Gleixner wrote:
>>> On Fri, Jan 12 2024 at 14:39, Pierre Gondois wrote:
>>>> On 1/12/24 11:56, Anna-Maria Behnsen wrote:
>>>>> Pierre Gondois <pierre.gondois@arm.com> writes:
>>>>>> I agree that the absence of cpuidle driver prevents from reaching deep
>>>>>> idle states. FWIU, there is however still benefits in stopping the tick
>>>>>> on such platform.
>>>>>
>>>>> What's the benefit?
>>>>
>>>> I did the following test:
>>>> - on an arm64 Juno-r2 platform (2 big A-72 and 4 little A-53 CPUs)
>>>> - booting with 'cpuidle.off=1'
>>>> - using the energy counters of the platforms
>>>>      (the counters measure energy for the whole cluster of big/little CPUs)
>>>> - letting the platform idling during 10s
>>>>
>>>> So the energy consumption would be up:
>>>> - ~6% for the big CPUs
>>>> - ~10% for the litte CPUs
>>>
>>> Fair enough, but what's the actual usecase?
>>>
>>> NOHZ w/o cpuidle driver seems a rather academic exercise to me.
> 
> Don't know if it's really a valid use case but can't we have VMs in
> such a configuration ?
> NOHZ enabled and no cpuidle driver as VM doesn't manage HW anyway ?

Yes right,
I tried with a kvmtool generated VM and it seemed to be the case:

$ grep . /sys/devices/system/cpu/cpuidle/*
/sys/devices/system/cpu/cpuidle/available_governors:menu
/sys/devices/system/cpu/cpuidle/current_driver:none
/sys/devices/system/cpu/cpuidle/current_governor:menu
/sys/devices/system/cpu/cpuidle/current_governor_ro:menu


> 
>>
>> I thought Anna-Maria had a use-case for this.
>> I just wanted to point out that this patch could potentially
>> increase the energy consumption for her use-case, nothing more,
>>
>> Regards,
>> Pierre
>>
>>>
>>> Thanks,
>>>
>>>           tglx

