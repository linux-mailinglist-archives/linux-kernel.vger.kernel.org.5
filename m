Return-Path: <linux-kernel+bounces-88541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95A2986E321
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 15:15:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B7BD1F21B46
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 14:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3095D70AD8;
	Fri,  1 Mar 2024 14:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jIOiKtc7"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE9976F515
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 14:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709302509; cv=none; b=ZpaD2EMJSIMVgu3BMUEjjcSHcipevSVGCG2qZNM/GHKVgQbZ39bP+YUcwo+XANgd1AuixF1+HgPjDCqittGYJFxMShSl7CsPt8pOszvL8XoZHIl8FFj3c611PNgQWpk6PqZJtyf7VRBHjM69XY8bh6e14HvJ8RjbxiNdzTP28uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709302509; c=relaxed/simple;
	bh=qbYqMvNQG8lVro8BRlE4MVKy+Bgmcj6YkMm/dwli/WM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lYD3N5BLn9AbnKCaZuhpTl84JFun+3YQql2nJ+9WyBqjKKHxiZasybklqTQ/9wiSEIw41/beu8c+M0oS0tzvcsF0KwJ5LXp/X73KZcb6/aYkP4E5oTt/7RuCj+iOcvim/j++7TbHdoeohw3p5CLgz4Nw5RGDuSNDuya7A8xVySc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=jIOiKtc7; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 421D66xF024479;
	Fri, 1 Mar 2024 14:14:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=V1+XVIwgAiwb999/xc4fdEgdrjel7/2oxVbwbxZFhU8=;
 b=jIOiKtc76aPf1OWi1jGX5Yb6UrFuAOMV/MULTCqZwGjCZedYIphb4kwAK2/SI9IXk1R/
 qztRry8Xm8P3IBeH/2C+M3vvtm2l9bEh0CENXV0DaTpIkL9xirk+2ZhszZb3jn98HkDF
 LYg1GmG7Sr4ml/xiophIM27g55PAInYBY0nmIvyVRX17jOJDWIYEMA98wHIp9DoiTTjl
 rwSNLBbzfWBoyvQ7fV5jnXSbE0qu1aZdk4ny2ie3uuA+rcPOG/BWJNtKBMdCBy9kXN/0
 Su5hOlYjC/xqdkGttGbM0g8kG7oZVEaRHnaRP+U7gfqymFiCRWkSqU2Ity+leXV9zzTb Lw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wkf1jjhpp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Mar 2024 14:14:47 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 421DuDOx026756;
	Fri, 1 Mar 2024 14:14:47 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wkf1jjhp8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Mar 2024 14:14:47 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 421BfU7W021278;
	Fri, 1 Mar 2024 14:14:45 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wfuspmume-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Mar 2024 14:14:45 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 421EEg4U8127374
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 1 Mar 2024 14:14:44 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 577CD58066;
	Fri,  1 Mar 2024 14:14:42 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B868558063;
	Fri,  1 Mar 2024 14:14:37 +0000 (GMT)
Received: from [9.43.69.231] (unknown [9.43.69.231])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  1 Mar 2024 14:14:37 +0000 (GMT)
Message-ID: <e6fc36a5-e1aa-4476-b334-ce3875061095@linux.ibm.com>
Date: Fri, 1 Mar 2024 19:44:34 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] sched/fair: Add EAS checks before updating
 overutilized
Content-Language: en-US
To: mingo@kernel.org, peterz@infradead.org, vincent.guittot@linaro.org
Cc: yu.c.chen@intel.com, dietmar.eggemann@arm.com,
        linux-kernel@vger.kernel.org, nysal@linux.ibm.com,
        aboorvad@linux.ibm.com, srikar@linux.vnet.ibm.com, vschneid@redhat.com,
        pierre.gondois@arm.com, morten.rasmussen@arm.com, qyousef@layalina.io
References: <20240229104010.747411-1-sshegde@linux.ibm.com>
 <20240229104010.747411-2-sshegde@linux.ibm.com>
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <20240229104010.747411-2-sshegde@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: CRB6HvnsqpHxiEDjSXnVO9pmiN6A6BeE
X-Proofpoint-GUID: UWq7VQxo256Pjw3Um-q0MdEpmdhleoNV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-01_14,2024-03-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 bulkscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 lowpriorityscore=0 mlxscore=0 spamscore=0 malwarescore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403010118



