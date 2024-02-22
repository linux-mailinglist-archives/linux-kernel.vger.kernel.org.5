Return-Path: <linux-kernel+bounces-76762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B06CC85FC23
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 16:18:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D35D01C247DE
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 15:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 781B714C5A6;
	Thu, 22 Feb 2024 15:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AtRvhUD2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2ZFYFNdm"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E434614C59B
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 15:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708615044; cv=none; b=QcOrM2tWdJ8cQlxWoZofTyDEOSQv3gUdpipYI9AjZrqHeu2FINvQmB3RrfJ6pjqTQ4g0GX8pWoo20s+imlEgBr8JpZj5u0ryZVrOGTAHRrQa0ojQmx/+okp/KKdAqKPZniTw2nlAloczP18B+XDK97MsgfokBRG+Tmir5veuHq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708615044; c=relaxed/simple;
	bh=rNZr/qFbvQHD7VbWILK52ET8FPFhOj9+F1CVqYpT9f0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DyCNJXQThFRg3KfScPhWFAvMZa0XZ+Vuxvcp9bmrPWefeYIuT77Nj2Gc2DTK/4zgifjjdsb2rsgnHS7jOMzMNhdgy6PdoN8RyV1LAuSAxZc1+WZl6uT/9DNbpe4Hnm5d2l+GbW42OUrLWP6ZJLDpBYcUliDs+vabIHI0VPwHmX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AtRvhUD2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2ZFYFNdm; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708615041;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JqXgMEODvPqPWYehMT24n8azEjHEKTzJ7cm4bihqX5A=;
	b=AtRvhUD2TcijhmJTc2X2hbKB5Qiw5lbsMzLyZSv3kYjk6+Ek+7o0Rhd3/c391N+BwFtmeP
	OgXY4RiLCjegmvreLavnTKvPx5Ftre63el61eNLf0Z/pRdCcJtGp1LO73ypE7uBSq0vbTF
	r4XOAL9AN/zgAkaaAWhSKHbmrnybcqlEjNRL9784LpmM27NnHPpyoHcRl263XT9Rsuc1ZB
	p/Pl+cU0UZL6h+7L29nadqdDEeoGWCbHl4cYAHhiubfdNAZ+MvQvBA59WwIPPe0T9kZoZ+
	QaJfDH6dzH1+Rk480UNdoDKy6XAo+Xfg21jttdh/AlIAFFRvnoM2UDbu8bun9g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708615041;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JqXgMEODvPqPWYehMT24n8azEjHEKTzJ7cm4bihqX5A=;
	b=2ZFYFNdmrBhxKjlPD+VSEjVhYQRF7PKVsIHqOr4x3DFyvOAhNySXWUnlmIk5zOcj7LW8Ee
	AfiaE5DBj/sUTODw==
To: John Stultz <jstultz@google.com>, LKML <linux-kernel@vger.kernel.org>
Cc: John Stultz <jstultz@google.com>, Frederic Weisbecker
 <frederic@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 kernel-team@android.com, John Ogness <jogness@linutronix.de>
Subject: Re: [RFC][PATCH] hrtimer: Use printk_deferred_once for
 hrtimer_interrupt message
In-Reply-To: <20240222051253.1361002-1-jstultz@google.com>
References: <20240222051253.1361002-1-jstultz@google.com>
Date: Thu, 22 Feb 2024 16:17:20 +0100
Message-ID: <8734tkfrzz.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Feb 21 2024 at 21:12, John Stultz wrote:

Cc+ John. Keeping context intact,

> With qemu, I constantly see lockdep warnings after the
> hrimter_interrupt message is printed:
>
> [   43.434557] hrtimer: interrupt took 6517564 ns
> [   43.435000]
> [   43.435000] =============================
> [   43.435000] [ BUG: Invalid wait context ]

Do you have PROVE_RAW_LOCK_NESTING enabled?

