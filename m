Return-Path: <linux-kernel+bounces-46685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7B9F8442A3
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 16:08:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D16F288EFE
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 15:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88B9E69D00;
	Wed, 31 Jan 2024 15:07:55 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA9FA5DF35;
	Wed, 31 Jan 2024 15:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706713675; cv=none; b=uQFIdKDCmfrZ8UvjarmDmDnsHT009CLYAtzNXpkXR5Rx4zSXhjsKBNieRBAEK8CxRHN59xvpbfo7+uyLujX5QkDoT5yiUg7v8ltQztwAb41GduHLiUJ1qbpXb+4NZSTFOCGDJ859qRVH+iUQUx6Kwq5bfRlqxZXTR2DGeOTlCp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706713675; c=relaxed/simple;
	bh=5CGuVX64DYCwdNnCJUQsNva1RNBMZiRYqfO2D2HvL0o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OpnQDAlqTtFsJBCn4lZBO5/+1nbY34q6NlVQjJNtxt4WBvgjBrT/mXTkNSY4huRhSmHFQ8bVo84jTSGyyxhH+7368i7t3p9M3rPn7/S3w45jNHKU+bniQfolV706jwrvX0Jvax3f03cKYbbJoR/buowixI0z2bWn3FCdOXYvTF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 35C31DA7;
	Wed, 31 Jan 2024 07:08:35 -0800 (PST)
Received: from [192.168.178.6] (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A8D0C3F762;
	Wed, 31 Jan 2024 07:07:49 -0800 (PST)
Message-ID: <e968092a-dc2b-4351-9489-acf874bbc7b6@arm.com>
Date: Wed, 31 Jan 2024 16:07:48 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] cpufreq: scmi: Add boost frequency support
Content-Language: en-US
To: Sudeep Holla <sudeep.holla@arm.com>,
 Viresh Kumar <viresh.kumar@linaro.org>
Cc: Sibi Sankar <quic_sibis@quicinc.com>, cristian.marussi@arm.com,
 rafael@kernel.org, morten.rasmussen@arm.com, lukasz.luba@arm.com,
 sboyd@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 quic_mdtipton@quicinc.com, linux-arm-msm@vger.kernel.org, nm@ti.com
References: <20240117110443.2060704-1-quic_sibis@quicinc.com>
 <20240123060827.a3vszziftj6pszt3@vireshk-i7> <Za-RtBrSxI-j4Jdx@bogus>
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <Za-RtBrSxI-j4Jdx@bogus>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23/01/2024 11:15, Sudeep Holla wrote:
> On Tue, Jan 23, 2024 at 11:38:27AM +0530, Viresh Kumar wrote:
>> On 17-01-24, 16:34, Sibi Sankar wrote:
>>> This series adds provision to mark dynamic opps as boost capable and adds
>>> boost frequency support to the scmi cpufreq driver.
>>>
>>> Depends on:
>>> HW pressure v4: https://patchwork.kernel.org/project/linux-arm-msm/cover/20240109164655.626085-1-vincent.guittot@linaro.org/
>>> scmi notification v2: https://patchwork.kernel.org/project/linux-arm-msm/cover/20240117104116.2055349-1-quic_sibis@quicinc.com/
>>>
>>> Sibi Sankar (3):
>>>   OPP: Extend dev_pm_opp_data with turbo support
>>>   firmware: arm_scmi: Add support for marking certain frequencies as
>>>     boost
>>>   cpufreq: scmi: Enable boost support
>>
>> Sudeep, please lemme know if you are okay with the changes. Will apply
>> them.
> 
> I was planning to look at it once Lukasz/Dietmar confirm that this concept
> doesn't change anything fundamental in the way EAS related changes work
> today. I know I suggested the change as that seem to be right way to do
> but I haven't analysed if this has any negative impact on the existing
> features as this change will impact all the existing platform with OPPs
> above sustained performance/frequency advertised from the SCMI platform
> firmware.

I was mostly concerned about the settings for the CPU frequency
invariance implementation in [drivers/base/arch_topology.c]:

#define arch_scale_freq_capacity topology_get_freq_scale

But per_cpu(capacity_freq_ref, cpu) is still set to
'policy->cpuinfo.max_freq' in init_cpu_capacity_callback()
which stays the same.

With some extra debugging I get the following on Juno-r0 [L b b L L L]:

root@juno:~# dmesg -w | grep -i "freq\|boost\|noti\|OPP\|cap" 

