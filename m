Return-Path: <linux-kernel+bounces-156724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B5148B0754
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 12:28:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA80B285B0B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 10:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE0A8159593;
	Wed, 24 Apr 2024 10:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="J+sbYCbO"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B22ED152DE1;
	Wed, 24 Apr 2024 10:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713954483; cv=none; b=JHz2JtQeFrfSVwRqytvi7tgjC/P2rc3MmBnyBMAaicqfo9YWbTYf9YOR7TDJ3Hlt4mqMJPb3YCUc1vcyvxNJyWR0uzV8WKVVu4Db6wX+T8JToEza+mqv8K75k7pUzi30rko2TyG2MGKkfA6EOpDKC7eAia9hn5JMOe14roG/HZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713954483; c=relaxed/simple;
	bh=KMVHm+SIAgutMAbC6mgTihoI+YnjySmbBuGhkkDnQtM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=TZj5UKXGvgbqZdw7jp9xv+FwHVpytd0b2ALw2pAlIE9LwKDhsQNGp7Wi5rmhCq2kYYjVjb01w9itDVKvS+gnLIuia3fz+GITVbPypoiRTFfmRwcsknc34yQPKtrArFHl0HVvztH4OPYBp2AWDfbXeXoH20jxn9PuR377CXvMDFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=J+sbYCbO; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43O6Xc50016794;
	Wed, 24 Apr 2024 10:27:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=RQNt5PZZm3frh00wj8WKWSZPe7aKlTUmfVkfoQWkc4g=; b=J+
	sbYCbOCxdLNqKvWyyG2apikUXBGiWrqSBsioJEOPuPWldzZZLss82Cw5wpyesS1t
	xfq5MylLo5D6k4Oet2g8Zs1GOXK02jbfOvBUoJsBPp8CpVRveVZlFmPV8HPUWMUM
	d7dQM2enkLhfNBahD0VEV9tDjIzrkHGJvPtvulnxA3Q/ZlVJoIZz0lHDuFuOrWUV
	Pp8fhMYIlMd/5YO1ozlwZkifc+tSxiYT3HvVtvBWlZBbehuTT88cxwXjUKun2Gs1
	EcUIXB7FCGUwaD8l5yjrkWccctFy3dteg2omVj+K8IfzXm7teDn/tjr8T5Jv8Lc3
	ArUmhB/KVUptpc/5QTCg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xpv9fgj42-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 10:27:52 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43OARoPf012223
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 10:27:50 GMT
Received: from [10.218.5.19] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 24 Apr
 2024 03:27:42 -0700
Message-ID: <2e8f5e93-1f24-4451-ab9f-ad1e7d98bc65@quicinc.com>
Date: Wed, 24 Apr 2024 15:57:39 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 RESEND 3/5] clk: qcom: gdsc: Add set and get hwmode
 callbacks to switch GDSC mode
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        "Stephen
 Boyd" <sboyd@kernel.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Mauro Carvalho Chehab
	<mchehab@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J .
 Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>, Pavel Machek
	<pavel@ucw.cz>,
        Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "Andy
 Gross" <agross@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Abel Vesa <abel.vesa@linaro.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-media@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, Taniya Das <quic_tdas@quicinc.com>,
        "Satya Priya
 Kakitapalli" <quic_skakitap@quicinc.com>,
        Imran Shaik
	<quic_imrashai@quicinc.com>,
        Ajit Pandey <quic_ajipan@quicinc.com>
References: <20240413152013.22307-1-quic_jkona@quicinc.com>
 <20240413152013.22307-4-quic_jkona@quicinc.com>
 <e70e0379-cab0-4586-825e-ade6775ca67c@linaro.org>
 <e419c6aa-6bb2-48ff-bacb-17a2e85856ea@quicinc.com>
 <0ed739d8-7ef6-4b0d-bd61-62966c9a9362@linaro.org>
