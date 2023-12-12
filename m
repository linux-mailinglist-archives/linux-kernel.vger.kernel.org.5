Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59BC380F942
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 22:26:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377590AbjLLV0O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 16:26:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377811AbjLLVZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 16:25:49 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D3E4BD;
        Tue, 12 Dec 2023 13:25:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702416356; x=1733952356;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ov2UTLO3Baw5jITloNdK10XmQAFQz4ShV61yRK+Dd98=;
  b=AS3is0/hVgeC7xGB4y1DP+qw7SjOSdkX7UGjfc9C6eMYOy75PqKKbD+I
   FaGt0B1MwAtTGyeNdln3HKcjCY+Srxb0uCMzGNvj+uqPruJzc3XnEhszI
   agbYkN9WAgnqQi86GSc9msoGbX6raZneKpKtiYdoV/vAla3SNk1INtiNB
   HWJvL22jLsDaYKAEt1aHDrruNNwBShFL6T0w4yiN5Tbo48YwnQ/HgjxBf
   3vJwmI8gr8uRCn99HYfhbzdW8h4A+M9k/+n2H6cvby6Yjf8TCVu8thnUx
   hwo9h8YTpkPc4CqA/K5MzR2AUAov+ZSBstBKhXKa4f3Y8lSzK+y0TLp+W
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="8234850"
X-IronPort-AV: E=Sophos;i="6.04,271,1695711600"; 
   d="scan'208";a="8234850"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 13:25:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="766954480"
X-IronPort-AV: E=Sophos;i="6.04,271,1695711600"; 
   d="scan'208";a="766954480"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 13:25:55 -0800
Received: from [10.209.138.122] (kliang2-mobl1.ccr.corp.intel.com [10.209.138.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 9DB2C580DC5;
        Tue, 12 Dec 2023 13:25:54 -0800 (PST)
Message-ID: <996ec30b-2bcf-4739-bec0-728c7f7af2ac@linux.intel.com>
Date:   Tue, 12 Dec 2023 16:25:53 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] perf top: Use evsel's cpus to replace
 user_requested_cpus
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>
Cc:     acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com,
        maz@kernel.org, marcan@marcan.st, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
References: <20231212193833.415110-1-kan.liang@linux.intel.com>
 <CAP-5=fWCgjCC-DHHx+HJCuYk6vNn9Lf9EKcnBBZQ+xmnyYnmPg@mail.gmail.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <CAP-5=fWCgjCC-DHHx+HJCuYk6vNn9Lf9EKcnBBZQ+xmnyYnmPg@mail.gmail.com>
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



On 2023-12-12 3:37 p.m., Ian Rogers wrote:
> On Tue, Dec 12, 2023 at 11:39 AM <kan.liang@linux.intel.com> wrote:
>>
>> From: Kan Liang <kan.liang@linux.intel.com>
>>
>> perf top errors out on a hybrid machine
>>  $perf top
>>
>>  Error:
>>  The cycles:P event is not supported.
>>
>> The perf top expects that the "cycles" is collected on all CPUs in the
>> system. But for hybrid there is no single "cycles" event which can cover
>> all CPUs. Perf has to split it into two cycles events, e.g.,
>> cpu_core/cycles/ and cpu_atom/cycles/. Each event has its own CPU mask.
>> If a event is opened on the unsupported CPU. The open fails. That's the
>> reason of the above error out.
>>
>> Perf should only open the cycles event on the corresponding CPU. The
>> commit ef91871c960e ("perf evlist: Propagate user CPU maps intersecting
>> core PMU maps") intersect the requested CPU map with the CPU map of the
>> PMU. Use the evsel's cpus to replace user_requested_cpus.
>>
>> The evlist's threads are also propagated to the evsel's threads in
>> __perf_evlist__propagate_maps(). For a system-wide event, perf appends
>> a dummy event and assign it to the evsel's threads. For a per-thread
>> event, the evlist's thread_map is assigned to the evsel's threads. The
>> same as the other tools, e.g., perf record, using the evsel's threads
>> when opening an event.
>>
>> Reported-by: Arnaldo Carvalho de Melo <acme@kernel.org>
>> Closes: https://lore.kernel.org/linux-perf-users/ZXNnDrGKXbEELMXV@kernel.org/
>> Reviewed-by: Ian Rogers <irogers@google.com>
>> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
>> ---
>>
>> Changes since V1:
>> - Update the description
>> - Add Reviewed-by from Ian
> 
> Thanks Kan, quick question. Does "perf top" on hybrid ask the user to
> select between the cycles event on cpu_atom and cpu_core? 

Yes, but the event doesn't include the PMU information.
We probably need a follow up patch to append the PMU name.

Available samples
385 cycles:P

903 cycles:P

Thanks,
Kan

> I'm
> wondering if there is some kind of missing "hybrid-merge"
> functionality like we have for perf stat.
> 
> Thanks,
> Ian
> 
>>  tools/perf/builtin-top.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
>> index ea8c7eca5eee..cce9350177e2 100644
>> --- a/tools/perf/builtin-top.c
>> +++ b/tools/perf/builtin-top.c
>> @@ -1027,8 +1027,8 @@ static int perf_top__start_counters(struct perf_top *top)
>>
>>         evlist__for_each_entry(evlist, counter) {
>>  try_again:
>> -               if (evsel__open(counter, top->evlist->core.user_requested_cpus,
>> -                                    top->evlist->core.threads) < 0) {
>> +               if (evsel__open(counter, counter->core.cpus,
>> +                               counter->core.threads) < 0) {
>>
>>                         /*
>>                          * Specially handle overwrite fall back.
>> --
>> 2.35.1
>>
