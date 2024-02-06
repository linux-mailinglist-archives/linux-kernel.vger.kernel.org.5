Return-Path: <linux-kernel+bounces-55355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F17084BBA4
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 18:08:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 542E81C24488
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 17:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09A616FB8;
	Tue,  6 Feb 2024 17:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="a4U7yzeE"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E736FD9;
	Tue,  6 Feb 2024 17:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707239307; cv=none; b=o+S6r+eWM4N6WH9lLsxlKFfjfGEq+qGLzmoeJEXmAJrugYWpFsOdjvVC+BKqwkCbGfMxG0wNasG4cjhuD33cYhBJhkRKhyhpAO+dkcRq/qssSGO8GnzQq+WBuyHrixTQ7f/rt8el8IPoRu/KWWZgKQjD0YiGOEAaOnSMHpwmWw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707239307; c=relaxed/simple;
	bh=14s6CeuHaL1RQI15Tz/VklngYR3GkDWGqIIlHeQGvOI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Kt51MUiWLWl1TI+1mQsXQnwuwSp5ySesiyY+W6lgIGT7ey5iCYG1TxC9Y/QlVTcu6RD4bL20iQlyKCZpBElMFu0I/peQ0dR3rZlhKao/dXQKsXrXcq6AA/8GRWG+8phXRTBHfqdWw+/aU9uCfxarLhK75hcbMwkO+1duozhdOB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=a4U7yzeE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 416DUZiL020109;
	Tue, 6 Feb 2024 17:08:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=Mr8HJfhsoNrEVp1gheHDyxNF2ZOCvLKFfY39KoScgSY=; b=a4
	U7yzeEAujlD/Cg7pA6KkeCiwQ5MQAJZF2oPZaDePQa+V2KOf6uieDBqP/j4o+3he
	OXWaOGgc0VckdEDQ7WCO3PikhMwYIFZUeqyWP/EVe45fwcXPChkhdUw4dEpT1F2e
	OL2iMYmdhUddxUsGieOPVHmwcy3JyzVAmBgEDz0YRhSwHMV/31L2EeRNxA4TPA8q
	qpt9hy3eqMWHxHR2/NCkRzGLGO/HDCZjMgJBXAhcv5XqhiJFJ5gYS9EhUGTJOImH
	jHMGSIMbq23xxX7Di5bSEi50+4cCb+1JyQX+a/MPvcuNO4HZK2lRo70iV7gxpMiV
	pydZ8zb7dBEF+OURmxzw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w35bxjkqu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Feb 2024 17:08:07 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 416H7sJh019498
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 6 Feb 2024 17:07:54 GMT
Received: from [10.216.20.88] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 6 Feb
 2024 09:07:48 -0800
Message-ID: <2270ebb6-3830-d667-1b9e-2efc96746b94@quicinc.com>
Date: Tue, 6 Feb 2024 22:37:32 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 8/8] sched/pelt: Introduce PELT multiplier
Content-Language: en-US
To: Vincent Guittot <vincent.guittot@linaro.org>
CC: Qais Yousef <qyousef@layalina.io>, Ingo Molnar <mingo@kernel.org>,
        "Peter
 Zijlstra" <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Dietmar Eggemann
	<dietmar.eggemann@arm.com>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        Lukasz Luba <lukasz.luba@arm.com>, Wei Wang
	<wvw@google.com>,
        Rick Yiu <rickyiu@google.com>, Chung-Kai Mei
	<chungkai@google.com>,
        <quic_anshar@quicinc.com>, <quic_atulpant@quicinc.com>,
        <quic_shashim@quicinc.com>, <quic_rgottimu@quicinc.com>,
        <quic_adharmap@quicinc.com>, <quic_kshivnan@quicinc.com>,
        <quic_pkondeti@quicinc.com>
References: <20231208002342.367117-1-qyousef@layalina.io>
 <20231208002342.367117-9-qyousef@layalina.io>
 <a561029e-993d-726d-18ce-0bc014e6533c@quicinc.com>
 <20240121000444.ghue2miejmiair6l@airbuntu>
 <8dfb5db7-6da0-4f6f-30ef-8966428e4a1c@quicinc.com>
 <CAKfTPtB=nv7DDqTvsdenOg+UNoNFx=f2SLvihHx+CMkeE6NyNA@mail.gmail.com>
