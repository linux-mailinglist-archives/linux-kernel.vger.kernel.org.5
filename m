Return-Path: <linux-kernel+bounces-75220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C99C085E4D5
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 18:45:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F089B24402
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 17:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E92FB85268;
	Wed, 21 Feb 2024 17:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vI/jrYjn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C822F69313
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 17:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708537459; cv=none; b=OuoETSj5Vzf9Illf2rkOU4NPqTlgMpChQcVO3kZTnVU9m1ca/jdGymX0oKDvOGxVctxI2sA96MNHSAEfgtD/JSIAu2yrm7f9kgq/IPSnyDR1xm+TsAqs6QdurMMOEyp7+uEuc06+AG7QodxogLo1ZvYyab967+pqdbsgJt2kh5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708537459; c=relaxed/simple;
	bh=LY/DCtjxBQ426cRUw5PWk34Xvm6uvkCfQ5vML6hCGJg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hPl8i61DsysG3F/0KguF6VNrOtaj+Ed/wheiKLGwsu9uII8B10hV3tw7cP5fq21Fx7aerdCnDLr3lUuylh7eueUKr8s/b+KZPoNh0PeKgjz2p0FKeH5HwtBGFEhoA8RH1cQcIGarBSPDxY2dm+Kg5J/5e5E2+k9dd5X+Dh7X7zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vI/jrYjn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E0A9C433F1;
	Wed, 21 Feb 2024 17:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708537459;
	bh=LY/DCtjxBQ426cRUw5PWk34Xvm6uvkCfQ5vML6hCGJg=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=vI/jrYjnuhrsVz+KzpUdrJeFycLTU5GUnwLCDHVqnTn5eieWD4pvIkXJNkscaa6F9
	 TVL4ppUDgRzdkyUg9kxPZu5x6IckAhDVlwbmmaFmvYkxMVxvxUzg9qQ24K+3UqJa+w
	 n/5B5KkA5yMzUd1mcUxNgEUiF+1f8/V6WtWDXdMkD4Oi9wXkbz5LbbKLXcvSft+kPh
	 0LpDOoVioIIeRuE1qrhZLTqCeWW5As/A83bzQL68m5iyxx3NfRNT5HGedH3u2At0mD
	 bEN4tN/eS6gD9jW7TWhC4CC73XZFLaDj6kPOCErHjAKDSfqwralLVFgcQSYeg4i7Y+
	 ifa/dgTFrU8tQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id D94A6CE15E3; Wed, 21 Feb 2024 09:44:18 -0800 (PST)
Date: Wed, 21 Feb 2024 09:44:18 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de, peterz@infradead.org,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	luto@kernel.org, bp@alien8.de, dave.hansen@linux.intel.com,
	hpa@zytor.com, mingo@redhat.com, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, willy@infradead.org, mgorman@suse.de,
	jpoimboe@kernel.org, mark.rutland@arm.com, jgross@suse.com,
	andrew.cooper3@citrix.com, bristot@kernel.org,
	mathieu.desnoyers@efficios.com, glaubitz@physik.fu-berlin.de,
	anton.ivanov@cambridgegreys.com, mattst88@gmail.com,
	krypton@ulrich-teichert.org, rostedt@goodmis.org,
	David.Laight@aculab.com, richard@nod.at, jon.grimm@amd.com,
	bharata@amd.com, boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Subject: Re: [PATCH 00/30] PREEMPT_AUTO: support lazy rescheduling
Message-ID: <7f00e799-a4ce-4fd0-896c-cc1fec3a5647@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <a7e785f8-d4c3-4b1b-9abe-36ac0b971e44@paulmck-laptop>
 <87le7mpjpr.fsf@oracle.com>
 <4e070ae0-29dc-41ee-aee6-0d3670304825@paulmck-laptop>
 <0d4a4eec-ce91-48da-91b6-1708a97edaeb@paulmck-laptop>
 <871q9dmndg.fsf@oracle.com>
 <9916c73f-510c-47a6-a9b4-ea6b438e82c0@paulmck-laptop>
 <87le7lkzj6.fsf@oracle.com>
 <4bc4ea06-e3e9-4d22-bacf-71cae0ba673d@paulmck-laptop>
 <0be4df28-99be-41a3-9e24-2b7cfc740b4a@paulmck-laptop>
 <87a5nugvna.fsf@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a5nugvna.fsf@oracle.com>

