Return-Path: <linux-kernel+bounces-119215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 08B5688C5C3
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:50:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53CC11F61FA8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 14:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9904A13C909;
	Tue, 26 Mar 2024 14:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="o3Q83JPu"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC52763E6
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 14:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711464594; cv=none; b=PUG44qCSi7N0glwyAKt+PLwJK/8PJSK9yvs1eNm0BExm1HBEL1jtotMtDgOmdute5NtFDS4jYrwsxw2V6xRveo4+svLtpCSeIH0kyWzLN1Zsbz1C0B0UXl2ZNIR+9lTlXUQN+3xdfaChvHO8XIsQpKz07euePVNukm4+Z4LP6Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711464594; c=relaxed/simple;
	bh=nRX9hcwmY2B8gQNvYhLivbEqgl2pKIQdHk40kdwNzxo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nNZ9BF1V4yU9KYC1X7gevFu/okgcGd1F+xkGtppRxK0NOLLAHrlVSG18TLxKwEmihMEl6+2ankTUQGkNAV87Ngie8T/Z41P0jqgDCAqIxQ9sHY96alXwXp0BLVvB7J+rrvjocHtotM7hSCTRqH+XvUFHArYfZQT38wXqfFuZFN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=o3Q83JPu; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42QDgSau029603;
	Tue, 26 Mar 2024 14:49:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=Sy0B2REPevXpGq5TMlG2zvw4/q277xymIde0VY13bIg=;
 b=o3Q83JPuMjHhAGUdIh+Yjlb+TdhwV6CmIW6cpHwx3Y1dd+thIH2aE50IuBjlTzOSHl4U
 aeszy1a+fwSHtt4sZIfjMXx7hDWTgHj6zpsM5AMQhoyFRs0L+F9oB+HiqymeK9/sKKET
 aM0QdsmO3fhd9Nefei9iZi1BqhdoUQTzFsUXWLTc1NvbgQKE/TZ5YPNddDPHD/2nu+9s
 Nx0P8YYr5yVCREn9ZTOoFohmt4T8lJTGNFi6KicFxipKsjgJSGZ0dPspm1vLf4mwrB4H
 0kn162kafQA55nSLwlc7zSpooFqyzlQ/uFhVRNXlKvxZorMgIkT/2J/fZFLluhIQbNSU XQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x3xm7ranb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Mar 2024 14:49:22 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42QEnL4T003393;
	Tue, 26 Mar 2024 14:49:21 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x3xm7ran9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Mar 2024 14:49:21 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42QEZXQK011321;
	Tue, 26 Mar 2024 14:49:21 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3x2bmkyxf3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Mar 2024 14:49:21 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42QEnHVT43122980
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 Mar 2024 14:49:19 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4BE1F58056;
	Tue, 26 Mar 2024 14:49:17 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9CA3258066;
	Tue, 26 Mar 2024 14:49:13 +0000 (GMT)
Received: from [9.195.45.32] (unknown [9.195.45.32])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 26 Mar 2024 14:49:13 +0000 (GMT)
Message-ID: <b1f784ca-0583-4f85-8f2d-5ceb2d035ae7@linux.ibm.com>
Date: Tue, 26 Mar 2024 20:19:12 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/3] sched/fair: Combine EAS check with overutilized
 access
To: Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@kernel.org>
Cc: peterz@infradead.org, yu.c.chen@intel.com, dietmar.eggemann@arm.com,
        linux-kernel@vger.kernel.org, nysal@linux.ibm.com,
        aboorvad@linux.ibm.com, srikar@linux.ibm.com, vschneid@redhat.com,
        pierre.gondois@arm.com, qyousef@layalina.io
References: <20240307085725.444486-1-sshegde@linux.ibm.com>
 <20240307085725.444486-4-sshegde@linux.ibm.com> <ZgKAJAiAM61MLPBN@gmail.com>
 <CAKfTPtBTUHv3xBe0U75_4GGYPLYj-NC1uSGd6QjdQyS5k1N0QA@mail.gmail.com>
 <3495922c-91cd-448f-8831-5ce8bab0eda4@linux.ibm.com>
 <CAKfTPtDPMShXQYv7ZtfZ6RAgve3Ogsn7aDAYFj7vJuTYe9BOfg@mail.gmail.com>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <CAKfTPtDPMShXQYv7ZtfZ6RAgve3Ogsn7aDAYFj7vJuTYe9BOfg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: J6LsBtssx3s_SRYO3LhKeVmWn381RPBj
X-Proofpoint-GUID: 9rAj251Re4WnnJvfNJgJ8SeKZCooWg6E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-26_06,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 bulkscore=0 mlxscore=0 adultscore=0 clxscore=1015 spamscore=0
 mlxlogscore=999 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2403210000 definitions=main-2403260104



