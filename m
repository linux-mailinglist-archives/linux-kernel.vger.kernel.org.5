Return-Path: <linux-kernel+bounces-23768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DCA5682B16F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 16:09:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED3AF1C23FF2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 15:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E42714C623;
	Thu, 11 Jan 2024 15:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="R5E1PaX/"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B172C51C56;
	Thu, 11 Jan 2024 15:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40BDPqGc003982;
	Thu, 11 Jan 2024 15:07:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=oWks87PWyPYWEJUAAjYFQQFONgB+Y0XGxRoT0vf9C10=; b=R5
	E1PaX/bXt9a3werjDefHPYinnlPkuD5PWb5eF7/MGj95Q4gZ8oE1U6m9Up0g8PPw
	vhK7nyh8No2A2T6fpEjtEEuO79Px1RVrAz9yCMbPOoSBqyOi02T4CCuIfKSX2G3Z
	7HD77ff3Tax9Ric3MaraC1u38E6kTUXr20MWxB7hvLevNMbnoSw7+XztnGl5LexS
	iujxSv9/PHGcgTT6pYyTGmFeMM5XndhdQv1A7HxVxuSHSCyzrGKBpzjROOaRKjrU
	SIEXec20BuqMowmjUbGuknpcSELcjhSxCg3+Df7bTN/JJpP78K+KDUTrgDWdfEuw
	9Wc9okQQkQ4IgG2JL6xg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vjcvjrv7s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jan 2024 15:07:12 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40BF7Bgh028635
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jan 2024 15:07:12 GMT
Received: from [10.216.48.118] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 11 Jan
 2024 07:07:08 -0800
Message-ID: <cd223912-ac76-4b5d-93c3-92b1f89b9820@quicinc.com>
Date: Thu, 11 Jan 2024 20:37:03 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] watchdog: qcom: fine tune the max timeout value
 calculation
To: Guenter Roeck <linux@roeck-us.net>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Wim Van
 Sebroeck <wim@linux-watchdog.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-watchdog@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20240111-wdt-v1-1-28c648b3b1f3@quicinc.com>
 <73eda412-18cf-4c1e-8764-8341c2254659@roeck-us.net>
Content-Language: en-US
From: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
In-Reply-To: <73eda412-18cf-4c1e-8764-8341c2254659@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: SnzYX6LxjJPFeFK8ImCSLJP9Rfmp70Yt
X-Proofpoint-ORIG-GUID: SnzYX6LxjJPFeFK8ImCSLJP9Rfmp70Yt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 spamscore=0
 adultscore=0 mlxscore=0 suspectscore=0 impostorscore=0 lowpriorityscore=0
 malwarescore=0 phishscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2401110119



On 1/11/2024 8:21 PM, Guenter Roeck wrote:
> On 1/11/24 01:49, Kathiravan Thirumoorthy wrote:
>> To determine the max_timeout value, the below calculation is used.
>>
>>     max_timeout = 0x10000000 / clk_rate
>>
>> cat 
>> /sys/devices/platform/soc@0/b017000.watchdog/watchdog/watchdog0/max_timeout
>> 8388
>>
>> However, this is not valid for all the platforms. IPQ SoCs starting from
>> IPQ40xx and recent Snapdragron SoCs also has the bark and bite time field
>> length of 20bits, which can hold max up to 32 seconds if the clk_rate is
>> 32KHz.
>>
>> If the user tries to configure the timeout more than 32s, then the value
>> will be truncated and the actual value will not be reflected in the HW.
>>
>> To avoid this, lets add a variable called max_tick_count in the device 
>> data,
>> which defines max counter value of the WDT controller. Using this, 
>> max-timeout
>> will be calculated in runtime for various WDT contorllers.
>>
>> With this change, we get the proper max_timeout as below and restricts
>> the user from configuring the timeout higher than this.
>>
>> cat 
>> /sys/devices/platform/soc@0/b017000.watchdog/watchdog/watchdog0/max_timeout
>> 32
>>
>> Signed-off-by: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
> 
> [ ... ]
> 
>> @@ -268,11 +271,11 @@ static int qcom_wdt_probe(struct platform_device 
>> *pdev)
>>           wdt->wdd.bootstatus = WDIOF_CARDRESET;
>>       /*
>> -     * If 'timeout-sec' unspecified in devicetree, assume a 30 second
>> -     * default, unless the max timeout is less than 30 seconds, then use
>> +     * If 'timeout-sec' unspecified in devicetree, assume a 32 second
>> +     * default, unless the max timeout is less than 32 seconds, then use
>>        * the max instead.
>>        */
>> -    wdt->wdd.timeout = min(wdt->wdd.max_timeout, 30U);
>> +    wdt->wdd.timeout = min(wdt->wdd.max_timeout, 32U);
> 
> This is an unrelated change which would have to be discussed separately,
> in a separate patch. But I really don't see the point of it.


Ack, will revert this change in V2.


> 
> Guenter
> 

