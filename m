Return-Path: <linux-kernel+bounces-88334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FC9F86E01D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 12:24:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5B551F217EE
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 11:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E5FD6BFD6;
	Fri,  1 Mar 2024 11:24:23 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0D1D6BFA2
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 11:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709292262; cv=none; b=TqjDwxlduB48RUzp2wylrWXabWM4eTuiivNHsISAvI6sNSeNcPoU+naBZniHKq0qTiarSuSX5JXpiDmPGxnRYidvq6IrdV+mvMUBSH1kLDsKP5mZ8wBXbluWecZfxSaDeVLynllHWdEISSWs3UJSzA87pFF3PVqf8DpNVY63u6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709292262; c=relaxed/simple;
	bh=NXtVQpQbXjbQ+2nDWsgKqIjl673GUDImuBDZ3hHzKmI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UxgJBJilwYHSSJtu3oVHruk7j56fP6IcNNgRn8QzJ4Q9QnFQLdCv57OQOgOESQDtl6CxINjDXfG4U6O1AyZGRXO+CMPSnOW44zXjnMSvcm0apxMC4rWeVpxDwq1+Bw4N5EOYdBacBtvgE4LCnfJI4fEZdQaPfainvCKeSfh2pBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 58C141FB;
	Fri,  1 Mar 2024 03:24:58 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.69.134])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AABE63F6C4;
	Fri,  1 Mar 2024 03:24:18 -0800 (PST)
Date: Fri, 1 Mar 2024 11:24:13 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Puranjay Mohan <puranjay12@gmail.com>, catalin.marinas@arm.com,
	will@kernel.org
Cc: nathan@kernel.org, broonie@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH] arm64: prohibit probing on arch_kunwind_consume_entry()
Message-ID: <ZeG63LbuDQaOYLKm@FVFF77S0Q05N>
References: <20240229231620.24846-1-puranjay12@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240229231620.24846-1-puranjay12@gmail.com>

On Thu, Feb 29, 2024 at 11:16:20PM +0000, Puranjay Mohan wrote:
> Make arch_kunwind_consume_entry() as __always_inline otherwise the
> compiler might not inline it and allow attaching probes to it.
> 
> Without this, just probing arch_kunwind_consume_entry() via
> <tracefs>/kprobe_events will crash the kernel on arm64.
> 
> The crash can be reproduced using the following compiler and kernel
> combination:
> clang version 19.0.0git (https://github.com/llvm/llvm-project.git d68d29516102252f6bf6dc23fb22cef144ca1cb3)
> commit 87adedeba51a ("Merge tag 'net-6.8-rc7' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net")
> 
>  [root@localhost ~]# echo 'p arch_kunwind_consume_entry' > /sys/kernel/debug/tracing/kprobe_events
>  [root@localhost ~]# echo 1 > /sys/kernel/debug/tracing/events/kprobes/enable
> 
>  Modules linked in: aes_ce_blk aes_ce_cipher ghash_ce sha2_ce virtio_net sha256_arm64 sha1_ce arm_smccc_trng net_failover failover virtio_mmio uio_pdrv_genirq uio sch_fq_codel dm_mod dax configfs
>  CPU: 3 PID: 1405 Comm: bash Not tainted 6.8.0-rc6+ #14
>  Hardware name: linux,dummy-virt (DT)
>  pstate: 604003c5 (nZCv DAIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>  pc : kprobe_breakpoint_handler+0x17c/0x258
>  lr : kprobe_breakpoint_handler+0x17c/0x258
>  sp : ffff800085d6ab60
>  x29: ffff800085d6ab60 x28: ffff0000066f0040 x27: ffff0000066f0b20
>  x26: ffff800081fa7b0c x25: 0000000000000002 x24: ffff00000b29bd18
>  x23: ffff00007904c590 x22: ffff800081fa6590 x21: ffff800081fa6588
>  x20: ffff00000b29bd18 x19: ffff800085d6ac40 x18: 0000000000000079
>  x17: 0000000000000001 x16: ffffffffffffffff x15: 0000000000000004
>  x14: ffff80008277a940 x13: 0000000000000003 x12: 0000000000000003
>  x11: 00000000fffeffff x10: c0000000fffeffff x9 : aa95616fdf80cc00
>  x8 : aa95616fdf80cc00 x7 : 205d343137373231 x6 : ffff800080fb48ec
>  x5 : 0000000000000000 x4 : 0000000000000001 x3 : 0000000000000000
>  x2 : 0000000000000000 x1 : ffff800085d6a910 x0 : 0000000000000079
>  Call trace:
>  kprobes: Failed to recover from reentered kprobes.
>  kprobes: Dump kprobe:
>  .symbol_name = arch_kunwind_consume_entry, .offset = 0, .addr = arch_kunwind_consume_entry+0x0/0x40
>  ------------[ cut here ]------------
>  kernel BUG at arch/arm64/kernel/probes/kprobes.c:241!
>  kprobes: Failed to recover from reentered kprobes.
>  kprobes: Dump kprobe:
>  .symbol_name = arch_kunwind_consume_entry, .offset = 0, .addr = arch_kunwind_consume_entry+0x0/0x40
> 
> Fixes: 1aba06e7b2b49 ("arm64: stacktrace: factor out kunwind_stack_walk()")
> Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>

Thanks for this!

Whoops; I had meant to make this __always_inline (or noinstr), but I evidently
messed that up. I don't recall any problem with making this __always_inline,
and that's preferable here to allow the compiler to fold some of the
indirection.

From a scan of stacktrace.c I don't see anything else that needs similar
treatment; the other functions lacking __always_inline and noinstr are safe to
instrument as they aren't core to the unwinder, and won't recurse into
themselves in a problematic way.

Given all the above:

Reviewed-by: Mark Rutland <mark.rutland@arm.com>

Catalin, Will, are you happy to queue this as a fix?

Mark.

> ---
>  arch/arm64/kernel/stacktrace.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrace.c
> index 7f88028a00c0..b2a60e0bcfd2 100644
> --- a/arch/arm64/kernel/stacktrace.c
> +++ b/arch/arm64/kernel/stacktrace.c
> @@ -247,7 +247,7 @@ struct kunwind_consume_entry_data {
>  	void *cookie;
>  };
>  
> -static bool
> +static __always_inline bool
>  arch_kunwind_consume_entry(const struct kunwind_state *state, void *cookie)
>  {
>  	struct kunwind_consume_entry_data *data = cookie;
> 
> base-commit: 87adedeba51a822533649b143232418b9e26d08b
> -- 
> 2.40.1
> 

