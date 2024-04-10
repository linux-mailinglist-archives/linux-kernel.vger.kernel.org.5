Return-Path: <linux-kernel+bounces-138892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F55189FBB8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 17:36:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AE1B282A29
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 15:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1F82171665;
	Wed, 10 Apr 2024 15:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c6Y5zMar"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF81416F0D7;
	Wed, 10 Apr 2024 15:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712763329; cv=none; b=Oxz68gcOEkDEEmuJZJFt0Vj0DtbkSOtnxfYVI4W3IdqYQ9iozV4x0PwyAiH0oU67fgCjG5GdpttKizmEdY1fuI93ow+8sIkFGDfqiAeV9/E6nkjXhFuOE8q+B0Lmvb+EAAl4I2ERfkge0bnAZH2w8B5urTRkn6B8xmvZEuBTjnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712763329; c=relaxed/simple;
	bh=8walZAK6NKjpVLbHHEWlhePnShxtE50CiegFbxlpbWI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RsJ8vG4xjaeUBNVHyrudGYq48UU3wyB8diVjh9JiXjaVabiNiccdIgf5Jm3CvvZNfvxDqWIwwclntiyToJhlB/FolncK4TSCKOFNmupGBgt/sClJnRYVfUya6zHA3u3gLCOA3MK+DNnd6Pl19hhfQnRMaXIAHAV6dLZvWxjtW9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c6Y5zMar; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6F6FC433C7;
	Wed, 10 Apr 2024 15:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712763328;
	bh=8walZAK6NKjpVLbHHEWlhePnShxtE50CiegFbxlpbWI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c6Y5zMarCKVz3VPX6NsdWppeDYYLGFkgF0PbgtXXc+k2laIh0nDzyC4Y/efTBFxiU
	 2JCUjjKClnzkNX/Qr9FWnzmw0yrKxqVJVoAMIqNdUnS0IyV6haPm1To1d/ddU+Q2fZ
	 wDMzjlUhPXh+xN0UF+2iAuQWAdRKyZhFMZp8jivs/LioNfa2RK/igv2dPedDvsqDho
	 xRphNNEY4zs19RJLQN26ElP2IQvOxjZvHK7hCvjZCYSpOpMPlOGFNTEHRWBsKzWeza
	 Vn9ZfyO/qXGe6djlH+GvaXmf4UKYY4MiBhRNX4MFYaYnFjIwwNJkVCx9nm2ImIuVDn
	 J3aJEbjGGbK5w==
Date: Wed, 10 Apr 2024 08:35:26 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: zhuqiuer <zhuqiuer1@huawei.com>, justinstitt@google.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux@armlinux.org.uk, llvm@lists.linux.dev, morbo@google.com,
	ndesaulniers@google.com
Subject: Re: [PATCH v2] ARM: Add a memory clobber to the fmrx instruction
Message-ID: <20240410153526.GA3904754@dev-arch.thelio-3990X>
References: <20240409164641.GC3219862@dev-arch.thelio-3990X>
 <20240410024126.21589-1-zhuqiuer1@huawei.com>
 <20240410024126.21589-2-zhuqiuer1@huawei.com>
 <CAMj1kXFdR49n2Je5jYSdbWRZbMGoZenfaqDX3iCQFVZUecrCmw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXFdR49n2Je5jYSdbWRZbMGoZenfaqDX3iCQFVZUecrCmw@mail.gmail.com>

On Wed, Apr 10, 2024 at 02:31:11PM +0200, Ard Biesheuvel wrote:
> On Wed, 10 Apr 2024 at 04:41, zhuqiuer <zhuqiuer1@huawei.com> wrote:
> >
> > The instruction fmrx is used throughout the kernel,
> > where it is sometimes expected to be skipped
> > by incrementing the program counter, such as in vfpmodule.c:vfp_init().
> > Therefore, the instruction should not be reordered when it is not intended.
> > Adding a barrier() instruction before and after this call cannot prevent
> > reordering by the compiler, as the fmrx instruction is constrained
> > by '=r', meaning it works on the general register but not on memory.
> > To ensure the order of the instruction after compiling,
> > adding a memory clobber is necessary.
> >
> > Below is the code snippet disassembled from the method:
> > vfpmodule.c:vfp_init(), compiled by LLVM.
> >
> > Before the patching:
> > xxxxx:   xxxxx    bl  c010c688 <register_undef_hook>
> > xxxxx:   xxxxx    mov r0, r4
> > xxxxx:   xxxxx    bl  c010c6e4 <unregister_undef_hook>
> > ...
> > xxxxx:   xxxxx    bl  c0791c8c <printk>
> > xxxxx:   xxxxx    movw    r5, #23132  ; 0x5a5c
> > xxxxx:   xxxxx    vmrs    r4, fpsid  <- this is the fmrx instruction
> >
> > After the patching:
> > xxxxx:   xxxxx    bl  c010c688 <register_undef_hook>
> > xxxxx:   xxxxx    mov r0, r4
> > xxxxx:   xxxxx    vmrs    r5, fpsid  <- this is the fmrx instruction
> > xxxxx:   xxxxx    bl  c010c6e4 <unregister_undef_hook>
> >
> > Signed-off-by: zhuqiuer <zhuqiuer1@huawei.com>
> 
> This also fixes the issue I observed so
> 
> Reviewed-by: Ard Biesheuvel <ardb@kernel.org>

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

This can probably go in Russell's patch tracker? Your patch had

Cc: stable@vger.kernel.org

in it, should this one as well?

> > ---
> >  arch/arm/vfp/vfpinstr.h | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/arm/vfp/vfpinstr.h b/arch/arm/vfp/vfpinstr.h
> > index 3c7938fd40aa..ae2c9b9b7701 100644
> > --- a/arch/arm/vfp/vfpinstr.h
> > +++ b/arch/arm/vfp/vfpinstr.h
> > @@ -68,14 +68,14 @@
> >         u32 __v;                        \
> >         asm(".fpu       vfpv2\n"        \
> >             "vmrs       %0, " #_vfp_    \
> > -           : "=r" (__v) : : "cc");     \
> > +           : "=r" (__v) : : "memory", "cc");   \
> >         __v;                            \
> >   })
> >
> >  #define fmxr(_vfp_,_var_)              \
> >         asm(".fpu       vfpv2\n"        \
> >             "vmsr       " #_vfp_ ", %0" \
> > -          : : "r" (_var_) : "cc")
> > +          : : "r" (_var_) : "memory", "cc")
> >
> >  #else
> >
> > --
> > 2.12.3
> >

