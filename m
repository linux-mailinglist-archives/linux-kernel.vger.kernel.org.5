Return-Path: <linux-kernel+bounces-86940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35B4686CD4C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 16:43:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66D2B1C22034
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 15:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D388314A4CF;
	Thu, 29 Feb 2024 15:43:32 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83E9D14A089;
	Thu, 29 Feb 2024 15:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709221412; cv=none; b=RyOyNLk0OSMEpKrHBcKx5rqguDsLq5qvAhbCxC1YpeMedsQjSm5cjNg8iLSfPUJc+RuOJ+uyZAlrTGXXU3fJCewnS9zmipe+7nu1OBQrTJZK6zaQ+eXFc59DHEQasNDjvjEftUjYV01S8qk9g45SMOoah8ycRdNv+348q7zbokk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709221412; c=relaxed/simple;
	bh=VwlMZVqyzIQ7HwzKaB0DOVora1ocbFGWaqk1VMNGMPc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PdzMy3XxK0D7V1DmbbHldixVQeWxCA0EdAJsgZmkJ2g6QUTltvva+/fo+nHqPe0c7VepY52mq995nthlwpeOQhwk/YfCKWp9AF7tnSQf0GZxEsYD6PAc/K14Rc5ipg/G7BciYA+dRX0a2lV6n5eWu60vbuQFK4RJUNLY3kGxgjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 58D221FB;
	Thu, 29 Feb 2024 07:44:07 -0800 (PST)
Received: from [10.57.51.9] (unknown [10.57.51.9])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0F5F43F6C4;
	Thu, 29 Feb 2024 07:43:25 -0800 (PST)
Message-ID: <57994888-f82f-4d2b-a7e1-8dfed825533f@arm.com>
Date: Thu, 29 Feb 2024 15:43:24 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V16 2/8] KVM: arm64: Prevent guest accesses into BRBE
 system registers/instructions
Content-Language: en-GB
To: Mark Rutland <mark.rutland@arm.com>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 will@kernel.org, catalin.marinas@arm.com, Mark Brown <broonie@kernel.org>,
 James Clark <james.clark@arm.com>, Rob Herring <robh@kernel.org>,
 Marc Zyngier <maz@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 linux-perf-users@vger.kernel.org, Oliver Upton <oliver.upton@linux.dev>,
 James Morse <james.morse@arm.com>, kvmarm@lists.linux.dev
References: <20240125094119.2542332-1-anshuman.khandual@arm.com>
 <20240125094119.2542332-3-anshuman.khandual@arm.com>
 <ZdYCUi9YVDNDz7fr@FVFF77S0Q05N>
 <ab50e67e-3d06-4ba7-a5f8-4684e9ef98a4@arm.com>
 <Zd2zy0oUk8XvoDJM@FVFF77S0Q05N>
 <b134c30d-d855-41bb-a260-9f6437b77697@arm.com>
 <62e64ddd-266c-414e-b66a-8ca94f3c2bbf@arm.com>
 <ZeB9kHheAGJ__TQU@FVFF77S0Q05N>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <ZeB9kHheAGJ__TQU@FVFF77S0Q05N>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29/02/2024 12:50, Mark Rutland wrote:
