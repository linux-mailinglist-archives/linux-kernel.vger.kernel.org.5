Return-Path: <linux-kernel+bounces-5009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B02C881853B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 11:21:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C592B226DD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 10:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74CB914A90;
	Tue, 19 Dec 2023 10:21:30 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0246A14F78;
	Tue, 19 Dec 2023 10:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4A99E1FB;
	Tue, 19 Dec 2023 02:22:11 -0800 (PST)
Received: from [10.57.85.227] (unknown [10.57.85.227])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C4BBD3F738;
	Tue, 19 Dec 2023 02:21:24 -0800 (PST)
Message-ID: <4f780b5e-7e37-40e3-bdf1-d7fe5d8dd1fc@arm.com>
Date: Tue, 19 Dec 2023 10:22:30 +0000
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
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20231217182255.mgrpgpu6ojjg62jp@airbuntu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Qais,

On 12/17/23 18:22, Qais Yousef wrote:
> Hi Lukasz
> 
> On 11/29/23 11:08, Lukasz Luba wrote:
>> Hi all,
>>
>> This patch set adds a new feature which allows to modify Energy Model (EM)
>> power values at runtime. It will allow to better reflect power model of
>> a recent SoCs and silicon. Different characteristics of the power usage
>> can be leveraged and thus better decisions made during task placement in EAS.
>>
>> It's part of feature set know as Dynamic Energy Model. It has been presented
>> and discussed recently at OSPM2023 [3]. This patch set implements the 1st
>> improvement for the EM.
> 
> Thanks. The problem of EM accuracy has been observed in the field and would be
> nice to have a mainline solution for it. We carry our own out-of-tree change to
> enable modifying the EM.

Thanks for that statement here.

> 
>>
>> The concepts:
>> 1. The CPU power usage can vary due to the workload that it's running or due
>> to the temperature of the SoC. The same workload can use more power when the
>> temperature of the silicon has increased (e.g. due to hot GPU or ISP).
>> In such situation the EM can be adjusted and reflect the fact of increased
>> power usage. That power increase is due to static power
>> (sometimes called simply: leakage). The CPUs in recent SoCs are different.
>> We have heterogeneous SoCs with 3 (or even 4) different microarchitectures.
>> They are also built differently with High Performance (HP) cells or
>> Low Power (LP) cells. They are affected by the temperature increase
>> differently: HP cells have bigger leakage. The SW model can leverage that
>> knowledge.
> 
> One thing I'm not sure about is that in practice temperature of the SoC can
> vary a lot in a short period of time. What is the expectation here? I can see
> this useful in practice only if we average it over a window of time. Following
> it will be really hard. Big variations can happen in few ms scales.

It's mostly for long running heavy workloads, which involve other device
than CPUs, e.g. GPU or ISP (Image Signal Processor). Those devices can
heat up the SoC. In our game DrArm running on pixel6 the GPU uses 75-77%
of total power budget (starting from ~2.5W for GPU + 1.3W for all CPUs).
That 2.5W from the GPU is heating up the CPUs and mostly impact the Big
cores, which are made from High-Performance cells (thus leaking more).
OverUtilization in the first 4-5min of gaming is ~4-9%, so EAS can work
and save some power, if it has a good model. Later we have thermal
throttling and OU goes to ~50% but EAS still can work. If the model is
more precised - thus adjusted for the raising leakage due to temperature
increase (generated due to GPU power), than we still can use better that
power budget and not waist on the leakage at higher OPPs.

> 
> Driver interface for this part makes sense; as thermal framework will likely to
> know how feed things back to EM table, if necessary.

Thermal framework or I would rather say smarter thermal dedicated driver
which has built-in power model and access to the sensors data. In this
way it can provide adjusted power model into the EM dynamically.
It will also calculate the efficiency (the 'cost' field).

> 
>>
>> 2. It is also possible to change the EM to better reflect the currently
>> running workload. Usually the EM is derived from some average power values
>> taken from experiments with benchmark (e.g. Dhrystone). The model derived
>> from such scenario might not represent properly the workloads usually running
>> on the device. Therefore, runtime modification of the EM allows to switch to
>> a different model, when there is a need.
> 
> I didn't get how the new performance field is supposed to be controlled and
> modified by users. A driver interface doesn't seem suitable as there's no
> subsystem that knows the characteristic of the workload except userspace. In
> Android we do have contextual info about what the current top-app to enable
> modifying the capacities to match its characteristics.

Well in latest public documentation (May2023) for Cortex-X4 there are
described new features of Arm cores: PDP, MPMM, which can change the
'performance' of the core in FW. Our SCMI kernel subsystem will get an
interrupt, so the drivers can know about it. It could be used for
recalculating the efficiency of the CPUs in the EM. When there is no
hotplug and the long running app is still running, that FW policy would
be reflected in EM. It's just not done all-in-one-step. Those patches
will be later.

Second, I have used that 'performance' field to finally get rid of
this runtime division in em_cpu_energy() hot path - which was annoying
me for very long time. It wasn't possible to optimize that last
operation there, because the not all CPUs boot and final CPU capacity
is not known when we register EMs. With this feature finally I can
remove that heavy operation. You can see more in that patch 15/23.

