Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BB0D780E12
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 16:35:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377753AbjHROep (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 10:34:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377759AbjHROeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 10:34:22 -0400
Received: from smtpout.efficios.com (unknown [IPv6:2607:5300:203:b2ee::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 770453AAC
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 07:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1692369257;
        bh=DRkdbAleRrQPog1gpTWFm1kGFkNEcMuLH+Qt6QzMTbQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=SMIwK4tK828RzVUIel/FKF8jh8xa6F+U6XXdxWSIxO6kBt60mDvguNivt6nOtEr/h
         tvIzWHVC2+WsXiRedfS4TYBCPkvAovEnWqnXFu81jzx9kCZnzfb2Hyav8alYbTzYWc
         TKSn2Kao34sygCUIkdi8beWs+LqZpuo8/msMZ1h8gEG36tcIpCB1s4O0Fvrqxgqywk
         QCTBH0dNwknETvXHgHkXGgp63O7+ybxQdi+6tSM7KpqsCkJAseby2ozanpOxrsC3EU
         p79E4WySNk/PBDI0Q7yqELYwizuGlsZSWOdzLHs08eVVZfDMNLlqgYpEeFB+EhxD+H
         RhuPzM0TE2JPg==
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4RS4Bd0Qkxz1LW5;
        Fri, 18 Aug 2023 10:34:17 -0400 (EDT)
Message-ID: <eadede2d-227b-cf99-cf92-4781d73d1352@efficios.com>
Date:   Fri, 18 Aug 2023 10:35:21 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [RFC PATCH 1/1] sched: ttwu_queue_cond: perform queued wakeups
 across different L2 caches
Content-Language: en-US
To:     K Prateek Nayak <kprateek.nayak@amd.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Swapnil Sapkal <Swapnil.Sapkal@amd.com>,
        Aaron Lu <aaron.lu@intel.com>, x86@kernel.org
References: <20230817153515.143932-1-mathieu.desnoyers@efficios.com>
 <CAKfTPtCavFCk+1cJe2=zFa7WfiX4XGMdc5AsA_2r4xqsk+4v7Q@mail.gmail.com>
 <2f9aaf2b-165d-8a98-98af-a3a0ee4c4b2e@amd.com>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <2f9aaf2b-165d-8a98-98af-a3a0ee4c4b2e@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/18/23 02:39, K Prateek Nayak wrote:
> Hello Vincent, Mathieu,
> 
> On 8/17/2023 9:31 PM, Vincent Guittot wrote:
>> On Thu, 17 Aug 2023 at 17:34, Mathieu Desnoyers
>> <mathieu.desnoyers@efficios.com> wrote:
>>>
>>> Skipping queued wakeups for all logical CPUs sharing an LLC means that
>>> on a 192 cores AMD EPYC 9654 96-Core Processor (over 2 sockets), groups
>>> of 8 cores (16 hardware threads) end up grabbing runqueue locks of other
>>> runqueues within the same group for each wakeup, causing contention on
>>> the runqueue locks.
>>>
>>> Improve this by only considering hardware threads sharing an L2 cache as
>>> candidates for skipping use of the queued wakeups.
>>>
>>> This results in the following benchmark improvements:
>>>
>>>      hackbench -g 32 -f 20 --threads --pipe -l 480000 -s 100
>>>
>>> from 49s to 34s. (30% speedup)
>>>
>>> And similarly with perf bench:
>>>
>>>      perf bench sched messaging -g 32 -p -t -l 100000
>>>
>>> from 10.9s to 7.4s (32% speedup)
>>>
>>> This was developed as part of the investigation into a weird regression
>>> reported by AMD where adding a raw spinlock in the scheduler context
>>> switch accelerated hackbench. It turned out that changing this raw
>>> spinlock for a loop of 10000x cpu_relax within do_idle() had similar
>>> benefits.
>>>
>>> This patch achieves a similar effect without busy waiting nor changing
>>> anything about runqueue selection on wakeup. It considers that only
>>> hardware threads sharing an L2 cache should skip the queued
>>> try-to-wakeup and directly grab the target runqueue lock, rather than
>>> allowing all hardware threads sharing an LLC to do so.
>>>
>>> I would be interested to hear feedback about performance impact of this
>>> patch (improvement or regression) on other workloads and hardware,
>>> especially for Intel CPUs. One thing that we might want to empirically
>>> figure out from the topology is whether there is a maximum number of
>>> hardware threads within an LLC below which it would make sense to use
>>> the LLC rather than L2 as group within which queued wakeups can be
>>> skipped.
>>>
>>> [ Only tested on AMD CPUs so far. ]
>>>
>>> Link: https://lore.kernel.org/r/09e0f469-a3f7-62ef-75a1-e64cec2dcfc5@amd.com
>>> Link: https://lore.kernel.org/lkml/20230725193048.124796-1-mathieu.desnoyers@efficios.com/
>>> Link: https://lore.kernel.org/lkml/20230810140635.75296-1-mathieu.desnoyers@efficios.com/
>>> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>>> Cc: Ingo Molnar <mingo@redhat.com>
>>> Cc: Peter Zijlstra <peterz@infradead.org>
>>> Cc: Valentin Schneider <vschneid@redhat.com>
>>> Cc: Steven Rostedt <rostedt@goodmis.org>
>>> Cc: Ben Segall <bsegall@google.com>
>>> Cc: Mel Gorman <mgorman@suse.de>
>>> Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
>>> Cc: Vincent Guittot <vincent.guittot@linaro.org>
>>> Cc: Juri Lelli <juri.lelli@redhat.com>
>>> Cc: Swapnil Sapkal <Swapnil.Sapkal@amd.com>
>>> Cc: Aaron Lu <aaron.lu@intel.com>
>>> Cc: x86@kernel.org
>>> ---
>>>   arch/Kconfig                   |  6 ++++++
>>>   arch/x86/Kconfig               |  1 +
>>>   drivers/base/Kconfig           |  1 +
>>>   include/linux/sched/topology.h |  3 ++-
>>>   kernel/sched/core.c            | 26 +++++++++++++++++++++++---
>>>   5 files changed, 33 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/arch/Kconfig b/arch/Kconfig
>>> index 205fd23e0cad..e5aac1741712 100644
>>> --- a/arch/Kconfig
>>> +++ b/arch/Kconfig
>>> @@ -340,6 +340,12 @@ config HAVE_ASM_MODVERSIONS
>>>            <asm/asm-prototypes.h> to support the module versioning for symbols
>>>            exported from assembly code.
>>>
>>> +config HAVE_CLUSTERGROUP
>>> +       bool
>>> +       help
>>> +         This symbol should be selected by an architecture if it
>>> +         implements CPU clustergroup.
>>> +
>>>   config HAVE_REGS_AND_STACK_ACCESS_API
>>>          bool
>>>          help
>>> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
>>> index cb1031018afa..07813a1a9a58 100644
>>> --- a/arch/x86/Kconfig
>>> +++ b/arch/x86/Kconfig
>>> @@ -299,6 +299,7 @@ config X86
>>>          select FUNCTION_ALIGNMENT_4B
>>>          imply IMA_SECURE_AND_OR_TRUSTED_BOOT    if EFI
>>>          select HAVE_DYNAMIC_FTRACE_NO_PATCHABLE
>>> +       select HAVE_CLUSTERGROUP
>>>
>>>   config INSTRUCTION_DECODER
>>>          def_bool y
>>> diff --git a/drivers/base/Kconfig b/drivers/base/Kconfig
>>> index 2b8fd6bb7da0..408aaf7a4bd1 100644
>>> --- a/drivers/base/Kconfig
>>> +++ b/drivers/base/Kconfig
>>> @@ -218,6 +218,7 @@ config DMA_FENCE_TRACE
>>>
>>>   config GENERIC_ARCH_TOPOLOGY
>>>          bool
>>> +       select HAVE_CLUSTERGROUP
>>>          help
>>>            Enable support for architectures common topology code: e.g., parsing
>>>            CPU capacity information from DT, usage of such information for
>>> diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
>>> index 816df6cc444e..714386070463 100644
>>> --- a/include/linux/sched/topology.h
>>> +++ b/include/linux/sched/topology.h
>>> @@ -178,7 +178,8 @@ extern void partition_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
>>>   cpumask_var_t *alloc_sched_domains(unsigned int ndoms);
>>>   void free_sched_domains(cpumask_var_t doms[], unsigned int ndoms);
>>>
>>> -bool cpus_share_cache(int this_cpu, int that_cpu);
>>> +bool cpus_share_cluster(int this_cpu, int that_cpu);   /* Share L2. */
>>> +bool cpus_share_cache(int this_cpu, int that_cpu);     /* Share LLC. */
>>
>> I think that Yicong is doing what you want with
>> cpus_share_lowest_cache() which points to cluster when available or
>> LLC otherwise
>> https://lore.kernel.org/lkml/20220720081150.22167-1-yangyicong@hisilicon.com/t/#m0ab9fa0fe0c3779b9bbadcfbc1b643dce7cb7618
> Please correct me if I'm wrong, but with Yicong's latest version
> (https://lore.kernel.org/lkml/20230719092838.2302-2-yangyicong@huawei.com/)
> "sd_share_id" will follow "sd_llc_id" if the SD_CLUSTER domain is
> degenerated, which is the case with any system where CLUSTER domain is
> same as SMT domain.
> 
> On logging the cpu and sd_share_id on my 3rd Gen EPYC system I see,
> 
>      CPU(0) sd_share_id(0)
>      CPU(1) sd_share_id(0)
>      CPU(2) sd_share_id(0)
>      CPU(3) sd_share_id(0)
>      CPU(4) sd_share_id(0)
>      CPU(5) sd_share_id(0)
>      CPU(6) sd_share_id(0)
>      CPU(7) sd_share_id(0)
>      CPU(8) sd_share_id(8)
>      CPU(9) sd_share_id(8)
>      ...
>      CPU(127) sd_share_id(120)
>      CPU(128) sd_share_id(0)
>      CPU(129) sd_share_id(0)
>      CPU(130) sd_share_id(0)
>      CPU(131) sd_share_id(0)
>      CPU(132) sd_share_id(0)
>      CPU(133) sd_share_id(0)
>      CPU(134) sd_share_id(0)
>      CPU(135) sd_share_id(0)
>      CPU(136) sd_share_id(8)
>      ...
> 
> "sd_share_id" follows the "sd_llc_id" since CLUSTER domain is
> degenerated.
> 
>      # echo Y > /sys/kernel/debug/sched/verbose
>      # cat /sys/kernel/debug/sched/domains/cpu0/domain*/flags
>      SD_BALANCE_NEWIDLE SD_BALANCE_EXEC SD_BALANCE_FORK SD_WAKE_AFFINE SD_SHARE_CPUCAPACITY SD_SHARE_PKG_RESOURCES SD_PREFER_SIBLING # SMT Domain
>      SD_BALANCE_NEWIDLE SD_BALANCE_EXEC SD_BALANCE_FORK SD_WAKE_AFFINE SD_SHARE_PKG_RESOURCES SD_PREFER_SIBLING # MC Domain
>      SD_BALANCE_NEWIDLE SD_BALANCE_EXEC SD_BALANCE_FORK SD_WAKE_AFFINE SD_PREFER_SIBLING # DIE Domain
>      SD_BALANCE_NEWIDLE SD_BALANCE_EXEC SD_BALANCE_FORK SD_WAKE_AFFINE SD_SERIALIZE SD_OVERLAP SD_NUMA # NUMA Domain
> 
> But I believe Mathieu's case would require falling back to "core_id" if
> the cluster domain has degenerated.

Yes, I've noticed the same thing on my system. I'm preparing an updated 
patchset which renames cpus_share_cache() to cpus_share_llc(), and 
introduces a new cpus_share_l2c() based on a new sd_l2c_id per-cpu 
variable derived from topology_cluster_cpumask(). It seems to work fine 
so far.

Thanks,

Mathieu

> 
> --
> Thanks and Regards,
> Prateek

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

