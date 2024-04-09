Return-Path: <linux-kernel+bounces-137292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62C0089E00A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 18:09:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 945421C21181
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 16:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 599E113D8AA;
	Tue,  9 Apr 2024 16:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NyPllkZe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF8413D88C
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 16:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712678961; cv=none; b=dHXWxFMCsOp10lSt21LgpDf8LLcB/gEbXx9d7rdOB7sEN9qeaX8WrwB0kAZm1IDlTF6Ufk9VWoifRKLyfjGuw5zFNmjLNhcjlP8rUhYKocQirY2etv5etS27GKiRKaslOo5IjQdCk0c/RWvVYJDMdwWIu+t4deh0t9sGay7c+zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712678961; c=relaxed/simple;
	bh=FuHhBnuMHW5KShI9lBYL3cbQoRz8uVMGSTwsNXS4Tcc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YD+AOdKmbt+XLpY2NdtyKxM6oDaMnHTLE+U/K1Tv5rjHNqnMTjgMkfo4XSi4yPY5AzctGMNAwn73r717YmDkK/0xvOtaJzUkQ050kQMDvDXu6d7geDkSmAdGMjKrfKRpOC1qSchB9PmiWJzYMYtS95ayzReRPVSeICxTNfZFEsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NyPllkZe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40430C433C7;
	Tue,  9 Apr 2024 16:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712678961;
	bh=FuHhBnuMHW5KShI9lBYL3cbQoRz8uVMGSTwsNXS4Tcc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NyPllkZeQg+Qk3wZ72d2oY/A34R5fUk70Q2hF4aIuPiY+cJJ2++O8PFwaIQQcMbhG
	 9HvHbWu9G8PTTl1nHn6YvMjUyg6J6LwTCkvt6MjzSfXUXxRrb6/KbsrtUwskhkdxzm
	 gjI87z+xp46MbaL2D3OGMnYZpJ8kkG1Sh2DShQuPinHMxE97JIeiklXkV5qTIix5pt
	 HiOUubWJW4aLxpMFwxxNJPgDoeDOb42Tx5fO3ag1hPT6coXagjG0c8l3qXF8zo3nvt
	 F9lroYy3PyHMugluqPMPZbABQce6XCxLOo5QRP0GCSvE3VsQa5kz4sJIEXo3KWJKn4
	 JqTpiXxPt6x+w==
Date: Tue, 9 Apr 2024 17:09:16 +0100
From: Will Deacon <will@kernel.org>
To: Yicong Yang <yangyicong@huawei.com>
Cc: mark.rutland@arm.com, catalin.marinas@arm.com, broonie@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	jonathan.cameron@huawei.com, prime.zeng@hisilicon.com,
	linuxarm@huawei.com, yangyicong@hisilicon.com
Subject: Re: [PATCH] arm64: arm_pmuv3: Correctly extract and check the PMUVer
Message-ID: <20240409160915.GA24004@willie-the-truck>
References: <20240408081158.15291-1-yangyicong@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240408081158.15291-1-yangyicong@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Mon, Apr 08, 2024 at 04:11:58PM +0800, Yicong Yang wrote:
> From: Yicong Yang <yangyicong@hisilicon.com>
> 
> Currently we're using "sbfx" to extract the PMUVer from ID_AA64DFR0_EL1
> and skip the init/reset if no PMU present when the extracted PMUVer is
> negative or is zero. However for PMUv3p8 the PMUVer will be 0b1000 and
> PMUVer extracted by "sbfx" will always be negative and we'll skip the
> init/reset in __init_el2_debug/reset_pmuserenr_el0 unexpectedly.
> 
> So this patch use "ubfx" instead of "sbfx" to extract the PMUVer. If
> the PMUVer is implementation defined (0b1111) then reset it to zero
> and skip the reset/init. Previously we'll also skip the init/reset
> if the PMUVer is higher than the version we known (currently PMUv3p9),
> with this patch we'll only skip if the PMU is not implemented or
> implementation defined. This keeps consistence with how we probe
> the PMU in the driver with pmuv3_implemented().
> 
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> ---
>  arch/arm64/include/asm/assembler.h | 5 ++++-
>  arch/arm64/include/asm/el2_setup.h | 5 ++++-
>  2 files changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
> index ab8b396428da..3b7373d6c565 100644
> --- a/arch/arm64/include/asm/assembler.h
> +++ b/arch/arm64/include/asm/assembler.h
> @@ -480,7 +480,10 @@ alternative_endif
>   */
>  	.macro	reset_pmuserenr_el0, tmpreg
>  	mrs	\tmpreg, id_aa64dfr0_el1
> -	sbfx	\tmpreg, \tmpreg, #ID_AA64DFR0_EL1_PMUVer_SHIFT, #4
> +	ubfx	\tmpreg, \tmpreg, #ID_AA64DFR0_EL1_PMUVer_SHIFT, #4
> +	cmp	\tmpreg, #ID_AA64DFR0_EL1_PMUVer_IMP_DEF
> +	csel	\tmpreg, xzr, \tmpreg, eq	// If PMU's IMP_DEF, regard it
> +						// as not implemented and skip
>  	cmp	\tmpreg, #1			// Skip if no PMU present
>  	b.lt	9000f
>  	msr	pmuserenr_el0, xzr		// Disable PMU access from EL0

I think the cmp/csel/cmp/b.lt sequence might be a little tidier if you
reworked it to use ccmp. For example, something like (totally untested):

	cmp	\tmpreg, ID_AA64DFR0_EL1_PMUVer_NI
	ccmp	\tmpreg, ID_AA64DFR0_EL1_PMUVer_IMP_DEF, #4, ne

would then, I think, mean we could just b.eq 9000f. But please check
this because encoding nzcv as an immediate always catches me out.

> diff --git a/arch/arm64/include/asm/el2_setup.h b/arch/arm64/include/asm/el2_setup.h
> index b7afaa026842..2438e12b60c5 100644
> --- a/arch/arm64/include/asm/el2_setup.h
> +++ b/arch/arm64/include/asm/el2_setup.h
> @@ -59,7 +59,10 @@
>  
>  .macro __init_el2_debug
>  	mrs	x1, id_aa64dfr0_el1
> -	sbfx	x0, x1, #ID_AA64DFR0_EL1_PMUVer_SHIFT, #4
> +	ubfx	x0, x1, #ID_AA64DFR0_EL1_PMUVer_SHIFT, #4
> +	cmp	x0, #ID_AA64DFR0_EL1_PMUVer_IMP_DEF
> +	csel	x0, xzr, x0, eq			// If PMU's IMP_DEF, regard it
> +						// as not implemented and skip
>  	cmp	x0, #1
>  	b.lt	.Lskip_pmu_\@			// Skip if no PMU present
>  	mrs	x0, pmcr_el0			// Disable debug access traps

Similar sort of thing here.

Will

