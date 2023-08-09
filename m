Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 630117752E2
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 08:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231164AbjHIG3b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 02:29:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjHIG33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 02:29:29 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EBF110CF;
        Tue,  8 Aug 2023 23:29:28 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3794nIpn010181;
        Wed, 9 Aug 2023 06:29:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=B/SKV0Z5OCOEsQi93EDaBkEICj89eDViKO/RfRJZkG8=;
 b=bm94BPa4XleFRh/m6zUwVf/qyNmXsl2EOsqbf9uaR57UFAuAKJmgx+Z4EE7tt7qOfFvv
 GHT1Ohh0cRyMKrGHW82UU+RnZ9MxnX9YxH9bYHAIzCbU3TCjn42G6LkIppK4jv+FAN5s
 i28Xjw8zBRHGRnmAqLXIvyq0By0B4xprQ4TanhgedFl25SGuReVmXjutAcWtbWsN6x6G
 fhJ5To92f3pdydnIuZ/V43fPw2+DgZDW7Y09/aDwDtannXFe+uy+S87r33cemYpOUD/Z
 nh7MK0fU+qYZO71XqKzJY+pMgp+4ku7OLwy1PqVuD3SVpDXZP/AepE7zaLxkIgPu6IIp bQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sbp17hvpj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Aug 2023 06:29:16 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3796TFiG021844
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 9 Aug 2023 06:29:15 GMT
Received: from [10.239.133.211] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Tue, 8 Aug
 2023 23:29:10 -0700
Message-ID: <0ece2f67-ea07-edd3-8fdd-617508fd03e0@quicinc.com>
Date:   Wed, 9 Aug 2023 14:29:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v7 05/13] coresight-tpdm: Initialize DSB subunit
 configuration
Content-Language: en-US
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Konrad Dybcio <konradybcio@gmail.com>,
        Mike Leach <mike.leach@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     Jinlong Mao <quic_jinlmao@quicinc.com>,
        Leo Yan <leo.yan@linaro.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        <coresight@lists.linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Hao Zhang <quic_hazha@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <andersson@kernel.org>
References: <1690269353-10829-1-git-send-email-quic_taozha@quicinc.com>
 <1690269353-10829-6-git-send-email-quic_taozha@quicinc.com>
 <1e24afa4-7945-351f-2ba2-c5ba4ce925ae@arm.com>
