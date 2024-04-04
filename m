Return-Path: <linux-kernel+bounces-130852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3AC5897DF4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 05:09:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C062B261AF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 03:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 950891CD3F;
	Thu,  4 Apr 2024 03:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RzZasvmc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DACC91CD2D
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 03:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712200161; cv=none; b=ud7gZpZkMUZmUE6VPwo+WU5PNqLkvKpTAmIydn72ii8rUDd3IiS3YrnXgEQSHN12i0qYqZD1TLcuqPuNEQICvcahD2sWxFE1vS3nx2qTCvCxhGJqpHWi3qadBq6dnUlVmCMuP8s1SMr7W8vylCmUhasL17UkOqKVJHnn0zu1Yzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712200161; c=relaxed/simple;
	bh=VeDsqzIDw+9y6Q1G53nbCpHTMO3LeJQlYx7W7Yi3jSM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pA7lYxyq0QUkk5ZPnAhsyhqclj0cSap2jJXaPBbGv0g9jCUL3Rfp3HVe8JrIxN95A3AZSrfPYYtQAqKJ0vAA/eEbcRUh89n5rYTxTri0VYWZ7CzAc/vfZu9M0fRIuL41rE5CTKJ7xbhRmDERwEnaMPxP9x2OQc+l6oOW9WsYGLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RzZasvmc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 658EFC433F1;
	Thu,  4 Apr 2024 03:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712200161;
	bh=VeDsqzIDw+9y6Q1G53nbCpHTMO3LeJQlYx7W7Yi3jSM=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=RzZasvmcsRMTp33dFG8x+1sEkl14h39MN8HQ/TPzu7uHky1o2tJzapBkO/zM5ctUR
	 5HAnhPIT6aNJ30FETgzkhPAtMe2PcZMMI1e5edBVVoAJiaGuqycqqgCaXy8CmwzdQ/
	 3FwUVCWmLeKWwDGhE8yQoCtpk6WhNOa5lQruIwnVP5Q+TaRGg/lLZyYFHby3toAfo9
	 rfG0KBcZZ9T04c/qBELknVaIIezJ1BPqppzujFuktbVH54FZbZgfE6JaESIz6Fb70r
	 AK7KHzFmVdEw29ZrZg8E7BUpVV9rMGxUPKTZ2/zt8Y9FvK/fBWOGGyyhly7HpOn2zX
	 ec5R1M38NjUjA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 0DAD8CE109B; Wed,  3 Apr 2024 20:09:21 -0700 (PDT)
Date: Wed, 3 Apr 2024 20:09:21 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Palmer Dabbelt <palmer@rivosinc.com>, Arnd Bergmann <arnd@arndb.de>,
	Marco Elver <elver@google.com>
Subject: Re: [PATCH 1/8] sparc32: make __cmpxchg_u32() return u32
Message-ID: <2676cf77-1374-4d39-a669-e2db4b9b7bf5@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240402041138.GF538574@ZenIV>
 <20240402042835.11815-1-viro@zeniv.linux.org.uk>
 <85837f16-903c-44cd-8277-377e0228eb61@paulmck-laptop>
 <20240403222053.GK538574@ZenIV>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403222053.GK538574@ZenIV>

On Wed, Apr 03, 2024 at 11:20:53PM +0100, Al Viro wrote:
> On Tue, Apr 02, 2024 at 01:03:13PM -0700, Paul E. McKenney wrote:
> > On Tue, Apr 02, 2024 at 12:28:28AM -0400, Al Viro wrote:
> > > Conversion between u32 and unsigned long is tautological there,
> > > and the only use of return value is to return it from
> > > __cmpxchg() (which return unsigned long).
> > > 
> > > Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> > 
> > I have pulled these in as replacements for my patches in the meantime.
> > 
> > Thank you!
> 
> FWIW, updated branch force-pushed; the difference is that __cmpxchg()
> on sparc32 went
> -       switch (size) {
> -       case 1:
> -               return __cmpxchg_u8((u8 *)ptr, (u8)old, (u8)new_);
> -       case 2:
> -               return __cmpxchg_u16((u16 *)ptr, (u16)old, (u16)new_);
> -       case 4:
> -               return __cmpxchg_u32((u32 *)ptr, (u32)old, (u32)new_);
> -       default:
> -               __cmpxchg_called_with_bad_pointer();
> -               break;
> -       }
> -       return old;
> +       return
> +               size == 1 ? __cmpxchg_u8(ptr, old, new_) :
> +               size == 2 ? __cmpxchg_u16(ptr, old, new_) :
> +               size == 4 ? __cmpxchg_u32(ptr, old, new_) :
> +                       (__cmpxchg_called_with_bad_pointer(), old);
> 
> (and similar for parisc).  Rationale: sparse does generate constant
> truncation warnings in unreachable statements, but not in never-evaluated
> subexpressions.  Alternative would be what parisc used to do in mainline:
> 	case 1: return __cmpxchg_u8((u8 *)ptr, old & 0xff, new_ & 0xff);
> and we'd need the same in 16bit case (both on parisc and sparc32).
> Explicit (and rather mysterious) & 0xff for passing unsigned long to
> a function that takes u8 was there to tell sparse that e.g.
> cmpxchg(&int_var, 0, 0x12345678) was *not* trying to feed
> 0x12345678 to a __cmpxchg_u8(), which would quietly truncate it had
> it ever been reached.  Use of conditional expression avoids that
> without having to play with explicit (and utterly pointless from
> C point of view) masking.  IMO it's better that way, not to mention
> being more concise than use of switch.

Cute!  I replaced the old versions of your patches with this series.

However, I was too lazy to apply this transformation to the other
cmpxchg() implementations.  ;-)

							Thanx, Paul

