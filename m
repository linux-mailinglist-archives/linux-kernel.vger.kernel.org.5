Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C777804FC4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 11:05:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232001AbjLEKFR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 05:05:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232007AbjLEKFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 05:05:14 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5BFC9BA
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 02:05:20 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A33B8FEC;
        Tue,  5 Dec 2023 02:06:06 -0800 (PST)
Received: from [10.1.197.1] (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 34E323F5A1;
        Tue,  5 Dec 2023 02:05:17 -0800 (PST)
Message-ID: <6576da2f-4427-43ab-91e5-40508bf1e128@arm.com>
Date:   Tue, 5 Dec 2023 10:05:15 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/6] arm64: KVM: Add iflag for FEAT_TRF
Content-Language: en-US
To:     Marc Zyngier <maz@kernel.org>, James Clark <james.clark@arm.com>
Cc:     coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.linux.dev, broonie@kernel.org,
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
        Fuad Tabba <tabba@google.com>,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        Akihiko Odaki <akihiko.odaki@daynix.com>,
        Joey Gouly <joey.gouly@arm.com>, linux-kernel@vger.kernel.org
References: <20231019165510.1966367-1-james.clark@arm.com>
 <20231019165510.1966367-4-james.clark@arm.com> <86o7f6b8n8.wl-maz@kernel.org>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <86o7f6b8n8.wl-maz@kernel.org>
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

On 04/12/2023 09:48, Marc Zyngier wrote:
> On Thu, 19 Oct 2023 17:55:01 +0100,
> James Clark <james.clark@arm.com> wrote:
>>
>> Add an extra iflag to signify if the TRFCR register is accessible.
>> Because TRBE requires FEAT_TRF, DEBUG_STATE_SAVE_TRBE still has the same
>> behavior even though it's only set when FEAT_TRF is present.
>>
>> The following holes are left in struct kvm_vcpu_arch, but there aren't
>> enough other 8 bit fields to rearrange it to leave any hole smaller than
>> 7 bytes:
>>
>>    u8                         cflags;               /*  2292     1 */
>>    /* XXX 1 byte hole, try to pack */
>>    u16                        iflags;               /*  2294     2 */
>>    u8                         sflags;               /*  2296     1 */
>>    bool                       pause;                /*  2297     1 */
>>    /* XXX 6 bytes hole, try to pack */
>>
>> Signed-off-by: James Clark <james.clark@arm.com>
>> ---
>>   arch/arm64/include/asm/kvm_host.h |  4 +++-
>>   arch/arm64/kvm/debug.c            | 22 ++++++++++++++++++----
>>   2 files changed, 21 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
>> index 7c82927ddaf2..0f0bf8e641bd 100644
>> --- a/arch/arm64/include/asm/kvm_host.h
>> +++ b/arch/arm64/include/asm/kvm_host.h
>> @@ -535,7 +535,7 @@ struct kvm_vcpu_arch {
>>   	u8 cflags;
>>   
>>   	/* Input flags to the hypervisor code, potentially cleared after use */
>> -	u8 iflags;
>> +	u16 iflags;
>>   
>>   	/* State flags for kernel bookkeeping, unused by the hypervisor code */
>>   	u8 sflags;
>> @@ -741,6 +741,8 @@ struct kvm_vcpu_arch {
>>   #define DEBUG_STATE_SAVE_TRBE	__vcpu_single_flag(iflags, BIT(6))
>>   /* vcpu running in HYP context */
>>   #define VCPU_HYP_CONTEXT	__vcpu_single_flag(iflags, BIT(7))
>> +/* Save trace filter controls */
>> +#define DEBUG_STATE_SAVE_TRFCR	__vcpu_single_flag(iflags, BIT(8))
>>   
>>   /* SVE enabled for host EL0 */
>>   #define HOST_SVE_ENABLED	__vcpu_single_flag(sflags, BIT(0))
>> diff --git a/arch/arm64/kvm/debug.c b/arch/arm64/kvm/debug.c
>> index 8725291cb00a..20cdd40b3c42 100644
>> --- a/arch/arm64/kvm/debug.c
>> +++ b/arch/arm64/kvm/debug.c
>> @@ -331,14 +331,28 @@ void kvm_arch_vcpu_load_debug_state_flags(struct kvm_vcpu *vcpu)
>>   	    !(read_sysreg_s(SYS_PMBIDR_EL1) & BIT(PMBIDR_EL1_P_SHIFT)))
>>   		vcpu_set_flag(vcpu, DEBUG_STATE_SAVE_SPE);
>>   
>> -	/* Check if we have TRBE implemented and available at the host */
>> -	if (cpuid_feature_extract_unsigned_field(dfr0, ID_AA64DFR0_EL1_TraceBuffer_SHIFT) &&
>> -	    !(read_sysreg_s(SYS_TRBIDR_EL1) & TRBIDR_EL1_P))
>> -		vcpu_set_flag(vcpu, DEBUG_STATE_SAVE_TRBE);
>> +	/*
>> +	 * Save TRFCR on nVHE if FEAT_TRF (TraceFilt) exists. This will be
>> +	 * done in cases where use of TRBE doesn't completely disable trace and
>> +	 * handles the exclude_host/exclude_guest rules of the trace session.
> 
> This comment provides zero information. What will be done? Under which
> conditions? What are the rules?
> 
>> +	 */
>> +	if (cpuid_feature_extract_unsigned_field(dfr0, ID_AA64DFR0_EL1_TraceFilt_SHIFT)) {
>> +		vcpu_set_flag(vcpu, DEBUG_STATE_SAVE_TRFCR);
>> +		/*
>> +		 * Check if we have TRBE implemented and available at the host. If it's
>> +		 * in use at the time of guest switch it will need to be disabled and
>> +		 * then restored. The architecture mandates FEAT_TRF with TRBE, so we
>> +		 * only need to check for TRBE after TRF.
>> +		 */
>> +		if (cpuid_feature_extract_unsigned_field(dfr0, ID_AA64DFR0_EL1_TraceBuffer_SHIFT) &&
>> +		    !(read_sysreg_s(SYS_TRBIDR_EL1) & TRBIDR_EL1_P))
>> +			vcpu_set_flag(vcpu, DEBUG_STATE_SAVE_TRBE);
>> +	}
> 
> Multiple questions:
> 
> - Why is it safe to trust the local CPU's capability rather than the
>    consolidated view from the cpufeature infrastructure?

The coresight driver is capable of handling heterogeneous systems. i.e., 
some CPUs may not have FEAT_TRF or FEAT_TRBE. This could be for various
reasons (e.g., CPU Erratum disabling TRBE, though not used now). It 
already needs to treat each CPU differently (due to the capabilities
of the ETM).

That said, we could reject events with exclude_guest/exclude_host flags
on CPUs that do not support FEAT_TRF. But that doesn't solve checking
the local capability.

Suzuki


> 
> - Why defer the saving of the registers if there are no changes made
>    to them in the interval?
> 
> Thanks,
> 
> 	M.
> 

