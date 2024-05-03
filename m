Return-Path: <linux-kernel+bounces-168136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C50668BB419
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 21:33:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 018AA1C21D79
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 19:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4042158A03;
	Fri,  3 May 2024 19:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="GL5t1h78"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858802206E;
	Fri,  3 May 2024 19:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714764796; cv=none; b=AZoYn9rrBcUombhjA6inY5vO0UXQrcVa06LoTopzi0AuOjlUABfHn86+eAWbD0VO6hbyPmbpYEi5H3ZlrpkbQLmdBE5XRenBL6fGAmclwXYTngAPmTNLfrAkNQnH+HBaLMKPHP0dNMrQh06+1QRFUDAXePgNzt8Z1df5vS+jgeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714764796; c=relaxed/simple;
	bh=PMt2BtExKcYHLhwqcNWGhtMPtpwvpK77j8n1ZhWpy0I=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ZzgBy8snktDjO4PYcRZPKkj7QuWvY1I0xkKWnkbDhzCYEz7xCDJZjkSMxW0EOjUwVa4xF7PYOtVgBoIM09g+0ZwRyGUiRhpzBGHTPN8wqE37HX5Oq0LJIuZ8dimyJagaxuSQpOynAF6dO/5dwb45vDMpzaMwZySUS6qEX0+Xa/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=GL5t1h78; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 443IUGgJ003326;
	Fri, 3 May 2024 19:32:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=ieAOOODnpvY0Ey8J7eJ0Q5AQm0nI6LyiFkdkDQuyWaQ=; b=GL
	5t1h782NlRJfBdpjH5PGHI/ikw0PwNNAsS8voSUzwtnh45B/yS6mbXlUPofjesdF
	CyIZKuzaEvghFrRUiKiT8kmTW60urgNttkZ1VyudegSDRSfJpNrRwhS/22lMeRWq
	vXH0//7LshjIVWKAvE7vTbE7ALdx218B1gLNvCYQU2qLC/NcWOVKYIYKbp9ZNsbH
	Nos0ke5aVifwDtvaikzzliXYEBDWmmgeb8UiVfQFb8PLo6LYHjwsYSqY04f1/3cN
	Wf0xaETwJEXbSfNd+5oHdwp5eCRu3M+RH2sm3FZyQXaPJerJ10z9n1UQq1gCzAad
	gUfD56UOYDTHUQt7E96g==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xv8vsbkvm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 03 May 2024 19:32:52 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 443JWpt3009949
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 3 May 2024 19:32:51 GMT
Received: from [10.110.114.34] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 3 May 2024
 12:32:50 -0700
Message-ID: <85c7f268-60e1-bd3a-2646-eb01efa0d547@quicinc.com>
Date: Fri, 3 May 2024 12:32:49 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 1/2] drm/msm/gen_header: allow skipping the validation
Content-Language: en-US
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Clark
	<robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Marijn Suijten
	<marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Daniel
 Vetter <daniel@ffwll.ch>,
        Helen Koike <helen.koike@collabora.com>,
        Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard
	<mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
CC: <linux-arm-msm@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <freedreno@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        Stephen
 Rothwell <sfr@canb.auug.org.au>
References: <20240503-fd-fix-lxml-v2-0-f80a60ce21a1@linaro.org>
 <20240503-fd-fix-lxml-v2-1-f80a60ce21a1@linaro.org>
From: Abhinav Kumar <quic_abhinavk@quicinc.com>
In-Reply-To: <20240503-fd-fix-lxml-v2-1-f80a60ce21a1@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: UuXuCLTMiwePbV3jfGkTU1oXBcTx2Q-z
X-Proofpoint-GUID: UuXuCLTMiwePbV3jfGkTU1oXBcTx2Q-z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-03_13,2024-05-03_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 suspectscore=0 priorityscore=1501 mlxscore=0 spamscore=0 adultscore=0
 impostorscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0 phishscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2405030139



On 5/3/2024 11:15 AM, Dmitry Baryshkov wrote:
> We don't need to run the validation of the XML files if we are just
> compiling the kernel. Skip the validation unless the user enables
> corresponding Kconfig option. This removes a warning from gen_header.py
> about lxml being not installed.
> 
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Closes: https://lore.kernel.org/all/20240409120108.2303d0bd@canb.auug.org.au/
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>   drivers/gpu/drm/msm/Kconfig                 |  8 ++++++++
>   drivers/gpu/drm/msm/Makefile                |  9 ++++++++-
>   drivers/gpu/drm/msm/registers/gen_header.py | 14 +++++++++++---
>   3 files changed, 27 insertions(+), 4 deletions(-)
> 

Looks reasonable to me, only developers need to worry about or fix the 
xml files

Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>

