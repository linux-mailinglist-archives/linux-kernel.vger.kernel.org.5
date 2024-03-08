Return-Path: <linux-kernel+bounces-97191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 429578766B7
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 15:51:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC9DD2820F5
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 14:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B94A65234;
	Fri,  8 Mar 2024 14:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ipMkZbK6"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E8315D0
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 14:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709909492; cv=none; b=E1ox18D0ax0N7O0ET0rGnyz5TnbvJGFYIWX3cjHFrenOb3TWFEUXSSORAB+uE5ExVG4OT5tVfTn5SghnltO4xaN36OrohtmVp4VMcfhN/2vqU9+wv2Zaz/fobxGwqUB38V45m8EmYZ6A6boH6+sYma+mAujh87XG8Sem1i6m8ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709909492; c=relaxed/simple;
	bh=o5R28wo1j5yA4yxUQwa0nYdZ/B/7PlrJWZdj4kQ/lyw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gYJMp6+6mmNKqsL811bxqf/cSkgXX5+po/rQMuEZyeyRZkfNiLrmE5PLsm+NfJlpMgfoIGyU5oRESru+EEnixjvUAEXNIocP/Bhhn4n9jwoAmnZE2UYpHmc73WeJhRebndPAswb4T+GTZ/tHpC4XUOJoRua3gvkpb1oNAWHD0pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ipMkZbK6; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 428DwAUS016158;
	Fri, 8 Mar 2024 14:51:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=mNKr1aY4tr6ItgDy271C6SAxOqLBFZSiO32Am6yndb4=;
 b=ipMkZbK6SriI1GneiHJ6BsegQnuiCY7iEDb5HRRGM5fmwnkvjestm1bXPdDlFx6s4QsR
 8ACYNaW/3G03KMTB2LF+9yg5jbKv/+WLwePbk2yssec7H4cD/Ig/YwWkZW++sdsXEu3j
 s+Kfgy6zMOfQtWWn+gof+iY3T3YZoHlHZeCbULVZIB/8w32iwgASFmRGlVXgdEswnFCQ
 LM39wKoVKPb0aAXtVN1hprRJ5mXYoHQL+cfEEJc5gq6RXAZxcGBrj0EX8Vzwdf/xSgVW
 +hPuYvzuSrE6uaB+aBHTzuvmn2vDirphbiRu8WjR3bld/k3vJUupifA5E8XT2HR2J9pP Cg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wr414s08r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Mar 2024 14:51:16 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 428EpFa6013051;
	Fri, 8 Mar 2024 14:51:15 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wr414s06f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Mar 2024 14:51:15 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 428DkgGE010913;
	Fri, 8 Mar 2024 14:48:24 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wmh52vhak-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Mar 2024 14:48:24 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 428EmLsM46137848
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 8 Mar 2024 14:48:23 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F177158059;
	Fri,  8 Mar 2024 14:48:20 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 75D4658043;
	Fri,  8 Mar 2024 14:48:18 +0000 (GMT)
Received: from [9.43.68.167] (unknown [9.43.68.167])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  8 Mar 2024 14:48:18 +0000 (GMT)
Message-ID: <41e11090-a100-48a7-a0dd-c989772822d7@linux.ibm.com>
Date: Fri, 8 Mar 2024 20:18:17 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/9] sched/balancing: Switch the
 'DEFINE_SPINLOCK(balancing)' spinlock into an 'atomic_t
 sched_balance_running' flag
Content-Language: en-US
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Valentin Schneider <vschneid@redhat.com>
References: <20240304094831.3639338-1-mingo@kernel.org>
 <20240304094831.3639338-2-mingo@kernel.org>
 <bf612672-f7c3-4585-ac31-e02a1ebf614c@linux.ibm.com>
 <Zer1Hkxh/UMxs3xs@gmail.com>
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <Zer1Hkxh/UMxs3xs@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: OrO-E_HYdWmR55ah_cR2SGMeWJGZmd_S
X-Proofpoint-ORIG-GUID: i7ZagJP1pphcK0XFWn907U_imEKtXy24
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-08_08,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 spamscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0 bulkscore=0
 phishscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2403080119



On 3/8/24 4:53 PM, Ingo Molnar wrote:
> 
> * Shrikanth Hegde <sshegde@linux.ibm.com> wrote:
> 
>> system is at 75% load		<-- 	25.6% contention
>> 113K probe:rebalance_domains_L37
>> 84K probe:rebalance_domains_L55
>>
>> 87
>> system is at 100% load		<--	87.5% contention.
>> 64K probe:rebalance_domains_L37
>> 8K probe:rebalance_domains_L55
>>
>>
>> A few reasons for contentions could be: 
>>
>> 1. idle load balance is running and some other cpu is becoming idle, and 
>>    tries newidle_balance.
>>
>> 2. when system is busy, every CPU would do busy balancing, it would 
>>    contend for the lock. It will not do balance as should_we_balance says 
>>    this CPU need not balance. It bails out and release the lock.
> 
> Thanks, these measurements are really useful!
> 
> Would it be possible to disambiguate these two cases?

I think its not case 1, since newidle_balance doesnt even take that lock. So 
likely its case 2. 

> 
> I think we should probably do something about this contention on this large 
> system: especially if #2 'no work to be done' bailout is the common case.
> 


I have been thinking would it be right to move this balancing trylock/atomic after 
should_we_balance(swb). This does reduce the number of times this checked/updated 
significantly. Contention is still present. That's possible at higher utilization 
when there are multiple NUMA domains. one CPU in each NUMA domain can contend if their invocation
is aligned. 