> Hi Suzuki,
> 
> On Thu, Feb 29, 2024 at 11:45:08AM +0000, Suzuki K Poulose wrote:
>> On 27/02/2024 11:13, Anshuman Khandual wrote:
>>> On 2/27/24 15:34, Mark Rutland wrote:
>>>> On Fri, Feb 23, 2024 at 12:58:48PM +0530, Anshuman Khandual wrote:
>>>>> On 2/21/24 19:31, Mark Rutland wrote:
>>>>>> On Thu, Jan 25, 2024 at 03:11:13PM +0530, Anshuman Khandual wrote:
>>>>>>> Currently BRBE feature is not supported in a guest environment. This hides
>>>>>>> BRBE feature availability via masking ID_AA64DFR0_EL1.BRBE field.
>>>>>>
>>>>>> Does that means that a guest can currently see BRBE advertised in the
>>>>>> ID_AA64DFR0_EL1.BRB field, or is that hidden by the regular cpufeature code
>>>>>> today?
>>>>>
>>>>> IIRC it is hidden, but will have to double check. When experimenting for BRBE
>>>>> guest support enablement earlier, following changes were need for the feature
>>>>> to be visible in ID_AA64DFR0_EL1.
>>>>>
>>>>> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
>>>>> index 646591c67e7a..f258568535a8 100644
>>>>> --- a/arch/arm64/kernel/cpufeature.c
>>>>> +++ b/arch/arm64/kernel/cpufeature.c
>>>>> @@ -445,6 +445,7 @@ static const struct arm64_ftr_bits ftr_id_mmfr0[] = {
>>>>>    };
>>>>>    static const struct arm64_ftr_bits ftr_id_aa64dfr0[] = {
>>>>> +       S_ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64DFR0_EL1_BRBE_SHIFT, 4, ID_AA64DFR0_EL1_BRBE_IMP),
>>>>>           S_ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64DFR0_EL1_DoubleLock_SHIFT, 4, 0),
>>>>>           ARM64_FTR_BITS(FTR_HIDDEN, FTR_NONSTRICT, FTR_LOWER_SAFE, ID_AA64DFR0_EL1_PMSVer_SHIFT, 4, 0),
>>>>>           ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64DFR0_EL1_CTX_CMPs_SHIFT, 4, 0),
>>>>>
>>>>> Should we add the following entry - explicitly hiding BRBE from the guest
>>>>> as a prerequisite patch ?
>>
>> This has nothing to do with the Guest visibility of the BRBE. This is
>> specifically for host "userspace" (via MRS emulation).
>>
>>>>>
>>>>> S_ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64DFR0_EL1_BRBE_SHIFT, 4, ID_AA64DFR0_EL1_BRBE_NI)
>>>>
>>>> Is it visbile currently, or is it hidden currently?
>>>>
>>>> * If it is visible before this patch, that's a latent bug that we need to go
>>>>     fix first, and that'll require more coordination.
>>>>
>>>> * If it is not visible before this patch, there's no problem in the code, but
>>>>     the commit message needs to explicitly mention that's the case as the commit
>>>>     message currently implies it is visible by only mentioning hiding it.
>>>>
>>>> ... so can you please double check as you suggested above? We should be able to
>>>> explain why it is or is not visible today.
>>>
>>> It is currently hidden i.e following code returns 1 in the host
>>> but returns 0 inside the guest.
>>>
>>> aa64dfr0 = read_sysreg_s(SYS_ID_AA64DFR0_EL1);
>>> brbe = cpuid_feature_extract_unsigned_field(aa64dfr0, ID_AA64DFR0_EL1_BRBE_SHIFT);
>>>
>>> Hence - will update the commit message here as suggested.
>>
>> This is by virtue of the masking we do in the kvm/sysreg.c below.
> 
> Yep, once this patch is applied.
> 
> I think we might have some crossed wires here; I'm only really asking for the
> commit message (and title) to be updated and clarified.
> 
> Ignoring the patchlet above, and just considering the original patch:
> 
> IIUC before the patch is applied, the ID_AA64DFR0_EL1.BRBE field is zero for
> the guest because we don't have an arm64_ftr_bits entry for the
> ID_AA64DFR0_EL1.BRBE field, and so init_cpu_ftr_reg() will leave that as zero
> in arm64_ftr_reg::sys_val, and hence when read_sanitised_id_aa64dfr0_el1()
> calls read_sanitised_ftr_reg(SYS_ID_AA64DFR0_EL1), the BRBE field will be zero.
> 
> This series as-is doesn't add an arm64_ftr_bits entry for ID_AA64DFR0_EL1.BRBE,
> so it'd still be hidden from a guest regardless of whether we add explicit
> masking in read_sanitised_id_aa64dfr0_el1(). The reason to add that masking is
> to be explicit, so that if/when we add an arm64_ftr_bits entry for
> ID_AA64DFR0_EL1.BRBE, it isn't exposed to a guest unexpectedly.
> 
> Similarly, IIUC the BRBE register accesses are *already* trapped, and
> emulate_sys_reg() will log a warning an inject an UNDEFINED exception into the
> guest if the guest tries to access the BRBE registers. Any well-behaved guest
> *shouldn't* do that, but a poorly-behaved guest could do that and (slowly) spam
> dmesg with messages about the unhandled sysreg traps. The reasons to handle
> thos regs is largely to suppress that warning, and to make it clear that we
> intend for those to be handled as undef.
> 
> So the commit title should be something like:
> 
>    KVM: arm64: explicitly handle BRBE register accesses as UNDEFINED
> 
> ... and the message should mention the key points from the above.
> 
> Suzuki, does that sound right to you?

Yes, that makes perfect sense to me. Thanks for clarifying

Suzuki

> 
> Anshuman, can you go re-write the commit message with that in mind?
> 
> Mark.