From:   Tao Zhang <quic_taozha@quicinc.com>
In-Reply-To: <1e24afa4-7945-351f-2ba2-c5ba4ce925ae@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: w7FQ_ErMIKArBSeaHBUi-njGZ8ugM086
X-Proofpoint-GUID: w7FQ_ErMIKArBSeaHBUi-njGZ8ugM086
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-09_04,2023-08-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 malwarescore=0 mlxlogscore=999 priorityscore=1501 lowpriorityscore=0
 bulkscore=0 spamscore=0 mlxscore=0 adultscore=0 suspectscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308090057
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/7/2023 5:28 PM, Suzuki K Poulose wrote:
> On 25/07/2023 08:15, Tao Zhang wrote:
>> DSB is used for monitoring “events”. Events are something that
>> occurs at some point in time. It could be a state decode, the
>> act of writing/reading a particular address, a FIFO being empty,
>> etc. This decoding of the event desired is done outside TPDM.
>> DSB subunit need to be configured in enablement and disablement.
>> A struct that specifics associated to dsb dataset is needed. It
>> saves the configuration and parameters of the dsb datasets. This
>> change is to add this struct and initialize the configuration of
>> DSB subunit.
>>
>> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
>> ---
>>   drivers/hwtracing/coresight/coresight-tpdm.c | 55 
>> ++++++++++++++++++++++++++--
>>   drivers/hwtracing/coresight/coresight-tpdm.h | 18 +++++++++
>>   2 files changed, 69 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-tpdm.c 
>> b/drivers/hwtracing/coresight/coresight-tpdm.c
>> index abaff0b..52aa48a6 100644
>> --- a/drivers/hwtracing/coresight/coresight-tpdm.c
>> +++ b/drivers/hwtracing/coresight/coresight-tpdm.c
>> @@ -20,17 +20,46 @@
>>     DEFINE_CORESIGHT_DEVLIST(tpdm_devs, "tpdm");
>>   +static void tpdm_reset_datasets(struct tpdm_drvdata *drvdata)
>> +{
>> +    if (drvdata->datasets & TPDM_PIDR0_DS_DSB) {
>
> Do we need a helper for this, we seem to be doing this more than once ?
>
> tpdm_has_dsb_dataset(drvdata) ?
Sure, I will update this in the next patch series.
>
>> +        memset(drvdata->dsb, 0, sizeof(struct dsb_dataset));
>> +
>> +        drvdata->dsb->trig_ts = true;
>> +        drvdata->dsb->trig_type = false;
>> +    }
>> +}
>> +
>>   static void tpdm_enable_dsb(struct tpdm_drvdata *drvdata)
>>   {
>>       u32 val;
>>   -    /* Set the enable bit of DSB control register to 1 */
>> +    val = readl_relaxed(drvdata->base + TPDM_DSB_TIER);
>> +    /* Set trigger timestamp */
>> +    if (drvdata->dsb->trig_ts)
>> +        val |= TPDM_DSB_TIER_XTRIG_TSENAB;
>> +    else
>> +        val &= ~TPDM_DSB_TIER_XTRIG_TSENAB;
>> +    writel_relaxed(val, drvdata->base + TPDM_DSB_TIER);
>> +
>>       val = readl_relaxed(drvdata->base + TPDM_DSB_CR);
>> +    /* Set trigger type */
>> +    if (drvdata->dsb->trig_type)
>> +        val |= TPDM_DSB_CR_TRIG_TYPE;
>> +    else
>> +        val &= ~TPDM_DSB_CR_TRIG_TYPE;
>> +    /* Set the enable bit of DSB control register to 1 */
>>       val |= TPDM_DSB_CR_ENA;
>>       writel_relaxed(val, drvdata->base + TPDM_DSB_CR);
>>   }
>>   -/* TPDM enable operations */
>> +/* TPDM enable operations
>
> minor nit:
>
> /*
>  * TPDM enable..
I will update this in the next patch series.
>
>> + * The TPDM or Monitor serves as data collection component for various
>> + * dataset types. It covers Basic Counts(BC), Tenure Counts(TC),
>> + * Continuous Multi-Bit(CMB), Multi-lane CMB(MCMB) and Discrete Single
>> + * Bit(DSB). This function will initialize the configuration according
>> + * to the dataset type supported by the TPDM.
>> + */
>>   static void __tpdm_enable(struct tpdm_drvdata *drvdata)
>>   {
>>       CS_UNLOCK(drvdata->base);
>> @@ -110,13 +139,24 @@ static const struct coresight_ops tpdm_cs_ops = {
>>       .source_ops    = &tpdm_source_ops,
>>   };
>>   -static void tpdm_init_default_data(struct tpdm_drvdata *drvdata)
>> +static int tpdm_datasets_setup(struct tpdm_drvdata *drvdata)
>>   {
>>       u32 pidr;
>>         /*  Get the datasets present on the TPDM. */
>>       pidr = readl_relaxed(drvdata->base + CORESIGHT_PERIPHIDR0);
>>       drvdata->datasets |= pidr & GENMASK(TPDM_DATASETS - 1, 0);
>> +
>> +    if (drvdata->datasets & TPDM_PIDR0_DS_DSB) {
>> +        if (!drvdata->dsb) {
>
> This could be :
>
>     if (tpdm_has_dsb_dataset(drvdata) && !drvdata->dsb) {
I will update this in the next patch series.
>> +            drvdata->dsb = devm_kzalloc(drvdata->dev,
>> +                            sizeof(*drvdata->dsb), GFP_KERNEL);
>> +            if (!drvdata->dsb)
>> +                return -ENOMEM;
>
>     }
>
>> +        }
>> +    }
>
> Could we move the reset datasets here ?
>     tpdm_reset_datasets(drvdata);
I will update this in the next patch series.
>
>> +
>> +    return 0;
>>   }
>>     /*
>> @@ -179,6 +219,7 @@ static int tpdm_probe(struct amba_device *adev, 
>> const struct amba_id *id)
>>       struct coresight_platform_data *pdata;
>>       struct tpdm_drvdata *drvdata;
>>       struct coresight_desc desc = { 0 };
>> +    int ret;
>>         pdata = coresight_get_platform_data(dev);
>>       if (IS_ERR(pdata))
>> @@ -198,6 +239,12 @@ static int tpdm_probe(struct amba_device *adev, 
>> const struct amba_id *id)
>>         drvdata->base = base;
>>   +    ret = tpdm_datasets_setup(drvdata);
>> +    if (ret)
>> +        return ret;
>> +
>> +    tpdm_reset_datasets(drvdata);
>
> ^^ We could move this to datasets_setup(), see above.
I will update this in the next patch series.
>
>> +
>>       /* Set up coresight component description */
>>       desc.name = coresight_alloc_device_name(&tpdm_devs, dev);
>>       if (!desc.name)
>> @@ -214,7 +261,7 @@ static int tpdm_probe(struct amba_device *adev, 
>> const struct amba_id *id)
>>           return PTR_ERR(drvdata->csdev);
>>         spin_lock_init(&drvdata->spinlock);
>> -    tpdm_init_default_data(drvdata);
>> +
>>       /* Decrease pm refcount when probe is done.*/
>>       pm_runtime_put(&adev->dev);
>>   diff --git a/drivers/hwtracing/coresight/coresight-tpdm.h 
>> b/drivers/hwtracing/coresight/coresight-tpdm.h
>> index 5438540..92c34cd 100644
>> --- a/drivers/hwtracing/coresight/coresight-tpdm.h
>> +++ b/drivers/hwtracing/coresight/coresight-tpdm.h
>> @@ -11,8 +11,14 @@
>>     /* DSB Subunit Registers */
>>   #define TPDM_DSB_CR        (0x780)
>> +#define TPDM_DSB_TIER        (0x784)
>> +
>>   /* Enable bit for DSB subunit */
>>   #define TPDM_DSB_CR_ENA        BIT(0)
>> +/* Enable bit for DSB subunit trigger type */
>> +#define TPDM_DSB_CR_TRIG_TYPE        BIT(12)
>> +/* Enable bit for DSB subunit trigger timestamp */
>> +#define TPDM_DSB_TIER_XTRIG_TSENAB        BIT(1)
>>     /* TPDM integration test registers */
>>   #define TPDM_ITATBCNTRL        (0xEF0)
>> @@ -41,6 +47,16 @@
>>   #define TPDM_PIDR0_DS_DSB    BIT(1)
>>     /**
>> + * struct dsb_dataset - specifics associated to dsb dataset
>> + * @trig_ts:          Enable/Disable trigger timestamp.
>> + * @trig_type:        Enable/Disable trigger type.
>> + */
>> +struct dsb_dataset {
>> +    bool            trig_ts;
>> +    bool            trig_type;
>> +};
>> +
>> +/**
>>    * struct tpdm_drvdata - specifics associated to an TPDM component
>>    * @base:       memory mapped base address for this component.
>>    * @dev:        The device entity associated to this component.
>> @@ -48,6 +64,7 @@
>>    * @spinlock:   lock for the drvdata value.
>>    * @enable:     enable status of the component.
>>    * @datasets:   The datasets types present of the TPDM.
>> + * @dsb         Specifics associated to an TPDM component.
>
>             TPDM DSB related settings ?

I will update this in the next patch series.


Best,

Tao

>
> Suzuki
>
>
>>    */
>>     struct tpdm_drvdata {
>> @@ -57,6 +74,7 @@ struct tpdm_drvdata {
>>       spinlock_t        spinlock;
>>       bool            enable;
>>       unsigned long        datasets;
>> +    struct dsb_dataset    *dsb;
>>   };
>>     #endif  /* _CORESIGHT_CORESIGHT_TPDM_H */
>
