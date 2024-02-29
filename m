Return-Path: <linux-kernel+bounces-86812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79A5086CB2A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 15:15:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DB001C22773
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 14:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 894AE12C53A;
	Thu, 29 Feb 2024 14:15:06 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E111D12FB0B;
	Thu, 29 Feb 2024 14:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709216105; cv=none; b=aLJ0vpDLSAXOQNZ3jJJbE8595OKPuENxN+D/XPDw+UsWU/KJNJDsLwEEGLVTWJUqja8WDVdqtBWZIr97OoHH0HKi4dSyfwZNYpb6KHubklYEjdQkdF4QNaJvDi8euEf4vBssaZ9Nhr/q3g5OIEiSNDaBD6DPCTaGtJ0U2tzj4Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709216105; c=relaxed/simple;
	bh=SOJeGxTl0P3bQbsHku67aZnJjprqw3J887nhw1Gl0x4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C/s+QDiZwoAEBTL4gefs/k+7twNLLbL/yIS8ZwHl0N1u3+UlPugTo73zJkQ1Q2zYKitHEue8mOY89tKoFiJXmyZEHU+qrFX2/2FJo1M0+xL4E+woCaEWe+BfoCanS+DcQQta9fbQB4tldNwLZVgXeXBVdQIzTZC0P4+8m0GkJWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F36AA1FB;
	Thu, 29 Feb 2024 06:15:41 -0800 (PST)
Received: from [10.57.13.21] (unknown [10.57.13.21])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CF16A3F6C4;
	Thu, 29 Feb 2024 06:15:00 -0800 (PST)
Message-ID: <66ca73cc-8bdd-453a-951c-5e0166340edd@arm.com>
Date: Thu, 29 Feb 2024 14:15:17 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 2/2] cpufreq: scmi: Register for limit change
 notifications
Content-Language: en-US
To: Cristian Marussi <cristian.marussi@arm.com>,
 Sibi Sankar <quic_sibis@quicinc.com>
Cc: sudeep.holla@arm.com, linux-arm-kernel@lists.infradead.org,
 pierre.gondois@arm.com, dietmar.eggemann@arm.com, morten.rasmussen@arm.com,
 viresh.kumar@linaro.org, rafael@kernel.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, quic_mdtipton@quicinc.com,
 linux-arm-msm@vger.kernel.org
