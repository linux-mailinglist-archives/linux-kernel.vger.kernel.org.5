Return-Path: <linux-kernel+bounces-16886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B264824563
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 16:51:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF92DB214A2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 15:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF767249F3;
	Thu,  4 Jan 2024 15:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rRVIBBF2"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705AA241F6
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 15:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 404Ff2Jv010935;
	Thu, 4 Jan 2024 15:50:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=yvKeq7n7YH/k5ACy1j4ywYrnDi4du92WyhFY0X31Xq0=;
 b=rRVIBBF2guGiOZ8e0r1tEmECYnTENcXZgQ6GyRC9qv+ryEu3Hh3rq+U4BBGi1GIaPyd3
 4xLcOM8on0a3LlAnk/bUITtF20wKuNDtfSJ3ouC8CO7ylal5xrcJ0qa6+Qu5z+Vs90t7
 w1SaPQlvgb+kcpbALoyLD1cC05mmS0aWDGDAQy+vs0bbSBxxPgIApM/1fFJyJ1NnG3jH
 jbuWCX+ThzWS/xCTqBhx9s4V+JiH/Zfm/975y7C8omupbzOXpQTMLKlRZT35x2ApTnft
 1JyqQjZAvpU2/c1n4QgFqDeESlu+WBqusWYPVEBK+Hy2ymS6svWiIWthaLhyw/5cKIfE Xg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vdxvwscmw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Jan 2024 15:50:30 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 404FfJTP012173;
	Thu, 4 Jan 2024 15:50:29 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vdxvwscm7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Jan 2024 15:50:29 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 404F83nf017981;
	Thu, 4 Jan 2024 15:50:28 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vayrkspxr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Jan 2024 15:50:28 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 404FoRJg2818568
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 4 Jan 2024 15:50:28 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B97BC5805C;
	Thu,  4 Jan 2024 15:50:27 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C917558058;
	Thu,  4 Jan 2024 15:50:21 +0000 (GMT)
Received: from [9.43.43.218] (unknown [9.43.43.218])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  4 Jan 2024 15:50:21 +0000 (GMT)
Message-ID: <ea049b25-ba49-4790-8b79-05078adbfc77@linux.vnet.ibm.com>
Date: Thu, 4 Jan 2024 21:20:19 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched/fair: Enable group_asym_packing in
 find_idlest_group
Content-Language: en-US
To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira
 <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Tim Chen <tim.c.chen@linux.intel.com>
References: <20231018155036.2314342-1-srikar@linux.vnet.ibm.com>
From: Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
In-Reply-To: <20231018155036.2314342-1-srikar@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: oFHg0x_HeP1helCipJGJExdDawOWiei1
X-Proofpoint-GUID: N4-4daF7XpwfCX5Dgpc4iWRRKCbWqzc_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-04_09,2024-01-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 impostorscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 mlxscore=0 spamscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401040124


On 10/18/23 9:20 PM, Srikar Dronamraju wrote:

Hi Srikar, 

> Current scheduler code doesn't handle SD_ASYM_PACKING in the
> find_idlest_cpu path. On few architectures, like Powerpc, cache is at a
> core. Moving threads across cores may end up in cache misses.
> 
> While asym_packing can be enabled above SMT level, enabling Asym packing
> across cores could result in poorer performance due to cache misses.
> However if the initial task placement via find_idlest_cpu does take
> Asym_packing into consideration, then scheduler can avoid asym_packing
> migrations. This will result in lesser migrations and better packing and
> better overall performance.
> 

This would handle asym packing case when finding the idle CPU for newly woken
up task and thereby reducing the number of migrations if it is placed correctly in 
the first place. I think thats helpful. 

Currently intel cluster and powerVM shared LPAR's are the two where ASYM PACKING 
is enabled at higher domain than SMT. Is that correct or is there any other topology?

+tim 

> Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
> ---
>  kernel/sched/fair.c | 33 ++++++++++++++++++++++++++++++---
>  1 file changed, 30 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index cb225921bbca..7164f79a3d13 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -9931,11 +9931,13 @@ static int idle_cpu_without(int cpu, struct task_struct *p)
>   * @group: sched_group whose statistics are to be updated.
>   * @sgs: variable to hold the statistics for this group.
>   * @p: The task for which we look for the idlest group/CPU.
> + * @this_cpu: current cpu
>   */
>  static inline void update_sg_wakeup_stats(struct sched_domain *sd,
>  					  struct sched_group *group,
>  					  struct sg_lb_stats *sgs,
> -					  struct task_struct *p)
> +					  struct task_struct *p,
> +					  int this_cpu)
>  {
>  	int i, nr_running;
>  
> @@ -9972,6 +9974,11 @@ static inline void update_sg_wakeup_stats(struct sched_domain *sd,
>  
>  	}
>  
> +	if (sd->flags & SD_ASYM_PACKING && sgs->sum_h_nr_running &&
> +			sched_asym_prefer(group->asym_prefer_cpu, this_cpu)) {
> +		sgs->group_asym_packing = 1;
> +	}
> +


I think there is a corner case here which could be taken care. please correct me if i 
am wrong. 

Assume there are four sched groups, sg1, sg2, sg3 and sg4. asym packing is enabled at sd. 
sg1, and sg3 have one task each and a new task is being created. So find_idlest_cpu is 
called for this new task. 

Because of sgs->sum_h_nr_running check, sg1 and sg3 will have group_asym_packing, while 
sg2 and sg4 will have group_has_spare. update_pick_idlest will choose the lowest type. 
so group_has_spare. TIE would be between sg2 and sg4. Because of asym packing (atleast true 
for powerpc shared LPAR case) sg4 will have lower utilization compared to sg2, and hence sg4 
will be given as the idlest_cpu. On the next load balance sg2 will pull task from sg4 due to 
asym packing. 

Additional migration may be avoided if we omit the sum_h_nr_running check? 


>  	sgs->group_capacity = group->sgc->capacity;
>  
>  	sgs->group_weight = group->group_weight;
> @@ -10012,8 +10019,17 @@ static bool update_pick_idlest(struct sched_group *idlest,
>  			return false;
>  		break;
>  
> -	case group_imbalanced:
>  	case group_asym_packing:
> +		if (sched_asym_prefer(group->asym_prefer_cpu, idlest->asym_prefer_cpu)) {
> +			int busy_cpus = idlest_sgs->group_weight - idlest_sgs->idle_cpus;
> +
> +			busy_cpus -= (sgs->group_weight - sgs->idle_cpus);
> +			if (busy_cpus >= 0)
> +				return true;


wouldn't using idle_cpus would be simpler? something like, 

if (sgs->idle_cpus - idlest->idle_cpus > 0)
	return true

> +		}
> +		return false;
> +
> +	case group_imbalanced:
>  	case group_smt_balance:
>  		/* Those types are not used in the slow wakeup path */
>  		return false;
> @@ -10080,7 +10096,7 @@ find_idlest_group(struct sched_domain *sd, struct task_struct *p, int this_cpu)
>  			sgs = &tmp_sgs;
>  		}
>  
> -		update_sg_wakeup_stats(sd, group, sgs, p);
> +		update_sg_wakeup_stats(sd, group, sgs, p, this_cpu);
>  
>  		if (!local_group && update_pick_idlest(idlest, &idlest_sgs, group, sgs)) {
>  			idlest = group;
> @@ -10112,6 +10128,17 @@ find_idlest_group(struct sched_domain *sd, struct task_struct *p, int this_cpu)
>  	if (local_sgs.group_type > idlest_sgs.group_type)
>  		return idlest;
>  
> +	if (idlest_sgs.group_type == group_asym_packing) {
> +		if (sched_asym_prefer(idlest->asym_prefer_cpu, local->asym_prefer_cpu)) {
> +			int busy_cpus = local_sgs.group_weight - local_sgs.idle_cpus;
> +
> +			busy_cpus -= (idlest_sgs.group_weight - idlest_sgs.idle_cpus);
> +			if (busy_cpus >= 0)
> +				return idlest;
> +		}
> +		return NULL;
> +	}

same comment of using idle_cpus 

> +
>  	switch (local_sgs.group_type) {
>  	case group_overloaded:
>  	case group_fully_busy:

