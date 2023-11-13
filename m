Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33AF17EA121
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 17:18:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231458AbjKMQKj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 11:10:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230034AbjKMQKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 11:10:37 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D03B710E0;
        Mon, 13 Nov 2023 08:10:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699891833; x=1731427833;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=vRyOHh8fGEaI4QGodHnPBNlhG7VgWbIgHMktGZ0CYWU=;
  b=SSQLZ99CdcG4FEvNo1pSAfyq1AnPlH9Pd9GDMRkcIuca7sKhEiJJz+NR
   08/spa41Dh5c4svQCv8SXzOAjeKhsx/x59VcPyeg2khzf7Z9JM4q3lTMX
   bm4/elYcbnwf28g8v8auMDoV0W+WtL+oaTDMVZcZ0ojvzdmWzuGgMAkQc
   kmnjQcH6wH779sLkqkRSaxS/RppiuKaKxbuU3GE91gjbs544fSu882gpf
   T+c9N27F2Leu7X8omM2VAUBrpBU/ybb+syhlDcsQScfrCL2sg7UW52Niy
   CgvvZEIyq2FOZOHqzOymMiRJFhWCLBwteNOvoMGBrquHu4lcGiaaFL9DZ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="456950049"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="456950049"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2023 08:10:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="799227519"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="799227519"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2023 08:10:33 -0800
Received: from [10.212.17.243] (kliang2-mobl1.ccr.corp.intel.com [10.212.17.243])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id B56875805B5;
        Mon, 13 Nov 2023 08:10:31 -0800 (PST)
Message-ID: <d7887fd3-ebf1-47f9-bda7-fd47d79b9807@linux.intel.com>
Date:   Mon, 13 Nov 2023 11:10:30 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf evsel: Ignore the non-group case for branch counters
To:     Ian Rogers <irogers@google.com>
Cc:     acme@kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, jolsa@kernel.org, namhyung@kernel.org,
        adrian.hunter@intel.com, tinghao.zhang@intel.com,
        Arnaldo Carvalho de Melo <acme@redhat.com>
References: <20231109164007.2037721-1-kan.liang@linux.intel.com>
 <CAP-5=fXGavfHvSPs5dRWmS93gspj4uUE6ftd855xFyN-hKRTzg@mail.gmail.com>
Content-Language: en-US
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <CAP-5=fXGavfHvSPs5dRWmS93gspj4uUE6ftd855xFyN-hKRTzg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-11-13 10:49 a.m., Ian Rogers wrote:
> On Thu, Nov 9, 2023 at 8:41 AM <kan.liang@linux.intel.com> wrote:
>>
>> From: Kan Liang <kan.liang@linux.intel.com>
>>
>> The perf test 27: Sample parsing fails with the branch counters support
>> introduced.
>>
>> The branch counters feature requires all the events to belong to a
>> group. There is no problem with the normal perf usage which usually
>> initializes an evlist even for a single evsel.
>> But the perf test is special, which may not initialize an evlist. The
>> Sample parsing test case is one of the examples. The existing code
>> crashes with the !evsel->evlist.
>>
>> Non-group means the evsel doesn't have branch counters support.
> 
> Thanks Kan, do we need to add this condition to
> parse_events__sort_events_and_fix_groups?
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/util/parse-events.c#n2174
> 

I don't think so. The "non-group" here means the case that the evlist is
not initialized. It should only happen with some perf test case.

In the parse_events__sort_events_and_fix_groups(), IIUC, the ungrouped
event should mean a single event group. The feature works with the case.
We don't need to add the condition.

BTW: Arnaldo should have already folded it with the original patch. We
don't need the patch anymore.
https://lore.kernel.org/lkml/ZU0pGuUBJH+bF1yU@kernel.org/

Thanks,
Kan

> Ian
> 
>> Reported-by: Arnaldo Carvalho de Melo <acme@redhat.com>
>> Closes: https://lore.kernel.org/lkml/ZUv+G+w5EvJgQS45@kernel.org/
>> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
>> ---
>>  tools/perf/util/evsel.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
>> index 58a9b8c82790..7a6a2d1f96db 100644
>> --- a/tools/perf/util/evsel.c
>> +++ b/tools/perf/util/evsel.c
>> @@ -2355,6 +2355,10 @@ static inline bool evsel__has_branch_counters(const struct evsel *evsel)
>>  {
>>         struct evsel *cur, *leader = evsel__leader(evsel);
>>
>> +       /* The branch counters feature only supports group */
>> +       if (!leader || !evsel->evlist)
>> +               return false;
>> +
>>         evlist__for_each_entry(evsel->evlist, cur) {
>>                 if ((leader == evsel__leader(cur)) &&
>>                     (cur->core.attr.branch_sample_type & PERF_SAMPLE_BRANCH_COUNTERS))
>> --
>> 2.35.1
>>
