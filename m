Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8725580F231
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 17:16:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232750AbjLLQQp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 11:16:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377214AbjLLP4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 10:56:14 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A0B410C;
        Tue, 12 Dec 2023 07:56:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702396578; x=1733932578;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=10Oi9jUazqpFfUsl4OZ7fFWWPlRIeJ/3mXU2j9410Iw=;
  b=Y98T/mHqfnV4fKaQkzlblHrG1pEj+GufdfrwGvhrX+NJZGHKyHhb8gLy
   gYRCtXHe2lDXD3SF6hnATHfNR09jXCUIz8H3dcg0cI6POpe9pJOi8PNOI
   lif0PAb7rCmXzH1HFPSymiDuUHkuimZNkMqy9rpC8ju4hkBmYLT7t8Ptj
   kmnrqBotKPtw6yyVk2qAcuXZA22/vjnR1FGEbG5JNnIcRelDpemjBnJht
   bKFsZyfn2zAZxBBn72Js3UHvi1WWytTwu7ASxttO0TjFnIVm9ol1DWBzp
   ej5vU2iVvqUKC27akiXN1ucKIQtOEWuilbAjQqqQpHPnszWaOk8KxX4Aj
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="459143082"
X-IronPort-AV: E=Sophos;i="6.04,270,1695711600"; 
   d="scan'208";a="459143082"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 07:56:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="766864623"
X-IronPort-AV: E=Sophos;i="6.04,270,1695711600"; 
   d="scan'208";a="766864623"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 07:56:17 -0800
Received: from [10.209.138.122] (kliang2-mobl1.ccr.corp.intel.com [10.209.138.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 6AB91580DC5;
        Tue, 12 Dec 2023 07:56:16 -0800 (PST)
Message-ID: <07677ab2-c29b-499b-b473-f7535fb27a8c@linux.intel.com>
Date:   Tue, 12 Dec 2023 10:56:15 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf top: Use evsel's cpus to replace user_requested_cpus
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     irogers@google.com, namhyung@kernel.org, mark.rutland@arm.com,
        maz@kernel.org, marcan@marcan.st, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
References: <20231208210855.407580-1-kan.liang@linux.intel.com>
 <ZXd7ZuxbNNsjAyqm@kernel.org>
Content-Language: en-US
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <ZXd7ZuxbNNsjAyqm@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-12-11 4:13 p.m., Arnaldo Carvalho de Melo wrote:
> Em Fri, Dec 08, 2023 at 01:08:55PM -0800, kan.liang@linux.intel.com escreveu:
>> From: Kan Liang <kan.liang@linux.intel.com>
>>
>> perf top errors out on a hybrid machine
>>  $perf top
>>
>>  Error:
>>  The cycles:P event is not supported.
>>
>> The user_requested_cpus may contain CPUs that are invalid for a hybrid
>> PMU. It causes perf_event_open to fail.
> 
> ?
> 
> All perf top expects is that the "cycles", the most basic one, be
> collected, on all CPUs in the system.
>

Yes, but for hybrid there is no single "cycles" event which can cover
all CPUs. Perf has to split it into two cycles events, cpu_core/cycles/
and cpu_atom/cycles/. Each event has its own CPU mask. If a event is
opened on the unsupported CPU. The open fails. That's the reason perf
top fails. So perf should only open the cycles event on the
corresponding CPU.

>> The commit ef91871c960e ("perf evlist: Propagate user CPU maps
>> intersecting core PMU maps") already intersect the requested CPU map
>> with the CPU map of the PMU. Use the evsel's cpus to replace
>> user_requested_cpus.
>  
>> The evlist's threads is also propagated to evsel's threads in
>> __perf_evlist__propagate_maps(). Replace it as well.
> 
> Thanks, but please try to add more detail to the fix so as to help
> others to consider looking at the patch.

OK. For the threads, the same as other tools, e.g., perf record, perf
appends a dummy for the system wide event. For a per-thread event, the
evlist's thread_map is assigned to the evsel. So using the evsel's
threads is appropriate and also be consistent with other tools.

I will update the description and send a V2.

Thanks,
Kan

> 
> - Arnaldo
>  
>> Reported-by: Arnaldo Carvalho de Melo <acme@kernel.org>
>> Closes: https://lore.kernel.org/linux-perf-users/ZXNnDrGKXbEELMXV@kernel.org/
>> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
>> ---
>>  tools/perf/builtin-top.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
>> index ea8c7eca5eee..cce9350177e2 100644
>> --- a/tools/perf/builtin-top.c
>> +++ b/tools/perf/builtin-top.c
>> @@ -1027,8 +1027,8 @@ static int perf_top__start_counters(struct perf_top *top)
>>  
>>  	evlist__for_each_entry(evlist, counter) {
>>  try_again:
>> -		if (evsel__open(counter, top->evlist->core.user_requested_cpus,
>> -				     top->evlist->core.threads) < 0) {
>> +		if (evsel__open(counter, counter->core.cpus,
>> +				counter->core.threads) < 0) {
>>  
>>  			/*
>>  			 * Specially handle overwrite fall back.
>> -- 
>> 2.35.1
>>
> 
