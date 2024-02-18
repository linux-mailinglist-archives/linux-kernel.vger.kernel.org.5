Return-Path: <linux-kernel+bounces-70478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FEB2859872
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 19:17:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE5FC1F2157D
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 18:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 955F96F072;
	Sun, 18 Feb 2024 18:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mb2r4Xwf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDCA66EB7E
	for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 18:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708280270; cv=none; b=B/oCEe1QW/fX9CFf/RpOp+lneT4kRXWiMQZEWNy0SCHHjrt398OuQHGEWsJmsF8s1Anecc5Xno5KsWF8YvpU0M4H26VLxMzQPu09qm39NykhRoKgbMMUzI+L0cPMjlgYIOK89yMF9cHqT//45EkntoGqVmH6KxBgshLJy9LLWLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708280270; c=relaxed/simple;
	bh=nh3PhWzuHxTjy2y0Xw28lJ6suV9919lMaTOcUazN1Lw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Thmi4Zs/iRs0umSIC1yCEE+1VV5IE1EjeSVxnJ5sqVMkNaogZd2GmqI3iCM2vVEnnSeHz9QvEzT6J/pdipvaSMtLLreASogzDJO/RvabSTdPmcsQVocxwwZL7S3VyzDA3rizU4SCiZ7s6XXjXChc7UQ6tqaAGbKa+G3aUBGlZqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mb2r4Xwf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EB8EC433C7;
	Sun, 18 Feb 2024 18:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708280269;
	bh=nh3PhWzuHxTjy2y0Xw28lJ6suV9919lMaTOcUazN1Lw=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=Mb2r4Xwf6mj+OGIdWpjKyXZkhZa6adQf9Ks934h0Z3lwQkGRxk/Uaq6BTBO+TwaPz
	 sUjGcsUpuPXE5cDy1AofyYYIK0ppAR/J90uOTkCDHn/Sku9JViPPAIjmLKqH5OU2J+
	 NYl3lsV2AHA3wnR/V3s2r8QCOHeWSvSo+caJK3L9G1WMgvVm7ifi0qHCGFM1/WUEAy
	 Ymzy0J+c55kODGi/w7zSMzYlor8WjfAslnIJkzR3qgXGzVRgp2pKtBRmn6XrYDXuoI
	 AiuAGo33dRVJuSAEEgiz4IW9cMaAxLhqH6GSZpk2yV8anNgV5YkKpObs/TR3i6erP2
	 15p0dA8QgC5Qw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id C3564CE0CB0; Sun, 18 Feb 2024 10:17:48 -0800 (PST)
Date: Sun, 18 Feb 2024 10:17:48 -0800
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
Message-ID: <7db5c057-8bd4-4209-8484-3a0f9f3cd02d@paulmck-laptop>
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
 <87r0hbkafi.fsf@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <87r0hbkafi.fsf@oracle.com>

On Fri, Feb 16, 2024 at 07:59:45PM -0800, Ankur Arora wrote:
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
> >> > >> > On Wed, Feb 14, 2024 at 07:45:18PM -0800, Paul E. McKenney wrot=
e:
> >> > >> >> On Wed, Feb 14, 2024 at 06:03:28PM -0800, Ankur Arora wrote:
> >> > >> >> >
> >> > >> >> > Paul E. McKenney <paulmck@kernel.org> writes:
> >> > >> >> >
> >> > >> >> > > On Mon, Feb 12, 2024 at 09:55:24PM -0800, Ankur Arora wrot=
e:
> >> > >> >> > >> Hi,
> >> > >> >> > >>
> >> > >> >> > >> This series adds a new scheduling model PREEMPT_AUTO, whi=
ch like
> >> > >> >> > >> PREEMPT_DYNAMIC allows dynamic switching between a none/v=
oluntary/full
> >> > >> >> > >> preemption model. However, unlike PREEMPT_DYNAMIC, it doe=
sn't depend
> >> > >> >> > >> on explicit preemption points for the voluntary models.
> >> > >> >> > >>
> >> > >> >> > >> The series is based on Thomas' original proposal which he=
 outlined
> >> > >> >> > >> in [1], [2] and in his PoC [3].
> >> > >> >> > >>
> >> > >> >> > >> An earlier RFC version is at [4].
> >> > >> >> > >
> >> > >> >> > > This uncovered a couple of latent bugs in RCU due to its h=
aving been
> >> > >> >> > > a good long time since anyone built a !SMP preemptible ker=
nel with
> >> > >> >> > > non-preemptible RCU.  I have a couple of fixes queued on -=
rcu [1], most
> >> > >> >> > > likely for the merge window after next, but let me know if=
 you need