> 
>>
>> 3. The EM can be adjusted after boot, when all the modules are loaded and
>> more information about the SoC is available e.g. chip binning. This would help
>> to better reflect the silicon characteristics. Thus, this EM modification
>> API allows it now. It wasn't possible in the past and the EM had to be
>> 'set in stone'.
>>
>> More detailed explanation and background can be found in presentations
>> during LPC2022 [1][2] or in the documentation patches.
>>
>> Some test results.
>> The EM can be updated to fit better the workload type. In the case below the EM
>> has been updated for the Jankbench test on Pixel6 (running v5.18 w/ mainline backports
>> for the scheduler bits). The Jankbench was run 10 times for those two configurations,
>> to get more reliable data.
>>
>> 1. Janky frames percentage
>> +--------+-----------------+---------------------+-------+-----------+
>> | metric |    variable     |       kernel        | value | perc_diff |
>> +--------+-----------------+---------------------+-------+-----------+
>> | gmean  | jank_percentage | EM_default          |  2.0  |   0.0%    |
>> | gmean  | jank_percentage | EM_modified_runtime |  1.3  |  -35.33%  |
>> +--------+-----------------+---------------------+-------+-----------+
>>
>> 2. Avg frame render time duration
>> +--------+---------------------+---------------------+-------+-----------+
>> | metric |      variable       |       kernel        | value | perc_diff |
>> +--------+---------------------+---------------------+-------+-----------+
>> | gmean  | mean_frame_duration | EM_default          | 10.5  |   0.0%    |
>> | gmean  | mean_frame_duration | EM_modified_runtime |  9.6  |  -8.52%   |
>> +--------+---------------------+---------------------+-------+-----------+
>>
>> 3. Max frame render time duration
>> +--------+--------------------+---------------------+-------+-----------+
>> | metric |      variable      |       kernel        | value | perc_diff |
>> +--------+--------------------+---------------------+-------+-----------+
>> | gmean  | max_frame_duration | EM_default          | 251.6 |   0.0%    |
>> | gmean  | max_frame_duration | EM_modified_runtime | 115.5 |  -54.09%  |
>> +--------+--------------------+---------------------+-------+-----------+
>>
>> 4. OS overutilized state percentage (when EAS is not working)
>> +--------------+---------------------+------+------------+------------+
>> |    metric    |       wa_path       | time | total_time | percentage |
>> +--------------+---------------------+------+------------+------------+
>> | overutilized | EM_default          | 1.65 |   253.38   |    0.65    |
>> | overutilized | EM_modified_runtime | 1.4  |   277.5    |    0.51    |
>> +--------------+---------------------+------+------------+------------+
>>
>> 5. All CPUs (Little+Mid+Big) power values in mW
>> +------------+--------+---------------------+-------+-----------+
>> |  channel   | metric |       kernel        | value | perc_diff |
>> +------------+--------+---------------------+-------+-----------+
>> |    CPU     | gmean  | EM_default          | 142.1 |   0.0%    |
>> |    CPU     | gmean  | EM_modified_runtime | 131.8 |  -7.27%   |
>> +------------+--------+---------------------+-------+-----------+
> 
> How did you modify the EM here? Did you change both performance and power
> fields? How did you calculate the new ones?

It was just the power values modified on my pixel6:
for Littles 1.6x, Mid 0.8x, Big 1.3x of their boot power.
TBH I don't know the chip binning of that SoC, but I suspect it
could be due to this fact. More about possible error range in chip
binning power values you can find in my comment to the patch 22/23

> 
> Did you try to simulate any heating effect during the run if you're taking
> temperature into account to modify the power? What was the variation like and

Yes, I did that experiment and presented on OSPM 2023 slide 13. There is
big CPU power plot change in time, due to GPU heat. All detailed data is
there. The big CPU power is ~18-20% higher when 1-1.5W GPU is heating up
the whole SoC.

> at what rate was the EM being updated in this case? I think Jankbench in

In this experiment EM was only set once w/ the values mentioned above.
It could be due to the chip lottery. I cannot say on 100% this phone.

> general wouldn't stress the SoC enough.

True, this test is not power heavy as it can be seen. It's more
to show that the default EM after boot might not be the optimal one.

> 
> It'd be insightful to look at frequency residencies between the two runs and
> power breakdown for each cluster if you have access to them. No worries if not!

I'm afraid you're asking for too much ;)

> 
> My brain started to fail me somewhere around patch 15. I'll have another look
> some time later in the week but generally looks good to me. If I have any
> worries it is about how it can be used with the provided interfaces. Especially
> expectations about managing fast thermal changes at the level you're targeting.

No worries, thanks for the review! The fast thermal changes, which are
linked to the CPU's workload are not an issue here and I'm not worried
about those. The side effect of the heat from other device is the issue.
Thus, that thermal driver which modifies the EM should be aware of the
'whole SoC' situation (like mainline IPA does, when it manages all
devices in a single thermal zone).

Regards,
Lukasz

