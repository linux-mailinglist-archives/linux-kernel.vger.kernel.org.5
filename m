Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5A3D776031
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 15:06:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232339AbjHINGj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 09:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232192AbjHINGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 09:06:36 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C54C71FF9;
        Wed,  9 Aug 2023 06:06:35 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B4B7ED75;
        Wed,  9 Aug 2023 06:07:17 -0700 (PDT)
Received: from [10.57.1.30] (unknown [10.57.1.30])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EED1A3F6C4;
        Wed,  9 Aug 2023 06:06:31 -0700 (PDT)
Message-ID: <a4b93320-cf5d-9622-77fe-f51e1ec7f75b@arm.com>
Date:   Wed, 9 Aug 2023 14:06:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v4 5/6] perf vendor events arm64: Update stall_slot
 workaround for N2 r0p3
Content-Language: en-US
To:     John Garry <john.g.garry@oracle.com>,
        linux-perf-users@vger.kernel.org, irogers@google.com,
        renyu.zj@linux.alibaba.com
Cc:     Will Deacon <will@kernel.org>, Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Nick Forrington <nick.forrington@arm.com>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org
References: <20230807142138.288713-1-james.clark@arm.com>
 <20230807142138.288713-6-james.clark@arm.com>
 <6b3d8f28-9a38-d544-e396-706022f2e5f5@oracle.com>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <6b3d8f28-9a38-d544-e396-706022f2e5f5@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/08/2023 11:18, John Garry wrote:
> On 07/08/2023 15:20, James Clark wrote:
> 
> Hi James,
> 
> Thanks for the effort in doing this.
> 
>> N2 r0p3 doesn't require the workaround [1], so gating on (#slots - 5) no
>> longer works because all N2s have 5 slots. Add a new expression builtin
>> that identifies the need for the workaround correctly.
>>
>> [1]:
>> https://urldefense.com/v3/__https://gitlab.arm.com/telemetry-solution/telemetry-solution/-/blob/main/data/pmu/cpu/neoverse/neoverse-n2-r0p3.json__;!!ACWV5N9M2RV99hQ!Nx1xgWXXS9GBasNpOKQXHWKe8VwpRB0h8lAfOmwUmkkOQTjFqn2NswO8ti8vTcblUfAYN9NAtxqAh-sf0TEOvQ$
>> Signed-off-by: James Clark <james.clark@arm.com>
>> ---
>>   tools/perf/arch/arm64/util/pmu.c              | 21 +++++++++++++++++++
>>   .../arm64/arm/neoverse-n2-v2/metrics.json     |  8 +++----
>>   tools/perf/util/expr.c                        |  4 ++++
>>   tools/perf/util/pmu.c                         |  6 ++++++
>>   tools/perf/util/pmu.h                         |  1 +
>>   5 files changed, 36 insertions(+), 4 deletions(-)
>>
>> diff --git a/tools/perf/arch/arm64/util/pmu.c
>> b/tools/perf/arch/arm64/util/pmu.c
>> index 561de0cb6b95..30e2385a83cf 100644
>> --- a/tools/perf/arch/arm64/util/pmu.c
>> +++ b/tools/perf/arch/arm64/util/pmu.c
>> @@ -2,6 +2,7 @@
>>     #include <internal/cpumap.h>
>>   #include "../../../util/cpumap.h"
>> +#include "../../../util/header.h"
>>   #include "../../../util/pmu.h"
>>   #include "../../../util/pmus.h"
>>   #include <api/fs/fs.h>
>> @@ -62,3 +63,23 @@ double perf_pmu__cpu_slots_per_cycle(void)
>>         return slots ? (double)slots : NAN;
>>   }
>> +
>> +double perf_pmu__no_stall_errata(void)
> 
> While I like the approach of encoding the per-CPU support in the metric
> expression, I find that literal "no stall errata" is vague and could
> apply to any "stall errata" for any SoC for any architecture.
> 
> If we were going to do it this way, then we would need a more specific
> name, like perf_pmu__no_stall_errata_arm64_errata123456(), but that
> should not be in the core perf code.
> 
> Could we instead add a function to check cpuid and have something like
> this in the JSON:
> 
> "MetricExpr": "(op_retired / op_spec) * (1 - (stall_slot if
> (cpuid_less_than(410fd493)) else (stall_slot - cpu_cycles)) / (#slots *
> cpu_cycles))"
> 
> I'm currently figuring out how cpuid_less_than() would be implemented
> (I'm no great python wrangler), but it would be along the lines of what
> Ian added for "has_event" in
> https://lore.kernel.org/linux-perf-users/20230623151016.4193660-1-irogers@google.com/
> 
> Thanks,
> John

Yeah it looks like it could be done that way. Also, the way I added it,
it doesn't have access to the PMU type, it just does a generic
pmu__find_core_pmu() so won't work very well for heterogeneous systems.

If we're going to do a deeper modification of the expression parser like
with has_event() it might be possible to pass in the actual CPU ID that
the metric is running on which would be better.

I'll have a look.

James

