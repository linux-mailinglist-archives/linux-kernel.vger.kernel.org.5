Return-Path: <linux-kernel+bounces-132654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38D0E8997D3
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 10:30:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3EFCB21167
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 08:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6547C14D70C;
	Fri,  5 Apr 2024 08:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="GsFLDj/e"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C8D14D2AB;
	Fri,  5 Apr 2024 08:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712305833; cv=none; b=doOkKmon5hXjXn1ybMsrD1H7bt4wbd5Wo3ku6UnTt051GKfLgVIvFtiZF9XpSw2Sg5pKzYaPGnb4lDWyrOUmwoqHeSdtJa+aQBq2lOaKl8kjdl3abmDi2fsqODJlIGdudoPnqB6Zxr9h/EQUE18slPHa6WXRuk7YOu069/HYZXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712305833; c=relaxed/simple;
	bh=LE9kcDHuYvI9jTeyySzcqd6yMPIj1SuKKRQt/X3Sinc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=nxbPAqvxhY30F7CzeJ1Zoc3FqLKth4ZiaiMC6fLVgch3qMtpQlvAJorQwYeq3nj/pFc1ZHSYhtsQhjE76mE8DNFbyVNOyIG1sJIQh7AcZ/3a8QQFcH8lW70Bi39+zsTj0s9jPYWxRHpJxHCRvftiqHfarB0+ywgs2bPP7oKZ4QQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=GsFLDj/e; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4355Bn2N010957;
	Fri, 5 Apr 2024 08:30:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=+G0j8IW88PEArlm/qC8NPfjW9x8m5NPgi3w8vh4fE6E=; b=Gs
	FLDj/eJNmlCCaVQ9fTZteD1rohCIcJtSJmDVdGw4+iHDmhDoEy3Rj/qCK4+g+muK
	R+03247s4RZrA++7VRQ47bjj73rDruP51pPKnK1JnmthvgqcwivFKJSJ324fwpJ+
	okdu5/MPUFzvdtvfqOyarSzi/nyrEh1wrux3FibE4X9jq84aiQgys/hXJnGsucEp
	vZbVZYBmQT4v2gi9C2OzIhFS9KRHk+wjv0S3OLsSGTf7mSFQjHmPzyPggMFDOHeb
	kG6U1gYYH1BDeqaswa8Lrja9siZYGmfUrBV3DHUAUYoUI6ZCGRtykcdQTaJac3NS
	6M6tEB6g9YBCWJrtea5w==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xa2q397a2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Apr 2024 08:30:21 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4358UK4Q022917
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 5 Apr 2024 08:30:20 GMT
Received: from [10.216.11.24] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 5 Apr 2024
 01:30:16 -0700
Message-ID: <79c2b0eb-e7f3-3826-d977-3c4367d42d7f@quicinc.com>
Date: Fri, 5 Apr 2024 14:00:11 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 19/19] media: venus: pm_helpers: Use reset_bulk API
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
References: <20230911-topic-mars-v3-0-79f23b81c261@linaro.org>
 <20230911-topic-mars-v3-19-79f23b81c261@linaro.org>
From: Dikshita Agarwal <quic_dikshita@quicinc.com>
In-Reply-To: <20230911-topic-mars-v3-19-79f23b81c261@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: LwJS-YydmJf_7PgsKyOs2GUSgD952wXE
X-Proofpoint-GUID: LwJS-YydmJf_7PgsKyOs2GUSgD952wXE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-05_07,2024-04-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 priorityscore=1501 clxscore=1015 malwarescore=0 bulkscore=0
 mlxlogscore=999 adultscore=0 impostorscore=0 lowpriorityscore=0
 spamscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404050062



