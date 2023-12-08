Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7B9380ABD5
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 19:15:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574516AbjLHSPL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 13:15:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233799AbjLHSO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 13:14:59 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 213D22135;
        Fri,  8 Dec 2023 10:14:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702059274; x=1733595274;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=S0DU6UXRnqkwipMQJ+g0tYyAb8FzOeAi6xMp0rCqaJY=;
  b=LsQI8hDdxm2whJoiTrYdACZyxGZXrUmIa3435B4I6dpbwXcNL6G7RinX
   S9ioTk+OhVETHChUVh9Jw4V8HcpuwNhHBuU7OHiNGBqkEgS6S0GHhYkyF
   hg7bbHkNVLCWiNA6rH9MEvseWQPls3H0b+gsG9Tq/06Xx3CHa+c0Dg8yP
   L2dRTC5++NWzXXisf4QMZFqiIoXWYsFxtB4LkvyliBY73Iha3v6J8l4wi
   axTXF0Nd9vcK3e8zQj0ZU+pU1d7ZU390jl2uxsny/2PK63K6QQxijKb+0
   Ph+PyumENXb3w91zGDo4Yt8HwsBJHMJIRLNzBmGVj6zYA0nuynByOdi5p
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10918"; a="373945582"
X-IronPort-AV: E=Sophos;i="6.04,261,1695711600"; 
   d="scan'208";a="373945582"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2023 10:14:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10918"; a="1103644637"
X-IronPort-AV: E=Sophos;i="6.04,261,1695711600"; 
   d="scan'208";a="1103644637"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2023 10:14:32 -0800
Received: from [10.212.91.62] (unknown [10.212.91.62])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id C7F4D580DA9;
        Fri,  8 Dec 2023 10:14:29 -0800 (PST)
Message-ID: <98863f44-4a35-4910-8db0-dbbf0474f6ae@linux.intel.com>
Date:   Fri, 8 Dec 2023 13:14:28 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 1/5] perf mem: Add mem_events into the supported
 perf_pmu
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
 <20231207192338.400336-2-kan.liang@linux.intel.com>
 <20231208102922.GB769184@leoy-huanghe.lan>
Content-Language: en-US
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20231208102922.GB769184@leoy-huanghe.lan>
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



