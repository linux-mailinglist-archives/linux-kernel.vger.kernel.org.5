Return-Path: <linux-kernel+bounces-87069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A68F386CF01
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 17:27:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 969371C22685
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 16:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4747D134422;
	Thu, 29 Feb 2024 16:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="MWEWHopi"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8CD16062E;
	Thu, 29 Feb 2024 16:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709223789; cv=none; b=jgK2QVxIVoGAu8c4KrlP7aSmt0OYSBJp4ZoO6geTvQ6R03tMkIxPZ+24IALKKVvvqebJ0mA40hNUCSsrE0wON98n8Et6ExkYDDramR5wZwo7pDKLn+c+x2vUHVb1TklPfwIxZoTgC87lqVBxq3mg6FSdGMs7UyQ3YSzoz3L6nl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709223789; c=relaxed/simple;
	bh=GF1s7Q8vKeSknVTRTuJ/BYUn33sLoamb5Smgo6MtprM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Mi07XhFB1dbbnHL/UYZZDTExZtRyWrMKMWNdyHjA6983F1Jhq2iLlzPEAhsQOta2361lw5IPJcjHkkwrQ2kPA42xCiruFY9gP/WC9b/5aW8OqAUXU72MqAmjg9hHC804P3usTspeHa9dgoium7Cak9mrnGoqQS3MQDdxlHb1b4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=MWEWHopi; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41TBOiWM002741;
	Thu, 29 Feb 2024 16:22:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=ZN5gdEWigi3Ga6SN9PMQwfoCGrcxYSlAymOOVKjJd54=; b=MW
	EWHopiObuUOqeu7dwpQj9PTulX8h6FVQ2ns2rLhIYvqQ/enbdJj6tJ6De+qC13CM
	0HDzNlD9LXtRuC3L1Er9KRCJ/JTxjjzKmgyxBl3QgW1+KRK9k8IG6Y56ZVCSgLtw
	6KM4+pWD79WfF6+69r3Pg5Kb76v9byxhqDY2ygHmi8JB3LvtjogorLwEnUqhv4K4
	aDnkkmSR3sxXnzEjMpCy4okeept5DikSV63AmU3Mpj3YRLU2jjrRa7J2KBIJw8Fj
	pTFvYZGrOvz+msYeezW20ovlFetjZAWAO/HJzvbY2ybn/RsVdGMtWktVYXnFW7JC
	/I+qy9q2Pq4UZpBXp06A==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wjmwn9kr6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Feb 2024 16:22:58 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41TGMvnI030285
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Feb 2024 16:22:57 GMT
Received: from [10.50.20.62] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 29 Feb
 2024 08:22:53 -0800
Message-ID: <f1ac744d-092b-4a19-a22a-810e25bacddb@quicinc.com>
Date: Thu, 29 Feb 2024 21:52:50 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [1/4] interconnect: qcom: icc-rpmh: Add QoS config support
Content-Language: en-US
To: Konrad Dybcio <konrad.dybcio@linaro.org>, <georgi.djakov@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Alex Elder <elder@linaro.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>,
        Dmitry Baryshkov
	<dmitry.baryshkov@linaro.org>
References: <20240122143030.11904-1-quic_okukatla@quicinc.com>
 <20240122143030.11904-2-quic_okukatla@quicinc.com>
 <9224341f-e0d8-427b-9064-4a51bf5c547e@linaro.org>
 <DM8PR02MB8261BA6A8870193265380991F0472@DM8PR02MB8261.namprd02.prod.outlook.com>
 <16a776d9-8303-4033-a694-8ed83bc7b66d@linaro.org>
 <34099e94-2439-45a2-8020-13c8c145397b@quicinc.com>
 <eef3d3f6-b905-4f12-8f56-ffab13e585e9@linaro.org>
