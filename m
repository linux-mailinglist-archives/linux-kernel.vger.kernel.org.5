Return-Path: <linux-kernel+bounces-48494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20368845D04
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 17:20:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F40C4B28227
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 16:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D390515F314;
	Thu,  1 Feb 2024 16:14:27 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F21741649C6
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 16:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706804067; cv=none; b=N/x3T8Vs3Z1Viz2BA1LnfZBCDN8aqPQw6GR9NFRcnkp4FnrWSoFs+WwstND5vVyR9+lv2nR0889gkzx42+bFrf+K2y57QIgj2r2yDzhQeG6PGSVj7uMafmUP2p2bS8Mj68MK6J5/xnCUEAeGvUusbQQuDpoRyIQub8kn8zrcpX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706804067; c=relaxed/simple;
	bh=I2iQg10hWdVozFDY8hY/xeo6vUVw0V5jMT5OkqOtfeY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sE0PBbOthifcN+3Q1Kej37Dzut07LuLcX9TwTSaK5IsH2DfsayuxX8EQT2eRQ7hF73GiBX7XdmYUrXtbN0bTaieguYIq1+zhMSo6Z7iZUri4UCrQQ1Mltwplbq2d4BZ62OuJCm9j0VKp8aIpgTKqwxmaHzz7AK3zVv2i0Rcm61s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 09F36DA7;
	Thu,  1 Feb 2024 08:15:07 -0800 (PST)
Received: from [192.168.1.100] (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E4F9F3F738;
	Thu,  1 Feb 2024 08:14:20 -0800 (PST)
Message-ID: <486c9452-2d36-f7c7-8b54-38427336d4c1@arm.com>
Date: Thu, 1 Feb 2024 16:14:11 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v4 2/7] arm64: KVM: Use shared area to pass PMU event
 state to hypervisor
Content-Language: en-US
To: maz@kernel.org
Cc: Oliver Upton <oliver.upton@linux.dev>, James Morse <james.morse@arm.com>,
 Zenghui Yu <yuzenghui@huawei.com>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linaro.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>, Rob Herring
 <robh@kernel.org>, Miguel Luis <miguel.luis@oracle.com>,
 Jintack Lim <jintack.lim@linaro.org>, Ard Biesheuvel <ardb@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>,
 Vincent Donnefort <vdonnefort@google.com>,
 Kristina Martsenko <kristina.martsenko@arm.com>,
 Fuad Tabba <tabba@google.com>, Joey Gouly <joey.gouly@arm.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, Jing Zhang
 <jingzhangos@google.com>, linux-kernel@vger.kernel.org,
 coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.linux.dev, broonie@kernel.org, suzuki.poulose@arm.com,
 acme@kernel.org
References: <20240104162714.1062610-1-james.clark@arm.com>
 <20240104162714.1062610-3-james.clark@arm.com>
From: James Clark <james.clark@arm.com>
In-Reply-To: <20240104162714.1062610-3-james.clark@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 04/01/2024 16:27, James Clark wrote:
> Currently the state of the PMU events is copied into the VCPU struct
> before every VCPU run. This isn't scalable if more data for other
> features needs to be added too. So make a writable area that's shared
> between the host and the hypervisor to store this state.
> 
> Normal per-cpu constructs can't be used because although the framework
> exists for the host to write to the hypervisor's per-cpu structs, this
> only works until the protection is enabled. And for the other way
> around, no framework exists for the hypervisor to access the host's size
> and layout of per-cpu data. Instead of making a new framework for the
> hypervisor to access the host's per-cpu data that would only be used
> once, just define the new shared area as an array with NR_CPUS elements.
> This also reduces the amount of sharing that needs to be done, because
> unlike this array, the per-cpu data isn't contiguous.
> 
> Signed-off-by: James Clark <james.clark@arm.com>

Hi Marc,

Do you have any feedback about whether this what you were thinking of in
your comment here:
https://lore.kernel.org/kvmarm/86msuqb84g.wl-maz@kernel.org/

Thanks
James

