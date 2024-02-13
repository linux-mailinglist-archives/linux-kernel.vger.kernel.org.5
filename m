Return-Path: <linux-kernel+bounces-62562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C26ED8522F5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 01:10:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63B39B254AD
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 00:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 278B128E3;
	Tue, 13 Feb 2024 00:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="T25wJcfY"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81781FAB
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 00:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707783015; cv=none; b=bF7zFMu+kryNUw1E3hKLWML+1TMoskG7cAiZg2Tuk+SbXMGsfkqeG/ncmwEb6fpJf9/iUHgJJZaQ6Ks9lAXCFAF3t2Qd56GbYJaDsTy5cnzQUyCD/mn4jYHS1c2zsY48gIIpJ4qRaPTN444OeuSvOXyCJzDIxru2YWB14AdipKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707783015; c=relaxed/simple;
	bh=J7FejEFnbMm74uZsExP5QWA3ZxhT4NbGZP6EJnx295g=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ItwcSKhq5+XFaD0CTFC30MSrlVkrtW9zxg301CBiaqO20fJ1c5FuId+4Hp29FWIu5MlJ52hb1bCAGY1qGjgHVIWkTsybWzHkWXxTexgnqqtsNhjEFuiN3H4CAzP2yZRmBP/61ctWJlmMmhhjAr+YWsSuObm3XVU3opnYzt1Xg8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=T25wJcfY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41CNNWC9002327;
	Tue, 13 Feb 2024 00:09:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=SKTZ/3gDrjTrmPt81XU/FfX33drgx94XxgkNqX5kp7Y=; b=T2
	5wJcfYBq8HUo5ZGxsokAPOP8K9BC2QvE3Iz8ZTy/DCE2WQ1eRui+5C/9cXtsAghE
	QSNETroOGAfpQ6aPqx3GfXel40SyCKBP9FzmHNJELPk5o1xuJJgmUFTxZF5pFDf/
	3TaeuDikn35hJ1BnViB4fQ5buOj5uiFjQfXBJnywCEW0q0izkeSPTsOj5WIwuntQ
	Ox1b3z8sgTJBtWSDhuCfRpZttQ6sIOgS+IhfAwuKHBUv29kL5iD64Tb29GfEiQJR
	0ctWmM4Nnchg6jcYpqc68DAxLNU9OZC08uqHy5IY4+UfQ8Otb6EVgo4el2ORsc0h
	kXui0XdyyNup2vXQYylw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w7gvjhsv4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Feb 2024 00:09:53 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41D09qgn001486
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Feb 2024 00:09:52 GMT
Received: from [10.71.109.81] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 12 Feb
 2024 16:09:51 -0800
Message-ID: <e5dd6d92-0d9d-fcfe-2aac-8302b421c0a0@quicinc.com>
Date: Mon, 12 Feb 2024 16:09:50 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/crtc: fix uninitialized variable use even harder
Content-Language: en-US
To: Rob Clark <robdclark@gmail.com>, <dri-devel@lists.freedesktop.org>
CC: Rob Clark <robdclark@chromium.org>,
        Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Jani Nikula <jani.nikula@intel.com>,
        open
 list <linux-kernel@vger.kernel.org>
References: <20240212215534.190682-1-robdclark@gmail.com>
From: Abhinav Kumar <quic_abhinavk@quicinc.com>
In-Reply-To: <20240212215534.190682-1-robdclark@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Z6k0dI9SZ8x1JhC7HruQaOgew-bmVxBU
X-Proofpoint-ORIG-GUID: Z6k0dI9SZ8x1JhC7HruQaOgew-bmVxBU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-12_19,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 suspectscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 mlxlogscore=881 adultscore=0
 bulkscore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402120186



On 2/12/2024 1:55 PM, Rob Clark wrote:
> From: Rob Clark <robdclark@chromium.org>
> 
> DRM_MODESET_LOCK_ALL_BEGIN() has a hidden trap-door (aka retry loop),
> which means we can't rely too much on variable initializers.
> 
> Fixes: 6e455f5dcdd1 ("drm/crtc: fix uninitialized variable use")
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
> I have mixed feelings about DRM_MODESET_LOCK_ALL_BEGIN() (and friends)
> magic.  On one hand it simplifies the deadlock/back dance.  OTOH it
> conceals a nasty sharp edge.  Maybe it is better to have the complicated
> restart path a bit more explicit, like it was originally.
> 
>   drivers/gpu/drm/drm_crtc.c | 1 +
>   1 file changed, 1 insertion(+)
> 

Nice catch !!

Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>

