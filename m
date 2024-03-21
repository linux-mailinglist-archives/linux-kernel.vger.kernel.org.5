Return-Path: <linux-kernel+bounces-110012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB46F8858E0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 13:13:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37A3E283FBC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 12:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8319576038;
	Thu, 21 Mar 2024 12:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mE8rWLos"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DFFB58AAF
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 12:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711023184; cv=none; b=O7DzTdFvyMwXjyg9vhKzJuZlfDemStEiL0PQcWLid7mfbgVRnYvEkcbWu3UC02c64+RvtPES/0VAwc8ntdrUnxTMDh2+F8bWhUwrX5lXsS55YLC/y4U2HGGHF1VCsVtFWls9MMbhanVNlAjhlHO1nqXfKWtNgWCuBjOTfXPcSeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711023184; c=relaxed/simple;
	bh=4Igbt/oi4WxkJRaoy6eHX4cTgTkeBFORb6mCsFIAH7c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZUXkh08BYfEOWV4dZPwGoGrvH9onhUt2+Sn5uekYvlO0d7hcaD9sfZnPhRGSHTUAZMXmeN5BZ11K7X/+iaQVE56c2hgkA0TQwNN2uI84y1EFr1Fb3+dJB8yg7uy0rs4IoESpbjxIqQBMcD8k+vF4mRv5G+JKPEXsjFRVP1jMwOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=mE8rWLos; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42LBUT5F020926;
	Thu, 21 Mar 2024 12:12:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=ojpW2Gzz1CfdzsktsbrIUMF/M1oCTQ95Q3z5RXQZ8+I=;
 b=mE8rWLoszLmLUBqnl6Wwqnz3mGW1ksOLtmXAHgwh/+jxDTOqPhs4lcRu8HEtM5hTwHC6
 nm7f7lbd/Xw0fBGT70+Hg66LZFVrfb7i1YSsmv93RvzC51DMVt1Rv+3CLcW2rGKkNwvd
 Kv4kwIE+CGPhoWpq1s6Y+Y8eb2dIu4z17bjAbOGslCgEGFZaBAtd3m4pJ00zj0TijYQC
 YNSuK1w+fKaYQPcfSere/ruB/lo8JA6XC8f9fmeqoyLPPo6fUNJiSp/JyfMAKwdgo2wm
 R5TFALScIerzFYLtzVLDI0I+YF5eliwtZsnDKGGUNHwO8Jwyhe8cK06X5brn76UTywZ1 VA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x0m2u83h1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Mar 2024 12:12:42 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42LCCfS8023130;
	Thu, 21 Mar 2024 12:12:41 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x0m2u83gw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Mar 2024 12:12:41 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42LBB3Mf002765;
	Thu, 21 Mar 2024 12:12:40 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wwrf2vfbb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Mar 2024 12:12:40 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42LCCcZD13763306
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Mar 2024 12:12:40 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1AE5F58053;
	Thu, 21 Mar 2024 12:12:38 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3224058061;
	Thu, 21 Mar 2024 12:12:33 +0000 (GMT)
Received: from [9.79.184.193] (unknown [9.79.184.193])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 21 Mar 2024 12:12:32 +0000 (GMT)
Message-ID: <1e43e783-55e7-417f-a1a7-503229eb163a@linux.ibm.com>
Date: Thu, 21 Mar 2024 17:42:31 +0530
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
To: Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, Dietmar Eggemann
 <dietmar.eggemann@arm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Valentin Schneider <vschneid@redhat.com>
References: <20240304094831.3639338-1-mingo@kernel.org>
 <20240304094831.3639338-2-mingo@kernel.org>
 <bf612672-f7c3-4585-ac31-e02a1ebf614c@linux.ibm.com>
 <Zer1Hkxh/UMxs3xs@gmail.com>
 <41e11090-a100-48a7-a0dd-c989772822d7@linux.ibm.com>
 <ZfA1LRq1d2ueoSRm@gmail.com>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <ZfA1LRq1d2ueoSRm@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: cnqtfVuvZu-XaVhY1TC5QnX986hHVv_b
X-Proofpoint-GUID: 9X6pSaHM2WpmGl5IIYsJiL-8ZQHQa6VY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-21_08,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 adultscore=0 impostorscore=0 bulkscore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 clxscore=1015 malwarescore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403140000 definitions=main-2403210086



