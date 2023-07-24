Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA60E75FB90
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 18:12:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbjGXQMP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 12:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbjGXQMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 12:12:14 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78F45FB;
        Mon, 24 Jul 2023 09:12:12 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36OCmOq7012072;
        Mon, 24 Jul 2023 16:12:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : from : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=cGN1PWSmxpU82L8ml53+9813uONOyCuEPlZO+RVUYsU=;
 b=HHatbNQeoao9rH/ms1J1cOQVttcHg/dtX0t/H9gnYCyP9GoKmKmRN8NpPvY7U4biPyYa
 HqJDt2KxabZ5hY312frJVOgzWc6k1tcZUTAr0ypeQyNswDTYVMf3i27OwvZxtK+2Tvr2
 7eNTSl3Fo1dkFOkIM2af50Vp1xEBiOB3npHVZufy4+Oyx+5AN7xG9OtLwUMQyAgZjOOG
 mho69ze/bDFI+4fUe4+GAJaYDtKcjGV82hs8Kpmh2dXsb9jSQOGDGv0jr07sCbNBvGcL
 mr4PJ0WrVIAhfMPD5n90E0i9IeOt3gNmzoHULCd1gFkWfr2OSOyEbt1Llsiez+geSTfb JA== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s1qa3rrgx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Jul 2023 16:12:08 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36OGC7RI023348
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Jul 2023 16:12:07 GMT
Received: from [10.216.25.90] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Mon, 24 Jul
 2023 09:12:02 -0700
Message-ID: <431fa748-5b4c-061c-a5b1-331b504e5475@quicinc.com>
Date:   Mon, 24 Jul 2023 21:41:58 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v5 2/6] soc: qcom: llcc: Refactor llcc driver to support
 multiple configuration
Content-Language: en-US
From:   Mukesh Ojha <quic_mojha@quicinc.com>
To:     Komal Bajaj <quic_kbajaj@quicinc.com>, <agross@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <srinivas.kandagatla@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20230724084155.8682-1-quic_kbajaj@quicinc.com>
 <20230724084155.8682-3-quic_kbajaj@quicinc.com>
 <39b4bafd-410f-cae8-13ae-e18d751b51a2@quicinc.com>
In-Reply-To: <39b4bafd-410f-cae8-13ae-e18d751b51a2@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: wxH1cnOTyn4ryInrKgEgT2nvvrMBT_dQ
X-Proofpoint-GUID: wxH1cnOTyn4ryInrKgEgT2nvvrMBT_dQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-24_12,2023-07-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 malwarescore=0 suspectscore=0 clxscore=1015 mlxlogscore=999
 priorityscore=1501 mlxscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307240144
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/24/2023 5:58 PM, Mukesh Ojha wrote:
> 
> 
> On 7/24/2023 2:11 PM, Komal Bajaj wrote:
>> Refactor driver to support multiple configuration for llcc on a target.
>>
>> Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>
>> ---
>>   drivers/soc/qcom/llcc-qcom.c | 264 +++++++++++++++++++++++------------
>>   1 file changed, 178 insertions(+), 86 deletions(-)
>>
>> diff --git a/drivers/soc/qcom/llcc-qcom.c b/drivers/soc/qcom/llcc-qcom.c
>> index 67c19ed2219a..321f8d2079f7 100644
>> --- a/drivers/soc/qcom/llcc-qcom.c
>> +++ b/drivers/soc/qcom/llcc-qcom.c
>> @@ -127,6 +127,12 @@ struct qcom_llcc_config {
>>       bool no_edac;
>>   };
>> +struct qcom_sct_config
> 
> const ?

Please ignore this comment, it looks like, I wrote something and forgot
to remove..


-Mukesh

