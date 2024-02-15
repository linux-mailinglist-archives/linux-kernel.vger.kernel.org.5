Return-Path: <linux-kernel+bounces-66779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B8EF8561AC
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 12:35:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB569B34BF0
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 11:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F35F0129A8A;
	Thu, 15 Feb 2024 11:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="UOmLZR3g"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E767E53369;
	Thu, 15 Feb 2024 11:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707996262; cv=none; b=Q03rCQQRo+jaSN4Ff1OElow11wiGZrzsLiQ/6v9wHm6fdbp2xYZXdgZiUoyu+IZf0fMWto0Bi4ztHhJBr+WUt5QJ19qX1P7/gA2KneMvavjNR7EuQaZ+jIKNyVplU2oQI5vAbY7nzbMCb7akNJQA6pM3u9ZnarhKh3C02MAMr9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707996262; c=relaxed/simple;
	bh=T40Bb/okSk8xC07J0s4tBjEbaqfT+JQiYdFRe1exttY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=QWEIZxUsl5J3QkHg4OO+m2JGyRQaMNoMsS+w2CiWJ8y4jclN1g5pxIEwHYP5k1nahDf2Kh3Hxrq+5rA/yEMFsAOHnGNfhcPvMT+SvjvY+GDbw4yy7nJry371mJej9zJKuutNGAzrbIqQn9rVaHbh/lNmL4JvygwTU6mmx/izE18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=UOmLZR3g; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41F9lUf4022733;
	Thu, 15 Feb 2024 11:24:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=fuX4jRjU3Bu1HVqZnpt7tw+geePMvX9MHSSgoEALtGg=; b=UO
	mLZR3gkffoJ2mhbzUuQ7bnbQVrNwGIz6royeUIJrhgCSkXIhL970zQSx6ob1QcVr
	RC14NRAD6eFuA1R8B0npG3ngYma4PMDecU/0fj8RHlG99yE0wXeENeMedmiOJOaL
	WWI0ouTEIec78yAXTibissim6hl/QLgiHy1yJckYVvUBbhILKiBrFdDZDxUjdYkJ
	qy3QzvGjxmrE08rM19e0f9GgUXLbWqH3VAJ15glyx9+iGlbImbO4rgk0Qa8Ur6Sv
	SifauzqlCMvpxr6MpbifYH9iTI1T3Q1esy8M2i7L79GnWmNBlT8ZDEevVgGlNGSK
	R4zQqYxIXDmM8EKQVgcQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w9e4h0f0r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Feb 2024 11:24:17 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41FBOGDl027876
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Feb 2024 11:24:16 GMT
Received: from [10.217.198.224] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 15 Feb
 2024 03:24:15 -0800
Message-ID: <bc40a8b6-de9b-4715-90fa-94eabdc2102f@quicinc.com>
Date: Thu, 15 Feb 2024 16:54:12 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] soc: qcom: qcom_stats: Add DSPs and apss subsystem stats
Content-Language: en-US
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson
	<andersson@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240215-qcom_stats-v1-1-4a2cf83d0bdd@quicinc.com>
 <6ffa3094-ccbb-4947-9f28-e1437c9f500c@linaro.org>
From: "Maulik Shah (mkshah)" <quic_mkshah@quicinc.com>
In-Reply-To: <6ffa3094-ccbb-4947-9f28-e1437c9f500c@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 5M-CG8XxMQAiJFGmqk7wR5khkJaRlPUB
X-Proofpoint-ORIG-GUID: 5M-CG8XxMQAiJFGmqk7wR5khkJaRlPUB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-15_10,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 impostorscore=0 adultscore=0 mlxscore=0 phishscore=0 malwarescore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402150090

On 2/15/2024 3:24 PM, Konrad Dybcio wrote:
> On 15.02.2024 10:23, Maulik Shah wrote:
>> Add SMEM items for compute, general purpose DSPs and application processor
>> subsystem stats.
>>
>> Signed-off-by: Maulik Shah <quic_mkshah@quicinc.com>
>> ---
>>   drivers/soc/qcom/qcom_stats.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/soc/qcom/qcom_stats.c b/drivers/soc/qcom/qcom_stats.c
>> index 0216fc24f2ca..c429d5154aae 100644
>> --- a/drivers/soc/qcom/qcom_stats.c
>> +++ b/drivers/soc/qcom/qcom_stats.c
>> @@ -35,11 +35,15 @@ static const struct subsystem_data subsystems[] = {
>>   	{ "wpss", 605, 13 },
>>   	{ "adsp", 606, 2 },
>>   	{ "cdsp", 607, 5 },
>> +	{ "cdsp1", 607, 12 },
>> +	{ "gpdsp0", 607, 17 },
>> +	{ "gpdsp1", 607, 18 },
>>   	{ "slpi", 608, 3 },
>>   	{ "gpu", 609, 0 },
>>   	{ "display", 610, 0 },
>>   	{ "adsp_island", 613, 2 },
>>   	{ "slpi_island", 613, 3 },
>> +	{ "apss", 631, QCOM_SMEM_HOST_ANY },
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> 
Thanks for the review.

> Although, giving it a spin on 8280, it's not there.. It is there
> on 8450, but the reported count seems to coincide with cpuidle..
> roughly min{/sys/bus/cpu/devices/cpu*/cpuidle/state0/usage).
> 
> Konrad

yes apss stats should be available from sm8450 onward and count should 
(not necessarily) coincide with 
/sys/kernel/debug/pm_genpd/power-domain-cluster/idle_states, s1 usage 
count on sm8450.

DSP stats for gdsp0/gdsp1/cdsp1 are available in sa8775p.

Thanks,
Maulik

