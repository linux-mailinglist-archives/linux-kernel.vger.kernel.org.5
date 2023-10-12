Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC58E7C6F39
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 15:31:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378880AbjJLNbI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 09:31:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347294AbjJLNbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 09:31:00 -0400
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B997BA
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 06:30:56 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R671e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=rongwei.wang@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0Vu-xY8c_1697117451;
Received: from 30.27.105.7(mailfrom:rongwei.wang@linux.alibaba.com fp:SMTPD_---0Vu-xY8c_1697117451)
          by smtp.aliyun-inc.com;
          Thu, 12 Oct 2023 21:30:52 +0800
Message-ID: <57eba42c-732a-4a30-a714-5e5538f2e5d5@linux.alibaba.com>
Date:   Thu, 12 Oct 2023 21:30:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/5] support NUMA emulation for arm64
To:     Pierre Gondois <pierre.gondois@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, willy@infradead.org,
        catalin.marinas@arm.com, dave.hansen@linux.intel.com,
        tj@kernel.org, mingo@redhat.com
References: <20231012024842.99703-1-rongwei.wang@linux.alibaba.com>
 <f43112b2-ef8a-46ba-b57f-e3f0cc81b638@arm.com>
Content-Language: en-US
From:   Rongwei Wang <rongwei.wang@linux.alibaba.com>
In-Reply-To: <f43112b2-ef8a-46ba-b57f-e3f0cc81b638@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023/10/12 20:37, Pierre Gondois wrote:
> Hello Rongwei,
>
> On 10/12/23 04:48, Rongwei Wang wrote:
>> A brief introduction
>> ====================
>>
>> The NUMA emulation can fake more node base on a single
>> node system, e.g.
>>
>> one node system:
>>
>> [root@localhost ~]# numactl -H
>> available: 1 nodes (0)
>> node 0 cpus: 0 1 2 3 4 5 6 7
>> node 0 size: 31788 MB
>> node 0 free: 31446 MB
>> node distances:
>> node   0
>>    0:  10
>>
>> add numa=fake=2 (fake 2 node on each origin node):
>>
>> [root@localhost ~]# numactl -H
>> available: 2 nodes (0-1)
>> node 0 cpus: 0 1 2 3 4 5 6 7
>> node 0 size: 15806 MB
>> node 0 free: 15451 MB
>> node 1 cpus: 0 1 2 3 4 5 6 7
>> node 1 size: 16029 MB
>> node 1 free: 15989 MB
>> node distances:
>> node   0   1
>>    0:  10  10
>>    1:  10  10
>>
>> As above shown, a new node has been faked. As cpus, the realization
>> of x86 NUMA emulation is kept. Maybe each node should has 4 cores is
>> better (not sure, next to do if so).
>>
>> Why do this
>> ===========
>>
>> It seems has following reasons:
>>    (1) In x86 host, apply NUMA emulation can fake more nodes environment
>>        to test or verify some performance stuff, but arm64 only has
>>        one method that modify ACPI table to do this. It's troublesome
>>        more or less.
>>    (2) Reduce competition for some locks. Here an example we found:
>>        will-it-scale/tlb_flush1_processes -t 96 -s 10, it shows obvious
>>        hotspot on lruvec->lock when test in single environment. What's
>>        more, The performance improved greatly if test in two more nodes
>>        system. The data shows below (more is better):
>>
>> ---------------------------------------------------------------------
>>        threads/process |   1     |     12   |     24   | 48     |   96
>> ---------------------------------------------------------------------
>>        one node        | 14 1122 | 110 5372 | 111 2615 | 79 7084  | 
>> 72 4516
>> ---------------------------------------------------------------------
>>        numa=fake=2     | 14 1168 | 144 4848 | 215 9070 | 157 0412 | 
>> 142 3968
>> ---------------------------------------------------------------------
>>                        | For concurrency 12, no lruvec->lock hotspot. 
>> For 24,
>>        hotspot         | one node has 24% hotspot on lruvec->lock, but
>>                        | two nodes env hasn't.
>> ---------------------------------------------------------------------
>>
>> As for risks (e.g. numa balance...), they need to be discussed here.
>>
>> Lastly, this just is a draft, I can improve next if it's acceptable.
>
> I'm not engaging on the utility/relevance of the patch-set, but I tried
> them on an arm64 system with the 'numa=fake=2' parameter and could not

