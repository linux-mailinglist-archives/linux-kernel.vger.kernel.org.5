Return-Path: <linux-kernel+bounces-81111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3337E867055
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 11:16:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2BE9289514
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C8413C490;
	Mon, 26 Feb 2024 09:52:37 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 307C71757E
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 09:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708941156; cv=none; b=JzR8HQeJvOhGkeVmf1uwQs3Wn51DWWXHbVa6h287vly7ngIAA1AKXJyPuUbRkEE8lrwrvlpi7g+aq6XxmXrrJnlhoXj8E6nlMxlzgMR647//k9KEJn1CLgg5YAqmEvFt98duDIBZBz7exYFEFSM3mFAk/9YlK2ZcK0oN2tJUXrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708941156; c=relaxed/simple;
	bh=BI3vHnQrL8eZBMmoQ4kVzllzrn0jROcl6BxkptM6u+E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UPORd0NXk6LCJsG7rNqwANrsHCNzKzDfnuygOAv3g8YjBIg9pyc8yqS/wqF5XFBXWz8aHsV96mG5T95oRUyFxlOHblJ/R3D+Sdi92NXWjvyiebt3LI7emcTKVmckvuJvhKcA7TffOqNsEO7lYpNl84f19EVpa+kfS1z3mEA1DwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0FAF1DA7;
	Mon, 26 Feb 2024 01:53:12 -0800 (PST)
Received: from [10.57.50.187] (unknown [10.57.50.187])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C15EB3F6C4;
	Mon, 26 Feb 2024 01:52:28 -0800 (PST)
Message-ID: <125fe2f0-bd21-462f-893a-fbf80813dfbf@arm.com>
Date: Mon, 26 Feb 2024 09:52:27 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/7] arm64: KVM: Add interface to set guest value for
 TRFCR register
To: James Clark <james.clark@arm.com>
Cc: James Morse <james.morse@arm.com>, Zenghui Yu <yuzenghui@huawei.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Mike Leach <mike.leach@linaro.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Miguel Luis <miguel.luis@oracle.com>, Joey Gouly <joey.gouly@arm.com>,
 Ard Biesheuvel <ardb@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Arnd Bergmann <arnd@arndb.de>, Helge Deller <deller@gmx.de>,
 Andrew Walbran <qwandor@google.com>,
 Vincent Donnefort <vdonnefort@google.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Fuad Tabba <tabba@google.com>,
 Jing Zhang <jingzhangos@google.com>, linux-kernel@vger.kernel.org,
 coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.linux.dev, maz@kernel.org, acme@kernel.org,
 oliver.upton@linux.dev, broonie@kernel.org
References: <20240220100924.2761706-1-james.clark@arm.com>
 <20240220100924.2761706-6-james.clark@arm.com>
 <c8819064-13c3-41c6-8b2e-779ef8a22ee8@arm.com>
 <9d3f9f70-0b34-7426-8b62-93dc173a0bb2@arm.com>
