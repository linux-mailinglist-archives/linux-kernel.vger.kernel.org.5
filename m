Return-Path: <linux-kernel+bounces-87836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3232886D9A4
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 03:24:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0DC6281AA4
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 02:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA45B3AC12;
	Fri,  1 Mar 2024 02:21:06 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CACE13A8DE;
	Fri,  1 Mar 2024 02:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709259666; cv=none; b=WaPrmfJMZbqgoCNayRFbDtghB6+VFWAeEYI3Mt5wQT2RMSQblRLrn8EjbX3G7qrjZm9/l/mI+ie76Ey12vYuOEOL91FqdFNfvNi+znvWUjg3eIRUg/AXZRlsw8Z+UbNvglmJN4WHAOCgLKhzab+I2Me8IDW+CjS6XQDagbAUivc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709259666; c=relaxed/simple;
	bh=lDcV+UIK2UmQdtVQx2J9DB22Eek2v9YcVzkNvM9HlEo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qv88LqYx2esdpqgBxqCn7gYky2mMQgaS2taMDFzTZM7U6+AHfmTnxScgwkyRPLRp/SwFGpuiat8Tw54FdrC0kv1OU8mXn5dMBuhDR4GR5AJ5f825h/Pr7gU3F5lqhp9o+iMtySXDMy/xwO8tUgkAH13DymbpbD0VZNfTmFnR8U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 262C51FB;
	Thu, 29 Feb 2024 18:21:34 -0800 (PST)
Received: from [10.162.42.8] (a077893.blr.arm.com [10.162.42.8])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B5CB43F762;
	Thu, 29 Feb 2024 18:20:50 -0800 (PST)
Message-ID: <2adf726f-5a94-4e4f-85de-db30e1586584@arm.com>
Date: Fri, 1 Mar 2024 07:50:47 +0530
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
To: Marc Zyngier <maz@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 will@kernel.org, catalin.marinas@arm.com, mark.rutland@arm.com,
 Mark Brown <broonie@kernel.org>, James Clark <james.clark@arm.com>,
 Rob Herring <robh@kernel.org>, Suzuki Poulose <suzuki.poulose@arm.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 linux-perf-users@vger.kernel.org, Oliver Upton <oliver.upton@linux.dev>,
 James Morse <james.morse@arm.com>, kvmarm@lists.linux.dev
