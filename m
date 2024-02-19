Return-Path: <linux-kernel+bounces-71288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A39D85A2F1
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 13:14:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 691A6B222B8
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 12:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF56E2D608;
	Mon, 19 Feb 2024 12:14:23 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6376C2C848;
	Mon, 19 Feb 2024 12:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708344863; cv=none; b=quh4DtMIIabGk3z4kZXVGMr90afkWjOR6Vzlxgc6RarId85/1Y8hpCo0tEspNYKP7p3nKB1d1+WBkShHJjiKexjruVAfIcUYtLIFSWFbzQlTFyzmE4Tc/FDJXklW0/hU/gUzs46sbtR1WKFSIJU7uVmD8anmOv5HuHMAKEC06Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708344863; c=relaxed/simple;
	bh=NZ4jnqU/EuB2SUEt+cn3RuhNToVBs6BNR7tAp3xZ3mY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h/V0+m5b9KHTEgUV5cgNWryAFSX2+OC0/pNNQJBLdwSD8ScnmbvTunZjz/D52RPHC+1n/xOhAHzHqgDlYFpK8mTI+G0oDsnocjJ4C1IRz8jnIgnYsWmDJfq35AdWJ1AHe04XCnL66ZiUkp50FaxeP15cR8thF+pA98m76NvF35c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 852C7C433C7;
	Mon, 19 Feb 2024 12:14:21 +0000 (UTC)
Date: Mon, 19 Feb 2024 12:14:18 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Christoffer Dall <cdall@cs.columbia.edu>, Marc Zyngier <maz@kernel.org>,
	Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>
Subject: Re: linux-next: manual merge of the kvm-arm tree with the arm64 tree
Message-ID: <ZdNGGrUDWfvqCudV@arm.com>
References: <20240219135805.1c4138a3@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240219135805.1c4138a3@canb.auug.org.au>

On Mon, Feb 19, 2024 at 01:58:05PM +1100, Stephen Rothwell wrote:
> diff --cc arch/arm64/kernel/cpufeature.c
> index 0be9296e9253,f309fd542c20..000000000000
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@@ -721,13 -754,12 +756,14 @@@ static const struct __ftr_reg_entry 
>   			       &id_aa64isar2_override),
>   
>   	/* Op1 = 0, CRn = 0, CRm = 7 */
>  -	ARM64_FTR_REG(SYS_ID_AA64MMFR0_EL1, ftr_id_aa64mmfr0),
>  +	ARM64_FTR_REG_OVERRIDE(SYS_ID_AA64MMFR0_EL1, ftr_id_aa64mmfr0,
>  +			       &id_aa64mmfr0_override),
>   	ARM64_FTR_REG_OVERRIDE(SYS_ID_AA64MMFR1_EL1, ftr_id_aa64mmfr1,
>   			       &id_aa64mmfr1_override),
>  -	ARM64_FTR_REG(SYS_ID_AA64MMFR2_EL1, ftr_id_aa64mmfr2),
>  +	ARM64_FTR_REG_OVERRIDE(SYS_ID_AA64MMFR2_EL1, ftr_id_aa64mmfr2,
>  +			       &id_aa64mmfr2_override),
>   	ARM64_FTR_REG(SYS_ID_AA64MMFR3_EL1, ftr_id_aa64mmfr3),
> + 	ARM64_FTR_REG(SYS_ID_AA64MMFR4_EL1, ftr_id_aa64mmfr4),
>   
>   	/* Op1 = 1, CRn = 0, CRm = 0 */
>   	ARM64_FTR_REG(SYS_GMID_EL1, ftr_gmid),
> @@@ -2701,33 -2817,13 +2779,40 @@@ static const struct arm64_cpu_capabilit
>   		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
>   		.matches = has_lpa2,
>   	},
>  +#ifdef CONFIG_ARM64_VA_BITS_52
>  +	{
>  +		.capability = ARM64_HAS_VA52,
>  +		.type = ARM64_CPUCAP_BOOT_CPU_FEATURE,
>  +		.matches = has_cpuid_feature,
>  +		.field_width = 4,
>  +#ifdef CONFIG_ARM64_64K_PAGES
>  +		.desc = "52-bit Virtual Addressing (LVA)",
>  +		.sign = FTR_SIGNED,
>  +		.sys_reg = SYS_ID_AA64MMFR2_EL1,
>  +		.field_pos = ID_AA64MMFR2_EL1_VARange_SHIFT,
>  +		.min_field_value = ID_AA64MMFR2_EL1_VARange_52,
>  +#else
>  +		.desc = "52-bit Virtual Addressing (LPA2)",
>  +		.sys_reg = SYS_ID_AA64MMFR0_EL1,
>  +#ifdef CONFIG_ARM64_4K_PAGES
>  +		.sign = FTR_SIGNED,
>  +		.field_pos = ID_AA64MMFR0_EL1_TGRAN4_SHIFT,
>  +		.min_field_value = ID_AA64MMFR0_EL1_TGRAN4_52_BIT,
>  +#else
>  +		.sign = FTR_UNSIGNED,
>  +		.field_pos = ID_AA64MMFR0_EL1_TGRAN16_SHIFT,
>  +		.min_field_value = ID_AA64MMFR0_EL1_TGRAN16_52_BIT,
>  +#endif
>  +#endif
>  +	},
>  +#endif
> + 	{
> + 		.desc = "NV1",
> + 		.capability = ARM64_HAS_HCR_NV1,
> + 		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
> + 		.matches = has_nv1,
> + 		ARM64_CPUID_FIELDS_NEG(ID_AA64MMFR4_EL1, E2H0, NI_NV1)
> + 	},
>   	{},
>   };

Thanks Stephen. It looks fine.

-- 
Catalin

