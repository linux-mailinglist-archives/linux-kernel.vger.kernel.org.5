Return-Path: <linux-kernel+bounces-43911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5556D841AA9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 04:41:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79F321C23163
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 03:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49AA637157;
	Tue, 30 Jan 2024 03:41:40 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FE3E36133;
	Tue, 30 Jan 2024 03:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706586099; cv=none; b=UAbNEBFNfYhKDoGnzOjot7ko270jdbp/m2nN0xkGrkMHUteQdancJ8UxpnN6u+ht+HWgQhmx/6H5hz8Ba0WRLEt+7FGGALkUu9BRmdxST0/W8TARn4UX5QQSciVWNHXRtKG6r7WFZg8dAV6OFuAbMVrD64R+V7gVi3dbf8gn7bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706586099; c=relaxed/simple;
	bh=MS9XkrHIxAOgVMwkPgUdkJNkZsvXrigVFaMPH+MQ3tg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G4c7qY+2+qfpPolS4Vur3iUf+g3Wkzf49raIc7dAmDNOWmPbzD4TPOXyK5d8pk1L9hrwXsZRKraVvAfN5pBqn+m8JVndXSrsMLCKkeIy5xhnnGg8wJf/bVZ76ZUqaXNsZT1aLE2RJJanpsjvCy62C/0Lg4sx9lZXMJJ5lXM72ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B6419DA7;
	Mon, 29 Jan 2024 19:42:20 -0800 (PST)
Received: from [10.163.41.110] (unknown [10.163.41.110])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CE7BE3F738;
	Mon, 29 Jan 2024 19:41:30 -0800 (PST)
Message-ID: <a575d0d0-a882-40e5-95a4-d59dd010e047@arm.com>
Date: Tue, 30 Jan 2024 09:11:30 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V16 5/8] KVM: arm64: nvhe: Disable branch generation in
 nVHE guests
Content-Language: en-US
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 will@kernel.org, catalin.marinas@arm.com, mark.rutland@arm.com
Cc: Mark Brown <broonie@kernel.org>, James Clark <james.clark@arm.com>,
 Rob Herring <robh@kernel.org>, Marc Zyngier <maz@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 linux-perf-users@vger.kernel.org, Oliver Upton <oliver.upton@linux.dev>,
 James Morse <james.morse@arm.com>, kvmarm@lists.linux.dev
