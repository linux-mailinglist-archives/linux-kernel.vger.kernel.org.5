Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B204680D4FA
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 19:09:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345273AbjLKSJg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 13:09:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345261AbjLKSJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 13:09:35 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8570999;
        Mon, 11 Dec 2023 10:09:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702318181; x=1733854181;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ghjTfbSH+fXK6Gs9YVXjvfTHrHTvBn/enjq1gPsZCAE=;
  b=amz4IF/bG74OltUaqDkL0y2xQ9DPlyn57/22xoH0I7qW54Ju77kGc9a5
   MDl/y24yb8LbSo1z7qDOf9m7C0EeppjexdVscpKNR9UIhV++EXSlqe6Kl
   uHLJ2vjFFql8FZK010hwSU3VJ0yKbZjKUSkc6g0V5Yi6AArxS53W/AU36
   thXnEkZmiPvwUMu8cDbv3jJwmAe7rmf/v8b9ENGOry508fatBkhXDY6a3
   3oJwqXVcJlFPGSMP1AMOf5ojXVcLAw5Gt1QlP+ph9B61DaHIEzcWc5TKR
   7Q9iuHW5pzXWVsSgmXW1l4GsJtiNW/f09R8NERModyza9Fz5Yz+jnU46L
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="398538690"
X-IronPort-AV: E=Sophos;i="6.04,268,1695711600"; 
   d="scan'208";a="398538690"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 10:09:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="1020337252"
X-IronPort-AV: E=Sophos;i="6.04,268,1695711600"; 
   d="scan'208";a="1020337252"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 10:09:40 -0800