On 3/12/24 4:27 PM, Ingo Molnar wrote:
> 
> * Shrikanth Hegde <sshegde@linux.ibm.com> wrote:
> 
>> I have been thinking would it be right to move this balancing 
>> trylock/atomic after should_we_balance(swb). This does reduce the number 
>> of times this checked/updated significantly. Contention is still present. 
>> That's possible at higher utilization when there are multiple NUMA 
>> domains. one CPU in each NUMA domain can contend if their invocation is 
>> aligned.
> 
> Note that it's not true contention: it simply means there's overlapping 
> requests for the highest domains to be balanced, for which we only have a 
> single thread of execution at a time, system-wide.
> 

Hi Ingo, Vincent, Peter,

I did some more experiments and collected quite a bit of data. 
Some interesting observations.

tl;dr

1. For BUSY and IDLE type load balancing, contention arises since multiple CPU's
are trying to set the flag at the same time. Only one succeeds and tries to do 
load balance. Whether it can do load balance or not is decided later in should_we_balance(swb). 
contention increases with system utilization. Why contention happens is simpler for BUSY, if their 
SOFTIRQ's are aligned. If the busy is invoked(but may prefer idle) while an IDLE CPU is trying is 
scenario when utilization is low. 

2. NEWIDLE does not even check for sched_balance_running and it does not honor 
continue_balancing flag either. should_we_balance for NEWIDLE is mostly return true anyway. 
So NEWIDLE balance doesn't honor the SD_SERIALIZE flag. It does go through all the rq even at the 
highest NUMA Domains often, and pulls task opportunistically. cost of balancing at NUMA is costly 
as it would need to fetch all rq.

>> That makes sense since, Right now a CPU takes lock, checks if it can 
>>  balance, do balance if yes and then releases the lock. If the lock is 
>>  taken after swb then also, CPU checks if it can balance,
>> tries to take the lock and releases the lock if it did. If lock is 
>> contended, it bails out of load_balance. That is the current behaviour as 
>> well, or I am completely wrong.
>>
>> Perf probes at spin_trylock and spin_unlock codepoints on the same 224CPU, 6 NUMA node system. 
>> 6.8-rc6                                                                         
>> -----------------------------------------                                       
>> idle system:                                                                    
>> 449 probe:rebalance_domains_L37                                                 
>> 377 probe:rebalance_domains_L55                                                 
>> stress-ng --cpu=$(nproc) -l 51     << 51% load                                               
>> 88K probe:rebalance_domains_L37                                                 
>> 77K probe:rebalance_domains_L55                                                 
>> stress-ng --cpu=$(nproc) -l 100    << 100% load                                             
>> 41K probe:rebalance_domains_L37                                                 
>> 10K probe:rebalance_domains_L55                                                 
>>                                                                                 
>> +below patch                                                                          
>> ----------------------------------------                                        
>> idle system:                                                                    
>> 462 probe:load_balance_L35                                                      
>> 394 probe:load_balance_L274                                                     
>> stress-ng --cpu=$(nproc) -l 51      << 51% load                                            
>> 5K probe:load_balance_L35                       	<<-- almost 15x less                                
>> 4K probe:load_balance_L274                                                      
>> stress-ng --cpu=$(nproc) -l 100     << 100% load                                            
>> 8K probe:load_balance_L35                                                       
>> 3K probe:load_balance_L274 				<<-- almost 4x less
> 
> That's nice.
> 

These numbers completely go crazy for schbench or hackbench if we move the sched_balance_running 
after should_we_balance due to NEWIDLE. we could add a idle type check before doing operations on
sched_balance_running.   


