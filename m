Return-Path: <linux-kernel+bounces-75284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CBF685E5D8
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 19:26:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6C2928400F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 18:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5DF585C52;
	Wed, 21 Feb 2024 18:23:38 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62FE27FBD5;
	Wed, 21 Feb 2024 18:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708539817; cv=none; b=mQ3vFwuiwkwV43looaol2zOZQXlv5Zd58FnsJ3a9i9V2MOeaxKnB8CaCgKcZ8kyAi1TPpeoggX+/aRZs1lPspQ51i1vvX6fUCsHWq047FU27+5lT+NX/sBZ6xYQNbR4OBBYsz2eHtBuI2443Zqu48SMf0I0dBkRS4LMs6W4Wwws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708539817; c=relaxed/simple;
	bh=tAEVWFMMqfC0PW/E3UicVC58kHswqXXAzw9k5Z8NYbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uSjaAGb/VLTrJTbX9djDQiIcquC17tBCKx5SqJKn2xL/893z/8oQa4YAmVZLWKSmJrLJJ7aQEIBUEt94uZE1neOu6n/9D26jR8PKdh7YXel0ZqL33SAsSSUEWCAUyszn8MwRwcUK9Ng4+vnfgY4afcOUpi7KcPpqpSJ3pLIrra8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E463B1007;
	Wed, 21 Feb 2024 10:24:11 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.65.165])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 61B423F762;
	Wed, 21 Feb 2024 10:23:31 -0800 (PST)
Date: Wed, 21 Feb 2024 18:23:28 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	will@kernel.org, catalin.marinas@arm.com,
	Mark Brown <broonie@kernel.org>, James Clark <james.clark@arm.com>,
	Rob Herring <robh@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Suzuki Poulose <suzuki.poulose@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH V16 4/8] drivers: perf: arm_pmuv3: Enable branch stack
 sampling via FEAT_BRBE
Message-ID: <ZdY_oEYPGSj7nwvP@FVFF77S0Q05N>
References: <20240125094119.2542332-1-anshuman.khandual@arm.com>
 <20240125094119.2542332-5-anshuman.khandual@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240125094119.2542332-5-anshuman.khandual@arm.com>

