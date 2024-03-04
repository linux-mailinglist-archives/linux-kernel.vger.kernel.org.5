Return-Path: <linux-kernel+bounces-90197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 345E286FBCB
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 09:24:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57B3F1C21B15
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 08:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9A0017560;
	Mon,  4 Mar 2024 08:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZFGYjuw/"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F6D171BC
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 08:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709540678; cv=none; b=eQTB2nrgYLwWLfv1jm6c293YaJMXz3Q4JQc4CaKwArwWb4cZZAdenxNBUh8YH27LXX6/ZTXahrBcrE1dYEuf5R0xlxpH8LspM8gWUGuOinG1IYl2e+buQiamDLqbPzssGFM0jJ2bep52v+hpQE54ld1wA0Ydpm+HAPgjAum+TdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709540678; c=relaxed/simple;
	bh=6hOP+avF4BKxXFp32vqRyN1htmj6UoHNuXpdY2evI4A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mNMcVclpCS7nPeyfBU3CWGT2p0geX/vJTBBcjtk65Q6r8QVAnGt0WyycKnEIN1iLeVJkdJAxgsQW3ev2BsvJ6BHPsr2DDYfuhUA894T8eqIUVDQjbNS8uLpetmL9ffAY55ff3PRWAp5Xxw+K5tZ+MKO/9e/fpX4TlDOjaZp7F1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZFGYjuw/; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42486o1f009871;
	Mon, 4 Mar 2024 08:24:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=NLkf6Dbd5BXO0oftNsH+WYAc8SxMzC7WGTPXzEMqprE=;
 b=ZFGYjuw/1fXOcJmfZxh25V3xDxaS1Xq9a7sursd24nNv2sVjXLpe9jDFFVDghzBxO/y9
 g2dFh5SkoqK8sg1IJRcVPxHwR98Y12U3l9/BbMQXIuxbqD0hvIu13ue1p9GMQ+R29C+D
 IHDVDkPUzB0S/zROyJaOCPy4MNk3xWmhh2JSuy+1WJDfX132KkpY6vbTzs/znx/7YLDq
 RZUMOSVQEujsQucQXbbVh2SZfZ637SiYlshJk85ehBsgcclxS4ge8GfoZX9LMazpuadC
 URS1LG8SSHRYUs+jxBXIYPkB92btrokN/JBiENNVYyTOJ2dOqmmgELA/ln3coowbxPHO Zw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wnag98ej7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Mar 2024 08:24:20 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42487NMi010952;
	Mon, 4 Mar 2024 08:24:20 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wnag98ed3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Mar 2024 08:24:19 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 4245EsIb031560;
	Mon, 4 Mar 2024 08:24:15 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wmgnjpyag-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Mar 2024 08:24:15 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4248OCes32637402
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 4 Mar 2024 08:24:14 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AA5785805D;
	Mon,  4 Mar 2024 08:24:12 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5EBC858068;
	Mon,  4 Mar 2024 08:24:08 +0000 (GMT)
Received: from [9.109.201.126] (unknown [9.109.201.126])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  4 Mar 2024 08:24:08 +0000 (GMT)
Message-ID: <5c6259a2-fadd-41c6-aa41-91f3af01272c@linux.ibm.com>
Date: Mon, 4 Mar 2024 13:54:06 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] sched/fair: Add EAS checks before updating
 overutilized
To: Qais Yousef <qyousef@layalina.io>, dietmar.eggemann@arm.com,
        pierre.gondois@arm.com
Cc: mingo@kernel.org, peterz@infradead.org, vincent.guittot@linaro.org,
        yu.c.chen@intel.com, linux-kernel@vger.kernel.org, nysal@linux.ibm.com,
        aboorvad@linux.ibm.com, srikar@linux.ibm.com, vschneid@redhat.com,
        morten.rasmussen@arm.com
References: <20240301151725.874604-1-sshegde@linux.ibm.com>
 <20240301151725.874604-2-sshegde@linux.ibm.com>
 <20240303185059.wvjkrrn7liwl4wtv@airbuntu>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <20240303185059.wvjkrrn7liwl4wtv@airbuntu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: l6uO3vuO3gDWtYn9N-wldRX8vsr23WcT
X-Proofpoint-GUID: 8p31SLlkPFgsSAK8HLrVBMw21dkux0GC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-04_04,2024-03-01_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 clxscore=1015
 mlxscore=0 phishscore=0 suspectscore=0 impostorscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403040063



On 3/4/24 12:20 AM, Qais Yousef wrote:
> On 03/01/24 20:47, Shrikanth Hegde wrote:
>> Overutilized field of root domain is only used for EAS(energy aware scheduler)

[...]


Hi Qais, Thanks for taking a look. 

