Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 800B37B5E6B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 02:58:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238933AbjJCA6H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 20:58:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbjJCA6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 20:58:05 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0B52B7
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 17:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696294682; x=1727830682;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9ElHeu35WB3FN5ywyVYMmUbielz++Q1fz01ylClzBW8=;
  b=i4VQZrwJNmD+OXstsJOXuI8FYtWBUOVZSpbme04tlY2HsvZTKTUn9CGK
   hNMRE7qLzPSd/Bm4pY0IHrzB0BVCzgIoq0hli4j0jJKBo0+vCWaiziaCU
   acCLYBEIr0CjPpHXMghSIgCUfwXJsARZh5QgXfmkIus0ynawS4oF9f/Vy
   KDkoq9ntgTCJoyN6ZH0Z4GEpAZiPW3H7l4ckCpk+XklPisus00CrsyWQ6
   ieWCUi2GBGbLiEjpHbdyrjGY/gGWIlNUopDpgqcv3Iks2pYvdd9TB5TNY
   Hy7j27gYS1HICfME7zbX/rY6PJIBCMR0pBuQJlEWmsJJQl6Je4CQMLZVe
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="413688812"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="413688812"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 17:58:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="894299176"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="894299176"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 17:56:39 -0700
Received: from [10.212.65.113] (kliang2-mobl1.ccr.corp.intel.com [10.212.65.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 360A8580CBC;
        Mon,  2 Oct 2023 17:57:59 -0700 (PDT)
Message-ID: <ed169d4d-76d5-c134-c685-ad3d812028be@linux.intel.com>
Date:   Mon, 2 Oct 2023 20:57:57 -0400
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
 <ce16c6c1-9bdc-35e2-fe85-155bd7edbaa4@linux.intel.com>
 <20231002213752.GB1539@noisy.programming.kicks-ass.net>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20231002213752.GB1539@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-10-02 5:37 p.m., Peter Zijlstra wrote:
> On Mon, Oct 02, 2023 at 03:19:04PM -0400, Liang, Kan wrote:
> 
>>>> Also, add a new branch sample type, PERF_SAMPLE_BRANCH_EVT_CNTRS, to
>>>> indicate whether include occurrences of events in branch info. The
>>>> information will be stored in the extra space.
>>>
>>> This... why do we need two flags?
>>
>> Users may only collect the occurrences of some events in a group. The
>> EVT_CNTRS flag is used to indicate those events. E.g.,
>> perf record -e "{cpu/branch-instructions,branch_type=call/,
>> cpu/branch-misses,branch_type=event/}"
>>
>> Only the occurrences of the branch-misses event is collected in LBR and
>> finally dumped into the extra buffer.
>>
>> While the first flag, PERF_SAMPLE_BRANCH_EXTRA, only tells that the
>> extra space is required.
> 
> Or have it implicit, I reallt don't see the point of having two bits
> here.

Perf has to traverse the whole group to decide whether using the extra
space. But It should be possible to use an internal flag to avoid the
traverse every time. Let me have a try.

> 
>>> Also, I can't find this in the SDM, how wide are these counter deltas?
>>> ISTR they're saturating, but not how wide they are.
>>
>> Now, it's documented in the Intel® Architecture Instruction Set
>> Extensions and Future Features, Chapter 8, 8.6 LBR ENHANCEMENTS. It
>> should be moved to SDM later.
>> https://cdrdv2.intel.com/v1/dl/getContent/671368
>>
>> Only 2 bits for each counter. Saturating at a value of 3.
> 
> Urgh, this ISE document is shite, that thing don't say how many
> IA32_LBR_INFO.PMCx_CNT fields there are, I think your later patch says
> 4, right? And is this for arch LBR or the other thing?
>

It's for Arch LBR. Yes, the current CPUID enumeration implies that only
4 counters.

"Per-counter support for LBR Event Logging is indicated by the “Event
Logging Supported” bitmap in CPUID.(EAX=01CH, ECX=0).ECX[19:16]"

> (Also, what is IA32_LER_x_INFO ?)

Last Event Record (LER). It records the last taken branch preceding the
last exception, hardware interrupt, or software interrupt.
Linux doesn't have it supported.

> 
> This is then a grant total of 8 bits.
> 
> And we still have 31 spare bits in perf_branch_entry.
> 
> Why again do we need the extra u64 ?!?
>

The first version utilizes the spare bits in perf_branch_entry.
https://lore.kernel.org/lkml/20230414145324.GB761523@hirez.programming.kicks-ass.net/

To address the similar concern (what should we do if more counters and a
wider bits are added later), I changed it to the extra space method
since V2.

Another consideration is that the 'events' field in the
perf_branch_entry from V1 is Intel specific. The u64 extra space is more
generic. Other ARCHs can utilize it to store other extra information if
they want.

Please let me know if I'm overthinking. I can switch back to the
'events' field of V1.

> More specifically, this interface is pretty crap -- suppose the next
> generation of things feels that 2 bits aint' enough and goes and gives
> us 4. Then what do we do?
>

The current LBR is an architectural feature. The existed fields of 2
bits 4 counters should not be changed.
But yes, it's possible to add more bits and counters into the reserved
bits. The reserved bits of the IA32_LBR_x_INFO are only 31 now. The u64
extra space should be good enough.
If more information is introduced later (e.g., a brand new
LBR_x_INFO_2), then we can add a extra_2 space.

But I don't see there is a plan to extend the IA32_LBR_x_INFO again in
the near future.

> Did I already say that the ISE document raises more questions than it
> provides answers?

Yes. Would an improved CPUID enumeration can address the questions? For
example, the CPUID enumeration can give the maximum number of counters
and supported width? I think we can discuss it with the architect.

Thanks,
Kan
