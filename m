Return-Path: <linux-kernel+bounces-146286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F2168A6336
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 07:46:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 238AB2868C2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 05:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FE5B3BB23;
	Tue, 16 Apr 2024 05:46:25 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B7083C060
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 05:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713246384; cv=none; b=a2tyk9I0BQ5EpKyETEfGxTFTikELoJjmbeL4Cn9WT3DREFK4rwIM1eeov89I9lNsrSg4u0zeGfaot3zlIqdndzX4gJmTaGmtRQ5mJXcj69m0tiJLEvNtgP3n7dhGomvkdk8KiJdpdCIYD3DKM4AMZupY7hIxB6VFtH113j+EtLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713246384; c=relaxed/simple;
	bh=8yi+iAcNQsOCEWwn+oeKCc87Tp/mRYW3yWJYh+YDXMU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PZN8+twsTQvrWm7F6Y2KEmH9coyf/47r/oV7Wj69mdDGGQuS0FEzouVw+idbCf3QeJj5yd0HlrhHpfloyjYR0PG2I7tfJQYOeBhpKlz64OEqEsjAPeYPokvUoxsXihYPKkRs5nmisZn4s9Ez9605ySzBRffqRHsoJT6uMYHNRb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2BB132F4;
	Mon, 15 Apr 2024 22:46:49 -0700 (PDT)
Received: from [10.163.59.235] (unknown [10.163.59.235])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F16D23F792;
	Mon, 15 Apr 2024 22:46:15 -0700 (PDT)
Message-ID: <58cdb927-a2d9-4af4-900f-2132472afe9f@arm.com>
Date: Tue, 16 Apr 2024 11:16:13 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 5/8] KVM: arm64: Explicitly handle MDSELR_EL1 traps as
 UNDEFINED
Content-Language: en-US
To: Marc Zyngier <maz@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, Jonathan Corbet <corbet@lwn.net>,
 Oliver Upton <oliver.upton@linux.dev>, James Morse <james.morse@arm.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Mark Brown <broonie@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240405080008.1225223-1-anshuman.khandual@arm.com>
 <20240405080008.1225223-6-anshuman.khandual@arm.com>
 <86a5m8t8s6.wl-maz@kernel.org> <5a2a74b3-f6cd-4cb6-8ee8-5dd7dc2bd686@arm.com>
 <86mspysuw8.wl-maz@kernel.org>
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <86mspysuw8.wl-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/12/24 16:35, Marc Zyngier wrote:
> On Fri, 12 Apr 2024 03:41:23 +0100,
> Anshuman Khandual <anshuman.khandual@arm.com> wrote:
>>
>>
>>
>> On 4/5/24 15:45, Marc Zyngier wrote:
>>> On Fri, 05 Apr 2024 09:00:05 +0100,
>>> Anshuman Khandual <anshuman.khandual@arm.com> wrote:
>>>>
>>>> Currently read_sanitised_id_aa64dfr0_el1() caps the ID_AA64DFR0.DebugVer to
>>>> ID_AA64DFR0_DebugVer_V8P8, resulting in FEAT_Debugv8p9 not being exposed to
>>>> the guest. MDSELR_EL1 register access in the guest, is currently trapped by
>>>> the existing configuration of the fine-grained traps.
>>>
>>> Please add support for the HDFGxTR2_EL2 registers in the trap routing
>>> arrays, add support for the corresponding FGUs in the corresponding
>>
>> Afraid that I might not have enough background here to sufficiently understand
>> your suggestion above, but nonetheless here is an attempt in this regard.
> 
> Thanks for at least giving it a try, this is *MUCH* appreciated.
> 
>>
>> - Add HDFGRTR2_EL2/HDFGWTR2_EL2 to enum vcpu_sysreg
>> 	enum vcpu_sysreg {
>> 		..........
>> 		VNCR(HDFGRTR2_EL2),
>> 		VNCR(HDFGWTR2_EL2),
>> 		..........
>> 	}
> 
> Yes.
> 
>>
>> - Add their VNCR mappings addresses
>>
>> 	#define VNCR_HDFGRTR2_EL2      0x1A0
>> 	#define VNCR_HDFGWTR2_EL2      0x1B0
> 
> Yes.
> 
>>
>> - Add HDFGRTR2_EL2/HDFGWTR2_EL2 to sys_reg_descs[]
>>
>> static const struct sys_reg_desc sys_reg_descs[] = {
>> 	..........
>> 	EL2_REG_VNCR(HDFGRTR2_EL2, reset_val, 0),
>> 	EL2_REG_VNCR(HDFGWTR2_EL2, reset_val, 0),
>> 	..........
>> }
> 
> Yes
> 
>>
>> - Add HDFGRTR2_GROUP to enum fgt_group_id
>> - Add HDFGRTR2_GROUP to reg_to_fgt_group_id()
>> - Update triage_sysreg_trap() for HDFGRTR2_GROUP
>> - Update __activate_traps_hfgxtr() both for HDFGRTR2_EL2 and HDFGWTR2_EL2
>> - Updated __deactivate_traps_hfgxtr() both for HDFGRTR2_EL2 and HDFGWTR2_EL2
> 
> Yes. Don't miss check_fgt_bit() though.  You also need to update

