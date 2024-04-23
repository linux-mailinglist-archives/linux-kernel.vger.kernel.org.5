Return-Path: <linux-kernel+bounces-155956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0854B8AFBB5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 00:28:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AA601C224A5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 22:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A7F814389D;
	Tue, 23 Apr 2024 22:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pT3cr/Bp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D97D85274
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 22:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713911332; cv=none; b=P21nE1ekQ1/68HrYzvmt0TW53hNZAVKbO8r+LweZ86suY1T4qgKMnGfuE3LB+B+u50LuUB4cd2+hOYS8w/bf4UPaOjp3WDNOnlxooTYbmSzAupvtPbhnW70j7rO6SyR0A4XQpK4S796zrnqzWT3bS1TFr45mlue2M7cKN/EhOT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713911332; c=relaxed/simple;
	bh=Smf0YUi9NGBseopnvhxZ9pzCNFEUTNZ5RF659bgElf4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XQ2Jh5lKU++OI0igsiCOzzRnvoAS/KWlYCn/xjxYEpRJRDGyjNZmWSz+WxvOpXqNPamwnlJfPNu/cP8Gh/HG6G5eSE9ANkm6qL9S5E/9ED7mIq53I86j7Fv2fLKVgvjW8pOevNBqPlCvpGPEoQM/uo69+pWSc3QlwhZ8FqBC9Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pT3cr/Bp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CC42C116B1;
	Tue, 23 Apr 2024 22:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713911332;
	bh=Smf0YUi9NGBseopnvhxZ9pzCNFEUTNZ5RF659bgElf4=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=pT3cr/BpI9fJXm4Qa832D0PSY/sgZxHItlthFSvHVDo1rjuvGzfnwSYjA8Lg860wH
	 D8H/ZTKmsvNjx89M8WhajFkoUA4dzhIRRgpb4CljVuVHmWf5wjwuXec1al1RyjVon9
	 msADxm2hIpTFRIq/ojxxJzFz3Qv0Y78G8yH31Vtk5brOnAXIC1bw9J+b9IBmZ215Jx
	 WGCQhdDvUG3epMw6VANYNSgJnMF1te9oCIdofr9+MOosLCfABOmOZlPqiESlMW8RWb
	 jDvcuhbgA6LzuvrnbhvBywsG1eGeWDFahsgd0awSZdVQODOJ8EBetM/wpsc4N2IJxD
	 mMdvK6T9krP8Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id A6590CE0962; Tue, 23 Apr 2024 15:28:51 -0700 (PDT)
Date: Tue, 23 Apr 2024 15:28:51 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Z qiang <qiang.zhang1211@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	syzbot <syzbot+dce04ed6d1438ad69656@syzkaller.appspotmail.com>,
	linux-kernel@vger.kernel.org, peterz@infradead.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [kernel?] WARNING: suspicious RCU usage in __do_softirq
Message-ID: <b735d174-8ad9-4ace-86ee-75dc09852537@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <CALm+0cWx1kYtftE4nj7Jjgx2_bmNmSrBAgd36ksSvxJtNVhxHg@mail.gmail.com>
 <CALm+0cWRC1kqLJvmEqda4O97PZ-n0R0UQ35=fi6oA3rLsPoUSQ@mail.gmail.com>
 <8f281a10-b85a-4586-9586-5bbc12dc784f@paulmck-laptop>
 <CALm+0cWN0+cCsYddBUefya3aUw9c9Xn89GVV=Ys1_UPjS19WrQ@mail.gmail.com>
 <4c09abb6-4f6e-42d7-9944-c5da995649cb@paulmck-laptop>
 <CALm+0cVaLfE2ieK9aqh9yHkPDyO7zWbMe9K6WjTUgm4t9SnSFQ@mail.gmail.com>
 <ac7bf2c3-c752-46db-a5c8-0c55a1af8561@paulmck-laptop>
 <CALm+0cXGBPWxiNOkAoQG4hdnKCeVVR-APbfBPk9OGeU2RW+bKA@mail.gmail.com>
 <87o7a1umj3.ffs@tglx>
 <CALm+0cUesD9KaWyfsRUyGdErbrU11sAfRgRR=Qjyz7Boq9Vt=g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALm+0cUesD9KaWyfsRUyGdErbrU11sAfRgRR=Qjyz7Boq9Vt=g@mail.gmail.com>

On Tue, Apr 23, 2024 at 10:20:49AM +0800, Z qiang wrote:
> >
> > On Fri, Apr 19 2024 at 13:50, Z qiang wrote:
> > >> On Thu, Apr 18, 2024 at 05:49:38PM +0800, Z qiang wrote:
> > >  static __init int spawn_ksoftirqd(void)
> > >  {
> > > +       int cpu;
> > > +
> > > +       for_each_possible_cpu(cpu)
> > > +               per_cpu(ksoftirqd_work, cpu) = false;
> >
> > First of all that initialization is pointless, but why making all of
> > this complex as hell?
> >
> > Thanks,
> >
> >         tglx
> > ---
> > diff --git a/kernel/softirq.c b/kernel/softirq.c
> > index b315b21fb28c..e991d735be0d 100644
> > --- a/kernel/softirq.c
> > +++ b/kernel/softirq.c
> > @@ -508,7 +508,7 @@ static inline bool lockdep_softirq_start(void) { return false; }
> >  static inline void lockdep_softirq_end(bool in_hardirq) { }
> >  #endif
> >
> > -asmlinkage __visible void __softirq_entry __do_softirq(void)
> > +static void handle_softirqs(bool kirqd)
> >  {
> >         unsigned long end = jiffies + MAX_SOFTIRQ_TIME;
> >         unsigned long old_flags = current->flags;
> > @@ -563,8 +563,7 @@ asmlinkage __visible void __softirq_entry __do_softirq(void)
> >                 pending >>= softirq_bit;
> >         }
> >
> > -       if (!IS_ENABLED(CONFIG_PREEMPT_RT) &&
> > -           __this_cpu_read(ksoftirqd) == current)
> > +       if (!IS_ENABLED(CONFIG_PREEMPT_RT) && kirqd)
> >                 rcu_softirq_qs();
> >
> >         local_irq_disable();
> > @@ -584,6 +583,11 @@ asmlinkage __visible void __softirq_entry __do_softirq(void)
> >         current_restore_flags(old_flags, PF_MEMALLOC);
> >  }
> >
> > +asmlinkage __visible void __softirq_entry __do_softirq(void)
> > +{
> > +       handle_softirqs(false);
> > +}
> > +
> >  /**
> >   * irq_enter_rcu - Enter an interrupt context with RCU watching
> >   */
> > @@ -921,7 +925,7 @@ static void run_ksoftirqd(unsigned int cpu)
> >                  * We can safely run softirq on inline stack, as we are not deep
> >                  * in the task stack here.
> >                  */
> > -               __do_softirq();
> > +               handle_softirqs(true);
> 
> Thanks, this is good for me :),
> Paul, what do you think?

This looks quite nice to me, especially given that it avoids changing
all the other calls to __do_softirq().  Some architectures might want
to directly call handle_softirqs(), but if so, they can send the patches.

							Thanx, Paul

> Thanks
> Zqiang
> 
> >                 ksoftirqd_run_end();
> >                 cond_resched();
> >                 return;