> >> > >> >> > > them sooner.
> >> > >> >> >
> >> > >> >> > Thanks. As you can probably tell, I skipped out on !SMP in m=
y testing.
> >> > >> >> > But, the attached diff should tide me over until the fixes a=
re in.
> >> > >> >>
> >> > >> >> That was indeed my guess.  ;-)
> >> > >> >>
> >> > >> >> > > I am also seeing OOM conditions during rcutorture testing =
of callback
> >> > >> >> > > flooding, but I am still looking into this.
> >> > >> >> >
> >> > >> >> > That's on the PREEMPT_AUTO && PREEMPT_VOLUNTARY configuratio=
n?
> >> > >> >>
> >> > >> >> On two of the PREEMPT_AUTO && PREEMPT_NONE configurations, but=
 only on
> >> > >> >> two of them thus far.  I am running a longer test to see if th=
is might
> >> > >> >> be just luck.  If not, I look to see what rcutorture scenarios=
 TREE10
> >> > >> >> and TRACE01 have in common.
> >> > >> >
> >> > >> > And still TRACE01 and TREE10 are hitting OOMs, still not seeing=
 what
> >> > >> > sets them apart.  I also hit a grace-period hang in TREE04, whi=
ch does
> >> > >> > CONFIG_PREEMPT_VOLUNTARY=3Dy along with CONFIG_PREEMPT_AUTO=3Dy=
=2E  Something
> >> > >> > to dig into more.
> >> > >>
> >> > >> So, the only PREEMPT_VOLUNTARY=3Dy configuration is TREE04. I won=
der
> >> > >> if you would continue to hit the TREE04 hang with CONFIG_PREEMTP_=
NONE=3Dy
> >> > >> as well?
> >> > >> (Just in the interest of minimizing configurations.)
> >> > >
> >> > > I would be happy to, but in the spirit of full disclosure...
> >> > >
> >> > > First, I have seen that failure only once, which is not enough to
> >> > > conclude that it has much to do with TREE04.  It might simply be l=
ow
> >> > > probability, so that TREE04 simply was unlucky enough to hit it fi=
rst.
> >> > > In contrast, I have sufficient data to be reasonably confident tha=
t the
> >> > > callback-flooding OOMs really do have something to do with the TRA=
CE01 and
> >> > > TREE10 scenarios, even though I am not yet seeing what these two s=
cenarios
> >> > > have in common that they don't also have in common with other scen=
arios.
> >> > > But what is life without a bit of mystery?  ;-)
> >> >
> >> > :).
> >> >
> >> > > Second, please see the attached tarball, which contains .csv files=
 showing
> >> > > Kconfig options and kernel boot parameters for the various torture=
 tests.
> >> > > The portions of the filenames preceding the "config.csv" correspon=
d to
> >> > > the directories in tools/testing/selftests/rcutorture/configs.
> >> >
> >> > So, at least some of the HZ_FULL=3Dy tests don't run into problems.
> >> >
> >> > > Third, there are additional scenarios hand-crafted by the script at
> >> > > tools/testing/selftests/rcutorture/bin/torture.sh.  Thus far, none=
 of
> >> > > them have triggered, other than via the newly increased difficulty
> >> > > of configurating a tracing-free kernel with which to test, but they
> >> > > can still be useful in ruling out particular Kconfig options or ke=
rnel
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
> >> unlikely though that might be given those fixes and the runs that fail=
ed.
> >
> > And I only got no failures from either TREE10 or TRACE01 on last night's
> > run.
>=20
> Oh that's great news. Same for my overnight runs for TREE04 and TRACE01.
>=20
> Ongoing: a 24 hour run for those. Let's see how that goes.
>=20
> > I merged your series on top of v6.8-rc4 with the -rcu tree's
> > dev branch, the latter to get the RCU fixes.  But this means that last
> > night's results are not really comparable to earlier results.
> >
> > I did get a few TREE09 failures, but I get those anyway.  I took it
> > apart below for you because I got confused and thought that it was a
> > TREE10 failure.  So just in case you were curious what one of these
> > looks like and because I am too lazy to delete it.  ;-)
>=20
> Heh. Well, thanks for being lazy /after/ dissecting it nicely.
>=20
> > So from the viewpoint of moderate rcutorture testing, this series
> > looks good.  Woo hoo!!!
>=20
> Awesome!
>=20
> > We did uncover a separate issue with Tasks RCU, which I will report on
> > in more detail separately.  However, this issue does not (repeat, *not*)
> > affect lazy preemption as such, but instead any attempt to remove all
> > of the cond_resched() invocations.
>=20
> So, that sounds like it happens even with (CONFIG_PREEMPT_AUTO=3Dn,
> CONFIG_PREEMPT=3Dy)?
> Anyway will look out for it when you go into the detail.

