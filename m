Return-Path: <linux-kernel+bounces-96128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56232875771
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 20:47:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5CCD1B21410
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 19:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53ED71369A6;
	Thu,  7 Mar 2024 19:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TrQCKxgt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FDB4136989;
	Thu,  7 Mar 2024 19:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709840856; cv=none; b=tmImzljWWREsS5epNfkNf3PfmSmYe95NQitv+THRRN/MQ4NbDX/z/F1SA2jdto+a+iimdWESkNY2b2lKabCkg1eO/6j/i+d+7vukbZnHoSH5yPAFsLerMylI1dKGmO78omlTDpiAmBdWjwX9TMVZsVcxOjLbRSo+xNc3t4VUEX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709840856; c=relaxed/simple;
	bh=OHMHjrmXLAl+M5prZnWsXYc3CPrx3uhUlRe0pX2R6CM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jSutElqdKNdF3aH1Mc2qO+VLHkhW8T1JSxe/OhJ17g2ulbHph/jhvWDYSEx9CJEj0v8H7FUwhXPaYLQrGYeVyw+9K3GAJEXFVtAHBI0Xn3eQlvdaTugOlgGZ5SdDMjEdRRp/4EC1ZTCUNpT2XwU2Ifj+vHBCBEPQLXqSOpmm8u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TrQCKxgt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D894FC433C7;
	Thu,  7 Mar 2024 19:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709840855;
	bh=OHMHjrmXLAl+M5prZnWsXYc3CPrx3uhUlRe0pX2R6CM=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=TrQCKxgt61A6b11OT+EDHqfSLuUFzmlZq9xGRsenob5TEn7/IstinO10wOl6paOnv
	 GY2tT4Usoc6RQq4Dy8ZPnUDb97YEJuQTClOTvMYvo8KJ/fr4ojm4Pvk4QTMoIa4mgY
	 SaoWufgDt5RgKinvMUAIKQqTjvec7oVGmT95SdCMYb3RS6RU8tjehGcY+yVt/oUzWp
	 O0UbBuMkEAI1X97PhfWKWmUr97cmzOl5RtovIJ8sNEVR18wvBwdWRCWa+jRH+MKVLW
	 G2cbyy3VcX6vnxd2Oat/J5RI/czw0AC/Nn15j4BeLsypo8ULPaUHncmbogr1ah3GWo
	 Oer+72wTykJFw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 62B50CE0716; Thu,  7 Mar 2024 11:47:35 -0800 (PST)
Date: Thu, 7 Mar 2024 11:47:35 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Steven Rostedt <rostedt@goodmis.org>, linke li <lilinke99@qq.com>,
	joel@joelfernandes.org, boqun.feng@gmail.com, dave@stgolabs.net,
	frederic@kernel.org, jiangshanlai@gmail.com, josh@joshtriplett.org,
	linux-kernel@vger.kernel.org, qiang.zhang1211@gmail.com,
	quic_neeraju@quicinc.com, rcu@vger.kernel.org
Subject: Re: [PATCH] rcutorture: Fix
 rcu_torture_pipe_update_one()/rcu_torture_writer() data race and concurrency
 bug
Message-ID: <c1bb35c4-29af-4a84-8ba7-81ba30639a69@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <CAHk-=wgG6Dmt1JTXDbrbXh_6s2yLjL=9pHo7uv0==LHFD+aBtg@mail.gmail.com>
 <20240306135504.2b3872ef@gandalf.local.home>
 <CAHk-=wjbDgMKLgxbV+yK4LKZ+2Qj6zVL_sHeb+L9KDia980Q8Q@mail.gmail.com>
 <20240306142738.7b66a716@rorschach.local.home>
 <CAHk-=wgPAZ4KnCQergqAOUypwinYh=gZ0q4EQbwvuUcJ_8UK+Q@mail.gmail.com>
 <83b47424-e5e0-46de-aa63-d413a5aa6cec@paulmck-laptop>
 <CAHk-=wiX_zF5Mpt8kUm_LFQpYY-mshrXJPOe+wKNwiVhEUcU9g@mail.gmail.com>
 <851dc594-d2ea-4050-b7c6-e33a1cddf3a1@efficios.com>
 <72b14322-78c1-4479-9c4e-b0e11c1f0d53@paulmck-laptop>
 <bebbed4a-ced1-42c5-865c-dc9dc7857b6c@efficios.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bebbed4a-ced1-42c5-865c-dc9dc7857b6c@efficios.com>

