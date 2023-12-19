Return-Path: <linux-kernel+bounces-5294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A49C6818916
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 14:56:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDFA31C23F35
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 13:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C5D31A58F;
	Tue, 19 Dec 2023 13:56:33 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55B121A58B;
	Tue, 19 Dec 2023 13:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C01681FB;
	Tue, 19 Dec 2023 05:57:14 -0800 (PST)
Received: from [10.57.46.64] (unknown [10.57.46.64])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E8CB33F5A1;
	Tue, 19 Dec 2023 05:56:27 -0800 (PST)
Message-ID: <df433a15-2698-4e1f-9d15-db52befb7541@arm.com>
Date: Tue, 19 Dec 2023 13:56:26 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/8] coresight-tpdm: Add CMB dataset support
Content-Language: en-GB
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
References: <1700533494-19276-1-git-send-email-quic_taozha@quicinc.com>
 <1700533494-19276-4-git-send-email-quic_taozha@quicinc.com>
 <f4ed3577-f78b-4b78-b306-8284ccb96043@arm.com>
 <8dcafd9a-ff90-439a-9337-fb957d2fcad1@quicinc.com>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <8dcafd9a-ff90-439a-9337-fb957d2fcad1@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 19/12/2023 09:22, Tao Zhang wrote:
> 
> On 12/18/2023 6:34 PM, Suzuki K Poulose wrote:
>> On 21/11/2023 02:24, Tao Zhang wrote:
>>> CMB (continuous multi-bit) is one of TPDM's dataset type. CMB subunit
>>> can be enabled for data collection by writing 1 to the first bit of
>>> CMB_CR register. This change is to add enable/disable function for
>>> CMB dataset by writing CMB_CR register.
>>>
>>> Reviewed-by: James Clark <james.clark@arm.com>
>>> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
>>> Signed-off-by: Jinlong Mao <quic_jinlmao@quicinc.com>
>>> ---
>>>   drivers/hwtracing/coresight/coresight-tpdm.c | 31 ++++++++++++++++++++
>>>   drivers/hwtracing/coresight/coresight-tpdm.h |  8 +++++
>>>   2 files changed, 39 insertions(+)
>>>
>>> diff --git a/drivers/hwtracing/coresight/coresight-tpdm.c 
>>> b/drivers/hwtracing/coresight/coresight-tpdm.c
>>> index 97654aa4b772..c8bb38822e08 100644
>>> --- a/drivers/hwtracing/coresight/coresight-tpdm.c
>>> +++ b/drivers/hwtracing/coresight/coresight-tpdm.c
>>> @@ -131,6 +131,11 @@ static bool tpdm_has_dsb_dataset(struct 
>>> tpdm_drvdata *drvdata)
>>>       return (drvdata->datasets & TPDM_PIDR0_DS_DSB);
>>>   }
>>>   +static bool tpdm_has_cmb_dataset(struct tpdm_drvdata *drvdata)
>>> +{
>>> +    return (drvdata->datasets & TPDM_PIDR0_DS_CMB);
>>> +}
>>> +
>>>   static umode_t tpdm_dsb_is_visible(struct kobject *kobj,
>>>                      struct attribute *attr, int n)
>>>   {
>>> @@ -267,6 +272,17 @@ static void tpdm_enable_dsb(struct tpdm_drvdata 
>>> *drvdata)
>>>       writel_relaxed(val, drvdata->base + TPDM_DSB_CR);
>>>   }
>>>   +static void tpdm_enable_cmb(struct tpdm_drvdata *drvdata)
>>> +{
>>> +    u32 val;
>>> +
>>> +    val = readl_relaxed(drvdata->base + TPDM_CMB_CR);
>>> +    val |= TPDM_CMB_CR_ENA;
>>> +
>>> +    /* Set the enable bit of CMB control register to 1 */
>>> +    writel_relaxed(val, drvdata->base + TPDM_CMB_CR);
>>> +}
>>> +
>>>   /*
>>>    * TPDM enable operations
>>>    * The TPDM or Monitor serves as data collection component for various
>>> @@ -281,6 +297,8 @@ static void __tpdm_enable(struct tpdm_drvdata 
>>> *drvdata)
>>>         if (tpdm_has_dsb_dataset(drvdata))
>>>           tpdm_enable_dsb(drvdata);
>>> +    if (tpdm_has_cmb_dataset(drvdata))
>>> +        tpdm_enable_cmb(drvdata);
>>
>> Don't we need to add this check in the "property read" section ?
>> Otherwise, we could generate warnings unnecessarily ?
>>
>> i.e, if (tpdm_has_cmb_..())
>>       rc |= fwnode_..read_property(cmb-elem-size...)
>>
>> Similarly for DSB.
> 
> TPDM and TPDA are two independent hardware. If you want to modify them 
> in this way, the
> 

You don't have to, as long as the header files are included ?

Read my response in the other patch, where it applies.

Suzuki

> two independent drivers will be coupled to each other. At the same time, 
> this configuration
> 
> is manually set in the devicetree by the users, and this check cannot 
> avoid manual setting errors.
> 
>   Even if the configuration is wrong, it will not cause the driver to 
> stop working, it will only cause
> 
> the data to be lost from the TPDM.
> 
>>
>>>       CS_LOCK(drvdata->base);
>>>   }
>>> @@ -314,6 +332,17 @@ static void tpdm_disable_dsb(struct tpdm_drvdata 
>>> *drvdata)
>>>       writel_relaxed(val, drvdata->base + TPDM_DSB_CR);
>>>   }
>>>   +static void tpdm_disable_cmb(struct tpdm_drvdata *drvdata)
>>> +{
>>> +    u32 val;
>>> +
>>> +    val = readl_relaxed(drvdata->base + TPDM_CMB_CR);
>>> +    val &= ~TPDM_CMB_CR_ENA;
>>> +
>>> +    /* Set the enable bit of CMB control register to 0 */
>>> +    writel_relaxed(val, drvdata->base + TPDM_CMB_CR);
>>> +}
>>> +
>>>   /* TPDM disable operations */
>>>   static void __tpdm_disable(struct tpdm_drvdata *drvdata)
>>>   {
>>> @@ -321,6 +350,8 @@ static void __tpdm_disable(struct tpdm_drvdata 
>>> *drvdata)
>>>         if (tpdm_has_dsb_dataset(drvdata))
>>>           tpdm_disable_dsb(drvdata);
>>> +    if (tpdm_has_cmb_dataset(drvdata))
>>> +        tpdm_disable_cmb(drvdata);
>>
>> minor nit: Instead of having these :
>>
>>     if (tpdm_has_XY_()
>>         tpdm_{enable/disable}_XY_()
>> I prefer :
>>
>>     tpdm_{enable/disable}_XY_
>>
>> and the helper take care of returning early if the feature is
>> not present.
> Does the following sample modification meet your expectation?
> static void tpdm_disable_dsb(struct tpdm_drvdata *drvdata)
> {
>      u32 val;
> 
>      if (tpdm_has_dsb_dataset(drvdata)) {
>          /* Set the enable bit of DSB control register to 0 */
>          val = readl_relaxed(drvdata->base + TPDM_DSB_CR);
>          val &= ~TPDM_DSB_CR_ENA;
>          writel_relaxed(val, drvdata->base + TPDM_DSB_CR);
>      }
> }
> 
> static void tpdm_disable_cmb(struct tpdm_drvdata *drvdata)
> {
>      u32 val;
> 
>      if (tpdm_has_cmb_dataset(drvdata)) {
>          val = readl_relaxed(drvdata->base + TPDM_CMB_CR);
>          val &= ~TPDM_CMB_CR_ENA;
> 
>          /* Set the enable bit of CMB control register to 0 */
>          writel_relaxed(val, drvdata->base + TPDM_CMB_CR);
>      }
> }
> 
> /* TPDM disable operations */
> static void __tpdm_disable(struct tpdm_drvdata *drvdata)
> {
>      CS_UNLOCK(drvdata->base);
> 
>      tpdm_disable_dsb(drvdata);
>      tpdm_disable_cmb(drvdata);
> 

Yes, thats exactly I was looking for.

>      CS_LOCK(drvdata->base);
> 
> }
> 
> 
> Best,
> 
> Tao
> 
>>
>>
>> Suzuki
>>
>>
>>>         CS_LOCK(drvdata->base);
>>>   }
>>> diff --git a/drivers/hwtracing/coresight/coresight-tpdm.h 
>>> b/drivers/hwtracing/coresight/coresight-tpdm.h
>>> index 4115b2a17b8d..0098c58dfdd6 100644
>>> --- a/drivers/hwtracing/coresight/coresight-tpdm.h
>>> +++ b/drivers/hwtracing/coresight/coresight-tpdm.h
>>> @@ -9,6 +9,12 @@
>>>   /* The max number of the datasets that TPDM supports */
>>>   #define TPDM_DATASETS       7
>>>   +/* CMB Subunit Registers */
>>> +#define TPDM_CMB_CR        (0xA00)
>>> +
>>> +/* Enable bit for CMB subunit */
>>> +#define TPDM_CMB_CR_ENA        BIT(0)
>>> +
>>>   /* DSB Subunit Registers */
>>>   #define TPDM_DSB_CR        (0x780)
>>>   #define TPDM_DSB_TIER        (0x784)
>>> @@ -79,10 +85,12 @@
>>>    *
>>>    * PERIPHIDR0[0] : Fix to 1 if ImplDef subunit present, else 0
>>>    * PERIPHIDR0[1] : Fix to 1 if DSB subunit present, else 0
>>> + * PERIPHIDR0[2] : Fix to 1 if CMB subunit present, else 0
>>>    */
>>>     #define TPDM_PIDR0_DS_IMPDEF    BIT(0)
>>>   #define TPDM_PIDR0_DS_DSB    BIT(1)
>>> +#define TPDM_PIDR0_DS_CMB    BIT(2)
>>>     #define TPDM_DSB_MAX_LINES    256
>>>   /* MAX number of EDCR registers */
>>