That makes sense since, Right now a CPU takes lock, checks if it can balance, do balance if yes and
 then releases the lock. If the lock is taken after swb then also, CPU checks if it can balance, 
tries to take the lock and releases the lock if it did. If lock is contended, it bails out of 
load_balance. That is the current behaviour as well, or I am completely wrong. 

Not sure in which scenarios that would hurt. we could do this after this series. 
This may need wider functional testing to make sure we don't regress badly in some cases. 
This is only an *idea* as of now. 

Perf probes at spin_trylock and spin_unlock codepoints on the same 224CPU, 6 NUMA node system. 
6.8-rc6                                                                         
-----------------------------------------                                       
idle system:                                                                    
449 probe:rebalance_domains_L37                                                 
377 probe:rebalance_domains_L55                                                 
stress-ng --cpu=$(nproc) -l 51     << 51% load                                               
88K probe:rebalance_domains_L37                                                 
77K probe:rebalance_domains_L55                                                 
stress-ng --cpu=$(nproc) -l 100    << 100% load                                             
41K probe:rebalance_domains_L37                                                 
10K probe:rebalance_domains_L55                                                 
                                                                                
+below patch                                                                          
----------------------------------------                                        
idle system:                                                                    
462 probe:load_balance_L35                                                      
394 probe:load_balance_L274                                                     
stress-ng --cpu=$(nproc) -l 51      << 51% load                                            
5K probe:load_balance_L35                       	<<-- almost 15x less                                
4K probe:load_balance_L274                                                      
stress-ng --cpu=$(nproc) -l 100     << 100% load                                            
8K probe:load_balance_L35                                                       
3K probe:load_balance_L274 				<<-- almost 4x less


diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 62f247bdec86..3a8de7454377 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -11272,6 +11272,7 @@ static int should_we_balance(struct lb_env *env)
 	return group_balance_cpu(sg) == env->dst_cpu;
 }

+static DEFINE_SPINLOCK(balancing);
 /*
  * Check this_cpu to ensure it is balanced within domain. Attempt to move
  * tasks if there is an imbalance.
@@ -11286,6 +11287,7 @@ static int load_balance(int this_cpu, struct rq *this_rq,
 	struct rq *busiest;
 	struct rq_flags rf;
 	struct cpumask *cpus = this_cpu_cpumask_var_ptr(load_balance_mask);
+	int need_serialize;
 	struct lb_env env = {
 		.sd		= sd,
 		.dst_cpu	= this_cpu,
@@ -11308,6 +11310,12 @@ static int load_balance(int this_cpu, struct rq *this_rq,
 		goto out_balanced;
 	}

+	need_serialize = sd->flags & SD_SERIALIZE;
+	if (need_serialize) {
+		if (!spin_trylock(&balancing))
+			goto lockout;
+	}
+
 	group = find_busiest_group(&env);
 	if (!group) {
 		schedstat_inc(sd->lb_nobusyg[idle]);
@@ -11434,6 +11442,8 @@ static int load_balance(int this_cpu, struct rq *this_rq,
 			if (!cpumask_subset(cpus, env.dst_grpmask)) {
 				env.loop = 0;
 				env.loop_break = SCHED_NR_MIGRATE_BREAK;
+				if (need_serialize)
+					spin_unlock(&balancing);
 				goto redo;
 			}
 			goto out_all_pinned;
@@ -11540,7 +11550,12 @@ static int load_balance(int this_cpu, struct rq *this_rq,
 	     sd->balance_interval < MAX_PINNED_INTERVAL) ||
 	    sd->balance_interval < sd->max_interval)
 		sd->balance_interval *= 2;
+
 out:
+	if (need_serialize)
+		spin_unlock(&balancing);
+
+lockout:
 	return ld_moved;
 }

@@ -11665,7 +11680,6 @@ static int active_load_balance_cpu_stop(void *data)
 	return 0;
 }

-static DEFINE_SPINLOCK(balancing);

 /*
  * Scale the max load_balance interval with the number of CPUs in the system.
@@ -11716,7 +11730,7 @@ static void rebalance_domains(struct rq *rq, enum cpu_idle_type idle)
 	/* Earliest time when we have to do rebalance again */
 	unsigned long next_balance = jiffies + 60*HZ;
 	int update_next_balance = 0;
-	int need_serialize, need_decay = 0;
+	int need_decay = 0;
 	u64 max_cost = 0;

 	rcu_read_lock();
@@ -11741,12 +11755,6 @@ static void rebalance_domains(struct rq *rq, enum cpu_idle_type idle)

 		interval = get_sd_balance_interval(sd, busy);

-		need_serialize = sd->flags & SD_SERIALIZE;
-		if (need_serialize) {
-			if (!spin_trylock(&balancing))
-				goto out;
-		}
-
 		if (time_after_eq(jiffies, sd->last_balance + interval)) {
 			if (load_balance(cpu, rq, sd, idle, &continue_balancing)) {
 				/*
@@ -11760,9 +11768,7 @@ static void rebalance_domains(struct rq *rq, enum cpu_idle_type idle)
 			sd->last_balance = jiffies;
 			interval = get_sd_balance_interval(sd, busy);
 		}
-		if (need_serialize)
-			spin_unlock(&balancing);
-out:
+
 		if (time_after(next_balance, sd->last_balance + interval)) {
 			next_balance = sd->last_balance + interval;
 			update_next_balance = 1;