> ---
>  arch/arm64/include/asm/kvm_host.h |  8 ++++++++
>  arch/arm64/kernel/image-vars.h    |  1 +
>  arch/arm64/kvm/arm.c              | 16 ++++++++++++++--
>  arch/arm64/kvm/hyp/nvhe/setup.c   | 11 +++++++++++
>  arch/arm64/kvm/hyp/nvhe/switch.c  |  9 +++++++--
>  arch/arm64/kvm/pmu.c              |  4 +---
>  include/kvm/arm_pmu.h             | 17 -----------------
>  7 files changed, 42 insertions(+), 24 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> index 824f29f04916..93d38ad257ed 100644
> --- a/arch/arm64/include/asm/kvm_host.h
> +++ b/arch/arm64/include/asm/kvm_host.h
> @@ -466,6 +466,14 @@ struct kvm_cpu_context {
>  	struct kvm_vcpu *__hyp_running_vcpu;
>  };
>  
> +struct kvm_host_global_state {
> +	struct kvm_pmu_events {
> +		u32 events_host;
> +		u32 events_guest;
> +	} pmu_events;
> +} ____cacheline_aligned;
> +extern struct kvm_host_global_state kvm_host_global_state[NR_CPUS];
> +
>  struct kvm_host_data {
>  	struct kvm_cpu_context host_ctxt;
>  };
> diff --git a/arch/arm64/kernel/image-vars.h b/arch/arm64/kernel/image-vars.h
> index 119ca121b5f8..1a9dbb02bb4a 100644
> --- a/arch/arm64/kernel/image-vars.h
> +++ b/arch/arm64/kernel/image-vars.h
> @@ -59,6 +59,7 @@ KVM_NVHE_ALIAS(alt_cb_patch_nops);
>  
>  /* Global kernel state accessed by nVHE hyp code. */
>  KVM_NVHE_ALIAS(kvm_vgic_global_state);
> +KVM_NVHE_ALIAS(kvm_host_global_state);
>  
>  /* Kernel symbols used to call panic() from nVHE hyp code (via ERET). */
>  KVM_NVHE_ALIAS(nvhe_hyp_panic_handler);
> diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
> index 4796104c4471..bd6b2eda5f4f 100644
> --- a/arch/arm64/kvm/arm.c
> +++ b/arch/arm64/kvm/arm.c
> @@ -47,6 +47,20 @@
>  
>  static enum kvm_mode kvm_mode = KVM_MODE_DEFAULT;
>  
> +/*
> + * Host state that isn't associated with any VCPU, but will affect any VCPU
> + * running on a host CPU in the future. This remains writable from the host and
> + * readable in the hyp.
> + *
> + * PER_CPU constructs aren't compatible between the hypervisor and the host so
> + * just define it as a NR_CPUS array. DECLARE_KVM_NVHE_PER_CPU works in both
> + * places, but not after the hypervisor protection is initialised. After that,
> + * kvm_arm_hyp_percpu_base isn't accessible from the host, so even if the
> + * kvm_host_global_state struct was shared with the host, the per-cpu offset
> + * can't be calculated without sharing even more data with the host.
> + */
> +struct kvm_host_global_state kvm_host_global_state[NR_CPUS];
> +
>  DECLARE_KVM_HYP_PER_CPU(unsigned long, kvm_hyp_vector);
>  
>  DEFINE_PER_CPU(unsigned long, kvm_arm_hyp_stack_page);
> @@ -1016,8 +1030,6 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
>  
>  		kvm_vgic_flush_hwstate(vcpu);
>  
> -		kvm_pmu_update_vcpu_events(vcpu);
> -
>  		/*
>  		 * Ensure we set mode to IN_GUEST_MODE after we disable
>  		 * interrupts and before the final VCPU requests check.
> diff --git a/arch/arm64/kvm/hyp/nvhe/setup.c b/arch/arm64/kvm/hyp/nvhe/setup.c
> index b5452e58c49a..3e45cc10ba96 100644
> --- a/arch/arm64/kvm/hyp/nvhe/setup.c
> +++ b/arch/arm64/kvm/hyp/nvhe/setup.c
> @@ -159,6 +159,17 @@ static int recreate_hyp_mappings(phys_addr_t phys, unsigned long size,
>  	if (ret)
>  		return ret;
>  
> +	/*
> +	 * Similar to kvm_vgic_global_state, but this one remains writable by
> +	 * the host rather than read-only. Used to store per-cpu state about the
> +	 * host that isn't associated with any particular VCPU.
> +	 */
> +	prot = pkvm_mkstate(KVM_PGTABLE_PROT_RW, PKVM_PAGE_SHARED_OWNED);
> +	ret = pkvm_create_mappings(&kvm_host_global_state,
> +				   &kvm_host_global_state + 1, prot);
> +	if (ret)
> +		return ret;
> +
>  	ret = create_hyp_debug_uart_mapping();
>  	if (ret)
>  		return ret;
> diff --git a/arch/arm64/kvm/hyp/nvhe/switch.c b/arch/arm64/kvm/hyp/nvhe/switch.c
> index c50f8459e4fc..89147a9dc38c 100644
> --- a/arch/arm64/kvm/hyp/nvhe/switch.c
> +++ b/arch/arm64/kvm/hyp/nvhe/switch.c
> @@ -130,13 +130,18 @@ static void __hyp_vgic_restore_state(struct kvm_vcpu *vcpu)
>  	}
>  }
>  
> +static struct kvm_pmu_events *kvm_nvhe_get_pmu_events(struct kvm_vcpu *vcpu)
> +{
> +	return &kvm_host_global_state[vcpu->cpu].pmu_events;
> +}
> +
>  /*
>   * Disable host events, enable guest events
>   */
>  #ifdef CONFIG_HW_PERF_EVENTS
>  static bool __pmu_switch_to_guest(struct kvm_vcpu *vcpu)
>  {
> -	struct kvm_pmu_events *pmu = &vcpu->arch.pmu.events;
> +	struct kvm_pmu_events *pmu = kvm_nvhe_get_pmu_events(vcpu);
>  
>  	if (pmu->events_host)
>  		write_sysreg(pmu->events_host, pmcntenclr_el0);
> @@ -152,7 +157,7 @@ static bool __pmu_switch_to_guest(struct kvm_vcpu *vcpu)
>   */
>  static void __pmu_switch_to_host(struct kvm_vcpu *vcpu)
>  {
> -	struct kvm_pmu_events *pmu = &vcpu->arch.pmu.events;
> +	struct kvm_pmu_events *pmu = kvm_nvhe_get_pmu_events(vcpu);
>  
>  	if (pmu->events_guest)
>  		write_sysreg(pmu->events_guest, pmcntenclr_el0);
> diff --git a/arch/arm64/kvm/pmu.c b/arch/arm64/kvm/pmu.c
> index a243934c5568..136d5c6c1916 100644
> --- a/arch/arm64/kvm/pmu.c
> +++ b/arch/arm64/kvm/pmu.c
> @@ -6,8 +6,6 @@
>  #include <linux/kvm_host.h>
>  #include <linux/perf_event.h>
>  
> -static DEFINE_PER_CPU(struct kvm_pmu_events, kvm_pmu_events);
> -
>  /*
>   * Given the perf event attributes and system type, determine
>   * if we are going to need to switch counters at guest entry/exit.
> @@ -28,7 +26,7 @@ static bool kvm_pmu_switch_needed(struct perf_event_attr *attr)
>  
>  struct kvm_pmu_events *kvm_get_pmu_events(void)
>  {
> -	return this_cpu_ptr(&kvm_pmu_events);
> +	return &kvm_host_global_state[smp_processor_id()].pmu_events;
>  }
>  
>  /*
> diff --git a/include/kvm/arm_pmu.h b/include/kvm/arm_pmu.h
> index 4b9d8fb393a8..71a835970ab5 100644
> --- a/include/kvm/arm_pmu.h
> +++ b/include/kvm/arm_pmu.h
> @@ -18,14 +18,8 @@ struct kvm_pmc {
>  	struct perf_event *perf_event;
>  };
>  
> -struct kvm_pmu_events {
> -	u32 events_host;
> -	u32 events_guest;
> -};
> -
>  struct kvm_pmu {
>  	struct irq_work overflow_work;
> -	struct kvm_pmu_events events;
>  	struct kvm_pmc pmc[ARMV8_PMU_MAX_COUNTERS];
>  	int irq_num;
>  	bool created;
> @@ -79,17 +73,6 @@ void kvm_vcpu_pmu_resync_el0(void);
>  #define kvm_vcpu_has_pmu(vcpu)					\
>  	(vcpu_has_feature(vcpu, KVM_ARM_VCPU_PMU_V3))
>  
> -/*
> - * Updates the vcpu's view of the pmu events for this cpu.
> - * Must be called before every vcpu run after disabling interrupts, to ensure
> - * that an interrupt cannot fire and update the structure.
> - */
> -#define kvm_pmu_update_vcpu_events(vcpu)				\
> -	do {								\
> -		if (!has_vhe() && kvm_vcpu_has_pmu(vcpu))		\
> -			vcpu->arch.pmu.events = *kvm_get_pmu_events();	\
> -	} while (0)
> -
>  /*
>   * Evaluates as true when emulating PMUv3p5, and false otherwise.
>   */

