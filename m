Return-Path: <linux-kernel+bounces-117100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F86E88A6F6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:40:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 635D0300E79
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47FCA13DBBD;
	Mon, 25 Mar 2024 13:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="eTQGJliG"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F9E13D892;
	Mon, 25 Mar 2024 13:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711372599; cv=none; b=IJiXMWBEEjlJNqTSBUeNjZoY4yuARy8cYUvfhSsXnvfaZz/tJoD6AzKeW//1YTSzJj7WXtHxq6WpVTxhPQx/nH3u4n2U+Vtpvv31v/xBXGoCLKUeRfn/R3apKGs46Dzox9GfarQDUC8x+Psn/GL6caqyTlyPo+fx9fIgardmGgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711372599; c=relaxed/simple;
	bh=OCUpgoU2kavYuvWdrcbQ+y5rtvazJcggTLmF0IH6zZA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=GIQdSEOwrW6D6KCfZ8GYO6Qlm7CMUBkAb1Wj00mN/XrBJsSqT1aE4BMr1vUac70Sr+SfEUlfg5kyfxgylPnEbBN4KHRFOjNefjn5cvd4k/Di2cbUP8jl2BwLPOHgAXj2ZiAFyVBBkin2UqMHQJMpWb56JUZAdnwuajIz4ojBaJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=eTQGJliG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42PB2XGM002228;
	Mon, 25 Mar 2024 13:16:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=nchwiDm9gDNbcj8YOFtZUF5KqbrEgINcorL3dm/jF68=; b=eT
	QGJliGGoXXSuJotsF8ZRO0dypTSLTk8w7tE9OHzOzaDYI6Dcqxq/sCt0rHIVK1a0
	5+NBUfX9twhTt8bidSCGphZfUZXgqiba5H4cVlfQnE8UNQvYnuH9GBXZZxpDlj3L
	IQW+Y+OO2LY7fMhHBAJ6nD/iskjURO/qEwJn2TzDNFT+zcNbjYc7eMeVDZx3LDZz
	p6wPXuwB0bqFt75mYKAlBolKAGPTYuH9NJm3pF9KFq8asnunCMVqf7VgD2IlaJiS
	dyDNkpDGW2z93A5KWk0MAyViTrv4vGWr4445Y1/5qFmM+7rBV6/BITPiuI7YT5VJ
	VvUEGDDqc2prlCuYKqIA==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x381e8bx1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Mar 2024 13:16:32 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42PDGV55020829
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Mar 2024 13:16:31 GMT
Received: from [10.239.96.73] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 25 Mar
 2024 06:16:29 -0700
Message-ID: <dcc315cb-c787-462e-b61e-20f0e5d43d8f@quicinc.com>
Date: Mon, 25 Mar 2024 21:16:26 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 8/8] media: qcom: camss: Add sm8550 support
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>, <rfoss@kernel.org>,
        <todor.too@gmail.com>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <mchehab@kernel.org>,
        <quic_yon@quicinc.com>
CC: <linux-kernel@vger.kernel.org>, <linux-media@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>
References: <20240320141136.26827-1-quic_depengs@quicinc.com>
 <20240320141136.26827-9-quic_depengs@quicinc.com>
 <944ff951-53dc-40f6-a7b0-5ecfc2cd4771@linaro.org>
Content-Language: en-US
From: Depeng Shao <quic_depengs@quicinc.com>
In-Reply-To: <944ff951-53dc-40f6-a7b0-5ecfc2cd4771@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: WRNt1GiwIt45YVSWeoit8lCzsDFzunEo
X-Proofpoint-ORIG-GUID: WRNt1GiwIt45YVSWeoit8lCzsDFzunEo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-25_08,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 clxscore=1015
 spamscore=0 priorityscore=1501 suspectscore=0 mlxscore=0 impostorscore=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2403210001
 definitions=main-2403250073

Hi Bryan,

