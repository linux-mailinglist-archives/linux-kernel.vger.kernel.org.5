Return-Path: <linux-kernel+bounces-14328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF9C6821B6F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 13:11:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 679D31F21259
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 12:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66670EED9;
	Tue,  2 Jan 2024 12:11:39 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D11EBEAED;
	Tue,  2 Jan 2024 12:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5AD3DC15;
	Tue,  2 Jan 2024 04:12:22 -0800 (PST)
Received: from [10.57.86.61] (unknown [10.57.86.61])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E2F093F7A6;
	Tue,  2 Jan 2024 04:11:33 -0800 (PST)
Message-ID: <c546fb2b-e713-4dec-a4cb-d597bc432b4a@arm.com>
Date: Tue, 2 Jan 2024 12:12:51 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/23] Introduce runtime modifiable Energy Model
Content-Language: en-US
To: Qais Yousef <qyousef@layalina.io>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 rafael@kernel.org, dietmar.eggemann@arm.com, rui.zhang@intel.com,
 amit.kucheria@verdurent.com, amit.kachhap@gmail.com,
 daniel.lezcano@linaro.org, viresh.kumar@linaro.org, len.brown@intel.com,
 pavel@ucw.cz, mhiramat@kernel.org, wvw@google.com
References: <20231129110853.94344-1-lukasz.luba@arm.com>
 <20231217182255.mgrpgpu6ojjg62jp@airbuntu>
 <4f780b5e-7e37-40e3-bdf1-d7fe5d8dd1fc@arm.com>
 <20231228184107.mfxgfwaclwaeqswg@airbuntu>
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20231228184107.mfxgfwaclwaeqswg@airbuntu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/28/23 18:41, Qais Yousef wrote:
> On 12/19/23 10:22, Lukasz Luba wrote:
> 
>>> One thing I'm not sure about is that in practice temperature of the SoC can
>>> vary a lot in a short period of time. What is the expectation here? I can see
>>> this useful in practice only if we average it over a window of time. Following
>>> it will be really hard. Big variations can happen in few ms scales.
>>
>> It's mostly for long running heavy workloads, which involve other device
>> than CPUs, e.g. GPU or ISP (Image Signal Processor). Those devices can
>> heat up the SoC. In our game DrArm running on pixel6 the GPU uses 75-77%
>> of total power budget (starting from ~2.5W for GPU + 1.3W for all CPUs).
>> That 2.5W from the GPU is heating up the CPUs and mostly impact the Big
>> cores, which are made from High-Performance cells (thus leaking more).
>> OverUtilization in the first 4-5min of gaming is ~4-9%, so EAS can work
>> and save some power, if it has a good model. Later we have thermal
>> throttling and OU goes to ~50% but EAS still can work. If the model is
>> more precised - thus adjusted for the raising leakage due to temperature
>> increase (generated due to GPU power), than we still can use better that
>> power budget and not waist on the leakage at higher OPPs.
> 
> I can understand the need. But looking at one specific case vs generalized form
> is different.
> 
> So IIUC the expectation is to track temperature variations over minutes by
> external sources to CPU.

Yes

> 
>>> I didn't get how the new performance field is supposed to be controlled and
>>> modified by users. A driver interface doesn't seem suitable as there's no
>>> subsystem that knows the characteristic of the workload except userspace. In
>>> Android we do have contextual info about what the current top-app to enable
>>> modifying the capacities to match its characteristics.
>>
>> Well in latest public documentation (May2023) for Cortex-X4 there are
>> described new features of Arm cores: PDP, MPMM, which can change the
>> 'performance' of the core in FW. Our SCMI kernel subsystem will get an
>> interrupt, so the drivers can know about it. It could be used for
>> recalculating the efficiency of the CPUs in the EM. When there is no
>> hotplug and the long running app is still running, that FW policy would
>> be reflected in EM. It's just not done all-in-one-step. Those patches
>> will be later.
> 
> I think these features are some form of thermal throttling IIUC.
> 
> I was asking for handling the EM accuracy issue using the runtime model. I was
> expecting some sysfs knobs. Do you see this also require a vendor specific
> driver to try to account for the EM inaccuracy issues we're seeing?

Yes, it needs vendor driver. In the EM fwk we don't plan to add sysfs
interface.

