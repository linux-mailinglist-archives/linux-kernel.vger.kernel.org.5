Return-Path: <linux-kernel+bounces-81754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D0DF8679C1
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 16:14:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5E2429DB24
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 15:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DF9D136654;
	Mon, 26 Feb 2024 15:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kwfH7y3J"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B0813664B;
	Mon, 26 Feb 2024 15:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708959700; cv=none; b=bmEXCqDldWYwnxS9nlZFPrqXFUYtEhP+mTQ4TlR/ewG5MdxmIXn2kKJyzQCgQOOT9gbSjc/WTwWtt2ij0BRpQy3c9uRlvmt+C9Se4kZBeK5k4eP5eNLHI17DJpMdADehuGixFCrJG9cXmOkn4HgJ04Kzy1XcSfs0hKdxOfX2msw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708959700; c=relaxed/simple;
	bh=D8HlEBqMqa8Slmy0g5ueUVqytfKUCj85MN8+CdplaqM=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=udvME7CKb6z2U6s6eizomjPvHmgKCNQGLGNrYMTOADS4fK8BMxTid5BmIicyi4JWPEaiY1xPNVotb4VmxLkyEDkl4Y6Je2e5J3q4F8E1JONi+5C2WyHvKQAt1GurBpP6wO60QmlWiFe8tx433xu+Lnh3+fBcCJ2kt9ZLjfN+tQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kwfH7y3J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76AC8C43390;
	Mon, 26 Feb 2024 15:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708959699;
	bh=D8HlEBqMqa8Slmy0g5ueUVqytfKUCj85MN8+CdplaqM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kwfH7y3J13gAalkPS3+SMe3tnFBXCZCfL2ArmHbC8gG6YEUOdSfDGZDBR/hOmQIsl
	 XQCtM5c/W9/yjbmIsPZGnB+H0RZDY9SvukwfWbzXOPoOrR5SA5MzRDxp3UUdFOEwq9
	 QGAn2tY+CPrr40nvmShNdtT2H0AkH8iMkdkwfiSxRRq2gTaR1c8X0XqknTXFBrcMl4
	 v7x0gire2v1iA/DTYaGlXcBqZPnMIdDmuOUxMnjkOA6/j00OJbgsr1mjTn1yDvGPfU
	 wSwpKC0ze/oUgwUE8ln8NmwNUsquLkEAqVF/tlbf10/2FUgQNG07RDoil9hMh8BTOM
	 tw1gq12sAiO4w==
Received: from sofa.misterjones.org ([185.219.108.64] helo=goblin-girl.misterjones.org)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1recU4-006uX5-Lk;
	Mon, 26 Feb 2024 15:01:36 +0000
Date: Mon, 26 Feb 2024 15:01:35 +0000
Message-ID: <86cysj2rsg.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: James Clark <james.clark@arm.com>
Cc: coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	suzuki.poulose@arm.com,
	acme@kernel.org,
	oliver.upton@linux.dev,
	broonie@kernel.org,
	James Morse <james.morse@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mike Leach <mike.leach@linaro.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Miguel Luis <miguel.luis@oracle.com>,
	Joey Gouly <joey.gouly@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Kalesh Singh <kaleshsingh@google.com>,
	Vincent Donnefort <vdonnefort@google.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Fuad Tabba <tabba@google.com>,
	Jing Zhang <jingzhangos@google.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 6/8] arm64: KVM: Add interface to set guest value for TRFCR register
In-Reply-To: <20240226113044.228403-7-james.clark@arm.com>
References: <20240226113044.228403-1-james.clark@arm.com>
	<20240226113044.228403-7-james.clark@arm.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/29.1
 (aarch64-unknown-linux-gnu) MULE/6.0 (HANACHIRUSATO)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: james.clark@arm.com, coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, suzuki.poulose@arm.com, acme@kernel.org, oliver.upton@linux.dev, broonie@kernel.org, james.morse@arm.com, yuzenghui@huawei.com, catalin.marinas@arm.com, will@kernel.org, mike.leach@linaro.org, alexander.shishkin@linux.intel.com, anshuman.khandual@arm.com, miguel.luis@oracle.com, joey.gouly@arm.com, ardb@kernel.org, mark.rutland@arm.com, gregkh@linuxfoundation.org, arnd@arndb.de, kaleshsingh@google.com, vdonnefort@google.com, ryan.roberts@arm.com, tabba@google.com, jingzhangos@google.com, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

On Mon, 26 Feb 2024 11:30:34 +0000,
James Clark <james.clark@arm.com> wrote:
> 
> Add an interface for the Coresight driver to use to set the value of the
> TRFCR register for the guest. This register controls the exclude

This is not *for* the guest. It is the *host* value while running the
guest.

> settings for trace at different exception levels, and is used to honor
> the exclude_host and exclude_guest parameters from the Perf session.
> This will be used to later write TRFCR_EL1 on nVHE at guest switch. For
> VHE, the host trace is controlled by TRFCR_EL2 and thus we can write to
> the TRFCR_EL1 immediately. Because guest writes to the register are
> trapped, the value will persist and can't be modified.

See?

> 
> Instead of adding a load of infrastructure to share the host's per-cpu
> offsets with the hypervisor, just define the new storage as a NR_CPUS
> array.
> 
> Signed-off-by: James Clark <james.clark@arm.com>
> ---
>  arch/arm64/include/asm/kvm_host.h |  3 +++
>  arch/arm64/kernel/image-vars.h    |  1 +
>  arch/arm64/kvm/debug.c            | 29 +++++++++++++++++++++++++++++
>  3 files changed, 33 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> index 85b5477bd1b4..56b7f7eca195 100644
> --- a/arch/arm64/include/asm/kvm_host.h
> +++ b/arch/arm64/include/asm/kvm_host.h
> @@ -509,6 +509,7 @@ struct kvm_host_psci_config {
>  	bool psci_0_1_cpu_off_implemented;
>  	bool psci_0_1_migrate_implemented;
>  };
> +extern u64 ____cacheline_aligned kvm_guest_trfcr[NR_CPUS];