On Tue, Feb 20, 2024 at 10:48:41PM -0800, Ankur Arora wrote:
> Paul E. McKenney <paulmck@kernel.org> writes:
> > On Thu, Feb 15, 2024 at 06:59:25PM -0800, Paul E. McKenney wrote:
> >> On Thu, Feb 15, 2024 at 04:45:17PM -0800, Ankur Arora wrote:
> >> >
> >> > Paul E. McKenney <paulmck@kernel.org> writes:
> >> >
> >> > > On Thu, Feb 15, 2024 at 01:24:59PM -0800, Ankur Arora wrote:
> >> > >>
> >> > >> Paul E. McKenney <paulmck@kernel.org> writes:
> >> > >>
> >> > >> > On Wed, Feb 14, 2024 at 07:45:18PM -0800, Paul E. McKenney wrote:
> >> > >> >> On Wed, Feb 14, 2024 at 06:03:28PM -0800, Ankur Arora wrote:
> >> > >> >> >
> >> > >> >> > Paul E. McKenney <paulmck@kernel.org> writes:
> >> > >> >> >
> >> > >> >> > > On Mon, Feb 12, 2024 at 09:55:24PM -0800, Ankur Arora wrote:
> >> > >> >> > >> Hi,
> >> > >> >> > >>
> >> > >> >> > >> This series adds a new scheduling model PREEMPT_AUTO, which like
> >> > >> >> > >> PREEMPT_DYNAMIC allows dynamic switching between a none/voluntary/full
> >> > >> >> > >> preemption model. However, unlike PREEMPT_DYNAMIC, it doesn't depend
> >> > >> >> > >> on explicit preemption points for the voluntary models.
> >> > >> >> > >>
> >> > >> >> > >> The series is based on Thomas' original proposal which he outlined
> >> > >> >> > >> in [1], [2] and in his PoC [3].
> >> > >> >> > >>
> >> > >> >> > >> An earlier RFC version is at [4].
> >> > >> >> > >
> >> > >> >> > > This uncovered a couple of latent bugs in RCU due to its having been
> >> > >> >> > > a good long time since anyone built a !SMP preemptible kernel with
> >> > >> >> > > non-preemptible RCU.  I have a couple of fixes queued on -rcu [1], most
> >> > >> >> > > likely for the merge window after next, but let me know if you need
> >> > >> >> > > them sooner.
> >> > >> >> >
> >> > >> >> > Thanks. As you can probably tell, I skipped out on !SMP in my testing.
> >> > >> >> > But, the attached diff should tide me over until the fixes are in.
> >> > >> >>
> >> > >> >> That was indeed my guess.  ;-)
> >> > >> >>
> >> > >> >> > > I am also seeing OOM conditions during rcutorture testing of callback
> >> > >> >> > > flooding, but I am still looking into this.
> >> > >> >> >
> >> > >> >> > That's on the PREEMPT_AUTO && PREEMPT_VOLUNTARY configuration?
> >> > >> >>
> >> > >> >> On two of the PREEMPT_AUTO && PREEMPT_NONE configurations, but only on
> >> > >> >> two of them thus far.  I am running a longer test to see if this might
> >> > >> >> be just luck.  If not, I look to see what rcutorture scenarios TREE10
> >> > >> >> and TRACE01 have in common.
> >> > >> >
> >> > >> > And still TRACE01 and TREE10 are hitting OOMs, still not seeing what
> >> > >> > sets them apart.  I also hit a grace-period hang in TREE04, which does
> >> > >> > CONFIG_PREEMPT_VOLUNTARY=y along with CONFIG_PREEMPT_AUTO=y.  Something
> >> > >> > to dig into more.
> >> > >>
> >> > >> So, the only PREEMPT_VOLUNTARY=y configuration is TREE04. I wonder
> >> > >> if you would continue to hit the TREE04 hang with CONFIG_PREEMTP_NONE=y
> >> > >> as well?
> >> > >> (Just in the interest of minimizing configurations.)
> >> > >
> >> > > I would be happy to, but in the spirit of full disclosure...
> >> > >
> >> > > First, I have seen that failure only once, which is not enough to
> >> > > conclude that it has much to do with TREE04.  It might simply be low
> >> > > probability, so that TREE04 simply was unlucky enough to hit it first.
> >> > > In contrast, I have sufficient data to be reasonably confident that the
> >> > > callback-flooding OOMs really do have something to do with the TRACE01 and
> >> > > TREE10 scenarios, even though I am not yet seeing what these two scenarios
> >> > > have in common that they don't also have in common with other scenarios.
> >> > > But what is life without a bit of mystery?  ;-)
> >> >
> >> > :).
> >> >
> >> > > Second, please see the attached tarball, which contains .csv files showing
> >> > > Kconfig options and kernel boot parameters for the various torture tests.
> >> > > The portions of the filenames preceding the "config.csv" correspond to
> >> > > the directories in tools/testing/selftests/rcutorture/configs.
> >> >
> >> > So, at least some of the HZ_FULL=y tests don't run into problems.
> >> >
> >> > > Third, there are additional scenarios hand-crafted by the script at
> >> > > tools/testing/selftests/rcutorture/bin/torture.sh.  Thus far, none of
> >> > > them have triggered, other than via the newly increased difficulty
> >> > > of configurating a tracing-free kernel with which to test, but they
> >> > > can still be useful in ruling out particular Kconfig options or kernel
> >> > > boot parameters being related to a given issue.
> >> > >
> >> > > But please do take a look at the .csv files and let me know what
> >> > > adjustments would be appropriate given the failure information.
> >> >
> >> > Nothing stands out just yet. Let me start a run here and see if
> >> > that gives me some ideas.
> >>
> >> Sounds good, thank you!
> >>
> >> > I'm guessing the splats don't give any useful information or
> >> > you would have attached them ;).
> >>
> >> My plan is to extract what can be extracted from the overnight run
> >> that I just started.  Just in case the fixes have any effect on things,
> >> unlikely though that might be given those fixes and the runs that failed.
> >
> > And I only got no failures from either TREE10 or TRACE01 on last night's
> > run.  I merged your series on top of v6.8-rc4 with the -rcu tree's
> > dev branch, the latter to get the RCU fixes.  But this means that last
> > night's results are not really comparable to earlier results.
> 
> Not sure if you saw any othe instances of this since, but a couple of
> things I tbelatedly noticed below.

