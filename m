Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF57780D86A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 19:45:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345445AbjLKSpZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 13:45:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345375AbjLKSpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 13:45:22 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B076AC;
        Mon, 11 Dec 2023 10:45:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702320328; x=1733856328;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=cptjvy+NwHQ+E4fcpou4LlAyfaL5P8r20mk0Sn0DCJE=;
  b=eL8/Tcd55lk0XubJyzHlS8nqGG/539RXEANx1cMzfDNzS2Pcm5RFsgu1
   A+mXBiiCzRd+NZhmOHUFN9bEq8puFdD6b5u0f1gE24GarO9DXHYUjcyRH
   I8BbAM3XtfG+mMhBIMWld0XQEaAKqg4gXPeNe9MoKPmmLh1/wIa7fJnkW
   XW/c78J8I38m5Ufd74zs4RTaN2Kc950HrGSxiuI2fwzT29H6doeKme+CJ
   uSVBajhVfxP1C3hOt7tfvwGj1qvy2kY/7IlbNSQkIrSkizBB4s3qSsjqy
   K+POEuLUYqKPmqE4EO7llzJn2Zzu9H1pUg0c84BXrh1FNP6Cxi8qCT9rC
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="1509693"
X-IronPort-AV: E=Sophos;i="6.04,268,1695711600"; 
   d="scan'208";a="1509693"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 10:45:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,268,1695711600"; 
   d="scan'208";a="21191879"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 10:45:28 -0800
Received: from [10.212.109.181] (kliang2-mobl1.ccr.corp.intel.com [10.212.109.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 8A7E4580DA9;
        Mon, 11 Dec 2023 10:45:24 -0800 (PST)
Message-ID: <ab399f36-bef6-4ff7-92b9-95ed873ce822@linux.intel.com>
Date:   Mon, 11 Dec 2023 13:45:24 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 5/5] perf mem: Clean up is_mem_loads_aux_event()
To:     Leo Yan <leo.yan@linaro.org>
Cc:     acme@kernel.org, irogers@google.com, peterz@infradead.org,
        mingo@redhat.com, namhyung@kernel.org, jolsa@kernel.org,
        adrian.hunter@intel.com, john.g.garry@oracle.com, will@kernel.org,
        james.clark@arm.com, mike.leach@linaro.org,
        yuhaixin.yhx@linux.alibaba.com, renyu.zj@linux.alibaba.com,
        tmricht@linux.ibm.com, ravi.bangoria@amd.com,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20231207192338.400336-1-kan.liang@linux.intel.com>
 <20231207192338.400336-6-kan.liang@linux.intel.com>
 <20231209062709.GD2116834@leoy-yangtze.lan>
Content-Language: en-US
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20231209062709.GD2116834@leoy-yangtze.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-12-09 1:27 a.m., Leo Yan wrote:
> On Thu, Dec 07, 2023 at 11:23:38AM -0800, kan.liang@linux.intel.com wrote:
>> From: Kan Liang <kan.liang@linux.intel.com>
>>
>> The aux_event can be retrieved from the perf_pmu now. Implement a
>> generic support.
>>
>> Reviewed-by: Ian Rogers <irogers@google.com>
>> Tested-by: Ravi Bangoria <ravi.bangoria@amd.com>
>> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
>> ---
>>  tools/perf/arch/x86/util/mem-events.c | 23 ++++-------------------
>>  tools/perf/util/mem-events.c          | 14 ++++++++++++--
>>  2 files changed, 16 insertions(+), 21 deletions(-)
>>
>> diff --git a/tools/perf/arch/x86/util/mem-events.c b/tools/perf/arch/x86/util/mem-events.c
>> index b776d849fc64..62df03e91c7e 100644
>> --- a/tools/perf/arch/x86/util/mem-events.c
>> +++ b/tools/perf/arch/x86/util/mem-events.c
>> @@ -1,11 +1,9 @@
>>  // SPDX-License-Identifier: GPL-2.0
>> -#include "util/pmu.h"
>> -#include "util/pmus.h"
>> -#include "util/env.h"
>> -#include "map_symbol.h"
>> -#include "mem-events.h"
>>  #include "linux/string.h"
>> -#include "env.h"
>> +#include "util/map_symbol.h"
>> +#include "util/mem-events.h"
>> +#include "mem-events.h"
>> +
>>  
>>  #define MEM_LOADS_AUX		0x8203
>>  
>> @@ -28,16 +26,3 @@ struct perf_mem_event perf_mem_events_amd[PERF_MEM_EVENTS__MAX] = {
>>  	E(NULL,		NULL,		NULL,	false,	0),
>>  	E("mem-ldst",	"%s//",		NULL,	false,	0),
>>  };
>> -
>> -bool is_mem_loads_aux_event(struct evsel *leader)
>> -{
>> -	struct perf_pmu *pmu = perf_pmus__find("cpu");
>> -
>> -	if (!pmu)
>> -		pmu = perf_pmus__find("cpu_core");
>> -
>> -	if (pmu && !perf_pmu__have_event(pmu, "mem-loads-aux"))
>> -		return false;
>> -
>> -	return leader->core.attr.config == MEM_LOADS_AUX;
>> -}
>> diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
>> index 0d174f161034..d418320e52e3 100644
>> --- a/tools/perf/util/mem-events.c
>> +++ b/tools/perf/util/mem-events.c
>> @@ -103,9 +103,19 @@ static const char *perf_pmu__mem_events_name(int i, struct perf_pmu *pmu)
>>  	return NULL;
>>  }
>>  
>> -__weak bool is_mem_loads_aux_event(struct evsel *leader __maybe_unused)
>> +bool is_mem_loads_aux_event(struct evsel *leader)
>>  {
>> -	return false;
>> +	struct perf_pmu *pmu = leader->pmu;
>> +	struct perf_mem_event *e;
>> +
>> +	if (!pmu || !pmu->mem_events)
>> +		return false;
>> +
>> +	e = &pmu->mem_events[PERF_MEM_EVENTS__LOAD];
>> +	if (!e->aux_event)
>> +		return false;
>> +
>> +	return leader->core.attr.config == e->aux_event;
>>  }
> 
> I am wandering if we need to set the field 'aux_event' for Arm SPE.
> 
> So a quesiton maybe is not relevant with this patch actually, we can
> see is_mem_loads_aux_event() is invoked in the file util/record.c:
> 
>   static struct evsel *evsel__read_sampler(struct evsel *evsel, struct evlist *evlist)
>   {
>           struct evsel *leader = evsel__leader(evsel);
> 
>           if (evsel__is_aux_event(leader) || arch_topdown_sample_read(leader) ||
>               is_mem_loads_aux_event(leader)) {
>               ...
>           }
>   
>           return leader;
>   }
> 
> Has evsel__is_aux_event() covered the memory load aux event?  If it's,
> then is_mem_loads_aux_event() is not needed anymore.

They are two different things. The evsel__is_aux_event() should means an
event requires AUX area, like intel_pt.

While the aux event for the mem_loads event is an extra event which has
to be scheduled together with the mem_loads event when sampling. It's
only available for some Intel platforms, e.g., SPR.

Thanks,
Kan
> 
> Thanks,
> Leo
