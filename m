Return-Path: <linux-kernel+bounces-30229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86C64831BCF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 15:52:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F78E28312E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 14:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 819C31F16B;
	Thu, 18 Jan 2024 14:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WpH6lnIy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C497E1E87F;
	Thu, 18 Jan 2024 14:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705589518; cv=none; b=XxWQpztae7djWD6H2u4NMkyIF8jBZaM7P7dIGdKfBWULZF3FVZEzqX3+Hzno4jThsWkBCDT2KZ4iSLDyFhSSwfYS+ytoB8GlJIOe5YfJUn0vVyRr+M1Ozj38Zx3JumvIVKQM4mG5diWfmdQrcbR5HMOXxsk9b6Z3l3DbXYyPMtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705589518; c=relaxed/simple;
	bh=xeoxo1JeEqSffJNlDwl5IKuOr/B7hUoTC/bpE5m133g=;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:Reply-To:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To; b=YFCx0OESmWpu50MTOA5lxkOkU4SZrJH8eFnjCzpNi9rNON3EWhvOO5fM/nbtjQJOgodcQ60uKkFSWhOFJL9J2xVkQuxXA4hmWEs7hjMXFCf/NS1vTGX70Ia/S1ND29i1ttEzaZbP1adzt+38Jym53zMCcmbsnEMrI9UXwH0eZvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WpH6lnIy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 823ADC433C7;
	Thu, 18 Jan 2024 14:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705589518;
	bh=xeoxo1JeEqSffJNlDwl5IKuOr/B7hUoTC/bpE5m133g=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=WpH6lnIy7dg3b6oFMj1TyOY17r9YDQVNchWh+1G2VKtQqNCxKu5RYSsMxdZRE3/0b
	 lk0gpYly4T8EarX6fSks+SMX7x/xzSZmArDUtNFbZOaqjrKGyF4UXypHKlJ0cyxV6p
	 R9fnppqLn6+zUiUpzQDBT6l2vwu0TfdPD0bStBzdeAdVSsHaX6pRcrhfEpBRg+iH+t
	 OmIp8k1ypakJgnvOsfZ3xmcJZX2qMFcF8nVOcn4l8oKRn1HpUSWg3NHdUcUFewsjEM
	 HNsqhrby28VfWl+RWvH7qXXTKEwS/u3YlG0Z66qkzpRYVPRo4iAtDo/FF6OTZ7TfyO
	 zgy62VOaRiuYg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id E5FAFCE0546; Thu, 18 Jan 2024 06:51:57 -0800 (PST)
Date: Thu, 18 Jan 2024 06:51:57 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Zqiang <qiang.zhang1211@gmail.com>, quic_neeraju@quicinc.com,
	joel@joelfernandes.org, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu/nocb: Check rdp_gp->nocb_timer in
 __call_rcu_nocb_wake()
Message-ID: <3b63cf39-3805-4c1d-b79b-fdd5aeb17db3@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240117102616.18302-1-qiang.zhang1211@gmail.com>
 <ZafC_YkTJKsOropE@localhost.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZafC_YkTJKsOropE@localhost.localdomain>

On Wed, Jan 17, 2024 at 01:07:25PM +0100, Frederic Weisbecker wrote:
> Le Wed, Jan 17, 2024 at 06:26:16PM +0800, Zqiang a écrit :
> > Currently, only rdp_gp->nocb_timer is used, for nocb_timer of
> > no-rdp_gp structure, the timer_pending() is always return false,
> > this commit therefore need to check rdp_gp->nocb_timer in
> > __call_rcu_nocb_wake().
> > 
> > Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
> > ---
> >  kernel/rcu/tree_nocb.h | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
> > index 54971afc3a9b..3f85577bddd4 100644
> > --- a/kernel/rcu/tree_nocb.h
> > +++ b/kernel/rcu/tree_nocb.h
> > @@ -564,6 +564,7 @@ static void __call_rcu_nocb_wake(struct rcu_data *rdp, bool was_alldone,
> >  	long lazy_len;
> >  	long len;
> >  	struct task_struct *t;
> > +	struct rcu_data *rdp_gp = rdp->nocb_gp_rdp;
> >  
> >  	// If we are being polled or there is no kthread, just leave.
> >  	t = READ_ONCE(rdp->nocb_gp_kthread);
> > @@ -608,7 +609,7 @@ static void __call_rcu_nocb_wake(struct rcu_data *rdp, bool was_alldone,
> >  		smp_mb(); /* Enqueue before timer_pending(). */
> >  		if ((rdp->nocb_cb_sleep ||
> >  		     !rcu_segcblist_ready_cbs(&rdp->cblist)) &&
> > -		    !timer_pending(&rdp->nocb_timer)) {
> > +		    !timer_pending(&rdp_gp->nocb_timer)) {
> 
> Hehe, good eyes ;-)
> 
> I had that change in mind but while checking that area further I actually
> wondered what is the actual purpose of this RCU_NOCB_WAKE_FORCE thing. If
> we reach that place, it means that the nocb_gp kthread should be awaken
> already (or the timer pending), so what does a force wake up solve in that
> case?
> 
> Paul, any recollection of that?

Huh.  We never actually do RCU_NOCB_WAKE_FORCE in v6.7, if I followed
all the code paths correctly.

Historically, I have been worried about lost wakeups.  Also, there
used to be code paths in which a wakeup was not needed, for example,
because we knew that the ending of the current grace period would take
care of things.  Unless there was some huge pile of callbacks, in which
case an immediate wakeup could avoid falling behind a callback flood.

Given that rcutorture does test callback flooding, we appear to be OK,
but maybe it is time to crank up the flooding more.

On the other hand, I have started seeing the (very) occasional OOM
on TREE03.  (In addition to those that show up from time to time on the
single-CPU TREE09 scenario.)

							Thanx, Paul

> In the meantime:
> 
> Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

