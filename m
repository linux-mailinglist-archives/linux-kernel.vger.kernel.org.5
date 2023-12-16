Return-Path: <linux-kernel+bounces-2180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78691815910
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 13:45:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AE101C217AD
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 12:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA38318ED7;
	Sat, 16 Dec 2023 12:44:52 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80D6B154BA;
	Sat, 16 Dec 2023 12:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4D20E2F4;
	Sat, 16 Dec 2023 04:45:29 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 78DC73F762;
	Sat, 16 Dec 2023 04:44:42 -0800 (PST)
Date: Sat, 16 Dec 2023 12:44:33 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: James Clark <james.clark@arm.com>, will@kernel.org,
	catalin.marinas@arm.com
Cc: linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org,
	linux-next@vger.kernel.org, u.kleine-koenig@pengutronix.de,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v2 1/1] arm: perf: Fix ARCH=arm build with GCC
Message-ID: <ZX2bsYEdWVxTCiTi@FVFF77S0Q05N>
References: <20231215175648.3397170-1-james.clark@arm.com>
 <20231215175648.3397170-2-james.clark@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231215175648.3397170-2-james.clark@arm.com>

On Fri, Dec 15, 2023 at 05:56:48PM +0000, James Clark wrote:
> LLVM ignores everything inside the if statement and doesn't generate
> errors, but GCC doesn't ignore it, resulting in the following error:
> 
>   drivers/perf/arm_pmuv3.c: In function 'armv8pmu_write_evtype':
>   include/linux/bits.h:34:29: error: left shift count >= width of type [-Werror=shift-count-overflow]
>   34 |         (((~UL(0)) - (UL(1) << (l)) + 1) & \
> 
> Fix it by using GENMASK_ULL which doesn't overflow on arm32 (even though
> the value is never used there).

It would be nice if this could explain the overflow problem, i.e.

| The GENMASK() macro creates masks of type unsigned long, and we use this to
| geenrate the ARMV8_PMU_EVTYPE_TH and ARMV8_PMU_EVTYPE_TC constants. These
| include bits above bit 31, and generating these requires shifting more than the
| size of unsigned long on 32-bit ARM.
| 
| Consequently when building for 32-bit arm, GCC warns about their use:
| 
|   drivers/perf/arm_pmuv3.c: In function 'armv8pmu_write_evtype':
|   include/linux/bits.h:34:29: error: left shift count >= width of type [-Werror=shift-count-overflow]
|   34 |         (((~UL(0)) - (UL(1) << (l)) + 1) & \
| 
| ... though LLVM does not warn as the actual usage is not reachable on 32-bit
| ARM due to `if (IS_ENABLED(...)` checks.
| 
| Avoid the warning by using GENMACK_ULL(), which doesn't overflow on 32-bit arm.

> Fixes: 3115ee021bfb ("arm64: perf: Include threshold control fields in PMEVTYPER mask")
> Reported-by: Uwe Kleine-K"onig <u.kleine-koenig@pengutronix.de>
> Closes: https://lore.kernel.org/linux-arm-kernel/20231215120817.h2f3akgv72zhrtqo@pengutronix.de/
> Signed-off-by: James Clark <james.clark@arm.com>

Thanks for this!

Acked-by: Mark Rutland <mark.rutland@arm.com>

Will, Catalin, the broken commit is queued in the arm64 for-next/perf branch
(and merged into for-next/core); is this something we can easily fold in?

Mark.

> ---
>  include/linux/perf/arm_pmuv3.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/perf/arm_pmuv3.h b/include/linux/perf/arm_pmuv3.h
> index 0f4d62ef3a9a..46377e134d67 100644
> --- a/include/linux/perf/arm_pmuv3.h
> +++ b/include/linux/perf/arm_pmuv3.h
> @@ -234,8 +234,8 @@
>   * PMXEVTYPER: Event selection reg
>   */
>  #define ARMV8_PMU_EVTYPE_EVENT	GENMASK(15, 0)	/* Mask for EVENT bits */
> -#define ARMV8_PMU_EVTYPE_TH	GENMASK(43, 32)
> -#define ARMV8_PMU_EVTYPE_TC	GENMASK(63, 61)
> +#define ARMV8_PMU_EVTYPE_TH	GENMASK_ULL(43, 32) /* arm64 only */
> +#define ARMV8_PMU_EVTYPE_TC	GENMASK_ULL(63, 61) /* arm64 only */
>  
>  /*
>   * Event filters for PMUv3
> -- 
> 2.34.1
> 

