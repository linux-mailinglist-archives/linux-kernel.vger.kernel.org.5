Return-Path: <linux-kernel+bounces-87734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C841F86D851
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 01:28:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69C51B22412
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 00:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D063637;
	Fri,  1 Mar 2024 00:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vO9ua2+5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574FB368
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 00:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709252901; cv=none; b=kw4u+aSy+EJQqp0i+enp6/2sIuiXoAxPkOdm8A4IPMkQqHdMgwID87ultcm8SaSjiZyPLYxlsL5zhxcXnJ4VlWXdcTW/Gc8L4CsKUVRl9QrXeUpH5dgdz9A+tI2Ujs7ICTrPs5Dut2LI3CH14ET8xqiG3m8oFi0bzrVdxV7+jys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709252901; c=relaxed/simple;
	bh=dVqPsWNUmiWnQmiOcSt5UZwFL2hedrAKbpRRWjmdhbU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jBvLT4XLeEBNAjXc63Dz8N0Z26E1lOotWFz+Vb8xB2Hscj3lk4pR5VNQqIykGBfFGMCfU4SiZHCguSsiZQdSQzB6Xe7PYVeiTshxMEAQKLrGsznnT1eAOjzy0e1utu+EaPTYtdxDM+a75Jlpu5ZefiRilzp1g7yTxoDWlgBBwOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vO9ua2+5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0264C433F1;
	Fri,  1 Mar 2024 00:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709252900;
	bh=dVqPsWNUmiWnQmiOcSt5UZwFL2hedrAKbpRRWjmdhbU=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=vO9ua2+5EtkcfmQJPeAAwbItqAA6JCWIBPQuDFlhUdmHG2VlG05cq1iJC1vTxYI9i
	 wnQD5iG7VNzZR1XR50IMZej/HgUSBZVTU4VZajWCqJ9GT1WmUSswEABIIKkpEKVIbv
	 Hul/8/imWcyt03uRyGYlDab/M6U4pOD4iZnjqQV0XdctkLvycm75iogmEHN8myHwJr
	 BHOwBxpISwo7xGgWW11BimoiKlnn2DuENzdVvsHbAFaVvSOTCJI3QjU+njNG99Tfs5
	 IErBkMZUhbLeSeKOBUZdKg8ICBT6kpAiVpE82h2Wvnor6pZA2LbY3RahBQgr+crrz0
	 16SO8szLf/VmA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 53257CE0B6C; Thu, 29 Feb 2024 16:28:20 -0800 (PST)
Date: Thu, 29 Feb 2024 16:28:20 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: Juri Lelli <juri.lelli@redhat.com>, linux-kernel@vger.kernel.org,
	tglx@linutronix.de, peterz@infradead.org,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	luto@kernel.org, bp@alien8.de, dave.hansen@linux.intel.com,
	hpa@zytor.com, mingo@redhat.com, vincent.guittot@linaro.org,
	willy@infradead.org, mgorman@suse.de, jpoimboe@kernel.org,
	mark.rutland@arm.com, jgross@suse.com, andrew.cooper3@citrix.com,
	bristot@kernel.org, mathieu.desnoyers@efficios.com,
	geert@linux-m68k.org, glaubitz@physik.fu-berlin.de,
	anton.ivanov@cambridgegreys.com, mattst88@gmail.com,
	krypton@ulrich-teichert.org, rostedt@goodmis.org,
	David.Laight@aculab.com, richard@nod.at, mjguzik@gmail.com,
	jon.grimm@amd.com, bharata@amd.com, raghavendra.kt@amd.com,
	boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Subject: Re: [PATCH 23/30] sched/fair: handle tick expiry under lazy
 preemption
Message-ID: <fee93055-52e7-422e-96d3-0e7e373a40eb@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240213055554.1802415-1-ankur.a.arora@oracle.com>
 <20240213055554.1802415-24-ankur.a.arora@oracle.com>
 <Zd85iRyY6-zlo2wl@localhost.localdomain>
 <871q8v7otl.fsf@oracle.com>
 <ZeBPXNFkipU9yytp@localhost.localdomain>
 <87a5ni6d31.fsf@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a5ni6d31.fsf@oracle.com>

On Thu, Feb 29, 2024 at 03:54:42PM -0800, Ankur Arora wrote:
> 
> Juri Lelli <juri.lelli@redhat.com> writes:
> 
> > On 28/02/24 22:43, Ankur Arora wrote:
> >> Juri Lelli <juri.lelli@redhat.com> writes:
> >
> > ..
> >
> >> > For deadline we call resched_curr_tick() from the throttle part of
> >> > update_curr_dl_se() if the dl_se happens to not be the leftmost anymore,
> >> > so in this case I believe we really want to reschedule straight away and
> >> > not wait for the second time around (otherwise we might be breaking the
> >> > new leftmost tasks guarantees)?
> >>
> >> Yes, agreed, this looks like it breaks the deadline invariant for both
> >> preempt=none and preempt=voluntary.
> >>
> >> For RT, update_curr_rt() seems to have a similar problem if the task
> >> doesn't have RUNTIME_INF.
> >>
> >> Relatedly, do you think there's a similar problem when switching to
> >> a task with a higher scheduling class?
> >> (Related to code is in patch 25, 26.)
> >>
> >> For preempt=voluntary, wakeup_preempt() will do the right thing, but
> >
> > Right.
> >
> >> for preempt=none, we only reschedule lazily so the target might
> >> continue to run until the end of the tick.
> >
> > Hummm, not sure honestly, but I seem to understand that with
> > preempt=none we want to be super conservative wrt preemptions, so maybe
> > current behavior (1 tick of laziness) is OK? Otherwise what would be the
> 
> Yeah, that's kind of where I'm thinking of getting to. Be lazy so long
> as we don't violate guarantees.
> 
> > difference wrt preempt=voluntary from a scheduler pow? Yes, it might
> > break deadline guarantees, but if you wanted to use preempt=none maybe
> > there is a strong reason for it, I'm thinking.
> 
> Yeah, the difference between preempt=none and preempt=voluntary is
> looking narrower and narrower, and maybe a bit artificial in that
> there seem to be very few cases where the two models would actually
> differ in behaviour.

If it turns out that cond_resched() and the preemption points in
might_sleep() really can be dispensed with, then there would be little
difference between them.  But that is still "if".  ;-)

							Thanx, Paul

> Thanks
> Ankur
> 
> >> Thanks for the review, btw.
> >
> > Sure. Thanks for working on this actually! :)
> >
> > Best,
> > Juri

