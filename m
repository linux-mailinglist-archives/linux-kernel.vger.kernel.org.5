Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BF197B320C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 14:09:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233151AbjI2MJv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 08:09:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232964AbjI2MJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 08:09:50 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6DC60193
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 05:09:47 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4DF6D1FB;
        Fri, 29 Sep 2023 05:10:25 -0700 (PDT)
Received: from [10.57.3.6] (unknown [10.57.3.6])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3DC133F59C;
        Fri, 29 Sep 2023 05:09:44 -0700 (PDT)
Message-ID: <a46d6c52-36f8-1098-9806-41f3ed804c3b@arm.com>
Date:   Fri, 29 Sep 2023 13:09:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v1 3/5] arm64: KVM: Add interface to set guest value for
 TRFCR register
Content-Language: en-US
To:     Marc Zyngier <maz@kernel.org>
Cc:     coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.linux.dev, broonie@kernel.org, suzuki.poulose@arm.com,
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
        Joey Gouly <joey.gouly@arm.com>, linux-kernel@vger.kernel.org
References: <20230928151611.3042443-1-james.clark@arm.com>
 <20230928151611.3042443-4-james.clark@arm.com> <87edihmgfm.wl-maz@kernel.org>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <87edihmgfm.wl-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 29/09/2023 11:17, Marc Zyngier wrote:
> On Thu, 28 Sep 2023 16:16:07 +0100,
> James Clark <james.clark@arm.com> wrote:
>>
>> Add an interface for the Coresight driver to use to set the value of the
>> TRFCR register for the guest. This register controls the exclude
>> settings for trace at different exception levels, and is used to
>> honor the exclude_host and exclude_guest parameters from the Perf
>> session. This will be used to later write TRFCR_EL1 on nVHE at guest
>> switch. For VHE, TRFCR_EL1 is written immediately. Because guest writes
>> to the register are trapped, the value will persist and can't be
>> modified.
>>
>> The settings must be copied to the vCPU before each run in the same
>> way that PMU events are because the per-cpu struct isn't accessible in
>> protected mode.
>>
>> Now that both guest and host values are saved, rename trfcr_el1 to
>> host_trfcr_el1 to make it clear that's the value that should be restored
>> on return to the host.
>>
>> Reviewed-by: Mark Brown <broonie@kernel.org> (sysreg)
>> Signed-off-by: James Clark <james.clark@arm.com>
>> ---
>>  arch/arm64/include/asm/kvm_host.h  |  6 +++++-
>>  arch/arm64/kvm/arm.c               |  1 +
>>  arch/arm64/kvm/debug.c             | 21 +++++++++++++++++++++
>>  arch/arm64/kvm/hyp/nvhe/debug-sr.c |  4 ++--
>>  arch/arm64/tools/sysreg            |  4 ++++
>>  5 files changed, 33 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
>> index 498f922f4f41..0e57827a0cf2 100644
>> --- a/arch/arm64/include/asm/kvm_host.h
>> +++ b/arch/arm64/include/asm/kvm_host.h
>> @@ -547,7 +547,8 @@ struct kvm_vcpu_arch {
>>  		/* Statistical profiling extension */
>>  		u64 pmscr_el1;
>>  		/* Self-hosted trace */
>> -		u64 trfcr_el1;
>> +		u64 host_trfcr_el1;
>> +		u64 guest_trfcr_el1;
>>  	} host_debug_state;
> 
> I think it is high time we stop having *guest* state in a structure
> that is obviously for the host, starting by moving the breakpoint and
> watchpoint out, and into the sysreg array.
> 

It looks like host_debug_state::regs is actually the host debug state,
despite the type being called "struct kvm_guest_debug_arch".

But yeah I can move pmscr_el1 and trfcr_el1 to the guest and host sysreg
arrays, that would make sense.

