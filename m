Return-Path: <linux-kernel+bounces-52411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 589088497C5
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 11:29:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1096D281689
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 10:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95DB8171B0;
	Mon,  5 Feb 2024 10:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PRT5sYqw"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C7F171AE;
	Mon,  5 Feb 2024 10:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707128934; cv=none; b=uMEWPLQmwirT79cM347lmZHz4xrSuNLhpmvE47MkJhTngnF2j9OHbPjELy0Ms0phXhjyB90VzFiekQ0AmxL1GUjkYoeU66+GwNxF5l8ICNNwQ8/2hIiK9Uvs56GAHA8fHOuIHCQ7/XtJB/bH/joBTe5hUb/czesltfW1ZhNxjgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707128934; c=relaxed/simple;
	bh=m38cADo9z6VVvxj6P+Fi8aaRnZ09Ugt/ustDOItD5/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a5r3KUlt6KWUKXN7/ivZpGvzLijuMtkGB5lYe3Htf76vVN+UvVmKQxwSEXyisiRnitOF6YqEz3gYDh6wIvcpbd4Pr4sVcAUwvzevTMvOrGDURSddv2/PxxTY11dVeSA/7vJuvvUR7lp5kMrqZ8D9pGrgmgrMjAesRukL8l/4czk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PRT5sYqw; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707128933; x=1738664933;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=m38cADo9z6VVvxj6P+Fi8aaRnZ09Ugt/ustDOItD5/U=;
  b=PRT5sYqwukwfWGkE/+VuBUF9XGZRUeFu1ZqJr81mE1R5afKmSzas8j9P
   5I55Y+LuoI1xqTldPOEKkfP4KCwIvAR3yF/fMcWu7JV5F+oZA4MxphWaF
   zfRE9z0s9qa8vgjExGkCTM/LmuTEc6924ucBB8zr1wFa2cr+67ML+zBbJ
   uPdSHJRv5Gl21xqZF/+rJsYa+mIVI/xn3U10ykDhEsi67zB0BqB2h1Xf8
   kA/NIqm2rrJ62LzlwhUjIODCUlyCbE87jT//YV8WkAapBXrfbYivgAO+y
   0fSVr9BzRA7QNvc49oiMQiZ/VbhITwkCzbkEfslX+AXeKaBS8NaOXutaL
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10974"; a="11848533"
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="11848533"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 02:28:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="732928"
Received: from sgruszka-mobl.ger.corp.intel.com (HELO localhost) ([10.252.42.97])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 02:28:49 -0800
Date: Mon, 5 Feb 2024 11:28:47 +0100
From: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Len Brown <len.brown@intel.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Zhao Liu <zhao1.liu@intel.com>,
	Zhuocheng Ding <zhuocheng.ding@intel.com>, x86@kernel.org,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	Zhao Liu <zhao1.liu@linux.intel.com>
Subject: Re: [PATCH 6/9] thermal: intel: hfi: Enable Intel Thread Director
Message-ID: <ZcC4Xy9xBtBsCDLq@linux.intel.com>
References: <20240203040515.23947-1-ricardo.neri-calderon@linux.intel.com>
 <20240203040515.23947-7-ricardo.neri-calderon@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240203040515.23947-7-ricardo.neri-calderon@linux.intel.com>

On Fri, Feb 02, 2024 at 08:05:12PM -0800, Ricardo Neri wrote:
> Enable Intel Thread Director (ITD) from the CPU hotplug callback: globally
> from CPU0 and then enable the thread-classification hardware in each
> logical processor individually.
> 
> Also, initialize the number of classes supported.
> 
> Currently, a bare-metal machine does not use ITD, but KVM uses the
> attributes of the bare-metal machine to virtualize HFI.
> 
> Cc: Len Brown <len.brown@intel.com>
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Cc: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
> Cc: Zhao Liu <zhao1.liu@linux.intel.com>
> Cc: Zhuocheng Ding <zhuocheng.ding@intel.com>
> Cc: x86@kernel.org
> Cc: linux-pm@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com> # intel_hfi.c
> Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> ---
> Discussion:
> 
> This patch conflicts with a patchset from Stanislaw Gruszka to enable HFI
> only if there are user space entities listening to the thermal netlink
> events. ITD requires that HFI is enabled to function. ITD needs to be
> unconditionally enabled for virtual machines.

