Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4240577DD13
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 11:15:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243244AbjHPJO7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 05:14:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243231AbjHPJOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 05:14:39 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0FCA7173F;
        Wed, 16 Aug 2023 02:14:38 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E4CC01063;
        Wed, 16 Aug 2023 02:15:18 -0700 (PDT)
Received: from [10.57.2.104] (unknown [10.57.2.104])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 952E63F64C;
        Wed, 16 Aug 2023 02:14:34 -0700 (PDT)
Message-ID: <fc71f840-8c4e-eeac-580b-5e0065a4cbee@arm.com>
Date:   Wed, 16 Aug 2023 10:14:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v5 3/6] perf test: Add a test for the new Arm CPU ID
 comparison behavior
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
        Nick Forrington <nick.forrington@arm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Sohom Datta <sohomdatta1@gmail.com>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org
References: <20230811144017.491628-1-james.clark@arm.com>
 <20230811144017.491628-4-james.clark@arm.com>
 <3c382d80-7666-8207-a534-0b20807d3f6c@oracle.com>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <3c382d80-7666-8207-a534-0b20807d3f6c@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 15/08/2023 10:47, John Garry wrote:
> On 11/08/2023 15:39, James Clark wrote:
>> Now that variant and revision fields are taken into account the behavior
>> is slightly more complicated so add a test to ensure that this behaves
>> as expected.
>>
>> Signed-off-by: James Clark <james.clark@arm.com>
>> ---
>>   tools/perf/arch/arm64/include/arch-tests.h |  3 ++
>>   tools/perf/arch/arm64/tests/Build          |  1 +
>>   tools/perf/arch/arm64/tests/arch-tests.c   |  4 +++
>>   tools/perf/arch/arm64/tests/cpuid-match.c  | 38 ++++++++++++++++++++++
>>   4 files changed, 46 insertions(+)
>>   create mode 100644 tools/perf/arch/arm64/tests/cpuid-match.c
>>
>> diff --git a/tools/perf/arch/arm64/include/arch-tests.h
>> b/tools/perf/arch/arm64/include/arch-tests.h
>> index 452b3d904521..474d7cf5afbd 100644
>> --- a/tools/perf/arch/arm64/include/arch-tests.h
>> +++ b/tools/perf/arch/arm64/include/arch-tests.h
>> @@ -2,6 +2,9 @@
>>   #ifndef ARCH_TESTS_H
>>   #define ARCH_TESTS_H
>>   +struct test_suite;
>> +
>> +int test__cpuid_match(struct test_suite *test, int subtest);
>>   extern struct test_suite *arch_tests[];
>>     #endif
>> diff --git a/tools/perf/arch/arm64/tests/Build
>> b/tools/perf/arch/arm64/tests/Build
>> index a61c06bdb757..e337c09e7f56 100644
>> --- a/tools/perf/arch/arm64/tests/Build
>> +++ b/tools/perf/arch/arm64/tests/Build
>> @@ -2,3 +2,4 @@ perf-y += regs_load.o
>>   perf-$(CONFIG_DWARF_UNWIND) += dwarf-unwind.o
>>     perf-y += arch-tests.o
>> +perf-y += cpuid-match.o
>> diff --git a/tools/perf/arch/arm64/tests/arch-tests.c
>> b/tools/perf/arch/arm64/tests/arch-tests.c
>> index ad16b4f8f63e..74932e72c727 100644
>> --- a/tools/perf/arch/arm64/tests/arch-tests.c
>> +++ b/tools/perf/arch/arm64/tests/arch-tests.c
>> @@ -3,9 +3,13 @@
>>   #include "tests/tests.h"
>>   #include "arch-tests.h"
>>   +
>> +DEFINE_SUITE("arm64 CPUID matching", cpuid_match);
>> +
>>   struct test_suite *arch_tests[] = {
>>   #ifdef HAVE_DWARF_UNWIND_SUPPORT
>>       &suite__dwarf_unwind,
>>   #endif
>> +    &suite__cpuid_match,
>>       NULL,
>>   };
>> diff --git a/tools/perf/arch/arm64/tests/cpuid-match.c
>> b/tools/perf/arch/arm64/tests/cpuid-match.c
>> new file mode 100644
>> index 000000000000..af0871b54ae7
>> --- /dev/null
>> +++ b/tools/perf/arch/arm64/tests/cpuid-match.c
>> @@ -0,0 +1,38 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +#include <linux/compiler.h>
>> +
>> +#include "arch-tests.h"
>> +#include "tests/tests.h"
>> +#include "util/header.h"
>> +
>> +int test__cpuid_match(struct test_suite *test __maybe_unused,
>> +                 int subtest __maybe_unused)
>> +{
>> +    /* midr with no leading zeros matches */
>> +    if (strcmp_cpuid_str("0x410fd0c0", "0x00000000410fd0c0"))
>> +        return -1;
>> +    /* Upper case matches */
>> +    if (strcmp_cpuid_str("0x410fd0c0", "0x00000000410FD0C0"))
>> +        return -1;
>> +    /* r0p0 = r0p0 matches */
>> +    if (strcmp_cpuid_str("0x00000000410fd480", "0x00000000410fd480"))
>> +        return -1;
>> +    /* r0p1 > r0p0 matches */
>> +    if (strcmp_cpuid_str("0x00000000410fd480", "0x00000000410fd481"))
>> +        return -1;
>> +    /* r1p0 > r0p0 matches*/
>> +    if (strcmp_cpuid_str("0x00000000410fd480", "0x00000000411fd480"))
>> +        return -1;
>> +    /* r0p0 < r0p1 doesn't match */
>> +    if (!strcmp_cpuid_str("0x00000000410fd481", "0x00000000410fd480"))
>> +        return -1;
>> +    /* r0p0 < r1p0 doesn't match */
>> +    if (!strcmp_cpuid_str("0x00000000411fd480", "0x00000000410fd480"))
>> +        return -1;
>> +    /* Different CPU doesn't match */
>> +    if (!strcmp_cpuid_str("0x00000000410fd4c0", "0x00000000430f0af0"))
>> +        return -1;
>> +
>> +    return 0;
>> +}
>> +
> 
> Would it be possible to put this in core test code, since x86 also
> supports strcmp_cpuid_str()?
> 

That's how I started, but Ian suggested to move it to an arch specific
folder because that's what it was testing.

We could still add test__cpuid_match() in the x86 folder rather than
adding it with #ifdefs, but I don't think it needs to be done here
because I haven't touched the x86 code.

> Maybe we would have an structure per arch of cpuids and expected
> results, like
> 
> struct cpuid_match {
>     char *cpuid1;
>     char *cpuid1;
>     int expected_result;
> };
> 
> 
> #ifdef ARM64
>  cpuid_match_array[] = {
>     {"0x410fd0c0", "0x00000000410FD0C0", -1},
>     {"0x00000000410fd480", "0x00000000410fd480", -1},
>     ...
>     {} /* sentinel */
> 
> };
> #else if defined(X86)
>  cpuid_match_array[] = {
>     {....}
>     ...
>     {} /* sentinel */
> 
> };
> #else
> /* no support */
> #endif
> 
> Thanks,
> John
