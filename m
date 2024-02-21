Return-Path: <linux-kernel+bounces-74372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51C2A85D327
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 10:13:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7448B1C21734
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 09:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD0523D0B3;
	Wed, 21 Feb 2024 09:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ehfED+vb"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4823E3C6AB;
	Wed, 21 Feb 2024 09:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708506785; cv=none; b=ATIuPnL777uhePdTnhhHbVBy+gs0upHB3rvhp3b8tObiCwpPoPar4aA9CpWXj57fv3XVwlU8JHyMgWNMoi6Utq94JYFmNdJXz7eVR2RfzFCRZCYaDOijFFWiRMpzTIQVxALtDWIVeIpOBB3V81bRYQXlMPbpuNlA8pD/ML46b5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708506785; c=relaxed/simple;
	bh=1SkocYH3fo2j2uDv5WnCnFcUqIuX9Fi1/HdKKH2UY0Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ubp5lLFFl6un/EVMn62xdIvyZhbf79ce9VVEGkx1HTTiAm6SQrZlIzspbHC50FVH3sbwsYHmBu1Y8ia/GDmXsf7qL0MMFIHVQZwUr5JwqGPN8Hpa2LCEWZ7RF8Rn2p3hGjluWBy4bTqNzM/YBQLFIFvXpquQxZ39a5JupXzCcPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ehfED+vb; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41L2bCow027853;
	Wed, 21 Feb 2024 09:13:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=B3vXZICwlVLnOSYVFqiY/q6uGIvLfgq4175ICymiVU4=; b=eh
	fED+vbmKkfkY6wOO/LaCh+CNzunLAntCLcGfh7y9sJF3Q86xIxelmsgaj253c251
	EApmtfhUUU9W2jL1Go5fUKrTBvVC8Ct75wHkquzF5v696wX+cqE3IktasfKQaUbc
	W9tujCfJDl2EPfiyYn8EpZL7ftd4KiltjB2Qu3x9CqN3RnXOfbvNJRLlv+Tjhhcl
	j96OoSgUG/Oz7CEQxLNBItku/zMfEC7aOGlbtfbCq6wF0XoQSX6Rp4dG8Jcmq19W
	/XOGucPU/c/CbLY9kzi9QVjBaEHGNxI54DNr4j3bcYo8Wuna+1+9LCV1WAz4qin/
	6ZxSa+52YehvNR+kxhHg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wd21qsgem-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Feb 2024 09:12:59 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41L9CwW7001678
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Feb 2024 09:12:58 GMT
Received: from [10.239.154.73] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 21 Feb
 2024 01:12:56 -0800
Message-ID: <6b36bdc2-0ffb-491f-a1ae-93a20822e6f0@quicinc.com>
Date: Wed, 21 Feb 2024 17:11:24 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] regulator: qcom-rpmh: Fix pm8010 pmic5_pldo502ln minimum
 voltage
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Mark Brown
	<broonie@kernel.org>
CC: <andersson@kernel.org>, <konrad.dybcio@linaro.org>, <lgirdwood@gmail.com>,
        <quic_collinsd@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20240214121614.2723085-1-bryan.odonoghue@linaro.org>
 <13baed68-1014-4a48-874a-94027a6dd061@sirena.org.uk>
 <f38468b4-8b16-4180-9738-0a2b557651a1@linaro.org>
 <dcce3fa9-ecf3-42be-adf6-ca653a79ba2e@sirena.org.uk>
 <3851e21f-f8cb-487b-9ed4-9975949ff922@linaro.org>
 <a09d6450-95e7-4ed6-a0ad-5e7bb661533a@sirena.org.uk>
 <df6a49f3-88e9-46b4-b7c3-e5419fd01eca@linaro.org>
 <6f6dfaa2-f529-c9fe-7dde-402c92f0daf6@quicinc.com>
 <bc05fe84-0700-4587-bb18-eb39d30f10a8@linaro.org>
Content-Language: en-US
From: Fenglin Wu <quic_fenglinw@quicinc.com>
In-Reply-To: <bc05fe84-0700-4587-bb18-eb39d30f10a8@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: NZbMFwcvnBhDiZdoiWZQEpX3zpdwKpHD
X-Proofpoint-ORIG-GUID: NZbMFwcvnBhDiZdoiWZQEpX3zpdwKpHD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-20_06,2024-02-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 mlxscore=0 spamscore=0 suspectscore=0
 phishscore=0 adultscore=0 impostorscore=0 bulkscore=0 mlxlogscore=999
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402210071



