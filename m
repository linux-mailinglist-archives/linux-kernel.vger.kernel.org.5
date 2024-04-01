Return-Path: <linux-kernel+bounces-127212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C0AB89480F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 01:58:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 965A71C21641
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 23:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D2AA5730A;
	Mon,  1 Apr 2024 23:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lo8p8kuZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A512A1BF
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 23:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712015884; cv=none; b=K6gdD4DGoaSMPn888AZXhvOcTz/yjH98YTS9oCTv8lHrR3S40KBGBnexAJOBs8tfRBUctUYTmBVZzPGZK1ZPqnnAlUEUY0B9E1RcqifgDY5q9SOUAvd6eBxX657LCyDWZ19bJnaz54kBR3J9amK3B9hVFfqpa2vCYCWTDR+3Ung=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712015884; c=relaxed/simple;
	bh=fsiBBvIJAOzzKkbKl77IibYOq5HU+gyI/GmJc1/N8Vk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qsBdMPh9DYz3voEtidb1j05y/h6Bd72X4HspBQh0VKeJnzximSa7d68PI79SkT/PI5sA49zjJIl7uto4af7+vFXStGpi2FkvcGxXC+VkZ0AsBx9VJNJRZRr92uGp0Sy25GRLuqa/lbSdqKN+KwD+dOM6zNb9S5AxlFGaAtyhBzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lo8p8kuZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F396BC433F1;
	Mon,  1 Apr 2024 23:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712015884;
	bh=fsiBBvIJAOzzKkbKl77IibYOq5HU+gyI/GmJc1/N8Vk=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=Lo8p8kuZ/TY9CU6DLhsKgJkQwAHZzkjU4kDnOqCreVzehJUoObE6bR/rDpj+Yjlxq
	 wrUErTMq/JVkppEA74kwgoCiqwSosVaZtn9IcSfOBks8ESpX32sTdp71n+RRbYap3Q
	 WK3z0d8XSlLrn+y9rTBEzcQSB16uVOHl/FjyraGaE0ARPQswMFBwgZEj7MrMu5EKD3
	 vDO7DXAfNp0jlpSn33iUzcnWTQbVPoYstRv/NeyYNBdZYNa07YZ9nBwMussb3yQfYU
	 aSEDz1gmph0j4UDBWrVNl8rcAiq+dJ843+Uinay+7jvymOR7qDDaI1PH0jIeWQ2hI9
	 qT0HOiB4NtRgg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 97F9ACE074C; Mon,  1 Apr 2024 16:58:03 -0700 (PDT)
Date: Mon, 1 Apr 2024 16:58:03 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Palmer Dabbelt <palmer@rivosinc.com>, Arnd Bergmann <arnd@arndb.de>,
	Marco Elver <elver@google.com>
Subject: Re: [PATCH RFC cmpxchg 2/8] sparc: Emulate one-byte and two-byte
 cmpxchg
Message-ID: <114dc62e-e0fb-41c8-bf9c-a9fda8b19eb6@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <31c82dcc-e203-48a9-aadd-f2fcd57d94c1@paulmck-laptop>
 <20240401213950.3910531-2-paulmck@kernel.org>
 <20240401223803.GZ538574@ZenIV>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240401223803.GZ538574@ZenIV>

On Mon, Apr 01, 2024 at 11:38:03PM +0100, Al Viro wrote:
> On Mon, Apr 01, 2024 at 02:39:44PM -0700, Paul E. McKenney wrote:
> > Use the new cmpxchg_emu_u8() and cmpxchg_emu_u16() to emulate one-byte
> > and two-byte cmpxchg() on 32-bit sparc.
> 
> >  __cmpxchg(volatile void *ptr, unsigned long old, unsigned long new_, int size)
> >  {
> >  	switch (size) {
> > +	case 1:
> > +		return cmpxchg_emu_u8((volatile u8 *)ptr, old, new_);
> > +	case 2:
> > +		return cmpxchg_emu_u16((volatile u16 *)ptr, old, new_);
> >  	case 4:
> >  		return __cmpxchg_u32((u32 *)ptr, (u32)old, (u32)new_);
> >  	default:
> 
> Considering how awful sparc32 32bit cmpxchg is, it might be better to
> implement those directly rather than trying to do them on top of
> that.  Something like
> 
> #define CMPXCHG(T)	\
> 	T __cmpxchg_##T(volatile ##T *ptr, ##T old, ##T new)	\
> 	{							\
> 		unsigned long flags;				\
> 		##T prev;					\
> 								\
> 		spin_lock_irqsave(ATOMIC_HASH(ptr), flags);	\
> 		if ((prev = *ptr) == old)			\
> 			*ptr = new;				\
> 		spin_unlock_irqrestore(ATOMIC_HASH(ptr), flags);\
> 		return prev;					\
> 	}
> 
> CMPXCHG(u8)
> CMPXCHG(u16)
> CMPXCHG(u32)
> CMPXCHG(u64)
> 
> in arch/sparc/lib/atomic32.c, replacing equivalent __cmpxchg_u{32,64}()
> definitions already there and use of those in that switch in __cmpxchg()
> definition...

Fair enough, and ATOMIC_HASH() is set up to permit mixed-size atomic
accesses courtesy of ignoring the bottom bits, though ignoring more
of them than absolutely necessary.  Maybe 32-bit sparc has 32-byte
cache lines?

Would you like to do that patch?  If so, I would be happy to drop mine
in favor of yours.  If not, could I please have your Signed-off-by so
I can do the Co-developed-by dance?

							Thanx, Paul

