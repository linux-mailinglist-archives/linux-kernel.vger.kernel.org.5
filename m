Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8B2180C113
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 07:00:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233203AbjLKGAN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 01:00:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjLKGAK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 01:00:10 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 864DED9;
        Sun, 10 Dec 2023 22:00:16 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4C4131007;
        Sun, 10 Dec 2023 22:01:02 -0800 (PST)
Received: from [10.162.41.8] (a077893.blr.arm.com [10.162.41.8])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3799C3F762;
        Sun, 10 Dec 2023 22:00:10 -0800 (PST)
Message-ID: <e48f5cdc-2711-4a03-a074-da87d84b3caf@arm.com>
Date:   Mon, 11 Dec 2023 11:30:08 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V15 5/8] KVM: arm64: nvhe: Disable branch generation in
 nVHE guests
Content-Language: en-US
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        will@kernel.org, catalin.marinas@arm.com, mark.rutland@arm.com,
        Mark Brown <broonie@kernel.org>,
        James Clark <james.clark@arm.com>,
        Rob Herring <robh@kernel.org>,
        Suzuki Poulose <suzuki.poulose@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-perf-users@vger.kernel.org,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>, kvmarm@lists.linux.dev
References: <20231201053906.1261704-1-anshuman.khandual@arm.com>
 <20231201053906.1261704-6-anshuman.khandual@arm.com>
 <86ttoybbp4.wl-maz@kernel.org>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <86ttoybbp4.wl-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/4/23 14:12, Marc Zyngier wrote:
> On Fri, 01 Dec 2023 05:39:03 +0000,
> Anshuman Khandual <anshuman.khandual@arm.com> wrote:
>>
>> Disable the BRBE before we enter the guest, saving the status and enable it
>> back once we get out of the guest. This is just to avoid capturing records
>> in the guest kernel/userspace, which would be confusing the samples.
> 
> Why does it have to be limited to non-VHE? What protects host EL0
> records from guest's EL0 execution when the host is VHE?

In a scenario when running the host in VHE mode
 
- The host might have enabled branch records for host EL0 through BRBCR_EL2.E0HBRE
  indirectly via accessing BRBCR_EL1.E0BRE

- But after the guest switches in on the cpu - BRBCR_EL2.E0HBRE will still remain
  set and enable branch records in guest EL0 as well because BRBCR_EL1.E0BRE will
  not have any effect when EL2 is implemented and HCR_EL2.TGE == 1. The guest EL0
  execution branch records will find their way into branch records being captured
  for host EL0

You are right. The host EL0 branch records too need to be protected from guest EL0
execution. A similar BRBCR_EL1 save/restore mechanism is needed for VHE as well ?

