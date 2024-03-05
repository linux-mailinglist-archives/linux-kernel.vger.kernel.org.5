Return-Path: <linux-kernel+bounces-92564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB02D872233
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 15:59:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92058285BBF
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 14:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C62261272A7;
	Tue,  5 Mar 2024 14:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QIBNQ7Xv"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D35E1272CC
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 14:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709650729; cv=none; b=tmsPNu4ufr9zPO83lUCKyzre+FAEjw0abj1B3hOCDdSht8HDmpBMq07a6wT0UtK1SfjYdChmdEPTObnqoqvdbB4uiUNP62TTPlLwylMrnyldTmNYlcMajsNygqyKWKyIPxU1Oi5GKN3PJKuZqH+ZG7hfTSCx47OTxvxqPEzBuZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709650729; c=relaxed/simple;
	bh=SEJR+owDaVd26AN4IDt/UWU4WTVRoD/qoP6NAHHjN6k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fc+i/NjBoYm1XOB7LziUnUtC1OMnOfdYuE9fuP9uEsBocekp4dFQee+k/0ScY2Iga+GNhWKn8mgNjsu3gJ7kTq76WfZi6s96s74PHJ4kkfmhnj7NsJW6EJtAjrXw4Ew41xmN9f5z2vPbz3/3TkheF7ExYQa5FjG5dGEHqTntwtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QIBNQ7Xv; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 425EwN7O029262;
	Tue, 5 Mar 2024 14:58:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=gF8G3ruhGegqq982W60tv+nSJXALi85T8YtQmLiRDC0=;
 b=QIBNQ7XvN8EpUp9x+tE5jj6jC5LgivULSjwTU6KYimxMDlp02np1QnjHxoBnMH9LnSJs
 ina8p94YUFP5TiZLnjT+fuDe7U+t7gDOpbYCJ7ivOvNWLFKSoTAsZ3cDYq2fSMX6faLF
 /mvzayJOClT53ZxDtIQu+V2eUkpj75k16u3K8cyzp94U2l6KgPaMUYLZXpKKJGMfGb1w
 tiyqGSaSc/6PqCU7L4ATqowc3e6oaay1w0lx0+AJ3vFgZPpxkUIOlqKSenTYEiMz8xaY
 oGJU5cmm1NqbHE7xZE+12SJH51Tezvwxy5BOGO2TyV5Sv2Amh0rA88olcDsL4AWyMu8J +w== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wp560grue-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Mar 2024 14:58:30 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 425EfN1a004632;
	Tue, 5 Mar 2024 14:58:27 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wp560grpf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Mar 2024 14:58:25 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 425E38DZ020667;
	Tue, 5 Mar 2024 14:56:58 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wmfxkr36b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Mar 2024 14:56:58 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 425Eut6050725196
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 5 Mar 2024 14:56:57 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 397F558059;
	Tue,  5 Mar 2024 14:56:55 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E08CF58058;
	Tue,  5 Mar 2024 14:56:50 +0000 (GMT)
Received: from [9.43.117.244] (unknown [9.43.117.244])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  5 Mar 2024 14:56:50 +0000 (GMT)
Message-ID: <6ccd425f-7c02-4ede-9321-1e8154d5d470@linux.ibm.com>
Date: Tue, 5 Mar 2024 20:26:49 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] sched/fair: Add EAS checks before updating
 overutilized
Content-Language: en-US
To: Qais Yousef <qyousef@layalina.io>
Cc: dietmar.eggemann@arm.com, pierre.gondois@arm.com, mingo@kernel.org,
        peterz@infradead.org, vincent.guittot@linaro.org, yu.c.chen@intel.com,
        linux-kernel@vger.kernel.org, nysal@linux.ibm.com,
        aboorvad@linux.ibm.com, srikar@linux.ibm.com, vschneid@redhat.com,
        morten.rasmussen@arm.com
