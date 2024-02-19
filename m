Return-Path: <linux-kernel+bounces-71592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7483B85A780
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 16:35:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4B94B23FFE
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 15:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E45338F9F;
	Mon, 19 Feb 2024 15:35:24 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BB36381CE;
	Mon, 19 Feb 2024 15:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708356924; cv=none; b=dqvLQn4HDkIkpqp/hxQcNBQjlLXhpNpTxRSUzcCc9DDSxxw1wkcvSE6bDSDJ2p0SxX+eHUwH24R7t5GifGvbqfo74cwbP9HcwkXn11udyrCXqHYpXVVmueBWicO4s+gnvWNB8MVBgZxHQQGqayKiMA3jC20kG/JR8I6LWx76J18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708356924; c=relaxed/simple;
	bh=gWExRT6udu7I7jl7GjueXlupno17y2YrXS0ghER5g9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q+yeL6exu54Ak51Gma/ZefyQgj4xTzKlpLCoOSS5na9FDCskYqv7nfA3pu0EMJ1YKsrWUipJe0v334QztYtgPYAjDQ09I2egJgeZz1wQvgXEsSNmKWob8wcUgj78eWzJfjqfAMMlLE4/3FA+UJwQ/K3yTNs3dordZV6wX0rwN1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A15CEFEC;
	Mon, 19 Feb 2024 07:35:57 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.64.104])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7E8103F762;
	Mon, 19 Feb 2024 07:35:16 -0800 (PST)
Date: Mon, 19 Feb 2024 15:35:08 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Marc Zyngier <maz@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Christoffer Dall <cdall@cs.columbia.edu>,
	Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>
Subject: Re: linux-next: manual merge of the kvm-arm tree with the arm64 tree
Message-ID: <ZdN1LGKRwcwfhvKB@FVFF77S0Q05N>
References: <20240219135805.1c4138a3@canb.auug.org.au>
 <ZdNGGrUDWfvqCudV@arm.com>
 <86bk8c4gyh.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86bk8c4gyh.wl-maz@kernel.org>

On Mon, Feb 19, 2024 at 03:22:14PM +0000, Marc Zyngier wrote:
> From f24638a5f41424faf47f3d9035e6dcbd3800fcb6 Mon Sep 17 00:00:00 2001
> From: Marc Zyngier <maz@kernel.org>
> Date: Mon, 19 Feb 2024 15:13:22 +0000
> Subject: [PATCH] arm64: Use Signed/Unsigned enums for TGRAN{4,16,64} and
>  VARange
> 
> Open-coding the feature matching parameters for LVA/LVA2 leads to
> issues with upcoming changes to the cpufeature code.
> 
> By making TGRAN{4,16,64} and VARange signed/unsigned as per the
> architecture, we can use the existing macros, making the feature
> match robust against those changes.
> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>

I think this is the right thing to do; the patch itself looks good to me, so
FWIW:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  arch/arm64/kernel/cpufeature.c | 15 +++------------
>  arch/arm64/tools/sysreg        |  8 ++++----
>  2 files changed, 7 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index 8f9665e8774b..2119e9dd0c4e 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -2791,24 +2791,15 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
>  		.capability = ARM64_HAS_VA52,
>  		.type = ARM64_CPUCAP_BOOT_CPU_FEATURE,
>  		.matches = has_cpuid_feature,
> -		.field_width = 4,
>  #ifdef CONFIG_ARM64_64K_PAGES
>  		.desc = "52-bit Virtual Addressing (LVA)",
> -		.sign = FTR_SIGNED,
> -		.sys_reg = SYS_ID_AA64MMFR2_EL1,
> -		.field_pos = ID_AA64MMFR2_EL1_VARange_SHIFT,
> -		.min_field_value = ID_AA64MMFR2_EL1_VARange_52,
> +		ARM64_CPUID_FIELDS(ID_AA64MMFR2_EL1, VARange, 52)
>  #else
>  		.desc = "52-bit Virtual Addressing (LPA2)",
> -		.sys_reg = SYS_ID_AA64MMFR0_EL1,
>  #ifdef CONFIG_ARM64_4K_PAGES
> -		.sign = FTR_SIGNED,
> -		.field_pos = ID_AA64MMFR0_EL1_TGRAN4_SHIFT,
> -		.min_field_value = ID_AA64MMFR0_EL1_TGRAN4_52_BIT,
> +		ARM64_CPUID_FIELDS(ID_AA64MMFR0_EL1, TGRAN4, 52_BIT)
>  #else
> -		.sign = FTR_UNSIGNED,
> -		.field_pos = ID_AA64MMFR0_EL1_TGRAN16_SHIFT,
> -		.min_field_value = ID_AA64MMFR0_EL1_TGRAN16_52_BIT,
> +		ARM64_CPUID_FIELDS(ID_AA64MMFR0_EL1, TGRAN16, 52_BIT)
>  #endif
>  #endif
>  	},
> diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
> index fa3fe0856880..670a33fca3bc 100644
> --- a/arch/arm64/tools/sysreg
> +++ b/arch/arm64/tools/sysreg
> @@ -1540,16 +1540,16 @@ Enum	35:32	TGRAN16_2
>  	0b0010	IMP
>  	0b0011	52_BIT
>  EndEnum
> -Enum	31:28	TGRAN4
> +SignedEnum	31:28	TGRAN4
>  	0b0000	IMP
>  	0b0001	52_BIT
>  	0b1111	NI
>  EndEnum
> -Enum	27:24	TGRAN64
> +SignedEnum	27:24	TGRAN64
>  	0b0000	IMP
>  	0b1111	NI
>  EndEnum
> -Enum	23:20	TGRAN16
> +UnsignedEnum	23:20	TGRAN16
>  	0b0000	NI
>  	0b0001	IMP
>  	0b0010	52_BIT
> @@ -1697,7 +1697,7 @@ Enum	23:20	CCIDX
>  	0b0000	32
>  	0b0001	64
>  EndEnum
> -Enum	19:16	VARange
> +UnsignedEnum	19:16	VARange
>  	0b0000	48
>  	0b0001	52
>  EndEnum
> -- 
> 2.39.2
> 
> 
> -- 
> Without deviation from the norm, progress is not possible.

