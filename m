Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0F1977CCC0
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 14:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237225AbjHOMeQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 08:34:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237277AbjHOMdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 08:33:52 -0400
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F5D91BF6;
        Tue, 15 Aug 2023 05:33:44 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R371e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=renyu.zj@linux.alibaba.com;NM=1;PH=DS;RN=20;SR=0;TI=SMTPD_---0Vps0sJO_1692102816;
Received: from 30.221.150.39(mailfrom:renyu.zj@linux.alibaba.com fp:SMTPD_---0Vps0sJO_1692102816)
          by smtp.aliyun-inc.com;
          Tue, 15 Aug 2023 20:33:38 +0800
Message-ID: <30f6e625-cd3e-f846-e04d-667404f9f3c5@linux.alibaba.com>
Date:   Tue, 15 Aug 2023 20:33:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v6 5/7] perf test: Add pmu-event test for "Compat" and new
 event_field.
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
References: <1691394685-61240-1-git-send-email-renyu.zj@linux.alibaba.com>
 <1691394685-61240-6-git-send-email-renyu.zj@linux.alibaba.com>
 <CAP-5=fXPhtPCGYotDi2P_LeFPBMd8N+z_WAPwUT8eR+QiLLTMg@mail.gmail.com>
From:   Jing Zhang <renyu.zj@linux.alibaba.com>
In-Reply-To: <CAP-5=fXPhtPCGYotDi2P_LeFPBMd8N+z_WAPwUT8eR+QiLLTMg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/8/15 上午9:11, Ian Rogers 写道:
> On Mon, Aug 7, 2023 at 12:51 AM Jing Zhang <renyu.zj@linux.alibaba.com> wrote:
>>
>> Add new event test for uncore system event which is used to verify the
>> functionality of "Compat" matching multiple identifiers and the new event
>> fields "EventIdCode" and "Type".
>>
>> Signed-off-by: Jing Zhang <renyu.zj@linux.alibaba.com>
> 
> Did you test with NO_JEVENTS=1?
> 

You are absolutely right. I completely overlooked the case where NO_JEVENTS=1.


>> ---
>>  .../pmu-events/arch/test/test_soc/sys/uncore.json  |  8 ++++
>>  tools/perf/tests/pmu-events.c                      | 55 ++++++++++++++++++++++
>>  2 files changed, 63 insertions(+)
>>
>> diff --git a/tools/perf/pmu-events/arch/test/test_soc/sys/uncore.json b/tools/perf/pmu-events/arch/test/test_soc/sys/uncore.json
>> index c7e7528..19ec595 100644
>> --- a/tools/perf/pmu-events/arch/test/test_soc/sys/uncore.json
>> +++ b/tools/perf/pmu-events/arch/test/test_soc/sys/uncore.json
>> @@ -12,5 +12,13 @@
>>             "EventName": "sys_ccn_pmu.read_cycles",
>>             "Unit": "sys_ccn_pmu",
>>             "Compat": "0x01"
>> +   },
>> +   {
>> +           "BriefDescription": "Counts total cache misses in first lookup result (high priority).",
>> +           "Type": "0x05",
>> +           "EventIdCode": "0x01",
>> +           "EventName": "sys_cmn_pmu.hnf_cache_miss",
>> +           "Unit": "sys_cmn_pmu",
>> +           "Compat": "434*;436*;43c*;43a01"
> 
> I suspect this needs adding here:
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/pmu-events/empty-pmu-events.c?h=perf-tools-next#n247
> 
After adding the relevant code in empty-pmu-events.c, it can successfully test with NO_JEVENTS=1.

Thanks,
Jing

> Thanks,
> Ian
> 
>>     }
>>  ]
>> diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
>> index 3204252..79fb3e2 100644
>> --- a/tools/perf/tests/pmu-events.c
>> +++ b/tools/perf/tests/pmu-events.c
>> @@ -255,9 +255,24 @@ struct perf_pmu_test_pmu {
>>         .matching_pmu = "uncore_sys_ccn_pmu4",
>>  };
>>
>> +static const struct perf_pmu_test_event sys_cmn_pmu_hnf_cache_miss = {
>> +       .event = {
>> +               .name = "sys_cmn_pmu.hnf_cache_miss",
>> +               .event = "type=0x05,eventid=0x01",
>> +               .desc = "Counts total cache misses in first lookup result (high priority). Unit: uncore_sys_cmn_pmu ",
>> +               .topic = "uncore",
>> +               .pmu = "uncore_sys_cmn_pmu",
>> +               .compat = "434*;436*;43c*;43a01",
>> +       },
>> +       .alias_str = "type=0x5,eventid=0x1",
>> +       .alias_long_desc = "Counts total cache misses in first lookup result (high priority). Unit: uncore_sys_cmn_pmu ",
>> +       .matching_pmu = "uncore_sys_cmn_pmu0",
>> +};
>> +
>>  static const struct perf_pmu_test_event *sys_events[] = {
>>         &sys_ddr_pmu_write_cycles,
>>         &sys_ccn_pmu_read_cycles,
>> +       &sys_cmn_pmu_hnf_cache_miss,
>>         NULL
>>  };
>>
>> @@ -704,6 +719,46 @@ static int __test_uncore_pmu_event_aliases(struct perf_pmu_test_pmu *test_pmu)
>>                         &sys_ccn_pmu_read_cycles,
>>                 },
>>         },
>> +       {
>> +               .pmu = {
>> +                       .name = (char *)"uncore_sys_cmn_pmu0",
>> +                       .is_uncore = 1,
>> +                       .id = (char *)"43401",
>> +               },
>> +               .aliases = {
>> +                       &sys_cmn_pmu_hnf_cache_miss,
>> +               },
>> +       },
>> +       {
>> +               .pmu = {
>> +                       .name = (char *)"uncore_sys_cmn_pmu0",
>> +                       .is_uncore = 1,
>> +                       .id = (char *)"43602",
>> +               },
>> +               .aliases = {
>> +                       &sys_cmn_pmu_hnf_cache_miss,
>> +               },
>> +       },
>> +       {
>> +               .pmu = {
>> +                       .name = (char *)"uncore_sys_cmn_pmu0",
>> +                       .is_uncore = 1,
>> +                       .id = (char *)"43c03",
>> +               },
>> +               .aliases = {
>> +                       &sys_cmn_pmu_hnf_cache_miss,
>> +               },
>> +       },
>> +       {
>> +               .pmu = {
>> +                       .name = (char *)"uncore_sys_cmn_pmu0",
>> +                       .is_uncore = 1,
>> +                       .id = (char *)"43a01",
>> +               },
>> +               .aliases = {
>> +                       &sys_cmn_pmu_hnf_cache_miss,
>> +               },
>> +       }
>>  };
>>
>>  /* Test that aliases generated are as expected */
>> --
>> 1.8.3.1
>>
