Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FE3377BA70
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 15:44:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231608AbjHNNoY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 09:44:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231845AbjHNNoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 09:44:21 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 03830171D;
        Mon, 14 Aug 2023 06:44:10 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ED16F1063;
        Mon, 14 Aug 2023 06:44:51 -0700 (PDT)
Received: from [10.57.3.178] (unknown [10.57.3.178])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 925953F64C;
        Mon, 14 Aug 2023 06:44:06 -0700 (PDT)
Message-ID: <db7d5375-b5b1-1fff-d612-73873ef2765c@arm.com>
Date:   Mon, 14 Aug 2023 14:44:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v5 5/6] perf vendor events arm64: Update stall_slot
 workaround for N2 r0p3
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
 <8a4ebdbc-c2c9-9f61-329f-8fd235f5f65c@oracle.com>
Content-Language: en-US
From:   James Clark <james.clark@arm.com>
In-Reply-To: <8a4ebdbc-c2c9-9f61-329f-8fd235f5f65c@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 14/08/2023 14:02, John Garry wrote:
> 
>>     try:
>>       parsed = ast.parse(py, mode='eval')
>>     except SyntaxError as e:
>> diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
>> index 7410a165f68b..0985a3cbc6f9 100644
>> --- a/tools/perf/util/expr.c
>> +++ b/tools/perf/util/expr.c
>> @@ -13,6 +13,8 @@
>>   #include <util/expr-bison.h>
>>   #include <util/expr-flex.h>
>>   #include "util/hashmap.h"
>> +#include "util/header.h"
>> +#include "util/pmu.h"
>>   #include "smt.h"
>>   #include "tsc.h"
>>   #include <api/fs/fs.h>
>> @@ -495,3 +497,19 @@ double expr__has_event(const struct
>> expr_parse_ctx *ctx, bool compute_ids, const
>>       evlist__delete(tmp);
>>       return ret;
>>   }
>> +
>> +double expr__strcmp_cpuid_str(const struct expr_parse_ctx *ctx
>> __maybe_unused,
>> +               bool compute_ids __maybe_unused, const char *test_id)
>> +{
>> +    double ret;
>> +    struct perf_pmu *pmu = pmu__find_core_pmu();
>> +    char *cpuid = perf_pmu__getcpuid(pmu);
>> +
>> +    if (!cpuid)
>> +        return NAN;
>> +
>> +    ret = !strcmp_cpuid_str(test_id, cpuid);
> 
> It seems that strcmp_cpuid_str() is only added in arm64 arch code -
> should there be a weak version for other archs?

I think there is one in tools/perf/util/header.c. I tested the build on
x86 as well as arm so it should be working.

> 
>> +
>> +    free(cpuid);
>> +    return ret;
>> +}
>> diff --git a/tools/perf/util/expr.h b/tools/perf/util/expr.h
>> index 3c1e49b3e35d..c0cec29ddc29 100644
>> --- a/tools/perf/util/expr.h
>> +++ b/tools/perf/util/expr.h
>> @@ -55,5 +55,6 @@ double expr_id_data__value(const struct expr_id_data
>> *data);
>>   double expr_id_data__source_count(const struct expr_id_data *data);
>>   double expr__get_literal(const char *literal, const struct
>> expr_scanner_ctx *ctx);
>>   double expr__has_event(const struct expr_parse_ctx *ctx, bool
>> compute_ids, const char *id);
>> +double expr__strcmp_cpuid_str(const struct expr_parse_ctx *ctx, bool
>> compute_ids, const char *id);
>>     #endif
>> diff --git a/tools/perf/util/expr.l b/tools/perf/util/expr.l
>> index dbb117414710..0feef0726c48 100644
>> --- a/tools/perf/util/expr.l
>> +++ b/tools/perf/util/expr.l
>> @@ -114,6 +114,7 @@ if        { return IF; }
>>   else        { return ELSE; }
>>   source_count    { return SOURCE_COUNT; }
>>   has_event    { return HAS_EVENT; }
>> +strcmp_cpuid_str    { return STRCMP_CPUID_STR; }
>>   {literal}    { return literal(yyscanner, sctx); }
>>   {number}    { return value(yyscanner); }
>>   {symbol}    { return str(yyscanner, ID, sctx->runtime); }
>> diff --git a/tools/perf/util/expr.y b/tools/perf/util/expr.y
>> index 65d54a6f29ad..6c93b358cc2d 100644
>> --- a/tools/perf/util/expr.y
>> +++ b/tools/perf/util/expr.y
>> @@ -39,7 +39,7 @@ int expr_lex(YYSTYPE * yylval_param , void *yyscanner);
>>       } ids;
>>   }
>>   -%token ID NUMBER MIN MAX IF ELSE LITERAL D_RATIO SOURCE_COUNT
>> HAS_EVENT EXPR_ERROR
>> +%token ID NUMBER MIN MAX IF ELSE LITERAL D_RATIO SOURCE_COUNT
>> HAS_EVENT STRCMP_CPUID_STR EXPR_ERROR
>>   %left MIN MAX IF
>>   %left '|'
>>   %left '^'
>> @@ -207,6 +207,12 @@ expr: NUMBER
>>       $$.ids = NULL;
>>       free($3);
>>   }
>> +| STRCMP_CPUID_STR '(' ID ')'
>> +{
>> +    $$.val = expr__strcmp_cpuid_str(ctx, compute_ids, $3);
>> +    $$.ids = NULL;
>> +    free($3);
>> +}
>>   | expr '|' expr
>>   {
>>       if (is_const($1.val) && is_const($3.val)) {
>> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
>> index b6654b9f55d2..b6948021fe29 100644
>> --- a/tools/perf/util/pmu.c
>> +++ b/tools/perf/util/pmu.c
>> @@ -1779,3 +1779,20 @@ void perf_pmu__delete(struct perf_pmu *pmu)
>>       zfree(&pmu->alias_name);
>>       free(pmu);
>>   }
>> +
>> +struct perf_pmu *pmu__find_core_pmu(void)
> 
> Why was this relocated? I don't see anywhere changed which referenced
> pmu__find_core_pmu() in this patch
> 

It's in expr__strcmp_cpuid_str(), I added a new call to it.

>> +{
>> +    struct perf_pmu *pmu = NULL;
>> +
>> +    while ((pmu = perf_pmus__scan_core(pmu))) {
>> +        /*
>> +         * The cpumap should cover all CPUs. Otherwise, some CPUs may
>> +         * not support some events or have different event IDs.
>> +         */
>> +        if (RC_CHK_ACCESS(pmu->cpus)->nr != cpu__max_cpu().cpu)
>> +            return NULL;
>> +
>> +        return pmu;
>> +    }
>> +    return NULL;
>> +}
>> diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
>> index 203b92860e3c..580b8d65bd65 100644
>> --- a/tools/perf/util/pmu.h
>> +++ b/tools/perf/util/pmu.h
>> @@ -288,5 +288,6 @@ int perf_pmu__pathname_fd(int dirfd, const char
>> *pmu_name, const char *filename,
>>   struct perf_pmu *perf_pmu__lookup(struct list_head *pmus, int dirfd,
>> const char *lookup_name);
>>   struct perf_pmu *perf_pmu__create_placeholder_core_pmu(struct
>> list_head *core_pmus);
>>   void perf_pmu__delete(struct perf_pmu *pmu);
>> +struct perf_pmu *pmu__find_core_pmu(void);
>>     #endif /* __PMU_H */
> 
