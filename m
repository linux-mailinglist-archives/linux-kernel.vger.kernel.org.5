Return-Path: <linux-kernel+bounces-99685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4C76878BC3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 01:04:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E03F31C2114B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 00:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 039888F6D;
	Tue, 12 Mar 2024 00:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G4wt9IcV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434FB8F40
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 00:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710201838; cv=none; b=UM+/i8Mzen//eGYXH8PhZ2gGHgKi3+/m5FlHbd4MQLVsHiusPIPtdBiGMIhO2ewi/K9iP2EdMHcmqDsj4lT83zSrt5d/vC8sVTNBGtiyUAXDbATy3n3NBIMIrjo28PKVg5cmXhXQK4tPJu2TBo+gSoNFgJeGy2Mrlr0bNxC3A2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710201838; c=relaxed/simple;
	bh=iWI7eirf2P5weWGviJSXIz79p1ZWQJpxDdxTs6MwCZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tasxdinNXm/ZLWLR20WhTydhY0HcWchoDlTYNo1SnNueVXXnpKdTs7lmD+1bmbDoO6hLdOx7vCKZMuxXCSv44dfQ+VSI4HtCqGGpKlbGXpOnWRHnXaOylp8Q87/nyqMoigijkxvwrCZ0LRfT8r5D6a1Sn6vPaUw9xtN9lOnx8E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G4wt9IcV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE201C433C7;
	Tue, 12 Mar 2024 00:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710201837;
	bh=iWI7eirf2P5weWGviJSXIz79p1ZWQJpxDdxTs6MwCZ0=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=G4wt9IcVDIZ8xVxg05yXWLC9Po+YlHwG3JzRoa0pQnM4CadBmvrCsYdM3OH9GsXOC
	 xFBtiQ+E7NQylsH5IU832ITNJAw/cdhW7Zoa+1rDAUFJPG6TIhCbLHoTbqwEj9IHKZ
	 r5y2E8n0nmgmq81zw/cR10v61LT3oj1i2Za/uTbE2SItf/W7qNu+/iWmSfCfl5VI/G
	 eMLThWNyCuCHevSAgyumL5CkN1kK+gIx9BUno+/67tNh5B+K0l2Lsk8jYVTShFqGj1
	 RsRCvZSQ5SF5iyov0yDn2PFbRNfrkMg7yAPCXQ7NLxYVaK5/RPhuCQmxGF+RhPG60O
	 Ry5plBcskaiew==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 5AAB4CE1A25; Mon, 11 Mar 2024 17:03:57 -0700 (PDT)
Date: Mon, 11 Mar 2024 17:03:57 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ankur Arora <ankur.a.arora@oracle.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	linux-kernel@vger.kernel.org, tglx@linutronix.de,
	peterz@infradead.org, akpm@linux-foundation.org, luto@kernel.org,
	bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
	mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
	willy@infradead.org, mgorman@suse.de, jpoimboe@kernel.org,
	mark.rutland@arm.com, jgross@suse.com, andrew.cooper3@citrix.com,
	bristot@kernel.org, mathieu.desnoyers@efficios.com,
	geert@linux-m68k.org, glaubitz@physik.fu-berlin.de,
	anton.ivanov@cambridgegreys.com, mattst88@gmail.com,
	krypton@ulrich-teichert.org, rostedt@goodmis.org,
	David.Laight@aculab.com, richard@nod.at, mjguzik@gmail.com,
	jon.grimm@amd.com, bharata@amd.com, raghavendra.kt@amd.com,
	boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Subject: Re: [PATCH 26/30] sched: handle preempt=voluntary under PREEMPT_AUTO
Message-ID: <85cba8bd-5d2f-4da2-b4f9-93ae7c6a2a45@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <12a20651-5429-43df-88d7-9d01ff6212c6@joelfernandes.org>
 <63380f0a-329c-43df-8e6c-4818de5eb371@paulmck-laptop>
 <d956c2e9-492d-4559-b9f9-400f37f523bf@joelfernandes.org>
 <6054a8e0-eb95-45a3-9901-fe2a31b6fe4e@paulmck-laptop>
 <87plw5pd2x.fsf@oracle.com>
 <e36b84bc-09c4-4b2e-bad0-f72530a9b15e@paulmck-laptop>
 <87wmq9mkx2.fsf@oracle.com>
 <36eef8c5-8ecd-4c90-8851-1c2ab342e2bb@paulmck-laptop>
 <87cys0il7x.fsf@oracle.com>
 <CAHk-=whgp+Az+rR4L3oAnmbpSq7QqUEjJUNRpeeqsJ3O+Z8-QQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whgp+Az+rR4L3oAnmbpSq7QqUEjJUNRpeeqsJ3O+Z8-QQ@mail.gmail.com>

On Mon, Mar 11, 2024 at 01:23:09PM -0700, Linus Torvalds wrote:
> On Mon, 11 Mar 2024 at 13:10, Ankur Arora <ankur.a.arora@oracle.com> wrote:
> >
> > Ah, I see your point. Basically, keep the lazy semantics but -- in
> > addition -- also provide the ability to dynamically toggle
> > cond_resched(), might_reshed() as a feature to help move this along
> > further.
> 
> Please, let's not make up any random hypotheticals.
> 
> Honestly, if we ever hit the hypothetical scenario that Paul outlined, let's
> 
>  (a) deal with it THEN, when we actually know what the situation is
> 
>  (b) learn and document what it is that actually causes the odd behavior
> 
> IOW, instead of assuming that some "cond_resched()" case would even be
> the right thing to do, maybe there are other issues going on?  Let's
> not paper over them by keeping some hack around - and *if* some
> cond_resched() model is actually the right model in some individual
> place, let's make it the rule that *when* we hit that case, we
> document it.
> 
> And we should absolutely not have some hypothetical case keep us from
> just doing the right thing and getting rid of the existing
> cond_resched().
> 
> Because any potential future case is *not* going to be the same
> cond_resched() that the current case is anyway. It is going to have
> some very different cause.

Fair enough, and that approach just means that we will be reaching out
to Ankur and Thomas sooner rather than later if something goes sideways
latency-wise.  ;-)

							Thanx, Paul

