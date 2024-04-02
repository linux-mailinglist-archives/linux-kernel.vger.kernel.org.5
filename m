Return-Path: <linux-kernel+bounces-127365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D0C6894A59
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 06:18:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2076B244CE
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 04:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7814517730;
	Tue,  2 Apr 2024 04:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rBeVOwbD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF14F9DF
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 04:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712031522; cv=none; b=qiClQ7buQs3yO6fBR8/K5MTuRNmQKQG8mdQqa4ce3qX8lOlOzokzhy6XhPuuyhq8FwGu3blfXiiFKltiyU+pa/uoYt702DduHOKIaE3ZlRQws9zCT+KK766d+DsQKCZudPIwc3g3vzIasL4fzzLW0llNH4pDjFVdwKuqME/x+OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712031522; c=relaxed/simple;
	bh=iHHfKFn/5YWAKVFaluAiBITG9Vbff9SyBx/lFMADkjc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EFW2zbbddXoBq04qO9DSbVkXgXVCZiOqR/p+dRLilfF4s4D131oBsm5dYVMz0aDKFw5JZ4rcPHpT9MRxks0qRYsJoCl9f5Fi7lO05SlBVfZfpHxDwX0Il5l685inOgVsVfrLtbvMzWqQqH9nQsv0aMItf8lLe1FeJR1jmtrorC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rBeVOwbD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C5ABC433F1;
	Tue,  2 Apr 2024 04:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712031522;
	bh=iHHfKFn/5YWAKVFaluAiBITG9Vbff9SyBx/lFMADkjc=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=rBeVOwbDfvG6XgxgzC4ASd9Zjgii20pcrbltnb453ZEtg777ILHY15EZ3GYCz3oA2
	 kFQsJUAODAxbuRXG958u9SrqqKnGET8QpNut9E/7wFD9qOcR4TdtNrSt94sSqnkI9f
	 L2WkrDxSAKsBTqeEUgtdzNk9I4gKYLSIF2jgxYJYT5ManSDVE3QU8NG1idxjXoWSAS
	 jqCwlvUDCPXV/Z7CvVDh8zxwCKU5FRzQn7nk4bJBtbldj/jaKdsEaquznGurdwfGF3
	 NwC6F4I6e7kv8Sco17GbBwR8Kfh+cInZBHryx63Duyrwh1c+kZDBX5aoaOrhDGhGK7
	 VdBYuQsL6Cuew==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 0767DCE074C; Mon,  1 Apr 2024 21:18:42 -0700 (PDT)
Date: Mon, 1 Apr 2024 21:18:42 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Palmer Dabbelt <palmer@rivosinc.com>, Arnd Bergmann <arnd@arndb.de>,
	Marco Elver <elver@google.com>
Subject: Re: [PATCH RFC cmpxchg 2/8] sparc: Emulate one-byte and two-byte
 cmpxchg
Message-ID: <c6581992-03c6-44e4-8d98-0a73a5ea948b@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <31c82dcc-e203-48a9-aadd-f2fcd57d94c1@paulmck-laptop>
 <20240401213950.3910531-2-paulmck@kernel.org>
 <20240401223803.GZ538574@ZenIV>
 <114dc62e-e0fb-41c8-bf9c-a9fda8b19eb6@paulmck-laptop>
 <20240402000758.GC538574@ZenIV>
 <20240402033753.GE538574@ZenIV>
 <20240402041138.GF538574@ZenIV>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240402041138.GF538574@ZenIV>

On Tue, Apr 02, 2024 at 05:11:38AM +0100, Al Viro wrote:
> On Tue, Apr 02, 2024 at 04:37:53AM +0100, Al Viro wrote:
> > On Tue, Apr 02, 2024 at 01:07:58AM +0100, Al Viro wrote:
> > 
> > > It does, IIRC.
> > > 
> > > > Would you like to do that patch?  If so, I would be happy to drop mine
> > > > in favor of yours.  If not, could I please have your Signed-off-by so
> > > > I can do the Co-developed-by dance?
> > > 
> > > Will do once I dig my way from under the pile of mail (sick for a week
> > > and subscribed to l-k, among other lists)...
> > 
> > FWIW, parisc is in the same situation - atomics-by-cached-spinlocks.
> > 've a candidate branch, will post if it survives build...
> 
> Seems to survive.  See
> git://git.kernel.org:/pub/scm/linux/kernel/git/viro/vfs.git misc.cmpxchg
> 
> Completely untested; builds on several configs, but that's it.
> Al Viro (8):
>       sparc32: make __cmpxchg_u32() return u32
>       sparc32: make the first argument of __cmpxchg_u64() volatile u64 *
>       sparc32: unify __cmpxchg_u{32,64}
>       sparc32: add __cmpxchg_u{8,16}() and teach __cmpxchg() to handle those sizes
>       parisc: __cmpxchg_u32(): lift conversion into the callers
>       parisc: unify implementations of __cmpxchg_u{8,32,64}
>       parisc: add missing export of __cmpxchg_u8()
>       parisc: add u16 support to cmpxchg()
> 
>  arch/parisc/include/asm/cmpxchg.h   | 16 ++++++------
>  arch/parisc/kernel/parisc_ksyms.c   |  2 ++
>  arch/parisc/lib/bitops.c            | 52 ++++++++++++-------------------------
>  arch/sparc/include/asm/cmpxchg_32.h | 11 +++++---
>  arch/sparc/lib/atomic32.c           | 45 ++++++++++++++------------------
>  5 files changed, 55 insertions(+), 71 deletions(-)
> 
> Individual patches in followups.

Very good, thank you!  I will take yours in place of mine on my next
rebase.

							Thanx, Paul

