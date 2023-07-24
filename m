Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70EB775F658
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 14:29:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbjGXM3U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 08:29:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231168AbjGXM3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 08:29:10 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA3C710EF;
        Mon, 24 Jul 2023 05:29:02 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36OBqCCd014493;
        Mon, 24 Jul 2023 12:28:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=vvTgGZ5ZzfDIIhvZf5v2ew4Kd6/ODFZ9t3BLKDf7CbQ=;
 b=ibMWh6kDQj6hP+sGkfINta9adeknrGggelc741f7OY6dHBCpAarhUs+SspcoPTcpg9J7
 OxV/FWvGixKDhgA1/g7VMLeZNy8WwI6rFvbWi3RLhErwnmUtQJDobHYRzbxRfnFv4b6j
 yBbLagjnYT3a8prpyLwAtdWb1EeiCnWX2lK9eFMyDuxlKMIGLefIgZ7/SyI3C/PazT1z
 ghGI8vh88/sqUMtRdl20DS41ZxHlmTrKkVWrEk1YHmOI8ZfzPrH/g7/TiCFKuOi2bI4i
 IfmqOJx0mH+N4ADKdfJBUYR11UafeXdGX0HX/NNpnnVmdM7mQps/jRix3bxZs8djUtD/ 3g== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s1rs5g28d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Jul 2023 12:28:57 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36OCSuOK027372
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Jul 2023 12:28:56 GMT
Received: from [10.214.66.81] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Mon, 24 Jul
 2023 05:28:53 -0700
Message-ID: <39b4bafd-410f-cae8-13ae-e18d751b51a2@quicinc.com>
Date:   Mon, 24 Jul 2023 17:58:45 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v5 2/6] soc: qcom: llcc: Refactor llcc driver to support
 multiple configuration
Content-Language: en-US
To:     Komal Bajaj <quic_kbajaj@quicinc.com>, <agross@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <srinivas.kandagatla@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20230724084155.8682-1-quic_kbajaj@quicinc.com>
 <20230724084155.8682-3-quic_kbajaj@quicinc.com>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <20230724084155.8682-3-quic_kbajaj@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: PzR-XKH77tsI6G29TFXPftDhc3M1OU48
X-Proofpoint-ORIG-GUID: PzR-XKH77tsI6G29TFXPftDhc3M1OU48
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-24_09,2023-07-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501
 mlxlogscore=999 mlxscore=0 adultscore=0 clxscore=1015 bulkscore=0
 suspectscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307240110
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/24/2023 2:11 PM, Komal Bajaj wrote:
> Refactor driver to support multiple configuration for llcc on a target.
> 
> Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>
> ---
>   drivers/soc/qcom/llcc-qcom.c | 264 +++++++++++++++++++++++------------
>   1 file changed, 178 insertions(+), 86 deletions(-)
> 
> diff --git a/drivers/soc/qcom/llcc-qcom.c b/drivers/soc/qcom/llcc-qcom.c
> index 67c19ed2219a..321f8d2079f7 100644
> --- a/drivers/soc/qcom/llcc-qcom.c
> +++ b/drivers/soc/qcom/llcc-qcom.c
> @@ -127,6 +127,12 @@ struct qcom_llcc_config {
>   	bool no_edac;
>   };
>   
> +struct qcom_sct_config

const ?
  > +	const struct qcom_llcc_config *llcc_config;