Great. So you are making it a guarantee that this is going to
ping-pong on every CPU that accesses this stuff. I'm sure my nVHE 64
core system is going to enjoy it. Not.

Look, we already have some per-CPU context: it's called kvm_host_data,
and we link to it from each and every vcpu. So as long as you're in
the context of a vcpu, you have access to it. Simples. We even have
accessors that pick the correct instance between VHE and (n/h)VHE.

What is wrong with using that?

>  
>  extern struct kvm_host_psci_config kvm_nvhe_sym(kvm_host_psci_config);
>  #define kvm_host_psci_config CHOOSE_NVHE_SYM(kvm_host_psci_config)
> @@ -1174,6 +1175,7 @@ void kvm_arch_vcpu_put_debug_state_flags(struct kvm_vcpu *vcpu);
>  void kvm_set_pmu_events(u32 set, struct perf_event_attr *attr);
>  void kvm_clr_pmu_events(u32 clr);
>  bool kvm_set_pmuserenr(u64 val);
> +void kvm_etm_set_guest_trfcr(u64 trfcr_guest);
>  #else
>  static inline void kvm_set_pmu_events(u32 set, struct perf_event_attr *attr) {}
>  static inline void kvm_clr_pmu_events(u32 clr) {}
> @@ -1181,6 +1183,7 @@ static inline bool kvm_set_pmuserenr(u64 val)
>  {
>  	return false;
>  }
> +static inline void kvm_etm_set_guest_trfcr(u64 trfcr_guest) {}
>  #endif
>  
>  void kvm_vcpu_load_vhe(struct kvm_vcpu *vcpu);
> diff --git a/arch/arm64/kernel/image-vars.h b/arch/arm64/kernel/image-vars.h
> index 31daa1da191c..fe9e2bd7f43a 100644
> --- a/arch/arm64/kernel/image-vars.h
> +++ b/arch/arm64/kernel/image-vars.h
> @@ -59,6 +59,7 @@ KVM_NVHE_ALIAS(alt_cb_patch_nops);
>  
>  /* Global kernel state accessed by nVHE hyp code. */
>  KVM_NVHE_ALIAS(kvm_vgic_global_state);
> +KVM_NVHE_ALIAS(kvm_guest_trfcr);
>  
>  /* Kernel symbols used to call panic() from nVHE hyp code (via ERET). */
>  KVM_NVHE_ALIAS(nvhe_hyp_panic_handler);
> diff --git a/arch/arm64/kvm/debug.c b/arch/arm64/kvm/debug.c
> index 49a13e72ddd2..fe90bc7d6dd4 100644
> --- a/arch/arm64/kvm/debug.c
> +++ b/arch/arm64/kvm/debug.c
> @@ -22,6 +22,7 @@
>  				DBG_MDSCR_MDE)
>  
>  static DEFINE_PER_CPU(u64, mdcr_el2);
> +u64 ____cacheline_aligned kvm_guest_trfcr[NR_CPUS];
>  
>  /*
>   * save/restore_guest_debug_regs
> @@ -359,3 +360,31 @@ void kvm_arch_vcpu_put_debug_state_flags(struct kvm_vcpu *vcpu)
>  	vcpu_clear_flag(vcpu, DEBUG_STATE_SAVE_TRBE);
>  	vcpu_clear_flag(vcpu, DEBUG_STATE_SAVE_TRFCR);
>  }
> +
> +/*
> + * Interface for the Coresight driver to use to set the value of the TRFCR

nit: s/to use//

> + * register for the guest. This register controls the exclude settings for trace

s/for the guest/for *tracing* the guest/

> + * at different exception levels, and is used to honor the exclude_host and
> + * exclude_guest parameters from the Perf session.
> + *
> + * This will be used to later write TRFCR_EL1 on nVHE at guest switch. For VHE,
> + * the host trace is controlled by TRFCR_EL2 and thus we can write to the

s/to the/to/

> + * TRFCR_EL1 immediately. Because guest writes to the register are trapped, the
> + * value will persist and can't be modified. For pKVM, kvm_guest_trfcr can't
> + * be read by the hypervisor, so don't bother writing it.

I don't know what you mean by "can't be read". Because controlling all
of the EL1 memory is not enough?

> + */
> +void kvm_etm_set_guest_trfcr(u64 trfcr_guest)
> +{
> +	if (WARN_ON_ONCE(!cpuid_feature_extract_unsigned_field(read_sysreg(id_aa64dfr0_el1),
> +							       ID_AA64DFR0_EL1_TraceFilt_SHIFT)))
> +		return;
> +
> +	/* Warn in invalid use of smp_processor_id() */
> +	WARN_ON_ONCE(preemptible());

What does it buy us to WARN, but continue to do the *wrong* thing?

> +
> +	if (has_vhe())
> +		write_sysreg_s(trfcr_guest, SYS_TRFCR_EL12);

Please use write_sysreg_el1() instead.

> +	else if (!is_protected_kvm_enabled())
> +		kvm_guest_trfcr[smp_processor_id()] = trfcr_guest;
> +}
> +EXPORT_SYMBOL_GPL(kvm_etm_set_guest_trfcr);

Thanks,

	M.

-- 
Without deviation from the norm, progress is not possible.