On 2023-12-08 5:29 a.m., Leo Yan wrote:
> On Thu, Dec 07, 2023 at 11:23:34AM -0800, kan.liang@linux.intel.com wrote:
>> From: Kan Liang <kan.liang@linux.intel.com>
>>
>> With the mem_events, perf doesn't need to read sysfs for each PMU to
>> find the mem-events-supported PMU. The patch also makes it possible to
>> clean up the related __weak functions later.
>>
>> The patch is only to add the mem_events into the perf_pmu for all ARCHs.
>> It will be used in the later cleanup patches.
>>
>> Reviewed-by: Ian Rogers <irogers@google.com>
>> Tested-by: Ravi Bangoria <ravi.bangoria@amd.com>
>> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
>> ---
>>  tools/perf/arch/arm64/util/mem-events.c | 4 ++--
>>  tools/perf/arch/arm64/util/mem-events.h | 7 +++++++
>>  tools/perf/arch/arm64/util/pmu.c        | 6 ++++++
>>  tools/perf/arch/s390/util/pmu.c         | 3 +++
>>  tools/perf/arch/x86/util/mem-events.c   | 4 ++--
>>  tools/perf/arch/x86/util/mem-events.h   | 9 +++++++++
>>  tools/perf/arch/x86/util/pmu.c          | 7 +++++++
>>  tools/perf/util/mem-events.c            | 2 +-
>>  tools/perf/util/mem-events.h            | 1 +
>>  tools/perf/util/pmu.c                   | 4 +++-
>>  tools/perf/util/pmu.h                   | 7 +++++++
>>  11 files changed, 48 insertions(+), 6 deletions(-)
>>  create mode 100644 tools/perf/arch/arm64/util/mem-events.h
>>  create mode 100644 tools/perf/arch/x86/util/mem-events.h
>>
>> diff --git a/tools/perf/arch/arm64/util/mem-events.c b/tools/perf/arch/arm64/util/mem-events.c
>> index 3bcc5c7035c2..aaa4804922b4 100644
>> --- a/tools/perf/arch/arm64/util/mem-events.c
>> +++ b/tools/perf/arch/arm64/util/mem-events.c
>> @@ -4,7 +4,7 @@
>>  
>>  #define E(t, n, s) { .tag = t, .name = n, .sysfs_name = s }
>>  
>> -static struct perf_mem_event perf_mem_events[PERF_MEM_EVENTS__MAX] = {
>> +struct perf_mem_event perf_mem_events_arm[PERF_MEM_EVENTS__MAX] = {
>>  	E("spe-load",	"arm_spe_0/ts_enable=1,pa_enable=1,load_filter=1,store_filter=0,min_latency=%u/",	"arm_spe_0"),
>>  	E("spe-store",	"arm_spe_0/ts_enable=1,pa_enable=1,load_filter=0,store_filter=1/",			"arm_spe_0"),
>>  	E("spe-ldst",	"arm_spe_0/ts_enable=1,pa_enable=1,load_filter=1,store_filter=1,min_latency=%u/",	"arm_spe_0"),
>> @@ -17,7 +17,7 @@ struct perf_mem_event *perf_mem_events__ptr(int i)
>>  	if (i >= PERF_MEM_EVENTS__MAX)
>>  		return NULL;
>>  
>> -	return &perf_mem_events[i];
>> +	return &perf_mem_events_arm[i];
> 
> I recognized that it's hard code to "arm_spe_0", which might break if
> system registers different Arm SPE groups.  But this is not the issue
> introduced by this patch, we might need to consider to fix it later.
> 
>>  }
>>  
>>  const char *perf_mem_events__name(int i, const char *pmu_name __maybe_unused)
>> diff --git a/tools/perf/arch/arm64/util/mem-events.h b/tools/perf/arch/arm64/util/mem-events.h
>> new file mode 100644
>> index 000000000000..5fc50be4be38
>> --- /dev/null
>> +++ b/tools/perf/arch/arm64/util/mem-events.h
>> @@ -0,0 +1,7 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +#ifndef _ARM64_MEM_EVENTS_H
>> +#define _ARM64_MEM_EVENTS_H
>> +
>> +extern struct perf_mem_event perf_mem_events_arm[PERF_MEM_EVENTS__MAX];
>> +
>> +#endif /* _ARM64_MEM_EVENTS_H */
>> diff --git a/tools/perf/arch/arm64/util/pmu.c b/tools/perf/arch/arm64/util/pmu.c
>> index 2a4eab2d160e..06ec9b838807 100644
>> --- a/tools/perf/arch/arm64/util/pmu.c
>> +++ b/tools/perf/arch/arm64/util/pmu.c
>> @@ -8,6 +8,12 @@
>>  #include <api/fs/fs.h>
>>  #include <math.h>
>>  
>> +void perf_pmu__arch_init(struct perf_pmu *pmu)
>> +{
>> +	if (!strcmp(pmu->name, "arm_spe_0"))
>> +		pmu->mem_events = perf_mem_events_arm;
> 
> This is not right and it should cause building failure on aarch64.
> 
> aarch64 reuses aarch32's file arch/arm/util/pmu.c, and this file has
> already defined perf_pmu__arch_init(), you should add above change in
> the file arch/arm/util/pmu.c.
> 

Sure.

> Now I cannot access a machine for testing Arm SPE, but I will play
> a bit for this patch set to ensure it can pass compilation.  After
> that, I will seek Arm maintainers/reviewers help for the test.
>

Thanks. I guess I will hold the v3 until the test is done in case there
are other issues found in ARM.

Thanks,
Kan