> +	int num_cfgs;
> +};
> +
> +
>   enum llcc_reg_offset {
>   	LLCC_COMMON_HW_INFO,
>   	LLCC_COMMON_STATUS0,
> @@ -423,101 +429,185 @@ static const u32 llcc_v2_1_reg_offset[] = {
>   	[LLCC_COMMON_STATUS0]	= 0x0003400c,
>   };
>   
> -static const struct qcom_llcc_config sc7180_cfg = {
> -	.sct_data	= sc7180_data,
> -	.size		= ARRAY_SIZE(sc7180_data),
> -	.need_llcc_cfg	= true,
> -	.reg_offset	= llcc_v1_reg_offset,
> -	.edac_reg_offset = &llcc_v1_edac_reg_offset,
> +static const struct qcom_llcc_config sc7180_cfg[] = {
> +	{
> +		.sct_data	= sc7180_data,
> +		.size		= ARRAY_SIZE(sc7180_data),
> +		.need_llcc_cfg	= true,
> +		.reg_offset	= llcc_v1_reg_offset,
> +		.edac_reg_offset = &llcc_v1_edac_reg_offset,
> +	},
> +};
> +
> +static const struct qcom_llcc_config sc7280_cfg[] = {
> +	{
> +		.sct_data	= sc7280_data,
> +		.size		= ARRAY_SIZE(sc7280_data),
> +		.need_llcc_cfg	= true,
> +		.reg_offset	= llcc_v1_reg_offset,
> +		.edac_reg_offset = &llcc_v1_edac_reg_offset,
> +	},
> +};
> +
> +static const struct qcom_llcc_config sc8180x_cfg[] = {
> +	{
> +		.sct_data	= sc8180x_data,
> +		.size		= ARRAY_SIZE(sc8180x_data),
> +		.need_llcc_cfg	= true,
> +		.reg_offset	= llcc_v1_reg_offset,
> +		.edac_reg_offset = &llcc_v1_edac_reg_offset,
> +	},
> +};
> +
> +static const struct qcom_llcc_config sc8280xp_cfg[] = {
> +	{
> +		.sct_data	= sc8280xp_data,
> +		.size		= ARRAY_SIZE(sc8280xp_data),
> +		.need_llcc_cfg	= true,
> +		.reg_offset	= llcc_v1_reg_offset,
> +		.edac_reg_offset = &llcc_v1_edac_reg_offset,
> +	},
> +};
> +
> +static const struct qcom_llcc_config sdm845_cfg[] = {
> +	{
> +		.sct_data	= sdm845_data,
> +		.size		= ARRAY_SIZE(sdm845_data),
> +		.need_llcc_cfg	= false,
> +		.reg_offset	= llcc_v1_reg_offset,
> +		.edac_reg_offset = &llcc_v1_edac_reg_offset,
> +		.no_edac	= true,
> +	},
> +};
> +
> +static const struct qcom_llcc_config sm6350_cfg[] = {
> +	{
> +		.sct_data	= sm6350_data,
> +		.size		= ARRAY_SIZE(sm6350_data),
> +		.need_llcc_cfg	= true,
> +		.reg_offset	= llcc_v1_reg_offset,
> +		.edac_reg_offset = &llcc_v1_edac_reg_offset,
> +	},
> +};
> +
> +static const struct qcom_llcc_config sm7150_cfg[] = {
> +	{
> +		.sct_data       = sm7150_data,
> +		.size           = ARRAY_SIZE(sm7150_data),
> +		.need_llcc_cfg	= true,
> +		.reg_offset	= llcc_v1_reg_offset,
> +		.edac_reg_offset = &llcc_v1_edac_reg_offset,
> +	},
> +};
> +
> +static const struct qcom_llcc_config sm8150_cfg[] = {
> +	{
> +		.sct_data       = sm8150_data,
> +		.size           = ARRAY_SIZE(sm8150_data),
> +		.need_llcc_cfg	= true,
> +		.reg_offset	= llcc_v1_reg_offset,
> +		.edac_reg_offset = &llcc_v1_edac_reg_offset,
> +	},
> +};
> +
> +static const struct qcom_llcc_config sm8250_cfg[] = {
> +	{
> +		.sct_data       = sm8250_data,
> +		.size           = ARRAY_SIZE(sm8250_data),
> +		.need_llcc_cfg	= true,
> +		.reg_offset	= llcc_v1_reg_offset,
> +		.edac_reg_offset = &llcc_v1_edac_reg_offset,
> +	},
> +};
> +
> +static const struct qcom_llcc_config sm8350_cfg[] = {
> +	{
> +		.sct_data       = sm8350_data,
> +		.size           = ARRAY_SIZE(sm8350_data),
> +		.need_llcc_cfg	= true,
> +		.reg_offset	= llcc_v1_reg_offset,
> +		.edac_reg_offset = &llcc_v1_edac_reg_offset,
> +	},
> +};
> +
> +static const struct qcom_llcc_config sm8450_cfg[] = {
> +	{
> +		.sct_data       = sm8450_data,
> +		.size           = ARRAY_SIZE(sm8450_data),
> +		.need_llcc_cfg	= true,
> +		.reg_offset	= llcc_v2_1_reg_offset,
> +		.edac_reg_offset = &llcc_v2_1_edac_reg_offset,
> +	},
> +};
> +
> +static const struct qcom_llcc_config sm8550_cfg[] = {
> +	{
> +		.sct_data       = sm8550_data,
> +		.size           = ARRAY_SIZE(sm8550_data),
> +		.need_llcc_cfg	= true,
> +		.reg_offset	= llcc_v2_1_reg_offset,
> +		.edac_reg_offset = &llcc_v2_1_edac_reg_offset,
> +	},
> +};
> +
> +static const struct qcom_sct_config sc7180_cfgs = {
> +	.llcc_config	= sc7180_cfg,
> +	.num_cfgs	= 1,
>   };
>   
> -static const struct qcom_llcc_config sc7280_cfg = {
> -	.sct_data	= sc7280_data,
> -	.size		= ARRAY_SIZE(sc7280_data),
> -	.need_llcc_cfg	= true,
> -	.reg_offset	= llcc_v1_reg_offset,
> -	.edac_reg_offset = &llcc_v1_edac_reg_offset,
> +static const struct qcom_sct_config sc7280_cfgs = {
> +	.llcc_config	= sc7280_cfg,
> +	.num_cfgs	= 1,
>   };
>   
> -static const struct qcom_llcc_config sc8180x_cfg = {
> -	.sct_data	= sc8180x_data,
> -	.size		= ARRAY_SIZE(sc8180x_data),
> -	.need_llcc_cfg	= true,
> -	.reg_offset	= llcc_v1_reg_offset,
> -	.edac_reg_offset = &llcc_v1_edac_reg_offset,
> +static const struct qcom_sct_config sc8180x_cfgs = {
> +	.llcc_config	= sc8180x_cfg,
> +	.num_cfgs	= 1,
>   };
>   
> -static const struct qcom_llcc_config sc8280xp_cfg = {
> -	.sct_data	= sc8280xp_data,
> -	.size		= ARRAY_SIZE(sc8280xp_data),
> -	.need_llcc_cfg	= true,
> -	.reg_offset	= llcc_v1_reg_offset,
> -	.edac_reg_offset = &llcc_v1_edac_reg_offset,
> +static const struct qcom_sct_config sc8280xp_cfgs = {
> +	.llcc_config	= sc8280xp_cfg,
> +	.num_cfgs	= 1,
>   };
>   
> -static const struct qcom_llcc_config sdm845_cfg = {
> -	.sct_data	= sdm845_data,
> -	.size		= ARRAY_SIZE(sdm845_data),
> -	.need_llcc_cfg	= false,
> -	.reg_offset	= llcc_v1_reg_offset,
> -	.edac_reg_offset = &llcc_v1_edac_reg_offset,
> -	.no_edac	= true,
> +static const struct qcom_sct_config sdm845_cfgs = {
> +	.llcc_config	= sdm845_cfg,
> +	.num_cfgs	= 1,
>   };
>   
> -static const struct qcom_llcc_config sm6350_cfg = {
> -	.sct_data	= sm6350_data,
> -	.size		= ARRAY_SIZE(sm6350_data),
> -	.need_llcc_cfg	= true,
> -	.reg_offset	= llcc_v1_reg_offset,
> -	.edac_reg_offset = &llcc_v1_edac_reg_offset,
> +static const struct qcom_sct_config sm6350_cfgs = {
> +	.llcc_config	= sm6350_cfg,
> +	.num_cfgs	= 1,
>   };
>   
> -static const struct qcom_llcc_config sm7150_cfg = {
> -	.sct_data       = sm7150_data,
> -	.size           = ARRAY_SIZE(sm7150_data),
> -	.need_llcc_cfg	= true,
> -	.reg_offset	= llcc_v1_reg_offset,
> -	.edac_reg_offset = &llcc_v1_edac_reg_offset,
> +static const struct qcom_sct_config sm7150_cfgs = {
> +	.llcc_config	= sm7150_cfg,
> +	.num_cfgs	= 1,
>   };
>   
> -static const struct qcom_llcc_config sm8150_cfg = {
> -	.sct_data       = sm8150_data,
> -	.size           = ARRAY_SIZE(sm8150_data),
> -	.need_llcc_cfg	= true,
> -	.reg_offset	= llcc_v1_reg_offset,
> -	.edac_reg_offset = &llcc_v1_edac_reg_offset,
> +static const struct qcom_sct_config sm8150_cfgs = {
> +	.llcc_config	= sm8150_cfg,
> +	.num_cfgs	= 1,
>   };
>   
> -static const struct qcom_llcc_config sm8250_cfg = {
> -	.sct_data       = sm8250_data,
> -	.size           = ARRAY_SIZE(sm8250_data),
> -	.need_llcc_cfg	= true,
> -	.reg_offset	= llcc_v1_reg_offset,
> -	.edac_reg_offset = &llcc_v1_edac_reg_offset,
> +static const struct qcom_sct_config sm8250_cfgs = {
> +	.llcc_config	= sm8250_cfg,
> +	.num_cfgs	= 1,
>   };
>   
> -static const struct qcom_llcc_config sm8350_cfg = {
> -	.sct_data       = sm8350_data,
> -	.size           = ARRAY_SIZE(sm8350_data),
> -	.need_llcc_cfg	= true,
> -	.reg_offset	= llcc_v1_reg_offset,
> -	.edac_reg_offset = &llcc_v1_edac_reg_offset,
> +static const struct qcom_sct_config sm8350_cfgs = {
> +	.llcc_config	= sm8350_cfg,
> +	.num_cfgs	= 1,
>   };
>   
> -static const struct qcom_llcc_config sm8450_cfg = {
> -	.sct_data       = sm8450_data,
> -	.size           = ARRAY_SIZE(sm8450_data),
> -	.need_llcc_cfg	= true,
> -	.reg_offset	= llcc_v2_1_reg_offset,
> -	.edac_reg_offset = &llcc_v2_1_edac_reg_offset,
> +static const struct qcom_sct_config sm8450_cfgs = {
> +	.llcc_config	= sm8450_cfg,
> +	.num_cfgs	= 1,
>   };
>   
> -static const struct qcom_llcc_config sm8550_cfg = {
> -	.sct_data       = sm8550_data,
> -	.size           = ARRAY_SIZE(sm8550_data),
> -	.need_llcc_cfg	= true,
> -	.reg_offset	= llcc_v2_1_reg_offset,
> -	.edac_reg_offset = &llcc_v2_1_edac_reg_offset,
> +static const struct qcom_sct_config sm8550_cfgs = {
> +	.llcc_config	= sm8550_cfg,
> +	.num_cfgs	= 1,

num prefix itself take care of singular/plural, num_config would do
good.


>   };
>   
>   static struct llcc_drv_data *drv_data = (void *) -EPROBE_DEFER;
> @@ -939,6 +1029,7 @@ static int qcom_llcc_probe(struct platform_device *pdev)
>   	struct device *dev = &pdev->dev;
>   	int ret, i;
>   	struct platform_device *llcc_edac;
> +	const struct qcom_sct_config *cfgs;
>   	const struct qcom_llcc_config *cfg;
>   	const struct llcc_slice_config *llcc_cfg;
>   	u32 sz;
> @@ -958,7 +1049,8 @@ static int qcom_llcc_probe(struct platform_device *pdev)
>   		goto err;
>   	}
>   
> -	cfg = of_device_get_match_data(&pdev->dev);
> +	cfgs = of_device_get_match_data(&pdev->dev);
> +	cfg = &cfgs->llcc_config[0];

Hardcoding without check ?

#define DEFAULT_NUM_CFG    1

if (cfgs->num_cfgs != DEFAULT_NUM_CFG)
      ret = -EINVAL;
      goto err;

cfg = &cfgs->llcc_config[DEFAULT_NUM_CFG - 1];

I would let others comment as well..


-Mukesh

>   
>   	ret = regmap_read(regmap, cfg->reg_offset[LLCC_COMMON_STATUS0], &num_banks);
>   	if (ret)
> @@ -1051,18 +1143,18 @@ static int qcom_llcc_probe(struct platform_device *pdev)
>   }
>   
>   static const struct of_device_id qcom_llcc_of_match[] = {
> -	{ .compatible = "qcom,sc7180-llcc", .data = &sc7180_cfg },
> -	{ .compatible = "qcom,sc7280-llcc", .data = &sc7280_cfg },
> -	{ .compatible = "qcom,sc8180x-llcc", .data = &sc8180x_cfg },
> -	{ .compatible = "qcom,sc8280xp-llcc", .data = &sc8280xp_cfg },
> -	{ .compatible = "qcom,sdm845-llcc", .data = &sdm845_cfg },
> -	{ .compatible = "qcom,sm6350-llcc", .data = &sm6350_cfg },
> -	{ .compatible = "qcom,sm7150-llcc", .data = &sm7150_cfg },
> -	{ .compatible = "qcom,sm8150-llcc", .data = &sm8150_cfg },
> -	{ .compatible = "qcom,sm8250-llcc", .data = &sm8250_cfg },
> -	{ .compatible = "qcom,sm8350-llcc", .data = &sm8350_cfg },
> -	{ .compatible = "qcom,sm8450-llcc", .data = &sm8450_cfg },
> -	{ .compatible = "qcom,sm8550-llcc", .data = &sm8550_cfg },
> +	{ .compatible = "qcom,sc7180-llcc", .data = &sc7180_cfgs },
> +	{ .compatible = "qcom,sc7280-llcc", .data = &sc7280_cfgs },
> +	{ .compatible = "qcom,sc8180x-llcc", .data = &sc8180x_cfgs },
> +	{ .compatible = "qcom,sc8280xp-llcc", .data = &sc8280xp_cfgs },
> +	{ .compatible = "qcom,sdm845-llcc", .data = &sdm845_cfgs },
> +	{ .compatible = "qcom,sm6350-llcc", .data = &sm6350_cfgs },
> +	{ .compatible = "qcom,sm7150-llcc", .data = &sm7150_cfgs },
> +	{ .compatible = "qcom,sm8150-llcc", .data = &sm8150_cfgs },
> +	{ .compatible = "qcom,sm8250-llcc", .data = &sm8250_cfgs },
> +	{ .compatible = "qcom,sm8350-llcc", .data = &sm8350_cfgs },
> +	{ .compatible = "qcom,sm8450-llcc", .data = &sm8450_cfgs },
> +	{ .compatible = "qcom,sm8550-llcc", .data = &sm8550_cfgs },
>   	{ }
>   };
>   MODULE_DEVICE_TABLE(of, qcom_llcc_of_match);