On 3/21/2024 12:01 AM, Bryan O'Donoghue wrote:
> On 20/03/2024 14:11, Depeng Shao wrote:
>> Add in functional logic throughout the code to support the SM8550.
>>
>> Signed-off-by: Depeng Shao <quic_depengs@quicinc.com>
>> ---
>>   .../media/platform/qcom/camss/camss-csid.c    | 19 +++++++++++++++++++
>>   .../media/platform/qcom/camss/camss-csiphy.c  |  1 +
>>   drivers/media/platform/qcom/camss/camss-vfe.c |  7 +++++++
>>   .../media/platform/qcom/camss/camss-video.c   |  1 +
>>   4 files changed, 28 insertions(+)
>>
>> diff --git a/drivers/media/platform/qcom/camss/camss-csid.c 
>> b/drivers/media/platform/qcom/camss/camss-csid.c
>> index eb27d69e89a1..e9203dc15798 100644
>> --- a/drivers/media/platform/qcom/camss/camss-csid.c
>> +++ b/drivers/media/platform/qcom/camss/camss-csid.c
>> @@ -590,6 +590,25 @@ int msm_csid_subdev_init(struct camss *camss, 
>> struct csid_device *csid,
>>               csid->base = camss->vfe[id].base + 
>> VFE_480_LITE_CSID_OFFSET;
>>           else
>>               csid->base = camss->vfe[id].base + VFE_480_CSID_OFFSET;
>> +    } else if (camss->res->version == CAMSS_8550) {
>> +        /* for titan 780, CSID lite registers are inside the VFE lite 
>> region,
>> +         * between the VFE "top" and "bus" registers. this requires
>> +         * VFE to be initialized before CSID
>> +         */
>> +        if (id >= 2)
>> +            csid->base = camss->vfe[id].base;
> 
> Hard-coded magic numbers are definitely out.
> 
> If you need to differentiate - please include something in the struct 
> resources so that the flag is always available and we don't have to 
> start doing funky magic index/magic number gymnastics.
> 

Sure, will update this part.

>> +        else {
>> +            csid->base =
>> +                devm_platform_ioremap_resource_byname(pdev, 
>> res->reg[0]);
>> +            if (id != 0)
>> +                csid->top_base = camss->csid[0].top_base;
>> +            else
>> +                csid->top_base =
>> +                    devm_platform_ioremap_resource_byname(pdev, 
>> res->reg[1]);
>> +        }
> 
> What is the point of hooking the TOP base just to clear our the status 
> registers ?
> 
> We take no meaningful action in the ISR that I can see.
>

The csid top is a new small hardware block, it controls the output of 
CSID, since the CSID can connect to Sensor Front End(SFE) or original 
VFE in CSID gen3.

> 
>> +
>> +        if (IS_ERR(csid->base))
>> +            return PTR_ERR(csid->base);
>>       } else {
>>           csid->base = devm_platform_ioremap_resource_byname(pdev, 
>> res->reg[0]);
>>           if (IS_ERR(csid->base))
>> diff --git a/drivers/media/platform/qcom/camss/camss-csiphy.c 
>> b/drivers/media/platform/qcom/camss/camss-csiphy.c
>> index 45b3a8e5dea4..f35af0dd2147 100644
>> --- a/drivers/media/platform/qcom/camss/camss-csiphy.c
>> +++ b/drivers/media/platform/qcom/camss/camss-csiphy.c
>> @@ -579,6 +579,7 @@ int msm_csiphy_subdev_init(struct camss *camss,
>>       case CAMSS_845:
>>       case CAMSS_8250:
>>       case CAMSS_8280XP:
>> +    case CAMSS_8550:
>>           csiphy->formats = csiphy_formats_sdm845;
>>           csiphy->nformats = ARRAY_SIZE(csiphy_formats_sdm845);
>>           break;
>> diff --git a/drivers/media/platform/qcom/camss/camss-vfe.c 
>> b/drivers/media/platform/qcom/camss/camss-vfe.c
>> index d875237cf244..ff115c5521c6 100644
>> --- a/drivers/media/platform/qcom/camss/camss-vfe.c
>> +++ b/drivers/media/platform/qcom/camss/camss-vfe.c
>> @@ -226,6 +226,7 @@ static u32 vfe_src_pad_code(struct vfe_line *line, 
>> u32 sink_code,
>>       case CAMSS_845:
>>       case CAMSS_8250:
>>       case CAMSS_8280XP:
>> +    case CAMSS_8550:
>>           switch (sink_code) {
>>           case MEDIA_BUS_FMT_YUYV8_1X16:
>>           {
>> @@ -296,6 +297,10 @@ int vfe_reset(struct vfe_device *vfe)
>>       reinit_completion(&vfe->reset_complete);
>> +    // The reset has been moved to csid in 8550
> 
> Please run checkpatch.pl on your code before submission C++ are not 
> allowed.
> 
> ---
> bod

Thanks,
Depeng

