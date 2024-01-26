Return-Path: <linux-kernel+bounces-40311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A98783DE40
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 17:04:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E53CB20E24
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 16:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 504991D6A4;
	Fri, 26 Jan 2024 16:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="me5TcXcA"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910B61CD1F;
	Fri, 26 Jan 2024 16:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706285031; cv=none; b=Hp9o6/sVIj0K8uRkseTmGvE3pHJyxRCtYSuErX+DPCpWem7HLpp3HPsngDfudTcTLZu4pE5nA1TDaAzJ58TZUh6vbNCaqVOSutVwiTSkPjffwQq7Hp53jhVvVUo5VdlUKRU9w+EKal/roTUYfU5nP6Z+5MvyfOgVaz37WQcooyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706285031; c=relaxed/simple;
	bh=a2FDYa8SVRiWVcXHltyA+EbeAgkQBMuaOsQcBHD69JU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=F6+OIYnBtdyITwdNppWMpTou6kvpfpp/tyMzwGoENivKt5l6afONUuwurwFTK9UE3ZOua4eKKKZHgX2zfIL6qhNsrWTfO/ipfSDmexpwmHyRXRMN4K7fmR9DBsJ3crA/AMcstqouItK/+c4RFGI+KAGQly+MLDGp49ec35Km/Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=me5TcXcA; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40QFHQ8J009101;
	Fri, 26 Jan 2024 16:03:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=BliTP1l+lG2LEeQXattTsm7SacSHWHKJM/bBgLnOkW0=; b=me
	5TcXcAkB5GNCBEM/HO4zzJXYg9veoD5ZbhvIPDCo/SbXaWW7a+Fuk56GsX62n2Fu
	XPVM+q1HQqan9FU7nOyaayBTDQuiUptBQ6Kl5RtCWH4Vm14zIwCeRtZaNVpmwuIM
	MY1uWufjqhMuARCjUOdyGUZGs6uovZCTAp7TRqpP51BI1SMFK1wNm85J+cRIaqjl
	39Ad7ODwP26atcw7iNfKRdrZzQftqEoeIMm4Die4Im/G72Y5qpypalIJ+1f0+9hY
	vrYai0NOOFahOnUhJhl6gks/yNzG4DePpycyMkGAn7laE8zJlwjK/hHG58PhMQrc
	lwlm/mamK49knkVAKZTQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vv8e88y5g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jan 2024 16:03:27 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40QG3QZ2015720
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jan 2024 16:03:26 GMT
Received: from [10.253.33.199] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 26 Jan
 2024 08:03:21 -0800
Message-ID: <5d778fc0-864c-4e91-9722-1e39551ffc45@quicinc.com>
Date: Sat, 27 Jan 2024 00:03:19 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next PATCH 0/3] net: mdio-ipq4019: fix wrong default MDC
 rate
Content-Language: en-US
To: Andrew Lunn <andrew@lunn.ch>
CC: Christian Marangi <ansuelsmth@gmail.com>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
	<pabeni@redhat.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Robert Marko <robert.marko@sartura.hr>,
        <linux-arm-msm@vger.kernel.org>, <netdev@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Sergey Ryazanov <ryazanov.s.a@gmail.com>
References: <20240124213640.7582-1-ansuelsmth@gmail.com>
 <53445feb-a02c-4859-a993-ccf957208115@quicinc.com>
 <f8a9e328-5284-4f24-be5d-7e9804869ecd@lunn.ch>
From: Jie Luo <quic_luoj@quicinc.com>
In-Reply-To: <f8a9e328-5284-4f24-be5d-7e9804869ecd@lunn.ch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: hkBudbvisV_pQZDINTb_7j5f9k_yVKxx
X-Proofpoint-ORIG-GUID: hkBudbvisV_pQZDINTb_7j5f9k_yVKxx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_14,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 spamscore=0 malwarescore=0 priorityscore=1501 mlxlogscore=573
 impostorscore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0
 clxscore=1015 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401260118



On 1/26/2024 1:18 AM, Andrew Lunn wrote:
>> Hi Christian,
>> Just a gentle reminder.
>>
>> The MDIO frequency config is already added by the following patch series.
>> https://lore.kernel.org/netdev/28c8b31c-8dcb-4a19-9084-22c77a74b9a1@linaro.org/T/#m840cb8d269dca133c3ad3da3d112c63382ec2058
> 
> I admit this version was posted first. However, its embedded in a
> patch series which is not making much progress, and i doubt will make
> progress any time soon.
> 
> If you really want your version to be used, please split it out into a
> standalone patch series adding just MDIO clock-frequency support, with
> its binding, and nothing else.
> 
>      Andrew

Hi Andrew,
We will rework the patch series to include only MDIO frequency related
function and frequency dt binding, and post the updated patch series
on the Monday/Tuesday of next week. We will work with Christian to 
ensure he can re-use this patch as well.

Thanks

