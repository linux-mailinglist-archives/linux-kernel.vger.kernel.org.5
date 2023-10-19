Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFA467D001F
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 18:59:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345222AbjJSQ7J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 12:59:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235474AbjJSQ7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 12:59:08 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0A93612A
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 09:59:06 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9C4942F4;
        Thu, 19 Oct 2023 09:59:46 -0700 (PDT)
Received: from [10.57.67.150] (unknown [10.57.67.150])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DBEFB3F5A1;
        Thu, 19 Oct 2023 09:59:02 -0700 (PDT)
Message-ID: <ec50ef51-e0f7-90f5-2c4a-01754e3b70ad@arm.com>
Date:   Thu, 19 Oct 2023 17:59:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 5/6] arm64: KVM: Write TRFCR value on guest switch with
 nVHE
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
        Jintack Lim <jintack.lim@linaro.org>,
        Akihiko Odaki <akihiko.odaki@daynix.com>,
        Fuad Tabba <tabba@google.com>, Joey Gouly <joey.gouly@arm.com>,
        linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        broonie@kernel.org, maz@kernel.org
References: <20231005125757.649345-1-james.clark@arm.com>
 <20231005125757.649345-6-james.clark@arm.com>
 <3b41286f-d2b0-5fdf-88ef-1e63f302f9c8@arm.com>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <3b41286f-d2b0-5fdf-88ef-1e63f302f9c8@arm.com>
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