References: <20240301151725.874604-1-sshegde@linux.ibm.com>
 <20240301151725.874604-2-sshegde@linux.ibm.com>
 <20240303185059.wvjkrrn7liwl4wtv@airbuntu>
 <5c6259a2-fadd-41c6-aa41-91f3af01272c@linux.ibm.com>
 <20240305102318.6qfib44f2ciffomw@airbuntu>
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <20240305102318.6qfib44f2ciffomw@airbuntu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Tpq11kbzyt4YjhiQAIvXN8aHQH6weq5e
X-Proofpoint-ORIG-GUID: M2-t9Hh1ljZXV3XH9BxYEKV_xVOhCshl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-05_12,2024-03-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 impostorscore=0 mlxscore=0 phishscore=0 spamscore=0 malwarescore=0
 bulkscore=0 adultscore=0 mlxlogscore=999 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403050119



On 3/5/24 3:53 PM, Qais Yousef wrote:
> On 03/04/24 13:54, Shrikanth Hegde wrote:
>>
>>
>> On 3/4/24 12:20 AM, Qais Yousef wrote:
>>> On 03/01/24 20:47, Shrikanth Hegde wrote:
>>>> Overutilized field of root domain is only used for EAS(energy aware scheduler)
>>
>> [...]
>>
>>
>> Hi Qais, Thanks for taking a look. 
>>
>>>> ---
>>>>  kernel/sched/fair.c | 49 +++++++++++++++++++++++++++------------------
>>>>  1 file changed, 30 insertions(+), 19 deletions(-)
>>>>
>>>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>>>> index 6a16129f9a5c..a71f8a1506e4 100644
>>>> --- a/kernel/sched/fair.c
>>>> +++ b/kernel/sched/fair.c
>>>> @@ -6670,15 +6670,29 @@ static inline bool cpu_overutilized(int cpu)
>>>>  	return !util_fits_cpu(cpu_util_cfs(cpu), rq_util_min, rq_util_max, cpu);
>>>>  }
>>>>
>>>> -static inline void update_overutilized_status(struct rq *rq)
>>>> +static inline void set_rd_overutilized_status(struct root_domain *rd,
>>>> +					      unsigned int status)
>>>>  {
>>>> -	if (!READ_ONCE(rq->rd->overutilized) && cpu_overutilized(rq->cpu)) {
>>>> -		WRITE_ONCE(rq->rd->overutilized, SG_OVERUTILIZED);
>>>> -		trace_sched_overutilized_tp(rq->rd, SG_OVERUTILIZED);
>>>> -	}
>>>
>>> Can we add
>>>
>>> 	if (!sched_energy_enabled())
>>> 		return;
>>
>> This is very close to what i had till v2. But it was pointed out that, it 
>> would end up calling sched_energy_enabled twice in  check_update_overutilized_status. 
> 
> It's a static key. It will either patch the code to be a NOP and return, or
> work normally. I don't see a problem.


Yes. That's what i thought initially as well. It does make the code simpler. 
I will change it to use similar to what i had in v2 in next version. I will wait for a while 
to hear any issues with that. 


> 
>> In check_update_overutilized_status, it would be better to avoid access to 
>> overutilized and computing cpu_overutilized if EAS is not enabled. 
> 
> cpu_overutilized() could gain a protection with sched_energy_enabled() too.
> I think it's better to encapsulate the deps within the function.
> 

ok. let me try to incorporate that. 

>>
>> I am okay with either code. keeping sched_energy_enabled in set_rd_overutilized_status
>> would be less code and more readable. But would call sched_energy_enabled twice. 
>>
>> Dietmar, Pierre, 
>> Could you please provide your inputs here? 
> 
> I prefer not sprinkling sched_energy_enabled() for every user. But FWIW the
> code looks correct to me and these stylistic issues are not a blocker for me
> 
> Reviewed-by: Qais Yousef <qyousef@layalina.io>
> 
>>

Thank you. 

>>

