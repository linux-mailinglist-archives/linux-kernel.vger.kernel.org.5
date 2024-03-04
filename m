Return-Path: <linux-kernel+bounces-91185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 434B3870ACD
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 20:36:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3ED7282743
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 19:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3A1A79DA5;
	Mon,  4 Mar 2024 19:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="RgC1/X7e"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B770E78664;
	Mon,  4 Mar 2024 19:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709580959; cv=none; b=RhO+NgXLDetWMShGSSBpNA79eclt5L/XPqCVzOrP4XxlBrx+oQtKF0TgyC23uxg6c3y2rmgqlAzNE3qLHgaA6F3uIkqndDZZwIHClEVRuoa7AR1DtQk2yQqcwGh30+FfPpJh4tPqqMg5/a4k6GhdEhyTOUdAlReZy3TNunzBI64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709580959; c=relaxed/simple;
	bh=AWwt9iWslA/+2HB0N1qeBZ0N+tWGyi7ScfyPtfMBDqI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ozfM2hIU/iEFe7ESUALE5iOnkqmopu257AAS4UHG5DFmHLD9ULzCyRqfZlnyxoNP7Nlc6VAh4lOyiJnGEzE4+Fw+JK1gxEaPPKtThUEErQYuF+KrGalAYfkVNs2HmM9f97JPPClbugix6QbZmc47aLwE9Gm7fNjG0A4CTb0Um6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=RgC1/X7e; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 424HlVAO026348;
	Mon, 4 Mar 2024 19:35:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=qcppdkim1; bh=roM4l3ctcAaYii9wFZPAF
	0RE2wcIuL57dvuM5l1K7lk=; b=RgC1/X7esUR/Pz/MXpwdIr38qGv0Ps+HelQPA
	h48kG18M5ocojtFNaVPMP2ejV7HTa9i5dQebpD0Fb9H0t6SbNSufoHxwhohbuYM6
	INu/XH9cbnOR/ayW7aKPe3TPR0vqD/RxVxwu4rrI9S3QqsNyzB6Z6lTj0mmXbzlh
	Qi4xOsrOKaiwtzToGty5GNcCcDYd8Sfxsr3ZATpTw+MeNKBOEIsiZvyOMRcVk5AF
	PuRpktEt0FzyjWjUZblL6Ta600UCGdbkm6UcR5F4y0MMJ9IpgxEPjmP78LDdOQqC
	AflYJIJ2kS2tyLdAJ8cbEKvHIxImvx4+QLv+UMRlvArf1GhMw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wn96esjmw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Mar 2024 19:35:37 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 424JZbDh011531
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 4 Mar 2024 19:35:37 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 4 Mar 2024 11:35:18 -0800
Date: Mon, 4 Mar 2024 11:35:17 -0800
From: Bjorn Andersson <quic_bjorande@quicinc.com>
To: Canfeng Zhuang <quic_czhuang@quicinc.com>
CC: Derek Kiernan <derek.kiernan@amd.com>,
        Dragan Cvetic
	<dragan.cvetic@amd.com>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>,
        Bjorn Andersson <andersson@kernel.org>,
        "Konrad
 Dybcio" <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH 0/2] QCOM QRC device driver
Message-ID: <20240304193517.GA4014015@hu-bjorande-lv.qualcomm.com>
References: <20240304-qcom_qrc-v1-0-2a709f95fd61@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240304-qcom_qrc-v1-0-2a709f95fd61@quicinc.com>
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: a-mrT3blGKGjGbxzQc-VMt5AqHPkoBTI
X-Proofpoint-GUID: a-mrT3blGKGjGbxzQc-VMt5AqHPkoBTI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-04_15,2024-03-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 malwarescore=0
 mlxscore=0 impostorscore=0 clxscore=1011 mlxlogscore=999
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403040150

On Mon, Mar 04, 2024 at 12:53:15AM +0800, Canfeng Zhuang wrote:
> QCOM QRC device driver is used for Robotic SDK MCU
> 

Please review go/upstream and have your patches reviewed on the internal
list before posting to the public mailing lists.

Thank you,
Bjorn

> [commit]misc: qualcomm: QRC driver for Robotic SDK MCU
> This commit is used to enable robotic controller device driver.
> QRC Driver support functions:
> - Read data from serial device port.
> - Write data to serial device port.
> - Pin control reset robotic controller.
> 
> [commit]dt-bindings: misc: merge qcom,qrc
> This commit is used to support qcom qrc devicetree binding.
> 
> Signed-off-by: Canfeng Zhuang <quic_czhuang@quicinc.com>
> ---
> Canfeng Zhuang (2):
>       misc: qualcomm: QRC driver for Robotic SDK MCU
>       dt-bindings: misc: merge qcom,qrc
> 
>  .../devicetree/bindings/misc/qcom,qrc.yaml         |  32 ++
>  drivers/misc/Kconfig                               |   1 +
>  drivers/misc/Makefile                              |   1 +
>  drivers/misc/qrc/Kconfig                           |  16 +
>  drivers/misc/qrc/Makefile                          |   6 +
>  drivers/misc/qrc/qrc_core.c                        | 336 ++++++++++++++++++++
>  drivers/misc/qrc/qrc_core.h                        | 143 +++++++++
>  drivers/misc/qrc/qrc_uart.c                        | 345 +++++++++++++++++++++
>  8 files changed, 880 insertions(+)
> ---
> base-commit: 805d849d7c3cc1f38efefd48b2480d62b7b5dcb7
> change-id: 20240304-qcom_qrc-778c8fad8846
> 
> Best regards,
> -- 
> Canfeng Zhuang <quic_czhuang@quicinc.com>
> 

