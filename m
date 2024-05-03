Return-Path: <linux-kernel+bounces-168373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F23BA8BB7AB
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 00:42:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD9282894D4
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 22:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3474F84A22;
	Fri,  3 May 2024 22:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ZmAhSACs"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2AB2C684;
	Fri,  3 May 2024 22:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714775938; cv=none; b=ormzEf/4QU9eJEAyn9GOx7AzKE6vU8y3AX8l2qsWTuOcYPE3ixsJFUEgNpGlIjPVLOkVAfrABbcl5LjMF0x0ZsLT9dhsVKkGG+7QqIrSeF/TYGFW1dtLoVE8SIgm6eLqp/k8rAEo252nf3HO0YeqS61n3i2z0KhbQ157u3SIGG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714775938; c=relaxed/simple;
	bh=SM9kYn7TNaYtIgIW4dTtS96tqMgkyYWOqgZTw1Kw9S8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=IFrDtbMYhCZnD9SlL5R+ZTAKIY9YN5F58DAt/+yfNHCxdx6vykSetZc+glPsGIE1ZKEW1E9BWv2xTwicxD7sK/wDd8owlNbV0P+nug3QmkySkvCWt+QLpBuOU0LH6mlAVWS2BAdY29O7nlxh0kJ4gC6GOTLAOOGkK320OqtwL8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ZmAhSACs; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 443LNWRh020078;
	Fri, 3 May 2024 22:38:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=urnXA00algNWY4sZig1/JWwNFY3hO76XDLqsf9MC3bE=; b=Zm
	AhSACs0y5sI5/mfNnvkifc1xLlUywujp2TTczjo1qapAfjws9dv5Smr/bJYOgL/a
	f3OYu5ekBvmX/bJOGb90K2bKdnqrM6ZCS94BjVuZa3ebVj5NRAVw9U6e2m5ROGjn
	GCbGbBNS5Rck0F5tnArbksG5rvNakGMEauflI+hQZ/TFc9xJxhghTZJrCg6o4YFw
	+QfqwEi9t4pm1NNiCZOqoO4aFlx4zMPLdzaWlkbkzj4cy+9mjmjph0gotYL5xCSr
	Ao+N5T7DN/0iFlT/ZtfDRWGPRnZC9nfniNONBs/WhhC10BYm34/GDHW3eY61NIKU
	THKJTCR765/UCmX6EoOA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xvwfa9j3e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 03 May 2024 22:38:41 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 443Mce6T028489
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 3 May 2024 22:38:40 GMT
Received: from [10.110.114.34] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 3 May 2024
 15:38:39 -0700
Message-ID: <24fb0b07-af03-1341-d98c-46f4f167fbbb@quicinc.com>
Date: Fri, 3 May 2024 15:38:38 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 2/2] drm/ci: validate drm/msm XML register files
 against schema
Content-Language: en-US
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Marijn
 Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Helen Koike <helen.koike@collabora.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard
	<mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        <linux-arm-msm@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <freedreno@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
References: <20240503-fd-fix-lxml-v2-0-f80a60ce21a1@linaro.org>
 <20240503-fd-fix-lxml-v2-2-f80a60ce21a1@linaro.org>
 <69b593b7-109c-825f-3dbb-5e8cce63ff01@quicinc.com>
 <CAA8EJpp4x+NEpMAGtgOmu-0NY8ycTu0iQX6-1Vv76mkKPea_Cw@mail.gmail.com>
From: Abhinav Kumar <quic_abhinavk@quicinc.com>
In-Reply-To: <CAA8EJpp4x+NEpMAGtgOmu-0NY8ycTu0iQX6-1Vv76mkKPea_Cw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 5O7mhWqJWY2GtAgNP9TNe07xL1XgU3Z8
X-Proofpoint-ORIG-GUID: 5O7mhWqJWY2GtAgNP9TNe07xL1XgU3Z8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-03_15,2024-05-03_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 clxscore=1015 mlxscore=0 suspectscore=0 phishscore=0
 spamscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2404010003 definitions=main-2405030161



On 5/3/2024 1:20 PM, Dmitry Baryshkov wrote:
> On Fri, 3 May 2024 at 22:42, Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
>>
>>
>>
>> On 5/3/2024 11:15 AM, Dmitry Baryshkov wrote:
>>> In order to validate drm/msm register definition files against schema,
>>> reuse the nodebugfs build step. The validation entry is guarded by
>>> the EXPERT Kconfig option and we don't want to enable that option for
>>> all the builds.
>>>
>>> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>>> ---
>>>    drivers/gpu/drm/ci/build.sh  | 3 +++
>>>    drivers/gpu/drm/ci/build.yml | 1 +
>>>    2 files changed, 4 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/ci/build.sh b/drivers/gpu/drm/ci/build.sh
>>> index 106f2d40d222..28a495c0c39c 100644
>>> --- a/drivers/gpu/drm/ci/build.sh
>>> +++ b/drivers/gpu/drm/ci/build.sh
>>> @@ -12,6 +12,9 @@ rm -rf .git/rebase-apply
>>>    apt-get update
>>>    apt-get install -y libssl-dev
>>>
>>> +# for msm header validation
>>> +apt-get install -y python3-lxml
>>> +
>>>    if [[ "$KERNEL_ARCH" = "arm64" ]]; then
>>>        GCC_ARCH="aarch64-linux-gnu"
>>>        DEBIAN_ARCH="arm64"
>>> diff --git a/drivers/gpu/drm/ci/build.yml b/drivers/gpu/drm/ci/build.yml
>>> index 17ab38304885..9c198239033d 100644
>>> --- a/drivers/gpu/drm/ci/build.yml
>>> +++ b/drivers/gpu/drm/ci/build.yml
>>> @@ -106,6 +106,7 @@ build-nodebugfs:arm64:
>>>      extends: .build:arm64
>>>      variables:
>>>        DISABLE_KCONFIGS: "DEBUG_FS"
>>> +    ENABLE_KCONFIGS: "EXPERT DRM_MSM_VALIDATE_XML"
>>>
>>
>> Wouldnt this end up enabling DRM_MSM_VALIDATE_XML for any arm64 device.
>>
>> Cant we make this build rule msm specific?
> 
> No need to. We just need to validate the files at least once during
> the whole pipeline build.
>

ah okay, today the arm64 config anyway sets all arm64 vendor drm configs 
to y.

A couple of more questions:

1) Why is this enabled only for no-debugfs option?
2) Will there be any concerns from other vendors to enable CONFIG_EXPERT 
in their CI runs as the arm64 config is shared across all arm64 vendors.

