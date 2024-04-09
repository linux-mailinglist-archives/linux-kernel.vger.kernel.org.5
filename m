Return-Path: <linux-kernel+bounces-137527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0A4189E368
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 21:27:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 005291C221C6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 19:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9E66157A7E;
	Tue,  9 Apr 2024 19:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L/SGLq92"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B5D157A51
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 19:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712690739; cv=none; b=g/NhhdIuFZkbPIK0Q3pNwatjz/47Z5nywwNjP9ZHu9h6fmef2tVtTU7hFvTphTTmnoG9AahyLqfCXvFaZ/L85eoZaqiPPu2kK3f3MF0vlaPtL9eXOcyt3NfbPNFJaCd7W5ydmyR7Yu7CZ3+hSe49JfGzl+TMPJR3J3iwgq5mxRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712690739; c=relaxed/simple;
	bh=sZns4wWiCwVq2UKw3DllXS1aY/CmVoZGF+v/FMeR3zg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VPAPRKkJ53UWSiKCOKeHNX2sdYs130MFKud+WpFRJ/fH0R9vohwNNHGxZNpVJ1cM+brfltOnBVjzKaqS2EX7jjqSud01iSgnSvvs3kHmRhziB9rdNo2/BZ1tYgJJVPzgUZwsEdRIXspv8tBMyXsc9Ml1lQ3On/WKnFO5DRiLhfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L/SGLq92; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7621FC433C7;
	Tue,  9 Apr 2024 19:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712690738;
	bh=sZns4wWiCwVq2UKw3DllXS1aY/CmVoZGF+v/FMeR3zg=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=L/SGLq92FO/Y3Ifb/DIrf0ewcs/SvPtFMxGhrGdIItA5B7TNlzsLA5NhLFZHE4Sf5
	 ax+o5r283Ugp/c4OxkE3Oyv7Fbgui/3EePahWdUxJC6/1PEWJUoup3vBFs5qdjjLW0
	 u3Srk84StwXDJT5/HK6BK49ESE5tlA8aXfyiQZ/Bx6uNQ4+mft0Q05VT7M5StCpoug
	 lcoqa1k9tqFxqgtwlz+DOdj0HngoveTKYtR/LeZvrJG2g54QN9ndsdhkf96YkfJ5i/
	 dnhmEV4K+LmdqGVOK/HBmFLPJy8Hb7HhiUxOiQmZKv4+rfpwg5ZIV+6E/9QOi+H9iT
	 HZ4MU0o7Jr/eQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 11B81CE2D22; Tue,  9 Apr 2024 12:25:38 -0700 (PDT)
Date: Tue, 9 Apr 2024 12:25:38 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: Re: Finding open-coded workarounds for 1/2-byte cmpxchg()?
Message-ID: <d0c0e4c6-0791-448b-90ec-0bb4edcb8518@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <f57bcb57-45a4-4dfb-8758-8f7302223ea9@paulmck-laptop>
 <alpine.DEB.2.22.394.2404060057110.3446@hadrien>
 <0e489247-6350-4485-9976-320b457ae748@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e489247-6350-4485-9976-320b457ae748@paulmck-laptop>