On 05/10/2023 19:05, Suzuki K Poulose wrote:
> On 05/10/2023 13:57, James Clark wrote:
>> The guest value for TRFCR requested by the Coresight driver is saved
>> in sysregs[TRFCR_EL1]. On guest switch this value needs to be written to
>> the register. Currently TRFCR is only modified when we want to disable
>> trace completely in guests due to an issue with TRBE. Expand the
>> __debug_save_trace() function to always write to the register if a
>> different value for guests is required, but also keep the existing TRBE
>> disable behavior if that's required.
>>
>> The TRFCR restore function remains functionally the same, except a value
>> of 0 doesn't mean "don't restore" anymore. Now that we save both guest
>> and host values the register is restored any time the guest and host
>> values differ.
>>
>> Signed-off-by: James Clark <james.clark@arm.com>
>> ---
>>   arch/arm64/include/asm/kvm_hyp.h   |  6 ++-
>>   arch/arm64/kvm/debug.c             | 13 +++++-
>>   arch/arm64/kvm/hyp/nvhe/debug-sr.c | 63 ++++++++++++++++++------------
>>   arch/arm64/kvm/hyp/nvhe/switch.c   |  4 +-
>>   4 files changed, 57 insertions(+), 29 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/kvm_hyp.h
>> b/arch/arm64/include/asm/kvm_hyp.h
>> index 37e238f526d7..0383fd3d60b5 100644
>> --- a/arch/arm64/include/asm/kvm_hyp.h
>> +++ b/arch/arm64/include/asm/kvm_hyp.h
>> @@ -103,8 +103,10 @@ void __debug_switch_to_guest(struct kvm_vcpu *vcpu);
>>   void __debug_switch_to_host(struct kvm_vcpu *vcpu);
>>     #ifdef __KVM_NVHE_HYPERVISOR__
>> -void __debug_save_host_buffers_nvhe(struct kvm_cpu_context *host_ctxt);
>> -void __debug_restore_host_buffers_nvhe(struct kvm_cpu_context
>> *host_ctxt);
>> +void __debug_save_host_buffers_nvhe(struct kvm_cpu_context *host_ctxt,
>> +                    struct kvm_cpu_context *guest_ctxt);
>> +void __debug_restore_host_buffers_nvhe(struct kvm_cpu_context
>> *host_ctxt,
>> +                       struct kvm_cpu_context *guest_ctxt);
>>   #endif
>>     void __fpsimd_save_state(struct user_fpsimd_state *fp_regs);
>> diff --git a/arch/arm64/kvm/debug.c b/arch/arm64/kvm/debug.c
>> index 19e722359154..d949dd354464 100644
>> --- a/arch/arm64/kvm/debug.c
>> +++ b/arch/arm64/kvm/debug.c
>> @@ -337,10 +337,21 @@ void kvm_arch_vcpu_load_debug_state_flags(struct
>> kvm_vcpu *vcpu)
>>           !(read_sysreg_s(SYS_PMBIDR_EL1) & BIT(PMBIDR_EL1_P_SHIFT)))
>>           vcpu_set_flag(vcpu, DEBUG_STATE_SAVE_SPE);
>>   -    /* Check if we have TRBE implemented and available at the host */
>> +    /*
>> +     * Check if we have TRBE implemented and available at the host.
>> If it's
>> +     * in use at the time of guest switch it will need to be disabled
>> and
>> +     * then restored.
>> +     */
>>       if (cpuid_feature_extract_unsigned_field(dfr0,
>> ID_AA64DFR0_EL1_TraceBuffer_SHIFT) &&
>>           !(read_sysreg_s(SYS_TRBIDR_EL1) & TRBIDR_EL1_P))
>>           vcpu_set_flag(vcpu, DEBUG_STATE_SAVE_TRFCR);
> 
> As per A3.1 Armv9-A architecture extensions (DDI 0487J.a), FEAT_TRBE
> mandates FEAT_TRF. So, we could check FEAT_TRF and if we have a hit,
> skip the TRBE checks. But, having read the code below, it looks like
> we need separate flags for TRFCR and TRBE.
>     
>> +    /*
>> +     * Also save TRFCR on nVHE if FEAT_TRF (TraceFilt) exists. This
>> will be
>> +     * done in cases where use of TRBE doesn't completely disable
>> trace and
>> +     * handles the exclude_host/exclude_guest rules of the trace
>> session.
>> +     */
>> +    if (cpuid_feature_extract_unsigned_field(dfr0,
>> ID_AA64DFR0_EL1_TraceFilt_SHIFT))
>> +        vcpu_set_flag(vcpu, DEBUG_STATE_SAVE_TRFCR);
>     
>>   }
>>     void kvm_arch_vcpu_put_debug_state_flags(struct kvm_vcpu *vcpu)
>> diff --git a/arch/arm64/kvm/hyp/nvhe/debug-sr.c
>> b/arch/arm64/kvm/hyp/nvhe/debug-sr.c
>> index 128a57dddabf..c6252029c277 100644
>> --- a/arch/arm64/kvm/hyp/nvhe/debug-sr.c
>> +++ b/arch/arm64/kvm/hyp/nvhe/debug-sr.c
>> @@ -51,42 +51,56 @@ static void __debug_restore_spe(struct
>> kvm_cpu_context *host_ctxt)
>>       write_sysreg_s(ctxt_sys_reg(host_ctxt, PMSCR_EL1), SYS_PMSCR_EL1);
>>   }
>>   -static void __debug_save_trace(struct kvm_cpu_context *host_ctxt)
>> +/*
>> + * Save TRFCR and disable trace completely if TRBE is being used,
>> otherwise
>> + * apply required guest TRFCR value.
>> + */
>> +static void __debug_save_trace(struct kvm_cpu_context *host_ctxt,
>> +                   struct kvm_cpu_context *guest_ctxt)
>>   {
>> -    ctxt_sys_reg(host_ctxt, TRFCR_EL1) = 0;
>> +    ctxt_sys_reg(host_ctxt, TRFCR_EL1) = read_sysreg_s(SYS_TRFCR_EL1);
>>         /* Check if the TRBE is enabled */
>> -    if (!(read_sysreg_s(SYS_TRBLIMITR_EL1) & TRBLIMITR_EL1_E))
>> -        return;
>> -    /*
>> -     * Prohibit trace generation while we are in guest.
>> -     * Since access to TRFCR_EL1 is trapped, the guest can't
>> -     * modify the filtering set by the host.
>> -     */
>> -    ctxt_sys_reg(host_ctxt, TRFCR_EL1) = read_sysreg_s(SYS_TRFCR_EL1);
>> -    write_sysreg_s(0, SYS_TRFCR_EL1);
>> -    isb();
>> -    /* Drain the trace buffer to memory */
>> -    tsb_csync();
>> +    if (read_sysreg_s(SYS_TRBLIMITR_EL1) & TRBLIMITR_EL1_E) {
> 
> This is problematic. At this point, we are not sure if TRBE is available
> or not (e.g. we could be on a v8.4 CPU or a v9.0 with TRBE disabled by
> higher EL). May be we need to add a separate flag to indicate the
> presence of TRBE.
> 
> Suzuki
> 

Fixed in V3

>> +        /*
>> +         * Prohibit trace generation while we are in guest. Since access
>> +         * to TRFCR_EL1 is trapped, the guest can't modify the filtering
>> +         * set by the host.
>> +         */
>> +        ctxt_sys_reg(guest_ctxt, TRFCR_EL1) = 0;
>> +        write_sysreg_s(0, SYS_TRFCR_EL1);
>> +        isb();
>> +        /* Drain the trace buffer to memory */
>> +        tsb_csync();
>> +    } else {
>> +        /*
>> +         * Not using TRBE, so guest trace works. Apply the guest filters
>> +         * provided by the Coresight driver, if different.
>> +         */
>> +        if (ctxt_sys_reg(host_ctxt, TRFCR_EL1) !=
>> +            ctxt_sys_reg(guest_ctxt, TRFCR_EL1))
>> +            write_sysreg_s(ctxt_sys_reg(guest_ctxt, TRFCR_EL1),
>> +                       SYS_TRFCR_EL1);
>> +    }
>>   }
>>   -static void __debug_restore_trace(struct kvm_cpu_context *host_ctxt)
>> +static void __debug_restore_trace(struct kvm_cpu_context *host_ctxt,
>> +                  struct kvm_cpu_context *guest_ctxt)
>>   {
>> -    if (!ctxt_sys_reg(host_ctxt, TRFCR_EL1))
>> -        return;
>> -
>>       /* Restore trace filter controls */
>> -    write_sysreg_s(ctxt_sys_reg(host_ctxt, TRFCR_EL1), SYS_TRFCR_EL1);
>> +    if (ctxt_sys_reg(host_ctxt, TRFCR_EL1) !=
>> ctxt_sys_reg(guest_ctxt, TRFCR_EL1))
>> +        write_sysreg_s(ctxt_sys_reg(host_ctxt, TRFCR_EL1),
>> SYS_TRFCR_EL1);
>>   }
>>   -void __debug_save_host_buffers_nvhe(struct kvm_cpu_context *host_ctxt)
>> +void __debug_save_host_buffers_nvhe(struct kvm_cpu_context *host_ctxt,
>> +                    struct kvm_cpu_context *guest_ctxt)
>>   {
>>       /* Disable and flush SPE data generation */
>>       if (vcpu_get_flag(host_ctxt->__hyp_running_vcpu,
>> DEBUG_STATE_SAVE_SPE))
>>           __debug_save_spe(host_ctxt);
>> -    /* Disable and flush Self-Hosted Trace generation */
>> +
>>       if (vcpu_get_flag(host_ctxt->__hyp_running_vcpu,
>> DEBUG_STATE_SAVE_TRFCR))
>> -        __debug_save_trace(host_ctxt);
>> +        __debug_save_trace(host_ctxt, guest_ctxt);
>>   }
>>     void __debug_switch_to_guest(struct kvm_vcpu *vcpu)
>> @@ -94,12 +108,13 @@ void __debug_switch_to_guest(struct kvm_vcpu *vcpu)
>>       __debug_switch_to_guest_common(vcpu);
>>   }
>>   -void __debug_restore_host_buffers_nvhe(struct kvm_cpu_context
>> *host_ctxt)
>> +void __debug_restore_host_buffers_nvhe(struct kvm_cpu_context
>> *host_ctxt,
>> +                       struct kvm_cpu_context *guest_ctxt)
>>   {
>>       if (vcpu_get_flag(host_ctxt->__hyp_running_vcpu,
>> DEBUG_STATE_SAVE_SPE))
>>           __debug_restore_spe(host_ctxt);
>>       if (vcpu_get_flag(host_ctxt->__hyp_running_vcpu,
>> DEBUG_STATE_SAVE_TRFCR))
>> -        __debug_restore_trace(host_ctxt);
>> +        __debug_restore_trace(host_ctxt, guest_ctxt);
>>   }
>>     void __debug_switch_to_host(struct kvm_vcpu *vcpu)
>> diff --git a/arch/arm64/kvm/hyp/nvhe/switch.c
>> b/arch/arm64/kvm/hyp/nvhe/switch.c
>> index c8f15e4dab19..55207ec31bd3 100644
>> --- a/arch/arm64/kvm/hyp/nvhe/switch.c
>> +++ b/arch/arm64/kvm/hyp/nvhe/switch.c
>> @@ -276,7 +276,7 @@ int __kvm_vcpu_run(struct kvm_vcpu *vcpu)
>>        * translation regime to EL2 (via MDCR_EL2_E2PB == 0) and
>>        * before we load guest Stage1.
>>        */
>> -    __debug_save_host_buffers_nvhe(host_ctxt);
>> +    __debug_save_host_buffers_nvhe(host_ctxt, guest_ctxt);
>>         /*
>>        * We're about to restore some new MMU state. Make sure
>> @@ -343,7 +343,7 @@ int __kvm_vcpu_run(struct kvm_vcpu *vcpu)
>>        * This must come after restoring the host sysregs, since a non-VHE
>>        * system may enable SPE here and make use of the TTBRs.
>>        */
>> -    __debug_restore_host_buffers_nvhe(host_ctxt);
>> +    __debug_restore_host_buffers_nvhe(host_ctxt, guest_ctxt);
>>         if (pmu_switch_needed)
>>           __pmu_switch_to_host(vcpu);
> 
