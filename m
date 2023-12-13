Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08A1F81208F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 22:19:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233702AbjLMVSm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 16:18:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442750AbjLMVK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 16:10:57 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10A1A9A;
        Wed, 13 Dec 2023 13:11:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702501864; x=1734037864;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=hueJ+Wb7TnVxcE3IGOjRy11SfymJEZ0zP/QL+9LdPf8=;
  b=bElGwLqlaqXCOkxJ4xXylGc2LMCOtcmpSmyIj8IgyhquTJGizUXAJqcB
   RNxtJZzaSspMgTsrKXYxCiy0SoCzWh2t1AqCYi6wvfpTVTapGsls1GypT
   qVnOj1SE7Q9iaPDOYazWiEvMgNcqPBV7QX6uWcLISiPdHuBaExoPMEi2C
   mcWba4xGAZPe0udgFZtoFobptrUCp+T4HCvHXZTzQsMjY2Be1KSnW0JlC
   6vdQ6qe+S/wclDYRWeujeEoDVbMg2gjkUQrXC19vrc3+q5I/cnTsyXQpa
   OxgIBkuU2xzlAhTjtIxIF4siOn0Fu7yLCDeJrKGYyfU6ARj8Qd0TfSw4r
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="374533648"
X-IronPort-AV: E=Sophos;i="6.04,273,1695711600"; 
   d="scan'208";a="374533648"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 13:11:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,273,1695711600"; 
   d="scan'208";a="15581492"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 13:11:04 -0800