From: Odelu Kukatla <quic_okukatla@quicinc.com>
In-Reply-To: <eef3d3f6-b905-4f12-8f56-ffab13e585e9@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: _VJSaW-fN0RHOsFmbeWWaJ3Bq56t6dwh
X-Proofpoint-ORIG-GUID: _VJSaW-fN0RHOsFmbeWWaJ3Bq56t6dwh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-29_02,2024-02-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 mlxlogscore=999 phishscore=0 priorityscore=1501 malwarescore=0
 suspectscore=0 clxscore=1011 bulkscore=0 adultscore=0 lowpriorityscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402290126



On 2/22/2024 6:00 PM, Konrad Dybcio wrote:
> 
> 
> On 2/21/24 18:57, Odelu Kukatla wrote:
>>
>>
>> On 2/5/2024 5:51 PM, Konrad Dybcio wrote:
>>> On 5.02.2024 12:57, Odelu Kukatla (QUIC) wrote:
>>>> -----Original Message-----
>>>> From: Konrad Dybcio <konrad.dybcio@linaro.org>
>>>> Sent: Monday, January 22, 2024 8:55 PM
>>>> To: Odelu Kukatla (QUIC) <quic_okukatla@quicinc.com>; georgi.djakov@linaro.org; Bjorn Andersson <andersson@kernel.org>; Georgi Djakov <djakov@kernel.org>; linux-arm-msm@vger.kernel.org; linux-pm@vger.kernel.org; linux-kernel@vger.kernel.org
>>>> Subject: Re: [1/4] interconnect: qcom: icc-rpmh: Add QoS config support
> 
> Why is this email taken private?
> 
> [...]
> 
I am adding previous list back for now, will add "to list" from "./scripts/get_maintainer.pl" in V3.
>>>
>>
>> Yeah, you are right. !synced_state holds all BCMs enabled. But clock voting is still required.
>> But qcom_icc_rpmh_configure_qos() can be invoked from out side of qcom_icc_rpmh_probe() in QuickBoot mode where *_probe does not happen.
>> so irrespective of !synced_state votes, better to keep it separate from sync_state() and place votes on required BCMs during QoS time and remove them after that.
> 
> What on earth is quickboot mode?
> Grepping for it on linux-next, there's precisely 0 results.
> 
> If it's some downstream sw invention, it has no right to affect
> the code submitted upstream - "if it's not on the list, it doesn't
> exist".
> 

Quickboot is not there yet in upstream. I will clean the code related to BCM voting and move the required clock voting to qcom_icc_rpmh_configure_qos().

>>
>>>>> + * @prio: priority value assigned to requests on the node
>>>>> + * @urg_fwd: if set, master priority is used for requests.
>>>>
>>>> "master priority" meaning "this req goes before anyone else", or "use the icc provider [master]'s priority value"?
>>>>
>>>>> + * @prio_fwd_disable: if set, master priority is ignored and NOCs default priority is used.
>>>>
>>>> NoC's
>>>>
>>>> This sounds like !(prio || urg_fwd)? Surely it must do something more useful?
>>>
>>> This remains unanswered
>>>
>>> Konrad
>>
>> @prio_fwd_disable:
>> 1 -> FIXED MODE; upstream tnx-inband-priority is ignored; value @pio is used for transaction.
>> 0 -> BYPASS MODE; max of (tnx-inband-priority, @prio).
> 
> So, this could be basically called "force_priority_val"
> 
> 
>> @urg_fwd:
>> 1 -> Urgency promotion messages issued by the connected master IP remain unchanged as they transit the NIU and the QNoC QoS generator.
>> 0 -> IP-generated messages are discarded, and messages generated by QoS generators are used instead.
> 
> So the interconnect endpoints can effectively modify the priority if
> urg_fwd is enabled.. Interesting.. "ignore_ep_urgency_req"?
> 

Names were chosen closer to bit fields in QoS registers. I will keep the names same and update the documentation with clear explanation.

> Both of these should also be better documented, the kerneldoc you
> submitted explains nothing unless this what I believe to be excerpt
> from the documentation is present to support it.
> 
> Konrad

Thanks,
Odelu

