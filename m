Return-Path: <linux-kernel+bounces-130372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CAD589773F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 19:48:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E4C91C23147
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3C4F156961;
	Wed,  3 Apr 2024 17:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="e/zzmnXh"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 895AB156888;
	Wed,  3 Apr 2024 17:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712165061; cv=none; b=gfG/c8NE1zq8b1O/hYSjAtn0YyuQwOrnp1L1ZYhNmJgylSNnJ+j57wY6i9JOEWHLvCpzOfmIIXzoKHhcKjA3FWGJM9jK3fOu8iLOMBjjBJnDZZqc/6PmruDc7sXLAG6hUyRpsvoUWEichPCUXKh8vzjqyT9xYhm1dopG1lTIIyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712165061; c=relaxed/simple;
	bh=B/y872zb6f2CvLaHGcqyZBTBXES6JFiuSyjS0w8aW5M=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=DrJNbh4LwMYLYn64No7kjXJeeskn4v5OL9G/K6y3dXbLH5mwEJdtctCvXWRx1+ucws72V+naMT6KWdxByZ5JZpgZMWe4Jk4HP7aFw/rjMjsHgjHlfRrLRJVLqZSPXw0mihQ5GqUL9vD/7EqW9Lbj9IY/Tzd3T7P6somdzBTD/68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=e/zzmnXh; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 433GxAh1021447;
	Wed, 3 Apr 2024 17:24:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=2JPx6TwP3TixIfu9uBlgTPj2U8PhmVwaQIll4DjjblI=; b=e/
	zzmnXhLw+h39vMcc5PJ1xtHsmqliqbI/4lb8QLMxNVJdQvKHe3NVC9igEM9Bg7nD
	foFGHxOuH3xdQ5JqtflSdOzy6eccmXf9Y5YjI1876ah0kwtxWhAKTk9XN+/ZiWg+
	Px8tK94Q8KsCoaRUhoC7EGjTHcz8V3BfMwoyt8rYl5d+trL6xEv6dMLzZFcgEd96
	Nf3VIfaNMMP/6qWsoAgT3pX3bl9f4DpmEW2GeYSRr05ALjasMmDPKLz7+20J9Odv
	gEC1ytm1sx/Jn15WLUe5oHR7NiPhBENKOuo0IBD1HQXg2+AQjs4S/9qEMyYLfN8T
	KA9UsCD/LJ/+y6GKItDA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x92hb1h87-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Apr 2024 17:24:09 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 433HO8pK022925
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 3 Apr 2024 17:24:08 GMT
Received: from [10.110.67.196] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 3 Apr 2024
 10:24:07 -0700
Message-ID: <f0dcfd6a-55cf-84d8-6599-319a700e1960@quicinc.com>
Date: Wed, 3 Apr 2024 10:23:59 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3] drm/msm/dp: assign correct DP controller ID to
 x1e80100 interface table
To: <dri-devel@lists.freedesktop.org>, <robdclark@gmail.com>,
        <sean@poorly.run>, <swboyd@chromium.org>, <dianders@chromium.org>,
        <vkoul@kernel.org>, <daniel@ffwll.ch>, <airlied@gmail.com>,
        <agross@kernel.org>, <dmitry.baryshkov@linaro.org>,
        <abel.vesa@linaro.org>, <andersson@kernel.org>
CC: <quic_abhinavk@quicinc.com>, <quic_jesszhan@quicinc.com>,
        <quic_sbillaka@quicinc.com>, <marijn.suijten@somainline.org>,
        <freedreno@lists.freedesktop.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1711741586-9037-1-git-send-email-quic_khsieh@quicinc.com>
Content-Language: en-US
From: Kuogee Hsieh <quic_khsieh@quicinc.com>
In-Reply-To: <1711741586-9037-1-git-send-email-quic_khsieh@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: SvE6clYGD40F0jHrmd_JNjrin2kdEppU
X-Proofpoint-ORIG-GUID: SvE6clYGD40F0jHrmd_JNjrin2kdEppU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-03_18,2024-04-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 mlxscore=0
 clxscore=1015 adultscore=0 spamscore=0 lowpriorityscore=0 phishscore=0
 malwarescore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2404030117

Dmitry,

any more comments?

