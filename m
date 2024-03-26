Return-Path: <linux-kernel+bounces-118968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7211188C20A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 13:26:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 964761C276D8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 12:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E3DB71B40;
	Tue, 26 Mar 2024 12:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gMv3UC4E"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38E570CDA
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 12:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711455978; cv=none; b=ojl+kim8s0UVTydheRZzfGWi140w0HTnkJzeBwXwO6Slx5iwU+ya/CgEH3c+LODgCOs90qH8DapskmdRGS1bUkQBmJGpqcyKqoT7/x086TrKalCcnr3e7NgMgUnrHAAAeT6RhvsiPWZJJwyVjjepZdaH4hpEQzb+NHWbcrnmids=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711455978; c=relaxed/simple;
	bh=3XLj5IZlJyNEY4fIlHQV6mXEEcwmRsFukUfbxJJYI+E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mJolUZGxJMmKiTTMfes32AWqqApmioxLwnR9ozb2Z4UZXHmfIQ6G/WNqvPPsGCMv9SRcar1NubFkjRTCKgsfVRM+BV7EB74y53RTkPY5IgLekOhSiFWnEaacVHWPjrAj53pol53E+FJa0KVP9BnrOiJdYg+gV0ozQi3ogDft160=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gMv3UC4E; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42QBhnNW005165;
	Tue, 26 Mar 2024 12:25:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=mR+5+uAwLj0yaCK+5SHhm91B5fgVG/P2GunM61QlzC0=;
 b=gMv3UC4ELA/FMMerCG7TTjQO08Lvgnw8rtdIwM5xwnyS9+Fp+WOt3Wzdtm2SndLk7k+H
 s3jBsJF0o6xZv1k7VzVrCx/x2LzSYYyR3504zSOLeHotVF9TGBpPYiIoXtKZTOCp7UPJ
 k0CbWdDvr/unK7U7mN/Su9qucThf372jRztRZOfu80KzIFgVdErWAbDIBi5ftdly0HU9
 +zMQdiRR/nyBLrdHZ5BfdFU2v1/toDFB+yNKgPwkc7AcHskdzhXOS+A8urclXwyfCXsQ
 ypH25NWPsfovuPw68P8GW6VX60FdHQF8j02wQk5HgvqiLi/QEF4z7NKSbfYcB/qW0Mlo bA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x3wqyg3cr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Mar 2024 12:25:55 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42QCPsVV003010;
	Tue, 26 Mar 2024 12:25:54 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x3wqyg3cn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Mar 2024 12:25:54 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42QA7JST028650;
	Tue, 26 Mar 2024 12:25:53 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3x2adp7my2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Mar 2024 12:25:53 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42QCPoW910748546
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 Mar 2024 12:25:52 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6E59C58061;
	Tue, 26 Mar 2024 12:25:50 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 426F858063;
	Tue, 26 Mar 2024 12:25:47 +0000 (GMT)
Received: from [9.79.190.64] (unknown [9.79.190.64])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 26 Mar 2024 12:25:46 +0000 (GMT)
Message-ID: <3495922c-91cd-448f-8831-5ce8bab0eda4@linux.ibm.com>
Date: Tue, 26 Mar 2024 17:55:45 +0530
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
From: Shrikanth Hegde <sshegde@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <CAKfTPtBTUHv3xBe0U75_4GGYPLYj-NC1uSGd6QjdQyS5k1N0QA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: r86puTIbn_vVnT8OanCXKprJydEXUPFv
X-Proofpoint-GUID: 0GsENojla9s0K9JV4DAuj_tRAEQ1jHQS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-26_06,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 malwarescore=0 suspectscore=0 priorityscore=1501
 impostorscore=0 adultscore=0 phishscore=0 spamscore=0 mlxlogscore=999
 mlxscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2403260086