On Thu, Jan 25, 2024 at 03:11:15PM +0530, Anshuman Khandual wrote:
> This extends recently added branch stack sampling framework in ARMV8 PMU to
> enable such events via new architecture feature called Branch Record Buffer
> Extension aka BRBE. This implements all the armv8pmu_branch_xxx() callbacks
> as expected at ARMV8 PMU level required to drive perf branch stack sampling
> events. This adds a new config option CONFIG_ARM64_BRBE to encapsulate this
> BRBE based implementation, available only on ARM64 platforms.
> 
> BRBE hardware captures a branch record via three distinct system registers
> representing branch source address, branch target address, and other branch
> information. A BRBE buffer implementation is organized as multiple banks of
> 32 branch records each, which is a collection of BRBSRC_EL1, BRBTGT_EL1 and
> BRBINF_EL1 registers. Though total BRBE record entries i.e BRBE_MAX_ENTRIES
> cannot exceed MAX_BRANCH_RECORDS as defined for ARM PMU.
> 
> BRBE hardware attributes get captured in a new reg_brbidr element in struct
> arm_pmu during armv8pmu_branch_probe() which is called from broader probing
> function __armv8pmu_probe_pmu(). Attributes such as number of branch record
> entries implemented in the hardware can be derived from armpmu->reg_brbidr.
> 
> BRBE gets enabled via armv8pmu_branch_enable() where it also derives branch
> filter, and additional requirements from event's 'attr.branch_sample_type'
> and configures them via BRBFCR_EL1 and BRBCR_EL1 registers.
> 
> PMU event overflow triggers IRQ, where current branch records get captured,
> stitched along with older records available in 'task_ctx', before getting
> processed for core perf ring buffer. Task context switch outs incrementally
> save current branch records in event's 'pmu_ctx->task_ctx_data' to optimize
> workload's branch record samples.
> 
> In case multiple events with different branch sample type requests converge
> on the same PMU, BRBE gets enabled for branch filters for the last event's
> branch sample type. No branch records will be captured and processed for an
> event if BRBE hardware config does not match its branch sample type, while
> handling the PMU IRQ.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
> Changes in V16:
> 
> - Added new PERF_SAMPLE_BRANCH_COUNTERS into BRBE_EXCLUDE_BRANCH_FILTERS
> - Fixed typo (s/informations/information) in Documentation/arch/arm64/brbe.rst
> - Added SPDX-License-Identifier in Documentation/arch/arm64/brbe.rst
> 
>  Documentation/arch/arm64/booting.rst |   6 +
>  Documentation/arch/arm64/brbe.rst    | 158 +++++
>  arch/arm64/include/asm/el2_setup.h   | 113 ++-
>  drivers/perf/Kconfig                 |  11 +
>  drivers/perf/Makefile                |   1 +
>  drivers/perf/arm_brbe.c              | 986 +++++++++++++++++++++++++++
>  drivers/perf/arm_pmuv3_branch.h      |  13 +
>  include/linux/perf/arm_pmu.h         |   5 +
>  8 files changed, 1290 insertions(+), 3 deletions(-)
>  create mode 100644 Documentation/arch/arm64/brbe.rst
>  create mode 100644 drivers/perf/arm_brbe.c
> 
> diff --git a/Documentation/arch/arm64/booting.rst b/Documentation/arch/arm64/booting.rst
> index b57776a68f15..2276df285e83 100644
> --- a/Documentation/arch/arm64/booting.rst
> +++ b/Documentation/arch/arm64/booting.rst
> @@ -349,6 +349,12 @@ Before jumping into the kernel, the following conditions must be met:
>  
>      - HWFGWTR_EL2.nSMPRI_EL1 (bit 54) must be initialised to 0b01.
>  
> +  For CPUs with feature Branch Record Buffer Extension (FEAT_BRBE):
> +
> +  - If the kernel is entered at EL1 and EL2 is present:
> +
> +    - BRBCR_EL2.CC (bit 3) must be initialised to 0b1.
> +

We don't care about any of the other bits? e.g. MPRED?

There are no EL3 controls or fine-grain traps we care about?

>    For CPUs with the Scalable Matrix Extension FA64 feature (FEAT_SME_FA64):
>  
>    - If EL3 is present:
> diff --git a/Documentation/arch/arm64/brbe.rst b/Documentation/arch/arm64/brbe.rst
> new file mode 100644
> index 000000000000..c6380db3b03a
> --- /dev/null
> +++ b/Documentation/arch/arm64/brbe.rst
> @@ -0,0 +1,158 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +============================================
> +Branch Record Buffer Extension aka FEAT_BRBE
> +============================================
> +
> +Author: Anshuman Khandual <anshuman.khandual@arm.com>
> +
> +FEAT_BRBE is an optional architecture feature, which creates branch records
> +containing information about change in control flow. The branch information
> +contains source address, target address, and some relevant metadata related
> +to that change in control flow. BRBE can be configured to filter out branch
> +records based on their type and privilege level.

Do we actually need this documentation?

The set of peopl writing kernel code can read the ARM ARM or the kernel code,
and there's not much here useful to users.

