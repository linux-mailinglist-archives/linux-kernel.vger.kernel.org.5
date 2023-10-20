Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5696E7D0FCC
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 14:45:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377210AbjJTMpL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 08:45:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377239AbjJTMpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 08:45:10 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B29DED45
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 05:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697805908; x=1729341908;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=e3++mxHhCWmXYCjs3kiYA86Yyh8phmTVg9Odiy6aSbU=;
  b=Fe0VjAABqdtibMx4JP2QwGeX3ttQSxeIbTevZLuF5Nuv+P82wWxDDAVf
   1kB4mKrEdiH7BKDUrUWnLBj3ZBi35Fycmknz4xg8Eutyy3xwh70nZW87Z
   AmA6/WjkdHMal13MCBOyF2phdS709WVGAyyRcttsL9isX3cXznmUeHhm7
   Zu1rIpFsSzMNDfeFuiE2MDRkXxuIVg6gmiKhz4AH6aU2hQ8ciYrQjIFUk
   h08MZt5JEjaocIQrAxwXgUp5f1R9L71LhInNueB9HNfLaTlfXdoqG6VsR
   d96RrVTy+t3e/NmALVYecCFmsyQwusf4COZF0Bz8rYOMqVVHQF2xRIVtx
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10869"; a="390372999"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="390372999"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 05:45:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10869"; a="750902673"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="750902673"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 05:45:08 -0700
Received: from [10.209.139.149] (kliang2-mobl1.ccr.corp.intel.com [10.209.139.149])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 2998C580D4F;
        Fri, 20 Oct 2023 05:45:06 -0700 (PDT)
Message-ID: <149fef35-b24f-426a-9e8a-d7cadcd7bdeb@linux.intel.com>
Date:   Fri, 20 Oct 2023 08:45:04 -0400
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
 <20231019111202.GJ36211@noisy.programming.kicks-ass.net>
Content-Language: en-US
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20231019111202.GJ36211@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-10-19 7:12 a.m., Peter Zijlstra wrote:
> On Wed, Oct 04, 2023 at 11:40:41AM -0700, kan.liang@linux.intel.com wrote:
>> +static __always_inline void get_lbr_events(struct cpu_hw_events *cpuc,
>> +					   int i, u64 info)
>> +{
>> +	/*
>> +	 * The later code will decide what content can be disclosed
>> +	 * to the perf tool. It's no harmful to unconditionally update
>> +	 * the cpuc->lbr_events.
>> +	 * Pleae see intel_pmu_lbr_event_reorder()
>> +	 */
>> +	cpuc->lbr_events[i] = info & LBR_INFO_EVENTS;
>> +}
> 
> You could be forcing an extra cachemiss here. 

Here is to temporarily store the branch _counter information. Maybe we
can leverage the reserved field of cpuc->lbr_entries[i] to avoid the
cachemiss.

	e->reserved = info & LBR_INFO_COUNTERS;

I tried to add something like a static_assert to check the size of the
reserved field in case the field is shrink later. But the reserved field
is a bit field. I have no idea how to get the exact size of a bit field
unless define a macro. Is something as below OK? Any suggestions are
appreciated.


diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index 1e80a551a4c2..62675593e39a 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -1582,6 +1582,8 @@ static bool is_arch_lbr_xsave_available(void)
 	return true;
 }

+static_assert((64 - PERF_BRANCH_ENTRY_INFO_BITS_MAX) >
LBR_INFO_COUNTERS_MAX_NUM * 2);
+
 void __init intel_pmu_arch_lbr_init(void)
 {
	struct pmu *pmu = x86_get_pmu(smp_processor_id());
diff --git a/arch/x86/include/asm/msr-index.h
b/arch/x86/include/asm/msr-index.h
index f220c3598d03..e9ff8eba5efd 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -238,6 +238,7 @@
 #define LBR_INFO_BR_TYPE		(0xfull << LBR_INFO_BR_TYPE_OFFSET)
 #define LBR_INFO_EVENTS_OFFSET		32
 #define LBR_INFO_EVENTS			(0xffull << LBR_INFO_EVENTS_OFFSET)
+#define LBR_INFO_COUNTERS_MAX_NUM	4

 #define MSR_ARCH_LBR_CTL		0x000014ce
 #define ARCH_LBR_CTL_LBREN		BIT(0)
diff --git a/include/uapi/linux/perf_event.h
b/include/uapi/linux/perf_event.h
index 4461f380425b..3a64499b0f5d 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -1437,6 +1437,9 @@ struct perf_branch_entry {
 		reserved:31;
 };

+/* Size of used info bits in struct perf_branch_entry */
+#define PERF_BRANCH_ENTRY_INFO_BITS_MAX		33
+
 union perf_sample_weight {
 	__u64		full;
 #if defined(__LITTLE_ENDIAN_BITFIELD)



> A long time ago I had
> hacks to profile perf with perf, but perhaps PT can be abused for that
> now?

As my understanding, the PT can only give the trace information, and may
not tell if there is a canchemiss or something.
I will take a deep look and see if PT can help the case.

Thanks,
Kan
