Return-Path: <linux-kernel+bounces-71704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 256E585A945
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 17:48:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A62041F210CF
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 16:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0267040BF2;
	Mon, 19 Feb 2024 16:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z01Qm+QH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA7DC23B9
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 16:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708361301; cv=none; b=o5rBkTAeysKVOIQNPdIOWrPN2el+81JHgsrYAl+uP8+9GZm9/16ScKssOHCUKTNFG8dOtBTqhe/ILl2193nAN9t+IUjFNf/dKqHcmQuEkVEwM/N1M3DGYScWnXX9/y0XRCA+nbXU0XBHrF+dRmdXe+/oVUN1zFUvU+VWmrZ2g3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708361301; c=relaxed/simple;
	bh=wSPw9UkCG99trlTdwwfeNfoqln4802f3EtTZElKyj28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fm2cRP/S9jLIcrMvMc4YD0ks+scXRLfftLHoJG1rXpa9dXtTDi1d7MerebumTjP3L9EgAc6yHHaEYWiDV8KTpl3QN8293mf5QoBagJq4CrTNRiW+gUWkt27nurQAhNskopqNRbR/iFauQxyu4JHEh5ONHL4CmgSKFh680jULmIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z01Qm+QH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C10A3C433F1;
	Mon, 19 Feb 2024 16:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708361300;
	bh=wSPw9UkCG99trlTdwwfeNfoqln4802f3EtTZElKyj28=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=Z01Qm+QHVpz35IUITrvufcGLJLn63xJhtzkGuXwQIQvXwP6RTljcmzowU81Y/qFbF
	 Ae4wFu7E66M3DG+JCDUm/CoyXEVIdVSNKF9UPLAc+gdJ3NLviCsR+xSRs51uXqgYeD
	 oVPdNXve3bKEIlNEhEQBT1CP2B6Nq3P4qdkeSWKeLCguiixHjLHXyTKNCBpKjF2zwa
	 nXZm3zSF435n7YXAUWALb7k8LzPphx9C8UqQsqT3kyKm543f+TyVVPZf+G1ELgQRGy
	 R60vZvyGe2NcAkai6y2qkm/R90yIoE5imlQ9tkKv6JgVndI2GlpE+TH/5rCZ4zpiv5
	 QE9OCgVCLd/Ew==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 6A644CE0D32; Mon, 19 Feb 2024 08:48:20 -0800 (PST)
Date: Mon, 19 Feb 2024 08:48:20 -0800
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
Message-ID: <2b735ba4-8081-4ddb-9397-4fe83143d97f@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <87le7mpjpr.fsf@oracle.com>
 <4e070ae0-29dc-41ee-aee6-0d3670304825@paulmck-laptop>
 <0d4a4eec-ce91-48da-91b6-1708a97edaeb@paulmck-laptop>
 <871q9dmndg.fsf@oracle.com>
 <9916c73f-510c-47a6-a9b4-ea6b438e82c0@paulmck-laptop>
 <87le7lkzj6.fsf@oracle.com>
 <4bc4ea06-e3e9-4d22-bacf-71cae0ba673d@paulmck-laptop>
 <0be4df28-99be-41a3-9e24-2b7cfc740b4a@paulmck-laptop>
 <87r0hbkafi.fsf@oracle.com>
 <7db5c057-8bd4-4209-8484-3a0f9f3cd02d@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7db5c057-8bd4-4209-8484-3a0f9f3cd02d@paulmck-laptop>

