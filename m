Return-Path: <linux-kernel+bounces-16878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CD5282454F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 16:47:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9BDD1B23A61
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 15:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E5F2249FC;
	Thu,  4 Jan 2024 15:46:34 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42739249EC
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 15:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 19763C15;
	Thu,  4 Jan 2024 07:47:15 -0800 (PST)
Received: from [10.57.75.15] (unknown [10.57.75.15])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B8B753F64C;
	Thu,  4 Jan 2024 07:46:26 -0800 (PST)
Message-ID: <04b625e0-58c7-4814-952e-1fb1e1e8ff9c@arm.com>
Date: Thu, 4 Jan 2024 16:46:24 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] sched/topology: Annotate RCU pointers properly
Content-Language: en-US
To: Valentin Schneider <vschneid@redhat.com>, linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Daniel Bristot de Oliveira <bristot@redhat.com>
References: <20240103125648.194516-1-pierre.gondois@arm.com>
 <20240103125648.194516-2-pierre.gondois@arm.com>
 <xhsmh1qaxjuf1.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
From: Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <xhsmh1qaxjuf1.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello Valentin,

On 1/4/24 10:54, Valentin Schneider wrote:
> On 03/01/24 13:56, Pierre Gondois wrote:
>> Cleanup RCU-related spare errors by annotating RCU pointers.
>>
>> sched_domains_numa_distance:
>>    error: incompatible types in comparison expression
>>    (different address spaces):
>>        int [noderef] __rcu *
>>        int *
>>
>> sched_domains_numa_masks:
>>    error: incompatible types in comparison expression
>>    (different address spaces):
>>        struct cpumask **[noderef] __rcu *
>>        struct cpumask ***
>>
>> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
> 
> That's from when the NUMA topologies were made dynamic, which should be:
> Fixes: 0fb3978b0aac ("sched/numa: Fix NUMA topology for systems with CPU-less nodes")

Ok yes

>> ---
>>   kernel/sched/topology.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
>> index 10d1391e7416..0342a4f41f09 100644
>> --- a/kernel/sched/topology.c
>> +++ b/kernel/sched/topology.c
>> @@ -1542,8 +1542,8 @@ static int			sched_domains_numa_levels;
>>   static int			sched_domains_curr_level;
>>
>>   int				sched_max_numa_distance;
>> -static int			*sched_domains_numa_distance;
>> -static struct cpumask		***sched_domains_numa_masks;
>> +static int			__rcu *sched_domains_numa_distance;
>> +static struct cpumask		** __rcu *sched_domains_numa_masks;
> 
> I understand that's what sparse is asking for, but that looks odd to me. We
> use it as:
> 
>    rcu_assign_pointer(sched_domains_numa_masks, foo);
> 
> so why isn't it
> 
>    __rcu ***sched_domains_numa_masks;
> 
> ?
> 
> This isn't a pointer to an RCU-protected array of masks, this is an
> RCU-protected double array of masks.

I think:
   static struct cpumask ** __rcu *sched_domains_numa_masks;
should denote an RCU-protected array^3 of 'struct cpumask', when
   static struct cpumask __rcu ***sched_domains_numa_masks;
would denote an array^2 of RCU-protected 'struct cpumask*',
and assignments would look like:
   rcu_assign_pointer(**sched_domains_numa_masks, foo);

Meaning that, when taking as a better example:
   static int __rcu *sched_domains_numa_distance;
Here we would like to avoid having 'access after free' to the array of
integer allocated to sched_domains_numa_distance.

For sched_domains_numa_masks:
   static struct cpumask	** __rcu *sched_domains_numa_masks;
   rcu_assign_pointer(sched_domains_numa_masks, foo);
   bar = rcu_dereference(sched_domains_numa_masks);
once the first array pointed by sched_domains_numa_masks is accessed/assigned,
we know the RCU-framework makes it safe against 'accesses after free' when
accessing the level-2 array of sched_domains_numa_masks, or accessing the mask
(level 3).

Please let me know if the reasoning seems dodgy.

About the kernel test robot:
   kernel/sched/topology.c:1998:19: sparse: sparse: incorrect type in assignment (different address spaces) @@
        expected int *distances @@
        got int [noderef] __rcu *static [addressable] [assigned] [toplevel] sched_domains_numa_distance
   kernel/sched/topology.c:2000:15: sparse: sparse: incorrect type in assignment (different address spaces) @@
        expected struct cpumask ***masks @@
        got struct cpumask **[noderef] __rcu *static [addressable] [assigned] [toplevel] sched_domains_numa_masks @@
I think the warnings can be ignored since the two pointers (distances, masks)
are only dereferenced after a 'synchronize_rcu()'

Regards,
Pierre

>>   #endif
>>
>>   /*
>> --
>> 2.25.1
> 