> 
>>
>> Cc: Marc Zyngier <maz@kernel.org>
>> Cc: Oliver Upton <oliver.upton@linux.dev>
>> Cc: James Morse <james.morse@arm.com>
>> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: kvmarm@lists.linux.dev
>> Cc: linux-arm-kernel@lists.infradead.org
>> CC: linux-kernel@vger.kernel.org
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>> Changes in V15:
>>
>> - Dropped runtime BRBE enable for setting DEBUG_STATE_SAVE_BRBE
>> - Dropped BRBFCR_EL1 from __debug_save_brbe()/__debug_restore_brbe()
>> - Always save the live SYS_BRBCR_EL1 in host context and then check if
>>   BRBE was enabled before resetting SYS_BRBCR_EL1 for the host
>>
>>  arch/arm64/include/asm/kvm_host.h  |  4 ++++
>>  arch/arm64/kvm/debug.c             |  5 +++++
>>  arch/arm64/kvm/hyp/nvhe/debug-sr.c | 33 ++++++++++++++++++++++++++++++
>>  3 files changed, 42 insertions(+)
>>
>> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
>> index 68421c74283a..1faa0430d8dd 100644
>> --- a/arch/arm64/include/asm/kvm_host.h
>> +++ b/arch/arm64/include/asm/kvm_host.h
>> @@ -449,6 +449,8 @@ enum vcpu_sysreg {
>>  	CNTHV_CVAL_EL2,
>>  	PMSCR_EL1,	/* Statistical profiling extension */
>>  	TRFCR_EL1,	/* Self-hosted trace filters */
>> +	BRBCR_EL1,	/* Branch Record Buffer Control Register */
>> +	BRBFCR_EL1,	/* Branch Record Buffer Function Control Register */
> 
> Whose state is this? If this is limited to the host, it has no purpose
> in this enum. Once you add guest support, then it will make sense.

yes, this is limited to host but if not here, where this register (BRBCR_EL1)
should be stored during guest context switch ? This place holder is used for
that purpose via ctxt_sys_reg(host_ctxt, BRBCR_EL1).

> 
>>
>>  	NR_SYS_REGS	/* Nothing after this line! */
>>  };
>> @@ -753,6 +755,8 @@ struct kvm_vcpu_arch {
>>  #define VCPU_HYP_CONTEXT	__vcpu_single_flag(iflags, BIT(7))
>>  /* Save trace filter controls */
>>  #define DEBUG_STATE_SAVE_TRFCR	__vcpu_single_flag(iflags, BIT(8))
>> +/* Save BRBE context if active  */
>> +#define DEBUG_STATE_SAVE_BRBE	__vcpu_single_flag(iflags, BIT(9))
>>  
>>  /* SVE enabled for host EL0 */
>>  #define HOST_SVE_ENABLED	__vcpu_single_flag(sflags, BIT(0))
>> diff --git a/arch/arm64/kvm/debug.c b/arch/arm64/kvm/debug.c
>> index 2ab41b954512..fa46a70a9503 100644
>> --- a/arch/arm64/kvm/debug.c
>> +++ b/arch/arm64/kvm/debug.c
>> @@ -354,6 +354,10 @@ void kvm_arch_vcpu_load_debug_state_flags(struct kvm_vcpu *vcpu)
>>  		    !(read_sysreg_s(SYS_TRBIDR_EL1) & TRBIDR_EL1_P))
>>  			vcpu_set_flag(vcpu, DEBUG_STATE_SAVE_TRBE);
>>  	}
>> +
>> +	/* Check if we have BRBE implemented and available at the host */
>> +	if (cpuid_feature_extract_unsigned_field(dfr0, ID_AA64DFR0_EL1_BRBE_SHIFT))
>> +		vcpu_set_flag(vcpu, DEBUG_STATE_SAVE_BRBE);
>>  }
>>  
>>  void kvm_arch_vcpu_put_debug_state_flags(struct kvm_vcpu *vcpu)
>> @@ -361,6 +365,7 @@ void kvm_arch_vcpu_put_debug_state_flags(struct kvm_vcpu *vcpu)
>>  	vcpu_clear_flag(vcpu, DEBUG_STATE_SAVE_SPE);
>>  	vcpu_clear_flag(vcpu, DEBUG_STATE_SAVE_TRBE);
>>  	vcpu_clear_flag(vcpu, DEBUG_STATE_SAVE_TRFCR);
>> +	vcpu_clear_flag(vcpu, DEBUG_STATE_SAVE_BRBE);
>>  }
>>  
>>  void kvm_etm_set_guest_trfcr(u64 trfcr_guest)
>> diff --git a/arch/arm64/kvm/hyp/nvhe/debug-sr.c b/arch/arm64/kvm/hyp/nvhe/debug-sr.c
>> index 6174f710948e..1994fc48b57c 100644
>> --- a/arch/arm64/kvm/hyp/nvhe/debug-sr.c
>> +++ b/arch/arm64/kvm/hyp/nvhe/debug-sr.c
>> @@ -93,6 +93,33 @@ static void __debug_restore_trace(struct kvm_cpu_context *host_ctxt,
>>  		write_sysreg_s(ctxt_sys_reg(host_ctxt, TRFCR_EL1), SYS_TRFCR_EL1);
>>  }
>>  
>> +static void __debug_save_brbe(struct kvm_cpu_context *host_ctxt)
>> +{
>> +	ctxt_sys_reg(host_ctxt, BRBCR_EL1) = read_sysreg_s(SYS_BRBCR_EL1);
>> +
>> +	/* Check if the BRBE is enabled */
>> +	if (!(ctxt_sys_reg(host_ctxt, BRBCR_EL1) & (BRBCR_ELx_E0BRE | BRBCR_ELx_ExBRE)))
>> +		return;
> 
> Why save BRBCR_EL1 if there is nothing enabled? It isn't like it can
> change behind your back, can it?

James mentioned that always setting the host value with real BRBCR_EL1 is preferred.

https://lore.kernel.org/linux-arm-kernel/1a94cccd-d871-1824-9fad-a8f7b99bb02a@arm.com/
 
> 
>> +
>> +	/*
>> +	 * Prohibit branch record generation while we are in guest.
>> +	 * Since access to BRBCR_EL1 is trapped, the guest can't
>> +	 * modify the filtering set by the host.
>> +	 */
>> +	write_sysreg_s(0, SYS_BRBCR_EL1);
>> +	isb();
> 
> What is the point of this ISB? We're at EL2, and this only affects
> EL1.

Makes sense, will drop this isb().

> 
>> +}
>> +
>> +static void __debug_restore_brbe(struct kvm_cpu_context *host_ctxt)
>> +{
>> +	if (!ctxt_sys_reg(host_ctxt, BRBCR_EL1))
>> +		return;
> 
> So on one side you're using a flag, and on the other you're using the
> *value*. You need some consistency.

Both DEBUG_STATE_SAVE_BRBE flag and BRBCR_EL1 value is checked on both save
and restore side.

__debug_save_host_buffers_nvhe()
	vcpu_get_flag(host_ctxt->__hyp_running_vcpu, DEBUG_STATE_SAVE_BRBE)
		__debug_save_brbe(host_ctxt)
			Save BRBE but reset if BRBE is running

__debug_restore_host_buffers_nvhe()
	vcpu_get_flag(host_ctxt->__hyp_running_vcpu, DEBUG_STATE_SAVE_BRBE)
		__debug_restore_brbe(host_ctxt)
			Restore when saved BRBCR_EL1 is positive

> 
>> +
>> +	/* Restore BRBE controls */
>> +	write_sysreg_s(ctxt_sys_reg(host_ctxt, BRBCR_EL1), SYS_BRBCR_EL1);
>> +	isb();
> 
> Same question.
> 
>> +}
>> +
>>  void __debug_save_host_buffers_nvhe(struct kvm_cpu_context *host_ctxt,
>>  				    struct kvm_cpu_context *guest_ctxt)
>>  {
>> @@ -102,6 +129,10 @@ void __debug_save_host_buffers_nvhe(struct kvm_cpu_context *host_ctxt,
>>  
>>  	if (vcpu_get_flag(host_ctxt->__hyp_running_vcpu, DEBUG_STATE_SAVE_TRFCR))
>>  		__debug_save_trace(host_ctxt, guest_ctxt);
>> +
>> +	/* Disable BRBE branch records */
>> +	if (vcpu_get_flag(host_ctxt->__hyp_running_vcpu, DEBUG_STATE_SAVE_BRBE))
>> +		__debug_save_brbe(host_ctxt);
>>  }
>>  
>>  void __debug_switch_to_guest(struct kvm_vcpu *vcpu)
>> @@ -116,6 +147,8 @@ void __debug_restore_host_buffers_nvhe(struct kvm_cpu_context *host_ctxt,
>>  		__debug_restore_spe(host_ctxt);
>>  	if (vcpu_get_flag(host_ctxt->__hyp_running_vcpu, DEBUG_STATE_SAVE_TRFCR))
>>  		__debug_restore_trace(host_ctxt, guest_ctxt);
>> +	if (vcpu_get_flag(host_ctxt->__hyp_running_vcpu, DEBUG_STATE_SAVE_BRBE))
>> +		__debug_restore_brbe(host_ctxt);
>>  }
>>  
>>  void __debug_switch_to_host(struct kvm_vcpu *vcpu)
> 
> The lifetime of this flag seems bogus, specially when there is nothing
> to do, which will always be the arch-majority of the executions.

Not sure if I follow your point, could you please be more specific here ?

DEBUG_STATE_SAVE_BRBE follows all existing register state context save/restore
mechanism such as DEBUG_STATE_SAVE_SPE and DEBUG_STATE_SAVE_TRFCR. How is this
any different or problematic ?
