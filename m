Return-Path: <linux-kernel+bounces-24741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0857382C1A7
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 15:25:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E3111F23B06
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 14:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BAFD74E03;
	Fri, 12 Jan 2024 14:23:48 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD858745F1
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 14:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 987091FB;
	Fri, 12 Jan 2024 06:24:31 -0800 (PST)
Received: from [192.168.178.6] (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7BD8D3F5A1;
	Fri, 12 Jan 2024 06:23:43 -0800 (PST)
Message-ID: <4405adb5-0b16-4716-9542-47d8bb1737ee@arm.com>
Date: Fri, 12 Jan 2024 15:23:41 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] Scheduler changes for v6.8
Content-Language: en-US
To: Vincent Guittot <vincent.guittot@linaro.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>,
 Juri Lelli <juri.lelli@redhat.com>, Steven Rostedt <rostedt@goodmis.org>,
 Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
 Daniel Bristot de Oliveira <bristot@redhat.com>,
 Valentin Schneider <vschneid@redhat.com>
References: <ZTz9RpZxfxysYCmt@gmail.com> <ZZwBi/YmnMqm7zrO@gmail.com>
 <CAHk-=wgWcYX2oXKtgvNN2LLDXP7kXkbo-xTfumEjmPbjSer2RQ@mail.gmail.com>
 <CAHk-=wiXpsxMcQb7MhL-AxOityTajK0G8eWeBOzX-qBJ9X2DSw@mail.gmail.com>
 <CAHk-=wjK28MUqBZzBSMEM8vdJhDOuXGSWPmmp04GEt9CXtW6Pw@mail.gmail.com>
 <ZZ+ixagkxRPYyTCE@vingu-book>
 <CAHk-=wj75Er8k4QY-KF34NBCWkDpr3D26XptOpkfDcTyGEA7iA@mail.gmail.com>
 <CAHk-=whK-cuBUQ2hECtkGu3LR-ipai+tmB85M=C7n3b1M8B4gQ@mail.gmail.com>
 <CAKfTPtCnT9VLqiQGL5kyhzqv=WAUNRA3tVDVoKjB7jX-00Un+g@mail.gmail.com>
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <CAKfTPtCnT9VLqiQGL5kyhzqv=WAUNRA3tVDVoKjB7jX-00Un+g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/01/2024 19:16, Vincent Guittot wrote:
> On Thu, 11 Jan 2024 at 18:53, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>>
>> On Thu, 11 Jan 2024 at 09:45, Linus Torvalds
>> <torvalds@linux-foundation.org> wrote:
>>>
>>> On Thu, 11 Jan 2024 at 00:11, Vincent Guittot
>>> <vincent.guittot@linaro.org> wrote:
>>>>
>>>> Could you confirm that cpufreq governor is schedutil and the driver is
>>>> amd-pstate on your system ?
>>>
>>> schedutil yes, amd-pstate no. I actually just use acpi_cpufreq
>>
>> Bah. Hit 'send' mistakenly too soon, thus the abrupt end and
>> unfinished quoting removal.
>>
>> And don't ask me why it's acpi_pstate-driven. I have X86_AMD_PSTATE=y, but
>>
>>     /sys/devices/system/cpu/cpufreq/policy0/scaling_driver
>>
>> clearly says 'acpi-cpufreq'. Maybe I'm looking in the wrong place. My dmesg says
> 
> That seems to be the right place to look
> 
>>
>>     amd_pstate: the _CPC object is not present in SBIOS or ACPI disabled
>>
>> which is presumably the reason my machine uses acpi-pstate.
>>
>> I will also test out your other questions, but I need to go back and
>> do more pull requests first.
> 
> ok, thanks
> 
> I'm going to continue checking what else could trigger such regression
> having in mind that your system should not have beeb impacted by this
> changes

I can't see the regression on my

  20-core (40-thread) Intel Xeon CPU E5-2690 v2

with 'schedutil' and 'acpi-cpufreq'.

f12560779f9d - sched/cpufreq: Rework iowait boost                              <- (w/ patches)
9c0b4bb7f630 - sched/cpufreq: Rework schedutil governor performance estimation
50181c0cff31 - sched/pelt: Avoid underestimation of task utilization           <- (base)
..

# cpufreq-info -c 0 -e
..
analyzing CPU 0:
  driver: acpi-cpufreq
  CPUs which run at the same hardware frequency: 0
  CPUs which need to have their frequency coordinated by software: 0
  maximum transition latency: 10.0 us.
  hardware limits: 1.20 GHz - 3.00 GHz
  available frequency steps: 3.00 GHz, 3.00 GHz, 2.90 GHz, 2.70 GHz, 2.60 GHz, 2.50 GHz, 2.40 GHz, 2.20 GHz,
                             2.10 GHz, 2.00 GHz, 1.80 GHz, 1.70 GHz, 1.60 GHz, 1.50 GHz, 1.30 GHz, 1.20 GHz
  available cpufreq governors: conservative, ondemand, userspace, powersave, performance, schedutil
  current policy: frequency should be within 1.20 GHz and 3.00 GHz.
                  The governor "schedutil" may decide which speed to use
                  within this range.
  current CPU frequency is 1.20 GHz (asserted by call to hardware).


cpufreq is still fast-switching, so no schedutil 'sugov' DL threads.

