Return-Path: <linux-kernel+bounces-130414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 375B98977BF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 20:05:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC1731F25F1A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 18:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E644153819;
	Wed,  3 Apr 2024 18:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eZZftPSh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9476015358B
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 18:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712167512; cv=none; b=h+7z2eB31RmNeSrYsv189kWijCqjGBRrNUcw03oPL/cKzy7UElKIavvRvzJbqJYveVwXruEsd/rUlHNwPqD5/LOfsVVCnBg3Fv81BXWmRjbMFV81NEcRTaCzssQti6ZTqeWjiZ7l7aKsKbG/gIIG8kwFHtGNGUojq20m1/AsWCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712167512; c=relaxed/simple;
	bh=qyTX9PCGdZlKPgAFk3WtbDgUfv+tS3H3+547kM4FpWI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jLQvGinJ9X4FOoFcHvDeAnJ3am1/ESC6Y+3ew7UbzORTy+9CcxXXuBGrMc98e5Si5bIYKy0N2QjpUf4eM3FfbF6kcS+dYWtNAp2/uz4t18tSGtPgufJt1NB6LU2LXcZ5dYoPQnGoPyAcZfwUe0tOv0zcn+kCWAp0yeHUAcKHrJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eZZftPSh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29725C43394;
	Wed,  3 Apr 2024 18:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712167512;
	bh=qyTX9PCGdZlKPgAFk3WtbDgUfv+tS3H3+547kM4FpWI=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=eZZftPShbISmEeQKoIHT5469+LMJIlQ7sbTCf8W5J1a6toL/QjjxL5MTFCRnRBM+u
	 qzIHtVnam99z8xqLySmXQLaA8VCwLFjLIoscuf+fx3rb4PYSN3YKjdT8mZ/GK234q0
	 t+lKgbL/D6Oi/sqM9H9vhc8FVuNYbN/3OIjtBt1ZK720TvS92ynZN2t1IWlHPu3XQM
	 2P8bKGdiJktgXPQp8RixC5H2R4bZzEmzqQg+T1KdG3S4lM/9rLf9+CnBZskPZyXvik
	 C59Nze07s8TBcNEx80uINLXVZthiRmiOfoMfruWqnxw3nIqXACfphwBXjjdEW7Tcoz
	 c45SgVDesmxJw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id BAAA4CE0D85; Wed,  3 Apr 2024 11:05:11 -0700 (PDT)
Date: Wed, 3 Apr 2024 11:05:11 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: Re: [PATCH 2/2] timers: Fix removed self-IPI on global timer's
 enqueue in nohz_full
Message-ID: <9e1a3be7-839a-44fb-9d10-82784581f7a0@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <464f6be2-4a72-440d-be53-6a1035d56a4f@paulmck-laptop>
 <1b5752c8-ef32-4ed4-b539-95d507ec99ce@paulmck-laptop>
 <ZfsLtMijRrNZfqh6@localhost.localdomain>
 <6a95b6ac-6681-4492-b155-e30c19bb3341@paulmck-laptop>
 <ZfwdEROGFFmIbkCM@lothringen>
 <bf8689c2-0749-47cb-9535-53cf66e34f5e@paulmck-laptop>
 <797f44f9-701d-4fca-a9f4-d112a7178e7b@paulmck-laptop>
 <ZgstlCZn0l9wSv7H@pavilion.home>
 <ed13826a-d2d3-4999-8d9e-77dfc6245e1c@paulmck-laptop>
 <3f2597ea-81ba-4498-a0ee-84d7e4e3da59@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3f2597ea-81ba-4498-a0ee-84d7e4e3da59@paulmck-laptop>

On Tue, Apr 02, 2024 at 09:47:37AM -0700, Paul E. McKenney wrote:
> On Mon, Apr 01, 2024 at 05:04:10PM -0700, Paul E. McKenney wrote:
> > On Mon, Apr 01, 2024 at 11:56:36PM +0200, Frederic Weisbecker wrote:
> > > Le Mon, Apr 01, 2024 at 02:26:25PM -0700, Paul E. McKenney a écrit :
> > > > > > _ The RCU CPU Stall report. I strongly suspect the cause is the hrtimer
> > > > > >   enqueue to an offline CPU. Let's solve that and we'll see if it still
> > > > > >   triggers.
> > > > > 
> > > > > Sounds like a plan!
> > > > 
> > > > Just checking in on this one.  I did reproduce your RCU CPU stall report
> > > > and also saw a TREE03 OOM that might (or might not) be related.  Please
> > > > let me know if hammering TREE03 harder or adding some debug would help.
> > > > Otherwise, I will assume that you are getting sufficient bug reports
> > > > from your own testing to be getting along with.
> > > 
> > > Hehe, there are a lot indeed :-)
> > > 
> > > So there has been some discussion on CPUSET VS Hotplug, as a problem there
> > > is likely the cause of the hrtimer warning you saw, which in turn might
> > > be the cause of the RCU stalls.
> > > 
> > > Do you always see the hrtimer warning along the RCU stalls? Because if so, this
> > > might help:
> > > https://lore.kernel.org/lkml/20240401145858.2656598-1-longman@redhat.com/T/#m1bed4d298715d1a6b8289ed48e9353993c63c896
> > 
> > Not always, but why not give it a shot?
> 
> And no failures, though I would need to run much longer for this to
> mean much.  These were wide-spectrum tests, so my next step will be to
> run only TREE03 and TREE07.

And 600 hours each of TREE03 and TREE07 got me a single TREE07 instance
of the sched_tick_remote() failure.  This one:

	WARN_ON_ONCE(delta > (u64)NSEC_PER_SEC * 3);

But this is just rcutorture testing out "short" 14-second stalls, which
can only be expected to trigger this from time to time.  The point of
this stall is to test the evasive actions that RCU takes when 50% of
the way to the RCU CPU stall timeout.

One approach would be to increase that "3" to "15", but that sounds
quite fragile.  Another would be for rcutorture to communicate the fact
that stall testing is in progress, and then this WARN_ON_ONCE() could
silence itself in that case.

But is there a better approach?

							Thanx, Paul

