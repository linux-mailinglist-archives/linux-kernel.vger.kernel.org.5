Return-Path: <linux-kernel+bounces-83473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B82438699E8
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 16:10:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA1731C241C1
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 15:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9597814A4DD;
	Tue, 27 Feb 2024 15:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="LlOiVQRF"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 436CF14A4C1;
	Tue, 27 Feb 2024 15:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709046453; cv=none; b=fJUv12b8Gu/pqU87vm84gEsFlRozl4u4InuNjv7LW7ORiyvaYsIrsZn43cHyDUHoNWeIJ76XvYaXpoEyeaRIIXSha9suvnN3Mobd74KM+h+FziEkljmt22XU4cOXk45GzvO348oZoOiGA/1pBWdvPVKdNNT++SmZMTuEF4d8iZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709046453; c=relaxed/simple;
	bh=nbBHPd7hWnt+9fYQpHo+4Cb/SCBb82djYs8mBUn7M3s=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=b0NmLj+y1MXJOXdSHAPBv12ugay1lig64DKfyosXwmMXIoe4OYl9ELHJgodfDJUE0Zkor0K/JPtnscrEeuAO6WdLbyjw5kVqlLuoZGResu1eQCVjcK0Je/EPq9yp5H6Nw7QlU0Ev1im93JuXpqf5K5QlJsFh1I63cErQLSjGXoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=LlOiVQRF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41RBjuWF011343;
	Tue, 27 Feb 2024 15:07:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:from:to:cc:references
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=u9sTptxpOGNQHmo+HL35UVlPPUynBEERtiX8yI981Ko=; b=Ll
	OiVQRFHPm/nyxkkAPb8BD/BVtUdTA1VVFij/PheD0+xu8Ux2Yr3p7L2C9gTL3SQF
	KSBhl+k8G1Y1DbD4T4BsJw3C/3Zw6c29fuLBhENUtWqsyZh6xDHT9528ELrR1+r5
	YR4fPZrz8biPemT4XkP0cu76Vs+k+pkQhbjkNUfVCz+xrLL6rf9RAAO+n4btn03y
	6Y7RQHgA9S/Ezlsnl78Hm5zQrqtGZWUc6g05dmnWV8ohPEXkTv05ut92bIkCipMI
	+cmBR+GekmpJCwsbpYc7Oct6TamabQ0HtQ/iQRNJvc/z+yhw4tUAfaSlzBLGu7qU
	XK+oLcfqntKWmreJo0+g==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3whd7b0s58-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Feb 2024 15:07:15 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41RF74Pp021840
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Feb 2024 15:07:04 GMT
Received: from [10.216.43.248] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 27 Feb
 2024 07:07:01 -0800
Message-ID: <9f084781-2233-4b36-8b1c-db1fa9a9db49@quicinc.com>
Date: Tue, 27 Feb 2024 20:36:56 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] watchdog: qcom: fine tune the max timeout value
 calculation
Content-Language: en-US
From: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
To: Guenter Roeck <linux@roeck-us.net>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Wim Van
 Sebroeck <wim@linux-watchdog.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-watchdog@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20240116-wdt-v2-1-501c7694c3f0@quicinc.com>
 <2c4f9829-138d-41a5-8810-d13cf749fded@roeck-us.net>
 <67ed3805-40cb-4f00-9d0d-b0fd012d6221@quicinc.com>
In-Reply-To: <67ed3805-40cb-4f00-9d0d-b0fd012d6221@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: eq9d10-VwcsDL5E0n_LL7x96ZGksmBKy
X-Proofpoint-ORIG-GUID: eq9d10-VwcsDL5E0n_LL7x96ZGksmBKy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-27_01,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 impostorscore=0
 mlxlogscore=999 priorityscore=1501 spamscore=0 adultscore=0 malwarescore=0
 mlxscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2402120000
 definitions=main-2402270117



