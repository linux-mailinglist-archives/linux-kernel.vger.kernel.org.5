Return-Path: <linux-kernel+bounces-85432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B031486B5E2
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 18:25:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D9221F279B4
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 17:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96C825B1FB;
	Wed, 28 Feb 2024 17:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="So3wmLE+"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04FF53FBB2
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 17:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709141092; cv=none; b=qLAAFOWRNudeQXiR/PYNeJpQBGNc8+XHNa982S1zwu53Y73Y+JnI5Yw7W9HXAIzg7nHxvVqhi7DdGFDSuHzpGHNtst1jX2KNFhKwpCRb7FkCTLz11+d/sTAw8V/GKewBMS1zPw5Frn6fUF/G3V4dWkWGA5k4RgXnTaly5rupqI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709141092; c=relaxed/simple;
	bh=soRTzd7Me30gCUd+6AIO6TJS6L30Xaor13mHaLhngq4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jzP+cVNU05aqd4ADT2oPU6CE4DyfYeCZP15NmJ/Cc0Ds8m34VXbCWWSurrdo7fqmh2wJVo7x2w+czmDxFs1j5urb4OaovvBOix8banwHTkkwRTdBlgn8I//aMbENdnNMrafLyvE7WDiTSwkw7HjB2x0KvLuZG3S5tdTFvVu9Zls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=So3wmLE+; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41SHImi6015851;
	Wed, 28 Feb 2024 17:24:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=mqVYMcMMlUFQsUkdjAg6n2QQizzlVsv07gqAGjVOnrA=;
 b=So3wmLE+1xlXKVRPvoQSl5IgoV7+AYseQFHyTb+3f7t9DaMnQ3f595vJMw9yDNPomxvh
 eTCMBZV4GMZ2LrrZ3jquSpXDK90ZKkRWitu1FsNUvjLdMgE0GMpU3/m5Es0GZIaVdpoD
 GmILclZCYJQgmYi5G50WJYe8IW/zoYP2topojCXFfR8iglleOTkHZPs7AQ4odw00Q1du
 GZwFvCGEL9aWj6MwFYa2zOYd9ptQ4pajTlVlTaiXiuzbbXDsbnimVOojltohNhmkAJNk
 xku815MOCkPikWAfOlOoGYnex4KfLacUY46adELhANvuWLsqQIvPuLWS49yTNyG8IVOa Qw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wj8wnrk3j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Feb 2024 17:24:34 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41SHIqOf015993;
	Wed, 28 Feb 2024 17:24:33 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wj8wnrk1x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Feb 2024 17:24:33 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41SH6GTX008154;
	Wed, 28 Feb 2024 17:24:32 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wfv9mfk74-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Feb 2024 17:24:32 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41SHOSKO25035314
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 Feb 2024 17:24:30 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C450E58061;
	Wed, 28 Feb 2024 17:24:28 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F0E3558058;
	Wed, 28 Feb 2024 17:24:23 +0000 (GMT)
Received: from [9.43.11.51] (unknown [9.43.11.51])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 28 Feb 2024 17:24:23 +0000 (GMT)
Message-ID: <72c2d279-90ae-4612-9b96-e579333b8088@linux.ibm.com>
Date: Wed, 28 Feb 2024 22:54:22 +0530
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
To: Pierre Gondois <pierre.gondois@arm.com>
Cc: yu.c.chen@intel.com, dietmar.eggemann@arm.com,
        linux-kernel@vger.kernel.org, nysal@linux.ibm.com,
        aboorvad@linux.ibm.com, srikar@linux.vnet.ibm.com, vschneid@redhat.com,
        morten.rasmussen@arm.com, qyousef@layalina.io, mingo@kernel.org,
        peterz@infradead.org, vincent.guittot@linaro.org
References: <20240228071621.602596-1-sshegde@linux.ibm.com>
 <20240228071621.602596-2-sshegde@linux.ibm.com>
 <86f000a3-3068-4c57-858d-c00e3eb6e974@arm.com>
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <86f000a3-3068-4c57-858d-c00e3eb6e974@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: LwbNPo9sYLxtcIBcZ2FqHeKx4th4lZtP
X-Proofpoint-GUID: _LNIgGbO8nsthWBrN9SkJoj9Cl0-F2ik
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-28_08,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 clxscore=1015 impostorscore=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 bulkscore=0 phishscore=0 suspectscore=0
 spamscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402280137



On 2/28/24 9:28 PM, Pierre Gondois wrote:

Hi Pierre, Thanks for taking a look.

> It is nice to avoid calling effective_cpu_util() through the following
> when EAS is not enabled:
> I think we are avoiding calling cpu_overutilized except in update_sg_lb_stats. 
I didnt want to put a EAS check in cpu_overutilized as it could be useful 
function in non-EAS cases in future. calling cpu_overutilized alone doesnt 
do any access to root_domain's overutilized field. So we are okay w.r.t to 
cache issues. 
But we will do some extra computation currently and then not use it if it 
Non-EAS case in update_sg_lb_stats

