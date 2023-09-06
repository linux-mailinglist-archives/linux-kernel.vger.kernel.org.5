Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E6D3793E27
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 15:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241277AbjIFNzz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 09:55:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235927AbjIFNzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 09:55:54 -0400
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0402510D3
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 06:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1694008546;
        bh=cbdEaZskg1Eb8bSgffgQ8UrE5Yz6irBaNCZamGZ8ZLg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ZEU/5S8i8I8ho0hfbcadPCtpi5Q64QcPI2/Wh2PAYX/PqsAMjeb35KFLOg+X/fxfm
         MGBlLeJPOLfYI7KWl9ab559rqzhkMIwmUl6KUTjrOMtvvAiHltpBCfADS9fupV27il
         WdD06chnLjHfFJzoSO2N1XUs2oNlsGlJydsdjl/w5mbIetMt6hEeXwP+aq5shsDnGn
         dxLnZ6ftMt7UNrhvu9EaydSwDmr7Nlk7fWtzHxI0SVOWCUR0OxxO+mCI0VqZ49eCXs
         Y8V3kR8jUqmWJUqNSzF6azoCLB+L4cj98E1IyL8vvTBiswQKbRqoWzu1PfdZSlUrCT
         wkO74w99WJEtQ==
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4RgkRQ4N4Cz1NdL;
        Wed,  6 Sep 2023 09:55:46 -0400 (EDT)
Message-ID: <c0728f14-7373-1e19-1655-1944411290b2@efficios.com>
Date:   Wed, 6 Sep 2023 09:57:04 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [RFC PATCH 1/2] sched: Rate limit migrations to 1 per 2ms per
 task
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Swapnil Sapkal <Swapnil.Sapkal@amd.com>,
        Aaron Lu <aaron.lu@intel.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>, x86@kernel.org
References: <20230905171105.1005672-1-mathieu.desnoyers@efficios.com>
 <20230905171105.1005672-2-mathieu.desnoyers@efficios.com>
 <20230906084145.GC38741@noisy.programming.kicks-ass.net>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <20230906084145.GC38741@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/6/23 04:41, Peter Zijlstra wrote:
> On Tue, Sep 05, 2023 at 01:11:04PM -0400, Mathieu Desnoyers wrote:
>> Rate limit migrations to 1 migration per 2 milliseconds per task. On a
>> kernel with EEVDF scheduler (commit b97d64c722598ffed42ece814a2cb791336c6679),
> 
> This is not in any way related to the actual eevdf part, perhaps just
> call it fair.

Good point.

> 
> 
>>   include/linux/sched.h |  2 ++
>>   kernel/sched/core.c   |  1 +
>>   kernel/sched/fair.c   | 14 ++++++++++++++
>>   kernel/sched/sched.h  |  2 ++
>>   4 files changed, 19 insertions(+)
>>
>> diff --git a/include/linux/sched.h b/include/linux/sched.h
>> index 177b3f3676ef..1111d04255cc 100644
>> --- a/include/linux/sched.h
>> +++ b/include/linux/sched.h
>> @@ -564,6 +564,8 @@ struct sched_entity {
>>   
>>   	u64				nr_migrations;
>>   
>> +	u64				next_migration_time;
>> +
>>   #ifdef CONFIG_FAIR_GROUP_SCHED
>>   	int				depth;
>>   	struct sched_entity		*parent;
>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>> index 479db611f46e..0d294fce261d 100644
>> --- a/kernel/sched/core.c
>> +++ b/kernel/sched/core.c
>> @@ -4510,6 +4510,7 @@ static void __sched_fork(unsigned long clone_flags, struct task_struct *p)
>>   	p->se.vruntime			= 0;
>>   	p->se.vlag			= 0;
>>   	p->se.slice			= sysctl_sched_base_slice;
>> +	p->se.next_migration_time	= 0;
>>   	INIT_LIST_HEAD(&p->se.group_node);
>>   
>>   #ifdef CONFIG_FAIR_GROUP_SCHED
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index d92da2d78774..24ac69913005 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -960,6 +960,14 @@ int sched_update_scaling(void)
>>   
>>   static void clear_buddies(struct cfs_rq *cfs_rq, struct sched_entity *se);
>>   
>> +static bool should_migrate_task(struct task_struct *p, int prev_cpu)
>> +{
>> +	/* Rate limit task migration. */
>> +	if (sched_clock_cpu(prev_cpu) < p->se.next_migration_time)
>> +	       return false;
>> +	return true;
>> +}
>> +
>>   /*
>>    * XXX: strictly: vd_i += N*r_i/w_i such that: vd_i > ve_i
>>    * this is probably good enough.
>> @@ -7897,6 +7905,9 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int wake_flags)
>>   		want_affine = !wake_wide(p) && cpumask_test_cpu(cpu, p->cpus_ptr);
>>   	}
>>   
>> +	if (want_affine && !should_migrate_task(p, prev_cpu))
>> +		return prev_cpu;
>> +
>>   	rcu_read_lock();
>>   	for_each_domain(cpu, tmp) {
>>   		/*
>> @@ -7944,6 +7955,9 @@ static void migrate_task_rq_fair(struct task_struct *p, int new_cpu)
>>   {
>>   	struct sched_entity *se = &p->se;
>>   
>> +	/* Rate limit task migration. */
>> +	se->next_migration_time = sched_clock_cpu(new_cpu) + SCHED_MIGRATION_RATELIMIT_WINDOW;
>> +
>>   	if (!task_on_rq_migrating(p)) {
>>   		remove_entity_load_avg(se);
>>   
>> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
>> index cf54fe338e23..c9b1a5976761 100644
>> --- a/kernel/sched/sched.h
>> +++ b/kernel/sched/sched.h
>> @@ -104,6 +104,8 @@ struct cpuidle_state;
>>   #define TASK_ON_RQ_QUEUED	1
>>   #define TASK_ON_RQ_MIGRATING	2
>>   
>> +#define SCHED_MIGRATION_RATELIMIT_WINDOW	2000000		/* 2 ms */
>> +
>>   extern __read_mostly int scheduler_running;
>>   
>>   extern unsigned long calc_load_update;
> 
> Urgh... so we already have much of this around task_hot() /
> can_migrate_task(). And I would much rather see we extend those things
> to this wakeup migration path, rather than build a whole new parallel
> thing.

Yes, good point.

> 
> Also:
> 
>> I have noticed that in order to observe the speedup, the workload needs
>> to keep the CPUs sufficiently busy to cause runqueue lock contention,
>> but not so busy that they don't go idle.
> 
> This would suggest inhibiting pulling tasks based on rq statistics,
> instead of tasks stats. It doesn't matter when the task migrated last,
> what matter is that this rq doesn't want new tasks at this point.
> 
> Them not the same thing.

I suspect we could try something like this then:

When a cpu enters idle state, it could grab a sched_clock() timestamp
and store it into this_rq()->enter_idle_time. Then, when it exits
idle and reenters idle again, it could save rq->enter_idle_time to
rq->prev_enter_idle_time, and sample enter_idle_time again.

When considering the CPU as a target for task migration, if it is
idle but the delta between sched_clock_cpu(cpu_of(rq)) and that
prev_enter_idle_time is below a threshold (e.g. a few ms), this means
the CPU got out of idle and went back to idle pretty quickly, which
means it's not a good target for pulling tasks for a short while.

I'll try something along these lines and see how it goes.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

