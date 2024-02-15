Return-Path: <linux-kernel+bounces-67675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9202D856EF6
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 21:55:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0FE9B25883
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 20:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A945213B795;
	Thu, 15 Feb 2024 20:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ws/B6r/K"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D391B13B2BA
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 20:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708030542; cv=none; b=Z+Ahq6fElH2GeIeslED2TwDFXqJz/Lv4+84GJlTzNVJJBSN6YHCvfiNcjPZc1WyjEmtXY/Zpf6g5GU81oQSrBQnmwKjwpOr0YP64QEsxmp4V2C8WmY246z2eazsbR+iO3Ct+KPsCIoN77LFYdkedgV3sAcreiOu6Hm+ySsdc9Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708030542; c=relaxed/simple;
	bh=8jSuuQhpcQclievgNJd1ypuzcfWgo4VmuhUlUb2FpaE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ruFVzlF8g7r7MHVmYdoFbL6tfYCuX87fnLw8gnMaUpbiqB+a7OSAH1jWEiHyIkW4Cb55j5ksy+q/LFnHkkYl+dxwodwUk9n8B4DRPnoYsGru177IPk2M7iGE5gkU+JneB35crQM5k646noUd6RaRSoMVdfdlMYTYFfTCy7iRqOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ws/B6r/K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52FE8C433C7;
	Thu, 15 Feb 2024 20:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708030542;
	bh=8jSuuQhpcQclievgNJd1ypuzcfWgo4VmuhUlUb2FpaE=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=Ws/B6r/KLmIGHVLe/VAGB2yEUChPYQCKG8Dnq6NgHu6hz0L4T8p6xa4RmbLCSFNUe
	 Kr0UTFGyf3/o2IPT/C3yyur3YBWsBMlKOsRWmAyb+i6R4uaek5LbZpgkrU9WA6euDg
	 1Mcx1kyXNHBVRIzZbieJxUIpXNrkvWk5Z+BvKbFpF6KJIBvelbt31aXlbrdlKe0O2e
	 xoNvPAjlLVpCrNwrmKdGRwY1LCmYyARlBN+9IGqVPayQo+skcbcIMyTDi46MXAPe88
	 f0hs6STh5TqFfwTdaay53BcsGqKBPn+XglTQWrULC9MY1eGGV3WZ25QpgQHtLZXU/s
	 0OIt3UlDBjzyw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 0326BCE0D0D; Thu, 15 Feb 2024 12:55:42 -0800 (PST)
Date: Thu, 15 Feb 2024 12:55:41 -0800
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
Message-ID: <11b858de-06ae-4df6-82b0-b709bc89ca25@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240213055554.1802415-1-ankur.a.arora@oracle.com>
 <a7e785f8-d4c3-4b1b-9abe-36ac0b971e44@paulmck-laptop>
 <87le7mpjpr.fsf@oracle.com>
 <4e070ae0-29dc-41ee-aee6-0d3670304825@paulmck-laptop>
 <0d4a4eec-ce91-48da-91b6-1708a97edaeb@paulmck-laptop>
 <878r3lmoue.fsf@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878r3lmoue.fsf@oracle.com>

On Thu, Feb 15, 2024 at 12:53:13PM -0800, Ankur Arora wrote:
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
> >
> > I am also getting these from builds that enable KASAN:
> >
> > vmlinux.o: warning: objtool: mwait_idle+0x13: call to tif_resched.constprop.0() leaves .noinstr.text section
> > vmlinux.o: warning: objtool: acpi_processor_ffh_cstate_enter+0x36: call to tif_resched.constprop.0() leaves .noinstr.text section
> > vmlinux.o: warning: objtool: cpu_idle_poll.isra.0+0x18: call to tif_resched.constprop.0() leaves .noinstr.text section
> > vmlinux.o: warning: objtool: acpi_safe_halt+0x0: call to tif_resched.constprop.0() leaves .noinstr.text section
> > vmlinux.o: warning: objtool: poll_idle+0x33: call to tif_resched.constprop.0() leaves .noinstr.text section
> > vmlinux.o: warning: objtool: default_enter_idle+0x18: call to tif_resched.constprop.0() leaves .noinstr.text section
> 
> Thanks Paul. Yeah, with KASAN, tif_resched() transforms into this out of
> line function:
> 
> ffffffff810fec20 <tif_resched.constprop.0>:
> ffffffff810fec20:       e8 5b c6 20 00          call   ffffffff8130b280 <__sanitizer_cov_trace_pc>
> ffffffff810fec25:       b8 03 00 00 00          mov    $0x3,%eax
> ffffffff810fec2a:       e9 71 56 61 01          jmp    ffffffff827142a0 <__x86_return_thunk>
> ffffffff810fec2f:       90                      nop
> 
> > Does tif_resched() need to be marked noinstr or some such?
> 
> Builds fine with Thomas' suggested fix.

You beat me to it.  ;-)

							Thanx, Paul

> --------
> diff --git a/include/linux/thread_info.h b/include/linux/thread_info.h
> index 8752dbc2dac7..0810ddeb365d 100644
> --- a/include/linux/thread_info.h
> +++ b/include/linux/thread_info.h
> @@ -81,12 +81,12 @@ typedef enum {
>   * reduce to the same value (TIF_NEED_RESCHED) leaving any scheduling behaviour
>   * unchanged.
>   */
> -static inline int tif_resched(resched_t rs)
> +static __always_inline inline int tif_resched(resched_t rs)
>  {
>         return TIF_NEED_RESCHED + rs * TIF_NEED_RESCHED_LAZY_OFFSET;
>  }
> 
> -static inline int _tif_resched(resched_t rs)
> +static __always_inline inline int _tif_resched(resched_t rs)
>  {
>         return 1 << tif_resched(rs);
>  }