References: <20240125094119.2542332-1-anshuman.khandual@arm.com>
 <20240125094119.2542332-6-anshuman.khandual@arm.com>
 <8634tb2jwp.wl-maz@kernel.org>
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <8634tb2jwp.wl-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/1/24 00:10, Marc Zyngier wrote:
> On Thu, 25 Jan 2024 09:41:16 +0000,
> Anshuman Khandual <anshuman.khandual@arm.com> wrote:
>>
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
>>   element, and dropped the previous dependency on Jame's coresight series
>>
>>  arch/arm64/include/asm/kvm_host.h  |  5 ++++-
>>  arch/arm64/kvm/debug.c             |  5 +++++
>>  arch/arm64/kvm/hyp/nvhe/debug-sr.c | 33 ++++++++++++++++++++++++++++++
>>  3 files changed, 42 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
>> index 21c57b812569..bce8792092af 100644
>> --- a/arch/arm64/include/asm/kvm_host.h
>> +++ b/arch/arm64/include/asm/kvm_host.h
>> @@ -569,7 +569,7 @@ struct kvm_vcpu_arch {
>>  	u8 cflags;
>>  
>>  	/* Input flags to the hypervisor code, potentially cleared after use */
>> -	u8 iflags;
>> +	u16 iflags;
>>  
>>  	/* State flags for kernel bookkeeping, unused by the hypervisor code */
>>  	u8 sflags;
>> @@ -610,6 +610,7 @@ struct kvm_vcpu_arch {
>>  		u64 pmscr_el1;
>>  		/* Self-hosted trace */
>>  		u64 trfcr_el1;
>> +		u64 brbcr_el1;
>>  	} host_debug_state;
>>  
>>  	/* VGIC state */
>> @@ -779,6 +780,8 @@ struct kvm_vcpu_arch {
>>  #define DEBUG_STATE_SAVE_TRBE	__vcpu_single_flag(iflags, BIT(6))
>>  /* vcpu running in HYP context */
>>  #define VCPU_HYP_CONTEXT	__vcpu_single_flag(iflags, BIT(7))
>> +/* Save BRBE context if active  */
>> +#define DEBUG_STATE_SAVE_BRBE	__vcpu_single_flag(iflags, BIT(8))
>>  
>>  /* SVE enabled for host EL0 */
>>  #define HOST_SVE_ENABLED	__vcpu_single_flag(sflags, BIT(0))
>> diff --git a/arch/arm64/kvm/debug.c b/arch/arm64/kvm/debug.c
>> index 8725291cb00a..99f85d8acbf3 100644
>> --- a/arch/arm64/kvm/debug.c
>> +++ b/arch/arm64/kvm/debug.c
>> @@ -335,10 +335,15 @@ void kvm_arch_vcpu_load_debug_state_flags(struct kvm_vcpu *vcpu)
>>  	if (cpuid_feature_extract_unsigned_field(dfr0, ID_AA64DFR0_EL1_TraceBuffer_SHIFT) &&
>>  	    !(read_sysreg_s(SYS_TRBIDR_EL1) & TRBIDR_EL1_P))
>>  		vcpu_set_flag(vcpu, DEBUG_STATE_SAVE_TRBE);
>> +
>> +	/* Check if we have BRBE implemented and available at the host */
>> +	if (cpuid_feature_extract_unsigned_field(dfr0, ID_AA64DFR0_EL1_BRBE_SHIFT))
>> +		vcpu_set_flag(vcpu, DEBUG_STATE_SAVE_BRBE);
>>  }
>>  
>>  void kvm_arch_vcpu_put_debug_state_flags(struct kvm_vcpu *vcpu)
>>  {
>>  	vcpu_clear_flag(vcpu, DEBUG_STATE_SAVE_SPE);
>>  	vcpu_clear_flag(vcpu, DEBUG_STATE_SAVE_TRBE);
>> +	vcpu_clear_flag(vcpu, DEBUG_STATE_SAVE_BRBE);
>>  }
>> diff --git a/arch/arm64/kvm/hyp/nvhe/debug-sr.c b/arch/arm64/kvm/hyp/nvhe/debug-sr.c
>> index 4558c02eb352..79bcf0fb1326 100644
>> --- a/arch/arm64/kvm/hyp/nvhe/debug-sr.c
>> +++ b/arch/arm64/kvm/hyp/nvhe/debug-sr.c
>> @@ -79,6 +79,34 @@ static void __debug_restore_trace(u64 trfcr_el1)
>>  	write_sysreg_s(trfcr_el1, SYS_TRFCR_EL1);
>>  }
>>  
>> +static void __debug_save_brbe(u64 *brbcr_el1)
>> +{
>> +	*brbcr_el1 = 0;
>> +
>> +	/* Check if the BRBE is enabled */
>> +	if (!(read_sysreg_s(SYS_BRBCR_EL1) & (BRBCR_ELx_E0BRE | BRBCR_ELx_ExBRE)))
>> +		return;
>> +
>> +	/*
>> +	 * Prohibit branch record generation while we are in guest.
>> +	 * Since access to BRBCR_EL1 is trapped, the guest can't
>> +	 * modify the filtering set by the host.
>> +	 */
>> +	*brbcr_el1 = read_sysreg_s(SYS_BRBCR_EL1);
>> +	write_sysreg_s(0, SYS_BRBCR_EL1);
> 
> As for TRFCR and PMSCR, this is broken on hVHE.
> 
> Please see [1]
> 
> 	M.
> 
> [1] https://lore.kernel.org/r/20240229145417.3606279-1-maz@kernel.org
> 

Ahh I see, so the unified accessors read_sysreg_el1()/write_sysreg_el1()
need to be used here - which will choose between BRBCR_EL1 & BRBCR_EL12
as required. Will do the changes, thanks for pointing out.

