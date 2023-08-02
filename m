Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCFE676CD26
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 14:42:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234206AbjHBMmA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 08:42:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231641AbjHBMl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 08:41:58 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AC4492D7D;
        Wed,  2 Aug 2023 05:41:23 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B90B8113E;
        Wed,  2 Aug 2023 05:41:00 -0700 (PDT)
Received: from [10.57.89.109] (unknown [10.57.89.109])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 36A843F6C4;
        Wed,  2 Aug 2023 05:40:15 -0700 (PDT)
Message-ID: <6e8d5f13-865d-e39f-1e2e-96f2b447219b@arm.com>
Date:   Wed, 2 Aug 2023 13:40:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH V13 - RESEND 06/10] arm64/perf: Enable branch stack events
 via FEAT_BRBE
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Yang Shen <shenyang39@huawei.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        will@kernel.org, catalin.marinas@arm.com, mark.rutland@arm.com
Cc:     Mark Brown <broonie@kernel.org>, James Clark <james.clark@arm.com>,
        Rob Herring <robh@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-perf-users@vger.kernel.org
References: <20230711082455.215983-1-anshuman.khandual@arm.com>
 <20230711082455.215983-7-anshuman.khandual@arm.com>
 <5c7c1ff3-1e2a-1258-7fa0-c82a9ab62646@huawei.com>
 <9d07e82a-06fb-a5f8-6f4f-f3c16784b9b7@arm.com>
 <3873f3b6-5e0b-360f-2f01-4584e15e960a@arm.com>
 <8b9d860f-f235-651e-3e48-34cdc489440d@arm.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <8b9d860f-f235-651e-3e48-34cdc489440d@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/07/2023 06:32, Anshuman Khandual wrote:
