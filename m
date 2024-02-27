Return-Path: <linux-kernel+bounces-82756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3B2C868921
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 07:47:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 994A228482D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 06:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FA04537EE;
	Tue, 27 Feb 2024 06:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="B/F9pSkr"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3984DA0F;
	Tue, 27 Feb 2024 06:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709016450; cv=none; b=tx/zVCVOMkAVhXn87/a1CGANwujm4XAcejbc7J2v4RZi9X8OxgIjigAuTGVs2WPHUtEIao8MxH6BVZdipeiYVRb2FIddiq3dhz50sjnnxFUAQWUvVzHJnGGbTczGpcXr6pz8/4vov7CQnYVgxS+F/dI7kYV9SNj5twMRe7jKB+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709016450; c=relaxed/simple;
	bh=CgqML60LicyyecSPHKCPprKS1ES+SeKDnEDVlBXLz+M=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=bvj3ESsKBPU6UevD/SwvOxc3buc5RrAg7tnkkU8MAMc8qITc9Xyp+/6TXnKOfRS8O4salE2T1CgKm/4gWrmvLP4/GOa+I3HNNYKOxM2xmv0JE9OJOTvpqy0Dlu4k53RtsBRm9skhSv+kQ2na9bbv4N4MhOA1wVIp3R6CETyea/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=B/F9pSkr; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41R3wHqX023578;
	Tue, 27 Feb 2024 06:47:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=GVlRqYEBafsXxkeD2Y5NwpTYZnw3z1chquQtrnGlgUY=; b=B/
	F9pSkrmMx82dYnZO/1ukdnneQ+OqtWOciuzC8HmMAQpIpP3Yr2fToO2jcXOWymi/
	L2WqiXpcuqW6SDSmEknq2ExYE19jff0vxOBRVszKqc7QcJqZUjMOHY7rdAUrvHFB
	1fOFoqoZHkKFfBygYdzdzG45MVGGyjJprx0Zital6PRAj6Z7UIES8LusZciZV9x8
	PvPPfaxuYTrgj75MROvGtm7W7uXp+nsStAldNA6r5v3tM/DmZkuGWGyo23hX+556
	DJY37Awv+A5mwO9cGwDU+/WhvMrmyCjOa2Ppa+B0KLxUV/K90sT3RZV4BSiAJ+cB
	m6JkxdsLq5NgOc1B4upQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wh89t0a00-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Feb 2024 06:47:24 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41R6lNSO030718
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Feb 2024 06:47:23 GMT
Received: from [10.214.66.209] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 26 Feb
 2024 22:47:17 -0800
Message-ID: <09b7aa90-1cbb-42e0-a3e7-62d4c7ec9afb@quicinc.com>
Date: Tue, 27 Feb 2024 12:16:55 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: arm: qcom: Document rb5gen2-hdk board
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel@quicinc.com>
References: <20240202133638.4720-1-quic_wasimn@quicinc.com>
 <20240202133638.4720-2-quic_wasimn@quicinc.com>
 <c9dcbb3b-90eb-4e41-93cf-859d74cf57ea@linaro.org>
Content-Language: en-US
From: Wasim Nazir <quic_wasimn@quicinc.com>
In-Reply-To: <c9dcbb3b-90eb-4e41-93cf-859d74cf57ea@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: g5pvopohDWHGDmQ_z0JgyWWlsqGCm1qN
X-Proofpoint-GUID: g5pvopohDWHGDmQ_z0JgyWWlsqGCm1qN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-26_11,2024-02-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 malwarescore=0 mlxscore=0 phishscore=0
 adultscore=0 spamscore=0 impostorscore=0 bulkscore=0 mlxlogscore=783
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402270053



On 2/2/2024 8:04 PM, Krzysztof Kozlowski wrote:
> On 02/02/2024 14:36, Wasim Nazir wrote:
>> Document board bindings for Rb5 gen2 hardware development kit.
>> Rb5gen2-HDK is using Rb5 gen2 SOM which is based on QCS8550 SoC.
>> RB5gen2-HDK is development kit used for IOT solutions.
>>
>> Signed-off-by: Wasim Nazir <quic_wasimn@quicinc.com>
>>
>> diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
>> index 9cee874a8eae..ce5b5dfe0e46 100644
>> --- a/Documentation/devicetree/bindings/arm/qcom.yaml
>> +++ b/Documentation/devicetree/bindings/arm/qcom.yaml
>> @@ -104,6 +104,7 @@ description: |
>>           qcp
>>           qrd
>>           rb2
>> +        rb5gen2-hdk
> 
> I think we decided to stop growing this, especially that "rb5gen2-hdk"
> does not look generic type of a board.
> 
Will remove this in next patch version.

>> --
>> 2.43.0
>>
> 
> Best regards,
> Krzysztof
> 

Thanks & regards,
Wasim

