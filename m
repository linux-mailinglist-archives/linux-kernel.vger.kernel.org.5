Return-Path: <linux-kernel+bounces-107751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C787D880141
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 16:56:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7499E1F24207
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 15:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38E2B657C9;
	Tue, 19 Mar 2024 15:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lfZms955"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1517FBAB
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 15:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710863782; cv=none; b=odFyLHM6cr4TBnSqg+/lHo5a1nbfUcrXNwot9B+AkAoq3+FVFxZ9GLyAEDrfKnjX6zEiva172H/c7zqvcpkgWs81GNW0xmz/ZmWzBaGxx8kFoHNQ6RjqZrARDywfiBUAdiqSYWLjGH8dzCditAyT4r4ahmcuGLWYnPhkI2Pdel8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710863782; c=relaxed/simple;
	bh=txdGx+DK7znFHGf/0tjjerKq64zYiimbR1qcsYKXEwc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HeadZdZmSuH3W5VFboDXP2o0asMHZehVGfRyAE7o8aIVxc2zW5WoyuWZNhR/q4GmQnnf5VlmrlYKFle9mHPq0bxRUMmAO7UfKGba0FII+vyj5AmNY7QqFSysvqJLQdpZILhjnedWFZ+eIrIcuTSoZqm3ATibmZIst+U8sNGCijY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lfZms955; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A3ADC433C7;
	Tue, 19 Mar 2024 15:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710863782;
	bh=txdGx+DK7znFHGf/0tjjerKq64zYiimbR1qcsYKXEwc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lfZms95528UbY5tS+DZlHXPvGdfzpILgEyRdEPXRU5/FevqAaYzJl8l/uYMo4T/5g
	 G0KyQQL1bDZ+4bh8Z2JpuF/vI2koqKVWwjHxmAAKVy1CXZGfnqxhj9vxhcyHNify9p
	 6Hssk2wpYQDvFdCUEoWvFulZMmMqWZKThqWCh/zrXHvbfWOIWk2Ra2Qk7Dx8CvPKAv
	 3IMLgBimgp08RRx/QskyZowU2DD05VdT+48IKH/xLbqpjBdhdIfUadK786BPq7ufGS
	 cnhAkC4Re/eeuHZ1CNF8nhxVApf/051Ax2LlqJjwZTl4ZLb9+SijLBMaboTC68D/uC
	 6Xibd+2/5wFSA==
Date: Tue, 19 Mar 2024 15:56:16 +0000
From: Will Deacon <will@kernel.org>
To: Conor Dooley <conor@kernel.org>, catalin.marinas@arm.com
Cc: linux-riscv@lists.infradead.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ji Sheng Teoh <jisheng.teoh@starfivetech.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] perf: starfive: fix 64-bit only COMPILE_TEST condition
Message-ID: <20240319155616.GC2901@willie-the-truck>
References: <20240318-emphatic-rally-f177a4fe1bdc@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240318-emphatic-rally-f177a4fe1bdc@spud>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Mon, Mar 18, 2024 at 03:35:04PM +0000, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> ARCH_STARFIVE is not restricted to 64-bit platforms, so while Will's
> addition of a 64-bit only condition satisfied the build robots doing
> COMPILE_TEST builds, Palmer ran into the same problems with writeq()
> being undefined during regular rv32 builds.
> 
> Promote the dependency on 64-bit to its own `depends on` so that the
> driver can never be included in 32-bit builds.
> 
> Reported-by: Palmer Dabbelt <palmer@rivosinc.com>
> Fixes: c2b24812f7bc ("perf: starfive: Add StarLink PMU support")
> Fixes: f0dbc6d0de38 ("perf: starfive: Only allow COMPILE_TEST for 64-bit architectures")
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
> CC: Will Deacon <will@kernel.org>
> CC: Mark Rutland <mark.rutland@arm.com>
> CC: Ji Sheng Teoh <jisheng.teoh@starfivetech.com>
> CC: linux-arm-kernel@lists.infradead.org
> CC: linux-kernel@vger.kernel.org
> ---
>  drivers/perf/Kconfig | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
> index 5060e1f1ea10..7526a9e714fa 100644
> --- a/drivers/perf/Kconfig
> +++ b/drivers/perf/Kconfig
> @@ -87,7 +87,8 @@ config RISCV_PMU_SBI
>  	  filtering, counter configuration.
>  
>  config STARFIVE_STARLINK_PMU
> -	depends on ARCH_STARFIVE || (COMPILE_TEST && 64BIT)
> +	depends on ARCH_STARFIVE || COMPILE_TEST
> +	depends on 64BIT
>  	bool "StarFive StarLink PMU"
>  	help
>  	   Provide support for StarLink Performance Monitor Unit.
> -- 
> 2.43.0


Thanks guys, I don't know what a starfive is so sorry for not spotting
this when I noticed the build failure on arm64.

Acked-by: Will Deacon <will@kernel.org>

Catalin -- please can you pick this into the arm64 fixes branch for -rc1?

Cheers,

Will

