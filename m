Return-Path: <linux-kernel+bounces-132760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4B3D8999D5
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 11:48:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 893601F2248D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 09:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D9541607BF;
	Fri,  5 Apr 2024 09:48:17 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 628641A26E
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 09:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712310497; cv=none; b=QD9heXD5Nmh5EvAI4hcbF+pRG1gXNktzBXPvJ5EYmrUdpHmZ6HNzZEPc/osQ3MspzuRc/W0ebxq+/bH4uBFLkJqyzXNFb6yMEhV1Nta1+H/jwKM5/TXX+JRVC2sOHxElGUsWuV/yGinKjw7zrPuXUhLzEKw188FT7v4MWudsgCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712310497; c=relaxed/simple;
	bh=cJbnnlU2IrQbKX6MyuGanbX91V+FSwBB56HgQEm7moE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f9HiIA1N4hhvdFYVSzqtSf298utKEQT6rGedo3MjCM2z4ycFCorKnzTSqxEf/Z6KC2KFBQ/KDdIDjXnCSwd0PbjH2JuInhQedFGjFxxTAUxR0cmh/6dApMeioac5PVmHNbeJSJO+tVx0u5v7UUTJTvaJQWw5gR4TK1mbA0WrbfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 422C1FEC;
	Fri,  5 Apr 2024 02:48:45 -0700 (PDT)
Received: from [10.57.72.221] (unknown [10.57.72.221])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7C9753F64C;
	Fri,  5 Apr 2024 02:48:10 -0700 (PDT)
Message-ID: <a73e4a31-cd32-4e75-ad79-10492b2cd0e4@arm.com>
Date: Fri, 5 Apr 2024 11:48:07 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/7] sched/fair: Remove on_null_domain() and redundant
 checks
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, Aaron Lu <aaron.lu@intel.com>,
 Rui Zhang <rui.zhang@intel.com>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Daniel Bristot de Oliveira
 <bristot@redhat.com>, Valentin Schneider <vschneid@redhat.com>,
 Waiman Long <longman@redhat.com>, Andrew Morton <akpm@linux-foundation.org>,
 Michal Hocko <mhocko@suse.com>
References: <20240403150543.2793354-1-pierre.gondois@arm.com>
 <20240403150543.2793354-7-pierre.gondois@arm.com>
 <20240404072745.GA35684@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <20240404072745.GA35684@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello Peter,

On 4/4/24 09:27, Peter Zijlstra wrote:
> On Wed, Apr 03, 2024 at 05:05:38PM +0200, Pierre Gondois wrote:
>> CPUs with a NULL sched domain are removed from the HKR_TYPE_SCHED
>> isolation mask. The two following checks are equialent:
>> - !housekeeping_runtime_test_cpu(cpu, HKR_TYPE_SCHED)
>> - on_null_domain(rq)
>>
>> Remove on_null_domain() and the redundant checks.
>>
>> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
>> ---
>>   kernel/sched/fair.c | 18 ++++++------------
>>   1 file changed, 6 insertions(+), 12 deletions(-)
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index 3e0f2a0f153f..9657c8f2176b 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -11830,11 +11830,6 @@ static void sched_balance_domains(struct rq *rq, enum cpu_idle_type idle)
>>   
>>   }
>>   
>> -static inline int on_null_domain(struct rq *rq)
>> -{
>> -	return unlikely(!rcu_dereference_sched(rq->sd));
>> -}
>> -
>>   #ifdef CONFIG_NO_HZ_COMMON
>>   /*
>>    * NOHZ idle load balancing (ILB) details:
>> @@ -12040,7 +12035,7 @@ void nohz_balance_exit_idle(struct rq *rq)
>>   	SCHED_WARN_ON(rq != this_rq());
>>   
>>   	/* If we're a completely isolated CPU, we don't play: */
>> -	if (on_null_domain(rq))
>> +	if (!housekeeping_runtime_test_cpu(cpu_of(rq), HKR_TYPE_SCHED))
>>   		return;
>>   
>>   	if (likely(!rq->nohz_tick_stopped))
> 
> This seems broken, the whole null domain can happen with cpusets, but
> this housekeeping nonsense is predicated on CPU_ISOLATION and none of
> that is mandatory for CPUSETS.

ok right,
I will try to remove this implicit dependency,

Regards,
Pierre