host_debug_state::regs seems to be a bit more intertwined with the
kvm_arch_vcpu_ioctl_set_guest_debug() ioctl and the pattern to support
two different sets of guest debug state, so I'm not sure if it's worth
touching that at this point:

  * We maintain more than a single set of debug registers to support
  * debugging the guest
  ...
  * debug_ptr points to the set of debug registers that should be loaded
  * onto the hardware when running the guest.
  */
  struct kvm_guest_debug_arch *debug_ptr;
  struct kvm_guest_debug_arch vcpu_debug_state;
  struct kvm_guest_debug_arch external_debug_state;

> And then TRFCR_EL1 can join the fun. But it is pretty unclear whether
> that's actually the guest state.
> 

It has an effect on the guest, but can never actually be read or written
by the guest. Not sure if that pattern exists elsewhere...

>>  
>>  	/* VGIC state */
>> @@ -1097,6 +1098,8 @@ void kvm_arch_vcpu_put_debug_state_flags(struct kvm_vcpu *vcpu);
>>  void kvm_set_pmu_events(u32 set, struct perf_event_attr *attr);
>>  void kvm_clr_pmu_events(u32 clr);
>>  bool kvm_set_pmuserenr(u64 val);
>> +void kvm_etm_set_guest_trfcr(u64 trfcr_guest);
>> +void kvm_etm_update_vcpu_events(struct kvm_vcpu *vcpu);
>>  #else
>>  static inline void kvm_set_pmu_events(u32 set, struct perf_event_attr *attr) {}
>>  static inline void kvm_clr_pmu_events(u32 clr) {}
>> @@ -1104,6 +1107,7 @@ static inline bool kvm_set_pmuserenr(u64 val)
>>  {
>>  	return false;
>>  }
>> +static inline void kvm_etm_set_guest_trfcr(u64 trfcr_guest) {}
>>  #endif
>>  
>>  void kvm_vcpu_load_sysregs_vhe(struct kvm_vcpu *vcpu);
>> diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
>> index 1bfdd583b261..65e805dc1d7a 100644
>> --- a/arch/arm64/kvm/arm.c
>> +++ b/arch/arm64/kvm/arm.c
>> @@ -958,6 +958,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
>>  		kvm_vgic_flush_hwstate(vcpu);
>>  
>>  		kvm_pmu_update_vcpu_events(vcpu);
>> +		kvm_etm_update_vcpu_events(vcpu);
>>  
>>  		/*
>>  		 * Ensure we set mode to IN_GUEST_MODE after we disable
>> diff --git a/arch/arm64/kvm/debug.c b/arch/arm64/kvm/debug.c
>> index 6a1bad1a921b..379d2677961f 100644
>> --- a/arch/arm64/kvm/debug.c
>> +++ b/arch/arm64/kvm/debug.c
>> @@ -22,6 +22,7 @@
>>  				DBG_MDSCR_MDE)
>>  
>>  static DEFINE_PER_CPU(u64, mdcr_el2);
>> +static DEFINE_PER_CPU(u64, guest_trfcr);
> 
> Hold on a sec. Why is that global? I'd expect the tracing to be
> specific to a vcpu, and not to affect *everything*.
> 

I suppose because it is a property of the host CPU rather than the vcpu.
The vcpu might not even exist yet when the Perf session starts, and Perf
sessions only care about the host CPU's perspective. It's defining the
guest trfcr value for any vcpu that might or might not run on this core
in the future, rather than any one specific vcpu.

I copied the pattern from the existing Perf PMU settings in
arch/arm64/kvm/pmu.c:

  static DEFINE_PER_CPU(struct kvm_pmu_events, kvm_pmu_events);

We could flip it around and make KVM say "what's the guest trfcr value
for this core?" to the Coresight driver at the point of guest switch,
but all that would mean is that the global would be in the Coresight
driver instead.

>>  
>>  /**
>>   * save/restore_guest_debug_regs
>> @@ -342,3 +343,23 @@ void kvm_arch_vcpu_put_debug_state_flags(struct kvm_vcpu *vcpu)
>>  	vcpu_clear_flag(vcpu, DEBUG_STATE_SAVE_SPE);
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
> In what context can this be called? What if we want to expose TRFCR to
> guests instead? It looks to me that this ultimately precludes such
> use.
> 

Yes it does, but currently Coresight isn't exposed to guests at all so
it's not a problem.

In the future if we did decide to do it, there would be significant work
to somehow share the components between the host and the guest. But even
if they were shared, in the case where the guest isn't using trace the
trfcr and exclude guest settings would still need to work, so something
of this form would still be required.

>> +
>> +/*
>> + * Updates the vcpu's view of the etm events for this cpu. Must be
>> + * called before every vcpu run after disabling interrupts, to ensure
>> + * that an interrupt cannot fire and update the structure.
>> + */
>> +void kvm_etm_update_vcpu_events(struct kvm_vcpu *vcpu)
>> +{
>> +	if (!has_vhe() && vcpu_get_flag(vcpu, DEBUG_STATE_SAVE_TRFCR))
>> +		vcpu->arch.host_debug_state.guest_trfcr_el1 = *this_cpu_ptr(&guest_trfcr);
> 
> But what is the point of this per-vcpu field if all you care about is
> some per-CPU data?
> 

This was the only way I could find to share data between the host and
have it available to EL2 on the guest switch. I saw it was also done
that way for PMUs in kvm_pmu_update_vcpu_events(). Maybe it could be
done by exposing the guest_trfcr global to both sides with some
annotation? But I assumed that wasn't idomatic as it wasn't done for PMUs.

>> +}
>> diff --git a/arch/arm64/kvm/hyp/nvhe/debug-sr.c b/arch/arm64/kvm/hyp/nvhe/debug-sr.c
>> index 89c208112eb7..55bc01e9808f 100644
>> --- a/arch/arm64/kvm/hyp/nvhe/debug-sr.c
>> +++ b/arch/arm64/kvm/hyp/nvhe/debug-sr.c
>> @@ -86,7 +86,7 @@ void __debug_save_host_buffers_nvhe(struct kvm_vcpu *vcpu)
>>  		__debug_save_spe(&vcpu->arch.host_debug_state.pmscr_el1);
>>  	/* Disable and flush Self-Hosted Trace generation */
>>  	if (vcpu_get_flag(vcpu, DEBUG_STATE_SAVE_TRFCR))
>> -		__debug_save_trace(&vcpu->arch.host_debug_state.trfcr_el1);
>> +		__debug_save_trace(&vcpu->arch.host_debug_state.host_trfcr_el1);
>>  }
> `<>
>>  void __debug_switch_to_guest(struct kvm_vcpu *vcpu)
>> @@ -99,7 +99,7 @@ void __debug_restore_host_buffers_nvhe(struct kvm_vcpu *vcpu)
>>  	if (vcpu_get_flag(vcpu, DEBUG_STATE_SAVE_SPE))
>>  		__debug_restore_spe(vcpu->arch.host_debug_state.pmscr_el1);
>>  	if (vcpu_get_flag(vcpu, DEBUG_STATE_SAVE_TRFCR))
>> -		__debug_restore_trace(vcpu->arch.host_debug_state.trfcr_el1);
>> +		__debug_restore_trace(vcpu->arch.host_debug_state.host_trfcr_el1);
>>  }
>>  
>>  void __debug_switch_to_host(struct kvm_vcpu *vcpu)
>> diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
>> index 992722c0c23b..295a4a625b8b 100644
>> --- a/arch/arm64/tools/sysreg
>> +++ b/arch/arm64/tools/sysreg
>> @@ -2661,3 +2661,7 @@ EndSysreg
>>  Sysreg	TRFCR_EL2	3	4	1	2	1
>>  Fields	TRFCR_EL2
>>  EndSysreg
>> +
>> +Sysreg TRFCR_EL12	3	5	1	2	1
>> +Fields	TRFCR_ELx
>> +EndSysreg
> 
> Please move this to the first patch.
> 
> 	M.
> 

Will do.

James