> 
>> Second, I have used that 'performance' field to finally get rid of
>> this runtime division in em_cpu_energy() hot path - which was annoying
>> me for very long time. It wasn't possible to optimize that last
>> operation there, because the not all CPUs boot and final CPU capacity
>> is not known when we register EMs. With this feature finally I can
>> remove that heavy operation. You can see more in that patch 15/23.
> 
> Yep, it's good addition :)
> 
>>>> 5. All CPUs (Little+Mid+Big) power values in mW
>>>> +------------+--------+---------------------+-------+-----------+
>>>> |  channel   | metric |       kernel        | value | perc_diff |
>>>> +------------+--------+---------------------+-------+-----------+
>>>> |    CPU     | gmean  | EM_default          | 142.1 |   0.0%    |
>>>> |    CPU     | gmean  | EM_modified_runtime | 131.8 |  -7.27%   |
>>>> +------------+--------+---------------------+-------+-----------+
>>>
>>> How did you modify the EM here? Did you change both performance and power
>>> fields? How did you calculate the new ones?
>>
>> It was just the power values modified on my pixel6:
>> for Littles 1.6x, Mid 0.8x, Big 1.3x of their boot power.
>> TBH I don't know the chip binning of that SoC, but I suspect it
>> could be due to this fact. More about possible error range in chip
>> binning power values you can find in my comment to the patch 22/23
> 
> Strange just modifying the power had this impact. It could be related to
> similar impact I've seen with migration margin for the little increasing. By
> making the cost higher there, then it'd move the residency to other cores and
> potentially reduce running at higher freq on the littles.

Well, on Pixel6 we don't know the chip binning for the CPUs and big L3
cache... This could be the source of such a need in power values
adjustment. In my OdroidXU4 (Exynos5422) I can see binning and the max
power for some OPP can be ~30%. It's too big to ignore and I dare to say
that in Pixel6 the binning should be there (don't know the variation
though).

> 
>>> Did you try to simulate any heating effect during the run if you're taking
>>> temperature into account to modify the power? What was the variation like and
>>
>> Yes, I did that experiment and presented on OSPM 2023 slide 13. There is
>> big CPU power plot change in time, due to GPU heat. All detailed data is
>> there. The big CPU power is ~18-20% higher when 1-1.5W GPU is heating up
>> the whole SoC.
> 
> I meant during your experiment above.

For that experiment there power is too low and GPU is even lower ~5-10mW
so there is no temperature impact.

> 
>>> at what rate was the EM being updated in this case? I think Jankbench in
>>
>> In this experiment EM was only set once w/ the values mentioned above.
>> It could be due to the chip lottery. I cannot say on 100% this phone.
>>
>>> general wouldn't stress the SoC enough.
>>
>> True, this test is not power heavy as it can be seen. It's more
>> to show that the default EM after boot might not be the optimal one.
> 
> I wouldn't reach that conclusion for this particular case. But the underlying
> issues exists for sure.

Hard to say for sure the root cause, when you don't have full access to
the SoC internals and doc. We would need the chip binning and some
other internals.

> 
>>> It'd be insightful to look at frequency residencies between the two runs and
>>> power breakdown for each cluster if you have access to them. No worries if not!
>>
>> I'm afraid you're asking for too much ;)
> 
> It should be easy to get them. It's hard to know where the benefit is coming
> from otherwise. But as I said, no worries if not. If you have perfetto traces
> I can take help to take a look.

We use Mid cores more (but still at lowest OPP) instead of keeping them
in idle. I don't have perfetto traces.

> 
>>> My brain started to fail me somewhere around patch 15. I'll have another look
>>> some time later in the week but generally looks good to me. If I have any
>>> worries it is about how it can be used with the provided interfaces. Especially
>>> expectations about managing fast thermal changes at the level you're targeting.
>>
>> No worries, thanks for the review! The fast thermal changes, which are
>> linked to the CPU's workload are not an issue here and I'm not worried
>> about those. The side effect of the heat from other device is the issue.
>> Thus, that thermal driver which modifies the EM should be aware of the
>> 'whole SoC' situation (like mainline IPA does, when it manages all
>> devices in a single thermal zone).
> 
> I think in practice there will be challenges to generalize the thermal impact.
> But overall from EM accuracy point of view (for all the various reasons
> mentioned), we need this ability to help handle them in practice. Booting with
> a single hardcoded EM doesn't work.
> 

Thanks, I agree. That's the main goal, to get rid of the single
hardcoded EM created during boot, from sometimes bogus information.

Regards,
Lukasz


