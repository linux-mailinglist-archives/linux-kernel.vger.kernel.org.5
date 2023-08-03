Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FBB676E961
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 15:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231874AbjHCNF4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 09:05:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235928AbjHCNFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 09:05:10 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4383C4699;
        Thu,  3 Aug 2023 06:04:17 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 373BxiEJ032717;
        Thu, 3 Aug 2023 13:04:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=RRrQnAhR6FNsP9SJQwuRieWP4imWqEQ5laUlOmcsK4k=;
 b=h6ASH6NCfmHWCmZeJ8hv4FAs8u2YGU8WlnvtuF5ddh003tKN+G+sWUsrgVzgeZL1U4Ns
 7Fnt6vudoCDngXeckJNrMSsF5vaY3FzlLc5xPY83aAPM4/MegvnyTjzSNEVNPScCZg5p
 2hrPo2sLAKZPIxY/1erOKuAKsffOQrh2ugiwwUtypSI3e6lRg8Cw27FHjeKIf7CISQkU
 E9wRtcwfavUMuo3oq6ANZFFV/E7ndMtZvV7lH/e3Hc+VJhYISSzJCpyBqR083Q7+BsmL
 pu45VHuIShDYW4kyj5EOp9rWtU01619cYJByiyTr1qs29LfMg7kQdHc0FVZVvuvTQGvj mg== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s85fxruqw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Aug 2023 13:04:09 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 373D3w9H011073
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 3 Aug 2023 13:03:58 GMT
Received: from [10.216.37.36] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Thu, 3 Aug
 2023 06:03:54 -0700
Message-ID: <7cd69645-8f65-172b-88ac-2e8bfe80837d@quicinc.com>
Date:   Thu, 3 Aug 2023 18:33:36 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v6 2/6] soc: qcom: llcc: Refactor llcc driver to support
 multiple configuration
To:     Komal Bajaj <quic_kbajaj@quicinc.com>, <agross@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <srinivas.kandagatla@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20230802091429.20892-1-quic_kbajaj@quicinc.com>
 <20230802091429.20892-3-quic_kbajaj@quicinc.com>
Content-Language: en-US
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <20230802091429.20892-3-quic_kbajaj@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 4lss8ICEYuKPA5UW5HFyUb2qLm88J2Gs
X-Proofpoint-ORIG-GUID: 4lss8ICEYuKPA5UW5HFyUb2qLm88J2Gs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-03_12,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 mlxscore=0 clxscore=1015 priorityscore=1501 mlxlogscore=999 bulkscore=0
 phishscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308030118
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/2/2023 2:44 PM, Komal Bajaj wrote:
> Refactor driver to support multiple configuration for llcc on a target.
> 
> Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>
> ---
>   drivers/soc/qcom/llcc-qcom.c | 270 ++++++++++++++++++++++++-----------
>   1 file changed, 184 insertions(+), 86 deletions(-)
> 
> diff --git a/drivers/soc/qcom/llcc-qcom.c b/drivers/soc/qcom/llcc-qcom.c
> index 67c19ed2219a..808c5aaa7407 100644
> --- a/drivers/soc/qcom/llcc-qcom.c
> +++ b/drivers/soc/qcom/llcc-qcom.c
> @@ -66,6 +66,8 @@
>   #define LLCC_VERSION_2_1_0_0          0x02010000
>   #define LLCC_VERSION_4_1_0_0          0x04010000
> 
> +#define DEFAULT_CONFIG               1

Could it be DEF_NUM_CFG ?

