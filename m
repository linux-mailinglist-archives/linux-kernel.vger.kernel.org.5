Return-Path: <linux-kernel+bounces-15452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1B99822C32
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 12:34:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B6BB2824CC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 11:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFE6A18EB6;
	Wed,  3 Jan 2024 11:33:57 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13D2418E1A;
	Wed,  3 Jan 2024 11:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0BE85C15;
	Wed,  3 Jan 2024 03:34:40 -0800 (PST)
Received: from [10.57.45.90] (unknown [10.57.45.90])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6156E3F7A6;
	Wed,  3 Jan 2024 03:33:52 -0800 (PST)
Message-ID: <b2b6cccb-ede0-4f19-bfaf-efdc203de7f2@arm.com>
Date: Wed, 3 Jan 2024 11:33:51 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] coresight: Add coresight name support
Content-Language: en-GB
To: James Clark <james.clark@arm.com>, Mao Jinlong
 <quic_jinlmao@quicinc.com>, Mike Leach <mike.leach@linaro.org>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 Tingwei Zhang <quic_tingweiz@quicinc.com>,
 Yuanfang Zhang <quic_yuanfang@quicinc.com>,
 Tao Zhang <quic_taozha@quicinc.com>, Leo Yan <leo.yan@linaro.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20231228093321.5522-1-quic_jinlmao@quicinc.com>
 <12ce6e5d-6e4d-fb99-eb82-dece97423bfb@arm.com>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <12ce6e5d-6e4d-fb99-eb82-dece97423bfb@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28/12/2023 11:26, James Clark wrote:
> 
> 
> On 28/12/2023 09:33, Mao Jinlong wrote:
>> Add coresight name support for custom names which will be
>> easy to identify the device by the name.
>>
> 
> I suppose this is more of a V2 because the subject is the same as the
> one sent earlier this year. But it looks like the discussion on the
> previous one wasn't resolved.
> 
> With the main issues to solve being:
> 
>   * It would be nice to use the existing root node name instead of adding
>     a new property. But at the same time DT nodes are supposed to have
>     generic names.
> 
>   * This only works for DT and not ACPI
> 
> To me it seems like adding the new property is just a "cheat" to get
> around not being allowed to have a specific name for the root node. But
> if we admit that we need a name I don't see the benefit of not putting
> the name where the node is already named.
> 
> Using the root node name at this point would also undo the hard coded
> per-cpu naming of the CTI and ETM devices, so maybe it would be nice,
> but it's just too late. That means that a new field is necessary.

The CTI and ETM can be handled as special cases, like they are
already done and fall back to the nodename for the rest ?
But, I thought the node names must be generic (e.g, cti) and doesn't
really solve the naming requirements for naming CTIs. (e.g,
<device>_tpda, etr_cti). Is there something I missed ?

> Although that field could be a boolean like "use-root-name-for-display"
> or something like that. In the end it probably doesn't really make a
> difference whether it's that or a name string. >
> And maybe the answer to the ACPI question is just that if anyone needs
> it, they can add it in the future. It doesn't seem like it would
> conflict with anything we do here.
> 
>> Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
>> ---
>>   .../hwtracing/coresight/coresight-cti-core.c  | 20 ++++++++------
>>   drivers/hwtracing/coresight/coresight-dummy.c | 10 ++++---
>>   .../hwtracing/coresight/coresight-platform.c  | 27 +++++++++++++++++++
>>   drivers/hwtracing/coresight/coresight-tpdm.c  | 10 ++++---
>>   include/linux/coresight.h                     |  1 +
>>   5 files changed, 53 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-cti-core.c b/drivers/hwtracing/coresight/coresight-cti-core.c
>> index 3999d0a2cb60..60a1e76064a9 100644
>> --- a/drivers/hwtracing/coresight/coresight-cti-core.c
>> +++ b/drivers/hwtracing/coresight/coresight-cti-core.c
>> @@ -902,14 +902,18 @@ static int cti_probe(struct amba_device *adev, const struct amba_id *id)
>>   	/* default to powered - could change on PM notifications */
>>   	drvdata->config.hw_powered = true;
>>   
>> -	/* set up device name - will depend if cpu bound or otherwise */
>> -	if (drvdata->ctidev.cpu >= 0)
>> -		cti_desc.name = devm_kasprintf(dev, GFP_KERNEL, "cti_cpu%d",
>> -					       drvdata->ctidev.cpu);
>> -	else
>> -		cti_desc.name = coresight_alloc_device_name(&cti_sys_devs, dev);
> 
> Can we put the new name stuff inside coresight_alloc_device_name()? Then
> it happens by default for every device.

