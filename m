Return-Path: <linux-kernel+bounces-160313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CFB168B3BC4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 17:39:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F38A21C23954
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 15:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F316A149C73;
	Fri, 26 Apr 2024 15:39:24 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 720E51487DA;
	Fri, 26 Apr 2024 15:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714145964; cv=none; b=q9Re3ygU2o3De5V4QqrY5VHpoFTJDmX16bzjTBQrtw6WDlggI/pMYcfnc/kOY75+haBJ+W0y+u/uVBvPMV7RJ6wMMk2/RX9eTEzW/eWZsn+s9tZtoyFjJVeDFC/RqbiI/E7+CZM1Y8sOf0ong8YUE8nqsbQV5JR5zFqasK6IUDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714145964; c=relaxed/simple;
	bh=4WFzQGpOjDJKNHNLLs3leqq356kBHkd0ysmWxrlPiqY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nVfIAzCHbMORHAxbW4uqLS8qHvtbmdlzpmrpv6S2jYojdlAo9YNV9q1ttOQyqg3z4OWq13Pshzh+Na3u2AOMaofr3584OjkQrp5KKShsKFNYkjxRR766wqCQLhvNUbjyO5PKXjx/MHNfi6CwpB/ySIja8m+3Mu0Q/Q4T0wFd+Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E79652F4;
	Fri, 26 Apr 2024 08:39:49 -0700 (PDT)
