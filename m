Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51B677F60E5
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 14:55:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345650AbjKWNzA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 08:55:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345628AbjKWNy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 08:54:59 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F1C481A5;
        Thu, 23 Nov 2023 05:55:04 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 273271063;
        Thu, 23 Nov 2023 05:55:51 -0800 (PST)
Received: from [10.57.3.62] (unknown [10.57.3.62])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 547B23F6C4;
        Thu, 23 Nov 2023 05:54:57 -0800 (PST)
Message-ID: <1a94cccd-d871-1824-9fad-a8f7b99bb02a@arm.com>
Date:   Thu, 23 Nov 2023 13:54:55 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [V14 5/8] KVM: arm64: nvhe: Disable branch generation in nVHE
 guests
Content-Language: en-US
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Suzuki Poulose <suzuki.poulose@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-perf-users@vger.kernel.org,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>, kvmarm@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        will@kernel.org, catalin.marinas@arm.com, mark.rutland@arm.com
References: <20231114051329.327572-1-anshuman.khandual@arm.com>
 <20231114051329.327572-6-anshuman.khandual@arm.com>
 <f2661879-636c-1865-0e1c-60d8e11f80f0@arm.com>
 <20858eb9-a4d0-41be-ad1d-2a5f2d2fa0de@arm.com>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <20858eb9-a4d0-41be-ad1d-2a5f2d2fa0de@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 21/11/2023 11:12, Anshuman Khandual wrote:
