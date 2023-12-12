Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D3EE80E248
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 03:50:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345727AbjLLCoa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 21:44:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjLLCo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 21:44:29 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90C05B5;
        Mon, 11 Dec 2023 18:44:34 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BC2PiGr002115;
        Tue, 12 Dec 2023 02:44:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
        message-id:date:mime-version:subject:to:cc:references:from
        :in-reply-to:content-type:content-transfer-encoding; s=
        qcppdkim1; bh=v04bdi64DE9YImBhMWuPysMHAj1EZZHaZn1b/bacBeU=; b=he
        nAiqxK74VwtY5X/6UhTW5neaLvzneg2FkppEuojTOFfWKzQRM2z4wNG1h3BYZti6
        YLyQlZsOeCHVJxvOAgJn8uS4ryk2mIQ1kK4M50Lc/Nasb4OHsS7ML4AVl79THBIa
        rTRywFhE9te/JrWAvQ9eotiHY4vxhdAie96Z4RwLM2XnhKZxOch1cg7UBTFcJSaw
        iR/35dETLk/4XQEWvipfhglmtE79Luvht+qygAXzZdBbi6h73rCJmaFrmHB+9NPO
        l4MQ3+woPecovo6YTIGqmYbybazeVmJ8IHdxtyfjdNuyoNEo5+WpiZbNjYGSRoNn
        1tbVN51DiaxlKfW7GQQw==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uvnv8cxxk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Dec 2023 02:44:28 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BC2iRQg019530
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Dec 2023 02:44:27 GMT
Received: from [10.47.206.1] (10.49.16.6) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 11 Dec
 2023 18:44:23 -0800
Message-ID: <cd104cd4-de02-d7ae-13e2-5d45dad5bd49@quicinc.com>
Date:   Mon, 11 Dec 2023 18:44:22 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/4] regulator: qcom-rpmh: extend to support multiple
 linear voltage ranges
Content-Language: en-US
To:     <quic_fenglinw@quicinc.com>, Andy Gross <agross@kernel.org>,
        "Bjorn Andersson" <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, <kernel@quicinc.com>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <quic_subbaram@quicinc.com>,
        <quic_jprakash@quicinc.com>
References: <20231211-pm8010-regulator-v1-0-571e05fb4ecc@quicinc.com>
 <20231211-pm8010-regulator-v1-1-571e05fb4ecc@quicinc.com>
From:   David Collins <quic_collinsd@quicinc.com>
In-Reply-To: <20231211-pm8010-regulator-v1-1-571e05fb4ecc@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: j1gevCUrL7QkQ1BSsYPFuPLhEvK9pWFm
X-Proofpoint-GUID: j1gevCUrL7QkQ1BSsYPFuPLhEvK9pWFm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 mlxlogscore=963 suspectscore=0 priorityscore=1501
 impostorscore=0 adultscore=0 mlxscore=0 phishscore=0 clxscore=1011
 bulkscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312120021
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/10/23 19:16, Fenglin Wu via B4 Relay wrote:
> From: Fenglin Wu <quic_fenglinw@quicinc.com>
> 
> Update rpmh_vreg_hw_data to support multiple linear voltage ranges for
> potential regulators which have discrete voltage program ranges.
> 
> Suggested-by: David Collins <quic_collinsd@quicinc.com>
> Signed-off-by: Fenglin Wu <quic_fenglinw@quicinc.com>

Reviewed-by: David Collins <quic_collinsd@quicinc.com>


