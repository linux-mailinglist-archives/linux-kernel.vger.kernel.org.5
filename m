Return-Path: <linux-kernel+bounces-14768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B80888221F5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 20:25:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BFC71F2176C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 19:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CD2E15AF9;
	Tue,  2 Jan 2024 19:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uOffRpye"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9FF15AE6;
	Tue,  2 Jan 2024 19:25:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 262C0C433C8;
	Tue,  2 Jan 2024 19:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704223514;
	bh=9V0vCJ4+GodEccsQMreY2i8HY2m1UiJC6KxW8j9XPZc=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=uOffRpye5Hs9O9LrEaJEqVhIOWGQrP8nAOkDtf1osHW2gP2WBsMOC+fdUesAKoFWo
	 cYrZZyaWmEOaSw5cdFh2LmV8UQg/m+v+XymwI2jEwFakkITknX/tWBk4godrcVV68e
	 3G4XMWKW5auXu+reliWrGbFRkhmMXTHBttOWTAJht/i2SgacUXe+WwA8IAszJnSjII
	 lnd6ExFhbF5RB3GeuxmU/iO0ySq/UfMfOPcqbhcxSqZSH+E6yMWBHmc2geIb1T7qGJ
	 Hlozi8JScjT8q1nOzsbkb+eyuSMU/IloUbx74eY8srRQKUWIDp0xhVqrbttfZDhsO7
	 2pxpiu5PYvGcA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id ADC12CE158D; Tue,  2 Jan 2024 11:25:13 -0800 (PST)
Date: Tue, 2 Jan 2024 11:25:13 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Uladzislau Rezki <urezki@gmail.com>
Cc: RCU <rcu@vger.kernel.org>, Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Boqun Feng <boqun.feng@gmail.com>, Hillf Danton <hdanton@sina.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
	Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH v3 4/7] rcu: Improve handling of synchronize_rcu() users
Message-ID: <cd45b0b5-f86b-43fb-a5f3-47d340cd4f9f@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20231128080033.288050-1-urezki@gmail.com>
 <20231128080033.288050-5-urezki@gmail.com>
 <579f86e0-e03e-4ab3-9a85-a62064bcf2a1@paulmck-laptop>
 <ZYQY8bB3zpywfBxO@pc636>
 <650554ca-17f6-4119-ab4e-42239c958c73@paulmck-laptop>
 <ZYVWjc65LzD8qkdw@pc636>
 <e20058f9-a525-4d65-b22b-7dd9cfec9737@paulmck-laptop>
 <ZZQHCrGNwjooI4kU@pc636>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZZQHCrGNwjooI4kU@pc636>

On Tue, Jan 02, 2024 at 01:52:26PM +0100, Uladzislau Rezki wrote:
> Hello, Paul!
> 
> Sorry for late answer, it is because of holidays :)
> 
> > > > > The problem is that, we are limited in number of "wait-heads" which we
> > > > > add as a marker node for this/current grace period. If there are more clients
> > > > > and there is no a wait-head available it means that a system, the deferred
> > > > > kworker, is slow in processing callbacks, thus all wait-nodes are in use.
> > > > > 
> > > > > That is why we need an extra grace period. Basically to repeat our try one
> > > > > more time, i.e. it might be that a current grace period is not able to handle
> > > > > users due to the fact that a system is doing really slow, but this is rather
> > > > > a corner case and is not a problem.
> > > > 
> > > > But in that case, the real issue is not the need for an extra grace
> > > > period, but rather the need for the wakeup processing to happen, correct?
> > > > Or am I missing something subtle here?
> > > > 
> > > Basically, yes. If we had a spare dummy-node we could process the users
> > > by the current GP(no need in extra). Why we may not have it - it is because
> > > like you pointed:
> > > 
> > > - wake-up issue, i.e. wake-up time + when we are on_cpu;
> > > - slow list process. For example priority. The kworker is not
> > >   given enough CPU time to do the progress, thus "dummy-nodes"
> > >   are not released in time for reuse.
> > > 
> > > Therefore, en extra GP is requested if there is a high flow of
> > > synchronize_rcu() users and kworker is not able to do a progress
> > > in time.
> > > 
> > > For example 60K+ parallel synchronize_rcu() users will trigger it.
> > 
> > OK, but what bad thing would happen if that was moved to precede the
> > rcu_seq_start(&rcu_state.gp_seq)?  That way, the requested grace period
> > would be the same as the one that is just now starting.
> > 
> > Something like this?
> > 
> > 	start_new_poll = rcu_sr_normal_gp_init();
> > 
> > 	/* Record GP times before starting GP, hence rcu_seq_start(). */
> > 	rcu_seq_start(&rcu_state.gp_seq);
> > 	ASSERT_EXCLUSIVE_WRITER(rcu_state.gp_seq);
> >
> I had a concern about the case when rcu_sr_normal_gp_init() handles what
> we currently have, in terms of requests. Right after that there is/are
> extra sync requests which invoke the start_poll_synchronize_rcu() but
> since a GP has been requested before it will not request an extra one. So
> "last" incoming users might not be processed.
> 
> That is why i have placed the rcu_sr_normal_gp_init() after a gp_seq is
> updated.
> 
> I can miss something, so please comment. Apart of that we can move it
> as you proposed.

Couldn't that possibility be handled by a check in rcu_gp_cleanup()?

							Thanx, Paul

