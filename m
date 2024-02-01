Return-Path: <linux-kernel+bounces-47961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B12C845547
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 11:26:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 683941C255DE
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 10:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10A1615B96B;
	Thu,  1 Feb 2024 10:26:50 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 593524DA06;
	Thu,  1 Feb 2024 10:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706783209; cv=none; b=jT1w2vZuzCuSCU5Nvx3561iob74GK5Q3ID6MBt2j+b6H11HwjwDTwoDU1PCDqIhRw0ccOuEvLOXGAqQ8Lr+tlCQN9QjX2lKYfA5K1ziE2IC3xvJRA4h0d/htZq3Xf/OxgcMXHz36VDT6xdWkRQCUr8HuIcJyung6LhSKQS78o3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706783209; c=relaxed/simple;
	bh=1Yr/AHhB6XmjVqcxBy7N7dT+IhyHnjIGtbEVFp9eSiM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HbEWmAhwOOC9/eTH2O34BDhJFuhdEnAuhYk99tB33HuIUbrTWTyR4U4OtjhOg73rttUMidbkGPN12+CCV2nSFXspHD5tOaRCW0t0Lnyetppoz5PTdqqGIECcqIQ4DA/JT4pq1zws3yRaOE52siY/wZsSKIB8kux6JnpUwWEvEyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 32AC8DA7;
	Thu,  1 Feb 2024 02:27:29 -0800 (PST)
Received: from [10.1.197.1] (ewhatever.cambridge.arm.com [10.1.197.1])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 45A733F738;
	Thu,  1 Feb 2024 02:26:42 -0800 (PST)
Message-ID: <812bd339-4728-40ee-b19e-c8a04cc740de@arm.com>
Date: Thu, 1 Feb 2024 10:26:40 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 05/10] coresight-tpda: Add support to configure CMB
 element
Content-Language: en-US
To: Tao Zhang <quic_taozha@quicinc.com>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Konrad Dybcio <konradybcio@gmail.com>, Mike Leach <mike.leach@linaro.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: Jinlong Mao <quic_jinlmao@quicinc.com>, Leo Yan <leo.yan@linaro.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, coresight@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, Tingwei Zhang <quic_tingweiz@quicinc.com>,
 Yuanfang Zhang <quic_yuanfang@quicinc.com>,
 Trilok Soni <quic_tsoni@quicinc.com>, Song Chai <quic_songchai@quicinc.com>,
 linux-arm-msm@vger.kernel.org, andersson@kernel.org
References: <1706605366-31705-1-git-send-email-quic_taozha@quicinc.com>
 <1706605366-31705-6-git-send-email-quic_taozha@quicinc.com>
 <6ccb98f2-2f68-45db-9941-1c7b05da84d0@arm.com>
 <6fff5991-01ed-44ea-aa08-9f302d2465e8@quicinc.com>
 <1f5a7c7b-56de-4f19-9d48-652ae6efe50f@arm.com>
 <9fca774e-3519-4d0c-ba61-6b84965f36c2@quicinc.com>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <9fca774e-3519-4d0c-ba61-6b84965f36c2@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 01/02/2024 02:25, Tao Zhang wrote:
