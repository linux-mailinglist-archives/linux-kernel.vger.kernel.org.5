Return-Path: <linux-kernel+bounces-139909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 571BB8A090A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 09:02:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 137A5283978
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 07:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BF3A13DBB3;
	Thu, 11 Apr 2024 07:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JnQGip1n"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF3E523A
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 07:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712818949; cv=none; b=idu/N+6FUVZO2u7AnIBFcynTGnZyq6K9s/iZSr8RAl5xBRBi7g/sM5C6nmCTbpElesYvV0n+BQR3uZ+yPqjWbcGhsc0C1ghfOaNl54TBUIl3Qf/Gd70T2i9/31ylV2b9ADrfwMxdZo0m1LJqDbjw+2eavUeiPLyVs27fOW/XwKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712818949; c=relaxed/simple;
	bh=qU7wfKPZiKmQZPy2qC63qZahYpClPjRIwc8qAFTnCRo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TgNMDQeIeEBj259aUfppcS2fbn7YgTag6ZR12D5RDXp5utxvfJ1GHHQFYc9BhHZTf+NXj8ueVO8+IRL94hO/drCc8oSch3GSH2CuEAYXsFhzduslAYPP8p9htYyGkzqfg2gVH7mzNs5/dTPaFsl1eFspp+dBpfwTI6c3xnZqF8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JnQGip1n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4027BC433A6
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 07:02:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712818949;
	bh=qU7wfKPZiKmQZPy2qC63qZahYpClPjRIwc8qAFTnCRo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=JnQGip1nNqvMljL4chRVLeKyXx5BxyENIVgT/vswWlDP0CI98VUPJzYNZ5fqNf5O0
	 b2OjSm/byKoEP7AjARUDNt7EJINTpuw/p3BZ0qrQ72sFbOxXEC3T+RAcH5pyJoSvBM
	 ZoviIVNSuWSGZ9hjd2c4BpD6q0aeD9ZsToQZZ/eQmZZR2pPYRmDLC4y/X6iWPUeT8y
	 LygNDcEhgElIlEHeOkLHInBP82wnED0INqeWrd55+uPJaMMam4QpAdt3FRZz4xHqyy
	 EDy3RL8yJDlI/1IHfG0YU3w0H3CQMgSaH7Fb6+wc9dHIQbIDcuvdVgF4e2T6/OV0cb
	 ljN04KYQGrQ0w==
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2d715638540so88249591fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 00:02:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW3ymnvmgL/wiph7Pgdv437f5qsEvbxTegxpqzFzo8GWRRrz+EQf2RbiD5cL9cMSH6ScCm1ayf3QIwPvzwDrOcUkqKBWwX95nSovyQ+
X-Gm-Message-State: AOJu0YyIaEhOHXixc6XY6OTVY8hMHgLJ6jw/CLgDbLJ3voZeu+qx76D7
	6SlQ+2Iuf3wA/8+PK/T4oadxchwfNIEcZv9WB8eHOKq5LJftJcfuEAVUGNJRCchvy92qOBnCxdZ
	mb8ajF23H39O8m7y+yGC0u8C3Y9Y=
X-Google-Smtp-Source: AGHT+IFfUboQwbkillPEb97o+5lWxVz4+at6POcnOx90LxTpR0WO+PgGYZmr7iUDw5DEp7TCw475oS+fqafGCEdqvDE=
X-Received: by 2002:a05:651c:102c:b0:2d6:fc0b:f122 with SMTP id
 w12-20020a05651c102c00b002d6fc0bf122mr2858466ljm.18.1712818947405; Thu, 11
 Apr 2024 00:02:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240409164641.GC3219862@dev-arch.thelio-3990X>
 <20240410024126.21589-1-zhuqiuer1@huawei.com> <20240410024126.21589-2-zhuqiuer1@huawei.com>
 <CAMj1kXFdR49n2Je5jYSdbWRZbMGoZenfaqDX3iCQFVZUecrCmw@mail.gmail.com> <20240410153526.GA3904754@dev-arch.thelio-3990X>