From: Ashay Jaiswal <quic_ashayj@quicinc.com>
In-Reply-To: <CAKfTPtB=nv7DDqTvsdenOg+UNoNFx=f2SLvihHx+CMkeE6NyNA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 6H1Qu58SWwfiCqyZXx_UA5NAQiYavpof
X-Proofpoint-ORIG-GUID: 6H1Qu58SWwfiCqyZXx_UA5NAQiYavpof
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-06_10,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 priorityscore=1501 mlxscore=0 clxscore=1015 malwarescore=0 mlxlogscore=553
 impostorscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2401310000
 definitions=main-2402060121



On 1/30/2024 10:58 PM, Vincent Guittot wrote:
> On Sun, 28 Jan 2024 at 17:22, Ashay Jaiswal <quic_ashayj@quicinc.com> wrote:
>>
>> Hello Qais Yousef,
>>
>> Thank you for your response.
>>
>> On 1/21/2024 5:34 AM, Qais Yousef wrote:
>>> Hi Ashay
>>>
>>> On 01/20/24 13:22, Ashay Jaiswal wrote:
>>>> Hello Qais Yousef,
>>>>
>>>> We ran few benchmarks with PELT multiplier patch on a Snapdragon 8Gen2
>>>> based internal Android device and we are observing significant
>>>> improvements with PELT8 configuration compared to PELT32.
>>>>
>>>> Following are some of the benchmark results with PELT32 and PELT8
>>>> configuration:
>>>>
>>>> +-----------------+---------------+----------------+----------------+
>>>> | Test case                       |     PELT32     |     PELT8      |
>>>> +-----------------+---------------+----------------+----------------+
>>>> |                 |    Overall    |     711543     |     971275     |
>>>> |                 +---------------+----------------+----------------+
>>>> |                 |    CPU        |     193704     |     224378     |
>>>> |                 +---------------+----------------+----------------+
>>>> |ANTUTU V9.3.9    |    GPU        |     284650     |     424774     |
>>>> |                 +---------------+----------------+----------------+
>>>> |                 |    MEM        |     125207     |     160548     |
>>>> |                 +---------------+----------------+----------------+
>>>> |                 |    UX         |     107982     |     161575     |
>>>> +-----------------+---------------+----------------+----------------+
>>>> |                 |   Single core |     1170       |     1268       |
>>>> |GeekBench V5.4.4 +---------------+----------------+----------------+
>>>> |                 |   Multi core  |     2530       |     3797       |
>>>> +-----------------+---------------+----------------+----------------+
>>>> |                 |    Twitter    |     >50 Janks  |     0          |
>>>> |     SCROLL      +---------------+----------------+----------------+
>>>> |                 |    Contacts   |     >30 Janks  |     0          |
>>>> +-----------------+---------------+----------------+----------------+
>>>>
>>>> Please let us know if you need any support with running any further
>>>> workloads for PELT32/PELT8 experiments, we can help with running the
>>>> experiments.
>>>
>>> Thanks a lot for the test results. Was this tried with this patch alone or
>>> the whole series applied?
>>>
>> I have only applied patch8(sched/pelt: Introduce PELT multiplier) for the tests.
>>
>>> Have you tried to tweak each policy response_time_ms introduced in patch
>>> 7 instead? With the series applied, boot with PELT8, record the response time
>>> values for each policy, then boot back again to PELT32 and use those values.
>>> Does this produce similar results?
>>>
>> As the device is based on 5.15 kernel, I will try to pull all the 8 patches
>> along with the dependency patches on 5.15 and try out the experiments as
>> suggested.
> 
> Generally speaking, it would be better to compare with the latest
> kernel or at least close and which includes new features added since
> v5.15 (which is more than 2 years old now). I understand that this is
> not always easy or doable but you could be surprised by the benefit of
> some features like [0] merged since v5.15
> 
> [0] https://lore.kernel.org/lkml/249816c9-c2b5-8016-f9ce-dab7b7d384e4@arm.com/
> 
Thank you Vincent for the suggestion, I will try to get the results on device running
with most recent kernel and update.

Thanks,
Ashay Jaiswal
>>
>>> You didn't share power numbers which I assume the perf gains are more important
>>> than the power cost for you.
>>>
>> If possible I will try to collect the power number for future test and share the
>> details.
>>
>>>
>>> Thanks!
>>>
>>> --
>>> Qais Yousef

