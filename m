Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95EBB7B699B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 14:57:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231268AbjJCM5d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 08:57:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbjJCM5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 08:57:32 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 529B09B
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 05:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696337847; x=1727873847;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=o/mh9hb5YaYdyMWIuqazNV+KdQvIMuDcQZAsPPctTTs=;
  b=R67/aelCANeWjp/nCN3NgEWc1LGETNFcxYbx2KzloJElIFoZsG8idN6C
   cRDPOXxsi9X8jKHraVHKabiVUXaKuPNumx3qKj1k3FK4f0AfnsyQkHxxy
   L9mXSf4LemlJ5eERaXshlcsoVJyAemXq6gNsG2XuNvVDQgzVdiB/7uFKE
   sK9pg9FyI/ahiH8Pdx0c439Gq/Lj3t/Yqbx4PkDmmIw6lyKhzBgkcefJT
   i1tXgD479pbRI8Cg9behlDO4nRMWryPjnrdXczeQEqG8qwQbg26kttzlp
   61sPF+adzTUvTPuq90SpOZFbK9/+/A3ZovO/n/kYoMI6wIsDKezu75Xcp
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="367916445"
X-IronPort-AV: E=Sophos;i="6.03,197,1694761200"; 
   d="scan'208";a="367916445"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 05:57:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="780294465"
X-IronPort-AV: E=Sophos;i="6.03,197,1694761200"; 
   d="scan'208";a="780294465"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 05:57:26 -0700
Received: from [10.209.133.202] (kliang2-mobl1.ccr.corp.intel.com [10.209.133.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 7CF0B580C73;
        Tue,  3 Oct 2023 05:57:24 -0700 (PDT)
Message-ID: <3d0e9d76-b20c-2f44-cff6-0701f4487048@linux.intel.com>
Date:   Tue, 3 Oct 2023 08:57:23 -0400
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
 <ed169d4d-76d5-c134-c685-ad3d812028be@linux.intel.com>
 <20231003102733.GC1539@noisy.programming.kicks-ass.net>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20231003102733.GC1539@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-10-03 6:27 a.m., Peter Zijlstra wrote:
> On Mon, Oct 02, 2023 at 08:57:57PM -0400, Liang, Kan wrote:
> 
>>> Did I already say that the ISE document raises more questions than it
>>> provides answers?
>>
>> Yes. Would an improved CPUID enumeration can address the questions? For
>> example, the CPUID enumeration can give the maximum number of counters
>> and supported width? I think we can discuss it with the architect.
> 
> So.. no. Suppose another arch goes and does the same, but with a
> different number and width of counters. They won't have CPUID.
> 
> I'm thinking we should do something like expose branch_counter_nr and
> branch_counter_width in the sysfs node, and then rename this extra field
> to counters.

Sure. I will expose them under the "caps" folder.

> 
> Then userspace can do something like:
> 
> 	for (i = 0; i < branch_counter_nr; i++) {
> 		counter[i] = counters & ((1 << branch_counter_width) - 1);
> 		counters >>= branch_counter_width;
> 	}
> 
> to extract the actual counter values.
> 
> 
> So then we end up with:
> 
>          *      { u64                   nr;
>          *        { u64 hw_idx; } && PERF_SAMPLE_BRANCH_HW_INDEX
>          *        { u64 from, to, flags } lbr[nr];
> +        *        { u64 counters; } cntr[nr] && PERF_SAMPLE_BRANCH_COUNTERS
>          *      } && PERF_SAMPLE_BRANCH_STACK
> 
> Have it explicitly named counters, have only the one flag and have sysfs
> files describe how to decode it.
> 
> Then for this Intel thing we have 4 counters of 2 bits, but if someone
> else were to do something different (both Power and ARM64 have this
> branch stack stuff now) they can describe it.
> 
> It is a bit wasteful on bits... but at least its clear I suppose.

Yes. I will send a V4 with the above suggestions.

Thanks,
Kan
