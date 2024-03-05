Return-Path: <linux-kernel+bounces-92230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79FEE871D1F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 12:12:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28052285C9C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 11:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C877548F6;
	Tue,  5 Mar 2024 11:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Rhlj1ltm"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE5A566D
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 11:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709637147; cv=none; b=XiGBaHDod3i1wK17kOVczVoKDtYeX3XuumFVDXH9UM24HYimbyRw7f/riAL1ZDK383esnpo4nu0cmPKofMMqb/+xjIqh5S2IjJGt3yNQWxGi5Y3UCAZm5X83Z9GSWqUcLtqDD5szADW2R/gL7ow+/FnPYqLwBG3F5BIIqIBbcgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709637147; c=relaxed/simple;
	bh=/8RgNZ/pL48W7/zF85BzN1nTc006TcPDtgbRodGQmAw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mEO8waexZPUpJtQkcXfCLLXeJ+d8IO/J4GLig/V2CSbcdtJQtgfny0Lu3zv06yxTObXlWGzSa/WH2X3pvbu/0kHFZJ4Pmt8UlCP08UrIZ9CnG8OFpkKzi+RyVXK/GiEgnGu03VnVtLlOL3HhUa6J7Oeb3/9brji+c367Extyp30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Rhlj1ltm; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 425AvUae030348;
	Tue, 5 Mar 2024 11:12:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=JjolfC5LWMpuVZ/45XF64mjgvB5hzzQSkfrbIAioEh4=;
 b=Rhlj1ltmYcKiw7oZwCZyztbYX+Kx8AlaVdr9r0xNZqiCTAqN5zeLKnxWQ9wSV1tDy0o7
 yUADM0VLQKdVMx0AIV+dUVNAW22X8Xmlo5RCF3RqHhRGDPG3mgZaAwvfrhfLeRw4rT6V
 jWf+1SkvzdQlmbh8ocmwadwv0fYPsvBtYLsgJ6q23gRgT6akDokG9xXsfjeh16wKyXSn
 FCn4yI/tFOrg2kJP0Eh2Ec7InMW/VaC3xNsYOoa4KNmPrvWyscak0ptUmHmBvLlNszRx
 EgFgvZPgCt46cKxX6lvpzqU/HdhqtAtBpHJ4/+wfXjy7oROxqrmBj+g2aWTW6z+f0u7n EQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wp23h8k09-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Mar 2024 11:12:06 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 425Aw23U002551;
	Tue, 5 Mar 2024 11:12:06 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wp23h8k00-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Mar 2024 11:12:06 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42596UAg010910;
	Tue, 5 Mar 2024 11:12:05 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wmh526kyp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Mar 2024 11:12:05 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 425BC2wk13894326
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 5 Mar 2024 11:12:04 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 391F758051;
	Tue,  5 Mar 2024 11:12:02 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D69DB58068;
	Tue,  5 Mar 2024 11:11:59 +0000 (GMT)
Received: from [9.43.11.170] (unknown [9.43.11.170])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  5 Mar 2024 11:11:59 +0000 (GMT)
Message-ID: <bf612672-f7c3-4585-ac31-e02a1ebf614c@linux.ibm.com>
Date: Tue, 5 Mar 2024 16:41:58 +0530
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
To: Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Valentin Schneider <vschneid@redhat.com>
References: <20240304094831.3639338-1-mingo@kernel.org>
 <20240304094831.3639338-2-mingo@kernel.org>
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <20240304094831.3639338-2-mingo@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ykbUEYPIc_M2F3nuMZVYZkJZUVCv1mqn
X-Proofpoint-GUID: ttYggmbhUUsnVbGR72Ngjo1yDcO8kizv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-05_08,2024-03-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 priorityscore=1501 malwarescore=0 mlxlogscore=999 impostorscore=0
 mlxscore=0 spamscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403050090



On 3/4/24 3:18 PM, Ingo Molnar wrote:
> The 'balancing' spinlock added in:
> 
>   08c183f31bdb ("[PATCH] sched: add option to serialize load balancing")
> 

[...]

