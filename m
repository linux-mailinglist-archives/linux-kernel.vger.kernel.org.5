Return-Path: <linux-kernel+bounces-89389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B38D186EFB7
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 10:05:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FAE51F226A6
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 09:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A148712B9F;
	Sat,  2 Mar 2024 09:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PAEJstwa"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC80613A
	for <linux-kernel@vger.kernel.org>; Sat,  2 Mar 2024 09:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709370327; cv=none; b=hWIl7grLKRIAN5X09K85nFb7HXgPLpDgNVRLhKDUSylK+pEAI4gO3bvt2x+TUcvX/VVfrM2nyJoQMcE3J81vIDR0wsnC18kOR8Jlt2K2bwZ3CfPqSv1ja5VjgK4bsUCn1BCLHuT2b9t55GPm5kPm5XVhmQclCHtykkiroF7W4Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709370327; c=relaxed/simple;
	bh=UuBVQMCD72UhsqdnTyfA5rYoLUHvLoag41gHhc7RQhE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dPBPMwFgR0eQt1Opak6Rmn7+n6EMfPy1NXRnE4uOL99iwF19gS0knFfiZ0O8L0PPPqbTaGA0Y87c+SUi5hHPswgVRQAuvbJFDhoysEl9FZLg5OM547Z42sGMJ98po2XmmiatDjea91wa/eJlraycHCEb/rAGtKVqCQWbuctCa6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PAEJstwa; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4227RTSM020438;
	Sat, 2 Mar 2024 09:05:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=EqRuLtlTpyrMtcvQU2zCeGEOQZ07lNuLoxuUkJJk4YI=;
 b=PAEJstwaNjTn/wn47srLAjuog9hI/orC4HM7ax7uSnU61ocmHgDXp4CUOh3s8hJACuFG
 bP1ZLF+7Jabv1Tz3F7+QJAaYY/n6vx/hdvFj9Vh3K6IZtjtnVJZp0qVOE3uuP467zSo/
 EdulLyaLn2HAZCImn8YzDHt8ofxNtpHH4OFVL7JVREacrLnU03pwcBHUnw2uYEYn1g/H
 Zg5r4n41YcNMHIG3xJ1vxIwLjhla3SvCfDjxh9uqURDdeOnQU9d0JIU7uyj4Awxt045C
 J9jLf0JeM89xNFpiqvbwWWzpPNQeVHQIpet0T3fZdgisksMBMZ3mAttdV0vhEOYqulrj /A== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wkyr29ek2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 02 Mar 2024 09:05:08 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4228vDMH032718;
	Sat, 2 Mar 2024 09:05:08 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wkyr29ejc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 02 Mar 2024 09:05:08 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 4225Us0J008787;
	Sat, 2 Mar 2024 09:05:07 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wftsua7wh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 02 Mar 2024 09:05:07 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 422954BJ49742436
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 2 Mar 2024 09:05:06 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8702458068;
	Sat,  2 Mar 2024 09:05:04 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BCE4258055;
	Sat,  2 Mar 2024 09:05:01 +0000 (GMT)
Received: from [9.43.77.11] (unknown [9.43.77.11])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Sat,  2 Mar 2024 09:05:01 +0000 (GMT)
Message-ID: <588d1af3-e619-414f-a26f-467ea51b4ab8@linux.ibm.com>
Date: Sat, 2 Mar 2024 14:34:59 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] sched/balancing: Change 'enum cpu_idle_type' to have
 more natural definitions
Content-Language: en-US
To: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Valentin Schneider <vschneid@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <20240301110951.3707367-1-mingo@kernel.org>
 <20240301110951.3707367-3-mingo@kernel.org>
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <20240301110951.3707367-3-mingo@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 5jwXaD3OHG5EDqa2Gchi8AzKia_KDDmO
X-Proofpoint-ORIG-GUID: ysVJtFiVmi0nS7-MWjmFs4lzMdYedHKv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-02_04,2024-03-01_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1015
 phishscore=0 mlxlogscore=957 spamscore=0 bulkscore=0 suspectscore=0
 mlxscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403020077



