Return-Path: <linux-kernel+bounces-69589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F0F8858C0D
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 01:56:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2330282B91
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 00:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64B27BA55;
	Sat, 17 Feb 2024 00:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JVS2r22t"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F93D149E08
	for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 00:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708131365; cv=none; b=ad5vYvBGcbhXfHttAiC/n7BH72zol5R59eXsBnpZrrYNtObkwjOuSoj6HEZECEGfF020QlXCHZSc0sa4J/bS6uQm5PsWhIhS/5lCebExOCc1AVgTk+IduwIHGu450Q9dl1TdeijrNyM45bj2qboy27ZJiQlzTCO1wL55fGAclas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708131365; c=relaxed/simple;
	bh=IQvKkppJnpp7En7ryfZlp1k7EhW923PR3EO+Gd8lOCA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eNVciMg8OyzPIsN3ncCeq2eCzV59FK/AsZwlQacoxZakSjh4I06m3l2/nKrk3yU3F27Ay8d/O57Td+ke121tYPo3nNKl6Uko4+7wGGMhRnGkASzeYjeb0ksQB/AjGP+TK6/FRHQS4UAKSN+3lZmBNm0aeEDz6V0mNssj0fysAkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JVS2r22t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B07ABC433C7;
	Sat, 17 Feb 2024 00:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708131364;
	bh=IQvKkppJnpp7En7ryfZlp1k7EhW923PR3EO+Gd8lOCA=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=JVS2r22tB1slrc7lIgeucvLE0h0TbbicM1KW/2nRQaBMjkdrX5mDYlBZonX0YHuLr
	 ul/9Ld1GdDOukhLrUx3yGwShqZuh/bqNUE7hA1n1ROelaw5L2aEOSC3a0ngKBOGYiL
	 JpYGiqp+fDhjYwlyy1a8+8uwc3hlbVi7tov5OAYmwsKUH4CUNCv1PMnvTnVwk2wT+t
	 kKLcxgKqZ7CILcPjqsY1OOe+YwNQguqHyizkxlS19AEIj1L4b3J14oSMSXmawZyI8G
	 HEVazkUzbL9bciSyuDBLM7aptUcz75REVqeyfo4ZJUJd/2JMbjHChTjtnbD54i9QAd
	 Q/6K4mRxBn1PA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 31C99CE0FF5; Fri, 16 Feb 2024 16:55:59 -0800 (PST)
Date: Fri, 16 Feb 2024 16:55:59 -0800
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
Message-ID: <0be4df28-99be-41a3-9e24-2b7cfc740b4a@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240213055554.1802415-1-ankur.a.arora@oracle.com>
 <a7e785f8-d4c3-4b1b-9abe-36ac0b971e44@paulmck-laptop>
 <87le7mpjpr.fsf@oracle.com>
 <4e070ae0-29dc-41ee-aee6-0d3670304825@paulmck-laptop>
 <0d4a4eec-ce91-48da-91b6-1708a97edaeb@paulmck-laptop>
 <871q9dmndg.fsf@oracle.com>
 <9916c73f-510c-47a6-a9b4-ea6b438e82c0@paulmck-laptop>
 <87le7lkzj6.fsf@oracle.com>
 <4bc4ea06-e3e9-4d22-bacf-71cae0ba673d@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4bc4ea06-e3e9-4d22-bacf-71cae0ba673d@paulmck-laptop>

