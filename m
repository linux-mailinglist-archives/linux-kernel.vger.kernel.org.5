Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF40B776244
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 16:21:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231752AbjHIOVK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 10:21:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233277AbjHIOVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 10:21:07 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 83565212E
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 07:21:02 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8D5DFD75;
        Wed,  9 Aug 2023 07:21:44 -0700 (PDT)
Received: from [10.57.1.30] (unknown [10.57.1.30])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E15FB3F59C;
        Wed,  9 Aug 2023 07:20:59 -0700 (PDT)
Message-ID: <f80b7a56-8d7d-f960-307b-98fa89f97695@arm.com>
Date:   Wed, 9 Aug 2023 15:20:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [RFC PATCH 2/3] arm64: KVM: Support exclude_guest for Coresight
 trace in nVHE
Content-Language: en-US
To:     Marc Zyngier <maz@kernel.org>
Cc:     coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.linux.dev, Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org
References: <20230804101317.460697-1-james.clark@arm.com>
 <20230804101317.460697-3-james.clark@arm.com> <871qgdre18.wl-maz@kernel.org>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <871qgdre18.wl-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/08/2023 12:04, Marc Zyngier wrote:
> On Fri, 04 Aug 2023 11:13:12 +0100,
> James Clark <james.clark@arm.com> wrote:
>>
>> Currently trace will always be generated in nVHE as long as TRBE isn't
>> being used. To allow filtering out guest trace, re-apply the filter
>> rules before switching to the guest.
>>
>> The TRFCR restore function remains the same.
>>
>> Signed-off-by: James Clark <james.clark@arm.com>
>> ---
>>  arch/arm64/kvm/debug.c             |  7 ++++
>>  arch/arm64/kvm/hyp/nvhe/debug-sr.c | 56 +++++++++++++++++++++++++++---
>>  2 files changed, 59 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/arm64/kvm/debug.c b/arch/arm64/kvm/debug.c
>> index 8725291cb00a..ebb4db20a859 100644
>> --- a/arch/arm64/kvm/debug.c
>> +++ b/arch/arm64/kvm/debug.c
>> @@ -335,10 +335,17 @@ void kvm_arch_vcpu_load_debug_state_flags(struct kvm_vcpu *vcpu)
>>  	if (cpuid_feature_extract_unsigned_field(dfr0, ID_AA64DFR0_EL1_TraceBuffer_SHIFT) &&
>>  	    !(read_sysreg_s(SYS_TRBIDR_EL1) & TRBIDR_EL1_P))
>>  		vcpu_set_flag(vcpu, DEBUG_STATE_SAVE_TRBE);
>> +	/*
>> +	 * Save TRFCR on nVHE if FEAT_TRF exists. This will be done in cases
>> +	 * where DEBUG_STATE_SAVE_TRBE doesn't completely disable trace.
>> +	 */
>> +	if (cpuid_feature_extract_unsigned_field(dfr0, ID_AA64DFR0_EL1_TraceFilt_SHIFT))
>> +		vcpu_set_flag(vcpu, DEBUG_STATE_SAVE_TRFCR);
>>  }
>>  
>>  void kvm_arch_vcpu_put_debug_state_flags(struct kvm_vcpu *vcpu)
>>  {
>>  	vcpu_clear_flag(vcpu, DEBUG_STATE_SAVE_SPE);
>>  	vcpu_clear_flag(vcpu, DEBUG_STATE_SAVE_TRBE);
>> +	vcpu_clear_flag(vcpu, DEBUG_STATE_SAVE_TRFCR);
>>  }
>> diff --git a/arch/arm64/kvm/hyp/nvhe/debug-sr.c b/arch/arm64/kvm/hyp/nvhe/debug-sr.c
>> index 4558c02eb352..0e8c85b29b92 100644
>> --- a/arch/arm64/kvm/hyp/nvhe/debug-sr.c
>> +++ b/arch/arm64/kvm/hyp/nvhe/debug-sr.c
>> @@ -51,13 +51,17 @@ static void __debug_restore_spe(u64 pmscr_el1)
>>  	write_sysreg_s(pmscr_el1, SYS_PMSCR_EL1);
>>  }
>>  
>> -static void __debug_save_trace(u64 *trfcr_el1)
>> +/*
>> + * Save TRFCR and disable trace completely if TRBE is being used. Return true
>> + * if trace was disabled.
>> + */
>> +static bool __debug_save_trace(u64 *trfcr_el1)
>>  {
>>  	*trfcr_el1 = 0;
>>  
>>  	/* Check if the TRBE is enabled */
>>  	if (!(read_sysreg_s(SYS_TRBLIMITR_EL1) & TRBLIMITR_EL1_E))
>> -		return;
>> +		return false;
> 
> While you're refactoring this code, please move the zeroing of
> *trfcr_el1 under the if statement.
> 
>>  	/*
>>  	 * Prohibit trace generation while we are in guest.
>>  	 * Since access to TRFCR_EL1 is trapped, the guest can't
>> @@ -68,6 +72,8 @@ static void __debug_save_trace(u64 *trfcr_el1)
>>  	isb();
>>  	/* Drain the trace buffer to memory */
>>  	tsb_csync();
>> +
>> +	return true;
>>  }
>>  
>>  static void __debug_restore_trace(u64 trfcr_el1)
>> @@ -79,14 +85,55 @@ static void __debug_restore_trace(u64 trfcr_el1)
>>  	write_sysreg_s(trfcr_el1, SYS_TRFCR_EL1);
>>  }
>>  
>> +#if IS_ENABLED(CONFIG_PERF_EVENTS)
> 
> As previously stated, just always compile this. There shouldn't be
> anything here that's so large that it becomes a candidate for
> exclusion. Hell, even the whole of NV+pKVM are permanent features,
> even of most people won't use *any* of that.
> 
>> +static inline void __debug_save_trfcr(struct kvm_vcpu *vcpu)
>> +{
>> +	u64 trfcr;
>> +	struct kvm_etm_event etm_event = vcpu->arch.host_debug_state.etm_event;
>> +
>> +	/* No change if neither are excluded */
>> +	if (!etm_event.exclude_guest && !etm_event.exclude_host) {
>> +		/* Zeroing prevents restoring a stale value */
>> +		vcpu->arch.host_debug_state.trfcr_el1 = 0;
> 
> I find this "zero means do nothing" part very odd. I can see it is
> already done, but I really dislike this sort of assumption to avoid
> writing to a register.
> 
> I'd really prefer we track another version of TRFCR_EL1, compare host
> and guest, and decide to avoid writing if they are equal. At least, it
> would be readable.
> 
> And in the end, expressing *everything* in terms of the register would
> really help, instead of the exclude_* stuff that has no place in the
> low-level arch code.
> 

Yep, I agree with all of the above, I can make these changes for the
next version. I just want to clarify your point about disabling trace
for protected guests when not in debug mode that I asked about in the
review on patch 1.

> Thanks,
> 
> 	M.
> 