On 2/3/2024 12:07 PM, Kathiravan Thirumoorthy wrote:
> 
> 
> On 1/16/2024 8:32 PM, Guenter Roeck wrote:
>> On 1/16/24 00:22, Kathiravan Thirumoorthy wrote:
>>> To determine the max_timeout value, the below calculation is used.
>>>
>>>     max_timeout = 0x10000000 / clk_rate
>>>
>>> cat 
>>> /sys/devices/platform/soc@0/b017000.watchdog/watchdog/watchdog0/max_timeout
>>> 8388
>>>
>>> However, this is not valid for all the platforms. IPQ SoCs starting from
>>> IPQ40xx and recent Snapdragron SoCs also has the bark and bite time 
>>> field
>>> length of 20bits, which can hold max up to 32 seconds if the clk_rate is
>>> 32KHz.
>>>
>>> If the user tries to configure the timeout more than 32s, then the value
>>> will be truncated and the actual value will not be reflected in the HW.
>>>
>>> To avoid this, lets add a variable called max_tick_count in the 
>>> device data,
>>> which defines max counter value of the WDT controller. Using this, 
>>> max-timeout
>>> will be calculated in runtime for various WDT contorllers.
>>>
>>> With this change, we get the proper max_timeout as below and restricts
>>> the user from configuring the timeout higher than this.
>>>
>>> cat 
>>> /sys/devices/platform/soc@0/b017000.watchdog/watchdog/watchdog0/max_timeout
>>> 32
>>>
>>> Signed-off-by: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
>>
>> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> 
> 
> Guenter / Will, Can this be picked for v6.9? I don't see this in linux- 
> next yet, so please consider this as a gentle reminder!


Guenter / Will, Gentle Reminder... is this change queued for v6.9?


> 
>>
>>> ---
>>> Changes in v2:
>>> - drop the minimum timeout change from 30s to 32s
>>> - Link to v1: 
>>> https://lore.kernel.org/r/20240111-wdt-v1-1-28c648b3b1f3@quicinc.com
>>> ---
>>>   drivers/watchdog/qcom-wdt.c | 7 +++++--
>>>   1 file changed, 5 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/watchdog/qcom-wdt.c b/drivers/watchdog/qcom-wdt.c
>>> index 9e790f0c2096..006f9c61aa64 100644
>>> --- a/drivers/watchdog/qcom-wdt.c
>>> +++ b/drivers/watchdog/qcom-wdt.c
>>> @@ -41,6 +41,7 @@ static const u32 reg_offset_data_kpss[] = {
>>>   struct qcom_wdt_match_data {
>>>       const u32 *offset;
>>>       bool pretimeout;
>>> +    u32 max_tick_count;
>>>   };
>>>   struct qcom_wdt {
>>> @@ -177,11 +178,13 @@ static const struct watchdog_info 
>>> qcom_wdt_pt_info = {
>>>   static const struct qcom_wdt_match_data match_data_apcs_tmr = {
>>>       .offset = reg_offset_data_apcs_tmr,
>>>       .pretimeout = false,
>>> +    .max_tick_count = 0x10000000U,
>>>   };
>>>   static const struct qcom_wdt_match_data match_data_kpss = {
>>>       .offset = reg_offset_data_kpss,
>>>       .pretimeout = true,
>>> +    .max_tick_count = 0xFFFFFU,
>>>   };
>>>   static int qcom_wdt_probe(struct platform_device *pdev)
>>> @@ -236,7 +239,7 @@ static int qcom_wdt_probe(struct platform_device 
>>> *pdev)
>>>        */
>>>       wdt->rate = clk_get_rate(clk);
>>>       if (wdt->rate == 0 ||
>>> -        wdt->rate > 0x10000000U) {
>>> +        wdt->rate > data->max_tick_count) {
>>>           dev_err(dev, "invalid clock rate\n");
>>>           return -EINVAL;
>>>       }
>>> @@ -260,7 +263,7 @@ static int qcom_wdt_probe(struct platform_device 
>>> *pdev)
>>>       wdt->wdd.ops = &qcom_wdt_ops;
>>>       wdt->wdd.min_timeout = 1;
>>> -    wdt->wdd.max_timeout = 0x10000000U / wdt->rate;
>>> +    wdt->wdd.max_timeout = data->max_tick_count / wdt->rate;
>>>       wdt->wdd.parent = dev;
>>>       wdt->layout = data->offset;
>>>
>>> ---
>>> base-commit: 9e21984d62c56a0f6d1fc6f76b646212cfd7fe88
>>> change-id: 20240111-wdt-5bd079ecf14d
>>>
>>> Best regards,
>>
> 

