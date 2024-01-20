Return-Path: <linux-kernel+bounces-31645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF09F8331D3
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 01:30:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C863284D01
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 00:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBC3F396;
	Sat, 20 Jan 2024 00:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nz/A+akL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ADA636A;
	Sat, 20 Jan 2024 00:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705710593; cv=none; b=cHSpGpJLfh/V4myHNDat8dHzytqJC8xm5C/qsmMHh+M8W1iihXcSbfrXwR8nax7JqTgWGJOtcEoEQ5m9ukc2yM11gXSZ1o55qiIwZh0GDKNzIs5kWOBx44uN2oOcTt1iFHVcupi0gQ5x+6RnDpW3KhSJ8818YSI85PMYsMzsibo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705710593; c=relaxed/simple;
	bh=TOm/SE3sJMeMhvmO3cK62Aeswe3mdfk0a7J8msw05PU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RXKw7dh/4zxAOvuNKD+KD0aj0hYn4wn163Wz1FlvkjY4iR9rXveBA9DQQ6jIOu10NDoVzmTnWPJ3gWMlzAkjeOvxZbYWD+cOFTQiZu82SStG/tsF3Hx0bh7uOeYUxoh7lGW43huV9ukceaK6bJKNKupyQWGAgKH65rVe9Qx0CQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nz/A+akL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA705C433F1;
	Sat, 20 Jan 2024 00:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705710592;
	bh=TOm/SE3sJMeMhvmO3cK62Aeswe3mdfk0a7J8msw05PU=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=Nz/A+akLZNSDo/1m2TuO86KlEgH0TZoJunpq70FmCqC2wWfTRb5tGi+g/jF/v+0sW
	 t9y0unHooxq+ZAxTQ0DHjcTKmheYjRPzYnI766zXQn4564+AGkkDxl2HOY9FkItt6o
	 so1JIKBP7ibPPd3Q62s9YXJHLv9mMGGC5wpL+PIesPmtomjE9wsC1W+une82v2Y5H4
	 lECTuPQnQr4wHahGNmeDcjdcJyvRu5av6tw8sjKndlSo3yc3kzYHZJ7SOwn2Jwss5E
	 u6gduS1iZueO3YKI2eqzfDURrXdmvmeigwIX/rIPbP+h+CRw7cr1C8uYoxPSbfAX+N
	 0o+BNQLCA9YZw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 379E4CE0ACF; Fri, 19 Jan 2024 16:29:52 -0800 (PST)
Date: Fri, 19 Jan 2024 16:29:52 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Zqiang <qiang.zhang1211@gmail.com>, quic_neeraju@quicinc.com,
	joel@joelfernandes.org, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu/nocb: Check rdp_gp->nocb_timer in
 __call_rcu_nocb_wake()
Message-ID: <2490b90d-ebce-42bf-8a83-1314e8272df8@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240117102616.18302-1-qiang.zhang1211@gmail.com>
 <ZafC_YkTJKsOropE@localhost.localdomain>
 <3b63cf39-3805-4c1d-b79b-fdd5aeb17db3@paulmck-laptop>
 <Zart693B-klrEF5I@pavilion.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zart693B-klrEF5I@pavilion.home>

On Fri, Jan 19, 2024 at 10:47:23PM +0100, Frederic Weisbecker wrote:
> Le Thu, Jan 18, 2024 at 06:51:57AM -0800, Paul E. McKenney a écrit :
> > On Wed, Jan 17, 2024 at 01:07:25PM +0100, Frederic Weisbecker wrote:
> > > Le Wed, Jan 17, 2024 at 06:26:16PM +0800, Zqiang a écrit :
> > > > Currently, only rdp_gp->nocb_timer is used, for nocb_timer of
> > > > no-rdp_gp structure, the timer_pending() is always return false,
> > > > this commit therefore need to check rdp_gp->nocb_timer in
> > > > __call_rcu_nocb_wake().
> > > > 
> > > > Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
> > > > ---
> > > >  kernel/rcu/tree_nocb.h | 3 ++-
> > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
> > > > index 54971afc3a9b..3f85577bddd4 100644
> > > > --- a/kernel/rcu/tree_nocb.h
> > > > +++ b/kernel/rcu/tree_nocb.h
> > > > @@ -564,6 +564,7 @@ static void __call_rcu_nocb_wake(struct rcu_data *rdp, bool was_alldone,
> > > >  	long lazy_len;
> > > >  	long len;
> > > >  	struct task_struct *t;
> > > > +	struct rcu_data *rdp_gp = rdp->nocb_gp_rdp;
> > > >  
> > > >  	// If we are being polled or there is no kthread, just leave.
> > > >  	t = READ_ONCE(rdp->nocb_gp_kthread);
> > > > @@ -608,7 +609,7 @@ static void __call_rcu_nocb_wake(struct rcu_data *rdp, bool was_alldone,
> > > >  		smp_mb(); /* Enqueue before timer_pending(). */
> > > >  		if ((rdp->nocb_cb_sleep ||
> > > >  		     !rcu_segcblist_ready_cbs(&rdp->cblist)) &&
> > > > -		    !timer_pending(&rdp->nocb_timer)) {
> > > > +		    !timer_pending(&rdp_gp->nocb_timer)) {
> > > 
> > > Hehe, good eyes ;-)
> > > 
> > > I had that change in mind but while checking that area further I actually
> > > wondered what is the actual purpose of this RCU_NOCB_WAKE_FORCE thing. If
> > > we reach that place, it means that the nocb_gp kthread should be awaken
> > > already (or the timer pending), so what does a force wake up solve in that
> > > case?
> > > 
> > > Paul, any recollection of that?
> > 
> > Huh.  We never actually do RCU_NOCB_WAKE_FORCE in v6.7, if I followed
> > all the code paths correctly.
> > 
> > Historically, I have been worried about lost wakeups.  Also, there
> > used to be code paths in which a wakeup was not needed, for example,
> > because we knew that the ending of the current grace period would take
> > care of things.  Unless there was some huge pile of callbacks, in which
> > case an immediate wakeup could avoid falling behind a callback flood.
> 
> Ok then looks like it's time for me to add RCU_NOCB_WAKE_FORCE removal in
> my TODO list...unless Zqiang would like to give it a try? :-)
> 
> > Given that rcutorture does test callback flooding, we appear to be OK,
> > but maybe it is time to crank up the flooding more.
> > 
> > On the other hand, I have started seeing the (very) occasional OOM
> > on TREE03.
> > (In addition to those that show up from time to time on the
> > single-CPU TREE09 scenario.)
> 
> Interesting, are those recent? Bisectable?

Bisection in progress, got it down to 10 commits.  Yet again about
ten hours per step on 20 systems...

Though maybe I should have put more time into making it happen faster.
Except that I was on travel, so I doubt that I would have made all that
much progress.  ;-)

							Thanx, Paul

							Thanx, Paul

