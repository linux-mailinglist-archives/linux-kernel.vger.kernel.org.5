Return-Path: <linux-kernel+bounces-143271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8EC48A367D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 21:48:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 059B41C21C2C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 19:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06EF2150980;
	Fri, 12 Apr 2024 19:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Rol3UFQd";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+wva99r1"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9FC405FD
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 19:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712951307; cv=none; b=FDKP3INAAioAKn4zG7v8ywBYRY/5TTXSqJ1cdNda+hDfmYytcI9rmOZF8GtWznRDWek6sWFiWASXNqmyBWE97AUQW/kOsi99/VxeAuIPypeXhhB4sPeYmqVf1iCGobQVTtzLAXDQUouKRDR/WOMn9qdk7vO7hZLmnGjx4wzKYOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712951307; c=relaxed/simple;
	bh=gvBb/3sOt9Qvp6wLzqbJbKrrCL8NP4h8q5rBctg3GSU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=q90fgeyrfkBbr25LbXKPQNwstnMae8RgM87C4aA3yr78DP7En4nPh+cyAScVMvkS9Ptj8dLyuHfZJkVw+8yuGlMWDDfCbcKMi+TFokss3GQoF869bWCHqaKw89rBTJzUYRdMG3lIiNQZG0XPH20+VnHbr40jo4x9BRwhlNdK05g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Rol3UFQd; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+wva99r1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712951304;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T1vyvcDhC58JLm7RLxNaW159SgckVo+LvqWczZaOlJk=;
	b=Rol3UFQdnbm+phlwCqPYQhYOpgVywBhFXjBjpW8EcYqJm52Eyurq4CRBevU0G8GgbzH9Vy
	nhEHvKOoJ7Ocq49eQnjvuFSWlmJBhRrZxyvql1nK9fqOhdJmiI43QURiMn6ekQUiJtMAR7
	NTkQ5+bULDllJNCkqGXNW90BFOH1075W2jECe9mjSER/yV0q9Ma/xScXadC62ozdXZWy5L
	hXmOKWWtLa7Z+IQu8+mOuoUM0rLe23aGaC8pAFb6ffHJA4tsz+51OltmZGFOIxWGSrUJNQ
	/TBI2HqMIyjJ/fDQ/V2JVOKodM5xd5mP43O6KChf9CI5A8xWBfxQAlCvMS1izQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712951304;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T1vyvcDhC58JLm7RLxNaW159SgckVo+LvqWczZaOlJk=;
	b=+wva99r1FJa/LWjWhAjfjRQVcAppxuAozPmQzy71WOTAayQJudzY+y5ueftRrufMi89Qu6
	CkA/pEEk+Yix9nBg==
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Anna-Maria Behnsen
 <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>,
 John Stultz <jstultz@google.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>, Stephen Boyd <sboyd@kernel.org>, Oleg
 Nesterov <oleg@redhat.com>
Subject: Re: [patch V2 07/50] posix-cpu-timers: Split up posix_cpu_timer_get()
In-Reply-To: <87mspyxwua.fsf@email.froward.int.ebiederm.org>
References: <20240410164558.316665885@linutronix.de>
 <20240410165551.376994018@linutronix.de>
 <87mspyxwua.fsf@email.froward.int.ebiederm.org>
Date: Fri, 12 Apr 2024 21:48:23 +0200
Message-ID: <87jzl2z7js.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Apr 12 2024 at 13:25, Eric W. Biederman wrote:
> Thomas Gleixner <tglx@linutronix.de> writes:
>> In preparation for addressing issues in the timer_get() and timer_set()
>> functions of posix CPU timers.
>
> To see that this was safe I had to lookup and see that
> cpu_timer_getexpires is a truly trivial function.
>
> static inline u64 cpu_timer_getexpires(struct cpu_timer *ctmr)
> {
> 	return ctmr->node.expires;
> }
>
> I am a bit confused by the purpose of this function in
> posix-cpu-timers.c.

I added that back then when I converted the code over to use a
timerqueue instead of a linked list mostly because I did not want to
fiddle in the inwars of timerqueue.

> In some places this helper is used (like below), and in other places
> like bump_cpu_timer the expires member is accessed directly.
>
> It isn't really a problem, but it is something that might be
> worth making consistent in the code to make it easier to read.

Yes, that's definitely inconsistent. I'll have a look.

Thanks,

        tglx

