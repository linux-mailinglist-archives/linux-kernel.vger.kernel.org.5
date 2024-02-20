Return-Path: <linux-kernel+bounces-73568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF8FF85C44F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 20:09:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2C4A1C23A60
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 19:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5B6D13341C;
	Tue, 20 Feb 2024 19:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="nPhda2ek"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C5244C94
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 19:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708456177; cv=none; b=R9nnjMDKnfligfylivGZ0TNf9wfhuC+UTlOV67/0lfceizsy4iW9R/AomaKs9kxBkVTlva7l8yxBYSeSohvZwLpALkTLkH7pq+uCtZ3yQY9IeWfqh81RUDV0L4E97Anh08dizBF2aZpwpw9jgzWgKgz9zSDatB1NGA3BZuPaJZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708456177; c=relaxed/simple;
	bh=qrVV78qO61nyMK0GR2YYe1ZndubOOAh+IvIhMAvkwSw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=eZ3y+s2pbD5NDMXLlemtlKI1EYnPmDojVoQgcNcRAkXAws7vHAN/coHLyrl63Egxoan4LchEZ3eZN+AcUo0BcWDuMSKYjssOEV1Q9pqa3CS2XOPPW8v142SqqUwEx+eQXx8UctX5pvOwbVZ8skkha1uTgw2yVtO4pP2qUBi8VtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=nPhda2ek; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41KIqxGc006471;
	Tue, 20 Feb 2024 19:09:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=KwPoO44LDK/S2cPQf1Om3aK71Wu5Bk11+T3BTeQiEBM=; b=nP
	hda2ekRSBQF/iwJaD8xFQrIWPYQKeMvlDHMrE476j1J/v6xFGnRUilZBAWDrqisz
	1/b30H1kqm2wOv9c/+pFgtGtpRHQJmjuP56OIHkD2dCO8v7g0oLTn1gmb7XpDp3D
	E6l375el+ufFVA6dj5SavoWE4svA7KhCWgP1ErGe1sGDrrO4B6LFNNxA1VjIodYL
	FMQBqydl6GfN8RM8MteotwKTiFK0GI086vE0gqQF0X1E9tZcnYLPhmuXLKNoQnhs
	iMXSp52KBvUrTnpQ7yu06H6FIa0DwZ5lraf+n+tUusf3wpDquTCIfJdvRcb6daOq
	GFn3TB7Fsmonglo8LWFw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wcmqp9t9m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Feb 2024 19:09:25 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41KJ9Ond017797
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Feb 2024 19:09:24 GMT
Received: from [10.110.62.85] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 20 Feb
 2024 11:09:23 -0800
Message-ID: <b1f4856a-ee08-c1fc-2db0-e22773633bcb@quicinc.com>
Date: Tue, 20 Feb 2024 11:09:23 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] drm/dp: move intel_dp_vsc_sdp_pack() to generic helper
Content-Language: en-US
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: <dri-devel@lists.freedesktop.org>,
        Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Joonas Lahtinen
	<joonas.lahtinen@linux.intel.com>,
        Tvrtko Ursulin
	<tvrtko.ursulin@linux.intel.com>,
        <robdclark@gmail.com>, <freedreno@lists.freedesktop.org>,
        <intel-gfx@lists.freedesktop.org>, <ville.syrjala@linux.intel.com>,
        <quic_jesszhan@quicinc.com>, <linux-kernel@vger.kernel.org>,
        <intel-xe@lists.freedesktop.org>
References: <20240215190834.3222812-1-quic_abhinavk@quicinc.com>
 <CAA8EJppQquHgSgCrxKZHPHk248Pxg7Q8mvmmjbcpUxpreQkcuA@mail.gmail.com>
 <d3674c10-5c29-d917-44f5-758d90d9e679@quicinc.com>
 <CAA8EJpqaG+fBA_FO-L7Bimtjqqg3ZDQtyJL0oPFEueb-1WxjUw@mail.gmail.com>
From: Abhinav Kumar <quic_abhinavk@quicinc.com>
In-Reply-To: <CAA8EJpqaG+fBA_FO-L7Bimtjqqg3ZDQtyJL0oPFEueb-1WxjUw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: YfwYp2JcpgXC2_j8spxazpIqXQ8m34qE
X-Proofpoint-ORIG-GUID: YfwYp2JcpgXC2_j8spxazpIqXQ8m34qE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-20_06,2024-02-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 spamscore=0 mlxlogscore=315 adultscore=0 mlxscore=0 malwarescore=0
 priorityscore=1501 impostorscore=0 clxscore=1015 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402200138



On 2/20/2024 11:05 AM, Dmitry Baryshkov wrote:
> On Tue, 20 Feb 2024 at 20:53, Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
>>
>>
>>
>> On 2/20/2024 10:49 AM, Dmitry Baryshkov wrote:
>>> On Thu, 15 Feb 2024 at 21:08, Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
>>>>
>>>> intel_dp_vsc_sdp_pack() can be re-used by other DRM drivers as well.
>>>> Lets move this to drm_dp_helper to achieve this.
>>>>
>>>> changes in v2:
>>>>           - rebased on top of drm-tip
>>>>
>>>> Acked-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>>>
>>> v1 had an explicit comment before the ack:
>>>
>>
>> Yes, I remember the comment. I did not make any changes to v2 other than
>> just rebasing it on drm-tip to get the ack from i915 folks.
>>
>>>>      From my side, with the promise of the size fixup.
>>>
>>> However I observe neither a second patch removing the size argument
>>> nor it being dropped as a part of this patch.
>>>
>>
>> Yes, now that in v2 we got the ack for this patch, I can spin a v3 with
>> the addition of the next patch to remove the size OR as another series
>> so as to not block the main series which needs this patch.
>>
>> I would prefer the latter.
> 
> It doesn't work this way. The comment should have been fixed for v2.
> 

Ack, I can post a v3 now by adding the removal in patch 2 of this series.

> 
> 

