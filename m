Return-Path: <linux-kernel+bounces-135722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7322689CA4B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 19:05:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B02B286FB7
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 17:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8117142E9C;
	Mon,  8 Apr 2024 17:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="OnbJIjKk"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EEA563CB;
	Mon,  8 Apr 2024 17:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712595896; cv=none; b=ASstNHDoBf0IovBLXFrDElk2LSKL6tCaiVKiwDdvoGC4kF5bFSC8jhZskOIcAklfY0h2vDOAMBjFq8MP6myVJeR+NSXR/GXOmcscXXJi5tdlNj3+rmAhsOoX6niuj2stuGiclutecdow00ymsvVseeqP9RYgQQkyFLIrvhfshPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712595896; c=relaxed/simple;
	bh=jQt5fWtSrqnw4LOaCGG5paCwu/qrUWYQYYfyTEi/y2E=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=AC9ZetiDs2Q29gffaTvU8PNKKQsJO5egrt0OtrOOK9tZ+neaJ6y0jxB15xsvPptMATm2yypWJfO8J2Vr3B25qyxv3nQhfTlLK81M/IeqoQwhXlabkYYJA2vwYI6vd8w1lfjxl9g7xculA+V2hDn924+lVLzhkeOkf7wk6JBJ1Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=OnbJIjKk; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 438DAS0Y011633;
	Mon, 8 Apr 2024 17:04:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=EmbZsgRQtI3hnTKgTCh06rmHUQcq9Po3Jvk5u93mytY=; b=On
	bJIjKk0SI8N3F5JO0W8urZBf4WE0I20BtlJXPrHS3F3AtvppJ4waFNdDOw1CcTRF
	CT0BVRp/LsGoJVIWpeZKbQ1PsFwq6MaNSqYIpfWH/sLhfUVLMdhEqiEExZsQ9apZ
	eU8Vz+L7sz8gPb9OjHn9/Ezhyl37/xhfOT5GmaeXRENDzN7Oe8HvBTY1XYpwsM2K
	TznhgirloF6wfu2rnD8C4Y1Z9vRpGJUOpAWvAZt+uQxJzpLiZDeHWZ4Gx7UutdX1
	GZ6lhaf+m+pEFxEUM01HoQjr0I4o1dwNkhQVQTW1hSwexV71krOmNPP6lvescENs
	3md7dUYvv7miV3Ndtx6Q==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xcbg09f6v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Apr 2024 17:04:39 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 438H4cMi005779
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 8 Apr 2024 17:04:38 GMT
Received: from [10.71.109.81] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 8 Apr 2024
 10:04:37 -0700
Message-ID: <357b6395-5fae-38c9-8b53-5edc9fcbae32@quicinc.com>
Date: Mon, 8 Apr 2024 10:04:36 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm: ci: fix the xfails for apq8016
Content-Language: en-US
To: Rob Clark <robdclark@gmail.com>,
        Dmitry Baryshkov
	<dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten
	<marijn.suijten@somainline.org>,
        Helen Koike <helen.koike@collabora.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard
	<mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie
	<airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
CC: <linux-arm-msm@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <freedreno@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
References: <20240401204859.24223-1-quic_abhinavk@quicinc.com>
From: Abhinav Kumar <quic_abhinavk@quicinc.com>
In-Reply-To: <20240401204859.24223-1-quic_abhinavk@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: TpNA7rz0y7aZAhQo4BnaZdP1GOu3ECmr
X-Proofpoint-ORIG-GUID: TpNA7rz0y7aZAhQo4BnaZdP1GOu3ECmr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-08_15,2024-04-05_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 mlxlogscore=999 clxscore=1015 spamscore=0 impostorscore=0
 adultscore=0 suspectscore=0 lowpriorityscore=0 mlxscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404080131

Hi Helen

Gentle reminder on this.

If you are okay, we can land it via msm-next tree...

Thanks

Abhinav

On 4/1/2024 1:48 PM, Abhinav Kumar wrote:
> After IGT migrating to dynamic sub-tests, the pipe prefixes
> in the expected fails list are incorrect. Lets drop those
> to accurately match the expected fails.
> 
> In addition, update the xfails list to match the current passing
> list. This should have ideally failed in the CI run because some
> tests were marked as fail even though they passed but due to the
> mismatch in test names, the matching didn't correctly work and was
> resulting in those failures not being seen.
> 
> Here is the passing pipeline for apq8016 with this change:
> 
> https://gitlab.freedesktop.org/drm/msm/-/jobs/57050562
> 
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> ---
>   drivers/gpu/drm/ci/xfails/msm-apq8016-fails.txt | 13 +------------
>   1 file changed, 1 insertion(+), 12 deletions(-)
> 
> diff --git a/drivers/gpu/drm/ci/xfails/msm-apq8016-fails.txt b/drivers/gpu/drm/ci/xfails/msm-apq8016-fails.txt
> index 44a5c62dedad..b14d4e884971 100644
> --- a/drivers/gpu/drm/ci/xfails/msm-apq8016-fails.txt
> +++ b/drivers/gpu/drm/ci/xfails/msm-apq8016-fails.txt
> @@ -1,17 +1,6 @@
>   kms_3d,Fail
>   kms_addfb_basic@addfb25-bad-modifier,Fail
> -kms_cursor_legacy@all-pipes-forked-bo,Fail
> -kms_cursor_legacy@all-pipes-forked-move,Fail
> -kms_cursor_legacy@all-pipes-single-bo,Fail
> -kms_cursor_legacy@all-pipes-single-move,Fail
> -kms_cursor_legacy@all-pipes-torture-bo,Fail
> -kms_cursor_legacy@all-pipes-torture-move,Fail
> -kms_cursor_legacy@pipe-A-forked-bo,Fail
> -kms_cursor_legacy@pipe-A-forked-move,Fail
> -kms_cursor_legacy@pipe-A-single-bo,Fail
> -kms_cursor_legacy@pipe-A-single-move,Fail
> -kms_cursor_legacy@pipe-A-torture-bo,Fail
> -kms_cursor_legacy@pipe-A-torture-move,Fail
> +kms_cursor_legacy@torture-bo,Fail
>   kms_force_connector_basic@force-edid,Fail
>   kms_hdmi_inject@inject-4k,Fail
>   kms_selftest@drm_format,Timeout

