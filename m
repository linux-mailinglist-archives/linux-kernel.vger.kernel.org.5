Return-Path: <linux-kernel+bounces-75942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A016E85F0F9
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 06:34:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4158CB23E96
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 05:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E1ACDF41;
	Thu, 22 Feb 2024 05:33:54 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 902531426A;
	Thu, 22 Feb 2024 05:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708580034; cv=none; b=RZyOXd2RHk8N1eTYtNKewUDS2zeDEoB6oOcF4Gk43E9uu5Vd6p2vnpAQQPqNoUrRIj6WR1mbB72+QYOLt5SuFRFjxk4PoGXIJQXQ0oYVv11sG+mhVAYRydx7y1Ehv/u4N3dJgV2xE5Jzz2bMHki2AxDom0zdsPqyL/KUAkxbOO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708580034; c=relaxed/simple;
	bh=MM1sRk4nx6qNEmdH3x8O44biAvjLA0F06rhd1AE65cE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l2ZVJc8xPtFU54BBP57bbawMW7jrgmLy8CRqR+g+ifnv0hPkRi+7ihxxwz4oUsRFWd0M0JsCJyy/6SfEqBQB/BEyoo8o1MW2JK34lTDk6xWog/caJcgSkt4Ij1ReeZNc1p2RQFptRjjD+RUL0u0XPAQzu63cFryqsYr0bqgQXmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B28B21007;
	Wed, 21 Feb 2024 21:34:27 -0800 (PST)
Received: from [10.162.42.8] (a077893.blr.arm.com [10.162.42.8])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E180F3F766;
	Wed, 21 Feb 2024 21:33:45 -0800 (PST)
Message-ID: <af8c690f-226b-4397-ad38-9f12f3c1bd15@arm.com>
Date: Thu, 22 Feb 2024 11:03:42 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 02/11] coresight: stm: Extract device name from AMBA
 pid based table lookup
Content-Language: en-US
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
 linux-arm-kernel@lists.infradead.org
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Sudeep Holla <sudeep.holla@arm.com>, Mike Leach <mike.leach@linaro.org>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
 linux-stm32@st-md-mailman.stormreply.com
References: <20240123054608.1790189-1-anshuman.khandual@arm.com>
 <20240123054608.1790189-3-anshuman.khandual@arm.com>
 <56d56f85-6172-4fb1-a002-fe82ffc8a66a@arm.com>
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <56d56f85-6172-4fb1-a002-fe82ffc8a66a@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2/15/24 16:25, Suzuki K Poulose wrote:
> On 23/01/2024 05:45, Anshuman Khandual wrote:
>> Instead of using AMBA private data field, extract the device name from AMBA
>> pid based table lookup using new coresight_get_uci_data_from_amba() helper.
>>
>> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
>> Cc: Mike Leach <mike.leach@linaro.org>
>> Cc: James Clark <james.clark@arm.com>
>> Cc: coresight@lists.linaro.org
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: linux-kernel@vger.kernel.org
>> Cc: linux-stm32@st-md-mailman.stormreply.com
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>>   drivers/hwtracing/coresight/coresight-priv.h | 10 ++++++++++
>>   drivers/hwtracing/coresight/coresight-stm.c  | 14 +++++++++++++-
>>   2 files changed, 23 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-priv.h b/drivers/hwtracing/coresight/coresight-priv.h
>> index 767076e07970..68cbb036cec8 100644
>> --- a/drivers/hwtracing/coresight/coresight-priv.h
>> +++ b/drivers/hwtracing/coresight/coresight-priv.h
>> @@ -221,6 +221,16 @@ static inline void *coresight_get_uci_data(const struct amba_id *id)
>>       return uci_id->data;
>>   }
>>   +static inline void *coresight_get_uci_data_from_amba(const struct amba_id *table, u32 pid)
>> +{
>> +    while (table->mask) {
>> +        if ((table->id & table->mask) == pid)
> 
> Why are we masking table->id ? table->id is a static value that the
> driver wants to check for "variants" of a given device. The table->mask
> is there to filter out the "irrelevant" bits of the PID that we read
> from the device. So this should instead be:
> 
>         if ((table->mask & pid) == table->id)

Sure, will this change as suggested.

> 
>> +            return coresight_get_uci_data(table);
>> +        table++;
>> +    };
>> +    return NULL;
>> +}
>> +
>>   void coresight_release_platform_data(struct coresight_device *csdev,
>>                        struct device *dev,
>>                        struct coresight_platform_data *pdata);
>> diff --git a/drivers/hwtracing/coresight/coresight-stm.c b/drivers/hwtracing/coresight/coresight-stm.c
>> index a1c27c901ad1..9cdca4f86cab 100644
>> --- a/drivers/hwtracing/coresight/coresight-stm.c
>> +++ b/drivers/hwtracing/coresight/coresight-stm.c
>> @@ -804,6 +804,18 @@ static void stm_init_generic_data(struct stm_drvdata *drvdata,
>>       drvdata->stm.set_options = stm_generic_set_options;
>>   }
>>   +#define STM_AMBA_MASK 0xfffff
>> +
>> +static const struct amba_id stm_ids[];
>> +
>> +static char *stm_csdev_name(struct coresight_device *csdev)
>> +{
>> +    u32 stm_pid = coresight_get_pid(&csdev->access) & STM_AMBA_MASK;
> 
> Similar to above:
> 
> Why do we apply a "custom" mask to the PID and later check the PID with
> that of the table->pid.
> 
> The way it is supposed work is :
> 
>     (table->mask & dev_pid) == table->pid
> 
> the table->mask is there for a reason: i.e., to get the relevant bits from the device_pid and compare it against "the" expected value (table->pid).

Understood, will change the helper as follows

static inline void *coresight_get_uci_data_from_amba(const struct amba_id *table, u32 pid)
{
        while (table->mask) {
                if ((pid & table->mask) == table->id)
                        return coresight_get_uci_data(table);
                table++;
        };
        return NULL;
}

and also drop both the custom masks STM_AMBA_MASK and TMC_AMBA_MASK.

