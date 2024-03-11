Return-Path: <linux-kernel+bounces-99514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35037878978
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 21:29:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF368282235
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 20:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1E3556776;
	Mon, 11 Mar 2024 20:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1sRb6odO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EhJ3cmYh"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F9255E6E;
	Mon, 11 Mar 2024 20:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710188959; cv=none; b=q273D1YYaanVmV4JdBQG942qQZ98QK8hCI5jkiBr40pDYalAuejtEFqYSs2kZJvRj2q1klq6i0vjSPK1aU49ScFSTw+9SkyfPor5r59PIylin8MObVXa+kaqSTsGIwIkJL5ClgNCQfci2paq8vDzfYPAsLBLqQ7EeYP8VPBL1UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710188959; c=relaxed/simple;
	bh=4APU1M/KiK/+7uHuA2Rc0JmxJJOyGmFbaOp9a1HyEk4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hLSlG2HTcyA9BpxTB0X7AdOlSVLHmY9B485DVTbi3nna7rcMS2ukrOWc6x3Bq/pyXCb0pNZdRBYtKteAodKtMde/YEselsKRdoaDvZrfEyLOoHiKKVCQJWmR4H1S2onL7akUI9DTykSWecE/xr6ZRzbk7YtuJaUtLaoTaZh//Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1sRb6odO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EhJ3cmYh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1710188955;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/RAL3fYVWZNqFN7wXyFIkNxC3jxlsCU2f89ndHvGZcU=;
	b=1sRb6odO88mKWisW7Zoe/byDZmdSjuCZTsE+7xLVkO31JJdKHRlj/Y0e0Sw76WdvWCTSnV
	FGKLJmbBB64L3W9NNsk5FiUW/A/btRDvXnHyvW+/XS4g3+ldq5EdQEvCLj3SXtP6hbj/yX
	M8R8lGB//fNL3gB/hO+Pyl+gHEEwPgx/vy5tHti2ribJFf/vcsVGAYdPIoarDFJGvCkopF
	qoiBriPNbKek8/k+u5EWGl+S6u2iN8BSRtaAtcbPrc3GbfESPkkRssFkxifEE6sGBzE92S
	QQVefvwy67ZOAkelbgXL287Y3dkpiNhgonbfdssKny7fHfQVD7RWRVRDGUYmZw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1710188955;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/RAL3fYVWZNqFN7wXyFIkNxC3jxlsCU2f89ndHvGZcU=;
	b=EhJ3cmYhVqGFu5SUIPrGg740WTWN+4Bum96bZPucQEnzHncIxMdH3YX4ufpnhpXoSd4dpt
	UJ8jvknNjp+qYJCA==
To: paulmck@kernel.org
Cc: Joel Fernandes <joel@joelfernandes.org>, Ankur Arora
 <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org,
 peterz@infradead.org, torvalds@linux-foundation.org,
 akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
 dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
 juri.lelli@redhat.com, vincent.guittot@linaro.org, willy@infradead.org,
 mgorman@suse.de, jpoimboe@kernel.org, mark.rutland@arm.com,
 jgross@suse.com, andrew.cooper3@citrix.com, bristot@kernel.org,
 mathieu.desnoyers@efficios.com, geert@linux-m68k.org,
 glaubitz@physik.fu-berlin.de, anton.ivanov@cambridgegreys.com,
 mattst88@gmail.com, krypton@ulrich-teichert.org, rostedt@goodmis.org,
 David.Laight@aculab.com, richard@nod.at, mjguzik@gmail.com,
 jon.grimm@amd.com, bharata@amd.com, raghavendra.kt@amd.com,
 boris.ostrovsky@oracle.com, konrad.wilk@oracle.com, rcu@vger.kernel.org
Subject: Re: [PATCH 15/30] rcu: handle quiescent states for PREEMPT_RCU=n,
 PREEMPT_COUNT=y
