Return-Path: <linux-kernel+bounces-45991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7B928438DF
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 09:25:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6041928B30E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 08:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 095125D72A;
	Wed, 31 Jan 2024 08:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="CYRTZhpc"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539875813B;
	Wed, 31 Jan 2024 08:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706689490; cv=none; b=Qmq2wezFzTStoezZXShNuu8chX0wGE8ARNMOHIIZ2dVaaAPXZsGIX6pT8z6vD4rZWrJ307V9lRTFJt78oqCLdfGWHdjJNl1pIadeg8HeWIh0YyoOm5qKnMW6+bk0UbHZas5Uu8Jh6eB99OnbhuqIh6f4RUPk9M6mswse2FD+KHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706689490; c=relaxed/simple;
	bh=tn25MHQt9e+XeY213gUVx2kBtMJGCp5894PFZEy46Zk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=YQy0wF9dond39E2lPKO6jqvM6NyKZDvxijfQLeISSCLRuE5NBTDOFF8T1Jo7A4dyB1ydSLTi/cYaqha0V+TAtKtItlXKriUfxOwPL4mC7kRaGziMal8fvsfnf3KtquOGOCEz97NtU9qIWRLPAUPp0CZXFEeO2iRR9ozTV/oxd8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=CYRTZhpc; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40V77XL5004425;
	Wed, 31 Jan 2024 08:24:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=BATHeXE6YLReFxJgjH618xTQA2Y0kqWat5nvxqw9FgA=; b=CY
	RTZhpcGPPVEHMa4KiFL0cQRIoqGNwkK5rpYeaMMocwVZSK63u/tTORc/FGQPIr8u
	AyzSNlO+e+b0jF/30tI/2CGBplRlNHjJFaDwL3fw69vSlQRraBOp+xNxauuNVN6I
	0cZVDtoVIiTolW+b5s8XHGpSttV2VL0E9ETZmwz+V01FYvOpxK+VrEPK4Udb55m9
	39xMyjwHdmt3lTVTG04e7RQv7XKeO88BvI+jxfzqcpNbGJtOlyp+Ju8pJhadxc1f
	tfKPcwZnCirEbx962PvLYDxAiN1Y4lO/0tmxObOKXfZl3MKv5v+JdyWYidkt8vYm
	CNXwvCk8tRRjmgPgVugQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vyfc8rm08-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Jan 2024 08:24:43 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40V8OgHU009321
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Jan 2024 08:24:42 GMT
Received: from [10.239.132.204] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 31 Jan
 2024 00:24:37 -0800
Message-ID: <8a3866ee-d70b-419c-bde4-7bf55415402e@quicinc.com>
Date: Wed, 31 Jan 2024 16:24:34 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] dt-bindings: pinctrl: qcom: consolidate functions
 to match with driver
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <linus.walleij@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel@quicinc.com>
References: <20240129092512.23602-1-quic_tengfan@quicinc.com>
 <20240129092512.23602-3-quic_tengfan@quicinc.com>
 <aa870f52-d956-4c3e-82a4-980a32f5f698@linaro.org>
From: Tengfei Fan <quic_tengfan@quicinc.com>
In-Reply-To: <aa870f52-d956-4c3e-82a4-980a32f5f698@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: p3oktYrZbuH3L2HKXmszgsrM7auN08H-
X-Proofpoint-ORIG-GUID: p3oktYrZbuH3L2HKXmszgsrM7auN08H-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-31_03,2024-01-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 malwarescore=0 phishscore=0 adultscore=0
 suspectscore=0 impostorscore=0 mlxscore=0 spamscore=0 mlxlogscore=728
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401310063



On 1/29/2024 7:24 PM, Krzysztof Kozlowski wrote:
> On 29/01/2024 10:25, Tengfei Fan wrote:
>> Consolidate functions to match with SM4450 pinctrl driver, because
>> consolidate functions are being used in SM4450 pinctrl driver.
> 
> It's very difficult to see what changed from the diff, so please explain
> brieflyl changes here.
> 
> What is that "consolidate functions" that you use in the driver?
> 
> Best regards,
> Krzysztof
> 

please help to comfirm that the following description as commit message 
whether it covers your concerns:

Pin alternative functions are consolidated(like: atest_char, phase_flag, 
qdss_gpio etc.) in SM4450 pinctrl driver while they are still split in 
DeviceTree binding file. SM4450 pinctrl function is broken if current 
binding doc is followed. Update SM4450 pinctrl DeviceTree binding doc to 
align with driver.


-- 
Thx and BRs,
Tengfei Fan