Right, added the following in there.

       case HDFGRTR2_GROUP:
               sr = is_read ? HDFGRTR2_EL2 : HDFGWTR2_EL2;
               break;

> kvm_init_nv_sysregs() to ensure that these new registers have the
> correct RES0/RES1 behaviour depending on the supported feature set for
> the guest.

Following might be sufficient for MDSELR_EL1, but wondering if these fine
grained control registers (HDFG[RW]TR2_EL2) need to be completely defined
for the entire guest feature set, probably required.

       /* HDFG[RW]TR2_EL2 */
       res0 = res1 = 0;
       if (!kvm_has_feat(kvm, ID_AA64DFR0_EL1, DebugVer, V8P9))
               res0 |= HDFGRTR2_EL2_nMDSELR_EL1;
       set_sysreg_masks(kvm, HDFGRTR2_EL2, res0 | HDFGRTR2_EL2_RES0, res1);
       set_sysreg_masks(kvm, HDFGWTR2_EL2, res0 | HDFGWTR2_EL2_RES0, res1);

> 
>>
>>> structure, and condition the UNDEF on the lack of *guest* support for
>>> the feature.
>>
>> Does something like the following looks OK for preventing guest access into
>> MDSELR_EL1 instead ?
>>
>> --- a/arch/arm64/kvm/sys_regs.c
>> +++ b/arch/arm64/kvm/sys_regs.c
>> @@ -1711,6 +1711,19 @@ static u64 read_sanitised_id_aa64dfr0_el1(struct kvm_vcpu *vcpu,
>>         return val;
>>  }
>>  
>> +static bool trap_mdselr_el1(struct kvm_vcpu *vcpu,
>> +                          struct sys_reg_params *p,
>> +                          const struct sys_reg_desc *r)
>> +{
>> +       u64 dfr0 = read_sanitised_id_aa64dfr0_el1(vcpu, r);
>> +       int dver = cpuid_feature_extract_unsigned_field(dfr0, ID_AA64DFR0_EL1_DebugVer_SHIFT);
>> +
>> +       if (dver != ID_AA64DFR0_EL1_DebugVer_V8P9)
>> +               return undef_access(vcpu, p, r);
> 
> This is very cumbersome, and we now have a much better infrastructure
> for the stuff that is handled with FGTs, see below.

Okay

> 
>> +
>> +       return true;
>> +}
>> +
>>  static int set_id_aa64dfr0_el1(struct kvm_vcpu *vcpu,
>>                                const struct sys_reg_desc *rd,
>>                                u64 val)
>> @@ -2203,7 +2216,7 @@ static const struct sys_reg_desc sys_reg_descs[] = {
>>         { SYS_DESC(SYS_MDSCR_EL1), trap_debug_regs, reset_val, MDSCR_EL1, 0 },
>>         DBG_BCR_BVR_WCR_WVR_EL1(2),
>>         DBG_BCR_BVR_WCR_WVR_EL1(3),
>> -       { SYS_DESC(SYS_MDSELR_EL1), undef_access },
>> +       { SYS_DESC(SYS_MDSELR_EL1), trap_mdselr_el1 },
>>         DBG_BCR_BVR_WCR_WVR_EL1(4),
>>         DBG_BCR_BVR_WCR_WVR_EL1(5),
>>         DBG_BCR_BVR_WCR_WVR_EL1(6),
>>
>> I am sure this is rather incomplete, but will really appreciate if you could
>> provide some details and pointers.
> 
> What is missing is the Fine-Grained-Undef part. You need to update
> kvm_init_sysreg() so that kvm->arch.fgu[HDFGRTR2_GROUP] has all the
> correct bits set for anything that needs to UNDEF depending on the
> guest configuration.
> 
> For example, in your case, I'd expect to see something like:
> 
> if (!kvm_has_feat(kvm, ID_AA64DFR0_EL1, DebugVer, V8P9))
> 	kvm->arch.fgu[HDFGRTR2_GROUP] |= ~(HDFGRTR2_EL2_nMDSELR_EL1 | [...]);

Understood.

> 
> Then allowing the feature becomes conditioned on the bit being clear,
> and the trap handler only needs to deal with the actual emulation, and
> not the feature checking.

Got it.

> 
> I appreciate that this is a lot to swallow, but I'd be very happy to
> review patches implementing this and provide guidance. It is all
> pretty simple, just that there is a lot of parts all over the place.
> In the end, this is only about following the architecture.

Sure, will read through all these pointers you have mentioned here,
and be back with an implementation.

> 
> Thanks again,

Thanks for the detailed explanation.

> 
> 	M.
> 

