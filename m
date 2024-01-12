Return-Path: <linux-kernel+bounces-24694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1262382C0F3
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 14:40:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BCA72824FC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 13:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B7D06D1A9;
	Fri, 12 Jan 2024 13:40:00 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B5B222078
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 13:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 393541FB;
	Fri, 12 Jan 2024 05:40:36 -0800 (PST)
Received: from [10.57.77.195] (unknown [10.57.77.195])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EED703F5A1;
	Fri, 12 Jan 2024 05:39:47 -0800 (PST)
Message-ID: <d0f1617e-0088-4bd9-bea6-e89c63b0e2ae@arm.com>
Date: Fri, 12 Jan 2024 14:39:46 +0100
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
 <06a2561f-557b-4eaa-8f11-75883bbbaef9@arm.com> <87a5pag6q7.fsf@somnus>
From: Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <87a5pag6q7.fsf@somnus>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello Anna-Maria,

On 1/12/24 11:56, Anna-Maria Behnsen wrote:
> Pierre Gondois <pierre.gondois@arm.com> writes:
> 
>> Hello Anna-Maria,
>>
>> On 1/9/24 17:24, Anna-Maria Behnsen wrote:
>>>
>>> When there is no cpuidle driver, there is no instance which could bring
>>> the CPU into a deeper C state. But at the moment the code does
>>> unconditionally try to stop the tick. So the aim of the patch is to
>>> remove this unconditional stop of the tick.
>>
>> I agree that the absence of cpuidle driver prevents from reaching deep
>> idle states. FWIU, there is however still benefits in stopping the tick
>> on such platform.
> 
> What's the benefit?

I did the following test:
- on an arm64 Juno-r2 platform (2 big A-72 and 4 little A-53 CPUs)
- booting with 'cpuidle.off=1'
- using the energy counters of the platforms
   (the counters measure energy for the whole cluster of big/little CPUs)
- letting the platform idling during 10s

Without patch:
|       |     big-CPUs | little-CPUs |
|:------|-------------:|------------:|
| count | 10           | 10          |
| mean  |  0.353266    |  0.33399    |
| std   |  0.000254574 |  0.00206803 |
| min   |  0.352991    |  0.332145   |
| 25%   |  0.353039    |  0.332506   |
| 50%   |  0.353267    |  0.333089   |
| 75%   |  0.353412    |  0.335231   |
| max   |  0.353737    |  0.337964   |

With patch:
|       |     big-CPUs |  little-CPUs |
|:------|-------------:|-------------:|
| count | 10           | 10           |
| mean  |  0.375086    |  0.352451    |
| std   |  0.000299919 |  0.000752727 |
| min   |  0.374527    |  0.351743    |
| 25%   |  0.374872    |  0.35181     |
| 50%   |  0.37512     |  0.352063    |
| 75%   |  0.375335    |  0.353256    |
| max   |  0.375485    |  0.353461    |

So the energy consumption would be up:
- ~6% for the big CPUs
- ~10% for the litte CPUs

Regards,
Pierre


> 
> Thanks,
> 
>          Anna-Maria
> 

