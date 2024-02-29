Return-Path: <linux-kernel+bounces-86118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B25B086BFE3
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 05:30:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 889F41C22BBC
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 04:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE369383A9;
	Thu, 29 Feb 2024 04:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ed23Cbqq"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A295812
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 04:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709181051; cv=none; b=g+w30oJzZqx2bEUlIW53f7JlVP9yyI8WiCt6S3ovfLtbpgx81QMLTa8de+n4bMJbSryHWrNJd5nkeDybBU0zaQRMTaa2+ENZDSBUMgs9un1FQfAzUgAawOg57h5e5kGoVgGlFNu5dI78pGYNPkmnyQBOJ7bhkrSHBSPfUxdIpSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709181051; c=relaxed/simple;
	bh=KeL78d4oFFLDZDPY0TE09R2NoTnxPgtfsE8SY+eJAeU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DztxbDJVLeQ+4IM+4FZhye+qPyPDfI68O3UxYnyf17Z8cUv+UNZyzPY/A6JiM7cD1z6PWigs5GLH5Djcri+GjIKMIVCGxhptJHu6NpEH+P8faU/ICFYxwKJLFFvZlw42CtjbLHqLbvW7G12TXJXmrWxjm1GUMHXlOK3a2UTjXI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ed23Cbqq; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41T3bBaP014236;
	Thu, 29 Feb 2024 04:30:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=RaMk2bsxacQXgozJllMGVkmPV8yKUeA0sKwR8WYytgY=;
 b=ed23CbqqlgJCHz7yfil477MQhlbmlNrSpWyh33a3zY6bjLiy9BVpn6jOD2PoNeoQb7Jh
 u74pvt0C+vwUd5/YMbZ/MwxYeyBIMYrFiaEjvSpOzJnKGcm5sKPSigFuHA1/MeB92mux
 dm+CO0B5ZpPyFBBgW4n7KicjVpUOwvxDDQQcWGsazy+Yj0o3eRnVO2QhxubqxXQp/QqA
 0S03CRxEGCP0FaC743wIfjFe6KRhjuoNyVfgGZmzpxWcpiPoPJRgZ0rVNN3fwlsrQw6r
 XRakQF1m/A/Pkcozfoca+btjU+nXKSpXjc3J6QjfROEAKa8AZvvlwfrftg73UDybzDy2 /w== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wjj671a57-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Feb 2024 04:30:32 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41T40BDC026452;
	Thu, 29 Feb 2024 04:30:31 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wjj671a4g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Feb 2024 04:30:31 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41T41eYS008792;
	Thu, 29 Feb 2024 04:30:30 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wftstu8dv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Feb 2024 04:30:30 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41T4URt321889696
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Feb 2024 04:30:30 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CE72E5805D;
	Thu, 29 Feb 2024 04:30:27 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EE09858058;
	Thu, 29 Feb 2024 04:30:23 +0000 (GMT)
Received: from [9.109.201.126] (unknown [9.109.201.126])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 29 Feb 2024 04:30:23 +0000 (GMT)
Message-ID: <f022d110-9125-4d00-bc13-3e0413520cb5@linux.ibm.com>
Date: Thu, 29 Feb 2024 10:00:22 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] sched/fair: Add EAS checks before updating
 overutilized
Content-Language: en-US
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: yu.c.chen@intel.com, linux-kernel@vger.kernel.org, nysal@linux.ibm.com,
        aboorvad@linux.ibm.com, srikar@linux.vnet.ibm.com, vschneid@redhat.com,
        morten.rasmussen@arm.com, qyousef@layalina.io, mingo@kernel.org,
        peterz@infradead.org, vincent.guittot@linaro.org,
        Pierre Gondois <pierre.gondois@arm.com>
References: <20240228071621.602596-1-sshegde@linux.ibm.com>
 <20240228071621.602596-2-sshegde@linux.ibm.com>
 <86f000a3-3068-4c57-858d-c00e3eb6e974@arm.com>
 <72c2d279-90ae-4612-9b96-e579333b8088@linux.ibm.com>
 <1146ab2f-56c7-43f3-b26b-d91d2bd08556@arm.com>
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <1146ab2f-56c7-43f3-b26b-d91d2bd08556@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Nj8D26EejobnZqYtsg82aH6DGmIzI0S0
X-Proofpoint-GUID: ucxKSMdJRNiB22PraYr32HfjT5Zr2DCI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-28_08,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 clxscore=1015 bulkscore=0 mlxlogscore=999 phishscore=0 adultscore=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402290033