On 3/1/24 4:39 PM, Ingo Molnar wrote:
> The cpu_idle_type enum has the confusingly inverted property
> that 'not idle' is 1, and 'idle' is '0'.
> 
> This resulted in a number of unnecessary complications in the code.
> 
> Reverse the order, remove the CPU_NOT_IDLE type, and convert
> all code to a natural boolean form.
> 
> It's much more readable:
> 
>   -       enum cpu_idle_type idle = this_rq->idle_balance ?
>   -                                               CPU_IDLE : CPU_NOT_IDLE;
>   -
>   +       enum cpu_idle_type idle = this_rq->idle_balance;
> 
>   --------------------------------
> 
>   -       if (env->idle == CPU_NOT_IDLE || !busiest->sum_nr_running)
>   +       if (!env->idle || !busiest->sum_nr_running)
> 
>   --------------------------------
> 
> And gets rid of the double negation in these usages:
> 
>   -               if (env->idle != CPU_NOT_IDLE && env->src_rq->nr_running <= 1)
>   +               if (env->idle && env->src_rq->nr_running <= 1)
> 
> Furthermore, this makes code much more obvious where there's
> differentiation between CPU_IDLE and CPU_NEWLY_IDLE.
> 
> Signed-off-by: Ingo Molnar <mingo@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Valentin Schneider <vschneid@redhat.com>
> ---
>  include/linux/sched/idle.h |  3 +--
>  kernel/sched/fair.c        | 27 ++++++++++++---------------
>  2 files changed, 13 insertions(+), 17 deletions(-)
> 
> diff --git a/include/linux/sched/idle.h b/include/linux/sched/idle.h
> index 478084f9105e..4a6423700ffc 100644
> --- a/include/linux/sched/idle.h
> +++ b/include/linux/sched/idle.h
> @@ -5,8 +5,7 @@
>  #include <linux/sched.h>
>  
>  enum cpu_idle_type {
> -	CPU_IDLE,
> -	CPU_NOT_IDLE,
> +	CPU_IDLE = 1,
>  	CPU_NEWLY_IDLE,
>  	CPU_MAX_IDLE_TYPES
>  };

[...]

>  	struct rq *this_rq = this_rq();
> -	enum cpu_idle_type idle = this_rq->idle_balance ?
> -						CPU_IDLE : CPU_NOT_IDLE;
> -
> +	enum cpu_idle_type idle = this_rq->idle_balance;
>  	/*
>  	 * If this CPU has a pending nohz_balance_kick, then do the
>  	 * balancing on behalf of the other idle CPUs whose ticks are

Hi Ingo.
This is more readable code indeed.

But schedtstat area also needs a fix. I applied the patch, I see it displays 
only for CPU_IDLE and CPU_NEWLY_IDLE since stats.c displays starting from CPU_IDLE. 


Did below test.
echo 1 > /proc/sys/kernel/sched_schedstats
sleep 300
stress-ng --cpu=$(nproc) -t 300
cat /proc/schedstat


6.8.rc5  -- There are 36 fields.
cpu0 0 0 4400 1485 1624 1229 301472313236 120382198 7714                        
domain0 00000000,00000000,00000055 1661 1661 0 0 0 0 0 1661 2495 2495 0 0 0 0 0 2495 67 66 1 2 0 0 0 66 0 0 0 0 0 0 0 0 0 133 38 0
domain1 ff000000,00ff0000,ffffffff 382 369 13 13 4 0 2 207 198 195 3 36 0 0 0 195 67 64 3 3 0 0 0 64 4 0 4 0 0 0 0 0 0 124 9 0
domain2 ff00ffff,00ffffff,ffffffff 586 585 1 6 0 0 0 365 118 116 2 96 0 0 0 116 67 67 0 0 0 0 0 67 0 0 0 0 0 0 0 0 0 59 0 0
domain3 ffffffff,ffffffff,ffffffff 481 479 2 58 0 0 0 387 97 97 0 0 0 0 0 96 67 67 0 0 0 0 0 67 0 0 0 0 0 0 0 0 0 79 0 0

+Patch - There are 28 fields.
cpu0 0 0 2520 1244 1283 974 2273868054 212337506 6911                           
domain0 00000000,00000000,00000055 1975 1975 0 0 0 0 0 1975 45 45 0 0 0 0 0 45 0 0 0 0 0 0 0 0 0 65 3 0
domain1 ff000000,00ff0000,ffffffff 441 438 3 3 1 0 0 242 45 43 2 2 0 0 0 43 1 0 1 0 0 0 0 0 0 48 0 0
domain2 ff00ffff,00ffffff,ffffffff 655 654 1 2 0 0 0 468 45 45 0 0 0 0 0 45 0 0 0 0 0 0 0 0 0 152 0 0
domain3 ffffffff,ffffffff,ffffffff 521 521 0 0 0 0 0 472 44 44 0 0 0 0 0 44 0 0 0 0 0 0 0 0 0 44 0 0


I think its all getting accounted. Just that its not being printed. 
With the below change, able to see all the three types, albeit not in right order as 
per schedstat documentation. 

diff --git a/kernel/sched/stats.c b/kernel/sched/stats.c
index 857f837f52cb..f36b54bdd9fa 100644
--- a/kernel/sched/stats.c
+++ b/kernel/sched/stats.c
@@ -150,7 +150,7 @@ static int show_schedstat(struct seq_file *seq, void *v)
 
                        seq_printf(seq, "domain%d %*pb", dcount++,
                                   cpumask_pr_args(sched_domain_span(sd)));
-                       for (itype = CPU_IDLE; itype < CPU_MAX_IDLE_TYPES;
+                       for (itype = 0; itype < CPU_MAX_IDLE_TYPES;
                                        itype++) {
                                seq_printf(seq, " %u %u %u %u %u %u %u %u",
                                    sd->lb_count[itype],

