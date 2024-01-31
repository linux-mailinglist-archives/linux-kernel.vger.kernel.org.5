Return-Path: <linux-kernel+bounces-46627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F35184422C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 15:50:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48A5BB2326C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 14:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90FF784A3B;
	Wed, 31 Jan 2024 14:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QW+u4gkx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE81084A25;
	Wed, 31 Jan 2024 14:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706712581; cv=none; b=IPjKnuUAKAyQvdmnJVsio/rmvjepDTKYEMXqBQtjYIld+X6cDOSjQgRRTcY+zMa65GEWX6c8C3xJyVzxRazKKpMkL/YHXoZD6m1nY0bqFb5Wk28rdljc6bZSUUoau4EmXsxIiKVPzhkAEE03ZAwtvTzobIV3LKJQItpqnHPxnWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706712581; c=relaxed/simple;
	bh=2yHAEIfWo9jtDG3p0AkHhbA/aM0nxnP2vXRtqVa7teY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=of1j+/5tEnySYCkBCNiEzjgVL3GOVNdhNCz8HOvDTpQDWSBkaMzdds5kkNG/wVDFNUgWmeGuDM2/aBkUnQFGOd+3vnnpkXze3VL7Lr9TWJnEFixNZY7S+khQZ0Ncv6TQjjonpNonJvf0Yl+81CCX7dueCYmQ9I24p488AbCNDzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QW+u4gkx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDC5CC433C7;
	Wed, 31 Jan 2024 14:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706712581;
	bh=2yHAEIfWo9jtDG3p0AkHhbA/aM0nxnP2vXRtqVa7teY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QW+u4gkxi4Y+A1kx9nhpvAQ1EP8rM+k3jqjMGovujJJB59p7806HWkXfBEj0gLi/3
	 dpE9ybCf48GATqlB1ESTepI2Vpc3Gz5mcuduAC0xO4CA3jImqCFl1onHVBM3vgNgve
	 P7WRiiNDNwbi/bBxQFbHMPjLCcSFpaECoKh3R4IzGBz8kKHS0VLNM+83cFVzXFslcS
	 ElzySdf458R0htk5byWFQGchyYXTxhGF1QstYas278sioSKd3GxQvzlRYyXl412lt1
	 JdArA3NOIlG6ngKW+zO3XK46/bMum/FZUw4ptS5PISyPW2hhEUfe+LEN6JUngCsW63
	 Vc+Yrx6EsRs4Q==
Date: Wed, 31 Jan 2024 08:49:39 -0600
From: Rob Herring <robh@kernel.org>
To: Alexander Graf <graf@amazon.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-mm@kvack.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kexec@lists.infradead.org,
	linux-doc@vger.kernel.org, x86@kernel.org,
	Eric Biederman <ebiederm@xmission.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Ashish Kalra <ashish.kalra@amd.com>,
	James Gowans <jgowans@amazon.com>,
	Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
	arnd@arndb.de, pbonzini@redhat.com, madvenka@linux.microsoft.com,
	Anthony Yznaga <anthony.yznaga@oracle.com>,
	Usama Arif <usama.arif@bytedance.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v3 08/17] arm64: Add KHO support
Message-ID: <20240131144939.GA1241147-robh@kernel.org>
References: <20240117144704.602-1-graf@amazon.com>
 <20240117144704.602-9-graf@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240117144704.602-9-graf@amazon.com>

On Wed, Jan 17, 2024 at 02:46:55PM +0000, Alexander Graf wrote:
> We now have all bits in place to support KHO kexecs. This patch adds
> awareness of KHO in the kexec file as well as boot path for arm64 and
> adds the respective kconfig option to the architecture so that it can
> use KHO successfully.
> 
> Signed-off-by: Alexander Graf <graf@amazon.com>
> 
> ---
> 
> v1 -> v2:
> 
>   - test bot warning fix
>   - Change kconfig option to ARCH_SUPPORTS_KEXEC_KHO
>   - s/kho_reserve_mem/kho_reserve_previous_mem/g
>   - s/kho_reserve/kho_reserve_scratch/g
>   - Remove / reduce ifdefs for kho fdt code
> ---
>  arch/arm64/Kconfig        |  3 +++
>  arch/arm64/kernel/setup.c |  2 ++
>  arch/arm64/mm/init.c      |  8 ++++++
>  drivers/of/fdt.c          | 39 ++++++++++++++++++++++++++++
>  drivers/of/kexec.c        | 54 +++++++++++++++++++++++++++++++++++++++
>  5 files changed, 106 insertions(+)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 8f6cf1221b6a..44d8923d9db4 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -1496,6 +1496,9 @@ config ARCH_SUPPORTS_KEXEC_IMAGE_VERIFY_SIG
>  config ARCH_DEFAULT_KEXEC_IMAGE_VERIFY_SIG
>  	def_bool y
>  
> +config ARCH_SUPPORTS_KEXEC_KHO
> +	def_bool y
> +
>  config ARCH_SUPPORTS_CRASH_DUMP
>  	def_bool y
>  
> diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
> index 417a8a86b2db..9aa05b84d202 100644
> --- a/arch/arm64/kernel/setup.c
> +++ b/arch/arm64/kernel/setup.c
> @@ -346,6 +346,8 @@ void __init __no_sanitize_address setup_arch(char **cmdline_p)
>  
>  	paging_init();
>  
> +	kho_reserve_previous_mem();
> +
>  	acpi_table_upgrade();
>  
>  	/* Parse the ACPI tables for possible boot-time configuration */
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index 74c1db8ce271..1a8fc91509af 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -358,6 +358,8 @@ void __init bootmem_init(void)
>  	 */
>  	arch_reserve_crashkernel();
>  
> +	kho_reserve_scratch();
> +
>  	memblock_dump_all();
>  }
>  
> @@ -386,6 +388,12 @@ void __init mem_init(void)
>  	/* this will put all unused low memory onto the freelists */
>  	memblock_free_all();
>  
> +	/*
> +	 * Now that all KHO pages are marked as reserved, let's flip them back
> +	 * to normal pages with accurate refcount.
> +	 */
> +	kho_populate_refcount();
> +
>  	/*
>  	 * Check boundaries twice: Some fundamental inconsistencies can be
>  	 * detected at build time already.
> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> index bf502ba8da95..f9b9a36fb722 100644
> --- a/drivers/of/fdt.c
> +++ b/drivers/of/fdt.c
> @@ -1006,6 +1006,42 @@ void __init early_init_dt_check_for_usable_mem_range(void)
>  		memblock_add(rgn[i].base, rgn[i].size);
>  }
>  
> +/**
> + * early_init_dt_check_kho - Decode info required for kexec handover from DT
> + */
> +static void __init early_init_dt_check_kho(void)
> +{
> +	unsigned long node = chosen_node_offset;
> +	u64 kho_start, scratch_start, scratch_size, mem_start, mem_size;
> +	const __be32 *p;
> +	int l;
> +
> +	if (!IS_ENABLED(CONFIG_KEXEC_KHO) || (long)node < 0)
> +		return;
> +
> +	p = of_get_flat_dt_prop(node, "linux,kho-dt", &l);

These need to be documented. chosen node schema lives in dtschema.

> +	if (l != (dt_root_addr_cells + dt_root_size_cells) * sizeof(__be32))
> +		return;

I would just make all these fixed 64-bit values rather than based on 
address and size cells. That's what we've done on more recent chosen 
properties describing regions.

Rob

