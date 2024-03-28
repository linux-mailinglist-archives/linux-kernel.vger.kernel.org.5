Return-Path: <linux-kernel+bounces-123574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B126890B3A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 21:25:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C18D7B22A91
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 20:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 973D313A246;
	Thu, 28 Mar 2024 20:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="oGnCbTGv"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A994436D;
	Thu, 28 Mar 2024 20:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711657333; cv=none; b=lOC1aysSMb49A6LlvLW8Nvk/GlTeZtO1ERR4qviBuvmF2JqVDUjEYyNYdzQGIhTr/D8Le5JVajAzjwMSqiFgMwDXeOQyXWWUCKdiAEt94Z2PaWydxoGo9owowq6P9bnyNkOvGG71Lz15zuiutWem59ym3M28oHg2mqxhETbH76w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711657333; c=relaxed/simple;
	bh=M8T2eHxcwVam9R/FyyfxaBsuCgGcpoM9g3sIorrJ/Lk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=WGAT7ym2lIljE0VPTZsSnAG5Q4KS1TWUKmHuaa3OKfBBHaAEyskA09/dyAEajGCcCSTUiirP/fn2SbJlTPuYf3IYubudDUGN16+6MTcPvkAsF7Lu5EZJ3bVUbX/yQcOZ3spMDzILCyFkDLmVMMLSfruVpSgbznLLXVHU8x4JtHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=oGnCbTGv; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42SJkdNx017897;
	Thu, 28 Mar 2024 20:22:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=BFbqoL7Pm0we+a3PEnAVyAr7/vZB9JsanhUu29n+DMk=; b=oG
	nCbTGvNWtym/7bx4jZlwtarVdBTbQqNVNR/Yf842rBwLZwATE98wa7lQoDpk3ac0
	ifwqGHJhtaidshHXP0RivGrpxPtLf6YDQVq3i1oXXe2nX6HgzllR/mTc8VPm/L1B
	1rkiz3f0TpDkH8D+BSowcyHFSwwMsNrUbapuPFnzDbWQDQ3K0Uds9jHdkWMs+Gvb
	ye1nRGqEXubL5+hM2RjmNRaep+J/x/UbilK5rO3+eLlcossusSwOUyLTNliPw084
	AxMJYOvz+giypajCd1BMrWUSgzB4Qw6YdAunqE3I7gNn7GJ6cvYY+K3fl9tYIbwn
	DaVhSRpvNWJ4rhXTUEGw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x56njhmf1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Mar 2024 20:22:01 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42SKLv4R008931
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Mar 2024 20:22:00 GMT
Received: from [10.71.109.81] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 28 Mar
 2024 13:21:51 -0700
Message-ID: <2bede86d-aae4-65f7-45b1-3df00bf7b40d@quicinc.com>
Date: Thu, 28 Mar 2024 13:21:50 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v1] drm/msm/dp: assign correct DP controller ID to
 interface table
Content-Language: en-US
To: Kuogee Hsieh <quic_khsieh@quicinc.com>, <dri-devel@lists.freedesktop.org>,
        <robdclark@gmail.com>, <sean@poorly.run>, <swboyd@chromium.org>,
        <dianders@chromium.org>, <vkoul@kernel.org>, <daniel@ffwll.ch>,
        <airlied@gmail.com>, <agross@kernel.org>,
        <dmitry.baryshkov@linaro.org>, <abel.vesa@linaro.org>,
        <andersson@kernel.org>
CC: <quic_jesszhan@quicinc.com>, <quic_sbillaka@quicinc.com>,
        <marijn.suijten@somainline.org>, <freedreno@lists.freedesktop.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1711656246-3483-1-git-send-email-quic_khsieh@quicinc.com>
From: Abhinav Kumar <quic_abhinavk@quicinc.com>
In-Reply-To: <1711656246-3483-1-git-send-email-quic_khsieh@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: jd4OLNHw3HjRWn_jgEmHy-rtHmSP6nn7
X-Proofpoint-GUID: jd4OLNHw3HjRWn_jgEmHy-rtHmSP6nn7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-28_17,2024-03-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 mlxlogscore=999 impostorscore=0
 phishscore=0 clxscore=1011 lowpriorityscore=0 malwarescore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2403280145



On 3/28/2024 1:04 PM, Kuogee Hsieh wrote:
> At current x1e80100 interface table, interface #3 is wrongly
> connected to DP controller #0 and interface #4 wrongly connected
> to DP controller #2. Fix this problem by connect Interface #3 to
> DP controller #0 and interface #4 connect to DP controller #1.
> Also add interface #6, #7 and #8 connections to DP controller to
> complete x1e80100 interface table.
> 
> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> ---
>   .../drm/msm/disp/dpu1/catalog/dpu_9_2_x1e80100.h   | 34 ++++++++++++++++++++--
>   1 file changed, 31 insertions(+), 3 deletions(-)
> 

Fixes: e3b1f369db5a ("drm/msm/dpu: Add X1E80100 support")

I cross-checked all the entries and this looks right.

Thanks for fixing this.

Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>

