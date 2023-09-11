Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4232B79A167
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 04:34:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231533AbjIKCeA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Sep 2023 22:34:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbjIKCd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Sep 2023 22:33:58 -0400
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D5511BF4;
        Sun, 10 Sep 2023 19:33:22 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=renyu.zj@linux.alibaba.com;NM=1;PH=DS;RN=20;SR=0;TI=SMTPD_---0VrjjD3D_1694399569;
Received: from 30.221.149.162(mailfrom:renyu.zj@linux.alibaba.com fp:SMTPD_---0VrjjD3D_1694399569)
          by smtp.aliyun-inc.com;
          Mon, 11 Sep 2023 10:32:51 +0800
Message-ID: <8bab7404-8e24-8606-558c-db3495429f2f@linux.alibaba.com>
Date:   Mon, 11 Sep 2023 10:32:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH v8 1/8] perf pmu: "Compat" supports matching multiple
 identifiers
To:     Ian Rogers <irogers@google.com>
Cc:     John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-doc@vger.kernel.org,
        Zhuo Song <zhuo.song@linux.alibaba.com>,
        Shuai Xue <xueshuai@linux.alibaba.com>
References: <1694087913-46144-1-git-send-email-renyu.zj@linux.alibaba.com>
 <1694087913-46144-2-git-send-email-renyu.zj@linux.alibaba.com>
 <CAP-5=fVWcQrqLeuc-k4HRNrNdb_=9CbqTSOAX=HDR7f=j8b0Hg@mail.gmail.com>
From:   Jing Zhang <renyu.zj@linux.alibaba.com>
In-Reply-To: <CAP-5=fVWcQrqLeuc-k4HRNrNdb_=9CbqTSOAX=HDR7f=j8b0Hg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-11.4 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/9/9 上午5:33, Ian Rogers 写道:
> On Thu, Sep 7, 2023 at 4:58 AM Jing Zhang <renyu.zj@linux.alibaba.com> wrote:
>>
>> The jevent "Compat" is used for uncore PMU alias or metric definitions.
>>
>> The same PMU driver has different PMU identifiers due to different
>> hardware versions and types, but they may have some common PMU event.
>> Since a Compat value can only match one identifier, when adding the
>> same event alias to PMUs with different identifiers, each identifier
>> needs to be defined once, which is not streamlined enough.
>>
>> So let "Compat" supports matching multiple identifiers for uncore PMU
>> alias. For example, the Compat value {43401;436*} can match the PMU
>> identifier "43401", that is, CMN600_r0p0, and the PMU identifier with
>> the prefix "436", that is, all CMN650, where "*" is a wildcard.
>> Tokens in Unit field are delimited by ';' with no spaces.
>>
>> Signed-off-by: Jing Zhang <renyu.zj@linux.alibaba.com>
>> Reviewed-by: John Garry <john.g.garry@oracle.com>
>> ---
>>  tools/perf/util/pmu.c | 28 ++++++++++++++++++++++++++--
>>  tools/perf/util/pmu.h |  1 +
>>  2 files changed, 27 insertions(+), 2 deletions(-)
>>
>> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
>> index e215985..c3c3818 100644
>> --- a/tools/perf/util/pmu.c
>> +++ b/tools/perf/util/pmu.c
>> @@ -875,6 +875,30 @@ static bool pmu_uncore_alias_match(const char *pmu_name, const char *name)
>>         return res;
>>  }
>>
>> +bool pmu_uncore_identifier_match(const char *id, const char *compat)
>> +{
>> +       char *tmp = NULL, *tok, *str;
>> +       bool res = false;
>> +
>> +       /*
>> +        * The strdup() call is necessary here because "compat" is a const str*
>> +        * type and cannot be used as an argument to strtok_r().
>> +        */
>> +       str = strdup(compat);
>> +       if (!str)
>> +               return false;
>> +
>> +       tok = strtok_r(str, ";", &tmp);
> 
> Did the comma vs semicolon difference get explained? It seems to add
> inconsistency to use a semicolon.
> 

Hi Ian,

Yes, I explained the reason for using semicolons instead of commas in v7.

I use a semicolon instead of a comma because I want to distinguish it from the function
of the comma in "Unit" and avoid confusion between the use of commas in "Unit" and "Compat".
Because in Unit, commas act as wildcards, and in “Compat”, the semicolon means “or”. So
I think semicolons are more appropriate.

John also raised this issue earlier, and we finally agreed to use semicolons.
What do you think?


Thanks,
Jing

> Thanks,
> Ian
> 
>> +       for (; tok; tok = strtok_r(NULL, ";", &tmp)) {
>> +               if (!fnmatch(tok, id, FNM_CASEFOLD)) {
>> +                       res = true;
>> +                       break;
>> +               }
>> +       }
>> +       free(str);
>> +       return res;
>> +}
>> +
>>  static int pmu_add_cpu_aliases_map_callback(const struct pmu_event *pe,
>>                                         const struct pmu_events_table *table __maybe_unused,
>>                                         void *vdata)
>> @@ -915,8 +939,8 @@ static int pmu_add_sys_aliases_iter_fn(const struct pmu_event *pe,
>>         if (!pe->compat || !pe->pmu)
>>                 return 0;
>>
>> -       if (!strcmp(pmu->id, pe->compat) &&
>> -           pmu_uncore_alias_match(pe->pmu, pmu->name)) {
>> +       if (pmu_uncore_alias_match(pe->pmu, pmu->name) &&
>> +                       pmu_uncore_identifier_match(pmu->id, pe->compat)) {
>>                 perf_pmu__new_alias(pmu,
>>                                 pe->name,
>>                                 pe->desc,
>> diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
>> index bd5d804..1bf5cf1 100644
>> --- a/tools/perf/util/pmu.h
>> +++ b/tools/perf/util/pmu.h
>> @@ -240,6 +240,7 @@ void pmu_add_cpu_aliases_table(struct perf_pmu *pmu,
>>  char *perf_pmu__getcpuid(struct perf_pmu *pmu);
>>  const struct pmu_events_table *pmu_events_table__find(void);
>>  const struct pmu_metrics_table *pmu_metrics_table__find(void);
>> +bool pmu_uncore_identifier_match(const char *id, const char *compat);
>>
>>  int perf_pmu__convert_scale(const char *scale, char **end, double *sval);
>>
>> --
>> 1.8.3.1
>>
