Return-Path: <linux-kernel+bounces-137340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DD9A489E0BE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 18:47:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0243B27392
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 16:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14A0C15380D;
	Tue,  9 Apr 2024 16:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qj2j4il8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4817914D2AB;
	Tue,  9 Apr 2024 16:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712681204; cv=none; b=DzdJ0GjxiYIjseJtisOUiXGGLoUm6iHtDmKjOf3SY+qhW7nHslm5xoH51bg1uBz4huR5VMddSG/p330FbbYlHYRCmhEYu0YiL0CIVwXHS3L4d4nc8aNYqFiHxxucyMJZdzgIBSRTznENdqMAmii0lRijUA7BNBDsAd2oxu4LDMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712681204; c=relaxed/simple;
	bh=o0OAciAt/jXavMnT0VtNrsX62U+AXVJqJQ9T4iXq+7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H6ChrulH8EiSFcfr0N2kCgxSE3H8sAViNyrujND4YBGNOJI7OhGx58l1F8+t/zc8xWwu8LdycCT/OyUpjR4rVzkdbfGKv4uFmzR9NmZfcMuhgWPBrYfQmMNfE/ipDAaJM3DZJdFxn4DCG5cI8i9D22ZjmLpej0RSNBlt4DDifxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qj2j4il8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3118DC433C7;
	Tue,  9 Apr 2024 16:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712681203;
	bh=o0OAciAt/jXavMnT0VtNrsX62U+AXVJqJQ9T4iXq+7k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qj2j4il8RUcgG+h9QuuOQyyLw5K4BETmu32EIMGukESkD6+rVLGhgu7Wo6j7f1gHI
	 Kprshu1febqMDXtTaROJ5oOUXGjzhN8HC914Kiwarg6YGOJ+qecCtdkWjwCLCsPiWD
	 4BfXplP3CSNLrdPwyFS0BxRPT5G36dK/+lQY0kwxK8jbd4zuFT9t1QWkCbKihBPM9x
	 bkTC+JpcPN5XMhDoyc4m2d7ubhQHwJrQ7SQUir9GI4MydoBb2r0y0JluVaomu34jtd
	 wm9q9aWIiGS9z8NqqogdRRtOHcHAoudKafnIjr0d0GE4G++ztQiVvDRrborxRw/9iU
	 zzm+JkIcGTO5Q==
Date: Tue, 9 Apr 2024 09:46:41 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: zhuqiuer <zhuqiuer1@huawei.com>
Cc: linux@armlinux.org.uk, ndesaulniers@google.com, morbo@google.com,
	justinstitt@google.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, ardb@kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] ARM: Add a memory clobber to the fmrx instruction
Message-ID: <20240409164641.GC3219862@dev-arch.thelio-3990X>
References: <20240409113844.4813-1-zhuqiuer1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240409113844.4813-1-zhuqiuer1@huawei.com>

+ Ard

On Tue, Apr 09, 2024 at 07:38:44PM +0800, zhuqiuer wrote:
> The instruction fmrx is used throughout the kernel,
> where it is sometimes expected to be skipped
> by incrementing the program counter, such as in vfpmodule.c:vfp_init().
> Therefore, the instruction should not be reordered when it is not intended.
> Adding a barrier() instruction before and after this call cannot prevent
> reordering by the compiler, as the fmrx instruction is constrained
> by '=r', meaning it works on the general register but not on memory.
> To ensure the order of the instruction after compiling,
> adding a memory clobber is necessary.
> 
> Below is the code snippet disassembled from the method:
> vfpmodule.c:vfp_init(), compiled by LLVM.
> 
> Before the patching:
> xxxxx:   xxxxx    bl  c010c688 <register_undef_hook>
> xxxxx:   xxxxx    mov r0, r4
> xxxxx:   xxxxx    bl  c010c6e4 <unregister_undef_hook>
> ...
> xxxxx:   xxxxx    bl  c0791c8c <printk>
> xxxxx:   xxxxx    movw    r5, #23132  ; 0x5a5c
> xxxxx:   xxxxx    vmrs    r4, fpsid  <- this is the fmrx instruction
> 
> After the patching:
> xxxxx:   xxxxx    bl  c010c688 <register_undef_hook>
> xxxxx:   xxxxx    mov r0, r4
> xxxxx:   xxxxx    vmrs    r5, fpsid  <- this is the fmrx instruction
> xxxxx:   xxxxx    bl  c010c6e4 <unregister_undef_hook>
> 
> Signed-off-by: zhuqiuer <zhuqiuer1@huawei.com>
> ---
>  arch/arm/vfp/vfpinstr.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/vfp/vfpinstr.h b/arch/arm/vfp/vfpinstr.h
> index 3c7938fd40aa..e70129e10b8e 100644
> --- a/arch/arm/vfp/vfpinstr.h
> +++ b/arch/arm/vfp/vfpinstr.h
> @@ -68,7 +68,7 @@
>  	u32 __v;			\
>  	asm(".fpu	vfpv2\n"	\
>  	    "vmrs	%0, " #_vfp_	\
> -	    : "=r" (__v) : : "cc");	\
> +	    : "=r" (__v) : : "memory", "cc");	\
>  	__v;				\
>   })
>  
> -- 
> 2.12.3
> 

This seems like the same issue that Ard was addressing with this patch
at https://lore.kernel.org/20240318093004.117153-2-ardb+git@google.com/,
does that change work for your situation as well? I do not really have a
strong preference between the two approaches, Ard also mentioned using
*current in the asm constraints as another option.

Cheers,
Nathan

