Return-Path: <linux-kernel+bounces-42340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8618E83FFE2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 09:19:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B906D1C232D2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 08:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 373CE52F9E;
	Mon, 29 Jan 2024 08:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="N5ZfhKub"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF23537EA;
	Mon, 29 Jan 2024 08:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706516345; cv=none; b=ILT+xmoUpMDo27gcOX/C1MXtpe1w9QBWqbkMbIqRhGxXcNOJ1LpuylPI1UoW3RSbH4WV03o9xGsm1xpqUKxxJAuiKJWMx47JFaCtOl3UavQPsidgKTK402lKUZhRYXrHw6PUJ52MDr5q/Mcrncqs17Bkxgtn5VLimAWZxCzg7gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706516345; c=relaxed/simple;
	bh=Wltv3IcF4GiJwkC0spp3IeKWcmLfqFMKNnqdYsxaHYI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=KB9ZQmoiuj5RKLeToKoA7Xwqgr9lE0250WqtMe/AZ7UeXrazHrz/cDyqXrcC3G5Hp7SkyNcUtSjEdAJl0ABcTXNRKJYeiDUDZcwlxmbFYNsNBLw7mc+gRaEIOrNURiydFmxmwpyQmZnRknMO52PhYHHCP062v6JecBfgdMgT7e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=N5ZfhKub; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40T6mMT4009270;
	Mon, 29 Jan 2024 08:18:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=M4mWjMiuS2Jg4y+4lTwMuCIV8p9H63+kb0jufrdS76Q=; b=N5
	ZfhKubZbDKLFqlcSQVlUIIAfGGTYSJ3LRssmHgyZIQTQJmM00MJ+6NoTdLi0BEFB
	WSRwAHNNLdQssTxKdnBbKIaEoRT30tw9E7WKWpZIK3sAshmhi3XMemquDDGhvhwC
	s/0KZq+5MxjymnIgWzdoxLiYSqm5KkIqCGo0mQsFt2Va3eTCemZ0xBamEr0/jIV7
	Y4wQPOxtu6zqV7SgCNL/2YNc8vufCxQZ10OfcoXzyReFqL9tEwSKUP5+0FyWupuj
	DwHgC4SVgkvxTTnw8/YRJe6UHnvLv9PiAUn5yTzZ8t4UCXy8l9w99/GztBVN9BQW
	lOMyFkv38wsRfhfYIenQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vvt2734a3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jan 2024 08:18:55 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40T8ItGZ028794
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jan 2024 08:18:55 GMT
Received: from [10.239.132.204] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 29 Jan
 2024 00:18:49 -0800
Message-ID: <842bf6ad-46e1-43d8-86be-79ab0f49710b@quicinc.com>
Date: Mon, 29 Jan 2024 16:18:47 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/6] arm64: dts: qcom: aim300: add AIM300 AIoT
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <dmitry.baryshkov@linaro.org>
CC: <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel@quicinc.com>,
        Qiang Yu
	<quic_qianyu@quicinc.com>,
        Ziyue Zhang <quic_ziyuzhan@quicinc.com>
References: <20240119100621.11788-1-quic_tengfan@quicinc.com>
 <20240119100621.11788-7-quic_tengfan@quicinc.com>
 <d3ef45cf-2de8-4f5b-8857-62d1996f3f58@linaro.org>
From: Tengfei Fan <quic_tengfan@quicinc.com>
In-Reply-To: <d3ef45cf-2de8-4f5b-8857-62d1996f3f58@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: GFvjIMrBw-IAX8pgqYDqSMZVedBCa_v-
X-Proofpoint-ORIG-GUID: GFvjIMrBw-IAX8pgqYDqSMZVedBCa_v-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-29_04,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 phishscore=0 suspectscore=0 lowpriorityscore=0 mlxlogscore=485
 clxscore=1015 spamscore=0 mlxscore=0 impostorscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401290059



On 1/29/2024 4:09 PM, Krzysztof Kozlowski wrote:
> On 19/01/2024 11:06, Tengfei Fan wrote:
>> Add AIM300 AIoT board DTS support, including usb, serial, PCIe, mpss,
>> adsp, cdsp and sound card functions support.
>>
> 
> ...
> 
>> +
>> +	sound {
>> +		compatible = "qcom,sm8550-sndcard", "qcom,sm8450-sndcard";
>> +		model = "AIM300-AIOT";
>> +		audio-routing = "SpkrLeft IN", "WSA_SPK1 OUT",
>> +				"SpkrRight IN", "WSA_SPK2 OUT",
>> +				"IN1_HPHL", "HPHL_OUT",
>> +				"IN2_HPHR", "HPHR_OUT",
>> +				"AMIC2", "MIC BIAS2",
>> +				"VA DMIC0", "MIC BIAS1",
>> +				"VA DMIC1", "MIC BIAS1",
>> +				"VA DMIC2", "MIC BIAS3",
>> +				"TX DMIC0", "MIC BIAS1",
>> +				"TX DMIC1", "MIC BIAS2",
>> +				"TX DMIC2", "MIC BIAS3",
>> +				"TX SWR_ADC1", "ADC2_OUTPUT";
> 
> This should be probably TX SWR_INPUT1.
> 
> Best regards,
> Krzysztof
> 

I will double check this with related team and I will update this.

-- 
Thx and BRs,
Tengfei Fan

