Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F13428117F0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 16:46:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442374AbjLMPp7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 10:45:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442522AbjLMPpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 10:45:42 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D16A19E;
        Wed, 13 Dec 2023 07:45:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702482327; x=1734018327;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=6bYoCbaQIuVKd2XkyTBgwU+GNniTOSyr+Y+GORha3VA=;
  b=aEGyjfKWBI+qAYOYgJvYHll3jymL40OEhXTzAv6qdzZ3S5v0KQNeDCpr
   2GC0atp+omoRKNUdQ2yjnFJJdwSHGBwvVE+EhCxWIVNvLDGQXv0nHvRkJ
   FZTA+GCk/BSwTsbhKaaOJ7xtWIQZ8Tc+8ONi9hIP2NBfEJZGytIzHpBt9
   495UlXQ3VlBpeBOHtJnPaOmItmIw5ophpffVMuP+LQ7JeNqgjcsdAa8aW
   ZdN4bzkJ6IL14Xd07BHXW7YYW4RtF2GigN7SeiOAfTjyRlPMcSsO2MkFC
   PmqQ6yGHBTqGgtONOoVCtqPB+2BJywZGqs+N3GIjV7GzlMewmWj3cZPfK
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="2158905"
X-IronPort-AV: E=Sophos;i="6.04,273,1695711600"; 
   d="scan'208";a="2158905"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 07:45:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="1021154988"
X-IronPort-AV: E=Sophos;i="6.04,273,1695711600"; 
   d="scan'208";a="1021154988"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 07:45:26 -0800
Received: from [10.212.117.13] (unknown [10.212.117.13])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 050B4580BF0;
        Wed, 13 Dec 2023 07:45:23 -0800 (PST)
Message-ID: <43e57041-fe13-452a-af6e-db2ed451f93a@linux.intel.com>
Date:   Wed, 13 Dec 2023 10:45:22 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] perf top: Use evsel's cpus to replace
 user_requested_cpus
Content-Language: en-US
To:     Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>
Cc:     acme@kernel.org, mark.rutland@arm.com, maz@kernel.org,
        marcan@marcan.st, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
References: <20231212193833.415110-1-kan.liang@linux.intel.com>
 <CAP-5=fWCgjCC-DHHx+HJCuYk6vNn9Lf9EKcnBBZQ+xmnyYnmPg@mail.gmail.com>
 <996ec30b-2bcf-4739-bec0-728c7f7af2ac@linux.intel.com>
 <CAP-5=fVnH0eTEvvNbKLF9xYye5Pu8hvDL4ruoxh5xG76+B8WFQ@mail.gmail.com>
 <CAM9d7chQ4NbbcmumQSMRaGm987nxxh6_QbbJr7+GYgL_WAmaNw@mail.gmail.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <CAM9d7chQ4NbbcmumQSMRaGm987nxxh6_QbbJr7+GYgL_WAmaNw@mail.gmail.com>
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



