Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C79397E645E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 08:34:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232763AbjKIHe5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 02:34:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232707AbjKIHe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 02:34:56 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9AB7D40;
        Wed,  8 Nov 2023 23:34:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699515293; x=1731051293;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=kvHm4PqW3NGwYPNqsGkDgyxCLjvtlEmhvslkk2QZ2QY=;
  b=UywRw+xPBsZR7TBjZoLLZKkcuVqCjPkWOWsxewIJH2Vijd/OgqVa7L+w
   aLNW49kdOPKKYhPXWU1iqH/7kHizxMKeoGOfMXiXiQ8ntITER/PmsSY8V
   +s5AsA2MZTmBXNp/nxYFcEiPTkAnvdWVWS+pkctTfllc1Sqr/zhle48ID
   LldKiNNtWN/+x6mAIZoDPuTz2E+tXZUbxrqhU2mheTpBJWd3p4SfnR5Vb
   PEebEwhpJ3TIVJcsjk+fDf/bzV0315QkywAnzSfAh1wBOWPsaswXykcAe
   TPlRA9KL3MFT/5ipKXbsmBSSwl+7iQ7TBM1+ClLWxRmTC8waT3r2Hxa1D
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10888"; a="421034051"
X-IronPort-AV: E=Sophos;i="6.03,288,1694761200"; 
   d="scan'208";a="421034051"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2023 23:34:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10888"; a="1094780030"
X-IronPort-AV: E=Sophos;i="6.03,288,1694761200"; 
   d="scan'208";a="1094780030"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.93.5.53]) ([10.93.5.53])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2023 23:34:50 -0800
Message-ID: <fa25f3eb-eb9a-4d83-8fdf-f133c60484da@linux.intel.com>
Date:   Thu, 9 Nov 2023 15:34:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 12/19] KVM: selftests: Test consistency of CPUID with
 num of fixed counters
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
 <20231108003135.546002-13-seanjc@google.com>
From:   "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20231108003135.546002-13-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/8/2023 8:31 AM, Sean Christopherson wrote:
> From: Jinrong Liang <cloudliang@tencent.com>
>
> Extend the PMU counters test to verify KVM emulation of fixed counters in
> addition to general purpose counters.  Fixed counters add an extra wrinkle
> in the form of an extra supported bitmask.  Thus quoth the SDM:
>
>    fixed-function performance counter 'i' is supported if ECX[i] || (EDX[4:0] > i)
>
> Test that KVM handles a counter being available through either method.
>
> Co-developed-by: Like Xu <likexu@tencent.com>
> Signed-off-by: Like Xu <likexu@tencent.com>
> Signed-off-by: Jinrong Liang <cloudliang@tencent.com>
> Co-developed-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>   .../selftests/kvm/x86_64/pmu_counters_test.c  | 60 ++++++++++++++++++-
>   1 file changed, 57 insertions(+), 3 deletions(-)
>
> diff --git a/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c b/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c
> index 6f2d3a64a118..8c934e261f2d 100644
> --- a/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c
> +++ b/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c
> @@ -285,13 +285,19 @@ __GUEST_ASSERT(expect_gp ? vector == GP_VECTOR : !vector,			\
>   	       expect_gp ? "#GP" : "no fault", msr, vector)			\
>   
>   static void guest_rd_wr_counters(uint32_t base_msr, uint8_t nr_possible_counters,
> -				 uint8_t nr_counters)
> +				 uint8_t nr_counters, uint32_t or_mask)


'or_mask' doesn't show a clear meaning, "counters_bitmap" may be a 
better name.

Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>