Content-Language: en-US
From: Jagadeesh Kona <quic_jkona@quicinc.com>
In-Reply-To: <0ed739d8-7ef6-4b0d-bd61-62966c9a9362@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: UdaJqMHmAelHEwYEvmrTYsnUWBXurROV
X-Proofpoint-GUID: UdaJqMHmAelHEwYEvmrTYsnUWBXurROV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-24_08,2024-04-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 impostorscore=0 clxscore=1015 priorityscore=1501 adultscore=0 phishscore=0
 mlxlogscore=999 lowpriorityscore=0 suspectscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404240043



On 4/24/2024 3:25 PM, Bryan O'Donoghue wrote:
> On 24/04/2024 10:47, Jagadeesh Kona wrote:
>>
>>
>> On 4/24/2024 5:18 AM, Bryan O'Donoghue wrote:
>>> On 13/04/2024 16:20, Jagadeesh Kona wrote:
>>>> Some GDSC client drivers require the GDSC mode to be switched 
>>>> dynamically
>>>> to HW mode at runtime to gain the power benefits. Typically such client
>>>> drivers require the GDSC to be brought up in SW mode initially to 
>>>> enable
>>>> the required dependent clocks and configure the hardware to proper 
>>>> state.
>>>> Once initial hardware set up is done, they switch the GDSC to HW 
>>>> mode to
>>>> save power. At the end of usecase, they switch the GDSC back to SW mode
>>>> and disable the GDSC.
>>>>
>>>> Introduce HW_CTRL_TRIGGER flag to register the set_hwmode_dev and
>>>> get_hwmode_dev callbacks for GDSC's whose respective client drivers
>>>> require the GDSC mode to be switched dynamically at runtime using
>>>> dev_pm_genpd_set_hwmode() API.
>>>>
>>>> Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
>>>> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
>>>> ---
>>>>   drivers/clk/qcom/gdsc.c | 37 +++++++++++++++++++++++++++++++++++++
>>>>   drivers/clk/qcom/gdsc.h |  1 +
>>>>   2 files changed, 38 insertions(+)
>>>>
>>>> diff --git a/drivers/clk/qcom/gdsc.c b/drivers/clk/qcom/gdsc.c
>>>> index df9618ab7eea..c5f6be8181d8 100644
>>>> --- a/drivers/clk/qcom/gdsc.c
>>>> +++ b/drivers/clk/qcom/gdsc.c
>>>> @@ -363,6 +363,39 @@ static int gdsc_disable(struct 
>>>> generic_pm_domain *domain)
>>>>       return 0;
>>>>   }
>>>> +static int gdsc_set_hwmode(struct generic_pm_domain *domain, struct 
>>>> device *dev, bool mode)
>>>> +{
>>>> +    struct gdsc *sc = domain_to_gdsc(domain);
>>>> +    int ret;
>>>> +
>>>> +    ret = gdsc_hwctrl(sc, mode);
>>>> +    if (ret)
>>>> +        return ret;
>>>> +
>>>> +    /* Wait for 1usec for mode transition to properly complete */
>>>> +    udelay(1);
>>>
>>> A delay I suspect you don't need - if the HW spec says "takes 1 usec 
>>> for this to take effect" that's 1 usec from io write completion from 
>>> APSS to another system agent.
>>>
>>> You poll for the state transition down below anyway.
>>>
>>> I'd be pretty certain that's a redundant delay.
>>>
>>
>> Thanks Bryan for your review!
>>
>> This 1usec delay is needed every time GDSC is moved in and out of HW 
>> control mode and the reason for same is explained in one of the older 
>> gdsc driver change at below link
>>
>> https://lore.kernel.org/all/1484027679-18397-1-git-send-email-rnayak@codeaurora.org/
>>
> 
> Right.
> 
> If that is your precedent then you seem to be missing the mb(); between
> 
> gdsc_hwctrl();
> 
> /* mb(); here */
> 
> and this
> 
> udelay(1);
> 

Sorry, earlier I shared the link to base patch series which has mb() 
used, but in the mainlined series of the same patch mb() is removed as 
per the review comments.

Please find the mainlined series link:-
https://lore.kernel.org/all/1485145581-517-1-git-send-email-rnayak@codeaurora.org/

Thanks,
Jagadeesh

> ---
> bod