On Thu, Feb 15, 2024 at 06:59:25PM -0800, Paul E. McKenney wrote:
> On Thu, Feb 15, 2024 at 04:45:17PM -0800, Ankur Arora wrote:
> > 
> > Paul E. McKenney <paulmck@kernel.org> writes:
> > 
> > > On Thu, Feb 15, 2024 at 01:24:59PM -0800, Ankur Arora wrote:
> > >>
> > >> Paul E. McKenney <paulmck@kernel.org> writes:
> > >>
> > >> > On Wed, Feb 14, 2024 at 07:45:18PM -0800, Paul E. McKenney wrote:
> > >> >> On Wed, Feb 14, 2024 at 06:03:28PM -0800, Ankur Arora wrote:
> > >> >> >
> > >> >> > Paul E. McKenney <paulmck@kernel.org> writes:
> > >> >> >
> > >> >> > > On Mon, Feb 12, 2024 at 09:55:24PM -0800, Ankur Arora wrote:
> > >> >> > >> Hi,
> > >> >> > >>
> > >> >> > >> This series adds a new scheduling model PREEMPT_AUTO, which like
> > >> >> > >> PREEMPT_DYNAMIC allows dynamic switching between a none/voluntary/full
> > >> >> > >> preemption model. However, unlike PREEMPT_DYNAMIC, it doesn't depend
> > >> >> > >> on explicit preemption points for the voluntary models.
> > >> >> > >>
> > >> >> > >> The series is based on Thomas' original proposal which he outlined
> > >> >> > >> in [1], [2] and in his PoC [3].
> > >> >> > >>
> > >> >> > >> An earlier RFC version is at [4].
> > >> >> > >
> > >> >> > > This uncovered a couple of latent bugs in RCU due to its having been
> > >> >> > > a good long time since anyone built a !SMP preemptible kernel with
> > >> >> > > non-preemptible RCU.  I have a couple of fixes queued on -rcu [1], most
> > >> >> > > likely for the merge window after next, but let me know if you need
> > >> >> > > them sooner.
> > >> >> >
> > >> >> > Thanks. As you can probably tell, I skipped out on !SMP in my testing.
> > >> >> > But, the attached diff should tide me over until the fixes are in.
> > >> >>
> > >> >> That was indeed my guess.  ;-)
> > >> >>
> > >> >> > > I am also seeing OOM conditions during rcutorture testing of callback
> > >> >> > > flooding, but I am still looking into this.
> > >> >> >
> > >> >> > That's on the PREEMPT_AUTO && PREEMPT_VOLUNTARY configuration?
> > >> >>
> > >> >> On two of the PREEMPT_AUTO && PREEMPT_NONE configurations, but only on
> > >> >> two of them thus far.  I am running a longer test to see if this might
> > >> >> be just luck.  If not, I look to see what rcutorture scenarios TREE10
> > >> >> and TRACE01 have in common.
> > >> >
> > >> > And still TRACE01 and TREE10 are hitting OOMs, still not seeing what
> > >> > sets them apart.  I also hit a grace-period hang in TREE04, which does
> > >> > CONFIG_PREEMPT_VOLUNTARY=y along with CONFIG_PREEMPT_AUTO=y.  Something
> > >> > to dig into more.
> > >>
> > >> So, the only PREEMPT_VOLUNTARY=y configuration is TREE04. I wonder
> > >> if you would continue to hit the TREE04 hang with CONFIG_PREEMTP_NONE=y
> > >> as well?
> > >> (Just in the interest of minimizing configurations.)
> > >
> > > I would be happy to, but in the spirit of full disclosure...
> > >
> > > First, I have seen that failure only once, which is not enough to
> > > conclude that it has much to do with TREE04.  It might simply be low
> > > probability, so that TREE04 simply was unlucky enough to hit it first.
> > > In contrast, I have sufficient data to be reasonably confident that the
> > > callback-flooding OOMs really do have something to do with the TRACE01 and
> > > TREE10 scenarios, even though I am not yet seeing what these two scenarios
> > > have in common that they don't also have in common with other scenarios.
> > > But what is life without a bit of mystery?  ;-)
> > 
> > :).
> > 
> > > Second, please see the attached tarball, which contains .csv files showing
> > > Kconfig options and kernel boot parameters for the various torture tests.
> > > The portions of the filenames preceding the "config.csv" correspond to
> > > the directories in tools/testing/selftests/rcutorture/configs.
> > 
> > So, at least some of the HZ_FULL=y tests don't run into problems.
> > 
> > > Third, there are additional scenarios hand-crafted by the script at
> > > tools/testing/selftests/rcutorture/bin/torture.sh.  Thus far, none of
> > > them have triggered, other than via the newly increased difficulty
> > > of configurating a tracing-free kernel with which to test, but they
> > > can still be useful in ruling out particular Kconfig options or kernel
> > > boot parameters being related to a given issue.
> > >
> > > But please do take a look at the .csv files and let me know what
> > > adjustments would be appropriate given the failure information.
> > 
> > Nothing stands out just yet. Let me start a run here and see if
> > that gives me some ideas.
> 
> Sounds good, thank you!
> 
> > I'm guessing the splats don't give any useful information or
> > you would have attached them ;).
> 
> My plan is to extract what can be extracted from the overnight run
> that I just started.  Just in case the fixes have any effect on things,
> unlikely though that might be given those fixes and the runs that failed.

And I only got no failures from either TREE10 or TRACE01 on last night's
run.  I merged your series on top of v6.8-rc4 with the -rcu tree's
dev branch, the latter to get the RCU fixes.  But this means that last
night's results are not really comparable to earlier results.

I did get a few TREE09 failures, but I get those anyway.  I took it
apart below for you because I got confused and thought that it was a
TREE10 failure.  So just in case you were curious what one of these
looks like and because I am too lazy to delete it.  ;-)

So from the viewpoint of moderate rcutorture testing, this series
looks good.  Woo hoo!!!

We did uncover a separate issue with Tasks RCU, which I will report on
in more detail separately.  However, this issue does not (repeat, *not*)
affect lazy preemption as such, but instead any attempt to remove all
of the cond_resched() invocations.

