Return-Path: <linux-kernel+bounces-99681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45A64878BB6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 01:01:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A89421F221A5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 00:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDBBB4A00;
	Tue, 12 Mar 2024 00:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R06HgEQ8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECBE42C9D;
	Tue, 12 Mar 2024 00:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710201689; cv=none; b=kYMmiIEWW+XpjpqWQH6b1hSCrRGdHKiH01fKYtDDosgFCNsmXFj+0dDiH6utwxEOGOwNbqYy4Z9KA6zXUDr+XzAa3qx/GUHHH9q3x6ZMXHWVUs9U23HbaQ10+AD7cBHqv6tylphGbC3PXffE4OHK/Yc5QGvmsoPjXqAXq76jOTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710201689; c=relaxed/simple;
	bh=dc00JfnlMwsCkx7wvw26s5xru2o4c6hpy3ciZ88KKUI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OYJ4RTsylCIob3JySyT3NyR2y4++J9M5ZA46EWxh0q5x8JTAVFn7bWlPQlQdcazwgJs8o7bLGdI5h37WUUCQ4Djzy62GkWyb//6Nnk1BpNx1pCESGWQKO2ld/vDwQTLluFFCmM4dNU3xTQQ5VlcKeyg+LldtxYRdSIvW4g2AYMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R06HgEQ8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 742DBC433C7;
	Tue, 12 Mar 2024 00:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710201688;
	bh=dc00JfnlMwsCkx7wvw26s5xru2o4c6hpy3ciZ88KKUI=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=R06HgEQ8ueRBd+IxAYd6Sb6KNvhrgDsGnFhILaRj5SfchOcDX5Z2KwOaPej//uPyN
	 s8rJf7FYa3pebEpw6AT1ZTbsorycm+maYNrcyx9g4XvJNdwibJTSclYLogt64g2XCR
	 ZN50/eh4sy0r88sjxWsrrIjr2IvGAOS+YNIWBEL5RQhpyhycDwBiZjbrzyMnghYoJ1
	 kGlBhZYQWZ2uA3/tBmJAWwdSgRZFMTmCz0idxo4pqWtAZm3guTA4hSYi+mmcRp2BcL
	 xgErY+vfZS9JPiyRiKZwWMvahvjD9+0RPJBGTeu5w/h6zyBl+eTs6ZqxgmXt/hZ4aa
	 /gZGGUES3810w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 12FDFCE1A25; Mon, 11 Mar 2024 17:01:28 -0700 (PDT)
Date: Mon, 11 Mar 2024 17:01:28 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Joel Fernandes <joel@joelfernandes.org>,
	Ankur Arora <ankur.a.arora@oracle.com>,
	linux-kernel@vger.kernel.org, peterz@infradead.org,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	luto@kernel.org, bp@alien8.de, dave.hansen@linux.intel.com,
	hpa@zytor.com, mingo@redhat.com, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, willy@infradead.org, mgorman@suse.de,
	jpoimboe@kernel.org, mark.rutland@arm.com, jgross@suse.com,
	andrew.cooper3@citrix.com, bristot@kernel.org,
	mathieu.desnoyers@efficios.com, geert@linux-m68k.org,
	glaubitz@physik.fu-berlin.de, anton.ivanov@cambridgegreys.com,
	mattst88@gmail.com, krypton@ulrich-teichert.org,
	rostedt@goodmis.org, David.Laight@aculab.com, richard@nod.at,
	mjguzik@gmail.com, jon.grimm@amd.com, bharata@amd.com,
	raghavendra.kt@amd.com, boris.ostrovsky@oracle.com,
	konrad.wilk@oracle.com, rcu@vger.kernel.org
Subject: Re: [PATCH 15/30] rcu: handle quiescent states for PREEMPT_RCU=n,
 PREEMPT_COUNT=y
Message-ID: <ac753dd6-8b78-4fbc-96fe-353c9be2935f@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240213055554.1802415-1-ankur.a.arora@oracle.com>
 <20240213055554.1802415-16-ankur.a.arora@oracle.com>
 <20240310100330.GA2705505@joelbox2>
 <da51dacc-cdf7-4129-b424-b32764736f48@paulmck-laptop>
 <fd48ea5c-bc74-4914-a621-d12c9741c014@joelfernandes.org>
 <87r0ghl51f.fsf@oracle.com>
 <66820daa-421b-469a-a7e8-ae7ae9dfa978@joelfernandes.org>
 <87wmq8pop1.ffs@tglx>
 <e762474b-a3fa-46bd-9816-7663fbba7271@paulmck-laptop>
 <87le6opl5x.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87le6opl5x.ffs@tglx>

