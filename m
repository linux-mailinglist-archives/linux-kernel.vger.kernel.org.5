Return-Path: <linux-kernel+bounces-67794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 661E38570D6
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 23:56:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8ABFD1C20BF3
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 22:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4D4E145346;
	Thu, 15 Feb 2024 22:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LyuqhOAn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA858145326
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 22:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708037794; cv=none; b=UoLEpyfWIuK5uq6UKUPw7XxJHSeQzskWypwML5DkUIIcYXKUKhMchJVPELCAeaiZog0WqLaBNc8njDZQ7mAhBQfro5NsDsoi8e8c24x0iBoitDgmQSOQC5VMzW0KQipaViSP+zhoE9YcXVoxfzTRoPVskEyu/1oUE6m2TjI2QXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708037794; c=relaxed/simple;
	bh=pNpQtUNSn8aRt1csc3tfj9x0ATaeAcczpbcDd4VpwXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P9WaOUPn6ZvZhXJqaL7t3WtXVfmP5c5Mca27mjq2g+NuOJ3B37/Y3NYmvHcFRJH6bOjee1tkS3xYn9Ok6YMqv8EC2DcWYl3sI1fSC0hlnzeuef4kWh3rkPB7TBdHdIfK1O4pJq4HzA3/EhEIoUNBw8GOLBY2qAuQFOserge4wno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LyuqhOAn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D1BCC433F1;
	Thu, 15 Feb 2024 22:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708037794;
	bh=pNpQtUNSn8aRt1csc3tfj9x0ATaeAcczpbcDd4VpwXU=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=LyuqhOAni5LvefD4vhEmeg9Hu8FS9G07sFkDWg8wORsUlrFYV+Dxq38MD5B+M43KR
	 77r7Rrg1ni6L7v5YvpU1w8Cnh/ZViDhg2boIKT12v35FdErL257kk+hWJ6FJAhAZRA
	 JWbztsE9U3guWZoCId+FHyk4mR4pZLW2vi9ywmZeaMyTsu5XJ3nczmp2dL0AtsVWS5
	 tpgSZQQ7tg5PlCc9W5Ul1OZhreTBZjD208vAuLdbC6mozaJqZd5ipfkp5W5+SfLtod
	 9ck5d8IBsSkWmNpgkjHYJn6yrrWAU7zyUGqr1phduJjnLaULtHEzcNin6mXktRtWpP
	 2A63OnGtjou9g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id ED89DCE0D0D; Thu, 15 Feb 2024 14:56:33 -0800 (PST)
Date: Thu, 15 Feb 2024 14:56:33 -0800
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
Message-ID: <0fe2140a-90d5-4af5-ab0b-bec363ff793b@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240213055554.1802415-1-ankur.a.arora@oracle.com>
 <a7e785f8-d4c3-4b1b-9abe-36ac0b971e44@paulmck-laptop>
 <87le7mpjpr.fsf@oracle.com>
 <4e070ae0-29dc-41ee-aee6-0d3670304825@paulmck-laptop>
 <0d4a4eec-ce91-48da-91b6-1708a97edaeb@paulmck-laptop>
 <871q9dmndg.fsf@oracle.com>
 <9916c73f-510c-47a6-a9b4-ea6b438e82c0@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="90i4ueA/18l4dmrF"
Content-Disposition: inline
In-Reply-To: <9916c73f-510c-47a6-a9b4-ea6b438e82c0@paulmck-laptop>


