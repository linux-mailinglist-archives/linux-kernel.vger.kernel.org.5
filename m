Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E823476B281
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 13:02:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232665AbjHALCd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 07:02:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234238AbjHALCI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 07:02:08 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5643D49C7;
        Tue,  1 Aug 2023 03:56:19 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A2B41D75;
        Tue,  1 Aug 2023 03:55:59 -0700 (PDT)
Received: from [10.57.2.32] (unknown [10.57.2.32])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8C9423F6C4;
        Tue,  1 Aug 2023 03:55:12 -0700 (PDT)
Message-ID: <750344ea-d1a2-87c2-b790-38dd79e11223@arm.com>
Date:   Tue, 1 Aug 2023 11:55:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3 4/5] perf vendor events arm64: Update N2-r0p3 and V2
 metrics and events using Arm telemetry repo
Content-Language: en-US
From:   James Clark <james.clark@arm.com>
To:     Ian Rogers <irogers@google.com>
Cc:     linux-perf-users@vger.kernel.org, renyu.zj@linux.alibaba.com,
        john.g.garry@oracle.com, namhyung@kernel.org, acme@kernel.org,
        Will Deacon <will@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Nick Forrington <nick.forrington@arm.com>,
        Ilkka Koskinen <ilkka@os.amperecomputing.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20230711100218.1651995-1-james.clark@arm.com>
 <20230711100218.1651995-5-james.clark@arm.com>
 <CAP-5=fVPriUQZN+OzDOVnMMe0y9QzRHuaBMgrCcSvbE+3ME=Lg@mail.gmail.com>
 <59630da4-316b-55c4-c2c7-30c53b1ba642@arm.com>
