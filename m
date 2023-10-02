Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 744F57B5677
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 17:38:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238044AbjJBPSi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 11:18:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238039AbjJBPSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 11:18:34 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83F23AC
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 08:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696259910; x=1727795910;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=a7iJz2gJK/YmvDsTGeMSnvxZ20Rp1Kv5Km6DA0NMl+Y=;
  b=WuPWw+KogLF9BGcqMUnG3eTY5b17ADc/7NhS3eG3fHyE2UtRtHS/dgTY
   MEcSoh3SuwGj4MV3Y6KaN2+se+b0vzhB08IHqXWOy42AH+1sKImxe05FK
   4S6NegtXqGeCnu+gxY6HYB4T7tMJuXna3WLS2PEjvC4diikWTDHnvm2/G
   OERTtSsmu54w6+nilDCgiHFX3MWk6Hu54Iqr3GodPx+czm3Wa1+rOXly1
   xKE5hETyck3uQCChpP7rpQu7zz5f9kno5mkJWKG7Ty45McoMjJoPV0J6u
   So6GErqHk8YIM+v4GN60qBpe8XTC3Ok3OfPfeh07fZ/EAej7OPDJJnSQT
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="4236603"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="4236603"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 08:08:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="700376549"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="700376549"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 08:08:03 -0700
Received: from [10.212.65.113] (kliang2-mobl1.ccr.corp.intel.com [10.212.65.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 67412580AFF;
        Mon,  2 Oct 2023 08:08:02 -0700 (PDT)
Message-ID: <85f37929-bde3-5076-c5ca-afa7ed24cb32@linux.intel.com>
Date:   Mon, 2 Oct 2023 11:08:01 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] perf/x86/intel: Extend the ref-cycles event to GP
 counters
Content-Language: en-US
To:     Stephane Eranian <eranian@google.com>
Cc:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, ak@linux.intel.com
References: <20230911144139.2354015-1-kan.liang@linux.intel.com>
 <CABPqkBQ1R9K_2L6pNp1dLmHnjwzcSiWeAhJ+J701_cojpVzwFw@mail.gmail.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <CABPqkBQ1R9K_2L6pNp1dLmHnjwzcSiWeAhJ+J701_cojpVzwFw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-09-27 12:47 a.m., Stephane Eranian wrote:
> On Mon, Sep 11, 2023 at 7:41 AM <kan.liang@linux.intel.com> wrote:
>>
>> From: Kan Liang <kan.liang@linux.intel.com>
>>
>> The current ref-cycles event is only available on the fixed counter 2.
>> Starting from the GLC and GRT core, the architectural UnHalted Reference
>> Cycles event (0x013c) which is available on general-purpose counters
>> can collect the exact same events as the fixed counter 2.
>>
>> Update the mapping of ref-cycles to 0x013c. So the ref-cycles can be
>> available on both fixed counter 2 and general-purpose counters.
>>
>> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
>> ---
>>  arch/x86/events/intel/core.c | 21 ++++++++++++++++++++-
>>  1 file changed, 20 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
>> index e1543d6dc48a..a08f794a0e79 100644
>> --- a/arch/x86/events/intel/core.c
>> +++ b/arch/x86/events/intel/core.c
>> @@ -211,6 +211,14 @@ static struct event_constraint intel_slm_event_constraints[] __read_mostly =
>>         EVENT_CONSTRAINT_END
>>  };
>>
>> +static struct event_constraint intel_grt_event_constraints[] __read_mostly = {
>> +       FIXED_EVENT_CONSTRAINT(0x00c0, 0), /* INST_RETIRED.ANY */
>> +       FIXED_EVENT_CONSTRAINT(0x003c, 1), /* CPU_CLK_UNHALTED.CORE */
>> +       FIXED_EVENT_CONSTRAINT(0x0300, 2), /* pseudo CPU_CLK_UNHALTED.REF */
>> +       FIXED_EVENT_CONSTRAINT(0x013c, 2), /* CPU_CLK_UNHALTED.REF_TSC_P */
>> +       EVENT_CONSTRAINT_END
>> +};
>> +
>>  static struct event_constraint intel_skl_event_constraints[] = {
>>         FIXED_EVENT_CONSTRAINT(0x00c0, 0),      /* INST_RETIRED.ANY */
>>         FIXED_EVENT_CONSTRAINT(0x003c, 1),      /* CPU_CLK_UNHALTED.CORE */
>> @@ -314,6 +322,7 @@ static struct event_constraint intel_glc_event_constraints[] = {
>>         FIXED_EVENT_CONSTRAINT(0x0100, 0),      /* INST_RETIRED.PREC_DIST */
>>         FIXED_EVENT_CONSTRAINT(0x003c, 1),      /* CPU_CLK_UNHALTED.CORE */
>>         FIXED_EVENT_CONSTRAINT(0x0300, 2),      /* CPU_CLK_UNHALTED.REF */
>> +       FIXED_EVENT_CONSTRAINT(0x013c, 2),      /* CPU_CLK_UNHALTED.REF_TSC_P */
> 
> I don't think that on SKL there is a REF_TSC_P. It only appears on
> SPR. The encoding exists on SKL
> but it counts REF_XCLK which I think counts something different. Please check.

Right, the patch is to update the event constraint to GLC
(intel_glc_event_constraints) for SPR, not SKL.

Thanks,
Kan

>>         FIXED_EVENT_CONSTRAINT(0x0400, 3),      /* SLOTS */
>>         METRIC_EVENT_CONSTRAINT(INTEL_TD_METRIC_RETIRING, 0),
>>         METRIC_EVENT_CONSTRAINT(INTEL_TD_METRIC_BAD_SPEC, 1),
>> @@ -5983,6 +5992,12 @@ static __always_inline int intel_pmu_init_hybrid(enum hybrid_pmu_type pmus)
>>         return 0;
>>  }
>>
>> +static __always_inline void intel_pmu_ref_cycles_ext(void)
>> +{
>> +       if (!(x86_pmu.events_maskl & (INTEL_PMC_MSK_FIXED_REF_CYCLES >> INTEL_PMC_IDX_FIXED)))
>> +               intel_perfmon_event_map[PERF_COUNT_HW_REF_CPU_CYCLES] = 0x013c;
>> +}
>> +
>>  static __always_inline void intel_pmu_init_glc(struct pmu *pmu)
>>  {
>>         x86_pmu.late_ack = true;
>> @@ -6005,6 +6020,8 @@ static __always_inline void intel_pmu_init_glc(struct pmu *pmu)
>>         memcpy(hybrid_var(pmu, hw_cache_extra_regs), glc_hw_cache_extra_regs, sizeof(hw_cache_extra_regs));
>>         hybrid(pmu, event_constraints) = intel_glc_event_constraints;
>>         hybrid(pmu, pebs_constraints) = intel_glc_pebs_event_constraints;
>> +
>> +       intel_pmu_ref_cycles_ext();
>>  }
>>
>>  static __always_inline void intel_pmu_init_grt(struct pmu *pmu)
>> @@ -6021,9 +6038,11 @@ static __always_inline void intel_pmu_init_grt(struct pmu *pmu)
>>         memcpy(hybrid_var(pmu, hw_cache_event_ids), glp_hw_cache_event_ids, sizeof(hw_cache_event_ids));
>>         memcpy(hybrid_var(pmu, hw_cache_extra_regs), tnt_hw_cache_extra_regs, sizeof(hw_cache_extra_regs));
>>         hybrid_var(pmu, hw_cache_event_ids)[C(ITLB)][C(OP_READ)][C(RESULT_ACCESS)] = -1;
>> -       hybrid(pmu, event_constraints) = intel_slm_event_constraints;
>> +       hybrid(pmu, event_constraints) = intel_grt_event_constraints;
>>         hybrid(pmu, pebs_constraints) = intel_grt_pebs_event_constraints;
>>         hybrid(pmu, extra_regs) = intel_grt_extra_regs;
>> +
>> +       intel_pmu_ref_cycles_ext();
>>  }
>>
>>  __init int intel_pmu_init(void)
>> --
>> 2.35.1
>>
