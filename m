Return-Path: <linux-kernel+bounces-161883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24D9C8B52A8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 09:54:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1EBB1F2132B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 07:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F69515E88;
	Mon, 29 Apr 2024 07:54:01 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACA4C10A0B;
	Mon, 29 Apr 2024 07:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714377241; cv=none; b=EAUJQITDfnt8Qgcsy9ljgR/Cq2d1E6LDngteK54U4/eOlehxobIo5Lf8guvkEWYSi5iae7rQytHGuAzjMlVn1N/2y5AQLmCFF5uKNSCM/2KADhxS/AgOqnpWef58dyAEJoNba99PHm/rxCg/8vVHA7XbUATnJiQLf8rz1vJeUWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714377241; c=relaxed/simple;
	bh=qhwQtw+U1S4uCs55SmoK0dXjELgfVw8THmXycVX7OQg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mecKPps6nvcyT0DPV0OFLj7XS51jf4Bw0cwPv1Y/+n09XS0YGinQokR4Zgc9fo4aod2dGfAvR3Z1vLVx1Uk6+cM9P2MiSflVWhSV2qSRZH13HnpuQifMVGLAqzakSV22fjUks2YEIeCuUAGdtKyUctvKfSELfwA+JCV2GAZxuoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 47A502F4;
	Mon, 29 Apr 2024 00:54:25 -0700 (PDT)
Received: from [10.57.65.146] (unknown [10.57.65.146])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EE3473F73F;
	Mon, 29 Apr 2024 00:53:55 -0700 (PDT)
Message-ID: <3aba1a1d-8ebc-4ee0-9caf-d9baae586db7@arm.com>
Date: Mon, 29 Apr 2024 08:53:54 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [linus:master] [timers] 7ee9887703: stress-ng.uprobe.ops_per_sec
 -17.1% regression
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: Oliver Sang <oliver.sang@intel.com>, oe-lkp@lists.linux.dev,
 lkp@intel.com, linux-kernel@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, ying.huang@intel.com,
 feng.tang@intel.com, fengwei.yin@intel.com,
 Frederic Weisbecker <frederic@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org
References: <Zgtjdd0C2FzYVBto@xsang-OptiPlex-9020> <87zfth3l6y.fsf@somnus>
 <CAJZ5v0g_GKF8-QK5UdFCpJapf+MK7EouQ7hMTVtPYRjNNyUt+g@mail.gmail.com>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <CAJZ5v0g_GKF8-QK5UdFCpJapf+MK7EouQ7hMTVtPYRjNNyUt+g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 4/26/24 17:03, Rafael J. Wysocki wrote:
> Hi,
> 
> On Thu, Apr 25, 2024 at 10:23 AM Anna-Maria Behnsen
> <anna-maria@linutronix.de> wrote:
>>
>> Hi,
>>
>> (adding cpuidle/power people to cc-list)
>>
>> Oliver Sang <oliver.sang@intel.com> writes:
>>
>>> hi, Frederic Weisbecker,
>>>
>>> On Tue, Apr 02, 2024 at 12:46:15AM +0200, Frederic Weisbecker wrote:
>>>> Le Wed, Mar 27, 2024 at 04:39:17PM +0800, kernel test robot a écrit :
>>>>>
>>>>>
>>>>> Hello,
>>>>>
>>>>>
>>>>> we reported
>>>>> "[tip:timers/core] [timers]  7ee9887703:  netperf.Throughput_Mbps -1.2% regression"
>>>>> in
>>>>> https://lore.kernel.org/all/202403011511.24defbbd-oliver.sang@intel.com/
>>>>>
>>>>> now we noticed this commit is in mainline and we captured further results.
>>>>>
>>>>> still include netperf results for complete. below details FYI.
>>>>>
>>>>>
>>>>> kernel test robot noticed a -17.1% regression of stress-ng.uprobe.ops_per_sec
>>>>> on:
>>>>
>>>> The good news is that I can reproduce.
>>>> It has made me spot something already:
>>>>
>>>>     https://lore.kernel.org/lkml/ZgsynV536q1L17IS@pavilion.home/T/#m28c37a943fdbcbadf0332cf9c32c350c74c403b0
>>>>
>>>> But that's not enough to fix the regression. Investigation continues...
>>>
>>> Thanks a lot for information! if you want us test any patch, please let us know.
>>
>> Oliver, I would be happy to see, whether the patch at the end of the
>> message restores the original behaviour also in your test setup. I
>> applied it on 6.9-rc4. This patch is not a fix - it is just a pointer to
>> the kernel path, that might cause the regression. I know, it is
>> probable, that a warning in tick_sched is triggered. This happens when
>> the first timer is alredy in the past. I didn't add an extra check when
>> creating the 'defacto' timer thingy. But existing code handles this
>> problem already properly. So the warning could be ignored here.
>>
>> For the cpuidle people, let me explain what I oberserved, my resulting
>> assumption and my request for help:
>>
>> cpuidle governors use expected sleep length values (beside other data)
>> to decide which idle state would be good to enter. The expected sleep
>> length takes the first queued timer of the CPU into account and is
>> provided by tick_nohz_get_sleep_length(). With the timer pull model in
>> place the non pinned timers are not taken into account when there are
>> other CPUs up and running which could handle those timers. This could
>> lead to increased sleep length values. On my system during the stress-ng
>> uprobes test it was in the range of maximum 100us without the patch set
>> and with the patch set the maximum was in a range of 200sec. This is
>> intended behaviour, because timers which could expire on any CPU should
>> expire on the CPU which is busy anyway and the non busy CPU should be
>> able to go idle.
>>
>> Those increased sleep length values were the only anomalies I could find
>> in the traces with the regression.
>>
>> I created the patch below which simply fakes the sleep length values
>> that they take all timers of the CPU into account (also the non
>> pinned). This patch kind of restores the behavoir of
>> tick_nohz_get_sleep_length() before the change but still with the timer
>> pull model in place.
>>
>> With the patch the regression was gone, at least on my system (using
>> cpuidle governor menu but also teo).
>>
>> So my assumption here is, that cpuidle governors assume that a deeper
>> idle state could be choosen and selecting the deeper idle state makes an
>> overhead when returning from idle. But I have to notice here, that I'm
>> still not familiar with cpuidle internals... So I would be happy about
>> some hints how I can debug/trace cpuidle internals to falsify or verify
>> this assumption.
> 
> You can look at the "usage" and "time" numbers for idle states in
> 
> /sys/devices/system/cpu/cpu*/cpuidle/state*/
> 
> The "usage" value is the number of times the governor has selected the
> given state and the "time" is the total idle time after requesting the
> given state (ie. the sum of time intervals between selecting that
> state by the governor and wakeup from it).
> 
> If "usage" decreases for deeper (higher number) idle states relative
> to its value for shallower (lower number) idle states after applying
> the test patch, that will indicate that the theory is valid.

I agree with Rafael here, this is the first thing to check, those
statistics. Then, when you see difference in those stats in baseline
vs. patched version, we can analyze the internal gov decisions
with help of tracing.

Please also share how many idle states is in those testing platforms.

BTW, this stress-ng app looks like is a good candidate for OSPM
discussion that we (me & Rafael) are going to conduct this year.
We are going to talk about QoS for frequency and latency for apps.
Those governors (in idle, cpufreq, devfreq) try hard to 'recognize' what
should be best platform setup for particular workloads, but it's really
tough to get it right w/o user-space help.

Therefore, beside these proposed fixes for new timers model, we need
something 'newer' in our Linux, since the HW evolves (e.g. L3 cache
w/ DVFS in phones) IMO.

Regards,
Lukasz

