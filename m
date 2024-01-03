Return-Path: <linux-kernel+bounces-15665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA85C822FCF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 15:47:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C117D1C2373B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 14:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CD371A703;
	Wed,  3 Jan 2024 14:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qJNkOxWc"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D8371A5B5;
	Wed,  3 Jan 2024 14:47:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2FD1C433C7;
	Wed,  3 Jan 2024 14:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704293250;
	bh=eKE/r4uonx3PcogK9mog978qwaEOZTJ0rKW7BO68qPM=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=qJNkOxWcITLB8VoaHZTNEZzTNKz80+v+zaTL9u1xUBdud3hiuZaVF8Ar3tvT+t6gy
	 uYuwCT6ul5DiPp0d2a/oV1osoAI8lgLpA7qRzJ0Zps/FLcYtfR+/dj8+bKDv9H9fgR
	 jXIQUu8dElUYOcbmQMK+PwiRWG/c53D3D3aMJPDtHwkRQfKEml9sUjaW2UTUqSsa3n
	 W6DqpjyBIJch7nUeKnHqovIkcXdWiff/2b4g94PCf58fhbH5P/nf1jIk2XrqT1bWip
	 AtpomRTjKFz0Oehp7cAfcSDwvvv1mLddAL/+Nd1z6eo+egRmGJD32sX32xL2mFFROX
	 +VE9BH47amKqg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 4D34CCE0874; Wed,  3 Jan 2024 06:47:30 -0800 (PST)
Date: Wed, 3 Jan 2024 06:47:30 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Uladzislau Rezki <urezki@gmail.com>
Cc: RCU <rcu@vger.kernel.org>, Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Boqun Feng <boqun.feng@gmail.com>, Hillf Danton <hdanton@sina.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
	Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH v3 4/7] rcu: Improve handling of synchronize_rcu() users
Message-ID: <45a15103-0302-4e7d-b522-e17e8b8ac927@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20231128080033.288050-1-urezki@gmail.com>
 <20231128080033.288050-5-urezki@gmail.com>
 <579f86e0-e03e-4ab3-9a85-a62064bcf2a1@paulmck-laptop>
 <ZYQY8bB3zpywfBxO@pc636>
 <650554ca-17f6-4119-ab4e-42239c958c73@paulmck-laptop>
 <ZYVWjc65LzD8qkdw@pc636>
 <e20058f9-a525-4d65-b22b-7dd9cfec9737@paulmck-laptop>
 <ZZQHCrGNwjooI4kU@pc636>
 <cd45b0b5-f86b-43fb-a5f3-47d340cd4f9f@paulmck-laptop>
 <ZZVeEGTKVp7CUqtK@pc636>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZZVeEGTKVp7CUqtK@pc636>

On Wed, Jan 03, 2024 at 02:16:00PM +0100, Uladzislau Rezki wrote:
> On Tue, Jan 02, 2024 at 11:25:13AM -0800, Paul E. McKenney wrote:
> > On Tue, Jan 02, 2024 at 01:52:26PM +0100, Uladzislau Rezki wrote:
> > > Hello, Paul!
> > > 
> > > Sorry for late answer, it is because of holidays :)
> > > 
> > > > > > > The problem is that, we are limited in number of "wait-heads" which we
> > > > > > > add as a marker node for this/current grace period. If there are more clients
> > > > > > > and there is no a wait-head available it means that a system, the deferred
> > > > > > > kworker, is slow in processing callbacks, thus all wait-nodes are in use.
> > > > > > > 
> > > > > > > That is why we need an extra grace period. Basically to repeat our try one
> > > > > > > more time, i.e. it might be that a current grace period is not able to handle
> > > > > > > users due to the fact that a system is doing really slow, but this is rather
> > > > > > > a corner case and is not a problem.
> > > > > > 
> > > > > > But in that case, the real issue is not the need for an extra grace
> > > > > > period, but rather the need for the wakeup processing to happen, correct?
> > > > > > Or am I missing something subtle here?
> > > > > > 
> > > > > Basically, yes. If we had a spare dummy-node we could process the users
> > > > > by the current GP(no need in extra). Why we may not have it - it is because
> > > > > like you pointed:
> > > > > 
> > > > > - wake-up issue, i.e. wake-up time + when we are on_cpu;
> > > > > - slow list process. For example priority. The kworker is not
> > > > >   given enough CPU time to do the progress, thus "dummy-nodes"
> > > > >   are not released in time for reuse.
> > > > > 
> > > > > Therefore, en extra GP is requested if there is a high flow of
> > > > > synchronize_rcu() users and kworker is not able to do a progress
> > > > > in time.
> > > > > 
> > > > > For example 60K+ parallel synchronize_rcu() users will trigger it.
> > > > 
> > > > OK, but what bad thing would happen if that was moved to precede the
> > > > rcu_seq_start(&rcu_state.gp_seq)?  That way, the requested grace period
> > > > would be the same as the one that is just now starting.
> > > > 
> > > > Something like this?
> > > > 
> > > > 	start_new_poll = rcu_sr_normal_gp_init();
> > > > 
> > > > 	/* Record GP times before starting GP, hence rcu_seq_start(). */
> > > > 	rcu_seq_start(&rcu_state.gp_seq);
> > > > 	ASSERT_EXCLUSIVE_WRITER(rcu_state.gp_seq);
> > > >
> > > I had a concern about the case when rcu_sr_normal_gp_init() handles what
> > > we currently have, in terms of requests. Right after that there is/are
> > > extra sync requests which invoke the start_poll_synchronize_rcu() but
> > > since a GP has been requested before it will not request an extra one. So
> > > "last" incoming users might not be processed.
> > > 
> > > That is why i have placed the rcu_sr_normal_gp_init() after a gp_seq is
> > > updated.
> > > 
> > > I can miss something, so please comment. Apart of that we can move it
> > > as you proposed.
> > 
> > Couldn't that possibility be handled by a check in rcu_gp_cleanup()?
> > 
> It is controlled by the caller anyway, i.e. if a new GP is needed.
> 
> I am not 100% sure it is as straightforward as it could look like to
> handle it in the rcu_sr_normal_gp_cleaup() function. At least i see
> that we need to access to the first element of llist and find out if
> it is a wait-dummy-head or not. If not we know there are extra incoming
> calls.
> 
> So that way requires extra calling of start_poll_synchronize_rcu().

If this is invoked early enough in rcu_gp_cleanup(), all that needs to
happen is to set the need_gp flag.  Plus you can count the number of
requests, and snapshot that number at rcu_gp_init() time and check to
see if it changed at rcu_gp_cleanup() time.  Later on, this could be
used to reduce the number of wakeups, correct?

> I can add a comment about your concern and we can find the best approach
> later, if it is OK with you!

I agree that this should be added via a later patch, though I have not
yet given up on the possibility that this patch might be simple enough
to be later in this same series.

							Thanx, Paul

