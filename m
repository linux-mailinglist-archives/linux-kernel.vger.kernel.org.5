Return-Path: <linux-kernel+bounces-75863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56A0085EFFC
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 04:41:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91C7E1C21EF2
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 03:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 546DD17573;
	Thu, 22 Feb 2024 03:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="eO52uUaY"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112F328EF;
	Thu, 22 Feb 2024 03:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708573255; cv=none; b=bpHn0yZEmeJXtfh11BYvb2GnaeEMu2PfkjfC2mWaphKeHQtu33M+EE8qnNyyIfijipem0b2MW8HfPCEoJ0/UfSUfHi1AP8Y0yjsDZkxZnWVZB6nkHGelDqePKUD+me9Kos2/0xYoxjyi16ec3bUfymIF1K+wvRI88El+6zNrEUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708573255; c=relaxed/simple;
	bh=H1D9PDnVVG40/hjTEiTfCsbHBqVee9qL3NCQwHhswqI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sjZ4j+9fDZyWiyCUEZrVKgvfy0fjvVoPEIxbeKBB27HpT3x0yQnVTv/gUJHp1JeOm2tOkDqkI44xjGW/LFGj7BdEAumK/Bp2w0fPXFqSq459kWWvjqP4pWUUswru/mDT8KMT/q/bX6Qqccq8JP93uQoY5QcuWX2Ruf5P3h/7vEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=eO52uUaY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41M1tnR2015354;
	Thu, 22 Feb 2024 03:40:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=qcppdkim1; bh=Ds2yZ/R7d+RJNs02PAlJC
	WH5zE4c0b1LVXuVtLmrDDY=; b=eO52uUaYx4Y8uQ8BsYzqGugmFo9cihMcFgvg1
	zLl3F2+Z6x69+KyYofIc9HUSSupDJaoadJE3tjfzS66CUucvHQp4uH45Q0tWmtRG
	FXYnsV5aZZdEiRAgDM3SQ2OyAFNfd0ZdJbYMem87T6k9Fd+cl7FRaLEwB3tEym/y
	2B92LyQ+wVrB8SfJj+Y9LyjlhbCRP5Dr8dQpRcIEINiTkgnunG/wt64tcwyZFcg1
	2ssM0tcfirzIsgLCZL9EBAziVge55MrAuxG5bvbA94mg+WcsKeRTBShyv0auFJ6b
	gYqzb06JQcxxQ1Aisg6VClR01TLUEoCQbIYOGtsh8lIjtzrPA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wdw13866p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Feb 2024 03:40:41 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41M3ed73030760
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Feb 2024 03:40:40 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 21 Feb 2024 19:40:39 -0800
Date: Wed, 21 Feb 2024 19:40:38 -0800
From: Bjorn Andersson <quic_bjorande@quicinc.com>
To: Abel Vesa <abel.vesa@linaro.org>
CC: Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar
	<quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard
	<mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Johan Hovold <johan@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>, <freedreno@lists.freedesktop.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC 3/3] drm/msm/dp: Add support for the X1E80100
Message-ID: <20240222034038.GC2273464@hu-bjorande-lv.qualcomm.com>
References: <20240221-x1e80100-display-refactor-connector-v1-0-86c0e1ebd5ec@linaro.org>
 <20240221-x1e80100-display-refactor-connector-v1-3-86c0e1ebd5ec@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240221-x1e80100-display-refactor-connector-v1-3-86c0e1ebd5ec@linaro.org>
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ujOmDQbP3bxRMRsHhIRF5eLpgclOwkFe
X-Proofpoint-GUID: ujOmDQbP3bxRMRsHhIRF5eLpgclOwkFe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_01,2024-02-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 malwarescore=0 impostorscore=0 bulkscore=0 adultscore=0 mlxscore=0
 clxscore=1015 lowpriorityscore=0 spamscore=0 priorityscore=1501
 phishscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2402120000 definitions=main-2402220026

On Wed, Feb 21, 2024 at 12:50:33AM +0200, Abel Vesa wrote:
> Add the X1E80100 DP descs and compatible. This platform will be using
> a single compatible for both eDP and DP mode. The actual mode will
> be set in devicetree via is-edp flag.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>  drivers/gpu/drm/msm/dp/dp_display.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> index 9e58285d4ec6..7b8c695d521a 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -171,6 +171,14 @@ static const struct msm_dp_desc sm8650_dp_descs[] = {
>  	{}
>  };
>  
> +static const struct msm_dp_desc x1e80100_dp_descs[] = {
> +	{ .io_start = 0x0ae90000, .id = MSM_DP_CONTROLLER_0, .wide_bus_en = true },
> +	{ .io_start = 0x0ae98000, .id = MSM_DP_CONTROLLER_1, .wide_bus_en = true },
> +	{ .io_start = 0x0ae9a000, .id = MSM_DP_CONTROLLER_2, .wide_bus_en = true },
> +	{ .io_start = 0x0aea0000, .id = MSM_DP_CONTROLLER_3, .wide_bus_en = true },
> +	{}
> +};
> +
>  static const struct of_device_id dp_dt_match[] = {
>  	{ .compatible = "qcom,sc7180-dp", .data = &sc7180_dp_descs },
>  	{ .compatible = "qcom,sc7280-dp", .data = &sc7280_dp_descs },
> @@ -179,6 +187,7 @@ static const struct of_device_id dp_dt_match[] = {
>  	{ .compatible = "qcom,sc8180x-edp", .data = &sc8180x_dp_descs },
>  	{ .compatible = "qcom,sc8280xp-dp", .data = &sc8280xp_dp_descs },
>  	{ .compatible = "qcom,sc8280xp-edp", .data = &sc8280xp_edp_descs },
> +	{ .compatible = "qcom,x1e80100-dp", .data = &x1e80100_dp_descs },

This doesn't look like alphabetical order.

Regards,
Bjorn

>  	{ .compatible = "qcom,sdm845-dp", .data = &sc7180_dp_descs },
>  	{ .compatible = "qcom,sm8350-dp", .data = &sm8350_dp_descs },
>  	{ .compatible = "qcom,sm8650-dp", .data = &sm8650_dp_descs },
> 
> -- 
> 2.34.1
> 

