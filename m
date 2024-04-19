Return-Path: <linux-kernel+bounces-151592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AEE98AB0D7
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 16:37:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88D641C21A2A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 14:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B51A712E1E7;
	Fri, 19 Apr 2024 14:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GdkCOTLd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02BCE85C6C;
	Fri, 19 Apr 2024 14:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713537439; cv=none; b=YIE/RPCM/QsYx9ReG/baWrsmBPAIRhAymg/e91nVR/JlxnDOfeRrcsvL6gD29vNunml9j2SSTjiGc1btYypbIewjmIcCD+XFu5i5EXqs7e5hRChSi5kaMLqC8WvyF71CEXNBYjCpRoWjvsMzRmmiPE248kjoGk41O3oi7dsF/+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713537439; c=relaxed/simple;
	bh=JkAHRjfxu4Qjq8Y/LEAkgUceMDR3NN3t0G4oqLoLsaw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ClVUFrrvZhysOzRbZYeYLHMoVkNUVlvOH1Vrk5qPGWGdafg2obwzyMbBFMiDfDrtEIJzgM16t48/HmjQ9Vp2h1+bw2JwGA+1TKYqx4ssSqrnW+K9JHJsTXHf4CMd4FW/+xKvJwsBmGNBwL2OyNzZP/9Wc03g7fRNtN7gB5mJEjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GdkCOTLd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EED6CC072AA;
	Fri, 19 Apr 2024 14:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713537438;
	bh=JkAHRjfxu4Qjq8Y/LEAkgUceMDR3NN3t0G4oqLoLsaw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GdkCOTLdBieuMPvW/9e/28Vn0guU0gGfX2iZVwYnsd2Tw3VBdLm2empa1flGGpEFG
	 hJmwlZhVBAZHXTC7/tMjg1LMvk7UMozaQQb3YrmWjRs0qLwFlElPxj8KF0SA3/aSYq
	 DPqlqeNPaApEhZcIdEYGgQl0kPezQ+fLUbuqFEUcZ1BtwLkWN68OyNzZ7ol2YWjHDz
	 Kh1Z1SRtEWqhTrnJH/pWzt751I/tML/r0FrQgdPBR1YPAwVKjwf9jiw/KcF3IVyA1p
	 hc2NodWM5G3gQfVfq5h6o0auN2d/whUOYC2SHCzjyM1otSzr8XvUJGaL6u25QP1lZP
	 Ykqx4YmVXIAyw==
Date: Fri, 19 Apr 2024 15:37:12 +0100
From: Will Deacon <will@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Peter Zijlstra <peterz@infradead.org>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 1/2] cpu: Re-enable CPU mitigations by default for !X86
 architectures
Message-ID: <20240419143712.GA3458@willie-the-truck>
References: <20240417001507.2264512-1-seanjc@google.com>
 <20240417001507.2264512-2-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240417001507.2264512-2-seanjc@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Tue, Apr 16, 2024 at 05:15:06PM -0700, Sean Christopherson wrote:
> Add a generic Kconfig, CPU_MITIGATIONS, to control whether or not CPU
> mitigations are enabled by default, and force it on for all architectures
> except x86.  A recent commit to turn mitigations off by default if
> SPECULATION_MITIGATIONS=n kinda sorta missed that "cpu_mitigations" is
> completely generic, where as SPECULATION_MITIGATIONS is x86 specific.
> 
> Alternatively, SPECULATION_MITIGATIONS could simply be defined in common
> code, but that creates weirdness for x86 because SPECULATION_MITIGATIONS
> ends up being defined twice, and the default behavior would likely depend
> on the arbitrary include order (if the two definitions diverged).
> 
> Ideally, CPU_MITIGATIONS would be unconditionally on by default for all
> architectures, and manually turned off, but there is no way to unselect a
> Kconfig.
> 
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Reported-by: Michael Ellerman <mpe@ellerman.id.au>
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Closes: https://lkml.kernel.org/r/20240413115324.53303a68%40canb.auug.org.au
> Fixes: f337a6a21e2f ("x86/cpu: Actually turn off mitigations by default for SPECULATION_MITIGATIONS=n")
> Cc: stable@vger.kernel.org
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/Kconfig     | 1 +
>  drivers/base/Kconfig | 3 +++
>  kernel/cpu.c         | 4 ++--
>  3 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 4474bf32d0a4..a0eca6313276 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -2490,6 +2490,7 @@ config PREFIX_SYMBOLS
>  
>  menuconfig SPECULATION_MITIGATIONS
>  	bool "Mitigations for speculative execution vulnerabilities"
> +	select CPU_MITIGATIONS
>  	default y
>  	help
>  	  Say Y here to enable options which enable mitigations for
> diff --git a/drivers/base/Kconfig b/drivers/base/Kconfig
> index 2b8fd6bb7da0..dab19f15fa57 100644
> --- a/drivers/base/Kconfig
> +++ b/drivers/base/Kconfig
> @@ -191,6 +191,9 @@ config GENERIC_CPU_AUTOPROBE
>  config GENERIC_CPU_VULNERABILITIES
>  	bool
>  
> +config CPU_MITIGATIONS
> +	def_bool !X86
> +
>  config SOC_BUS
>  	bool
>  	select GLOB
> diff --git a/kernel/cpu.c b/kernel/cpu.c
> index 07ad53b7f119..bb0ff275fb46 100644
> --- a/kernel/cpu.c
> +++ b/kernel/cpu.c
> @@ -3207,8 +3207,8 @@ enum cpu_mitigations {
>  };
>  
>  static enum cpu_mitigations cpu_mitigations __ro_after_init =
> -	IS_ENABLED(CONFIG_SPECULATION_MITIGATIONS) ? CPU_MITIGATIONS_AUTO :
> -						     CPU_MITIGATIONS_OFF;
> +	IS_ENABLED(CONFIG_CPU_MITIGATIONS) ? CPU_MITIGATIONS_AUTO :
> +					     CPU_MITIGATIONS_OFF;
>  
>  static int __init mitigations_parse_cmdline(char *arg)
>  {
> -- 
> 2.44.0.683.g7961c838ac-goog

Thanks, Sean!

Acked-by: Will Deacon <will@kernel.org>

Will