Would something like this makes sense?
@@ -9925,7 +9925,7 @@ static inline void update_sg_lb_stats(struct lb_env *env,
                if (nr_running > 1)
                        *sg_status |= SG_OVERLOAD;
 
-               if (cpu_overutilized(i))
+               if (sched_energy_enabled() && cpu_overutilized(i))
                        *sg_status |= SG_OVERUTILIZED;
 



I didnt find how would util_fits_cpu ends up calling effective_cpu_util. 
Could you please elaborate? 

> cpu_overutilized()
> \-util_fits_cpu()
>   \- ...
>     \-effective_cpu_util()
> 
> On 2/28/24 08:16, Shrikanth Hegde wrote:
>> Overutilized field of root domain is only used for EAS(energy aware
>> scheduler)
>> to decide whether to do regular load balance or EAS aware load
>> balance. It
>> is not used if EAS not possible.
>>
>> Currently enqueue_task_fair and task_tick_fair accesses, sometime updates
>> this field. In update_sd_lb_stats it is updated often.
>> Which causes cache contention due to load/store tearing and burns
>> a lot of cycles. Hence add EAS check before updating this field.
>> EAS check is optimized at compile time or it is static branch.
>> Hence it shouldn't cost much.
>>
>> With the patch, both enqueue_task_fair and newidle_balance don't show
>> up as hot routines in perf profile.
>>
>> 6.8-rc4:
>> 7.18%  swapper          [kernel.vmlinux]              [k]
>> enqueue_task_fair
>> 6.78%  s                [kernel.vmlinux]              [k] newidle_balance
>> +patch:
>> 0.14%  swapper          [kernel.vmlinux]              [k]
>> enqueue_task_fair
>> 0.00%  swapper          [kernel.vmlinux]              [k] newidle_balance
>>
>> Minor change; trace_sched_overutilized_tp expect that second argument to
>> be bool. So do a int to bool conversion for that.
>>
>> Fixes: 2802bf3cd936 ("sched/fair: Add over-utilization/tipping point
>> indicator")
>> Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
>> ---
>>   kernel/sched/fair.c | 35 ++++++++++++++++++++++++-----------
>>   1 file changed, 24 insertions(+), 11 deletions(-)
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index 8e30e2bb77a0..3105fb08b87e 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -6670,15 +6670,30 @@ static inline bool cpu_overutilized(int cpu)
>>       return !util_fits_cpu(cpu_util_cfs(cpu), rq_util_min,
>> rq_util_max, cpu);
>>   }
>>
>> -static inline void update_overutilized_status(struct rq *rq)
>> +static inline void update_rd_overutilized_status(struct root_domain *rd,
>> +                         int status)
>>   {
>> -    if (!READ_ONCE(rq->rd->overutilized) && cpu_overutilized(rq->cpu)) {
>> -        WRITE_ONCE(rq->rd->overutilized, SG_OVERUTILIZED);
>> -        trace_sched_overutilized_tp(rq->rd, SG_OVERUTILIZED);
>> +    if (sched_energy_enabled()) {
>> +        WRITE_ONCE(rd->overutilized, status);
>> +        trace_sched_overutilized_tp(rd, !!status);
>> +    }
>> +}
> 
> NIT:
> When called from check_update_overutilized_status(),
> sched_energy_enabled() will be checked twice.
Yes. 
But, I think that's okay since it is a static branch check at best. 
This way it keeps the code simpler. 

> 
>> +
>> +static inline void check_update_overutilized_status(struct rq *rq)
>> +{
>> +    /*
>> +     * overutilized field is used for load balancing decisions only
>> +     * if energy aware scheduler is being used
>> +     */
>> +    if (sched_energy_enabled()) {
>> +        if (!READ_ONCE(rq->rd->overutilized) &&
>> cpu_overutilized(rq->cpu))
>> +            update_rd_overutilized_status(rq->rd, SG_OVERUTILIZED);
>>       }
>>   }
>>   #else
>> -static inline void update_overutilized_status(struct rq *rq) { }
>> +static inline void check_update_overutilized_status(struct rq *rq) { }
>> +static inline void update_rd_overutilized_status(struct root_domain *rd,
>> +                         bool status) { }
>>   #endif
>>
>>   /* Runqueue only has SCHED_IDLE tasks enqueued */
>> @@ -6779,7 +6794,7 @@ enqueue_task_fair(struct rq *rq, struct
>> task_struct *p, int flags)
>>        * and the following generally works well enough in practice.
>>        */
>>       if (!task_new)
>> -        update_overutilized_status(rq);
>> +        check_update_overutilized_status(rq);
>>
>>   enqueue_throttle:
>>       assert_list_leaf_cfs_rq(rq);
>> @@ -10613,13 +10628,11 @@ static inline void update_sd_lb_stats(struct
>> lb_env *env, struct sd_lb_stats *sd
>>           WRITE_ONCE(rd->overload, sg_status & SG_OVERLOAD);
>>
>>           /* Update over-utilization (tipping point, U >= 0) indicator */
>> -        WRITE_ONCE(rd->overutilized, sg_status & SG_OVERUTILIZED);
>> -        trace_sched_overutilized_tp(rd, sg_status & SG_OVERUTILIZED);
>> +        update_rd_overutilized_status(rd, sg_status & SG_OVERUTILIZED);
>>       } else if (sg_status & SG_OVERUTILIZED) {
>>           struct root_domain *rd = env->dst_rq->rd;
>>
>> -        WRITE_ONCE(rd->overutilized, SG_OVERUTILIZED);
>> -        trace_sched_overutilized_tp(rd, SG_OVERUTILIZED);
>> +        update_rd_overutilized_status(rd, SG_OVERUTILIZED);
>>       }
>>
>>       update_idle_cpu_scan(env, sum_util);
>> @@ -12625,7 +12638,7 @@ static void task_tick_fair(struct rq *rq,
>> struct task_struct *curr, int queued)
>>           task_tick_numa(rq, curr);
>>
>>       update_misfit_status(curr, rq);
>> -    update_overutilized_status(task_rq(curr));
>> +    check_update_overutilized_status(task_rq(curr));
>>
>>       task_tick_core(rq, curr);
>>   }
>> -- 
>> 2.39.3
>>