On Sun, Feb 18, 2024 at 10:17:48AM -0800, Paul E. McKenney wrote:
> On Fri, Feb 16, 2024 at 07:59:45PM -0800, Ankur Arora wrote:
> > Paul E. McKenney <paulmck@kernel.org> writes:
> > > On Thu, Feb 15, 2024 at 06:59:25PM -0800, Paul E. McKenney wrote:
> > >> On Thu, Feb 15, 2024 at 04:45:17PM -0800, Ankur Arora wrote:
> > >> >
> > >> > Paul E. McKenney <paulmck@kernel.org> writes:
> > >> >
> > >> > > On Thu, Feb 15, 2024 at 01:24:59PM -0800, Ankur Arora wrote:
> > >> > >>
> > >> > >> Paul E. McKenney <paulmck@kernel.org> writes:
> > >> > >>
> > >> > >> > On Wed, Feb 14, 2024 at 07:45:18PM -0800, Paul E. McKenney wrote:
> > >> > >> >> On Wed, Feb 14, 2024 at 06:03:28PM -0800, Ankur Arora wrote:
> > >> > >> >> >
> > >> > >> >> > Paul E. McKenney <paulmck@kernel.org> writes:
> > >> > >> >> >
> > >> > >> >> > > On Mon, Feb 12, 2024 at 09:55:24PM -0800, Ankur Arora wrote:
> > >> > >> >> > >> Hi,
> > >> > >> >> > >>
> > >> > >> >> > >> This series adds a new scheduling model PREEMPT_AUTO, which like
> > >> > >> >> > >> PREEMPT_DYNAMIC allows dynamic switching between a none/voluntary/full
> > >> > >> >> > >> preemption model. However, unlike PREEMPT_DYNAMIC, it doesn't depend
> > >> > >> >> > >> on explicit preemption points for the voluntary models.
> > >> > >> >> > >>
> > >> > >> >> > >> The series is based on Thomas' original proposal which he outlined
> > >> > >> >> > >> in [1], [2] and in his PoC [3].
> > >> > >> >> > >>
> > >> > >> >> > >> An earlier RFC version is at [4].
> > >> > >> >> > >
> > >> > >> >> > > This uncovered a couple of latent bugs in RCU due to its having been
> > >> > >> >> > > a good long time since anyone built a !SMP preemptible kernel with
> > >> > >> >> > > non-preemptible RCU.  I have a couple of fixes queued on -rcu [1], most
> > >> > >> >> > > likely for the merge window after next, but let me know if you need
> > >> > >> >> > > them sooner.
> > >> > >> >> >
> > >> > >> >> > Thanks. As you can probably tell, I skipped out on !SMP in my testing.
> > >> > >> >> > But, the attached diff should tide me over until the fixes are in.
> > >> > >> >>
> > >> > >> >> That was indeed my guess.  ;-)
> > >> > >> >>
> > >> > >> >> > > I am also seeing OOM conditions during rcutorture testing of callback
> > >> > >> >> > > flooding, but I am still looking into this.
> > >> > >> >> >
> > >> > >> >> > That's on the PREEMPT_AUTO && PREEMPT_VOLUNTARY configuration?
> > >> > >> >>
> > >> > >> >> On two of the PREEMPT_AUTO && PREEMPT_NONE configurations, but only on
> > >> > >> >> two of them thus far.  I am running a longer test to see if this might
> > >> > >> >> be just luck.  If not, I look to see what rcutorture scenarios TREE10
> > >> > >> >> and TRACE01 have in common.
> > >> > >> >
> > >> > >> > And still TRACE01 and TREE10 are hitting OOMs, still not seeing what
> > >> > >> > sets them apart.  I also hit a grace-period hang in TREE04, which does
> > >> > >> > CONFIG_PREEMPT_VOLUNTARY=y along with CONFIG_PREEMPT_AUTO=y.  Something
> > >> > >> > to dig into more.
> > >> > >>
> > >> > >> So, the only PREEMPT_VOLUNTARY=y configuration is TREE04. I wonder
> > >> > >> if you would continue to hit the TREE04 hang with CONFIG_PREEMTP_NONE=y
> > >> > >> as well?
> > >> > >> (Just in the interest of minimizing configurations.)
> > >> > >
> > >> > > I would be happy to, but in the spirit of full disclosure...
> > >> > >
> > >> > > First, I have seen that failure only once, which is not enough to
> > >> > > conclude that it has much to do with TREE04.  It might simply be low
> > >> > > probability, so that TREE04 simply was unlucky enough to hit it first.
> > >> > > In contrast, I have sufficient data to be reasonably confident that the
> > >> > > callback-flooding OOMs really do have something to do with the TRACE01 and
> > >> > > TREE10 scenarios, even though I am not yet seeing what these two scenarios
> > >> > > have in common that they don't also have in common with other scenarios.
> > >> > > But what is life without a bit of mystery?  ;-)
> > >> >
> > >> > :).
> > >> >
> > >> > > Second, please see the attached tarball, which contains .csv files showing
> > >> > > Kconfig options and kernel boot parameters for the various torture tests.
> > >> > > The portions of the filenames preceding the "config.csv" correspond to
> > >> > > the directories in tools/testing/selftests/rcutorture/configs.
> > >> >
> > >> > So, at least some of the HZ_FULL=y tests don't run into problems.
> > >> >
> > >> > > Third, there are additional scenarios hand-crafted by the script at
> > >> > > tools/testing/selftests/rcutorture/bin/torture.sh.  Thus far, none of
> > >> > > them have triggered, other than via the newly increased difficulty
> > >> > > of configurating a tracing-free kernel with which to test, but they
> > >> > > can still be useful in ruling out particular Kconfig options or kernel
> > >> > > boot parameters being related to a given issue.
> > >> > >
> > >> > > But please do take a look at the .csv files and let me know what
> > >> > > adjustments would be appropriate given the failure information.
> > >> >
> > >> > Nothing stands out just yet. Let me start a run here and see if
> > >> > that gives me some ideas.
> > >>
> > >> Sounds good, thank you!
> > >>
> > >> > I'm guessing the splats don't give any useful information or
> > >> > you would have attached them ;).
> > >>
> > >> My plan is to extract what can be extracted from the overnight run
> > >> that I just started.  Just in case the fixes have any effect on things,
> > >> unlikely though that might be given those fixes and the runs that failed.
> > >
> > > And I only got no failures from either TREE10 or TRACE01 on last night's
> > > run.
> > 
> > Oh that's great news. Same for my overnight runs for TREE04 and TRACE01.
> > 
> > Ongoing: a 24 hour run for those. Let's see how that goes.
> > 
> > > I merged your series on top of v6.8-rc4 with the -rcu tree's
> > > dev branch, the latter to get the RCU fixes.  But this means that last
> > > night's results are not really comparable to earlier results.
> > >
> > > I did get a few TREE09 failures, but I get those anyway.  I took it
> > > apart below for you because I got confused and thought that it was a
> > > TREE10 failure.  So just in case you were curious what one of these
> > > looks like and because I am too lazy to delete it.  ;-)
> > 
> > Heh. Well, thanks for being lazy /after/ dissecting it nicely.
> > 
> > > So from the viewpoint of moderate rcutorture testing, this series
> > > looks good.  Woo hoo!!!
> > 
> > Awesome!
> > 
> > > We did uncover a separate issue with Tasks RCU, which I will report on
> > > in more detail separately.  However, this issue does not (repeat, *not*)
> > > affect lazy preemption as such, but instead any attempt to remove all
> > > of the cond_resched() invocations.
> > 
> > So, that sounds like it happens even with (CONFIG_PREEMPT_AUTO=n,
> > CONFIG_PREEMPT=y)?
> > Anyway will look out for it when you go into the detail.
> 
> Fair point, normally Tasks RCU isn't present when cond_resched()
> means anything.
> 
> I will look again -- it is quite possible that I was confused by earlier
> in-fleet setups that had Tasks RCU enabled even when preemption was
> disabled.  (We don't do that anymore, and, had I been paying sufficient
> attention, would not have been doing it to start with.  Back in the day,
> enabling rcutorture, even as a module, had the side effect of enabling
> Tasks RCU.  How else to test it, right?  Well...)

