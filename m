Return-Path: <linux-kernel+bounces-23684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0C5D82B000
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 14:55:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5E531C23ACA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 13:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FBB932C90;
	Thu, 11 Jan 2024 13:55:03 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6970F1804A
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 13:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 722292F4;
	Thu, 11 Jan 2024 05:55:45 -0800 (PST)
Received: from FVFF77S0Q05N.cambridge.arm.com (FVFF77S0Q05N.cambridge.arm.com [10.1.35.168])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C8E873F73F;
	Thu, 11 Jan 2024 05:54:58 -0800 (PST)
Date: Thu, 11 Jan 2024 13:54:56 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Rob Herring <robh@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] arm64: errata: Add Cortex-A510 speculative
 unprivileged load workaround
Message-ID: <ZZ_zMHQdIXwZEpkq@FVFF77S0Q05N.cambridge.arm.com>
References: <20240110-arm-errata-a510-v1-0-d02bc51aeeee@kernel.org>
 <20240110-arm-errata-a510-v1-2-d02bc51aeeee@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240110-arm-errata-a510-v1-2-d02bc51aeeee@kernel.org>

On Wed, Jan 10, 2024 at 11:29:21AM -0600, Rob Herring wrote:
> Implement the workaround for ARM Cortex-A510 erratum 3117295. On an
> affected Cortex-A510 core, a speculatively executed unprivileged load
> might leak data from a privileged load via a cache side channel. The
> issue only exists for loads within a translation regime with the same
> translation (e.g. same ASID and VMID). Therefore, the issue only affects
> the return to EL0.
> 
> The erratum and workaround are the same as ARM Cortex-A520 erratum
> 2966298, so reuse the existing workaround.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/arch/arm64/silicon-errata.rst |  2 ++
>  arch/arm64/Kconfig                          | 14 ++++++++++++++
>  arch/arm64/kernel/cpu_errata.c              | 17 +++++++++++++++--
>  3 files changed, 31 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/arch/arm64/silicon-errata.rst b/Documentation/arch/arm64/silicon-errata.rst
> index f47f63bcf67c..7acd64c61f50 100644
> --- a/Documentation/arch/arm64/silicon-errata.rst
> +++ b/Documentation/arch/arm64/silicon-errata.rst
> @@ -71,6 +71,8 @@ stable kernels.
>  +----------------+-----------------+-----------------+-----------------------------+
>  | ARM            | Cortex-A510     | #2658417        | ARM64_ERRATUM_2658417       |
>  +----------------+-----------------+-----------------+-----------------------------+
> +| ARM            | Cortex-A510     | #3117295        | ARM64_ERRATUM_3117295       |
> ++----------------+-----------------+-----------------+-----------------------------+
>  | ARM            | Cortex-A520     | #2966298        | ARM64_ERRATUM_2966298       |
>  +----------------+-----------------+-----------------+-----------------------------+
>  | ARM            | Cortex-A53      | #826319         | ARM64_ERRATUM_826319        |
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index ba9f6ceddbbe..456e8680e16e 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -1054,6 +1054,20 @@ config ARM64_ERRATUM_2966298
>  
>  	  If unsure, say Y.
>  
> +config ARM64_ERRATUM_3117295
> +	bool "Cortex-A510: 3117295: workaround for speculatively executed unprivileged load"
> +	select ARM64_WORKAROUND_SPECULATIVE_UNPRIV_LOAD
> +	default y
> +	help
> +	  This option adds the workaround for ARM Cortex-A510 erratum 3117295.
> +
> +	  On an affected Cortex-A510 core, a speculatively executed unprivileged
> +	  load might leak data from a privileged level via a cache side channel.
> +
> +	  Work around this problem by executing a TLBI before returning to EL0.
> +
> +	  If unsure, say Y.
> +
>  config CAVIUM_ERRATUM_22375
>  	bool "Cavium erratum 22375, 24313"
>  	default y
> diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
> index cb5e0622168d..8b69fa296470 100644
> --- a/arch/arm64/kernel/cpu_errata.c
> +++ b/arch/arm64/kernel/cpu_errata.c
> @@ -416,6 +416,19 @@ static struct midr_range broken_aarch32_aes[] = {
>  };
>  #endif /* CONFIG_ARM64_WORKAROUND_TRBE_WRITE_OUT_OF_RANGE */
>  
> +#ifdef CONFIG_ARM64_WORKAROUND_SPECULATIVE_UNPRIV_LOAD
> +static const struct midr_range erratum_spec_unpriv_load_list[] = {
> +#ifdef CONFIG_ARM64_ERRATUM_3117295
> +	MIDR_ALL_VERSIONS(MIDR_CORTEX_A510),
> +#endif
> +#ifdef CONFIG_ARM64_ERRATUM_2966298
> +	/* Cortex-A520 r0p0 to r0p1 */
> +	MIDR_REV_RANGE(MIDR_CORTEX_A520, 0, 0, 1),
> +#endif
> +	{},
> +};
> +#endif
> +
>  const struct arm64_cpu_capabilities arm64_errata[] = {
>  #ifdef CONFIG_ARM64_WORKAROUND_CLEAN_CACHE
>  	{
> @@ -715,10 +728,10 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
>  #endif
>  #ifdef CONFIG_ARM64_WORKAROUND_SPECULATIVE_UNPRIV_LOAD
>  	{
> -		.desc = "ARM erratum 2966298",
> +		.desc = "ARM erratum 2966298 and 3117295",

Minor nit: s/and/or/

>  		.capability = ARM64_WORKAROUND_SPECULATIVE_UNPRIV_LOAD,
>  		/* Cortex-A520 r0p0 - r0p1 */
> -		ERRATA_MIDR_REV_RANGE(MIDR_CORTEX_A520, 0, 0, 1),
> +		ERRATA_MIDR_RANGE_LIST(erratum_spec_unpriv_load_list),
>  	},
>  #endif
>  #ifdef CONFIG_AMPERE_ERRATUM_AC03_CPU_38

Regardless of the nit above, this looks good to me.

I applied this atop the v6.7 (with the prior patch), and checked the following combinations:

	CONFIG_ARM64_ERRATUM_3117295=y && CONFIG_ARM64_ERRATUM_2966298=y
	CONFIG_ARM64_ERRATUM_3117295=y && CONFIG_ARM64_ERRATUM_2966298=n
	CONFIG_ARM64_ERRATUM_3117295=n && CONFIG_ARM64_ERRATUM_2966298=y
	CONFIG_ARM64_ERRATUM_3117295=n && CONFIG_ARM64_ERRATUM_2966298=n

On all cases the resulting Kconfig looked good i.e.
CONFIG_ARM64_WORKAROUND_CLEAN_CACHE was only selected when at least one of
those was selected), and the kernel built cleanly and booted fine for each
configuration.

I don't have a Cortex-A510 to test on, but I see no reason that this shouldn't
work as described.

With or without the "s/and/or/" fixup above:

Reviewed-by: Mark Rutland <mark.rutland@arm.com>

Catalin, Will, I assume you'd be happy to adjust that when applying, so there's
no reason to send a v2.

Mark.

