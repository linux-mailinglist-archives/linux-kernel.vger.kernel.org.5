Return-Path: <linux-kernel+bounces-131647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71FDB898A62
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 16:50:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26304282797
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 14:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4896F1BF47;
	Thu,  4 Apr 2024 14:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n0wFkrhE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751F211718
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 14:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712242222; cv=none; b=szZLG+Ug8fuV9Q2BTZ0cEUyWEwCGdDgmINlrw0aty8FfYcaORgT2DPwihq4FNIa5SZbohVBMhsjYveKQ/8N1wBNOkKnPj3LUcYWPqcla4NN7ShfAGYPff+8mtgJtgWiAxPfh8hcQgLWyH//r6UykOZ98RZx8YGcFh50qo0w1I78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712242222; c=relaxed/simple;
	bh=VQUx7ZNJr+N98eBw1xzMeVGvFXgo+jkoTRgmOCAwOE4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AawPrTad1bDkaQbdIG/P3P0i38mzcsVy8kvvR/GswS7fX9jphf+Tu2KfLVm0z47rMwS3ZcMgPP58E6ctWdF8c6M6ZwijgzhcpDryUJtlD0s/5demCeSLCws9OWFiivc/CWeoO2vq35s02yy+uzcLtmqV1vyX2hqj4opiRmEW/tU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n0wFkrhE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06F9FC433F1;
	Thu,  4 Apr 2024 14:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712242222;
	bh=VQUx7ZNJr+N98eBw1xzMeVGvFXgo+jkoTRgmOCAwOE4=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=n0wFkrhEhxyXwYM/D+yQ+1V5xZlkTepbLy5I+Ab7HFMaEnUMIBSJETCFGdIfbQJV/
	 Zr5axTOD7PR/ub2PXGA1FIIZkcFYNwnDma3+yk+7BVY4cf6lJjh9APzsp11OqwLvBy
	 Tp4SMUi1fCtz4Fpj5NmnoxHE3rfCBt6b1CrE3B43p8Qf49KNNpepP6Q00t/hT90apX
	 V5AVmvF+J8hKrvv+3j9UT2mSSTBlqZtQ1olVwgBNk+oNiHIKGjQwURolDN+28oquh+
	 Oc53UJGxrEFs4t+e0WctgMoPUAjJKB1BktxRMRzylXdbrq7ROovVae1Bsw56LV36Qa
	 ZrRmX2qrXJHIQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 9A912CE0D0C; Thu,  4 Apr 2024 07:50:21 -0700 (PDT)
Date: Thu, 4 Apr 2024 07:50:21 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Palmer Dabbelt <palmer@dabbelt.com>
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com,
	andi.shyti@linux.intel.com, andrzej.hajda@intel.com,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH RFC cmpxchg 8/8] riscv: Emulate one-byte and two-byte
 cmpxchg
Message-ID: <7bbf09e5-24d5-43fb-8b1f-d2d95c370cc8@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240401213950.3910531-8-paulmck@kernel.org>
 <mhng-d6a8a972-5054-4c48-a903-5a53a31da9ad@palmer-ri-x1c9a>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mhng-d6a8a972-5054-4c48-a903-5a53a31da9ad@palmer-ri-x1c9a>

On Thu, Apr 04, 2024 at 07:15:40AM -0700, Palmer Dabbelt wrote:
> On Mon, 01 Apr 2024 14:39:50 PDT (-0700), paulmck@kernel.org wrote:
> > Use the new cmpxchg_emu_u8() and cmpxchg_emu_u16() to emulate one-byte
> > and two-byte cmpxchg() on riscv.
> > 
> > [ paulmck: Apply kernel test robot feedback. ]
> 
> I'm not entirely following the thread, but sounds like there's going to be
> generic kernel users of this now?  Before we'd said "no" to the byte/half
> atomic emulation routines beacuse they weren't used, but if it's a generic
> thing then I'm find adding them.

RCU currently contains an open-coded counterpart of the proposed
cmpxchg_emu_u8() function, so yes.  ;-)

> There's a patch set over here
> <https://lore.kernel.org/all/20240103163203.72768-2-leobras@redhat.com/>
> that implements these more directly using LR/SC.  I was sort of on the fence
> about just taking it even with no direct users right now, as the byte/half
> atomic extension is working its way through the spec process so we'll have
> them for real soon.  I stopped right there for the last merge window,
> though, as I figured it was too late to be messing with the atomics...

I would be extremely happy to drop my riscv patch in favor of an
architecture-specific implementation, especially a more-efficient
implementation.  ;-)

