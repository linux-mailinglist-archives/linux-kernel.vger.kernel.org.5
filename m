Return-Path: <linux-kernel+bounces-155915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 303AC8AF8D7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 23:19:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57848B252C5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 21:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D77DD143881;
	Tue, 23 Apr 2024 21:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="n2V3xDRp";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VqWCn/9W"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C287E14387C
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 21:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713907139; cv=none; b=X9yHnKUNBS146Doe+aJqDNVfDq3uoouOSaq7e/b0I4WSE8Vvs/fstC0NZvXinLSKBSoj3IrXBs242sPj0nEwJc2daV6BO44PtvrJGO2S37mVg5mGGaP0KkGCeifvGbzCNavj4in9hDgTlDXHE4PegVj6LRh+GdGHk7lNJ0Bv6Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713907139; c=relaxed/simple;
	bh=lQ5mz/3QF+FVbW6Cfu+b6iZSyuXyJkg85ruyQbmfF/k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rLPMxJMUuj7Q5TiHxhHnvOzeiH3PmOZURjHwoUQv2cvZf5nug3/SGEkHIPushMLr6SGIwdJiylsi/ShyqWovQBWXUQNMQ8O+rbxpGz9rJCz77Mxu+ng0DI6GDuTGdi0fWAFUYORrU9h4LjxUbr/83ENIAyr8tOtknyAACj4N9dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=n2V3xDRp; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VqWCn/9W; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1713907134;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U480bomknQkqybyCzO4J0bpvqYL9TETZBB5r+gmlD9E=;
	b=n2V3xDRptp5ca229GRDuXFDrkDAMuNphD0RbBkEsRBOrdZ3IoCCnCsUMTuC3JGWKrjjOuw
	JOooF/PSbq7QyUaSaB53ASiVsOlByuxN8RnoKB5QEaN2Pb2sp4Z1Z0Jf2/+G61jqKNQNcc
	MIJd1364YA3hL3ztRJS+lEJP6gXylHNlisL1KSb0P9/8ZRmMyEFbJRu2WGY0+GKxPhq1qO
	o0dXbfUmT1i+HMFbskccY1wjam5juMd0vewcxSTWzUQA5TDOW6n/uBF/QIJE9rC4vXcgSn
	d1Puz7Vn9quEDxyB7z6lp34BhA3j2UjXYbcj+pypKRpKHAjS+F2WgCitVXZyNg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1713907134;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U480bomknQkqybyCzO4J0bpvqYL9TETZBB5r+gmlD9E=;
	b=VqWCn/9WpFA7UmkAXSC/5UDpSs42pO5g4B2z64w7XDLSiiQHkALvUluFS9pvczSWXlY4k6
	luxxYxULG7bQ+VBQ==
To: Oleg Nesterov <oleg@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Anna-Maria Behnsen
 <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>,
 John Stultz <jstultz@google.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>, Stephen Boyd <sboyd@kernel.org>, Eric
 Biederman <ebiederm@xmission.com>, Andrei Vagin <avagin@google.com>
Subject: Re: [patch V2 26/50] signal: Get rid of resched_timer logic
In-Reply-To: <20240419110632.GA3198@redhat.com>
References: <20240410164558.316665885@linutronix.de>
 <20240410165552.572304080@linutronix.de>
 <20240418163811.GA23440@redhat.com> <20240418181821.GA26239@redhat.com>
 <20240419110632.GA3198@redhat.com>
Date: Tue, 23 Apr 2024 23:18:50 +0200
Message-ID: <87sezbu69x.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Apr 19 2024 at 13:06, Oleg Nesterov wrote:
> On 04/18, Oleg Nesterov wrote:
>> But this is not simple, collect_signal() checks SIGQUEUE_PREALLOC exactly
>> because (iiuc) we need to ensure that SI_TIMER didn't come from userspace.
>>
>> perhaps we should disallow SI_TIMER with _sys_private != 0 from userspace,
>> I dunno...
>>
>> And I don't really understand the "not to be passed to user" comment in
>> include/uapi/asm-generic/siginfo.h. copy_siginfo_to_user() just copies
>> the whole kernel_siginfo.
>
> OK, si_sys_private is cleared in dequeue_signal() (or in posixtimer_rearm()
> with this series).
>
> In the past SI_TIMER was defined as __SI_CODE(__SI_TIMER,-2), it was > 0,
> so it could not come from userspace (see the info->si_code >= 0 check in
> do_rt_sigqueueinfo).

Duh.

> Today SI_TIMER < 0. We could introduce SI_TIMER_KERNEL > 0 with the minimal
> changes, but this can't help because the commit 66dd34ad31e59 allows to send
> any siginfo to itself.

Well that predates the __SI_CODE() removal. So I doubt it's required
today, but what do I know about CRIU.

> Otoh, I have no idea how CRIU restores the posix timers. If a process has
> a pending blocked SI_TIMER signal, then I guess it actually needs to enqueue
> this signal at restore time, but resched_timer will be never true?

It can't restore the correct sys_si_private value because that is
nowhere exposed to user space.

There is no special treatment for SI_TIMER, so the signal restore might
just end up queueing a random extra SI_TIMER signal if there was one
pending.

I checked the CRIU source and it looks like this just "works" by
reconstructing and rearming the timer with the last expiry value. As
that is in the past it will fire immediately and queue the signal.

sys_si_private seems to be excluded from being set from user space in
compat mode, but in non-compat mode I can't find anything which prevents
that.

Let me stare more at this. 

Thanks,

        tglx