Fair point, normally Tasks RCU isn't present when cond_resched()
means anything.

I will look again -- it is quite possible that I was confused by earlier
in-fleet setups that had Tasks RCU enabled even when preemption was
disabled.  (We don't do that anymore, and, had I been paying sufficient
attention, would not have been doing it to start with.  Back in the day,
enabling rcutorture, even as a module, had the side effect of enabling
Tasks RCU.  How else to test it, right?  Well...)

> > My next step is to try this on bare metal on a system configured as
> > is the fleet.  But good progress for a week!!!
>=20
> Yeah this is great. Fingers crossed for the wider set of tests.

I got what might be a one-off when hitting rcutorture and KASAN harder.
I am running 320*TRACE01 to see if it reproduces.

In the meantime...

[ 2242.502082] ------------[ cut here ]------------
[ 2242.502946] WARNING: CPU: 3 PID: 72 at kernel/rcu/rcutorture.c:2839 rcu_=
torture_fwd_prog+0x1125/0x14e0

	Callback-flooding events go for at most eight seconds, and end
	earlier if the RCU flavor under test can clear the flood sooner.
	If the flood does consume the full eight seconds, then we get the
	above WARN_ON if too few callbacks are invoked in the meantime.

	So we get a splat, which is mostly there to make sure that
	rcutorture complains about this, not much information here.

[ 2242.504580] Modules linked in:
[ 2242.505125] CPU: 3 PID: 72 Comm: rcu_torture_fwd Not tainted 6.8.0-rc4-0=
0101-ga3ecbc334926 #8321
[ 2242.506652] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel=
-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
[ 2242.508577] RIP: 0010:rcu_torture_fwd_prog+0x1125/0x14e0
[ 2242.509513] Code: 4b f9 ff ff e8 ac 16 3d 00 e9 0e f9 ff ff 48 c7 c7 c0 =
b9 00 91 e8 9b 16 3d 00 e9 71 f9 ff ff e8 91 16 3d 00 e9 bb f0 ff ff 90 <0f=
> 0b 90 e9 38 fe ff ff 48 8b bd 48 ff ff ff e8 47 16 3d 00 e9 53
[ 2242.512705] RSP: 0018:ffff8880028b7da0 EFLAGS: 00010293
[ 2242.513615] RAX: 000000010031ebc4 RBX: 0000000000000000 RCX: ffffffff8d5=
c6040
[ 2242.514843] RDX: 00000001001da27d RSI: 0000000000000008 RDI: 00000000000=
00e10
[ 2242.516073] RBP: ffff8880028b7ee0 R08: 0000000000000000 R09: ffffed10003=
6d340
[ 2242.517308] R10: ffff888001b69a07 R11: 0000000000030001 R12: dffffc00000=
00000
[ 2242.518537] R13: 000000000001869e R14: ffffffff9100b9c0 R15: ffff8880027=
14000
[ 2242.519765] FS:  0000000000000000(0000) GS:ffff88806d100000(0000) knlGS:=
0000000000000000
[ 2242.521152] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 2242.522151] CR2: 0000000000000000 CR3: 0000000003f26000 CR4: 00000000000=
006f0
[ 2242.523392] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000=
00000
[ 2242.524624] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000000=
00400
[ 2242.525857] Call Trace:
[ 2242.526301]  <TASK>
[ 2242.526674]  ? __warn+0xc8/0x260
[ 2242.527258]  ? rcu_torture_fwd_prog+0x1125/0x14e0
[ 2242.528077]  ? report_bug+0x291/0x2e0
[ 2242.528726]  ? handle_bug+0x3d/0x80
[ 2242.529348]  ? exc_invalid_op+0x18/0x50
[ 2242.530022]  ? asm_exc_invalid_op+0x1a/0x20
[ 2242.530753]  ? kthread_should_stop+0x70/0xc0
[ 2242.531508]  ? rcu_torture_fwd_prog+0x1125/0x14e0
[ 2242.532333]  ? __pfx_rcu_torture_fwd_prog+0x10/0x10
[ 2242.533191]  ? __pfx__raw_spin_lock_irqsave+0x10/0x10
[ 2242.534083]  ? set_cpus_allowed_ptr+0x7c/0xb0
[ 2242.534847]  ? __pfx_set_cpus_allowed_ptr+0x10/0x10
[ 2242.535696]  ? __pfx_rcu_torture_fwd_prog+0x10/0x10
[ 2242.536547]  ? kthread+0x24a/0x300
[ 2242.537159]  ? __pfx_rcu_torture_fwd_prog+0x10/0x10
[ 2242.538038]  kthread+0x24a/0x300
[ 2242.538607]  ? __pfx_kthread+0x10/0x10
[ 2242.539283]  ret_from_fork+0x2f/0x70
[ 2242.539907]  ? __pfx_kthread+0x10/0x10
[ 2242.540571]  ret_from_fork_asm+0x1b/0x30
[ 2242.541273]  </TASK>
[ 2242.541661] ---[ end trace 0000000000000000 ]---

	But now there is some information...

