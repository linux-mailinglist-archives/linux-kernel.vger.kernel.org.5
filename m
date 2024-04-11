Return-Path: <linux-kernel+bounces-141657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B44668A218A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 00:02:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E48951C21890
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 22:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EA7A3B295;
	Thu, 11 Apr 2024 22:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kH3vamkr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sHxB9WKJ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE7A2335DB
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 22:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712872952; cv=none; b=XVuGnztP1R2Xma7AMBLewmuqQlRj5vIzusVVimevi/FAj/UuqJJ/anp8RTEOFmAHCs6Jb21np2T/bZhzlzx+y9H66QWRN04NIlSuFUN2gVewGLVW4AaMWNJUITCTIxQxsUfPO0ztEvqYt3dp328d2xuJ6W5Ly+T7Qo9/S37igbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712872952; c=relaxed/simple;
	bh=TCfpmkNbXZg9S1OkDm7bfoX9eNqr+D7wDqMO4QFGPj4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rVqoTuADpv4ZuDsuboPrfKX0utBouCb0r2YqIx8hweAuhzezGrWntWHg5VArLycx+925Cb7YZNa9+Q5gFwJJRV3VP9mQdbsnfQde4O35KEOdeEZ7gxj8bjzr50KtkrrzmigHyCbPCrndld+RGhVczWns8nQoBwbdNw+EA7oCOn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kH3vamkr; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sHxB9WKJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712872949;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hINm3VgQ/iC6NoqwrzPmAm3wluW8FRV5SPabfp2G4Gg=;
	b=kH3vamkrl06XlfoOKfM24LZgFpbciy1x6UL2uypn0k+Yq0bZxfqlSH+YQESS6gt0UlYqxl
	DJm+tZXQhFj31oRRpedNmux7RKAuLWehq5UZKaXYTyThx/kTSm3/7BqJGNt/IVYLjirIfb
	kN2zdMDYga7obVKmHPfWGLYMVQU1uemB0nw4dAAHfDffNSt/JOiFNbtUY994BMvkSGE4Il
	EC61fnfII6yl1+wtH7Zk0qVUR+SjHFYfBeLMxfvzRBUpBWOq4xCdMV+XUvWtyocjvqFcfU
	3EuFnqxDetof3nSc7qygV1sxYzMApgOyMaY2OKrJUfUY8If6BsnX0Fo+16r0Ng==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712872949;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hINm3VgQ/iC6NoqwrzPmAm3wluW8FRV5SPabfp2G4Gg=;
	b=sHxB9WKJKQ2xlGJZC354hn/1JFfYSX4YScgHtT+oeovXlRAO6oq5UkUNXnLrqwZ+mKMZ32
	WPuaHPioqoL80JAw==
To: Anna-Maria Behnsen <anna-maria@linutronix.de>, LKML
 <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>, John Stultz
 <jstultz@google.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar
 <mingo@kernel.org>, Stephen Boyd <sboyd@kernel.org>, Eric Biederman
 <ebiederm@xmission.com>, Oleg Nesterov <oleg@redhat.com>
Subject: Re: [patch V2 11/50] posix-cpu-timers: Handle SIGEV_NONE timers
 correctly in timer_set()
In-Reply-To: <8734rrvr1p.fsf@somnus>
References: <20240410164558.316665885@linutronix.de>
 <20240410165551.635345704@linutronix.de> <8734rrvr1p.fsf@somnus>
Date: Fri, 12 Apr 2024 00:02:28 +0200
Message-ID: <87zftzzhfv.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Apr 11 2024 at 17:48, Anna-Maria Behnsen wrote:

> Thomas Gleixner <tglx@linutronix.de> writes:
>
>> Expired SIGEV_NONE oneshot timers must return 0 nsec for the expiry time in
>> timer_get(), but the posix CPU timer implementation returns 1 nsec.
>
> copy paste error (get/set) ?

Yes.

>> Add the missing conditional.
>>
>> This will be cleaned up in a follow up patch.
>
> I'm confused. Why do you want to cleanup the conditional in a follow up
> patch?

This patch is to fix the issue. The next one consolidates the code, but
I can see why the "this will be ..." part of the changelog does not make
sense.

Thanks,

        tglx