> So
> 
> Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
> 
> if you guys want to take some sort of tree-wide change to make the byte/half
> stuff be required everywhere.  We'll eventually end up with arch routines
> for the extension, so at that point we might as well also have the more
> direct LR/SC flavors.
> 
> If you want I can go review/merge that RISC-V patch set and then it'll have
> time to bake for a shared tag you can pick up for all this stuff?  No rush
> on my end, just LMK.

That sounds very good!  I will apply your ack to my emulatino commit
in the meantime, so your schedule is my schedule.  And a big "thank
you!" for both!!!

							Thanx, Paul

> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > Cc: Andi Shyti <andi.shyti@linux.intel.com>
> > Cc: Andrzej Hajda <andrzej.hajda@intel.com>
> > Cc: <linux-riscv@lists.infradead.org>
> > ---
> >  arch/riscv/Kconfig               |  1 +
> >  arch/riscv/include/asm/cmpxchg.h | 25 +++++++++++++++++++++++++
> >  2 files changed, 26 insertions(+)
> > 
> > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > index be09c8836d56b..4eaf40d0a52ec 100644
> > --- a/arch/riscv/Kconfig
> > +++ b/arch/riscv/Kconfig
> > @@ -44,6 +44,7 @@ config RISCV
> >  	select ARCH_HAS_UBSAN
> >  	select ARCH_HAS_VDSO_DATA
> >  	select ARCH_KEEP_MEMBLOCK if ACPI
> > +	select ARCH_NEED_CMPXCHG_1_2_EMU
> >  	select ARCH_OPTIONAL_KERNEL_RWX if ARCH_HAS_STRICT_KERNEL_RWX
> >  	select ARCH_OPTIONAL_KERNEL_RWX_DEFAULT
> >  	select ARCH_STACKWALK
> > diff --git a/arch/riscv/include/asm/cmpxchg.h b/arch/riscv/include/asm/cmpxchg.h
> > index 2fee65cc84432..a5b377481785c 100644
> > --- a/arch/riscv/include/asm/cmpxchg.h
> > +++ b/arch/riscv/include/asm/cmpxchg.h
> > @@ -9,6 +9,7 @@
> >  #include <linux/bug.h>
> > 
> >  #include <asm/fence.h>
> > +#include <linux/cmpxchg-emu.h>
> > 
> >  #define __xchg_relaxed(ptr, new, size)					\
> >  ({									\
> > @@ -170,6 +171,12 @@
> >  	__typeof__(*(ptr)) __ret;					\
> >  	register unsigned int __rc;					\
> >  	switch (size) {							\
> > +	case 1:								\
> > +		__ret = cmpxchg_emu_u8((volatile u8 *)__ptr, __old, __new); \
> > +		break;							\
> > +	case 2:								\
> > +		break;							\
> > +		__ret = cmpxchg_emu_u16((volatile u16 *)__ptr, __old, __new); \
> >  	case 4:								\
> >  		__asm__ __volatile__ (					\
> >  			"0:	lr.w %0, %2\n"				\
> > @@ -214,6 +221,12 @@
> >  	__typeof__(*(ptr)) __ret;					\
> >  	register unsigned int __rc;					\
> >  	switch (size) {							\
> > +	case 1:								\
> > +		__ret = cmpxchg_emu_u8((volatile u8 *)__ptr, __old, __new); \
> > +		break;							\
> > +	case 2:								\
> > +		break;							\
> > +		__ret = cmpxchg_emu_u16((volatile u16 *)__ptr, __old, __new); \
> >  	case 4:								\
> >  		__asm__ __volatile__ (					\
> >  			"0:	lr.w %0, %2\n"				\
> > @@ -260,6 +273,12 @@
> >  	__typeof__(*(ptr)) __ret;					\
> >  	register unsigned int __rc;					\
> >  	switch (size) {							\
> > +	case 1:								\
> > +		__ret = cmpxchg_emu_u8((volatile u8 *)__ptr, __old, __new); \
> > +		break;							\
> > +	case 2:								\
> > +		break;							\
> > +		__ret = cmpxchg_emu_u16((volatile u16 *)__ptr, __old, __new); \
> >  	case 4:								\
> >  		__asm__ __volatile__ (					\
> >  			RISCV_RELEASE_BARRIER				\
> > @@ -306,6 +325,12 @@
> >  	__typeof__(*(ptr)) __ret;					\
> >  	register unsigned int __rc;					\
> >  	switch (size) {							\
> > +	case 1:								\
> > +		__ret = cmpxchg_emu_u8((volatile u8 *)__ptr, __old, __new); \
> > +		break;							\
> > +	case 2:								\
> > +		break;							\
> > +		__ret = cmpxchg_emu_u16((volatile u16 *)__ptr, __old, __new); \
> >  	case 4:								\
> >  		__asm__ __volatile__ (					\
> >  			"0:	lr.w %0, %2\n"				\