>   > +    const struct qcom_llcc_config *llcc_config;
>> +    int num_cfgs;
>> +};
>> +
>> +
>>   enum llcc_reg_offset {
>>       LLCC_COMMON_HW_INFO,
>>       LLCC_COMMON_STATUS0,
>> @@ -423,101 +429,185 @@ static const u32 llcc_v2_1_reg_offset[] = {
>>       [LLCC_COMMON_STATUS0]    = 0x0003400c,
>>   };
>> -static const struct qcom_llcc_config sc7180_cfg = {
>> -    .sct_data    = sc7180_data,
>> -    .size        = ARRAY_SIZE(sc7180_data),
>> -    .need_llcc_cfg    = true,
>> -    .reg_offset    = llcc_v1_reg_offset,
>> -    .edac_reg_offset = &llcc_v1_edac_reg_offset,
>> +static const struct qcom_llcc_config sc7180_cfg[] = {
>> +    {
>> +        .sct_data    = sc7180_data,
>> +        .size        = ARRAY_SIZE(sc7180_data),
>> +        .need_llcc_cfg    = true,
>> +        .reg_offset    = llcc_v1_reg_offset,
>> +        .edac_reg_offset = &llcc_v1_edac_reg_offset,
>> +    },
>> +};
>> +
>> +static const struct qcom_llcc_config sc7280_cfg[] = {
>> +    {
>> +        .sct_data    = sc7280_data,
>> +        .size        = ARRAY_SIZE(sc7280_data),
>> +        .need_llcc_cfg    = true,
>> +        .reg_offset    = llcc_v1_reg_offset,
>> +        .edac_reg_offset = &llcc_v1_edac_reg_offset,
>> +    },
>> +};
>> +
>> +static const struct qcom_llcc_config sc8180x_cfg[] = {
>> +    {
>> +        .sct_data    = sc8180x_data,
>> +        .size        = ARRAY_SIZE(sc8180x_data),
>> +        .need_llcc_cfg    = true,
>> +        .reg_offset    = llcc_v1_reg_offset,
>> +        .edac_reg_offset = &llcc_v1_edac_reg_offset,
>> +    },
>> +};
>> +
>> +static const struct qcom_llcc_config sc8280xp_cfg[] = {
>> +    {
>> +        .sct_data    = sc8280xp_data,
>> +        .size        = ARRAY_SIZE(sc8280xp_data),
>> +        .need_llcc_cfg    = true,
>> +        .reg_offset    = llcc_v1_reg_offset,
>> +        .edac_reg_offset = &llcc_v1_edac_reg_offset,
>> +    },
>> +};
>> +
>> +static const struct qcom_llcc_config sdm845_cfg[] = {
>> +    {
>> +        .sct_data    = sdm845_data,
>> +        .size        = ARRAY_SIZE(sdm845_data),
>> +        .need_llcc_cfg    = false,
>> +        .reg_offset    = llcc_v1_reg_offset,
>> +        .edac_reg_offset = &llcc_v1_edac_reg_offset,
>> +        .no_edac    = true,
>> +    },
>> +};
>> +
>> +static const struct qcom_llcc_config sm6350_cfg[] = {
>> +    {
>> +        .sct_data    = sm6350_data,
>> +        .size        = ARRAY_SIZE(sm6350_data),
>> +        .need_llcc_cfg    = true,
>> +        .reg_offset    = llcc_v1_reg_offset,
>> +        .edac_reg_offset = &llcc_v1_edac_reg_offset,
>> +    },
>> +};
>> +
>> +static const struct qcom_llcc_config sm7150_cfg[] = {
>> +    {
>> +        .sct_data       = sm7150_data,
>> +        .size           = ARRAY_SIZE(sm7150_data),
>> +        .need_llcc_cfg    = true,
>> +        .reg_offset    = llcc_v1_reg_offset,
>> +        .edac_reg_offset = &llcc_v1_edac_reg_offset,
>> +    },
>> +};
>> +
>> +static const struct qcom_llcc_config sm8150_cfg[] = {
>> +    {
>> +        .sct_data       = sm8150_data,
>> +        .size           = ARRAY_SIZE(sm8150_data),
>> +        .need_llcc_cfg    = true,
>> +        .reg_offset    = llcc_v1_reg_offset,
>> +        .edac_reg_offset = &llcc_v1_edac_reg_offset,
>> +    },
>> +};
>> +
>> +static const struct qcom_llcc_config sm8250_cfg[] = {
>> +    {
>> +        .sct_data       = sm8250_data,
>> +        .size           = ARRAY_SIZE(sm8250_data),
>> +        .need_llcc_cfg    = true,
>> +        .reg_offset    = llcc_v1_reg_offset,
>> +        .edac_reg_offset = &llcc_v1_edac_reg_offset,
>> +    },
>> +};
>> +
>> +static const struct qcom_llcc_config sm8350_cfg[] = {
>> +    {
>> +        .sct_data       = sm8350_data,
>> +        .size           = ARRAY_SIZE(sm8350_data),
>> +        .need_llcc_cfg    = true,
>> +        .reg_offset    = llcc_v1_reg_offset,
>> +        .edac_reg_offset = &llcc_v1_edac_reg_offset,
>> +    },
>> +};
>> +
>> +static const struct qcom_llcc_config sm8450_cfg[] = {
>> +    {
>> +        .sct_data       = sm8450_data,
>> +        .size           = ARRAY_SIZE(sm8450_data),
>> +        .need_llcc_cfg    = true,
>> +        .reg_offset    = llcc_v2_1_reg_offset,
>> +        .edac_reg_offset = &llcc_v2_1_edac_reg_offset,
>> +    },
>> +};
>> +
>> +static const struct qcom_llcc_config sm8550_cfg[] = {
>> +    {
>> +        .sct_data       = sm8550_data,
>> +        .size           = ARRAY_SIZE(sm8550_data),
>> +        .need_llcc_cfg    = true,
>> +        .reg_offset    = llcc_v2_1_reg_offset,
>> +        .edac_reg_offset = &llcc_v2_1_edac_reg_offset,
>> +    },
>> +};
>> +
>> +static const struct qcom_sct_config sc7180_cfgs = {
>> +    .llcc_config    = sc7180_cfg,
>> +    .num_cfgs    = 1,
>>   };
>> -static const struct qcom_llcc_config sc7280_cfg = {
>> -    .sct_data    = sc7280_data,
>> -    .size        = ARRAY_SIZE(sc7280_data),
>> -    .need_llcc_cfg    = true,
>> -    .reg_offset    = llcc_v1_reg_offset,
>> -    .edac_reg_offset = &llcc_v1_edac_reg_offset,
>> +static const struct qcom_sct_config sc7280_cfgs = {
>> +    .llcc_config    = sc7280_cfg,
>> +    .num_cfgs    = 1,
>>   };
>> -static const struct qcom_llcc_config sc8180x_cfg = {
>> -    .sct_data    = sc8180x_data,
>> -    .size        = ARRAY_SIZE(sc8180x_data),
>> -    .need_llcc_cfg    = true,
>> -    .reg_offset    = llcc_v1_reg_offset,
>> -    .edac_reg_offset = &llcc_v1_edac_reg_offset,
>> +static const struct qcom_sct_config sc8180x_cfgs = {
>> +    .llcc_config    = sc8180x_cfg,
>> +    .num_cfgs    = 1,
>>   };
>> -static const struct qcom_llcc_config sc8280xp_cfg = {
>> -    .sct_data    = sc8280xp_data,
>> -    .size        = ARRAY_SIZE(sc8280xp_data),
>> -    .need_llcc_cfg    = true,
>> -    .reg_offset    = llcc_v1_reg_offset,
>> -    .edac_reg_offset = &llcc_v1_edac_reg_offset,
>> +static const struct qcom_sct_config sc8280xp_cfgs = {
>> +    .llcc_config    = sc8280xp_cfg,
>> +    .num_cfgs    = 1,
>>   };
>> -static const struct qcom_llcc_config sdm845_cfg = {
>> -    .sct_data    = sdm845_data,
>> -    .size        = ARRAY_SIZE(sdm845_data),
>> -    .need_llcc_cfg    = false,
>> -    .reg_offset    = llcc_v1_reg_offset,
>> -    .edac_reg_offset = &llcc_v1_edac_reg_offset,
>> -    .no_edac    = true,
>> +static const struct qcom_sct_config sdm845_cfgs = {
>> +    .llcc_config    = sdm845_cfg,
>> +    .num_cfgs    = 1,
>>   };
>> -static const struct qcom_llcc_config sm6350_cfg = {
>> -    .sct_data    = sm6350_data,
>> -    .size        = ARRAY_SIZE(sm6350_data),
>> -    .need_llcc_cfg    = true,
>> -    .reg_offset    = llcc_v1_reg_offset,
>> -    .edac_reg_offset = &llcc_v1_edac_reg_offset,
>> +static const struct qcom_sct_config sm6350_cfgs = {
>> +    .llcc_config    = sm6350_cfg,
>> +    .num_cfgs    = 1,
>>   };
>> -static const struct qcom_llcc_config sm7150_cfg = {
>> -    .sct_data       = sm7150_data,
>> -    .size           = ARRAY_SIZE(sm7150_data),
>> -    .need_llcc_cfg    = true,
>> -    .reg_offset    = llcc_v1_reg_offset,
>> -    .edac_reg_offset = &llcc_v1_edac_reg_offset,
>> +static const struct qcom_sct_config sm7150_cfgs = {
>> +    .llcc_config    = sm7150_cfg,
>> +    .num_cfgs    = 1,
>>   };
>> -static const struct qcom_llcc_config sm8150_cfg = {
>> -    .sct_data       = sm8150_data,
>> -    .size           = ARRAY_SIZE(sm8150_data),
>> -    .need_llcc_cfg    = true,
>> -    .reg_offset    = llcc_v1_reg_offset,
>> -    .edac_reg_offset = &llcc_v1_edac_reg_offset,
>> +static const struct qcom_sct_config sm8150_cfgs = {
>> +    .llcc_config    = sm8150_cfg,
>> +    .num_cfgs    = 1,
>>   };
>> -static const struct qcom_llcc_config sm8250_cfg = {
>> -    .sct_data       = sm8250_data,
>> -    .size           = ARRAY_SIZE(sm8250_data),
>> -    .need_llcc_cfg    = true,
>> -    .reg_offset    = llcc_v1_reg_offset,
>> -    .edac_reg_offset = &llcc_v1_edac_reg_offset,
>> +static const struct qcom_sct_config sm8250_cfgs = {
>> +    .llcc_config    = sm8250_cfg,
>> +    .num_cfgs    = 1,
>>   };
>> -static const struct qcom_llcc_config sm8350_cfg = {
>> -    .sct_data       = sm8350_data,
>> -    .size           = ARRAY_SIZE(sm8350_data),
>> -    .need_llcc_cfg    = true,
>> -    .reg_offset    = llcc_v1_reg_offset,
>> -    .edac_reg_offset = &llcc_v1_edac_reg_offset,
>> +static const struct qcom_sct_config sm8350_cfgs = {
>> +    .llcc_config    = sm8350_cfg,
>> +    .num_cfgs    = 1,
>>   };
>> -static const struct qcom_llcc_config sm8450_cfg = {
>> -    .sct_data       = sm8450_data,
>> -    .size           = ARRAY_SIZE(sm8450_data),
>> -    .need_llcc_cfg    = true,
>> -    .reg_offset    = llcc_v2_1_reg_offset,
>> -    .edac_reg_offset = &llcc_v2_1_edac_reg_offset,
>> +static const struct qcom_sct_config sm8450_cfgs = {
>> +    .llcc_config    = sm8450_cfg,
>> +    .num_cfgs    = 1,
>>   };
>> -static const struct qcom_llcc_config sm8550_cfg = {
>> -    .sct_data       = sm8550_data,
>> -    .size           = ARRAY_SIZE(sm8550_data),
>> -    .need_llcc_cfg    = true,
>> -    .reg_offset    = llcc_v2_1_reg_offset,
>> -    .edac_reg_offset = &llcc_v2_1_edac_reg_offset,
>> +static const struct qcom_sct_config sm8550_cfgs = {
>> +    .llcc_config    = sm8550_cfg,
>> +    .num_cfgs    = 1,
> 
> num prefix itself take care of singular/plural, num_config would do
> good.
> 
> 
>>   };
>>   static struct llcc_drv_data *drv_data = (void *) -EPROBE_DEFER;
>> @@ -939,6 +1029,7 @@ static int qcom_llcc_probe(struct platform_device 
>> *pdev)
>>       struct device *dev = &pdev->dev;
>>       int ret, i;
>>       struct platform_device *llcc_edac;
>> +    const struct qcom_sct_config *cfgs;
>>       const struct qcom_llcc_config *cfg;
>>       const struct llcc_slice_config *llcc_cfg;
>>       u32 sz;
>> @@ -958,7 +1049,8 @@ static int qcom_llcc_probe(struct platform_device 
>> *pdev)
>>           goto err;
>>       }
>> -    cfg = of_device_get_match_data(&pdev->dev);
>> +    cfgs = of_device_get_match_data(&pdev->dev);
>> +    cfg = &cfgs->llcc_config[0];
> 
> Hardcoding without check ?
> 
> #define DEFAULT_NUM_CFG    1
> 
> if (cfgs->num_cfgs != DEFAULT_NUM_CFG)
>       ret = -EINVAL;
>       goto err;
> 
> cfg = &cfgs->llcc_config[DEFAULT_NUM_CFG - 1];
> 
> I would let others comment as well..
> 
> 
> -Mukesh
> 
>>       ret = regmap_read(regmap, cfg->reg_offset[LLCC_COMMON_STATUS0], 
>> &num_banks);
>>       if (ret)
>> @@ -1051,18 +1143,18 @@ static int qcom_llcc_probe(struct 
>> platform_device *pdev)
>>   }
>>   static const struct of_device_id qcom_llcc_of_match[] = {
>> -    { .compatible = "qcom,sc7180-llcc", .data = &sc7180_cfg },
>> -    { .compatible = "qcom,sc7280-llcc", .data = &sc7280_cfg },
>> -    { .compatible = "qcom,sc8180x-llcc", .data = &sc8180x_cfg },
>> -    { .compatible = "qcom,sc8280xp-llcc", .data = &sc8280xp_cfg },
>> -    { .compatible = "qcom,sdm845-llcc", .data = &sdm845_cfg },
>> -    { .compatible = "qcom,sm6350-llcc", .data = &sm6350_cfg },
>> -    { .compatible = "qcom,sm7150-llcc", .data = &sm7150_cfg },
>> -    { .compatible = "qcom,sm8150-llcc", .data = &sm8150_cfg },
>> -    { .compatible = "qcom,sm8250-llcc", .data = &sm8250_cfg },
>> -    { .compatible = "qcom,sm8350-llcc", .data = &sm8350_cfg },
>> -    { .compatible = "qcom,sm8450-llcc", .data = &sm8450_cfg },
>> -    { .compatible = "qcom,sm8550-llcc", .data = &sm8550_cfg },
>> +    { .compatible = "qcom,sc7180-llcc", .data = &sc7180_cfgs },
>> +    { .compatible = "qcom,sc7280-llcc", .data = &sc7280_cfgs },
>> +    { .compatible = "qcom,sc8180x-llcc", .data = &sc8180x_cfgs },
>> +    { .compatible = "qcom,sc8280xp-llcc", .data = &sc8280xp_cfgs },
>> +    { .compatible = "qcom,sdm845-llcc", .data = &sdm845_cfgs },
>> +    { .compatible = "qcom,sm6350-llcc", .data = &sm6350_cfgs },
>> +    { .compatible = "qcom,sm7150-llcc", .data = &sm7150_cfgs },
>> +    { .compatible = "qcom,sm8150-llcc", .data = &sm8150_cfgs },
>> +    { .compatible = "qcom,sm8250-llcc", .data = &sm8250_cfgs },
>> +    { .compatible = "qcom,sm8350-llcc", .data = &sm8350_cfgs },
>> +    { .compatible = "qcom,sm8450-llcc", .data = &sm8450_cfgs },
>> +    { .compatible = "qcom,sm8550-llcc", .data = &sm8550_cfgs },
>>       { }
>>   };
>>   MODULE_DEVICE_TABLE(of, qcom_llcc_of_match);