On 3/26/24 7:42 PM, Vincent Guittot wrote:
> On Tue, 26 Mar 2024 at 13:26, Shrikanth Hegde <sshegde@linux.ibm.com> wrote:
>>
>>
>>
>>>>
>>>> While adding the sched_energy_enabled() condition looks OK, the _not prefix
>>>> This is silly: putting logical operators into functions names is far less
>>>> readable than a !fn()...
>>>>
>>>>> -     if (!is_rd_overutilized(rq->rd) && cpu_overutilized(rq->cpu))
>>>>> +     if (is_rd_not_overutilized(rq->rd) && cpu_overutilized(rq->cpu))
>>>>
>>>> Especially since we already have cpu_overutilized(). It's far more coherent
>>>> to have the same basic attribute functions and put any negation into
>>>> *actual* logical operators.
>>>
>>> I was concerned by the || in this case that could defeat the purpose
>>> of sched_energy_enabled() but it will return early anyway
>>>
>>
>>> return !sched_energy_enabled() || READ_ONCE(rd->overutilized);
>>
>> I think this would work.
>>
>>>
>>>>
>>>> Thanks,
>>>>
>>>>         Ingo
>>
>>
>> If EAS - false, then is_rd_overutilized -> would be true always and all users of it do !is_rd_overutilized(). so No operation.
>> If EAS - true, it reads rd->overutilized value.
>>
>> Does this look correct?
> 
> yes looks good to me
> 

Thank you. Let me send it as a patch

>> -------------------------------------------------------------------------------------
>> From 3adc0d58f87d8a2e96196a0f47bcd0d2afd057ae Mon Sep 17 00:00:00 2001
>> From: Shrikanth Hegde <sshegde@linux.ibm.com>
>> Date: Wed, 6 Mar 2024 03:58:58 -0500
>> Subject: [PATCH v7 3/3] sched/fair: Combine EAS check with overutilized access
>>
>> Access to overutilized is always used with sched_energy_enabled in
>> the pattern:
>>
>> if (sched_energy_enabled && !overutilized)
>>        do something
>>
>> So modify the helper function to return this pattern. This is more
>> readable code as it would say, do something when root domain is not
>> overutilized. This function always return true when EAS is disabled.
>>
>> No change in functionality intended.
>>
>> Suggested-by: Vincent Guittot <vincent.guittot@linaro.org>
>> Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
>> ---
>>  kernel/sched/fair.c | 20 +++++++-------------
>>  1 file changed, 7 insertions(+), 13 deletions(-)
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index 24a7530a7d3f..e222e3ad4cfe 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -6686,12 +6686,11 @@ static inline bool cpu_overutilized(int cpu)
>>  }
>>
>>  /*
>> - * Ensure that caller can do EAS. overutilized value
>> - * make sense only if EAS is enabled
>> + * overutilized value make sense only if EAS is enabled
>>   */
>>  static inline int is_rd_overutilized(struct root_domain *rd)
>>  {
>> -       return READ_ONCE(rd->overutilized);
>> +       return !sched_energy_enabled() || READ_ONCE(rd->overutilized);
>>  }
>>
>>  static inline void set_rd_overutilized_status(struct root_domain *rd,
>> @@ -6710,8 +6709,6 @@ static inline void check_update_overutilized_status(struct rq *rq)
>>          * overutilized field is used for load balancing decisions only
>>          * if energy aware scheduler is being used
>>          */
>> -       if (!sched_energy_enabled())
>> -               return;
>>
>>         if (!is_rd_overutilized(rq->rd) && cpu_overutilized(rq->cpu))
>>                 set_rd_overutilized_status(rq->rd, SG_OVERUTILIZED);
>> @@ -7999,7 +7996,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
>>
>>         rcu_read_lock();
>>         pd = rcu_dereference(rd->pd);
>> -       if (!pd || is_rd_overutilized(rd))
>> +       if (!pd)
>>                 goto unlock;
>>
>>         /*
>> @@ -8202,7 +8199,7 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int wake_flags)
>>                     cpumask_test_cpu(cpu, p->cpus_ptr))
>>                         return cpu;
>>
>> -               if (sched_energy_enabled()) {
>> +               if (!is_rd_overutilized(this_rq()->rd)) {
>>                         new_cpu = find_energy_efficient_cpu(p, prev_cpu);
>>                         if (new_cpu >= 0)
>>                                 return new_cpu;
>> @@ -10903,12 +10900,9 @@ static struct sched_group *sched_balance_find_src_group(struct lb_env *env)
>>         if (busiest->group_type == group_misfit_task)
>>                 goto force_balance;
>>
>> -       if (sched_energy_enabled()) {
>> -               struct root_domain *rd = env->dst_rq->rd;
>> -
>> -               if (rcu_dereference(rd->pd) && !is_rd_overutilized(rd))
>> -                       goto out_balanced;
>> -       }
>> +       if (!is_rd_overutilized(env->dst_rq->rd) &&
>> +           rcu_dereference(env->dst_rq->rd->pd))
>> +               goto out_balanced;
>>
>>         /* ASYM feature bypasses nice load balance check */
>>         if (busiest->group_type == group_asym_packing)
>> --
>> 2.39.3

