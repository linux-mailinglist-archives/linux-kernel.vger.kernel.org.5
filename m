Return-Path: <linux-kernel+bounces-16257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EAAF823BB9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 06:16:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F297E28831D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 05:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A21041DFC5;
	Thu,  4 Jan 2024 05:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XpgJnW2k"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1C61DFC6
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 05:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4043togk000683;
	Thu, 4 Jan 2024 05:15:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=q1tmPt6GGmSYhXZrd5IsQakKeAkCXff5lraT3Ey2K0o=;
 b=XpgJnW2kQg6k4u5+HUsYDUMiC2/FST/Oekf+ZKtBDrMEFVoMb3YAc7GRuZLE6LbHMRoq
 VXteHcPmHGyB+mhweUsE6dqt0SOW8zHCRjw85t/eeaX0/HaTSGHkFLTbI/ZDBtCpbttZ
 doc2q0F2+eWuKz6xXQ9xY6u56eTD0OeY2LRSdCx99yDFPxC7LDHurOMkdQccVXjV22BU
 OyHSKhapH2uUlvHya10Axo6I30XieUcB47Z1jb2M5gIZOvGKCx6E5Fl8KVjD53xZYeED
 sTdNZLHRp2wy+sBfFQPkevljQ2radEnrdRA8j3HAs7kCvPkpcJjeG3WeBHjIUD46JILv PQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vdfcfjet8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Jan 2024 05:15:51 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4044unaa023421;
	Thu, 4 Jan 2024 05:15:51 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vdfcfjesp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Jan 2024 05:15:51 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 4041sG8M027284;
	Thu, 4 Jan 2024 05:15:50 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vawhtfm12-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Jan 2024 05:15:50 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4045FnD012452534
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 4 Jan 2024 05:15:49 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 50E7A5805A;
	Thu,  4 Jan 2024 05:15:49 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 397D05805F;
	Thu,  4 Jan 2024 05:15:45 +0000 (GMT)
Received: from [9.109.201.126] (unknown [9.109.201.126])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  4 Jan 2024 05:15:44 +0000 (GMT)
Message-ID: <75b01ec8-dda9-433e-8980-2d94593dd80c@linux.vnet.ibm.com>
Date: Thu, 4 Jan 2024 10:45:43 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] sched/fair: Use rq in idle_cpu_without()
Content-Language: en-US
To: Pierre Gondois <pierre.gondois@arm.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira
 <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>, linux-kernel@vger.kernel.org
References: <20240103125648.194516-1-pierre.gondois@arm.com>
 <20240103125648.194516-3-pierre.gondois@arm.com>
From: Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
In-Reply-To: <20240103125648.194516-3-pierre.gondois@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: MPdxFPp-L-zs4V7lRLMUcSXwzqsYIW7l
X-Proofpoint-ORIG-GUID: K61uQdkveppnutOwZTNAOLRqGTXfImkl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-04_01,2024-01-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=402
 suspectscore=0 clxscore=1011 impostorscore=0 mlxscore=0 spamscore=0
 phishscore=0 malwarescore=0 adultscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401040033



On 1/3/24 6:26 PM, Pierre Gondois wrote:
> idle_cpu_without() could receive a 'struct rq' instead of a
> cpu number to avoid converting the cpu number to a 'struct rq'

nit: s/cpu/CPU

> two times. Indeed update_sg_wakeup_stats() already makes the
> conversion.

This change looks good. There maybe other candidates which might get simplified 
as well. for example, update_blocked_averages. (and then there are some 
like balance_push_set which maybe borderline when it comes to such simplification)

> 
> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
> ---
>  kernel/sched/fair.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 93e928e76959..d38fec26fd3d 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -10184,15 +10184,13 @@ static unsigned int task_running_on_cpu(int cpu, struct task_struct *p)
>  
>  /**
>   * idle_cpu_without - would a given CPU be idle without p ?
> - * @cpu: the processor on which idleness is tested.
> + * @rq: the rq on which idleness is tested.
>   * @p: task which should be ignored.
>   *
>   * Return: 1 if the CPU would be idle. 0 otherwise.
>   */
> -static int idle_cpu_without(int cpu, struct task_struct *p)
> +static int idle_cpu_without(struct rq *rq, struct task_struct *p)

This might need change in the function name too. perception here is that, is the 
CPU idle without task p. 
Otherwise LGTM. 

Reviewed-by: Shrikanth Hegde <sshegde@linux.vnet.ibm.com>

>  {
> -	struct rq *rq = cpu_rq(cpu);
> -
>  	if (rq->curr != rq->idle && rq->curr != p)
>  		return 0;
>  
> @@ -10247,7 +10245,7 @@ static inline void update_sg_wakeup_stats(struct sched_domain *sd,
>  		/*
>  		 * No need to call idle_cpu_without() if nr_running is not 0
>  		 */
> -		if (!nr_running && idle_cpu_without(i, p))
> +		if (!nr_running && idle_cpu_without(rq, p))
>  			sgs->idle_cpus++;
>  
>  		/* Check if task fits in the CPU */