+1

> 
> I know Suzuki said previously to do it per-device, but the new DT
> property is just "coresight-name", so it's generic. Rather than being
> specific like "cti-name". So I don't see the benefit of duplicating the
> code at this point if we do decide to do it.

My suggestion was to name the device based on the specific device rather
than following a generic rule for all device. e.g., A TPDM connected to 
modem, could be named as such based on the platform information. It
could be any means, for e.g., tpdm nodes are always children nodes of
the devices they are connected to ? or could have a phandle to point to 
the device they are monitoring etc. And the name could be created from
the "monitoring device name" + tpdm. Also, we do this for CPU bound CTI
and ETMs already, where we name them based on the CPU.

But then the "nodename" is something we explored and it looks like
may not be an option.

> 
>> -	if (!cti_desc.name)
>> -		return -ENOMEM;
>> +	cti_desc.name = coresight_get_device_name(dev);
>> +	if (!cti_desc.name) {
>> +		/* set up device name - will depend if cpu bound or otherwise */
>> +		if (drvdata->ctidev.cpu >= 0)
>> +			cti_desc.name = devm_kasprintf(dev, GFP_KERNEL, "cti_cpu%d",
>> +						       drvdata->ctidev.cpu);
>> +		else {
>> +			cti_desc.name = coresight_alloc_device_name(&cti_sys_devs, dev);
>> +			if (!cti_desc.name)
>> +				return -ENOMEM;
>> +		}
>> +	}

For these special cases, i.e., CPU bound, we should handle them with 
priority.

if (drvdata->ctidev.cpu >= 0)
	name = devm_kasprintf(... "cti_cpu%d", .. cpu);
else
         name = coresight_alloc_device_name(...);

> 
>>   
>>   	/* setup CPU power management handling for CPU bound CTI devices. */
>>   	ret = cti_pm_setup(drvdata);
>> diff --git a/drivers/hwtracing/coresight/coresight-dummy.c b/drivers/hwtracing/coresight/coresight-dummy.c
>> index e4deafae7bc2..b19cd400df79 100644
>> --- a/drivers/hwtracing/coresight/coresight-dummy.c
>> +++ b/drivers/hwtracing/coresight/coresight-dummy.c
>> @@ -76,10 +76,12 @@ static int dummy_probe(struct platform_device *pdev)
>>   	struct coresight_desc desc = { 0 };
>>   
>>   	if (of_device_is_compatible(node, "arm,coresight-dummy-source")) {
>> -
>> -		desc.name = coresight_alloc_device_name(&source_devs, dev);
>> -		if (!desc.name)
>> -			return -ENOMEM;
>> +		desc.name = coresight_get_device_name(dev);
>> +		if (!desc.name) {
>> +			desc.name = coresight_alloc_device_name(&source_devs, dev);
>> +			if (!desc.name)
>> +				return -ENOMEM;
>> +		}
>>   
>>   		desc.type = CORESIGHT_DEV_TYPE_SOURCE;
>>   		desc.subtype.source_subtype =
>> diff --git a/drivers/hwtracing/coresight/coresight-platform.c b/drivers/hwtracing/coresight/coresight-platform.c
>> index 9d550f5697fa..284aa22a06b7 100644
>> --- a/drivers/hwtracing/coresight/coresight-platform.c
>> +++ b/drivers/hwtracing/coresight/coresight-platform.c
>> @@ -183,6 +183,18 @@ static int of_coresight_get_cpu(struct device *dev)
>>   	return cpu;
>>   }
>>   
>> +static const char *of_coresight_get_device_name(struct device *dev)
>> +{
>> +	const char *name = NULL;
>> +
>> +	if (!dev->of_node)
>> +		return NULL;
>> +
>> +	of_property_read_string(dev->of_node, "coresight-name", &name);
> 
> Do you need to update the binding docs with this new property?
> 
> Also a minor nit: Maybe "display-name" is better? "Coresight" is
> implied, and the node is already named, although that node name isn't
> used for display purposes, but this one is.

On that front, the name is used as a "device" name and not simply 
display. So, even "device-name" sounds more appropriate.

Suzuki

> 
> Thanks
> James


