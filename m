Return-Path: <linux-kernel+bounces-83770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B8D8869E48
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 18:50:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACEF51C22F61
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 17:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F0124EB32;
	Tue, 27 Feb 2024 17:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="S98oTVF/"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1494E1CE
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 17:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709056206; cv=none; b=DY72OG4oHRerY+OvMJclCZlzDAbv8GTSDj2o5WgHIR3LgKQxV9fxHIlr7DAsct9WiyRSc0J8T5l/1fECD34v5XODykh5BZiH269lKDF2pafZt8E2dB5EHcssqqvEzc05e5r2zAzr4dBRG2zMFC8DmKK/btlrOb/JQ+ke28LvCvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709056206; c=relaxed/simple;
	bh=i9+aThPZgLldzijKsM2Ydwnx/AxPAA5Q+suNNuHCYdg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LgplUbgDuJbNv3K9HY5YP4AAgbSbkDNJ+8ivNopGuP8bDjEaMqoFylWgyqAGap8y8bUZ3FJFGkq1/UcVMG57pgESIt4hsobat+fdq2f1LKkzbKueqR169mDcP04WnuDG5/yKNYYgTLNWVc/NTsAP8YxX4TyP1m2i9H/zQ0eV9Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=S98oTVF/; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41RH1v9t015869;
	Tue, 27 Feb 2024 17:49:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=0Ia0QL8JqTJDFrtsrADg0HqWz/7ziWmL83LyNxIblqY=;
 b=S98oTVF/XSnI3OxA8yMg4fJLEx1bAKyMmiaVukj1W2xpx6kpZygfGbL1MJkP6yc3l31y
 vthNStnXc3XaM/98CjC85L6WMAXihmzXNLjTLbWHF50JS7cYuWBi+gZuSr5Juu3hi5Mb
 pgVeZUAJPAQhrT84kNMbjs99hXGTCtNKE9KfguuR6LYaJ1T04a0XK+dVZMyRkQyjhFf4
 ctlfDX/s+kA+s1ovlEiYGvkzfK7X/dbcuJljC4HqD/ITfiK2PUDX4W5HsQS2KGX5oZGs
 kK5/zg9W87qVyohKuSc6yV8C57p5y12BuJgJfMTfQMsAu+t7+aV6m4Yzpql+jD48qoJb LQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3whkseh8xs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Feb 2024 17:49:50 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41RH387B020965;
	Tue, 27 Feb 2024 17:49:50 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3whkseh8xf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Feb 2024 17:49:50 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41RGGKIq024127;
	Tue, 27 Feb 2024 17:49:49 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wfw0k8wws-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Feb 2024 17:49:49 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41RHnk1Z37028582
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Feb 2024 17:49:48 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6C3DC58051;
	Tue, 27 Feb 2024 17:49:46 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4410658065;
	Tue, 27 Feb 2024 17:49:42 +0000 (GMT)
Received: from [9.43.122.193] (unknown [9.43.122.193])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 27 Feb 2024 17:49:41 +0000 (GMT)
Message-ID: <42d5da16-b0d6-48f6-8da3-356f1717bb06@linux.ibm.com>
Date: Tue, 27 Feb 2024 23:19:40 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] sched/fair: Add EAS checks before updating
 overutilized
Content-Language: en-US
To: Chen Yu <yu.c.chen@intel.com>
Cc: mingo@kernel.org, peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, linux-kernel@vger.kernel.org,
        nysal@linux.ibm.com, aboorvad@linux.ibm.com, srikar@linux.vnet.ibm.com,
        vschneid@redhat.com, pierre.gondois@arm.com, morten.rasmussen@arm.com,
        qyousef@layalina.io
References: <20240223150707.410417-1-sshegde@linux.ibm.com>
 <20240223150707.410417-2-sshegde@linux.ibm.com>
 <Zd4RlJJfruTs4Kiu@chenyu5-mobl2>
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <Zd4RlJJfruTs4Kiu@chenyu5-mobl2>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: y1f_8uyAX7FLqf533c3wyZJaYCxDB-22
X-Proofpoint-ORIG-GUID: vSDXGdv01Xke14sKbEqRdjDgL2SNZtb0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-27_05,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 clxscore=1011 spamscore=0 mlxlogscore=999
 suspectscore=0 mlxscore=0 impostorscore=0 adultscore=0 priorityscore=1501
 phishscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311290000 definitions=main-2402270137