> 
> 
> On 7/25/23 18:59, Suzuki K Poulose wrote:
>> On 25/07/2023 12:42, Anshuman Khandual wrote:
>>> Hello Yang,
>>>
>>> On 7/25/23 12:42, Yang Shen wrote:
>>>>> +    if (!(branch_type & PERF_SAMPLE_BRANCH_NO_CYCLES))
>>>>> +        brbcr |= BRBCR_EL1_CC;
>>>>
>>>> Hi Anshuman,
>>>>
>>>> Here is problem about enable CYCLES_COUNT. The SPEC defines that the CYCLES_COUNT is only
>>>>
>>>> valid when the BRECR_EL1.CC & BRBCR_EL2.CC is true. And here the SPEC also defines that
>>>>
>>>> when PSTATE.EL == EL2 and HCR_EL2.E2h == '1', 'MSR BRBCR_EL1, <Xt>' means writing to
>>>>
>>>> BRBCR_EL2 actually. So 'armv8pmu_branch_enable' can only set the BRBCR_EL2.CC, while the
>>>>
>>>> BRECR_EL1.CC is still 0. The CYCLES_COUNT will be always 0 in records.
>>>
>>>
>>> Agreed, this is a valid problem i.e BRBCR_EL1.CC and BRBCR_EL2.CC both needs to be set
>>> for valid cycle count information regardless if the kernel runs in EL1 or EL2. A simple
>>> hack in the current code setting BRBCR_EL12.C, which in turn sets BRBCR_EL1.CC when the
>>> kernel runs in EL2 solves the problem.
>>>
>>>>
>>>> As a solution, maybe BRBCR_EL12 should be added for driver according to the registers definition.
>>>
>>> Right, will add the definition for BRBCR_EL12 in arch/arm64/tools/sysreg
>>>
>>>>
>>>> Or, do you have a more standard solution?
>>>
>>> Right, there are some nuances involved here.
>>>
>>> Kernel could boot
>>>      
>>> a. Directly into EL2 and stays in EL2 for good
>>> b. Directly into EL2 but switches into EL1
>>> c. Directly into EL1 without ever going into EL2
>>>
>>> In all the above cases BRBCR_EL1.CC and BRBCR_EL2.CC needs to be set when cycle count
>>> is requested in the perf event interface (event->attr.branch_sample_type) via clearing
>>> PERF_SAMPLE_BRANCH_NO_CYCLES.
>>>
>>>
>>> - For the case as in (c) where kernel boots into EL1 directly and hence cannot ever set
>>>     EL2 register, BRBCR_EL2.CC would be a booting requirement - updated in booting.rst
>>>
>>> - For the cases as in (a) and (b) kernel boots via EL2, hence there is an opportunity
>>>     to set both BRBCR_EL1.CC (via accessed BRBCR_EL12.CC) and BRBCR_EL2.CC. Depending on
>>
>> You don't need to use BRBCR_EL12, if you do it early enough, before
>> HCR_EL2.E2H == 1 is applied.
> 
> Agreed. Please find the code change which solves this reported problem, please
> have a look and let me know if anything needs changing.
> 
> ------------------------------------------------------------------------------
>   Documentation/arch/arm64/booting.rst |  6 ++++
>   arch/arm64/include/asm/el2_setup.h   | 45 ++++++++++++++++++++++++++++
>   arch/arm64/tools/sysreg              | 38 +++++++++++++++++++++++
>   3 files changed, 89 insertions(+)
> 
> diff --git a/Documentation/arch/arm64/booting.rst b/Documentation/arch/arm64/booting.rst
> index b57776a68f15..2276df285e83 100644
> --- a/Documentation/arch/arm64/booting.rst
> +++ b/Documentation/arch/arm64/booting.rst
> @@ -349,6 +349,12 @@ Before jumping into the kernel, the following conditions must be met:
>   
>       - HWFGWTR_EL2.nSMPRI_EL1 (bit 54) must be initialised to 0b01.
>   
> +  For CPUs with feature Branch Record Buffer Extension (FEAT_BRBE):
> +
> +  - If the kernel is entered at EL1 and EL2 is present:
> +
> +    - BRBCR_EL2.CC (bit 3) must be initialised to 0b1.
> +
>     For CPUs with the Scalable Matrix Extension FA64 feature (FEAT_SME_FA64):
>   
>     - If EL3 is present:
> diff --git a/arch/arm64/include/asm/el2_setup.h b/arch/arm64/include/asm/el2_setup.h
> index 8e5ffb58f83e..75b04eff2dc7 100644
> --- a/arch/arm64/include/asm/el2_setup.h
> +++ b/arch/arm64/include/asm/el2_setup.h
> @@ -150,6 +150,50 @@
>   	msr	cptr_el2, x0			// Disable copro. traps to EL2
>   .endm
>   
> +/*
> + * Enable BRBE cycle count
> + *
> + * BRBE requires both BRBCR_EL1.CC and BRBCR_EL2.CC fields, be set
> + * for the cycle counts to be available in BRBINF<N>_EL1.CC during
> + * branch record processing after a PMU interrupt. This enables CC
> + * field on both these registers while still executing inside EL2.
> + *
> + * BRBE driver would still be able to toggle branch records cycle
> + * count support via BRBCR_EL1.CC field regardless of whether the
> + * kernel end up executing in EL1 or EL2.
> + */
> +.macro __init_el2_brbe
> +	mrs	x1, id_aa64dfr0_el1
> +	ubfx	x1, x1, #ID_AA64DFR0_EL1_BRBE_SHIFT, #4
> +	cbz	x1, .Lskip_brbe_cc_\@
> +
> +	mrs_s	x0, SYS_BRBCR_EL2
> +	orr	x0, x0, BRBCR_EL2_CC
> +	msr_s	SYS_BRBCR_EL2, x0
> +
> +	/*
> +	 * Accessing BRBCR_EL1 register here does not require
> +	 * BRBCR_EL12 addressing mode as HCR_EL2.E2H is still
> +	 * clear. Regardless, check for HCR_E2H and be on the
> +	 * safer side.
> +	 */
> +	mrs	x1, hcr_el2
> +	and	x1, x1, #HCR_E2H
> +	cbz	x1, .Lset_brbe_el1_direct_\@
> +
> +	mrs_s	x0, SYS_BRBCR_EL12
> +	orr	x0, x0, BRBCR_EL12_CC
> +	msr_s	SYS_BRBCR_EL12, x0
> +	b	.Lskip_brbe_cc_\@
> +
> +.Lset_brbe_el1_direct_\@:
> +	mrs_s	x0, SYS_BRBCR_EL1
> +	orr	x0, x0, BRBCR_EL1_CC
> +	msr_s	SYS_BRBCR_EL1, x0
> +
> +.Lskip_brbe_cc_\@:
> +.endm
> +
>   /* Disable any fine grained traps */
>   .macro __init_el2_fgt
>   	mrs	x1, id_aa64mmfr0_el1
> @@ -224,6 +268,7 @@
>   	__init_el2_nvhe_idregs
>   	__init_el2_cptr
>   	__init_el2_fgt
> +	__init_el2_brbe
>   .endm
>   
>   #ifndef __KVM_NVHE_HYPERVISOR__
> diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
> index 9892af96262f..7d1d6b3976b4 100644
> --- a/arch/arm64/tools/sysreg
> +++ b/arch/arm64/tools/sysreg
> @@ -1048,6 +1048,44 @@ Enum	1:0	VALID
>   EndEnum
>   EndSysregFields
>   
> +Sysreg	BRBCR_EL12	2	5	9	0	0
> +Res0	63:24
> +Field	23 	EXCEPTION
> +Field	22 	ERTN
> +Res0	21:9
> +Field	8 	FZP
> +Res0	7
> +Enum	6:5	TS
> +	0b01	VIRTUAL
> +	0b10	GUEST_PHYSICAL
> +	0b11	PHYSICAL
> +EndEnum
> +Field	4	MPRED
> +Field	3	CC
> +Res0	2
> +Field	1	E1BRE
> +Field	0	E0BRE
> +EndSysreg

As this is exactly same as BRBCR_EL1, please could we use SysregFields
for BRBCR_EL1 and reuse it here ?



> +
> +Sysreg	BRBCR_EL2	2	4	9	0	0
> +Res0	63:24
> +Field	23 	EXCEPTION
> +Field	22 	ERTN
> +Res0	21:9
> +Field	8 	FZP
> +Res0	7
> +Enum	6:5	TS
> +	0b01	VIRTUAL
> +	0b10	GUEST_PHYSICAL
> +	0b11	PHYSICAL
> +EndEnum
> +Field	4	MPRED
> +Field	3	CC
> +Res0	2
> +Field	1	E1BRE

E2BRE?
> +Field	0	E0BRE

E0HBRE?

Rest looks good to me

Suzuki

> +EndSysreg
> +
>   Sysreg	BRBCR_EL1	2	1	9	0	0
>   Res0	63:24
>   Field	23 	EXCEPTION