> 
> 
> On 11/14/23 14:46, James Clark wrote:
>>
>>
>> On 14/11/2023 05:13, Anshuman Khandual wrote:
>>> Disable the BRBE before we enter the guest, saving the status and enable it
>>> back once we get out of the guest. This is just to avoid capturing records
>>> in the guest kernel/userspace, which would be confusing the samples.
>>>
>>> Cc: Marc Zyngier <maz@kernel.org>
>>> Cc: Oliver Upton <oliver.upton@linux.dev>
>>> Cc: James Morse <james.morse@arm.com>
>>> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
>>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>>> Cc: Will Deacon <will@kernel.org>
>>> Cc: kvmarm@lists.linux.dev
>>> Cc: linux-arm-kernel@lists.infradead.org
>>> CC: linux-kernel@vger.kernel.org
>>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>>> ---
>>> Changes in V14:
>>>
>>> - This is a new patch in the series
>>>
>>>  arch/arm64/include/asm/kvm_host.h  |  4 ++++
>>>  arch/arm64/kvm/debug.c             |  6 +++++
>>>  arch/arm64/kvm/hyp/nvhe/debug-sr.c | 38 ++++++++++++++++++++++++++++++
>>>  3 files changed, 48 insertions(+)
>>>
>>> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
>>> index 68421c74283a..1faa0430d8dd 100644
>>> --- a/arch/arm64/include/asm/kvm_host.h
>>> +++ b/arch/arm64/include/asm/kvm_host.h
>>> @@ -449,6 +449,8 @@ enum vcpu_sysreg {
>>>  	CNTHV_CVAL_EL2,
>>>  	PMSCR_EL1,	/* Statistical profiling extension */
>>>  	TRFCR_EL1,	/* Self-hosted trace filters */
>>> +	BRBCR_EL1,	/* Branch Record Buffer Control Register */
>>> +	BRBFCR_EL1,	/* Branch Record Buffer Function Control Register */
>>>  
>>>  	NR_SYS_REGS	/* Nothing after this line! */
>>>  };
>>> @@ -753,6 +755,8 @@ struct kvm_vcpu_arch {
>>>  #define VCPU_HYP_CONTEXT	__vcpu_single_flag(iflags, BIT(7))
>>>  /* Save trace filter controls */
>>>  #define DEBUG_STATE_SAVE_TRFCR	__vcpu_single_flag(iflags, BIT(8))
>>> +/* Save BRBE context if active  */
>>> +#define DEBUG_STATE_SAVE_BRBE	__vcpu_single_flag(iflags, BIT(9))
>>>  
>>>  /* SVE enabled for host EL0 */
>>>  #define HOST_SVE_ENABLED	__vcpu_single_flag(sflags, BIT(0))
>>> diff --git a/arch/arm64/kvm/debug.c b/arch/arm64/kvm/debug.c
>>> index 2ab41b954512..4055783c3d34 100644
>>> --- a/arch/arm64/kvm/debug.c
>>> +++ b/arch/arm64/kvm/debug.c
>>> @@ -354,6 +354,11 @@ void kvm_arch_vcpu_load_debug_state_flags(struct kvm_vcpu *vcpu)
>>>  		    !(read_sysreg_s(SYS_TRBIDR_EL1) & TRBIDR_EL1_P))
>>>  			vcpu_set_flag(vcpu, DEBUG_STATE_SAVE_TRBE);
>>>  	}
>>> +
>>> +	/* Check if we have BRBE implemented and available at the host */
>>> +	if (cpuid_feature_extract_unsigned_field(dfr0, ID_AA64DFR0_EL1_BRBE_SHIFT) &&
>>> +	    (read_sysreg_s(SYS_BRBCR_EL1) & (BRBCR_ELx_E0BRE | BRBCR_ELx_ExBRE)))
>>> +		vcpu_set_flag(vcpu, DEBUG_STATE_SAVE_BRBE);
>>
>> Isn't this supposed to just be the feature check? Whether BRBE is
>> enabled or not is checked later in __debug_save_brbe() anyway.
> 
> Okay, will make it just a feature check via ID_AA64DFR0_EL1_BRBE_SHIFT.
> 
>>
>> It seems like it's possible to become enabled after this flag load part.
> 
> Agreed.
> 
>>
>>>  }
>>>  
>>>  void kvm_arch_vcpu_put_debug_state_flags(struct kvm_vcpu *vcpu)
>>> @@ -361,6 +366,7 @@ void kvm_arch_vcpu_put_debug_state_flags(struct kvm_vcpu *vcpu)
>>>  	vcpu_clear_flag(vcpu, DEBUG_STATE_SAVE_SPE);
>>>  	vcpu_clear_flag(vcpu, DEBUG_STATE_SAVE_TRBE);
>>>  	vcpu_clear_flag(vcpu, DEBUG_STATE_SAVE_TRFCR);
>>> +	vcpu_clear_flag(vcpu, DEBUG_STATE_SAVE_BRBE);
>>>  }
>>>  
>>>  void kvm_etm_set_guest_trfcr(u64 trfcr_guest)
>>> diff --git a/arch/arm64/kvm/hyp/nvhe/debug-sr.c b/arch/arm64/kvm/hyp/nvhe/debug-sr.c
>>> index 6174f710948e..e44a1f71a0f8 100644
>>> --- a/arch/arm64/kvm/hyp/nvhe/debug-sr.c
>>> +++ b/arch/arm64/kvm/hyp/nvhe/debug-sr.c
>>> @@ -93,6 +93,38 @@ static void __debug_restore_trace(struct kvm_cpu_context *host_ctxt,
>>>  		write_sysreg_s(ctxt_sys_reg(host_ctxt, TRFCR_EL1), SYS_TRFCR_EL1);
>>>  }
>>>  
>>> +static void __debug_save_brbe(struct kvm_cpu_context *host_ctxt)
>>> +{
>>> +	ctxt_sys_reg(host_ctxt, BRBCR_EL1) = 0;
>>> +	ctxt_sys_reg(host_ctxt, BRBFCR_EL1) = 0;
>>> +
>>> +	/* Check if the BRBE is enabled */
>>> +	if (!(ctxt_sys_reg(host_ctxt, BRBCR_EL1) & (BRBCR_ELx_E0BRE | BRBCR_ELx_ExBRE)))
>>> +		return;
>>
>> Doesn't this always fail, the host BRBCR_EL1 value was just cleared on
>> the line above.
> 
> Agreed, this error might have slipped in while converting to ctxt_sys_reg().
> 
>>
>> Also, you need to read the register to determine if it was enabled or
> 
> Right
> 
>> not, so you might as well always store the real value, rather than 0 in
>> the not enabled case.
> 
> But if it is not enabled - why store the real value ?
> 

It's fewer lines of code and it's less likely to catch someone out if
it's always set to whatever the host value was. Using 0 as a special
value could also be an issue because it's indistinguishable from if the
register was actually set to 0. It's just more to reason about when you
could reduce it to a single assignment.

Also it probably would have avoided the current mistake if it was always
assigned to the host value as well.

>>
>>> +
>>> +	/*
>>> +	 * Prohibit branch record generation while we are in guest.
>>> +	 * Since access to BRBCR_EL1 and BRBFCR_EL1 is trapped, the
>>> +	 * guest can't modify the filtering set by the host.
>>> +	 */
>>> +	ctxt_sys_reg(host_ctxt, BRBCR_EL1) = read_sysreg_s(SYS_BRBCR_EL1);
>>> +	ctxt_sys_reg(host_ctxt, BRBFCR_EL1) = read_sysreg_s(SYS_BRBFCR_EL1)
>>> +	write_sysreg_s(0, SYS_BRBCR_EL1);
>>> +	write_sysreg_s(0, SYS_BRBFCR_EL1);
>>
>> Why does SYS_BRBFCR_EL1 need to be saved and restored? Only
>> BRBCR_ELx_E0BRE and BRBCR_ELx_ExBRE need to be cleared to disable BRBE.
> 
> Right, just thought both brbcr, and brbfcr system registers represent
> current BRBE state (besides branch records), in a more comprehensive
> manner, although none would be changed from inside the guest.
> 

The comment above doesn't match up with this explanation.

Having it in the code implies that it's needed. And as you say the
branch records are missing anyway, so you can't even infer that it's
only done to be comprehensive.

It would be better to not make anyone reading it wonder why it's done
and just not do it. It's only 8 bytes but it's also a waste of space.

>>
>>> +	isb();
>>> +}
>>> +
>>> +static void __debug_restore_brbe(struct kvm_cpu_context *host_ctxt)
>>> +{
>>> +	if (!ctxt_sys_reg(host_ctxt, BRBCR_EL1) || !ctxt_sys_reg(host_ctxt, BRBFCR_EL1))
>>> +		return;
>>> +
>>> +	/* Restore BRBE controls */
>>> +	write_sysreg_s(ctxt_sys_reg(host_ctxt, BRBCR_EL1), SYS_BRBCR_EL1);
>>> +	write_sysreg_s(ctxt_sys_reg(host_ctxt, BRBFCR_EL1), SYS_BRBFCR_EL1);
>>> +	isb();
>>> +}
>>> +
>>>  void __debug_save_host_buffers_nvhe(struct kvm_cpu_context *host_ctxt,
>>>  				    struct kvm_cpu_context *guest_ctxt)
>>>  {
>>> @@ -102,6 +134,10 @@ void __debug_save_host_buffers_nvhe(struct kvm_cpu_context *host_ctxt,
>>>  
>>>  	if (vcpu_get_flag(host_ctxt->__hyp_running_vcpu, DEBUG_STATE_SAVE_TRFCR))
>>>  		__debug_save_trace(host_ctxt, guest_ctxt);
>>> +
>>> +	/* Disable BRBE branch records */
>>> +	if (vcpu_get_flag(host_ctxt->__hyp_running_vcpu, DEBUG_STATE_SAVE_BRBE))
>>> +		__debug_save_brbe(host_ctxt);
>>>  }
>>>  
>>>  void __debug_switch_to_guest(struct kvm_vcpu *vcpu)
>>> @@ -116,6 +152,8 @@ void __debug_restore_host_buffers_nvhe(struct kvm_cpu_context *host_ctxt,
>>>  		__debug_restore_spe(host_ctxt);
>>>  	if (vcpu_get_flag(host_ctxt->__hyp_running_vcpu, DEBUG_STATE_SAVE_TRFCR))
>>>  		__debug_restore_trace(host_ctxt, guest_ctxt);
>>> +	if (vcpu_get_flag(host_ctxt->__hyp_running_vcpu, DEBUG_STATE_SAVE_BRBE))
>>> +		__debug_restore_brbe(host_ctxt);
>>>  }
>>>  
>>>  void __debug_switch_to_host(struct kvm_vcpu *vcpu)
> 
