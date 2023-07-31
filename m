Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C92E2769659
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 14:31:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232613AbjGaMa5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 08:30:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232615AbjGaMaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 08:30:52 -0400
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8898C10DF;
        Mon, 31 Jul 2023 05:30:49 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=renyu.zj@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0VofLXKW_1690806644;
Received: from 30.221.150.94(mailfrom:renyu.zj@linux.alibaba.com fp:SMTPD_---0VofLXKW_1690806644)
          by smtp.aliyun-inc.com;
          Mon, 31 Jul 2023 20:30:45 +0800
Message-ID: <2dc21269-2fa0-ea39-454d-5f12a414bc13@linux.alibaba.com>
Date:   Mon, 31 Jul 2023 20:30:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH v5 3/5] perf test: Add pmu-event test for "Compat" and new
 event_field.
To:     John Garry <john.g.garry@oracle.com>,
        Ian Rogers <irogers@google.com>
Cc:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Ilkka Koskinen <ilkka@os.amperecomputing.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-doc@vger.kernel.org,
        Zhuo Song <zhuo.song@linux.alibaba.com>,
        Shuai Xue <xueshuai@linux.alibaba.com>
References: <1690525040-77423-1-git-send-email-renyu.zj@linux.alibaba.com>
 <1690525040-77423-4-git-send-email-renyu.zj@linux.alibaba.com>
 <abeaafbe-2290-d272-ddd1-f358f7271edc@oracle.com>
From:   Jing Zhang <renyu.zj@linux.alibaba.com>
In-Reply-To: <abeaafbe-2290-d272-ddd1-f358f7271edc@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/7/28 下午4:30, John Garry 写道:
> On 28/07/2023 07:17, Jing Zhang wrote:
>> Add new event test for uncore system event which is used to verify the
>> functionality of "Compat" matching multiple identifiers and the new event
>> fields "EventIdCode" and "Type".
>>
> 
> Thanks for doing this. It looks ok. I just have a comment, below.
> 

Thanks.

>> Signed-off-by: Jing Zhang <renyu.zj@linux.alibaba.com>
>> ---
>>   .../pmu-events/arch/test/test_soc/sys/uncore.json  |  8 ++++
>>   tools/perf/tests/pmu-events.c                      | 55 ++++++++++++++++++++++
>>   2 files changed, 63 insertions(+)
>>
>> diff --git a/tools/perf/pmu-events/arch/test/test_soc/sys/uncore.json b/tools/perf/pmu-events/arch/test/test_soc/sys/uncore.json
>> index c7e7528..879a0ae 100644
>> --- a/tools/perf/pmu-events/arch/test/test_soc/sys/uncore.json
>> +++ b/tools/perf/pmu-events/arch/test/test_soc/sys/uncore.json
>> @@ -12,5 +12,13 @@
>>              "EventName": "sys_ccn_pmu.read_cycles",
>>              "Unit": "sys_ccn_pmu",
>>              "Compat": "0x01"
>> +   },
>> +   {
>> +           "BriefDescription": "Counts total cache misses in first lookup result (high priority).",
>> +           "Type": "0x05",
>> +           "EventIdCode": "0x01",
>> +           "EventName": "sys_cmn_pmu.hnf_cache_miss",
>> +           "Unit": "arm_cmn",
>> +           "Compat": "434*;436*;43c*;43a01"
>>      }
>>   ]
>> diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
>> index 1dff863b..e227dcd 100644
>> --- a/tools/perf/tests/pmu-events.c
>> +++ b/tools/perf/tests/pmu-events.c
>> @@ -255,9 +255,24 @@ struct perf_pmu_test_pmu {
>>       .matching_pmu = "uncore_sys_ccn_pmu",
>>   };
>>   +static const struct perf_pmu_test_event sys_cmn_pmu_hnf_cache_miss = {
>> +    .event = {
>> +        .name = "sys_cmn_pmu.hnf_cache_miss",
>> +        .event = "type=0x05,eventid=0x01",
>> +        .desc = "Counts total cache misses in first lookup result (high priority). Unit: uncore_arm_cmn ",
>> +        .topic = "uncore",
>> +        .pmu = "uncore_arm_cmn",
>> +        .compat = "434*;436*;43c*;43a01",
>> +    },
>> +    .alias_str = "type=0x5,eventid=0x1",
>> +    .alias_long_desc = "Counts total cache misses in first lookup result (high priority). Unit: uncore_arm_cmn ",
>> +    .matching_pmu = "uncore_arm_cmn_0",
>> +};
>> +
>>   static const struct perf_pmu_test_event *sys_events[] = {
>>       &sys_ddr_pmu_write_cycles,
>>       &sys_ccn_pmu_read_cycles,
>> +    &sys_cmn_pmu_hnf_cache_miss,
>>       NULL
>>   };
>>   @@ -699,6 +714,46 @@ static int __test_uncore_pmu_event_aliases(struct perf_pmu_test_pmu *test_pmu)
>>               &sys_ccn_pmu_read_cycles,
>>           },
>>       },
>> +    {
>> +        .pmu = {
>> +            .name = (char *)"uncore_arm_cmn_0",
>> +            .is_uncore = 1,
>> +            .id = (char *)"43401",
>> +        },
>> +        .aliases = {
>> +            &sys_cmn_pmu_hnf_cache_miss,
>> +        },
>> +    },
>> +    {
>> +        .pmu = {
>> +            .name = (char *)"uncore_arm_cmn_0",
>> +            .is_uncore = 1,
>> +            .id = (char *)"43602",
>> +        },
>> +        .aliases = {
>> +            &sys_cmn_pmu_hnf_cache_miss,
>> +        },
>> +    },
>> +    {
>> +        .pmu = {
>> +            .name = (char *)"uncore_arm_cmn_1",
> 
> Shouldn't this match some perf_pmu_test_event entry with same matching_pmu member? But is perf_pmu_test_event.matching_pmu member ever used for any checking???
> 

I need to double check because I was testing against 6.3-rc2.

Thanks,
Jing

> Thanks,
> John
> 
>> +            .is_uncore = 1,
>> +            .id = (char *)"43c03",
>> +        },
>> +        .aliases = {
>> +            &sys_cmn_pmu_hnf_cache_miss,
>> +        },
>> +    },
>> +    {
>> +        .pmu = {
>> +            .name = (char *)"uncore_arm_cmn_1",
>> +            .is_uncore = 1,
>> +            .id = (char *)"43a01",
>> +        },
>> +        .aliases = {
>> +            &sys_cmn_pmu_hnf_cache_miss,
>> +        },
>> +    }
>>   };
>>     /* Test that aliases generated are as expected */