In-Reply-To: <e762474b-a3fa-46bd-9816-7663fbba7271@paulmck-laptop>
References: <20240213055554.1802415-1-ankur.a.arora@oracle.com>
 <20240213055554.1802415-16-ankur.a.arora@oracle.com>
 <20240310100330.GA2705505@joelbox2>
 <da51dacc-cdf7-4129-b424-b32764736f48@paulmck-laptop>
 <fd48ea5c-bc74-4914-a621-d12c9741c014@joelfernandes.org>
 <87r0ghl51f.fsf@oracle.com>
 <66820daa-421b-469a-a7e8-ae7ae9dfa978@joelfernandes.org>
 <87wmq8pop1.ffs@tglx>
 <e762474b-a3fa-46bd-9816-7663fbba7271@paulmck-laptop>
Date: Mon, 11 Mar 2024 21:29:14 +0100
Message-ID: <87le6opl5x.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Paul!

On Mon, Mar 11 2024 at 12:53, Paul E. McKenney wrote:
> On Mon, Mar 11, 2024 at 08:12:58PM +0100, Thomas Gleixner wrote:
>> I'd rather spend brain cycles on figuring out whether RCU can be flipped
>> over between PREEMPT_RCU=n/y at boot or obviously run-time.
>
> Well, it is just software, so anything is possible.  But there can
> be a wide gap between "possible" and "sensible".  ;-)

Indeed.

> In theory, one boot-time approach would be build preemptible RCU,
> and then to boot-time binary-rewrite calls to __rcu_read_lock()
> and __rcu_read_unlock() to preempt_disable() and preempt_enable(),
> respectively.  Because preemptible RCU has to treat preemption-disabled
> regions of code as RCU readers, this Should Just Work.  However, there
> would then be a lot of needless branches in the grace-period code.
> Only the ones on fastpaths (for example, context switch) would need
> to be static-branchified, but there would likely need to be other
> restructuring, given the need for current preemptible RCU to do a better
> job of emulating non-preemptible RCU.  (Emulating non-preemptible RCU
> is of course currently a complete non-goal for preemptible RCU.)

Sure, but that might be a path to have a more unified RCU model in the
longer term with the tweak of patching the flavor once at boot.

> But this one needs careful design and review up front, as in step through
> all the code and check assumptions and changes in behavior.  After all,
> this stuff is way easier to break than to debug and fix.  ;-)

Isn't that where all the real fun is? :)

> On the other hand, making RCU switch at runtime is...  Tricky.

I was only half serious about that. Just thought to mention if for
completeness sake and of course to make you write a novel. :)

> For example, if the system was in non-preemptible mode at rcu_read_lock()
> time, the corresponding rcu_read_unlock() needs to be aware that it needs
> to act as if the system was still in non-preemptible mode, and vice versa.
> Grace period processing during the switch needs to be aware that different
> CPUs will be switching at different times.  Also, it will be common for a
> given CPU's switch to span more than one grace period.  So any approach
> based on either binary rewrite or static branches will need to be set
> up in a multi-phase multi-grace-period state machine.  Sort of like
> Frederic's runtime-switched callback offloading, but rather more complex,
> and way more performance sensitive.

Of course it would be a complex endavour at the scale of run-time
switching to or from PREEMPT_RT, which will never happen. Even the boot
time switch for RT would be way harder than the RCU one :)

> But do we even need to switch RCU at runtime, other than to say that
> we did it?  What is the use case?  Or is this just a case of "it would
> be cool!"?  Don't get me wrong, I am a sucker for "it would be cool",
> as you well know, but even for me there are limits.  ;-)

There is no need for runtime switching other than "it would be cool" and
I'm happy that even you have limits. :)

> At the moment, I would prioritize improving quiescent-state forcing for
> existing RCU over this, especially perhaps given the concerns from the
> MM folks.
>
> But what is motivating the desire to boot-time/run-time switch RCU
> between preemptible and non-preemptible?

The goal of PREEMPT_AUTO is to get rid of the zoo of preemption models
and their associated horrors. As we debated some time ago we still need
to have the distinction of preemptible and non-preemptible RCU even with
that.

So it's a pretty obvious consequence to make this decision at boot time
to reduce the number of kernel flavors for distros to build.

Nothing urgent, but it just came to my mind when reading through this
thread and replying to Joel.

Thanks,

        tglx

