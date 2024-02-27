Return-Path: <linux-kernel+bounces-83003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C5DD868CDF
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 11:05:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E3B31C21E71
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 10:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9F85137C48;
	Tue, 27 Feb 2024 10:05:11 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A60C136665;
	Tue, 27 Feb 2024 10:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709028311; cv=none; b=gwlhO/Umpzkl/ofIG65u9pFpoUA7UNJ7Djis4ybhCf3JLKfmrVAioN8LKMjOaw6RTpr+Kuy9ubERUHgr4fsyA5XvhKAthdGuQMGVCbrJ9Cft1cFvggZSnFlDDp50TZ5IjBm8ag2sVAs7BT62Eff0sBvvbkyAYQkMMWBYmSBgLRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709028311; c=relaxed/simple;
	bh=zc3K2y4HYZYpQe/0M78zHPkZOoeKRZUHrD9sAX/ihp0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l5YtgXsc4ePVjwL2RXKYEeCBvly7igwU4rlos5GiUp6mnQLRPQ6IxXF4EeCw/xCB+dnUIOczV1DCt52nW9U27mQnetmvw6lLwumLVaKLvOByFrXalhydvSiRA7Zbsj9yy7c9yiHd5mwfTOn9+eNwK7rIdC8wgOZ6NjjfeBeun+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5BC61DA7;
	Tue, 27 Feb 2024 02:05:46 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.79.110])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7349C3F762;
	Tue, 27 Feb 2024 02:05:05 -0800 (PST)
Date: Tue, 27 Feb 2024 10:04:59 +0000
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
	linux-perf-users@vger.kernel.org,
	Oliver Upton <oliver.upton@linux.dev>,
	James Morse <james.morse@arm.com>, kvmarm@lists.linux.dev
Subject: Re: [PATCH V16 2/8] KVM: arm64: Prevent guest accesses into BRBE
 system registers/instructions
Message-ID: <Zd2zy0oUk8XvoDJM@FVFF77S0Q05N>
References: <20240125094119.2542332-1-anshuman.khandual@arm.com>
 <20240125094119.2542332-3-anshuman.khandual@arm.com>
 <ZdYCUi9YVDNDz7fr@FVFF77S0Q05N>
 <ab50e67e-3d06-4ba7-a5f8-4684e9ef98a4@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab50e67e-3d06-4ba7-a5f8-4684e9ef98a4@arm.com>

On Fri, Feb 23, 2024 at 12:58:48PM +0530, Anshuman Khandual wrote:
> 
> 
> On 2/21/24 19:31, Mark Rutland wrote:
> > On Thu, Jan 25, 2024 at 03:11:13PM +0530, Anshuman Khandual wrote:
> >> Currently BRBE feature is not supported in a guest environment. This hides
> >> BRBE feature availability via masking ID_AA64DFR0_EL1.BRBE field.
> > 
> > Does that means that a guest can currently see BRBE advertised in the
> > ID_AA64DFR0_EL1.BRB field, or is that hidden by the regular cpufeature code
> > today?
> 
> IIRC it is hidden, but will have to double check. When experimenting for BRBE
> guest support enablement earlier, following changes were need for the feature
> to be visible in ID_AA64DFR0_EL1.
> 
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index 646591c67e7a..f258568535a8 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -445,6 +445,7 @@ static const struct arm64_ftr_bits ftr_id_mmfr0[] = {
>  };
>  
>  static const struct arm64_ftr_bits ftr_id_aa64dfr0[] = {
> +       S_ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64DFR0_EL1_BRBE_SHIFT, 4, ID_AA64DFR0_EL1_BRBE_IMP),
>         S_ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64DFR0_EL1_DoubleLock_SHIFT, 4, 0),
>         ARM64_FTR_BITS(FTR_HIDDEN, FTR_NONSTRICT, FTR_LOWER_SAFE, ID_AA64DFR0_EL1_PMSVer_SHIFT, 4, 0),
>         ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64DFR0_EL1_CTX_CMPs_SHIFT, 4, 0),
> 
> Should we add the following entry - explicitly hiding BRBE from the guest
> as a prerequisite patch ?
> 
> S_ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64DFR0_EL1_BRBE_SHIFT, 4, ID_AA64DFR0_EL1_BRBE_NI)