On Mon, Mar 11, 2024 at 09:29:14PM +0100, Thomas Gleixner wrote:
> Paul!
> 
> On Mon, Mar 11 2024 at 12:53, Paul E. McKenney wrote:
> > On Mon, Mar 11, 2024 at 08:12:58PM +0100, Thomas Gleixner wrote:
> >> I'd rather spend brain cycles on figuring out whether RCU can be flipped
> >> over between PREEMPT_RCU=n/y at boot or obviously run-time.
> >
> > Well, it is just software, so anything is possible.  But there can
> > be a wide gap between "possible" and "sensible".  ;-)
> 
> Indeed.
> 
> > In theory, one boot-time approach would be build preemptible RCU,
> > and then to boot-time binary-rewrite calls to __rcu_read_lock()
> > and __rcu_read_unlock() to preempt_disable() and preempt_enable(),
> > respectively.  Because preemptible RCU has to treat preemption-disabled
> > regions of code as RCU readers, this Should Just Work.  However, there
> > would then be a lot of needless branches in the grace-period code.
> > Only the ones on fastpaths (for example, context switch) would need
> > to be static-branchified, but there would likely need to be other
> > restructuring, given the need for current preemptible RCU to do a better
> > job of emulating non-preemptible RCU.  (Emulating non-preemptible RCU
> > is of course currently a complete non-goal for preemptible RCU.)
> 
> Sure, but that might be a path to have a more unified RCU model in the
> longer term with the tweak of patching the flavor once at boot.

I am pretty sure that it can be made to happen.  The big question in my
mind is "Is it worth it?"

> > But this one needs careful design and review up front, as in step through
> > all the code and check assumptions and changes in behavior.  After all,
> > this stuff is way easier to break than to debug and fix.  ;-)
> 
> Isn't that where all the real fun is? :)
> 
> > On the other hand, making RCU switch at runtime is...  Tricky.
> 
> I was only half serious about that. Just thought to mention if for
> completeness sake and of course to make you write a novel. :)

A short novel.  ;-)

> > For example, if the system was in non-preemptible mode at rcu_read_lock()
> > time, the corresponding rcu_read_unlock() needs to be aware that it needs
> > to act as if the system was still in non-preemptible mode, and vice versa.
> > Grace period processing during the switch needs to be aware that different
> > CPUs will be switching at different times.  Also, it will be common for a
> > given CPU's switch to span more than one grace period.  So any approach
> > based on either binary rewrite or static branches will need to be set
> > up in a multi-phase multi-grace-period state machine.  Sort of like
> > Frederic's runtime-switched callback offloading, but rather more complex,
> > and way more performance sensitive.
> 
> Of course it would be a complex endavour at the scale of run-time
> switching to or from PREEMPT_RT, which will never happen. Even the boot
> time switch for RT would be way harder than the RCU one :)

Run-time switching of either RCU or PREEMPT_RT would likely provide many
opportunities along the way for black hats.  ;-)

> > But do we even need to switch RCU at runtime, other than to say that
> > we did it?  What is the use case?  Or is this just a case of "it would
> > be cool!"?  Don't get me wrong, I am a sucker for "it would be cool",
> > as you well know, but even for me there are limits.  ;-)
> 
> There is no need for runtime switching other than "it would be cool" and
> I'm happy that even you have limits. :)

So *that* was the point of this whole email exchange.  ;-)

> > At the moment, I would prioritize improving quiescent-state forcing for
> > existing RCU over this, especially perhaps given the concerns from the
> > MM folks.
> >
> > But what is motivating the desire to boot-time/run-time switch RCU
> > between preemptible and non-preemptible?
> 
> The goal of PREEMPT_AUTO is to get rid of the zoo of preemption models
> and their associated horrors. As we debated some time ago we still need
> to have the distinction of preemptible and non-preemptible RCU even with
> that.
> 
> So it's a pretty obvious consequence to make this decision at boot time
> to reduce the number of kernel flavors for distros to build.

Very well, we can look to the distros for requirements, when and if.

> Nothing urgent, but it just came to my mind when reading through this
> thread and replying to Joel.

Got it, thank you!

							Thanx, Paul

