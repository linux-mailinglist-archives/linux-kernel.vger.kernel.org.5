Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38A2180D77F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 19:39:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345353AbjLKSji (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 13:39:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345268AbjLKSjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 13:39:37 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F390DB4;
        Mon, 11 Dec 2023 10:39:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702319983; x=1733855983;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=h1hUWb9hEAZpwNxgC2q+0NMjKYHNn4ijwHf1rS2GGy0=;
  b=XuqjFJWSw99y2xtxjTI18fLqxBNqr2aC74AtxWrRgMRniIPh/lnCPuUC
   5ub7MED6l3S4fFKfDvJ7Go7LkgSlD4M9C4f0DUBUlBMjugUOA5KCasdl2
   ZBG/stJnYtobAgvScQ5eTSVd1FSoNvhvjM3Nmm0WnNsZo44e5zHDrGm+J
   I2cca38HHKst/EIzkAaagTrJUANm+7+pRtfyDyfLqKYYRQYao1G2Ty7I1
   SVMgwZxlqX1lWlDAdrlI87jiAYws1Nc0KrNvjgoBarT1WZ8dvrA82MKHH
   G43+64LVgwKzWp79brUD+gvasOSqxXgoYVa7icgyvwrruWcblow5d8M56
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="394441924"
X-IronPort-AV: E=Sophos;i="6.04,268,1695711600"; 
   d="scan'208";a="394441924"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 10:39:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="916951253"
X-IronPort-AV: E=Sophos;i="6.04,268,1695711600"; 
   d="scan'208";a="916951253"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 10:39:41 -0800
Received: from [10.212.109.181] (kliang2-mobl1.ccr.corp.intel.com [10.212.109.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 3A8E6580DC5;
        Mon, 11 Dec 2023 10:39:38 -0800 (PST)
Message-ID: <3b67c2de-741d-4d5e-8c8f-87b8b9e08825@linux.intel.com>
Date:   Mon, 11 Dec 2023 13:39:36 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 3/5] perf mem: Clean up perf_mem_events__name()
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
 <20231207192338.400336-4-kan.liang@linux.intel.com>
 <20231209054809.GB2116834@leoy-yangtze.lan>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20231209054809.GB2116834@leoy-yangtze.lan>
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



On 2023-12-09 12:48 a.m., Leo Yan wrote:
> On Thu, Dec 07, 2023 at 11:23:36AM -0800, kan.liang@linux.intel.com wrote:
>> From: Kan Liang <kan.liang@linux.intel.com>
>>
>> Introduce a generic perf_mem_events__name(). Remove the ARCH-specific
>> one.
> 
> Now memory event naming is arch dependent, this is because every arch
> has different memory PMU names, and it appends specific configurations
> (e.g. aarch64 appends 'ts_enable=1,...,min_latency=%u', and x86_64
> appends 'ldlat=%u', etc).  This is not friendly for extension, e.g. it's
> impossible for users to specify any extra attributes for memory events.
> 
> This patch tries to consolidate in a central place for generating memory
> event names, its approach is to add more flags to meet special usage
> cases, which means the code gets more complex (and more difficult for
> later's maintenance).
> 
> I think we need to distinguish the event naming into two levels: in
> util/mem-events.c, we can consider it as a common layer, and we maintain
> common options in it, e.g. 'latency', 'all-user', 'all-kernel',
> 'timestamp', 'physical_address', etc.  In every arch's mem-events.c
> file, it converts the common options to arch specific configurations.
> 
> In the end, this can avoid to add more and more flags into the
> structure perf_mem_event.

The purpose of this cleanup patch set is to remove the unnecessary
__weak functions, and try to make the code more generic.
The two flags has already covered all the current usage.
For now, it's good enough.

I agree that if there are more flags, it should not be a perfect
solution. But we don't have the third flag right now. Could we clean up
it later e.g., when introducing the third flag?

I just don't want to make the patch bigger and bigger. Also, I don't
think we usually implement something just for future possibilities.


> 
> Anyway, I also have a question for this patch itself, please see below
> inline comment.
> 
> [...]
> 
>> diff --git a/tools/perf/arch/arm64/util/mem-events.c b/tools/perf/arch/arm64/util/mem-events.c
>> index 2602e8688727..eb2ef84f0fc8 100644
>> --- a/tools/perf/arch/arm64/util/mem-events.c
>> +++ b/tools/perf/arch/arm64/util/mem-events.c
>> @@ -2,28 +2,10 @@
>>  #include "map_symbol.h"
>>  #include "mem-events.h"
>>  
>> -#define E(t, n, s) { .tag = t, .name = n, .sysfs_name = s }
>> +#define E(t, n, s, l, a) { .tag = t, .name = n, .sysfs_name = s, .ldlat = l, .aux_event = a }
>>  
>>  struct perf_mem_event perf_mem_events_arm[PERF_MEM_EVENTS__MAX] = {
>> -	E("spe-load",	"arm_spe_0/ts_enable=1,pa_enable=1,load_filter=1,store_filter=0,min_latency=%u/",	"arm_spe_0"),
>> -	E("spe-store",	"arm_spe_0/ts_enable=1,pa_enable=1,load_filter=0,store_filter=1/",			"arm_spe_0"),
>> -	E("spe-ldst",	"arm_spe_0/ts_enable=1,pa_enable=1,load_filter=1,store_filter=1,min_latency=%u/",	"arm_spe_0"),
>> +	E("spe-load",	"%s/ts_enable=1,pa_enable=1,load_filter=1,store_filter=0,min_latency=%u/",	"arm_spe_0",	true,	0),
>> +	E("spe-store",	"%s/ts_enable=1,pa_enable=1,load_filter=0,store_filter=1/",			"arm_spe_0",	false,	0),
>> +	E("spe-ldst",	"%s/ts_enable=1,pa_enable=1,load_filter=1,store_filter=1,min_latency=%u/",	"arm_spe_0",	true,	0),
> 
> Arm SPE is AUX event, should set '1' to the field '.aux_event'.

It actually means whether an extra event is required with a mem_loads
event.  I guess for ARM the answer is no.

> 
> I am a bit suspect if we really need the field '.aux_event', the
> '.aux_event' field is only used for generating event string.

No, it stores the event encoding for the extra event.
ARM doesn't need it, so it's 0.

> 
> So in the below function perf_pmu__mem_events_name(), I prefer to call
> an arch specific function, e.g. arch_memory_event_name(event_id, cfg),
> the parameter 'event_id' passes memory event ID for load, store, and
> load-store, and the parameter 'cfg' which is a pointer to the common
> memory options (as mentioned above for latency, all-user or all-kernel
> mode, timestamp tracing, etc).

If I understand correctly, I think we try to avoid the __weak function
for the perf tool. If there will be more parameters later, a mask may be
used for the parameters. But, again, I think it should be an improvement
for later.

Thanks,
Kan
> 
> In the end, the common layer just passes the common options to low
> level arch's layer and get a event string for recording.
> 
> Thanks,
> Leo