Is it visbile currently, or is it hidden currently?

* If it is visible before this patch, that's a latent bug that we need to go
  fix first, and that'll require more coordination.

* If it is not visible before this patch, there's no problem in the code, but
  the commit message needs to explicitly mention that's the case as the commit
  message currently implies it is visible by only mentioning hiding it.

.. so can you please double check as you suggested above? We should be able to
explain why it is or is not visible today.

Mark.

> >> This also blocks guest accesses into BRBE system registers and instructions
> >> as if the underlying hardware never implemented FEAT_BRBE feature.
> >>
> >> Cc: Marc Zyngier <maz@kernel.org>
> >> Cc: Oliver Upton <oliver.upton@linux.dev>
> >> Cc: James Morse <james.morse@arm.com>
> >> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> >> Cc: Catalin Marinas <catalin.marinas@arm.com>
> >> Cc: Will Deacon <will@kernel.org>
> >> Cc: kvmarm@lists.linux.dev
> >> Cc: linux-arm-kernel@lists.infradead.org
> >> Cc: linux-kernel@vger.kernel.org
> >> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> >> ---
> >> Changes in V16:
> >>
> >> - Added BRB_INF_SRC_TGT_EL1 macro for corresponding BRB_[INF|SRC|TGT] expansion
> >>
> >>  arch/arm64/kvm/sys_regs.c | 56 +++++++++++++++++++++++++++++++++++++++
> >>  1 file changed, 56 insertions(+)
> >>
> >> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
> >> index 30253bd19917..6a06dc2f0c06 100644
> >> --- a/arch/arm64/kvm/sys_regs.c
> >> +++ b/arch/arm64/kvm/sys_regs.c
> >> @@ -1304,6 +1304,11 @@ static int set_pmcr(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r,
> >>  	return 0;
> >>  }
> >>  
> >> +#define BRB_INF_SRC_TGT_EL1(n)					\
> >> +	{ SYS_DESC(SYS_BRBINF##n##_EL1), undef_access },	\
> >> +	{ SYS_DESC(SYS_BRBSRC##n##_EL1), undef_access },	\
> >> +	{ SYS_DESC(SYS_BRBTGT##n##_EL1), undef_access }		\
> > 
> > With the changes suggested on the previous patch, this would need to change to be:
> > 
> > 	#define BRB_INF_SRC_TGT_EL1(n)					\
> > 		{ SYS_DESC(SYS_BRBINF_EL1(n)), undef_access },	\
> > 		{ SYS_DESC(SYS_BRBSRC_EL1(n)), undef_access },	\
> > 		{ SYS_DESC(SYS_BRBTGT_EL1(n)), undef_access }	\
> 
> Sure, already folded back in these above changes.
> 
> > 
> > 
> > ... which would also be easier for backporting (if necessary), since those
> > definitions have existed for a while.
> > 
> > Otherwise (modulo Suzuki's comment about rebasing), this looks good to me.
> 
> Okay.
> 
> > 
> > Mark.
> > 
> >>  /* Silly macro to expand the DBG{BCR,BVR,WVR,WCR}n_EL1 registers in one go */
> >>  #define DBG_BCR_BVR_WCR_WVR_EL1(n)					\
> >>  	{ SYS_DESC(SYS_DBGBVRn_EL1(n)),					\
> >> @@ -1707,6 +1712,9 @@ static u64 read_sanitised_id_aa64dfr0_el1(struct kvm_vcpu *vcpu,
> >>  	/* Hide SPE from guests */
> >>  	val &= ~ID_AA64DFR0_EL1_PMSVer_MASK;
> >>  
> >> +	/* Hide BRBE from guests */
> >> +	val &= ~ID_AA64DFR0_EL1_BRBE_MASK;
> >> +
> >>  	return val;
> >>  }
> >>  
> >> @@ -2195,6 +2203,8 @@ static const struct sys_reg_desc sys_reg_descs[] = {
> >>  	{ SYS_DESC(SYS_DC_CISW), access_dcsw },
> >>  	{ SYS_DESC(SYS_DC_CIGSW), access_dcgsw },
> >>  	{ SYS_DESC(SYS_DC_CIGDSW), access_dcgsw },
> >> +	{ SYS_DESC(OP_BRB_IALL), undef_access },
> >> +	{ SYS_DESC(OP_BRB_INJ), undef_access },
> >>  
> >>  	DBG_BCR_BVR_WCR_WVR_EL1(0),
> >>  	DBG_BCR_BVR_WCR_WVR_EL1(1),
> >> @@ -2225,6 +2235,52 @@ static const struct sys_reg_desc sys_reg_descs[] = {
> >>  	{ SYS_DESC(SYS_DBGCLAIMCLR_EL1), trap_raz_wi },
> >>  	{ SYS_DESC(SYS_DBGAUTHSTATUS_EL1), trap_dbgauthstatus_el1 },
> >>  
> >> +	/*
> >> +	 * BRBE branch record sysreg address space is interleaved between
> >> +	 * corresponding BRBINF<N>_EL1, BRBSRC<N>_EL1, and BRBTGT<N>_EL1.
> >> +	 */
> >> +	BRB_INF_SRC_TGT_EL1(0),
> >> +	BRB_INF_SRC_TGT_EL1(16),
> >> +	BRB_INF_SRC_TGT_EL1(1),
> >> +	BRB_INF_SRC_TGT_EL1(17),
> >> +	BRB_INF_SRC_TGT_EL1(2),
> >> +	BRB_INF_SRC_TGT_EL1(18),
> >> +	BRB_INF_SRC_TGT_EL1(3),
> >> +	BRB_INF_SRC_TGT_EL1(19),
> >> +	BRB_INF_SRC_TGT_EL1(4),
> >> +	BRB_INF_SRC_TGT_EL1(20),
> >> +	BRB_INF_SRC_TGT_EL1(5),
> >> +	BRB_INF_SRC_TGT_EL1(21),
> >> +	BRB_INF_SRC_TGT_EL1(6),
> >> +	BRB_INF_SRC_TGT_EL1(22),
> >> +	BRB_INF_SRC_TGT_EL1(7),
> >> +	BRB_INF_SRC_TGT_EL1(23),
> >> +	BRB_INF_SRC_TGT_EL1(8),
> >> +	BRB_INF_SRC_TGT_EL1(24),
> >> +	BRB_INF_SRC_TGT_EL1(9),
> >> +	BRB_INF_SRC_TGT_EL1(25),
> >> +	BRB_INF_SRC_TGT_EL1(10),
> >> +	BRB_INF_SRC_TGT_EL1(26),
> >> +	BRB_INF_SRC_TGT_EL1(11),
> >> +	BRB_INF_SRC_TGT_EL1(27),
> >> +	BRB_INF_SRC_TGT_EL1(12),
> >> +	BRB_INF_SRC_TGT_EL1(28),
> >> +	BRB_INF_SRC_TGT_EL1(13),
> >> +	BRB_INF_SRC_TGT_EL1(29),
> >> +	BRB_INF_SRC_TGT_EL1(14),
> >> +	BRB_INF_SRC_TGT_EL1(30),
> >> +	BRB_INF_SRC_TGT_EL1(15),
> >> +	BRB_INF_SRC_TGT_EL1(31),
> >> +
> >> +	/* Remaining BRBE sysreg addresses space */
> >> +	{ SYS_DESC(SYS_BRBCR_EL1), undef_access },
> >> +	{ SYS_DESC(SYS_BRBFCR_EL1), undef_access },
> >> +	{ SYS_DESC(SYS_BRBTS_EL1), undef_access },
> >> +	{ SYS_DESC(SYS_BRBINFINJ_EL1), undef_access },
> >> +	{ SYS_DESC(SYS_BRBSRCINJ_EL1), undef_access },
> >> +	{ SYS_DESC(SYS_BRBTGTINJ_EL1), undef_access },
> >> +	{ SYS_DESC(SYS_BRBIDR0_EL1), undef_access },
> >> +
> >>  	{ SYS_DESC(SYS_MDCCSR_EL0), trap_raz_wi },
> >>  	{ SYS_DESC(SYS_DBGDTR_EL0), trap_raz_wi },
> >>  	// DBGDTR[TR]X_EL0 share the same encoding
> >> -- 
> >> 2.25.1
> >>