Thank you for taking a look!

> [ ...  ]
> 
> > [ 3459.733109] ------------[ cut here ]------------
> > [ 3459.734165] rcutorture_oom_notify invoked upon OOM during forward-progress testing.
> > [ 3459.735828] WARNING: CPU: 0 PID: 43 at kernel/rcu/rcutorture.c:2874 rcutorture_oom_notify+0x3e/0x1d0
> >
> > 	Now something bad happened.  RCU was unable to keep up with the
> > 	callback flood.  Given that users can create callback floods
> > 	with close(open()) loops, this is not good.
> >
> > [ 3459.737761] Modules linked in:
> > [ 3459.738408] CPU: 0 PID: 43 Comm: rcu_torture_fwd Not tainted 6.8.0-rc4-00096-g40c2642e6f24 #8252
> > [ 3459.740295] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
> > [ 3459.742651] RIP: 0010:rcutorture_oom_notify+0x3e/0x1d0
> > [ 3459.743821] Code: e8 37 48 c2 00 48 8b 1d f8 b4 dc 01 48 85 db 0f 84 80 01 00 00 90 48 c7 c6 40 f5 e0 92 48 c7 c7 10 52 23 93 e8 d3 b9 f9 ff 90 <0f> 0b 90 90 8b 35 f8 c0 66 01 85 f6 7e 40 45 31 ed 4d 63 e5 41 83
> > [ 3459.747935] RSP: 0018:ffffabbb0015bb30 EFLAGS: 00010282
> > [ 3459.749061] RAX: 0000000000000000 RBX: ffff9485812ae000 RCX: 00000000ffffdfff
> > [ 3459.750601] RDX: 0000000000000000 RSI: 00000000ffffffea RDI: 0000000000000001
> > [ 3459.752026] RBP: ffffabbb0015bb98 R08: ffffffff93539388 R09: 00000000ffffdfff
> > [ 3459.753616] R10: ffffffff934593a0 R11: ffffffff935093a0 R12: 0000000000000000
> > [ 3459.755134] R13: ffffabbb0015bb98 R14: ffffffff93547da0 R15: 00000000ffffffff
> > [ 3459.756695] FS:  0000000000000000(0000) GS:ffffffff9344f000(0000) knlGS:0000000000000000
> > [ 3459.758443] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [ 3459.759672] CR2: 0000000000600298 CR3: 0000000001958000 CR4: 00000000000006f0
> > [ 3459.761253] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > [ 3459.762748] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > [ 3459.764472] Call Trace:
> > [ 3459.765003]  <TASK>
> > [ 3459.765483]  ? __warn+0x61/0xe0
> > [ 3459.766176]  ? rcutorture_oom_notify+0x3e/0x1d0
> > [ 3459.767154]  ? report_bug+0x174/0x180
> > [ 3459.767942]  ? handle_bug+0x3d/0x70
> > [ 3459.768715]  ? exc_invalid_op+0x18/0x70
> > [ 3459.769561]  ? asm_exc_invalid_op+0x1a/0x20
> > [ 3459.770494]  ? rcutorture_oom_notify+0x3e/0x1d0
> > [ 3459.771501]  blocking_notifier_call_chain+0x5c/0x80
> > [ 3459.772553]  out_of_memory+0x236/0x4b0
> > [ 3459.773365]  __alloc_pages+0x9ca/0xb10
> > [ 3459.774233]  ? set_next_entity+0x8b/0x150
> > [ 3459.775107]  new_slab+0x382/0x430
> > [ 3459.776454]  ___slab_alloc+0x23c/0x8c0
> > [ 3459.777315]  ? preempt_schedule_irq+0x32/0x50
> > [ 3459.778319]  ? rcu_torture_fwd_prog+0x6bf/0x970
> > [ 3459.779291]  ? rcu_torture_fwd_prog+0x6bf/0x970
> > [ 3459.780264]  ? rcu_torture_fwd_prog+0x6bf/0x970
> > [ 3459.781244]  kmalloc_trace+0x179/0x1a0
> > [ 3459.784651]  rcu_torture_fwd_prog+0x6bf/0x970
> > [ 3459.785529]  ? __pfx_rcu_torture_fwd_prog+0x10/0x10
> > [ 3459.786617]  ? kthread+0xc3/0xf0
> > [ 3459.787352]  ? __pfx_rcu_torture_fwd_prog+0x10/0x10
> > [ 3459.788417]  kthread+0xc3/0xf0
> > [ 3459.789101]  ? __pfx_kthread+0x10/0x10
> > [ 3459.789906]  ret_from_fork+0x2f/0x50
> > [ 3459.790708]  ? __pfx_kthread+0x10/0x10
> > [ 3459.791523]  ret_from_fork_asm+0x1a/0x30
> > [ 3459.792359]  </TASK>
> > [ 3459.792835] ---[ end trace 0000000000000000 ]---
> >
> > 	Standard rcutorture stack trace for this failure mode.
> 
> I see a preempt_schedule_irq() in the stack. So, I guess that at some
> point current (the task responsible for the callback flood?) was marked
> for lazy scheduling, did not schedule out, and then was eagerly
> preempted out at the next tick.