[ 2242.542471] rcu_torture_fwd_prog_cr Duration 8000 barrier: 749 pending 4=
9999 n_launders: 99998 n_launders_sa: 99998 n_max_gps: 0 n_max_cbs: 50000 c=
ver 0 gps 0

	The flood lasted the full eight seconds ("Duration 8000").

	The rcu_barrier_trace() operation consumed an additional 749ms
	("barrier: 749").

	There were almost 50K callbacks for that rcu_barrier_trace()
	to deal with ("pending 49999").

	There were almost 100K that were recycled directly, as opposed
	to being newly allocated ("n_launders: 99998"), and all launders
	happened after the last allocation ("n_launders_sa: 99998").
	This is to be expected because RCU Tasks Trace does not do
	priority boosting of preempted readers, and therefore rcutorture
	limits the number of outstanding callbacks in the flood to 50K.
	And it might never boost readers, given that it is legal to
	block in an RCU Tasks Trace read-side critical section.

	Insufficient callbacks were invoked ("n_max_gps: 0") and the
	full 50K permitted was allocated ("n_max_cbs: 50000").

	The rcu_torture_writer() did not see a full grace period in the
	meantime ("cver 0") and there was no recorded grace period in
	the meantime ("gps 0").

[ 2242.544890] rcu_torture_fwd_cb_hist: Callback-invocation histogram 0 (du=
ration 8751 jiffies): 1s/10: 0:0 2s/10: 0:0 3s/10: 0:0 4s/10: 0:0 5s/10: 0:=
0 6s/10: 0:0 7s/10: 0:0 8s/10: 50000:0 9s/10: 0:0 10s/10: 0:0 11s/10: 0:0 1=
2s/10: 0:0 13s/10: 0:0 14s/10: 0:0 15s/10: 0:0 16s/10: 49999:0 17s/10: 0:0 =
18s/10: 0:0 19s/10: 0:0 20s/10: 0:0 21s/10: 0:0 22s/10: 0:0 23s/10: 0:0 24s=
/10: 0:0 25s/10: 0:0 26s/10: 0:0 27s/10: 0:0 28s/10: 0:0 29s/10: 0:0 30s/10=
: 0:0 31s/10: 0:0 32s/10: 0:0 33s/10: 0:0 34s/10: 0:0 35s/10: 0:0 36s/10: 0=
:0 37s/10: 0:0 38s/10: 0:0 39s/10: 0:0 40s/10: 0:0 41s/10: 0:0 42s/10: 0:0 =
43s/10: 0:0 44s/10: 0:0 45s/10: 0:0 46s/10: 0:0 47s/10: 0:0 48s/10: 0:0 49s=
/10: 0:0 50s/10: 0:0 51s/10: 0:0 52s/10: 0:0 53s/10: 0:0 54s/10: 0:0 55s/10=
: 0:0 56s/10: 0:0 57s/10: 0:0 58s/10: 0:0 59s/10: 0:0 60s/10: 0:0 61s/10: 0=
:0 62s/10: 0:0 63s/10: 0:0 64s/10: 0:0 65s/10: 0:0 66s/10: 0:0 67s/10: 0:0 =
68s/10: 0:0 69s/10: 0:0 70s/10: 0:0 71s/10: 0:0 72s/10: 0:0 73s/10: 0:0 74s=
/10: 0:0 75s/10: 0:0 76s/10: 0:0 77s/10: 0:0 78s/10: 0:0
[ 2242.545050]  79s/10: 0:0 80s/10: 0:0 81s/10: 49999:0

	Except that we can see callbacks having been invoked during this
	time ("8s/10: 50000:0", "16s/10: 49999:0", "81s/10: 49999:0").

	In part because rcutorture is unaware of RCU Tasks Trace's
	grace-period sequence number.

So, first see if it is reproducible, second enable more diagnostics,
third make more grace-period sequence numbers available to rcutorture,
fourth recheck the diagnostics code, and then see where we go from there.
It might be that lazy preemption needs adjustment, or it might be that
it just tickled latent diagnostic issues in rcutorture.

(I rarely hit this WARN_ON() except in early development, when the
problem is usually glaringly obvious, hence all the uncertainty.)

							Thanx, Paul

