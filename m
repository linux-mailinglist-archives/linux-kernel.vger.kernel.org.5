Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3F3F78EEAC
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 15:32:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243867AbjHaNcX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 09:32:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbjHaNcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 09:32:22 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 381CD1A2;
        Thu, 31 Aug 2023 06:32:19 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37VAbdi2028175;
        Thu, 31 Aug 2023 13:32:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=s4J0x/0dGJLI9Sdm5f6C8bYPxNzEcJdHFyVeQMHKCi4=;
 b=X5Cm5+Hwyo8L2LtNqKKMa62tx5F1ljQ3AQxPPc4m7K+Xj6yD0xjcIaoZZfP84K7q/Xqr
 K3DSTUvAeJecuG03NEkJ/RN0PcCzyf1djbd/76BJ+FrtfkaRrM4yUUlMkTTotnigm1t0
 PpVuTqU0MWU900lAR5RYq9PqAtiiGYpyFzQINroIiYdmcFr8TUc8VkPk56NCUh83Yjd7
 3Rwe/nj4rkRXK0HBL6c5T3Ep5jP8UIVRVjDOZH8LewHWiLH3ST/Sxdm5k/f6jqmSPU+Q
 6B5o7uWo1175HWDo1FLvHwlCl53zUaS/XAkqhlTVbQsaI/5RIgNg0QW3EkVRfWeI7bNw 8g== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3stpy98q9h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 31 Aug 2023 13:32:12 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37VDWBxN027354
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 31 Aug 2023 13:32:11 GMT
Received: from [10.216.37.211] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Thu, 31 Aug
 2023 06:32:07 -0700
Message-ID: <392fedab-d434-804f-554c-12710adf908e@quicinc.com>
Date:   Thu, 31 Aug 2023 19:01:56 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v8 2/6] soc: qcom: llcc: Refactor llcc driver to support
 multiple configuration
Content-Language: en-US
To:     Komal Bajaj <quic_kbajaj@quicinc.com>, <agross@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <srinivas.kandagatla@linaro.org>,
        <bryan.odonoghue@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20230830105654.28057-1-quic_kbajaj@quicinc.com>
 <20230830105654.28057-3-quic_kbajaj@quicinc.com>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <20230830105654.28057-3-quic_kbajaj@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: aQBVkZtb6pti1wqErrza0IXS2jHn_vQ1
X-Proofpoint-GUID: aQBVkZtb6pti1wqErrza0IXS2jHn_vQ1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-31_11,2023-08-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 impostorscore=0 suspectscore=0 adultscore=0
 mlxlogscore=999 clxscore=1015 malwarescore=0 phishscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308310121
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/30/2023 4:26 PM, Komal Bajaj wrote:
> Refactor driver to support multiple configuration for llcc on a target.
> 
> Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>
> ---
>   drivers/soc/qcom/llcc-qcom.c | 267 ++++++++++++++++++++++++-----------
>   1 file changed, 181 insertions(+), 86 deletions(-)
> 
> diff --git a/drivers/soc/qcom/llcc-qcom.c b/drivers/soc/qcom/llcc-qcom.c
> index e32a4161a8d0..cbef8d825361 100644
> --- a/drivers/soc/qcom/llcc-qcom.c
> +++ b/drivers/soc/qcom/llcc-qcom.c
> @@ -126,6 +126,11 @@ struct qcom_llcc_config {
>   	bool no_edac;
>   };
> 
> +struct qcom_sct_config {
> +	const struct qcom_llcc_config *llcc_config;
> +	int num_config;
> +};
> +
>   enum llcc_reg_offset {
>   	LLCC_COMMON_HW_INFO,
>   	LLCC_COMMON_STATUS0,
> @@ -422,101 +427,185 @@ static const u32 llcc_v2_1_reg_offset[] = {
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
>   };
> 
> -static const struct qcom_llcc_config sc7280_cfg = {
> -	.sct_data	= sc7280_data,
> -	.size		= ARRAY_SIZE(sc7280_data),
> -	.need_llcc_cfg	= true,
> -	.reg_offset	= llcc_v1_reg_offset,
> -	.edac_reg_offset = &llcc_v1_edac_reg_offset,
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
> +	.num_config	= ARRAY_SIZE(sc7180_cfg),
> +};
> +
> +static const struct qcom_sct_config sc7280_cfgs = {
> +	.llcc_config	= sc7280_cfg,
> +	.num_config	= ARRAY_SIZE(sc7280_cfg),
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
> +	.num_config	= ARRAY_SIZE(sc8180x_cfg),
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
> +	.num_config	= ARRAY_SIZE(sc8280xp_cfg),
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
> +	.num_config	= ARRAY_SIZE(sdm845_cfg),
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
> +	.num_config	= ARRAY_SIZE(sm6350_cfg),
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
> +	.num_config	= ARRAY_SIZE(sm7150_cfg),
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
> +	.num_config	= ARRAY_SIZE(sm8150_cfg),
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
> +	.num_config	= ARRAY_SIZE(sm8250_cfg),
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
> +	.num_config	= ARRAY_SIZE(sm8350_cfg),
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
> +	.num_config	= ARRAY_SIZE(sm8450_cfg),
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
> +	.num_config	= ARRAY_SIZE(sm8550_cfg),
>   };
> 
>   static struct llcc_drv_data *drv_data = (void *) -EPROBE_DEFER;
> @@ -938,6 +1027,7 @@ static int qcom_llcc_probe(struct platform_device *pdev)
>   	struct device *dev = &pdev->dev;
>   	int ret, i;
>   	struct platform_device *llcc_edac;
> +	const struct qcom_sct_config *cfgs;
>   	const struct qcom_llcc_config *cfg;
>   	const struct llcc_slice_config *llcc_cfg;
>   	u32 sz;
> @@ -957,7 +1047,12 @@ static int qcom_llcc_probe(struct platform_device *pdev)
>   		goto err;
>   	}
> 
> -	cfg = of_device_get_match_data(&pdev->dev);
> +	cfgs = of_device_get_match_data(&pdev->dev);
> +	if (!cfgs) {

This patch also fixing this NULL pointer issue.

Fixes: ee13b5008707 ("qcom: llcc/edac: Fix the base address used for 
accessing LLCC banks")

Reviewed-by: Mukesh Ojha <quic_mojha@quicinc.com>

-Mukesh

> +		ret = -EINVAL;
> +		goto err;
> +	}
> +	cfg = &cfgs->llcc_config[0];
> 
>   	ret = regmap_read(regmap, cfg->reg_offset[LLCC_COMMON_STATUS0], &num_banks);
>   	if (ret)
> @@ -1050,18 +1145,18 @@ static int qcom_llcc_probe(struct platform_device *pdev)
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
