Return-Path: <linux-kernel+bounces-67793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67FC88570CF
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 23:55:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0869D285CD9
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 22:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D02BA145324;
	Thu, 15 Feb 2024 22:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uAhqVH4O"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E8713DBA4
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 22:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708037687; cv=none; b=EMOMaTaBpUtrDU/D/VfJtsRfSLc5aQTxWq4Ail3l4WrHe+XWar/Mm2CoFKO30JdPqIcHSE7Oz09exeoLIWfR7+hnhZRmdisAz+XzXnj+GUO8USb1Au1MJKUzfIC50caMES9tRVNb6BdASKagoIiNVNNiA9lAx5cGX5jAG8grO1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708037687; c=relaxed/simple;
	bh=zbF3FYI3PLntHOa327ey9TUu9dEvJ4MP0H8qomuSkl0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D1H9Td5rx3hGqJVL+szPZp5UevYtjXXhdCdlOIAyAhtdyE3aH1YuQbavUcgNKqIWJbyoyyer411Ee/AJIsrhRRr6PbUnZCEiN1LiFmaHCiZ4M8l+W5R/z0oe22znw8wtlLgHSBtVtncNwdPALfngBClmjTH0bjIULmf3581Uc2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uAhqVH4O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E001C433F1;
	Thu, 15 Feb 2024 22:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708037686;
	bh=zbF3FYI3PLntHOa327ey9TUu9dEvJ4MP0H8qomuSkl0=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=uAhqVH4OBYEV4zDad6XlQPCAJRvcPmYZ0pPAFCyVFt0mA3YTBzHNRd5cuJqSSqGOK
	 Zt0PSZq/cecmoyVDGiJfyP05Rfvx8u4VvIVzWtyYcpCSs1eMQ6NedT+MYgTHHuDSi+
	 3YtEcLU9yrJGzfciFWuFqqZNZ5SMF1ZmPQJuYmZWoQcfcw42OSSjBO4STRLCq+SoCU
	 xo0PGX4dyJ2XnFN8CKQfVNzlRCtrjJtAj2whOlMJuAZn23nYdvUfDeUSYDnCPHG+Nv
	 rVGwLzTNgQ0a2+rQiA0iJ0qit43F/XeJ0TQwEq3UWbCiQ/BizjXHI52vV7b8/lgSc6
	 uPm7mmQDgv6Sg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id E655BCE0D0D; Thu, 15 Feb 2024 14:54:45 -0800 (PST)
Date: Thu, 15 Feb 2024 14:54:45 -0800
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
Message-ID: <9916c73f-510c-47a6-a9b4-ea6b438e82c0@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240213055554.1802415-1-ankur.a.arora@oracle.com>
 <a7e785f8-d4c3-4b1b-9abe-36ac0b971e44@paulmck-laptop>
 <87le7mpjpr.fsf@oracle.com>
 <4e070ae0-29dc-41ee-aee6-0d3670304825@paulmck-laptop>
 <0d4a4eec-ce91-48da-91b6-1708a97edaeb@paulmck-laptop>
 <871q9dmndg.fsf@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871q9dmndg.fsf@oracle.com>

