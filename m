Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B6AC7CFCCE
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 16:33:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235448AbjJSOdd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 10:33:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235437AbjJSOdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 10:33:12 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF9461706
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 07:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697725970; x=1729261970;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=BD6tOgd5xXMhR4Ti7Oj9LMdEa7HxxgFUOFjS0EWxFt4=;
  b=YFkw81B6ECaZqWpCVxue9xETk646Mc0SfTHzfmr6rgYBHfb9A0/KZN+f
   MTubyFYA1RtaFEVl41kxLlZ7IZK9SZICA+hlx448BOAmdKqbrSFiib+fm
   atdIKe/EjDvVIvdePCVMi1tQ9auhp2BXtA4Ur76iHbDr2ubRcx7rydnJC
   afAywNLPw0sG1hbxirYtZWcbVXc7+3daIfInTavN5k4HC0TH5nRMLlBXA
   UDwamKfO8S1tNif5UnjAiOWacNhWS94kIt28ISOGsvhaambmOdGEYd5o4
   a+Dv76TWGjlFKdcj2rvdx/hnft/BmKSY/dYaFIAEFKZsS5QK2zRVAnqu8
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="383486268"
X-IronPort-AV: E=Sophos;i="6.03,237,1694761200"; 
   d="scan'208";a="383486268"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2023 07:31:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="792023482"
X-IronPort-AV: E=Sophos;i="6.03,237,1694761200"; 
   d="scan'208";a="792023482"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2023 07:31:52 -0700
Received: from [10.212.5.13] (kliang2-mobl1.ccr.corp.intel.com [10.212.5.13])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id E6232580BE3;
        Thu, 19 Oct 2023 07:31:50 -0700 (PDT)
Message-ID: <9d388599-8c7b-4461-be05-76a8b452fd26@linux.intel.com>
Date:   Thu, 19 Oct 2023 10:31:49 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 4/7] perf/x86/intel: Support LBR event logging
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, acme@kernel.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, irogers@google.com,
        adrian.hunter@intel.com, ak@linux.intel.com, eranian@google.com,
        alexey.v.bayduraev@linux.intel.com, tinghao.zhang@intel.com
References: <20231004184044.3062788-1-kan.liang@linux.intel.com>
 <20231004184044.3062788-4-kan.liang@linux.intel.com>
 <20231019110917.GI36211@noisy.programming.kicks-ass.net>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20231019110917.GI36211@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-10-19 7:09 a.m., Peter Zijlstra wrote:
> On Wed, Oct 04, 2023 at 11:40:41AM -0700, kan.liang@linux.intel.com wrote:
> 
>> @@ -3905,6 +3915,44 @@ static int intel_pmu_hw_config(struct perf_event *event)
>>  	if (needs_branch_stack(event) && is_sampling_event(event))
>>  		event->hw.flags  |= PERF_X86_EVENT_NEEDS_BRANCH_STACK;
>>  
>> +	if (branch_sample_counters(event)) {
>> +		struct perf_event *leader, *sibling;
>> +
>> +		if (!(x86_pmu.flags & PMU_FL_LBR_EVENT) ||
>> +		    (event->attr.config & ~INTEL_ARCH_EVENT_MASK))
>> +			return -EINVAL;
>> +
>> +		/*
>> +		 * The event logging is not supported in the call stack mode
>> +		 * yet, since we cannot simply flush the LBR during e.g.,
>> +		 * multiplexing. Also, there is no obvious usage with the call
>> +		 * stack mode. Simply forbids it for now.
>> +		 *
>> +		 * If any events in the group enable the LBR event logging
>> +		 * feature, the group is treated as a LBR event logging group,
>> +		 * which requires the extra space to store the counters.
>> +		 */
>> +		leader = event->group_leader;
>> +		if (branch_sample_call_stack(leader))
>> +			return -EINVAL;
>> +		leader->hw.flags  |= PERF_X86_EVENT_BRANCH_COUNTERS;
> 
> (superfluous whitespace before operator)
> 
>> +
>> +		for_each_sibling_event(sibling, leader) {
>> +			if (branch_sample_call_stack(sibling))
>> +				return -EINVAL;
>> +		}
>> +
>> +		/*
>> +		 * Only applying the PERF_SAMPLE_BRANCH_COUNTERS doesn't
>> +		 * require any branch stack setup.
>> +		 * Clear the bit to avoid unnecessary branch stack setup.
>> +		 */
>> +		if (0 == (event->attr.branch_sample_type &
>> +			  ~(PERF_SAMPLE_BRANCH_PLM_ALL |
>> +			    PERF_SAMPLE_BRANCH_COUNTERS)))
>> +			event->hw.flags  &= ~PERF_X86_EVENT_NEEDS_BRANCH_STACK;
>> +	}
> 
> Does this / should this check the number of group members vs supported
> number of lbr counters?

Sure, I will add the check here for the numbers, so perf can error out
earlier.

Thanks,
Kan