OK, I got my head straight on this one...

And the problem is in fact that Tasks RCU isn't normally present
in non-preemptible kernels.  This is because normal RCU will wait
for preemption-disabled regions of code, and in PREMPT_NONE and
PREEMPT_VOLUNTARY kernels, that includes pretty much any region of code
lacking an explicit schedule() or similar.  And as I understand it,
tracing trampolines rely on this implicit lack of preemption.

So, with lazy preemption, we could preempt in the middle of a
trampoline, and synchronize_rcu() won't save us.

Steve and Mathieu will correct me if I am wrong.

If I do understand this correctly, one workaround is to remove the
"if PREEMPTIBLE" on all occurrences of "select TASKS_RCU".  That way,
all kernels would use synchronize_rcu_tasks(), which would wait for
a voluntary context switch.

This workaround does increase the overhead and tracepoint-removal
latency on non-preemptible kernels, so it might be time to revisit the
synchronization of trampolines.  Unfortunately, the things I have come
up with thus far have disadvantages:

o	Keep a set of permanent trampolines that enter and exit
	some sort of explicit RCU read-side critical section.
	If the address for this trampoline to call is in a register,
	then these permanent trampolines remain constant so that
	no synchronization of them is required.  The selected
	flavor of RCU can then be used to deal with the non-permanent
	trampolines.

	The disadvantage here is a significant increase in the complexity
	and overhead of trampoline code and the code that invokes the
	trampolines.  This overhead limits where tracing may be used
	in the kernel, which is of course undesirable.

o	Check for being preempted within a trampoline, and track this
	within the tasks structure.  The disadvantage here is that this
	requires keeping track of all of the trampolines and adding a
	check for being in one on a scheduler fast path.

o	Have a variant of Tasks RCU which checks the stack of preempted
	tasks, waiting until all have been seen without being preempted
	in a trampoline.  This still requires keeping track of all the
	trampolines in an easy-to-search manner, but gets the overhead
	of searching off of the scheduler fastpaths.

	It is also necessary to check running tasks, which might have
	been interrupted from within a trampoline.

	I would have a hard time convincing myself that these return
	addresses were unconditionally reliable.  But maybe they are?

o	Your idea here!

Again, the short-term workaround is to remove the "if PREEMPTIBLE" from
all of the "select TASKS_RCU" clauses.

> > > My next step is to try this on bare metal on a system configured as
> > > is the fleet.  But good progress for a week!!!
> > 
> > Yeah this is great. Fingers crossed for the wider set of tests.
> 
> I got what might be a one-off when hitting rcutorture and KASAN harder.
> I am running 320*TRACE01 to see if it reproduces.

[ . . . ]

> So, first see if it is reproducible, second enable more diagnostics,
> third make more grace-period sequence numbers available to rcutorture,
> fourth recheck the diagnostics code, and then see where we go from there.
> It might be that lazy preemption needs adjustment, or it might be that
> it just tickled latent diagnostic issues in rcutorture.
> 
> (I rarely hit this WARN_ON() except in early development, when the
> problem is usually glaringly obvious, hence all the uncertainty.)

And it is eminently reproducible.  Digging into it...

							Thanx, Paul

