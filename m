Return-Path: <linux-kernel+bounces-110049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D19D88595B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 13:48:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70E601F211A8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 12:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6045A83CC3;
	Thu, 21 Mar 2024 12:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H81E0HtB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BCCB83CB4
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 12:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711025282; cv=none; b=eVaR/ohywn6fP/NH9DZX6ShBnhbEWfrLYbr2G5ftbFrq+KRYTZj8Aii0Ka18wArj1Ad9/0zpKQgs7mgomJJsLn9WMxEJwAooAyI6zkNoIYbjt25i/iHLbP/SsUibfg0MiWjJsgWQ9hdK3v6GbmxE6Db2jQMxJB0iP0ueqOjNCzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711025282; c=relaxed/simple;
	bh=JsZYot1fWnRjbpWGZrt4rlGYKJXjiK3HdEc1worcLYc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mkmY107gsUpMs/YPzfdYiWDUU42mrLmpjVNFPmZ3ia7MH29yJK6gOGcOASzBd9gn1arzZ32N3Cd6LgH26oW2OmYd5r4KzsHIdZpwVh1tP46C9YK3/CcQiHkQt0k87y1lum8sScSvmvR+ehSlHyavdSvva88g2myLywK2jIKg5QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H81E0HtB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A402C433F1;
	Thu, 21 Mar 2024 12:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711025282;
	bh=JsZYot1fWnRjbpWGZrt4rlGYKJXjiK3HdEc1worcLYc=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=H81E0HtBaSA/Dxa6l0afpEgLCumcSC0+6ondIvpXdPiMCrg7QZAs2TI/cfzCnWtzg
	 ERda5Eov/heg4l415Sdp9Vfawatm5OdEQ9jNFGQn71X00MQVHuZYTnLQAu/kg5gY4i
	 Qgfvmt/6Dh29gvuKOIK5ZPxrccaeeEMz3Nj0O4tWUmMbw7Ef5FxzMidLwXBW2tZf8h
	 G+xOGG76RM85cjk6sZoSXsrK1zwTg8RA4jHoiT3CqlHJNbpk4ckwdNkyamVFZilRFi
	 +hLQgrhO/RH/zIkCVg+G44LY50JzOWxeQvT2on/H9ZqsqoKl9BoSfB08rbZTgZrirs
	 7od7OTlgX3IFg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 1A721CE0F1D; Thu, 21 Mar 2024 05:47:59 -0700 (PDT)
Date: Thu, 21 Mar 2024 05:47:59 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: Re: [PATCH 2/2] timers: Fix removed self-IPI on global timer's
 enqueue in nohz_full
Message-ID: <bf8689c2-0749-47cb-9535-53cf66e34f5e@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240318230729.15497-1-frederic@kernel.org>
 <20240318230729.15497-3-frederic@kernel.org>
 <464f6be2-4a72-440d-be53-6a1035d56a4f@paulmck-laptop>
 <1b5752c8-ef32-4ed4-b539-95d507ec99ce@paulmck-laptop>
 <ZfsLtMijRrNZfqh6@localhost.localdomain>
 <6a95b6ac-6681-4492-b155-e30c19bb3341@paulmck-laptop>
 <ZfwdEROGFFmIbkCM@lothringen>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZfwdEROGFFmIbkCM@lothringen>

On Thu, Mar 21, 2024 at 12:42:09PM +0100, Frederic Weisbecker wrote:
> On Wed, Mar 20, 2024 at 03:55:17PM -0700, Paul E. McKenney wrote:
> > On Wed, Mar 20, 2024 at 05:15:48PM +0100, Frederic Weisbecker wrote:
> > > Le Wed, Mar 20, 2024 at 04:14:24AM -0700, Paul E. McKenney a écrit :
> > > > On Tue, Mar 19, 2024 at 02:18:00AM -0700, Paul E. McKenney wrote:
> > > > > On Tue, Mar 19, 2024 at 12:07:29AM +0100, Frederic Weisbecker wrote:
> > > > > > While running in nohz_full mode, a task may enqueue a timer while the
> > > > > > tick is stopped. However the only places where the timer wheel,
> > > > > > alongside the timer migration machinery's decision, may reprogram the
> > > > > > next event accordingly with that new timer's expiry are the idle loop or
> > > > > > any IRQ tail.
> > > > > > 
> > > > > > However neither the idle task nor an interrupt may run on the CPU if it
> > > > > > resumes busy work in userspace for a long while in full dynticks mode.
> > > > > > 
> > > > > > To solve this, the timer enqueue path raises a self-IPI that will
> > > > > > re-evaluate the timer wheel on its IRQ tail. This asynchronous solution
> > > > > > avoids potential locking inversion.
> > > > > > 
> > > > > > This is supposed to happen both for local and global timers but commit:
> > > > > > 
> > > > > > 	b2cf7507e186 ("timers: Always queue timers on the local CPU")
> > > > > > 
> > > > > > broke the global timers case with removing the ->is_idle field handling
> > > > > > for the global base. As a result, global timers enqueue may go unnoticed
> > > > > > in nohz_full.
> > > > > > 
> > > > > > Fix this with restoring the idle tracking of the global timer's base,
> > > > > > allowing self-IPIs again on enqueue time.
> > > > > 
> > > > > Testing with the previous patch (1/2 in this series) reduced the number of
> > > > > problems by about an order of magnitude, down to two sched_tick_remote()
> > > > > instances and one enqueue_hrtimer() instance, very good!
> > > > > 
> > > > > I have kicked off a test including this patch.  Here is hoping!  ;-)
> > > > 
> > > > And 22*100 hours of TREE07 got me one run with a sched_tick_remote()
> > 
> > Sigh.  s/22/12/
> > 
> > > > complaint and another run with a starved RCU grace-period kthread.
> > > > So this is definitely getting more reliable, but still a little ways
> > > > to go.
> > 
> > An additional eight hours got anohtre sched_tick_remote().
> > 
> > > Right, there is clearly something else. Investigation continues...
> > 
> > Please let me know if there is a debug patch that I could apply.
> 
> So there are three things:
> 
> _ The sched_tick_remote() warning. I can easily trigger this one and while
>   trying a bisection, I realize it actually also triggers on v6.8
>   I'm not really tempted to investigate further because the warning doesn't make
>   much sense to me. This computes the delta between the time the kworker got
>   scheduled and the time it reaches the middle of the work. It happens to be
>   ~3s but isn't it something to be expected with jitter and all involved into
>   rcutorture?
> 
>   We should probably just remove this warning. This remote tick is my most horrible
>   hackery anyway.