Received: from [10.212.109.181] (unknown [10.212.109.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 785D9580DA9;
        Mon, 11 Dec 2023 10:09:36 -0800 (PST)
Message-ID: <2a3caf68-3a84-4963-aa61-3063d12c4c2a@linux.intel.com>
Date:   Mon, 11 Dec 2023 13:09:34 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 2/5] perf mem: Clean up perf_mem_events__ptr()
Content-Language: en-US
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
 <20231207192338.400336-3-kan.liang@linux.intel.com>
 <20231209043135.GA2116834@leoy-yangtze.lan>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20231209043135.GA2116834@leoy-yangtze.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-12-08 11:31 p.m., Leo Yan wrote:
> On Thu, Dec 07, 2023 at 11:23:35AM -0800, kan.liang@linux.intel.com wrote:
>> From: Kan Liang <kan.liang@linux.intel.com>
>>
>> The mem_events can be retrieved from the struct perf_pmu now. An ARCH
>> specific perf_mem_events__ptr() is not required anymore. Remove all of
>> them.
>>
>> The Intel hybrid has multiple mem-events-supported PMUs. But they share
>> the same mem_events. Other ARCHs only support one mem-events-supported
>> PMU. In the configuration, it's good enough to only configure the
>> mem_events for one PMU. Add perf_mem_events_find_pmu() which returns the
>> first mem-events-supported PMU.
>>
>> In the perf_mem_events__init(), the perf_pmus__scan() is not required
>> anymore. It avoids checking the sysfs for every PMU on the system.
>>
>> Make the perf_mem_events__record_args() more generic. Remove the
>> perf_mem_events__print_unsupport_hybrid().
>>
>> Since pmu is added as a new parameter, rename perf_mem_events__ptr() to
>> perf_pmu__mem_events_ptr(). Several other functions also do a similar
>> rename.
>>
>> Reviewed-by: Ian Rogers <irogers@google.com>
>> Tested-by: Ravi Bangoria <ravi.bangoria@amd.com>
>> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
>> ---
>>  tools/perf/arch/arm64/util/mem-events.c |  10 +--
>>  tools/perf/arch/x86/util/mem-events.c   |  18 ++---
>>  tools/perf/builtin-c2c.c                |  28 +++++--
>>  tools/perf/builtin-mem.c                |  28 +++++--
>>  tools/perf/util/mem-events.c            | 103 ++++++++++++------------
>>  tools/perf/util/mem-events.h            |   9 ++-
>>  6 files changed, 104 insertions(+), 92 deletions(-)
>>
>> diff --git a/tools/perf/arch/arm64/util/mem-events.c b/tools/perf/arch/arm64/util/mem-events.c
>> index aaa4804922b4..2602e8688727 100644
>> --- a/tools/perf/arch/arm64/util/mem-events.c
>> +++ b/tools/perf/arch/arm64/util/mem-events.c
>> @@ -12,17 +12,9 @@ struct perf_mem_event perf_mem_events_arm[PERF_MEM_EVENTS__MAX] = {
>>  
>>  static char mem_ev_name[100];
>>  
>> -struct perf_mem_event *perf_mem_events__ptr(int i)
>> -{
>> -	if (i >= PERF_MEM_EVENTS__MAX)
>> -		return NULL;
>> -
>> -	return &perf_mem_events_arm[i];
>> -}
>> -
>>  const char *perf_mem_events__name(int i, const char *pmu_name __maybe_unused)
>>  {
>> -	struct perf_mem_event *e = perf_mem_events__ptr(i);
>> +	struct perf_mem_event *e = &perf_mem_events_arm[i];
>>  
>>  	if (i >= PERF_MEM_EVENTS__MAX)
>>  		return NULL;
> 
> Nitpick: it's good to check if 'i' is a valid value and then access the
> array with a valid index.
> 
>         if (i >= PERF_MEM_EVENTS__MAX)
>                 return NULL;
> 
>         e = &perf_mem_events_arm[i];
> 
>> diff --git a/tools/perf/arch/x86/util/mem-events.c b/tools/perf/arch/x86/util/mem-events.c
>> index 2b81d229982c..5fb41d50118d 100644
>> --- a/tools/perf/arch/x86/util/mem-events.c
>> +++ b/tools/perf/arch/x86/util/mem-events.c
>> @@ -28,17 +28,6 @@ struct perf_mem_event perf_mem_events_amd[PERF_MEM_EVENTS__MAX] = {
>>  	E("mem-ldst",	"ibs_op//",	"ibs_op"),
>>  };
>>  
>> -struct perf_mem_event *perf_mem_events__ptr(int i)
>> -{
>> -	if (i >= PERF_MEM_EVENTS__MAX)
>> -		return NULL;
>> -
>> -	if (x86__is_amd_cpu())
>> -		return &perf_mem_events_amd[i];
>> -
>> -	return &perf_mem_events_intel[i];
>> -}
>> -
>>  bool is_mem_loads_aux_event(struct evsel *leader)
>>  {
>>  	struct perf_pmu *pmu = perf_pmus__find("cpu");
>> @@ -54,7 +43,12 @@ bool is_mem_loads_aux_event(struct evsel *leader)
>>  
>>  const char *perf_mem_events__name(int i, const char *pmu_name)
>>  {
>> -	struct perf_mem_event *e = perf_mem_events__ptr(i);
>> +	struct perf_mem_event *e;
> 
> A nitpick as well:
> 
> Given perf's mem/c2c, callers will almostly invoke a valid index via the
> argument 'i', but I still think here is a best place to return NULL
> pointer for an invalid index rather than returning a wild pointer.
> 
> Thus I suggest to apply checking for x86 and other archs:
> 
>         if (i >= PERF_MEM_EVENTS__MAX)
>                 return NULL;
> 
>> +
>> +	if (x86__is_amd_cpu())
>> +		e = &perf_mem_events_amd[i];
>> +	else
>> +		e = &perf_mem_events_intel[i];
>>  
>>  	if (!e)
>>  		return NULL;
> 
> [...]
> 
>>  int perf_mem_events__record_args(const char **rec_argv, int *argv_nr,
>>  				 char **rec_tmp, int *tmp_nr)
>>  {
>>  	const char *mnt = sysfs__mount();
>> +	struct perf_pmu *pmu = NULL;
>>  	int i = *argv_nr, k = 0;
>>  	struct perf_mem_event *e;
>>  
>> -	for (int j = 0; j < PERF_MEM_EVENTS__MAX; j++) {
>> -		e = perf_mem_events__ptr(j);
>> -		if (!e->record)
>> -			continue;
>>  
>> -		if (perf_pmus__num_mem_pmus() == 1) {
>> -			if (!e->supported) {
>> -				pr_err("failed: event '%s' not supported\n",
>> -				       perf_mem_events__name(j, NULL));
>> -				return -1;
>> -			}
>> +	while ((pmu = perf_pmus__scan_mem(pmu)) != NULL) {
>> +		for (int j = 0; j < PERF_MEM_EVENTS__MAX; j++) {
>> +			e = perf_pmu__mem_events_ptr(pmu, j);
>>  
>> -			rec_argv[i++] = "-e";
>> -			rec_argv[i++] = perf_mem_events__name(j, NULL);
>> -		} else {
>> -			struct perf_pmu *pmu = NULL;
>> +			if (!e->record)
>> +				continue;
>>  
>>  			if (!e->supported) {
>> -				perf_mem_events__print_unsupport_hybrid(e, j);
>> +				pr_err("failed: event '%s' not supported\n",
>> +					perf_mem_events__name(j, pmu->name));
>>  				return -1;
>>  			}
>>  
>> -			while ((pmu = perf_pmus__scan(pmu)) != NULL) {
>> +			if (perf_pmus__num_mem_pmus() == 1) {
>> +				rec_argv[i++] = "-e";
>> +				rec_argv[i++] = perf_mem_events__name(j, NULL);
>> +			} else {
>>  				const char *s = perf_mem_events__name(j, pmu->name);
>>  
>>  				if (!perf_mem_event__supported(mnt, pmu, e))
> 
> I think we can improve a bit for this part.
> 
> Current implementation uses perf_pmus__num_mem_pmus() to decide if
> system has only one memory PMU or multiple PMUs, and multiple PMUs
> the tool iterates all memory PMUs to synthesize event options.
> 
> In this patch, it has changed to iterate all memory PMUs, no matter the
> system has only one memory PMU or multiple PMUs. Thus, I don't see the
> point for the condition checking for "perf_pmus__num_mem_pmus() == 1".
> We can consolidate into the unified code like:

Yep, I think it's doable. Also, it seems we can further clean up the
perf_pmus__num_mem_pmus(), which is a __weak function now.

It seems we just need to change the perf_mem_events_find_pmu() a little
bit and let it give both the first mem_events_pmu and the number of
mem_pmus.
> 
>         char *copy;
>         const char *s = perf_pmu__mem_events_name(j, pmu);
> 
>         if (!s)
>                 continue;
> 
>         if (!perf_pmu__mem_events_supported(mnt, pmu, e))
>                 continue;
> 
>         copy = strdup(s);
>         if (!copy)
>                 return -1;
> 
>         rec_argv[i++] = "-e";
>         rec_argv[i++] = copy;
>         rec_tmp[k++] = copy;

Not sure what's the rec_tmp for. It seems no one use it.
I will try if it can be removed.

Thanks,
Kan

> 
> Thanks,
> Leo
