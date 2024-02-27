Return-Path: <linux-kernel+bounces-83854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36AAD869F4A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 19:45:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C960A1F248AA
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 18:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77C644F200;
	Tue, 27 Feb 2024 18:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="gi0ny6b+"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5DC250F8;
	Tue, 27 Feb 2024 18:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709059520; cv=none; b=FM7AJ/6aFOdisEFlLkRm+953JtqtY0meq2OJ3oDVY7lPmNjJVc/nKSZg7rYOaHricFO5ncxDexPfOZEleYx54UfzscNFD29LLIPLi7RanAhv5F0sf9qcRPiiwJQtnHhxQx2ImOoiz+tWx1owi4AtbT8xxmZtmitubgX89yvxHBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709059520; c=relaxed/simple;
	bh=o6ryqFc0iRLpn12KsCmb1ExGOk9ZvjbvZO4rjOxDm5E=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=emaKvfyq2y8zUHYcOy8K9A7IR49mCSJLhwS72t9z2ukqA/B/rh9HAyUfmcdtNqXcYpseH4L8I7b+K/BZKFC1iWepZEhJI3L1woNajZ7qbt6BDDjU2Kjv0Ofy9cqW8d+QUI6Vdv5Plgx7jrpwn/mXjKTrIRRW/lzlxYra6EO9NAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=gi0ny6b+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41R9Xt0l007042;
	Tue, 27 Feb 2024 18:45:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=JrqRRbgc0E8hZuTZ0QjDpC4MFhJKGpkorTSXbHuQ8pk=; b=gi
	0ny6b+WLIypBB7T3hrxXssw2Mruhxi9yIHfrSQ+4w0NIBfZuoN506s7cf9dTgbvM
	5EQlegwGJ+2Cfk0qWa9yQoqmJEMM9DHOAJYP1zzMMzXZNViBkH2/vh8C/E6m8NYW
	jce1NZ7iOGfxTmVwttlmOiFk9gZ8EPxEa2qjAEmGjntONwZ32CZ5X8mwxRaOP0oj
	dKZyEi27emnlmEl3VuxuXwFY81xOfwc9DcdOYpBrHq1andnREhkZLSS96K515+HA
	/qLzfMrQqGytLvU4WvdddvD4wAGXydo4A2sE8ShjGMKhMKr9AFrE5OKu4kuzudVW
	adzugJXzsA+VSrfWSEPg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wh8auhyyc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Feb 2024 18:45:07 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41RIj6bn004350
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Feb 2024 18:45:06 GMT
Received: from [10.131.33.37] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 27 Feb
 2024 10:45:02 -0800
Message-ID: <642ac3e4-d083-43fd-c0db-24e2bc4cb6a9@quicinc.com>
Date: Wed, 28 Feb 2024 00:14:57 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 0/3] cpufreq: scmi: Add boost frequency support
Content-Language: en-US
To: Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Sudeep Holla
	<sudeep.holla@arm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>
CC: <cristian.marussi@arm.com>, <rafael@kernel.org>,
        <morten.rasmussen@arm.com>, <lukasz.luba@arm.com>, <sboyd@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_mdtipton@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <nm@ti.com>
References: <20240117110443.2060704-1-quic_sibis@quicinc.com>
 <20240123060827.a3vszziftj6pszt3@vireshk-i7> <Za-RtBrSxI-j4Jdx@bogus>
 <e968092a-dc2b-4351-9489-acf874bbc7b6@arm.com>
 <01b3d0ed-3fd3-86c6-7b0f-48d34a5d9ba8@quicinc.com>
 <265e5f2c-9b45-420f-89b1-44369aeb8418@arm.com>
From: Sibi Sankar <quic_sibis@quicinc.com>
In-Reply-To: <265e5f2c-9b45-420f-89b1-44369aeb8418@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: mgjl9uWlg_EzxmRYGgK-gt0gxlloXHvl
X-Proofpoint-GUID: mgjl9uWlg_EzxmRYGgK-gt0gxlloXHvl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-27_05,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 bulkscore=0 suspectscore=0 phishscore=0 malwarescore=0
 mlxscore=0 lowpriorityscore=0 adultscore=0 mlxlogscore=999 clxscore=1015
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402270145



On 2/15/24 20:27, Dietmar Eggemann wrote:
> On 13/02/2024 08:35, Sibi Sankar wrote:
>>
>>
>> On 1/31/24 20:37, Dietmar Eggemann wrote:
>>> On 23/01/2024 11:15, Sudeep Holla wrote:
>>>> On Tue, Jan 23, 2024 at 11:38:27AM +0530, Viresh Kumar wrote:
>>>>> On 17-01-24, 16:34, Sibi Sankar wrote:
> 
> [...]
> 

[...]

>>> BTW, what's the use case you have in mind for this feature? Is it to cap
>>> high OPPs for CPUs in a certain CPUfreq policy?
>>
>> Yeah, that's exactly the use case for X1E. Boost frequencies defined in
>> the SoC are achievable by only one CPU in a cluster i.e. either the
>> other CPUs in the same cluster should be in low power mode or offline.
>> So it's mostly for book keeping i.e. we wouldn't to intimate incorrectly
>> that the CPUs are running at max possible frequency when it's actually
>> running at a lower frequency.
> 
> I see.
> 
> What about the issue with the settings of the global and the per-policy
> 'boost' file?
> 
> On my Juno-r0 the initial boost values are:
> 
> (1) Initial setting:
> 
> root@juno:/sys/devices/system/cpu/cpufreq# cat boost policy*/boost
> 1
> 0
> 0
> 
> Should they not all be 1 ?
> 
> 
> (2) Disabling system-wide boost
> 
> root@juno:/sys/devices/system/cpu/cpufreq# echo 0 > boost
> 
> Here I see 'cpufreq_pressure > 0' for all CPUs.
> 
> 
> (3) Enabling system-wide boost
> 
> root@juno:/sys/devices/system/cpu/cpufreq# echo 1 > boost
> 
> And here 'cpufreq_pressure == 0' for all CPUs.
> 
> 
> (4) Disabling boost for policy0.
> 
> root@juno:/sys/devices/system/cpu/cpufreq# echo 0 > policy0/boost
> 
> root@juno:/sys/devices/system/cpu/cpufreq# cat boost policy*/boost
> 1
> 0
> 1
> 
> Here nothing happened. But I was expecting to see 'cpufreq_pressure > 0'
> for CPUs of policy0:
> 

https://patchwork.kernel.org/project/linux-arm-msm/cover/20240227165309.620422-1-quic_sibis@quicinc.com/

Finally got some time to fix this, I've posted out the fix and re-spun
the series as well. This should fix the default values of per-policy
boost flags as well.

-Sibi

> root@juno:/sys/devices/system/cpu/cpufreq# cat policy0/affected_cpus
> 0 3 4 5

