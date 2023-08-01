Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDFE376BB96
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 19:48:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbjHARsO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 13:48:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbjHARsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 13:48:12 -0400
Received: from mgamail.intel.com (unknown [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A671DF;
        Tue,  1 Aug 2023 10:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690912091; x=1722448091;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=nx800bcgB0d+9AzYBPcP05FbBwoeGnKbUctGnfR13lw=;
  b=jCJi5OhY4quBAQaExAj14HTKTg3QJgB2guvxBtLu8CL6rncHOMnxxj5v
   UqIqW8mmfrAGQoVcXlVE9qx/Y6biF11Jq3LgiIsDYdKVhuVZKByb/VOXN
   R0Rqt88HIakDrJ0/bLV8X9ZoyozIpIe6xXZWvIfqwR5uoL/3jfDL9zRT5
   W/dkV+RXpdYpHfFvVGUK/3c6EZtPKmzzrpVCuz71MxcvSYv6CukQCOojb
   BkZXxxYLadG2xRm5sbmQ8IGUO40D6HSvRiea3faksKjzP5zcXT+AfiGSg
   JcYN8359cB4p4Wrv8wV3V4JdzhiUWs2Jhg43S3eS+xQL4QQNVXN1z9PvD
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="400317978"
X-IronPort-AV: E=Sophos;i="6.01,247,1684825200"; 
   d="scan'208";a="400317978"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2023 10:48:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="732070929"
X-IronPort-AV: E=Sophos;i="6.01,247,1684825200"; 
   d="scan'208";a="732070929"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga007.fm.intel.com with ESMTP; 01 Aug 2023 10:48:10 -0700
Received: from [10.213.165.139] (unknown [10.213.165.139])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 0A59B58068A;
        Tue,  1 Aug 2023 10:48:07 -0700 (PDT)
Message-ID: <9b3618ee-abe9-745a-01d7-98eb9ab70fc2@linux.intel.com>
Date:   Tue, 1 Aug 2023 13:48:06 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1 1/4] perf parse-events x86: Avoid sorting
 uops_retired.slots
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>,
        Weilin Wang <weilin.wang@intel.com>
References: <20230801053634.1142634-1-irogers@google.com>
 <20230801053634.1142634-2-irogers@google.com>
 <faca2b35-fdd6-7394-edea-32dd59d3a16f@linux.intel.com>
 <CAP-5=fU+KJCwxtS7RkBNqnECSrO4dqVeH9NHRP1oA7W6L3Rx4g@mail.gmail.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <CAP-5=fU+KJCwxtS7RkBNqnECSrO4dqVeH9NHRP1oA7W6L3Rx4g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-08-01 11:54 a.m., Ian Rogers wrote:
> On Tue, Aug 1, 2023 at 8:40 AM Liang, Kan <kan.liang@linux.intel.com> wrote:
>>
>>
>>
>> On 2023-08-01 1:36 a.m., Ian Rogers wrote:
>>> As topdown.slots may appear as slots it may get confused with
>>> uops_retired.slots which is an invalid perf metric event group
>>> leader. Special case uops_retired.slots to avoid this confusion.
>>>
>>
>> Does any name with format "name.slots" cause the confusion? If so, I
>> don't think we can stop others from naming like the above format.
>>
>> Is it better to hard code the topdown.slots/slots, rather than
>> uops_retired.slots?
> 
> So firstly, yet more fringe perf metric event benefits with this silly
> bit of complexity. The issue with "just" trying to pattern match
> "topdown.slots" and "slots" is that there may be pmu names in there.
> So (ignoring case) we get:
> 
> slots
> topdown.slots
> cpu/slots/
> cpu/topdown.slots/
> cpu_core/slots/
> cpu_core/topdown.slots/
> 
> but the name can have other junk like modifiers in there and also
> there's the name= config term, but let's just not think about that
> breaking stuff. To avoid 6 searches I searched for the known
> problematic uops_retired.slots, knowing if that's not there then one
> of the 6 above is the match. Searching for just "slots" or
> "topdown.slots" isn't good enough as "slots" will get a hit in
> "uops_retired.slots", how we ended up with this patch in the 1st
> place. So I ended up using the uops_retired.slots search to reduce
> complexity in the code and to avoid writing an event parser just to
> figure out what the name is... Ideally we'd be using the
> perf_event_attr to do this comparison, but immediately after
> parse-events when this code runs it hasn't been computed yet. Maybe I
> can shuffle things around and make this true. Ideally I think
> parse-events would just be a library that given some event description
> gives back perf_event_attr and not evsels, but that's yet further
> work...
>

Thanks for the details.

I don't think we have other events with a similar pattern. For now,
special case uops_retired.slots should be good enough.

Thanks,
Kan

> Thanks,
> Ian
> 
>>
>> Thanks,
>> Kan
>>
>>> Signed-off-by: Ian Rogers <irogers@google.com>
>>> ---
>>>  tools/perf/arch/x86/util/evlist.c | 7 ++++---
>>>  tools/perf/arch/x86/util/evsel.c  | 7 +++----
>>>  2 files changed, 7 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/tools/perf/arch/x86/util/evlist.c b/tools/perf/arch/x86/util/evlist.c
>>> index cbd582182932..b1ce0c52d88d 100644
>>> --- a/tools/perf/arch/x86/util/evlist.c
>>> +++ b/tools/perf/arch/x86/util/evlist.c
>>> @@ -75,11 +75,12 @@ int arch_evlist__add_default_attrs(struct evlist *evlist,
>>>
>>>  int arch_evlist__cmp(const struct evsel *lhs, const struct evsel *rhs)
>>>  {
>>> -     if (topdown_sys_has_perf_metrics() && evsel__sys_has_perf_metrics(lhs)) {
>>> +     if (topdown_sys_has_perf_metrics() &&
>>> +         (arch_evsel__must_be_in_group(lhs) || arch_evsel__must_be_in_group(rhs))) {
>>>               /* Ensure the topdown slots comes first. */
>>> -             if (strcasestr(lhs->name, "slots"))
>>> +             if (strcasestr(lhs->name, "slots") && !strcasestr(lhs->name, "uops_retired.slots"))
>>>                       return -1;
>>> -             if (strcasestr(rhs->name, "slots"))
>>> +             if (strcasestr(rhs->name, "slots") && !strcasestr(rhs->name, "uops_retired.slots"))
>>>                       return 1;
>>>               /* Followed by topdown events. */
>>>               if (strcasestr(lhs->name, "topdown") && !strcasestr(rhs->name, "topdown"))
>>> diff --git a/tools/perf/arch/x86/util/evsel.c b/tools/perf/arch/x86/util/evsel.c
>>> index 81d22657922a..090d0f371891 100644
>>> --- a/tools/perf/arch/x86/util/evsel.c
>>> +++ b/tools/perf/arch/x86/util/evsel.c
>>> @@ -40,12 +40,11 @@ bool evsel__sys_has_perf_metrics(const struct evsel *evsel)
>>>
>>>  bool arch_evsel__must_be_in_group(const struct evsel *evsel)
>>>  {
>>> -     if (!evsel__sys_has_perf_metrics(evsel))
>>> +     if (!evsel__sys_has_perf_metrics(evsel) || !evsel->name ||
>>> +         strcasestr(evsel->name, "uops_retired.slots"))
>>>               return false;
>>>
>>> -     return evsel->name &&
>>> -             (strcasestr(evsel->name, "slots") ||
>>> -              strcasestr(evsel->name, "topdown"));
>>> +     return strcasestr(evsel->name, "topdown") || strcasestr(evsel->name, "slots");
>>>  }
>>>
>>>  int arch_evsel__hw_name(struct evsel *evsel, char *bf, size_t size)
