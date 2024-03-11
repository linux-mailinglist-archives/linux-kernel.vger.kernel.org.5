Return-Path: <linux-kernel+bounces-99486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0658F87891A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 20:49:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37794B217A8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 19:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 756F655E56;
	Mon, 11 Mar 2024 19:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="c+Ta5PuI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MOOuhMzl"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D178255792
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 19:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710186561; cv=none; b=rzpCmLb09olR3TpxULnPe5Tj4zPxlyyYOcxrlWSSY+fNcy4YoqzNh/yCcJVs04xtSPTkx0DCcsqHLiCGpgZJk7rT/5iYgz/LmblKFNpRUyMBYiLgbClez3heSi3qnE+QTXVuq5n62QuWrXocnzkK464kFGhVPrPwwx1xHFkaNzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710186561; c=relaxed/simple;
	bh=I4TeOeewzmtiOwLT0Ur+c0xuyRQbbEIRl/612MHNtio=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sLXALVZb/CURvKUKiM8wRFVikIXy2Iw8Y7ZVE92EaZOGG5bWwonM0Nr2pBRQhwV4ktIFq3nOr8IJ2Fnj/OYKY+d2WjGd+s+/ilrFC96xMrVNk2IThy06Nq0ZYWOFx3DD6cG8bqadCH2AMmB8e1jjeJx7hF2nncxZBSROwEXia0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=c+Ta5PuI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MOOuhMzl; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1710186558;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bIf4gHPxpIeRGxCApdcoHYr9dHDC1FtrtTpngEnEr5g=;
	b=c+Ta5PuIJdY/6XEbA4Y9jt7Ux6AyCMU+f7As0RWcZjLCsNKUyJylK6pRUVpWqD/wKxiCgs
	csCzku3sbg9uwQWCLO5iQmwmNxm0oM9fklj/V8DoIWUCtxbBtBd1DiH2KDy92Eb9qDUHNx
	mAMFUqh4mZDN/VKQ/eYeAaUCL7cbAQxBfof1a1eBheMopq5qBz6y3bUB0Zir2iFisj5Zd/
	S1Q1Pv8GyqpE8V/xk6yt4tM8RoKYGnGYSmDnlVs4FSRJu8rRYt3PzrGDMVtW4W4uA1f58x
	v1Kv3X5G4+PPrr2UZs2yiyYAiEAvOYG7UnRR7EvTwMLzsA9U3dYLW/lyxa9EBA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1710186558;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bIf4gHPxpIeRGxCApdcoHYr9dHDC1FtrtTpngEnEr5g=;
	b=MOOuhMzlsP3Va93fiIQfNzdqaXNyZu8DO18YFUbuhrLOmkF199CFbhFGxvA+r4U6ptcKlS
	QE2pmj24HP8BTkBw==
To: =?utf-8?B?QW5kcsOpIFLDtnN0aQ==?= <an.roesti@gmail.com>,
 linux-kernel@vger.kernel.org
Cc: peterz@infradead.org, luto@kernel.org
Subject: Re: [PATCH] Respect system call number changes by sys_enter probes
In-Reply-To: <20240309055311.2144-1-an.roesti@gmail.com>
References: <20240309055311.2144-1-an.roesti@gmail.com>
Date: Mon, 11 Mar 2024 20:49:17 +0100
Message-ID: <87ttlcpn0i.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Andr=C3=A9!

On Sat, Mar 09 2024 at 05:53, Andr=C3=A9 R=C3=B6sti wrote:

Nice finding!

Just a few nitpicks:

  The subject line lacks a subsystem prefix. In this case is should be:

  Subject: [PATCH] entry: Respect ......

Documentation/process/ has quite some information about change logs
along with the tip tree specific one:

  https://www.kernel.org/doc/html/latest/process/maintainer-tip.html

> When a probe  is registered at the `trace_sys_enter` tracepoint, and

s/`trace_sys_enter`/trace_sys_enter()/=20

> that probe changes the system call number, the old system call still
> gets executed on x86_64 (and potentially other architectures). This

s/on x86_64 (and potentially other architectures//

Why? It's clear that this code is only executed on architectures which
utilize the generic entry code.

> is inconsistent with how ARM64 (and potentially other architectures)
> handles this, and inconsistent with the tracepoint semantics prior to
> change b6ec41346103 (core/entry: Report syscall correctly for trace
> and audit).

  This worked correctly until commit b6ec41346103 ("core/entry: Report
  syscall correctly for trace and audit") which removed the re-evaluation
  of the syscall number after the trace point.

The ARM64 info is nice to have, but not really relevant because the real
issue is the commit which changed the semantics of the entry code.

> With this patch, the semantics are restored to be the same as before

Please search for "This patch" in the process documentation

> the aforementioned change (and thus made consistent with ARM64). The
> change adds one line to re-read the system call number register into
> the `syscall` variable. By reading twice, the benefits of the
> aforementioned change b6ec41346103 are kept.

My version for the above would be:

  Restore the original semantics by re-evaluating the system call number
  after trace_sys_enter().

That's the gist of the change, right?

It does not matter where the number comes from and which variable is it
written to. That's what is in the patch itself. It's neither interesting
that reading twice keeps some benefit because again, that's what can be
seen from the actual change. You'd need to mention it if your fix would
change it.

> There should be no performance impact if no sys_enter tracepoints are
> registered, since re-reading the system call number from `regs` is
> only done conditonally if the tracepoint is in use. If a probe is
> registered, the performance impact should still be minimal, since the
> additional call to `syscall_get_nr` amounts to only an inlined read
> of `regs->orig_ax` (on x86_64).

That's pretty x86 specific. What about something like this:

  The performance impact of this re-evaluation is minimal because it is
  only relevant when a trace point is active and compared to the actual
  trace point overhead the read from a cache hot variable is
  neglectible.

This lacks a:

Fixes: commit b6ec41346103 ("core/entry: Report syscall correctly for trace=
 and audit")

tag.

> Signed-off-by: Andr=C3=A9 R=C3=B6sti <an.roesti@gmail.com>
> ---
> @Thomas Gleixner: You may have received this e-mail twice. My apologies!
> This is my first attempt to contribute, and I made a mistake using git
> send-email. Thanks for your work maintaining this and sorry again.

Don't worry. The first time submission is a learning experience. I
lively remember the healthy lesson I got a few decades ago and I still
get them today when I fail to see or describe something.

That said, I'm impressed by the detective work you did to put an
explanatory change log together on your first submission. Keep up the
good work!

I'm looking forward to the V2. Feel free to use my suggestions above as
guideline and rephrase it in your own words.

> ---
>  kernel/entry/common.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/entry/common.c b/kernel/entry/common.c
> index 88cb3c88aaa5..89b14ba9ed14 100644
> --- a/kernel/entry/common.c
> +++ b/kernel/entry/common.c
> @@ -57,8 +57,11 @@ long syscall_trace_enter(struct pt_regs *regs, long sy=
scall,
>  	/* Either of the above might have changed the syscall number */
>  	syscall =3D syscall_get_nr(current, regs);
>=20=20
> -	if (unlikely(work & SYSCALL_WORK_SYSCALL_TRACEPOINT))
> +	if (unlikely(work & SYSCALL_WORK_SYSCALL_TRACEPOINT)) {
>  		trace_sys_enter(regs, syscall);
> +		/* Tracers may have changed system call number as well */

I'd rather say 'Probes or BPF hooks in the tracepoint ...'

Because a trace point per se does not change anything.

> +		syscall =3D syscall_get_nr(current, regs);
> +	}
>=20=20
>  	syscall_enter_audit(regs, syscall);

Thanks,

        tglx

