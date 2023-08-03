Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE52D76EC67
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 16:24:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236773AbjHCOX6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 10:23:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236757AbjHCOXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 10:23:41 -0400
Received: from mgamail.intel.com (unknown [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FF5C4689
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 07:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691072570; x=1722608570;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=K3mNypQyQ9ec6BdcOmLKCFaYJPlxgoXUBqbjsEHdirk=;
  b=hLI3JfXhqlA5tmyCshraz4Y7JILvRiVub04M29MH5DWRHq/jyfE7zPK8
   sV7vgRJbx+ajlK5yZZAbG8yxKO+wxX8D8jjoYkBKu4r399n2vvXGu0tXA
   N3FAru8MghRKkbhBWHhzGmx8Gwk4CeQa2YtZ2Ba7tFXGIaFGkP2hf2Z5K
   dySd7Cd0twOEYDtBB9P8Dpb2PtpEL2lqCK1fofRWdClQUn+liUgSrFImm
   BAk95pbr915gqhpCjXlisf8RdqJ/lDZX2IGG7JebBVJN9kbg6HpWmkmo5
   PQBhAEAOloe04FdiCgcNKVNIP3cDq2Sya+p51NljTOmDGTFFkf6HJcplb
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="400837749"
X-IronPort-AV: E=Sophos;i="6.01,252,1684825200"; 
   d="scan'208";a="400837749"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2023 07:22:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="706562791"
X-IronPort-AV: E=Sophos;i="6.01,252,1684825200"; 
   d="scan'208";a="706562791"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga006.jf.intel.com with ESMTP; 03 Aug 2023 07:22:49 -0700
Received: from [10.209.176.203] (kliang2-mobl1.ccr.corp.intel.com [10.209.176.203])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 8E3DA580D54;
        Thu,  3 Aug 2023 07:22:47 -0700 (PDT)
Message-ID: <e23556db-c62d-3565-4192-7e0bb18572dd@linux.intel.com>
Date:   Thu, 3 Aug 2023 10:22:46 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH V2 2/6] perf: Add branch stack extension
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, acme@kernel.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, irogers@google.com,
        adrian.hunter@intel.com, ak@linux.intel.com, eranian@google.com,
        alexey.v.bayduraev@linux.intel.com, tinghao.zhang@intel.com,
        Sandipan Das <sandipan.das@amd.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>
References: <20230522113040.2329924-1-kan.liang@linux.intel.com>
 <20230522113040.2329924-2-kan.liang@linux.intel.com>
 <20230802215814.GH231007@hirez.programming.kicks-ass.net>
Content-Language: en-US
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20230802215814.GH231007@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-08-02 5:58 p.m., Peter Zijlstra wrote:
> On Mon, May 22, 2023 at 04:30:36AM -0700, kan.liang@linux.intel.com wrote:
>> From: Kan Liang <kan.liang@linux.intel.com>
>>
>> Currently, the extra information of a branch entry is stored in a u64
>> space. With more and more information added, the space is running out.
>> For example, the information of occurrences of events will be added for
>> each branch.
>>
>> Add an extension space to record the new information for each branch
>> entry. The space is appended after the struct perf_branch_stack.
>>
>> Add a bit in struct perf_branch_entry to indicate whether the extra
>> information is included.
>>
>> Reviewed-by: Andi Kleen <ak@linux.intel.com>
>> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
>> Cc: Sandipan Das <sandipan.das@amd.com>
>> Cc: Ravi Bangoria <ravi.bangoria@amd.com>
>> Cc: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
>> ---
>>
>> New patch
>> - Introduce a generic extension space which can be used to
>>   store the LBR event information for Intel. It can also be used by
>>   other ARCHs for the other purpose.
>> - Add a new bit in struct perf_branch_entry to indicate whether the
>>   extra information is included.
> 
> Bah.. I don't like this, also the actual format isn't clear to me.
> 
> The uapi part is severely lacking, it just adds the ext:1 thing, but
> doesn't describe what if anything happens when it's set.
> 
> The internal perf_branch_stack_ext thing is just that, internal.
> Additionally it contains a nr member, which seems to suggest it can be
> different from the number of entries in the branch-stack itself -- which
> would be odd indeed.
> 
> So we have an 'ext' bit per branch entry to indicate the existance of
> this extra data, this again suggests no 1:1 correspondence, but at most
> one extra entry per set bit.
> 
> Parsing this will be pretty horrible, no?
> 
> So what we have now is:
> 
> 	{ u64			nr;
> 	  { u64 hw_idx; } && PERF_SAMPLE_BRANCH_HW_INDEX
> 	  { u64 from, to, flags; } lbr[nr];
> 	} && PERF_SAMPLE_BRANCH_STACK
> 
> and AFAICT you're doing:
> 
> 	{ u64			nr;
> 	  { u64 hw_idx; } && PERF_SAMPLE_BRANCH_HW_INDEX
> 	  { u64 from, to, flags; } lbr[nr];
> +	  { u64	nr2;
> +	    { u64 extra; } extra[nr2];
> +         } && OR_i{lbr[i].flags.ext}
> 	} && PERF_SAMPLE_BRANCH_STACK
> 
> Which is pretty horrific, no? The straight forward:

I just tried to make the interface more flexible, since I had no idea
how other ARCHs would use the extra space. But it seems such flexibility
is not necessary. It is indeed not easy to be parsed.

> 
> 	{ u64			nr;
> 	  { u64 hw_idx; } && PERF_SAMPLE_BRANCH_HW_INDEX
> 	  { u64 from, to, flags; } lbr[nr];
> +	  { u64 extra; } ext[nr] && SOMETHING
> 	} && PERF_SAMPLE_BRANCH_STACK
> 
> Or perhaps even:
> 
> 	{ u64			nr;
> 	  { u64 hw_idx; } && PERF_SAMPLE_BRANCH_HW_INDEX
> 	  { u64 from, to, flags; 
> +	    u64 extra; && SOMETHING
> 	  } lbr[nr];
> 	} && PERF_SAMPLE_BRANCH_STACK
> 
> With the obvious question what 'SOMETHING' should be. I suppose
> PERF_SAMPLE_BRANCH_EXTRA was considered and discarded?

Yes, it's considered. I once tried to reuse the existing space/structure
as much as possible. So it's dropped.

Other than that, using a new sample type as an indicator should be a
better way and much straight forward. I will use it in V3.

> 
> Implementing the last suggestion wouldn't even be too bad, since having
> PERF_SAMPLE_BRANCH_EXTRA set, we know to allocate and cast the existing
> perf_sample_data::br_stack to a convenient new type, something like:
> 
> struct perf_branch_entry_ext {
> 	__u64	from;
> 	__u64	to;
> 	__u64	mispred:1,  /* target mispredicted */
> 		predicted:1,/* target predicted */
> 		in_tx:1,    /* in transaction */
> 		abort:1,    /* transaction abort */
> 		cycles:16,  /* cycle count to last branch */
> 		type:4,     /* branch type */
> 		spec:2,     /* branch speculation info */
> 		new_type:4, /* additional branch type */
> 		priv:3,     /* privilege level */
> 		reserved:31;
> 	__u64	extra;
> };
> 
> Except at that point I think I would suggest doing s/EXTRA/COUNTERS/g
> and making it something like:
> 
> 	union {
> 		__u64	counters;
> 		__u8 	c[8];
> 	};
> 

It's good enough for this feature and Intel LBR.
My only concern is that it's only a 64 bit extra space. If we need more
space later, we have to keep adding perf_branch_entry_ext2 and
PERF_SAMPLE_BRANCH_EXTRA2. But I don't have such use case now. Maybe I'm
just too paranoid. :)

I will use the suggested structure in V3. If anyone has other concerns,
we can discuss them from there.

Thanks,
Kan

> Or something daft like that.
> 
> Wouldn't all that make *MUCH* more sense?
