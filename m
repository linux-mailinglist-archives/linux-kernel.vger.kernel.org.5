Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB63D7D001C
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 18:58:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235493AbjJSQ63 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 12:58:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235556AbjJSQ6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 12:58:21 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5B764D63
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 09:58:16 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 03BD42F4;
        Thu, 19 Oct 2023 09:58:57 -0700 (PDT)
Received: from [10.57.67.150] (unknown [10.57.67.150])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6BA973F5A1;
        Thu, 19 Oct 2023 09:58:13 -0700 (PDT)
Message-ID: <ac2e17c6-4a8d-24bb-a41d-c57ab60e8415@arm.com>
Date:   Thu, 19 Oct 2023 17:58:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 4/6] arm64: KVM: Add interface to set guest value for
 TRFCR register
Content-Language: en-US
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Rob Herring <robh@kernel.org>,
        Akihiko Odaki <akihiko.odaki@daynix.com>,
        Fuad Tabba <tabba@google.com>, Joey Gouly <joey.gouly@arm.com>,
        linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        broonie@kernel.org, maz@kernel.org
References: <20231005125757.649345-1-james.clark@arm.com>
 <20231005125757.649345-5-james.clark@arm.com>
 <de8083f5-eb62-77d2-236b-6ad46ceb6142@arm.com>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <de8083f5-eb62-77d2-236b-6ad46ceb6142@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/10/2023 17:58, Suzuki K Poulose wrote:
> On 05/10/2023 13:57, James Clark wrote:
>> Add an interface for the Coresight driver to use to set the value of the
>> TRFCR register for the guest. This register controls the exclude
> 
> 
> 
>> settings for trace at different exception levels, and is used to
>> honor the exclude_host and exclude_guest parameters from the Perf
>> session. This will be used to later write TRFCR_EL1 on nVHE at guest
>> switch. For VHE, TRFCR_EL1 is written immediately. Because guest writes
> 
> minor nit: May be it would be clearer to say:
> 
> For VHE, the host trace is controlled by TRFCR_EL2 and thus we can
> write to the TRFCR_EL1 immediately. Because, ...
> 
>> to the register are trapped, the value will persist and can't be
>> modified.
>>
>> The settings must be copied to the vCPU before each run in the same
>> way that PMU events are because the per-cpu struct isn't accessible in
> 
> super minor nit:
> 
> way that PMU events are, because ...
> >> protected mode.
>>
>> Now that both guest and host values are saved, rename trfcr_el1 to
>> host_trfcr_el1 to make it clear that's the value that should be restored
> 
> This seems obsolete ? I couldn't find any reference to host_trfcr_el1
> anywhere ?
> 

Yep it was from an old version. I remove it and fixed all of the above too.

> Otherwise looks good to me.
> 
> Suzuki
> 


> 
>> on return to the host.
>>
>> Signed-off-by: James Clark <james.clark@arm.com>
>> ---
>>   arch/arm64/include/asm/kvm_host.h |  3 +++
>>   arch/arm64/kvm/arm.c              |  1 +
>>   arch/arm64/kvm/debug.c            | 26 ++++++++++++++++++++++++++
>>   3 files changed, 30 insertions(+)
>>
>> diff --git a/arch/arm64/include/asm/kvm_host.h
>> b/arch/arm64/include/asm/kvm_host.h
>> index b5200f199692..8f2b4ec8ea61 100644
>> --- a/arch/arm64/include/asm/kvm_host.h
>> +++ b/arch/arm64/include/asm/kvm_host.h
>> @@ -1123,6 +1123,8 @@ void kvm_arch_vcpu_put_debug_state_flags(struct
>> kvm_vcpu *vcpu);
>>   void kvm_set_pmu_events(u32 set, struct perf_event_attr *attr);
>>   void kvm_clr_pmu_events(u32 clr);
>>   bool kvm_set_pmuserenr(u64 val);
>> +void kvm_etm_set_guest_trfcr(u64 trfcr_guest);
>> +void kvm_etm_update_vcpu_events(struct kvm_vcpu *vcpu);
>>   #else
>>   static inline void kvm_set_pmu_events(u32 set, struct
>> perf_event_attr *attr) {}
>>   static inline void kvm_clr_pmu_events(u32 clr) {}
>> @@ -1130,6 +1132,7 @@ static inline bool kvm_set_pmuserenr(u64 val)
>>   {
>>       return false;
>>   }
>> +static inline void kvm_etm_set_guest_trfcr(u64 trfcr_guest) {}
>>   #endif
>>     void kvm_vcpu_load_sysregs_vhe(struct kvm_vcpu *vcpu);
>> diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
>> index 78b0970eb8e6..22fab356b88f 100644
>> --- a/arch/arm64/kvm/arm.c
>> +++ b/arch/arm64/kvm/arm.c
>> @@ -1012,6 +1012,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
>>           kvm_vgic_flush_hwstate(vcpu);
>>             kvm_pmu_update_vcpu_events(vcpu);
>> +        kvm_etm_update_vcpu_events(vcpu);
>>             /*
>>            * Ensure we set mode to IN_GUEST_MODE after we disable
>> diff --git a/arch/arm64/kvm/debug.c b/arch/arm64/kvm/debug.c
>> index 6a1bad1a921b..19e722359154 100644
>> --- a/arch/arm64/kvm/debug.c
>> +++ b/arch/arm64/kvm/debug.c
>> @@ -23,6 +23,12 @@
>>     static DEFINE_PER_CPU(u64, mdcr_el2);
>>   +/*
>> + * Per CPU value for TRFCR that should be applied to any guest vcpu
>> that may
>> + * run on that core in the future.
>> + */
>> +static DEFINE_PER_CPU(u64, guest_trfcr);
>> +
>>   /**
>>    * save/restore_guest_debug_regs
>>    *
>> @@ -342,3 +348,23 @@ void kvm_arch_vcpu_put_debug_state_flags(struct
>> kvm_vcpu *vcpu)
>>       vcpu_clear_flag(vcpu, DEBUG_STATE_SAVE_SPE);
>>       vcpu_clear_flag(vcpu, DEBUG_STATE_SAVE_TRFCR);
>>   }
>> +
>> +void kvm_etm_set_guest_trfcr(u64 trfcr_guest)
>> +{
>> +    if (has_vhe())
>> +        write_sysreg_s(trfcr_guest, SYS_TRFCR_EL12);
>> +    else
>> +        *this_cpu_ptr(&guest_trfcr) = trfcr_guest;
>> +}
>> +EXPORT_SYMBOL_GPL(kvm_etm_set_guest_trfcr);
>> +
>> +/*
>> + * Updates the vcpu's view of the etm events for this cpu. Must be
>> + * called before every vcpu run after disabling interrupts, to ensure
>> + * that an interrupt cannot fire and update the structure.
>> + */
>> +void kvm_etm_update_vcpu_events(struct kvm_vcpu *vcpu)
>> +{
>> +    if (!has_vhe() && vcpu_get_flag(vcpu, DEBUG_STATE_SAVE_TRFCR))
>> +        ctxt_sys_reg(&vcpu->arch.ctxt, TRFCR_EL1) =
>> *this_cpu_ptr(&guest_trfcr);
>> +}
> 
