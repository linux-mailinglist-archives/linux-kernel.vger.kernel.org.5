Return-Path: <linux-kernel+bounces-123356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0803089070C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 18:21:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0C4229BDEC
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 17:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 062E880BFD;
	Thu, 28 Mar 2024 17:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Ry54aVWQ"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FBA27F487
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 17:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711646423; cv=none; b=B6h3HP+sCJou4DqOskpeQo819nfudOzOezlSEqPNS61kZ8PVIP8ObvW/loXRTJUVXaXRM88lvzkYqgLoslNaM4Fs32Ly3m5QRUR0hJWWtFdGhyA/Pzb+yKyaPMsSBqEbjWHLDW2Q1zvyRylKuJx6rgapMH9rphGV/84RQkoj92A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711646423; c=relaxed/simple;
	bh=JQUYA8Qlno79ztgwkrbkxosbBM6CCQY/nkbTEkxToys=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Kk6m4rxd109XUZfDEmCH9LUHaz4Q5jTCbzgMIj75POYJ8uZg/e/vd/Nf7pP65Si1HZTgyQcjLz8sxwKr25klP6NrwwtouKrD0aV1ptpmjOAKQ3/nQQU/M0WbgIacUKWaoxGcq/MGKDv7IXXlK5L0bPStv91i8wcP/VDnNHBMM70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Ry54aVWQ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42SGTrbb000428;
	Thu, 28 Mar 2024 17:20:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=D5efm9nH0CE0KzcWESpM+3ZdQWjRL8jD0sF0ixlfotk=;
 b=Ry54aVWQZ4NVg7YthPbwfSdTWgJkeovbptNHnfN2ZbB2pOB1Ew4I3J5ptNAQag7AfK4I
 mCFZilRcJY/LG5iXmIaAlwX6A+OetEDuUc0wCoq6pc55Id1UurjYWU2HES/n1pXoNonb
 B1VOiKW+Y1lERimCF3gwsyugkhSLyYWq3Xq1Yn3PdiUpNXcRGj7jBUyAsWCOhU1PVtj1
 Th0PGwknIomNGnQSIrS3Y/opbKSVRxEvHM6g9ycodeaYJGR6GRAJpAS5gnH5aDNID7LP
 MwKJI3XGQ7nYthzlILOvblQ8EIr8NSzq7CKE9CPINl0eK/Tpw30PCTYkADhVcxT+YxSg WA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x5bn607er-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Mar 2024 17:20:03 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42SHFfab019320;
	Thu, 28 Mar 2024 17:20:03 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x5bn607en-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Mar 2024 17:20:03 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42SFIHio011285;
	Thu, 28 Mar 2024 17:20:02 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3x2bmmefp0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Mar 2024 17:20:02 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42SHJxvA18088690
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Mar 2024 17:20:01 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B334D5805C;
	Thu, 28 Mar 2024 17:19:59 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 836E758064;
	Thu, 28 Mar 2024 17:19:57 +0000 (GMT)
Received: from [9.79.188.43] (unknown [9.79.188.43])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 28 Mar 2024 17:19:57 +0000 (GMT)
Message-ID: <0b5a4432-384c-4470-a7b6-6fcaf8c28236@linux.ibm.com>
Date: Thu, 28 Mar 2024 22:49:55 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] sched: Minor changes for rd->overload access
To: Ingo Molnar <mingo@kernel.org>
Cc: peterz@infradead.org, vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        qyousef@layalina.io, linux-kernel@vger.kernel.org, vschneid@redhat.com
References: <20240325054505.201995-1-sshegde@linux.ibm.com>
 <ZgFTtAOw39tIyfzR@gmail.com>
 <3c92c18b-6a19-4477-9972-1219c29b3d71@linux.ibm.com>
 <ZgKApcWeuwxc2+WO@gmail.com>
 <38c39ea6-21df-44e9-96e7-6f6fd35822a7@linux.ibm.com>
 <ZgVHq65XKsOZpfgK@gmail.com> <ZgVPhODZ8/nbsqbP@gmail.com>
From: Shrikanth Hegde <sshegde@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <ZgVPhODZ8/nbsqbP@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: SyUtxbTdhzISIv-Xki7QAp8eyquzqPsQ
X-Proofpoint-ORIG-GUID: FJb4lPBm2TD5Sg4srNDbTsqwBdSGvSyk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-28_15,2024-03-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 clxscore=1015 impostorscore=0 mlxscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 phishscore=0 bulkscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2403210000
 definitions=main-2403280120



