Return-Path: <linux-kernel+bounces-42830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9CAE840764
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 14:50:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 347A328C27C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 13:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C10DE657B3;
	Mon, 29 Jan 2024 13:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jl+xkFuQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB33A657AC
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 13:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706536203; cv=none; b=PJ3VZ+LbwsTh709Zl8q3/CvKhGciZvuFe5FXT108zf/ixAW7ye7DHR3di+40rPKIFuQRQUJmtFMP3vdB4GeaJu0JVVnCxXpEWxKfJaeEACqTIn7m80p7k5NFCRDlzNQw/OngIfkg2uprcJvzxy11PzhyETP+leEaiyH9UtPN0xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706536203; c=relaxed/simple;
	bh=bsCADWdmeBcWI0RCp80+bgjOLuc1WKcJDyuWrtMXh84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CsYyBYcD9dUapOETRNIYBILLDIaDnF8N2etkBs9A7a0rI6Aa1JtP9koyVbbaSJDgahJxxeNqfw0sMdY033n1XwOKAoJ+KH3bYI5lzgGWj/PbZ/Ra0DAxt3ziPTyjdKiAJ+V7ue4kjXP/bwYR+GH/9DsPtKI800HNK7KCkZA8Xbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jl+xkFuQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CDE9C433F1;
	Mon, 29 Jan 2024 13:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706536202;
	bh=bsCADWdmeBcWI0RCp80+bgjOLuc1WKcJDyuWrtMXh84=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=Jl+xkFuQsv3QByFkIVG6axilxgkmOf0H4mNuEHLKOEJvW7UPvy+PFWHoOgNMJZIfk
	 Bm3/4xpEs81tWz7njg5m24LAnfIGStCYdZiDvKSTe6rJmgFEcraYhfwYuqjyndjU/K
	 CAwUlSxZW2LRLHN504GJgOXjyahF8S0R040j+zbtUNSC8EWiXQ4fHxLxAEBFf+3DpE
	 3ykhHgrsoGND5fn1yCIrTCEOk59OmORg8XN8hWVC8SXppVewTlG7o7JxzGlz9qiQ24
	 szmR0bSw7ENfoN2+oQG/0IHpuLOArnvAELOtdSDzUMTfsiXihz2DX8qkD5SbGkuFUW
	 fugbLQsFVSzuA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id E3D86CE0C37; Mon, 29 Jan 2024 05:50:01 -0800 (PST)
Date: Mon, 29 Jan 2024 05:50:01 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>,
	linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	John Stultz <jstultz@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Eric Dumazet <edumazet@google.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Arjan van de Ven <arjan@infradead.org>,
	Rik van Riel <riel@surriel.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sebastian Siewior <bigeasy@linutronix.de>,
	Giovanni Gherdovich <ggherdovich@suse.cz>,
	Lukasz Luba <lukasz.luba@arm.com>,
	"Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Srinivas Pandruvada <srinivas.pandruvada@intel.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [PATCH v10 18/20] timers: Implement the hierarchical pull model
Message-ID: <b4a7a0ce-258b-4469-876d-bd57a278d527@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240115143743.27827-1-anna-maria@linutronix.de>
 <20240115143743.27827-19-anna-maria@linutronix.de>
 <ZbWJtkAj9z0S9xsH@pavilion.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZbWJtkAj9z0S9xsH@pavilion.home>

