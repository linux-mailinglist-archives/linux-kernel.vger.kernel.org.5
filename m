Return-Path: <linux-kernel+bounces-67128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 282FB8566B7
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 16:00:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D922E28B892
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 15:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95F7C133287;
	Thu, 15 Feb 2024 14:57:47 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 520DD13173F;
	Thu, 15 Feb 2024 14:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708009067; cv=none; b=fFWy5pJqhtCu9Tr6wbTbLDOYrgm2Ot1yZrnBBe78lGwZkFAXFx6SFGda43bk5lvac+S9ijN/61YDI9sUMT2Q5giPU/kL2klReUglXUnICKs5UtPAJ//IoQBD2lSIbEKzY+tkx/wmYuxndR3M2QivBduAAhs0K5woRNbqD4OxMdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708009067; c=relaxed/simple;
	bh=1Gv7+LBoNQLxJ3O3mSHbpiF5DyNS3KBkgKz/fRO/mSE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nb1pr7DjZzlrjCTJrS8ehvHrq4z+L2S7NLwcAqs8TwpDlWv9Hdld+7cXtbM+t1PQj841Ksq7Z7rI8zCWNlF3Kv4xLGLxoEJMi38DI2OPYsArsw2gvf05/z6qOamAfRPvUwxPqzyC4cccvdNaDRMwXpqZ3BkABOZT++3E32pgNik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B24851FB;
	Thu, 15 Feb 2024 06:58:18 -0800 (PST)
Received: from [192.168.178.6] (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B27B13F7A6;
	Thu, 15 Feb 2024 06:57:35 -0800 (PST)
Message-ID: <265e5f2c-9b45-420f-89b1-44369aeb8418@arm.com>
Date: Thu, 15 Feb 2024 15:57:34 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] cpufreq: scmi: Add boost frequency support
Content-Language: en-US
To: Sibi Sankar <quic_sibis@quicinc.com>, Sudeep Holla
 <sudeep.holla@arm.com>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: cristian.marussi@arm.com, rafael@kernel.org, morten.rasmussen@arm.com,
 lukasz.luba@arm.com, sboyd@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 quic_mdtipton@quicinc.com, linux-arm-msm@vger.kernel.org, nm@ti.com
References: <20240117110443.2060704-1-quic_sibis@quicinc.com>
 <20240123060827.a3vszziftj6pszt3@vireshk-i7> <Za-RtBrSxI-j4Jdx@bogus>
 <e968092a-dc2b-4351-9489-acf874bbc7b6@arm.com>
 <01b3d0ed-3fd3-86c6-7b0f-48d34a5d9ba8@quicinc.com>
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <01b3d0ed-3fd3-86c6-7b0f-48d34a5d9ba8@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 13/02/2024 08:35, Sibi Sankar wrote:
> 
> 
> On 1/31/24 20:37, Dietmar Eggemann wrote:
>> On 23/01/2024 11:15, Sudeep Holla wrote:
>>> On Tue, Jan 23, 2024 at 11:38:27AM +0530, Viresh Kumar wrote:
>>>> On 17-01-24, 16:34, Sibi Sankar wrote:

[...]

>> root@juno:/sys/devices/system/cpu/cpufreq# cat boost policy*/boost
>> 1
>> 0
>> 0
>>
>> root@juno:/sys/devices/system/cpu/cpufreq# cat
>> policy*/scaling_available_frequencies policy*/scaling_boost_frequencies
>> 450000 575000 700000
>> 450000 625000 800000
>> 775000 850000
>> 950000 1100000
>>
>> If I disable system-wide boost I see the correct influence on
>> 'cpufreq_pressure':
>>
>> root@juno:/sys/devices/system/cpu/cpufreq# echo 0 > boost
>>
>> [  439.466682] cpufreq_update_pressure() cpu=1 cpufreq_pressure=280
>> [  439.472797] cpufreq_update_pressure() cpu=2 cpufreq_pressure=280
>> [  439.478889] cpufreq_update_pressure() cpu=0 cpufreq_pressure=79
>> [  439.484852] cpufreq_update_pressure() cpu=3 cpufreq_pressure=79
>> [  439.490843] cpufreq_update_pressure() cpu=4 cpufreq_pressure=79
>> [  439.499621] cpufreq_update_pressure() cpu=5 cpufreq_pressure=79
>>
>> reflecting the max frequency change from '1100000 to 800000' on CPU1,2
>> and from '850000 to 700000' on CPU0,3-5.
>>
>> root@juno:/sys/devices/system/cpu/cpufreq# echo 1 > boost
>>
>> [ 2722.693113] cpufreq_update_pressure() cpu=1 cpufreq_pressure=0
>> [ 2722.699041] cpufreq_update_pressure() cpu=2 cpufreq_pressure=0
>> [ 2722.704962] cpufreq_update_pressure() cpu=0 cpufreq_pressure=0
>> [ 2722.710842] cpufreq_update_pressure() cpu=3 cpufreq_pressure=0
>> [ 2722.719644] cpufreq_update_pressure() cpu=4 cpufreq_pressure=0
>> [ 2722.728224] cpufreq_update_pressure() cpu=5 cpufreq_pressure=0
>>
>> What doesn't work for me is to disable boost per policy:
>>
>> root@juno:/sys/devices/system/cpu/cpufreq# echo 1 > boost
>> root@juno:/sys/devices/system/cpu/cpufreq# echo 0 > policy0/boost
>> root@juno:/sys/devices/system/cpu/cpufreq# echo 0 > policy1/boost
>>
>> Here I don't see 'cpufreq_pressure' changes.
>>
>> BTW, what's the use case you have in mind for this feature? Is it to cap
>> high OPPs for CPUs in a certain CPUfreq policy?
> 
> Yeah, that's exactly the use case for X1E. Boost frequencies defined in
> the SoC are achievable by only one CPU in a cluster i.e. either the
> other CPUs in the same cluster should be in low power mode or offline.
> So it's mostly for book keeping i.e. we wouldn't to intimate incorrectly
> that the CPUs are running at max possible frequency when it's actually
> running at a lower frequency.

I see.

What about the issue with the settings of the global and the per-policy
'boost' file?

On my Juno-r0 the initial boost values are:

(1) Initial setting:

root@juno:/sys/devices/system/cpu/cpufreq# cat boost policy*/boost
1
0
0

Should they not all be 1 ?


(2) Disabling system-wide boost

root@juno:/sys/devices/system/cpu/cpufreq# echo 0 > boost

Here I see 'cpufreq_pressure > 0' for all CPUs.


(3) Enabling system-wide boost

root@juno:/sys/devices/system/cpu/cpufreq# echo 1 > boost

And here 'cpufreq_pressure == 0' for all CPUs.


(4) Disabling boost for policy0.

root@juno:/sys/devices/system/cpu/cpufreq# echo 0 > policy0/boost

root@juno:/sys/devices/system/cpu/cpufreq# cat boost policy*/boost
1
0
1

Here nothing happened. But I was expecting to see 'cpufreq_pressure > 0'
for CPUs of policy0:

root@juno:/sys/devices/system/cpu/cpufreq# cat policy0/affected_cpus
0 3 4 5