> 
>  
> -static DEFINE_SPINLOCK(balancing);
> +/*
> + * This flag serializes load-balancing passes over large domains
> + * (such as SD_NUMA) - only once load-balancing instance may run
> + * at a time, to reduce overhead on very large systems with lots
> + * of CPUs and large NUMA distances.
> + *
> + * - Note that load-balancing passes triggered while another one
> + *   is executing are skipped and not re-tried.
> + *
> + * - Also note that this does not serialize sched_balance_domains()
> + *   execution, as non-SD_SERIALIZE domains will still be
> + *   load-balanced in parallel.
> + */
> +static atomic_t sched_balance_running = ATOMIC_INIT(0);
>  
>  /*

Continuing the discussion related whether this balancing lock is 
contended or not. 


It was observed in large system (1920CPU, 16 NUMA Nodes) cacheline containing the 
balancing trylock was contended and rebalance_domains was seen as part of the traces. 

So did some experiments on smaller system. This system as 224 CPUs and 6 NUMA nodes.
Added probe points in rebalance_domains. If lock is not contended, then lock should
success and both probe points should match. If not, there should be contention. 
Below are the system details and perf probe -L rebalance_domains.

NUMA:                    
  NUMA node(s):          6
  NUMA node0 CPU(s):     0-31
  NUMA node1 CPU(s):     32-71
  NUMA node4 CPU(s):     72-111
  NUMA node5 CPU(s):     112-151
  NUMA node6 CPU(s):     152-183
  NUMA node7 CPU(s):     184-223


------------------------------------------------------------------------------------------------------------------
#perf probe -L rebalance_domains
<rebalance_domains@/shrikanth/sched_tip/kernel/sched/fair.c:0>
      0  static void rebalance_domains(struct rq *rq, enum cpu_idle_type idle)
         {
      2         int continue_balancing = 1;
      3         int cpu = rq->cpu;
[...]


     33                 interval = get_sd_balance_interval(sd, busy);

                        need_serialize = sd->flags & SD_SERIALIZE;
     36                 if (need_serialize) {
     37                         if (!spin_trylock(&balancing))
                                        goto out;
                        }

     41                 if (time_after_eq(jiffies, sd->last_balance + interval)) {
     42                         if (load_balance(cpu, rq, sd, idle, &continue_balancing)) {
                                        /*
                                         * The LBF_DST_PINNED logic could have changed
                                         * env->dst_cpu, so we can't know our idle
                                         * state even if we migrated tasks. Update it.
                                         */
     48                                 idle = idle_cpu(cpu) ? CPU_IDLE : CPU_NOT_IDLE;
     49                                 busy = idle != CPU_IDLE && !sched_idle_cpu(cpu);
                                }
     51                         sd->last_balance = jiffies;
     52                         interval = get_sd_balance_interval(sd, busy);
                        }
     54                 if (need_serialize)
     55                         spin_unlock(&balancing);
         out:
     57                 if (time_after(next_balance, sd->last_balance + interval)) {
                                next_balance = sd->last_balance + interval;
                                update_next_balance = 1;
                        }
                }

perf probe --list
  probe:rebalance_domains_L37 (on rebalance_domains+856)
  probe:rebalance_domains_L55 (on rebalance_domains+904)
------------------------------------------------------------------------------------------------------------------

Perf records are collected for 10 seconds in different system loads. load is created using stress-ng. 
Contention is calculated as (1-L55/L37)*100

system is idle:  		<--	No contention
1K probe:rebalance_domains_L37
1K probe:rebalance_domains_L55


system is at 25% loa: 		<-- 	4.4% contention
223K probe:rebalance_domains_L37: 1 chunks LOST!
213K probe:rebalance_domains_L55: 1 chunks LOST!



system is at 50% load		<--	12.5% contention
168K probe:rebalance_domains_L37
147K probe:rebalance_domains_L55


system is at 75% load		<-- 	25.6% contention
113K probe:rebalance_domains_L37
84K probe:rebalance_domains_L55

87
system is at 100% load		<--	87.5% contention.
64K probe:rebalance_domains_L37
8K probe:rebalance_domains_L55


A few reasons for contentions could be: 
1. idle load balance is running and some other cpu is becoming idle, and tries newidle_balance. 
2. when system is busy, every CPU would do busy balancing, it would contend for the lock. It will not do balance as 
   should_we_balance says this CPU need not balance. It bails out and release the lock. 

