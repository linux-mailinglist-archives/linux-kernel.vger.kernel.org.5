Return-Path: <linux-kernel+bounces-109967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77736885858
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 12:29:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35B7C1F21444
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 11:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9783C58AC6;
	Thu, 21 Mar 2024 11:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Y8VKxyX3"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D20F5821C;
	Thu, 21 Mar 2024 11:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711020576; cv=none; b=hJLidDsWyqZ4t6hsRZHFQwhl7JpqtTMGvMRwWTxIgHR5caDKNIGwsV4BV7jIB1vfMOktCC/8vza+ofb+Q6KkRV0p6Gsf8mgSxMQwYMjQuP7ElWDiSZpsWS+IVZff77ZtEeyIlCySKEzd6SwLVd1Zgpzz197KFzcVKtR+mxu79Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711020576; c=relaxed/simple;
	bh=uL6O1JHZDqhY19AXXUj5funrzm7vJfF2V5x3ffL2ujU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=TgneubEojX+dBGzWjFGXJrpLR6wU+8C5taoJlET5zCbws1oej7uQ2sCHKROD98Tae0GcqoRgli+CLo6mMfpDkxCYhs3tQ8bERyV98RERlmCsMdh/GGxdcd4tLy9GaXgqL0BxG/0w8960dPtcbNqP6uGmY1tcAUfWww3Sp90WWDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Y8VKxyX3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42L7Z717002282;
	Thu, 21 Mar 2024 11:29:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=7okcB99RuHJ+Ag1hDqSPyvTocXpjEnblUvaqIByGWWQ=; b=Y8
	VKxyX3DVvn0rh75BWMOd9l42CrD5Ukxj6iqTB75vGBRtzn6AGQ1+mGCXsJMlPGRU
	QXSuPNpspMbLIhdV22uQ/TYTTakdOLX4rW5pUr67gC/vipGES8B1vdQmNeR/YYoL
	dzObCw37VTdzeVXJNdrJfmQqbUL3m0wdk6W0jHsl3Drsw7d0Ug/nDV/mxeTaY4L2
	RbnOzAIqZyF1wq93bqJS+bCc3tunFLp+LHzxZCvEsXEd3wnq1hxBhI7LbgGZ7gPG
	w5eq1+5DbdcIvtdqc5FnXcLXTApeP4CH+PQcQODBxCubFPV/rK9IsjJPFWFSVLOC
	lsXdhPtMDvI3cY13sntw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x0f1ngpa1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Mar 2024 11:29:30 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42LBTJPJ013542
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Mar 2024 11:29:19 GMT
Received: from [10.218.5.19] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 21 Mar
 2024 04:29:13 -0700
Message-ID: <2fb1c144-afac-42f2-a4b8-4b5453d95274@quicinc.com>
Date: Thu, 21 Mar 2024 16:58:53 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 RESEND 4/6] dt-bindings: clock: qcom: Add SM8650 camera
 clock controller
To: Johan Hovold <johan@kernel.org>
CC: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Taniya Das
	<quic_tdas@quicinc.com>,
        Satya Priya Kakitapalli <quic_skakitap@quicinc.com>,
        Ajit Pandey <quic_ajipan@quicinc.com>,
        Imran Shaik
	<quic_imrashai@quicinc.com>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>
References: <20240321092529.13362-1-quic_jkona@quicinc.com>
 <20240321092529.13362-5-quic_jkona@quicinc.com>
 <ZfwJ1cgFLlWdj7xp@hovoldconsulting.com>
Content-Language: en-US
From: Jagadeesh Kona <quic_jkona@quicinc.com>
In-Reply-To: <ZfwJ1cgFLlWdj7xp@hovoldconsulting.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 66cnI_-yPyEhFdhDcE9qq0an2MjVcn40
X-Proofpoint-ORIG-GUID: 66cnI_-yPyEhFdhDcE9qq0an2MjVcn40
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-21_08,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 bulkscore=0 mlxlogscore=969 adultscore=0 malwarescore=0 spamscore=0
 suspectscore=0 clxscore=1011 lowpriorityscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403140001 definitions=main-2403210081



On 3/21/2024 3:50 PM, Johan Hovold wrote:
> On Thu, Mar 21, 2024 at 02:55:27PM +0530, Jagadeesh Kona wrote:
>> Add device tree bindings for the camera clock controller on
>> Qualcomm SM8650 platform.
>>
>> Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> Did Krzysztof really review this version?
> 

Thanks Johan for your review.

I carry forwarded the R-B tag from earlier version. Will fix the below 
comments and post the next series.

Thanks,
Jagadeesh

>> @@ -18,6 +19,7 @@ description: |
>>       include/dt-bindings/clock/qcom,sm8550-camcc.h
>>       include/dt-bindings/clock/qcom,sc8280xp-camcc.h
>>       include/dt-bindings/clock/qcom,x1e80100-camcc.h
>> +    include/dt-bindings/clock/qcom,sm8650-camcc.h
> 
> This does not look like alphabetical order.
> 
>>   allOf:
>>     - $ref: qcom,gcc.yaml#
>> @@ -29,6 +31,7 @@ properties:
>>         - qcom,sm8450-camcc
>>         - qcom,sm8550-camcc
>>         - qcom,x1e80100-camcc
>> +      - qcom,sm8650-camcc
> 
> And neither does this.
> 
> Johan
> 

