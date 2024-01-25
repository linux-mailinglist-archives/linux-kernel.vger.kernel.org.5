Return-Path: <linux-kernel+bounces-37849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2436183B67D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 02:19:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57BDD1C20E91
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 01:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD2A91877;
	Thu, 25 Jan 2024 01:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="QmUObi/E"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB59F7E1;
	Thu, 25 Jan 2024 01:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706145530; cv=none; b=TEEnT/Zyl5apFFXFjQJr+vmskj21+i5FZ38K6LwApmAcJJp/gsVPGYKwLcc8UJUP5FinvgKghGvHhLyAuG1H8GUhb1DIaLZ02PDzm/yNjkek64Ttz7uglfM3D3EZTCnLKolmr0Z+EOpA7vXfwPM1xoiawNwOnOe8VOFGNOXgp/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706145530; c=relaxed/simple;
	bh=wbqMyu7oZpMxsXU0lkcnp8wE0Oln4aYOrHTkE3a28Io=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=tOwVWkz7a/x2qsLBpRFiGF1401iTHlNuUWBZauc9hape3m5oeKXn+7bUSjRq3r6cn6S7m56TdNddefvYmJMrPpRHqqTumpgJDmw6Ni2Jp0l01OTFUIdn2Mp7seMPDopFYmCKgxas8x9+ODOw+wu8CQ/rnR7PHZBsCeQa6PXmoSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=QmUObi/E; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40P00VXD001043;
	Thu, 25 Jan 2024 01:18:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=HULk81uGrHcbYZWqBcEZRPGhmCUUJzUvPIETw8bfYLY=; b=Qm
	UObi/EiAuHIhT9iENN27QSuHtCG/f4oIP3ALU+71mKN+U+1u1XyGGcE/TP/8sPBf
	/82MD+o2gOMl4R9rXK4ORJUMkixLXTPzJTF/5ioVMHh5SPJrKX8zR9yheswC9aRI
	MEJDoy37JKvhTpt1WjnsychNe89nG+cnszlwrpEpgItI8S6QjBpDAgX6ohBZ+HPC
	XiWGVRkLuEGj94lt5zVhOFquskoba0gVwA/D6OGi0B4NetxtDD4DJtSMXUvTwD78
	49drJVJ8+rkGds5vMIX5S231RaqNV1KXIvkC8Szg1uSeFlegFLiJ0pHDTENIbcrc
	I+0vDrldX6Rf5T8RQnPA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vuavn8ac7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jan 2024 01:18:43 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40P1Igfk031425
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jan 2024 01:18:42 GMT
Received: from [10.239.132.204] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 24 Jan
 2024 17:18:36 -0800
Message-ID: <67e17efa-df15-45f0-9a13-873cbd8f7507@quicinc.com>
Date: Thu, 25 Jan 2024 09:18:34 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: pinctrl: qcom: modify the wrong
 compatible name
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <linus.walleij@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel@quicinc.com>
References: <20240124023305.15755-1-quic_tengfan@quicinc.com>
 <20240124023305.15755-2-quic_tengfan@quicinc.com>
 <CAA8EJpqkDcqjn-8HrK7=rRe49ycDY6fbNDCKKQOeUpa_EDjFtw@mail.gmail.com>
From: Tengfei Fan <quic_tengfan@quicinc.com>
In-Reply-To: <CAA8EJpqkDcqjn-8HrK7=rRe49ycDY6fbNDCKKQOeUpa_EDjFtw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: yC4lhn_mPc80TI_yf8zCcZLUopZk2TdI
X-Proofpoint-ORIG-GUID: yC4lhn_mPc80TI_yf8zCcZLUopZk2TdI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-24_12,2024-01-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 priorityscore=1501 mlxscore=0 bulkscore=0 malwarescore=0
 mlxlogscore=906 impostorscore=0 phishscore=0 adultscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401250008



On 1/24/2024 11:33 AM, Dmitry Baryshkov wrote:
> On Wed, 24 Jan 2024 at 04:33, Tengfei Fan <quic_tengfan@quicinc.com> wrote:
>>
>> Use right compatible name "qcom,sm4450-tlmm" instead of
>> "qcom,sm4450-pinctrl".
>>
>> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
>> ---
>>   Documentation/devicetree/bindings/pinctrl/qcom,sm4450-tlmm.yaml | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sm4450-tlmm.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sm4450-tlmm.yaml
>> index bb08ca5a1509..bb675c8ec220 100644
>> --- a/Documentation/devicetree/bindings/pinctrl/qcom,sm4450-tlmm.yaml
>> +++ b/Documentation/devicetree/bindings/pinctrl/qcom,sm4450-tlmm.yaml
>> @@ -17,7 +17,7 @@ allOf:
>>
>>   properties:
>>     compatible:
>> -    const: qcom,sm4450-pinctrl
>> +    const: qcom,sm4450-tlmm
> 
> Fixes: 7bf8b78f86db ("dt-bindings: pinctrl: qcom: Add SM4450 pinctrl")
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Thanks Dmitry. I will inside this "Fixes" tage into commit message in 
the next patch series.

> 
> 
>>
>>     reg:
>>       maxItems: 1
>> --
>> 2.17.1
>>
>>
> 
> 
> --
> With best wishes
> Dmitry

-- 
Thx and BRs,
Tengfei Fan

