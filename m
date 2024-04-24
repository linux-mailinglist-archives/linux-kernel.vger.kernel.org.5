Return-Path: <linux-kernel+bounces-156104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71E148AFE02
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 03:49:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A37E71C22842
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 01:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D58E18C3D;
	Wed, 24 Apr 2024 01:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cIIK77qv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MCa8Nam7"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F2F17C6D
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 01:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713923339; cv=none; b=FPSVGNDdGoiuTECx7ulgL40HTSRYcJ8gKr71JSW9/04cdhqw9vo373U3wJBMooH8ghkxUqnDiLxry6nmrRIzkI0+298M4bTFm52b84C6sr3x6f8btoy+jTB9EJOecbABeshDJ1PAKu5LBgeCESeQ7xjkxS2Pk8RDMYAvF4/2PRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713923339; c=relaxed/simple;
	bh=giMktJ71EARmlqXkvxyPyld7ZV/A3U4DTXZa/d46F1s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PX1UNAEYB6ZrTerCT0oRZx2YC30Rv0ZqdYi133dbof6E+NW/f1Y+p7N6Ua30XWV53kMo7kc4TR3FwzllI5RiFj272wG4dhaIaoltnRdvaRTeTL79oeuJ8qs2gmJUbPQgsaCa+4I+jUEwuGa8hP+YmOhhkt7zfXw6MN8iYxs+X6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cIIK77qv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MCa8Nam7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1713923336;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=F5zHfMiON8HFmLdW6+ELVSBVklR/odVfqVLnZps4L9s=;
	b=cIIK77qvYJfGCVTS8RxquL/s2q9Na4XPv7eZwPCzX2h1tGYISXKizpdg+3pBceBh4sD1DI
	xhBaXmf87+xArjdMN9dSrTPvA7yg3G3OzyNKF027U+pYgCsjqcyyk9ZedWyLhkpKpsZyhM
	rogm7qBxszzWnc5QMoglFSm4Ix755dQnqnWW0xeCnNHI5DgzOVoNXndKySAx6QGTxJAda3
	RxjIprmZxodxAcXM1BNGcRh9jUCum5aWSj5nSvLdpY8JV2//Swt0zSptlMqy6WwDvw+N5c
	gtA2F563nf4A7Gjhr6LeuFXdooi6OJdgMCUcu/Ua77Cdp6eB9W0eEbcduivWjQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1713923336;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=F5zHfMiON8HFmLdW6+ELVSBVklR/odVfqVLnZps4L9s=;
	b=MCa8Nam78NdyKjrcW4PuyoPaHpoeontl9QaAvrRnPrfD6vBl9j72+bWGklLyB9StRL5FKh
	zDQvmnpXaKmaCWAA==
To: Oleg Nesterov <oleg@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Anna-Maria Behnsen
 <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>,
 John Stultz <jstultz@google.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>, Stephen Boyd <sboyd@kernel.org>, Eric
 Biederman <ebiederm@xmission.com>, Andrei Vagin <avagin@google.com>
Subject: Re: [patch V2 26/50] signal: Get rid of resched_timer logic
In-Reply-To: <87sezbu69x.ffs@tglx>
References: <20240410164558.316665885@linutronix.de>
 <20240410165552.572304080@linutronix.de>
 <20240418163811.GA23440@redhat.com> <20240418181821.GA26239@redhat.com>
 <20240419110632.GA3198@redhat.com> <87sezbu69x.ffs@tglx>
Date: Wed, 24 Apr 2024 03:48:53 +0200
Message-ID: <87plufttru.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Apr 23 2024 at 23:18, Thomas Gleixner wrote:
> On Fri, Apr 19 2024 at 13:06, Oleg Nesterov wrote:
>> Otoh, I have no idea how CRIU restores the posix timers. If a process has
>> a pending blocked SI_TIMER signal, then I guess it actually needs to enqueue
>> this signal at restore time, but resched_timer will be never true?
>
> It can't restore the correct sys_si_private value because that is
> nowhere exposed to user space.

It is exposed via PTRACE_PEEKSIGINFO, but it's useless.

> There is no special treatment for SI_TIMER, so the signal restore might
> just end up queueing a random extra SI_TIMER signal if there was one
> pending.

It does. The sys_si_private value is not going to match the timer side
value and obviously the missing prealloc flag prevents it from trying to
rearm the timer.

> I checked the CRIU source and it looks like this just "works" by
> reconstructing and rearming the timer with the last expiry value. As
> that is in the past it will fire immediately and queue the signal.

It's not necessarily in the past, but it will fire eventually and in the
case of a blocked signal there will be two SI_TIMER signals queued.

So the patch is not completely wrong except that there is nothing which
prevents setting sys_si_private via rt_sigqueueinfo(), but that's
obviously a solvable problem. With that solved the condition:

                *resched_timer =
                        (first->flags & SIGQUEUE_PREALLOC) &&
                        (info->si_code == SI_TIMER) &&
                        (info->si_sys_private);
          
really can be reduced to:

       info->code == SI_TIMER && info->si_sys_private

In fact it makes a lot of sense _not_ to allow user space to set
info->si_sys_private because that's a kernel internal value and should
never be exposed to user space in the first place.

Let me look what it needs or if this can be solved slightly differently.



