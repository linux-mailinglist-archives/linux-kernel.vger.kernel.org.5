Return-Path: <linux-kernel+bounces-74565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 516B585D60A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 11:50:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08A291F24208
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 10:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 131813EA71;
	Wed, 21 Feb 2024 10:49:41 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3187B3F8D1;
	Wed, 21 Feb 2024 10:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708512580; cv=none; b=EFaW2aChIZfwZLFwgGCxW68wCJW9R9okEKSMHJzrpVHpXMYmDtsz54NMFVyb8YcfRy4KXzOrgBsZ+WmnwHbEsOCAbkif9VMW/JrTcVCPxfRQuEUTJgW62R3Gr72zBvMlk0Qlehl7oMTa2flxhiOhN953+b9bAo+SQ7zqYa5Vij0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708512580; c=relaxed/simple;
	bh=wacTz1ELhyQDBUYMDg6UXzsrdAj+sf1BNPx+vVtNVR8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IxkIlaX6AFPXbbRiEkHx0shj19E58BbNUETDk+S0d4joKEFHsEPS+NSin2PLt6uXH9dwNcCrjiEdhVlWPc2XMHs+C3dLcpj0Gnf3FbrdKWmnvQAAEjVr07wdOsG4QrpIkRljzbIa+ZyA4C/z8M4IPDszNbcM3cvs7rHqk/Bpx4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 08AB8FEC;
	Wed, 21 Feb 2024 02:50:16 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.65.90])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 64BF53F73F;
	Wed, 21 Feb 2024 02:49:36 -0800 (PST)
Date: Wed, 21 Feb 2024 10:49:31 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>, nathan@kernel.org,
	nicolas@fjasle.eu, linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] kbuild: Use -fmin-function-alignment when available
Message-ID: <ZdXVO45Y0Nr3D25Q@FVFF77S0Q05N>
References: <20240215151642.8970-1-petr.pavlu@suse.com>
 <CAK7LNAS=knGxd9ZRo37CaKTvjcc28bqNasx+XuqbV3S+XV=HtQ@mail.gmail.com>
 <9b067ec7-34e2-437b-a41b-319aaee4c7e6@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9b067ec7-34e2-437b-a41b-319aaee4c7e6@suse.com>

On Wed, Feb 21, 2024 at 11:38:38AM +0100, Petr Pavlu wrote:
> On 2/20/24 14:39, Masahiro Yamada wrote:
> > On Fri, Feb 16, 2024 at 12:16 AM Petr Pavlu <petr.pavlu@suse.com> wrote:
> >>
> >> GCC recently added option -fmin-function-alignment, which should appear
> >> in GCC 14. Unlike -falign-functions, this option causes all functions to
> >> be aligned at the specified value, including the cold ones.
> >>
> >> Detect availability of -fmin-function-alignment and use it instead of
> >> -falign-functions when present. Introduce CC_HAS_SANE_FUNCTION_ALIGNMENT
> >> and make the workarounds for the broken function alignment conditional
> >> on this setting.
> >>
> >> Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
> >> ---
> > 
> > [snip]
> > 
> >> index dfb963d2f862..5a6fed4ad3df 100644
> >> --- a/kernel/exit.c
> >> +++ b/kernel/exit.c
> >> @@ -1920,7 +1920,10 @@ EXPORT_SYMBOL(thread_group_exited);
> >>   *
> >>   * See https://gcc.gnu.org/bugzilla/show_bug.cgi?id=88345#c11
> >>   */
> >> -__weak __function_aligned void abort(void)
> >> +#ifndef CONFIG_CC_HAS_SANE_FUNCTION_ALIGNMENT
> >> +__function_aligned
> >> +#endif
> >> +__weak void abort(void)
> >>  {
> >>         BUG();
> > 
> > 
> > 
> > 
> > 
> > __function_aligned is conditionally defined in
> > include/linux/compiler_types.h, and then it is
> > conditionally used in kernel/exit.c
> > 
> > This is unreadable.
> > 
> > 
> > 
> > 
> > You may want to move CONFIG_CC_HAS_SANE_FUNCTION_ALIGNMENT
> > to include/linux/compiler_types.h, as this is more
> > aligned with what you did for __cold.
> > 
> > 
> > 
> > if !defined(CONFIG_CC_HAS_SANE_FUNCTION_ALIGNMENT) && \
> >                CONFIG_FUNCTION_ALIGNMENT > 0
> > #define __function_aligned       __aligned(CONFIG_FUNCTION_ALIGNMENT)
> > #else
> > #define __function_aligned
> > #endif
> > 
> > 
> > 
> > 
> > 
> > However, an even more elegant approach is to unify
> > the two #ifdef blocks because __cold and __function_aligned
> > are related to each other.
> > 
> > 
> > 
> > #if defined(CONFIG_CC_HAS_SANE_FUNCTION_ALIGNMENT) || \
> >                  (CONFIG_FUNCTION_ALIGNMENT == 0)
> > #define __cold                 __attribute__((__cold__))
> > #define __function_aligned
> > #else
> > #define __cold
> > #define __function_aligned     __aligned(CONFIG_FUNCTION_ALIGNMENT)
> > #endif
> 
> I didn't want to make __function_aligned conditional on
> CONFIG_CC_HAS_SANE_FUNCTION_ALIGNMENT because the macro has a fairly
> general name. One could decide to mark a variable as __function_aligned
> and with the above code, it would no longer produce an expected result
> when -fmin-function-alignment is available.
> 
> __function_aligned was introduced c27cd083cfb9 ("Compiler attributes:
> GCC cold function alignment workarounds") only for aligning the abort()
> function and has not been so far used anywhere else.
> 
> If the above unification is preferred, I think it would be good to
> additionally rename the macro in order to prevent the mentioned misuse,
> perhaps to __force_function_alignment.
> 
> #if defined(CONFIG_CC_HAS_SANE_FUNCTION_ALIGNMENT) || \
> 		(CONFIG_FUNCTION_ALIGNMENT == 0)
> #define __cold				__attribute__((__cold__))
> #define __force_function_alignment
> #else
> #define __cold
> #define __force_function_alignment	__aligned(CONFIG_FUNCTION_ALIGNMENT)
> #endif
> 
> Would this be ok?

FWIW, renaming this to __force_function_alignment makes sense to me, and I'm
happy with the above.

Mark.