That is expected, given that the kthread doing the callback flooding
will run for up to eight seconds.

Some instrumentation shows grace periods waiting on tasks, but that
instrumentation is later than would be good, after the barrier operation.

> > [ 3459.793849] rcu_torture_fwd_cb_hist: Callback-invocation histogram 0 (duration 913 jiffies): 1s/10: 0:1 2s/10: 719677:32517 3s/10: 646965:0
> >
> > 	So the whole thing lasted less than a second (913 jiffies).
> > 	Each element of the histogram is 100 milliseconds worth.  Nothing
> > 	came through during the first 100 ms (not surprising), and one
> > 	grace period elapsed (also not surprising).  A lot of callbacks
> > 	came through in the second 100 ms (also not surprising), but there
> > 	were some tens of thousand grace periods (extremely surprising).
> > 	The third 100 ms got a lot of callbacks but no grace periods
> > 	(not surprising).
> >
> > 	Huh.  This started at t=3458.877155 and we got the OOM at
> > 	t=3459.733109, which roughly matches the reported time.
> >
> > [ 3459.796413] rcu: rcu_fwd_progress_check: GP age 737 jiffies
> >
> > 	The callback flood does seem to have stalled grace periods,
> > 	though not by all *that* much.
> >
> > [ 3459.799402] rcu: rcu_preempt: wait state: RCU_GP_WAIT_FQS(5) ->state: 0x402 ->rt_priority 0 delta ->gp_start 740 ->gp_activity 0 ->gp_req_activity 747 ->gp_wake_time 68 ->gp_wake_seq 5535689 ->gp_seq 5535689 ->gp_seq_needed 5535696 ->gp_max 713 ->gp_flags 0x0
> >
> > 	The RCU grace-period kthread is in its loop looking for
> > 	quiescent states, and is executing normally ("->gp_activity 0",
> > 	as opposed to some huge number indicating that the kthread was
> > 	never awakened).
> >
> > [ 3459.804267] rcu:     rcu_node 0:0 ->gp_seq 5535689 ->gp_seq_needed 5535696 ->qsmask 0x0 ...G ->n_boosts 0
> >
> > 	The "->qsmask 0x0" says that all CPUs have provided a quiescent
> > 	state, but the "G" indicates that the normal grace period is
> > 	blocked by some task preempted within an RCU read-side critical
> > 	section.  This output is strange because a 56-CPU scenario should
> > 	have considerably more output.
> >
> > 	Plus this means that this cannot possibly be TREE10 because that
> > 	scenario is non-preemptible, so there cannot be grace periods
> > 	waiting for quiescent states on anything but CPUs.
> 
> Might be missing the point, but with CONFIG_PREEMPT_NONE, you could
> be preempted if you exceed your time quanta by more than one tick.
> Though that of course needs the task to not be in the read-side critical
> section.

I have three things on my list: (1) Improve the instrumentation so that it
captures the grace-period diagnostics periodically in a list of strings,
then prints them only if something bad happened, (2) Use bisection
to work out which commit instigates this behavior, and (3) that old
fallback, code inspection.

Other thoughts?

							Thanx, Paul

