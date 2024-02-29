Return-Path: <linux-kernel+bounces-86354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB5CC86C450
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 09:56:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF98B1C2169C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 08:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7F2055C05;
	Thu, 29 Feb 2024 08:56:08 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8842C54BFC;
	Thu, 29 Feb 2024 08:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709196967; cv=none; b=akYYrDujQX/u1aB7hIVdANXWmzcoK27DaMzoq5uzSDiGwbpzdWKva6bteMP8pwYwYDlCt1X8CG4Q47v4P84z1RevNxyhrpVpWSfi1oxreFErs5YPklSbQ3tR+R7Dh7wj5ELEeV0Y8MQzgHhAr/DJTXd8IwPmEw8BWEjeSqBwJQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709196967; c=relaxed/simple;
	bh=kfnakJ2LhbIuc1MYqpnklalb+//KhlmKSZbOZPastVE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W2N21jVflCvDHmvBeauc9diA5iJL2v3ZdK1i43zkPb0yD5C7JKyZrGoDoQY7Im2A3cRbgSJp00YNGPsPI05fD8AlTwPbEPKM6qd3Ob/R2cvoXGT48xxnKyb4VlDyb2d0Z+lfLxkRRs7WDFELHj/N9lo8pIXK7TWFIoUjl/szhpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 460461FB;
	Thu, 29 Feb 2024 00:56:43 -0800 (PST)
Received: from [10.163.47.238] (unknown [10.163.47.238])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EC5B73F6C4;
	Thu, 29 Feb 2024 00:55:59 -0800 (PST)
Message-ID: <feecbdd3-155a-4b95-8366-403637fd73d5@arm.com>
Date: Thu, 29 Feb 2024 14:25:57 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V16 4/8] drivers: perf: arm_pmuv3: Enable branch stack
 sampling via FEAT_BRBE
Content-Language: en-US
To: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 will@kernel.org, catalin.marinas@arm.com, Mark Brown <broonie@kernel.org>,
 James Clark <james.clark@arm.com>, Rob Herring <robh@kernel.org>,
 Marc Zyngier <maz@kernel.org>, Suzuki Poulose <suzuki.poulose@arm.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, linux-perf-users@vger.kernel.org
References: <20240125094119.2542332-1-anshuman.khandual@arm.com>
 <20240125094119.2542332-5-anshuman.khandual@arm.com>
 <ZdY_oEYPGSj7nwvP@FVFF77S0Q05N>
 <781dd6a8-cf18-48ab-93f3-5256d161b359@arm.com>
 <Zd8eYHbLebKLV648@FVFF77S0Q05N>
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <Zd8eYHbLebKLV648@FVFF77S0Q05N>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/28/24 17:22, Mark Rutland wrote:
> On Wed, Feb 28, 2024 at 01:41:05PM +0530, Anshuman Khandual wrote:
>> On 2/21/24 23:53, Mark Rutland wrote:
>>> On Thu, Jan 25, 2024 at 03:11:15PM +0530, Anshuman Khandual wrote:
> 
>>>> +============================================
>>>> +Branch Record Buffer Extension aka FEAT_BRBE
>>>> +============================================
>>>> +
>>>> +Author: Anshuman Khandual <anshuman.khandual@arm.com>
>>>> +
>>>> +FEAT_BRBE is an optional architecture feature, which creates branch records
>>>> +containing information about change in control flow. The branch information
>>>> +contains source address, target address, and some relevant metadata related
>>>> +to that change in control flow. BRBE can be configured to filter out branch
>>>> +records based on their type and privilege level.
>>>
>>> Do we actually need this documentation?
>>
>> IMHO we do need some documentation.
>>
>>> The set of peopl writing kernel code can read the ARM ARM or the kernel code,
>>> and there's not much here useful to users.
>>
>> But not all documentation write ups in the kernel are only for the users, there
>> are examples in many subsystems where documentations help explain implementation
>> details including data structures and function flows, for upcoming developers to
>> understand the code better and make further improvements.
> 
> Sure, but that's for things where there are *many* kernel developers that will
> consume this. The set of people who will modify the BRBE code in a meaningful
> way can be counted on a hand or two, and so I don't think there's a need or
> justification for having this detail under Documentation/.

Understood.

