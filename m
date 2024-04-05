Return-Path: <linux-kernel+bounces-133603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BEF089A648
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 23:44:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DA9F1C2165D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 21:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95D8517554D;
	Fri,  5 Apr 2024 21:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="fcOsco/l"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F371DA32
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 21:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712353470; cv=none; b=FNzRanMB1wGz+lTaV+6PjET9PmQhRsSal4CkGBoLRb0z/8Nrdp7HTFhWA7C9VbfjhaZVBiKodaz829ewWqLuQ2pTtsp7MLdv/KIkk9tjIwDvhZsSid70V0DAl9eCvK3DpX5Wtpc92iONBMrh6MhTB6Ya9CX0qMkW73UAkU6S07E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712353470; c=relaxed/simple;
	bh=VwUtSHE5K2hbSjDkxBhPMyHvodI0rBVLGkUu9QMlZ8M=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=GvzR+pvJ/YsroexmWqQGlbvxP8MgBiyhSbeYsOZNZgoKCy596u3/u3gMNasQ8Q7hkOAWhmmr7q6/W0VRAWi8FWYYbyyEdkRCOHeDyCuz54oXH438Xa9XWx8P0GashGLj0NTOeGh10nxfwRk9nEP3hTyxJkPoHhJ9uvqjEKoPMdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=fcOsco/l; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 435L0uwn018392;
	Fri, 5 Apr 2024 21:43:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=TIKqf+/mjzQE++LZKAfQ2rUXtVcdStL2Y6GyMNGqRI8=; b=fc
	Osco/lNvkY6OidF/l10oMq/2bzYr87JRZ5QClRwsOF0qMRXt4Fbz1ai4i80V+xNG
	n6kTky/7imsZnueu5JfZ1/Apo6xIAcuKe3rTW2TaZIByRFb3pbWuA8oSz0ssIBPC
	cEObCzwZzNHCJQRg+/DRgTQeDlpBTFc+eyPyes5cwsGKlu8+dCdY6XXwMgOxdGpF
	e8rxNuAwvoHSq0Et6V1/MXaZ5B3zTi7g+ax8plIEBp1SE1ksHvzFEjIQT6obj9/8
	xPNvC3Wo1QdFwtGQwIpJhtUXwFfqSNMTNLArTKyxPYNEUrLsT1bY+efbCCZoRi0t
	jB7abRAktHMD7Ot/48BQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xahgt1479-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Apr 2024 21:43:46 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 435LhivP032282
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 5 Apr 2024 21:43:44 GMT
Received: from [10.110.71.75] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 5 Apr 2024
 14:43:43 -0700
Message-ID: <d1368d46-5350-4455-ad72-418bad1dec09@quicinc.com>
Date: Fri, 5 Apr 2024 14:43:43 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] drm/panel: novatek-nt36682e: don't unregister DSI
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
 <20240404-drop-panel-unregister-v1-2-9f56953c5fb9@linaro.org>
From: Jessica Zhang <quic_jesszhan@quicinc.com>
In-Reply-To: <20240404-drop-panel-unregister-v1-2-9f56953c5fb9@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: nXJjY52e_EB-AGW9EaVj9oyjdD6YtJQt
X-Proofpoint-ORIG-GUID: nXJjY52e_EB-AGW9EaVj9oyjdD6YtJQt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-05_26,2024-04-05_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 clxscore=1015
 lowpriorityscore=0 suspectscore=0 mlxscore=0 malwarescore=0 phishscore=0
 impostorscore=0 adultscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404050155



On 4/4/2024 3:08 AM, Dmitry Baryshkov wrote:
> The DSI device for the panel was registered by the DSI host, so it is an
> error to unregister it from the panel driver. Drop the call to
> mipi_dsi_device_unregister().
> 
> Fixes: ea4f9975625a ("drm/panel: Add support for Novatek NT36672E panel driver")
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Reviewed-by: Jessica Zhang <quic_jesszhan@quicinc.com>

> ---
>   drivers/gpu/drm/panel/panel-novatek-nt36672e.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-novatek-nt36672e.c b/drivers/gpu/drm/panel/panel-novatek-nt36672e.c
> index cb7406d74466..c39fe0fc5d69 100644
> --- a/drivers/gpu/drm/panel/panel-novatek-nt36672e.c
> +++ b/drivers/gpu/drm/panel/panel-novatek-nt36672e.c
> @@ -614,8 +614,6 @@ static void nt36672e_panel_remove(struct mipi_dsi_device *dsi)
>   	struct nt36672e_panel *ctx = mipi_dsi_get_drvdata(dsi);
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

