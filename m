Return-Path: <linux-kernel+bounces-127140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1CC9894762
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 00:38:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABA30282B6F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 22:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DA0A55C3B;
	Mon,  1 Apr 2024 22:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="plBg51k+"
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB2B8F6F
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 22:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712011093; cv=none; b=fXJShpSsMm7IwyjXUk4CbOgWcClvVRJAG4wNGYHpnLoDtpDP0/ZA6LhEa6aLC1tkkvy2tS32YraeceI/5DZKFVKZ43MUHIb/EOITwh2cLzS+nScpH5ERjbpE4VHL1wtevM+onoSkflHuWJn75jXkN3xhGb8irJGrRqiEPcnqA/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712011093; c=relaxed/simple;
	bh=g/h+7JQtmK0612QuZpj38JeIqT5igHLPix+xixz83Ec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jd2X0LYRIvOqTRs31CbwNgr1lkbWifNHFNjStryrlV+4P0fHWMPxN95Ud6JB/AsmJmnzaLWhCfOUXT8yrexZPkRjRoLg63TB3+HQWuH9+RUIF4FmOkt8PtqLoTch7E/ae5VbGy45sVGm9nlfpLGJuWzNyNOrmOTvymNr7VoL08I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=plBg51k+; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=F/FK682CzzS2lTPRJ6kmulNGDgp0gh8yyv2qOpj+Vfg=; b=plBg51k+Zuu8uvQXOx6kwQJFfS
	1CYyecZypKTi0CKJmYscdL5L27L8oK69PJuj4qY/uWM+3WavqtqqwqoAV0qMsGwjoKwpAFS5zhVsB
	gewDLU3SmQmImtpBPWv6wTEecc7rK6tdR3Ku+97sXB3lWa1DD2l/nPQamIS+v0Y6ogh/YXJBRbvVx
	K6WzQGZkpN1zEm/jvuOusZv0As94oXKaVVKQAR+GQNDNg0eUffrchILbH8PfZb7Soebv4YX2uCkKi
	mx9haC3MgGgtmSTaeTdZLzG8dE4VrPKRHxk04CzctPMz+8kZxPSBvYNZKQ3Nl5DysTUSpIfuK3J4F
	IYPaac7A==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rrQHz-003mh2-1t;
	Mon, 01 Apr 2024 22:38:03 +0000
Date: Mon, 1 Apr 2024 23:38:03 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Palmer Dabbelt <palmer@rivosinc.com>, Arnd Bergmann <arnd@arndb.de>,
	Marco Elver <elver@google.com>
Subject: Re: [PATCH RFC cmpxchg 2/8] sparc: Emulate one-byte and two-byte
 cmpxchg
Message-ID: <20240401223803.GZ538574@ZenIV>
References: <31c82dcc-e203-48a9-aadd-f2fcd57d94c1@paulmck-laptop>
 <20240401213950.3910531-2-paulmck@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240401213950.3910531-2-paulmck@kernel.org>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Apr 01, 2024 at 02:39:44PM -0700, Paul E. McKenney wrote:
> Use the new cmpxchg_emu_u8() and cmpxchg_emu_u16() to emulate one-byte
> and two-byte cmpxchg() on 32-bit sparc.

>  __cmpxchg(volatile void *ptr, unsigned long old, unsigned long new_, int size)
>  {
>  	switch (size) {
> +	case 1:
> +		return cmpxchg_emu_u8((volatile u8 *)ptr, old, new_);
> +	case 2:
> +		return cmpxchg_emu_u16((volatile u16 *)ptr, old, new_);
>  	case 4:
>  		return __cmpxchg_u32((u32 *)ptr, (u32)old, (u32)new_);
>  	default:

Considering how awful sparc32 32bit cmpxchg is, it might be better to
implement those directly rather than trying to do them on top of
that.  Something like

#define CMPXCHG(T)	\
	T __cmpxchg_##T(volatile ##T *ptr, ##T old, ##T new)	\
	{							\
		unsigned long flags;				\
		##T prev;					\
								\
		spin_lock_irqsave(ATOMIC_HASH(ptr), flags);	\
		if ((prev = *ptr) == old)			\
			*ptr = new;				\
		spin_unlock_irqrestore(ATOMIC_HASH(ptr), flags);\
		return prev;					\
	}

CMPXCHG(u8)
CMPXCHG(u16)
CMPXCHG(u32)
CMPXCHG(u64)

in arch/sparc/lib/atomic32.c, replacing equivalent __cmpxchg_u{32,64}()
definitions already there and use of those in that switch in __cmpxchg()
definition...