[    1.768414] arm-scmi firmware:scmi: SCMI Notifications - Core Enabled.
[    1.793084] [1][LITTLE_CPU]:: Registered OPP[0] 450000000
[    1.798624] [1][LITTLE_CPU]:: Registered OPP[1] 575000000
[    1.804131] [1][LITTLE_CPU]:: Registered OPP[2] 700000000
[    1.809552] scmi_dvfs_device_opps_add() sustained_freq=700000000 freq=775000000
[    1.816971] [1][LITTLE_CPU]:: Registered OPP[3] 775000000
[    1.822392] scmi_dvfs_device_opps_add() sustained_freq=700000000 freq=850000000
[    1.829800] [1][LITTLE_CPU]:: Registered OPP[4] 850000000
[    1.835268] enabled boost: 0
[    1.838173] init_cpu_capacity_callback() cpu=0 max_freq=850000
[    1.844032] init_cpu_capacity_callback() cpu=3 max_freq=850000
[    1.849886] init_cpu_capacity_callback() cpu=4 max_freq=850000
[    1.855743] init_cpu_capacity_callback() cpu=5 max_freq=850000
[    1.866324] cpufreq_update_pressure() cpu=0 cpufreq_pressure=0
[    1.872178] cpufreq_update_pressure() cpu=3 cpufreq_pressure=0
[    1.878026] cpufreq_update_pressure() cpu=4 cpufreq_pressure=0
[    1.883874] cpufreq_update_pressure() cpu=5 cpufreq_pressure=0
[    1.890633] [0][BIG_CPU]:: Registered OPP[0] 450000000
[    1.895892] [0][BIG_CPU]:: Registered OPP[1] 625000000
[    1.901129] [0][BIG_CPU]:: Registered OPP[2] 800000000
[    1.906286] scmi_dvfs_device_opps_add() sustained_freq=800000000 freq=950000000
[    1.906381] [0][BIG_CPU]:: Registered OPP[3] 950000000
[    1.917377] scmi_dvfs_device_opps_add() sustained_freq=800000000 freq=1100000000
[    1.917468] [0][BIG_CPU]:: Registered OPP[4] 1100000000
[    1.939237] enabled boost: 0
[    1.942134] init_cpu_capacity_callback() cpu=1 max_freq=1100000
[    1.948078] init_cpu_capacity_callback() cpu=2 max_freq=1100000
[    1.959003] cpufreq_update_pressure() cpu=1 cpufreq_pressure=0
[    1.964853] cpufreq_update_pressure() cpu=2 cpufreq_pressure=0

root@juno:/sys/devices/system/cpu/cpufreq# cat boost policy*/boost
1
0
0

root@juno:/sys/devices/system/cpu/cpufreq# cat policy*/scaling_available_frequencies policy*/scaling_boost_frequencies
450000 575000 700000 
450000 625000 800000 
775000 850000 
950000 1100000

If I disable system-wide boost I see the correct influence on
'cpufreq_pressure':

root@juno:/sys/devices/system/cpu/cpufreq# echo 0 > boost

[  439.466682] cpufreq_update_pressure() cpu=1 cpufreq_pressure=280 
[  439.472797] cpufreq_update_pressure() cpu=2 cpufreq_pressure=280
[  439.478889] cpufreq_update_pressure() cpu=0 cpufreq_pressure=79
[  439.484852] cpufreq_update_pressure() cpu=3 cpufreq_pressure=79
[  439.490843] cpufreq_update_pressure() cpu=4 cpufreq_pressure=79
[  439.499621] cpufreq_update_pressure() cpu=5 cpufreq_pressure=79

reflecting the max frequency change from '1100000 to 800000' on CPU1,2
and from '850000 to 700000' on CPU0,3-5.

root@juno:/sys/devices/system/cpu/cpufreq# echo 1 > boost

[ 2722.693113] cpufreq_update_pressure() cpu=1 cpufreq_pressure=0
[ 2722.699041] cpufreq_update_pressure() cpu=2 cpufreq_pressure=0
[ 2722.704962] cpufreq_update_pressure() cpu=0 cpufreq_pressure=0
[ 2722.710842] cpufreq_update_pressure() cpu=3 cpufreq_pressure=0
[ 2722.719644] cpufreq_update_pressure() cpu=4 cpufreq_pressure=0
[ 2722.728224] cpufreq_update_pressure() cpu=5 cpufreq_pressure=0

What doesn't work for me is to disable boost per policy:

root@juno:/sys/devices/system/cpu/cpufreq# echo 1 > boost 
root@juno:/sys/devices/system/cpu/cpufreq# echo 0 > policy0/boost 
root@juno:/sys/devices/system/cpu/cpufreq# echo 0 > policy1/boost

Here I don't see 'cpufreq_pressure' changes.

BTW, what's the use case you have in mind for this feature? Is it to cap
high OPPs for CPUs in a certain CPUfreq policy?