I think it may make sense to document what userspace and/or VMs can and cannot
do (which is why we describe the ID registers), and any 'gotchas' (e.g.
restrictions we have that other architectures don't, or vice-versa). I do not
think that we should try to describe the hardware beyond what is necessary to
describe that, and I do not think that we should describe the structure of the
perf code beyond what is necessary to desribe that.

Otherwise, this is just a maintenance burden.

[...]

> +BRBE Hardware
> +=============
> +
> +FEAT_BRBE support on a given implementation, can be determined from system
> +register field ID_AA64DFR0_EL1.BRBE, containing 'ID_AA64DFR0_EL1_BRBE_IMP'
> +or 'ID_AA64DFR0_EL1_BRBE_BRBE_V1P1'. All BRBE system registers, including
> +branch record banks are available for each CPU.

I do not think that we need to explain the system-register level interface
here. That's documented in the ARM ARM, and userspace doesn't care.

[...]


> +Perf Implementation
> +===================
> +
> +Perf branch stack sampling framework has been enabled on arm64 platform via
> +this new FEAT_BRBE feature. The following description explains how this has
> +been implemented in various levels of abstraction - from perf core all the
> +way to ARMv8 PMUv3 implementation.

This should be described in comments in the code. This will rapdily become
stale and it's just a maintenance burden.

[...]

> diff --git a/arch/arm64/include/asm/el2_setup.h b/arch/arm64/include/asm/el2_setup.h
> index b7afaa026842..649b926bf69d 100644
> --- a/arch/arm64/include/asm/el2_setup.h
> +++ b/arch/arm64/include/asm/el2_setup.h
> @@ -154,6 +154,51 @@
>  .Lskip_set_cptr_\@:
>  .endm
>  
> +#ifdef CONFIG_ARM64_BRBE
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
> + * kernel ends up executing in EL1 or EL2.
> + */
> +.macro __init_el2_brbe
> +	mrs	x1, id_aa64dfr0_el1
> +	ubfx	x1, x1, #ID_AA64DFR0_EL1_BRBE_SHIFT, #4
> +	cbz	x1, .Lskip_brbe_cc_\@
> +
> +	mrs_s	x0, SYS_BRBCR_EL2
> +	orr	x0, x0, BRBCR_ELx_CC
> +	msr_s	SYS_BRBCR_EL2, x0

Please initialise this to a specific value rather than using a
read-modify-write.

> +
> +	/*
> +	 * Accessing BRBCR_EL1 register here does not require
> +	 * BRBCR_EL12 addressing mode as HCR_EL2.E2H is still
> +	 * clear. Regardless, check for HCR_E2H and be on the
> +	 * safer side.
> +	 */

Presumably this won't be the case for FEAT_E2H0, so the comment is going to be
misleading. So probably best to just delete the comment...

> +	mrs	x1, hcr_el2
> +	and	x1, x1, #HCR_E2H
> +	cbz	x1, .Lset_brbe_el1_direct_\@
> +
> +	mrs_s	x0, SYS_BRBCR_EL12
> +	orr	x0, x0, BRBCR_ELx_CC
> +	msr_s	SYS_BRBCR_EL12, x0
> +	b	.Lskip_brbe_cc_\@
> +
> +.Lset_brbe_el1_direct_\@:

Why 'direct'? This is just VHE vs nVHE.

Please look at the way finalise_el2_state() handles (h)VHE and nVHE, and do the
same thing here...

> +	mrs_s	x0, SYS_BRBCR_EL1
> +	orr	x0, x0, BRBCR_ELx_CC
> +	msr_s	SYS_BRBCR_EL1, x0
> +.Lskip_brbe_cc_\@:
> +.endm
> +#endif
> +
>  /* Disable any fine grained traps */
>  .macro __init_el2_fgt
>  	mrs	x1, id_aa64mmfr0_el1
> @@ -161,16 +206,62 @@
>  	cbz	x1, .Lskip_fgt_\@
>  
>  	mov	x0, xzr
> +	mov	x2, xzr
>  	mrs	x1, id_aa64dfr0_el1
>  	ubfx	x1, x1, #ID_AA64DFR0_EL1_PMSVer_SHIFT, #4
>  	cmp	x1, #3
>  	b.lt	.Lset_debug_fgt_\@
> +
>  	/* Disable PMSNEVFR_EL1 read and write traps */
> -	orr	x0, x0, #(1 << 62)
> +	orr	x0, x0, #HDFGRTR_EL2_nPMSNEVFR_EL1_MASK
> +	orr	x2, x2, #HDFGWTR_EL2_nPMSNEVFR_EL1_MASK
>  
>  .Lset_debug_fgt_\@:
> +	mrs	x1, id_aa64dfr0_el1
> +	ubfx	x1, x1, #ID_AA64DFR0_EL1_BRBE_SHIFT, #4
> +	cbz	x1, .Lskip_brbe_reg_fgt_\@
> +
> +	/*
> +	 * Disable read traps for the following BRBE related
> +	 * registers.
> +	 *
> +	 * BRBSRC_EL1
> +	 * BRBTGT_EL1
> +	 * BRBINF_EL1
> +	 * BRBSRCINJ_EL1
> +	 * BRBTGTINJ_EL1
> +	 * BRBINFINJ_EL1
> +	 * BRBTS_EL1
> +	 */
> +	orr	x0, x0, #HDFGRTR_EL2_nBRBDATA_MASK
> +
> +	/*
> +	 * Disable write traps for the following BRBE related
> +	 * registers.
> +	 *
> +	 * BRBSRCINJ_EL1
> +	 * BRBTGTINJ_EL1
> +	 * BRBINFINJ_EL1
> +	 * BRBTS_EL1
> +	 */
> +	orr	x2, x2, #HDFGWTR_EL2_nBRBDATA_MASK
> +
> +	/*
> +	 * Disable both read and write traps for the following
> +	 * BRBE related registers.
> +	 *
> +	 * BRBCR_EL1
> +	 * BRBFCR_EL1
> +	 */
> +	orr	x0, x0, #HDFGRTR_EL2_nBRBCTL_MASK
> +	orr	x2, x2, #HDFGWTR_EL2_nBRBCTL_MASK
> +
> +	/* Disable BRBIDR_EL1 read traps */
> +	orr	x0, x0, #HDFGRTR_EL2_nBRBIDR_MASK
> +
> +.Lskip_brbe_reg_fgt_\@:
>  	msr_s	SYS_HDFGRTR_EL2, x0
> -	msr_s	SYS_HDFGWTR_EL2, x0
> +	msr_s	SYS_HDFGWTR_EL2, x2
>  
>  	mov	x0, xzr
>  	mrs	x1, id_aa64pfr1_el1
> @@ -193,7 +284,20 @@
>  .Lset_fgt_\@:
>  	msr_s	SYS_HFGRTR_EL2, x0
>  	msr_s	SYS_HFGWTR_EL2, x0
> -	msr_s	SYS_HFGITR_EL2, xzr
> +
> +	mov	x0, xzr
> +	mrs	x1, id_aa64dfr0_el1
> +	ubfx	x1, x1, #ID_AA64DFR0_EL1_BRBE_SHIFT, #4
> +	cbz	x1, .Lskip_brbe_insn_fgt_\@
> +
> +	/* Disable traps for BRBIALL instruction */
> +	orr	x0, x0, #HFGITR_EL2_nBRBIALL_MASK
> +
> +	/* Disable traps for BRBINJ instruction */
> +	orr	x0, x0, #HFGITR_EL2_nBRBINJ_MASK
> +
> +.Lskip_brbe_insn_fgt_\@:
> +	msr_s	SYS_HFGITR_EL2, x0
>  
>  	mrs	x1, id_aa64pfr0_el1		// AMU traps UNDEF without AMU
>  	ubfx	x1, x1, #ID_AA64PFR0_EL1_AMU_SHIFT, #4

None of the fine-grain trap requirements were described in booting.rst, and
presumably should be, as we describe that for other features.

Can you split up the booting.rst and el2 setup code into a preparatory patch
jsut before the actual BRBE changes? It'll make it easier for people (e.g. KVM
folk) to review that in isolation, and we can settle that even if the actual
BRBE driver needs work.

