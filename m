Return-Path: <linux-kernel+bounces-133602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B720A89A643
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 23:43:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BD961F21ABD
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 21:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE23D4C74;
	Fri,  5 Apr 2024 21:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="am02KRi+"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A37175548
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 21:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712353398; cv=none; b=WJOL6WM3mLuRXQ30MxL0LYf9ViUTMz7FxzRbpUvu+70tip7cmml+aKz5i6mNk/itdd/lnDhbbP0xKqePVQc+KeCy1gEzW077aE5RqfcA9QPjm76UcpR5kq8niq5hmHoMLG63P6TuOFmilt+TzYMv0VSeR5XLP9g+OdGyXBTfhtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712353398; c=relaxed/simple;
	bh=7k/ylc+17Hjw/4zJ/zRh4X6dc/a817lzpAHoq0Y4w1Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ZUiKKfWwVGGB8yFcXyHYgOmKLNn/kiPWn+ezNkxvMXPJyBBkCS/sY+4fQuH+wNNtkc+3PEQKTPf9O63whpapl2Yv5PvPjYT+LV60UoWkpavowE2WnuNnGWxUSbeRv6xWn4no4ZlnbZsEWgo5DgidkXbo5pItnwgXEw6J90KLYM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=am02KRi+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 435LbM5b020139;
	Fri, 5 Apr 2024 21:42:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=YuuiR+RQPJyVoIjepBYrkuvRsZsSLh0GmO9Ed1j7vq0=; b=am
	02KRi+njP+X606LAEly7XjL3xQ7IO/wsTuKDla2/G7DK94aisqZhxLhf7ovcscqB
	LU0izX9sf0LK1dw+2vguduJuekcjsF1VIxJGlVCtzd7LcxTprb8KCjswEfCDio/I
	lg4hFawm33QQBQHGpe/OKBi2cUlKJyEh1c7gzTET2T1S/9uY75mIDeQL+0egRfsd
	6zQGbURcshpBq5yG0aBo4dsB6vkplYq6UIDj+ymWsnYWfuzdI7Hx8BlR6tK5CnKC
	jOLzxUXnp+Tf01mq2MZBx5Sv8qGfHeQySTtQ+mMJIbZheAT8dh6cOwOTBhtzGtaG
	eVtNcX95y0hxyF7jrJdQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xaaj1a333-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Apr 2024 21:42:28 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 435LgR26003029
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 5 Apr 2024 21:42:27 GMT
Received: from [10.110.71.75] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 5 Apr 2024
 14:42:26 -0700
Message-ID: <b67f530d-6128-44dc-aa93-60fc629c06c6@quicinc.com>
Date: Fri, 5 Apr 2024 14:42:25 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] drm/panel: visionox-rm69299: don't unregister DSI
 device
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
 <20240404-drop-panel-unregister-v1-1-9f56953c5fb9@linaro.org>
From: Jessica Zhang <quic_jesszhan@quicinc.com>
In-Reply-To: <20240404-drop-panel-unregister-v1-1-9f56953c5fb9@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: KkZvom-pySkCLQEs6pQaZznMgyU0JQGX
X-Proofpoint-GUID: KkZvom-pySkCLQEs6pQaZznMgyU0JQGX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-05_26,2024-04-05_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 impostorscore=0 bulkscore=0 clxscore=1011 lowpriorityscore=0
 mlxlogscore=999 suspectscore=0 malwarescore=0 spamscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404050155



On 4/4/2024 3:07 AM, Dmitry Baryshkov wrote:
> The DSI device for the panel was registered by the DSI host, so it is an
> error to unregister it from the panel driver. Drop the call to
> mipi_dsi_device_unregister().

Hi Dmitry,

Reviewed-by: Jessica Zhang <quic_jesszhan@quicinc.com>

Thanks,

Jessica Zhang

> 
> Fixes: c7f66d32dd43 ("drm/panel: add support for rm69299 visionox panel")
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>   drivers/gpu/drm/panel/panel-visionox-rm69299.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-visionox-rm69299.c b/drivers/gpu/drm/panel/panel-visionox-rm69299.c
> index 775144695283..b15ca56a09a7 100644
> --- a/drivers/gpu/drm/panel/panel-visionox-rm69299.c
> +++ b/drivers/gpu/drm/panel/panel-visionox-rm69299.c
> @@ -253,8 +253,6 @@ static void visionox_rm69299_remove(struct mipi_dsi_device *dsi)
>   	struct visionox_rm69299 *ctx = mipi_dsi_get_drvdata(dsi);
>   
>   	mipi_dsi_detach(ctx->dsi);
> -	mipi_dsi_device_unregister(ctx->dsi);
> -
>   	drm_panel_remove(&ctx->panel);
>   }
>   
> 
> -- 
> 2.39.2
> 

