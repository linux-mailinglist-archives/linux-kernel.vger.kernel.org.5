Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAB06776236
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 16:17:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232559AbjHIOR5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 10:17:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232513AbjHIOR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 10:17:56 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 33BA41FD7
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 07:17:55 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 26932D75;
        Wed,  9 Aug 2023 07:18:37 -0700 (PDT)
Received: from [10.57.1.30] (unknown [10.57.1.30])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 58FD33F59C;
        Wed,  9 Aug 2023 07:17:52 -0700 (PDT)
Message-ID: <b0581b86-a0b4-45cd-ac62-a7de45f8cc90@arm.com>
Date:   Wed, 9 Aug 2023 15:17:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [RFC PATCH 1/3] arm64: KVM: Add support for exclude_guest and
 exclude_host for ETM
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
 <20230804101317.460697-2-james.clark@arm.com> <87350uq6qf.wl-maz@kernel.org>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <87350uq6qf.wl-maz@kernel.org>
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



On 08/08/2023 09:27, Marc Zyngier wrote:
> On Fri, 04 Aug 2023 11:13:11 +0100,
> James Clark <james.clark@arm.com> wrote:
>>
>> Add an interface for the Coresight driver to use to set the current
>> exclude settings for the current CPU. This will be used to configure
>> TRFCR_EL1.
> 
> Can you start by stating the problem? There is *some* rationale in the
> cover letter, but not enough to get the full picture. Specially if you
> haven't looked at the trace subsystem in the past... 7 years or so.
> 

Yeah I will expand on it a bit.

>>
>> The settings must be copied to the vCPU before each run in the same
>> way that PMU events are because the per-cpu struct isn't accessible in
>> protected mode.
> 
> I'm pretty sure that for protected guests, we'd like to disable
> tracing altogether (debug mode excepted).
> 

Do you mean disable the ability to trace guests from the host? Or to
disable generation of any trace altogether when in the guest, even if
the guest started the session?

Currently the ETM driver isn't exposed to guests, so it's not possible
for the guest to start a session. That leaves only the host being able
to trace the guest. If you think that shouldn't happen outside of debug
mode then maybe we need another change to prevent that.

Another issue is that this only works with Feat_TRF, without that we'd
have to do something else again to prevent protected guests from being
traced, as currently there is nothing to stop it.

I'm not sure about debug mode though? Is that a kernel config or some
kvm option? I suppose this could be disabled for users by not loading
the Coresight driver, but there's currently nothing a guest can do to
stop its self from being traced.

>>
>> This is only needed for nVHE, otherwise it works automatically with
> 
> How about hVHE, which uses VHE at EL2 only? Doesn't it require the
> same treatment?
> 

Yes it sounds like it would. Does it use the same code as nVHE in
arch/arm64/kvm/hyp/nvhe? I think it might already work in that case, but
I need to read a bit about hVHE.

>> TRFCR_EL{1,2}. Unfortunately it can't be gated on CONFIG_CORESIGHT
>> because Coresight can be built as a module. It can however be gated on
>> CONFIG_PERF_EVENTS because that is required by Coresight.
> 
> Why does it need to be gated *at all*? We need this for the PMU
> because of the way we call into the perf subsystem, but I don't see
> anything like that here. In general, conditional compilation sucks,
> and I'd like to avoid it as much as possible.
> 

No real reason really, I was probably trying to minimise the impact
because it added a few bytes here and there, but it's tiny. If you're ok
with it I can quite easily remove the conditional compilation and it
should simplify it a bit.