> 
>>> I think it may make sense to document what userspace and/or VMs can and cannot
>>> do (which is why we describe the ID registers), and any 'gotchas' (e.g.
>>> restrictions we have that other architectures don't, or vice-versa). I do not
>>
>> Agreed - such documentations must be included for better technology adoption, but
>> those are not the only type of documentation available in the kernel - even right
>> now.
>>
>>> think that we should try to describe the hardware beyond what is necessary to
>>> describe that, and I do not think that we should describe the structure of the
>>> perf code beyond what is necessary to desribe that.
>>>
>>> Otherwise, this is just a maintenance burden
>>
>> I think we should have some documentation for BRBE implementation, and if there
>> are suggestions to improve the proposed one, will be happy to change. But for
>> now, will try and rewrite the documentation with your above suggestions in mind.
> 
> I think that any documentation on the implementation details should be within
> the driver itself; please limit anything under Documentation/ to be on details
> relevant to userspace.

Understood.

> 
> [...]
> 
>> I believe the proposed code is already well documented but will revisit and
>> try to fill gaps if any but the point being in code documentation might not
>> be a substitute for a Documentation/arch/arm64/ based file.
> 
> For the moment I'm not asking that you add new comments to the BRBE code, so
> please don't feel like you need to add anything there. I'm only asking that you
> limit the Documentation/ coverage to details which are directly relevant to
> userspace.

BRBE enables perf branch stack sampling here, hence all user space related
documentation should be done for the generic perf itself, unless there are
arm64 specific things such as unsupported branch filters, any rationale for
mapping the captured platform branch types into generic branch types etc. I
will look into the Documentation/arch/arm64/brbe.rst requirement with this
perspective, and get back with a new write up.

> 
>>
>>>
>>> [...]
>>>
>>>> diff --git a/arch/arm64/include/asm/el2_setup.h b/arch/arm64/include/asm/el2_setup.h
>>>> index b7afaa026842..649b926bf69d 100644
>>>> --- a/arch/arm64/include/asm/el2_setup.h
>>>> +++ b/arch/arm64/include/asm/el2_setup.h
>>>> @@ -154,6 +154,51 @@
>>>>  .Lskip_set_cptr_\@:
>>>>  .endm
>>>>  
>>>> +#ifdef CONFIG_ARM64_BRBE
>>>> +/*
>>>> + * Enable BRBE cycle count
>>>> + *
>>>> + * BRBE requires both BRBCR_EL1.CC and BRBCR_EL2.CC fields, be set
>>>> + * for the cycle counts to be available in BRBINF<N>_EL1.CC during
>>>> + * branch record processing after a PMU interrupt. This enables CC
>>>> + * field on both these registers while still executing inside EL2.
>>>> + *
>>>> + * BRBE driver would still be able to toggle branch records cycle
>>>> + * count support via BRBCR_EL1.CC field regardless of whether the
>>>> + * kernel ends up executing in EL1 or EL2.
>>>> + */
>>>> +.macro __init_el2_brbe
>>>> +	mrs	x1, id_aa64dfr0_el1
>>>> +	ubfx	x1, x1, #ID_AA64DFR0_EL1_BRBE_SHIFT, #4
>>>> +	cbz	x1, .Lskip_brbe_cc_\@
>>>> +
>>>> +	mrs_s	x0, SYS_BRBCR_EL2
>>>> +	orr	x0, x0, BRBCR_ELx_CC
>>>> +	msr_s	SYS_BRBCR_EL2, x0
>>>
>>> Please initialise this to a specific value rather than using a
>>> read-modify-write.
>>
>> I will change this as follows - which will be written into both BRBCR_EL2
>> and BRBCR_EL12 registers as applicable.
>>
>>         mov     x0, xzr
>>         orr     x0, x0, #(BRBCR_ELx_CC |BRBCR_ELx_MPRED)
> 
> Please generate the value directly, and only use ORR for bits that need to be
> conditionally set, e.g. the above can be:
> 
> 	mov_q	x0, #(BRBCR_ELx_CC | BRBCR_ELx_MPRED)
> 	msr_s	SYS_BRBCR_EL2, x0

Okay, will change as suggested above.

> 
> [...]
> 
>>>> +/*
>>>> + * A branch record with BRBINFx_EL1.LASTFAILED set, implies that all
>>>> + * preceding consecutive branch records, that were in a transaction
>>>> + * (i.e their BRBINFx_EL1.TX set) have been aborted.
>>>> + *
>>>> + * Similarly BRBFCR_EL1.LASTFAILED set, indicate that all preceding
>>>> + * consecutive branch records up to the last record, which were in a
>>>> + * transaction (i.e their BRBINFx_EL1.TX set) have been aborted.
>>>> + *
>>>> + * --------------------------------- -------------------
>>>> + * | 00 | BRBSRC | BRBTGT | BRBINF | | TX = 1 | LF = 0 | [TX success]
>>>> + * --------------------------------- -------------------
>>>> + * | 01 | BRBSRC | BRBTGT | BRBINF | | TX = 1 | LF = 0 | [TX success]
>>>> + * --------------------------------- -------------------
>>>> + * | 02 | BRBSRC | BRBTGT | BRBINF | | TX = 0 | LF = 0 |
>>>> + * --------------------------------- -------------------
>>>> + * | 03 | BRBSRC | BRBTGT | BRBINF | | TX = 1 | LF = 0 | [TX failed]
>>>> + * --------------------------------- -------------------
>>>> + * | 04 | BRBSRC | BRBTGT | BRBINF | | TX = 1 | LF = 0 | [TX failed]
>>>> + * --------------------------------- -------------------
>>>> + * | 05 | BRBSRC | BRBTGT | BRBINF | | TX = 0 | LF = 1 |
>>>> + * --------------------------------- -------------------
>>>> + * | .. | BRBSRC | BRBTGT | BRBINF | | TX = 0 | LF = 0 |
>>>> + * --------------------------------- -------------------
>>>> + * | 61 | BRBSRC | BRBTGT | BRBINF | | TX = 1 | LF = 0 | [TX failed]
>>>> + * --------------------------------- -------------------
>>>> + * | 62 | BRBSRC | BRBTGT | BRBINF | | TX = 1 | LF = 0 | [TX failed]
>>>> + * --------------------------------- -------------------
>>>> + * | 63 | BRBSRC | BRBTGT | BRBINF | | TX = 1 | LF = 0 | [TX failed]
>>>> + * --------------------------------- -------------------
>>>> + *
>>>> + * BRBFCR_EL1.LASTFAILED == 1
>>>> + *
>>>> + * BRBFCR_EL1.LASTFAILED fails all those consecutive, in transaction
>>>> + * branches records near the end of the BRBE buffer.
>>>> + *
>>>> + * Architecture does not guarantee a non transaction (TX = 0) branch
>>>> + * record between two different transactions. So it is possible that
>>>> + * a subsequent lastfailed record (TX = 0, LF = 1) might erroneously
>>>> + * mark more than required transactions as aborted.
>>>> + */
>>>> +static void process_branch_aborts(struct pmu_hw_events *cpuc)
>>>> +{
>>>> +	u64 brbfcr = read_sysreg_s(SYS_BRBFCR_EL1);
>>>> +	bool lastfailed = !!(brbfcr & BRBFCR_EL1_LASTFAILED);
>>>> +	int idx = brbe_get_numrec(cpuc->percpu_pmu->reg_brbidr) - 1;
>>>> +	struct perf_branch_entry *entry;
>>>> +
>>>> +	do {
>>>> +		entry = &cpuc->branches->branch_entries[idx];
>>>> +		if (entry->in_tx) {
>>>> +			entry->abort = lastfailed;
>>>> +		} else {
>>>> +			lastfailed = entry->abort;
>>>> +			entry->abort = false;
>>>> +		}
>>>> +	} while (idx--, idx >= 0);
>>>> +}
>>>
>>> Please consider:
>>>
>>> 1) There are no extant CPU implementations with TME.
>>> 2) There are no plans for anyone to build TME.
>>> 3) The kernel doesn't support TME.
>>>
>>> ... so why are we tryting to handle this architectural edge-case (complete with
>>> what is arguably an architectural bug!) that can only happen on a CPU with TME,
>>> under a kernel that's using TME?
>>>
>>> This cannot possibly have been tested, trivially by point 3.
>>>
>>> This is purely a maintenance and review burden.
>>>
>>> Please delete this and replace it with a comment somewhere that *if* we ever
>>> add support for TME this will need to be handled somehow.
>>
>> Alright, will drop TME handling completely.
>>
>> - Dropped process_branch_aborts() completely
>>
>> - Added an warning if transaction states get detected some how unexpectedly
>>
>>                 /*
>>                  * Currently TME feature is neither implemented in any hardware
>>                  * nor it is being supported in the kernel. Just warn here once
>>                  * if TME related information shows up rather unexpectedly.
>>                  */
>>                 if (entry->abort || entry->in_tx)
>>                         pr_warn_once("Unknown transaction states %d %d\n",
>>                                       entry->abort, entry->in_tx);
> 
> Something of that shape sounds good; thanks!

Understood.

