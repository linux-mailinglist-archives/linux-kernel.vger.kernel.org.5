Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 012AE7FD99B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 15:38:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234323AbjK2OiY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 09:38:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231737AbjK2OiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 09:38:23 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3A3319A;
        Wed, 29 Nov 2023 06:38:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701268709; x=1732804709;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=iiu1CrAFtHvE/LyjDhTrOzwbBCvrQr7xMUO05abJSSU=;
  b=XZ2/sO5HrsIyTFQfcThBTuDeElZw0BLGiZM2C5135DmqWnx3t3jQxYF4
   /iyFVcQ9jqGWS2wNz9R9VtEpqTQJWq2cECOgk4aQXIYqc3XOy1xszg9PZ
   wkftTHdiv2U1vDRmnjPT+OkJxIu1lehcq5VVHiySsMkXLbWlq9ODBYwUi
   vfhWDdR4/ZZBnO+i+87kprkWb4gYmb2tpFOBJVFQorMASbD+sKKCjPI2x
   VbdwRV4gNQq6eazOg2TTe7BQYUepDCOMEigNKg8/aInc9BGChAl8mPcqI
   Q+pDMMczuOBPC88MT7PM6JAH7MSahHIFC04xbxO7CjsKlReYiLzFuzjXs
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="372536842"
X-IronPort-AV: E=Sophos;i="6.04,235,1695711600"; 
   d="scan'208";a="372536842"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 06:38:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="892468033"
X-IronPort-AV: E=Sophos;i="6.04,235,1695711600"; 
   d="scan'208";a="892468033"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 06:38:29 -0800
Received: from [10.213.167.24] (kliang2-mobl1.ccr.corp.intel.com [10.213.167.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 7005F580D96;
        Wed, 29 Nov 2023 06:38:28 -0800 (PST)
Message-ID: <6c4bd247-1f81-4b43-9e21-012f831d26b8@linux.intel.com>
Date:   Wed, 29 Nov 2023 09:38:27 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] KVM: x86/pmu: Prevent any host user from enabling PEBS
 for profiling guest
Content-Language: en-US
To:     Like Xu <like.xu.linux@gmail.com>,
        Sean Christopherson <seanjc@google.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231129095055.88060-1-likexu@tencent.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20231129095055.88060-1-likexu@tencent.com>
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



On 2023-11-29 4:50 a.m., Like Xu wrote:
> From: Like Xu <likexu@tencent.com>
> 
> Stop using PEBS counters on host to profiling guest. Limit the range of
> enabled PEBS counters to only those counters enabled from the guest PEBS
> emulation perspective.
> 
> If there is a perf-record agent on host that uses perf-tools events like
> "cpu-cycles:GP" (G for attr.exclude_host, P for max precise event counter)
> to capture guest performance events, then the guest will be hanged. This is
> because Intel DS-based PEBS buffer is addressed using the 64-bit linear
> address of the current {p/v}CPU context based on MSR_IA32_DS_AREA.
> 
> Any perf user using PEBS counters to profile guest on host is, in perf/core
> implementation details, trying to set bits on cpuc->intel_ctrl_guest_mask
> and arr[pebs_enable].guest, much like the guest PEBS emulation behaviour.
> But the subsequent PEBS memory write, regardless of whether guest PEBS is
> enabled, can overshoot guest entry and corrupt guest memory.
> 
> Profiling guest via PEBS-DS buffer on host is not supported at this time.
> Fix this by filtering the real configured value of arr[pebs_enable].guest
> with the emulated state of guest enabled PEBS counters, under the condition
> of none cross-mapped PEBS counters.

So the counter will be silently disabled. The user never knows why
nothing is sampled.
Since we don't support the case, profiling guest via PEBS-DS buffer on
host. Maybe we should error out when creating the event. For example
(not tested),

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 3871267d3237..24b90c70737f 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3958,6 +3958,10 @@ static int intel_pmu_hw_config(struct perf_event
*event)
 		if ((event->attr.config & INTEL_ARCH_EVENT_MASK) ==
INTEL_FIXED_VLBR_EVENT)
 			return -EINVAL;

+		/* Profiling guest via PEBS-DS buffer on host is not supported. */
+		if (event->attr.exclude_host)
+			return -EINVAL;
+
 		if (!(event->attr.freq || (event->attr.wakeup_events &&
!event->attr.watermark))) {
 		    event->hw.flags |= PERF_X86_EVENT_AUTO_RELOAD;
 			if (!(event->attr.sample_type &


Thanks,
Kan

> 
> Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
> Fixes: c59a1f106f5c ("KVM: x86/pmu: Add IA32_PEBS_ENABLE MSR emulation for extended PEBS")
> Signed-off-by: Like Xu <likexu@tencent.com>
> ---
>  arch/x86/events/intel/core.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index a08f794a0e79..17afd504c35b 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -4103,13 +4103,19 @@ static struct perf_guest_switch_msr *intel_guest_get_msrs(int *nr, void *data)
>  		.guest = pebs_mask & ~cpuc->intel_ctrl_host_mask,
>  	};
>  
> +	/* In any case, clear guest PEBS bits first. */
> +	arr[global_ctrl].guest &= ~arr[pebs_enable].guest;
> +
>  	if (arr[pebs_enable].host) {
>  		/* Disable guest PEBS if host PEBS is enabled. */
>  		arr[pebs_enable].guest = 0;
>  	} else {
>  		/* Disable guest PEBS thoroughly for cross-mapped PEBS counters. */
>  		arr[pebs_enable].guest &= ~kvm_pmu->host_cross_mapped_mask;
> -		arr[global_ctrl].guest &= ~kvm_pmu->host_cross_mapped_mask;
> +
> +		/* Prevent any host user from enabling PEBS for profiling guest. */
> +		arr[pebs_enable].guest &= (kvm_pmu->pebs_enable & kvm_pmu->global_ctrl);
> +
>  		/* Set hw GLOBAL_CTRL bits for PEBS counter when it runs for guest */
>  		arr[global_ctrl].guest |= arr[pebs_enable].guest;
>  	}
> 
> base-commit: 6803fb00772cc50cd59a66bd8caaee5c84b13fcf