Why unconditionally? From what I can tell from KVM patches (please correct
me if I'm wrong) guests need to be modified to utilize HFI/ITD. Do we
also have to enable HFI/ITD if no such guest run on virtual machine ?

> Options to resolve this conflict include a command-line argument for users
> wanting to virtualize HFI or a CONFIG_ option for the same effect. QEMU
> could also learn to listen to thermal netlink event. A blunter option is
> to unconditionally enable HFI when KVM is enabled at build time.

In general similar principle should be applied - do not enable if not
needed. We should be able to get information from KVM when there is
actual need. QEMU registering to thermal events seems to be odd for
me, and I think there must be better solution.

Regards
Stanislaw

> ---
> Patch cherry-picked from the IPC classes patchset.
> ---
> ---
>  arch/x86/include/asm/hfi.h        |  9 ++++++
>  arch/x86/include/asm/msr-index.h  |  6 ++++
>  drivers/thermal/intel/intel_hfi.c | 52 +++++++++++++++++++++++++++++--
>  3 files changed, 65 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/include/asm/hfi.h b/arch/x86/include/asm/hfi.h
> index 02ee56dbaeb6..b7fda3e0e8c8 100644
> --- a/arch/x86/include/asm/hfi.h
> +++ b/arch/x86/include/asm/hfi.h
> @@ -23,6 +23,15 @@ union cpuid6_edx {
>  	u32 full;
>  };
>  
> +union cpuid6_ecx {
> +	struct {
> +		u32	dont_care0:8;
> +		u32	nr_classes:8;
> +		u32	dont_care1:16;
> +	} split;
> +	u32 full;
> +};
> +
>  /**
>   * struct hfi_hdr - Header of the HFI table
>   * @perf_updated:	Hardware updated performance capabilities
> diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
> index 46983fb0b5b3..d74932a0778d 100644
> --- a/arch/x86/include/asm/msr-index.h
> +++ b/arch/x86/include/asm/msr-index.h
> @@ -1148,6 +1148,12 @@
>  
>  #define MSR_IA32_HW_FEEDBACK_CONFIG     0x17d1
>  #define HW_FEEDBACK_CONFIG_HFI_ENABLE   BIT_ULL(0)
> +#define HW_FEEDBACK_CONFIG_ITD_ENABLE   BIT_ULL(1)
> +
> +#define MSR_IA32_HW_FEEDBACK_THREAD_CONFIG 0x17d4
> +#define HW_FEEDBACK_THREAD_CONFIG_ENABLE BIT_ULL(0)
> +
> +#define MSR_IA32_HW_FEEDBACK_CHAR       0x17d2
>  
>  /* x2APIC locked status */
>  #define MSR_IA32_XAPIC_DISABLE_STATUS	0xBD
> diff --git a/drivers/thermal/intel/intel_hfi.c b/drivers/thermal/intel/intel_hfi.c
> index 3c399f3d059f..b69fa234b317 100644
> --- a/drivers/thermal/intel/intel_hfi.c
> +++ b/drivers/thermal/intel/intel_hfi.c
> @@ -33,6 +33,7 @@
>  #include <linux/percpu-defs.h>
>  #include <linux/printk.h>
>  #include <linux/processor.h>
> +#include <linux/sched/topology.h>
>  #include <linux/slab.h>
>  #include <linux/spinlock.h>
>  #include <linux/suspend.h>
> @@ -298,6 +299,10 @@ static void hfi_enable(void)
>  
>  	rdmsrl(MSR_IA32_HW_FEEDBACK_CONFIG, msr_val);
>  	msr_val |= HW_FEEDBACK_CONFIG_HFI_ENABLE;
> +
> +	if (cpu_feature_enabled(X86_FEATURE_ITD))
> +		msr_val |= HW_FEEDBACK_CONFIG_ITD_ENABLE;
> +
>  	wrmsrl(MSR_IA32_HW_FEEDBACK_CONFIG, msr_val);
>  }
>  
> @@ -319,6 +324,10 @@ static void hfi_disable(void)
>  
>  	rdmsrl(MSR_IA32_HW_FEEDBACK_CONFIG, msr_val);
>  	msr_val &= ~HW_FEEDBACK_CONFIG_HFI_ENABLE;
> +
> +	if (cpu_feature_enabled(X86_FEATURE_ITD))
> +		msr_val &= ~HW_FEEDBACK_CONFIG_ITD_ENABLE;
> +
>  	wrmsrl(MSR_IA32_HW_FEEDBACK_CONFIG, msr_val);
>  
>  	/*
> @@ -337,6 +346,30 @@ static void hfi_disable(void)
>  	}
>  }
>  
> +static void hfi_enable_itd_classification(void)
> +{
> +	u64 msr_val;
> +
> +	if (!cpu_feature_enabled(X86_FEATURE_ITD))
> +		return;
> +
> +	rdmsrl(MSR_IA32_HW_FEEDBACK_THREAD_CONFIG, msr_val);
> +	msr_val |= HW_FEEDBACK_THREAD_CONFIG_ENABLE;
> +	wrmsrl(MSR_IA32_HW_FEEDBACK_THREAD_CONFIG, msr_val);
> +}
> +
> +static void hfi_disable_itd_classification(void)
> +{
> +	u64 msr_val;
> +
> +	if (!cpu_feature_enabled(X86_FEATURE_ITD))
> +		return;
> +
> +	rdmsrl(MSR_IA32_HW_FEEDBACK_THREAD_CONFIG, msr_val);
> +	msr_val &= ~HW_FEEDBACK_THREAD_CONFIG_ENABLE;
> +	wrmsrl(MSR_IA32_HW_FEEDBACK_THREAD_CONFIG, msr_val);
> +}
> +
>  /**
>   * intel_hfi_online() - Enable HFI on @cpu
>   * @cpu:	CPU in which the HFI will be enabled
> @@ -377,6 +410,8 @@ void intel_hfi_online(unsigned int cpu)
>  
>  	init_hfi_cpu_index(info);
>  
> +	hfi_enable_itd_classification();
> +
>  	/*
>  	 * Now check if the HFI instance of the package/die of @cpu has been
>  	 * initialized (by checking its header). In such case, all we have to
> @@ -460,6 +495,8 @@ void intel_hfi_offline(unsigned int cpu)
>  	if (!hfi_instance->local_table.hdr)
>  		return;
>  
> +	hfi_disable_itd_classification();
> +
>  	mutex_lock(&hfi_instance_lock);
>  	cpumask_clear_cpu(cpu, hfi_instance->cpus);
>  
> @@ -505,8 +542,14 @@ static __init int hfi_parse_features(void)
>  	 */
>  	hfi_features.class_stride = nr_capabilities;
>  
> -	/* For now, use only one class of the HFI table */
> -	hfi_features.nr_classes = 1;
> +	if (cpu_feature_enabled(X86_FEATURE_ITD)) {
> +		union cpuid6_ecx ecx;
> +
> +		ecx.full = cpuid_ecx(CPUID_HFI_LEAF);
> +		hfi_features.nr_classes = ecx.split.nr_classes;
> +	} else {
> +		hfi_features.nr_classes = 1;
> +	}
>  
>  	/*
>  	 * The header contains change indications for each supported feature.
> @@ -535,11 +578,16 @@ static void hfi_do_enable(void)
>  	/* No locking needed. There is no concurrency with CPU online. */
>  	hfi_set_hw_table(hfi_instance);
>  	hfi_enable();
> +
> +	hfi_enable_itd_classification();
>  }
>  
>  static int hfi_do_disable(void)
>  {
>  	/* No locking needed. There is no concurrency with CPU offline. */
> +
> +	hfi_disable_itd_classification();
> +
>  	hfi_disable();
>  
>  	return 0;
> -- 
> 2.25.1
> 