On Thu, Feb 15, 2024 at 01:24:59PM -0800, Ankur Arora wrote:
> 
> Paul E. McKenney <paulmck@kernel.org> writes:
> 
> > On Wed, Feb 14, 2024 at 07:45:18PM -0800, Paul E. McKenney wrote:
> >> On Wed, Feb 14, 2024 at 06:03:28PM -0800, Ankur Arora wrote:
> >> >
> >> > Paul E. McKenney <paulmck@kernel.org> writes:
> >> >
> >> > > On Mon, Feb 12, 2024 at 09:55:24PM -0800, Ankur Arora wrote:
> >> > >> Hi,
> >> > >>
> >> > >> This series adds a new scheduling model PREEMPT_AUTO, which like
> >> > >> PREEMPT_DYNAMIC allows dynamic switching between a none/voluntary/full
> >> > >> preemption model. However, unlike PREEMPT_DYNAMIC, it doesn't depend
> >> > >> on explicit preemption points for the voluntary models.
> >> > >>
> >> > >> The series is based on Thomas' original proposal which he outlined
> >> > >> in [1], [2] and in his PoC [3].
> >> > >>
> >> > >> An earlier RFC version is at [4].
> >> > >
> >> > > This uncovered a couple of latent bugs in RCU due to its having been
> >> > > a good long time since anyone built a !SMP preemptible kernel with
> >> > > non-preemptible RCU.  I have a couple of fixes queued on -rcu [1], most
> >> > > likely for the merge window after next, but let me know if you need
> >> > > them sooner.
> >> >
> >> > Thanks. As you can probably tell, I skipped out on !SMP in my testing.
> >> > But, the attached diff should tide me over until the fixes are in.
> >>
> >> That was indeed my guess.  ;-)
> >>
> >> > > I am also seeing OOM conditions during rcutorture testing of callback
> >> > > flooding, but I am still looking into this.
> >> >
> >> > That's on the PREEMPT_AUTO && PREEMPT_VOLUNTARY configuration?
> >>
> >> On two of the PREEMPT_AUTO && PREEMPT_NONE configurations, but only on
> >> two of them thus far.  I am running a longer test to see if this might
> >> be just luck.  If not, I look to see what rcutorture scenarios TREE10
> >> and TRACE01 have in common.
> >
> > And still TRACE01 and TREE10 are hitting OOMs, still not seeing what
> > sets them apart.  I also hit a grace-period hang in TREE04, which does
> > CONFIG_PREEMPT_VOLUNTARY=y along with CONFIG_PREEMPT_AUTO=y.  Something
> > to dig into more.
> 
> So, the only PREEMPT_VOLUNTARY=y configuration is TREE04. I wonder
> if you would continue to hit the TREE04 hang with CONFIG_PREEMTP_NONE=y
> as well?
> (Just in the interest of minimizing configurations.)

I would be happy to, but in the spirit of full disclosure...

First, I have seen that failure only once, which is not enough to
conclude that it has much to do with TREE04.  It might simply be low
probability, so that TREE04 simply was unlucky enough to hit it first.
In contrast, I have sufficient data to be reasonably confident that the
callback-flooding OOMs really do have something to do with the TRACE01 and
TREE10 scenarios, even though I am not yet seeing what these two scenarios
have in common that they don't also have in common with other scenarios.
But what is life without a bit of mystery?  ;-)

Second, please see the attached tarball, which contains .csv files showing
Kconfig options and kernel boot parameters for the various torture tests.
The portions of the filenames preceding the "config.csv" correspond to
the directories in tools/testing/selftests/rcutorture/configs.

Third, there are additional scenarios hand-crafted by the script at
tools/testing/selftests/rcutorture/bin/torture.sh.  Thus far, none of
them have triggered, other than via the newly increased difficulty
of configurating a tracing-free kernel with which to test, but they
can still be useful in ruling out particular Kconfig options or kernel
boot parameters being related to a given issue.

But please do take a look at the .csv files and let me know what
adjustments would be appropriate given the failure information.

							Thanx, Paul

> ---
> diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TREE04 b/tools/testing/selftests/rcutorture/configs/rcu/TREE04
> index 9ef845d54fa4..819cff9113d8 100644
> --- a/tools/testing/selftests/rcutorture/configs/rcu/TREE04
> +++ b/tools/testing/selftests/rcutorture/configs/rcu/TREE04
> @@ -1,7 +1,7 @@
>  CONFIG_SMP=y
>  CONFIG_NR_CPUS=8
> -CONFIG_PREEMPT_NONE=n
> -CONFIG_PREEMPT_VOLUNTARY=y
> +CONFIG_PREEMPT_NONE=y
> +CONFIG_PREEMPT_VOLUNTARY=n
>  CONFIG_PREEMPT_AUTO=y
>  CONFIG_PREEMPT=n
>  CONFIG_PREEMPT_DYNAMIC=n

