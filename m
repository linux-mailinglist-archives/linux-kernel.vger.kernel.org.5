Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 761907C6E56
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 14:37:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378664AbjJLMhz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 08:37:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378727AbjJLMhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 08:37:51 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B02BFD9
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 05:37:49 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3D93713D5;
        Thu, 12 Oct 2023 05:38:30 -0700 (PDT)
Received: from [10.34.100.121] (e126645.nice.arm.com [10.34.100.121])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1E8FF3F5A1;
        Thu, 12 Oct 2023 05:37:48 -0700 (PDT)
Message-ID: <f43112b2-ef8a-46ba-b57f-e3f0cc81b638@arm.com>
Date:   Thu, 12 Oct 2023 14:37:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/5] support NUMA emulation for arm64
To:     Rongwei Wang <rongwei.wang@linux.alibaba.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, willy@infradead.org,
        catalin.marinas@arm.com, dave.hansen@linux.intel.com,
        tj@kernel.org, mingo@redhat.com
References: <20231012024842.99703-1-rongwei.wang@linux.alibaba.com>
Content-Language: en-US
From:   Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <20231012024842.99703-1-rongwei.wang@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Rongwei,

On 10/12/23 04:48, Rongwei Wang wrote:
> A brief introduction
> ====================
> 
> The NUMA emulation can fake more node base on a single
> node system, e.g.
> 
> one node system:
> 
> [root@localhost ~]# numactl -H
> available: 1 nodes (0)
> node 0 cpus: 0 1 2 3 4 5 6 7
> node 0 size: 31788 MB
> node 0 free: 31446 MB
> node distances:
> node   0
>    0:  10
> 
> add numa=fake=2 (fake 2 node on each origin node):
> 
> [root@localhost ~]# numactl -H
> available: 2 nodes (0-1)
> node 0 cpus: 0 1 2 3 4 5 6 7
> node 0 size: 15806 MB
> node 0 free: 15451 MB
> node 1 cpus: 0 1 2 3 4 5 6 7
> node 1 size: 16029 MB
> node 1 free: 15989 MB
> node distances:
> node   0   1
>    0:  10  10
>    1:  10  10
> 
> As above shown, a new node has been faked. As cpus, the realization
> of x86 NUMA emulation is kept. Maybe each node should has 4 cores is
> better (not sure, next to do if so).
> 
> Why do this
> ===========
> 
> It seems has following reasons:
>    (1) In x86 host, apply NUMA emulation can fake more nodes environment
>        to test or verify some performance stuff, but arm64 only has
>        one method that modify ACPI table to do this. It's troublesome
>        more or less.
>    (2) Reduce competition for some locks. Here an example we found:
>        will-it-scale/tlb_flush1_processes -t 96 -s 10, it shows obvious
>        hotspot on lruvec->lock when test in single environment. What's
>        more, The performance improved greatly if test in two more nodes
>        system. The data shows below (more is better):
> 
>        ---------------------------------------------------------------------
>        threads/process |   1     |     12   |     24   |   48     |   96
>        ---------------------------------------------------------------------
>        one node        | 14 1122 | 110 5372 | 111 2615 | 79 7084  | 72 4516
>        ---------------------------------------------------------------------
>        numa=fake=2     | 14 1168 | 144 4848 | 215 9070 | 157 0412 | 142 3968
>        ---------------------------------------------------------------------
>                        | For concurrency 12, no lruvec->lock hotspot. For 24,
>        hotspot         | one node has 24% hotspot on lruvec->lock, but
>                        | two nodes env hasn't.
>        ---------------------------------------------------------------------
> 
> As for risks (e.g. numa balance...), they need to be discussed here.
> 
> Lastly, this just is a draft, I can improve next if it's acceptable.

I'm not engaging on the utility/relevance of the patch-set, but I tried
them on an arm64 system with the 'numa=fake=2' parameter and could not
see 2 nodes being created under:
   /sys/devices/system/node/
Indeed it seems that even though numa_emulation() is moved to a generic
mm/numa.c file, the function is only called from:
   arch/x86/mm/numa.c:numa_init()
(or maybe I'm misinterpreting the intent of the patches).

Also I had the following errors when building (still for arm64):
mm/numa.c:862:8: error: implicit declaration of function 'early_cpu_to_node' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
         nid = early_cpu_to_node(cpu);
               ^
mm/numa.c:862:8: note: did you mean 'early_map_cpu_to_node'?
./include/asm-generic/numa.h:37:13: note: 'early_map_cpu_to_node' declared here
void __init early_map_cpu_to_node(unsigned int cpu, int nid);
             ^
mm/numa.c:874:3: error: implicit declaration of function 'debug_cpumask_set_cpu' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
                 debug_cpumask_set_cpu(cpu, nid, enable);
                 ^
mm/numa.c:874:3: note: did you mean '__cpumask_set_cpu'?
./include/linux/cpumask.h:474:29: note: '__cpumask_set_cpu' declared here
static __always_inline void __cpumask_set_cpu(unsigned int cpu, struct cpumask *dstp)
                             ^
2 errors generated.

Regards,
Pierre

> 
> Thanks!
> 
> Rongwei Wang (5):
>    mm/numa: move numa emulation APIs into generic files
>    mm: percpu: fix variable type of cpu
>    arch_numa: remove __init in early_cpu_to_node()
>    mm/numa: support CONFIG_NUMA_EMU for arm64
>    mm/numa: migrate leftover numa emulation into mm/numa.c
> 
>   arch/x86/Kconfig                          |   8 -
>   arch/x86/include/asm/numa.h               |   3 -
>   arch/x86/mm/Makefile                      |   1 -
>   arch/x86/mm/numa.c                        | 216 +-------------
>   arch/x86/mm/numa_internal.h               |  14 +-
>   drivers/base/arch_numa.c                  |   7 +-
>   include/asm-generic/numa.h                |  33 +++
>   include/linux/percpu.h                    |   2 +-
>   mm/Kconfig                                |   8 +
>   mm/Makefile                               |   1 +
>   arch/x86/mm/numa_emulation.c => mm/numa.c | 333 +++++++++++++++++++++-
>   11 files changed, 373 insertions(+), 253 deletions(-)
>   rename arch/x86/mm/numa_emulation.c => mm/numa.c (63%)
> 