>   {
>   	uint8_t i;
>   
>   	for (i = 0; i < nr_possible_counters; i++) {
>   		const uint32_t msr = base_msr + i;
> -		const bool expect_success = i < nr_counters;
> +
> +		/*
> +		 * Fixed counters are supported if the counter is less than the
> +		 * number of enumerated contiguous counters *or* the counter is
> +		 * explicitly enumerated in the supported counters mask.
> +		 */
> +		const bool expect_success = i < nr_counters || (or_mask & BIT(i));
>   
>   		/*
>   		 * KVM drops writes to MSR_P6_PERFCTR[0|1] if the counters are
> @@ -335,7 +341,7 @@ static void guest_test_gp_counters(void)
>   	else
>   		base_msr = MSR_IA32_PERFCTR0;
>   
> -	guest_rd_wr_counters(base_msr, MAX_NR_GP_COUNTERS, nr_gp_counters);
> +	guest_rd_wr_counters(base_msr, MAX_NR_GP_COUNTERS, nr_gp_counters, 0);
>   }
>   
>   static void test_gp_counters(uint8_t pmu_version, uint64_t perf_capabilities,
> @@ -355,9 +361,50 @@ static void test_gp_counters(uint8_t pmu_version, uint64_t perf_capabilities,
>   	kvm_vm_free(vm);
>   }
>   
> +static void guest_test_fixed_counters(void)
> +{
> +	uint64_t supported_bitmask = 0;
> +	uint8_t nr_fixed_counters = 0;
> +
> +	/* Fixed counters require Architectural vPMU Version 2+. */
> +	if (guest_get_pmu_version() >= 2)
> +		nr_fixed_counters = this_cpu_property(X86_PROPERTY_PMU_NR_FIXED_COUNTERS);
> +
> +	/*
> +	 * The supported bitmask for fixed counters was introduced in PMU
> +	 * version 5.
> +	 */
> +	if (guest_get_pmu_version() >= 5)
> +		supported_bitmask = this_cpu_property(X86_PROPERTY_PMU_FIXED_COUNTERS_BITMASK);
> +
> +	guest_rd_wr_counters(MSR_CORE_PERF_FIXED_CTR0, MAX_NR_FIXED_COUNTERS,
> +			     nr_fixed_counters, supported_bitmask);
> +}
> +
> +static void test_fixed_counters(uint8_t pmu_version, uint64_t perf_capabilities,
> +				uint8_t nr_fixed_counters,
> +				uint32_t supported_bitmask)
> +{
> +	struct kvm_vcpu *vcpu;
> +	struct kvm_vm *vm;
> +
> +	vm = pmu_vm_create_with_one_vcpu(&vcpu, guest_test_fixed_counters,
> +					 pmu_version, perf_capabilities);
> +
> +	vcpu_set_cpuid_property(vcpu, X86_PROPERTY_PMU_FIXED_COUNTERS_BITMASK,
> +				supported_bitmask);
> +	vcpu_set_cpuid_property(vcpu, X86_PROPERTY_PMU_NR_FIXED_COUNTERS,
> +				nr_fixed_counters);
> +
> +	run_vcpu(vcpu);
> +
> +	kvm_vm_free(vm);
> +}
> +
>   static void test_intel_counters(void)
>   {
>   	uint8_t nr_arch_events = kvm_cpu_property(X86_PROPERTY_PMU_EBX_BIT_VECTOR_LENGTH);
> +	uint8_t nr_fixed_counters = kvm_cpu_property(X86_PROPERTY_PMU_NR_FIXED_COUNTERS);
>   	uint8_t nr_gp_counters = kvm_cpu_property(X86_PROPERTY_PMU_NR_GP_COUNTERS);
>   	uint8_t pmu_version = kvm_cpu_property(X86_PROPERTY_PMU_VERSION);
>   	unsigned int i;
> @@ -427,6 +474,13 @@ static void test_intel_counters(void)
>   				v, perf_caps[i]);
>   			for (j = 0; j <= nr_gp_counters; j++)
>   				test_gp_counters(v, perf_caps[i], j);
> +
> +			pr_info("Testing fixed counters, PMU version %u, perf_caps = %lx\n",
> +				v, perf_caps[i]);
> +			for (j = 0; j <= nr_fixed_counters; j++) {
> +				for (k = 0; k <= (BIT(nr_fixed_counters) - 1); k++)
> +					test_fixed_counters(v, perf_caps[i], j, k);
> +			}
>   		}
>   	}
>   }
