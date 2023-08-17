Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 964C477F2A8
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 11:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349216AbjHQJCs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 05:02:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232046AbjHQJCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 05:02:18 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 03A6AE7C;
        Thu, 17 Aug 2023 02:02:12 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 484CDD75;
        Thu, 17 Aug 2023 02:02:53 -0700 (PDT)
Received: from [10.57.3.248] (unknown [10.57.3.248])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 602CF3F64C;
        Thu, 17 Aug 2023 02:02:09 -0700 (PDT)
Message-ID: <fecfd732-df85-1bb9-f3d2-c1e12ca2db2e@arm.com>
Date:   Thu, 17 Aug 2023 10:02:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v6 2/6] perf test: Add a test for the new Arm CPU ID
 comparison behavior
Content-Language: en-US
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     linux-perf-users@vger.kernel.org, irogers@google.com,
        john.g.garry@oracle.com, renyu.zj@linux.alibaba.com,
        Will Deacon <will@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Haixin Yu <yuhaixin.yhx@linux.alibaba.com>,
        Nick Forrington <nick.forrington@arm.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Sohom Datta <sohomdatta1@gmail.com>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230816114841.1679234-1-james.clark@arm.com>
 <20230816114841.1679234-3-james.clark@arm.com> <ZNz1KNaNhct35bzd@kernel.org>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <ZNz1KNaNhct35bzd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 16/08/2023 17:11, Arnaldo Carvalho de Melo wrote:
> Em Wed, Aug 16, 2023 at 12:47:44PM +0100, James Clark escreveu:
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
>> +			     int subtest __maybe_unused)
>> +{
>> +	/* midr with no leading zeros matches */
>> +	if (strcmp_cpuid_str("0x410fd0c0", "0x00000000410fd0c0"))
>> +		return -1;
>> +	/* Upper case matches */
>> +	if (strcmp_cpuid_str("0x410fd0c0", "0x00000000410FD0C0"))
>> +		return -1;
>> +	/* r0p0 = r0p0 matches */
>> +	if (strcmp_cpuid_str("0x00000000410fd480", "0x00000000410fd480"))
>> +		return -1;
>> +	/* r0p1 > r0p0 matches */
>> +	if (strcmp_cpuid_str("0x00000000410fd480", "0x00000000410fd481"))
>> +		return -1;
>> +	/* r1p0 > r0p0 matches*/
>> +	if (strcmp_cpuid_str("0x00000000410fd480", "0x00000000411fd480"))
>> +		return -1;
>> +	/* r0p0 < r0p1 doesn't match */
>> +	if (!strcmp_cpuid_str("0x00000000410fd481", "0x00000000410fd480"))
>> +		return -1;
>> +	/* r0p0 < r1p0 doesn't match */
>> +	if (!strcmp_cpuid_str("0x00000000411fd480", "0x00000000410fd480"))
>> +		return -1;
>> +	/* Different CPU doesn't match */
>> +	if (!strcmp_cpuid_str("0x00000000410fd4c0", "0x00000000430f0af0"))
>> +		return -1;
>> +
>> +	return 0;
>> +}
>> +
>> -- 
>> 2.34.1
>>
> ⬢[acme@toolbox perf-tools-next]$        git am ./v6_20230816_james_clark_perf_vendor_events_arm64_update_n2_and_v2_metrics_and_events_using_arm_telem.mbx
> Applying: perf test: Add a test for the new Arm CPU ID comparison behavior
> .git/rebase-apply/patch:93: new blank line at EOF.
> +
> warning: 1 line adds whitespace errors.
> ⬢[acme@toolbox perf-tools-next]$
> 
> I'm removing it

Interesting that checkpatch.pl doesn't see that. Thanks for the fix.