On 3/28/24 4:37 PM, Ingo Molnar wrote:
> 
> * Ingo Molnar <mingo@kernel.org> wrote:
> 
>> Plus I've applied a patch to rename ::overload to ::overloaded. It is 
>> silly to use an ambiguous noun instead of a clear adjective when naming 
>> such a flag ...
> 
> Plus SG_OVERLOAD should be SG_OVERLOADED as well - it now looks in line 
> with SG_OVERUTILIZED:
> 
>  /* Scheduling group status flags */
>  #define SG_OVERLOADED           0x1 /* More than one runnable task on a CPU. */
>  #define SG_OVERUTILIZED         0x2 /* One or more CPUs are over-utilized. */
> 
> My followup question is: why are these a bitmask, why not separate 
> flags?
> 
> AFAICS we only ever set them separately:
> 
>  thule:~/tip> git grep SG_OVER kernel/sched/
>  kernel/sched/fair.c:            set_rd_overutilized_status(rq->rd, SG_OVERUTILIZED);
>  kernel/sched/fair.c:                    *sg_status |= SG_OVERLOADED;
>  kernel/sched/fair.c:                    *sg_status |= SG_OVERUTILIZED;
>  kernel/sched/fair.c:                            *sg_status |= SG_OVERLOADED;
>  kernel/sched/fair.c:            set_rd_overloaded(env->dst_rq->rd, sg_status & SG_OVERLOADED);
>  kernel/sched/fair.c:                                       sg_status & SG_OVERUTILIZED);
>  kernel/sched/fair.c:    } else if (sg_status & SG_OVERUTILIZED) {
>  kernel/sched/fair.c:            set_rd_overutilized_status(env->dst_rq->rd, SG_OVERUTILIZED);
>  kernel/sched/sched.h:#define SG_OVERLOADED              0x1 /* More than one runnable task on a CPU. */
>  kernel/sched/sched.h:#define SG_OVERUTILIZED            0x2 /* One or more CPUs are over-utilized. */
>  kernel/sched/sched.h:           set_rd_overloaded(rq->rd, SG_OVERLOADED);
> 
> In fact this results in suboptimal code:
> 
>                 /* update overload indicator if we are at root domain */
>                 set_rd_overloaded(env->dst_rq->rd, sg_status & SG_OVERLOADED);
>                         
>                 /* Update over-utilization (tipping point, U >= 0) indicator */
>                 set_rd_overutilized_status(env->dst_rq->rd,
>                                            sg_status & SG_OVERUTILIZED);
> 
> Note how the bits that got mixed together in sg_status now have to be 
> masked out individually.
> 
> The sg_status bitmask appears to make no sense at all to me.
> 
> By turning these into individual bool flags we could also do away with 
> all the extra SG_OVERLOADED/SG_OVERUTILIZED abstraction.
> 
> Ie. something like the patch below? Untested.

Looks good. I see it is merged to sched/core. 
Did a boot with that patch and hackbench is showing same results 320 CPU system.


> 
> Thanks,
> 
> 	Ingo
> 
> =================>
> From: Ingo Molnar <mingo@kernel.org>
> Date: Thu, 28 Mar 2024 12:00:14 +0100
> Subject: [PATCH] sched/balancing: Simplify the sg_status bitmask and use separate ->overloaded and ->overutilized flags
> 
> SG_OVERLOADED and SG_OVERUTILIZED flags plus the sg_status bitmask are an
> unnecessary complication that only make the code harder to read and slower.
> 
> We only ever set them separately:
> 
>  thule:~/tip> git grep SG_OVER kernel/sched/
>  kernel/sched/fair.c:            set_rd_overutilized_status(rq->rd, SG_OVERUTILIZED);
>  kernel/sched/fair.c:                    *sg_status |= SG_OVERLOADED;
>  kernel/sched/fair.c:                    *sg_status |= SG_OVERUTILIZED;
>  kernel/sched/fair.c:                            *sg_status |= SG_OVERLOADED;
>  kernel/sched/fair.c:            set_rd_overloaded(env->dst_rq->rd, sg_status & SG_OVERLOADED);
>  kernel/sched/fair.c:                                       sg_status & SG_OVERUTILIZED);
>  kernel/sched/fair.c:    } else if (sg_status & SG_OVERUTILIZED) {
>  kernel/sched/fair.c:            set_rd_overutilized_status(env->dst_rq->rd, SG_OVERUTILIZED);
>  kernel/sched/sched.h:#define SG_OVERLOADED              0x1 /* More than one runnable task on a CPU. */
>  kernel/sched/sched.h:#define SG_OVERUTILIZED            0x2 /* One or more CPUs are over-utilized. */
>  kernel/sched/sched.h:           set_rd_overloaded(rq->rd, SG_OVERLOADED);
> 
> And use them separately, which results in suboptimal code:
> 
>                 /* update overload indicator if we are at root domain */
>                 set_rd_overloaded(env->dst_rq->rd, sg_status & SG_OVERLOADED);
> 
>                 /* Update over-utilization (tipping point, U >= 0) indicator */
>                 set_rd_overutilized_status(env->dst_rq->rd,
> 
> Introduce separate sg_overloaded and sg_overutilized flags in update_sd_lb_stats()
> and its lower level functions, and change all of them to 'bool'.
> 
> Signed-off-by: Ingo Molnar <mingo@kernel.org>
> ---
>  kernel/sched/fair.c  | 33 ++++++++++++++++-----------------
>  kernel/sched/sched.h | 17 ++++++-----------
>  2 files changed, 22 insertions(+), 28 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index f29efd5f19f6..ebc8d5f855de 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6688,19 +6688,18 @@ static inline bool cpu_overutilized(int cpu)
>  /*
>   * overutilized value make sense only if EAS is enabled
>   */
> -static inline int is_rd_overutilized(struct root_domain *rd)
> +static inline bool is_rd_overutilized(struct root_domain *rd)
>  {
>  	return !sched_energy_enabled() || READ_ONCE(rd->overutilized);
>  }
>  
> -static inline void set_rd_overutilized(struct root_domain *rd,
> -					      unsigned int status)
> +static inline void set_rd_overutilized(struct root_domain *rd, bool flag)
>  {
>  	if (!sched_energy_enabled())
>  		return;
>  
> -	WRITE_ONCE(rd->overutilized, status);
> -	trace_sched_overutilized_tp(rd, !!status);
> +	WRITE_ONCE(rd->overutilized, flag);
> +	trace_sched_overutilized_tp(rd, flag);
>  }
>  
>  static inline void check_update_overutilized_status(struct rq *rq)
> @@ -6711,7 +6710,7 @@ static inline void check_update_overutilized_status(struct rq *rq)
>  	 */
>  
>  	if (!is_rd_overutilized(rq->rd) && cpu_overutilized(rq->cpu))
> -		set_rd_overutilized(rq->rd, SG_OVERUTILIZED);
> +		set_rd_overutilized(rq->rd, 1);
>  }
>  #else
>  static inline void check_update_overutilized_status(struct rq *rq) { }
> @@ -9940,7 +9939,8 @@ static inline void update_sg_lb_stats(struct lb_env *env,
>  				      struct sd_lb_stats *sds,
>  				      struct sched_group *group,
>  				      struct sg_lb_stats *sgs,
> -				      int *sg_status)
> +				      bool *sg_overloaded,
> +				      bool *sg_overutilized)
>  {
>  	int i, nr_running, local_group;
>  
> @@ -9961,10 +9961,10 @@ static inline void update_sg_lb_stats(struct lb_env *env,
>  		sgs->sum_nr_running += nr_running;
>  
>  		if (nr_running > 1)
> -			*sg_status |= SG_OVERLOADED;
> +			*sg_overloaded = 1;
>  
>  		if (cpu_overutilized(i))
> -			*sg_status |= SG_OVERUTILIZED;
> +			*sg_overutilized = 1;
>  
>  #ifdef CONFIG_NUMA_BALANCING
>  		sgs->nr_numa_running += rq->nr_numa_running;
> @@ -9986,7 +9986,7 @@ static inline void update_sg_lb_stats(struct lb_env *env,
>  			/* Check for a misfit task on the cpu */
>  			if (sgs->group_misfit_task_load < rq->misfit_task_load) {
>  				sgs->group_misfit_task_load = rq->misfit_task_load;
> -				*sg_status |= SG_OVERLOADED;
> +				*sg_overloaded = 1;
>  			}
>  		} else if (env->idle && sched_reduced_capacity(rq, env->sd)) {
>  			/* Check for a task running on a CPU with reduced capacity */
> @@ -10612,7 +10612,7 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
>  	struct sg_lb_stats *local = &sds->local_stat;
>  	struct sg_lb_stats tmp_sgs;
>  	unsigned long sum_util = 0;
> -	int sg_status = 0;
> +	bool sg_overloaded = 0, sg_overutilized = 0;
>  
>  	do {
>  		struct sg_lb_stats *sgs = &tmp_sgs;
> @@ -10628,7 +10628,7 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
>  				update_group_capacity(env->sd, env->dst_cpu);
>  		}
>  
> -		update_sg_lb_stats(env, sds, sg, sgs, &sg_status);
> +		update_sg_lb_stats(env, sds, sg, sgs, &sg_overloaded, &sg_overutilized);
>  
>  		if (!local_group && update_sd_pick_busiest(env, sds, sg, sgs)) {
>  			sds->busiest = sg;
> @@ -10657,13 +10657,12 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
>  
>  	if (!env->sd->parent) {
>  		/* update overload indicator if we are at root domain */
> -		set_rd_overloaded(env->dst_rq->rd, sg_status & SG_OVERLOADED);
> +		set_rd_overloaded(env->dst_rq->rd, sg_overloaded);
>  
>  		/* Update over-utilization (tipping point, U >= 0) indicator */
> -		set_rd_overutilized(env->dst_rq->rd,
> -					   sg_status & SG_OVERUTILIZED);
> -	} else if (sg_status & SG_OVERUTILIZED) {
> -		set_rd_overutilized(env->dst_rq->rd, SG_OVERUTILIZED);
> +		set_rd_overutilized(env->dst_rq->rd, sg_overloaded);
> +	} else if (sg_overutilized) {
> +		set_rd_overutilized(env->dst_rq->rd, sg_overutilized);
>  	}
>  
>  	update_idle_cpu_scan(env, sum_util);
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 07c6669b8250..7c39dbf31f75 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -713,7 +713,7 @@ struct rt_rq {
>  	} highest_prio;
>  #endif
>  #ifdef CONFIG_SMP
> -	int			overloaded;
> +	bool			overloaded;
>  	struct plist_head	pushable_tasks;
>  
>  #endif /* CONFIG_SMP */
> @@ -757,7 +757,7 @@ struct dl_rq {
>  		u64		next;
>  	} earliest_dl;
>  
> -	int			overloaded;
> +	bool			overloaded;
>  
>  	/*
>  	 * Tasks on this rq that can be pushed away. They are kept in
> @@ -850,10 +850,6 @@ struct perf_domain {
>  	struct rcu_head rcu;
>  };
>  
> -/* Scheduling group status flags */
> -#define SG_OVERLOADED		0x1 /* More than one runnable task on a CPU. */
> -#define SG_OVERUTILIZED		0x2 /* One or more CPUs are over-utilized. */
> -
>  /*
>   * We add the notion of a root-domain which will be used to define per-domain
>   * variables. Each exclusive cpuset essentially defines an island domain by
> @@ -874,10 +870,10 @@ struct root_domain {
>  	 * - More than one runnable task
>  	 * - Running task is misfit
>  	 */
> -	int			overloaded;
> +	bool			overloaded;
>  
>  	/* Indicate one or more cpus over-utilized (tipping point) */
> -	int			overutilized;
> +	bool			overutilized;
>  
>  	/*
>  	 * The bit corresponding to a CPU gets set here if such CPU has more
> @@ -2540,9 +2536,8 @@ static inline void add_nr_running(struct rq *rq, unsigned count)
>  	}
>  
>  #ifdef CONFIG_SMP
> -	if (prev_nr < 2 && rq->nr_running >= 2) {
> -		set_rd_overloaded(rq->rd, SG_OVERLOADED);
> -	}
> +	if (prev_nr < 2 && rq->nr_running >= 2)
> +		set_rd_overloaded(rq->rd, 1);
>  #endif
>  
>  	sched_update_tick_dependency(rq);

