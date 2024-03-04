Return-Path: <linux-kernel+bounces-90065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8C4B86F9B3
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 06:48:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 863A42812E4
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 05:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45D04C147;
	Mon,  4 Mar 2024 05:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="hRtRt05F"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD80BA27;
	Mon,  4 Mar 2024 05:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709531287; cv=none; b=C0oAMMJaFLQhaqagT+k6f2X7WwP1fnU9/XiDZPEIZJVdnYPqaK5T+cRmzlU+Ejgqobs/pue1XDHwX9apIBio9kfq5Sb6vWZClHLWTN9XluCU9Lhmrtp9nYjpxbPXB1j3QSKRn0hvkMgt1AmXAhnRSQCBqH1rjqriyWKD/5j499c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709531287; c=relaxed/simple;
	bh=Kv8Nr3FEIckencu6Ylpi3FmpKkAFdmqr9abFkn55fiI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=oG0XiIOYhySXLhcbuIbmje1GRhHbKHGH3iOERSfwvYbtk21LCIaAw3GLe1Wlw297wJNXw87HeFrn81iAck/LZ2OvxgpJtyJ41gsGVF+Wwf/RtYCxNFVVZeegO6IwssKbSqborkV0CEE+e5JYQfo5mk8kgnK8jL9txzQyGXWexyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=hRtRt05F; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4245YJkb026498;
	Mon, 4 Mar 2024 05:47:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=0HGg9g3P/i9jEj6DMJ5AkuHF0Bu5U7/pEoE/uLfkva4=; b=hR
	tRt05Fn+urAZCp8Y2wVArGbAGyD+fp7HcekU+xCNcOJJmplrcyxt+mvEOWweblqc
	vtw7bayyexRwOwLoWTFkLiCv5jkljI6G+Zcu/25bhcrYTY3LzlBRxSqMxksauj02
	DnyBbG8kYlxrq5psKw0YEz18ryLNYSUK+/CE/f+8h6+KeRzhCmidf0HBJbstN8ry
	7moAXPru2WSLrLGEYTDUopQW9HP2lDYQc2pHARXYVfyENyhFVwxwQR9zNL5oAxi1
	Qf3sqI0GofXmIQlRA6Amz0DW6UIFP8bUzmJwMOP7ZkiX2fHUNLMy12IRPvHCgb4x
	J/4fjk0fE20gBAnByJcA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wkstk2vey-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Mar 2024 05:47:54 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4245lrvP030149
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 4 Mar 2024 05:47:53 GMT
Received: from [10.50.22.179] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Sun, 3 Mar
 2024 21:47:48 -0800
Message-ID: <b3ec7faa-e059-d33e-4e4c-749c551e0097@quicinc.com>
Date: Mon, 4 Mar 2024 11:17:44 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 06/20] media: venus: pm_helpers: Move reset acquisition
 to common code
Content-Language: en-US
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
        Stanimir Varbanov
	<stanimir.k.varbanov@gmail.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Andy Gross
	<agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        "Mauro Carvalho
 Chehab" <mchehab@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
CC: Marijn Suijten <marijn.suijten@somainline.org>,
        Stanimir Varbanov
	<stanimir.varbanov@linaro.org>,
        Mauro Carvalho Chehab
	<mchehab+huawei@kernel.org>,
        <linux-media@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20230911-topic-mars-v2-0-3dac84b88c4b@linaro.org>
 <20230911-topic-mars-v2-6-3dac84b88c4b@linaro.org>
From: Dikshita Agarwal <quic_dikshita@quicinc.com>
In-Reply-To: <20230911-topic-mars-v2-6-3dac84b88c4b@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: lls06jQDGs_Oyew5LW_S1siVw8vwWBuC
X-Proofpoint-ORIG-GUID: lls06jQDGs_Oyew5LW_S1siVw8vwWBuC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-04_02,2024-03-01_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 spamscore=0 suspectscore=0 impostorscore=0 adultscore=0 malwarescore=0
 clxscore=1015 mlxscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403040041



On 2/10/2024 2:39 AM, Konrad Dybcio wrote:
> There is no reason to keep reset_get code local to HFIv4/v6.
> 
> Move it to the common part.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  drivers/media/platform/qcom/venus/core.c       |  9 ++++++++-
>  drivers/media/platform/qcom/venus/pm_helpers.c | 23 -----------------------
>  2 files changed, 8 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/platform/qcom/venus/core.c
> index 5ab3c414ec0f..0652065cb113 100644
> --- a/drivers/media/platform/qcom/venus/core.c
> +++ b/drivers/media/platform/qcom/venus/core.c
> @@ -15,6 +15,7 @@
>  #include <linux/of_platform.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_opp.h>
> +#include <linux/reset.h>
>  #include <linux/slab.h>
>  #include <linux/types.h>
>  #include <linux/pm_domain.h>
> @@ -286,7 +287,7 @@ static int venus_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
>  	struct venus_core *core;
> -	int ret;
> +	int i, ret;
>  
>  	core = devm_kzalloc(dev, sizeof(*core), GFP_KERNEL);
>  	if (!core)
> @@ -324,6 +325,12 @@ static int venus_probe(struct platform_device *pdev)
>  	if (ret)
>  		return ret;
>  
> +	for (i = 0; i < core->res->resets_num; i++) {
> +		core->resets[i] = devm_reset_control_get_exclusive(dev, core->res->resets[i]);
> +		if (IS_ERR(core->resets[i]))
> +			return PTR_ERR(core->resets[i]);
> +	}
> +
>  	if (core->pm_ops->core_get) {
>  		ret = core->pm_ops->core_get(core);
>  		if (ret)
> diff --git a/drivers/media/platform/qcom/venus/pm_helpers.c b/drivers/media/platform/qcom/venus/pm_helpers.c
> index 7193075e8c04..6017a9236bff 100644
> --- a/drivers/media/platform/qcom/venus/pm_helpers.c
> +++ b/drivers/media/platform/qcom/venus/pm_helpers.c
> @@ -939,25 +939,6 @@ static int core_resets_reset(struct venus_core *core)
>  	return ret;
>  }
>  
> -static int core_resets_get(struct venus_core *core)
> -{
> -	struct device *dev = core->dev;
> -	const struct venus_resources *res = core->res;
> -	unsigned int i;
> -	int ret;
> -
> -	for (i = 0; i < res->resets_num; i++) {
> -		core->resets[i] =
> -			devm_reset_control_get_exclusive(dev, res->resets[i]);
> -		if (IS_ERR(core->resets[i])) {
> -			ret = PTR_ERR(core->resets[i]);
> -			return ret;
> -		}
> -	}
> -
> -	return 0;
> -}
> -
resets are applicable to only v6 so it should be ok to keep this only in
core_get_v4 which is invoked for v6 as well. common code should be common
for all SOCs.
>  static int core_get_v4(struct venus_core *core)
>  {
>  	struct device *dev = core->dev;
> @@ -981,10 +962,6 @@ static int core_get_v4(struct venus_core *core)
>  	if (ret)
>  		return ret;
>  
> -	ret = core_resets_get(core);
> -	if (ret)
> -		return ret;
> -
>  	if (legacy_binding)
>  		return 0;
>  
> 

