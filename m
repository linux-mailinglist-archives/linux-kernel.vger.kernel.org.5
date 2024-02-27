Return-Path: <linux-kernel+bounces-82462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 806B28684F5
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 01:21:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A10D2863C3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 00:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7180120EE;
	Tue, 27 Feb 2024 00:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kpt4X6zd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB18B1859;
	Tue, 27 Feb 2024 00:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708993277; cv=none; b=dDYwd/bJo4q5msuCAU3svpd0lswqdqsWC312PUdvp2GzFdxSgIly3Ly27BmI1rj2RV51mJTkhKfmfarc8V8eefbPCfaozJMY4l5XLSK4mfL5Ima5aTN66p1jWv1vJHrvK1q5kVSGzyIC82edTxr2zyfkS5CWIQDgKDwWkpce+sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708993277; c=relaxed/simple;
	bh=8NaJg0kgxbhEDKrN/5IITu2XOQzRyVbnI1VrY65Y4SI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qT3phgQi6/IUqSnpVEjhMHeoG0AR0KXUcTPP4HUZdi/qzXA9zyok8ke2KlJkDkHyi/eFzp/ohtDuYdNKO6Nh+Egvd0UGNzYYMpDJRXlMLARC/VowrNKoG87rpqNqXtQ1ZOEposguc4OHVCmu+oG4f8wZCOa9gXrgMZdzDV0EfMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kpt4X6zd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DE9EC433F1;
	Tue, 27 Feb 2024 00:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708993277;
	bh=8NaJg0kgxbhEDKrN/5IITu2XOQzRyVbnI1VrY65Y4SI=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=Kpt4X6zd6vBGkK34OLhy32XndWxyOgYCqRHFb+cPvtbSkooMCCdhP0/XOpLFGTgQG
	 KXtFtojWCOS7qzr/uRY5fylOi+Is52NU7T+zDPAETFvZt/h/YKrFMjGPiOKC0GPvyW
	 ljHUNRRMByzsXZXQAOoJCZvcW/7qQQytIqLptrgiRzBdMrEKYNX0y+X+uY3R7ym0zj
	 ePqX4PiUi9qfoPMWJ7buWd56t6LRAARsJvDjHrqk2btCHkuCWVIKwANV7DSqC31Fmj
	 m5uwN5xDJUtVT0qruNr60wckE8zuwWIYuSCGqIDZ5gSjfKG8v6FNY7IV+QuZILppWA
	 lvBfyCGDCGW3w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id BB9EFCE098C; Mon, 26 Feb 2024 16:21:16 -0800 (PST)
Date: Mon, 26 Feb 2024 16:21:16 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Oleksandr Natalenko <oleksandr@natalenko.name>
Cc: linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
	Boqun Feng <boqun.feng@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <quic_neeraju@quicinc.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Marcus Seyfarth <m.seyfarth@gmail.com>,
	Tor Vic <torvic9@mailbox.org>
Subject: Re: [PATCH 5/6] rcu/nocb: Fix WARN_ON_ONCE() in the
 rcu_nocb_bypass_lock()
Message-ID: <20c65121-3a78-4c48-87d8-adc7589f8f74@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240201014100.3204532-1-boqun.feng@gmail.com>
 <20240201014100.3204532-6-boqun.feng@gmail.com>
 <12387583.O9o76ZdvQC@natalenko.name>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <12387583.O9o76ZdvQC@natalenko.name>

On Sat, Feb 24, 2024 at 05:30:29PM +0100, Oleksandr Natalenko wrote:
> Hello.
> 
> On čtvrtek 1. února 2024 2:40:57 CET Boqun Feng wrote:
> > From: Zqiang <qiang.zhang1211@gmail.com>
> > 
> > For the kernels built with CONFIG_RCU_NOCB_CPU_DEFAULT_ALL=y and
> > CONFIG_RCU_LAZY=y, the following scenarios will trigger WARN_ON_ONCE()
> > in the rcu_nocb_bypass_lock() and rcu_nocb_wait_contended() functions:
> > 
> >         CPU2                                               CPU11
> > kthread
> > rcu_nocb_cb_kthread                                       ksys_write
> > rcu_do_batch                                              vfs_write
> > rcu_torture_timer_cb                                      proc_sys_write
> > __kmem_cache_free                                         proc_sys_call_handler
> > kmemleak_free                                             drop_caches_sysctl_handler
> > delete_object_full                                        drop_slab
> > __delete_object                                           shrink_slab
> > put_object                                                lazy_rcu_shrink_scan
> > call_rcu                                                  rcu_nocb_flush_bypass
> > __call_rcu_commn                                            rcu_nocb_bypass_lock
> >                                                             raw_spin_trylock(&rdp->nocb_bypass_lock) fail
> >                                                             atomic_inc(&rdp->nocb_lock_contended);
> > rcu_nocb_wait_contended                                     WARN_ON_ONCE(smp_processor_id() != rdp->cpu);
> >  WARN_ON_ONCE(atomic_read(&rdp->nocb_lock_contended))                                          |
> >                             |_ _ _ _ _ _ _ _ _ _same rdp and rdp->cpu != 11_ _ _ _ _ _ _ _ _ __|
> > 
> > Reproduce this bug with "echo 3 > /proc/sys/vm/drop_caches".
> > 
> > This commit therefore uses rcu_nocb_try_flush_bypass() instead of
> > rcu_nocb_flush_bypass() in lazy_rcu_shrink_scan().  If the nocb_bypass
> > queue is being flushed, then rcu_nocb_try_flush_bypass will return
> > directly.
> > 
> > Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
> > Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
> > Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
> > Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> > ---
> >  kernel/rcu/tree_nocb.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
> > index 9e8052ba14b9..ffa69a5e18f4 100644
> > --- a/kernel/rcu/tree_nocb.h
> > +++ b/kernel/rcu/tree_nocb.h
> > @@ -1391,7 +1391,7 @@ lazy_rcu_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
> >  			rcu_nocb_unlock_irqrestore(rdp, flags);
> >  			continue;
> >  		}
> > -		WARN_ON_ONCE(!rcu_nocb_flush_bypass(rdp, NULL, jiffies, false));
> > +		rcu_nocb_try_flush_bypass(rdp, jiffies);
> >  		rcu_nocb_unlock_irqrestore(rdp, flags);
> >  		wake_nocb_gp(rdp, false);
> >  		sc->nr_to_scan -= _count;
> > 
> 
> Does this fix [1] [2]?
> 
> Thank you.
> 
> [1] https://bugzilla.kernel.org/show_bug.cgi?id=217948
> [2] https://lore.kernel.org/lkml/8461340f-c7c8-4e1e-b7fa-a0e4b9a6c2a8@gmail.com/

It might, but why not apply it to the exact kernel version on which the
bug appeared and see if it prevents it?

							Thanx, Paul

