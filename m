Return-Path: <linux-kernel+bounces-13459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92AD98206E7
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 16:39:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A03D281F8F
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 15:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83978BA37;
	Sat, 30 Dec 2023 15:39:26 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DDEEB66C;
	Sat, 30 Dec 2023 15:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alpha.franken.de
Received: from uucp by elvis.franken.de with local-rmail (Exim 3.36 #1)
	id 1rJacF-0004OV-00; Sat, 30 Dec 2023 15:47:07 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
	id 8EE31C028A; Sat, 30 Dec 2023 15:40:51 +0100 (CET)
Date: Sat, 30 Dec 2023 15:40:51 +0100
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] MIPS: Enable SPARSEMEM option unconditionally on
 64BIT
Message-ID: <ZZAr84wveFdBZ+hm@alpha.franken.de>
References: <20231028-mm-v1-0-45377cd158cf@flygoat.com>
 <20231028-mm-v1-1-45377cd158cf@flygoat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231028-mm-v1-1-45377cd158cf@flygoat.com>

On Sat, Oct 28, 2023 at 02:52:16PM +0100, Jiaxun Yang wrote:
> SPARSEMEM have been tested on Cavium and Loongson64 for a while
> and we are confident that they are working properly on 64bit
> systems.
> 
> Since it's almost certain for 64bit MIPS system to have a hole
> in memory space, SPARSEMEM will be more efficent for them.
> 
> Also promote platforms marked with SPARSEMEM_ENABLE before
> to SPARSEMEM_DEFAULT, as they tend to have huge holes in
> address space.
> 
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
>  arch/mips/Kconfig             | 13 ++++++++-----
>  arch/mips/loongson2ef/Kconfig |  4 ++--
>  2 files changed, 10 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index 76db82542519..d12e8f3c1d08 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -460,7 +460,7 @@ config MACH_LOONGSON2EF
>  
>  config MACH_LOONGSON64
>  	bool "Loongson 64-bit family of machines"
> -	select ARCH_SPARSEMEM_ENABLE
> +	select ARCH_SPARSEMEM_DEFAULT
>  	select ARCH_MIGHT_HAVE_PC_PARPORT
>  	select ARCH_MIGHT_HAVE_PC_SERIO
>  	select GENERIC_ISA_DMA_SUPPORT_BROKEN
> @@ -656,7 +656,7 @@ config SGI_IP22
>  config SGI_IP27
>  	bool "SGI IP27 (Origin200/2000)"
>  	select ARCH_HAS_PHYS_TO_DMA
> -	select ARCH_SPARSEMEM_ENABLE
> +	select ARCH_SPARSEMEM_DEFAULT
>  	select FW_ARC
>  	select FW_ARC64
>  	select ARC_CMDLINE_ONLY
> @@ -923,7 +923,7 @@ config CAVIUM_OCTEON_SOC
>  	select ZONE_DMA32
>  	select GPIOLIB
>  	select USE_OF
> -	select ARCH_SPARSEMEM_ENABLE
> +	select ARCH_SPARSEMEM_DEFAULT
>  	select SYS_SUPPORTS_SMP
>  	select NR_CPUS_DEFAULT_64
>  	select MIPS_NR_CPU_NR_MAP_1024
> @@ -2573,10 +2573,13 @@ config CPU_SUPPORTS_MSA
>  
>  config ARCH_FLATMEM_ENABLE
>  	def_bool y
> -	depends on !NUMA && !CPU_LOONGSON2EF
>  
>  config ARCH_SPARSEMEM_ENABLE
> -	bool
> +	def_bool y
> +	depends on 64BIT
> +
> +config ARCH_SELECT_MEMORY_MODEL
> +	def_bool ARCH_SPARSEMEM_ENABLE

maybe I'm blind, but I don't see ARCH_SPARSEMEM_DEFAULT declared in
Kconfig for MIPS. So what I'm missing ?

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]