Received: from [10.212.97.3] (kliang2-mobl1.ccr.corp.intel.com [10.212.97.3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 4AF85580DA9;
        Wed, 13 Dec 2023 13:11:02 -0800 (PST)
Message-ID: <e9383607-1e43-4c1a-9512-29f27784d035@linux.intel.com>
Date:   Wed, 13 Dec 2023 16:11:00 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] perf top: Use evsel's cpus to replace
 user_requested_cpus
To:     Ian Rogers <irogers@google.com>
Cc:     Namhyung Kim <namhyung@kernel.org>, acme@kernel.org,
        mark.rutland@arm.com, maz@kernel.org, marcan@marcan.st,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
References: <20231212193833.415110-1-kan.liang@linux.intel.com>
 <CAP-5=fWCgjCC-DHHx+HJCuYk6vNn9Lf9EKcnBBZQ+xmnyYnmPg@mail.gmail.com>
 <996ec30b-2bcf-4739-bec0-728c7f7af2ac@linux.intel.com>
 <CAP-5=fVnH0eTEvvNbKLF9xYye5Pu8hvDL4ruoxh5xG76+B8WFQ@mail.gmail.com>
 <CAM9d7chQ4NbbcmumQSMRaGm987nxxh6_QbbJr7+GYgL_WAmaNw@mail.gmail.com>
 <43e57041-fe13-452a-af6e-db2ed451f93a@linux.intel.com>
 <CAP-5=fXHadLYuRkY2Z=kymWJkB63dBWfCibQJnwgt0wkSuVVsg@mail.gmail.com>
Content-Language: en-US
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <CAP-5=fXHadLYuRkY2Z=kymWJkB63dBWfCibQJnwgt0wkSuVVsg@mail.gmail.com>
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



On 2023-12-13 12:42 p.m., Ian Rogers wrote:
> On Wed, Dec 13, 2023 at 7:45 AM Liang, Kan <kan.liang@linux.intel.com> wrote:
>>
>>
>> On 2023-12-12 8:06 p.m., Namhyung Kim wrote:
>>> On Tue, Dec 12, 2023 at 2:12 PM Ian Rogers <irogers@google.com> wrote:
>>>> On Tue, Dec 12, 2023 at 1:25 PM Liang, Kan <kan.liang@linux.intel.com> wrote:
>>>>>
>>>>>
>>>>> On 2023-12-12 3:37 p.m., Ian Rogers wrote:
>>>>>> On Tue, Dec 12, 2023 at 11:39 AM <kan.liang@linux.intel.com> wrote:
>>>>>>> From: Kan Liang <kan.liang@linux.intel.com>
>>>>>>>
>>>>>>> perf top errors out on a hybrid machine
>>>>>>>  $perf top
>>>>>>>
>>>>>>>  Error:
>>>>>>>  The cycles:P event is not supported.
>>>>>>>
>>>>>>> The perf top expects that the "cycles" is collected on all CPUs in the
>>>>>>> system. But for hybrid there is no single "cycles" event which can cover
>>>>>>> all CPUs. Perf has to split it into two cycles events, e.g.,
>>>>>>> cpu_core/cycles/ and cpu_atom/cycles/. Each event has its own CPU mask.
>>>>>>> If a event is opened on the unsupported CPU. The open fails. That's the
>>>>>>> reason of the above error out.
>>>>>>>
>>>>>>> Perf should only open the cycles event on the corresponding CPU. The
>>>>>>> commit ef91871c960e ("perf evlist: Propagate user CPU maps intersecting
>>>>>>> core PMU maps") intersect the requested CPU map with the CPU map of the
>>>>>>> PMU. Use the evsel's cpus to replace user_requested_cpus.
>>>>>>>
>>>>>>> The evlist's threads are also propagated to the evsel's threads in
>>>>>>> __perf_evlist__propagate_maps(). For a system-wide event, perf appends
>>>>>>> a dummy event and assign it to the evsel's threads. For a per-thread
>>>>>>> event, the evlist's thread_map is assigned to the evsel's threads. The
>>>>>>> same as the other tools, e.g., perf record, using the evsel's threads
>>>>>>> when opening an event.
>>>>>>>
>>>>>>> Reported-by: Arnaldo Carvalho de Melo <acme@kernel.org>
>>>>>>> Closes: https://lore.kernel.org/linux-perf-users/ZXNnDrGKXbEELMXV@kernel.org/
>>>>>>> Reviewed-by: Ian Rogers <irogers@google.com>
>>>>>>> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
>>>>>>> ---
>>>>>>>
>>>>>>> Changes since V1:
>>>>>>> - Update the description
>>>>>>> - Add Reviewed-by from Ian
>>>>>> Thanks Kan, quick question. Does "perf top" on hybrid ask the user to
>>>>>> select between the cycles event on cpu_atom and cpu_core?
>>>>> Yes, but the event doesn't include the PMU information.
>>>>> We probably need a follow up patch to append the PMU name.
>>>>>
>>>>> Available samples
>>>>> 385 cycles:P
>>>>>
>>>>> 903 cycles:P
>>>> Thanks and agreed, it isn't possible to tell which is which PMU/CPU
>>>> type at the moment. I tried the patch with perf top --stdio, there
>>>> wasn't a choice of event
>> The perf top --stdio uses a dedicated display function, see
>> perf_top__header_snprintf() in util/top.c
>>
>> It only shows one event at a time. "E" is used to switch the event.
>>
>>>> and I can't tell what counter is being
>>>> displayed.
>> For the hybrid case, I think we may display both PMU name and event
>> name. For example,
>>
>> Available samples
>> 656 cycles:P cpu_atom
>>
>> 701 cycles:P cpu_core
> I think there would be more uniformity if we could do:
> cpu/cycles/P
> I'm just reminded of the stat output where sometimes you can get things like:
> cpu/cycles/
> or sometimes:
> cycles [cpu]
> It seems the slash style approach is the most uniform given it looks
> like what is written on the command line. Perhaps we need some kind of
> helper function to do this as reformatting the modifier is a pain.

Actually, we already have a helper in the perf record,
record__uniquify_name().
I can move it to the util/record.c and let's perf top invoke it before
the open as well. Then we can get this in the perf top.

Available samples
148 cpu_atom/cycles:P/

1K cpu_core/cycles:P/

It should be good enough to distinguish the events.
I will send a patch to support it.

Thanks,
Kan