In-Reply-To: <20240410153526.GA3904754@dev-arch.thelio-3990X>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 11 Apr 2024 09:02:15 +0200
X-Gmail-Original-Message-ID: <CAMj1kXH=f4tS2wwgG2a8fz2eUZzATU_Hi4n82MmrOu8Aexux0A@mail.gmail.com>
Message-ID: <CAMj1kXH=f4tS2wwgG2a8fz2eUZzATU_Hi4n82MmrOu8Aexux0A@mail.gmail.com>
Subject: Re: [PATCH v2] ARM: Add a memory clobber to the fmrx instruction
To: Nathan Chancellor <nathan@kernel.org>
Cc: zhuqiuer <zhuqiuer1@huawei.com>, justinstitt@google.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux@armlinux.org.uk, llvm@lists.linux.dev, morbo@google.com, 
	ndesaulniers@google.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 10 Apr 2024 at 17:35, Nathan Chancellor <nathan@kernel.org> wrote:
>
> On Wed, Apr 10, 2024 at 02:31:11PM +0200, Ard Biesheuvel wrote:
> > On Wed, 10 Apr 2024 at 04:41, zhuqiuer <zhuqiuer1@huawei.com> wrote:
> > >
> > > The instruction fmrx is used throughout the kernel,
> > > where it is sometimes expected to be skipped
> > > by incrementing the program counter, such as in vfpmodule.c:vfp_init().
> > > Therefore, the instruction should not be reordered when it is not intended.
> > > Adding a barrier() instruction before and after this call cannot prevent
> > > reordering by the compiler, as the fmrx instruction is constrained
> > > by '=r', meaning it works on the general register but not on memory.
> > > To ensure the order of the instruction after compiling,
> > > adding a memory clobber is necessary.
> > >
> > > Below is the code snippet disassembled from the method:
> > > vfpmodule.c:vfp_init(), compiled by LLVM.
> > >
> > > Before the patching:
> > > xxxxx:   xxxxx    bl  c010c688 <register_undef_hook>
> > > xxxxx:   xxxxx    mov r0, r4
> > > xxxxx:   xxxxx    bl  c010c6e4 <unregister_undef_hook>
> > > ...
> > > xxxxx:   xxxxx    bl  c0791c8c <printk>
> > > xxxxx:   xxxxx    movw    r5, #23132  ; 0x5a5c
> > > xxxxx:   xxxxx    vmrs    r4, fpsid  <- this is the fmrx instruction
> > >
> > > After the patching:
> > > xxxxx:   xxxxx    bl  c010c688 <register_undef_hook>
> > > xxxxx:   xxxxx    mov r0, r4
> > > xxxxx:   xxxxx    vmrs    r5, fpsid  <- this is the fmrx instruction
> > > xxxxx:   xxxxx    bl  c010c6e4 <unregister_undef_hook>
> > >
> > > Signed-off-by: zhuqiuer <zhuqiuer1@huawei.com>
> >
> > This also fixes the issue I observed so
> >
> > Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
>
> Reviewed-by: Nathan Chancellor <nathan@kernel.org>
>
> This can probably go in Russell's patch tracker?

Yes.

> Your patch had
>
> Cc: stable@vger.kernel.org
>
> in it, should this one as well?
>

Yes.


> > > ---
> > >  arch/arm/vfp/vfpinstr.h | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/arch/arm/vfp/vfpinstr.h b/arch/arm/vfp/vfpinstr.h
> > > index 3c7938fd40aa..ae2c9b9b7701 100644
> > > --- a/arch/arm/vfp/vfpinstr.h
> > > +++ b/arch/arm/vfp/vfpinstr.h
> > > @@ -68,14 +68,14 @@
> > >         u32 __v;                        \
> > >         asm(".fpu       vfpv2\n"        \
> > >             "vmrs       %0, " #_vfp_    \
> > > -           : "=r" (__v) : : "cc");     \
> > > +           : "=r" (__v) : : "memory", "cc");   \
> > >         __v;                            \
> > >   })
> > >
> > >  #define fmxr(_vfp_,_var_)              \
> > >         asm(".fpu       vfpv2\n"        \
> > >             "vmsr       " #_vfp_ ", %0" \
> > > -          : : "r" (_var_) : "cc")
> > > +          : : "r" (_var_) : "memory", "cc")
> > >
> > >  #else
> > >
> > > --
> > > 2.12.3
> > >

