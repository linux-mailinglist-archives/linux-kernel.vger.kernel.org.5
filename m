Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F826804ECD
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 10:55:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234995AbjLEJy7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 04:54:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231929AbjLEJy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 04:54:57 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9A515196
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 01:55:01 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E4077FEC;
        Tue,  5 Dec 2023 01:55:47 -0800 (PST)
Received: from [192.168.1.3] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BD9BA3F5A1;
        Tue,  5 Dec 2023 01:54:58 -0800 (PST)
Message-ID: <ce9caa4a-273f-4272-9c58-81b3e4d535de@arm.com>
Date:   Tue, 5 Dec 2023 09:54:58 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3 4/6] arm64: KVM: Add interface to set guest value for
 TRFCR register
Content-Language: en-US
To:     Marc Zyngier <maz@kernel.org>
Cc:     coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.linux.dev, suzuki.poulose@arm.com, broonie@kernel.org,
        Oliver Upton <oliver.upton@linux.dev>,
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
 <20231019165510.1966367-5-james.clark@arm.com> <86msuqb84g.wl-maz@kernel.org>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <86msuqb84g.wl-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/12/2023 09:59, Marc Zyngier wrote:
> On Thu, 19 Oct 2023 17:55:02 +0100,
> James Clark <james.clark@arm.com> wrote:
>>
>> Add an interface for the Coresight driver to use to set the value of the
>> TRFCR register for the guest. This register controls the exclude
>> settings for trace at different exception levels, and is used to honor
>> the exclude_host and exclude_guest parameters from the Perf session.
>> This will be used to later write TRFCR_EL1 on nVHE at guest switch. For
>> VHE, the host trace is controlled by TRFCR_EL2 and thus we can write to
>> the TRFCR_EL1 immediately. Because guest writes to the register are
>> trapped, the value will persist and can't be modified.
>>
>> The settings must be copied to the vCPU before each run in the same
>> way that PMU events are, because the per-cpu struct isn't accessible in
>> protected mode.
> 
> Then maybe we should look at a better way of sharing global data
> between EL1 and EL2 instead of copying stuff ad-nauseam?
> 

That probably makes sense, I can have a look into that.

>>
>> Signed-off-by: James Clark <james.clark@arm.com>
>> ---
>>  arch/arm64/include/asm/kvm_host.h |  3 +++
>>  arch/arm64/kvm/arm.c              |  1 +
>>  arch/arm64/kvm/debug.c            | 26 ++++++++++++++++++++++++++
>>  3 files changed, 30 insertions(+)
>>
>> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
>> index 0f0bf8e641bd..e1852102550d 100644
>> --- a/arch/arm64/include/asm/kvm_host.h
>> +++ b/arch/arm64/include/asm/kvm_host.h
>> @@ -1125,6 +1125,8 @@ void kvm_arch_vcpu_put_debug_state_flags(struct kvm_vcpu *vcpu);
>>  void kvm_set_pmu_events(u32 set, struct perf_event_attr *attr);
>>  void kvm_clr_pmu_events(u32 clr);
>>  bool kvm_set_pmuserenr(u64 val);
>> +void kvm_etm_set_guest_trfcr(u64 trfcr_guest);
>> +void kvm_etm_update_vcpu_events(struct kvm_vcpu *vcpu);
>>  #else
>>  static inline void kvm_set_pmu_events(u32 set, struct perf_event_attr *attr) {}
>>  static inline void kvm_clr_pmu_events(u32 clr) {}
>> @@ -1132,6 +1134,7 @@ static inline bool kvm_set_pmuserenr(u64 val)
>>  {
>>  	return false;
>>  }
>> +static inline void kvm_etm_set_guest_trfcr(u64 trfcr_guest) {}
>>  #endif
>>  
>>  void kvm_vcpu_load_sysregs_vhe(struct kvm_vcpu *vcpu);
>> diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
>> index 0f717b6a9151..e4d846f2f665 100644
>> --- a/arch/arm64/kvm/arm.c
>> +++ b/arch/arm64/kvm/arm.c
>> @@ -1015,6 +1015,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
>>  		kvm_vgic_flush_hwstate(vcpu);
>>  
>>  		kvm_pmu_update_vcpu_events(vcpu);
>> +		kvm_etm_update_vcpu_events(vcpu);
>>  
>>  		/*
>>  		 * Ensure we set mode to IN_GUEST_MODE after we disable
>> diff --git a/arch/arm64/kvm/debug.c b/arch/arm64/kvm/debug.c
>> index 20cdd40b3c42..2ab41b954512 100644
>> --- a/arch/arm64/kvm/debug.c
>> +++ b/arch/arm64/kvm/debug.c
>> @@ -23,6 +23,12 @@
>>  
>>  static DEFINE_PER_CPU(u64, mdcr_el2);
>>  
>> +/*
>> + * Per CPU value for TRFCR that should be applied to any guest vcpu that may
>> + * run on that core in the future.
>> + */
>> +static DEFINE_PER_CPU(u64, guest_trfcr);
>> +
>>  /**
>>   * save/restore_guest_debug_regs
>>   *
>> @@ -356,3 +362,23 @@ void kvm_arch_vcpu_put_debug_state_flags(struct kvm_vcpu *vcpu)
>>  	vcpu_clear_flag(vcpu, DEBUG_STATE_SAVE_TRBE);
>>  	vcpu_clear_flag(vcpu, DEBUG_STATE_SAVE_TRFCR);
>>  }
>> +
>> +void kvm_etm_set_guest_trfcr(u64 trfcr_guest)
>> +{
>> +	if (has_vhe())
>> +		write_sysreg_s(trfcr_guest, SYS_TRFCR_EL12);
>> +	else
>> +		*this_cpu_ptr(&guest_trfcr) = trfcr_guest;
>> +}
>> +EXPORT_SYMBOL_GPL(kvm_etm_set_guest_trfcr);
> 
> How does the ETM code know what guests it impacts? Don't you have some
> per-process context already?
> 

It doesn't know what guests it impacts, it just does it blindly based on
host CPU and whatever guest might run on the CPU in the future. PMU
events are the same.

We do have per-process context for per-process sessions, so if that was
the VM process we might have been able to do something with that info.
But we also have per-cpu sessions that would trace anything that runs on
that CPU, so to be able to support that mode I think it has to be done
without knowing about any guest.

>> +
>> +/*
>> + * Updates the vcpu's view of the etm events for this cpu. Must be
>> + * called before every vcpu run after disabling interrupts, to ensure
>> + * that an interrupt cannot fire and update the structure.
>> + */
>> +void kvm_etm_update_vcpu_events(struct kvm_vcpu *vcpu)
>> +{
>> +	if (!has_vhe() && vcpu_get_flag(vcpu, DEBUG_STATE_SAVE_TRFCR))
>> +		ctxt_sys_reg(&vcpu->arch.ctxt, TRFCR_EL1) = *this_cpu_ptr(&guest_trfcr);
>> +}
> 
> Why this requirement of updating it at all times? Why can't this be
> done in a more lazy way, using the flags to instruct the hypervisor
> what and when to load it?
> 
> 	M.
> 

I could probably add a flag that gets set if the guest value should be
different to the host value. I was just trying to keep it simple and in
terms of just what the registers should be.

The PMU one has something similar where it doesn't write anything if
kvm_pmu_switch_needed() is false, but that's only on the path where the
host sets the events, it still always does the copy in
kvm_pmu_update_vcpu_events() before the guest switch.

I suppose if I make the change to have the shared global data then the
copy isn't needed and this function and kvm_pmu_update_vcpu_events()
will just get deleted.

Thanks
James
