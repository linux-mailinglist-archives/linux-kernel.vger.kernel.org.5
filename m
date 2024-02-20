Return-Path: <linux-kernel+bounces-73477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 978E385C31D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 18:56:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53B44283CF9
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 17:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 757B677648;
	Tue, 20 Feb 2024 17:56:47 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B696476C98;
	Tue, 20 Feb 2024 17:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708451807; cv=none; b=Njr0Ksq2V2t5nvzNS0vXhSBavCPlMu7OuzX2SFdc9fhb4W+PYRv0VyP2Yoj96UrlTtmu8QfWq5VbhANbwnBEBMnzGBkZNJuGMP09gI4tT8dCaE/Hg9QiLsWzyxzhyMADcWCDk2kBPq5DFThz5SVwWzvCiZ1n1AHH+2b0DLUI8nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708451807; c=relaxed/simple;
	bh=vBVZJ8qhjBTqUAubMKlfbOnylTorwMxfjgmZNZSlUnY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GM/hjiJJg68ID752+6SwBWdP+qwiHiKnspP0nyEO9GXyL/pCAYYdzvt08Sb7CAzM69AUbed9ej/5RSOA/IjvmzPGcrNVlsYeglJGYwtjK9jjf+SpOgABGqDMA/7SkJooYcvRBhgrqAI1tBFdytX2t14lQRtl8DmL5a+uM+/0+7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E0040FEC;
	Tue, 20 Feb 2024 09:57:22 -0800 (PST)
Received: from [10.1.197.60] (eglon.cambridge.arm.com [10.1.197.60])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8DF113F762;
	Tue, 20 Feb 2024 09:56:38 -0800 (PST)
Message-ID: <50bd1168-5461-43de-9e64-cbe0019d571d@arm.com>
Date: Tue, 20 Feb 2024 17:56:36 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/17] x86/resctrl: Detect Assignable Bandwidth
 Monitoring feature details
Content-Language: en-GB
To: Babu Moger <babu.moger@amd.com>, corbet@lwn.net, fenghua.yu@intel.com,
 reinette.chatre@intel.com, tglx@linutronix.de, mingo@redhat.com,
 bp@alien8.de, dave.hansen@linux.intel.com
Cc: x86@kernel.org, hpa@zytor.com, paulmck@kernel.org, rdunlap@infradead.org,
 tj@kernel.org, peterz@infradead.org, yanjiewtw@gmail.com,
 kim.phillips@amd.com, lukas.bulwahn@gmail.com, seanjc@google.com,
 jmattson@google.com, leitao@debian.org, jpoimboe@kernel.org,
 rick.p.edgecombe@intel.com, kirill.shutemov@linux.intel.com,
 jithu.joseph@intel.com, kai.huang@intel.com, kan.liang@linux.intel.com,
 daniel.sneddon@linux.intel.com, pbonzini@redhat.com, sandipan.das@amd.com,
 ilpo.jarvinen@linux.intel.com, peternewman@google.com,
 maciej.wieczor-retman@intel.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, eranian@google.com
References: <20231201005720.235639-1-babu.moger@amd.com>
 <cover.1705688538.git.babu.moger@amd.com>
 <bba869886410265ffac0250ba2a495e3e7576dfa.1705688539.git.babu.moger@amd.com>
From: James Morse <james.morse@arm.com>
In-Reply-To: <bba869886410265ffac0250ba2a495e3e7576dfa.1705688539.git.babu.moger@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Babu,

On 19/01/2024 18:22, Babu Moger wrote:
> ABMC feature details are reported via CPUID Fn8000_0020_EBX_x5.
> Bits Description
> 15:0 MAX_ABMC Maximum Supported Assignable Bandwidth
>      Monitoring Counter ID + 1
> 
> Detect the feature details and update
> /sys/fs/resctrl/info/L3_MON/mon_features.
> 
> If the system supports Assignable Bandwidth Monitoring Counters (ABMC),
> the output will have additional text.
>  $ cat /sys/fs/resctrl/info/L3_MON/mon_features
>    mbm_assign_capable
> 
> The feature details are documented in APM listed below [1].
> [1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
> Publication # 24593 Revision 3.41 section 19.3.3.3 Assignable Bandwidth
> Monitoring (ABMC).

> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
> index 4efe2d6a9eb7..f40ee271a5c7 100644
> --- a/arch/x86/kernel/cpu/resctrl/core.c
> +++ b/arch/x86/kernel/cpu/resctrl/core.c
> @@ -303,6 +303,17 @@ static void rdt_get_cdp_l2_config(void)
>  	rdt_get_cdp_config(RDT_RESOURCE_L2);
>  }
>  
> +static void rdt_get_abmc_cfg(struct rdt_resource *r)
> +{
> +	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
> +	u32 eax, ebx, ecx, edx;
> +
> +	r->mbm_assign_capable = true;
> +	/* Query CPUID_Fn80000020_EBX_x05 for number of ABMC counters */
> +	cpuid_count(0x80000020, 5, &eax, &ebx, &ecx, &edx);

> +	hw_res->mbm_assignable_counters = (ebx & 0xFFFF) + 1;

Please put the mbm_assignable_counters field in struct rdt_resource. The filesystem code
needs to access this to allocate/free counters and report how many are available.
After all this gets split and the filesystem code moves to /fs/, the rdt_hw_resrouce
structure is inaccessible to the filesystem code.


> +}
> +
>  static void
>  mba_wrmsr_amd(struct rdt_domain *d, struct msr_param *m, struct rdt_resource *r)
>  {
> @@ -815,6 +826,12 @@ static __init bool get_rdt_alloc_resources(void)
>  	if (get_slow_mem_config())
>  		ret = true;
>  
> +	if (rdt_cpu_has(X86_FEATURE_ABMC)) {
> +		r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
> +		rdt_get_abmc_cfg(r);

> +		ret = true;

Does it make sense to report rdt_alloc_capable if the SoC has ABMC, but nothing that can
be configured?

This code would probably make more sense in the get_rdt_mon_resources().


> +	}
> +
>  	return ret;
>  }
>  
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index a4f1aa15f0a2..01eb0522b42b 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -391,6 +391,8 @@ struct rdt_parse_data {
>   *			resctrl_arch_get_num_closid() to avoid confusion
>   *			with struct resctrl_schema's property of the same name,
>   *			which has been corrected for features like CDP.

> + * @mbm_assignable_counters:
> + *			Maximum number of assignable ABMC counters

As above, please move this to struct rdt_resource. The 'hw' version becomes private to the
arch code after the move to /fs//


>   * @msr_base:		Base MSR address for CBMs
>   * @msr_update:		Function pointer to update QOS MSRs
>   * @mon_scale:		cqm counter * mon_scale = occupancy in bytes


Thanks,

James