On 3/26/24 1:56 PM, Vincent Guittot wrote:
> On Tue, 26 Mar 2024 at 08:58, Ingo Molnar <mingo@kernel.org> wrote:
>>
>>
>> * Shrikanth Hegde <sshegde@linux.ibm.com> wrote:
>>
>>>  /*
>>> - * Ensure that caller can do EAS. overutilized value
>>> - * make sense only if EAS is enabled
>>> + * overutilized value make sense only if EAS is enabled
>>>   */
>>> -static inline int is_rd_overutilized(struct root_domain *rd)
>>> +static inline int is_rd_not_overutilized(struct root_domain *rd)
>>>  {
>>> -     return READ_ONCE(rd->overutilized);
>>> +     return sched_energy_enabled() && !READ_ONCE(rd->overutilized);
>>>  }
>>
>> While adding the sched_energy_enabled() condition looks OK, the _not prefix
>> This is silly: putting logical operators into functions names is far less
>> readable than a !fn()...
>>
>>> -     if (!is_rd_overutilized(rq->rd) && cpu_overutilized(rq->cpu))
>>> +     if (is_rd_not_overutilized(rq->rd) && cpu_overutilized(rq->cpu))
>>
>> Especially since we already have cpu_overutilized(). It's far more coherent
>> to have the same basic attribute functions and put any negation into
>> *actual* logical operators.
> 
> I was concerned by the || in this case that could defeat the purpose
> of sched_energy_enabled() but it will return early anyway
> 

> return !sched_energy_enabled() || READ_ONCE(rd->overutilized);

I think this would work. 

> 
>>
>> Thanks,
>>
>>         Ingo


If EAS - false, then is_rd_overutilized -> would be true always and all users of it do !is_rd_overutilized(). so No operation.
If EAS - true, it reads rd->overutilized value. 

Does this look correct?  
-------------------------------------------------------------------------------------
From 3adc0d58f87d8a2e96196a0f47bcd0d2afd057ae Mon Sep 17 00:00:00 2001
From: Shrikanth Hegde <sshegde@linux.ibm.com>
Date: Wed, 6 Mar 2024 03:58:58 -0500
Subject: [PATCH v7 3/3] sched/fair: Combine EAS check with overutilized access

Access to overutilized is always used with sched_energy_enabled in
the pattern:

if (sched_energy_enabled && !overutilized)
       do something

So modify the helper function to return this pattern. This is more
readable code as it would say, do something when root domain is not
overutilized. This function always return true when EAS is disabled.

No change in functionality intended.

Suggested-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
---
 kernel/sched/fair.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 24a7530a7d3f..e222e3ad4cfe 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6686,12 +6686,11 @@ static inline bool cpu_overutilized(int cpu)
 }

 /*
- * Ensure that caller can do EAS. overutilized value
- * make sense only if EAS is enabled
+ * overutilized value make sense only if EAS is enabled
  */
 static inline int is_rd_overutilized(struct root_domain *rd)
 {
-	return READ_ONCE(rd->overutilized);
+	return !sched_energy_enabled() || READ_ONCE(rd->overutilized);
 }

 static inline void set_rd_overutilized_status(struct root_domain *rd,
@@ -6710,8 +6709,6 @@ static inline void check_update_overutilized_status(struct rq *rq)
 	 * overutilized field is used for load balancing decisions only
 	 * if energy aware scheduler is being used
 	 */
-	if (!sched_energy_enabled())
-		return;

 	if (!is_rd_overutilized(rq->rd) && cpu_overutilized(rq->cpu))
 		set_rd_overutilized_status(rq->rd, SG_OVERUTILIZED);
@@ -7999,7 +7996,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)

 	rcu_read_lock();
 	pd = rcu_dereference(rd->pd);
-	if (!pd || is_rd_overutilized(rd))
+	if (!pd)
 		goto unlock;

 	/*
@@ -8202,7 +8199,7 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int wake_flags)
 		    cpumask_test_cpu(cpu, p->cpus_ptr))
 			return cpu;

-		if (sched_energy_enabled()) {
+		if (!is_rd_overutilized(this_rq()->rd)) {
 			new_cpu = find_energy_efficient_cpu(p, prev_cpu);
 			if (new_cpu >= 0)
 				return new_cpu;
@@ -10903,12 +10900,9 @@ static struct sched_group *sched_balance_find_src_group(struct lb_env *env)
 	if (busiest->group_type == group_misfit_task)
 		goto force_balance;

-	if (sched_energy_enabled()) {
-		struct root_domain *rd = env->dst_rq->rd;
-
-		if (rcu_dereference(rd->pd) && !is_rd_overutilized(rd))
-			goto out_balanced;
-	}
+	if (!is_rd_overutilized(env->dst_rq->rd) &&
+	    rcu_dereference(env->dst_rq->rd->pd))
+		goto out_balanced;

 	/* ASYM feature bypasses nice load balance check */
 	if (busiest->group_type == group_asym_packing)
--
2.39.3