On Sat, Jan 27, 2024 at 11:54:46PM +0100, Frederic Weisbecker wrote:
> Le Mon, Jan 15, 2024 at 03:37:41PM +0100, Anna-Maria Behnsen a écrit :
> > +static bool tmigr_inactive_up(struct tmigr_group *group,
> > +			      struct tmigr_group *child,
> > +			      void *ptr)
> > +{
> > +	union tmigr_state curstate, newstate, childstate;
> > +	struct tmigr_walk *data = ptr;
> > +	bool walk_done;
> > +	u8 childmask;
> > +
> > +	childmask = data->childmask;
> > +	curstate.state = atomic_read(&group->migr_state);
> > +	childstate.state = 0;
> > +
> > +	do {
> 
> So I got the confirmation from Boqun (+Cc) and Paul that a failing cmpxchg
> may not order the load of the old value against subsequent loads. And
> that may apply to atomic_try_cmpxchg() as well.

Plus we checked with Mark Rutland, who agreed and who went further kindly
submitted a patch to clarify the documentation:

https://lore.kernel.org/lkml/20240129122250.1086874-1-mark.rutland@arm.com/

Here is an LKMM litmus test demonstrating that failing cmpxchg() does not
provide ordering:

------------------------------------------------------------------------

C cmpxchg-fail-order

{}

P0(int *x, int *y, int *z)
{
      int r0;
      int r1;

      WRITE_ONCE(*x, 1);
      r1 = cmpxchg(z, 1, 0);
      r0 = READ_ONCE(*y);
}

P1(int *x, int *y, int *z)
{
      int r0;
      int r1;
 
      WRITE_ONCE(*y, 1);
      r1 = cmpxchg(z, 1, 0);
      r0 = READ_ONCE(*x);
}

locations[0:r1;1:r1]
exists (0:r0=0 /\ 1:r0=0)

------------------------------------------------------------------------

Yes, this is cmpxchg() rather than atomic_cmpxchg(), but both have the
same ordering properties.

Here P0() is one thread and P1() the other.  Their parameters are the
global shared variables.  The "{}" preceding P0() is where initialization
could be placed, but this test is fine with the default initialization
of zero, for example, given that both instances of cmpxchg() specify
the value 1 as the old value (and thus both instances will fail).

The "locations" clause says to print the final values of P0()'s and P1()'s
local variables r1, where the leading "0:" selects P0() and the leading
"1:" selects P1().  And yes, the first process must be named "P0" and
subsequent processes' names must consist of "P" followed by a consecutive
number, so P0(), P1(), P2(), P3(), ...

The "exists" clause gives an expression to be tested "at the end of time".
Again, the "0:" and "1:" select P0() and P1(), respectively.  The "="
tests for equality.  The "/\" is boolean AND.  Boolean OR would be
"\/" and boolean NOT "~".  Parentheses may be used.  A variable name on
the left-hand side of a relational operator denotes the value of that
variable, but on the right-hand side its address.

The value of any variable mentioned in the "exists" clause is printed as
part of the "States" list shown below.

Running this with the herd7 tool does the moral equivalent of a full
state-space search, and gets the following:

------------------------------------------------------------------------

$ herd7 -conf linux-kernel.cfg /tmp/cmpxchg.litmus
Test cmpxchg-fail-order Allowed
States 4
0:r0=0; 0:r1=0; 1:r0=0; 1:r1=0;
0:r0=0; 0:r1=0; 1:r0=1; 1:r1=0;
0:r0=1; 0:r1=0; 1:r0=0; 1:r1=0;
0:r0=1; 0:r1=0; 1:r0=1; 1:r1=0;
Ok
Witnesses
Positive: 1 Negative: 3
Condition exists (0:r0=0 /\ 1:r0=0)
Observation cmpxchg-fail-order Sometimes 1 3
Time cmpxchg-fail-order 0.00
Hash=564afea251867c6127350213c7eb388d

------------------------------------------------------------------------

Here, there are four possible combinations of final values for the two
r0 local variables, and all of them can happen, including the combination
where both are zero, which is the combination called out by the "exists"
clause.  The "Sometimes" says that the expression in the "exists" clause
is sometimes true (other options being "Always" and "Never").

The fact that both instances of r0 can be zero shows that failing
cmpxchg() really does not provide ordering.  And again, ordering for
atomic_try_cmpxchg() is the same as that for cmpxchg().

						Thanx, Paul

> Therefore you not only need to turn group->migr_state read into
> an atomic_read_acquire() but you also need to do this on each iteration
> of this loop. For example you can move the read_acquire right here.
> 
> Thanks.
> 
> > +		if (child)
> > +			childstate.state = atomic_read(&child->migr_state);
> > +
> > +		newstate = curstate;
> > +		walk_done = true;
> > +
> > +		/* Reset active bit when the child is no longer active */
> > +		if (!childstate.active)
> > +			newstate.active &= ~childmask;
> > +
> > +		if (newstate.migrator == childmask) {
> > +			/*
> > +			 * Find a new migrator for the group, because the child
> > +			 * group is idle!
> > +			 */
> > +			if (!childstate.active) {
> > +				unsigned long new_migr_bit, active = newstate.active;
> > +
> > +				new_migr_bit = find_first_bit(&active, BIT_CNT);
> > +
> > +				if (new_migr_bit != BIT_CNT) {
> > +					newstate.migrator = BIT(new_migr_bit);
> > +				} else {
> > +					newstate.migrator = TMIGR_NONE;
> > +
> > +					/* Changes need to be propagated */
> > +					walk_done = false;
> > +				}
> > +			}
> > +		}
> > +
> > +		newstate.seq++;
> > +
> > +		WARN_ON_ONCE((newstate.migrator != TMIGR_NONE) && !(newstate.active));
> > +
> > +	} while (!atomic_try_cmpxchg(&group->migr_state, &curstate.state, newstate.state));

