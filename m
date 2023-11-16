Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 248A17EE777
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 20:26:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345514AbjKPT0x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 14:26:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjKPT0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 14:26:50 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D9B2CD4D
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 11:26:46 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9A7F61595;
        Thu, 16 Nov 2023 11:27:32 -0800 (PST)
Received: from [10.57.84.40] (unknown [10.57.84.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9A0753F6C4;
        Thu, 16 Nov 2023 11:26:43 -0800 (PST)
Message-ID: <0ebe2a54-8111-4e8e-8afe-3e17ce85fcb9@arm.com>
Date:   Thu, 16 Nov 2023 19:26:42 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/6] arm64: KVM: Add interface to set guest value for
 TRFCR register
Content-Language: en-GB
To:     James Clark <james.clark@arm.com>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        maz@kernel.org
Cc:     broonie@kernel.org, Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Rob Herring <robh@kernel.org>,
        Jintack Lim <jintack.lim@linaro.org>,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        Fuad Tabba <tabba@google.com>,
        Akihiko Odaki <akihiko.odaki@daynix.com>,
        Joey Gouly <joey.gouly@arm.com>, linux-kernel@vger.kernel.org
References: <20231019165510.1966367-1-james.clark@arm.com>
 <20231019165510.1966367-5-james.clark@arm.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20231019165510.1966367-5-james.clark@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/10/2023 17:55, James Clark wrote:
> Add an interface for the Coresight driver to use to set the value of the
> TRFCR register for the guest. This register controls the exclude
> settings for trace at different exception levels, and is used to honor
> the exclude_host and exclude_guest parameters from the Perf session.
> This will be used to later write TRFCR_EL1 on nVHE at guest switch. For
> VHE, the host trace is controlled by TRFCR_EL2 and thus we can write to
> the TRFCR_EL1 immediately. Because guest writes to the register are
> trapped, the value will persist and can't be modified.

This could also be added below to make it easier for the code reader.

> 
> The settings must be copied to the vCPU before each run in the same
> way that PMU events are, because the per-cpu struct isn't accessible in
> protected mode.
> 
> Signed-off-by: James Clark <james.clark@arm.com>
> ---
>   arch/arm64/include/asm/kvm_host.h |  3 +++
>   arch/arm64/kvm/arm.c              |  1 +
>   arch/arm64/kvm/debug.c            | 26 ++++++++++++++++++++++++++
>   3 files changed, 30 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> index 0f0bf8e641bd..e1852102550d 100644
> --- a/arch/arm64/include/asm/kvm_host.h
> +++ b/arch/arm64/include/asm/kvm_host.h
> @@ -1125,6 +1125,8 @@ void kvm_arch_vcpu_put_debug_state_flags(struct kvm_vcpu *vcpu);
>   void kvm_set_pmu_events(u32 set, struct perf_event_attr *attr);
>   void kvm_clr_pmu_events(u32 clr);
>   bool kvm_set_pmuserenr(u64 val);
> +void kvm_etm_set_guest_trfcr(u64 trfcr_guest);
> +void kvm_etm_update_vcpu_events(struct kvm_vcpu *vcpu);
>   #else
>   static inline void kvm_set_pmu_events(u32 set, struct perf_event_attr *attr) {}
>   static inline void kvm_clr_pmu_events(u32 clr) {}
> @@ -1132,6 +1134,7 @@ static inline bool kvm_set_pmuserenr(u64 val)
>   {
>   	return false;
>   }
> +static inline void kvm_etm_set_guest_trfcr(u64 trfcr_guest) {}
>   #endif
>   
>   void kvm_vcpu_load_sysregs_vhe(struct kvm_vcpu *vcpu);
> diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
> index 0f717b6a9151..e4d846f2f665 100644
> --- a/arch/arm64/kvm/arm.c
> +++ b/arch/arm64/kvm/arm.c
> @@ -1015,6 +1015,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
>   		kvm_vgic_flush_hwstate(vcpu);
>   
>   		kvm_pmu_update_vcpu_events(vcpu);
> +		kvm_etm_update_vcpu_events(vcpu);
>   
>   		/*
>   		 * Ensure we set mode to IN_GUEST_MODE after we disable
> diff --git a/arch/arm64/kvm/debug.c b/arch/arm64/kvm/debug.c
> index 20cdd40b3c42..2ab41b954512 100644
> --- a/arch/arm64/kvm/debug.c
> +++ b/arch/arm64/kvm/debug.c
> @@ -23,6 +23,12 @@
>   
>   static DEFINE_PER_CPU(u64, mdcr_el2);
>   
> +/*
> + * Per CPU value for TRFCR that should be applied to any guest vcpu that may
> + * run on that core in the future.
> + */
> +static DEFINE_PER_CPU(u64, guest_trfcr);
> +
>   /**
>    * save/restore_guest_debug_regs
>    *
> @@ -356,3 +362,23 @@ void kvm_arch_vcpu_put_debug_state_flags(struct kvm_vcpu *vcpu)
>   	vcpu_clear_flag(vcpu, DEBUG_STATE_SAVE_TRBE);
>   	vcpu_clear_flag(vcpu, DEBUG_STATE_SAVE_TRFCR);
>   }
> +

The comment in the description could be helpful here.

> +void kvm_etm_set_guest_trfcr(u64 trfcr_guest)
> +{
> +	if (has_vhe())
> +		write_sysreg_s(trfcr_guest, SYS_TRFCR_EL12);
> +	else
> +		*this_cpu_ptr(&guest_trfcr) = trfcr_guest;
> +}
> +EXPORT_SYMBOL_GPL(kvm_etm_set_guest_trfcr);
> +
> +/*
> + * Updates the vcpu's view of the etm events for this cpu. Must be
> + * called before every vcpu run after disabling interrupts, to ensure
> + * that an interrupt cannot fire and update the structure.
> + */
> +void kvm_etm_update_vcpu_events(struct kvm_vcpu *vcpu)
> +{
> +	if (!has_vhe() && vcpu_get_flag(vcpu, DEBUG_STATE_SAVE_TRFCR))
> +		ctxt_sys_reg(&vcpu->arch.ctxt, TRFCR_EL1) = *this_cpu_ptr(&guest_trfcr);
> +}

Either way,

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
