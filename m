Return-Path: <linux-kernel+bounces-164875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D7268B8451
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 04:22:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C52AB2241C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 02:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB7E712B71;
	Wed,  1 May 2024 02:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="JCcmxzxx"
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E230F10A2B
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 02:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714530146; cv=none; b=l8JJDxEQxJZ42ffaPm2lf7Rr/pkNU6gAUNgEyYeJEHtbB7ETWul5qyOawhYiE+Z6Xi3FwdVTFDOiJRgHd3gHZpNqjvl0mKfgAJwEVEo1rgrCjsqdXXOZQzYpVH97k0+Q1tqQThRDFNVwhF0BnIFKts4KgqmqX+cl6enePSouIk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714530146; c=relaxed/simple;
	bh=tLDbUIdh1res7S2ApImHSrYF3GBedRC/aB6hGdipB7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VREIAtsrRtgFWYHC41diaXcMLOETMxU6SeEppoL6+L4mhGRXAM0bZkh6E61mSDmyqfyGlwxiKDeh0ggD+GFPGLFRkGuhMIVVVFlshEC0UIgBeH7TPt+3OPLRi1nygDZKzEu2rlrk25gcj0NFoYJlsei+ELjm75M876eqsCwmIfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=JCcmxzxx; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-108-26-156-33.bstnma.fios.verizon.net [108.26.156.33])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 4412M2lD018844
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Apr 2024 22:22:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1714530126; bh=ycnxCU4aRUN0CT5wAn+au+vBsaR04nzay6J9xUEb54Q=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=JCcmxzxxmA2Uiv4hCUXnE1PYZSqWRCq2ywaa3ukQfwZoIm9rCjZJmjwJD+IInjDDK
	 Ih7RL6X489M2hup3eskn7wdLc6yzll2AMQzJCDEWWZ8USYLsWKBTsGYyk9aAvBEXLx
	 UANwQfv0sZIIh92XmHx2AE1g9EqchQSznoIP4BQnJRfkPvC/QhQYBbm7/g3jYbiO8u
	 2lyWpqREDHAAkxbDrSi1QYoPvbSdenEWglYgwyckgc86Jc+XXLIBtAzmYYbXhhJHz7
	 J577qRGfGhm/FoDG9KDP09046zXEyJsT6enU7fYxM1Pg4UiqxeLQRgpWwxaYu7IkLD
	 sW9uvtl3+hl0A==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id EB87115C02BB; Tue, 30 Apr 2024 22:22:01 -0400 (EDT)
Date: Tue, 30 Apr 2024 22:22:01 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Aaron Toponce <aaron.toponce@gmail.com>
Cc: Eric Biggers <ebiggers@kernel.org>, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org
Subject: Re: [PATCH] random: add chacha8_block and swtich the rng to it
Message-ID: <20240501022201.GD1743554@mit.edu>
References: <20240429134942.2873253-1-aaron.toponce@gmail.com>
 <20240430031105.GA10165@sol.localdomain>
 <ZjB2ZjkebZyC7FZp@hercules>
 <20240430162632.GA1924352@mit.edu>
 <ZjEf2VV4igcCtkRE@hercules>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjEf2VV4igcCtkRE@hercules>

So first of all, my apologies for giving you offense.  I really didn't
think you were a shill for the NSA or the MSS, but I have to admit
that when I get large set of patches which removes "unnecessary" code,
which is _technically_ safe, but which reduces the safety margin, I
find myself wondering whether it's part of a binary payload.  (This is
especially when I get patches from someone that I don't normally
receive patches from.)  Unfortunately, in the wake of the xz hack,
we're just all going to have to be a lot more careful.

On Tue, Apr 30, 2024 at 10:44:09AM -0600, Aaron Toponce wrote:
>
> The goal is just to make the CSPRNG more efficient without sacrificing security.
> Of course most reads will be small for cryptographic keys. ChaCha8 means even
> those small reads will be 2.5x more efficient than ChaCha20. The dd(1) example
> was just to demonstrate the efficiency, not to be "fun".

This is a philosophical question; are we going for maximum efficiency,
or maximum safety so long as it meets the performance requirements for
the intended use case?  From an academic perspective, or if a
cryptographer is designing cipher for a NIST competition, there's a
strong desire for maximum efficiency, since that's one of the metrics
used in the competition.  But for the Linux RNG, my bias is to go for
safety, since we're not competing on who can do the fast bulk
encryption, but "sufficiently fast for keygen".

People of good will can disagree on what the approach should be.  I
tend to have much of a pragmatic engineer's perspective.  It's been
said that the Empire State Building is overbuilt by a factor of 10,
but that doesn't bother me.  People are now saying that perhaps the
Francis Scott Key bridge, when it is rebuilt, should have more safety
margin, since container ships have gotten so much bigger.  (And
apparently, cheap sh*t diesel fuel that is contaminated and the ship
owners buy fuel from the lowest bidder.)

Or we can talk about how Boeing has been trying to cheap-out on plane
manufacturing to save $$$; but I think you get the point of where I'm
coming from.  I'm not a big fan of trimming safety margins and making
things more efficient for it's own sake.  (At least in the case of
Boeing, the CEO at least got paid $22/million a year, so at least
there's that.  :-)

Now, if this is actually impacting the TLS connection termination for
a Facebook or Bing or Google's front end web server, then great, we
can try to optimize it.  But if it's not a bottleneck, what's the
point?  Making change for change's sake, especially when it's reducing
safety margins, is just one of those things that I find really hard to
get excited about.

Cheers,

					- Ted

