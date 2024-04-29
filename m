Return-Path: <linux-kernel+bounces-163125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82A438B660B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 01:11:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3F3D1C21652
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 23:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADE2982D90;
	Mon, 29 Apr 2024 23:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="PJHZ93X5"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54DC06FE39
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 23:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714432268; cv=none; b=BcnKIk3aqhPUsPzMDuXOXetdGUGJTlOt2ObAk+WUkhpwpKIuBiIwnacPpseu9cVhmjKrvtn9m/NqgCCnH39RdUPHSl7Zhoyz6qfOLu405G51gtVNZqE8bzFVaSw6D0RaURAC01ZlXpz2yBwvRgzLQKhwxGHBrSsiWBNohX3gLHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714432268; c=relaxed/simple;
	bh=Iad/sxvyEw3VxQlZ783ao5OF0QpwmdVI6P36y5MsTmQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=En+uPVKnS+dtcqQHJNzhjm9xsarWsZXD14DTFbzyDQQV4Pbud98ROA3CoYx6NCb5SW6ZqiMvG8T8QvZV8ZxGJEnwhaUpWnx1AvmR0Grzv+hTTJTKxUshUW8bvifkO4Rit9VNv4htjz0EnB3emfX2cEzmj8pHdY7cO7DS4XodIMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=PJHZ93X5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43TMDXn6012500;
	Mon, 29 Apr 2024 23:10:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=/iGrcEbU4mTTV/EfBj25+RbJHkCM05W+8/SkVzibSAk=; b=PJ
	HZ93X5HM+lfsu0N18u3oW0M0ouK5FxdpATo2xSgaA/CYIXlIPft/XbdUVJKiwNGc
	ike0M0SUE1aUQ0XmWUp2OeyT1bUTDXKYRSY6zeFKpzHU9bVloLnJ1KYROjLvQG0q
	ze2lqaPN7dsQ9lfOtAlFfftjEPGZ02FrOYU6V5K/Sg1owTMBDpKLQGS/qfbIqGIm
	2j/VJgDr+kTK78wRC7Iiz7/tY3xT2H9Q/tzc7ib2WeLLc0k4NIOSjfLtnHc2fg1B
	WdXZAeviK0apQS4zL19701i5GGw7Nwdzcgu5yrGiby91C6VZ9i+vgzPJ7/gcGhkv
	EEvaSmjAPm494a029WjQ==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xt8jm3qke-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Apr 2024 23:10:51 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43TNAoih021278
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Apr 2024 23:10:50 GMT
Received: from [10.71.108.229] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 29 Apr
 2024 16:10:50 -0700
Message-ID: <86b768d8-19e8-4f87-a250-b428bf78f756@quicinc.com>
Date: Mon, 29 Apr 2024 16:10:26 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/panel: ili9341: Remove a superfluous else after
 return
To: Sui Jingfeng <sui.jingfeng@linux.dev>,
        Neil Armstrong
	<neil.armstrong@linaro.org>
CC: Sam Ravnborg <sam@ravnborg.org>,
        Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
References: <20240429171218.708910-1-sui.jingfeng@linux.dev>
Content-Language: en-US
From: Jessica Zhang <quic_jesszhan@quicinc.com>
In-Reply-To: <20240429171218.708910-1-sui.jingfeng@linux.dev>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: wctaOuyARbRbTh91aLH7BFf4Xl0MWpJ4
X-Proofpoint-ORIG-GUID: wctaOuyARbRbTh91aLH7BFf4Xl0MWpJ4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-29_20,2024-04-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 impostorscore=0
 phishscore=0 priorityscore=1501 mlxscore=0 adultscore=0 malwarescore=0
 mlxlogscore=999 spamscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404290153



On 4/29/2024 10:12 AM, Sui Jingfeng wrote:
> The else clause after the ruturn clause is not useful.

Hi Sui,

Spelling nit: ruturn --> return

Besides that,

Reviewed-by: Jessica Zhang <quic_jesszhan@quicinc.com>

Thanks,

Jessica Zhang

> 
> Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>
> ---
>   drivers/gpu/drm/panel/panel-ilitek-ili9341.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-ilitek-ili9341.c b/drivers/gpu/drm/panel/panel-ilitek-ili9341.c
> index 3574681891e8..433572c4caf9 100644
> --- a/drivers/gpu/drm/panel/panel-ilitek-ili9341.c
> +++ b/drivers/gpu/drm/panel/panel-ilitek-ili9341.c
> @@ -722,7 +722,8 @@ static int ili9341_probe(struct spi_device *spi)
>   
>   	if (!strcmp(id->name, "sf-tc240t-9370-t"))
>   		return ili9341_dpi_probe(spi, dc, reset);
> -	else if (!strcmp(id->name, "yx240qv29"))
> +
> +	if (!strcmp(id->name, "yx240qv29"))
>   		return ili9341_dbi_probe(spi, dc, reset);
>   
>   	return -1;
> -- 
> 2.34.1
> 

