Return-Path: <linux-kernel+bounces-132279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CF96899266
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 02:02:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 565F3283BB3
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 00:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8D9E4A35;
	Fri,  5 Apr 2024 00:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="NnMehlyy"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A55317753;
	Fri,  5 Apr 2024 00:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712275347; cv=none; b=uwCGB11I/Km4fH2t4AGNyTTpBRN9BZfj3d2IcPSk6OR0LlClExULtCdatfGKkxRo/FO083QBrqrKvkce79g4xRpf6r4BAZwvkATP9UL99apLEk2n9et6BLLLt+7sUfgDpr/TVCEN2q1x/weUbq4al3jIPTrn68iHM6p/GnP6UqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712275347; c=relaxed/simple;
	bh=B39MCQV2EW1M08zT6OJ7JW3ozGAVx5636M3LnSrOAFs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Fi6KoY79ZiIsSe3oAYWZr/57Y2VzF6pCxNVx/Wh5ppr+pFcWb0F8xCUO7O1FjFI4T6yUi8nFbmLmu2WFTBl++QBDfKphSWILY2BDKwm9cpQbbUdB97fN6W7Xk7AFZjDIzK3zB+ULNSJQbRi6gTIpmA8/YFC4lUGXOibXPZrfawQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=NnMehlyy; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 434NAeLr030052;
	Fri, 5 Apr 2024 00:02:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=TD5oyqVKB4jfM/BR7AZ9j8sXSzPQIq9BgDIENBz6KKQ=; b=Nn
	Mehlyyipz7OdjTFvBf69BsEby7oJZpzZjnw+pV551sHekFezYboshGVIrRJ3tTg8
	Dqk+OPP89jxUdkSymndmrY8pNN5j233SP96plXH2aG8hRxscl/53QFPZcN+J11Gr
	YsrXmd1dsBAPXaADqPe3NUV/Aa8Er55x2iwjECwhYRm/WDIspAlF5KmtsBbBG5V+
	44vaVTvbmF1rT7l1AT6hjef2u9FDcrrxje5xNChPo+kCeHbF19SymFpleYAGs9kW
	nT2jW+143fi348/EtsAixvQ9Kfd6m1v1bY2hWfkaxen40PF8OrW8n/PNf9aNaavc
	j/aszn4wFbPLaw7uaDZg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x9ep4ts85-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Apr 2024 00:02:12 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43502BC9003661
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 5 Apr 2024 00:02:11 GMT
Received: from [10.71.109.81] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 4 Apr 2024
 17:02:10 -0700
Message-ID: <f7f7d56a-3292-4641-a479-c0b72d611bc3@quicinc.com>
Date: Thu, 4 Apr 2024 17:02:09 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] phy: qcom: qmp-combo: Fix VCO div offset on v3
Content-Language: en-US
To: Stephen Boyd <swboyd@chromium.org>, Vinod Koul <vkoul@kernel.org>,
        Kishon
 Vijay Abraham I <kishon@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <patches@lists.linux.dev>,
        <linux-arm-msm@vger.kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        <linux-phy@lists.infradead.org>,
        Neil
 Armstrong <neil.armstrong@linaro.org>,
        <freedreno@lists.freedesktop.org>,
        Douglas Anderson <dianders@chromium.org>,
        Dmitry Baryshkov
	<dmitry.baryshkov@linaro.org>
References: <20240404234345.1446300-1-swboyd@chromium.org>
From: Abhinav Kumar <quic_abhinavk@quicinc.com>
In-Reply-To: <20240404234345.1446300-1-swboyd@chromium.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Q_wGZcMFoP8FLWWXYAMl7MlV2SE4NBke
X-Proofpoint-GUID: Q_wGZcMFoP8FLWWXYAMl7MlV2SE4NBke
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-04_20,2024-04-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 bulkscore=0 impostorscore=0 clxscore=1011 spamscore=0 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 adultscore=0
 mlxlogscore=926 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404040171



On 4/4/2024 4:43 PM, Stephen Boyd wrote:
> Commit ec17373aebd0 ("phy: qcom: qmp-combo: extract common function to
> setup clocks") changed the offset that is used to write to
> DP_PHY_VCO_DIV from QSERDES_V3_DP_PHY_VCO_DIV to
> QSERDES_V4_DP_PHY_VCO_DIV. Unfortunately, this offset is different
> between v3 and v4 phys:
> 
>   #define QSERDES_V3_DP_PHY_VCO_DIV                 0x064
>   #define QSERDES_V4_DP_PHY_VCO_DIV                 0x070
> 
> meaning that we write the wrong register on v3 phys now. Add another
> generic register to 'regs' and use it here instead of a version specific
> define to fix this.
> 
> This was discovered after Abhinav looked over register dumps with me
> from sc7180 Trogdor devices that started failing to light up the
> external display with v6.6 based kernels. It turns out that some
> monitors are very specific about their link clk frequency and if the
> default power on reset value is still there the monitor will show a
> blank screen or a garbled display. Other monitors are perfectly happy to
> get a bad clock signal.
> 
> Cc: Douglas Anderson <dianders@chromium.org>
> Cc: Abhinav Kumar <quic_abhinavk@quicinc.com>
> Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Fixes: ec17373aebd0 ("phy: qcom: qmp-combo: extract common function to setup clocks")
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>   drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 

I cross-checked the foll chipsets which use qmp_v3_usb3phy_regs_layout:

-> sdm845
-> sc7180
-> sm6350

All of them have VCO_DIV at offset 0x64.

And, I cross-checked the foll chipsets which use 
qmp_v45_usb3phy_regs_layout:

-> sc8180x
-> x1e80100
-> sm8250
-> sm8350

All of them have VCO_DIV at offset 0x70.

Now, thing look in order to me.

Hence,

Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>