Content-Language: en-GB
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <9d3f9f70-0b34-7426-8b62-93dc173a0bb2@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 23/02/2024 16:39, James Clark wrote:
> 
> 
> On 23/02/2024 10:03, Suzuki K Poulose wrote:
>> On 20/02/2024 10:09, James Clark wrote:
>>> Add an interface for the Coresight driver to use to set the value of the
>>> TRFCR register for the guest. This register controls the exclude
>>> settings for trace at different exception levels, and is used to honor
>>> the exclude_host and exclude_guest parameters from the Perf session.
>>> This will be used to later write TRFCR_EL1 on nVHE at guest switch. For
>>> VHE, the host trace is controlled by TRFCR_EL2 and thus we can write to
>>> the TRFCR_EL1 immediately. Because guest writes to the register are
>>> trapped, the value will persist and can't be modified.
>>>
>>> Instead of adding a load of infrastructure to share the host's per-cpu
>>> offsets with the hypervisor, just define the new storage as a NR_CPUS
>>> array.
>>>
>>> Signed-off-by: James Clark <james.clark@arm.com>
>>> ---
>>>    arch/arm64/include/asm/kvm_host.h |  3 +++
>>>    arch/arm64/kernel/image-vars.h    |  1 +
>>>    arch/arm64/kvm/debug.c            | 26 ++++++++++++++++++++++++++
>>>    3 files changed, 30 insertions(+)
>>>
>>> diff --git a/arch/arm64/include/asm/kvm_host.h
>>> b/arch/arm64/include/asm/kvm_host.h
>>> index 85b5477bd1b4..56b7f7eca195 100644
>>> --- a/arch/arm64/include/asm/kvm_host.h
>>> +++ b/arch/arm64/include/asm/kvm_host.h
>>> @@ -509,6 +509,7 @@ struct kvm_host_psci_config {
>>>        bool psci_0_1_cpu_off_implemented;
>>>        bool psci_0_1_migrate_implemented;
>>>    };
>>> +extern u64 ____cacheline_aligned kvm_guest_trfcr[NR_CPUS];
>>>      extern struct kvm_host_psci_config
>>> kvm_nvhe_sym(kvm_host_psci_config);
>>>    #define kvm_host_psci_config CHOOSE_NVHE_SYM(kvm_host_psci_config)
>>> @@ -1174,6 +1175,7 @@ void kvm_arch_vcpu_put_debug_state_flags(struct
>>> kvm_vcpu *vcpu);
>>>    void kvm_set_pmu_events(u32 set, struct perf_event_attr *attr);
>>>    void kvm_clr_pmu_events(u32 clr);
>>>    bool kvm_set_pmuserenr(u64 val);
>>> +void kvm_etm_set_guest_trfcr(u64 trfcr_guest);
>>>    #else
>>>    static inline void kvm_set_pmu_events(u32 set, struct
>>> perf_event_attr *attr) {}
>>>    static inline void kvm_clr_pmu_events(u32 clr) {}
>>> @@ -1181,6 +1183,7 @@ static inline bool kvm_set_pmuserenr(u64 val)
>>>    {
>>>        return false;
>>>    }
>>> +static inline void kvm_etm_set_guest_trfcr(u64 trfcr_guest) {}
>>>    #endif
>>>      void kvm_vcpu_load_vhe(struct kvm_vcpu *vcpu);
>>> diff --git a/arch/arm64/kernel/image-vars.h
>>> b/arch/arm64/kernel/image-vars.h
>>> index 5e4dc72ab1bd..a451e4f10804 100644
>>> --- a/arch/arm64/kernel/image-vars.h
>>> +++ b/arch/arm64/kernel/image-vars.h
>>> @@ -59,6 +59,7 @@ KVM_NVHE_ALIAS(alt_cb_patch_nops);
>>>      /* Global kernel state accessed by nVHE hyp code. */
>>>    KVM_NVHE_ALIAS(kvm_vgic_global_state);
>>> +KVM_NVHE_ALIAS(kvm_guest_trfcr);
>>>      /* Kernel symbols used to call panic() from nVHE hyp code (via
>>> ERET). */
>>>    KVM_NVHE_ALIAS(nvhe_hyp_panic_handler);
>>> diff --git a/arch/arm64/kvm/debug.c b/arch/arm64/kvm/debug.c
>>> index 49a13e72ddd2..c8d936ce6e2b 100644
>>> --- a/arch/arm64/kvm/debug.c
>>> +++ b/arch/arm64/kvm/debug.c
>>> @@ -22,6 +22,7 @@
>>>                    DBG_MDSCR_MDE)
>>>      static DEFINE_PER_CPU(u64, mdcr_el2);
>>> +u64 ____cacheline_aligned kvm_guest_trfcr[NR_CPUS];
>>>      /*
>>>     * save/restore_guest_debug_regs
>>> @@ -359,3 +360,28 @@ void kvm_arch_vcpu_put_debug_state_flags(struct
>>> kvm_vcpu *vcpu)
>>>        vcpu_clear_flag(vcpu, DEBUG_STATE_SAVE_TRBE);
>>>        vcpu_clear_flag(vcpu, DEBUG_STATE_SAVE_TRFCR);
>>>    }
>>> +
>>> +/*
>>> + * Interface for the Coresight driver to use to set the value of the
>>> TRFCR
>>> + * register for the guest. This register controls the exclude
>>> settings for trace
>>> + * at different exception levels, and is used to honor the
>>> exclude_host and
>>> + * exclude_guest parameters from the Perf session.
>>> + *
>>> + * This will be used to later write TRFCR_EL1 on nVHE at guest
>>> switch. For VHE,
>>> + * the host trace is controlled by TRFCR_EL2 and thus we can write to
>>> the
>>> + * TRFCR_EL1 immediately. Because guest writes to the register are
>>> trapped, the
>>> + * value will persist and can't be modified. For pKVM,
>>> kvm_guest_trfcr can't
>>> + * be read by the hypervisor, so don't bother writing it.
>>> + */
>>> +void kvm_etm_set_guest_trfcr(u64 trfcr_guest)
>>> +{
>>> +    if
>>> (WARN_ON_ONCE(!cpuid_feature_extract_unsigned_field(read_sysreg(id_aa64dfr0_el1),
>>> +                                   ID_AA64DFR0_EL1_TraceFilt_SHIFT)))
>>> +        return;
>>> +
>>> +    if (has_vhe())
>>> +        write_sysreg_s(trfcr_guest, SYS_TRFCR_EL12);
>>> +    else if (!is_protected_kvm_enabled())
>>> +        kvm_guest_trfcr[smp_processor_id()] = trfcr_guest;
>>
>> smp_processor_id() could sleep in some configurations ? Should we switch
>> to raw_smp_processor_id() to be safer ?
>>
> 
> I don't think so, it's #defined to raw_smp_processor_id() anyway. Unless
> DEBUG_PREEMPT is on, then it's still raw_smp_processor_id() but it
> validates that preemption is disabled so the value isn't stale. >
> We actually want that validation, so should leave it as

This is actually what we want. i.e., We don't want the coresight drivers
to make this call from a non-premptible context. Relying on the 
DEBUG_PREEMPT for detecting such erroneous uses is not a good idea, 
production kernels may not do this and a comment doesn't go far.
So, I think we need a :

WARN_ON(preemptible()) in here and use smp_processor_id()

> smp_processor_id(). I can add a comment saying that this function should
> only be called with preemption disabled, but I wouldn't add any extra
> validation. Every smp_processor_id() call is already checked when
> DEBUG_PREEMPT is on and this one doesn't seem to be special in any way.
> 
> I also checked that the warning isn't triggered with DEBUG_PREEMPT on,
> and there are also a lot of other smp_processor_id() calls on similar
> paths in the Coresight driver.

Here, we are setting something for the KVM to program and if we set the
filters on the wrong Physical CPU, then we mess up the tracing.

Suzuki

> 
>> Otherwise looks good to me.
>>
>> Suzuki
>>
>>> +}
>>> +EXPORT_SYMBOL_GPL(kvm_etm_set_guest_trfcr);
>>