>> +static DEFINE_SPINLOCK(balancing);
>>  /*
>>   * Check this_cpu to ensure it is balanced within domain. Attempt to move
>>   * tasks if there is an imbalance.
>> @@ -11286,6 +11287,7 @@ static int load_balance(int this_cpu, struct rq *this_rq,
>>  	struct rq *busiest;
>>  	struct rq_flags rf;
>>  	struct cpumask *cpus = this_cpu_cpumask_var_ptr(load_balance_mask);
>> +	int need_serialize;
>>  	struct lb_env env = {
>>  		.sd		= sd,
>>  		.dst_cpu	= this_cpu,
>> @@ -11308,6 +11310,12 @@ static int load_balance(int this_cpu, struct rq *this_rq,
>>  		goto out_balanced;
>>  	}
>>
>> +	need_serialize = sd->flags & SD_SERIALIZE;
>> +	if (need_serialize) {
>> +		if (!spin_trylock(&balancing))
>> +			goto lockout;
>> +	}
>> +
>>  	group = find_busiest_group(&env);
> 
> So if I'm reading your patch right, the main difference appears to be that 
> it allows the should_we_balance() check to be executed in parallel, and 
> will only try to take the NUMA-balancing flag if that function indicates an 
> imbalance.

Yes for BUSY and IDLE balancing. 

> 
> Since should_we_balance() isn't taking any locks AFAICS, this might be a 
> valid approach. What might make sense is to instrument the percentage of 
> NUMA-balancing flag-taking 'failures' vs. successful attempts - not 
> necessarily the 'contention percentage'.

So i put a bunch of trace_printk and added a hacky check similar to swb if taking flag fails. 
I will put the numbers for schebench, hackbench and stress-ng -l 100 for initial reference. 

I ran these a slightly larger system this time.  I have two NUMA levels. domain 3 has two groups 0-159, 160-319.
Sorry in case the data isnt easy to read. I couldnt find a better way. some rounding errors are there, but mostly 
sum where applicable is close. trace is collected for 5 seconds.

  NUMA node(s):           4
  NUMA node0 CPU(s):      0-79
  NUMA node1 CPU(s):      80-159
  NUMA node6 CPU(s):      160-239
  NUMA node7 CPU(s):      240-319

more domain*/flags | cat
::::::::::::::
domain0/flags
::::::::::::::
SD_BALANCE_NEWIDLE SD_BALANCE_EXEC SD_BALANCE_FORK SD_WAKE_AFFINE SD_SHARE_CPUCAPACITY SD_SHARE_LLC SD_PREFER_SIBLING 
::::::::::::::
domain1/flags
::::::::::::::
SD_BALANCE_NEWIDLE SD_BALANCE_EXEC SD_BALANCE_FORK SD_WAKE_AFFINE SD_PREFER_SIBLING 
::::::::::::::
domain2/flags
::::::::::::::
SD_BALANCE_NEWIDLE SD_BALANCE_EXEC SD_BALANCE_FORK SD_WAKE_AFFINE SD_PREFER_SIBLING 
::::::::::::::
domain3/flags
::::::::::::::
SD_BALANCE_NEWIDLE SD_SERIALIZE SD_OVERLAP SD_NUMA 
::::::::::::::
domain4/flags
::::::::::::::
SD_BALANCE_NEWIDLE SD_SERIALIZE SD_OVERLAP SD_NUMA 

================================================================= BUSY balancing ===============================================
		   tried_access_to	|	  	failed			|		aquired(number of sched_balance_rq)  <<-- aquired need not call sched_balance_rq due to time check.
		sched_balance_running	|		to_aquire 		|
					|     swb true?		swb_false?    	|      swb_true?    swb_false?
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
					|    					|	
hackbench   	       254727		|		236268			|		18508(170)		
10 groups 				|	38     <--|-->	236230		| 	0	<--|-->	170      
					|					|
schbench	       217794		|		207117			|		10683(659)
320 groups				| 	1059   <--|-->  206058 		|	1	<--|-->  658
					|					|
stress-ng 		31646		|		 27430			|		4216(523)	
-l100					|	272	<--|-->	 27158		|	6	<--|-->	517
					|					|
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
Observations: 
  * When the flag was not aquired it was mostly that CPU wouldnt have done the balancing. Good.
  * When the flag was aquired, mostly that CPU didn't do load balancing. It bailed out since swb was false. Bad. 


=============================================================== IDLE Balancing ==================================================
		   tried_access_to	|	  	failed			|		aquired(number of sched_balance_rq)  <<-- aquired need not call sched_balance_rq due to time check.
		sched_balance_running	|		to_aquire 		|
					|     swb true?		swb_false?    	|      swb_true?    swb_false?
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

hackbench		11022		| 		7309			|		 3664(2635)
10 groups				|	1322   <--|-->  5987		| 	753	<--|-->	1882 
					|					|
schbench		 3018		|		2305			|		  707(632)
320 groups				|	1036   <--|-->	1269		|	268     <--|--> 364
					|					|
stress-ng 		    0		|		   0			|		    0
-l 100					|					|
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

Observations: 
 * When the flag was not aquired, it was good chance that CPU would have done the balance.  bad
 * When the flag is taken, many times it didnt do balance since swb was false.  bad. 