Sorry, my fault.

I should mention this in previous brief introduction: acpi=on numa=fake=2.

The default patch of arm64 numa initialize is numa_init() -> 
dummy_numa_init() if turn off acpi (this path has not been taken into 
account yet in this patch, next will to do).

What's more, if you test these patchset in qemu-kvm, you should add 
below parameters in the script.

object memory-backend-ram,id=mem0,size=32G \
numa node,memdev=mem0,cpus=0-7,nodeid=0 \

(Above parameters just make sure SRAT table has NUMA configure, avoiding 
path of numa_init() -> dummy_numa_init())

> see 2 nodes being created under:
>   /sys/devices/system/node/
> Indeed it seems that even though numa_emulation() is moved to a generic
> mm/numa.c file, the function is only called from:
>   arch/x86/mm/numa.c:numa_init()
> (or maybe I'm misinterpreting the intent of the patches).

Here drivers/base/arch_numa.c:numa_init() has called numa_emulation() (I 
guess it works if you add acpi=on :-)).


>
> Also I had the following errors when building (still for arm64):
> mm/numa.c:862:8: error: implicit declaration of function 
> 'early_cpu_to_node' is invalid in C99 
> [-Werror,-Wimplicit-function-declaration]
>         nid = early_cpu_to_node(cpu);

It seems CONFIG_DEBUG_PER_CPU_MAPS enabled in your environment? You can 
disable CONFIG_DEBUG_PER_CPU_MAPS and test it again.

I have not test it with CONFIG_DEBUG_PER_CPU_MAPS enabled. It's very 
helpful, I will fix it next time.

If you have any questions, please let me know.

Regards,

-wrw

> ^
> mm/numa.c:862:8: note: did you mean 'early_map_cpu_to_node'?
> ./include/asm-generic/numa.h:37:13: note: 'early_map_cpu_to_node' 
> declared here
> void __init early_map_cpu_to_node(unsigned int cpu, int nid);
>             ^
> mm/numa.c:874:3: error: implicit declaration of function 
> 'debug_cpumask_set_cpu' is invalid in C99 
> [-Werror,-Wimplicit-function-declaration]
>                 debug_cpumask_set_cpu(cpu, nid, enable);
>                 ^
> mm/numa.c:874:3: note: did you mean '__cpumask_set_cpu'?
> ./include/linux/cpumask.h:474:29: note: '__cpumask_set_cpu' declared here
> static __always_inline void __cpumask_set_cpu(unsigned int cpu, struct 
> cpumask *dstp)
>                             ^
> 2 errors generated.
>
> Regards,
> Pierre
>
>>
>> Thanks!
>>
>> Rongwei Wang (5):
>>    mm/numa: move numa emulation APIs into generic files
>>    mm: percpu: fix variable type of cpu
>>    arch_numa: remove __init in early_cpu_to_node()
>>    mm/numa: support CONFIG_NUMA_EMU for arm64
>>    mm/numa: migrate leftover numa emulation into mm/numa.c
>>
>>   arch/x86/Kconfig                          |   8 -
>>   arch/x86/include/asm/numa.h               |   3 -
>>   arch/x86/mm/Makefile                      |   1 -
>>   arch/x86/mm/numa.c                        | 216 +-------------
>>   arch/x86/mm/numa_internal.h               |  14 +-
>>   drivers/base/arch_numa.c                  |   7 +-
>>   include/asm-generic/numa.h                |  33 +++
>>   include/linux/percpu.h                    |   2 +-
>>   mm/Kconfig                                |   8 +
>>   mm/Makefile                               |   1 +
>>   arch/x86/mm/numa_emulation.c => mm/numa.c | 333 +++++++++++++++++++++-
>>   11 files changed, 373 insertions(+), 253 deletions(-)
>>   rename arch/x86/mm/numa_emulation.c => mm/numa.c (63%)
>>