> +
>   /**
>    * struct llcc_slice_config - Data associated with the llcc slice
>    * @usecase_id: Unique id for the client's use case
> @@ -127,6 +129,12 @@ struct qcom_llcc_config {
>   	bool no_edac;
>   };
> 
> +struct qcom_sct_config {
> +	const struct qcom_llcc_config *llcc_config;
> +	int num_config;
> +};
> +
> +

Extra line..

>   enum llcc_reg_offset {
>   	LLCC_COMMON_HW_INFO,
>   	LLCC_COMMON_STATUS0,
> @@ -423,101 +431,185 @@ static const u32 llcc_v2_1_reg_offset[] = {
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
>   };
> 
> -static const struct qcom_llcc_config sc7280_cfg = {
> -	.sct_data	= sc7280_data,
> -	.size		= ARRAY_SIZE(sc7280_data),
> -	.need_llcc_cfg	= true,
> -	.reg_offset	= llcc_v1_reg_offset,
> -	.edac_reg_offset = &llcc_v1_edac_reg_offset,
> +static const struct qcom_llcc_config sm8150_cfg[] = {
> +	{
> +		.sct_data       = sm8150_data,
> +		.size           = ARRAY_SIZE(sm8150_data),
> +		.need_llcc_cfg	= true,
> +		.reg_offset	= llcc_v1_reg_offset,
> +		.edac_reg_offset = &llcc_v1_edac_reg_offset,
> +	},
>   };
> 
> -static const struct qcom_llcc_config sc8180x_cfg = {
> -	.sct_data	= sc8180x_data,
> -	.size		= ARRAY_SIZE(sc8180x_data),
> -	.need_llcc_cfg	= true,
> -	.reg_offset	= llcc_v1_reg_offset,
> -	.edac_reg_offset = &llcc_v1_edac_reg_offset,
> +static const struct qcom_llcc_config sm8250_cfg[] = {
> +	{
> +		.sct_data       = sm8250_data,
> +		.size           = ARRAY_SIZE(sm8250_data),
> +		.need_llcc_cfg	= true,
> +		.reg_offset	= llcc_v1_reg_offset,
> +		.edac_reg_offset = &llcc_v1_edac_reg_offset,
> +	},
>   };
> 
> -static const struct qcom_llcc_config sc8280xp_cfg = {
> -	.sct_data	= sc8280xp_data,
> -	.size		= ARRAY_SIZE(sc8280xp_data),
> -	.need_llcc_cfg	= true,
> -	.reg_offset	= llcc_v1_reg_offset,
> -	.edac_reg_offset = &llcc_v1_edac_reg_offset,
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
>   };
> 
> -static const struct qcom_llcc_config sdm845_cfg = {
> -	.sct_data	= sdm845_data,
> -	.size		= ARRAY_SIZE(sdm845_data),
> -	.need_llcc_cfg	= false,
> -	.reg_offset	= llcc_v1_reg_offset,
> -	.edac_reg_offset = &llcc_v1_edac_reg_offset,
> -	.no_edac	= true,
> +static const struct qcom_sct_config sc7180_cfgs = {
> +	.llcc_config	= sc7180_cfg,
> +	.num_config	= ARRAY_SIZE(sc7180_cfg),
>   };
> 
> -static const struct qcom_llcc_config sm6350_cfg = {
> -	.sct_data	= sm6350_data,
> -	.size		= ARRAY_SIZE(sm6350_data),
> -	.need_llcc_cfg	= true,
> -	.reg_offset	= llcc_v1_reg_offset,
> -	.edac_reg_offset = &llcc_v1_edac_reg_offset,
> +static const struct qcom_sct_config sc7280_cfgs = {
> +	.llcc_config	= sc7280_cfg,
> +	.num_config	= ARRAY_SIZE(sc7280_cfg),
>   };
> 
> -static const struct qcom_llcc_config sm7150_cfg = {
> -	.sct_data       = sm7150_data,
> -	.size           = ARRAY_SIZE(sm7150_data),
> -	.need_llcc_cfg	= true,
> -	.reg_offset	= llcc_v1_reg_offset,
> -	.edac_reg_offset = &llcc_v1_edac_reg_offset,
> +static const struct qcom_sct_config sc8180x_cfgs = {
> +	.llcc_config	= sc8180x_cfg,
> +	.num_config	= ARRAY_SIZE(sc8180x_cfg),
>   };
> 
> -static const struct qcom_llcc_config sm8150_cfg = {
> -	.sct_data       = sm8150_data,
> -	.size           = ARRAY_SIZE(sm8150_data),
> -	.need_llcc_cfg	= true,
> -	.reg_offset	= llcc_v1_reg_offset,
> -	.edac_reg_offset = &llcc_v1_edac_reg_offset,
> +static const struct qcom_sct_config sc8280xp_cfgs = {
> +	.llcc_config	= sc8280xp_cfg,
> +	.num_config	= ARRAY_SIZE(sc8280xp_cfg),
>   };
> 
> -static const struct qcom_llcc_config sm8250_cfg = {
> -	.sct_data       = sm8250_data,
> -	.size           = ARRAY_SIZE(sm8250_data),
> -	.need_llcc_cfg	= true,
> -	.reg_offset	= llcc_v1_reg_offset,
> -	.edac_reg_offset = &llcc_v1_edac_reg_offset,
> +static const struct qcom_sct_config sdm845_cfgs = {
> +	.llcc_config	= sdm845_cfg,
> +	.num_config	= ARRAY_SIZE(sdm845_cfg),
>   };
> 
> -static const struct qcom_llcc_config sm8350_cfg = {
> -	.sct_data       = sm8350_data,
> -	.size           = ARRAY_SIZE(sm8350_data),
> -	.need_llcc_cfg	= true,
> -	.reg_offset	= llcc_v1_reg_offset,
> -	.edac_reg_offset = &llcc_v1_edac_reg_offset,
> +static const struct qcom_sct_config sm6350_cfgs = {
> +	.llcc_config	= sm6350_cfg,
> +	.num_config	= ARRAY_SIZE(sm6350_cfg),
>   };
> 
> -static const struct qcom_llcc_config sm8450_cfg = {
> -	.sct_data       = sm8450_data,
> -	.size           = ARRAY_SIZE(sm8450_data),
> -	.need_llcc_cfg	= true,
> -	.reg_offset	= llcc_v2_1_reg_offset,
> -	.edac_reg_offset = &llcc_v2_1_edac_reg_offset,
> +static const struct qcom_sct_config sm7150_cfgs = {
> +	.llcc_config	= sm7150_cfg,
> +	.num_config	= ARRAY_SIZE(sm7150_cfg),
>   };
> 
> -static const struct qcom_llcc_config sm8550_cfg = {
> -	.sct_data       = sm8550_data,
> -	.size           = ARRAY_SIZE(sm8550_data),
> -	.need_llcc_cfg	= true,
> -	.reg_offset	= llcc_v2_1_reg_offset,
> -	.edac_reg_offset = &llcc_v2_1_edac_reg_offset,
> +static const struct qcom_sct_config sm8150_cfgs = {
> +	.llcc_config	= sm8150_cfg,
> +	.num_config	= ARRAY_SIZE(sm8150_cfg),
> +};
> +
> +static const struct qcom_sct_config sm8250_cfgs = {
> +	.llcc_config	= sm8250_cfg,
> +	.num_config	= ARRAY_SIZE(sm8250_cfg),
> +};
> +
> +static const struct qcom_sct_config sm8350_cfgs = {
> +	.llcc_config	= sm8350_cfg,
> +	.num_config	= ARRAY_SIZE(sm8350_cfg),
> +};
> +
> +static const struct qcom_sct_config sm8450_cfgs = {
> +	.llcc_config	= sm8450_cfg,
> +	.num_config	= ARRAY_SIZE(sm8450_cfg),
> +};
> +
> +static const struct qcom_sct_config sm8550_cfgs = {
> +	.llcc_config	= sm8550_cfg,
> +	.num_config	= ARRAY_SIZE(sm8550_cfg),
>   };
> 
>   static struct llcc_drv_data *drv_data = (void *) -EPROBE_DEFER;
> @@ -939,6 +1031,7 @@ static int qcom_llcc_probe(struct platform_device *pdev)
>   	struct device *dev = &pdev->dev;
>   	int ret, i;
>   	struct platform_device *llcc_edac;
> +	const struct qcom_sct_config *cfgs;
>   	const struct qcom_llcc_config *cfg;
>   	const struct llcc_slice_config *llcc_cfg;
>   	u32 sz;
> @@ -958,7 +1051,12 @@ static int qcom_llcc_probe(struct platform_device *pdev)
>   		goto err;
>   	}
> 
> -	cfg = of_device_get_match_data(&pdev->dev);
> +	cfgs = of_device_get_match_data(&pdev->dev);
> +	if (cfgs->num_config != DEFAULT_CONFIG) {

NUL check is needed for cfgs;


-Mukesh
> +		ret = -EINVAL;
> +		goto err;
> +	}
> +	cfg = &cfgs->llcc_config[DEFAULT_CONFIG - 1];
> 
>   	ret = regmap_read(regmap, cfg->reg_offset[LLCC_COMMON_STATUS0], &num_banks);
>   	if (ret)
> @@ -1051,18 +1149,18 @@ static int qcom_llcc_probe(struct platform_device *pdev)
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
> --
> 2.41.0
> 
