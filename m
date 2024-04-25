Return-Path: <linux-kernel+bounces-158533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 33E968B21C0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 14:39:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 411D4B21AE3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 12:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7B411494C7;
	Thu, 25 Apr 2024 12:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="SARf4k9w"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DCA812BF04;
	Thu, 25 Apr 2024 12:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714048745; cv=none; b=RRvy3N2xHgRI5MBWHM099UHbqF4RI40LdvipPl/ywzvwXFJWC/i6oeTHIy5GRQbcUztwsuqXvMioVBs1OPoQYDCRcIlrHdn2j/RwHWNnUTNa3H6PIi6P59EJ47uzE+Ykb9GpZPeujNKGdQiKpBG3AAyWQ828cpmw1yQ4dC/XCGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714048745; c=relaxed/simple;
	bh=BVdWvAedTNOZ6PJWR1bHtbmXUdHDTHAhobj91tClV38=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=EOEYFYgz8K/etqv3srhdVIBHTjqjJFPogpHYkKgaAbaekLN3XCGO4zyFeoIQ/H99PuCVp1yhgvCpVY2iUrdo4UCmtJymAetFpuVTWa7TFxUyU4i3oIPOg4E2M0uzl3QeL6e2vES50XZzgNE1/gteXQT6iY1IBFmgNjWAXNBTkLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=SARf4k9w; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43PC5GQD002355;
	Thu, 25 Apr 2024 12:38:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=d1tj7b/5ep7BGWGsy9t18TIvNN2i9tXDWcCeCzfSP34=; b=SA
	Rf4k9wD0I9s/MIjuVbAZnLcD92EK8UFEABS2udSa+6D0vBi31W927H4LU99gSBcU
	fhQQfmuhs+fORkcPNYKu4T3W3G3fc90NJR1U+MkCUM5bAHIWrJ7aTvigHiLAdDFe
	A3+L0oJr4b174royFO8FNdxjbp2UeSoSrvnsrdcNVfuG2FIxdijQPoFNlWLH3Rtz
	lE+9D3W8FBLYr7WeZRYKvP1kBvqVjAApzXV9mSEBTy6ifqaQYuaOU6SrRMBPgPIy
	gj6Vc0XPxpiS3ohpQBZbQOSj6Fz6950qTvv2/Txa9B6942UVioU1wZXICSouMfiW
	FCXdaGwdJ9s+q/UilmLw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xqenkjgtu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Apr 2024 12:38:51 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43PCcoVF032390
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Apr 2024 12:38:50 GMT
Received: from [10.111.139.7] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 25 Apr
 2024 05:38:46 -0700
Message-ID: <77df205b-3577-7b89-dcaf-7cb3947b4fb4@quicinc.com>
Date: Thu, 25 Apr 2024 18:08:44 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 14/19] media: venus: core: Define a pointer to
 core->res
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
References: <20230911-topic-mars-v3-0-79f23b81c261@linaro.org>
 <20230911-topic-mars-v3-14-79f23b81c261@linaro.org>
Content-Language: en-US
From: Dikshita Agarwal <quic_dikshita@quicinc.com>
In-Reply-To: <20230911-topic-mars-v3-14-79f23b81c261@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: cFnzlcj5cyhptGoRcYAAIAls-nGkJJ1r
X-Proofpoint-GUID: cFnzlcj5cyhptGoRcYAAIAls-nGkJJ1r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-25_12,2024-04-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 mlxlogscore=999 priorityscore=1501 impostorscore=0 malwarescore=0
 bulkscore=0 lowpriorityscore=0 spamscore=0 adultscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404250091



On 3/27/2024 11:38 PM, Konrad Dybcio wrote:
> To make the code more concise, define a new variable 'res' pointing to
> the abundantly referenced core->res.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  drivers/media/platform/qcom/venus/core.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/platform/qcom/venus/core.c
> index 5b18b1f41267..e61aa863b7f7 100644
> --- a/drivers/media/platform/qcom/venus/core.c
> +++ b/drivers/media/platform/qcom/venus/core.c
> @@ -285,6 +285,7 @@ static irqreturn_t venus_isr_thread(int irq, void *dev_id)
>  
>  static int venus_probe(struct platform_device *pdev)
>  {
> +	const struct venus_resources *res;
>  	struct device *dev = &pdev->dev;
>  	struct venus_core *core;
>  	int i, ret;
> @@ -315,9 +316,11 @@ static int venus_probe(struct platform_device *pdev)
>  	if (!core->res)
>  		return -ENODEV;
>  
> +	res = core->res;
> +
>  	mutex_init(&core->pm_lock);
>  
> -	core->pm_ops = venus_pm_get(core->res->hfi_version);
> +	core->pm_ops = venus_pm_get(res->hfi_version);
>  	if (!core->pm_ops)
>  		return -ENODEV;
>  
> @@ -325,8 +328,8 @@ static int venus_probe(struct platform_device *pdev)
>  	if (ret)
>  		return ret;
>  
> -	for (i = 0; i < core->res->resets_num; i++) {
> -		core->resets[i] = devm_reset_control_get_exclusive(dev, core->res->resets[i]);
> +	for (i = 0; i < res->resets_num; i++) {
> +		core->resets[i] = devm_reset_control_get_exclusive(dev, res->resets[i]);
>  		if (IS_ERR(core->resets[i]))
>  			return PTR_ERR(core->resets[i]);
>  	}
> @@ -337,7 +340,7 @@ static int venus_probe(struct platform_device *pdev)
>  			return ret;
>  	}
>  
> -	ret = dma_set_mask_and_coherent(dev, core->res->dma_mask);
> +	ret = dma_set_mask_and_coherent(dev, res->dma_mask);
>  	if (ret)
>  		goto err_core_put;
>  
> 
Reviewed-by: Dikshita Agarwal <quic_dikshita@quicinc.com>	