> [   43.435000] 6.8.0-rc5-00002-g28763ef29a5b #3743 Not tainted
> [   43.435000] -----------------------------
> [   43.435000] lock_torture_wr/605 is trying to lock:
> [   43.435000] ffffffffbdcdc6f8 (&port_lock_key){-...}-{3:3}, at: serial8250_console_write+0xdd/0x710
> [   43.435000] other info that might help us debug this:
> [   43.435000] context-{2:2}
> [   43.435000] 4 locks held by lock_torture_wr/605:
> [   43.435000]  #0: ffffffffbd6f1de8 (torture_mutex_init#4){+.+.}-{4:4}, at: torture_mutex_nested_lock+0x4b/0x70
> [   43.435000]  #1: ffffffffbb557260 (console_lock){+.+.}-{0:0}, at: vprintk_emit+0xd3/0x330
> [   43.435000]  #2: ffffffffbb5572d0 (console_srcu){....}-{0:0}, at: console_flush_all+0xd6/0x6b0
> [   43.435000]  #3: ffffffffbb396e20 (console_owner){-...}-{0:0}, at: console_flush_all+0x2a0/0x6b0
> [   43.435000] stack backtrace:
> [   43.435000] CPU: 36 PID: 605 Comm: lock_torture_wr Not tainted 6.8.0-rc5-00002-g28763ef29a5b #3743
> [   43.435000] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> [   43.435000] Call Trace:
> [   43.435000]  <IRQ>
> [   43.435000]  dump_stack_lvl+0x57/0x90
> [   43.435000]  __lock_acquire+0xd07/0x3260
> [   43.435000]  ? __pfx___lock_acquire+0x10/0x10
> [   43.435000]  ? memchr+0x1e/0x50
> [   43.435000]  lock_acquire+0x159/0x3b0
> [   43.435000]  ? serial8250_console_write+0xdd/0x710
> [   43.435000]  ? __pfx_lock_acquire+0x10/0x10
> [   43.435000]  ? __pfx___lock_acquire+0x10/0x10
> [   43.435000]  _raw_spin_lock_irqsave+0x42/0x60
> [   43.435000]  ? serial8250_console_write+0xdd/0x710
> [   43.435000]  serial8250_console_write+0xdd/0x710
> [   43.435000]  ? __pfx_serial8250_console_write+0x10/0x10
> [   43.435000]  ? __pfx_lock_release+0x10/0x10
> [   43.435000]  ? do_raw_spin_lock+0x104/0x180
> [   43.435000]  ? __pfx_do_raw_spin_lock+0x10/0x10
> [   43.435000]  ? console_flush_all+0x2a0/0x6b0
> [   43.435000]  console_flush_all+0x2ea/0x6b0
> [   43.435000]  ? console_flush_all+0x2a0/0x6b0
> [   43.435000]  ? __pfx_console_flush_all+0x10/0x10
> [   43.435000]  ? __pfx_lock_acquire+0x10/0x10
> [   43.435000]  console_unlock+0x9d/0x150
> [   43.435000]  ? __pfx_console_unlock+0x10/0x10
> [   43.435000]  ? vprintk_emit+0xd3/0x330
> [   43.435000]  ? __down_trylock_console_sem+0x62/0xa0
> [   43.435000]  ? vprintk_emit+0xd3/0x330
> [   43.435000]  vprintk_emit+0xdc/0x330
> [   43.435000]  _printk+0x92/0xb0
> [   43.435000]  ? __pfx__printk+0x10/0x10
> [   43.435000]  ? hrtimer_interrupt+0x2f0/0x360
> [   43.439262]  __sysvec_apic_timer_interrupt+0xb8/0x290
> [   43.439345]  sysvec_apic_timer_interrupt+0x8a/0xb0
> [   43.439345]  </IRQ>
> [   43.439345]  <TASK>
> [   43.439345]  asm_sysvec_apic_timer_interrupt+0x16/0x20
>
> I thought the new printk work was going to resolve this, but
> apparently not, so to avoid trying to printk in this problematic
> context, lets use prink_deferred_once() instead.
>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Frederic Weisbecker <frederic@kernel.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: kernel-team@android.com
> Signed-off-by: John Stultz <jstultz@google.com>
> ---
>  kernel/time/hrtimer.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
> index edb0f821dcea..e6b060403384 100644
> --- a/kernel/time/hrtimer.c
> +++ b/kernel/time/hrtimer.c
> @@ -1870,7 +1870,8 @@ void hrtimer_interrupt(struct clock_event_device *dev)
>  	else
>  		expires_next = ktime_add(now, delta);
>  	tick_program_event(expires_next, 1);
> -	pr_warn_once("hrtimer: interrupt took %llu ns\n", ktime_to_ns(delta));
> +	printk_deferred_once(KERN_WARNING "hrtimer: interrupt took %llu ns\n",
> +			     ktime_to_ns(delta));
>  }
>  
>  /* called with interrupts disabled */

