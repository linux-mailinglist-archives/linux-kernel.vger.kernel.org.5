Return-Path: <linux-kernel+bounces-149248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 730568A8DBA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 23:21:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A43241C20B3E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 21:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 002BD4C619;
	Wed, 17 Apr 2024 21:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ZxSOuU9M"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56EA9262A3
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 21:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713388872; cv=none; b=GS4nOOhikIgy/TdEslA9FyaB0ynC4HCOqrsNKzrpyYu+NrjIYSOgLFSH3tgA2jx5jWd6qkK14pC99FWHWlEvATMzN3BHb9Do2Anu7lb07n3IB4UKmDwjCtr5bT6u8kKhLbLE3FvOEmoZHQGcd2shyhVsGsXLOvruwtd9d5W5rsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713388872; c=relaxed/simple;
	bh=ziWvNIRs5MK21vaVT8vHRJuh2HBjG2z5soqWpVvLPDE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ub8ry4ALYl3as8VwScCPiunc3DnL1D0ZIV2SGXsncQy+2nYi9VqEUCEd3+Gtx+llPWQR21rQ17BlVgOX7KT9UoL2QrtqzeTAdXRib8hgIOUl0DHGj32FXF/XytEG5eQBw+8q7m5ABXfPgQnhRd+yxGnZoXLfjAXCUGv+5/Qsujk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ZxSOuU9M; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43HKJkjh027275;
	Wed, 17 Apr 2024 21:20:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=2GZtLTSkn5P8Go1e017CsTki1su+ecSi7B1HZK8D7Ag=; b=Zx
	SOuU9MUT6Do9lgPChdz+op/Ov2gin+jA9cYSbOOLIkHaYFE0tgAvJanRzH28T3dK
	NO3ydQP/w6Fwf5flVgP15bZbyBczEnWJ16N48ywLo6P1hvrCD2W89ao4ZV8FlHNF
	Lwl5a877NHXQtqmbAXBjdUeFRPq10JOFkfNW4fW7O4OtcbTb0so7V9cqDJ1u4ZKb
	zN6PM1zp58eNp27yYnoXaZP9QpdmAa24i4xEZmRFNxCdvXVEZ44cF0+WVdwjYuRR
	jjMB6xIxUbyse3vPJxLgy7LCkhnsH1jSjZ9m+r7rp3KWi0CuHdI70zleahtStUDn
	gdWbqnkEJ/lHS4lOup+g==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xj9w5a79s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Apr 2024 21:20:33 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43HLKW9u001962
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Apr 2024 21:20:32 GMT
Received: from [10.71.108.229] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 17 Apr
 2024 14:20:31 -0700
Message-ID: <e89c5c19-7c8f-476b-a96a-a5bc330278ab@quicinc.com>
Date: Wed, 17 Apr 2024 14:20:31 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] drm/panel: novatek-nt36672e: stop calling
 regulator_set_load manually
Content-Language: en-US
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Neil Armstrong
	<neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard
	<mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie
	<airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Matthias Kaehlcke
	<mka@chromium.org>,
        Harigovindan P <harigovi@codeaurora.org>,
        Ritesh Kumar
	<quic_riteshk@quicinc.com>,
        Sumit Semwal <sumit.semwal@linaro.org>
CC: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
References: <20240404-drop-panel-unregister-v1-0-9f56953c5fb9@linaro.org>
 <20240404-drop-panel-unregister-v1-4-9f56953c5fb9@linaro.org>
From: Jessica Zhang <quic_jesszhan@quicinc.com>
In-Reply-To: <20240404-drop-panel-unregister-v1-4-9f56953c5fb9@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: sUN5mEQ1ForeJ8f8PSD1eri1RLzGU2nn
X-Proofpoint-GUID: sUN5mEQ1ForeJ8f8PSD1eri1RLzGU2nn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-17_18,2024-04-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 bulkscore=0 lowpriorityscore=0 mlxlogscore=999 priorityscore=1501
 spamscore=0 phishscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404170151



On 4/4/2024 3:08 AM, Dmitry Baryshkov wrote:
> Use .init_load_uA part of the bulk regulator API instead of calling
> register_set_load() manually.

Hi Dmitry,

Reviewed-by: Jessica Zhang <quic_jesszhan@quicinc.com>

Thanks,

Jessica Zhang

> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>   drivers/gpu/drm/panel/panel-novatek-nt36672e.c | 16 ++++------------
>   1 file changed, 4 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-novatek-nt36672e.c b/drivers/gpu/drm/panel/panel-novatek-nt36672e.c
> index 9a870b9b6765..20b7bfe4aa12 100644
> --- a/drivers/gpu/drm/panel/panel-novatek-nt36672e.c
> +++ b/drivers/gpu/drm/panel/panel-novatek-nt36672e.c
> @@ -343,17 +343,7 @@ static int nt36672e_1080x2408_60hz_init(struct mipi_dsi_device *dsi)
>   static int nt36672e_power_on(struct nt36672e_panel *ctx)
>   {
>   	struct mipi_dsi_device *dsi = ctx->dsi;
> -	int ret, i;
> -
> -	for (i = 0; i < ARRAY_SIZE(ctx->supplies); i++) {
> -		ret = regulator_set_load(ctx->supplies[i].consumer,
> -				regulator_enable_loads[i]);
> -		if (ret) {
> -			dev_err(&dsi->dev, "regulator set load failed for supply %s: %d\n",
> -				ctx->supplies[i].supply, ret);
> -			return ret;
> -		}
> -	}
> +	int ret;
>   
>   	ret = regulator_bulk_enable(ARRAY_SIZE(ctx->supplies), ctx->supplies);
>   	if (ret < 0) {
> @@ -550,8 +540,10 @@ static int nt36672e_panel_probe(struct mipi_dsi_device *dsi)
>   		return -ENODEV;
>   	}
>   
> -	for (i = 0; i < ARRAY_SIZE(ctx->supplies); i++)
> +	for (i = 0; i < ARRAY_SIZE(ctx->supplies); i++) {
>   		ctx->supplies[i].supply = regulator_names[i];
> +		ctx->supplies[i].init_load_uA = regulator_enable_loads[i];
> +	}
>   
>   	ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(ctx->supplies),
>   			ctx->supplies);
> 
> -- 
> 2.39.2
> 

