Return-Path: <linux-kernel+bounces-162060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 258508B5564
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 12:33:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE73C1F21EBC
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 10:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDA6A1D68F;
	Mon, 29 Apr 2024 10:33:29 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D9993A1CB;
	Mon, 29 Apr 2024 10:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714386809; cv=none; b=aCRkZ3ztHdyWUBNqa15o7bTpGVvzDomlE0tNj9jtVKUX2EHycwCpK3PHB22B51GAT9oWzyBpVVHupR1R1Ap9CUjj4rD9H2juO0z8FI/QGRLYJbHiJTDvug5V5CkGK6qQIu+6JzTgLHzN86uA8zUJHERghZr5no4GO1r9zxM1Brk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714386809; c=relaxed/simple;
	bh=oupRboKjBufdsvm0Be1u/ags3rlLK/JIk49zQPYmDH8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ANkyprROwmlC/fwbxh1B2qCwssGMZL8jxSfZwnSU+JmF5CjioSEarVSTlGMluTThiFe0MBWy7y8bgU7duye5IVtXps9lGqCCwjd7TQO++PNmDW6uIzR1AtkcFcqsn0UyX3LrwztsgxRQxAhMafMa0xOdAHJ/QhzDpgHktO7ULTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2B5832F4;
	Mon, 29 Apr 2024 03:33:53 -0700 (PDT)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D13E23F793;
	Mon, 29 Apr 2024 03:33:24 -0700 (PDT)
Date: Mon, 29 Apr 2024 11:33:21 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Dragan Simic <dsimic@manjaro.org>
Cc: linux-sunxi@lists.linux.dev, wens@csie.org, jernej.skrabec@gmail.com,
 samuel@sholland.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: allwinner: Add cache information to the SoC
 dtsi for A64
Message-ID: <20240429113321.1f4da653@donnerap.manchester.arm.com>
In-Reply-To: <6a772756c2c677dbdaaab4a2c71a358d8e4b27e9.1714304058.git.dsimic@manjaro.org>
References: <6a772756c2c677dbdaaab4a2c71a358d8e4b27e9.1714304058.git.dsimic@manjaro.org>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 28 Apr 2024 13:40:35 +0200
Dragan Simic <dsimic@manjaro.org> wrote:

Hi,

thanks for taking care of this!

> Add missing cache information to the Allwinner A64 SoC dtsi, to allow
> the userspace, which includes lscpu(1) that uses the virtual files provided
> by the kernel under the /sys/devices/system/cpu directory, to display the
> proper A64 cache information.
> 
> While there, use a more self-descriptive label for the L2 cache node, which
> also makes it more consistent with other SoC dtsi files.
> 
> The cache parameters for the A64 dtsi were obtained and partially derived
> by hand from the cache size and layout specifications found in the following
> datasheets and technical reference manuals:
> 
>   - Allwinner A64 datasheet, version 1.1
>   - ARM Cortex-A53 revision r0p3 TRM, version E
> 
> For future reference, here's a brief summary of the documentation:
> 
>   - All caches employ the 64-byte cache line length
>   - Each Cortex-A53 core has 32 KB of L1 2-way, set-associative instruction
>     cache and 32 KB of L1 4-way, set-associative data cache
>   - The entire SoC has 512 KB of unified L2 16-way, set-associative cache

So that looks correct when checking the manuals, and the per-CPU
entries below match both between themselves and with that description
above.
However I have some level of distrust towards the Allwinner manuals,
regarding the cache sizes (which are chosen by Allwinner).
So while I haven't measured this myself, nor checked the cache type
registers, tinymembench's memory latency test supports those sizes are
correct:
https://github.com/ssvb/tinymembench/wiki/PINE64-(Allwinner-A64)

> Signed-off-by: Dragan Simic <dsimic@manjaro.org>

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Cheers,
Andre

> ---
>  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 37 ++++++++++++++++---
>  1 file changed, 32 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> index 57ac18738c99..86074d03afa9 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> @@ -51,49 +51,76 @@ cpu0: cpu@0 {
>  			device_type = "cpu";
>  			reg = <0>;
>  			enable-method = "psci";
> -			next-level-cache = <&L2>;
>  			clocks = <&ccu CLK_CPUX>;
>  			clock-names = "cpu";
>  			#cooling-cells = <2>;
> +			i-cache-size = <0x8000>;
> +			i-cache-line-size = <64>;
> +			i-cache-sets = <256>;
> +			d-cache-size = <0x8000>;
> +			d-cache-line-size = <64>;
> +			d-cache-sets = <128>;
> +			next-level-cache = <&l2_cache>;
>  		};
>  
>  		cpu1: cpu@1 {
>  			compatible = "arm,cortex-a53";
>  			device_type = "cpu";
>  			reg = <1>;
>  			enable-method = "psci";
> -			next-level-cache = <&L2>;
>  			clocks = <&ccu CLK_CPUX>;
>  			clock-names = "cpu";
>  			#cooling-cells = <2>;
> +			i-cache-size = <0x8000>;
> +			i-cache-line-size = <64>;
> +			i-cache-sets = <256>;
> +			d-cache-size = <0x8000>;
> +			d-cache-line-size = <64>;
> +			d-cache-sets = <128>;
> +			next-level-cache = <&l2_cache>;
>  		};
>  
>  		cpu2: cpu@2 {
>  			compatible = "arm,cortex-a53";
>  			device_type = "cpu";
>  			reg = <2>;
>  			enable-method = "psci";
> -			next-level-cache = <&L2>;
>  			clocks = <&ccu CLK_CPUX>;
>  			clock-names = "cpu";
>  			#cooling-cells = <2>;
> +			i-cache-size = <0x8000>;
> +			i-cache-line-size = <64>;
> +			i-cache-sets = <256>;
> +			d-cache-size = <0x8000>;
> +			d-cache-line-size = <64>;
> +			d-cache-sets = <128>;
> +			next-level-cache = <&l2_cache>;
>  		};
>  
>  		cpu3: cpu@3 {
>  			compatible = "arm,cortex-a53";
>  			device_type = "cpu";
>  			reg = <3>;
>  			enable-method = "psci";
> -			next-level-cache = <&L2>;
>  			clocks = <&ccu CLK_CPUX>;
>  			clock-names = "cpu";
>  			#cooling-cells = <2>;
> +			i-cache-size = <0x8000>;
> +			i-cache-line-size = <64>;
> +			i-cache-sets = <256>;
> +			d-cache-size = <0x8000>;
> +			d-cache-line-size = <64>;
> +			d-cache-sets = <128>;
> +			next-level-cache = <&l2_cache>;
>  		};
>  
> -		L2: l2-cache {
> +		l2_cache: l2-cache {
>  			compatible = "cache";
>  			cache-level = <2>;
>  			cache-unified;
> +			cache-size = <0x80000>;
> +			cache-line-size = <64>;
> +			cache-sets = <512>;
>  		};
>  	};
>  
> 