My next step is to try this on bare metal on a system configured as
is the fleet.  But good progress for a week!!!

							Thanx, Paul

------------------------------------------------------------------------

[ 3458.875819] rcu_torture_fwd_prog: Starting forward-progress test 0
[ 3458.877155] rcu_torture_fwd_prog_cr: Starting forward-progress test 0

	This says that rcutorture is starting a callback-flood
	forward-progress test.

[ 3459.252546] rcu-torture: rtc: 00000000ec445089 ver: 298757 tfle: 0 rta: 298758 rtaf: 0 rtf: 298747 rtmbe: 0 rtmbkf: 0/0 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 895741 barrier: 27715/27716:0 read-exits: 3984 nocb-toggles: 0:0
[ 3459.261545] rcu-torture: Reader Pipe:  363878289 159521 0 0 0 0 0 0 0 0 0
[ 3459.263883] rcu-torture: Reader Batch:  363126419 911391 0 0 0 0 0 0 0 0 0
[ 3459.267544] rcu-torture: Free-Block Circulation:  298757 298756 298754 298753 298752 298751 298750 298749 298748 298747 0

	These lines are just statistics that rcutorture prints out
	periodically.  Thus far, nothing bad happened.	This is one of a
	few SMP scenarios that does not do CPU hotplug.  But the TRACE01
	scenario does do CPU hotplug, so not likely a determining factor.
	Another difference is that TREE10 is the only scenario with more
	than 16 CPUs, but then again, TRACE01 has only five.

[ 3459.733109] ------------[ cut here ]------------
[ 3459.734165] rcutorture_oom_notify invoked upon OOM during forward-progress testing.
[ 3459.735828] WARNING: CPU: 0 PID: 43 at kernel/rcu/rcutorture.c:2874 rcutorture_oom_notify+0x3e/0x1d0

	Now something bad happened.  RCU was unable to keep up with the
	callback flood.  Given that users can create callback floods
	with close(open()) loops, this is not good.

[ 3459.737761] Modules linked in:
[ 3459.738408] CPU: 0 PID: 43 Comm: rcu_torture_fwd Not tainted 6.8.0-rc4-00096-g40c2642e6f24 #8252
[ 3459.740295] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
[ 3459.742651] RIP: 0010:rcutorture_oom_notify+0x3e/0x1d0
[ 3459.743821] Code: e8 37 48 c2 00 48 8b 1d f8 b4 dc 01 48 85 db 0f 84 80 01 00 00 90 48 c7 c6 40 f5 e0 92 48 c7 c7 10 52 23 93 e8 d3 b9 f9 ff 90 <0f> 0b 90 90 8b 35 f8 c0 66 01 85 f6 7e 40 45 31 ed 4d 63 e5 41 83
[ 3459.747935] RSP: 0018:ffffabbb0015bb30 EFLAGS: 00010282
[ 3459.749061] RAX: 0000000000000000 RBX: ffff9485812ae000 RCX: 00000000ffffdfff
[ 3459.750601] RDX: 0000000000000000 RSI: 00000000ffffffea RDI: 0000000000000001
[ 3459.752026] RBP: ffffabbb0015bb98 R08: ffffffff93539388 R09: 00000000ffffdfff
[ 3459.753616] R10: ffffffff934593a0 R11: ffffffff935093a0 R12: 0000000000000000
[ 3459.755134] R13: ffffabbb0015bb98 R14: ffffffff93547da0 R15: 00000000ffffffff
[ 3459.756695] FS:  0000000000000000(0000) GS:ffffffff9344f000(0000) knlGS:0000000000000000
[ 3459.758443] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 3459.759672] CR2: 0000000000600298 CR3: 0000000001958000 CR4: 00000000000006f0
[ 3459.761253] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 3459.762748] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[ 3459.764472] Call Trace:
[ 3459.765003]  <TASK>
[ 3459.765483]  ? __warn+0x61/0xe0
[ 3459.766176]  ? rcutorture_oom_notify+0x3e/0x1d0
[ 3459.767154]  ? report_bug+0x174/0x180
[ 3459.767942]  ? handle_bug+0x3d/0x70
[ 3459.768715]  ? exc_invalid_op+0x18/0x70
[ 3459.769561]  ? asm_exc_invalid_op+0x1a/0x20
[ 3459.770494]  ? rcutorture_oom_notify+0x3e/0x1d0
[ 3459.771501]  blocking_notifier_call_chain+0x5c/0x80
[ 3459.772553]  out_of_memory+0x236/0x4b0
[ 3459.773365]  __alloc_pages+0x9ca/0xb10
[ 3459.774233]  ? set_next_entity+0x8b/0x150
[ 3459.775107]  new_slab+0x382/0x430
[ 3459.776454]  ___slab_alloc+0x23c/0x8c0
[ 3459.777315]  ? preempt_schedule_irq+0x32/0x50
[ 3459.778319]  ? rcu_torture_fwd_prog+0x6bf/0x970
[ 3459.779291]  ? rcu_torture_fwd_prog+0x6bf/0x970
[ 3459.780264]  ? rcu_torture_fwd_prog+0x6bf/0x970
[ 3459.781244]  kmalloc_trace+0x179/0x1a0
[ 3459.784651]  rcu_torture_fwd_prog+0x6bf/0x970
[ 3459.785529]  ? __pfx_rcu_torture_fwd_prog+0x10/0x10
[ 3459.786617]  ? kthread+0xc3/0xf0
[ 3459.787352]  ? __pfx_rcu_torture_fwd_prog+0x10/0x10
[ 3459.788417]  kthread+0xc3/0xf0
[ 3459.789101]  ? __pfx_kthread+0x10/0x10
[ 3459.789906]  ret_from_fork+0x2f/0x50
[ 3459.790708]  ? __pfx_kthread+0x10/0x10
[ 3459.791523]  ret_from_fork_asm+0x1a/0x30
[ 3459.792359]  </TASK>
[ 3459.792835] ---[ end trace 0000000000000000 ]---

	Standard rcutorture stack trace for this failure mode.

