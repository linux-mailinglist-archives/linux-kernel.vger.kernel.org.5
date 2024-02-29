Return-Path: <linux-kernel+bounces-86494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEBBF86C63A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 10:59:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 992B228438B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 09:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1C7B629E7;
	Thu, 29 Feb 2024 09:59:27 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEA3C4778B;
	Thu, 29 Feb 2024 09:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709200767; cv=none; b=t7eaQsQwOJdMFUvC1ij+FyLDKvLbvvEGmkAmt6Pdz0XA3Y1Sc/DPjvG1HHwZfN0tIM4rV5OJTmtd0uTFU8s5zgbfyh3AkPJIIqn44TLIAiL2Lptn8yaDflS7EfeAhH/31Ih2oSIRrvcKmZyty83o3nn4lgD8lZButus236wVMCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709200767; c=relaxed/simple;
	bh=LomPs8yZabTBRuijVP1x/mNDGcz7vRh2TwpwQn7qTaE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SalbO/JLdOAzHU+JIKN36oxhYOyoNfHYf7ZOesAtM8eytNoJ+WgUFIu0E/MYqrpXGxun6u+2A7uyMIBTjjfENTvivltZGGvkMa/8fNsiH501KS8q/dixT0XCz4b9UE7PIUWysvCjHwFCcAWOyTcc9ZMInamBFWW1hB0E7mPkg4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 578EA1FB;
	Thu, 29 Feb 2024 02:00:02 -0800 (PST)
Received: from [10.57.12.184] (unknown [10.57.12.184])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3B1633F762;
	Thu, 29 Feb 2024 01:59:21 -0800 (PST)
Message-ID: <64c6a1bc-92f2-4f44-ab10-cbd2473746f3@arm.com>
Date: Thu, 29 Feb 2024 09:59:38 +0000
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
To: Sibi Sankar <quic_sibis@quicinc.com>
Cc: linux-arm-kernel@lists.infradead.org, pierre.gondois@arm.com,
 dietmar.eggemann@arm.com, morten.rasmussen@arm.com, viresh.kumar@linaro.org,
 rafael@kernel.org, cristian.marussi@arm.com, sudeep.holla@arm.com,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 quic_mdtipton@quicinc.com, linux-arm-msm@vger.kernel.org
References: <20240227181632.659133-1-quic_sibis@quicinc.com>
 <20240227181632.659133-3-quic_sibis@quicinc.com>
 <f8bfc666-c216-44d5-a63b-99f04ff3b8ef@arm.com>
 <2608b2d8-f3b0-b4f5-f8e4-1f2242043ded@quicinc.com>
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <2608b2d8-f3b0-b4f5-f8e4-1f2242043ded@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2/28/24 17:00, Sibi Sankar wrote:
> 
> 
> On 2/28/24 18:54, Lukasz Luba wrote:
>>
>>
>> On 2/27/24 18:16, Sibi Sankar wrote:
>>> Register for limit change notifications if supported and use the 
>>> throttled
>>> frequency from the notification to apply HW pressure.
> 
> Lukasz,
> 
> Thanks for taking time to review the series!
> 
>>>
>>> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
>>> ---
>>>
>>> v3:
>>> * Sanitize range_max received from the notifier. [Pierre]
>>> * Update commit message.
>>>
>>>   drivers/cpufreq/scmi-cpufreq.c | 29 ++++++++++++++++++++++++++++-
>>>   1 file changed, 28 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/cpufreq/scmi-cpufreq.c 
>>> b/drivers/cpufreq/scmi-cpufreq.c
>>> index 76a0ddbd9d24..78b87b72962d 100644
>>> --- a/drivers/cpufreq/scmi-cpufreq.c
>>> +++ b/drivers/cpufreq/scmi-cpufreq.c
>>> @@ -25,9 +25,13 @@ struct scmi_data {
>>>       int domain_id;
>>>       int nr_opp;
>>>       struct device *cpu_dev;
>>> +    struct cpufreq_policy *policy;
>>>       cpumask_var_t opp_shared_cpus;
>>> +    struct notifier_block limit_notify_nb;
>>>   };
>>> +const struct scmi_handle *handle;

I've missed this bit here.

>>> +static struct scmi_device *scmi_dev;
>>>   static struct scmi_protocol_handle *ph;
>>>   static const struct scmi_perf_proto_ops *perf_ops;
>>>   static struct cpufreq_driver scmi_cpufreq_driver;
>>> @@ -151,6 +155,20 @@ static struct freq_attr *scmi_cpufreq_hw_attr[] = {
>>>       NULL,
>>>   };
>>> +static int scmi_limit_notify_cb(struct notifier_block *nb, unsigned 
>>> long event, void *data)
>>> +{
>>> +    struct scmi_data *priv = container_of(nb, struct scmi_data, 
>>> limit_notify_nb);
>>> +    struct scmi_perf_limits_report *limit_notify = data;
>>> +    struct cpufreq_policy *policy = priv->policy;
>>> +
>>> +    policy->max = clamp(limit_notify->range_max_freq/HZ_PER_KHZ, 
>>> policy->cpuinfo.min_freq,
>>> +                policy->cpuinfo.max_freq);
>>
>> Please take the division operation out of this clamp() call, somewhere
>> above. Currently it 'blurs' these stuff, while it's important convertion
>> to khz. You can call it e.g.:
>>
>> limit_freq_khz = limit_notify->range_max_freq / HZ_PER_KHZ;
>>
>> then use in clamp(limit_freq_khz, ...)
> 
> ack
> 
>>
>>> +
>>> +    cpufreq_update_pressure(policy);
>>> +
>>> +    return NOTIFY_OK;
>>> +}
>>> +
>>>   static int scmi_cpufreq_init(struct cpufreq_policy *policy)
>>>   {
>>>       int ret, nr_opp, domain;
>>> @@ -269,6 +287,15 @@ static int scmi_cpufreq_init(struct 
>>> cpufreq_policy *policy)
>>>           }
>>>       }
>>> +    priv->limit_notify_nb.notifier_call = scmi_limit_notify_cb;
>>> +    ret = handle->notify_ops->devm_event_notifier_register(scmi_dev, 
>>> SCMI_PROTOCOL_PERF,
>>> +                            SCMI_EVENT_PERFORMANCE_LIMITS_CHANGED,
>>> +                            &domain,
>>> +                            &priv->limit_notify_nb);
>>> +    if (ret)
>>> +        dev_warn(cpu_dev,
>>> +             "failed to register for limits change notifier for 
>>> domain %d\n", domain);
>>> +
>>>       priv->policy = policy;
>>>       return 0;
>>> @@ -342,8 +369,8 @@ static int scmi_cpufreq_probe(struct scmi_device 
>>> *sdev)
>>>   {
>>>       int ret;
>>>       struct device *dev = &sdev->dev;
>>> -    const struct scmi_handle *handle;
>>
>> It should be a compilation error...
>>
>>> +    scmi_dev = sdev;
>>>       handle = sdev->handle;
>>
>> due to usage here, wasn't it?
> 
> Not really, isn't it getting the first initialization here?
> Are there any compiler options that I need to turn on to
> catch these?

Yes, you're right, my apologies for confusion.
I couldn't apply the series due issues in two patch sets
in your dependency list.

Now when I have been manually applying the changes I spotted it.

