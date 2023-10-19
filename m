Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 016CF7CFBD3
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 15:58:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345867AbjJSN6a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 09:58:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345616AbjJSN61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 09:58:27 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E0E2B0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 06:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697723906; x=1729259906;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=HttYoGHdwVXHwuQOv7yk6b2XhuP1nklhkcCtI6dN/8A=;
  b=k08N7j849oaUJDwo4hGk4eTC6uFk+d93itV0kq/YnngpUkdGGu+cP1cv
   Cvd6nlQ5ag+w0yJuHnCUit739vHNEAUHCEzbU1i/v7FJyiNQ+DC7HG2ck
   ZBc/On00kqob5Wl6DUWq78rKQYyynFH0iqyRN+iE/j3SQFE2hn0QevXxz
   XaSivR/rTUTUL5Kvg4bQcv79Y1iEo1PqoFUDMVO5Dweg6i/7QPobB5x0m
   +upIrUsLuvwWklxSigFpBcTR8WpCqyTU1C5NNn/324VqW4f1VFytYahiP
   MouZxI6Qqp0V30nQWvLVC/jh/+2RWD0ihOXTKJHBYiMWB7qtQcyXc/IM7
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="7818628"
X-IronPort-AV: E=Sophos;i="6.03,237,1694761200"; 
   d="scan'208";a="7818628"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2023 06:56:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="733574790"
X-IronPort-AV: E=Sophos;i="6.03,237,1694761200"; 
   d="scan'208";a="733574790"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2023 06:56:05 -0700
Received: from [10.212.5.13] (kliang2-mobl1.ccr.corp.intel.com [10.212.5.13])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 0D986580D4F;
        Thu, 19 Oct 2023 06:56:03 -0700 (PDT)
Message-ID: <86df1293-c20b-4292-abde-852861dcedf1@linux.intel.com>
Date:   Thu, 19 Oct 2023 09:56:02 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 4/7] perf/x86/intel: Support LBR event logging
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, acme@kernel.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, irogers@google.com,
        adrian.hunter@intel.com, ak@linux.intel.com, eranian@google.com,
        alexey.v.bayduraev@linux.intel.com, tinghao.zhang@intel.com
References: <20231004184044.3062788-1-kan.liang@linux.intel.com>
 <20231004184044.3062788-4-kan.liang@linux.intel.com>
 <20231019092341.GE36211@noisy.programming.kicks-ass.net>
Content-Language: en-US
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20231019092341.GE36211@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-10-19 5:23 a.m., Peter Zijlstra wrote:
> On Wed, Oct 04, 2023 at 11:40:41AM -0700, kan.liang@linux.intel.com wrote:
> 
>> diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
>> index c3b0d15a9841..1e80a551a4c2 100644
>> --- a/arch/x86/events/intel/lbr.c
>> +++ b/arch/x86/events/intel/lbr.c
>> @@ -676,6 +676,21 @@ void intel_pmu_lbr_del(struct perf_event *event)
>>  	WARN_ON_ONCE(cpuc->lbr_users < 0);
>>  	WARN_ON_ONCE(cpuc->lbr_pebs_users < 0);
>>  	perf_sched_cb_dec(event->pmu);
>> +
>> +	/*
>> +	 * The logged occurrences information is only valid for the
>> +	 * current LBR group. If another LBR group is scheduled in
>> +	 * later, the information from the stale LBRs will be wrongly
>> +	 * interpreted. Reset the LBRs here.
>> +	 * For the context switch, the LBR will be unconditionally
>> +	 * flushed when a new task is scheduled in. If both the new task
>> +	 * and the old task are monitored by a LBR event group. The
>> +	 * reset here is redundant. But the extra reset doesn't impact
>> +	 * the functionality. It's hard to distinguish the above case.
>> +	 * Keep the unconditionally reset for a LBR event group for now.
>> +	 */
> 
> I found this really hard to read, also should this not rely on
> !cpuc->lbr_users ?
>

It's possible that the last LBR user is not in the branch_counters
group, e.g., a branch_counters group + several normal LBR events.
For this case, the is_branch_counters_group(event) return false for the
last LBR user. The LBR will not be reset.

> As is, you'll reset the lbr for every event in the group.
> 
>> +	if (is_branch_counters_group(event))
>> +		intel_pmu_lbr_reset();
>>  }

Right, I forgot to change it after I modified flag. :(

Here I think we should only clear the LBRs once for a branch_counters
group, e.g., in the leader event.

+	if (is_branch_counters_group(event) && event == event->group_leader)+	
intel_pmu_lbr_reset();

The only problem is that the leader event may not be an LBR event. But I
guess it should be OK to limit that the leader event of a
branch_counters group must be an LBR event in hw_config().

Thanks,
Kan