[ 3459.793849] rcu_torture_fwd_cb_hist: Callback-invocation histogram 0 (duration 913 jiffies): 1s/10: 0:1 2s/10: 719677:32517 3s/10: 646965:0

	So the whole thing lasted less than a second (913 jiffies).
	Each element of the histogram is 100 milliseconds worth.  Nothing
	came through during the first 100 ms (not surprising), and one
	grace period elapsed (also not surprising).  A lot of callbacks
	came through in the second 100 ms (also not surprising), but there
	were some tens of thousand grace periods (extremely surprising).
	The third 100 ms got a lot of callbacks but no grace periods
	(not surprising).

	Huh.  This started at t=3458.877155 and we got the OOM at
	t=3459.733109, which roughly matches the reported time.

[ 3459.796413] rcu: rcu_fwd_progress_check: GP age 737 jiffies

	The callback flood does seem to have stalled grace periods,
	though not by all *that* much.

[ 3459.799402] rcu: rcu_preempt: wait state: RCU_GP_WAIT_FQS(5) ->state: 0x402 ->rt_priority 0 delta ->gp_start 740 ->gp_activity 0 ->gp_req_activity 747 ->gp_wake_time 68 ->gp_wake_seq 5535689 ->gp_seq 5535689 ->gp_seq_needed 5535696 ->gp_max 713 ->gp_flags 0x0

	The RCU grace-period kthread is in its loop looking for
	quiescent states, and is executing normally ("->gp_activity 0",
	as opposed to some huge number indicating that the kthread was
	never awakened).

[ 3459.804267] rcu:     rcu_node 0:0 ->gp_seq 5535689 ->gp_seq_needed 5535696 ->qsmask 0x0 ...G ->n_boosts 0

	The "->qsmask 0x0" says that all CPUs have provided a quiescent
	state, but the "G" indicates that the normal grace period is
	blocked by some task preempted within an RCU read-side critical
	section.  This output is strange because a 56-CPU scenario should
	have considerably more output.

	Plus this means that this cannot possibly be TREE10 because that
	scenario is non-preemptible, so there cannot be grace periods
	waiting for quiescent states on anything but CPUs.

	This happens from time to time because TREE09 runs on a single
	CPU, and has preemption enabled, but not RCU priority boosting.
	And this output is quite appropriate for a single-CPU scenario.

	I probably should enable RCU priority boosting on this scenario.
	I would also need it to be pretty fast off the mark, because we
	OOMed about 700 milliseconds into the grace period.

	But that has nothing to do with lazy preemption!

[ 3459.806271] rcu:     cpu 0 ->gp_seq_needed 5535692
[ 3459.807139] rcu: RCU callbacks invoked since boot: 65398010
[ 3459.808374] rcu: rcu_fwd_progress_check: callbacks 0: 7484262
[ 3459.809640] rcutorture_oom_notify: Freed 1 RCU callbacks.
[ 3460.616268] rcutorture_oom_notify: Freed 7484253 RCU callbacks.
[ 3460.619551] rcutorture_oom_notify: Freed 0 RCU callbacks.
[ 3460.620740] rcutorture_oom_notify returning after OOM processing.
[ 3460.622719] rcu_torture_fwd_prog_cr: Waiting for CBs: rcu_barrier+0x0/0x2c0() 0
[ 3461.678556] rcu_torture_fwd_prog_nr: Starting forward-progress test 0
[ 3461.684546] rcu_torture_fwd_prog_nr: Waiting for CBs: rcu_barrier+0x0/0x2c0() 0