References: <20240227181632.659133-1-quic_sibis@quicinc.com>
 <20240227181632.659133-3-quic_sibis@quicinc.com>
 <f8bfc666-c216-44d5-a63b-99f04ff3b8ef@arm.com>
 <2608b2d8-f3b0-b4f5-f8e4-1f2242043ded@quicinc.com>
 <64c6a1bc-92f2-4f44-ab10-cbd2473746f3@arm.com>
 <18c249b2-ce8c-435b-8d65-a1770a1f294e@arm.com> <ZeBqW04f8V4dHphn@pluto>
 <7c82b316-89d9-470d-b46d-f86e81e2add3@arm.com> <ZeB0iCr9GpfUiOEg@pluto>
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <ZeB0iCr9GpfUiOEg@pluto>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2/29/24 12:11, Cristian Marussi wrote:
> On Thu, Feb 29, 2024 at 11:45:41AM +0000, Lukasz Luba wrote:
>>
>>
>> On 2/29/24 11:28, Cristian Marussi wrote:
>>> On Thu, Feb 29, 2024 at 10:22:39AM +0000, Lukasz Luba wrote:
>>>>
>>>>
>>>> On 2/29/24 09:59, Lukasz Luba wrote:
>>>>>
>>>>>
>>>>> On 2/28/24 17:00, Sibi Sankar wrote:
>>>>>>
>>>>>>
>>>>>> On 2/28/24 18:54, Lukasz Luba wrote:
>>>>>>>
>>>>>>>
>>>>>>> On 2/27/24 18:16, Sibi Sankar wrote:
>>>>>>>> Register for limit change notifications if supported and use
>>>>>>>> the throttled
>>>>>>>> frequency from the notification to apply HW pressure.
>>>>>>
>>>>>> Lukasz,
>>>>>>
>>>>>> Thanks for taking time to review the series!
>>>>>>
>>>>>>>>
>>>>>>>> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
>>>>>>>> ---
>>>>>>>>
>>>>>>>> v3:
>>>>>>>> * Sanitize range_max received from the notifier. [Pierre]
>>>>>>>> * Update commit message.
>>>>>>>>
>>>>>>>> ï¿½ drivers/cpufreq/scmi-cpufreq.c | 29 ++++++++++++++++++++++++++++-
>>>>>>>> ï¿½ 1 file changed, 28 insertions(+), 1 deletion(-)
>>>>>>>>
>>>>>>>> diff --git a/drivers/cpufreq/scmi-cpufreq.c
>>>>>>>> b/drivers/cpufreq/scmi-cpufreq.c
>>>>>>>> index 76a0ddbd9d24..78b87b72962d 100644
>>>>>>>> --- a/drivers/cpufreq/scmi-cpufreq.c
>>>>>>>> +++ b/drivers/cpufreq/scmi-cpufreq.c
>>>>>>>> @@ -25,9 +25,13 @@ struct scmi_data {
>>>>>>>> ï¿½ï¿½ï¿½ï¿½ï¿½ int domain_id;
>>>>>>>> ï¿½ï¿½ï¿½ï¿½ï¿½ int nr_opp;
>>>>>>>> ï¿½ï¿½ï¿½ï¿½ï¿½ struct device *cpu_dev;
>>>>>>>> +ï¿½ï¿½ï¿½ struct cpufreq_policy *policy;
>>>>>>>> ï¿½ï¿½ï¿½ï¿½ï¿½ cpumask_var_t opp_shared_cpus;
>>>>>>>> +ï¿½ï¿½ï¿½ struct notifier_block limit_notify_nb;
>>>>>>>> ï¿½ };
>>>>>>>> +const struct scmi_handle *handle;
>>>>>
>>>>> I've missed this bit here.
>>>>
>>>> So for this change we actually have to ask Cristian or Sudeep
>>>> because I'm not sure if we have only one 'handle' instance
>>>> for all cpufreq devices.
>>>>
>>>> If we have different 'handle' we cannot move it to the
>>>> global single pointer.
>>>>
>>>> Sudeep, Cristian what do you think?
>>>
>>> I was just replying noticing this :D .... since SCMI drivers can be
>>> probed multiple times IF you defined multiple scmi top nodes in your DT
>>> containing the same protocol nodes, they receive a distinct sdev/handle/ph
>>> for each probe...so any attempt to globalize these wont work...BUT...
>>>
>>> ...this is a bit of a weird setup BUT it is not against the spec and it can
>>> be used to parallelize more the SCMI accesses to disjont set of resources
>>> within the same protocol (a long story here...) AND this type of setup is
>>> something that it is already used by some other colleagues of Sibi working
>>> on a different line of products (AFAIK)...
>>>
>>> So, for these reasons, usually, all the other SCMI drivers have per-instance
>>> non-global references to handle/sdev/ph....
>>>
>>> ...having said that, thought, looking at the structure of CPUFReq
>>> drivers, I am not sure that they can stand such a similar setup
>>> where multiple instances of this same driver are probed
>>>
>>> .... indeed the existent *ph refs above is already global....so it wont already
>>> work anyway in case of multiple instances now...
>>>
>>> ...and if I look at how CPUFreq expects the signature of scmi_cpufreq_get_rate()
>>> to be annd how it is implemented now using the global *ph reference, it is
>>> clearly already not working cleanly on a multi-instance setup...
>>>
>>> ...now...I can imagine how to (maybe) fix the above removing the globals and
>>> fixing this, BUT the question, more generally, is CPUFreq supposed to work at all in
>>> this multi-probed mode of operation ?
>>> Does it even make sense to be able to support this in CPUFREQ ?
>>>
>>> (as an example in cpufreq,c there is static global cpufreq_driver
>>>    pointing to the arch-specific configured driver BUT that also holds
>>>    some .driver_data AND that cleraly wont be instance specific if you
>>>    probe multiple times and register with CPUFreq multiple times...)
>>>
>>>    More questions than answers here :D
>>>
>>
>> Thanks Cristian for instant response. Yes, indeed now we have more
>> questions :) (which is good). But that's good description of the
>> situation.
>>
>> So lets consider a few option what we could do now:
>> 1. Let Sibi add another global state the 'handle' but add
>>     a BUG_ON() or WARN_ON() in the probe path if the next
>>     'handle' instance is different than already set in global.
>>     This would simply mean that we don't support (yet)
>>     such configuration in a platform. As you said, we
>>     already have the *ph global, so maybe such platforms
>>     with multiple instances for this particular cpufreq and
>>     performance protocol don't exist yet.
> 
> Yes this is the quickst way (and a WARN_ON() is better I'd say) but there
> are similar issues of "unicity" currently already with another vendor SCMI
> drivers and custom protocol currently under review, so I was thinking to
> add a new common mechanism in SCMI to handle this ... not thought about
> this really in depth and I want to chat with Sudeep about this...
> 
>> 2. Ask Sibi to wait with this change, till we refactor the
>>     exiting driver such that it could support easily those
>>     multiple instances. Then pick up this patch set.
>>     Although, we would also like to have those notifications from our
>>     Juno SCP reference FW, so the feature is useful.
>> 3. Ask Sibi to refactor his patch to somehow get the 'handle'
>>     in different way, using exiting code and not introduce this global.
>>
> 
>> IHMO we could do this in steps: 1. and then 2. When
>> we create some mock platform to test this refactoring we can
>> start cleaning it.
>>
> 
> Both of these options really beg an answer to my original previous q
> question...if we somehow enable this multi-probe support in the
> scmi-cpufreq.c driver by avoiding glbals refs, does this work at all in
> the context of CPUFreq ?

I don't know yet.

> 
> ...or it is just that CPUFreq cannot handle such a configuration (and
> maybe dont want to) and so the only solution here is just 1. at first and
> then a common refined mechanism (as mentioned above) to ensure this "unicity"
> of the probes for some drivers ?

This sounds reasonable.

> 
> I'm not familiar enough to grasp if this "multi-probed" mode of operation is
> allowed/supported by CPUFreq and, more important, if it makes any sense
> at all to be a supported mode...
> 

OK, let me check some stuff in the code and think for a while on that.
Thanks Cristian!

Sibi, please give me a few days. In the meantime you can continue
on the 'boost' patch set probably.

