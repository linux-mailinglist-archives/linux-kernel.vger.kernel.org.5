Return-Path: <linux-kernel+bounces-56247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0AAD84C7DF
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 10:49:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 765951F2AFB5
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 09:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C4F023748;
	Wed,  7 Feb 2024 09:49:31 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2D4423746
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 09:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707299371; cv=none; b=KX74nL5cYw204H8PdFGQvnW0jbuYQfzsHcmAApgJn3uKu9koU3NlB+n89NaS+jK0Y52mKOvQSWDusIt1D7xQTqrXAxIOR7yll/I+wLJFI3CAOu4M4BC11Bsu+BDqxJHNOk9qHGnc6OEhvjT38mu8emmxPK2+/cQ+iwyuyavTZZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707299371; c=relaxed/simple;
	bh=MuZbi3mdQcpnHrJHkmlQTqUrkto/lcB3RcVF3kjns6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U8VTC55ROivsEWTctnRM2Hw4PVEkxnp0g3twsVvVg51pBDE08/D1IbORbzX08/KCS080k2fM+CeDuY2Q56zUJ+yYkmhEhG8GMGENG5n8K+QN8Xklz2OtzywZ7wvz2RY0B4Rn1RfsxjEsEHkpceMTkfYIv0/MH4wrAHDHSgAVWHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6F52A1FB;
	Wed,  7 Feb 2024 01:50:10 -0800 (PST)
Received: from FVFF77S0Q05N.cambridge.arm.com (FVFF77S0Q05N.cambridge.arm.com [10.1.26.150])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0778A3F5A1;
	Wed,  7 Feb 2024 01:49:25 -0800 (PST)
Date: Wed, 7 Feb 2024 09:49:23 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Easwar Hariharan <eahariha@linux.microsoft.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Andre Przywara <andre.przywara@arm.com>,
	Rob Herring <robh@kernel.org>, Fuad Tabba <tabba@google.com>,
	Joey Gouly <joey.gouly@arm.com>,
	Kristina Martsenko <kristina.martsenko@arm.com>,
	"moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:KERNEL VIRTUAL MACHINE FOR ARM64 (KVM/arm64)" <kvmarm@lists.linux.dev>
Subject: Re: [RFC PATCH] KVM: arm64: Override Microsoft Azure Cobalt 100 MIDR
 value with ARM Neoverse N2
Message-ID: <ZcNSI089xqia6lho@FVFF77S0Q05N.cambridge.arm.com>
References: <20240206195819.1146693-1-eahariha@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240206195819.1146693-1-eahariha@linux.microsoft.com>

On Tue, Feb 06, 2024 at 07:58:16PM +0000, Easwar Hariharan wrote:
> Several workload optimizations and errata depend on validating that the
> optimization or errata are applicable to the particular CPU by checking
> the MIDR_EL1 system register value. With the Microsoft implementer ID
> for Azure Cobalt 100, the value doesn't match and ~20-25% performance
> regression is seen in these workloads. Override the Azure Cobalt 100
> value and replace it with the default ARM Neoverse N2 value that Azure
> Cobalt 100 is based on.

NAK to rewriting the MIDR in the kernel; we do not lie to userspace about the
MIDR, and this is not a can of worms we're going to open.

If you desire some microarchitectural performance optimizations in particular
projects, please submit patches to those projects to understand your MIDR
value.

Further, if Azure Cobalt 100 is based on ARM Neoverse N2, you presumably suffer
from the same errata; can you comment on that at all? e.g. are there any
changes in this part that *might* lead to differences in errata and/or
workarounds? How do the MIDR_EL1.{Variant,Revision} values compare to that of
Neoverse N2?

Mark.

> Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
> ---
>  arch/arm64/include/asm/cputype.h   | 3 ++-
>  arch/arm64/include/asm/el2_setup.h | 5 +++++
>  arch/arm64/kvm/sys_regs.c          | 9 ++++++++-
>  3 files changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/cputype.h b/arch/arm64/include/asm/cputype.h
> index 7c7493cb571f..0450c6c32377 100644
> --- a/arch/arm64/include/asm/cputype.h
> +++ b/arch/arm64/include/asm/cputype.h
> @@ -262,7 +262,8 @@ is_midr_in_range_list(u32 midr, struct midr_range const *ranges)
>   */
>  static inline u32 __attribute_const__ read_cpuid_id(void)
>  {
> -	return read_cpuid(MIDR_EL1);
> +	return (read_cpuid(MIDR_EL1) == 0x6D0FD490 ? 0x410FD490 :
> +			read_cpuid(MIDR_EL1));
>  }
>  
>  static inline u64 __attribute_const__ read_cpuid_mpidr(void)
> diff --git a/arch/arm64/include/asm/el2_setup.h b/arch/arm64/include/asm/el2_setup.h
> index b7afaa026842..502a14e54a31 100644
> --- a/arch/arm64/include/asm/el2_setup.h
> +++ b/arch/arm64/include/asm/el2_setup.h
> @@ -138,6 +138,11 @@
>  .macro __init_el2_nvhe_idregs
>  	mrs	x0, midr_el1
>  	mrs	x1, mpidr_el1
> +	ldr	x2, =0x6D0FD490
> +	cmp	x0, x2
> +	bne	.Loverride_cobalt100_\@
> +	ldr	x0, =0x410FD490
> +.Loverride_cobalt100_\@:
>  	msr	vpidr_el2, x0
>  	msr	vmpidr_el2, x1
>  .endm
> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
> index 30253bd19917..8ea9c7fdabdb 100644
> --- a/arch/arm64/kvm/sys_regs.c
> +++ b/arch/arm64/kvm/sys_regs.c
> @@ -3574,7 +3574,14 @@ id_to_sys_reg_desc(struct kvm_vcpu *vcpu, u64 id,
>  		return ((struct sys_reg_desc *)r)->val;			\
>  	}
>  
> -FUNCTION_INVARIANT(midr_el1)
> +static u64 get_midr_el1(struct kvm_vcpu *v, const struct sys_reg_desc *r)
> +{
> +	((struct sys_reg_desc *)r)->val = read_sysreg(midr_el1);
> +	if (((struct sys_reg_desc *)r)->val == 0x6D0FD490)
> +		((struct sys_reg_desc *)r)->val == 0x410FD490;
> +	return ((struct sys_reg_desc *)r)->val;
> +}
> +
>  FUNCTION_INVARIANT(revidr_el1)
>  FUNCTION_INVARIANT(aidr_el1)
>  
> -- 
> 2.34.1
> 
> 

