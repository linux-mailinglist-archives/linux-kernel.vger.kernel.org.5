Return-Path: <linux-kernel+bounces-133704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BBE5389A78F
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 01:18:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C4E5B22C2A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 23:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F75036AF8;
	Fri,  5 Apr 2024 23:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UvR/mnCz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2C236121
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 23:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712359110; cv=none; b=c5R8em80cBOQBoyhCw6QHswJL518BBpvlRGh6txXwWXYqWdn1CgpFuHpqCcBb5ZQChFjzJnCgx4hK1dHzJ6mF8nFSxYg3B0pDauqZAYjmla/OhaQgMoujScIKfIVwfaExaAYM3y41Ny1KFxykeCoaW+IAjd7O16XFgG4IeQV3gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712359110; c=relaxed/simple;
	bh=Idn3J2kbXhzTnx8TU25Kz+NfgIvOh0Me4gtzQGiH3/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i9YEvC6Q+WMk/Wh2FNk4nk0d60wKjKIw2EFsw85UksLk2m90lyiAeCK7/dgSYHpjdgRQ5xjFsXb/A0hbB+aghRhhVXodZcsk/mmA+b5cBXjWmon/bF+6U4CK4slXkXYzRmtf13NwzQhSGH4QDAcSdRtjudlDcH1SJM5OqKmAPdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UvR/mnCz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02702C433C7;
	Fri,  5 Apr 2024 23:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712359110;
	bh=Idn3J2kbXhzTnx8TU25Kz+NfgIvOh0Me4gtzQGiH3/M=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=UvR/mnCzGXb8H3t46KE8KYjjSQ7AQO7lOsY2O4J7B5yYHGPCNuLtYm4A/5A7GPtj0
	 BafL9kUCY5ELPzDUc85sqcdLdrwZLFFE744GPJnq96oqxc4b/2ZlOGPVc2stDC4Ljy
	 Be6G127wXpCp3Z0E+KgIhsp53+3rc0xqyEpLC2PVJkABuPdUzVY7H23bGIsZ7Iwkbt
	 7ZafvDb46/a0zhdMB2A+si2mTpoJLFUZfTdcz5v7UC9GFFUcmxaKGB2cZzlqyfk6sF
	 kCCs2skX1jV5z6ipTwiDEJC0WTIeetDKZLiDGSmAXSRFXs5GvfwZ97ot5lZMDl0Iif
	 iIQA+3Wjap0JQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 7C834CE11CE; Fri,  5 Apr 2024 16:18:29 -0700 (PDT)
Date: Fri, 5 Apr 2024 16:18:29 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: Re: Finding open-coded workarounds for 1/2-byte cmpxchg()?
Message-ID: <0e489247-6350-4485-9976-320b457ae748@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <f57bcb57-45a4-4dfb-8758-8f7302223ea9@paulmck-laptop>
 <alpine.DEB.2.22.394.2404060057110.3446@hadrien>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2404060057110.3446@hadrien>

On Sat, Apr 06, 2024 at 01:00:35AM +0200, Julia Lawall wrote:
> 
> 
> On Thu, 4 Apr 2024, Paul E. McKenney wrote:
> 
> > Hello, Julia!
> >
> > I hope that things are going well for you and yours.
> >
> > TL;DR: Would you or one of your students be interested in looking for
> > some interesting code patterns involving cmpxchg?  If such patterns exist,
> > we would either need to provide fixes or to drop support for old systems.
> >
> > If this would be of interest, please read on!
> >
> > Arnd (CCed) and I are looking for open-coded emulations for one-byte
> > and two-byte cmpxchg().  Such emulations might be attempting to work
> > around the fact that not all architectures support those sizes, being
> > as they are only required to support four-byte cmpxchg() and, if they
> > are 64-bit architectures, eight-byte cmpxchg().
> >
> > There is a one-byte emulation in RCU (kernel/rcu/tasks.h), which looks
> > like this:
> >
> > ------------------------------------------------------------------------
> >
> > u8 rcu_trc_cmpxchg_need_qs(struct task_struct *t, u8 old, u8 new)
> > {
> > 	union rcu_special ret;
> > 	union rcu_special trs_old = READ_ONCE(t->trc_reader_special);
> > 	union rcu_special trs_new = trs_old;
> >
> > 	if (trs_old.b.need_qs != old)
> > 		return trs_old.b.need_qs;
> > 	trs_new.b.need_qs = new;
> > 	ret.s = cmpxchg(&t->trc_reader_special.s, trs_old.s, trs_new.s);
> > 	return ret.b.need_qs;
> > }
> >
> > ------------------------------------------------------------------------
> >
> > An additional issue is posed by these, also in kernel/rcu/tasks.h:
> >
> > ------------------------------------------------------------------------
> >
> > 	if (trs.b.need_qs == (TRC_NEED_QS_CHECKED | TRC_NEED_QS)) {
> >
> > 	return smp_load_acquire(&t->trc_reader_special.b.need_qs);
> >
> > 	smp_store_release(&t->trc_reader_special.b.need_qs, v);
> >
> > ------------------------------------------------------------------------
> >
> > The additional issue is that these statements assume that each CPU
> > architecture has single-byte load and store instructions, which some of
> > the older Alpha systems do not.  Fortunately for me, Arnd was already
> > thinking in terms of removing support for these systems.
> >
> > But there are additional systems that do not support 16-bit loads and
> > stores.  So if there is a 16-bit counterpart to rcu_trc_cmpxchg_need_qs()
> > on a quantity that is also subject to 16-bit loads or stores, either
> > that function needs adjustment or a few more ancient systems need to
> > lose their Linux-kernel support.
> >
> > Again, is looking for this sort of thing something that you or one of
> > your students would be interested in?
> 
> Hello,
> 
> I tried, but without much success.  The following looks a little bit
> promising, eg the use of the variable name "want", but it's not clear that
> the rest of the context fits the pattern.

Thank you for digging into this!!!

> diff -u -p /home/julia/linux/net/sunrpc/xprtsock.c
> /tmp/nothing/net/sunrpc/xprtsock.c
> --- /home/julia/linux/net/sunrpc/xprtsock.c
> +++ /tmp/nothing/net/sunrpc/xprtsock.c
> @@ -690,12 +690,9 @@ xs_read_stream(struct sock_xprt *transpo
>  		if (ret <= 0)
>  			goto out_err;
>  		transport->recv.offset = ret;
> -		if (transport->recv.offset != want)
> -			return transport->recv.offset;

Agreed, though you are quite right that ->recv.copied and ->recv.offset
are different lengths.  But yes, as you sugggest below, there must be
a cmpxchg() of some type (cmpxchg(), cmpxchg_acquire(), ...) in the mix
somewhere.  Also, the cmpxchg() must be applied to a pointer to either
a 32-bit or a 64-bit quantity, but the change must be 16 bits (or 8 bits).

> The semantic patch in question was:
> 
> @r@
> expression olde;
> idexpression old;
> @@
> 
> if (olde != old) { ... return olde; }
> 
> @@
> expression newe != r.olde;
> idexpression nw;
> expression r.olde;
> idexpression r.old;
> @@
> 
> *if (olde != old) { ... return olde; }
> ...
> *newe = nw;
> ...
> *return newe;
> 
> The semantic patch doesn't include the cmpxchg.  I wasn't sure if that
> would always be present, or in what form.

It would be, but I am having trouble characterizing exactly what the
pattern would look like beyond "emulating a 16-bit cmpxchg() using either
a 32-bit cmpxchg() or a 64-bit cmpxchg()".  :-(

Thank you again, and something to think more about.

							Thanx, Paul