> 
> But another question is, why do we get here so frequently, so that the 
> cumulative execution time of these SD_SERIAL rebalance passes exceeds that 
> of 100% of single CPU time? Ie. a single CPU is basically continuously 
> scanning the scheduler data structures for imbalances, right? That doesn't 
> seem natural even with just ~224 CPUs.
> 

SD_SERIALIZE passes are costly. Doing a pass through 0-319 takes 20-30us and Doing 
a pass through 0-159 takes around 10-20us.  NEWIDLE can be called very often and it 
doesnt serialize and loops through all domains aggressively.  NEWIDLE balancing 
successfully pull a task around 3-5% of the time. 


For reference, the running the same hackbench, Combined it would take 12 seconds on 320 CPU system 
where trace is collected for 5 seconds. Thats approx 0.7% cycles. 
domain_cost avg: 33031.77 times: 172991  
domain_cost avg: 15615.21 times: 211783
domain_cost avg: 15359.40 times: 208164

Similarly while running schbench, it takes approx 0.12% of total time. 

> Alternatively, is perhaps the execution time of the SD_SERIAL pass so large 
> that we exceed 100% CPU time?
> 

So Main questions i have are: 
1. Should NEWIDLE honor SD_SERIALIZE ? This would make SD_SERIALIZE defined correctly, 
all three types honor it. Currenly on BUSY,IDLE honors it.
2. Should we move taking sched_balance_running after swb atleast for BUSY, IDLE? 

================================================================================================


debug patch used: 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index c8e50fbac345..cb824c327ab6 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -11172,6 +11172,56 @@ static int need_active_balance(struct lb_env *env)
 
 static int active_load_balance_cpu_stop(void *data);
 
