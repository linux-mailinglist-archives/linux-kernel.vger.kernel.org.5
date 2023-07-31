Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C197A7693FD
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 13:00:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbjGaLAI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 07:00:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232062AbjGaK7x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 06:59:53 -0400
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45B15E6C;
        Mon, 31 Jul 2023 03:59:36 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=renyu.zj@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0VoeDj8W_1690801171;
Received: from 30.221.150.94(mailfrom:renyu.zj@linux.alibaba.com fp:SMTPD_---0VoeDj8W_1690801171)
          by smtp.aliyun-inc.com;
          Mon, 31 Jul 2023 18:59:32 +0800
Message-ID: <0801b73c-6649-8c54-8dca-276efc2a4967@linux.alibaba.com>
Date:   Mon, 31 Jul 2023 18:59:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH v5 1/5] perf metric: Event "Compat" value supports
 matching multiple identifiers
To:     John Garry <john.g.garry@oracle.com>
Cc:     Ian Rogers <irogers@google.com>, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Ilkka Koskinen <ilkka@os.amperecomputing.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-doc@vger.kernel.org,
        Zhuo Song <zhuo.song@linux.alibaba.com>,
        Shuai Xue <xueshuai@linux.alibaba.com>
References: <1690525040-77423-1-git-send-email-renyu.zj@linux.alibaba.com>
 <1690525040-77423-2-git-send-email-renyu.zj@linux.alibaba.com>
 <268b3891-be4b-5f63-eff3-7b6d83e906e9@oracle.com>
From:   Jing Zhang <renyu.zj@linux.alibaba.com>
In-Reply-To: <268b3891-be4b-5f63-eff3-7b6d83e906e9@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2023/7/28 下午4:11, John Garry 写道:
> On 28/07/2023 07:17, Jing Zhang wrote:
>> The jevent "Compat" is used for uncore PMU alias or metric definitions.
>>
>> The same PMU driver has different PMU identifiers due to different hardware
>> versions and types, but they may have some common PMU event/metric. Since a
>> Compat value can only match one identifier, when adding the same event
>> alias and metric to PMUs with different identifiers, each identifier needs
>> to be defined once, which is not streamlined enough.
>>
>> So let "Compat" value supports matching multiple identifiers. For example,
>> the Compat value {abcde;123*}
> why not use a comma-separated list? that is more common
> 

Hi John,

I use a semicolon instead of a comma because I want to distinguish it from the function
of the comma in "Unit" and avoid confusion between the use of commas in "Unit" and "Compat".
Because in “Compat”, the semicolon means "or". So I think semicolons are more appropriate,
what do you think?

>> can match the PMU identifier "abcde" and the
>> the PMU identifier with the prefix "123",
> 
> I have to admit that this is not a great example as it does not match an expected real-life scenario. I mean, I would not expect a PMU identifier for the same PMU to be in either format "abcde" or "123*". I would expect to be in only ever one format.
> 

Get, I'll pick a more appropriate example {43401;436*}(CMN600 r0p0 and all CMN650).

>> where "*" is a wildcard.
>> Tokens in Unit field are delimited by ';' with no spaces.
>>
>> Signed-off-by: Jing Zhang <renyu.zj@linux.alibaba.com>
>> ---
>>   tools/perf/util/metricgroup.c |  2 +-
>>   tools/perf/util/pmu.c         | 27 ++++++++++++++++++++++++++-
>>   tools/perf/util/pmu.h         |  1 +
>>   3 files changed, 28 insertions(+), 2 deletions(-)
>>
>> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
>> index 5e9c657..ff81bc5 100644
>> --- a/tools/perf/util/metricgroup.c
>> +++ b/tools/perf/util/metricgroup.c
>> @@ -477,7 +477,7 @@ static int metricgroup__sys_event_iter(const struct pmu_metric *pm,
>>         while ((pmu = perf_pmu__scan(pmu))) {
>>   -        if (!pmu->id || strcmp(pmu->id, pm->compat))
>> +        if (!pmu->id || !pmu_uncore_identifier_match(pmu->id, pm->compat))
>>               continue;
>>             return d->fn(pm, table, d->data);
>> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
>> index ad209c8..3ae249b 100644
>> --- a/tools/perf/util/pmu.c
>> +++ b/tools/perf/util/pmu.c
>> @@ -776,6 +776,31 @@ static bool pmu_uncore_alias_match(const char *pmu_name, const char *name)
>>       return res;
>>   }
>>   +bool pmu_uncore_identifier_match(const char *id, const char *compat)
>> +{
>> +    char *tmp = NULL, *tok, *str;
>> +    bool res;
>> +    int n;
>> +
>> +    str = strdup(compat);
> 
> why duplicate this? are you modifying something?
> 

This is really a redundant step, I will remove it.

>> +    if (!str)
>> +        return false;
>> +
>> +    tok = strtok_r(str, ";", &tmp);
>> +    for (; tok; tok = strtok_r(NULL, ";", &tmp)) {
>> +        n = strlen(tok);
>> +        if ((tok[n - 1] == '*' && !strncmp(id, tok, n - 1)) ||
>> +            !strcmp(id, tok)) {
>> +            res = true;
>> +            goto out;
>> +        }
>> +    }
>> +    res = false;
>> +out:
>> +    free(str);
>> +    return res;
>> +}
>> +
>>   struct pmu_add_cpu_aliases_map_data {
>>       struct list_head *head;
>>       const char *name;
>> @@ -847,7 +872,7 @@ static int pmu_add_sys_aliases_iter_fn(const struct pmu_event *pe,
> 
> This is not for metrics specifically. You are really doing 2x things here. I suggest that you split the patch out into 1st pmu.c change and 2nd metricgroup.c change
> 

Ok, will do.

>>       if (!pe->compat || !pe->pmu)
>>           return 0;
>>   -    if (!strcmp(pmu->id, pe->compat) &&
>> +    if (pmu_uncore_identifier_match(pmu->id, pe->compat) &&
>>           pmu_uncore_alias_match(pe->pmu, pmu->name)) {
> 
> nit: let's change order to check alias and then identifier
> 

Will do.


Thanks,
Jing

>>           __perf_pmu__new_alias(idata->head, -1,
>>                         (char *)pe->name,
>> diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
>> index b9a02de..9d4385d 100644
>> --- a/tools/perf/util/pmu.h
>> +++ b/tools/perf/util/pmu.h
>> @@ -241,6 +241,7 @@ void pmu_add_cpu_aliases_table(struct list_head *head, struct perf_pmu *pmu,
>>   char *perf_pmu__getcpuid(struct perf_pmu *pmu);
>>   const struct pmu_events_table *pmu_events_table__find(void);
>>   const struct pmu_metrics_table *pmu_metrics_table__find(void);
>> +bool pmu_uncore_identifier_match(const char *id, const char *compat);
>>   void perf_pmu_free_alias(struct perf_pmu_alias *alias);
>>     int perf_pmu__convert_scale(const char *scale, char **end, double *sval);
> 
> Thanks,
> John