[...]

> +enum brbe_bank_idx {
> +	BRBE_BANK_IDX_INVALID = -1,
> +	BRBE_BANK_IDX_0,
> +	BRBE_BANK_IDX_1,
> +	BRBE_BANK_IDX_MAX
> +};

AFAICT, this enum type isn't used anywhere in this series, nor so
BRBE_BANK_IDX_INVALID or BRBE_BANK_IDX_MAX. Please get rid of it, and just use
plain 0 and 1 for bank indices.v

[...]

> +/*
> + * A branch record with BRBINFx_EL1.LASTFAILED set, implies that all
> + * preceding consecutive branch records, that were in a transaction
> + * (i.e their BRBINFx_EL1.TX set) have been aborted.
> + *
> + * Similarly BRBFCR_EL1.LASTFAILED set, indicate that all preceding
> + * consecutive branch records up to the last record, which were in a
> + * transaction (i.e their BRBINFx_EL1.TX set) have been aborted.
> + *
> + * --------------------------------- -------------------
> + * | 00 | BRBSRC | BRBTGT | BRBINF | | TX = 1 | LF = 0 | [TX success]
> + * --------------------------------- -------------------
> + * | 01 | BRBSRC | BRBTGT | BRBINF | | TX = 1 | LF = 0 | [TX success]
> + * --------------------------------- -------------------
> + * | 02 | BRBSRC | BRBTGT | BRBINF | | TX = 0 | LF = 0 |
> + * --------------------------------- -------------------
> + * | 03 | BRBSRC | BRBTGT | BRBINF | | TX = 1 | LF = 0 | [TX failed]
> + * --------------------------------- -------------------
> + * | 04 | BRBSRC | BRBTGT | BRBINF | | TX = 1 | LF = 0 | [TX failed]
> + * --------------------------------- -------------------
> + * | 05 | BRBSRC | BRBTGT | BRBINF | | TX = 0 | LF = 1 |
> + * --------------------------------- -------------------
> + * | .. | BRBSRC | BRBTGT | BRBINF | | TX = 0 | LF = 0 |
> + * --------------------------------- -------------------
> + * | 61 | BRBSRC | BRBTGT | BRBINF | | TX = 1 | LF = 0 | [TX failed]
> + * --------------------------------- -------------------
> + * | 62 | BRBSRC | BRBTGT | BRBINF | | TX = 1 | LF = 0 | [TX failed]
> + * --------------------------------- -------------------
> + * | 63 | BRBSRC | BRBTGT | BRBINF | | TX = 1 | LF = 0 | [TX failed]
> + * --------------------------------- -------------------
> + *
> + * BRBFCR_EL1.LASTFAILED == 1
> + *
> + * BRBFCR_EL1.LASTFAILED fails all those consecutive, in transaction
> + * branches records near the end of the BRBE buffer.
> + *
> + * Architecture does not guarantee a non transaction (TX = 0) branch
> + * record between two different transactions. So it is possible that
> + * a subsequent lastfailed record (TX = 0, LF = 1) might erroneously
> + * mark more than required transactions as aborted.
> + */
> +static void process_branch_aborts(struct pmu_hw_events *cpuc)
> +{
> +	u64 brbfcr = read_sysreg_s(SYS_BRBFCR_EL1);
> +	bool lastfailed = !!(brbfcr & BRBFCR_EL1_LASTFAILED);
> +	int idx = brbe_get_numrec(cpuc->percpu_pmu->reg_brbidr) - 1;
> +	struct perf_branch_entry *entry;
> +
> +	do {
> +		entry = &cpuc->branches->branch_entries[idx];
> +		if (entry->in_tx) {
> +			entry->abort = lastfailed;
> +		} else {
> +			lastfailed = entry->abort;
> +			entry->abort = false;
> +		}
> +	} while (idx--, idx >= 0);
> +}

Please consider:

1) There are no extant CPU implementations with TME.
2) There are no plans for anyone to build TME.
3) The kernel doesn't support TME.

.. so why are we tryting to handle this architectural edge-case (complete with
what is arguably an architectural bug!) that can only happen on a CPU with TME,
under a kernel that's using TME?

This cannot possibly have been tested, trivially by point 3.

This is purely a maintenance and review burden.

Please delete this and replace it with a comment somewhere that *if* we ever
add support for TME this will need to be handled somehow.

Mark.

