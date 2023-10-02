Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E22237B5487
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 16:10:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237521AbjJBNua (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 09:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237624AbjJBNuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 09:50:22 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB09CCF1
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 06:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696254609; x=1727790609;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=s9l8KtiDUMAOrre33EYGPbaXdBleiPjNZzcomHstG4Y=;
  b=KxAmyIwayaKmM+kphkVE+LgIEnSsJ76negPLG4e0FNEr/CVYFt/pWxzi
   2QRG53OBldkDfBkSiyh6FIWFmzsx+ftDQWj/crc4PoXOxvy+zoMisaDwe
   86OAMtSbvLwbXSQC2Poa0D2lyixnWhW+qprAU3Jpvaf3yT7HRjvFuX7ZK
   aN9PSzLaQhDYRdRVL3xL3SW19p/lQrJmpd42FPKkeqUqgDX/DgGuLnESG
   hJo5LKaUeMBpq356EwdBfxONnj3D5LE2zlkajvdCqNexZPysTpGkT31Eq
   F4YOPhiHWe1AqBQdME1wLO4Bt92XWO5szPr6Z9aKh+fYNqne9CK+PnFtA
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="4220231"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="4220231"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 06:50:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="816290432"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="816290432"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 06:50:07 -0700
Received: from [10.212.65.113] (kliang2-mobl1.ccr.corp.intel.com [10.212.65.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 9BB8D580AFF;
        Mon,  2 Oct 2023 06:50:01 -0700 (PDT)
Message-ID: <e173ab1b-f739-1ed0-bbb9-a546b06d2812@linux.intel.com>
Date:   Mon, 2 Oct 2023 09:49:55 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [RESEND PATCH V3 1/6] perf: Add branch stack extra
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, irogers@google.com,
        adrian.hunter@intel.com, ak@linux.intel.com, eranian@google.com,
        alexey.v.bayduraev@linux.intel.com, tinghao.zhang@intel.com,
        Sandipan Das <sandipan.das@amd.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>
References: <20230911154822.2559213-1-kan.liang@linux.intel.com>
Content-Language: en-US
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20230911154822.2559213-1-kan.liang@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

Could you please share your comments for this series?

Thanks,
Kan

On 2023-09-11 11:48 a.m., kan.liang@linux.intel.com wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> Currently, the additional information of a branch entry is stored in a
> u64 space. With more and more information added, the space is running
> out. For example, the information of occurrences of events will be added
> for each branch.
> 
> Add a new branch sample type, PERF_SAMPLE_BRANCH_EXTRA, to indicate
> whether to support an extra space.
> 
> Two places were suggested to append the extra space.
> https://lore.kernel.org/lkml/20230802215814.GH231007@hirez.programming.kicks-ass.net/
> One place is right after the flags of each branch entry. It changes the
> existing struct perf_branch_entry. In the later Intel-specific
> implementation, two separate spaces have to be created in the
> struct cpu_hw_events to store different branch entry structures. That
> duplicates space.
> The other place is right after the entire struct perf_branch_stack.
> Only adding the new extra space in the struct cpu_hw_event is necessary.
> The disadvantage is that the pointer of the extra space has to be
> recorded. The common interface perf_sample_save_brstack() has to be
> updated as well.
> 
> The latter requires less space and is much straight forward. It is
> implemented in the patch.
> 
> Also, add a new branch sample type, PERF_SAMPLE_BRANCH_EVT_CNTRS, to
> indicate whether include occurrences of events in branch info. The
> information will be stored in the extra space.
> 
> Add two helper functions for the new branch sample types.
> 
> Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> Cc: Sandipan Das <sandipan.das@amd.com>
> Cc: Ravi Bangoria <ravi.bangoria@amd.com>
> Cc: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
> ---
> 
> Changes since V2:
> - Drop the new bit in struct perf_branch_entry
> - Introduce a new sample type PERF_SAMPLE_BRANCH_EXTRA
> 
>  arch/powerpc/perf/core-book3s.c |  2 +-
>  arch/x86/events/amd/core.c      |  2 +-
>  arch/x86/events/core.c          |  2 +-
>  arch/x86/events/intel/core.c    |  2 +-
>  arch/x86/events/intel/ds.c      |  4 ++--
>  include/linux/perf_event.h      | 22 +++++++++++++++++++++-
>  include/uapi/linux/perf_event.h |  9 +++++++++
>  kernel/events/core.c            |  8 ++++++++
>  8 files changed, 44 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
> index 8c1f7def596e..3c14596bbfaf 100644
> --- a/arch/powerpc/perf/core-book3s.c
> +++ b/arch/powerpc/perf/core-book3s.c
> @@ -2313,7 +2313,7 @@ static void record_and_restart(struct perf_event *event, unsigned long val,
>  			struct cpu_hw_events *cpuhw;
>  			cpuhw = this_cpu_ptr(&cpu_hw_events);
>  			power_pmu_bhrb_read(event, cpuhw);
> -			perf_sample_save_brstack(&data, event, &cpuhw->bhrb_stack);
> +			perf_sample_save_brstack(&data, event, &cpuhw->bhrb_stack, NULL);
>  		}
>  
>  		if (event->attr.sample_type & PERF_SAMPLE_DATA_SRC &&
> diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
> index abadd5f23425..01c0619d12d5 100644
> --- a/arch/x86/events/amd/core.c
> +++ b/arch/x86/events/amd/core.c
> @@ -930,7 +930,7 @@ static int amd_pmu_v2_handle_irq(struct pt_regs *regs)
>  			continue;
>  
>  		if (has_branch_stack(event))
> -			perf_sample_save_brstack(&data, event, &cpuc->lbr_stack);
> +			perf_sample_save_brstack(&data, event, &cpuc->lbr_stack, NULL);
>  
>  		if (perf_event_overflow(event, &data, regs))
>  			x86_pmu_stop(event, 0);
> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> index 185f902e5f28..2919bb5a53a0 100644
> --- a/arch/x86/events/core.c
> +++ b/arch/x86/events/core.c
> @@ -1702,7 +1702,7 @@ int x86_pmu_handle_irq(struct pt_regs *regs)
>  		perf_sample_data_init(&data, 0, event->hw.last_period);
>  
>  		if (has_branch_stack(event))
> -			perf_sample_save_brstack(&data, event, &cpuc->lbr_stack);
> +			perf_sample_save_brstack(&data, event, &cpuc->lbr_stack, NULL);
>  
>  		if (perf_event_overflow(event, &data, regs))
>  			x86_pmu_stop(event, 0);
> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index 64a3533997e1..0f4ce79de4f8 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -3058,7 +3058,7 @@ static int handle_pmi_common(struct pt_regs *regs, u64 status)
>  		perf_sample_data_init(&data, 0, event->hw.last_period);
>  
>  		if (has_branch_stack(event))
> -			perf_sample_save_brstack(&data, event, &cpuc->lbr_stack);
> +			perf_sample_save_brstack(&data, event, &cpuc->lbr_stack, NULL);
>  
>  		if (perf_event_overflow(event, &data, regs))
>  			x86_pmu_stop(event, 0);
> diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
> index eb8dd8b8a1e8..7566190389f0 100644
> --- a/arch/x86/events/intel/ds.c
> +++ b/arch/x86/events/intel/ds.c
> @@ -1755,7 +1755,7 @@ static void setup_pebs_fixed_sample_data(struct perf_event *event,
>  		setup_pebs_time(event, data, pebs->tsc);
>  
>  	if (has_branch_stack(event))
> -		perf_sample_save_brstack(data, event, &cpuc->lbr_stack);
> +		perf_sample_save_brstack(data, event, &cpuc->lbr_stack, NULL);
>  }
>  
>  static void adaptive_pebs_save_regs(struct pt_regs *regs,
> @@ -1912,7 +1912,7 @@ static void setup_pebs_adaptive_sample_data(struct perf_event *event,
>  
>  		if (has_branch_stack(event)) {
>  			intel_pmu_store_pebs_lbrs(lbr);
> -			perf_sample_save_brstack(data, event, &cpuc->lbr_stack);
> +			perf_sample_save_brstack(data, event, &cpuc->lbr_stack, NULL);
>  		}
>  	}
>  
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index e83f13ce4a9f..c4877924d43c 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -1137,6 +1137,15 @@ static inline bool branch_sample_priv(const struct perf_event *event)
>  	return event->attr.branch_sample_type & PERF_SAMPLE_BRANCH_PRIV_SAVE;
>  }
>  
> +static inline bool branch_sample_extra(const struct perf_event *event)
> +{
> +	return event->attr.branch_sample_type & PERF_SAMPLE_BRANCH_EXTRA;
> +}
> +
> +static inline bool branch_sample_evt_cntrs(const struct perf_event *event)
> +{
> +	return event->attr.branch_sample_type & PERF_SAMPLE_BRANCH_EVT_CNTRS;
> +}
>  
>  struct perf_sample_data {
>  	/*
> @@ -1171,6 +1180,7 @@ struct perf_sample_data {
>  	struct perf_callchain_entry	*callchain;
>  	struct perf_raw_record		*raw;
>  	struct perf_branch_stack	*br_stack;
> +	u64				*br_stack_ext;
>  	union perf_sample_weight	weight;
>  	union  perf_mem_data_src	data_src;
>  	u64				txn;
> @@ -1248,7 +1258,8 @@ static inline void perf_sample_save_raw_data(struct perf_sample_data *data,
>  
>  static inline void perf_sample_save_brstack(struct perf_sample_data *data,
>  					    struct perf_event *event,
> -					    struct perf_branch_stack *brs)
> +					    struct perf_branch_stack *brs,
> +					    u64 *brs_ext)
>  {
>  	int size = sizeof(u64); /* nr */
>  
> @@ -1256,7 +1267,16 @@ static inline void perf_sample_save_brstack(struct perf_sample_data *data,
>  		size += sizeof(u64);
>  	size += brs->nr * sizeof(struct perf_branch_entry);
>  
> +	/*
> +	 * The extension space is appended after the struct perf_branch_stack.
> +	 * It is used to store the extra data of each branch, e.g.,
> +	 * the occurrences of events since the last branch entry for Intel LBR.
> +	 */
> +	if (branch_sample_extra(event))
> +		size += brs->nr * sizeof(u64);
> +
>  	data->br_stack = brs;
> +	data->br_stack_ext = brs_ext;
>  	data->dyn_size += size;
>  	data->sample_flags |= PERF_SAMPLE_BRANCH_STACK;
>  }
> diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
> index 39c6a250dd1b..252066579dae 100644
> --- a/include/uapi/linux/perf_event.h
> +++ b/include/uapi/linux/perf_event.h
> @@ -204,6 +204,10 @@ enum perf_branch_sample_type_shift {
>  
>  	PERF_SAMPLE_BRANCH_PRIV_SAVE_SHIFT	= 18, /* save privilege mode */
>  
> +	PERF_SAMPLE_BRANCH_EXTRA_SHIFT		= 19, /* support extra space */
> +
> +	PERF_SAMPLE_BRANCH_EVT_CNTRS_SHIFT	= 20, /* save occurrences of events on a branch */
> +
>  	PERF_SAMPLE_BRANCH_MAX_SHIFT		/* non-ABI */
>  };
>  
> @@ -235,6 +239,10 @@ enum perf_branch_sample_type {
>  
>  	PERF_SAMPLE_BRANCH_PRIV_SAVE	= 1U << PERF_SAMPLE_BRANCH_PRIV_SAVE_SHIFT,
>  
> +	PERF_SAMPLE_BRANCH_EXTRA	= 1U << PERF_SAMPLE_BRANCH_EXTRA_SHIFT,
> +
> +	PERF_SAMPLE_BRANCH_EVT_CNTRS	= 1U << PERF_SAMPLE_BRANCH_EVT_CNTRS_SHIFT,
> +
>  	PERF_SAMPLE_BRANCH_MAX		= 1U << PERF_SAMPLE_BRANCH_MAX_SHIFT,
>  };
>  
> @@ -982,6 +990,7 @@ enum perf_event_type {
>  	 *	{ u64                   nr;
>  	 *	  { u64	hw_idx; } && PERF_SAMPLE_BRANCH_HW_INDEX
>  	 *        { u64 from, to, flags } lbr[nr];
> +	 *        { u64 extra; } ext[nr] && PERF_SAMPLE_BRANCH_EXTRA
>  	 *      } && PERF_SAMPLE_BRANCH_STACK
>  	 *
>  	 * 	{ u64			abi; # enum perf_sample_regs_abi
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index f84e2640ea2f..482e7efe365c 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -7324,6 +7324,14 @@ void perf_output_sample(struct perf_output_handle *handle,
>  			if (branch_sample_hw_index(event))
>  				perf_output_put(handle, data->br_stack->hw_idx);
>  			perf_output_copy(handle, data->br_stack->entries, size);
> +			/*
> +			 * Add the extension space which is appended
> +			 * right after the struct perf_branch_stack.
> +			 */
> +			if (branch_sample_extra(event) && data->br_stack_ext) {
> +				size = data->br_stack->nr * sizeof(u64);
> +				perf_output_copy(handle, data->br_stack_ext, size);
> +			}
>  		} else {
>  			/*
>  			 * we always store at least the value of nr
