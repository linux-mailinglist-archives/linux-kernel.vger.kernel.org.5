Return-Path: <linux-kernel+bounces-150750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D26758AA419
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 22:37:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 104ED1C212CD
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 20:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0368C190661;
	Thu, 18 Apr 2024 20:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aOFsHTBE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B7D2E416;
	Thu, 18 Apr 2024 20:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713472631; cv=none; b=mFDEdwo8g6zQJDnXilZVkI6zgZ8A2uTY1ggFMdEwuYJN3+IcuFVmJgcIj1ymlHU+pF9sCjrCWfeJ6cYKQN34D6jkTeX8TUv1g46GHPUxGnLjZIha3vG5EpuWwEl2SlpLnRXdItXGFFh3tgp53eF5yZ9G8vZ3cXCqP2pqaaFPC/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713472631; c=relaxed/simple;
	bh=1uj5MMoVXJZ0ZuCX2uWHlUOTJOwvV/H9O+jKzqffXPY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oysNn+Weef1lnqpqkBJAY1fuPC16Pw3FcGhq+ZRqprlNIE4WhEhpYfJHgfzaSQ1LjvrkuWlhD7UVO6K23kF6hBp118Nuv8ddHqvxlmsbOhDnvGCLJmpIHuyJPyXi9zcviv+5qILH4MYsGedby3uINOq2+HxW0nul/N9MdpYY37o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aOFsHTBE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1132CC113CC;
	Thu, 18 Apr 2024 20:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713472629;
	bh=1uj5MMoVXJZ0ZuCX2uWHlUOTJOwvV/H9O+jKzqffXPY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aOFsHTBET+Nl2MXIIpeu9QE6/nmA9idypaw+VhBAX2lBt7nCgiNM9kLP1GtL/atte
	 lI90Ms/l0hAXDqMnfbqZnMO8eZB59nTMvdffCN/50tAEXTKq1K+zyfzpcZ5FGI6SwR
	 UzxiKSNYYKLMODSGLjkIUnr6sbGYhzQgLoro/S4yDS7G7IjnvL0S5xKy0F9f4MBU4U
	 E4+yPg4ObzxSK2NGG0K5Pd+3dw41A4dzFNVsuNPkE1MN+EHfUn7W23/dfPDi0+bmJ6
	 M/7CLk13q77b+ZOA55cphLjaybBKdzWQ+d7dVYuISYmb7D0b96dA66KbV3g3sojPEB
	 HPq9ftVDZFnQQ==
Date: Thu, 18 Apr 2024 13:37:07 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, Song Liu <song@kernel.org>,
	Ricardo Ribalda <ribalda@kernel.org>,
	Fangrui Song <maskray@google.com>,
	Arthur Eubanks <aeubanks@google.com>, stable@vger.kernel.org
Subject: Re: [PATCH] x86/purgatory: Switch to the position-independent small
 code model
Message-ID: <20240418203707.GB2962980@dev-arch.thelio-3990X>
References: <20240418201705.3673200-2-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240418201705.3673200-2-ardb+git@google.com>

On Thu, Apr 18, 2024 at 10:17:06PM +0200, Ard Biesheuvel wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
> 
> On x86, the ordinary, position dependent 'small' and 'kernel' code models only
> support placement of the executable in 32-bit addressable memory, due to
> the use of 32-bit signed immediates to generate references to global
> variables. For the kernel, this implies that all global variables must
> reside in the top 2 GiB of the kernel virtual address space, where the
> implicit address bits 63:32 are equal to sign bit 31.
> 
> This means the kernel code model is not suitable for other bare metal
> executables such as the kexec purgatory, which can be placed arbitrarily
> in the physical address space, where its address may no longer be
> representable as a sign extended 32-bit quantity. For this reason,
> commit
> 
>   e16c2983fba0 ("x86/purgatory: Change compiler flags from -mcmodel=kernel to -mcmodel=large to fix kexec relocation errors")
> 
> switched to the 'large' code model, which uses 64-bit immediates for all
> symbol references, including function calls, in order to avoid relying
> on any assumptions regarding proximity of symbols in the final
> executable.
> 
> The large code model is rarely used, clunky and the least likely to
> operate in a similar fashion when comparing GCC and Clang, so it is best
> avoided. This is especially true now that Clang 18 has started to emit
> executable code in two separate sections (.text and .ltext), which
> triggers an issue in the kexec loading code at runtime.
> 
> Instead, use the position independent small code model, which makes no
> assumptions about placement but only about proximity, where all
> referenced symbols must be within -/+ 2 GiB, i.e., in range for a
> RIP-relative reference. Use hidden visibility to suppress the use of a
> GOT, which carries absolute addresses that are not covered by static ELF
> relocations, and is therefore incompatible with the kexec loader's
> relocation logic.
> 
> Cc: Nathan Chancellor <nathan@kernel.org>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Cc: Bill Wendling <morbo@google.com>
> Cc: Justin Stitt <justinstitt@google.com>
> Cc: Song Liu <song@kernel.org>
> Cc: Ricardo Ribalda <ribalda@kernel.org>
> Cc: Fangrui Song <maskray@google.com>
> Cc: Arthur Eubanks <aeubanks@google.com>
> Link: https://lore.kernel.org/all/20240417-x86-fix-kexec-with-llvm-18-v1-0-5383121e8fb7@kernel.org/
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>

Reviewed-by: Nathan Chancellor <nathan@kernel.org>
Tested-by: Nathan Chancellor <nathan@kernel.org>

This resolves the warning and relocation overflow error that I see with
LLVM 18.1.4 (the relocation error was fixed in LLVM but dropping
-mcmodel=large resolves it for toolchains without that fix).

> ---
>  arch/x86/purgatory/Makefile | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/purgatory/Makefile b/arch/x86/purgatory/Makefile
> index bc31863c5ee6..a18591f6e6d9 100644
> --- a/arch/x86/purgatory/Makefile
> +++ b/arch/x86/purgatory/Makefile
> @@ -42,7 +42,8 @@ KCOV_INSTRUMENT := n
>  # make up the standalone purgatory.ro
>  
>  PURGATORY_CFLAGS_REMOVE := -mcmodel=kernel
> -PURGATORY_CFLAGS := -mcmodel=large -ffreestanding -fno-zero-initialized-in-bss -g0
> +PURGATORY_CFLAGS := -mcmodel=small -ffreestanding -fno-zero-initialized-in-bss -g0
> +PURGATORY_CFLAGS += -fpic -fvisibility=hidden
>  PURGATORY_CFLAGS += $(DISABLE_STACKLEAK_PLUGIN) -DDISABLE_BRANCH_PROFILING
>  PURGATORY_CFLAGS += -fno-stack-protector
>  
> -- 
> 2.44.0.769.g3c40516874-goog
> 

