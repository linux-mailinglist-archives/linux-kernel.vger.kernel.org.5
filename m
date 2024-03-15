Return-Path: <linux-kernel+bounces-104046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9968887C849
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 05:38:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F5E51F2256A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 04:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66C5F1172C;
	Fri, 15 Mar 2024 04:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VZWZbI3C"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C9611185
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 04:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710477475; cv=none; b=EyEIL+PcaFmT3nvmbuWdFQ/arIHpWcnj9YUK0hogJOE8KfHhf9STOxn/Q43FqRmtkujTx41165bj7SipWVSrOPzQO/twE1ktwO1GrhZ9U0rAMeuxImJ5ihUH4FEiIoS0zHKA25FyDap07e+6SBYqphEKbuLKMS+Bw1jFtKvcPqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710477475; c=relaxed/simple;
	bh=M7CS8Zh3whvDJ7ess8kkHkXGSbR7TzkECrSRCBYZYnQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=id3aGnHNmKR8gp30t+u2X9tJLlJp4+74vWB2yE6PV0tL4+dT4FaGRXYQCeHW1ECTOn3D2ZMEvLC2gntBJYcS+uKpJaobck3a5TM88Ux02Xn3+Ry02ngz8Sg83NonivQJICrPb8jDCSdzMFgbuWyQJ0xhUnBZJBdX85XaGi+An7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VZWZbI3C; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42F4HMPs021629;
	Fri, 15 Mar 2024 04:37:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=QtJkBkwdMFdff2I6B/1RAwsWoI3vpqeQXnJvBAtP+0Q=;
 b=VZWZbI3CrsPpY3WJF7btZunGHKyvkmReVSH/Qm0FwVRJaTYeDhw0Tbu0vtW5AGDVQx1h
 yjM7J1+pY01TBaYOisRMx+inDewcRy/6NR4lyLV4Mja/yNd2M9SafzFFBSo93GP62OeQ
 AjVNRdFulAqMMNrVKtREKQkMOoPHlTxOOC0fxQrJKgO8wldZRKK2544x0VkrmVP5plEL
 HayVfqNbQPuWcDmmwpwAPCrsCkaEIj2obWIldA6m395ps3TzYT30kAg74oXbj96qpvR8
 ua6yS0FdsGDOiLuRMvc1wMmDt2PKduoZ0IYJsEWGW1fFnQn+uLcpjtUz7eLIrnvVuRgS Kg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wvf5ug6b4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Mar 2024 04:37:31 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42F4VjPJ018606;
	Fri, 15 Mar 2024 04:37:30 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wvf5ug6ay-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Mar 2024 04:37:30 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42F1ck7a018621;
	Fri, 15 Mar 2024 04:37:29 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3ws4t2h75w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Mar 2024 04:37:29 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42F4bQkS45678956
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Mar 2024 04:37:29 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9FE5D58059;
	Fri, 15 Mar 2024 04:37:26 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8DD2658057;
	Fri, 15 Mar 2024 04:37:23 +0000 (GMT)
Received: from [9.124.31.56] (unknown [9.124.31.56])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 15 Mar 2024 04:37:23 +0000 (GMT)
Message-ID: <d5a53c05-6ff3-4bb3-96e0-b8865bd81611@linux.ibm.com>
Date: Fri, 15 Mar 2024 10:07:22 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/10] sched/debug: Increase SCHEDSTAT_VERSION to 16
To: Swapnil Sapkal <Swapnil.Sapkal@amd.com>
Cc: linux-kernel@vger.kernel.org, Dietmar Eggemann
 <dietmar.eggemann@arm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Valentin Schneider <vschneid@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
        Ingo Molnar <mingo@kernel.org>
References: <20240308105901.1096078-1-mingo@kernel.org>
 <20240308105901.1096078-5-mingo@kernel.org>
 <14d29fdf-ef10-48e6-a102-f1f0bb27c181@linux.ibm.com>
 <ZfAoEmH6KRhjyUor@gmail.com> <ZfKJaztM0FhKRmjg@BLR-5CG11610CF.amd.com>
 <66f1e42c-9035-4f9b-8c77-976ab50638bd@amd.com>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <66f1e42c-9035-4f9b-8c77-976ab50638bd@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 9F1ul7Ev73V2ud58y45RKTFZOoMY_7mO
X-Proofpoint-GUID: B01tAFiTwuVrn-QyKnXVQfPG8jcWHJJS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-14_13,2024-03-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 suspectscore=0 adultscore=0
 mlxscore=0 priorityscore=1501 clxscore=1011 mlxlogscore=999 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403150034