On 2/27/24 10:15 PM, Chen Yu wrote:

> On 2024-02-23 at 20:37:06 +0530, Shrikanth Hegde wrote:
>> Overutilized field of root domain is only used for EAS(energy aware scheduler)
>> to decide whether to do regular load balance or EAS aware load balance. It
>> is not used if EAS not possible.
>>
>> Currently enqueue_task_fair and task_tick_fair accesses, sometime updates
>> this field. In update_sd_lb_stats it is updated often.
>> Which causes cache contention due to load/store tearing and burns
>> a lot of cycles.
> 
> Looks like a typical cache false sharing: CPU1 updates the rd->overutilized,
> which invalid the cache line when CPU2 access adjacent rd->overload.
> This changes looks good to me, just some minor questions:

Thanks for taking a look and reviewing it. 

> 
>> Hence add EAS check before updating this field.
>> EAS check is optimized at compile time or it is static branch.
>> Hence it shouldn't cost much.
>>
>> With the patch, both enqueue_task_fair and newidle_balance don't show
>> up as hot routines in perf profile.
>>
>> 6.8-rc4:
>> 7.18%  swapper          [kernel.vmlinux]              [k] enqueue_task_fair
>> 6.78%  s                [kernel.vmlinux]              [k] newidle_balance
>> +patch:
>> 0.14%  swapper          [kernel.vmlinux]              [k] enqueue_task_fair
>> 0.00%  swapper          [kernel.vmlinux]              [k] newidle_balance
>>
>> While here, Fix updating overutilized as either SG_OVERUTILIZED or 0
>> instead. Current code can make it 0, 1 or 2. This shouldn't alter the
>> functionality.
> 
> Just wonder where 1 comes from? In current code we either write SG_OVERUTILIZED
> or sg_status & SG_OVERUTILIZED.

Thanks for catching this, Silly mistake. 
Because of if conditions around I wrongly thought it would be 1. 

I will correct that and send a next version soon.

> 
>>
>> Fixes: 2802bf3cd936 ("sched/fair: Add over-utilization/tipping point indicator")
>> Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
>> ---
>>  kernel/sched/fair.c | 36 +++++++++++++++++++++++++-----------
>>  1 file changed, 25 insertions(+), 11 deletions(-)
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index 8e30e2bb77a0..9529d9ef2c5b 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -6670,15 +6670,30 @@ static inline bool cpu_overutilized(int cpu)
>>  	return !util_fits_cpu(cpu_util_cfs(cpu), rq_util_min, rq_util_max, cpu);
>>  }
>>
>> -static inline void update_overutilized_status(struct rq *rq)
>> +static inline void update_rd_overutilized_status(struct root_domain *rd,
>> +						 int status)
>>  {
>> -	if (!READ_ONCE(rq->rd->overutilized) && cpu_overutilized(rq->cpu)) {
>> -		WRITE_ONCE(rq->rd->overutilized, SG_OVERUTILIZED);
>> -		trace_sched_overutilized_tp(rq->rd, SG_OVERUTILIZED);
>> +	if (sched_energy_enabled()) {
>> +		WRITE_ONCE(rd->overutilized, status);
>> +		trace_sched_overutilized_tp(rd, !!status);
> 
> Is this !!status intentional? The original one is SG_OVERUTILIZED = 2,
> now it is either 0 or 1.
> 

Yes. this is intentional. To convert into to bool.
The tracepoint hook currently defines the second argument as bool.

include/trace/events/sched.h
DECLARE_TRACE(sched_overutilized_tp,                                               
        TP_PROTO(struct root_domain *rd, bool overutilized),                       
        TP_ARGS(rd, overutilized));  

> thanks,
> Chenyu

