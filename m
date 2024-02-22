Return-Path: <linux-kernel+bounces-76359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B17F585F623
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 11:52:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD4401C23FEC
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 10:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A934547F57;
	Thu, 22 Feb 2024 10:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="nOeyczLZ"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF95240BED;
	Thu, 22 Feb 2024 10:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708599068; cv=none; b=txEoq16OnZtBnLJPwh1HyHZeIGv/vdqMVlhM0LSgLZTlH0T3ETzVfQKJ+scsfYK1Q+yI9CER72bc/EHsAWoALMe6KPpqatNBYxPV5dDJ8x4cdmsg6X6JJWrU66bfUI5skQsPsYX1VQnqz178vp4+Vubxw5keUHpqNOqfZKrsiJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708599068; c=relaxed/simple;
	bh=raZuYxSJtMx0MudlT3SLEW4IpFq3EtsOEUU8cpEzvaE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=EyuXnckvOAJJPFj110Qfi0l4Hr2H6HfHQTtyrTi5qz8EzkzQCWlzGUkKeXPF8UPcrRDBVYYykBMcUW8COtEgmlNwiNKj05CnYEPmzOXgBTpGDZeOXOnZHyIgyMAZ5FxUa1CfrbA6m/papHUtIugmkmDRDeTc0Jmf1BUN2lnQqq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=nOeyczLZ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41M5lj6S008954;
	Thu, 22 Feb 2024 10:50:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=2JkTC+bXaqZFi/7GY4UexWzdKPeIW/dbKAv4pJ3f/Yg=; b=nO
	eyczLZoqYFh+ExkfQ4QkUFS1cLU88rbiJ80L9H0WELGb2jBE8i3q/LYOg81ka3jK
	PL2A71kjwdRMbBpeQHdgyncUwAmK25yrUqYGWbQDej1sXLPOrDsqd6VlJCZQ6EVQ
	yjA5PLLvGf8tZjtgdtIwLgYt5YvaqvNOpNxLHi0ffec0lRmB5IEUlEd8DgjdQvfn
	mSV/u7StoEhotYJj4gLxkraBglFDIPHejs9zs298B6P3kpeBwIjYNlNDMlVjR48n
	J6yDnYYeb5/WP7tCYZGHB6/vYzmJWZb2dWj+2T9McgYI5LpSKppK7tMUClsHlQx+
	IcXkUIz+fNBBzuAeb9gA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wdpe6t4hr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Feb 2024 10:50:57 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41MAou6R007593
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Feb 2024 10:50:56 GMT
Received: from [10.217.216.110] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 22 Feb
 2024 02:50:52 -0800
Message-ID: <4ad84f2c-a5c1-4c7c-a1b9-8376bb293f0b@quicinc.com>
Date: Thu, 22 Feb 2024 16:20:52 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] interconnect: qcom: sc7280: enable QoS
 configuration
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, <djakov@kernel.org>
CC: <rafael@kernel.org>, <corbet@lwn.net>, <linux-pm@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_viveka@quicinc.com>, <peterz@infradead.org>,
        <quic_mdtipton@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <konrad.dybcio@linaro.org>, <quic_rlaggysh@quicinc.com>
References: <20240205145606.16936-1-quic_okukatla@quicinc.com>
 <20240205145606.16936-3-quic_okukatla@quicinc.com>
 <ecdf3c46-77ba-443f-9d64-caf4dc67fc3a@linaro.org>
From: Odelu Kukatla <quic_okukatla@quicinc.com>
In-Reply-To: <ecdf3c46-77ba-443f-9d64-caf4dc67fc3a@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: NXnGpXFQWyaAdg9dcYoLGPMm8nEFnxbO
X-Proofpoint-ORIG-GUID: NXnGpXFQWyaAdg9dcYoLGPMm8nEFnxbO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_08,2024-02-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 adultscore=0 mlxlogscore=999 clxscore=1015 bulkscore=0 spamscore=0
 impostorscore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402220084



On 2/5/2024 8:42 PM, Krzysztof Kozlowski wrote:
> On 05/02/2024 15:56, Odelu Kukatla wrote:
>> Enable QoS configuration for the master ports with predefined values
>> for priority and urgency.
>>
>> Signed-off-by: Odelu Kukatla <quic_okukatla@quicinc.com>
>> ---
>>  drivers/interconnect/qcom/sc7280.c | 332 +++++++++++++++++++++++++++++
>>  1 file changed, 332 insertions(+)
>>
>> diff --git a/drivers/interconnect/qcom/sc7280.c b/drivers/interconnect/qcom/sc7280.c
>> index 7d33694368e8..438f927935e5 100644
>> --- a/drivers/interconnect/qcom/sc7280.c
>> +++ b/drivers/interconnect/qcom/sc7280.c
>> @@ -1,6 +1,7 @@
>>  // SPDX-License-Identifier: GPL-2.0
>>  /*
>>   * Copyright (c) 2021, The Linux Foundation. All rights reserved.
>> + * Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved.
>>   *
>>   */
>>  
>> @@ -16,29 +17,53 @@
>>  #include "icc-rpmh.h"
>>  #include "sc7280.h"
>>  
>> +static struct qcom_icc_qosbox qhm_qspi_qos = {
> 
> Why this cannot be const?
> 

I am addressing this in V3.

>> +	.num_ports = 1,
>> +	.port_offsets = { 0x7000 },
>> +	.prio = 2,
>> +	.urg_fwd = 0,
> 
> 
> Best regards,
> Krzysztof
> 

Thanks,
Odelu

