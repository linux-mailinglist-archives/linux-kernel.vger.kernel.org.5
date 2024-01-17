Return-Path: <linux-kernel+bounces-29511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AC0EF830F76
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 23:45:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8325B231DA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 22:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA5FB1E888;
	Wed, 17 Jan 2024 22:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="q5Nbd6aX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZlD9+QEh"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96BF1E876;
	Wed, 17 Jan 2024 22:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705531499; cv=none; b=JYEwBP6QeqUmIUjxoK144hYihFcHWt+7pnODgwWmGX+/KSzVsBckswgF294OpFaU2qp5hX1VhCbTy+ye/X94ZCqV4XThqe8SLxDM0+9f8F1Q1CsUHBeN4OuTsAhoN4UlHaiISFqsNYGSNQvRgpcC20W04UfQJVy5Ymqap1A6p5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705531499; c=relaxed/simple;
	bh=uo9ksenHf0PRrhzd7uNRhqtbQ/m5PRRiiMD8IzDJaPY=;
	h=From:DKIM-Signature:DKIM-Signature:To:Cc:Subject:In-Reply-To:
	 References:Date:Message-ID:MIME-Version:Content-Type; b=tgyHj9nn10FZk7Py2E5QvtN7l8JU6SVTioJXhOazkjpQ+bjHEExWSJIwnDBzG64meKRsipI68d5EuhSwPTGdVCrXKbbfMbnvWXN7v27GOTEx5lm/amEJ3yWA2f2eekMk/H3P19JGfotNpCfeO36FEAyl/hGyxnDilun2G3acwis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=q5Nbd6aX; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZlD9+QEh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1705531495;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qr3kH6h7RIJ2sdicFOor/RpNslyEnHGVdaaflfshLS8=;
	b=q5Nbd6aXGzNzRvYJi6G7PYohHTJzIRgJt6fVzRGuL/rAN9XneZSTUHLlGnQoHO+3kY1ke/
	V1zNuXWAGM1F84yMFkNT5s/I9PPtt4Mttgl+x9B/T6fF9aIFbDuejchtEsjrVNCm0PRXI3
	ebmQkASPnedXVAQSF/UQa5PP8N6xy5mzum5wrqVoBGnGjGVZ9dDQ1I24MLNPqIar0yEmjg
	BSTcORcrhXFtj8o/+f00oyXJ2r/+PSgnhvFbeXFQAoE+YKw9UD8rAchbUqLX6HyaZzqF4w
	hKKh4RT17T2wW+uQ7PNv2AmKvIxeikysPfbelvVxnX1q3vKWYJRSiUsHL0Mdzg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1705531495;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qr3kH6h7RIJ2sdicFOor/RpNslyEnHGVdaaflfshLS8=;
	b=ZlD9+QEhrSRD/um4Jdb5QhlmKaLo5cGlqQrsKtY+JOc2OZ2gIt6jQGqv7ylLRv0svjwOSo
	AYF5s5H0mv2K4QDw==
To: Leonardo Bras <leobras@redhat.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, Ilpo
 =?utf-8?Q?J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Florian Fainelli
 <f.fainelli@gmail.com>, John Ogness <john.ogness@linutronix.de>, Tony
 Lindgren <tony@atomide.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Sebastian
 Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [RESEND RFC PATCH v1 2/2] serial/8250: Avoid getting lock in RT
 atomic context
In-Reply-To: <20240116073701.2356171-3-leobras@redhat.com>
References: <20240116073701.2356171-1-leobras@redhat.com>
 <20240116073701.2356171-3-leobras@redhat.com>
Date: Wed, 17 Jan 2024 23:44:55 +0100
Message-ID: <87r0ifful4.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Jan 16 2024 at 04:37, Leonardo Bras wrote:
> With PREEMPT_RT enabled, a spin_lock_irqsave() becomes a possibly sleeping
> spin_lock(), without preempt_disable() or irq_disable().
>
> This allows a task T1 to get preempted or interrupted while holding the
> port->lock. If the preempting task T2 need the lock, spin_lock() code
> will schedule T1 back until it finishes using the lock, and then go back to
> T2.
>
> There is an issue if a T1 holding port->lock is interrupted by an
> IRQ, and this IRQ handler needs to get port->lock for writting (printk):
> spin_lock() code will try to reschedule the interrupt handler, which is in
> atomic context, causing a BUG() for trying to reschedule/sleep in atomic
> context.
>
> So for the case (PREEMPT_RT && in_atomic()) try to get the lock, and if it
> fails proceed anyway, just like it's done in oops_in_progress case.

That's just blantantly wrong. The locks are really only to be ignored
for the oops case, but not for regular printk.

I assume that this is not against the latest RT kernel as that should
not have that problem at all.

Thanks,

        tglx

