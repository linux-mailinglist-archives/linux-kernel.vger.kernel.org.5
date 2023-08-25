Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EC52787F5F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 07:41:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238636AbjHYFlP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 01:41:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238506AbjHYFlN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 01:41:13 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C8781BDA;
        Thu, 24 Aug 2023 22:41:10 -0700 (PDT)
Received: from kwepemm600003.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RX7xs1CdpztSMB;
        Fri, 25 Aug 2023 13:37:21 +0800 (CST)
Received: from [10.67.111.205] (10.67.111.205) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Fri, 25 Aug 2023 13:41:06 +0800
Subject: Re: [PATCH v6 1/7] perf evlist: Add perf_evlist__go_system_wide()
 helper
To:     Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>
CC:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>,
        <kan.liang@linux.intel.com>, <james.clark@arm.com>,
        <tmricht@linux.ibm.com>, <ak@linux.intel.com>,
        <anshuman.khandual@arm.com>, <linux-kernel@vger.kernel.org>,
        <linux-perf-users@vger.kernel.org>
References: <20230821012734.18241-1-yangjihong1@huawei.com>
 <20230821012734.18241-2-yangjihong1@huawei.com>
 <CAP-5=fXexLBnq1pkHPR5uXR-bL3CFTzEWkFnxHVs-71+S0yZSg@mail.gmail.com>
From:   Yang Jihong <yangjihong1@huawei.com>
Message-ID: <db2de7d0-d60d-33f8-3587-c776a3eb8fce@huawei.com>
Date:   Fri, 25 Aug 2023 13:41:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <CAP-5=fXexLBnq1pkHPR5uXR-bL3CFTzEWkFnxHVs-71+S0yZSg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.111.205]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 2023/8/25 12:51, Ian Rogers wrote:
> On Sun, Aug 20, 2023 at 6:30 PM Yang Jihong <yangjihong1@huawei.com> wrote:
>>
>> For dummy events that keep tracking, we may need to modify its cpu_maps.
>> For example, change the cpu_maps to record sideband events for all CPUS.
>> Add perf_evlist__go_system_wide() helper to support this scenario.
>>
>> Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
>> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
>> ---
>>   tools/lib/perf/evlist.c                  | 9 +++++++++
>>   tools/lib/perf/include/internal/evlist.h | 2 ++
>>   2 files changed, 11 insertions(+)
>>
>> diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
>> index b8b066d0dc5e..3acbbccc1901 100644
>> --- a/tools/lib/perf/evlist.c
>> +++ b/tools/lib/perf/evlist.c
>> @@ -738,3 +738,12 @@ int perf_evlist__nr_groups(struct perf_evlist *evlist)
>>          }
>>          return nr_groups;
>>   }
>> +
>> +void perf_evlist__go_system_wide(struct perf_evlist *evlist, struct perf_evsel *evsel)
>> +{
>> +       if (!evsel->system_wide) {
>> +               evsel->system_wide = true;
>> +               if (evlist->needs_map_propagation)
>> +                       __perf_evlist__propagate_maps(evlist, evsel);
>> +       }
>> +}
> 
> I think this should be:
> 
> void evsel__set_system_wide(struct evsel *evsel)
> {
>          if (evsel->system_wide)
>                 return;
>          evsel->system_wide = true;
>          if (evsel->evlist->core.needs_map_propagation)
> ...
> 
> The API being on evlist makes it look like all evsels are affected.
> 
This part of the code is implemented according to Adrian's suggestion.
Refer to:

https://lore.kernel.org/linux-perf-users/206972a3-d44d-1c75-3fbc-426427614543@intel.com/

The logic of both is the same, and either is OK for me.
If really want to change it, please let me know.

Thanks,
Yang
