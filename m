Return-Path: <linux-kernel+bounces-66270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D984855989
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 04:45:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C297FB2296C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 03:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC7C36FB8;
	Thu, 15 Feb 2024 03:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HcACt1nU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 146B833DD
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 03:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707968719; cv=none; b=nQiX28rfl85UVBBAdrH/VolSBNBKfMXBHliertc4koVyDTOtz0K6lkRBUplx7yai+hweEebSoz4/B70bFe7bD3FoyS0sBFD38r/+GTZR16+DdB3ucopox5q5oOAfbe3NzlHV1PqY1a+q5JeOuey/9Uj+3kL5jAak+N0tLHdCYpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707968719; c=relaxed/simple;
	bh=HCpAesOZ9BivNvW8yYNvBm2PY4syrHl8xlGIHLGijbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WO2x1LuWUTZEEQmP4RxpA1Sj6rzDEUH7bvcfRznJbYs0/iv9rGSKjFsMRD4z/ien58tcZY3bpVY1gAMP1rPNTDh+ty7foTr1SueFqxmBBtaUqG57hb9J72RhJ4exTds1qkgpNvjtrX74yiBN13px26/InPPjwRl6qf0tV8SfxLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HcACt1nU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 762D4C433F1;
	Thu, 15 Feb 2024 03:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707968718;
	bh=HCpAesOZ9BivNvW8yYNvBm2PY4syrHl8xlGIHLGijbQ=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=HcACt1nUHmU6MIboabfpkZtbTJqWVFKy7QlfttSkdSmnXEdjpFuvP2ttl+RBXE6iI
	 cy51U0HyX55W5BU+Vj8jIymLxyDGgwaB6aEvGNTi2ZDfPXzslJNXPgCRTW82GLrf39
	 iaWWlVXHkSDI5MK74/jA4LVPPgOGCqpJ0VmmABLtXeDowCnCRgyt5Us3+5lQusfQIs
	 olBQRZlU4HFad1YrR+4GZqSlkDn3wT6phun/6b9A/5uIrfLEDS8pdHHfxX9yhB2jtM
	 kDCgJ32EOW7nDsO1H1ZpX1CS8ZoLBA7/od8sFaCq5T5p3EBLWZgAnNJRQvK3if/PZT
	 R8g3CORkE+l9w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 1AC88CE0D11; Wed, 14 Feb 2024 19:45:18 -0800 (PST)
Date: Wed, 14 Feb 2024 19:45:18 -0800
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
Message-ID: <4e070ae0-29dc-41ee-aee6-0d3670304825@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240213055554.1802415-1-ankur.a.arora@oracle.com>
 <a7e785f8-d4c3-4b1b-9abe-36ac0b971e44@paulmck-laptop>
 <87le7mpjpr.fsf@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87le7mpjpr.fsf@oracle.com>

On Wed, Feb 14, 2024 at 06:03:28PM -0800, Ankur Arora wrote:
> 
> Paul E. McKenney <paulmck@kernel.org> writes:
> 
> > On Mon, Feb 12, 2024 at 09:55:24PM -0800, Ankur Arora wrote:
> >> Hi,
> >>
> >> This series adds a new scheduling model PREEMPT_AUTO, which like
> >> PREEMPT_DYNAMIC allows dynamic switching between a none/voluntary/full
> >> preemption model. However, unlike PREEMPT_DYNAMIC, it doesn't depend
> >> on explicit preemption points for the voluntary models.
> >>
> >> The series is based on Thomas' original proposal which he outlined
> >> in [1], [2] and in his PoC [3].
> >>
> >> An earlier RFC version is at [4].
> >
> > This uncovered a couple of latent bugs in RCU due to its having been
> > a good long time since anyone built a !SMP preemptible kernel with
> > non-preemptible RCU.  I have a couple of fixes queued on -rcu [1], most
> > likely for the merge window after next, but let me know if you need
> > them sooner.
> 
> Thanks. As you can probably tell, I skipped out on !SMP in my testing.
> But, the attached diff should tide me over until the fixes are in.

That was indeed my guess.  ;-)

> > I am also seeing OOM conditions during rcutorture testing of callback
> > flooding, but I am still looking into this.
> 
> That's on the PREEMPT_AUTO && PREEMPT_VOLUNTARY configuration?

On two of the PREEMPT_AUTO && PREEMPT_NONE configurations, but only on
two of them thus far.  I am running a longer test to see if this might
be just luck.  If not, I look to see what rcutorture scenarios TREE10
and TRACE01 have in common.

							Thanx, Paul