On 2/20/2024 4:20 PM, Bryan O'Donoghue wrote:
> On 19/02/2024 3:06 a.m., Fenglin Wu wrote:
>>
>>
>> On 2024/2/15 6:47, Bryan O'Donoghue wrote:
>>> On 14/02/2024 14:52, Mark Brown wrote:
>>>> On Wed, Feb 14, 2024 at 02:44:56PM +0000, Bryan O'Donoghue wrote:
>>>>> On 14/02/2024 14:13, Mark Brown wrote:
>>>>
>>>>>> Not just that but also note that every voltage step in the range will
>>>>>> have the 8mV offset added.
>>>>
>>>>> The documents I have just show sensors attached to ldo3, ldo4 and 
>>>>> ldo6 fixed
>>>>> at 1.808.
>>>>
>>>>> I don't think there's any better or different information than a 
>>>>> +200000uV
>>>>> increment TBH.
>>>>
>>>> This seems like a very surprising and unusual hardware design, the
>>>> 1.808V voltage is already unusual.  Note that this may break systems
>>>> that are trying to set a range of say 1.8-2.0V if they actually need to
>>>> set 2V.
>>>
>>> Hmm. I'm sure the rail value should be 1.808 its all over the 
>>> documentation for example when we get to index 3 we hit 2608000
>>>
>>> REGULATOR_LINEAR_RANGE(1808000, 0,  2,  200000),
>>> 1808000 0
>>> 2008000 1
>>> 2208000 2
>>> 2408000 x
>>> REGULATOR_LINEAR_RANGE(2608000, 3,  28, 16000),
>>>
>>> And there are other rails @ 1v8 if 1v8
>>>
>>> The one thing I can't easily verify is index 0 = 1808000 and not say 
>>> 1800000 or indeed that the increment is 200000 and not say 8000.
>>>
>>> I'll see if I can ask around with the hw people and get a more 
>>> complete answer.
>>>
>>> Similarly now that you've gotten me digging into this problem, it's 
>>> not clear to me why this regulator isn't just a linear regulator with 
>>> an 8mv increment over a range of indexes.
>>>
>>> At least the documentation I'm looking at doesn't elucidate.
>>>
>>> I'll dig some more.
>> Please see the voltage steps for LDO3/4/6 described in the PM8010 TDOS 
>> document which is the most authoritative that we used internally for 
>> PMIC driver development:
> 
> I will look - however
> 
> 1. The powertree internal docs for xe801000 show 1.808 rails derived
>     from 1.856 rails for camera sensors
> 
> 2. Publicly available with registration : 80-185821-1
> 
> https://docs.qualcomm.com/bundle/80-18582-1/resource/80-18582-1_REV_AV_PM8010_Data_Sheet.pdf
> 
>     Table 3-7 Linear/low-voltage regulator summary
> 
>     Specified programmable range (V)
>     ldo3, ldo4, ldo6 = 1.808 to 3.312
> 
> 3. The pmic ranges I'm looking at on the internal
>     show increases of 8000 mv linearly
> 
>> And I do see from the document change history that step 0 was changed 
>> from 1808mV and step 2 was changed from 2512mV, I don't know the 
>> reason of the change though.
> 
> Hrmm...
> 
> OK, that's enough to investigate further.
> 

Got feedback from the chip designer: "1.808V is the typical digital Vset 
logic output – always round up to the integer multiples of 8mV.
However, 1.8V is a more commonly used output. So we made analog only 
change, move the tap point of the reference generator to 1.8V when it is 
programmed to 1.808V.
If user program it to 1.8V, digital logic will round it up to 1.808V, 
send it to analog, then analog will map it to 1.8V. So the end result is 
the same regardless customer program it to 1.8V or 1.808V from PMIC 
register point of view. "

So, programming it to either 1.8V or 1.808V, the HW will output 1.8V. I 
understand there is a problem for x1e801000 because its AOP side limits 
the voltage range to [1.808V, 1.808V] for LDO3/4/6 power rails, it won't 
work if linux side updates to use 1.8V. Actually the same issue applies 
to SM8550 and SM8650 if you simply update the voltage level to 1.808V, 
because their AOP side limits the voltage ranges for some of these LDOs 
to [1.8V, 1.8V].

One possible fix is just adding 1.808v as another level for these LDOs.

Fenglin

> ---
> bod
> 

