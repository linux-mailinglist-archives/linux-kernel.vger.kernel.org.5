Return-Path: <linux-kernel+bounces-103836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E6E787C527
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 23:32:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FE6B1C21439
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 22:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0DEE1A38C9;
	Thu, 14 Mar 2024 22:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="lIVMO9vp"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7634C621
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 22:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710455560; cv=none; b=fDzIRoC191LI5q2CPQQ9dQZcTdUO+xNdijbRlq9oTusapIbeg5P5QZ6ZTIa8P8Hoi9vDah/01CMZX1QaxuWn+QlqkksJJO+LZGzWJ3GPZ7nwdoUYlt17eASB9cmrzCoQBprBpxy+bu0brI/UdEqXqjiGeq83UWkkEfGbkw9JLGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710455560; c=relaxed/simple;
	bh=X1NneLlmlLSB9XExkoogVf8XUmG48TCcq1cJRTrVBU4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=XxP5q5rvrOHrQT/IZ4w+zvTaj2Vj6MgX9HgGSRfuyqggns01278SL+9ckCv64k0VKNVNuWWzMfaM8txcUSuAwF5hLaPWid4Wu/I7OP0X4txNW2prZ+uMGFCDTNRUkGpXT8wl9xAhsqMfrkSS6vAGcZiaLLB//XqyF/JsZERsBzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=lIVMO9vp; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42EMTXbL031216;
	Thu, 14 Mar 2024 22:32:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=xXmOIatxQkgeH0JVMzaUkHFvtLBrY6AwQXmd7Zq9mJc=; b=lI
	VMO9vpcT57ZfiDeOAchKOx+K//SS8L/EOI+sYJLmUiLFqRIVekpBi7WysZI/nNg7
	W5mJNyupDVeo3LLtjOsIXtaMVhaMyArK/rih9ONqXIixmnpWu41i+FFroSYfuxGG
	JZ4nlZmqsYBAvts2Jby96m9X3DfJPstiaOtRKxpyeO4xHDeOKThlI7uPSE8ev+Ee
	hkoqRYRbhmNQhzYPnxeGZZVjw/r5GuFyGr2JdwBEqOj75ExAfvjxx+bBU7nlDknw
	zSdft17ZRTTAdptTbXT8iBj7BqzmcOwnTtjk/Q5XC/EUdzk/OMEYj8CVDS0PHQqf
	gKlEJ7NvNYDZbeT/0m0g==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wv9yq80d5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Mar 2024 22:32:22 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42EMWLk2018704
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Mar 2024 22:32:21 GMT
Received: from [10.110.97.122] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 14 Mar
 2024 15:32:20 -0700
Message-ID: <098d8dda-75fe-45b8-ad36-a21ed44c4555@quicinc.com>
Date: Thu, 14 Mar 2024 15:32:09 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/panel: atna33xc20: Fix unbalanced regulator in the
 case HPD doesn't assert
To: <dianders@chromium.org>, Neil Armstrong <neil.armstrong@linaro.org>,
        Sam
 Ravnborg <sam@ravnborg.org>,
        Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Dmitry Baryshkov
	<dmitry.baryshkov@linaro.org>
CC: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
References: <20240313-homestarpanel-regulator-v1-1-b8e3a336da12@chromium.org>
Content-Language: en-US
From: Jessica Zhang <quic_jesszhan@quicinc.com>
In-Reply-To: <20240313-homestarpanel-regulator-v1-1-b8e3a336da12@chromium.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: o0F9G-x63Byz-ivtQ01d98rMZ7Qd31e3
X-Proofpoint-GUID: o0F9G-x63Byz-ivtQ01d98rMZ7Qd31e3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-14_13,2024-03-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 phishscore=0 priorityscore=1501 mlxscore=0 spamscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 clxscore=1015 mlxlogscore=999
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403140001 definitions=main-2403140173



On 3/13/2024 2:12 PM, Douglas Anderson via B4 Relay wrote:
> From: Douglas Anderson <dianders@chromium.org>
> 
> When the atna33xc20 driver was first written the resume code never
> returned an error. If there was a problem waiting for HPD it just
> printed a warning and moved on. This changed in response to review
> feedback [1] on a future patch but I accidentally didn't account for
> rolling back the regulator enable in the error cases. Do so now.
> 
> [1] https://lore.kernel.org/all/5f3cf3a6-1cc2-63e4-f76b-4ee686764705@linaro.org/
> 
> Fixes: 3b5765df375c ("drm/panel: atna33xc20: Take advantage of wait_hpd_asserted() in struct drm_dp_aux")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
>   drivers/gpu/drm/panel/panel-samsung-atna33xc20.c | 22 +++++++++++++---------
>   1 file changed, 13 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-samsung-atna33xc20.c b/drivers/gpu/drm/panel/panel-samsung-atna33xc20.c
> index 76c2a8f6718c..9c336c71562b 100644
> --- a/drivers/gpu/drm/panel/panel-samsung-atna33xc20.c
> +++ b/drivers/gpu/drm/panel/panel-samsung-atna33xc20.c
> @@ -109,19 +109,17 @@ static int atana33xc20_resume(struct device *dev)
>   		if (hpd_asserted < 0)
>   			ret = hpd_asserted;
>   
> -		if (ret)
> +		if (ret) {
>   			dev_warn(dev, "Error waiting for HPD GPIO: %d\n", ret);
> -
> -		return ret;
> -	}
> -
> -	if (p->aux->wait_hpd_asserted) {
> +			goto error;
> +		}
> +	} else if (p->aux->wait_hpd_asserted) {

Hi Doug,

Acked-by: Jessica Zhang <quic_jesszhan@quicinc.com>

Thanks,

Jessica Zhang

>   		ret = p->aux->wait_hpd_asserted(p->aux, HPD_MAX_US);
>   
> -		if (ret)
> +		if (ret) {
>   			dev_warn(dev, "Controller error waiting for HPD: %d\n", ret);
> -
> -		return ret;
> +			goto error;
> +		}
>   	}
>   
>   	/*
> @@ -133,6 +131,12 @@ static int atana33xc20_resume(struct device *dev)
>   	 * right times.
>   	 */
>   	return 0;
> +
> +error:
> +	drm_dp_dpcd_set_powered(p->aux, false);
> +	regulator_disable(p->supply);
> +
> +	return ret;
>   }
>   
>   static int atana33xc20_disable(struct drm_panel *panel)
> 
> ---
> base-commit: b33651a5c98dbd5a919219d8c129d0674ef74299
> change-id: 20240311-homestarpanel-regulator-f4b890ff4b7c
> 
> Best regards,
> -- 
> Douglas Anderson <dianders@chromium.org>
> 