On 2023-12-12 8:06 p.m., Namhyung Kim wrote:
> On Tue, Dec 12, 2023 at 2:12 PM Ian Rogers <irogers@google.com> wrote:
>>
>> On Tue, Dec 12, 2023 at 1:25 PM Liang, Kan <kan.liang@linux.intel.com> wrote:
>>>
>>>
>>>
>>> On 2023-12-12 3:37 p.m., Ian Rogers wrote:
>>>> On Tue, Dec 12, 2023 at 11:39 AM <kan.liang@linux.intel.com> wrote:
>>>>>
>>>>> From: Kan Liang <kan.liang@linux.intel.com>
>>>>>
>>>>> perf top errors out on a hybrid machine
>>>>>  $perf top
>>>>>
>>>>>  Error:
>>>>>  The cycles:P event is not supported.
>>>>>
>>>>> The perf top expects that the "cycles" is collected on all CPUs in the
>>>>> system. But for hybrid there is no single "cycles" event which can cover
>>>>> all CPUs. Perf has to split it into two cycles events, e.g.,
>>>>> cpu_core/cycles/ and cpu_atom/cycles/. Each event has its own CPU mask.
>>>>> If a event is opened on the unsupported CPU. The open fails. That's the
>>>>> reason of the above error out.
>>>>>
>>>>> Perf should only open the cycles event on the corresponding CPU. The
>>>>> commit ef91871c960e ("perf evlist: Propagate user CPU maps intersecting
>>>>> core PMU maps") intersect the requested CPU map with the CPU map of the
>>>>> PMU. Use the evsel's cpus to replace user_requested_cpus.
>>>>>
>>>>> The evlist's threads are also propagated to the evsel's threads in
>>>>> __perf_evlist__propagate_maps(). For a system-wide event, perf appends
>>>>> a dummy event and assign it to the evsel's threads. For a per-thread
>>>>> event, the evlist's thread_map is assigned to the evsel's threads. The
>>>>> same as the other tools, e.g., perf record, using the evsel's threads
>>>>> when opening an event.
>>>>>
>>>>> Reported-by: Arnaldo Carvalho de Melo <acme@kernel.org>
>>>>> Closes: https://lore.kernel.org/linux-perf-users/ZXNnDrGKXbEELMXV@kernel.org/
>>>>> Reviewed-by: Ian Rogers <irogers@google.com>
>>>>> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
>>>>> ---
>>>>>
>>>>> Changes since V1:
>>>>> - Update the description
>>>>> - Add Reviewed-by from Ian
>>>>
>>>> Thanks Kan, quick question. Does "perf top" on hybrid ask the user to
>>>> select between the cycles event on cpu_atom and cpu_core?
>>>
>>> Yes, but the event doesn't include the PMU information.
>>> We probably need a follow up patch to append the PMU name.
>>>
>>> Available samples
>>> 385 cycles:P
>>>
>>> 903 cycles:P
>>
>> Thanks and agreed, it isn't possible to tell which is which PMU/CPU
>> type at the moment. I tried the patch with perf top --stdio, there
>> wasn't a choice of event  

The perf top --stdio uses a dedicated display function, see
perf_top__header_snprintf() in util/top.c

It only shows one event at a time. "E" is used to switch the event.

>> and I can't tell what counter is being
>> displayed. 

For the hybrid case, I think we may display both PMU name and event
name. For example,

Available samples
656 cycles:P cpu_atom

701 cycles:P cpu_core

diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index f4812b226818..afc7a1d54fe4 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -3433,8 +3433,10 @@ static void perf_evsel_menu__write(struct
ui_browser *browser,
        }

        nr_events = convert_unit(nr_events, &unit);
-       printed = scnprintf(bf, sizeof(bf), "%lu%c%s%s", nr_events,
-                          unit, unit == ' ' ? "" : " ", ev_name);
+       printed = scnprintf(bf, sizeof(bf), "%lu%c%s%s %s", nr_events,
+                          unit, unit == ' ' ? "" : " ", ev_name,
+                          evsel->pmu ? evsel->pmu_name : "");
+
        ui_browser__printf(browser, "%s", bf);

        nr_events = evsel->evlist->stats.nr_events[PERF_RECORD_LOST];


>> When I quit I also see:
>> ```
>> exiting.
>> corrupted double-linked list
>> Aborted (core dumped)
>> ```
>> but I wasn't able to repro this on a debuggable binary/system.

I haven't see the issue yet.

>>
>> If my memory serves there was a patch where perf top was showing >1
>> event. It would be nice here to do some kind of hybrid merging rather
>> than having to view each PMU's top separately.

The current perf top doesn't merge when there are >1 event.
sudo ./perf top -e "cycles,instructions"

Available samples
2K cycles

2K instructions

For now, I think we may just append a PMU name to distinguish the hybrid
case.

We may implement the merging feature which impacts both hybrid and
non-hybrid cases later separately.

> 
> Using event groups, but I noticed you removed the --group option.
> Maybe perf top can just use `{ ... }` notation for explicit grouping,
> but it might be implicit like in the hybrid case.
> 

Yes, if the events are from different PMUs, the perf tool will
implicitly de-group the hybrid events. "{ ... }" may not help here.

Thanks,
Kan
