Return-Path: <linux-kernel+bounces-52386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38854849764
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 11:10:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E82CD288C96
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 10:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C2971643E;
	Mon,  5 Feb 2024 10:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="KOIP+6Se"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B3313FE4;
	Mon,  5 Feb 2024 10:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707127824; cv=none; b=uwOiVk60/LV40RRGTHdH0fOhFQyKGLBVXrch+ZbrrNTHOl7F5r1X4bBw0p9eDBT0hxT8gP1aXN1YE5cXVpaMYTedqJI80A/YaZgGqvlqRlHr5+oRs9/OhOo2vLQwmm+s8yaH1lSRSwVUMT9bJ4AL2igFjggKnhSOqXHF1ocj9oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707127824; c=relaxed/simple;
	bh=5RSD9ihk588Ph/D1+uaXhR/80luu6z5MzJa3QKltexQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=H9Wlqpwn+yzI4dXMXPKgWd3JmCwiTEnaQ7X6bl7nCrTZC3XYKZQM1DNJhljvvflxRgJP95Vrn6xS2zNfCF1olSd540pBmv6gaou0bTGVd/ucRd9q/6n6lJ9SCALF1Ex45jI6hjr2wNPpspnrBhh9ys4xET3vyPKZhUczbjqxB/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=KOIP+6Se; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4158U4l7012947;
	Mon, 5 Feb 2024 10:10:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=Hgz3t7yBwgrnAiXaxk4/deI134kNYfYdBcxbAKmwBEk=; b=KO
	IP+6SeXAjTf1Y685vyx9GrIV0y3FShJNCv7X7keMv3H2azOjJyVw7CJ5Wa8/ALan
	I9MGDW7ya410J8U6mowmC47xm6Qe4iiWfWezizgJEEkUu3Uz/2sF/pkbOv1sdaik
	yz49e+an8EeR4dyV3v9jHaHpVAHDFH9Vk9nDOpD4zUfz2WdMBxtz99B7z57QwgPu
	XfNq5RAobSVhLjd6S3F2a1ZbnBJmRA9h2TzHv4wZeiboupFTMqp7XXE9BYulhhJT
	f980Qne2oS8d2OgdHKqhloQNaaGkBXWIUXPSABIHcLkLR4QYhJ+QLxqfeIr22xDH
	fN0rVpOypXcfz+NRm5Mg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w2v7286em-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Feb 2024 10:10:18 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 415AAHNG008640
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 5 Feb 2024 10:10:17 GMT
Received: from [10.239.132.204] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 5 Feb
 2024 02:10:12 -0800
Message-ID: <f5ab4243-dd74-4b34-87c4-0073f5585151@quicinc.com>
Date: Mon, 5 Feb 2024 18:10:10 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/6] soc: qcom: socinfo: add SoC Info support for
 QCM8550 and QCS8550 platform
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <dmitry.baryshkov@linaro.org>
CC: <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel@quicinc.com>
References: <20240119100621.11788-1-quic_tengfan@quicinc.com>
 <20240119100621.11788-4-quic_tengfan@quicinc.com>
 <04fa81b1-e47e-4cf9-8e59-3a1777a13879@linaro.org>
From: Tengfei Fan <quic_tengfan@quicinc.com>
In-Reply-To: <04fa81b1-e47e-4cf9-8e59-3a1777a13879@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ZW6phdW6nUAmtJ5LGeXvCd8a1BDjgt_x
X-Proofpoint-ORIG-GUID: ZW6phdW6nUAmtJ5LGeXvCd8a1BDjgt_x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-05_05,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 clxscore=1015 spamscore=0
 mlxscore=0 priorityscore=1501 bulkscore=0 suspectscore=0 mlxlogscore=480
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402050077



On 2/5/2024 4:04 PM, Krzysztof Kozlowski wrote:
> On 19/01/2024 11:06, Tengfei Fan wrote:
>> Add SoC Info support for QCM8550 and QCS8550 platform.
>>
>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
> 
> NAK.
> 
> Drop my tag.
> 
> Best regards,
> Krzysztof
> 

This patch has been applied by Bjorn.

Should I remove your tag only, or do I need to do other processing?

-- 
Thx and BRs,
Tengfei Fan

