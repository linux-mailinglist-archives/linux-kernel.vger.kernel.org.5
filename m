Return-Path: <linux-kernel+bounces-62010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F3F851A09
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 17:51:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AC111F21C30
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 16:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21EF43D3A1;
	Mon, 12 Feb 2024 16:51:08 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 102F318E11
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 16:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707756667; cv=none; b=H3eRYs2xWPWce88Vzr7IYWQVq2oo2NKtcPczeOmskX38QJhXMaFDHyBJx+wNmCS27oakoPRxYkcpaVPGH7vGAfW7qtw/xFVYKWz7G/kMUlF8qlZoOhjX4rm22e/KtO4wiSuR/Ph79Xc9qZysdlhblXgBDs04NSf7OGI/phWT3B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707756667; c=relaxed/simple;
	bh=eB9xMFTkL9TOu4VQG3m74Dcn6+Ley2QNkFj53q4psxM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qj2L/lELtQzuU+KxQcenAKaH06UghAlN9EyKIcN2tie7D7yREg47CEqUF7DEGEnLjasmG8d6e488y+TCOOABhcQvvMdZfx0b3TRtGw+wAVYCu52/NhLGNv7Xqb8fi/PoLZV6tD9fzgDgFEWDJJwpGc2U9UQ6WAFEzrg4eY/en8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9A006DA7;
	Mon, 12 Feb 2024 08:51:42 -0800 (PST)
Received: from e133344.arm.com (e133344.arm.com [10.1.25.137])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3BD983F762;
	Mon, 12 Feb 2024 08:51:00 -0800 (PST)
Date: Mon, 12 Feb 2024 16:50:49 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: Mark Brown <broonie@kernel.org>
Cc: Will Deacon <will@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Oleg Nesterov <oleg@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH] arm64/sve: Lower the maximum allocation for the SVE
 ptrace regset
Message-ID: <ZcpMabqH+VZv6RCZ@e133344.arm.com>
References: <20240203-arm64-sve-ptrace-regset-size-v1-1-2c3ba1386b9e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240203-arm64-sve-ptrace-regset-size-v1-1-2c3ba1386b9e@kernel.org>

On Sat, Feb 03, 2024 at 12:16:49PM +0000, Mark Brown wrote:
> Doug Anderson observed that ChromeOS crashes are being reported which
> include failing allocations of order 7 during core dumps due to ptrace
> allocating storage for regsets:
> 
>   chrome: page allocation failure: order:7,
>           mode:0x40dc0(GFP_KERNEL|__GFP_COMP|__GFP_ZERO),
>           nodemask=(null),cpuset=urgent,mems_allowed=0
>    ...
>   regset_get_alloc+0x1c/0x28
>   elf_core_dump+0x3d8/0xd8c
>   do_coredump+0xeb8/0x1378
> 
> with further investigation showing that this is:
> 
>    [   66.957385] DOUG: Allocating 279584 bytes
> 
> which is the maximum size of the SVE regset. As Doug observes it is not
> entirely surprising that such a large allocation of contiguous memory might
> fail on a long running system.
> 
> The SVE regset is currently sized to hold SVE registers with a VQ of
> SVE_VQ_MAX which is 512, substantially more than the architectural maximum
> of 16 which we might see even in a system emulating the limits of the
> architecture. Since we don't expose the size we tell the regset core
> externally let's define ARCH_SVE_VQ_MAX with the actual architectural
> maximum and use that for the regset, we'll still overallocate most of the
> time but much less so which will be helpful even if the core is fixed to
> not require contiguous allocations.
> 
> We could also teach the ptrace core about runtime discoverable regset sizes
> but that would be a more invasive change and this is being observed in
> practical systems.
> 
> Reported-by: Doug Anderson <dianders@chromium.org>
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
> We should probably also use the actual architectural limit for the
> bitmasks we use in the VL enumeration code, though that's both a little
> bit more involved and less immediately a problem.
> ---
>  arch/arm64/include/asm/fpsimd.h | 10 +++++-----
>  arch/arm64/kernel/ptrace.c      |  3 ++-
>  2 files changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/fpsimd.h b/arch/arm64/include/asm/fpsimd.h
> index 50e5f25d3024..cf5f31181bc8 100644
> --- a/arch/arm64/include/asm/fpsimd.h
> +++ b/arch/arm64/include/asm/fpsimd.h
> @@ -62,12 +62,12 @@ static inline void cpacr_restore(unsigned long cpacr)
>   * When we defined the maximum SVE vector length we defined the ABI so
>   * that the maximum vector length included all the reserved for future
>   * expansion bits in ZCR rather than those just currently defined by
> - * the architecture. While SME follows a similar pattern the fact that
> - * it includes a square matrix means that any allocations that attempt
> - * to cover the maximum potential vector length (such as happen with
> - * the regset used for ptrace) end up being extremely large. Define
> - * the much lower actual limit for use in such situations.
> + * the architecture.  Using this length to allocate worst size buffers
> + * results in excessively large allocations, and this effect is even
> + * more pronounced for SME due to ZA.  Define more suitable VLs for
> + * these situations.
>   */
> +#define ARCH_SVE_VQ_MAX 16
>  #define SME_VQ_MAX	16
>  
>  struct task_struct;
> diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
> index dc6cf0e37194..e3bef38fc2e2 100644
> --- a/arch/arm64/kernel/ptrace.c
> +++ b/arch/arm64/kernel/ptrace.c
> @@ -1500,7 +1500,8 @@ static const struct user_regset aarch64_regsets[] = {
>  #ifdef CONFIG_ARM64_SVE
>  	[REGSET_SVE] = { /* Scalable Vector Extension */
>  		.core_note_type = NT_ARM_SVE,
> -		.n = DIV_ROUND_UP(SVE_PT_SIZE(SVE_VQ_MAX, SVE_PT_REGS_SVE),
> +		.n = DIV_ROUND_UP(SVE_PT_SIZE(ARCH_SVE_VQ_MAX,
> +					      SVE_PT_REGS_SVE),
>  				  SVE_VQ_BYTES),

Do we need an actual check somewhere that we don't bust this limit?

Since ZCR_ELx_LEN_MASK was changed from 0x1ff to 0xf, it looks like the
kernel itself will not generate an overlarge VL, although it feels a bit
like this guarantee arrives by accident.
Could ARCH_SVE_VQ_MAX be based on ZCR_ELx_LEN_MASK instead?

Userspace could specify vl > sve_vl_from_vq(ARCH_SVE_VQ_MAX) in
PTRACE_SETREGSET; I'm not sure exactly what happens there.

(The original 0x1ff value of ZCR_ELx_LEN_MASK was based on more than
just hope, but it does seem appropriate to restrict it now so that it
matches the formal architecture, as per commit f171f9e4097d
("arm64/fp: Make SVE and SME length register definition match
architecture") )

[...]

Cheers
---Dave

