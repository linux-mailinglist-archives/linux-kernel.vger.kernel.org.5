Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D80FD7B5B4F
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 21:31:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238869AbjJBT0b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 15:26:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238864AbjJBT0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 15:26:25 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCEF5AC
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 12:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696274782; x=1727810782;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=YuFWCE9UZrd9fr2IBuryO9mjpzmeJCF3DeChyiMsuHk=;
  b=lBYYteULf4JyMYFPtBKK9ryo0JRdFy5INX9wKL8paHYbWTNS18o5kzf+
   0ZwX0oYVZ+sy21KKIKQKIq8kIqqUOb+ZAJWwf6SfTKaJj5b1MY+9bfVRb
   ZW0sR56bymPQ47Gj17NiVpyEp4dIWzTyVsgX6oTStMmRkS9qL67GdqsSB
   IIKpg70ozRoaP7vCAzakZ+gz9iq2gVuieqCxcGOsPPn4ShuGmj84C/iY2
   dPOAiKd6CyJ58hbX942/o+gH3UrgPKpWSyS2EIPxhpAlycna73WQAhaUu
   FR5Gfj+8v3/pV92QH6qA/1VvdnCByXsmrF194yThf6KGJkE3sKuiyY6WG
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="413627409"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="413627409"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 12:19:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="997729798"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="997729798"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 12:19:08 -0700
Received: from [10.212.65.113] (kliang2-mobl1.ccr.corp.intel.com [10.212.65.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 04A9F580CBC;
        Mon,  2 Oct 2023 12:19:05 -0700 (PDT)
Message-ID: <ce16c6c1-9bdc-35e2-fe85-155bd7edbaa4@linux.intel.com>
Date:   Mon, 2 Oct 2023 15:19:04 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [RESEND PATCH V3 1/6] perf: Add branch stack extra
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, acme@kernel.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, irogers@google.com,
        adrian.hunter@intel.com, ak@linux.intel.com, eranian@google.com,
        alexey.v.bayduraev@linux.intel.com, tinghao.zhang@intel.com,
        Sandipan Das <sandipan.das@amd.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>
References: <20230911154822.2559213-1-kan.liang@linux.intel.com>
 <20231002154535.GB35785@noisy.programming.kicks-ass.net>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20231002154535.GB35785@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-10-02 11:45 a.m., Peter Zijlstra wrote:
> On Mon, Sep 11, 2023 at 08:48:17AM -0700, kan.liang@linux.intel.com wrote:
>> From: Kan Liang <kan.liang@linux.intel.com>
>>
>> Currently, the additional information of a branch entry is stored in a
>> u64 space. With more and more information added, the space is running
>> out. For example, the information of occurrences of events will be added
>> for each branch.
>>
>> Add a new branch sample type, PERF_SAMPLE_BRANCH_EXTRA, to indicate
>> whether to support an extra space.
>>
>> Two places were suggested to append the extra space.
>> https://lore.kernel.org/lkml/20230802215814.GH231007@hirez.programming.kicks-ass.net/
>> One place is right after the flags of each branch entry. It changes the
>> existing struct perf_branch_entry. In the later Intel-specific
>> implementation, two separate spaces have to be created in the
>> struct cpu_hw_events to store different branch entry structures. That
>> duplicates space.
> 
> Well, something like so:
> 
> -       struct perf_branch_entry        lbr_entries[MAX_LBR_ENTRIES];
> +
> +       union {
> +               struct perf_branch_entry        lbr_entries[MAX_LBR_ENTRIES];
> +               struct perf_branch_entry_ext    lbr_entries_ext[MAX_LBR_ENTRIES];
> +       };
> 
> would just do... you just have to be really careful to consistently pick
> the right one.
> 
> Something that might help would be to do make perf_branch_stack::entries
> a 'void *' and use:
> 
> struct perf_branch_entry_ext *
> perf_get_branch_entry(struct perf_sample_data *data, int idx)
> {
> 	if (data->sample_flags & PERF_SAMPLE_BRANCH_EXTRA)
> 		return (struct perf_branch_entry_ext *)data->br_stack->entries + idx;
> 	
> 	return (struct perf_branch_entry *)data->br_stack->entries + idx;
> }

I tried to avoid the above extra calculation (although it should be
tiny), since it's in a NMI handler. So I once planned to add an extra
struct perf_branch_entry_ext    lbr_entries_ext[MAX_LBR_ENTRIES]; which
doubles the space.
But yes, it should be doable.

> 
>> The other place is right after the entire struct perf_branch_stack.
>> Only adding the new extra space in the struct cpu_hw_event is necessary.
>> The disadvantage is that the pointer of the extra space has to be
>> recorded. The common interface perf_sample_save_brstack() has to be
>> updated as well.
> 
> Right.. probably easier.

I don't see big drawbacks to it. Easier to understand and implement, so
should be easier to maintain as well.
I guess I will still use the latter, if no objection.

> 
>> The latter requires less space and is much straight forward. It is
>> implemented in the patch.
> 
> Same amount of space either way around. 'n*x+n*y == n*(x+y)' and all that.
> 
>> Also, add a new branch sample type, PERF_SAMPLE_BRANCH_EVT_CNTRS, to
>> indicate whether include occurrences of events in branch info. The
>> information will be stored in the extra space.
> 
> This... why do we need two flags?

Users may only collect the occurrences of some events in a group. The
EVT_CNTRS flag is used to indicate those events. E.g.,
perf record -e "{cpu/branch-instructions,branch_type=call/,
cpu/branch-misses,branch_type=event/}"

Only the occurrences of the branch-misses event is collected in LBR and
finally dumped into the extra buffer.

While the first flag, PERF_SAMPLE_BRANCH_EXTRA, only tells that the
extra space is required.

> 
> Also, I can't find this in the SDM, how wide are these counter deltas?
> ISTR they're saturating, but not how wide they are.

Now, it's documented in the Intel® Architecture Instruction Set
Extensions and Future Features, Chapter 8, 8.6 LBR ENHANCEMENTS. It
should be moved to SDM later.
https://cdrdv2.intel.com/v1/dl/getContent/671368

Only 2 bits for each counter. Saturating at a value of 3.

Thanks,
Kan
