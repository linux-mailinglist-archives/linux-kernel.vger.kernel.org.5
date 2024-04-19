Return-Path: <linux-kernel+bounces-151020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D2B78AA802
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 07:43:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F22AB24A34
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 05:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9CF9BA50;
	Fri, 19 Apr 2024 05:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="abS/lIn3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qlC2QhgH"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0CCE8F62
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 05:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713505392; cv=none; b=tWcpHS1V8Fedm/2vO+SRmHmRBzVMwR/C8kYL2fgX0VQoZA3ljC3qjECGqswImcvafWg/Ei3NzDAbkznhwk13g22JsoOSiVChacyaEMpHbvlbyUDyxJV8Vua+ifZAHDGOTdW8nHPpnYomi0gKWN7UnMPYm01A44wcmpXP/J3Ssz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713505392; c=relaxed/simple;
	bh=3Tmksko475RAPQHDprAZ87gMkRH6qpfx8ZmKwXxLaB8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NF0dTXyZ6RH3V7f6+wvCjMSqI3lbOF9uB9o3jTKeMkaqEErt6h1CAXVNJ1dNPTO6NIZadxXnp4f3sec/AfvM7ZrCqmevVHa7IueUiFYpMKBMxPwSMowWWZCO8f2S/0C4TcgNoXSs+NRuqp3pdZsTN3fjXpZ5acEaBECV9ZfKGIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=abS/lIn3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qlC2QhgH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1713505389;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pwFc3HvBM5e/MYXVzEFc0WpXcC13ZpOh67R7PvfUxA8=;
	b=abS/lIn3NuwPMUIYrOOoR8xQk4yeRNj20Re+hclc+swlaZgCtoYODOPoPunLqfwaVz3Gz2
	tnVmOtDiBFL9tyeOWeYlEnJ+08pqVkz4xBGj/oy614ncxNkDaRcf+2cEKefklRHFgOOKRC
	s6oal7JmmtdyHEIxgm+oFG/nT1Pf5f50wERam/8a6bGtiqXZxkCFoxL9hLgb1qWXVpgCqZ
	GGwInb1IQIzpASRFK9Tdvhbp6hGKEYNb6w7MyDoHUU9+tNyN/7jcCD7vTTHmN/T4jB1Gek
	+o8sh3JKuly7/EM0l3VI27WZodhwxjWaAc6jNW6/TiEMTZBc0VlmU7BDjvXTLQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1713505389;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pwFc3HvBM5e/MYXVzEFc0WpXcC13ZpOh67R7PvfUxA8=;
	b=qlC2QhgHw1VLNn3OF8UtVzH2xMDav2VyYtTG/2Wiv7VTn/nOjcdSwVUTf/yb9xjR4Yhhpa
	tbyqg5Vesx9KMBDA==
To: Oleg Nesterov <oleg@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Anna-Maria Behnsen
 <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>,
 John Stultz <jstultz@google.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>, Stephen Boyd <sboyd@kernel.org>, Eric
 Biederman <ebiederm@xmission.com>
Subject: Re: [patch V2 25/50] signal: Confine POSIX_TIMERS properly
In-Reply-To: <20240418152308.GA20625@redhat.com>
References: <20240410164558.316665885@linutronix.de>
 <20240410165552.509700441@linutronix.de>
 <20240418152308.GA20625@redhat.com>
Date: Fri, 19 Apr 2024 07:42:52 +0200
Message-ID: <87v84dx603.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Apr 18 2024 at 17:23, Oleg Nesterov wrote:
> On 04/11, Thomas Gleixner wrote:
>> +static inline void posixtimer_rearm_itimer(struct task_struct *p) { }
>> +static inline void posixtimer_rearm(struct kernel_siginfo *info) { }
>
> Do we really need these 2 nops ? please see below.

>> +		if (unlikely(signr == SIGALRM))
>> +			posixtimer_rearm_itimer(tsk);
>
> ...
>
>> +	if (IS_ENABLED(CONFIG_POSIX_TIMERS)) {
>> +		if (unlikely(resched_timer))
>> +			posixtimer_rearm(info);
>>  	}
>
> This looks a bit inconsistent to me.
>
> Can't we change the callsite of posixtimer_rearm_itimer() to check
> IS_ENABLED(CONFIG_POSIX_TIMERS) too,
>
> 		if (IS_ENABLED(CONFIG_POSIX_TIMERS)) {
> 			if (unlikely(signr == SIGALRM))
> 				posixtimer_rearm_itimer(tsk);
> 		}
> ?
>
> This will make the code more symmetrical, and we can avoid the dumb
> definitions of posixtimer_rearm_itimer/posixtimer_rearm.

Yes, we just need to expose the actual function prototypes
unconditionally. Let me fix that.

Thanks,

        tglx