On 2/29/24 5:04 AM, Dietmar Eggemann wrote:
> On 28/02/2024 18:24, Shrikanth Hegde wrote:
> 

Thank you Dietmar, for taking a look. 

> [...]
> 
>> But we will do some extra computation currently and then not use it if it 
>> Non-EAS case in update_sg_lb_stats
>>
>> Would something like this makes sense?
>> @@ -9925,7 +9925,7 @@ static inline void update_sg_lb_stats(struct lb_env *env,
>>                 if (nr_running > 1)
>>                         *sg_status |= SG_OVERLOAD;
>>  
>> -               if (cpu_overutilized(i))
>> +               if (sched_energy_enabled() && cpu_overutilized(i))
>>                         *sg_status |= SG_OVERUTILIZED;
> 
> Yes, we could also disable the setting of OU in load_balance in the none
> !EAS case.
> 
> [...]

Ok. I will add this change. I don't see any other place where we need to do EAS 
check w.r.t to overutilized. This should cover all cases then. 

> 
>>> NIT:
>>> When called from check_update_overutilized_status(),
>>> sched_energy_enabled() will be checked twice.
>> Yes. 
>> But, I think that's okay since it is a static branch check at best. 
>> This way it keeps the code simpler. 
> 
> You could keep the ched_energy_enabled() outside of the new
> set_overutilized_status() to avoid this:
> 
> -->8--

Ok. We can do this as well.  I will incorporate this and send out v3 soon. 


> 
> ---
>  kernel/sched/fair.c | 32 ++++++++++++++++++--------------
>  1 file changed, 18 insertions(+), 14 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 32bc98d9123d..c82164bf45f3 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6676,12 +6676,19 @@ static inline bool cpu_overutilized(int cpu)
>  	return !util_fits_cpu(cpu_util_cfs(cpu), rq_util_min, rq_util_max, cpu);
>  }
>  
> +static inline void set_overutilized_status(struct rq *rq, unsigned int val)
> +{
> +	WRITE_ONCE(rq->rd->overutilized, val);
> +	trace_sched_overutilized_tp(rq->rd, val);
> +}
> +
>  static inline void update_overutilized_status(struct rq *rq)
>  {
> -	if (!READ_ONCE(rq->rd->overutilized) && cpu_overutilized(rq->cpu)) {
> -		WRITE_ONCE(rq->rd->overutilized, SG_OVERUTILIZED);
> -		trace_sched_overutilized_tp(rq->rd, SG_OVERUTILIZED);
> -	}
> +	if (!sched_energy_enabled())
> +		return;
> +
> +	if (!READ_ONCE(rq->rd->overutilized) && cpu_overutilized(rq->cpu))
> +		set_overutilized_status(rq, SG_OVERUTILIZED);
>  }
>  #else
>  static inline void update_overutilized_status(struct rq *rq) { }
> @@ -10755,19 +10762,16 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
>  		env->fbq_type = fbq_classify_group(&sds->busiest_stat);
>  
>  	if (!env->sd->parent) {
> -		struct root_domain *rd = env->dst_rq->rd;
> -
>  		/* update overload indicator if we are at root domain */
> -		WRITE_ONCE(rd->overload, sg_status & SG_OVERLOAD);
> +		WRITE_ONCE(env->dst_rq->rd->overload, sg_status & SG_OVERLOAD);
>  
>  		/* Update over-utilization (tipping point, U >= 0) indicator */
> -		WRITE_ONCE(rd->overutilized, sg_status & SG_OVERUTILIZED);
> -		trace_sched_overutilized_tp(rd, sg_status & SG_OVERUTILIZED);
> -	} else if (sg_status & SG_OVERUTILIZED) {
> -		struct root_domain *rd = env->dst_rq->rd;
> -
> -		WRITE_ONCE(rd->overutilized, SG_OVERUTILIZED);
> -		trace_sched_overutilized_tp(rd, SG_OVERUTILIZED);
> +		if (sched_energy_enabled()) {
> +			set_overutilized_status(env->dst_rq,
> +						sg_status & SG_OVERUTILIZED);
> +		}
> +	} else if (sched_energy_enabled() && sg_status & SG_OVERUTILIZED) {
> +		set_overutilized_status(env->dst_rq, SG_OVERUTILIZED);
>  	}
>  
>  	update_idle_cpu_scan(env, sum_util);

