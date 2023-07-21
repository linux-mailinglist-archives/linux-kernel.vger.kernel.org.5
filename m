Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 699D075BC9C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 04:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbjGUC7A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 22:59:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjGUC67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 22:58:59 -0400
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F0441FED
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 19:58:57 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R971e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=kenan.liu@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0Vnsjqm-_1689908330;
Received: from B-P0CJMD6R-2140.local(mailfrom:Kenan.Liu@linux.alibaba.com fp:SMTPD_---0Vnsjqm-_1689908330)
          by smtp.aliyun-inc.com;
          Fri, 21 Jul 2023 10:58:51 +0800
Subject: Re: [RFC PATCH 0/2] Adjust CFS loadbalance to adapt QEMU CPU
 topology.
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, luoben@linux.alibaba.com,
        linux-kernel@vger.kernel.org
References: <1689842053-5291-1-git-send-email-Kenan.Liu@linux.alibaba.com>
 <20230720085032.GB3569127@hirez.programming.kicks-ass.net>
From:   "Kenan.Liu" <Kenan.Liu@linux.alibaba.com>
Message-ID: <6a70900a-649f-3a4d-2e47-61648bc95666@linux.alibaba.com>
Date:   Fri, 21 Jul 2023 10:58:50 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20230720085032.GB3569127@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter, thanks for your attention,

please refer to my answer to your question inline:


在 2023/7/20 下午4:50, Peter Zijlstra 写道:
> On Thu, Jul 20, 2023 at 04:34:11PM +0800, Kenan.Liu wrote:
>> From: "Kenan.Liu" <Kenan.Liu@linux.alibaba.com>
>>
>> Multithreading workloads in VM with Qemu may encounter an unexpected
>> phenomenon: one hyperthread of a physical core is busy while its sibling
>> is idle. Such as:
> Is this with vCPU pinning? Without that, guest topology makes no sense
> what so ever.


vCPU is pinned on host and the imbalance phenomenon we observed is inside
VM, not for the vCPU threads on host.


>> The main reason is that hyperthread index is consecutive in qemu native x86 CPU
>> model which is different from the physical topology.
> I'm sorry, what? That doesn't make sense. SMT enumeration is all over
> the place for Intel, but some actually do have (n,n+1) SMT. On AMD it's
> always (n,n+1) IIRC.
>
>> As the current kernel scheduler
>> implementation, hyperthread with an even ID number will be picked up in a much
>> higher probability during load-balancing and load-deploying.
> How so?


The SMT topology in qemu native x86 CPU model is (0,1),…,(n,n+1),…,
but nomarlly seen SMT topo in physical machine is like (0,n),(1,n+1),…,
n means the total core number of the machine.

The imbalance happens when the number of runnable threads is less
than the number of hyperthreads, select_idle_core() would be called
to decide which cpu be selected to run the waken-up task.

select_idle_core() will return the checked cpu number if the whole
core is idle. On the contrary, if any one HT of the core is busy,
select_idle_core() would clear the whole core out from cpumask and
check the next core.

select_idle_core():
     …
     if (idle)
         return core;

     cpumask_andnot(cpus, cpus, cpu_smt_mask(core));
     return -1;

In this manner, except the very beginning of for_each_cpu_wrap() loop,
HT with even ID number is always be checked at first, and be returned
to the caller if the whole core is idle, so the odd indexed HT almost
has no chance to be selected.

select_idle_cpu():
     …
     for_each_cpu_wrap(cpu, cpus, target + 1) {
         if (has_idle_core) {
             i = select_idle_core(p, cpu, cpus, &idle_cpu);

And this will NOT happen when the SMT topo is (0,n),(1,n+1),…, because
when the loop starts from the bottom half of SMT number, HTs with larger
number will be checked first, when it starts from the top half, their
siblings with smaller number take the first place of inner core searching.


>
>> This RFC targets to solve the problem by adjusting CFS loabalance policy:
>> 1. Explore CPU topology and adjust CFS loadbalance policy when we found machine
>> with qemu native CPU topology.
>> 2. Export a procfs to control the traverse length when select idle cpu.
>>
>> Kenan.Liu (2):
>>    sched/fair: Adjust CFS loadbalance for machine with qemu native CPU
>>      topology.
>>    sched/fair: Export a param to control the traverse len when select
>>      idle cpu.
> NAK, qemu can either provide a fake topology to the guest using normal
> x86 means (MADT/CPUID) or do some paravirt topology setup, but this is
> quite insane.
Thanks,

Kenan.Liu
