Return-Path: <linux-kernel+bounces-16909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D314F8245EC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 17:12:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 627F9B23A7D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 16:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D76B24A1B;
	Thu,  4 Jan 2024 16:12:29 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21D5A24A02
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 16:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 537A9C15;
	Thu,  4 Jan 2024 08:13:12 -0800 (PST)
Received: from [192.168.1.13] (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C39473F5A1;
	Thu,  4 Jan 2024 08:12:23 -0800 (PST)
Message-ID: <647e6f54-8247-4ee6-b2ed-2b49bfdece06@arm.com>
Date: Thu, 4 Jan 2024 17:12:22 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] sched/fair: Use rq in idle_cpu_without()
Content-Language: en-US
To: Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Daniel Bristot de Oliveira
 <bristot@redhat.com>, Valentin Schneider <vschneid@redhat.com>,
 linux-kernel@vger.kernel.org
References: <20240103125648.194516-1-pierre.gondois@arm.com>
 <20240103125648.194516-3-pierre.gondois@arm.com>
 <75b01ec8-dda9-433e-8980-2d94593dd80c@linux.vnet.ibm.com>
From: Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <75b01ec8-dda9-433e-8980-2d94593dd80c@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello Shrikanth,

On 1/4/24 06:15, Shrikanth Hegde wrote:
> 
> 
> On 1/3/24 6:26 PM, Pierre Gondois wrote:
>> idle_cpu_without() could receive a 'struct rq' instead of a
>> cpu number to avoid converting the cpu number to a 'struct rq'
> 
> nit: s/cpu/CPU
> 
>> two times. Indeed update_sg_wakeup_stats() already makes the
>> conversion.
> 
> This change looks good. There maybe other candidates which might get simplified
> as well. for example, update_blocked_averages. (and then there are some
> like balance_push_set which maybe borderline when it comes to such simplification)

Ok yes, I'll check the functions you pointed out.

> 
>>
>> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
>> ---
>>   kernel/sched/fair.c | 8 +++-----
>>   1 file changed, 3 insertions(+), 5 deletions(-)
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index 93e928e76959..d38fec26fd3d 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -10184,15 +10184,13 @@ static unsigned int task_running_on_cpu(int cpu, struct task_struct *p)
>>   
>>   /**
>>    * idle_cpu_without - would a given CPU be idle without p ?
>> - * @cpu: the processor on which idleness is tested.
>> + * @rq: the rq on which idleness is tested.
>>    * @p: task which should be ignored.
>>    *
>>    * Return: 1 if the CPU would be idle. 0 otherwise.
>>    */
>> -static int idle_cpu_without(int cpu, struct task_struct *p)
>> +static int idle_cpu_without(struct rq *rq, struct task_struct *p)
> 
> This might need change in the function name too. perception here is that, is the
> CPU idle without task p.

Yes right, I'll rename to idle_rq_without() in the next version.

Regards,
Pierre

> Otherwise LGTM.
> 
> Reviewed-by: Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
> 
>>   {
>> -	struct rq *rq = cpu_rq(cpu);
>> -
>>   	if (rq->curr != rq->idle && rq->curr != p)
>>   		return 0;
>>   
>> @@ -10247,7 +10245,7 @@ static inline void update_sg_wakeup_stats(struct sched_domain *sd,
>>   		/*
>>   		 * No need to call idle_cpu_without() if nr_running is not 0
>>   		 */
>> -		if (!nr_running && idle_cpu_without(i, p))
>> +		if (!nr_running && idle_cpu_without(rq, p))
>>   			sgs->idle_cpus++;
>>   
>>   		/* Check if task fits in the CPU */
> 
> 

