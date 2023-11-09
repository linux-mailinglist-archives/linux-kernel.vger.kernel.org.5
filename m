Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C4A97E6486
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 08:39:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233763AbjKIHjq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 02:39:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233661AbjKIHjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 02:39:35 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C71F42D62;
        Wed,  8 Nov 2023 23:39:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699515550; x=1731051550;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=3ASWqM4COtSvfUNBd+qgXRsrc+ivOwB+ZSi3IbAEev4=;
  b=EqNd1oFNlBeO0KCyYe3da2zZok6nEb8jiaKqdMpMmu6fHwBpVv9YKi1K
   o60mtz8SKwDBdiZ/Ecm15oBIXlNFPKXsLoX3+ljJYM5MznKTDNEmv9ZD5
   3AjTYlmDLaIjc8jhvkWSeSzUP/0Yd9cEkT32MerkGBqKSeXQXfY0ZzU38
   N++nLL8tIIMK7l+18RMz3utZhPatHEYghSUnnAxQMgUfa3xv1lvm7J9sp
   +HPZMyY/lDm87F5Fndam7r3Vp4qYDFF2S7cJmOs97YQsrh6LXOMjDqIfq
   u1hCWMeiW6upXrIOPJkggkz3e7Mq5kvithfpFNsX5diSHQfZJg/4k5Tci
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10888"; a="389739711"
X-IronPort-AV: E=Sophos;i="6.03,288,1694761200"; 
   d="scan'208";a="389739711"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2023 23:39:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10888"; a="886919486"
X-IronPort-AV: E=Sophos;i="6.03,288,1694761200"; 
   d="scan'208";a="886919486"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.93.5.53]) ([10.93.5.53])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2023 23:39:07 -0800
Message-ID: <b62e34cc-2756-4d69-b75a-26919a3e0ef7@linux.intel.com>
Date:   Thu, 9 Nov 2023 15:39:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 13/19] KVM: selftests: Add functional test for Intel's
 fixed PMU counters
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Jim Mattson <jmattson@google.com>,
        Jinrong Liang <cloudliang@tencent.com>,
        Aaron Lewis <aaronlewis@google.com>,
        Like Xu <likexu@tencent.com>
References: <20231108003135.546002-1-seanjc@google.com>
 <20231108003135.546002-14-seanjc@google.com>
From:   "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20231108003135.546002-14-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/8/2023 8:31 AM, Sean Christopherson wrote:
> From: Jinrong Liang <cloudliang@tencent.com>
>
> Extend the fixed counters test to verify that supported counters can
> actually be enabled in the control MSRs, that unsupported counters cannot,
> and that enabled counters actually count.
>
> Co-developed-by: Like Xu <likexu@tencent.com>
> Signed-off-by: Like Xu <likexu@tencent.com>
> Signed-off-by: Jinrong Liang <cloudliang@tencent.com>
> [sean: fold into the rd/wr access test, massage changelog]
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>   .../selftests/kvm/x86_64/pmu_counters_test.c  | 31 ++++++++++++++++++-
>   1 file changed, 30 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c b/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c
> index 8c934e261f2d..b9c073d3ade9 100644
> --- a/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c
> +++ b/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c
> @@ -324,7 +324,6 @@ static void guest_rd_wr_counters(uint32_t base_msr, uint8_t nr_possible_counters
>   		vector = wrmsr_safe(msr, 0);
>   		GUEST_ASSERT_PMC_MSR_ACCESS(WRMSR, msr, expect_gp, vector);
>   	}
> -	GUEST_DONE();
>   }
>   
>   static void guest_test_gp_counters(void)
> @@ -342,6 +341,7 @@ static void guest_test_gp_counters(void)
>   		base_msr = MSR_IA32_PERFCTR0;
>   
>   	guest_rd_wr_counters(base_msr, MAX_NR_GP_COUNTERS, nr_gp_counters, 0);
> +	GUEST_DONE();
>   }
>   
>   static void test_gp_counters(uint8_t pmu_version, uint64_t perf_capabilities,
> @@ -365,6 +365,7 @@ static void guest_test_fixed_counters(void)
>   {
>   	uint64_t supported_bitmask = 0;
>   	uint8_t nr_fixed_counters = 0;
> +	uint8_t i;
>   
>   	/* Fixed counters require Architectural vPMU Version 2+. */
>   	if (guest_get_pmu_version() >= 2)
> @@ -379,6 +380,34 @@ static void guest_test_fixed_counters(void)
>   
>   	guest_rd_wr_counters(MSR_CORE_PERF_FIXED_CTR0, MAX_NR_FIXED_COUNTERS,
>   			     nr_fixed_counters, supported_bitmask);
> +
> +	for (i = 0; i < MAX_NR_FIXED_COUNTERS; i++) {
> +		uint8_t vector;
> +		uint64_t val;
> +
> +		if (i >= nr_fixed_counters && !(supported_bitmask & BIT_ULL(i))) {
> +			vector = wrmsr_safe(MSR_CORE_PERF_FIXED_CTR_CTRL,
> +					    FIXED_PMC_CTRL(i, FIXED_PMC_KERNEL));
> +			__GUEST_ASSERT(vector == GP_VECTOR,
> +				       "Expected #GP for counter %u in FIXED_CTR_CTRL", i);
> +
> +			vector = wrmsr_safe(MSR_CORE_PERF_GLOBAL_CTRL,
> +					    FIXED_PMC_GLOBAL_CTRL_ENABLE(i));
> +			__GUEST_ASSERT(vector == GP_VECTOR,
> +				       "Expected #GP for counter %u in PERF_GLOBAL_CTRL", i);
> +			continue;
> +		}
> +
> +		wrmsr(MSR_CORE_PERF_FIXED_CTR0 + i, 0);
> +		wrmsr(MSR_CORE_PERF_FIXED_CTR_CTRL, FIXED_PMC_CTRL(i, FIXED_PMC_KERNEL));
> +		wrmsr(MSR_CORE_PERF_GLOBAL_CTRL, FIXED_PMC_GLOBAL_CTRL_ENABLE(i));
> +		__asm__ __volatile__("loop ." : "+c"((int){NUM_BRANCHES}));

This assembly code seems to be called many times, we may wrap it into a 
macro or function.

Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>


> +		wrmsr(MSR_CORE_PERF_GLOBAL_CTRL, 0);
> +		val = rdmsr(MSR_CORE_PERF_FIXED_CTR0 + i);
> +
> +		GUEST_ASSERT_NE(val, 0);
> +	}
> +	GUEST_DONE();
>   }
>   
>   static void test_fixed_counters(uint8_t pmu_version, uint64_t perf_capabilities,