> ---
>  drivers/regulator/qcom-rpmh-regulator.c | 115 ++++++++++++++++++++++++--------
>  1 file changed, 89 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/regulator/qcom-rpmh-regulator.c b/drivers/regulator/qcom-rpmh-regulator.c
> index cf502eec0915..43b45feb02e6 100644
> --- a/drivers/regulator/qcom-rpmh-regulator.c
> +++ b/drivers/regulator/qcom-rpmh-regulator.c
> @@ -1,5 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0
>  // Copyright (c) 2018-2021, The Linux Foundation. All rights reserved.
> +// Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
>  
>  #define pr_fmt(fmt) "%s: " fmt, __func__
>  
> @@ -68,10 +69,11 @@ enum rpmh_regulator_type {
>   * @regulator_type:		RPMh accelerator type used to manage this
>   *				regulator
>   * @ops:			Pointer to regulator ops callback structure
> - * @voltage_range:		The single range of voltages supported by this
> - *				PMIC regulator type
> + * @voltage_ranges:		The possible ranges of voltages supported by this
> + * 				PMIC regulator type
> + * @n_linear_ranges:		Number of entries in voltage_ranges
>   * @n_voltages:			The number of unique voltage set points defined
> - *				by voltage_range
> + *				by voltage_ranges
>   * @hpm_min_load_uA:		Minimum load current in microamps that requires
>   *				high power mode (HPM) operation.  This is used
>   *				for LDO hardware type regulators only.
> @@ -85,7 +87,8 @@ enum rpmh_regulator_type {
>  struct rpmh_vreg_hw_data {
>  	enum rpmh_regulator_type		regulator_type;
>  	const struct regulator_ops		*ops;
> -	const struct linear_range	voltage_range;
> +	const struct linear_range		*voltage_ranges;
> +	int					n_linear_ranges;
>  	int					n_voltages;
>  	int					hpm_min_load_uA;
>  	const int				*pmic_mode_map;
> @@ -449,8 +452,8 @@ static int rpmh_regulator_init_vreg(struct rpmh_vreg *vreg, struct device *dev,
>  	vreg->mode = REGULATOR_MODE_INVALID;
>  
>  	if (rpmh_data->hw_data->n_voltages) {
> -		vreg->rdesc.linear_ranges = &rpmh_data->hw_data->voltage_range;
> -		vreg->rdesc.n_linear_ranges = 1;
> +		vreg->rdesc.linear_ranges = rpmh_data->hw_data->voltage_ranges;
> +		vreg->rdesc.n_linear_ranges = rpmh_data->hw_data->n_linear_ranges;
>  		vreg->rdesc.n_voltages = rpmh_data->hw_data->n_voltages;
>  	}
>  
> @@ -613,7 +616,10 @@ static unsigned int rpmh_regulator_pmic4_bob_of_map_mode(unsigned int rpmh_mode)
>  static const struct rpmh_vreg_hw_data pmic4_pldo = {
>  	.regulator_type = VRM,
>  	.ops = &rpmh_regulator_vrm_drms_ops,
> -	.voltage_range = REGULATOR_LINEAR_RANGE(1664000, 0, 255, 8000),
> +	.voltage_ranges = (struct linear_range[]) {
> +		REGULATOR_LINEAR_RANGE(1664000, 0, 255, 8000),
> +	},
> +	.n_linear_ranges = 1,
>  	.n_voltages = 256,
>  	.hpm_min_load_uA = 10000,
>  	.pmic_mode_map = pmic_mode_map_pmic4_ldo,
> @@ -623,7 +629,10 @@ static const struct rpmh_vreg_hw_data pmic4_pldo = {
>  static const struct rpmh_vreg_hw_data pmic4_pldo_lv = {
>  	.regulator_type = VRM,
>  	.ops = &rpmh_regulator_vrm_drms_ops,
> -	.voltage_range = REGULATOR_LINEAR_RANGE(1256000, 0, 127, 8000),
> +	.voltage_ranges = (struct linear_range[]) {
> +	       REGULATOR_LINEAR_RANGE(1256000, 0, 127, 8000),
> +	},
> +	.n_linear_ranges = 1,
>  	.n_voltages = 128,
>  	.hpm_min_load_uA = 10000,
>  	.pmic_mode_map = pmic_mode_map_pmic4_ldo,
> @@ -633,7 +642,10 @@ static const struct rpmh_vreg_hw_data pmic4_pldo_lv = {
>  static const struct rpmh_vreg_hw_data pmic4_nldo = {
>  	.regulator_type = VRM,
>  	.ops = &rpmh_regulator_vrm_drms_ops,
> -	.voltage_range = REGULATOR_LINEAR_RANGE(312000, 0, 127, 8000),
> +	.voltage_ranges = (struct linear_range[]) {
> +		REGULATOR_LINEAR_RANGE(312000, 0, 127, 8000),
> +	},
> +	.n_linear_ranges = 1,
>  	.n_voltages = 128,
>  	.hpm_min_load_uA = 30000,
>  	.pmic_mode_map = pmic_mode_map_pmic4_ldo,
> @@ -643,7 +655,10 @@ static const struct rpmh_vreg_hw_data pmic4_nldo = {
>  static const struct rpmh_vreg_hw_data pmic4_hfsmps3 = {
>  	.regulator_type = VRM,
>  	.ops = &rpmh_regulator_vrm_ops,
> -	.voltage_range = REGULATOR_LINEAR_RANGE(320000, 0, 215, 8000),
> +	.voltage_ranges = (struct linear_range[]) {
> +		REGULATOR_LINEAR_RANGE(320000, 0, 215, 8000),
> +	},
> +	.n_linear_ranges = 1,
>  	.n_voltages = 216,
>  	.pmic_mode_map = pmic_mode_map_pmic4_smps,
>  	.of_map_mode = rpmh_regulator_pmic4_smps_of_map_mode,
> @@ -652,7 +667,10 @@ static const struct rpmh_vreg_hw_data pmic4_hfsmps3 = {
>  static const struct rpmh_vreg_hw_data pmic4_ftsmps426 = {
>  	.regulator_type = VRM,
>  	.ops = &rpmh_regulator_vrm_ops,
> -	.voltage_range = REGULATOR_LINEAR_RANGE(320000, 0, 258, 4000),
> +	.voltage_ranges = (struct linear_range[]) {
> +		REGULATOR_LINEAR_RANGE(320000, 0, 258, 4000),
> +	},
> +	.n_linear_ranges = 1,
>  	.n_voltages = 259,
>  	.pmic_mode_map = pmic_mode_map_pmic4_smps,
>  	.of_map_mode = rpmh_regulator_pmic4_smps_of_map_mode,
> @@ -661,7 +679,10 @@ static const struct rpmh_vreg_hw_data pmic4_ftsmps426 = {
>  static const struct rpmh_vreg_hw_data pmic4_bob = {
>  	.regulator_type = VRM,
>  	.ops = &rpmh_regulator_vrm_bypass_ops,
> -	.voltage_range = REGULATOR_LINEAR_RANGE(1824000, 0, 83, 32000),
> +	.voltage_ranges = (struct linear_range[]) {
> +		REGULATOR_LINEAR_RANGE(1824000, 0, 83, 32000),
> +	},
> +	.n_linear_ranges = 1,
>  	.n_voltages = 84,
>  	.pmic_mode_map = pmic_mode_map_pmic4_bob,
>  	.of_map_mode = rpmh_regulator_pmic4_bob_of_map_mode,
> @@ -676,7 +697,10 @@ static const struct rpmh_vreg_hw_data pmic4_lvs = {
>  static const struct rpmh_vreg_hw_data pmic5_pldo = {
>  	.regulator_type = VRM,
>  	.ops = &rpmh_regulator_vrm_drms_ops,
> -	.voltage_range = REGULATOR_LINEAR_RANGE(1504000, 0, 255, 8000),
> +	.voltage_ranges = (struct linear_range[]) {
> +		REGULATOR_LINEAR_RANGE(1504000, 0, 255, 8000),
> +	},
> +	.n_linear_ranges = 1,
>  	.n_voltages = 256,
>  	.hpm_min_load_uA = 10000,
>  	.pmic_mode_map = pmic_mode_map_pmic5_ldo,
> @@ -686,7 +710,10 @@ static const struct rpmh_vreg_hw_data pmic5_pldo = {
>  static const struct rpmh_vreg_hw_data pmic5_pldo_lv = {
>  	.regulator_type = VRM,
>  	.ops = &rpmh_regulator_vrm_drms_ops,
> -	.voltage_range = REGULATOR_LINEAR_RANGE(1504000, 0, 62, 8000),
> +	.voltage_ranges = (struct linear_range[]) {
> +		REGULATOR_LINEAR_RANGE(1504000, 0, 62, 8000),
> +	},
> +	.n_linear_ranges = 1,
>  	.n_voltages = 63,
>  	.hpm_min_load_uA = 10000,
>  	.pmic_mode_map = pmic_mode_map_pmic5_ldo,
> @@ -696,7 +723,10 @@ static const struct rpmh_vreg_hw_data pmic5_pldo_lv = {
>  static const struct rpmh_vreg_hw_data pmic5_pldo515_mv = {
>  	.regulator_type = VRM,
>  	.ops = &rpmh_regulator_vrm_drms_ops,
> -	.voltage_range = REGULATOR_LINEAR_RANGE(1800000, 0, 187, 8000),
> +	.voltage_ranges = (struct linear_range[]) {
> +		REGULATOR_LINEAR_RANGE(1800000, 0, 187, 8000),
> +	},
> +	.n_linear_ranges = 1,
>  	.n_voltages = 188,
>  	.hpm_min_load_uA = 10000,
>  	.pmic_mode_map = pmic_mode_map_pmic5_ldo,
> @@ -706,7 +736,10 @@ static const struct rpmh_vreg_hw_data pmic5_pldo515_mv = {
>  static const struct rpmh_vreg_hw_data pmic5_nldo = {
>  	.regulator_type = VRM,
>  	.ops = &rpmh_regulator_vrm_drms_ops,
> -	.voltage_range = REGULATOR_LINEAR_RANGE(320000, 0, 123, 8000),
> +	.voltage_ranges = (struct linear_range[]) {
> +		REGULATOR_LINEAR_RANGE(320000, 0, 123, 8000),
> +	},
> +	.n_linear_ranges = 1,
>  	.n_voltages = 124,
>  	.hpm_min_load_uA = 30000,
>  	.pmic_mode_map = pmic_mode_map_pmic5_ldo,
> @@ -716,7 +749,10 @@ static const struct rpmh_vreg_hw_data pmic5_nldo = {
>  static const struct rpmh_vreg_hw_data pmic5_nldo515 = {
>  	.regulator_type = VRM,
>  	.ops = &rpmh_regulator_vrm_drms_ops,
> -	.voltage_range = REGULATOR_LINEAR_RANGE(320000, 0, 210, 8000),
> +	.voltage_ranges = (struct linear_range[]) {
> +		REGULATOR_LINEAR_RANGE(320000, 0, 210, 8000),
> +	},
> +	.n_linear_ranges = 1,
>  	.n_voltages = 211,
>  	.hpm_min_load_uA = 30000,
>  	.pmic_mode_map = pmic_mode_map_pmic5_ldo,
> @@ -726,7 +762,10 @@ static const struct rpmh_vreg_hw_data pmic5_nldo515 = {
>  static const struct rpmh_vreg_hw_data pmic5_hfsmps510 = {
>  	.regulator_type = VRM,
>  	.ops = &rpmh_regulator_vrm_ops,
> -	.voltage_range = REGULATOR_LINEAR_RANGE(320000, 0, 215, 8000),
> +	.voltage_ranges = (struct linear_range[]) {
> +		REGULATOR_LINEAR_RANGE(320000, 0, 215, 8000),
> +	},
> +	.n_linear_ranges = 1,
>  	.n_voltages = 216,
>  	.pmic_mode_map = pmic_mode_map_pmic5_smps,
>  	.of_map_mode = rpmh_regulator_pmic4_smps_of_map_mode,
> @@ -735,7 +774,10 @@ static const struct rpmh_vreg_hw_data pmic5_hfsmps510 = {
>  static const struct rpmh_vreg_hw_data pmic5_ftsmps510 = {
>  	.regulator_type = VRM,
>  	.ops = &rpmh_regulator_vrm_ops,
> -	.voltage_range = REGULATOR_LINEAR_RANGE(300000, 0, 263, 4000),
> +	.voltage_ranges = (struct linear_range[]) {
> +		REGULATOR_LINEAR_RANGE(300000, 0, 263, 4000),
> +	},
> +	.n_linear_ranges = 1,
>  	.n_voltages = 264,
>  	.pmic_mode_map = pmic_mode_map_pmic5_smps,
>  	.of_map_mode = rpmh_regulator_pmic4_smps_of_map_mode,
> @@ -744,7 +786,10 @@ static const struct rpmh_vreg_hw_data pmic5_ftsmps510 = {
>  static const struct rpmh_vreg_hw_data pmic5_ftsmps520 = {
>  	.regulator_type = VRM,
>  	.ops = &rpmh_regulator_vrm_ops,
> -	.voltage_range = REGULATOR_LINEAR_RANGE(300000, 0, 263, 4000),
> +	.voltage_ranges = (struct linear_range[]) {
> +		REGULATOR_LINEAR_RANGE(300000, 0, 263, 4000),
> +	},
> +	.n_linear_ranges = 1,
>  	.n_voltages = 264,
>  	.pmic_mode_map = pmic_mode_map_pmic5_smps,
>  	.of_map_mode = rpmh_regulator_pmic4_smps_of_map_mode,
> @@ -753,7 +798,10 @@ static const struct rpmh_vreg_hw_data pmic5_ftsmps520 = {
>  static const struct rpmh_vreg_hw_data pmic5_ftsmps525_lv = {
>  	.regulator_type = VRM,
>  	.ops = &rpmh_regulator_vrm_ops,
> -	.voltage_range = REGULATOR_LINEAR_RANGE(300000, 0, 267, 4000),
> +	.voltage_ranges = (struct linear_range[]) {
> +		REGULATOR_LINEAR_RANGE(300000, 0, 267, 4000),
> +	},
> +	.n_linear_ranges = 1,
>  	.n_voltages = 268,
>  	.pmic_mode_map = pmic_mode_map_pmic5_smps,
>  	.of_map_mode = rpmh_regulator_pmic4_smps_of_map_mode,
> @@ -762,7 +810,10 @@ static const struct rpmh_vreg_hw_data pmic5_ftsmps525_lv = {
>  static const struct rpmh_vreg_hw_data pmic5_ftsmps525_mv = {
>  	.regulator_type = VRM,
>  	.ops = &rpmh_regulator_vrm_ops,
> -	.voltage_range = REGULATOR_LINEAR_RANGE(600000, 0, 267, 8000),
> +	.voltage_ranges = (struct linear_range[]) {
> +		REGULATOR_LINEAR_RANGE(600000, 0, 267, 8000),
> +	},
> +	.n_linear_ranges = 1,
>  	.n_voltages = 268,
>  	.pmic_mode_map = pmic_mode_map_pmic5_smps,
>  	.of_map_mode = rpmh_regulator_pmic4_smps_of_map_mode,
> @@ -771,7 +822,10 @@ static const struct rpmh_vreg_hw_data pmic5_ftsmps525_mv = {
>  static const struct rpmh_vreg_hw_data pmic5_ftsmps527 = {
>  	.regulator_type = VRM,
>  	.ops = &rpmh_regulator_vrm_ops,
> -	.voltage_range = REGULATOR_LINEAR_RANGE(320000, 0, 215, 8000),
> +	.voltage_ranges = (struct linear_range[]) {
> +		REGULATOR_LINEAR_RANGE(320000, 0, 215, 8000),
> +	},
> +	.n_linear_ranges = 1,
>  	.n_voltages = 215,
>  	.pmic_mode_map = pmic_mode_map_pmic5_smps,
>  	.of_map_mode = rpmh_regulator_pmic4_smps_of_map_mode,
> @@ -780,7 +834,10 @@ static const struct rpmh_vreg_hw_data pmic5_ftsmps527 = {
>  static const struct rpmh_vreg_hw_data pmic5_hfsmps515 = {
>  	.regulator_type = VRM,
>  	.ops = &rpmh_regulator_vrm_ops,
> -	.voltage_range = REGULATOR_LINEAR_RANGE(320000, 0, 235, 16000),
> +	.voltage_ranges = (struct linear_range[]) {
> +		REGULATOR_LINEAR_RANGE(320000, 0, 235, 16000),
> +	},
> +	.n_linear_ranges = 1,
>  	.n_voltages = 236,
>  	.pmic_mode_map = pmic_mode_map_pmic5_smps,
>  	.of_map_mode = rpmh_regulator_pmic4_smps_of_map_mode,
> @@ -789,7 +846,10 @@ static const struct rpmh_vreg_hw_data pmic5_hfsmps515 = {
>  static const struct rpmh_vreg_hw_data pmic5_hfsmps515_1 = {
>  	.regulator_type = VRM,
>  	.ops = &rpmh_regulator_vrm_ops,
> -	.voltage_range = REGULATOR_LINEAR_RANGE(900000, 0, 4, 16000),
> +	.voltage_ranges = (struct linear_range[]) {
> +		REGULATOR_LINEAR_RANGE(900000, 0, 4, 16000),
> +	},
> +	.n_linear_ranges = 1,
>  	.n_voltages = 5,
>  	.pmic_mode_map = pmic_mode_map_pmic5_smps,
>  	.of_map_mode = rpmh_regulator_pmic4_smps_of_map_mode,
> @@ -798,7 +858,10 @@ static const struct rpmh_vreg_hw_data pmic5_hfsmps515_1 = {
>  static const struct rpmh_vreg_hw_data pmic5_bob = {
>  	.regulator_type = VRM,
>  	.ops = &rpmh_regulator_vrm_bypass_ops,
> -	.voltage_range = REGULATOR_LINEAR_RANGE(3000000, 0, 31, 32000),
> +	.voltage_ranges = (struct linear_range[]) {
> +		REGULATOR_LINEAR_RANGE(3000000, 0, 31, 32000),
> +	},
> +	.n_linear_ranges = 1,
>  	.n_voltages = 32,
>  	.pmic_mode_map = pmic_mode_map_pmic5_bob,
>  	.of_map_mode = rpmh_regulator_pmic4_bob_of_map_mode,
> 