On 3/27/2024 11:38 PM, Konrad Dybcio wrote:
> All of the resets are toggled together. Use the bulk api to save on some
> code complexity.
> 
> The delay between resets is now correctly determined by the reset
> framework.
> 
> Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  drivers/media/platform/qcom/venus/core.c       | 15 ++++++++++-----
>  drivers/media/platform/qcom/venus/core.h       |  4 ++--
>  drivers/media/platform/qcom/venus/pm_helpers.c | 15 +++------------
>  3 files changed, 15 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/platform/qcom/venus/core.c
> index 6914fa991efb..f1762c725a11 100644
> --- a/drivers/media/platform/qcom/venus/core.c
> +++ b/drivers/media/platform/qcom/venus/core.c
> @@ -328,11 +328,16 @@ static int venus_probe(struct platform_device *pdev)
>  	if (ret)
>  		return ret;
>  
> -	for (i = 0; i < res->resets_num; i++) {
> -		core->resets[i] = devm_reset_control_get_exclusive(dev, res->resets[i]);
> -		if (IS_ERR(core->resets[i]))
> -			return PTR_ERR(core->resets[i]);
> -	}
> +	core->resets = devm_kcalloc(dev, res->resets_num, sizeof(*core->resets), GFP_KERNEL);
> +	if (res->resets_num && !core->resets)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < res->resets_num; i++)
> +		core->resets[i].id = res->resets[i];
> +
> +	ret = devm_reset_control_bulk_get_exclusive(dev, res->resets_num, core->resets);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to get resets\n");
>  
>  	ret = venus_get_resources(core);
>  	if (ret)
> diff --git a/drivers/media/platform/qcom/venus/core.h b/drivers/media/platform/qcom/venus/core.h
> index b4c41dc0f8c7..287bcf905057 100644
> --- a/drivers/media/platform/qcom/venus/core.h
> +++ b/drivers/media/platform/qcom/venus/core.h
> @@ -130,7 +130,7 @@ struct venus_format {
>   * @pmdomains:	a pointer to a list of pmdomains
>   * @opp_dl_venus: an device-link for device OPP
>   * @opp_pmdomain: an OPP power-domain
> - * @resets: an array of reset signals
> + * @resets: a reset_control_bulk_data array of hardware reset signals
>   * @vdev_dec:	a reference to video device structure for decoder instances
>   * @vdev_enc:	a reference to video device structure for encoder instances
>   * @v4l2_dev:	a holder for v4l2 device structure
> @@ -183,7 +183,7 @@ struct venus_core {
>  	struct dev_pm_domain_list *pmdomains;
>  	struct device_link *opp_dl_venus;
>  	struct device *opp_pmdomain;
> -	struct reset_control *resets[VIDC_RESETS_NUM_MAX];
> +	struct reset_control_bulk_data *resets;
>  	struct video_device *vdev_dec;
>  	struct video_device *vdev_enc;
>  	struct v4l2_device v4l2_dev;
> diff --git a/drivers/media/platform/qcom/venus/pm_helpers.c b/drivers/media/platform/qcom/venus/pm_helpers.c
> index 5d174b83926b..7690f66d1184 100644
> --- a/drivers/media/platform/qcom/venus/pm_helpers.c
> +++ b/drivers/media/platform/qcom/venus/pm_helpers.c
> @@ -865,21 +865,12 @@ void vcodec_domains_put(struct venus_core *core)
>  static int core_resets_reset(struct venus_core *core)
>  {
>  	const struct venus_resources *res = core->res;
> -	unsigned int i;
>  	int ret;
>  
> -	for (i = 0; i < res->resets_num; i++) {
> -		ret = reset_control_assert(core->resets[i]);
> -		if (ret)
> -			goto err;
> -
> -		usleep_range(150, 250);
> -		ret = reset_control_deassert(core->resets[i]);
> -		if (ret)
> -			goto err;
> -	}
> +	ret = reset_control_bulk_reset(res->resets_num, core->resets);
> +	if (ret)
> +		dev_err(core->dev, "Failed to toggle resets: %d\n", ret);
>  
> -err:
>  	return ret;
>  }
>  
> 
Reviewed-by: Dikshita Agarwal <quic_dikshita@quicinc.com>