Received: from [10.1.30.55] (e133047.arm.com [10.1.30.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 56AB03F73F;
	Fri, 26 Apr 2024 08:39:19 -0700 (PDT)
Message-ID: <6b6580df-4ffc-408e-9084-6f2f331dc24c@arm.com>
Date: Fri, 26 Apr 2024 16:39:17 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [linus:master] [timers] 7ee9887703: stress-ng.uprobe.ops_per_sec
 -17.1% regression
To: Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Oliver Sang <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, ying.huang@intel.com,
 feng.tang@intel.com, fengwei.yin@intel.com,
 Frederic Weisbecker <frederic@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org
References: <87zfth3l6y.fsf@somnus>
 <9272d284-ec2c-4e35-be90-c8852278b648@arm.com> <87h6foig4s.fsf@somnus>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <87h6foig4s.fsf@somnus>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 26/04/2024 11:15, Anna-Maria Behnsen wrote:
> Christian Loehle <christian.loehle@arm.com> writes:
> 
>> On 25/04/2024 09:23, Anna-Maria Behnsen wrote:
>>> Hi,
>>>
>>> (adding cpuidle/power people to cc-list)
>>>
>>> Oliver Sang <oliver.sang@intel.com> writes:
>>>
>>>> hi, Frederic Weisbecker,
>>>>
>>>> On Tue, Apr 02, 2024 at 12:46:15AM +0200, Frederic Weisbecker wrote:
>>>>> Le Wed, Mar 27, 2024 at 04:39:17PM +0800, kernel test robot a écrit :
>>>>>>
>>>>>>
>>>>>> Hello,
>>>>>>
>>>>>>
>>>>>> we reported
>>>>>> "[tip:timers/core] [timers]  7ee9887703:  netperf.Throughput_Mbps -1.2% regression"
>>>>>> in
>>>>>> https://lore.kernel.org/all/202403011511.24defbbd-oliver.sang@intel.com/
>>>>>>
>>>>>> now we noticed this commit is in mainline and we captured further results.
>>>>>>
>>>>>> still include netperf results for complete. below details FYI.
>>>>>>
>>>>>>
>>>>>> kernel test robot noticed a -17.1% regression of stress-ng.uprobe.ops_per_sec
>>>>>> on:
>>>>>
>>>>> The good news is that I can reproduce.
>>>>> It has made me spot something already:
>>>>>
>>>>>    https://lore.kernel.org/lkml/ZgsynV536q1L17IS@pavilion.home/T/#m28c37a943fdbcbadf0332cf9c32c350c74c403b0
>>>>>
>>>>> But that's not enough to fix the regression. Investigation continues...
>>>>
>>>> Thanks a lot for information! if you want us test any patch, please let us know.
>>>
>>> Oliver, I would be happy to see, whether the patch at the end of the
>>> message restores the original behaviour also in your test setup. I
>>> applied it on 6.9-rc4. This patch is not a fix - it is just a pointer to
>>> the kernel path, that might cause the regression. I know, it is
>>> probable, that a warning in tick_sched is triggered. This happens when
>>> the first timer is alredy in the past. I didn't add an extra check when
>>> creating the 'defacto' timer thingy. But existing code handles this
>>> problem already properly. So the warning could be ignored here.
>>>
>>> For the cpuidle people, let me explain what I oberserved, my resulting
>>> assumption and my request for help:
>>>
>>> cpuidle governors use expected sleep length values (beside other data)
>>> to decide which idle state would be good to enter. The expected sleep
>>> length takes the first queued timer of the CPU into account and is
>>> provided by tick_nohz_get_sleep_length(). With the timer pull model in
>>> place the non pinned timers are not taken into account when there are
>>> other CPUs up and running which could handle those timers. This could
>>> lead to increased sleep length values. On my system during the stress-ng
>>> uprobes test it was in the range of maximum 100us without the patch set
>>> and with the patch set the maximum was in a range of 200sec. This is
>>> intended behaviour, because timers which could expire on any CPU should
>>> expire on the CPU which is busy anyway and the non busy CPU should be
>>> able to go idle.
>>>
>>> Those increased sleep length values were the only anomalies I could find
>>> in the traces with the regression.
>>>
>>> I created the patch below which simply fakes the sleep length values
>>> that they take all timers of the CPU into account (also the non
>>> pinned). This patch kind of restores the behavoir of
>>> tick_nohz_get_sleep_length() before the change but still with the timer
>>> pull model in place.
>>>
>>> With the patch the regression was gone, at least on my system (using
>>> cpuidle governor menu but also teo).
>>
>> I assume the regression is reproducible for both?
>> (The original report is using menu for anyone else looking at this)
> 
> Yes. (at least in my setup)
> 
>>>
>>> So my assumption here is, that cpuidle governors assume that a deeper
>>> idle state could be choosen and selecting the deeper idle state makes an
>>> overhead when returning from idle. But I have to notice here, that I'm
>>> still not familiar with cpuidle internals... So I would be happy about
>>> some hints how I can debug/trace cpuidle internals to falsify or verify
>>> this assumption.
>>
>> I'd say that sounds correct.
>> Comparing cpu_idle_miss would be interesting for both.
> 
> 	total nr	above		below
> "bad":	2518343		2329072		189271
> "good":	3016019         2960004		56015
> 
> -> this is the result of just a single run using:
> 
>   perf script record -a -e power:cpu_idle_miss /home/anna-maria/src/stress-ng/stress-ng --timeout 60  --times --verify --metrics --no-rand-seed --uprobe 112

Thanks and sorry, I just realised now that this is the stress-ng uprobe and
not the netperf regression. So hopefully that shouldn't be much trouble
reproducing on my end. I will give that a try.

> 
> But beside of this, when running this stress-ng test, the cpus seems to
> be mostly idle (top tells me). So the question here fore me is, what is
> the stress in this test and what should the numbers tell we are
> comparing? It is not totally clear to me even after looking at the code.

Since we have a performance regression that is or may be related to cpuidle
the first thing I would like to know is if the governor is doing a good
job from a cpuidle perspective (and the regression is caused by the latency
of waking up from the deeper idle states that were a correct decision) or
if you can already see issues just from a cpuidle perspective.
Anyway I'll take a look and report back!

Regards,
Christian

> 
> Thanks,
> 
> 	Anna-Maria
> 


