Return-Path: <linux-kernel+bounces-147930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE90A8A7B7A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 06:40:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EC8A28433A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 04:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00364347C2;
	Wed, 17 Apr 2024 04:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="CQSLpV4P"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42DB1170F;
	Wed, 17 Apr 2024 04:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713328796; cv=none; b=ePygW5kMwlnO+2d5oGSxXuRs5pgIliWeGR1Gh/IaIhNStr8AMsl5L7ZbrN1Fe+KvlCuUK+YqLeg2+G26iMAHRKa1fHec7dz5Ch0r7Im6H5tcp75qC1QRUyW0yTRX/b/ljsUMn20vcUKJ+g4/R/jG7wy5f4dShgzP5bE1XsUUzxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713328796; c=relaxed/simple;
	bh=S3KeYWcnN7CaKj31q1rVFlks67eURbkzfUZxaWtCpkQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IzddBH8SOqCae8bBPgsWp77aMMTW2iGtH3NVlPL7BNYGaPMfoEVXq1agrsSTOcOF+TGe0BpMS/ZSxum3lQjWiVtAkFl2ezdH6KnWRrw5FI077RCjssevoO44L7l8acikLYxKHNtsy+AAmNtsGN0xRcUxBjnZqIerDntZiAP0G6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=CQSLpV4P; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43H4cdDH029196;
	Wed, 17 Apr 2024 04:39:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=qcppdkim1; bh=zxcprYMTZyoW0dZd3NOUX
	x8buyKspwXVHAPOYBlbg04=; b=CQSLpV4PVErXpXoo9GmDQ6nKTTj472zLKlxDz
	R0h/fu45FxEviv+xyps0w4ZLRuFzD7FOjBrelOuz+iR19xa3EPETsN7SvezU5EFM
	XJ2y9GUYOB61tZZL+9ohFOQD4L28o4LBxfjhhMgggtX9M2hKA35cXfqyG5zmbLlE
	EndNZvHhzPU0K3qr7/y9Ri98yNj+BKD5nKb8kOcoH4QdkLHqBVHlZOTLVEEg815A
	8eDJPooKLh1rxxESTyBmQslw3EHW0FU1giRoEkUyt3Euh5aS/ZHt9IZ764DM2coA
	CP3M1cxPM8KSteDzenbhS8FNwCFHK3Uj/1XUsz+WycsXdjiDA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xj7j90055-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Apr 2024 04:39:22 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43H4dKUr028471
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Apr 2024 04:39:20 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 16 Apr 2024 21:39:20 -0700
Date: Tue, 16 Apr 2024 21:39:19 -0700
From: Bjorn Andersson <quic_bjorande@quicinc.com>
To: Viken Dadhaniya <quic_vdadhani@quicinc.com>
CC: <cros-qcom-dts-watchers@chromium.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <swboyd@chromium.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <conor+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <rajpat@codeaurora.org>,
        <mka@chromium.org>, <rojay@codeaurora.org>,
        <quic_msavaliy@quicinc.com>, <quic_anupkulk@quicinc.com>
Subject: Re: [PATCH v1] arm64: dts: qcom: sc7280: Remove CTS/RTS configuration
Message-ID: <Zh9Sd4QVsN9TWomO@hu-bjorande-lv.qualcomm.com>
References: <20240416105650.2626-1-quic_vdadhani@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240416105650.2626-1-quic_vdadhani@quicinc.com>
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: qnZpEUul22HLGWytuiikdhWlsQ09LK6J
X-Proofpoint-ORIG-GUID: qnZpEUul22HLGWytuiikdhWlsQ09LK6J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-17_04,2024-04-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 adultscore=0 clxscore=1011 impostorscore=0 mlxlogscore=999 malwarescore=0
 phishscore=0 suspectscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404170029

On Tue, Apr 16, 2024 at 04:26:50PM +0530, Viken Dadhaniya wrote:
> Remove CTS and RTS pinctrl configuration for UART5 node as
> it's designed for debug UART for all the board variants of the
> sc7280 chipset.
> 
> Also change compatible string to debug UART.
> 

Why are you posting this on the public mailing list without first
addressing the feedback and questions I gave you on the internal review
list?

Now you wasted the time of our community members, just to receive the
same feedback I gave you last week.

Regards,
Bjorn

> Fixes: 38cd93f413fd ("arm64: dts: qcom: sc7280: Update QUPv3 UART5 DT node")
> Signed-off-by: Viken Dadhaniya <quic_vdadhani@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/sc7280.dtsi | 14 ++------------
>  1 file changed, 2 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> index 38c183b2bb26..2a6b4c4639d1 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> @@ -1440,12 +1440,12 @@
>  			};
>  
>  			uart5: serial@994000 {
> -				compatible = "qcom,geni-uart";
> +				compatible = "qcom,geni-debug-uart";
>  				reg = <0 0x00994000 0 0x4000>;
>  				clocks = <&gcc GCC_QUPV3_WRAP0_S5_CLK>;
>  				clock-names = "se";
>  				pinctrl-names = "default";
> -				pinctrl-0 = <&qup_uart5_cts>, <&qup_uart5_rts>, <&qup_uart5_tx>, <&qup_uart5_rx>;
> +				pinctrl-0 = <&qup_uart5_tx>, <&qup_uart5_rx>;
>  				interrupts = <GIC_SPI 606 IRQ_TYPE_LEVEL_HIGH>;
>  				power-domains = <&rpmhpd SC7280_CX>;
>  				operating-points-v2 = <&qup_opp_table>;
> @@ -5397,16 +5397,6 @@
>  				function = "qup04";
>  			};
>  
> -			qup_uart5_cts: qup-uart5-cts-state {
> -				pins = "gpio20";
> -				function = "qup05";
> -			};
> -
> -			qup_uart5_rts: qup-uart5-rts-state {
> -				pins = "gpio21";
> -				function = "qup05";
> -			};
> -
>  			qup_uart5_tx: qup-uart5-tx-state {
>  				pins = "gpio22";
>  				function = "qup05";
> -- 
> 2.17.1
> 

