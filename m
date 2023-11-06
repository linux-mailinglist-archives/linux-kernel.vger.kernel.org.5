Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57F997E2ED4
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 22:19:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233106AbjKFVTV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 16:19:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232527AbjKFVTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 16:19:20 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31CEEAF
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 13:19:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699305557; x=1730841557;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=mpCWcrut8F62PbVYjjL5lHvEe1d7GJoXVDQ8V9vdBdQ=;
  b=nj+Ca+uQFenqHKojku1/DxxmXDzDMuAiUuXWCM2pOfsvvwLhslJGmtQu
   2hwOS9SkZCed2oDDHH++z31+TD8k8NOj/S4on2VhvZ3+8Lz9+PvUSJqtk
   rxnQ7Ubd082dyMByfpaYdAwrt4Yk4owp/SamcrayOT2Deg8DrDiFg+TnH
   6EdNHyDm3g1r1ZEG7BEmGUIOWtREECOyBjMI+MW+6ySAAlU5St7oeGrTW
   4mw5GHsnFKenD1f3SBPqGEjJE2R5LH6U26n8NcOkwtoaCC0TPm/PINeG6
   GXaJtK0u5bL6B9sYY21YathVf1pJmf0y/tHY0oys/hPkxxJaZ1leKjRrs
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10886"; a="10911431"
X-IronPort-AV: E=Sophos;i="6.03,282,1694761200"; 
   d="scan'208";a="10911431"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 13:19:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10886"; a="755964159"
X-IronPort-AV: E=Sophos;i="6.03,282,1694761200"; 
   d="scan'208";a="755964159"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 13:19:16 -0800
Received: from [10.212.114.233] (kliang2-mobl1.ccr.corp.intel.com [10.212.114.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 91DF7580D4E;
        Mon,  6 Nov 2023 13:19:14 -0800 (PST)
Message-ID: <fb1ebf48-ac2f-499a-b480-ba8474b12200@linux.intel.com>
Date:   Mon, 6 Nov 2023 16:19:13 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 2/8] perf/x86: Add PERF_X86_EVENT_NEEDS_BRANCH_STACK
 flag
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, irogers@google.com, adrian.hunter@intel.com,
        ak@linux.intel.com, eranian@google.com,
        alexey.v.bayduraev@linux.intel.com, tinghao.zhang@intel.com
References: <20231025201626.3000228-1-kan.liang@linux.intel.com>
 <20231025201626.3000228-2-kan.liang@linux.intel.com>
 <ZUlWuROfYcYJlRn4@kernel.org>
Content-Language: en-US
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <ZUlWuROfYcYJlRn4@kernel.org>
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



On 2023-11-06 4:12 p.m., Arnaldo Carvalho de Melo wrote:
> Em Wed, Oct 25, 2023 at 01:16:20PM -0700, kan.liang@linux.intel.com escreveu:
>> From: Kan Liang <kan.liang@linux.intel.com>
>>
>> Currently, branch_sample_type !=0 is used to check whether a branch
>> stack setup is required. But it doesn't check the sample type,
>> unnecessary branch stack setup may be done for a counting event. E.g.,
>> perf record -e "{branch-instructions,branch-misses}:S" -j any
>> Also, the event only with the new PERF_SAMPLE_BRANCH_COUNTERS branch
>> sample type may not require a branch stack setup either.
>>
>> Add a new flag NEEDS_BRANCH_STACK to indicate whether the event requires
>> a branch stack setup. Replace the needs_branch_stack() by checking the
>> new flag.
>>
>> The counting event check is implemented here. The later patch will take
>> the new PERF_SAMPLE_BRANCH_COUNTERS into account.
>>
>> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
>> ---
>>
>> No changes since V4
> 
> So I saw this on tip/perf/urgent, I'm picking the tools bits then.

Thanks Arnaldo.

Ian has already reviewed the tool parts.

But I still owe a test case for the feature. I will post a patch later.
https://lore.kernel.org/lkml/acbb895a-475e-4679-98fc-6b90c05a00af@linux.intel.com/

Thanks,
Kan

> 
> - Arnaldo
>  
>>  arch/x86/events/intel/core.c       | 14 +++++++++++---
>>  arch/x86/events/perf_event_flags.h |  1 +
>>  2 files changed, 12 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
>> index 41a164764a84..a99449c0d77c 100644
>> --- a/arch/x86/events/intel/core.c
>> +++ b/arch/x86/events/intel/core.c
>> @@ -2527,9 +2527,14 @@ static void intel_pmu_assign_event(struct perf_event *event, int idx)
>>  		perf_report_aux_output_id(event, idx);
>>  }
>>  
>> +static __always_inline bool intel_pmu_needs_branch_stack(struct perf_event *event)
>> +{
>> +	return event->hw.flags & PERF_X86_EVENT_NEEDS_BRANCH_STACK;
>> +}
>> +
>>  static void intel_pmu_del_event(struct perf_event *event)
>>  {
>> -	if (needs_branch_stack(event))
>> +	if (intel_pmu_needs_branch_stack(event))
>>  		intel_pmu_lbr_del(event);
>>  	if (event->attr.precise_ip)
>>  		intel_pmu_pebs_del(event);
>> @@ -2820,7 +2825,7 @@ static void intel_pmu_add_event(struct perf_event *event)
>>  {
>>  	if (event->attr.precise_ip)
>>  		intel_pmu_pebs_add(event);
>> -	if (needs_branch_stack(event))
>> +	if (intel_pmu_needs_branch_stack(event))
>>  		intel_pmu_lbr_add(event);
>>  }
>>  
>> @@ -3897,7 +3902,10 @@ static int intel_pmu_hw_config(struct perf_event *event)
>>  			x86_pmu.pebs_aliases(event);
>>  	}
>>  
>> -	if (needs_branch_stack(event)) {
>> +	if (needs_branch_stack(event) && is_sampling_event(event))
>> +		event->hw.flags  |= PERF_X86_EVENT_NEEDS_BRANCH_STACK;
>> +
>> +	if (intel_pmu_needs_branch_stack(event)) {
>>  		ret = intel_pmu_setup_lbr_filter(event);
>>  		if (ret)
>>  			return ret;
>> diff --git a/arch/x86/events/perf_event_flags.h b/arch/x86/events/perf_event_flags.h
>> index 1dc19b9b4426..a1685981c520 100644
>> --- a/arch/x86/events/perf_event_flags.h
>> +++ b/arch/x86/events/perf_event_flags.h
>> @@ -20,3 +20,4 @@ PERF_ARCH(TOPDOWN,		0x04000) /* Count Topdown slots/metrics events */
>>  PERF_ARCH(PEBS_STLAT,		0x08000) /* st+stlat data address sampling */
>>  PERF_ARCH(AMD_BRS,		0x10000) /* AMD Branch Sampling */
>>  PERF_ARCH(PEBS_LAT_HYBRID,	0x20000) /* ld and st lat for hybrid */
>> +PERF_ARCH(NEEDS_BRANCH_STACK,	0x40000) /* require branch stack setup */
>> -- 
>> 2.35.1
>>
> 