> 
> On 1/31/2024 6:02 PM, Suzuki K Poulose wrote:
>> On 31/01/2024 01:39, Tao Zhang wrote:
>>>
>>> On 1/30/2024 8:35 PM, Suzuki K Poulose wrote:
>>>> On 30/01/2024 09:02, Tao Zhang wrote:
>>>>> Read the CMB element size from the device tree. Set the register
>>>>> bit that controls the CMB element size of the corresponding port.
>>>>>
>>>>> Reviewed-by: James Clark <james.clark@arm.com>
>>>>> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
>>>>> Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
>>>>> ---
>>>>>   drivers/hwtracing/coresight/coresight-tpda.c | 123 
>>>>> +++++++++++--------
>>>>>   drivers/hwtracing/coresight/coresight-tpda.h |   6 +
>>>>>   2 files changed, 79 insertions(+), 50 deletions(-)
>>>>>
>>>>> diff --git a/drivers/hwtracing/coresight/coresight-tpda.c 
>>>>> b/drivers/hwtracing/coresight/coresight-tpda.c
>>>>> index 4ac954f4bc13..fcddff3ded81 100644
>>>>> --- a/drivers/hwtracing/coresight/coresight-tpda.c
>>>>> +++ b/drivers/hwtracing/coresight/coresight-tpda.c
>>>>> @@ -18,6 +18,7 @@
>>>>>   #include "coresight-priv.h"
>>>>>   #include "coresight-tpda.h"
>>>>>   #include "coresight-trace-id.h"
>>>>> +#include "coresight-tpdm.h"
>>>>>     DEFINE_CORESIGHT_DEVLIST(tpda_devs, "tpda");
>>>>>   @@ -28,24 +29,57 @@ static bool coresight_device_is_tpdm(struct 
>>>>> coresight_device *csdev)
>>>>>               CORESIGHT_DEV_SUBTYPE_SOURCE_TPDM);
>>>>>   }
>>>>>   +static void tpdm_clear_element_size(struct coresight_device *csdev)
>>>>> +{
>>>>> +    struct tpda_drvdata *drvdata = 
>>>>> dev_get_drvdata(csdev->dev.parent);
>>>>> +
>>>>> +    drvdata->dsb_esize = 0;
>>>>> +    drvdata->cmb_esize = 0;
>>>>> +}
>>>>> +
>>>>> +static void tpda_set_element_size(struct tpda_drvdata *drvdata, 
>>>>> u32 *val)
>>>>> +{
>>>>> +
>>>>
>>>>
>>>>
>>>>> +    if (drvdata->dsb_esize == 64)
>>>>> +        *val |= TPDA_Pn_CR_DSBSIZE;
>>>>
>>>> We don't seem to be clearing the fields we modify, before updating 
>>>> them. This may be OK in real world where the device connected to 
>>>> TPDA port
>>>> may not change. But it is always safer to clear the bits and set it.
>>>>
>>>> e.g.:
>>>>     *val &= ~(TPDA_Pn_CR_DSBSIZE | TPDA_Pn_CR_CMBSIZE);
>>>>
>>>>
>>>>
>>>>> +    else if (drvdata->dsb_esize == 32)
>>>>> +        *val &= ~TPDA_Pn_CR_DSBSIZE;
>>>>> +
>>>>> +    if (drvdata->cmb_esize == 64)
>>>>> +        *val |= FIELD_PREP(TPDA_Pn_CR_CMBSIZE, 0x2);
>>>>> +    else if (drvdata->cmb_esize == 32)
>>>>> +        *val |= FIELD_PREP(TPDA_Pn_CR_CMBSIZE, 0x1);
>>>>
>>>> Similarly here ^^^. I am happy to fix it up if you are OK with it 
>>>> (unless there are other changes that need a respin)
>>>
>>> Thank you. I would be very grateful if you could help for this.
>>
>> Given, you need to respin, please incorporate this change too.
> 
> Sure.
> 
> Is it OK if I modify the code as follow and update to this patch directly?
> 
>      *val &= ~(TPDA_Pn_CR_DSBSIZE | TPDA_Pn_CR_CMBSIZE);
> 
>      if (drvdata->dsb_esize == 64)
>          *val |= TPDA_Pn_CR_DSBSIZE;
>      else if (drvdata->dsb_esize == 32)
>          *val &= ~TPDA_Pn_CR_DSBSIZE;
> 
>      if (drvdata->cmb_esize == 64)
>          *val |= FIELD_PREP(TPDA_Pn_CR_CMBSIZE, 0x2);
>      else if (drvdata->cmb_esize == 32)
>          *val |= FIELD_PREP(TPDA_Pn_CR_CMBSIZE, 0x1);.
>      else if (drvdata->cmb_esize == 8)
>          *val &= ~TPDA_Pn_CR_CMBSIZE;

Yes, that looks good to me. Even though you would be clearing the fields 
for (DSB=32 and CMB=8) once again, it is good to leave it like that 
rather than skipping them, making people stare at it to figure out if 
this was correct or not.

Suzuki




> 
> Best,
> 
> Tao
> 
>>
>> Suzuki
>>
>>
>>


