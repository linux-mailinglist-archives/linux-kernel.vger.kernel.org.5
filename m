Return-Path: <linux-kernel+bounces-56558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5C6B84CBBF
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 14:39:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BA23285B8A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 13:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 361BC77630;
	Wed,  7 Feb 2024 13:39:21 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 208F43C062
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 13:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707313160; cv=none; b=PBa8aePpQieYTpZqpQUtawSz0/HP/aBjN+uioZhGh/B+dvnNTJ7j9TfK8UqBTZB9Vb9uquQAngXQTYH5xOSmHBQuOGb++IKCu2NxivmOd5jPrPI14eLG4rGAiHI8j7brPcnybzxnpQicglj/rK9jdKY1IoFeO+r+ZdSKtHLvj0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707313160; c=relaxed/simple;
	bh=aBs+EX7Bb+YTjsckp3Mn2PkEbqjk5GQOA8AhCugaPyY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gRjNAd7iXtCXkveecCVH2T/Kh9E2Wn1hygFo+NDC52xqnyFCrtxTxNJf9pU0UM5ObwOVnx1ccgQ/wFH4z3J8GkZdOLssjqQ03ZucemOQXaJK6dBEn++DR2GEx4mOpstN5qN1Uxhl2Ay2MKvmV9mCopZd/uKPFFNi9xmABidSb3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 379A41FB;
	Wed,  7 Feb 2024 05:39:59 -0800 (PST)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.58])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0F7E03F762;
	Wed,  7 Feb 2024 05:39:15 -0800 (PST)
Date: Wed, 7 Feb 2024 13:39:13 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: Mark Brown <broonie@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64/sve: Document that __SVE_VQ_MAX is much larger
 than needed
Message-ID: <ZcOIAck16ZyUi/yj@e133380.arm.com>
References: <20240206-arm64-sve-vl-max-comment-v1-1-dddf16414412@kernel.org>
 <ZcNxJ56+bvcUTGlT@e133380.arm.com>
 <ZcN8OltRDUlDlTHQ@finisterre.sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZcN8OltRDUlDlTHQ@finisterre.sirena.org.uk>

On Wed, Feb 07, 2024 at 12:48:58PM +0000, Mark Brown wrote:
> On Wed, Feb 07, 2024 at 12:01:43PM +0000, Dave Martin wrote:
> > On Tue, Feb 06, 2024 at 04:27:01PM +0000, Mark Brown wrote:
> 
> > > +/*
> > > + * Note that for future proofing __SVE_VQ_MAX is defined much larger
> > > + * than the actual architecture maximum of 16.
> > > + */
> 
> > I think that putting shadow #defines in comments in UAPI headers is a
> > really bad idea...  is this a normative statement about the user API,
> > or what?
> 
> Well, the only reason I'm mentioning the constant here is that
> __SVE_VQ_MIN is defined too and has a perfectly good value, things look
> a bit neater with a shared comment block.  I'm not sure there's a hugely
> meaingful difference between having a comment adjacent to a named
> constant in a header and one a couple of lines away that mentions the
> constant by name.

It wasn't so much the exact location that concerned me, rather putting
it in a UAPI header at all.

Maybe so long as the comment doesn't quote a literal value for the arch
max VQ that would be better.  If there is a value there, we may be kind
of legitimising its use even if it's in a comment...

> 
> > My concern is that if we muddy the waters here different bits of
> > software will do different things and we will get a mess with no
> > advantages.
> 
> > Portability issues may ensue if userspace software feels it can
> > substitute some other value for this constant, since we can't control
> > what userspace uses it for.
> 
> I don't think we want people using this at all, ideally we'd remove it
> but it's in the uapi.

I think the main legitimate uses are for implementing sve_vl_valid() and
for type selection purposes (analogous to the C <limits.h> constants --
though all the "obvious" types are fine so this is a but redundant).
But yeah, it's there now.

> > Would it be sufficient to say something like:
> 
> > /*
> >  * Yes, this is 512 QUADWORDS.
> >  * Never allocate memory or size structures based on the value of this
> >  * constant.
> >  */
> > >  #define __SVE_VQ_MAX		512
> 
> I think the fact that this vector length is more than an order of
> magnitude more than is architecturally supported at present needs to be
> conveyed, it's perfectly reasonable for people to not want to do dynamic
> allocation/sizing of buffers in some applications and the above sounds
> more like stylistic guidance about using dynamic sizing to improve
> memory usage.

I guess that's true; people need to know that they'll be allocating a
silly amount of memory if they use the existing _MAX constants directly.
Laziness is a perfectly good reason for doing this for development hacks
that aren't going to be published, less so for code that ends up in
libraries or otherwise gets into the wild...

I preferred to encourage people to size dynamically, but we don't have
a way to enforce it.

Ideally there would be a direct way to read out the system-wide max VL
to provide userspace with a sensible default allocation size, but that
doesn't really exist today (though ptrace and PR_SVE_{SET,GEL}_VL
provide ways to find out, but it's a bit grungy).

How about something along the lines of:

/*
 * Yes, this is 512 QUADWORDS.
 * To help ensure forward portability, this is much larger than the
 * current maximum value defined by the SVE architecture.
 * While arrays or static allocations can be sized based on this value,
 * watch out!  It will waste a surprisingly large amount of memory.
 * Dynamic sizing based on the actual runtime vector length is likely to
 * be preferable for most purposes.
 */

> 
> > Though comments might be better placed alongsize SVE_VQ_MAX at al., in
> > ptrace.h and sigcontext.h rather than here.  The leading __ should at
> > least be a hint that __SVE_VQ_MAX shouldn't be used directly by
> > anyone...
> 
> Yeah, the multiple layers of indirection aren't helpful here.  We
> probably need to comment it in both places TBH.

Agreed, part of that came from a desire to avoid duplicating
information.  I think the indirection via sve_context.h was introduced
to work around a bad interaction with user C library headers, but I'm a
bit hazy on that now without digging through the history.

Cheers
---Dave