--90i4ueA/18l4dmrF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 15, 2024 at 02:54:45PM -0800, Paul E. McKenney wrote:
> On Thu, Feb 15, 2024 at 01:24:59PM -0800, Ankur Arora wrote:
> > 
> > Paul E. McKenney <paulmck@kernel.org> writes:
> > 
> > > On Wed, Feb 14, 2024 at 07:45:18PM -0800, Paul E. McKenney wrote:
> > >> On Wed, Feb 14, 2024 at 06:03:28PM -0800, Ankur Arora wrote:
> > >> >
> > >> > Paul E. McKenney <paulmck@kernel.org> writes:
> > >> >
> > >> > > On Mon, Feb 12, 2024 at 09:55:24PM -0800, Ankur Arora wrote:
> > >> > >> Hi,
> > >> > >>
> > >> > >> This series adds a new scheduling model PREEMPT_AUTO, which like
> > >> > >> PREEMPT_DYNAMIC allows dynamic switching between a none/voluntary/full
> > >> > >> preemption model. However, unlike PREEMPT_DYNAMIC, it doesn't depend
> > >> > >> on explicit preemption points for the voluntary models.
> > >> > >>
> > >> > >> The series is based on Thomas' original proposal which he outlined
> > >> > >> in [1], [2] and in his PoC [3].
> > >> > >>
> > >> > >> An earlier RFC version is at [4].
> > >> > >
> > >> > > This uncovered a couple of latent bugs in RCU due to its having been
> > >> > > a good long time since anyone built a !SMP preemptible kernel with
> > >> > > non-preemptible RCU.  I have a couple of fixes queued on -rcu [1], most
> > >> > > likely for the merge window after next, but let me know if you need
> > >> > > them sooner.
> > >> >
> > >> > Thanks. As you can probably tell, I skipped out on !SMP in my testing.
> > >> > But, the attached diff should tide me over until the fixes are in.
> > >>
> > >> That was indeed my guess.  ;-)
> > >>
> > >> > > I am also seeing OOM conditions during rcutorture testing of callback
> > >> > > flooding, but I am still looking into this.
> > >> >
> > >> > That's on the PREEMPT_AUTO && PREEMPT_VOLUNTARY configuration?
> > >>
> > >> On two of the PREEMPT_AUTO && PREEMPT_NONE configurations, but only on
> > >> two of them thus far.  I am running a longer test to see if this might
> > >> be just luck.  If not, I look to see what rcutorture scenarios TREE10
> > >> and TRACE01 have in common.
> > >
> > > And still TRACE01 and TREE10 are hitting OOMs, still not seeing what
> > > sets them apart.  I also hit a grace-period hang in TREE04, which does
> > > CONFIG_PREEMPT_VOLUNTARY=y along with CONFIG_PREEMPT_AUTO=y.  Something
> > > to dig into more.
> > 
> > So, the only PREEMPT_VOLUNTARY=y configuration is TREE04. I wonder
> > if you would continue to hit the TREE04 hang with CONFIG_PREEMTP_NONE=y
> > as well?
> > (Just in the interest of minimizing configurations.)

This time with the tarball actually attached!  :-/

						Thanx, Paul

> I would be happy to, but in the spirit of full disclosure...
> 
> First, I have seen that failure only once, which is not enough to
> conclude that it has much to do with TREE04.  It might simply be low
> probability, so that TREE04 simply was unlucky enough to hit it first.
> In contrast, I have sufficient data to be reasonably confident that the
> callback-flooding OOMs really do have something to do with the TRACE01 and
> TREE10 scenarios, even though I am not yet seeing what these two scenarios
> have in common that they don't also have in common with other scenarios.
> But what is life without a bit of mystery?  ;-)
> 
> Second, please see the attached tarball, which contains .csv files showing
> Kconfig options and kernel boot parameters for the various torture tests.
> The portions of the filenames preceding the "config.csv" correspond to
> the directories in tools/testing/selftests/rcutorture/configs.
> 
> Third, there are additional scenarios hand-crafted by the script at
> tools/testing/selftests/rcutorture/bin/torture.sh.  Thus far, none of
> them have triggered, other than via the newly increased difficulty
> of configurating a tracing-free kernel with which to test, but they
> can still be useful in ruling out particular Kconfig options or kernel
> boot parameters being related to a given issue.
> 
> But please do take a look at the .csv files and let me know what
> adjustments would be appropriate given the failure information.
> 
> 							Thanx, Paul
> 
> > ---
> > diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TREE04 b/tools/testing/selftests/rcutorture/configs/rcu/TREE04
> > index 9ef845d54fa4..819cff9113d8 100644
> > --- a/tools/testing/selftests/rcutorture/configs/rcu/TREE04
> > +++ b/tools/testing/selftests/rcutorture/configs/rcu/TREE04
> > @@ -1,7 +1,7 @@
> >  CONFIG_SMP=y
> >  CONFIG_NR_CPUS=8
> > -CONFIG_PREEMPT_NONE=n
> > -CONFIG_PREEMPT_VOLUNTARY=y
> > +CONFIG_PREEMPT_NONE=y
> > +CONFIG_PREEMPT_VOLUNTARY=n
> >  CONFIG_PREEMPT_AUTO=y
> >  CONFIG_PREEMPT=n
> >  CONFIG_PREEMPT_DYNAMIC=n

--90i4ueA/18l4dmrF
Content-Type: application/x-gtar-compressed
Content-Description: tortureconfigs.2024.02.15a.tgz
Content-Disposition: attachment; filename="tortureconfigs.2024.02.15a.tgz"
Content-Transfer-Encoding: base64

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

--90i4ueA/18l4dmrF--

