Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A404D787FE6
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 08:30:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242054AbjHYGaD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 02:30:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242197AbjHYG3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 02:29:44 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD474211F;
        Thu, 24 Aug 2023 23:29:09 -0700 (PDT)
Received: from kwepemm600003.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RX93Y6s9Zz1L8wg;
        Fri, 25 Aug 2023 14:27:21 +0800 (CST)
Received: from [10.67.111.205] (10.67.111.205) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Fri, 25 Aug 2023 14:28:53 +0800
Subject: Re: [PATCH v6 1/7] perf evlist: Add perf_evlist__go_system_wide()
 helper
To:     Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        "Liang, Kan" <kan.liang@linux.intel.com>,
        James Clark <james.clark@arm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Andi Kleen <ak@linux.intel.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>
References: <20230821012734.18241-1-yangjihong1@huawei.com>
 <20230821012734.18241-2-yangjihong1@huawei.com>
 <CAP-5=fXexLBnq1pkHPR5uXR-bL3CFTzEWkFnxHVs-71+S0yZSg@mail.gmail.com>
 <db2de7d0-d60d-33f8-3587-c776a3eb8fce@huawei.com>
 <CAP-5=fUtCHXDC5zOML4po8k1rQVPo9ybsTA8_AihepP6w8B5Kw@mail.gmail.com>
From:   Yang Jihong <yangjihong1@huawei.com>
Message-ID: <49d6639e-66ac-16e9-8a54-4b0279f808ce@huawei.com>
Date:   Fri, 25 Aug 2023 14:28:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <CAP-5=fUtCHXDC5zOML4po8k1rQVPo9ybsTA8_AihepP6w8B5Kw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.111.205]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 2023/8/25 13:45, Ian Rogers wrote:
> 
> 
> On Thu, Aug 24, 2023, 10:41 PM Yang Jihong <yangjihong1@huawei.com 
> <mailto:yangjihong1@huawei.com>> wrote:
> 
>     Hello,
> 
>     On 2023/8/25 12:51, Ian Rogers wrote:
>      > On Sun, Aug 20, 2023 at 6:30 PM Yang Jihong
>     <yangjihong1@huawei.com <mailto:yangjihong1@huawei.com>> wrote:
>      >>
>      >> For dummy events that keep tracking, we may need to modify its
>     cpu_maps.
>      >> For example, change the cpu_maps to record sideband events for
>     all CPUS.
>      >> Add perf_evlist__go_system_wide() helper to support this scenario.
>      >>
>      >> Signed-off-by: Yang Jihong <yangjihong1@huawei.com
>     <mailto:yangjihong1@huawei.com>>
>      >> Acked-by: Adrian Hunter <adrian.hunter@intel.com
>     <mailto:adrian.hunter@intel.com>>
>      >> ---
>      >>   tools/lib/perf/evlist.c                  | 9 +++++++++
>      >>   tools/lib/perf/include/internal/evlist.h | 2 ++
>      >>   2 files changed, 11 insertions(+)
>      >>
>      >> diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
>      >> index b8b066d0dc5e..3acbbccc1901 100644
>      >> --- a/tools/lib/perf/evlist.c
>      >> +++ b/tools/lib/perf/evlist.c
>      >> @@ -738,3 +738,12 @@ int perf_evlist__nr_groups(struct
>     perf_evlist *evlist)
>      >>          }
>      >>          return nr_groups;
>      >>   }
>      >> +
>      >> +void perf_evlist__go_system_wide(struct perf_evlist *evlist,
>     struct perf_evsel *evsel)
>      >> +{
>      >> +       if (!evsel->system_wide) {
>      >> +               evsel->system_wide = true;
>      >> +               if (evlist->needs_map_propagation)
>      >> +                       __perf_evlist__propagate_maps(evlist,
>     evsel);
>      >> +       }
>      >> +}
>      >
>      > I think this should be:
>      >
>      > void evsel__set_system_wide(struct evsel *evsel)
>      > {
>      >          if (evsel->system_wide)
>      >                 return;
>      >          evsel->system_wide = true;
>      >          if (evsel->evlist->core.needs_map_propagation)
>      > ...
>      >
>      > The API being on evlist makes it look like all evsels are affected.
>      >
>     This part of the code is implemented according to Adrian's suggestion.
>     Refer to:
> 
>     https://lore.kernel.org/linux-perf-users/206972a3-d44d-1c75-3fbc-426427614543@intel.com/
>     <https://lore.kernel.org/linux-perf-users/206972a3-d44d-1c75-3fbc-426427614543@intel.com/>
> 
>     The logic of both is the same, and either is OK for me.
>     If really want to change it, please let me know.
> 
> 
> Yes, I think the naming isn't correct and the function being on evlist 
> is misleading.
Uh, I have a little problem here, too.

Because perf_evlist__go_system_wide() needs to invoke the 
__perf_evlist__propagate_maps(), which is a local function and is 
located in the evlist.c file in tools/lib/perf/.
So perf_evlist__go_system_wide() can only be located in this file. The 
prefixes of all funcstions in this file are "perf_evlist__". Therefore, 
it is better to use the original names.

In addition, __perf_evlist__propagate_maps affects the evlist, so it is 
not misleading.

Thanks,
Yang
