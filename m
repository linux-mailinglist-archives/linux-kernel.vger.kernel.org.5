Return-Path: <linux-kernel+bounces-127215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4407789483A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 02:08:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECE37281276
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 00:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE34F10E4;
	Tue,  2 Apr 2024 00:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="EKJ77+z3"
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56D263B
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 00:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712016486; cv=none; b=Hk0BTc8jmQhh0/uOXufXHtygTJXNNlHFHBmGmkcbwwKDHj31rtkvN9g1jC2VYqynodwDUT2m96Tt+Vb9jtpx3Hm+CIrzED4HVPeMr7zjq6hFA2YNQ7YmA48HyVJtrCuBH2pMWfEsnl/ZzGwnzmrUTvhIpFm24dU9l5GPNsPLiSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712016486; c=relaxed/simple;
	bh=3iqcDfQvV5eTkK8+FaYqYkd8Mmp+kIsVRK+kk/49ADQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S2QeA2RyUWguc2NO0+hB5Fav6P4fBnN6ScAafLoOk7U3I9SevI864omfzxvOLaRoHIeSOFnLtOkEcl/Ei+KA8YHiRdMDkH5QZksW3DIJ/i44CMhFF1PPC2bVBdJkDGmRLeYNMzUezvLvlnTfvXVB8m7yng8V0x4SSvQGLX8Bt9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=EKJ77+z3; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=71a16oSYHYPdoHilTvQ/qeA3JByfSomScx3Ab6FT3e4=; b=EKJ77+z3UaGKJbaBtwJ353/6w9
	qrVwayRvcZxzoX4TC3dosfCiwdSFzL6TpCAvcNt2hMHIei0IwngS9UpsRTb7IfPhdvgScly78v5dl
	O8XESq8g82cY+LhnIcwTY1QvPxi+cOZgcspwFHPsmplE5UQCqgaq+1b7zPWQejaO0JqLjV1qCGDYg
	qnqWTHG8UjYbNIXr7LS+bw0XFpLNJsySoP7iLhQa058FGFLxnMltJL8NpffiCWDjhtjcm2y4wZ4x6
	u2slSCMwOdPGXYOAU16XSn4sbzC3WT60Mda59xX1ljvY1XZye7ZuBSSvOj9BQmttwoB7sePPCGfcu
	TycmZYug==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rrRh0-003pIt-0n;
	Tue, 02 Apr 2024 00:07:58 +0000
Date: Tue, 2 Apr 2024 01:07:58 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Palmer Dabbelt <palmer@rivosinc.com>, Arnd Bergmann <arnd@arndb.de>,
	Marco Elver <elver@google.com>
Subject: Re: [PATCH RFC cmpxchg 2/8] sparc: Emulate one-byte and two-byte
 cmpxchg
Message-ID: <20240402000758.GC538574@ZenIV>
References: <31c82dcc-e203-48a9-aadd-f2fcd57d94c1@paulmck-laptop>
 <20240401213950.3910531-2-paulmck@kernel.org>
 <20240401223803.GZ538574@ZenIV>
 <114dc62e-e0fb-41c8-bf9c-a9fda8b19eb6@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <114dc62e-e0fb-41c8-bf9c-a9fda8b19eb6@paulmck-laptop>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Apr 01, 2024 at 04:58:03PM -0700, Paul E. McKenney wrote:
> > #define CMPXCHG(T)	\
> > 	T __cmpxchg_##T(volatile ##T *ptr, ##T old, ##T new)	\
				 ^^^

*blink*

I understand what search-and-replace has produced that, but not
how I hadn't noticed the results...  Sorry ;-/

> > 	{							\
> > 		unsigned long flags;				\
> > 		##T prev;					\
> > 								\
> > 		spin_lock_irqsave(ATOMIC_HASH(ptr), flags);	\
> > 		if ((prev = *ptr) == old)			\
> > 			*ptr = new;				\
> > 		spin_unlock_irqrestore(ATOMIC_HASH(ptr), flags);\
> > 		return prev;					\
> > 	}
> > 
> > CMPXCHG(u8)
> > CMPXCHG(u16)
> > CMPXCHG(u32)
> > CMPXCHG(u64)
> > 
> > in arch/sparc/lib/atomic32.c, replacing equivalent __cmpxchg_u{32,64}()
> > definitions already there and use of those in that switch in __cmpxchg()
> > definition...
> 
> Fair enough, and ATOMIC_HASH() is set up to permit mixed-size atomic
> accesses courtesy of ignoring the bottom bits, though ignoring more
> of them than absolutely necessary.  Maybe 32-bit sparc has 32-byte
> cache lines?

It does, IIRC.

> Would you like to do that patch?  If so, I would be happy to drop mine
> in favor of yours.  If not, could I please have your Signed-off-by so
> I can do the Co-developed-by dance?

Will do once I dig my way from under the pile of mail (sick for a week
and subscribed to l-k, among other lists)...

