Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 800E780C157
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 07:31:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233440AbjLKG0M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 01:26:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjLKG0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 01:26:10 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35A96CD;
        Sun, 10 Dec 2023 22:26:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702275977; x=1733811977;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=vNb45DFkURFhGFAwMuG9PmhaPApB+4U0Sq1BO/qtZ/Q=;
  b=dY0NF6GdL+qV+9Wyh5Ar7D0UVzCII3WgNcHnFiq3Z3Zx0cEVLKei/tzh
   2drWMK49/cHav0xz+iNL1FcpIBzPbxoUBzmir0nMgJctdWNNut6eidbv4
   Pbxco4/lT4ZfbUXZLOVmYNL4OM/wpuXpeI7b0cj83iopwVzgnu1rurdJ2
   PAvjEVxzBlNXwtRTApO+5TwBqsU171KTGMEEYpExc8PjfXdbxmguqF9uh
   GichJVZdd+NdXHYRYebAozvqXSVLk1O4R3YtXqS1GNd2ZBRQ0NVLzBog2
   LolNCNAspAsL9NQKwGdf0OBWWtduQhGEX4C7LMHUMgo6cwizOA7vnq9ru
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10920"; a="1716778"
X-IronPort-AV: E=Sophos;i="6.04,267,1695711600"; 
   d="scan'208";a="1716778"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2023 22:26:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,267,1695711600"; 
   d="scan'208";a="14290999"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.93.5.53]) ([10.93.5.53])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2023 22:26:14 -0800
Message-ID: <b45efe2f-1b99-4596-b33f-d491726ed34d@linux.intel.com>
Date:   Mon, 11 Dec 2023 14:26:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 10/28] KVM: x86/pmu: Explicitly check for RDPMC of
 unsupported Intel PMC types
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Jim Mattson <jmattson@google.com>,
        Jinrong Liang <cloudliang@tencent.com>,
        Aaron Lewis <aaronlewis@google.com>,
        Like Xu <likexu@tencent.com>
References: <20231202000417.922113-1-seanjc@google.com>
 <20231202000417.922113-11-seanjc@google.com>
From:   "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20231202000417.922113-11-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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


On 12/2/2023 8:03 AM, Sean Christopherson wrote:
> Explicitly check for attempts to read unsupported PMC types instead of
> letting the bounds check fail.  Functionally, letting the check fail is
> ok, but it's unnecessarily subtle and does a poor job of documenting the
> architectural behavior that KVM is emulating.
>
> Opportunistically add macros for the type vs. index to further document
> what is going on.
>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>   arch/x86/kvm/vmx/pmu_intel.c | 11 +++++++++--
>   1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
> index 644de27bd48a..bd4f4bdf5419 100644
> --- a/arch/x86/kvm/vmx/pmu_intel.c
> +++ b/arch/x86/kvm/vmx/pmu_intel.c
> @@ -23,6 +23,9 @@
>   /* Perf's "BASE" is wildly misleading, this is a single-bit flag, not a base. */
>   #define INTEL_RDPMC_FIXED	INTEL_PMC_FIXED_RDPMC_BASE
>   
> +#define INTEL_RDPMC_TYPE_MASK	GENMASK(31, 16)
> +#define INTEL_RDPMC_INDEX_MASK	GENMASK(15, 0)
> +
>   #define MSR_PMC_FULL_WIDTH_BIT      (MSR_IA32_PMC0 - MSR_IA32_PERFCTR0)
>   
>   static void reprogram_fixed_counters(struct kvm_pmu *pmu, u64 data)
> @@ -82,9 +85,13 @@ static struct kvm_pmc *intel_rdpmc_ecx_to_pmc(struct kvm_vcpu *vcpu,
>   	/*
>   	 * Fixed PMCs are supported on all architectural PMUs.  Note, KVM only
>   	 * emulates fixed PMCs for PMU v2+, but the flag itself is still valid,
> -	 * i.e. let RDPMC fail due to accessing a non-existent counter.
> +	 * i.e. let RDPMC fail due to accessing a non-existent counter.  Reject
> +	 * attempts to read all other types, which are unknown/unsupported.
>   	 */
> -	idx &= ~INTEL_RDPMC_FIXED;
> +	if (idx & INTEL_RDPMC_TYPE_MASK & ~INTEL_RDPMC_FIXED)
> +		return NULL;
> +
> +	idx &= INTEL_RDPMC_INDEX_MASK;
>   	if (fixed) {
>   		counters = pmu->fixed_counters;
>   		num_counters = pmu->nr_arch_fixed_counters;
Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
