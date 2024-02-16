Return-Path: <linux-kernel+bounces-68898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 774B88581A1
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 16:43:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3FEEB21598
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 15:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2C1C12F5A9;
	Fri, 16 Feb 2024 15:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="h8h2bYkC"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5BC45465D;
	Fri, 16 Feb 2024 15:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708098219; cv=none; b=e2SPcVc/Atl+TVVE+w7guiCqLL19C3oKq+VUiKDTQYuqGVhzAI7EsqfOkj8hrfxwwi3IsQDsIDDxevAU+Vzm2qiLHS3vyR077pjVOx6gdGzHTUleflFmKoJJKQ9bUTe8Vqtkxo90noDwaKeYYJpIWkqWEx5EtkXqiP3e63VZAKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708098219; c=relaxed/simple;
	bh=Tc3AcWuA5+iVXsmy2J/ZZTnoqLhFQ1wG49YuwRB7wQ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=EaWJB/zK4Ryz65K7DjVz+aCVJCHwDGSx6Bwq7fUer2lOZDxFFMnoSCK4ivFZRemDqmbATci8XVBuN241OLcdQVTL1Z6f4L54eDiLxM+hoss5RoJ33R8woReB2Vp4NpNiwmm9g7OQYHKTmsWFEAZNdbbCaQSuxIFU0/DfSWXZ2yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=h8h2bYkC; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41GDbtS4011487;
	Fri, 16 Feb 2024 15:43:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=/TClJqpS+bBvRR6l6kjde6YHarFGL/FBzIBPSKAJuFU=; b=h8
	h2bYkCIh7hvXynXnyL5ltpS4Qc4WFGnjfggzmLwCP1+suiPjkCCWiGp0k+OC+BwE
	rlZ0rdJnGQV15WB6KqFmoV2CU25o30GknvrMLzhdPuPusKRrH7/VRlx7uXxXTtKo
	3s6HGQlBJEsc9T/Qcvas8R4BpEFGTDjCp6hCENoM6nt7gc4ycJeT8Jd3r8p3K0Sd
	bYz3bPv6kC1nR/2aqQmnsO9IxzXoGlNxIbNAnb6Lu5YRmMrc7en0GSDHd+j01xTy
	b7L+MhxVOWztPO5sqLvJ/Y7b5LkPRQ4f4nsivBp+scZUz69SqtzNMXajEaqelQEv
	BUDeHcuoCRS2kvfvAvpA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w9bfs4ckq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Feb 2024 15:43:24 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41GFhNnQ001001
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Feb 2024 15:43:23 GMT
Received: from [10.216.32.60] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 16 Feb
 2024 07:43:16 -0800
Message-ID: <ea840faa-e628-4f2f-a7ea-aa222f58f820@quicinc.com>
Date: Fri, 16 Feb 2024 21:13:11 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] arm64: dts: qcom: ipq9574: Disable eMMC node
Content-Language: en-US
To: Md Sadre Alam <quic_mdalam@quicinc.com>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <broonie@kernel.org>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <manivannan.sadhasivam@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>
CC: <quic_srichara@quicinc.com>, <quic_varada@quicinc.com>
References: <20240215134856.1313239-1-quic_mdalam@quicinc.com>
 <20240215134856.1313239-6-quic_mdalam@quicinc.com>
From: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
In-Reply-To: <20240215134856.1313239-6-quic_mdalam@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: BwJAlB4SoQosnOFzkFqSNVWefWffVrEn
X-Proofpoint-GUID: BwJAlB4SoQosnOFzkFqSNVWefWffVrEn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-16_15,2024-02-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 phishscore=0 suspectscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 adultscore=0 mlxscore=0 impostorscore=0 mlxlogscore=718
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402160126



On 2/15/2024 7:18 PM, Md Sadre Alam wrote:
> Disable eMMC node for rdp433, since rdp433 default boot mode
> is norplusnand.
> 
> Co-developed-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> Co-developed-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>


Single line of change is developed by 3 authors?


> ---
>   arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts b/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts
> index 1bb8d96c9a82..e33e7fafd695 100644
> --- a/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts
> +++ b/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts
> @@ -24,7 +24,7 @@ &sdhc_1 {
>   	mmc-hs400-enhanced-strobe;
>   	max-frequency = <384000000>;
>   	bus-width = <8>;
> -	status = "okay";
> +	status = "disabled";
>   };
>   
>   &tlmm {

