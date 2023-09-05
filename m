Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 419627930D3
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 23:15:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243885AbjIEVPQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 17:15:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234191AbjIEVPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 17:15:15 -0400
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C10ABC
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 14:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1693948509;
        bh=lTr6EzwtsWBs1ryCwPpdcGriJCkNGGE3Hi2jPSrb2Xw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Dx7WQasapbl9T0xWMikss/droqGd3TOi+BoOLhhIoqXhlsuybDT1cWdUKi1feBY0X
         /oXgpuRaNqa+EH6UNuqQY+JhdT5d6RCpNozKCZiglPlKwGkXu2HNlqiYlOylfr7cB2
         ssXfX5hdZjxxkWEfiy0R8JPksnFxqZPdDdTnBKbaXha1XmYLwyjFEdlQ6rlg3TV5b0
         eFjHG41l7aO4AEcW6/rP1fiKUckkv4FiEJ0CGUcB3lMucQitBNhEY1/9jEYRZqqXwW
         vHUQPvlbUAo0wR0dzFnJzjpTmYeeIu/ihhpkHnJBX/KHf7HiKashvqnlm3cfEeBRa6
         zfmnW1lA0l69A==
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4RgJDs1PtWz1NG4;
        Tue,  5 Sep 2023 17:15:09 -0400 (EDT)
Message-ID: <866f23cc-6725-fc74-099f-450939fc0dc4@efficios.com>
Date:   Tue, 5 Sep 2023 17:16:25 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [RFC PATCH 1/2] sched: Rate limit migrations to 1 per 2ms per
 task
Content-Language: en-US
To:     Tim Chen <tim.c.chen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>
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
 <cfc3de8fa3172cedf406ccef8c94ef4da0a00281.camel@linux.intel.com>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <cfc3de8fa3172cedf406ccef8c94ef4da0a00281.camel@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/5/23 16:28, Tim Chen wrote:
> On Tue, 2023-09-05 at 13:11 -0400, Mathieu Desnoyers wrote:
>> Rate limit migrations to 1 migration per 2 milliseconds per task. On a
>> kernel with EEVDF scheduler (commit b97d64c722598ffed42ece814a2cb791336c6679),
>> this speeds up hackbench from 62s to 45s on AMD EPYC 192-core (over 2 sockets).
>>
>>
>>
>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>> index 479db611f46e..0d294fce261d 100644
>> --- a/kernel/sched/core.c
>> +++ b/kernel/sched/core.c
>> @@ -4510,6 +4510,7 @@ static void __sched_fork(unsigned long clone_flags, struct task_struct *p)
>>   	p->se.vruntime			= 0;
>>   	p->se.vlag			= 0;
>>   	p->se.slice			= sysctl_sched_base_slice;
>> +	p->se.next_migration_time	= 0;
> 
> It seems like the next_migration_time should be initialized to the current time,
> in case the system run for a long time and clock wrap around could cause problem.

next_migration_time is a u64, which should "never" overflow. Other 
scheduler code comparing with sched_clock() don't appear to care about 
u64 overflow. Sampling the next_migration_time on fork could delay 
migrations for a 2ms window after process creation, which I don't think 
is something we want. Or if we do want this behavior, it should be 
validated with benchmarks beforehand.

> 
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
> 
> Should we use time_before(sched_clock_cpu(prev_cpu), p->se.next_migration_time) ?

No, because time_before expects unsigned long parameters, and 
sched_clock_cpu() and next_migration_time are u64.

Thanks,

Mathieu

> 
>> +	       return false;
>> +	return true;
>> +}
>> +
> 
> Thanks.
> 
> Tim

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

