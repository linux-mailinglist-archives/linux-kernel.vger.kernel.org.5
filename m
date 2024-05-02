Return-Path: <linux-kernel+bounces-167008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F1B8BA358
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 00:35:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83FE91F215F9
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 22:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2674E1BDDC;
	Thu,  2 May 2024 22:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ddB7Siqq"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3181B810
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 22:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714689300; cv=none; b=B2PrLdlfeO39umfqEyGIkmCW2CZh/+OgjZMHwIRHMQkN3IjKkG0SRtcTeS2k11SF1ERPUHDBEHRdcGzmW/aCdklbzPdTaTERUfFr4u9+u+juisCZsRbfu3fRDEFNfTT4ZfDnM3OxOxLOYeQvD/L4VJ8pi9eJ5+VMCIQnag52ybE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714689300; c=relaxed/simple;
	bh=qYjEdTjPlvdW+bE0tWfe8UYgo1CKVUHPiUbNzXxgMWo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=TnJLnZM0yOOiKd6tgpyIstQpC0XCWqUoJSHJnxtF1QfdO/STJqecdBpWGymeBpfTdrgAcgYkaQMGUFWB2mZrCQPsaIGf/b6fL4kexFeHv31PFGt335EVpWM6lZ6wzcU+KJcuddhPBThkQmh+e5nRth/1FqjB4PtbsadrJCRCcPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ddB7Siqq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 442MPonY022108;
	Thu, 2 May 2024 22:34:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=fRfLcMY0AJGwjaEuJZ8otI1nmXNpuNBsc8ugjVTNQt8=; b=dd
	B7SiqqemjgKfQ3hTAJoaprgjTdJ0F2zU/c/Pe5YkwoOmkjJtmn4eweehwYRZ2FbP
	5IrsuRRh/zbcDViN3ACCYmPvAGh6pcOUyqPAq78BxZ/HGGnU7QidEut84/CBBDVt
	V70Y0C7t6BaGwL8EyS+m6ExEkNFU4r1LdhBtPnzMHKFmE4NcE/KHDnoov3EkOY7u
	sJZW73X7yg2cbakukU/WbJuNYrWWNKHo+wIdAJPOiI8rGvzICdbISjkBmfctk3ji
	c+Oh0lttZopeTYvvWas1etIOQjge2Mw/vaoRNsd3KbIdBk3KeY20reZRaWkI+Zfx
	PvAtfMogLhSzw5+rrezg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xv01ttcrn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 May 2024 22:34:43 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 442MYgLd023640
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 2 May 2024 22:34:42 GMT
Received: from [10.110.114.34] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 2 May 2024
 15:34:41 -0700
Message-ID: <6ca4c345-cc67-2e98-48eb-6379a9ba7579@quicinc.com>
Date: Thu, 2 May 2024 15:34:40 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/connector: Add \n to message about demoting connector
 force-probes
Content-Language: en-US
To: Douglas Anderson <dianders@chromium.org>,
        <dri-devel@lists.freedesktop.org>
CC: Rob Clark <robdclark@chromium.org>, Daniel Vetter <daniel@ffwll.ch>,
        David
 Airlie <airlied@gmail.com>,
        Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Pekka Paalanen <pekka.paalanen@collabora.com>,
        Simon Ser
	<contact@emersion.fr>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        <linux-kernel@vger.kernel.org>
References: <20240502153234.1.I2052f01c8d209d9ae9c300b87c6e4f60bd3cc99e@changeid>
From: Abhinav Kumar <quic_abhinavk@quicinc.com>
In-Reply-To: <20240502153234.1.I2052f01c8d209d9ae9c300b87c6e4f60bd3cc99e@changeid>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: oe55n8zLLuOJ-F9oGUJHiJCumhejoQ4D
X-Proofpoint-GUID: oe55n8zLLuOJ-F9oGUJHiJCumhejoQ4D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-02_14,2024-05-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 suspectscore=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0 adultscore=0
 priorityscore=1501 mlxscore=0 malwarescore=0 mlxlogscore=818 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2405020151



On 5/2/2024 3:32 PM, Douglas Anderson wrote:
> The debug print clearly lacks a \n at the end. Add it.
> 
> Fixes: 8f86c82aba8b ("drm/connector: demote connector force-probes for non-master clients")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> 
>   drivers/gpu/drm/drm_connector.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>

