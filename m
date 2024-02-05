Return-Path: <linux-kernel+bounces-53071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5C4984A055
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 18:12:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24AC51C20FE0
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 17:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 448BF40C1B;
	Mon,  5 Feb 2024 17:12:06 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3AD13FE5B
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 17:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707153125; cv=none; b=GzIjVLKQQgaT2h9NPlXlM317J3eVUOwZ3FyBs0BWuFNIyBlNmaMsmOpFF3HKUvut8CjwSkRj6z7WK+yRCrdVG91RdIcWUqWaaKxEM8OcW0sTcZdqqS41oP5+OeRf3sH1l9J0WqyZ5Yy8lLmo9RCDIKF1tYIPRD5l/WhSlL8EiHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707153125; c=relaxed/simple;
	bh=bi2p0U5H3l/JGdhwUZBQJnQDpvA0TfMCPc6RnXD0HTo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h3wDKrDD1Ea6/u2nBvNodWfRxKDGfxF8CpxKLQNgycwzzl+MH0rIgwKjoidCKuCt1DmQw7UerIvtV+CyfmwTRuu2GkLBvIt1vMmiBoF+9mSfsbDjZ+e6KvGEh79Yh1WS+k/kw75Z24N6IvD+EDfQtvseegVuvCokX0hAu+dxtMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3D5E01FB;
	Mon,  5 Feb 2024 09:12:45 -0800 (PST)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.58])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 812EB3F5A1;
	Mon,  5 Feb 2024 09:12:01 -0800 (PST)
Date: Mon, 5 Feb 2024 17:11:59 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: Mark Brown <broonie@kernel.org>
Cc: Will Deacon <will@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Oleg Nesterov <oleg@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH] arm64/sve: Lower the maximum allocation for the SVE
 ptrace regset
Message-ID: <ZcEW3y0IlEctOYBA@e133380.arm.com>
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

This is not hard at all: see
27e64b4be4b8 ("regset: Add support for dynamically sized regsets") 

But since this is precisely what was ripped out, I guess adding it back
may be controversial (?)

> 
> Reported-by: Doug Anderson <dianders@chromium.org>
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
> We should probably also use the actual architectural limit for the
> bitmasks we use in the VL enumeration code, though that's both a little
> bit more involved and less immediately a problem.

Since these masks are 64 bytes each and rarely accessed, it seemed
pointless complexity to make them resizeable...

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

Ack, though part of the reason for not doing this was to discourage
people from allocating statically sized buffers in general.

If the kernel is now juggling two #defines for the maximum vector size,
this feels like it may seed bitrot...

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
>  		.size = SVE_VQ_BYTES,
>  		.align = SVE_VQ_BYTES,
> 
> ---
> base-commit: 41bccc98fb7931d63d03f326a746ac4d429c1dd3
> change-id: 20240202-arm64-sve-ptrace-regset-size-21b0928969e1
> 
> Best regards,
> -- 
> Mark Brown <broonie@kernel.org>

This looks reasonable, but patching the .n fields doesn't look too bad
either; I'll post a patch separately for comparison.

[...]

Cheers
---Dave

