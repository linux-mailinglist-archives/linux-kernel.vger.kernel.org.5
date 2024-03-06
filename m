Return-Path: <linux-kernel+bounces-93301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E3B6B872DB7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 04:55:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C058B20ECB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 03:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F05D214F61;
	Wed,  6 Mar 2024 03:55:04 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24EA718637;
	Wed,  6 Mar 2024 03:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709697304; cv=none; b=qI0wvJYOebmMSw1xy3JCU06YV3Wa4ntW/hL/7s9SMWT5q0JBRA8RuSwAlu7178TauI9YgkXgUFllLQdy3bRjk5rgKnuTQwz7at/XXPUDycXiKfrQEFLGoyox+dtK2fTkUFz28sFb5gE9L4pi1W3bWzjKDLnCKFTrfSb/LAUYfFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709697304; c=relaxed/simple;
	bh=QE+ywB9r3lEEE5CiBzVzKiKPeS/oqgnmiYa/KrTrZR0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nmBdabbNn8z3DSB1c+Tb0+eZhJdLtwyMvyQI/xgRKnH7pBkQwo7vwHkf0OltNNlToFV9uej4Wtl9DfgJAaLjo5GQunLiZ/ydqZxrUlFZ+vz5OLQKzfS/8v4SFYc1UcLxjW9Vqo/No3XUHP4EDaeEPqiF8dNvYnbgor/NKio/55M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EA08E1FB;
	Tue,  5 Mar 2024 19:55:37 -0800 (PST)
Received: from [10.162.41.20] (unknown [10.162.41.20])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 28C793F762;
	Tue,  5 Mar 2024 19:54:56 -0800 (PST)
Message-ID: <4bfe9477-9ea9-4609-96c8-470cd5393d75@arm.com>
Date: Wed, 6 Mar 2024 09:24:53 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 03/11] coresight: tmc: Extract device properties from
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
References: <20240222082142.3663983-1-anshuman.khandual@arm.com>
 <20240222082142.3663983-4-anshuman.khandual@arm.com>
 <921173d2-c996-4a0f-b3a5-b660036fa254@arm.com>
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <921173d2-c996-4a0f-b3a5-b660036fa254@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 3/5/24 20:06, Suzuki K Poulose wrote:
> On 22/02/2024 08:21, Anshuman Khandual wrote:
>> This extracts device properties from AMBA pid based table lookup. But first
>> this modifies tmc_etr_setup_caps() to accept csdev access.
>>
>> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
>> Cc: Mike Leach <mike.leach@linaro.org>
>> Cc: James Clark <james.clark@arm.com>
>> Cc: coresight@lists.linaro.org
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: linux-kernel@vger.kernel.org
>> Reviewed-by: James Clark <james.clark@arm.com>
> 
> minor nit: Since there were significant changes from what James previously reviewed, it is a good idea to drop his Reviewed-by:

Sure, will do.

> 
> Otherwise, the changes look good to me.
> 
> Suzuki
> 
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>> Changes in V5:
>>
>> - Modified tmc_etr_setup_caps() to accept struct csdev_access argument
>> - Reverted back tmc_etr_setup_caps() call site position in tmc_probe()
>> - Dropped custom mask TMC_AMBA_MASK
>>
>>   drivers/hwtracing/coresight/coresight-tmc-core.c | 14 ++++++++++----
>>   1 file changed, 10 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-tmc-core.c b/drivers/hwtracing/coresight/coresight-tmc-core.c
>> index 7ec5365e2b64..43874fa4def0 100644
>> --- a/drivers/hwtracing/coresight/coresight-tmc-core.c
>> +++ b/drivers/hwtracing/coresight/coresight-tmc-core.c
>> @@ -370,16 +370,23 @@ static inline bool tmc_etr_has_non_secure_access(struct tmc_drvdata *drvdata)
>>       return (auth & TMC_AUTH_NSID_MASK) == 0x3;
>>   }
>>   +static const struct amba_id tmc_ids[];
>> +
>>   /* Detect and initialise the capabilities of a TMC ETR */
>> -static int tmc_etr_setup_caps(struct device *parent, u32 devid, void *dev_caps)
>> +static int tmc_etr_setup_caps(struct device *parent, u32 devid,
>> +                  struct csdev_access *access)
>>   {
>>       int rc;
>> -    u32 dma_mask = 0;
>> +    u32 tmc_pid, dma_mask = 0;
>>       struct tmc_drvdata *drvdata = dev_get_drvdata(parent);
>> +    void *dev_caps;
>>         if (!tmc_etr_has_non_secure_access(drvdata))
>>           return -EACCES;
>>   +    tmc_pid = coresight_get_pid(access);
>> +    dev_caps = coresight_get_uci_data_from_amba(tmc_ids, tmc_pid);
>> +
>>       /* Set the unadvertised capabilities */
>>       tmc_etr_init_caps(drvdata, (u32)(unsigned long)dev_caps);
>>   @@ -497,8 +504,7 @@ static int tmc_probe(struct amba_device *adev, const struct amba_id *id)
>>           desc.type = CORESIGHT_DEV_TYPE_SINK;
>>           desc.subtype.sink_subtype = CORESIGHT_DEV_SUBTYPE_SINK_SYSMEM;
>>           desc.ops = &tmc_etr_cs_ops;
>> -        ret = tmc_etr_setup_caps(dev, devid,
>> -                     coresight_get_uci_data(id));
>> +        ret = tmc_etr_setup_caps(dev, devid, &desc.access);
>>           if (ret)
>>               goto out;
>>           idr_init(&drvdata->idr);
> 