On Thu, Mar 07, 2024 at 08:53:05AM -0500, Mathieu Desnoyers wrote:
> On 2024-03-06 22:37, Paul E. McKenney wrote:
> > On Wed, Mar 06, 2024 at 10:06:21PM -0500, Mathieu Desnoyers wrote:
> [...]
> > 
> > > As far as the WRITE_ONCE(x, READ_ONCE(x) + 1) pattern
> > > is concerned, the only valid use-case I can think of is
> > > split counters or RCU implementations where there is a
> > > single updater doing the increment, and one or more
> > > concurrent reader threads that need to snapshot a
> > > consistent value with READ_ONCE().
> > 
> [...]
> > 
> > So what would you use that pattern for?
> > 
> > One possibility is a per-CPU statistical counter in userspace on a
> > fastpath, in cases where losing the occasional count is OK.  Then learning
> > your CPU (and possibly being immediately migrated to some other CPU),
> > READ_ONCE() of the count, increment, and WRITE_ONCE() might (or might not)
> > make sense.
> > 
> > I suppose the same in the kernel if there was a fastpath so extreme you
> > could not afford to disable preemption.
> > 
> > At best, very niche.
> > 
> > Or am I suffering a failure of imagination yet again?  ;-)
> 
> The (niche) use-cases I have in mind are split-counters and RCU
> grace period tracking, where precise counters totals are needed
> (no lost count).
> 
> In the kernel, this could be:

Thank you for looking into this!

> - A per-cpu counter, each counter incremented from thread context with
>   preemption disabled (single updater per counter), read concurrently by
>   other threads. WRITE_ONCE/READ_ONCE is useful to make sure there
>   is no store/load tearing there. Atomics on the update would be stronger
>   than necessary on the increment fast-path.

But if preemption is disabled, the updater can read the value without
READ_ONCE() without risk of concurrent update.  Or are you concerned about
interrupt handlers?  This would have to be a read from the interrupt
handler, given that an updated from the interrupt handler could result
in a lost count.

> - A per-thread counter (e.g. within task_struct), only incremented by the
>   single thread, read by various threads concurrently.

Ditto.

> - A counter which increment happens to be already protected by a lock, read
>   by various threads without taking the lock. (technically doable, but
>   I'm not sure I see a relevant use-case for it)

In that case, the lock would exclude concurrent updates, so the lock
holder would not need READ_ONCE(), correct?

> In user-space:
> 
> - The "per-cpu" counter would have to use rseq for increments to prevent
>   inopportune migrations, which needs to be implemented in assembler anyway.
>   The counter reads would have to use READ_ONCE().

Fair enough!

> - The per-thread counter (Thread-Local Storage) incremented by a single
>   thread, read by various threads concurrently, is a good target
>   for WRITE_ONCE()/READ_ONCE() pairing. This is actually what we do in
>   various liburcu implementations which track read-side critical sections
>   per-thread.

Agreed, but do any of these use WRITE_ONCE(x, READ_ONCE(x) + 1) or
similar?

> - Same as for the kernel, a counter increment protected by a lock which
>   needs to be read from various threads concurrently without taking
>   the lock could be a valid use-case, though I fail to see how it is
>   useful due to lack of imagination on my part. ;-)

In RCU, we have "WRITE_ONCE(*sp, *sp + 1)" for this use case, though
here we have the WRITE_ONCE() but not the READ_ONCE() because we hold
the lock excluding any other updates.

> I'm possibly missing other use-cases, but those come to mind as not
> involving racy counter increments.
> 
> I agree that use-cases are so niche that we probably do _not_ want to
> introduce ADD_SHARED() for that purpose in a common header file,
> because I suspect that it would then become misused in plenty of
> scenarios where the updates are actually racy and would be better
> served by atomics or local-atomics.

I agree that unless or until we have a reasonable number of use cases, we
should open-code it.  With a big fat comment explaining how it works.  ;-)

							Thanx, Paul