Would it make sense to increase it to somewhere around the timeout for
RCU CPU stall warnings, softlockup, and so on?

> _ The hrtimer enqueue to an offline CPU warning:
> 
> 	[ 1054.265335] WARNING: CPU: 8 PID: 150 at kernel/time/hrtimer.c:1091 enqueue_hrtimer+0x6f/0x80
> 	[ 1054.269166] Modules linked in:
> 	[ 1054.270077] CPU: 8 PID: 150 Comm: rcu_torture_rea Not tainted 6.8.0-11407-ge990136580ab-dirty #21
> 	[ 1054.272768] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.2-3-gd478f380-rebuilt.opensuse.org 04/01/2014
> 	[ 1054.275893] RIP: 0010:enqueue_hrtimer+0x6f/0x80
> 	[ 1054.277252] Code: a3 05 b5 ff b7 01 73 bd 48 8b 05 44 c5 b5 01 48 85 c0 74 0c 48 8b 78 08 48 89 ee e8 7b b5 ff ff 48 8b 03 f6 40 10 10 75 a5 90 <0f> 0b 90 eb 9f 66 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90
> 	[ 1054.282448] RSP: 0000:ffffb1480056fd70 EFLAGS: 00010046
> 	[ 1054.283931] RAX: ffff95b7df2616c0 RBX: ffff95b7df261700 RCX: ffff95b7df2616c0
> 	[ 1054.286091] RDX: 0000000000000001 RSI: ffff95b7df261700 RDI: ffffb1480056fde0
> 	[ 1054.288095] RBP: ffffb1480056fde0 R08: 0000000000000001 R09: 000000000000fc03
> 	[ 1054.290189] R10: 0000000000000001 R11: ffff95b7c1271c80 R12: 0000000000000040
> 	[ 1054.292592] R13: ffff95b7df261700 R14: ffff95b7df261700 R15: ffff95b7df2616c0
> 	[ 1054.294622] FS:  0000000000000000(0000) GS:ffff95b7df400000(0000) knlGS:0000000000000000
> 	[ 1054.296884] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> 	[ 1054.298497] CR2: 0000000000000000 CR3: 000000001822c000 CR4: 00000000000006f0
> 	[ 1054.300475] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> 	[ 1054.302516] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> 	[ 1054.304580] Call Trace:
> 	[ 1054.305354]  <TASK>
> 	[ 1054.306009]  ? __warn+0x77/0x120
> 	[ 1054.306973]  ? enqueue_hrtimer+0x6f/0x80
> 	[ 1054.308177]  ? report_bug+0xf1/0x1d0
> 	[ 1054.310200]  ? handle_bug+0x40/0x70
> 	[ 1054.311252]  ? exc_invalid_op+0x13/0x70
> 	[ 1054.312437]  ? asm_exc_invalid_op+0x16/0x20
> 	[ 1054.313738]  ? enqueue_hrtimer+0x6f/0x80
> 	[ 1054.314994]  hrtimer_start_range_ns+0x258/0x2f0
> 	[ 1054.316531]  ? __pfx_rcu_torture_reader+0x10/0x10
> 	[ 1054.317983]  schedule_hrtimeout_range_clock+0x95/0x120
> 	[ 1054.319604]  ? __pfx_hrtimer_wakeup+0x10/0x10
> 	[ 1054.320957]  torture_hrtimeout_ns+0x50/0x70
> 	[ 1054.322211]  rcu_torture_reader+0x1be/0x280
> 	[ 1054.323455]  ? __pfx_rcu_torture_timer+0x10/0x10
> 	[ 1054.329888]  ? kthread+0xc4/0xf0
> 	[ 1054.330880]  ? __pfx_rcu_torture_reader+0x10/0x10
> 	[ 1054.332334]  kthread+0xc4/0xf0
> 	[ 1054.333305]  ? __pfx_kthread+0x10/0x10
> 	[ 1054.334466]  ret_from_fork+0x2b/0x40
> 	[ 1054.335551]  ? __pfx_kthread+0x10/0x10
> 	[ 1054.336690]  ret_from_fork_asm+0x1a/0x30
> 	[ 1054.337878]  </TASK>
> 
>   I don't know how it happened. This is where I'm investigating now.

It seems that rcutorture is the gift that keeps on giving?  ;-)

> _ The RCU CPU Stall report. I strongly suspect the cause is the hrtimer
>   enqueue to an offline CPU. Let's solve that and we'll see if it still
>   triggers.

Sounds like a plan!

							Thanx, Paul