>>
>> Signed-off-by: James Clark <james.clark@arm.com>
>> ---
>>  arch/arm64/include/asm/kvm_host.h | 10 ++++++-
>>  arch/arm64/kvm/Makefile           |  1 +
>>  arch/arm64/kvm/arm.c              |  1 +
>>  arch/arm64/kvm/etm.c              | 48 +++++++++++++++++++++++++++++++
>>  include/kvm/etm.h                 | 43 +++++++++++++++++++++++++++
>>  5 files changed, 102 insertions(+), 1 deletion(-)
>>  create mode 100644 arch/arm64/kvm/etm.c
>>  create mode 100644 include/kvm/etm.h
>>
>> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
>> index d7b1403a3fb2..f33262217c84 100644
>> --- a/arch/arm64/include/asm/kvm_host.h
>> +++ b/arch/arm64/include/asm/kvm_host.h
>> @@ -35,6 +35,7 @@
>>  #include <kvm/arm_vgic.h>
>>  #include <kvm/arm_arch_timer.h>
>>  #include <kvm/arm_pmu.h>
>> +#include <kvm/etm.h>
>>  
>>  #define KVM_MAX_VCPUS VGIC_V3_MAX_CPUS
>>  
>> @@ -500,7 +501,7 @@ struct kvm_vcpu_arch {
>>  	u8 cflags;
>>  
>>  	/* Input flags to the hypervisor code, potentially cleared after use */
>> -	u8 iflags;
>> +	u16 iflags;
> 
> If you make the iflags bigger, what ripple effect does it have on the
> alignment of the other data structures? Consider reordering things if
> it helps filling holes.
> 

I think you might be right. Possibly flipping iflags and sflags will be
enough but will have to check the exact alignment up to that point.

>>  
>>  	/* State flags for kernel bookkeeping, unused by the hypervisor code */
>>  	u8 sflags;
>> @@ -541,6 +542,9 @@ struct kvm_vcpu_arch {
>>  		u64 pmscr_el1;
>>  		/* Self-hosted trace */
>>  		u64 trfcr_el1;
>> +		/* exclude_guest settings for nVHE */
>> +		struct kvm_etm_event etm_event;
>> +
> 
> Spurious blank line. More importantly, how is that related to the
> trfcr_el1 field just above?
> 

It's not really related, it's just the same place that the code that
runs at a similar time and does a similar thing has its data stored.

Something that you mentioned in another comment might be relevant here.
If I do it only in terms of registers that are saved and restored then I
don't need to save the etm event settings and the low level code doesn't
need to know anything about it.

>>  	} host_debug_state;
>>  
>>  	/* VGIC state */
>> @@ -713,6 +717,8 @@ struct kvm_vcpu_arch {
>>  #define DEBUG_STATE_SAVE_TRBE	__vcpu_single_flag(iflags, BIT(6))
>>  /* vcpu running in HYP context */
>>  #define VCPU_HYP_CONTEXT	__vcpu_single_flag(iflags, BIT(7))
>> +/* Save TRFCR and apply exclude_guest rules */
>> +#define DEBUG_STATE_SAVE_TRFCR	__vcpu_single_flag(iflags, BIT(8))
>>  
>>  /* SVE enabled for host EL0 */
>>  #define HOST_SVE_ENABLED	__vcpu_single_flag(sflags, BIT(0))
>> @@ -1096,6 +1102,8 @@ void kvm_arch_vcpu_put_debug_state_flags(struct kvm_vcpu *vcpu);
>>  void kvm_set_pmu_events(u32 set, struct perf_event_attr *attr);
>>  void kvm_clr_pmu_events(u32 clr);
>>  bool kvm_set_pmuserenr(u64 val);
>> +void kvm_set_etm_events(struct perf_event_attr *attr);
>> +void kvm_clr_etm_events(void);
>>  #else
>>  static inline void kvm_set_pmu_events(u32 set, struct perf_event_attr *attr) {}
>>  static inline void kvm_clr_pmu_events(u32 clr) {}
>> diff --git a/arch/arm64/kvm/Makefile b/arch/arm64/kvm/Makefile
>> index c0c050e53157..0faff57423c4 100644
>> --- a/arch/arm64/kvm/Makefile
>> +++ b/arch/arm64/kvm/Makefile
>> @@ -23,6 +23,7 @@ kvm-y += arm.o mmu.o mmio.o psci.o hypercalls.o pvtime.o \
>>  	 vgic/vgic-its.o vgic/vgic-debug.o
>>  
>>  kvm-$(CONFIG_HW_PERF_EVENTS)  += pmu-emul.o pmu.o
>> +kvm-$(CONFIG_PERF_EVENTS) += etm.o
>>
>>  always-y := hyp_constants.h hyp-constants.s
>>  
>> diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
>> index b1a9d47fb2f3..7bd5975328a3 100644
>> --- a/arch/arm64/kvm/arm.c
>> +++ b/arch/arm64/kvm/arm.c
>> @@ -952,6 +952,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
>>  		kvm_vgic_flush_hwstate(vcpu);
>>  
>>  		kvm_pmu_update_vcpu_events(vcpu);
>> +		kvm_etm_update_vcpu_events(vcpu);
>>  
>>  		/*
>>  		 * Ensure we set mode to IN_GUEST_MODE after we disable
>> diff --git a/arch/arm64/kvm/etm.c b/arch/arm64/kvm/etm.c
>> new file mode 100644
>> index 000000000000..359c37745de2
>> --- /dev/null
>> +++ b/arch/arm64/kvm/etm.c
>> @@ -0,0 +1,48 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +
>> +#include <linux/kvm_host.h>
>> +
>> +#include <kvm/etm.h>
>> +
>> +static DEFINE_PER_CPU(struct kvm_etm_event, kvm_etm_events);
>> +
>> +struct kvm_etm_event *kvm_get_etm_event(void)
>> +{
>> +	return this_cpu_ptr(&kvm_etm_events);
>> +}
>> +
>> +void kvm_etm_set_events(struct perf_event_attr *attr)
>> +{
>> +	struct kvm_etm_event *etm_event;
>> +
>> +	/*
>> +	 * Exclude guest option only requires extra work with nVHE.
>> +	 * Otherwise it works automatically with TRFCR_EL{1,2}
>> +	 */
>> +	if (has_vhe())
>> +		return;
>> +
>> +	etm_event = kvm_get_etm_event();
>> +
>> +	etm_event->exclude_guest = attr->exclude_guest;
>> +	etm_event->exclude_host = attr->exclude_host;
>> +	etm_event->exclude_kernel = attr->exclude_kernel;
>> +	etm_event->exclude_user = attr->exclude_user;
>> +}
>> +EXPORT_SYMBOL_GPL(kvm_etm_set_events);
>> +
>> +void kvm_etm_clr_events(void)
>> +{
>> +	struct kvm_etm_event *etm_event;
>> +
>> +	if (has_vhe())
>> +		return;
>> +
>> +	etm_event = kvm_get_etm_event();
>> +
>> +	etm_event->exclude_guest = false;
>> +	etm_event->exclude_host = false;
>> +	etm_event->exclude_kernel = false;
>> +	etm_event->exclude_user = false;
>> +}
>> +EXPORT_SYMBOL_GPL(kvm_etm_clr_events);
> 
> Does it really need its own compilation unit if we were to build it at
> all times?
> 

I can probably throw it in arch/arm64/kvm/debug.c. I think I did that
originally but it had the conditional stuff around it so I made the new
file instead.

But yeah if I remove the conditional stuff it's probably cleaner to put
somewhere else.

>> diff --git a/include/kvm/etm.h b/include/kvm/etm.h
>> new file mode 100644
>> index 000000000000..95c4809fa2b0
>> --- /dev/null
>> +++ b/include/kvm/etm.h
>> @@ -0,0 +1,43 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +
>> +#ifndef __KVM_DEBUG_H
>> +#define __KVM_DEBUG_H
>> +
>> +struct perf_event_attr;
>> +struct kvm_vcpu;
>> +
>> +#if IS_ENABLED(CONFIG_KVM) && IS_ENABLED(CONFIG_PERF_EVENTS)
>> +
>> +struct kvm_etm_event {
>> +	bool exclude_host;
>> +	bool exclude_guest;
>> +	bool exclude_kernel;
>> +	bool exclude_user;
>> +};
>> +
>> +struct kvm_etm_event *kvm_get_etm_event(void);
>> +void kvm_etm_clr_events(void);
>> +void kvm_etm_set_events(struct perf_event_attr *attr);
>> +
>> +/*
>> + * Updates the vcpu's view of the etm events for this cpu. Must be
>> + * called before every vcpu run after disabling interrupts, to ensure
>> + * that an interrupt cannot fire and update the structure.
>> + */
>> +#define kvm_etm_update_vcpu_events(vcpu)						\
>> +	do {										\
>> +		if (!has_vhe() && vcpu_get_flag(vcpu, DEBUG_STATE_SAVE_TRFCR))		\
>> +			vcpu->arch.host_debug_state.etm_event = *kvm_get_etm_event();	\
>> +	} while (0)
>> +
> 
> Why is it a macro and not a function, which would avoid exposing
> kvm_get_etm_event?
> 

I think I saw that kvm_pmu_update_vcpu_events() was done that way, and I
couldn't inline it without some circular header issue so I made it a macro.

But yes a non inlined function works fine and then kvm_get_etm_event can
be hidden so I'll do that.

> Thanks,
> 
> 	M.
> 

Thanks for the review.

James