On Fri, Apr 05, 2024 at 04:18:29PM -0700, Paul E. McKenney wrote:
> On Sat, Apr 06, 2024 at 01:00:35AM +0200, Julia Lawall wrote:
> > 
> > 
> > On Thu, 4 Apr 2024, Paul E. McKenney wrote:
> > 
> > > Hello, Julia!
> > >
> > > I hope that things are going well for you and yours.
> > >
> > > TL;DR: Would you or one of your students be interested in looking for
> > > some interesting code patterns involving cmpxchg?  If such patterns exist,
> > > we would either need to provide fixes or to drop support for old systems.
> > >
> > > If this would be of interest, please read on!
> > >
> > > Arnd (CCed) and I are looking for open-coded emulations for one-byte
> > > and two-byte cmpxchg().  Such emulations might be attempting to work
> > > around the fact that not all architectures support those sizes, being
> > > as they are only required to support four-byte cmpxchg() and, if they
> > > are 64-bit architectures, eight-byte cmpxchg().
> > >
> > > There is a one-byte emulation in RCU (kernel/rcu/tasks.h), which looks
> > > like this:
> > >
> > > ------------------------------------------------------------------------
> > >
> > > u8 rcu_trc_cmpxchg_need_qs(struct task_struct *t, u8 old, u8 new)
> > > {
> > > 	union rcu_special ret;
> > > 	union rcu_special trs_old = READ_ONCE(t->trc_reader_special);
> > > 	union rcu_special trs_new = trs_old;
> > >
> > > 	if (trs_old.b.need_qs != old)
> > > 		return trs_old.b.need_qs;
> > > 	trs_new.b.need_qs = new;
> > > 	ret.s = cmpxchg(&t->trc_reader_special.s, trs_old.s, trs_new.s);
> > > 	return ret.b.need_qs;
> > > }
> > >
> > > ------------------------------------------------------------------------
> > >
> > > An additional issue is posed by these, also in kernel/rcu/tasks.h:
> > >
> > > ------------------------------------------------------------------------
> > >
> > > 	if (trs.b.need_qs == (TRC_NEED_QS_CHECKED | TRC_NEED_QS)) {
> > >
> > > 	return smp_load_acquire(&t->trc_reader_special.b.need_qs);
> > >
> > > 	smp_store_release(&t->trc_reader_special.b.need_qs, v);
> > >
> > > ------------------------------------------------------------------------
> > >
> > > The additional issue is that these statements assume that each CPU
> > > architecture has single-byte load and store instructions, which some of
> > > the older Alpha systems do not.  Fortunately for me, Arnd was already
> > > thinking in terms of removing support for these systems.
> > >
> > > But there are additional systems that do not support 16-bit loads and
> > > stores.  So if there is a 16-bit counterpart to rcu_trc_cmpxchg_need_qs()
> > > on a quantity that is also subject to 16-bit loads or stores, either
> > > that function needs adjustment or a few more ancient systems need to
> > > lose their Linux-kernel support.
> > >
> > > Again, is looking for this sort of thing something that you or one of
> > > your students would be interested in?
> > 
> > Hello,
> > 
> > I tried, but without much success.  The following looks a little bit
> > promising, eg the use of the variable name "want", but it's not clear that
> > the rest of the context fits the pattern.
> 
> Thank you for digging into this!!!
> 
> > diff -u -p /home/julia/linux/net/sunrpc/xprtsock.c
> > /tmp/nothing/net/sunrpc/xprtsock.c
> > --- /home/julia/linux/net/sunrpc/xprtsock.c
> > +++ /tmp/nothing/net/sunrpc/xprtsock.c
> > @@ -690,12 +690,9 @@ xs_read_stream(struct sock_xprt *transpo
> >  		if (ret <= 0)
> >  			goto out_err;
> >  		transport->recv.offset = ret;
> > -		if (transport->recv.offset != want)
> > -			return transport->recv.offset;
> 
> Agreed, though you are quite right that ->recv.copied and ->recv.offset
> are different lengths.  But yes, as you sugggest below, there must be
> a cmpxchg() of some type (cmpxchg(), cmpxchg_acquire(), ...) in the mix
> somewhere.  Also, the cmpxchg() must be applied to a pointer to either
> a 32-bit or a 64-bit quantity, but the change must be 16 bits (or 8 bits).
> 
> > The semantic patch in question was:
> > 
> > @r@
> > expression olde;
> > idexpression old;
> > @@
> > 
> > if (olde != old) { ... return olde; }
> > 
> > @@
> > expression newe != r.olde;
> > idexpression nw;
> > expression r.olde;
> > idexpression r.old;
> > @@
> > 
> > *if (olde != old) { ... return olde; }
> > ...
> > *newe = nw;
> > ...
> > *return newe;
> > 
> > The semantic patch doesn't include the cmpxchg.  I wasn't sure if that
> > would always be present, or in what form.
> 
> It would be, but I am having trouble characterizing exactly what the
> pattern would look like beyond "emulating a 16-bit cmpxchg() using either
> a 32-bit cmpxchg() or a 64-bit cmpxchg()".  :-(
> 
> Thank you again, and something to think more about.

I took the crude approach of looking at all of the cmpxchg*() invocations,
discarding those that were clearly not an issue.  Here are the close calls
that I found:

o	drivers/misc/genwqe/card_ddcb.c enqueue_ddcb() does work against
	a union that has 32-bit, 16-bit, and eight-bit members, but as
	far as I can see the ->icrc_16 member is not used.  But this
	might be an accident waiting to happen.  Or maybe this driver
	is used only by architectures with a full set of cmpxchg sizes.

	The 8-bit ->hsi and ->shi fields are used for debug output, which
	should be harmless.

	Ditto __genwqe_purge_ddcb() that same file.

o	drivers/platform/surface/aggregator/controller.c ssh_seq_next()
	does an 8-bit cmpxchg().

o	drivers/platform/surface/aggregator/controller.c ssh_rqid_next()
	does a 16-bit cmpxchg().

o	kernel/locking/qspinlock_paravirt.h pv_wait_node() does
	an 8-bit cmpxchg().  As does pv_kick_node() in that same
	file.  And __pv_queued_spin_unlock().  And, as Arnd noted,
	trylock_clear_pending() and pv_hybrid_queued_unfair_trylock()
	in that same file do 16-bit cmpxchg_acquire().

o	net/rxrpc/io_thread.c rxrpc_input_packet_on_conn() is strange
	in that it supplies 16-bit old and new fields to a cmpxchg()
	of a 32-bit quantity, but it is quite possible that this would
	be a 16-bit quantity if permitted in core code.  This is in an
	rxrpc_connection structure.

There are no doubt some false negatives omitted from this list, but
there are a few places that use or would like to use 8-bit and 16-bit
cmpxchg*().

							Thanx, Paul