>> ---
>>  kernel/sched/fair.c | 49 +++++++++++++++++++++++++++------------------
>>  1 file changed, 30 insertions(+), 19 deletions(-)
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index 6a16129f9a5c..a71f8a1506e4 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -6670,15 +6670,29 @@ static inline bool cpu_overutilized(int cpu)
>>  	return !util_fits_cpu(cpu_util_cfs(cpu), rq_util_min, rq_util_max, cpu);
>>  }
>>
>> -static inline void update_overutilized_status(struct rq *rq)
>> +static inline void set_rd_overutilized_status(struct root_domain *rd,
>> +					      unsigned int status)
>>  {
>> -	if (!READ_ONCE(rq->rd->overutilized) && cpu_overutilized(rq->cpu)) {
>> -		WRITE_ONCE(rq->rd->overutilized, SG_OVERUTILIZED);
>> -		trace_sched_overutilized_tp(rq->rd, SG_OVERUTILIZED);
>> -	}
> 
> Can we add
> 
> 	if (!sched_energy_enabled())
> 		return;

This is very close to what i had till v2. But it was pointed out that, it 
would end up calling sched_energy_enabled twice in  check_update_overutilized_status. 
In check_update_overutilized_status, it would be better to avoid access to 
overutilized and computing cpu_overutilized if EAS is not enabled. 

I am okay with either code. keeping sched_energy_enabled in set_rd_overutilized_status
would be less code and more readable. But would call sched_energy_enabled twice. 

Dietmar, Pierre, 
Could you please provide your inputs here? 


> 
> here and avoid sprinkling the condition in other various places instead?
> 
>> +	WRITE_ONCE(rd->overutilized, status);
>> +	trace_sched_overutilized_tp(rd, !!status);
>> +}
>> +
>> +static inline void check_update_overutilized_status(struct rq *rq)
>> +{
>> +	/*
>> +	 * overutilized field is used for load balancing decisions only
>> +	 * if energy aware scheduler is being used
>> +	 */
> 
> nit: I think this comment is unnecessary but I don't mind keeping it
> 
>> +	if (!sched_energy_enabled())
>> +		return;
>> +
>> +	if (!READ_ONCE(rq->rd->overutilized) && cpu_overutilized(rq->cpu))
>> +		set_rd_overutilized_status(rq->rd, SG_OVERUTILIZED);
>>  }
>>  #else
>> -static inline void update_overutilized_status(struct rq *rq) { }
>> +static inline void check_update_overutilized_status(struct rq *rq) { }
>> +static inline void set_rd_overutilized_status(struct root_domain *rd,
>> +					      unsigned int status) { }
>>  #endif
>>
>>  /* Runqueue only has SCHED_IDLE tasks enqueued */
>> @@ -6779,7 +6793,7 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>>  	 * and the following generally works well enough in practice.
>>  	 */
>>  	if (!task_new)
>> -		update_overutilized_status(rq);
>> +		check_update_overutilized_status(rq);
>>
>>  enqueue_throttle:
>>  	assert_list_leaf_cfs_rq(rq);
>> @@ -9902,7 +9916,7 @@ static inline void update_sg_lb_stats(struct lb_env *env,
>>  		if (nr_running > 1)
>>  			*sg_status |= SG_OVERLOAD;
>>
>> -		if (cpu_overutilized(i))
>> +		if (sched_energy_enabled() && cpu_overutilized(i))
> 
> I think we can drop sched_energy_enable() here if we add it to
> set_rd_overutilized_status()

we can avoid additional call to cpu_overutilized. So we should keep it. 

> 
>>  			*sg_status |= SG_OVERUTILIZED;
>>
>>  #ifdef CONFIG_NUMA_BALANCING
>> @@ -10596,19 +10610,16 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
>>  		env->fbq_type = fbq_classify_group(&sds->busiest_stat);
>>
>>  	if (!env->sd->parent) {
>> -		struct root_domain *rd = env->dst_rq->rd;
>> -
>>  		/* update overload indicator if we are at root domain */
>> -		WRITE_ONCE(rd->overload, sg_status & SG_OVERLOAD);
>> +		WRITE_ONCE(env->dst_rq->rd->overload, sg_status & SG_OVERLOAD);
>>
>>  		/* Update over-utilization (tipping point, U >= 0) indicator */
>> -		WRITE_ONCE(rd->overutilized, sg_status & SG_OVERUTILIZED);
>> -		trace_sched_overutilized_tp(rd, sg_status & SG_OVERUTILIZED);
>> -	} else if (sg_status & SG_OVERUTILIZED) {
>> -		struct root_domain *rd = env->dst_rq->rd;
>> -
>> -		WRITE_ONCE(rd->overutilized, SG_OVERUTILIZED);
>> -		trace_sched_overutilized_tp(rd, SG_OVERUTILIZED);
>> +		if (sched_energy_enabled()) {
> 
> ditto

First comment would apply for these two.

>> +			set_rd_overutilized_status(env->dst_rq->rd,
>> +						   sg_status & SG_OVERUTILIZED);
>> +		}
>> +	} else if (sched_energy_enabled() && (sg_status & SG_OVERUTILIZED)) {
> 
> ditto
> 
>> +		set_rd_overutilized_status(env->dst_rq->rd, SG_OVERUTILIZED);
>>  	}
>>
>>  	update_idle_cpu_scan(env, sum_util);
>> @@ -12609,7 +12620,7 @@ static void task_tick_fair(struct rq *rq, struct task_struct *curr, int queued)
>>  		task_tick_numa(rq, curr);
>>
>>  	update_misfit_status(curr, rq);
>> -	update_overutilized_status(task_rq(curr));
>> +	check_update_overutilized_status(task_rq(curr));
>>
>>  	task_tick_core(rq, curr);
>>  }
>> --
>> 2.39.3
>>

