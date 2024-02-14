Return-Path: <linux-kernel+bounces-65468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38EF2854D73
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 16:56:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC5A01F2BE24
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 15:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD12D5D916;
	Wed, 14 Feb 2024 15:56:00 +0000 (UTC)
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B0DF5B5DB
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 15:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=163.172.96.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707926160; cv=none; b=sToOmL6Rg8zVtS9Sz0etO0k5Y5BYHqSKRW/nPZ+b1kP/MREG+AbuUK07qqrH6nAWXLldiDz8CxSS9rJ1Xl1tj+7A4uRttxO3XNQf1U7R/9XKX3dWvKBhwvhCP+8JViuVGLrZ3yWMKF4MhaCEgwojGZ8BVA/43hpcJgkejaoymqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707926160; c=relaxed/simple;
	bh=GYlOf0ZLZBjDUzNZHnjjcXz77os/gke35De2B3RvlBc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UbSEZjQeFbsnpecZ7WrhdsMpDYh9TjVbvTKAUktIrMOxZzBAALrZ5Nk57ziAwJvn+YHT5BBxjQ9SOkh+MBjbw2L0YYLy4CMDBUHGD/AFbPOs6ka3jHM1H5FUSA9QFkBRaWp/za9ZCZqikpY1Dz14TQmH3vy7pOozoiXHpMkzKVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; arc=none smtp.client-ip=163.172.96.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Received: (from willy@localhost)
	by mail.home.local (8.17.1/8.17.1/Submit) id 41EFtj2x006798;
	Wed, 14 Feb 2024 16:55:45 +0100
Date: Wed, 14 Feb 2024 16:55:45 +0100
From: Willy Tarreau <w@1wt.eu>
To: Rodrigo Campos <rodrigo@sdfg.com.ar>
Cc: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] tools/nolibc: Fix strlcpy() return code and size
 usage
Message-ID: <ZczigTyNa5dqtKRy@1wt.eu>
References: <20240129141516.198636-1-rodrigo@sdfg.com.ar>
 <20240129141516.198636-4-rodrigo@sdfg.com.ar>
 <20240211110814.GB19364@1wt.eu>
 <cc997fd5-1478-43fc-8ba0-aba5e7b3bfdc@sdfg.com.ar>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc997fd5-1478-43fc-8ba0-aba5e7b3bfdc@sdfg.com.ar>

On Wed, Feb 14, 2024 at 12:50:53PM -0300, Rodrigo Campos wrote:
> On 2/11/24 12:08, Willy Tarreau wrote:
> > Hi Rodrigo,
> > 
> > It's good, but for the same reason as the previous one, I'm getting
> > smaller code by doing less in the loop. Also calling strlen() here
> > looks expensive, I'm seeing that the compiler inlined it nevertheless
> > and did it in a dep-optimized way due to the asm statement. That
> > results in 67 bytes total while a simpler version gives 47.
> > 
> > If I explicitly mark strlen() __attribute__((noinline)) that prevents
> > it from doing so starting with gcc-10, where it correctly places a jump
> > from strlcpy() to strlen() and ends up with 50 bytes (vs 44 for the alt
> > one). The other one I can propose is directly derived from the other
> > strlcat() variant, which first performs the copy and starts to count:
> > 
> > size_t strlcpy(char *dst, const char *src, size_t size)
> > {
> >          size_t len;
> > 
> >          for (len = 0; len < size; len++) {
> >                  if (!(dst[len] = src[len]))
> >                          return len;
> >          }
> > 
> >          /* end of src not found before size */
> >          if (size)
> >                  dst[size - 1] = '\0';
> > 
> >          while (src[len])
> >                  len++;
> > 
> >          return len;
> > }
> > 
> > Just let me know what you think.
> 
> This is one is very nice, thanks!
> 
> Sorry I didn't think about the size at all when writing the functions :)

Never be sorry, low-level user code like this is never trivial and
that's the goal of the nolibc-test in the first place ;-)

> We can change the loop to be:
> 
>         for (len = 0; len < size; len++) {
>                 dst[len] = src[len];
>                 if (!dst[len])
>                         break;
>         }
> 
> That IMHO it is slightly more readable and makes it only 2 bytes longer
> here.

It's not exactly the same, it will always write a zero at dst[size-1]
due to the break statement. As much as I hate returns in the middle,
this one made sense for this case. A goto to the final return statement
is fine as well.

> What do you think? I'm fine with both, of course.

I'm fine with the more readable part (I also prefer it) but not the use
of break here.

> If I resend, shall I add a suggested-by or directly you as the author?

No need for either, it's your work, my part was just a review and an
addictive temptation to look at asm code ;-)

Cheers,
Willy

