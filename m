Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31B4879D49C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 17:17:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236325AbjILPRU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 11:17:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236178AbjILPRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 11:17:18 -0400
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95FAA1BB
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 08:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1694531832;
        bh=pm0FGKtfxxTSRKFL2/sM6WK3QeRqGkLMV2tedpU+eJY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Xc0BtJnNZFWnjP6YDF78Ye27GM2CDB5QScP+Kcb5TeP582oOJDlxtMn/A4Zwd6j+L
         kGhfEVg5bV6TQ/CL1ykEWMTTT4ONIk7hiA/8h3LL5VqQpsTpNJOIb5uEfNrOhx4j9a
         V2j7RfxLQ3cO68+86kzSkK7EQopbsjoojkNJ2E/C7VwO+WruHncBh66aJETSoCFKa8
         n422VBUzuvZCqhpLkNj/OCqHe8CvoaYcWvp39HD7L8UCneASHLzis/1dX1JxwY/9fq
         SkMZLU4N9T91bDPz56Aw5y4GHlXVItocNdOZmBIQqxPKuGA+MIdY25dCgs+6qdfF+u
         iGg0HdweMCiMQ==
Received: from [IPV6:2606:6d00:100:4000:8b7d:289b:cbab:37c1] (unknown [IPv6:2606:6d00:100:4000:8b7d:289b:cbab:37c1])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4RlRyc21nxz1P8l;
        Tue, 12 Sep 2023 11:17:12 -0400 (EDT)
Message-ID: <2a47ae82-b8cd-95db-9f48-82b3df0730f3@efficios.com>
Date:   Tue, 12 Sep 2023 11:18:33 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [RFC PATCH 2/2] sched/fair: skip the cache hot CPU in
 select_idle_cpu()
Content-Language: en-US
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Tim Chen <tim.c.chen@intel.com>, Aaron Lu <aaron.lu@intel.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        linux-kernel@vger.kernel.org
References: <cover.1694397335.git.yu.c.chen@intel.com>
 <d49cf5748aa7c6d69580315d2373a9eafa21c21f.1694397335.git.yu.c.chen@intel.com>
 <30a7ff14-3f48-e8cf-333f-cbb7499656e3@efficios.com>
 <db8fa2ae-317b-1c5a-e23f-9d3396165c45@efficios.com>
 <ZQBRIUYT8PE/UbZe@chenyu5-mobl2.ccr.corp.intel.com>
 <244ff1b9-c51e-be9b-0755-757f969b36e1@efficios.com>
 <ZQByY4rDvjejRRs5@chenyu5-mobl2.ccr.corp.intel.com>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <ZQByY4rDvjejRRs5@chenyu5-mobl2.ccr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/12/23 10:14, Chen Yu wrote:
> On 2023-09-12 at 10:06:27 -0400, Mathieu Desnoyers wrote:
[...]
>>
>> One more tweak: given that more than one task can update the cache_hot_timeout forward
>> one after another, and given that some tasks have larger burst_sleep_avg values than
>> others, I suspect we want to keep the forward movement monotonic with something like:
>>
>> if (sched_feat(SIS_CACHE) && task_sleep && !rq->nr_running && p->se.burst_sleep_avg &&
>>      rq->cache_hot_timeout < now + p->se.burst_sleep_avg)
>> 	rq->cache_hot_timeout = now + p->se.burst_sleep_avg;
>>
> 
> Yeah, Aaron has mentioned this too:
> https://lore.kernel.org/lkml/ZP7SYu+gxlc%2FYjHu@chenyu5-mobl2/
> May I know the benefit of keeping forward movement monotonic?
> I thought that, should we only honor the latest dequeued task's burst_sleep_avg?
> Because we don't know whether the old deuqued task's cache has been scribbled by the latest
> dequeued task or not, does it still make sense to wake up the old dequeued task on its
> previous CPU?

Here is my reasoning:

If a second task is scheduled after the first dequeued task (a
task with large burst_sleep_avg) is dequeued, that second task (with
small burst_sleep_avg) would need to entirely scribble the other task's
cache lines within the time given by sysctl_sched_migration_cost, which
I suspect is typically not very large. So I doubt that the second task
can entirely kick out the first task cache lines within that time frame,
and therefore that second task should not move the cache_hot_timeout
value backwards.

But perhaps I'm missing something ?

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

