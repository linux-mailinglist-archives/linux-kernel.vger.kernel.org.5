Return-Path: <linux-kernel+bounces-60236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A8178501C5
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 02:30:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C98D28A82D
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 01:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52E224414;
	Sat, 10 Feb 2024 01:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="G3AZbyF7"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3193C2107;
	Sat, 10 Feb 2024 01:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707528648; cv=none; b=chmFB02xze8jQcwYsFL2TAPFiOqbwSvOzhE9ABpXTKdZqEJ+BMQ2HuWfUT+yRF3pCRkUaCiNtMInddd/AfoB75isz+BniYnZVDLetEsAsIPxVWmX9HqGq0iq/StczFTRSBquEWwtUaSTNfb37lWGx/+IpLuprKsWE5gke1m1AIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707528648; c=relaxed/simple;
	bh=VA6nnW7XlMPouQcgt9aueTlp7RunIePCx3962uBL9A8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=mddDPy+8qZYpn2jbhWctzm0RSfVwQDvK1zMmdBbnGN4dmP9rx0MrV0+5yOVxzjSA/efhV4Fn7IG07UTrl49zLkNKTNuNt26Vn0r2VrtkPWclQ1yJt96UsWgKsAVTMBkGCuwMKtGIX2zyYb4Y7oGMcXGM3mazEyGWZYnvwVv+3nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=G3AZbyF7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41A1UAqY005364;
	Sat, 10 Feb 2024 01:30:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=DEuMTKRM+LW5FgIPjLs18+12WMOzbSwQX4AzgaDK/90=; b=G3
	AZbyF78C1u8NQNmAyQpNdu1AbhUJODHWd391+JQ/zs6eVcnhxcjLnfmGHX0UOd/Q
	he84OhsrpVjMWb/kgcUDKhVAxAQFbdQd723z/oK+oQNUF/xntTWfnwhOVA9j+PM7
	BDxtAE8qmvpS+8orEisZ9mDTTSRr5+7i7vTvtd7kLZM+KAvn5K5utmn+SeScvOAM
	dhkq+ceT8oKcSmyveVAKAk/SQostQgkd7SLL/ce79VHyphL3wB9rDVpCc/6kNyHr
	eiHu0Lo08lpP1Jm3RLJax/tlZyA0POYRSnqJd/n6A6aETF/fWBDGielI/i3AEwlT
	0NYfQRP+VlUc+paRIdQw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w5qvaguu6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 10 Feb 2024 01:30:42 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41A1UgLk001601
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 10 Feb 2024 01:30:42 GMT
Received: from [10.110.97.178] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 9 Feb
 2024 17:30:39 -0800
Message-ID: <cfc42c1f-ff17-4d66-8e88-cbd4230e7d7b@quicinc.com>
Date: Fri, 9 Feb 2024 17:30:37 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] soc: qcom: llcc: Check return value on Broadcast_OR
 reg read
Content-Language: en-US
To: Unnathi Chalicheemala <quic_uchalich@quicinc.com>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Abel Vesa
	<abel.vesa@linaro.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel@quicinc.com>, Elliot Berman <quic_eberman@quicinc.com>
References: <20240210011415.3440236-1-quic_uchalich@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240210011415.3440236-1-quic_uchalich@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: W_gj7v4rx728_m6HlTP6vgbMBDoCLcsZ
X-Proofpoint-ORIG-GUID: W_gj7v4rx728_m6HlTP6vgbMBDoCLcsZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-10_01,2024-02-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 priorityscore=1501 mlxscore=0
 bulkscore=0 phishscore=0 mlxlogscore=970 adultscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402100009

On 2/9/2024 5:14 PM, Unnathi Chalicheemala wrote:
> Commit c72ca343f911 ("soc: qcom: llcc: Add v4.1 HW version support")
> introduced a new 4.1 if statement in llcc_update_act_ctrl() without
> considering that ret might be overwritten. So, adding return value check

nit: s/adding/add/ (use imperative voice)

> after Broadcast_OR register read in llcc_update_act_ctrl().
> 
> Fixes: c72ca343f911 ("soc: qcom: llcc: Add v4.1 HW version support">

remove this blank line -- the Fixes tag should be grouped with the other
tags

> Signed-off-by: Unnathi Chalicheemala <quic_uchalich@quicinc.com>
> Reviewed-by: Elliot Berman <quic_eberman@quicinc.com>
> 
> ---
> Changes in v2:
> - Referenced right commit to be fixed in the commit message.
> - Added Elliot's R-B tag.
> - Modified commit message to better explain problem statement.
> - Link to v1: https://lore.kernel.org/all/20240202-fix_llcc_update_act_ctrl-v1-1-d36df95c8bd5@quicinc.com/
> 
> ---
>  drivers/soc/qcom/llcc-qcom.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/soc/qcom/llcc-qcom.c b/drivers/soc/qcom/llcc-qcom.c
> index 4ca88eaebf06..cbef0dea1d5d 100644
> --- a/drivers/soc/qcom/llcc-qcom.c
> +++ b/drivers/soc/qcom/llcc-qcom.c
> @@ -859,6 +859,8 @@ static int llcc_update_act_ctrl(u32 sid,
>  	ret = regmap_read_poll_timeout(drv_data->bcast_regmap, status_reg,
>  				      slice_status, !(slice_status & status),
>  				      0, LLCC_STATUS_READ_DELAY);
> +	if (ret)
> +		return ret;
>  
>  	if (drv_data->version >= LLCC_VERSION_4_1_0_0)
>  		ret = regmap_write(drv_data->bcast_regmap, act_clear_reg,