References: <20240125094119.2542332-1-anshuman.khandual@arm.com>
 <20240125094119.2542332-6-anshuman.khandual@arm.com>
 <f30f3b77-0c72-49ab-8d30-48ba642ba0e8@arm.com>
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <f30f3b77-0c72-49ab-8d30-48ba642ba0e8@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 1/29/24 17:50, Suzuki K Poulose wrote:
> On 25/01/2024 09:41, Anshuman Khandual wrote:
>> Disable the BRBE before we enter the guest, saving the status and enable it
>> back once we get out of the guest. This avoids capturing branch records in
>> the guest kernel or userspace, which would be confusing the host samples.
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
>> Changes in V16:
>>
>> - Dropped BRBCR_EL1 and BRBFCR_EL1 from enum vcpu_sysreg
>> - Reverted back the KVM NVHE patch - used host_debug_state based 'brbcr_el1'
>>    element, and dropped the previous dependency on Jame's coresight series
>>
>>   arch/arm64/include/asm/kvm_host.h  |  5 ++++-
>>   arch/arm64/kvm/debug.c             |  5 +++++
>>   arch/arm64/kvm/hyp/nvhe/debug-sr.c | 33 ++++++++++++++++++++++++++++++
>>   3 files changed, 42 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
>> index 21c57b812569..bce8792092af 100644
>> --- a/arch/arm64/include/asm/kvm_host.h
>> +++ b/arch/arm64/include/asm/kvm_host.h
>> @@ -569,7 +569,7 @@ struct kvm_vcpu_arch {
>>       u8 cflags;
>>         /* Input flags to the hypervisor code, potentially cleared after use */
>> -    u8 iflags;
>> +    u16 iflags;
>>         /* State flags for kernel bookkeeping, unused by the hypervisor code */
>>       u8 sflags;
>> @@ -610,6 +610,7 @@ struct kvm_vcpu_arch {
>>           u64 pmscr_el1;
>>           /* Self-hosted trace */
>>           u64 trfcr_el1;
>> +        u64 brbcr_el1;
>>       } host_debug_state;
>>         /* VGIC state */
>> @@ -779,6 +780,8 @@ struct kvm_vcpu_arch {
>>   #define DEBUG_STATE_SAVE_TRBE    __vcpu_single_flag(iflags, BIT(6))
>>   /* vcpu running in HYP context */
>>   #define VCPU_HYP_CONTEXT    __vcpu_single_flag(iflags, BIT(7))
>> +/* Save BRBE context if active  */
>> +#define DEBUG_STATE_SAVE_BRBE    __vcpu_single_flag(iflags, BIT(8))
>>     /* SVE enabled for host EL0 */
>>   #define HOST_SVE_ENABLED    __vcpu_single_flag(sflags, BIT(0))
>> diff --git a/arch/arm64/kvm/debug.c b/arch/arm64/kvm/debug.c
>> index 8725291cb00a..99f85d8acbf3 100644
>> --- a/arch/arm64/kvm/debug.c
>> +++ b/arch/arm64/kvm/debug.c
>> @@ -335,10 +335,15 @@ void kvm_arch_vcpu_load_debug_state_flags(struct kvm_vcpu *vcpu)
>>       if (cpuid_feature_extract_unsigned_field(dfr0, ID_AA64DFR0_EL1_TraceBuffer_SHIFT) &&
>>           !(read_sysreg_s(SYS_TRBIDR_EL1) & TRBIDR_EL1_P))
>>           vcpu_set_flag(vcpu, DEBUG_STATE_SAVE_TRBE);
>> +
>> +    /* Check if we have BRBE implemented and available at the host */
>> +    if (cpuid_feature_extract_unsigned_field(dfr0, ID_AA64DFR0_EL1_BRBE_SHIFT))
>> +        vcpu_set_flag(vcpu, DEBUG_STATE_SAVE_BRBE);
>>   }
>>     void kvm_arch_vcpu_put_debug_state_flags(struct kvm_vcpu *vcpu)
>>   {
>>       vcpu_clear_flag(vcpu, DEBUG_STATE_SAVE_SPE);
>>       vcpu_clear_flag(vcpu, DEBUG_STATE_SAVE_TRBE);
>> +    vcpu_clear_flag(vcpu, DEBUG_STATE_SAVE_BRBE);
>>   }
>> diff --git a/arch/arm64/kvm/hyp/nvhe/debug-sr.c b/arch/arm64/kvm/hyp/nvhe/debug-sr.c
>> index 4558c02eb352..79bcf0fb1326 100644
>> --- a/arch/arm64/kvm/hyp/nvhe/debug-sr.c
>> +++ b/arch/arm64/kvm/hyp/nvhe/debug-sr.c
>> @@ -79,6 +79,34 @@ static void __debug_restore_trace(u64 trfcr_el1)
>>       write_sysreg_s(trfcr_el1, SYS_TRFCR_EL1);
>>   }
>>   +static void __debug_save_brbe(u64 *brbcr_el1)
>> +{
>> +    *brbcr_el1 = 0;
>> +
>> +    /* Check if the BRBE is enabled */
>> +    if (!(read_sysreg_s(SYS_BRBCR_EL1) & (BRBCR_ELx_E0BRE | BRBCR_ELx_ExBRE)))
>> +        return;
>> +
>> +    /*
>> +     * Prohibit branch record generation while we are in guest.
>> +     * Since access to BRBCR_EL1 is trapped, the guest can't
>> +     * modify the filtering set by the host.
>> +     */
>> +    *brbcr_el1 = read_sysreg_s(SYS_BRBCR_EL1);
>> +    write_sysreg_s(0, SYS_BRBCR_EL1);
>> +    isb();
> 
> Is this isb() required here ? This can be synchronised with the Guest entry ?
> 
>> +}
>> +
>> +static void __debug_restore_brbe(u64 brbcr_el1)
>> +{
>> +    if (!brbcr_el1)
>> +        return;
>> +
>> +    /* Restore BRBE controls */
>> +    write_sysreg_s(brbcr_el1, SYS_BRBCR_EL1);
>> +    isb();
> 
> Similarly here, exit back to EL1 host can synchronise the setting ?

Sure, will drop both the isb() here.