+static int hack_check_if_i_can_balance(struct sched_domain *sd, int this_cpu) {
+	struct cpumask *swb_cpus = this_cpu_cpumask_var_ptr(should_we_balance_tmpmask);
+	struct sched_group *sg = sd->groups;
+	int cpu, idle_smt = -1;
+	struct cpumask *cpus = this_cpu_cpumask_var_ptr(load_balance_mask);
+
+	cpumask_and(cpus, sched_domain_span(sd), cpu_active_mask);
+	if (!cpumask_test_cpu(this_cpu, cpus))
+		return 0;
+
+	cpumask_copy(swb_cpus, group_balance_mask(sg));
+	for_each_cpu_and(cpu, swb_cpus, cpus) {
+		if (!idle_cpu(cpu))
+			continue;
+
+		/*
+		 * Don't balance to idle SMT in busy core right away when
+		 * balancing cores, but remember the first idle SMT CPU for
+		 * later consideration.  Find CPU on an idle core first.
+		 */
+		if (!(sd->flags & SD_SHARE_CPUCAPACITY) && !is_core_idle(cpu)) {
+			if (idle_smt == -1)
+				idle_smt = cpu;
+			/*
+			 * If the core is not idle, and first SMT sibling which is
+			 * idle has been found, then its not needed to check other
+			 * SMT siblings for idleness:
+			 */
+#ifdef CONFIG_SCHED_SMT
+			cpumask_andnot(swb_cpus, swb_cpus, cpu_smt_mask(cpu));
+#endif
+			continue;
+		}
+
+		/*
+		 * Are we the first idle core in a non-SMT domain or higher,
+		 * or the first idle CPU in a SMT domain?
+		 */
+		return cpu == this_cpu;
+	}
+
+	/* Are we the first idle CPU with busy siblings? */
+	if (idle_smt != -1)
+		return idle_smt == this_cpu;
+
+	/* Are we the first CPU of this group ? */
+	return group_balance_cpu(sg) == this_cpu;
+}
+
+
 static int should_we_balance(struct lb_env *env)
 {
 	struct cpumask *swb_cpus = this_cpu_cpumask_var_ptr(should_we_balance_tmpmask);
@@ -11267,13 +11317,22 @@ static int sched_balance_rq(int this_cpu, struct rq *this_rq,
 	cpumask_and(cpus, sched_domain_span(sd), cpu_active_mask);
 
 	schedstat_inc(sd->lb_count[idle]);
+	if (sd->flags & SD_SERIALIZE)
+		trace_printk("Trying load_balance_rq for idle: %d span: %*pbl\n", idle,cpumask_pr_args(sched_domain_span(sd)));
 
 redo:
 	if (!should_we_balance(&env)) {
 		*continue_balancing = 0;
+		if (sd->flags & SD_SERIALIZE) {
+			trace_printk("swb says this cpu doesnt need to balance idle: %d span: %*pbl\n", idle, cpumask_pr_args(sched_domain_span(sd)));
+		}
 		goto out_balanced;
 	}
 
+	if (sd->flags & SD_SERIALIZE) {
+		trace_printk("This cpu would try balance idle: %d span: %*pbl\n", idle, cpumask_pr_args(sched_domain_span(sd)));
+	}
+
 	group = sched_balance_find_src_group(&env);
 	if (!group) {
 		schedstat_inc(sd->lb_nobusyg[idle]);
@@ -11288,6 +11347,9 @@ static int sched_balance_rq(int this_cpu, struct rq *this_rq,
 
 	WARN_ON_ONCE(busiest == env.dst_rq);
 
+	if (sd->flags & SD_SERIALIZE) {
+		trace_printk("There is some imbalance idle: %d span: %*pbl\n", idle, cpumask_pr_args(sched_domain_span(sd)));
+	}
 	schedstat_add(sd->lb_imbalance[idle], env.imbalance);
 
 	env.src_cpu = busiest->cpu;
@@ -11507,6 +11569,8 @@ static int sched_balance_rq(int this_cpu, struct rq *this_rq,
 	    sd->balance_interval < sd->max_interval)
 		sd->balance_interval *= 2;
 out:
+	if ((sd->flags & SD_SERIALIZE) && ld_moved)
+		trace_printk("load balance was successful idle: %d span: %*pbl\n", idle, cpumask_pr_args(sched_domain_span(sd)));
 	return ld_moved;
 }
 
@@ -11722,8 +11786,13 @@ static void sched_balance_domains(struct rq *rq, enum cpu_idle_type idle)
 
 		need_serialize = sd->flags & SD_SERIALIZE;
 		if (need_serialize) {
-			if (atomic_cmpxchg_acquire(&sched_balance_running, 0, 1))
+			int result;
+			trace_printk("try to set sched_balance_running idle: %d\n", idle);
+			if (atomic_cmpxchg_acquire(&sched_balance_running, 0, 1)) {
+				result = hack_check_if_i_can_balance(sd, cpu);
+				trace_printk("sched_balance_running  was not aquird idle: %d was_swb: %d\n", idle, result);
 				goto out;
+			}
 		}
 
 		if (time_after_eq(jiffies, sd->last_balance + interval)) {
@@ -11739,8 +11808,10 @@ static void sched_balance_domains(struct rq *rq, enum cpu_idle_type idle)
 			sd->last_balance = jiffies;
 			interval = get_sd_balance_interval(sd, busy);
 		}
-		if (need_serialize)
+		if (need_serialize) {
+			trace_printk("Release sched_balance_running idle: %d\n", idle);
 			atomic_set_release(&sched_balance_running, 0);
+		}
 out:
 		if (time_after(next_balance, sd->last_balance + interval)) {
 			next_balance = sd->last_balance + interval;
@@ -12347,6 +12418,10 @@ static int sched_balance_newidle(struct rq *this_rq, struct rq_flags *rf)
 		u64 domain_cost;
 
 		update_next_balance(sd, &next_balance);
+		if (sd->flags & SD_SERIALIZE) {
+			trace_printk("newidle balance called span: %*pbl,  rq_avg: %llu, curr_cost: %llu, max_idle_cost: %llu\n",
+					cpumask_pr_args(sched_domain_span(sd)), this_rq->avg_idle, curr_cost, sd->max_newidle_lb_cost);
+		}
 
 		if (this_rq->avg_idle < curr_cost + sd->max_newidle_lb_cost)
 			break;
@@ -12360,6 +12435,9 @@ static int sched_balance_newidle(struct rq *this_rq, struct rq_flags *rf)
 			t1 = sched_clock_cpu(this_cpu);
 			domain_cost = t1 - t0;
 			update_newidle_cost(sd, domain_cost);
+			if (sd->flags & SD_SERIALIZE)
+				trace_printk("cost of load balance,span: %*pbl,  pulled_task: %d, domain_cost: %llu\n",
+						cpumask_pr_args(sched_domain_span(sd)), pulled_task, domain_cost);
 
 			curr_cost += domain_cost;
 			t0 = t1;