In-Reply-To: <59630da4-316b-55c4-c2c7-30c53b1ba642@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/07/2023 09:33, James Clark wrote:
> 
> 
> On 12/07/2023 02:04, Ian Rogers wrote:
>> On Tue, Jul 11, 2023 at 3:03 AM James Clark <james.clark@arm.com> wrote:
>>>
>>> The new metrics contain a fix for N2 r0p3 where CPU_CYCLES should not be
>>> subtracted from stalls for topdown metrics anymore. The current metrics
>>> assume that the fix should be applied anywhere where slots != 5, but
>>> this is only the case for V2 and not N2 r0p3.
>>>
>>> Split the metrics into a new version for N2-r0p3 and V2 which still
>>> share the same metrics. Apart from some slight naming and grouping
>>> differences the new metrics are functionally the same as the existing
>>> ones. Any missing metrics were manually appended to the end of the auto
>>> generated file.
>>>
>>> For the events, the new data includes descriptions that may have product
>>> specific details and new groupings that will be consistent with other
>>> products.
>>>
>>> After generating the metrics from the telemetry repo [1], the following
>>> manual steps were performed:
>>>
>>>  * Change the hard coded slots in neoverse-n2r0p3-v2 to #slots so that
>>>    it will work on both N2 and V2.
>>>
>>>  * Append some metrics from the old N2/V2 data that aren't present in
>>>    the telemetry data. These will possibly be added to the
>>>    telemetry-solution repo at a later time:
>>>
>>>     l3d_cache_mpki, l3d_cache_miss_rate, branch_pki, ipc_rate, spec_ipc,
>>>     retired_rate, wasted_rate, load_spec_rate, store_spec_rate,
>>>     advanced_simd_spec_rate, float_point_spec_rate,
>>>     branch_immed_spec_rate, branch_return_spec_rate,
>>>     branch_indirect_spec_rate
>>>
>>> [1]: https://gitlab.arm.com/telemetry-solution/telemetry-solution/-/blob/main/data/pmu/cpu/neoverse/neoverse-n2.json
>>>
>>> Signed-off-by: James Clark <james.clark@arm.com>
>>
>> Acked-by: Ian Rogers <irogers@google.com>
>>
>>> ---
>>>  .../arm64/arm/neoverse-n2r0p3-v2/bus.json     |  18 +
>>>  .../arm/neoverse-n2r0p3-v2/exception.json     |  62 ++++
>>>  .../arm/neoverse-n2r0p3-v2/fp_operation.json  |  22 ++
>>>  .../arm64/arm/neoverse-n2r0p3-v2/general.json |  10 +
>>>  .../arm/neoverse-n2r0p3-v2/l1d_cache.json     |  54 +++
>>>  .../arm/neoverse-n2r0p3-v2/l1i_cache.json     |  14 +
>>>  .../arm/neoverse-n2r0p3-v2/l2_cache.json      |  50 +++
>>>  .../arm/neoverse-n2r0p3-v2/l3_cache.json      |  22 ++
>>>  .../arm/neoverse-n2r0p3-v2/ll_cache.json      |  10 +
>>>  .../arm64/arm/neoverse-n2r0p3-v2/memory.json  |  46 +++
>>>  .../arm64/arm/neoverse-n2r0p3-v2/metrics.json | 331 ++++++++++++++++++
>>>  .../arm64/arm/neoverse-n2r0p3-v2/retired.json |  30 ++
>>>  .../arm64/arm/neoverse-n2r0p3-v2/spe.json     |  18 +
>>>  .../neoverse-n2r0p3-v2/spec_operation.json    | 110 ++++++
>>>  .../arm64/arm/neoverse-n2r0p3-v2/stall.json   |  30 ++
>>>  .../arm64/arm/neoverse-n2r0p3-v2/sve.json     |  50 +++
>>>  .../arm64/arm/neoverse-n2r0p3-v2/tlb.json     |  66 ++++
>>>  .../arm64/arm/neoverse-n2r0p3-v2/trace.json   |  38 ++
>>>  tools/perf/pmu-events/arch/arm64/mapfile.csv  |   3 +-
>>>  19 files changed, 983 insertions(+), 1 deletion(-)
>>>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p3-v2/bus.json
>>>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p3-v2/exception.json
>>>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p3-v2/fp_operation.json
>>>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p3-v2/general.json
>>>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p3-v2/l1d_cache.json
>>>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p3-v2/l1i_cache.json
>>>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p3-v2/l2_cache.json
>>>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p3-v2/l3_cache.json
>>>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p3-v2/ll_cache.json
>>>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p3-v2/memory.json
>>>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p3-v2/metrics.json
>>>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p3-v2/retired.json
>>>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p3-v2/spe.json
>>>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p3-v2/spec_operation.json
>>>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p3-v2/stall.json
>>>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p3-v2/sve.json
>>>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p3-v2/tlb.json
>>>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p3-v2/trace.json
>>>
>>> diff --git a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p3-v2/bus.json b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p3-v2/bus.json
>>> new file mode 100644
>>> index 000000000000..2e11a8c4a484
>>> --- /dev/null
>>> +++ b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p3-v2/bus.json
>>> @@ -0,0 +1,18 @@
>>> +[
>>> +    {
>>> +        "ArchStdEvent": "BUS_ACCESS",
>>> +        "PublicDescription": "Counts memory transactions issued by the CPU to the external bus, including snoop requests and snoop responses. Each beat of data is counted individually."
>>
>> It might be nice to add "beat" to the glossary:
>> https://perf.wiki.kernel.org/index.php/Glossary
>>
> 
> I requested an account and I will add it. There is a definition in the
> Arm glossary here if, like me, you weren't sure:

Hi Ian,

I'm not sure if my wiki account request worked. I didn't get a response,
and I also get a "your IP is blocked from editing" on the password reset
page (this is an Arm internal IP).

Do you know anything about the account request procedure?

James

> 
> https://documentation-service.arm.com/static/639362d21d698c4dc521ba93
> 
> And I agree with the rest of the typos. Will update them manually here
> and get them updated in the source data as well.
> 
> Thanks for the review.
> 
>>> +    },
>>> +    {
>>> +        "ArchStdEvent": "BUS_CYCLES",
>>> +        "PublicDescription": "Counts bus cycles in the CPU. Bus cycles represent a clock cycle in which a transaction could be sent or received on the interface from the CPU to the external bus. Since that interface is driven at the same clock speed as the CPU, this event is a duplicate of CPU_CYCLES."
>>> +    },
>>> +    {
>>> +        "ArchStdEvent": "BUS_ACCESS_RD",
>>> +        "PublicDescription": "Counts memory read transactions seen on the external bus. Each beat of data is counted individually."
>>> +    },
>>> +    {
>>> +        "ArchStdEvent": "BUS_ACCESS_WR",
>>> +        "PublicDescription": "Counts memory write transactions seen on the external bus. Each beat of data is counted individually."
>>> +    }
>>> +]
>>> diff --git a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p3-v2/exception.json b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p3-v2/exception.json
>>> new file mode 100644
>>> index 000000000000..4404b8e91690
>>> --- /dev/null
>>> +++ b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p3-v2/exception.json
>>> @@ -0,0 +1,62 @@
>>> +[
>>> +    {
>>> +        "ArchStdEvent": "EXC_TAKEN",
>>> +        "PublicDescription": "Counts any taken architecturally visible exceptions such as IRQ, FIQ, SError, and other synchronous exceptions. Exceptions are counted whether or not they are taken locally."
>>> +    },
>>> +    {
>>> +        "ArchStdEvent": "EXC_RETURN",
>>> +        "PublicDescription": "Counts any architecturally executed exception return instructions. Eg: AArch64: ERET"
>>> +    },
>>> +    {
>>> +        "ArchStdEvent": "EXC_UNDEF",
>>> +        "PublicDescription": "Counts the number of synchronous exceptions which are taken locally that are due to attempting to execute an instruction that is UNDEFINED. Attempting to execute instruction bit patterns that have not been allocated. Attempting to execute instructions when they are disabled. Attempting to execute instructions at an inappropriate Exception level. Attempting to execute an instruction when the value of PSTATE.IL is 1."
>>> +    },
>>> +    {
>>> +        "ArchStdEvent": "EXC_SVC",
>>> +        "PublicDescription": "Counts SVC exceptions taken locally."
>>> +    },
>>> +    {
>>> +        "ArchStdEvent": "EXC_PABORT",
>>> +        "PublicDescription": "Counts synchronous exceptions that are taken locally and caused by Instruction Aborts."
>>> +    },
>>> +    {
>>> +        "ArchStdEvent": "EXC_DABORT",
>>> +        "PublicDescription": "Counts exceptions that are taken locally and are caused by data aborts or SErrors. Conditions that could cause those exceptions are attempting to read or write memory where the MMU generates a fault, attempting to read or write memory with a misaligned address, interrupts from the nSEI inputs and internally generated SErrors."
>>> +    },
>>> +    {
>>> +        "ArchStdEvent": "EXC_IRQ",
>>> +        "PublicDescription": "Counts IRQ exceptions including the virtual IRQs that are taken locally."
>>> +    },
>>> +    {
>>> +        "ArchStdEvent": "EXC_FIQ",
>>> +        "PublicDescription": "Counts FIQ exceptions including the virtual FIQs that are taken locally."
>>> +    },
>>> +    {
>>> +        "ArchStdEvent": "EXC_SMC",
>>> +        "PublicDescription": "Counts SMC exceptions take to EL3."
>>> +    },
>>> +    {
>>> +        "ArchStdEvent": "EXC_HVC",
>>> +        "PublicDescription": "Counts HVC exceptions taken to EL2."
>>> +    },
>>> +    {
>>> +        "ArchStdEvent": "EXC_TRAP_PABORT",
>>> +        "PublicDescription": "Counts exceptions which are traps not taken locally and are caused by Instruction Aborts. For example, attempting to execute an instruction with a misaligned PC."
>>> +    },
>>> +    {
>>> +        "ArchStdEvent": "EXC_TRAP_DABORT",
>>> +        "PublicDescription": "Counts exceptions which are traps not taken locally and are caused by Data Aborts or SError interrupts. Conditions that could cause those exceptions are:\n\n1. Attempting to read or write memory where the MMU generates a fault,\n2. Attempting to read or write memory with a misaligned address,\n3. Interrupts from the SEI input.\n4. internally generated SErrors."
>>> +    },
>>> +    {
>>> +        "ArchStdEvent": "EXC_TRAP_OTHER",
>>> +        "PublicDescription": "Counts the number of synchronous trap exceptions which are not taken locally and are not SVC, SMC, HVC, data aborts, Instruction Aborts, or interrupts."
>>> +    },
>>> +    {
>>> +        "ArchStdEvent": "EXC_TRAP_IRQ",
>>> +        "PublicDescription": "Counts IRQ exceptions including the virtual IRQs that are not taken locally."
>>> +    },
>>> +    {
>>> +        "ArchStdEvent": "EXC_TRAP_FIQ",
>>> +        "PublicDescription": "Counts FIQs which are not taken locally but taken from EL0, EL1,\n or EL2 to EL3 (which would be the normal behavior for FIQs when not executing\n in EL3)."
>>> +    }
>>> +]
>>> diff --git a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p3-v2/fp_operation.json b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p3-v2/fp_operation.json
>>> new file mode 100644
>>> index 000000000000..cec3435ac766
>>> --- /dev/null
>>> +++ b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p3-v2/fp_operation.json
>>> @@ -0,0 +1,22 @@
>>> +[
>>> +    {
>>> +        "ArchStdEvent": "FP_HP_SPEC",
>>> +        "PublicDescription": "Counts speculatively executed half precision floating point operations."
>>> +    },
>>> +    {
>>> +        "ArchStdEvent": "FP_SP_SPEC",
>>> +        "PublicDescription": "Counts speculatively executed single precision floating point operations."
>>> +    },
>>> +    {
>>> +        "ArchStdEvent": "FP_DP_SPEC",
>>> +        "PublicDescription": "Counts speculatively executed double precision floating point operations."
>>> +    },
>>> +    {
>>> +        "ArchStdEvent": "FP_SCALE_OPS_SPEC",
>>> +        "PublicDescription": "Counts speculatively executed scalable single precision floating point operations."
>>> +    },
>>> +    {
>>> +        "ArchStdEvent": "FP_FIXED_OPS_SPEC",
>>> +        "PublicDescription": "Counts speculatively executed non-scalable single precision floating point operations."
>>> +    }
>>> +]
>>> diff --git a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p3-v2/general.json b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p3-v2/general.json
>>> new file mode 100644
>>> index 000000000000..428810f855b8
>>> --- /dev/null
>>> +++ b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p3-v2/general.json
>>> @@ -0,0 +1,10 @@
>>> +[
>>> +    {
>>> +        "ArchStdEvent": "CPU_CYCLES",
>>> +        "PublicDescription": "Counts CPU clock cycles (not timer cycles). The clock measured by this event is defined as the physical clock driving the CPU logic."
>>> +    },
>>> +    {
>>> +        "ArchStdEvent": "CNT_CYCLES",
>>> +        "PublicDescription": "Counts constant frequency cycles"
>>> +    }
>>> +]
>>> diff --git a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p3-v2/l1d_cache.json b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p3-v2/l1d_cache.json
>>> new file mode 100644
>>> index 000000000000..ed83e1c5affe
>>> --- /dev/null
>>> +++ b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p3-v2/l1d_cache.json
>>> @@ -0,0 +1,54 @@
>>> +[
>>> +    {
>>> +        "ArchStdEvent": "L1D_CACHE_REFILL",
>>> +        "PublicDescription": "Counts level 1 data cache refills caused by speculatively executed load or store operations that missed in the level 1 data cache. This event only counts one event per cache line. This event does not count cache line allocations from preload instructions or from hardware cache prefetching."
>>> +    },
>>> +    {
>>> +        "ArchStdEvent": "L1D_CACHE",
>>> +        "PublicDescription": "Counts level 1 data cache accesses from any load/store operations. Atomic operations that resolve in the CPUs caches (near atomic operations) counts as both a write access and read access. Each access to a cache line is counted including the multiple accesses caused by single instructions such as LDM or STM. Each access to other level 1 data or unified memory structures, for example refill buffers, write buffers, and write-back buffers, are also counted."
>>
>> nit: "counts as both" should be "count as both"
>>
>>> +    },
>>> +    {
>>> +        "ArchStdEvent": "L1D_CACHE_WB",
>>> +        "PublicDescription": "Counts write-backs of dirty data from the L1 data cache to the L2 cache. This occurs when either a dirty cache line is evicted from L1 data cache and allocated in the L2 cache or dirty data is written to the L2 and possibly to the next level of cache. This event counts both victim cache line evictions and cache write-backs from snoops or cache maintenance operations. The following cache operations are not counted:\n\n1. Invalidations which do not result in data being transferred out of the L1 (such as evictions of clean data),\n2. Full line writes which write to L2 without writing L1, such as write streaming mode."
>>> +    },
>>> +    {
>>> +        "ArchStdEvent": "L1D_CACHE_LMISS_RD",
>>> +        "PublicDescription": "Counts cache line refills into the level 1 data cache from any memory read operations, that incurred additional latency."
>>> +    },
>>> +    {
>>> +        "ArchStdEvent": "L1D_CACHE_RD",
>>> +        "PublicDescription": "Counts level 1 data cache accesses from any load operation. Atomic load operations that resolve in the CPUs caches counts as both a write access and read access."
>>> +    },
>>> +    {
>>> +        "ArchStdEvent": "L1D_CACHE_WR",
>>> +        "PublicDescription": "Counts level 1 data cache accesses generated by store operations. This event also counts accesses caused by a DC ZVA (data cache zero, specified by virtual address) instruction. Near atomic operations that resolve in the CPUs caches count as a write access and read access."
>>> +    },
>>> +    {
>>> +        "ArchStdEvent": "L1D_CACHE_REFILL_RD",
>>> +        "PublicDescription": "Counts level 1 data cache refills caused by speculatively executed load instructions where the memory read operation misses in the level 1 data cache. This event only counts one event per cache line."
>>> +    },
>>> +    {
>>> +        "ArchStdEvent": "L1D_CACHE_REFILL_WR",
>>> +        "PublicDescription": "Counts level 1 data cache refills caused by speculatively executed store instructions where the memory write operation misses in the level 1 data cache. This event only counts one event per cache line."
>>> +    },
>>> +    {
>>> +        "ArchStdEvent": "L1D_CACHE_REFILL_INNER",
>>> +        "PublicDescription": "Counts level 1 data cache refills where the cache line data came from caches inside the immediate cluster of the core."
>>> +    },
>>> +    {
>>> +        "ArchStdEvent": "L1D_CACHE_REFILL_OUTER",
>>> +        "PublicDescription": "Counts level 1 data cache refills for which the cache line data came from outside the immediate cluster of the core, like an SLC in the system interconnect or DRAM."
>>> +    },
>>> +    {
>>> +        "ArchStdEvent": "L1D_CACHE_WB_VICTIM",
>>> +        "PublicDescription": "Counts dirty cache line evictions from the level 1 data cache caused by a new cache line allocation. This event does not count evictions caused by cache maintenance operations."
>>> +    },
>>> +    {
>>> +        "ArchStdEvent": "L1D_CACHE_WB_CLEAN",
>>> +        "PublicDescription": "Counts write-backs from the level 1 data cache that are a result of a coherency operation made by another CPU. Event count includes cache maintenance operations."
>>> +    },
>>> +    {
>>> +        "ArchStdEvent": "L1D_CACHE_INVAL",
>>> +        "PublicDescription": "Counts each explicit invalidation of a cache line in the level 1 data cache caused by:\n\n- Cache Maintenance Operations (CMO) that operate by a virtual address.\n- Broadcast cache coherency operations from another CPU in the system.\n\nThis event does not count for the following conditions:\n\n1. A cache refill invalidates a cache line.\n2. A CMO which is executed on that CPU and invalidates a cache line specified by set/way.\n\nNote that CMOs that operate by set/way cannot be broadcast from one CPU to another."
>>> +    }
>>> +]
>>> diff --git a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p3-v2/l1i_cache.json b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p3-v2/l1i_cache.json
>>> new file mode 100644
>>> index 000000000000..633f1030359d
>>> --- /dev/null
>>> +++ b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p3-v2/l1i_cache.json
>>> @@ -0,0 +1,14 @@
>>> +[
>>> +    {
>>> +        "ArchStdEvent": "L1I_CACHE_REFILL",
>>> +        "PublicDescription": "Counts cache line refills in the level 1 instruction cache caused by a missed instruction fetch. Instruction fetches may include accessing multiple instructions, but the single cache line allocation is counted once."
>>> +    },
>>> +    {
>>> +        "ArchStdEvent": "L1I_CACHE",
>>> +        "PublicDescription": "Counts instruction fetches which access the level 1 instruction cache. Instruction cache accesses caused by cache maintenance operations are not counted."
>>> +    },
>>> +    {
>>> +        "ArchStdEvent": "L1I_CACHE_LMISS",
>>> +        "PublicDescription": "Counts cache line refills into the level 1 instruction cache, that incurred additional latency."
>>> +    }
>>> +]
>>> diff --git a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p3-v2/l2_cache.json b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p3-v2/l2_cache.json
>>> new file mode 100644
>>> index 000000000000..0e31d0daf88b
>>> --- /dev/null
>>> +++ b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p3-v2/l2_cache.json
>>> @@ -0,0 +1,50 @@
>>> +[
>>> +    {
>>> +        "ArchStdEvent": "L2D_CACHE",
>>> +        "PublicDescription": "Counts level 2 cache accesses. level 2 cache is a unified cache for data and instruction accesses. Accesses are for misses in the first level caches or translation resolutions due to accesses. This event also counts write back of dirty data from level 1 data cache to the L2 cache."
>>> +    },
>>> +    {
>>> +        "ArchStdEvent": "L2D_CACHE_REFILL",
>>> +        "PublicDescription": "Counts cache line refills into the level 2 cache. level 2 cache is a unified cache for data and instruction accesses. Accesses are for misses in the level 1 caches or translation resolutions due to accesses."
>>> +    },
>>> +    {
>>> +        "ArchStdEvent": "L2D_CACHE_WB",
>>> +        "PublicDescription": "Counts write-backs of data from the L2 cache to outside the CPU. This includes snoops to the L2 (from other CPUs) which return data even if the snoops cause an invalidation. L2 cache line invalidations which do not write data outside the CPU and snoops which return data from an L1 cache are not counted. Data would not be written outside the cache when invalidating a clean cache line."
>>> +    },
>>> +    {
>>> +        "ArchStdEvent": "L2D_CACHE_ALLOCATE",
>>> +        "PublicDescription": "TBD"
>>> +    },
>>> +    {
>>> +        "ArchStdEvent": "L2D_CACHE_RD",
>>> +        "PublicDescription": "Counts level 2 cache accesses due to memory read operations. level 2 cache is a unified cache for data and instruction accesses, accesses are for misses in the level 1 caches or translation resolutions due to accesses."
>>> +    },
>>> +    {
>>> +        "ArchStdEvent": "L2D_CACHE_WR",
>>> +        "PublicDescription": "Counts level 2 cache accesses due to memory write operations. level 2 cache is a unified cache for data and instruction accesses, accesses are for misses in the level 1 caches or translation resolutions due to accesses."
>>> +    },
>>> +    {
>>> +        "ArchStdEvent": "L2D_CACHE_REFILL_RD",
>>> +        "PublicDescription": "Counts refills for memory accesses due to memory read operation counted by L2D_CACHE_RD. level 2 cache is a unified cache for data and instruction accesses, accesses are for misses in the level 1 caches or translation resolutions due to accesses."
>>> +    },
>>> +    {
>>> +        "ArchStdEvent": "L2D_CACHE_REFILL_WR",
>>> +        "PublicDescription": "Counts refills for memory accesses due to memory write operation counted by L2D_CACHE_WR. level 2 cache is a unified cache for data and instruction accesses, accesses are for misses in the level 1 caches or translation resolutions due to accesses."
>>> +    },
>>> +    {
>>> +        "ArchStdEvent": "L2D_CACHE_WB_VICTIM",
>>> +        "PublicDescription": "Counts evictions from the level 2 cache because of a line being allocated into the L2 cache."
>>> +    },
>>> +    {
>>> +        "ArchStdEvent": "L2D_CACHE_WB_CLEAN",
>>> +        "PublicDescription": "Counts write-backs from the level 2 cache that are a result of either:\n\n1. Cache maintenance operations,\n\n2. Snoop responses or,\n\n3. Direct cache transfers to another CPU due to a forwarding snoop request."
>>> +    },
>>> +    {
>>> +        "ArchStdEvent": "L2D_CACHE_INVAL",
>>> +        "PublicDescription": "Counts each explicit invalidation of a cache line in the level 2 cache by cache maintenance operations that operate by a virtual address, or by external coherency operations. This event does not count if either:\n\n1. A cache refill invalidates a cache line or,\n2. A Cache Maintenance Operation (CMO), which invalidates a cache line specified by set/way, is executed on that CPU.\n\nCMOs that operate by set/way cannot be broadcast from one CPU to another."
>>> +    },
>>> +    {
>>> +        "ArchStdEvent": "L2D_CACHE_LMISS_RD",
>>> +        "PublicDescription": "Counts cache line refills into the level 2 unified cache from any memory read operations that incurred additional latency."
>>> +    }
>>> +]
>>> diff --git a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p3-v2/l3_cache.json b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p3-v2/l3_cache.json
>>> new file mode 100644
>>> index 000000000000..45bfba532df7
>>> --- /dev/null
>>> +++ b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p3-v2/l3_cache.json
>>> @@ -0,0 +1,22 @@
>>> +[
>>> +    {
>>> +        "ArchStdEvent": "L3D_CACHE_ALLOCATE",
>>> +        "PublicDescription": "Counts level 3 cache line allocates that do not fetch data from outside the level 3 data or unified cache. For example, allocates due to streaming stores."
>>> +    },
>>> +    {
>>> +        "ArchStdEvent": "L3D_CACHE_REFILL",
>>> +        "PublicDescription": "Counts level 3 accesses that receive data from outside the L3 cache."
>>> +    },
>>> +    {
>>> +        "ArchStdEvent": "L3D_CACHE",
>>> +        "PublicDescription": "Counts level 3 cache accesses. level 3 cache is a unified cache for data and instruction accesses. Accesses are for misses in the lower level caches or translation resolutions due to accesses."
>>> +    },
>>> +    {
>>> +        "ArchStdEvent": "L3D_CACHE_RD",
>>> +        "PublicDescription": "TBD"
>>> +    },
>>> +    {
>>> +        "ArchStdEvent": "L3D_CACHE_LMISS_RD",
>>> +        "PublicDescription": "Counts any cache line refill into the level 3 cache from memory read operations that incurred additional latency."
>>> +    }
>>> +]
>>> diff --git a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p3-v2/ll_cache.json b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p3-v2/ll_cache.json
>>> new file mode 100644
>>> index 000000000000..bb712d57d58a
>>> --- /dev/null
>>> +++ b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p3-v2/ll_cache.json
>>> @@ -0,0 +1,10 @@
>>> +[
>>> +    {
>>> +        "ArchStdEvent": "LL_CACHE_RD",
>>> +        "PublicDescription": "Counts read transactions that were returned from outside the core cluster. This event counts when the system register CPUECTLR.EXTLLC bit is set. This event counts read transactions returned from outside the core if those transactions are either hit in the system level cache or missed in the SLC and are returned from any other external sources."
>>> +    },
>>> +    {
>>> +        "ArchStdEvent": "LL_CACHE_MISS_RD",
>>> +        "PublicDescription": "Counts read transactions that were returned from outside the core cluster but missed in the system level cache. This event counts when the system register CPUECTLR.EXTLLC bit is set. This event counts read transactions returned from outside the core if those transactions are missed in the System level Cache. The data source of the transaction is indicated by a field in the CHI transaction returning to the CPU. This event does not count reads caused by cache maintenance operations."
>>> +    }
>>> +]
>>> diff --git a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p3-v2/memory.json b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p3-v2/memory.json
>>> new file mode 100644
>>> index 000000000000..106a97f8b2e7
>>> --- /dev/null
>>> +++ b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p3-v2/memory.json
>>> @@ -0,0 +1,46 @@
>>> +[
>>> +    {
>>> +        "ArchStdEvent": "MEM_ACCESS",
>>> +        "PublicDescription": "Counts memory accesses issued by the CPU load store unit, where those accesses are issued due to load or store operations. This event counts memory accesses no matter whether the data is received from any level of cache hierarchy or external memory. If memory accesses are broken up into smaller transactions than what were specified in the load or store instructions, then the event counts those smaller memory transactions."
>>> +    },
>>> +    {
>>> +        "ArchStdEvent": "MEMORY_ERROR",
>>> +        "PublicDescription": "Counts any detected correctable or uncorrectable physical memory errors (ECC or parity) in protected CPUs RAMs. On the core, this event counts errors in the caches (including data and tag rams). Any detected memory error (from either a speculative and abandoned access, or an architecturally executed access) is counted. Note that errors are only detected when the actual protected memory is accessed by an operation."
>>> +    },
>>> +    {
>>> +        "ArchStdEvent": "REMOTE_ACCESS",
>>> +        "PublicDescription": "Counts accesses to another chip, which is implemented as a different CMN mesh in the system. If the CHI bus response back to the core indicates that the data source is from another chip (mesh), then the counter is updated. If no data is returned, even if the system snoops another chip/mesh, then the counter is not updated."
>>> +    },
>>> +    {
>>> +        "ArchStdEvent": "MEM_ACCESS_RD",
>>> +        "PublicDescription": "Counts memory accesses issued by the CPU due to load operations. The event counts any memory load access, no matter whether the data is received from any level of cache hierarchy or external memory. The event also counts atomic load operations. If memory accesses are broken up by the load/store unit into smaller transactions that are issued by the bus interface, then the event counts those smaller transactions."
>>> +    },
>>> +    {
>>> +        "ArchStdEvent": "MEM_ACCESS_WR",
>>> +        "PublicDescription": "Counts memory accesses issued by the CPU due to store operations. The event counts any memory store access, no matter whether the data is located in any level of cache or external memory. The event also counts atomic load and store operations. If memory accesses are broken up by the load/store unit into smaller transactions that are issued by the bus interface, then the event counts those smaller transactions."
>>> +    },
>>> +    {
>>> +        "ArchStdEvent": "LDST_ALIGN_LAT",
>>> +        "PublicDescription": "Counts the number of memory read and write accesses in a cycle that incurred additional latency, due to the alignment of the address and the size of data being accessed, which results in store crossing a single cache line."
>>> +    },
>>> +    {
>>> +        "ArchStdEvent": "LD_ALIGN_LAT",
>>> +        "PublicDescription": "Counts the number of memory read accesses in a cycle that incurred additional latency, due to the alignment of the address and size of data being accessed, which results in load crossing a single cache line."
>>> +    },
>>> +    {
>>> +        "ArchStdEvent": "ST_ALIGN_LAT",
>>> +        "PublicDescription": "Counts the number of memory write access in a cycle that incurred additional latency, due to the alignment of the address and size of data being accessed incurred additional latency."
>>> +    },
>>> +    {
>>> +        "ArchStdEvent": "MEM_ACCESS_CHECKED",
>>> +        "PublicDescription": "Counts the number of memory read and write accesses in a cycle that are tag checked by the Memory Tagging Extension (MTE)."
>>> +    },
>>> +    {
>>> +        "ArchStdEvent": "MEM_ACCESS_CHECKED_RD",
>>> +        "PublicDescription": "Counts the number of memory read accesses in a cycle that are tag checked by the Memory Tagging Extension (MTE)."
>>> +    },
>>> +    {
>>> +        "ArchStdEvent": "MEM_ACCESS_CHECKED_WR",
>>> +        "PublicDescription": "Counts the number of memory write accesses in a cycle that is tag checked by the Memory Tagging Extension (MTE)."
>>> +    }
>>> +]
>>> diff --git a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p3-v2/metrics.json b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p3-v2/metrics.json
>>> new file mode 100644
>>> index 000000000000..b01cc2120175
>>> --- /dev/null
>>> +++ b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p3-v2/metrics.json
>>> @@ -0,0 +1,331 @@
>>> +[
>>> +    {
>>> +        "ArchStdEvent": "backend_bound",
>>> +        "MetricExpr": "(100 * ((STALL_SLOT_BACKEND / (CPU_CYCLES * #slots)) - ((BR_MIS_PRED * 3) / CPU_CYCLES)))"
>>> +    },
>>> +    {
>>> +        "MetricName": "backend_stalled_cycles",
>>> +        "MetricExpr": "((STALL_BACKEND / CPU_CYCLES) * 100)",
>>> +        "BriefDescription": "This metric is the percentage of cycles that were stalled due to resource constraints in the backend unit of the processor.",
>>
>> nit: here and below saying "This metric" is somewhat redundant.
>>
>>> +        "MetricGroup": "Cycle_Accounting",
>>> +        "ScaleUnit": "1percent of cycles"
>>> +    },
>>> +    {
>>> +        "ArchStdEvent": "bad_speculation",
>>> +        "MetricExpr": "(100 * (((1 - (OP_RETIRED / OP_SPEC)) * (1 - (STALL_SLOT / (CPU_CYCLES * #slots)))) + ((BR_MIS_PRED * 4) / CPU_CYCLES)))"
>>> +    },
>>> +    {
>>> +        "MetricName": "branch_misprediction_ratio",
>>> +        "MetricExpr": "(BR_MIS_PRED_RETIRED / BR_RETIRED)",
>>> +        "BriefDescription": "This metric measures the ratio of branches mispredicted to the total number of branches architecturally executed. This gives an indication of the effectiveness of the branch prediction unit.",
>>> +        "MetricGroup": "Miss_Ratio;Branch_Effectiveness",
>>> +        "ScaleUnit": "1per branch"
>>> +    },
>>> +    {
>>> +        "MetricName": "branch_mpki",
>>> +        "MetricExpr": "((BR_MIS_PRED_RETIRED / INST_RETIRED) * 1000)",
>>> +        "BriefDescription": "This metric measures the number of branch mispredictions per thousand instructions executed.",
>>> +        "MetricGroup": "MPKI;Branch_Effectiveness",
>>> +        "ScaleUnit": "1MPKI"
>>> +    },
>>> +    {
>>> +        "MetricName": "branch_percentage",
>>> +        "MetricExpr": "(((BR_IMMED_SPEC + BR_INDIRECT_SPEC) / INST_SPEC) * 100)",
>>> +        "BriefDescription": "This metric measures branch operations as a percentage of operations speculatively executed.",
>>> +        "MetricGroup": "Operation_Mix",
>>> +        "ScaleUnit": "1percent of operations"
>>> +    },
>>> +    {
>>> +        "MetricName": "crypto_percentage",
>>> +        "MetricExpr": "((CRYPTO_SPEC / INST_SPEC) * 100)",
>>> +        "BriefDescription": "This metric measures crypto operations as a percentage of operations speculatively executed.",
>>> +        "MetricGroup": "Operation_Mix",
>>> +        "ScaleUnit": "1percent of operations"
>>> +    },
>>> +    {
>>> +        "MetricName": "dtlb_mpki",
>>> +        "MetricExpr": "((DTLB_WALK / INST_RETIRED) * 1000)",
>>> +        "BriefDescription": "This metric measures the number of data TLB Walks per thousand instructions executed.",
>>> +        "MetricGroup": "MPKI;DTLB_Effectiveness",
>>> +        "ScaleUnit": "1MPKI"
>>> +    },
>>> +    {
>>> +        "MetricName": "dtlb_walk_ratio",
>>> +        "MetricExpr": "(DTLB_WALK / L1D_TLB)",
>>> +        "BriefDescription": "This metric measures the ratio of data TLB Walks to the total number of data TLB accesses. This gives an indication of the effectiveness of the data TLB accesses.",
>>> +        "MetricGroup": "Miss_Ratio;DTLB_Effectiveness",
>>> +        "ScaleUnit": "1per TLB access"
>>> +    },
>>> +    {
>>> +        "ArchStdEvent": "frontend_bound",
>>> +        "MetricExpr": "(100 * ((STALL_SLOT_FRONTEND / (CPU_CYCLES * #slots)) - (BR_MIS_PRED / CPU_CYCLES)))"
>>> +    },
>>> +    {
>>> +        "MetricName": "frontend_stalled_cycles",
>>> +        "MetricExpr": "((STALL_FRONTEND / CPU_CYCLES) * 100)",
>>> +        "BriefDescription": "This metric is the percentage of cycles that were stalled due to resource constraints in the frontend unit of the processor.",
>>> +        "MetricGroup": "Cycle_Accounting",
>>> +        "ScaleUnit": "1percent of cycles"
>>> +    },
>>> +    {
>>> +        "MetricName": "integer_dp_percentage",
>>> +        "MetricExpr": "((DP_SPEC / INST_SPEC) * 100)",
>>> +        "BriefDescription": "This metric measures scalar integer operations as a percentage of operations speculatively executed.",
>>> +        "MetricGroup": "Operation_Mix",
>>> +        "ScaleUnit": "1percent of operations"
>>> +    },
>>> +    {
>>> +        "MetricName": "ipc",
>>> +        "MetricExpr": "(INST_RETIRED / CPU_CYCLES)",
>>> +        "BriefDescription": "This metric measures the number of instructions retired per cycle.",
>>> +        "MetricGroup": "General",
>>> +        "ScaleUnit": "1per cycle"
>>> +    },
>>> +    {
>>> +        "MetricName": "itlb_mpki",
>>> +        "MetricExpr": "((ITLB_WALK / INST_RETIRED) * 1000)",
>>> +        "BriefDescription": "This metric measures the number of instruction TLB Walks per thousand instructions executed.",
>>> +        "MetricGroup": "MPKI;ITLB_Effectiveness",
>>> +        "ScaleUnit": "1MPKI"
>>> +    },
>>> +    {
>>> +        "MetricName": "itlb_walk_ratio",
>>> +        "MetricExpr": "(ITLB_WALK / L1I_TLB)",
>>> +        "BriefDescription": "This metric measures the ratio of instruction TLB Walks to the total number of instruction TLB accesses. This gives an indication of the effectiveness of the instruction TLB accesses.",
>>> +        "MetricGroup": "Miss_Ratio;ITLB_Effectiveness",
>>> +        "ScaleUnit": "1per TLB access"
>>> +    },
>>> +    {
>>> +        "MetricName": "l1d_cache_miss_ratio",
>>> +        "MetricExpr": "(L1D_CACHE_REFILL / L1D_CACHE)",
>>> +        "BriefDescription": "This metric measures the ratio of level 1 data cache accesses missed to the total number of level 1 data cache accesses. This gives an indication of the effectiveness of the level 1 data cache.",
>>> +        "MetricGroup": "Miss_Ratio;L1D_Cache_Effectiveness",
>>> +        "ScaleUnit": "1per cache access"
>>> +    },
>>> +    {
>>> +        "MetricName": "l1d_cache_mpki",
>>> +        "MetricExpr": "((L1D_CACHE_REFILL / INST_RETIRED) * 1000)",
>>> +        "BriefDescription": "This metric measures the number of level 1 data cache accesses missed per thousand instructions executed.",
>>> +        "MetricGroup": "MPKI;L1D_Cache_Effectiveness",
>>> +        "ScaleUnit": "1MPKI"
>>> +    },
>>> +    {
>>> +        "MetricName": "l1d_tlb_miss_ratio",
>>> +        "MetricExpr": "(L1D_TLB_REFILL / L1D_TLB)",
>>> +        "BriefDescription": "This metric measures the ratio of level 1 data TLB accesses missed to the total number of level 1 data TLB accesses. This gives an indication of the effectiveness of the level 1 data TLB.",
>>> +        "MetricGroup": "Miss_Ratio;DTLB_Effectiveness",
>>> +        "ScaleUnit": "1per TLB access"
>>> +    },
>>> +    {
>>> +        "MetricName": "l1d_tlb_mpki",
>>> +        "MetricExpr": "((L1D_TLB_REFILL / INST_RETIRED) * 1000)",
>>> +        "BriefDescription": "This metric measures the number of level 1 instruction TLB accesses missed per thousand instructions executed.",
>>> +        "MetricGroup": "MPKI;DTLB_Effectiveness",
>>> +        "ScaleUnit": "1MPKI"
>>> +    },
>>> +    {
>>> +        "MetricName": "l1i_cache_miss_ratio",
>>> +        "MetricExpr": "(L1I_CACHE_REFILL / L1I_CACHE)",
>>> +        "BriefDescription": "This metric measures the ratio of level 1 instruction cache accesses missed to the total number of level 1 instruction cache accesses. This gives an indication of the effectiveness of the level 1 instruction cache.",
>>> +        "MetricGroup": "Miss_Ratio;L1I_Cache_Effectiveness",
>>> +        "ScaleUnit": "1per cache access"
>>> +    },
>>> +    {
>>> +        "MetricName": "l1i_cache_mpki",
>>> +        "MetricExpr": "((L1I_CACHE_REFILL / INST_RETIRED) * 1000)",
>>> +        "BriefDescription": "This metric measures the number of level 1 instruction cache accesses missed per thousand instructions executed.",
>>> +        "MetricGroup": "MPKI;L1I_Cache_Effectiveness",
>>> +        "ScaleUnit": "1MPKI"
>>> +    },
>>> +    {
>>> +        "MetricName": "l1i_tlb_miss_ratio",
>>> +        "MetricExpr": "(L1I_TLB_REFILL / L1I_TLB)",
>>> +        "BriefDescription": "This metric measures the ratio of level 1 instruction TLB accesses missed to the total number of level 1 instruction TLB accesses. This gives an indication of the effectiveness of the level 1 instruction TLB.",
>>> +        "MetricGroup": "Miss_Ratio;ITLB_Effectiveness",
>>> +        "ScaleUnit": "1per TLB access"
>>> +    },
>>> +    {
>>> +        "MetricName": "l1i_tlb_mpki",
>>> +        "MetricExpr": "((L1I_TLB_REFILL / INST_RETIRED) * 1000)",
>>> +        "BriefDescription": "This metric measures the number of level 1 instruction TLB accesses missed per thousand instructions executed.",
>>> +        "MetricGroup": "MPKI;ITLB_Effectiveness",
>>> +        "ScaleUnit": "1MPKI"
>>> +    },
>>> +    {
>>> +        "MetricName": "l2_cache_miss_ratio",
>>> +        "MetricExpr": "(L2D_CACHE_REFILL / L2D_CACHE)",
>>> +        "BriefDescription": "This metric measures the ratio of level 2 cache accesses missed to the total number of level 2 cache accesses. This gives an indication of the effectiveness of the level 2 cache, which is a unified cache that stores both data and instruction. Note that cache accesses in this cache are either data memory access or instruction fetch as this is a unified cache.",
>>> +        "MetricGroup": "Miss_Ratio;L2_Cache_Effectiveness",
>>> +        "ScaleUnit": "1per cache access"
>>> +    },
>>> +    {
>>> +        "MetricName": "l2_cache_mpki",
>>> +        "MetricExpr": "((L2D_CACHE_REFILL / INST_RETIRED) * 1000)",
>>> +        "BriefDescription": "This metric measures the number of level 2 unified cache accesses missed per thousand instructions executed. Note that cache accesses in this cache are either data memory access or instruction fetch as this is a unified cache.",
>>> +        "MetricGroup": "MPKI;L2_Cache_Effectiveness",
>>> +        "ScaleUnit": "1MPKI"
>>> +    },
>>> +    {
>>> +        "MetricName": "l2_tlb_miss_ratio",
>>> +        "MetricExpr": "(L2D_TLB_REFILL / L2D_TLB)",
>>> +        "BriefDescription": "This metric measures the ratio of level 2 unified TLB accesses missed to the total number of level 2 unified TLB accesses. This gives an indication of the effectiveness of the level 2 TLB.",
>>> +        "MetricGroup": "Miss_Ratio;ITLB_Effectiveness;DTLB_Effectiveness",
>>> +        "ScaleUnit": "1per TLB access"
>>> +    },
>>> +    {
>>> +        "MetricName": "l2_tlb_mpki",
>>> +        "MetricExpr": "((L2D_TLB_REFILL / INST_RETIRED) * 1000)",
>>> +        "BriefDescription": "This metric measures the number of level 2 unified TLB accesses missed per thousand instructions executed.",
>>> +        "MetricGroup": "MPKI;ITLB_Effectiveness;DTLB_Effectiveness",
>>> +        "ScaleUnit": "1MPKI"
>>> +    },
>>> +    {
>>> +        "MetricName": "ll_cache_read_hit_ratio",
>>> +        "MetricExpr": "((LL_CACHE_RD - LL_CACHE_MISS_RD) / LL_CACHE_RD)",
>>> +        "BriefDescription": "This metric measures the ratio of last level cache read accesses hit in the cache to the total number of last level cache accesses. This gives an indication of the effectiveness of the last level cache for read traffic. Note that cache accesses in this cache are either data memory access or instruction fetch as this is a system level cache.",
>>> +        "MetricGroup": "LL_Cache_Effectiveness",
>>> +        "ScaleUnit": "1per cache access"
>>> +    },
>>> +    {
>>> +        "MetricName": "ll_cache_read_miss_ratio",
>>> +        "MetricExpr": "(LL_CACHE_MISS_RD / LL_CACHE_RD)",
>>> +        "BriefDescription": "This metric measures the ratio of last level cache read accesses missed to the total number of last level cache accesses. This gives an indication of the effectiveness of the last level cache for read traffic. Note that cache accesses in this cache are either data memory access or instruction fetch as this is a system level cache.",
>>> +        "MetricGroup": "Miss_Ratio;LL_Cache_Effectiveness",
>>> +        "ScaleUnit": "1per cache access"
>>> +    },
>>> +    {
>>> +        "MetricName": "ll_cache_read_mpki",
>>> +        "MetricExpr": "((LL_CACHE_MISS_RD / INST_RETIRED) * 1000)",
>>> +        "BriefDescription": "This metric measures the number of last level cache read accesses missed per thousand instructions executed.",
>>> +        "MetricGroup": "MPKI;LL_Cache_Effectiveness",
>>> +        "ScaleUnit": "1MPKI"
>>> +    },
>>> +    {
>>> +        "MetricName": "load_percentage",
>>> +        "MetricExpr": "((LD_SPEC / INST_SPEC) * 100)",
>>> +        "BriefDescription": "This metric measures load operations as a percentage of operations speculatively executed.",
>>> +        "MetricGroup": "Operation_Mix",
>>> +        "ScaleUnit": "1percent of operations"
>>> +    },
>>> +    {
>>> +        "ArchStdEvent": "retiring"
>>> +    },
>>> +    {
>>> +        "MetricName": "scalar_fp_percentage",
>>> +        "MetricExpr": "((VFP_SPEC / INST_SPEC) * 100)",
>>> +        "BriefDescription": "This metric measures scalar floating point operations as a percentage of operations speculatively executed.",
>>> +        "MetricGroup": "Operation_Mix",
>>> +        "ScaleUnit": "1percent of operations"
>>> +    },
>>> +    {
>>> +        "MetricName": "simd_percentage",
>>> +        "MetricExpr": "((ASE_SPEC / INST_SPEC) * 100)",
>>> +        "BriefDescription": "This metric measures advanced SIMD operations as a percentage of total operations speculatively executed.",
>>> +        "MetricGroup": "Operation_Mix",
>>> +        "ScaleUnit": "1percent of operations"
>>> +    },
>>> +    {
>>> +        "MetricName": "store_percentage",
>>> +        "MetricExpr": "((ST_SPEC / INST_SPEC) * 100)",
>>> +        "BriefDescription": "This metric measures store operations as a percentage of operations speculatively executed.",
>>> +        "MetricGroup": "Operation_Mix",
>>> +        "ScaleUnit": "1percent of operations"
>>> +    },
>>> +    {
>>> +        "MetricExpr": "L3D_CACHE_REFILL / INST_RETIRED * 1000",
>>> +        "BriefDescription": "The rate of L3 D-Cache misses per kilo instructions",
>>> +        "MetricGroup": "MPKI;L3_Cache_Effectiveness",
>>> +        "MetricName": "l3d_cache_mpki",
>>> +        "ScaleUnit": "1MPKI"
>>> +    },
>>> +    {
>>> +        "MetricExpr": "L3D_CACHE_REFILL / L3D_CACHE",
>>> +        "BriefDescription": "The rate of L3 D-Cache misses to the overall L3 D-Cache",
>>> +        "MetricGroup": "Miss_Ratio;L3_Cache_Effectiveness",
>>> +        "MetricName": "l3d_cache_miss_rate",
>>> +        "ScaleUnit": "100%"
>>> +    },
>>> +    {
>>> +        "MetricExpr": "BR_RETIRED / INST_RETIRED * 1000",
>>> +        "BriefDescription": "The rate of branches retired per kilo instructions",
>>> +        "MetricGroup": "MPKI;Branch_Effectiveness",
>>> +        "MetricName": "branch_pki",
>>> +        "ScaleUnit": "1PKI"
>>> +    },
>>> +    {
>>> +        "MetricExpr": "ipc / #slots",
>>> +        "BriefDescription": "IPC percentage of peak. The peak of IPC is the number of slots.",
>>> +        "MetricGroup": "General",
>>> +        "MetricName": "ipc_rate",
>>> +        "ScaleUnit": "100%"
>>> +    },
>>> +    {
>>> +        "MetricExpr": "INST_SPEC / CPU_CYCLES",
>>> +        "BriefDescription": "Speculatively executed Instructions Per Cycle (IPC)",
>>> +        "MetricGroup": "General",
>>> +        "MetricName": "spec_ipc"
>>> +    },
>>> +    {
>>> +        "MetricExpr": "OP_RETIRED / OP_SPEC",
>>> +        "BriefDescription": "Of all the micro-operations issued, what percentage are retired(committed)",
>>> +        "MetricGroup": "General",
>>> +        "MetricName": "retired_rate",
>>> +        "ScaleUnit": "100%"
>>> +    },
>>> +    {
>>> +        "MetricExpr": "1 - OP_RETIRED / OP_SPEC",
>>> +        "BriefDescription": "Of all the micro-operations issued, what percentage are not retired(committed)",
>>> +        "MetricGroup": "General",
>>> +        "MetricName": "wasted_rate",
>>> +        "ScaleUnit": "100%"
>>> +    },
>>> +    {
>>> +        "MetricExpr": "LD_SPEC / INST_SPEC",
>>> +        "BriefDescription": "The rate of load instructions speculatively executed to overall instructions speclatively executed",
>>
>> nit: here and below "speclatively" should be "speculatively"
>>
>> Thanks,
>> Ian
>>
>>> +        "MetricGroup": "Operation_Mix",
>>> +        "MetricName": "load_spec_rate",
>>> +        "ScaleUnit": "100%"
>>> +    },
>>> +    {
>>> +        "MetricExpr": "ST_SPEC / INST_SPEC",
>>> +        "BriefDescription": "The rate of store instructions speculatively executed to overall instructions speclatively executed",
>>> +        "MetricGroup": "Operation_Mix",
>>> +        "MetricName": "store_spec_rate",
>>> +        "ScaleUnit": "100%"
>>> +    },
>>> +    {
>>> +        "MetricExpr": "ASE_SPEC / INST_SPEC",
>>> +        "BriefDescription": "The rate of advanced SIMD instructions speculatively executed to overall instructions speclatively executed",
>>> +        "MetricGroup": "Operation_Mix",
>>> +        "MetricName": "advanced_simd_spec_rate",
>>> +        "ScaleUnit": "100%"
>>> +    },
>>> +    {
>>> +        "MetricExpr": "VFP_SPEC / INST_SPEC",
>>> +        "BriefDescription": "The rate of floating point instructions speculatively executed to overall instructions speclatively executed",
>>> +        "MetricGroup": "Operation_Mix",
>>> +        "MetricName": "float_point_spec_rate",
>>> +        "ScaleUnit": "100%"
>>> +    },
>>> +    {
>>> +        "MetricExpr": "BR_IMMED_SPEC / INST_SPEC",
>>> +        "BriefDescription": "The rate of branch immediate instructions speculatively executed to overall instructions speclatively executed",
>>> +        "MetricGroup": "Operation_Mix",
>>> +        "MetricName": "branch_immed_spec_rate",
>>> +        "ScaleUnit": "100%"
>>> +    },
>>> +    {
>>> +        "MetricExpr": "BR_RETURN_SPEC / INST_SPEC",
>>> +        "BriefDescription": "The rate of procedure return instructions speculatively executed to overall instructions speclatively executed",
>>> +        "MetricGroup": "Operation_Mix",
>>> +        "MetricName": "branch_return_spec_rate",
>>> +        "ScaleUnit": "100%"
>>> +    },
>>> +    {
>>> +        "MetricExpr": "BR_INDIRECT_SPEC / INST_SPEC",
>>> +        "BriefDescription": "The rate of indirect branch instructions speculatively executed to overall instructions speclatively executed",
>>> +        "MetricGroup": "Operation_Mix",
>>> +        "MetricName": "branch_indirect_spec_rate",
>>> +        "ScaleUnit": "100%"
>>> +    }
>>> +]
>>> diff --git a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p3-v2/retired.json b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p3-v2/retired.json
>>> new file mode 100644
>>> index 000000000000..f297b049b62f
>>> --- /dev/null
>>> +++ b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p3-v2/retired.json
>>> @@ -0,0 +1,30 @@
>>> +[
>>> +    {
>>> +        "ArchStdEvent": "SW_INCR",
>>> +        "PublicDescription": "Counts software writes to the PMSWINC_EL0 (software PMU increment) register. The PMSWINC_EL0 register is a manually updated counter for use by application software.\n\nThis event could be used to measure any user program event, such as accesses to a particular data structure (by writing to the PMSWINC_EL0 register each time the data structure is accessed).\n\nTo use the PMSWINC_EL0 register and event, developers must insert instructions that write to the PMSWINC_EL0 register into the source code.\n\nSince the SW_INCR event records writes to the PMSWINC_EL0 register, there is no need to do a read/increment/write sequence to the PMSWINC_EL0 register."
>>> +    },
>>> +    {
>>> +        "ArchStdEvent": "INST_RETIRED",
>>> +        "PublicDescription": "Counts instructions that have been architecturally executed."
>>> +    },
>>> +    {
>>> +        "ArchStdEvent": "CID_WRITE_RETIRED",
>>> +        "PublicDescription": "Counts architecturally executed writes to the CONTEXTIDR register, which usually contain the kernel PID and can be output with hardware trace."
>>> +    },
>>> +    {
>>> +        "ArchStdEvent": "TTBR_WRITE_RETIRED",
>>> +        "PublicDescription": "Counts architectural writes to TTBR0/1_EL1. If virtualization host extensions are enabled (by setting the HCR_EL2.E2H bit to 1), then accesses to TTBR0/1_EL1 that are redirected to TTBR0/1_EL2, or accesses to TTBR0/1_EL12, are counted. TTBRn registers are typically updated when the kernel is swapping user-space threads or applications."
>>> +    },
>>> +    {
>>> +        "ArchStdEvent": "BR_RETIRED",
>>> +        "PublicDescription": "Counts architecturally executed branches, whether the branch is taken or not. Instructions that explicitly write to the PC are also counted."
>>> +    },
>>> +    {
>>> +        "ArchStdEvent": "BR_MIS_PRED_RETIRED",
>>> +        "PublicDescription": "Counts branches counted by BR_RETIRED which were mispredicted and caused a pipeline flush."
>>> +    },
>>> +    {
>>> +        "ArchStdEvent": "OP_RETIRED",
>>> +        "PublicDescription": "Counts micro-operations that are architecturally executed. This is a count of number of micro-operations retired from the commit queue in a single cycle."
>>> +    }
>>> +]
>>> diff --git a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p3-v2/spe.json b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p3-v2/spe.json
>>> new file mode 100644
>>> index 000000000000..5de8b0f3a440
>>> --- /dev/null
>>> +++ b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p3-v2/spe.json
>>> @@ -0,0 +1,18 @@
>>> +[
>>> +    {
>>> +        "ArchStdEvent": "SAMPLE_POP",
>>> +        "PublicDescription": "Counts statistical profiling sample population, the count of all operations that could be sampled but may or may not be chosen for sampling."
>>> +    },
>>> +    {
>>> +        "ArchStdEvent": "SAMPLE_FEED",
>>> +        "PublicDescription": "Counts statistical profiling samples taken for sampling."
>>> +    },
>>> +    {
>>> +        "ArchStdEvent": "SAMPLE_FILTRATE",
>>> +        "PublicDescription": "Counts statistical profiling samples taken which are not removed by filtering."
>>> +    },
>>> +    {
>>> +        "ArchStdEvent": "SAMPLE_COLLISION",
>>> +        "PublicDescription": "Counts statistical profiling samples that have collided with a previous sample and so therefore not taken."
>>> +    }
>>> +]
>>> diff --git a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p3-v2/spec_operation.json b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p3-v2/spec_operation.json
>>> new file mode 100644
>>> index 000000000000..1af961f8a6c8
>>> --- /dev/null
>>> +++ b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p3-v2/spec_operation.json
>>> @@ -0,0 +1,110 @@
>>> +[
>>> +    {
>>> +        "ArchStdEvent": "BR_MIS_PRED",
>>> +        "PublicDescription": "Counts branches which are speculatively executed and mispredicted."
>>> +    },
>>> +    {
>>> +        "ArchStdEvent": "BR_PRED",
>>> +        "PublicDescription": "Counts branches speculatively executed and were predicted right."
>>> +    },
>>> +    {
>>> +        "ArchStdEvent": "INST_SPEC",
>>> +        "PublicDescription": "Counts operations that have been speculatively executed."
>>> +    },
>>> +    {
>>> +        "ArchStdEvent": "OP_SPEC",
>>> +        "PublicDescription": "Counts micro-operations speculatively executed. This is the count of the number of micro-operations dispatched in a cycle."
>>> +    },
>>> +    {
>>> +        "ArchStdEvent": "UNALIGNED_LD_SPEC",
>>> +        "PublicDescription": "Counts unaligned memory read operations issued by the CPU. This event counts unaligned accesses (as defined by the actual instruction), even if they are subsequently issued as multiple aligned accesses. The event does not count preload operations (PLD, PLI)."
>>> +    },
>>> +    {
>>> +        "ArchStdEvent": "UNALIGNED_ST_SPEC",
>>> +        "PublicDescription": "Counts unaligned memory write operations issued by the CPU. This event counts unaligned accesses (as defined by the actual instruction), even if they are subsequently issued as multiple aligned accesses."
>>> +    },
>>> +    {
>>> +        "ArchStdEvent": "UNALIGNED_LDST_SPEC",
>>> +        "PublicDescription": "Counts unaligned memory operations issued by the CPU. This event counts unaligned accesses (as defined by the actual instruction), even if they are subsequently issued as multiple aligned accesses."
>>> +    },
>>> +    {
>>> +        "ArchStdEvent": "LDREX_SPEC",
>>> +        "PublicDescription": "Counts Load-Exclusive operations that have been speculatively executed. Eg: LDREX, LDX"
>>> +    },
>>> +    {
>>> +        "ArchStdEvent": "STREX_PASS_SPEC",
>>> +        "PublicDescription": "Counts store-exclusive operations that have been speculatively executed and have successfully completed the store operation."
>>> +    },
>>> +    {
>>> +        "ArchStdEvent": "STREX_FAIL_SPEC",
>>> +        "PublicDescription": "Counts store-exclusive operations that have been speculatively executed and have not successfully completed the store operation."
>>> +    },
>>> +    {
>>> +        "ArchStdEvent": "STREX_SPEC",
>>> +        "PublicDescription": "Counts store-exclusive operations that have been speculatively executed."
>>> +    },
>>> +    {
>>> +        "ArchStdEvent": "LD_SPEC",
>>> +        "PublicDescription": "Counts speculatively executed load operations including Single Instruction Multiple Data (SIMD) load operations."
>>> +    },
>>> +    {
>>> +        "ArchStdEvent": "ST_SPEC",
>>> +        "PublicDescription": "Counts speculatively executed store operations including Single Instruction Multiple Data (SIMD) store operations."
>>> +    },
>>> +    {
>>> +        "ArchStdEvent": "DP_SPEC",
>>> +        "PublicDescription": "Counts speculatively executed logical or arithmetic instructions such as MOV/MVN operations."
>>> +    },
>>> +    {
>>> +        "ArchStdEvent": "ASE_SPEC",
>>> +        "PublicDescription": "Counts speculatively executed Advanced SIMD operations excluding load, store and move micro-operations that move data to or from SIMD (vector) registers."
>>> +    },
>>> +    {
>>> +        "ArchStdEvent": "VFP_SPEC",
>>> +        "PublicDescription": "Counts speculatively executed floating point operations. This event does not count operations that move data to or from floating point (vector) registers."
>>> +    },
>>> +    {
>>> +        "ArchStdEvent": "PC_WRITE_SPEC",
>>> +        "PublicDescription": "Counts speculatively executed operations which cause software changes of the PC. Those operations include all taken branch operations."
>>> +    },
>>> +    {
>>> +        "ArchStdEvent": "CRYPTO_SPEC",
>>> +        "PublicDescription": "Counts speculatively executed cryptographic operations except for PMULL and VMULL operations."
>>> +    },
>>> +    {
>>> +        "ArchStdEvent": "BR_IMMED_SPEC",
>>> +        "PublicDescription": "Counts immediate branch operations which are speculatively executed."
>>> +    },
>>> +    {
>>> +        "ArchStdEvent": "BR_RETURN_SPEC",
>>> +        "PublicDescription": "Counts procedure return operations (RET) which are speculatively executed."
>>> +    },
>>> +    {
>>> +        "ArchStdEvent": "BR_INDIRECT_SPEC",
>>> +        "PublicDescription": "Counts indirect branch operations including procedure returns, which are speculatively executed. This includes operations that force a software change of the PC, other than exception-generating operations.  Eg: BR Xn, RET"
>>> +    },
>>> +    {
>>> +        "ArchStdEvent": "ISB_SPEC",
>>> +        "PublicDescription": "Counts ISB operations that are executed."
>>> +    },
>>> +    {
>>> +        "ArchStdEvent": "DSB_SPEC",
>>> +        "PublicDescription": "Counts DSB operations that are speculatively issued to Load/Store unit in the CPU."
>>> +    },
>>> +    {
>>> +        "ArchStdEvent": "DMB_SPEC",
>>> +        "PublicDescription": "Counts DMB operations that are speculatively issued to the Load/Store unit in the CPU. This event does not count implied barriers from load acquire/store release operations."
>>> +    },
>>> +    {
>>> +        "ArchStdEvent": "RC_LD_SPEC",
>>> +        "PublicDescription": "Counts any load acquire operations that are speculatively executed. Eg: LDAR, LDARH, LDARB"
>>> +    },
>>> +    {
>>> +        "ArchStdEvent": "RC_ST_SPEC",
>>> +        "PublicDescription": "Counts any store release operations that are speculatively executed. Eg: STLR, STLRH, STLRB'"
>>> +    },
>>> +    {
>>> +        "ArchStdEvent": "ASE_INST_SPEC",
>>> +        "PublicDescription": "Counts speculatively executed Advanced SIMD operations."
>>> +    }
>>> +]
>>> diff --git a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p3-v2/stall.json b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p3-v2/stall.json
>>> new file mode 100644
>>> index 000000000000..bbbebc805034
>>> --- /dev/null
>>> +++ b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p3-v2/stall.json
>>> @@ -0,0 +1,30 @@
>>> +[
>>> +    {
>>> +        "ArchStdEvent": "STALL_FRONTEND",
>>> +        "PublicDescription": "Counts cycles when frontend could not send any micro-operations to the rename stage because of frontend resource stalls caused by fetch memory latency or branch prediction flow stalls. All the frontend slots were empty during the cycle when this event counts."
>>> +    },
>>> +    {
>>> +        "ArchStdEvent": "STALL_BACKEND",
>>> +        "PublicDescription": "Counts cycles whenever the rename unit is unable to send any micro-operations to the backend of the pipeline because of backend resource constraints. Backend resource constraints can include issue stage fullness, execution stage fullness, or other internal pipeline resource fullness. All the backend slots were empty during the cycle when this event counts."
>>> +    },
>>> +    {
>>> +        "ArchStdEvent": "STALL",
>>> +        "PublicDescription": "Counts cycles when no operations are sent to the rename unit from the frontend or from the rename unit to the backend for any reason (either frontend or backend stall)."
>>> +    },
>>> +    {
>>> +        "ArchStdEvent": "STALL_SLOT_BACKEND",
>>> +        "PublicDescription": "Counts slots per cycle in which no operations are sent from the rename unit to the backend due to backend resource constraints."
>>> +    },
>>> +    {
>>> +        "ArchStdEvent": "STALL_SLOT_FRONTEND",
>>> +        "PublicDescription": "Counts slots per cycle in which no operations are sent to the rename unit from the frontend due to frontend resource constraints."
>>> +    },
>>> +    {
>>> +        "ArchStdEvent": "STALL_SLOT",
>>> +        "PublicDescription": "Counts slots per cycle in which no operations are sent to the rename unit from the frontend or from the rename unit to the backend for any reason (either frontend or backend stall)."
>>> +    },
>>> +    {
>>> +        "ArchStdEvent": "STALL_BACKEND_MEM",
>>> +        "PublicDescription": "Counts cycles when the backend is stalled because there is a pending demand load request in progress in the last level core cache."
>>> +    }
>>> +]
>>> diff --git a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p3-v2/sve.json b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p3-v2/sve.json
>>> new file mode 100644
>>> index 000000000000..51dab48cb2ba
>>> --- /dev/null
>>> +++ b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p3-v2/sve.json
>>> @@ -0,0 +1,50 @@
>>> +[
>>> +    {
>>> +        "ArchStdEvent": "SVE_INST_SPEC",
>>> +        "PublicDescription": "Counts speculatively executed operations that are SVE operations."
>>> +    },
>>> +    {
>>> +        "ArchStdEvent": "SVE_PRED_SPEC",
>>> +        "PublicDescription": "Counts speculatively executed predicated SVE operations."
>>> +    },
>>> +    {
>>> +        "ArchStdEvent": "SVE_PRED_EMPTY_SPEC",
>>> +        "PublicDescription": "Counts speculatively executed predicated SVE operations with no active predicate elements."
>>> +    },
>>> +    {
>>> +        "ArchStdEvent": "SVE_PRED_FULL_SPEC",
>>> +        "PublicDescription": "Counts speculatively executed predicated SVE operations with all predicate elements active."
>>> +    },
>>> +    {
>>> +        "ArchStdEvent": "SVE_PRED_PARTIAL_SPEC",
>>> +        "PublicDescription": "Counts speculatively executed predicated SVE operations with at least one but not all active predicate elements."
>>> +    },
>>> +    {
>>> +        "ArchStdEvent": "SVE_PRED_NOT_FULL_SPEC",
>>> +        "PublicDescription": "Counts speculatively executed predicated SVE operations with at least one non active predicate elements."
>>> +    },
>>> +    {
>>> +        "ArchStdEvent": "SVE_LDFF_SPEC",
>>> +        "PublicDescription": "Counts speculatively executed SVE first fault or non-fault load operations."
>>> +    },
>>> +    {
>>> +        "ArchStdEvent": "SVE_LDFF_FAULT_SPEC",
>>> +        "PublicDescription": "Counts speculatively executed SVE first fault or non-fault load operations that clear at least one bit in the FFR."
>>> +    },
>>> +    {
>>> +        "ArchStdEvent": "ASE_SVE_INT8_SPEC",
>>> +        "PublicDescription": "Counts speculatively executed Advanced SIMD or SVE integer operations with the largest data type an 8-bit integer."
>>> +    },
>>> +    {
>>> +        "ArchStdEvent": "ASE_SVE_INT16_SPEC",
>>> +        "PublicDescription": "Counts speculatively executed Advanced SIMD or SVE integer operations with the largest data type a 16-bit integer."
>>> +    },
>>> +    {
>>> +        "ArchStdEvent": "ASE_SVE_INT32_SPEC",
>>> +        "PublicDescription": "Counts speculatively executed Advanced SIMD or SVE integer operations with the largest data type a 32-bit integer."
>>> +    },
>>> +    {
>>> +        "ArchStdEvent": "ASE_SVE_INT64_SPEC",
>>> +        "PublicDescription": "Counts speculatively executed Advanced SIMD or SVE integer operations with the largest data type a 64-bit integer."
>>> +    }
>>> +]
>>> diff --git a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p3-v2/tlb.json b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p3-v2/tlb.json
>>> new file mode 100644
>>> index 000000000000..b550af1831f5
>>> --- /dev/null
>>> +++ b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p3-v2/tlb.json
>>> @@ -0,0 +1,66 @@
>>> +[
>>> +    {
>>> +        "ArchStdEvent": "L1I_TLB_REFILL",
>>> +        "PublicDescription": "Counts level 1 instruction TLB refills from any Instruction fetch. If there are multiple misses in the TLB that are resolved by the refill, then this event only counts once. This event will not count if the translation table walk results in a fault (such as a translation or access fault), since there is no new translation created for the TLB."
>>> +    },
>>> +    {
>>> +        "ArchStdEvent": "L1D_TLB_REFILL",
>>> +        "PublicDescription": "Counts level 1 data TLB accesses that resulted in TLB refills. If there are multiple misses in the TLB that are resolved by the refill, then this event only counts once. This event counts for refills caused by preload instructions or hardware prefetch accesses. This event counts regardless of whether the miss hits in L2 or results in a translation table walk. This event will not count if the translation table walk results in a fault (such as a translation or access fault), since there is no new translation created for the TLB. This event will not count on an access from an AT(address translation) instruction."
>>> +    },
>>> +    {
>>> +        "ArchStdEvent": "L1D_TLB",
>>> +        "PublicDescription": "Counts level 1 data TLB accesses caused by any memory load or store operation. Note that load or store instructions can be broken up into multiple memory operations. This event does not count TLB maintenance operations."
>>> +    },
>>> +    {
>>> +        "ArchStdEvent": "L1I_TLB",
>>> +        "PublicDescription": "Counts level 1 instruction TLB accesses, whether the access hits or misses in the TLB. This event counts both demand accesses and prefetch or preload generated accesses."
>>> +    },
>>> +    {
>>> +        "ArchStdEvent": "L2D_TLB_REFILL",
>>> +        "PublicDescription": "Counts level 2 TLB refills caused by memory operations from both data and instruction fetch, except for those caused by TLB maintenance operations and hardware prefetches."
>>> +    },
>>> +    {
>>> +        "ArchStdEvent": "L2D_TLB",
>>> +        "PublicDescription": "Counts level 2 TLB accesses except those caused by TLB maintenance operations."
>>> +    },
>>> +    {
>>> +        "ArchStdEvent": "DTLB_WALK",
>>> +        "PublicDescription": "Counts data memory translation table walks caused by a miss in the L2 TLB driven by a memory access. Note that partial translations that also cause a table walk are counted. This event does not count table walks caused by TLB maintenance operations."
>>> +    },
>>> +    {
>>> +        "ArchStdEvent": "ITLB_WALK",
>>> +        "PublicDescription": "Counts instruction memory translation table walks caused by a miss in the L2 TLB driven by a memory access. Partial translations that also cause a table walk are counted. This event does not count table walks caused by TLB maintenance operations."
>>> +    },
>>> +    {
>>> +        "ArchStdEvent": "L1D_TLB_REFILL_RD",
>>> +        "PublicDescription": "Counts level 1 data TLB refills caused by memory read operations. If there are multiple misses in the TLB that are resolved by the refill, then this event only counts once. This event counts for refills caused by preload instructions or hardware prefetch accesses. This event counts regardless of whether the miss hits in L2 or results in a translation table walk. This event will not count if the translation table walk results in a fault (such as a translation or access fault), since there is no new translation created for the TLB. This event will not count on an access from an Address Translation (AT) instruction."
>>> +    },
>>> +    {
>>> +        "ArchStdEvent": "L1D_TLB_REFILL_WR",
>>> +        "PublicDescription": "Counts level 1 data TLB refills caused by data side memory write operations. If there are multiple misses in the TLB that are resolved by the refill, then this event only counts once. This event counts for refills caused by preload instructions or hardware prefetch accesses. This event counts regardless of whether the miss hits in L2 or results in a translation table walk. This event will not count if the table walk results in a fault (such as a translation or access fault), since there is no new translation created for the TLB. This event will not count with an access from an Address Translation (AT) instruction."
>>> +    },
>>> +    {
>>> +        "ArchStdEvent": "L1D_TLB_RD",
>>> +        "PublicDescription": "Counts level 1 data TLB accesses caused by memory read operations. This event counts whether the access hits or misses in the TLB. This event does not count TLB maintenance operations."
>>> +    },
>>> +    {
>>> +        "ArchStdEvent": "L1D_TLB_WR",
>>> +        "PublicDescription": "Counts any L1 data side TLB accesses caused by memory write operations. This event counts whether the access hits or misses in the TLB. This event does not count TLB maintenance operations."
>>> +    },
>>> +    {
>>> +        "ArchStdEvent": "L2D_TLB_REFILL_RD",
>>> +        "PublicDescription": "Counts level 2 TLB refills caused by memory read operations from both data and instruction fetch except for those caused by TLB maintenance operations or hardware prefetches."
>>> +    },
>>> +    {
>>> +        "ArchStdEvent": "L2D_TLB_REFILL_WR",
>>> +        "PublicDescription": "Counts level 2 TLB refills caused by memory write operations from both data and instruction fetch except for those caused by TLB maintenance operations."
>>> +    },
>>> +    {
>>> +        "ArchStdEvent": "L2D_TLB_RD",
>>> +        "PublicDescription": "Counts level 2 TLB accesses caused by memory read operations from both data and instruction fetch except for those caused by TLB maintenance operations."
>>> +    },
>>> +    {
>>> +        "ArchStdEvent": "L2D_TLB_WR",
>>> +        "PublicDescription": "Counts level 2 TLB accesses caused by memory write operations from both data and instruction fetch except for those caused by TLB maintenance operations."
>>> +    }
>>> +]
>>> diff --git a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p3-v2/trace.json b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p3-v2/trace.json
>>> new file mode 100644
>>> index 000000000000..98f6fabfebc7
>>> --- /dev/null
>>> +++ b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p3-v2/trace.json
>>> @@ -0,0 +1,38 @@
>>> +[
>>> +    {
>>> +        "ArchStdEvent": "TRB_WRAP",
>>> +        "PublicDescription": "This event is generated each time the current write pointer is wrapped to the base pointer."
>>> +    },
>>> +    {
>>> +        "ArchStdEvent": "TRCEXTOUT0",
>>> +        "PublicDescription": "This event is generated each time an event is signaled by ETE external event 0."
>>> +    },
>>> +    {
>>> +        "ArchStdEvent": "TRCEXTOUT1",
>>> +        "PublicDescription": "This event is generated each time an event is signaled by ETE external event 1."
>>> +    },
>>> +    {
>>> +        "ArchStdEvent": "TRCEXTOUT2",
>>> +        "PublicDescription": "This event is generated each time an event is signaled by ETE external event 2."
>>> +    },
>>> +    {
>>> +        "ArchStdEvent": "TRCEXTOUT3",
>>> +        "PublicDescription": "This event is generated each time an event is signaled by ETE external event 3."
>>> +    },
>>> +    {
>>> +        "ArchStdEvent": "CTI_TRIGOUT4",
>>> +        "PublicDescription": "This event is generated each time an event is signaled on CTI output trigger 4."
>>> +    },
>>> +    {
>>> +        "ArchStdEvent": "CTI_TRIGOUT5",
>>> +        "PublicDescription": "This event is generated each time an event is signaled on CTI output trigger 5."
>>> +    },
>>> +    {
>>> +        "ArchStdEvent": "CTI_TRIGOUT6",
>>> +        "PublicDescription": "This event is generated each time an event is signaled on CTI output trigger 6."
>>> +    },
>>> +    {
>>> +        "ArchStdEvent": "CTI_TRIGOUT7",
>>> +        "PublicDescription": "This event is generated each time an event is signaled on CTI output trigger 7."
>>> +    }
>>> +]
>>> diff --git a/tools/perf/pmu-events/arch/arm64/mapfile.csv b/tools/perf/pmu-events/arch/arm64/mapfile.csv
>>> index 3a90fe650863..b1259deb8800 100644
>>> --- a/tools/perf/pmu-events/arch/arm64/mapfile.csv
>>> +++ b/tools/perf/pmu-events/arch/arm64/mapfile.csv
>>> @@ -45,7 +45,8 @@
>>>  0x00000000410fd470,v1,arm/cortex-a710,core
>>>  0x00000000410fd480,v1,arm/cortex-x2,core
>>>  0x00000000410fd490,v1,arm/neoverse-n2-v2,core
>>> -0x00000000410fd4f0,v1,arm/neoverse-n2-v2,core
>>> +0x00000000410fd493,v1,arm/neoverse-n2r0p3-v2,core
>>> +0x00000000410fd4f0,v1,arm/neoverse-n2r0p3-v2,core
>>>  0x00000000420f5160,v1,cavium/thunderx2,core
>>>  0x00000000430f0af0,v1,cavium/thunderx2,core
>>>  0x00000000460f0010,v1,fujitsu/a64fx,core
>>> --
>>> 2.34.1
>>>
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