On 2/29/24 4:10 PM, Shrikanth Hegde wrote:
> Overutilized field of root domain is only used for EAS(energy aware scheduler)
> to decide whether to do load balance or not. It is not used if EAS
> not possible.
> 
> Currently enqueue_task_fair and task_tick_fair accesses, sometime updates
> this field. In update_sd_lb_stats it is updated often. This causes cache
> contention due to true sharing and burns a lot of cycles. overload and
> overutilized are part of the same cacheline. Updating it often invalidates
> the cacheline. That causes access  to overload to slow down due to
> false sharing. Hence add EAS check before accessing/updating this field.
> EAS check is optimized at compile time or it is a static branch.
> Hence it shouldn't cost much.
> 
> With the patch, both enqueue_task_fair and newidle_balance don't show
> up as hot routines in perf profile.
> 
> 6.8-rc4:
> 7.18%  swapper          [kernel.vmlinux]              [k] enqueue_task_fair
> 6.78%  s                [kernel.vmlinux]              [k] newidle_balance
> +patch:
> 0.14%  swapper          [kernel.vmlinux]              [k] enqueue_task_fair
> 0.00%  swapper          [kernel.vmlinux]              [k] newidle_balance
> 
> Minor change: trace_sched_overutilized_tp expect that second argument to
> be bool. So do a int to bool conversion for that.
> 
> Fixes: 2802bf3cd936 ("sched/fair: Add over-utilization/tipping point indicator")
> Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
> ---
>  kernel/sched/fair.c | 47 ++++++++++++++++++++++++++++-----------------
>  1 file changed, 29 insertions(+), 18 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 6a16129f9a5c..1f7d62b7c26f 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6670,15 +6670,29 @@ static inline bool cpu_overutilized(int cpu)
>  	return !util_fits_cpu(cpu_util_cfs(cpu), rq_util_min, rq_util_max, cpu);
>  }
> 
> -static inline void update_overutilized_status(struct rq *rq)
> +static inline void set_rd_overutilized_status(struct root_domain *rd,
> +					      unsigned int status)
>  {
> -	if (!READ_ONCE(rq->rd->overutilized) && cpu_overutilized(rq->cpu)) {
> -		WRITE_ONCE(rq->rd->overutilized, SG_OVERUTILIZED);
> -		trace_sched_overutilized_tp(rq->rd, SG_OVERUTILIZED);
> -	}
> +	WRITE_ONCE(rd->overutilized, status);
> +	trace_sched_overutilized_tp(rd, !!status);
> +}
> +
> +static inline void check_update_overutilized_status(struct rq *rq)
> +{
> +	/*
> +	 * overutilized field is used for load balancing decisions only
> +	 * if energy aware scheduler is being used
> +	 */
> +	if (!sched_energy_enabled())
> +		return;
> +
> +	if (!READ_ONCE(rq->rd->overutilized) && cpu_overutilized(rq->cpu))
> +		set_rd_overutilized_status(rq->rd, SG_OVERUTILIZED);
>  }
>  #else
> -static inline void update_overutilized_status(struct rq *rq) { }
> +static inline void check_update_overutilized_status(struct rq *rq) { }
> +static inline void set_rd_overutilized_status(struct root_domain *rd,
> +					      unsigned int status) { }
>  #endif
> 
>  /* Runqueue only has SCHED_IDLE tasks enqueued */
> @@ -6779,7 +6793,7 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>  	 * and the following generally works well enough in practice.
>  	 */
>  	if (!task_new)
> -		update_overutilized_status(rq);
> +		check_update_overutilized_status(rq);
> 
>  enqueue_throttle:
>  	assert_list_leaf_cfs_rq(rq);
> @@ -9902,7 +9916,7 @@ static inline void update_sg_lb_stats(struct lb_env *env,
>  		if (nr_running > 1)
>  			*sg_status |= SG_OVERLOAD;
> 
> -		if (cpu_overutilized(i))
> +		if (sched_energy_enabled() && cpu_overutilized(i))
>  			*sg_status |= SG_OVERUTILIZED;
> 
>  #ifdef CONFIG_NUMA_BALANCING
> @@ -10596,19 +10610,16 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
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
> +		if (sched_energy_enabled()) {
> +			set_rd_overutilized_status(env->dst_rq->rd,
> +						   sg_status & SG_OVERUTILIZED);
> +		}
>  	} else if (sg_status & SG_OVERUTILIZED) {

Sorry. I missed adding a check here. 
Let me do that send out next version.

> -		struct root_domain *rd = env->dst_rq->rd;
> -
> -		WRITE_ONCE(rd->overutilized, SG_OVERUTILIZED);
> -		trace_sched_overutilized_tp(rd, SG_OVERUTILIZED);
> +		set_rd_overutilized_status(env->dst_rq->rd, SG_OVERUTILIZED);
>  	}
> 
>  	update_idle_cpu_scan(env, sum_util);
> @@ -12609,7 +12620,7 @@ static void task_tick_fair(struct rq *rq, struct task_struct *curr, int queued)
>  		task_tick_numa(rq, curr);
> 
>  	update_misfit_status(curr, rq);
> -	update_overutilized_status(task_rq(curr));
> +	check_update_overutilized_status(task_rq(curr));
> 
>  	task_tick_core(rq, curr);
>  }
> --
> 2.39.3
> 

