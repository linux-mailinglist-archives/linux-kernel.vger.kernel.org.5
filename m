Return-Path: <linux-kernel+bounces-137330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DAA4C89E07F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 18:34:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 175461C2119F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 16:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01EAF153574;
	Tue,  9 Apr 2024 16:34:46 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3274E131198
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 16:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712680485; cv=none; b=b5Ml7pBE89OE69sMp7i+CFgCfrp04DgAhP1BP9R8GfuTMrVoxhzaBIm8JsNOIMSu8ytS1anQKAhH2Pxsxby/vzkKUMfeU8h5WqVLPGIsvfLMIiC8pgUyvaFbLZyNdRevb3zT/rslJDE9GSRs5itSHREwLpIv871I40d6UYGeQXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712680485; c=relaxed/simple;
	bh=P7X6qHt95v8MEGLWqAQUF14/l9TPeP4OkPLmOmZK2XI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iSF0ucYA6zk1NYsCIHetjTmM+TKzYieXB6I6uSpXLWjSJWdzmfV7KAPfL0SI19HMtL7T/JUNYKdiX1tkkMaG7W40N2plEXGMLXJstECgZc69uqqZDXtxeV6a1uFXIQgZ1l+Lp+V9x5lvSGC+vCrlgn6a4QbA5IIhM8Q7P1qgHOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 67E90139F;
	Tue,  9 Apr 2024 09:35:12 -0700 (PDT)
Received: from FVFF77S0Q05N.cambridge.arm.com (FVFF77S0Q05N.cambridge.arm.com [10.1.29.129])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 005143F6C4;
	Tue,  9 Apr 2024 09:34:40 -0700 (PDT)
Date: Tue, 9 Apr 2024 17:34:35 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Uros Bizjak <ubizjak@gmail.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 2/6] locking/atomic/x86: Rewrite x86_32
 arch_atomic64_{,fetch}_{and,or,xor}() functions
Message-ID: <ZhVuG4J7aocGvd0-@FVFF77S0Q05N.cambridge.arm.com>
References: <20240409100503.274629-1-ubizjak@gmail.com>
 <20240409100503.274629-3-ubizjak@gmail.com>
 <ZhUixk5I_n53dbBb@FVFF77S0Q05N>
 <CAFULd4bBmQ85UsPOOEA+5dj-_JOBNWeyM-jipM7Zov2V484quQ@mail.gmail.com>
 <CAFULd4Z8JTc_5p8apO680es0fYO5ke9yYPpPUfp=15XrRbKESQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFULd4Z8JTc_5p8apO680es0fYO5ke9yYPpPUfp=15XrRbKESQ@mail.gmail.com>

On Tue, Apr 09, 2024 at 02:50:19PM +0200, Uros Bizjak wrote:
> On Tue, Apr 9, 2024 at 2:03 PM Uros Bizjak <ubizjak@gmail.com> wrote:
> >
> > On Tue, Apr 9, 2024 at 1:13 PM Mark Rutland <mark.rutland@arm.com> wrote:
> >
> > > >  static __always_inline void arch_atomic64_and(s64 i, atomic64_t *v)
> > > >  {
> > > > -     s64 old, c = 0;
> > > > +     s64 val = __READ_ONCE(v->counter);
> > >
> > > I reckon it's worth placing this in a helper with a big comment, e.g.
> > >
> > > static __always_inline s64 arch_atomic64_read_tearable(atomic64_t *v)
> > > {
> > >         /*
> > >          * TODO: explain that this might be torn, but it occurs *once*, and can
> > >          * safely be consumed by atomic64_try_cmpxchg().
> > >          *
> > >          * TODO: point to the existing commentary regarding why we use
> > >          * __READ_ONCE() for KASAN reasons.
> > >          */
> > >         return __READ_ONCE(v->counter);
> > > }
> > >
> > > ... and then use that in each of the instances below.
> > >
> > > That way the subtlety is clearly documented, and it'd more clearly align with
> > > the x86_64 verions.
> >
> > This is an excellent idea. The separate definitions needs to be placed
> > in atomic64_32.h and atomic_64_64.h (due to use of atomic64_t
> > typedef), but it will allow the same unification of functions between
> > x64_32 and x64_64 as the approach with __READ_ONCE().
> 
> Something like this:
> 
> --cut here--
> /*
>  * This function is intended to preload the value from atomic64_t
>  * location in a non-atomic way. The read might be torn, but can
>  * safely be consumed by the compare-and-swap loop.
>  */
> static __always_inline s64 arch_atomic64_read_tearable(atomic64_t *v)
> {
>     /*
>      * See the comment in arch_atomic_read() on why we use
>      * __READ_ONCE() instead of READ_ONCE_NOCHECK() here.
>      */
>     return __READ_ONCE(v->counter);
> }
> --cut here--
> 
> Thanks,
> Uros.

Yeah, something of that shape.

Having thought for a bit longer, it's probably better to use '_torn' rather
than '_tearable' (i.e. name this arch_atomic64_read_torn()).

It'd be nice if we could specify the usage restrictions a bit more clearly,
since this can only be used for compare-and-swap loops that implement
unconditional atomics. (e.g. arch_atomic64_and(), but not
arch_atomic_add_unless()).

So I'd suggest:

/*
 * Read an atomic64_t non-atomically.
 *
 * This is intended to be used in cases where a subsequent atomic operation
 * will handle the torn value, and can be used to prime the first iteration of
 * unconditional try_cmpxchg() loops, e.g.
 *
 * 	s64 val = arch_atomic64_read_torn(v);
 * 	do { } while (!arch_atomic_try_cmpxchg(v, &val, val OP i);
 *
 * This is NOT safe to use where the value is not always checked by a
 * subsequent atomic operation, such as in conditional try_cmpxchg() loops that
 * can break before the atomic, e.g.
 *
 * 	s64 val = arch_atomic64_read_torn(v);
 * 	do {
 * 		if (condition(val))
 * 			break;
 * 	} while (!arch_atomic_try_cmpxchg(v, &val, val OP i);
 */
static __always_inline s64 arch_atomic64_read_torn(atomic64_t *v)
{
    /* See comment in arch_atomic_read() */
    return __READ_ONCE(v->counter);
}

Mark.