On 3/29/2024 12:46 PM, Kuogee Hsieh wrote:
> At current x1e80100 interface table, interface #3 is wrongly
> connected to DP controller #0 and interface #4 wrongly connected
> to DP controller #2. Fix this problem by connect Interface #3 to
> DP controller #0 and interface #4 connect to DP controller #1.
> Also add interface #6, #7 and #8 connections to DP controller to
> complete x1e80100 interface table.
>
> Changs in V3:
> -- add v2 changes log
>
> Changs in V2:
> -- add x1e80100 to subject
> -- add Fixes
>
> Fixes: e3b1f369db5a ("drm/msm/dpu: Add X1E80100 support")
> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> Reviewed-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>   .../drm/msm/disp/dpu1/catalog/dpu_9_2_x1e80100.h   | 34 ++++++++++++++++++++--
>   1 file changed, 31 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_9_2_x1e80100.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_9_2_x1e80100.h
> index 9a9f709..a3e60ac 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_9_2_x1e80100.h
> +++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_9_2_x1e80100.h
> @@ -324,6 +324,7 @@ static const struct dpu_wb_cfg x1e80100_wb[] = {
>   	},
>   };
>   
> +/* TODO: INTF 3, 8 and 7 are used for MST, marked as INTF_NONE for now */
>   static const struct dpu_intf_cfg x1e80100_intf[] = {
>   	{
>   		.name = "intf_0", .id = INTF_0,
> @@ -358,8 +359,8 @@ static const struct dpu_intf_cfg x1e80100_intf[] = {
>   		.name = "intf_3", .id = INTF_3,
>   		.base = 0x37000, .len = 0x280,
>   		.features = INTF_SC7280_MASK,
> -		.type = INTF_DP,
> -		.controller_id = MSM_DP_CONTROLLER_1,
> +		.type = INTF_NONE,
> +		.controller_id = MSM_DP_CONTROLLER_0,	/* pair with intf_0 for DP MST */
>   		.prog_fetch_lines_worst_case = 24,
>   		.intr_underrun = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 30),
>   		.intr_vsync = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 31),
> @@ -368,7 +369,7 @@ static const struct dpu_intf_cfg x1e80100_intf[] = {
>   		.base = 0x38000, .len = 0x280,
>   		.features = INTF_SC7280_MASK,
>   		.type = INTF_DP,
> -		.controller_id = MSM_DP_CONTROLLER_2,
> +		.controller_id = MSM_DP_CONTROLLER_1,
>   		.prog_fetch_lines_worst_case = 24,
>   		.intr_underrun = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 20),
>   		.intr_vsync = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 21),
> @@ -381,6 +382,33 @@ static const struct dpu_intf_cfg x1e80100_intf[] = {
>   		.prog_fetch_lines_worst_case = 24,
>   		.intr_underrun = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 22),
>   		.intr_vsync = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 23),
> +	}, {
> +		.name = "intf_6", .id = INTF_6,
> +		.base = 0x3A000, .len = 0x280,
> +		.features = INTF_SC7280_MASK,
> +		.type = INTF_DP,
> +		.controller_id = MSM_DP_CONTROLLER_2,
> +		.prog_fetch_lines_worst_case = 24,
> +		.intr_underrun = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 17),
> +		.intr_vsync = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 16),
> +	}, {
> +		.name = "intf_7", .id = INTF_7,
> +		.base = 0x3b000, .len = 0x280,
> +		.features = INTF_SC7280_MASK,
> +		.type = INTF_NONE,
> +		.controller_id = MSM_DP_CONTROLLER_2,	/* pair with intf_6 for DP MST */
> +		.prog_fetch_lines_worst_case = 24,
> +		.intr_underrun = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 18),
> +		.intr_vsync = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 19),
> +	}, {
> +		.name = "intf_8", .id = INTF_8,
> +		.base = 0x3c000, .len = 0x280,
> +		.features = INTF_SC7280_MASK,
> +		.type = INTF_NONE,
> +		.controller_id = MSM_DP_CONTROLLER_1,	/* pair with intf_4 for DP MST */
> +		.prog_fetch_lines_worst_case = 24,
> +		.intr_underrun = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 12),
> +		.intr_vsync = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 13),
>   	},
>   };
>   

