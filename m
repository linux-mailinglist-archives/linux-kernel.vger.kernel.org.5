Return-Path: <linux-kernel+bounces-67580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39E95856DB6
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 20:28:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD19A1F26CF4
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 19:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4149B13A27C;
	Thu, 15 Feb 2024 19:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aYLvNPLv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85BF513A269
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 19:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708025315; cv=none; b=aDmcJ0UEqUe0OVUsWSLg4RwzA7jO/5R00qPI3Jm602hM6G3gezBRfLn9S5C78Ma+i1Dt+pbaVC2FOv1TsDya6Kk4NiegokoPXtU6YInyvZhNKiRJGOqk/uxLEOhDFiel64n/1k00a4UDtmvlhL8NzKXt86Ao7RPtwCYBqhk4Zlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708025315; c=relaxed/simple;
	bh=0kM+zjcqTLYhv7yd9HTfbFlqiT7ZOFsFU4xJukY2mcw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RtTXqy2ZhEtnAi/BX3pWcd5kY1w+c/7EA4r4miRNW5Ds1U1yW2KB385sCnzV8O2BVanf3jh+cWT5UtD0bOBP/BUe/mZAN6S8EVAXzhrSzxcFc6DDwx3sKQW4zf8U7H2IrE6KUkHLVhwmU33hGCZuDPMV9VtwTeG1LXScvDm3CMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aYLvNPLv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D2AAC433F1;
	Thu, 15 Feb 2024 19:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708025315;
	bh=0kM+zjcqTLYhv7yd9HTfbFlqiT7ZOFsFU4xJukY2mcw=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=aYLvNPLvrqx4jBIpmHk6IB6sl2Rxpa2Zq1u4/cAXTBsX9dGQNqnEK/qSRKeohJX5R
	 G/ldsZGmAXz4wzris2194+88sRlrvFLBh6DLfdVG0NmHPDtqR9XRb+ERyxLUAMPE00
	 irYRjetRTvGb2RC8FJws1pa0rdAJM7o3UGctTXGETkMNXr/nPtEYElmELtCBpM7aeH
	 raO0YBzwvswnN4mzUzj/dJFKMTzMFewhbl5iGkd8K3SX517qK+HzU7l3PJKN5YYC0P
	 du/inx/GJoPjvGtqy2sbE6ckuQFVnWZsdXcc9gEM0NUq5Aj2ASqouBGXc8pfW2TjPg
	 HlV9tjCzCLr4g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id DD794CE0D0D; Thu, 15 Feb 2024 11:28:34 -0800 (PST)
Date: Thu, 15 Feb 2024 11:28:34 -0800
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
Message-ID: <0d4a4eec-ce91-48da-91b6-1708a97edaeb@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240213055554.1802415-1-ankur.a.arora@oracle.com>
 <a7e785f8-d4c3-4b1b-9abe-36ac0b971e44@paulmck-laptop>
 <87le7mpjpr.fsf@oracle.com>
 <4e070ae0-29dc-41ee-aee6-0d3670304825@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e070ae0-29dc-41ee-aee6-0d3670304825@paulmck-laptop>

On Wed, Feb 14, 2024 at 07:45:18PM -0800, Paul E. McKenney wrote:
> On Wed, Feb 14, 2024 at 06:03:28PM -0800, Ankur Arora wrote:
> > 
> > Paul E. McKenney <paulmck@kernel.org> writes:
> > 
> > > On Mon, Feb 12, 2024 at 09:55:24PM -0800, Ankur Arora wrote:
> > >> Hi,
> > >>
> > >> This series adds a new scheduling model PREEMPT_AUTO, which like
> > >> PREEMPT_DYNAMIC allows dynamic switching between a none/voluntary/full
> > >> preemption model. However, unlike PREEMPT_DYNAMIC, it doesn't depend
> > >> on explicit preemption points for the voluntary models.
> > >>
> > >> The series is based on Thomas' original proposal which he outlined
> > >> in [1], [2] and in his PoC [3].
> > >>
> > >> An earlier RFC version is at [4].
> > >
> > > This uncovered a couple of latent bugs in RCU due to its having been
> > > a good long time since anyone built a !SMP preemptible kernel with
> > > non-preemptible RCU.  I have a couple of fixes queued on -rcu [1], most
> > > likely for the merge window after next, but let me know if you need
> > > them sooner.
> > 
> > Thanks. As you can probably tell, I skipped out on !SMP in my testing.
> > But, the attached diff should tide me over until the fixes are in.
> 
> That was indeed my guess.  ;-)
> 
> > > I am also seeing OOM conditions during rcutorture testing of callback
> > > flooding, but I am still looking into this.
> > 
> > That's on the PREEMPT_AUTO && PREEMPT_VOLUNTARY configuration?
> 
> On two of the PREEMPT_AUTO && PREEMPT_NONE configurations, but only on
> two of them thus far.  I am running a longer test to see if this might
> be just luck.  If not, I look to see what rcutorture scenarios TREE10
> and TRACE01 have in common.

And still TRACE01 and TREE10 are hitting OOMs, still not seeing what
sets them apart.  I also hit a grace-period hang in TREE04, which does
CONFIG_PREEMPT_VOLUNTARY=y along with CONFIG_PREEMPT_AUTO=y.  Something
to dig into more.

I am also getting these from builds that enable KASAN:

vmlinux.o: warning: objtool: mwait_idle+0x13: call to tif_resched.constprop.0() leaves .noinstr.text section
vmlinux.o: warning: objtool: acpi_processor_ffh_cstate_enter+0x36: call to tif_resched.constprop.0() leaves .noinstr.text section
vmlinux.o: warning: objtool: cpu_idle_poll.isra.0+0x18: call to tif_resched.constprop.0() leaves .noinstr.text section
vmlinux.o: warning: objtool: acpi_safe_halt+0x0: call to tif_resched.constprop.0() leaves .noinstr.text section
vmlinux.o: warning: objtool: poll_idle+0x33: call to tif_resched.constprop.0() leaves .noinstr.text section
vmlinux.o: warning: objtool: default_enter_idle+0x18: call to tif_resched.constprop.0() leaves .noinstr.text section

Does tif_resched() need to be marked noinstr or some such?

Tracing got harder to disable, but I beleive that is unrelated to lazy
preemption.  ;-)

							Thanx, Paul