On 3/14/24 11:34 AM, Swapnil Sapkal wrote:
> 
> 
> Please find the patch below. This is based on tip/sched/core.
> 
> ---
> From deeed5bf937bddf227deb1cdb9e2e6c164c48053 Mon Sep 17 00:00:00 2001
> From: Swapnil Sapkal <swapnil.sapkal@amd.com>
> Date: Thu, 15 Jun 2023 04:55:09 +0000
> Subject: [PATCH] sched: Report the different kinds of imbalances in
> /proc/schedstat
> 
> In /proc/schedstat, lb_imbalance reports the sum of imbalances
> discovered in sched domains with each call to sched_balance_rq(), which is
> not very useful because lb_imbalance is an aggregate of the imbalances
> due to load, utilization, nr_tasks and misfit_tasks. Remove this field
> from /proc/schedstat.
> 

Yes. This makes sense. any one of them can skew the value. 

> Currently there are no fields in /proc/schedstat to report different types
> of imbalances. Introduce new fields in /proc/schedstat to report the
> total imbalances in load, utilization, nr_tasks or misfit_tasks.
> 
> Added fields to /proc/schedstat:
>      - lb_imbalance_load: Total imbalance due to load.
>     - lb_imbalance_util: Total imbalance due to utilization.
>     - lb_imbalance_task: Total imbalance due to number of tasks.
>     - lb_imbalance_misfit: Total imbalance due to misfit tasks.
> 
> Signed-off-by: Swapnil Sapkal <swapnil.sapkal@amd.com>
> ---
>  Documentation/scheduler/sched-stats.rst | 104 +++++++++++++-----------
>  include/linux/sched/topology.h          |   5 +-
>  kernel/sched/fair.c                     |  15 +++-
>  kernel/sched/stats.c                    |   7 +-
>  4 files changed, 80 insertions(+), 51 deletions(-)
> 
> diff --git a/Documentation/scheduler/sched-stats.rst
> b/Documentation/scheduler/sched-stats.rst
> index 7c2b16c4729d..d6e9a8a5619c 100644
> --- a/Documentation/scheduler/sched-stats.rst
> +++ b/Documentation/scheduler/sched-stats.rst
> @@ -6,6 +6,9 @@ Version 16 of schedstats changed the order of
> definitions within
>  'enum cpu_idle_type', which changed the order of [CPU_MAX_IDLE_TYPES]
>  columns in show_schedstat(). In particular the position of CPU_IDLE
>  and __CPU_NOT_IDLE changed places. The size of the array is unchanged.
> +Also stop reporting 'lb_imbalance' as it has no significance anymore
> +and instead add more relevant fields namely 'lb_imbalance_load',
> +'lb_imbalance_util', 'lb_imbalance_task' and 'lb_imbalance_misfit'.
>  
>  Version 15 of schedstats dropped counters for some sched_yield:
>  yld_exp_empty, yld_act_empty and yld_both_empty. Otherwise, it is
> @@ -73,86 +76,93 @@ One of these is produced per domain for each cpu
> described. (Note that if
>  CONFIG_SMP is not defined, *no* domains are utilized and these lines
>  will not appear in the output.)
>  
> -domain<N> <cpumask> 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20
> 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36
> +domain<N> <cpumask> 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20
> 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45
>  
>  The first field is a bit mask indicating what cpus this domain operates
> over.
>  

IIUC, this is editing the content of Version 15, But changes would happen on Version 16. 
Instead can we add the section for Version 16 and not modify for 15? 

