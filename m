Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66EC977DD1D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 11:17:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243224AbjHPJQe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 05:16:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243333AbjHPJQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 05:16:25 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0C91326AE;
        Wed, 16 Aug 2023 02:16:20 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E6EC11FB;
        Wed, 16 Aug 2023 02:17:00 -0700 (PDT)
Received: from [10.57.2.104] (unknown [10.57.2.104])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 87ABE3F64C;
        Wed, 16 Aug 2023 02:16:16 -0700 (PDT)
Message-ID: <02706043-3c81-324d-60a6-ce71a20dfe31@arm.com>
Date:   Wed, 16 Aug 2023 10:16:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v5 5/6] perf vendor events arm64: Update stall_slot
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
        Kan Liang <kan.liang@linux.intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Nick Forrington <nick.forrington@arm.com>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Sohom Datta <sohomdatta1@gmail.com>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org
References: <20230811144017.491628-1-james.clark@arm.com>
 <20230811144017.491628-6-james.clark@arm.com>
 <18140960-e8bd-a331-8322-db7254c43bdf@oracle.com>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <18140960-e8bd-a331-8322-db7254c43bdf@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 15/08/2023 10:40, John Garry wrote:
> On 11/08/2023 15:39, James Clark wrote:
>> N2 r0p3 doesn't require the workaround [1], so gating on (#slots - 5) no
>> longer works because all N2s have 5 slots. Add a new expression builtin
>> that allows calling strcmp_cpuid_str() and comparing CPUIDs in metric
>> formulas.
>>
>> In this case, the commented formula looks like this:
>>
>>    strcmp_cpuid_str(0x410fd493)        # greater than or equal to N2 r0p3
>>    | strcmp_cpuid_str(0x410fd490) ^ 1  # OR NOT any version of N2
>>
>> [1]:https://urldefense.com/v3/__https://gitlab.arm.com/telemetry-solution/telemetry-solution/-/blob/main/data/pmu/cpu/neoverse/neoverse-n2-r0p3.json__;!!ACWV5N9M2RV99hQ!MaXDALyhn3HmfLdPUZRKTItKxg73C-qP4aTNAAdFwzjW5cFEBTHtD-VyqBzUTFbXMvABB-daDD01AfI7um_BtA$  Signed-off-by: James Clark<james.clark@arm.com>
>> ---
>>   tools/perf/arch/arm64/util/pmu.c               | 18 +-----------------
>>   .../arch/arm64/arm/neoverse-n2-v2/metrics.json |  8 ++++----
>>   tools/perf/pmu-events/metric.py                | 17 +++++++++++++++--
>>   tools/perf/util/expr.c                         | 18 ++++++++++++++++++
>>   tools/perf/util/expr.h                         |  1 +
>>   tools/perf/util/expr.l                         |  1 +
>>   tools/perf/util/expr.y                         |  8 +++++++-
>>   tools/perf/util/pmu.c                          | 17 +++++++++++++++++
>>   tools/perf/util/pmu.h                          |  1 +
>>   9 files changed, 65 insertions(+), 24 deletions(-)
> 
> This patch looks ok, but I think that it would be better to separate out
> the metrics.json change into a separate patch.
> 
Yep I thought about doing that, I can change it in the next version.

> Thanks,
> John
