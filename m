Return-Path: <linux-kernel+bounces-46455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C80A843FE1
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 14:01:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F49B1C210B0
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 13:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 562FF7B3E2;
	Wed, 31 Jan 2024 13:01:27 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDD9A55C14
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 13:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706706086; cv=none; b=QMVlk7SJh4z0JKBbDMnRcgkFO4FEEJM6fhqFJuxR2BSQ3ryamoi9GKLBQ5sAMILYni+kNyYqeRvm1V52ubY442cA0igyfY/W6TR+hwwQewtt169fKX9uMxNMH9+5nbx4Zu/97hzddmurn4QilbEQxFroJ1nwzZFC7zUk3rFy4ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706706086; c=relaxed/simple;
	bh=5CKTpaFjsTe6lonuoOUlHY2T/WH+/JtSRrKIXyTcYD4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ABaiMIBiuEIOgrNkFcu4O3eSnwzcvWSXycGjzOf6kaLKlGLsXu2KyqIzVCmMrf/cqxyfnK94AdSKjtPQhV8wkwvVeZKcJ+p/mqIWyvf40F8gD+RhV51JAdrc1PSQnHm0Zd+LEd60M3zIT+lFWZCrddpXwrHGhpKjf5OQozn+WgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A7774DA7;
	Wed, 31 Jan 2024 05:02:06 -0800 (PST)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.58])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1469B3F738;
	Wed, 31 Jan 2024 05:01:21 -0800 (PST)
Date: Wed, 31 Jan 2024 13:01:16 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Fangrui Song <maskray@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org,
	Jisheng Zhang <jszhang@kernel.org>, llvm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: jump_label: use constraint "S" instead of "i"
Message-ID: <ZbpEnDK3U/O24ng0@e133380.arm.com>
References: <20240131065322.1126831-1-maskray@google.com>
 <CAMj1kXGzADFWa7RmXyjWpCnQ=9hhz6i-XkN4PS1CboZ-kFL8dQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXGzADFWa7RmXyjWpCnQ=9hhz6i-XkN4PS1CboZ-kFL8dQ@mail.gmail.com>

On Wed, Jan 31, 2024 at 08:16:04AM +0100, Ard Biesheuvel wrote:
> Hello Fangrui,
> 
> On Wed, 31 Jan 2024 at 07:53, Fangrui Song <maskray@google.com> wrote:
> >
> > The constraint "i" seems to be copied from x86 (and with a redundant
> > modifier "c"). It works with -fno-PIE but not with -fPIE/-fPIC in GCC's
> > aarch64 port.

(I'm not sure of the exact history, but the "c" may be inherited from
arm, where an output modifier was needed to suppress the "#" that
prefixes immediates in the traditional asm syntax.  This does not
actually seem to be required for AArch64: rather while a # is allowed
and still considered good style in handwritten asm code, the syntax
doesn't require it, and the compiler doesn't emit it for "i" arguments,
AFAICT.)

> > The constraint "S", which denotes a symbol reference (e.g. function,
> > global variable) or label reference, is more appropriate, and has been
> > available in GCC since 2012 and in Clang since 7.0.
> >
> > Signed-off-by: Fangrui Song <maskray@google.com>
> > Link: https://maskray.me/blog/2024-01-30-raw-symbol-names-in-inline-assembly
> > ---
> >  arch/arm64/include/asm/jump_label.h | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/arch/arm64/include/asm/jump_label.h b/arch/arm64/include/asm/jump_label.h
> > index 48ddc0f45d22..31862b3bb33d 100644
> > --- a/arch/arm64/include/asm/jump_label.h
> > +++ b/arch/arm64/include/asm/jump_label.h
> > @@ -23,9 +23,9 @@ static __always_inline bool arch_static_branch(struct static_key * const key,
> >                  "      .pushsection    __jump_table, \"aw\"    \n\t"
> >                  "      .align          3                       \n\t"
> >                  "      .long           1b - ., %l[l_yes] - .   \n\t"
> > -                "      .quad           %c0 - .                 \n\t"
> > +                "      .quad           %0 - .                  \n\t"
> >                  "      .popsection                             \n\t"
> > -                :  :  "i"(&((char *)key)[branch]) :  : l_yes);
> > +                :  :  "S"(&((char *)key)[branch]) :  : l_yes);
> 
> 'key' is not used as a raw symbol name. We should make this
> 
> "    .quad   %0 + %1 - ."
> 
> and
> 
> ::  "S"(key), "i"(branch) :: l_yes);
>
> if we want to really clean this up.

This hides more logic in the asm so it's arguably more cryptic
(although the code is fairly cryptic to begin with -- I don't really
see why the argument wasn't written as the equivalent
(char *)key + branch...)

Anyway, I don't think the "i" versys "S" distinction makes any
difference without -fpic or equivalent, so it is not really relevant
for the kernel (except that "S" breaks compatibility with older
compilers...)


I think the main advantage of "S" is that it stops you accidentally
emitting undesirable relocations from asm code that is not written for
the -fpic case.

But just changing "i" to "S" is not sufficient to port asms to -fpic:
the asms still need to be reviewed.


So unless the asm has been reviewed for position-independence, it may
anyway be better to stick with "i" so that the compiler actually chokes
if someone tries to build the code with -fpic.

Since we are not trying to run arbitraily many running kernels in a
common address space (and not likely to do that), I'm not sure that we
would ever build the kernel with -fpic except for a few special-case
bits like the EFI stub and vDSO... unless I've missed something?

If there's another reason why "S" is advantageous though, I'm happy to
be corrected.

[...]

Cheers
---Dave

