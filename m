Return-Path: <linux-kernel+bounces-62897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E5438527A9
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 04:14:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B023B225B3
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 03:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36ECE8F65;
	Tue, 13 Feb 2024 03:13:51 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A6C7A923;
	Tue, 13 Feb 2024 03:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707794030; cv=none; b=kSITJzlVInch9Rp8MN9WL0InEX0mr9H7VfTcxvk5fx46PypfLvDcG2UlOkEhGZoWFypOJSzqnG+Qbyus8Kxno59skxslFuU5jqd+P0kZM4856eTM66dIKaIz528NAFe9nY2zAu922YH3CMrzPea1Rb8ZTpRTYMjtHO92WDNXzas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707794030; c=relaxed/simple;
	bh=qfdeYX1WSeI67xsYjil953V5Odinn00bOIHp83J4Uys=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eUarYANwm30R9EuGFYZzev+j4V0364a5fM5DujDgSfPBPC2/Pv1Uuhd1saMqb2M01DwMMxMt+OOxr5np9+uYJppMPrNsO7nWIlm9mkFHzO700XOJmKntKTGeVad2RmgWryBv5s2UCR74cSZP3F4jJY4OigDGXrIvvwxrF45M6pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1B30DDA7;
	Mon, 12 Feb 2024 19:14:28 -0800 (PST)
Received: from [10.162.41.8] (a077893.blr.arm.com [10.162.41.8])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 164D33F5A1;
	Mon, 12 Feb 2024 19:13:42 -0800 (PST)
Message-ID: <0c65f3b0-a879-444c-b0a4-4af485e72166@arm.com>
Date: Tue, 13 Feb 2024 08:43:39 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 03/11] coresight: tmc: Extract device properties from
 AMBA pid based table lookup
Content-Language: en-US
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
 linux-arm-kernel@lists.infradead.org
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Sudeep Holla <sudeep.holla@arm.com>, Mike Leach <mike.leach@linaro.org>,
 James Clark <james.clark@arm.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
 linux-stm32@st-md-mailman.stormreply.com
References: <20240123054608.1790189-1-anshuman.khandual@arm.com>
 <20240123054608.1790189-4-anshuman.khandual@arm.com>
 <44597c9a-79bd-40f8-87a7-b53582132583@arm.com>
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <44597c9a-79bd-40f8-87a7-b53582132583@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2/12/24 17:43, Suzuki K Poulose wrote:
> On 23/01/2024 05:46, Anshuman Khandual wrote:
>> This extracts device properties from AMBA pid based table lookup. This also
>> defers tmc_etr_setup_caps() after the coresight device has been initialized
>> so that PID value can be read.
>>
>> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
>> Cc: Mike Leach <mike.leach@linaro.org>
>> Cc: James Clark <james.clark@arm.com>
>> Cc: coresight@lists.linaro.org
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: linux-kernel@vger.kernel.org
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>>   .../hwtracing/coresight/coresight-tmc-core.c  | 19 +++++++++++++------
>>   1 file changed, 13 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-tmc-core.c b/drivers/hwtracing/coresight/coresight-tmc-core.c
>> index 7ec5365e2b64..e71db3099a29 100644
>> --- a/drivers/hwtracing/coresight/coresight-tmc-core.c
>> +++ b/drivers/hwtracing/coresight/coresight-tmc-core.c
>> @@ -370,16 +370,24 @@ static inline bool tmc_etr_has_non_secure_access(struct tmc_drvdata *drvdata)
>>       return (auth & TMC_AUTH_NSID_MASK) == 0x3;
>>   }
>>   +#define TMC_AMBA_MASK 0xfffff
>> +
>> +static const struct amba_id tmc_ids[];
>> +
>>   /* Detect and initialise the capabilities of a TMC ETR */
>> -static int tmc_etr_setup_caps(struct device *parent, u32 devid, void *dev_caps)
>> +static int tmc_etr_setup_caps(struct device *parent, u32 devid)
>>   {
>>       int rc;
>> -    u32 dma_mask = 0;
>> +    u32 tmc_pid, dma_mask = 0;
>>       struct tmc_drvdata *drvdata = dev_get_drvdata(parent);
>> +    void *dev_caps;
>>         if (!tmc_etr_has_non_secure_access(drvdata))
>>           return -EACCES;
>>   +    tmc_pid = coresight_get_pid(&drvdata->csdev->access) & TMC_AMBA_MASK;
>> +    dev_caps = coresight_get_uci_data_from_amba(tmc_ids, tmc_pid);
>> +
>>       /* Set the unadvertised capabilities */
>>       tmc_etr_init_caps(drvdata, (u32)(unsigned long)dev_caps);
>>   @@ -497,10 +505,6 @@ static int tmc_probe(struct amba_device *adev, const struct amba_id *id)
>>           desc.type = CORESIGHT_DEV_TYPE_SINK;
>>           desc.subtype.sink_subtype = CORESIGHT_DEV_SUBTYPE_SINK_SYSMEM;
>>           desc.ops = &tmc_etr_cs_ops;
>> -        ret = tmc_etr_setup_caps(dev, devid,
>> -                     coresight_get_uci_data(id));
>> -        if (ret)
>> -            goto out;
>>           idr_init(&drvdata->idr);
>>           mutex_init(&drvdata->idr_mutex);
>>           dev_list = &etr_devs;
>> @@ -539,6 +543,9 @@ static int tmc_probe(struct amba_device *adev, const struct amba_id *id)
>>           goto out;
>>       }
>>   +    if (drvdata->config_type == TMC_CONFIG_TYPE_ETR)
>> +        ret = tmc_etr_setup_caps(dev, devid);
>> +
> 
> With this change, we silently accept an ETR that may only have "SECURE" access only and crash later while we try to enable tracing. You could
> pass in the "access" (which is already in 'desc.access' in the original
> call site and deal with it ?

Just wondering, if something like the following will help ? A failed tmc_etr_setup_caps()
because of failed tmc_etr_has_non_secure_access(), will unregister the coresight device
before returning.

--- a/drivers/hwtracing/coresight/coresight-tmc-core.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-core.c
@@ -538,8 +538,13 @@ static int __tmc_probe(struct device *dev, struct resource *res)
                goto out;
        }
 
-       if (drvdata->config_type == TMC_CONFIG_TYPE_ETR)
+       if (drvdata->config_type == TMC_CONFIG_TYPE_ETR) {
                ret = tmc_etr_setup_caps(dev, devid);
+               if (ret) {
+                       coresight_unregister(drvdata->csdev);
+                       goto out;
+               }
+       }
 
        drvdata->miscdev.name = desc.name;
        drvdata->miscdev.minor = MISC_DYNAMIC_MINOR;