> -The next 24 are a variety of sched_balance_rq() statistics in grouped
> into types
> +The next 33 are a variety of sched_balance_rq() statistics in grouped
> into types
>  of idleness (idle, busy, and newly idle):
>  
>      1)  # of times in this domain sched_balance_rq() was called when the
> +        cpu was busy
> +    2)  # of times in this domain sched_balance_rq() checked but found the
> +        load did not require balancing when busy
> +    3)  # of times in this domain sched_balance_rq() tried to move one or
> +        more tasks and failed, when the cpu was busy
> +    4)  Total imbalance in load when the cpu was busy
> +    5)  Total imbalance in utilization when the cpu was busy
> +    6)  Total imbalance in number of tasks when the cpu was busy
> +    7)  Total imbalance due to misfit tasks when the cpu was busy
> +    8)  # of times in this domain pull_task() was called when busy
> +    9)  # of times in this domain pull_task() was called even though the
> +        target task was cache-hot when busy
> +    10) # of times in this domain sched_balance_rq() was called but did
> not
> +        find a busier queue while the cpu was busy
> +    11) # of times in this domain a busier queue was found while the cpu
> +        was busy but no busier group was found
> +
> +    12) # of times in this domain sched_balance_rq() was called when the
>          cpu was idle
> -    2)  # of times in this domain sched_balance_rq() checked but found
> +    13) # of times in this domain sched_balance_rq() checked but found
>          the load did not require balancing when the cpu was idle
> -    3)  # of times in this domain sched_balance_rq() tried to move one or
> +    14) # of times in this domain sched_balance_rq() tried to move one or
>          more tasks and failed, when the cpu was idle
> -    4)  sum of imbalances discovered (if any) with each call to
> -        sched_balance_rq() in this domain when the cpu was idle
> -    5)  # of times in this domain pull_task() was called when the cpu
> +    15) Total imbalance in load when the cpu was idle
> +    16) Total imbalance in utilization when the cpu was idle
> +    17) Total imbalance in number of tasks when the cpu was idle
> +    18) Total imbalance due to misfit tasks when the cpu was idle
> +    19) # of times in this domain pull_task() was called when the cpu
>          was idle
> -    6)  # of times in this domain pull_task() was called even though
> +    20) # of times in this domain pull_task() was called even though
>          the target task was cache-hot when idle
> -    7)  # of times in this domain sched_balance_rq() was called but did
> +    21) # of times in this domain sched_balance_rq() was called but did
>          not find a busier queue while the cpu was idle
> -    8)  # of times in this domain a busier queue was found while the
> +    22) # of times in this domain a busier queue was found while the
>          cpu was idle but no busier group was found
> -    9)  # of times in this domain sched_balance_rq() was called when the
> -        cpu was busy
> -    10) # of times in this domain sched_balance_rq() checked but found the
> -        load did not require balancing when busy
> -    11) # of times in this domain sched_balance_rq() tried to move one or
> -        more tasks and failed, when the cpu was busy
> -    12) sum of imbalances discovered (if any) with each call to
> -        sched_balance_rq() in this domain when the cpu was busy
> -    13) # of times in this domain pull_task() was called when busy
> -    14) # of times in this domain pull_task() was called even though the
> -        target task was cache-hot when busy
> -    15) # of times in this domain sched_balance_rq() was called but did
> not
> -        find a busier queue while the cpu was busy
> -    16) # of times in this domain a busier queue was found while the cpu
> -        was busy but no busier group was found
>  
> -    17) # of times in this domain sched_balance_rq() was called when the
> -        cpu was just becoming idle
> -    18) # of times in this domain sched_balance_rq() checked but found the
> +    23) # of times in this domain sched_balance_rq() was called when the
> +        was just becoming idle
> +    24) # of times in this domain sched_balance_rq() checked but found the
>          load did not require balancing when the cpu was just becoming idle
> -    19) # of times in this domain sched_balance_rq() tried to move one
> or more
> +    25) # of times in this domain sched_balance_rq() tried to move one
> or more
>          tasks and failed, when the cpu was just becoming idle
> -    20) sum of imbalances discovered (if any) with each call to
> -        sched_balance_rq() in this domain when the cpu was just
> becoming idle
> -    21) # of times in this domain pull_task() was called when newly idle
> -    22) # of times in this domain pull_task() was called even though the
> +    26) Total imbalance in load when the cpu was just becoming idle
> +    27) Total imbalance in utilization when the cpu was just becoming idle
> +    28) Total imbalance in number of tasks when the cpu was just
> becoming idle
> +    29) Total imbalance due to misfit tasks when the cpu was just
> becoming idle
> +    30) # of times in this domain pull_task() was called when newly idle
> +    31) # of times in this domain pull_task() was called even though the
>          target task was cache-hot when just becoming idle
> -    23) # of times in this domain sched_balance_rq() was called but did
> not
> +    32) # of times in this domain sched_balance_rq() was called but did
> not
>          find a busier queue while the cpu was just becoming idle
> -    24) # of times in this domain a busier queue was found while the cpu
> +    33) # of times in this domain a busier queue was found while the cpu
>          was just becoming idle but no busier group was found
>  
>     Next three are active_load_balance() statistics:
>  
> -    25) # of times active_load_balance() was called
> -    26) # of times active_load_balance() tried to move a task and failed
> -    27) # of times active_load_balance() successfully moved a task
> +    34) # of times active_load_balance() was called
> +    35) # of times active_load_balance() tried to move a task and failed
> +    36) # of times active_load_balance() successfully moved a task
>  
>     Next three are sched_balance_exec() statistics:
>  
> -    28) sbe_cnt is not used
> -    29) sbe_balanced is not used
> -    30) sbe_pushed is not used
> +    37) sbe_cnt is not used
> +    38) sbe_balanced is not used
> +    39) sbe_pushed is not used
>  
>     Next three are sched_balance_fork() statistics:
>  
> -    31) sbf_cnt is not used
> -    32) sbf_balanced is not used
> -    33) sbf_pushed is not used
> +    40) sbf_cnt is not used
> +    41) sbf_balanced is not used
> +    42) sbf_pushed is not used
>  
>     Next three are try_to_wake_up() statistics:
>  
> -    34) # of times in this domain try_to_wake_up() awoke a task that
> +    43) # of times in this domain try_to_wake_up() awoke a task that
>          last ran on a different cpu in this domain
> -    35) # of times in this domain try_to_wake_up() moved a task to the
> +    44) # of times in this domain try_to_wake_up() moved a task to the
>          waking cpu because it was cache-cold on its own cpu anyway
> -    36) # of times in this domain try_to_wake_up() started passive
> balancing
> +    45) # of times in this domain try_to_wake_up() started passive
> balancing
>  
>  /proc/<pid>/schedstat
>  ---------------------
> diff --git a/include/linux/sched/topology.h
> b/include/linux/sched/topology.h
> index c8fe9bab981b..15685c40a713 100644
> --- a/include/linux/sched/topology.h
> +++ b/include/linux/sched/topology.h
> @@ -114,7 +114,10 @@ struct sched_domain {
>      unsigned int lb_count[CPU_MAX_IDLE_TYPES];
>      unsigned int lb_failed[CPU_MAX_IDLE_TYPES];
>      unsigned int lb_balanced[CPU_MAX_IDLE_TYPES];
> -    unsigned int lb_imbalance[CPU_MAX_IDLE_TYPES];
> +    unsigned int lb_imbalance_load[CPU_MAX_IDLE_TYPES];
> +    unsigned int lb_imbalance_util[CPU_MAX_IDLE_TYPES];
> +    unsigned int lb_imbalance_task[CPU_MAX_IDLE_TYPES];
> +    unsigned int lb_imbalance_misfit[CPU_MAX_IDLE_TYPES];
>      unsigned int lb_gained[CPU_MAX_IDLE_TYPES];
>      unsigned int lb_hot_gained[CPU_MAX_IDLE_TYPES];
>      unsigned int lb_nobusyg[CPU_MAX_IDLE_TYPES];
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index a19ea290b790..515258f97ba3 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -11288,7 +11288,20 @@ static int sched_balance_rq(int this_cpu,
> struct rq *this_rq,
>  
>      WARN_ON_ONCE(busiest == env.dst_rq);
>  
> -    schedstat_add(sd->lb_imbalance[idle], env.imbalance);
> +    switch (env.migration_type) {
> +    case migrate_load:
> +        schedstat_add(sd->lb_imbalance_load[idle], env.imbalance);
> +        break;
> +    case migrate_util:
> +        schedstat_add(sd->lb_imbalance_util[idle], env.imbalance);
> +        break;
> +    case migrate_task:
> +        schedstat_add(sd->lb_imbalance_task[idle], env.imbalance);
> +        break;
> +    case migrate_misfit:
> +        schedstat_add(sd->lb_imbalance_misfit[idle], env.imbalance);
> +        break;
> +    }
>  

This switch statement could use a helper function. 

>      env.src_cpu = busiest->cpu;
>      env.src_rq = busiest;
> diff --git a/kernel/sched/stats.c b/kernel/sched/stats.c
> index 78e48f5426ee..a02bc9db2f1c 100644
> --- a/kernel/sched/stats.c
> +++ b/kernel/sched/stats.c
> @@ -151,11 +151,14 @@ static int show_schedstat(struct seq_file *seq,
> void *v)
>              seq_printf(seq, "domain%d %*pb", dcount++,
>                     cpumask_pr_args(sched_domain_span(sd)));
>              for (itype = 0; itype < CPU_MAX_IDLE_TYPES; itype++) {
> -                seq_printf(seq, " %u %u %u %u %u %u %u %u",
> +                seq_printf(seq, " %u %u %u %u %u %u %u %u %u %u %u",
>                      sd->lb_count[itype],
>                      sd->lb_balanced[itype],
>                      sd->lb_failed[itype],
> -                    sd->lb_imbalance[itype],
> +                    sd->lb_imbalance_load[itype],
> +                    sd->lb_imbalance_util[itype],
> +                    sd->lb_imbalance_task[itype],
> +                    sd->lb_imbalance_misfit[itype],
>                      sd->lb_gained[itype],
>                      sd->lb_hot_gained[itype],
>                      sd->lb_nobusyq[itype],

