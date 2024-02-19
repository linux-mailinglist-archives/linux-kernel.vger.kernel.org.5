Return-Path: <linux-kernel+bounces-71171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B15F685A199
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 12:03:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E38E61C212CE
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 11:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF96229424;
	Mon, 19 Feb 2024 11:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="km/R2N0W";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="W4XwrQWP"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7892EE572;
	Mon, 19 Feb 2024 11:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708340592; cv=none; b=X4yIi37FIG9li3KMlQtidXt+fKxfkQsdxo1TzSZ2KPGb1oKlcd80lb1AlP7awnvy5H28pLDFcwIZiH1E6xRJZCPxs8j/Yp3mBfi3Uv+fbfTTDzMqHz5gOxEN2ogHeLdFQPCh+/4H+ZeNtGNnBdc32YIUrGbOxUDS2sexbV4Yes8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708340592; c=relaxed/simple;
	bh=FmJQEyGJLQVLQYwch0n2HMhFM8e+cKsyEMeHqRiQ8SM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ddeTZWuWB+VX4txXf93QEcS2036swhX7Sfa/cK0lRrnkVuje5qhN582pEmz6ARUxxiBVUhzcSWlvpDbG25yu4n/jdejmGXnlrbu8gYcpbFGOo3kDRguy+6MR/20Jm8x0LkW+o84mpmZXpANw3/9r6aVAnuvN+UJGmXp55dMckn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=km/R2N0W; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=W4XwrQWP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708340587;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zKDld/uBnZjKtA3ymC1kDB57x1PvjJD6+IsbauqnIRc=;
	b=km/R2N0WeQl1h7yz5GnViOyv7tHLEwvzYLLabsfcjt2IUYyU2sVbYVViII9pL9a+1hoS6k
	sHJeBmxpSQEMjJ31AWpD7773/d94TU2p76eVW+0GdnqNLRhSqVoEBJJJIphQSGeouP3Nly
	Xl4WHudNOWljN1nOdgU1njWe8N7aEw1Daul6PfIhRVGSrIDAdc/KckanTTE/eYIpI1tRjR
	x/bhGxyNLcrwMnsZGDs/BZKvfIOUwMB6m+/XvPKDxceXwPwlpYrbHDWiRU/PLAkZ3xywjn
	4YrhVBf2SUNgEYaRzHKGg+BqugSuJkdz0PfPHU0mZ5MVuWYOQ20Ic4NojGByGA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708340587;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zKDld/uBnZjKtA3ymC1kDB57x1PvjJD6+IsbauqnIRc=;
	b=W4XwrQWPdPbbcWQ5uhHpV6oF0yPIWmY7na5LfqG+OiWCsL3D4e2qkqsujOrvpTnPSkMEKv
	HZdEgHYk2Jrf0AAA==
To: Leonardo Bras <leobras@redhat.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, Tony
 Lindgren <tony@atomide.com>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, John Ogness
 <john.ogness@linutronix.de>, Ilpo =?utf-8?Q?J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?=
 <u.kleine-koenig@pengutronix.de>, Leonardo Bras <leobras@redhat.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>, Shanker Donthineni
 <sdonthineni@nvidia.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [RFC PATCH v2 3/4] irq: Introduce IRQ_HANDLED_MANY
In-Reply-To: <87zfvwai62.ffs@tglx>
References: <20240216075948.131372-2-leobras@redhat.com>
 <20240216075948.131372-5-leobras@redhat.com> <87zfvwai62.ffs@tglx>
Date: Mon, 19 Feb 2024 12:03:07 +0100
Message-ID: <87v86kaf84.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Feb 19 2024 at 10:59, Thomas Gleixner wrote:
> On Fri, Feb 16 2024 at 04:59, Leonardo Bras wrote:
>
>> In threaded IRQs, some irq handlers are able to handle many requests at a
>> single run, but this is only accounted as a single IRQ_HANDLED when
>> increasing threads_handled.
>>
>> In order to fix this, introduce IRQ_HANDLED_MANY, so the returned value of
>> those IRQ handlers are able to signal that many IRQs got handled at that
>> run.
>>
>> Is scenarios where there is no need to keep track of IRQ handled, convert
>> it back to IRQ_HANDLED.
>
> That's not really workable as you'd have to update tons of drivers just
> to deal with that corner case. That's error prone and just extra
> complexity all over the place.
>
> This really needs to be solved in the core code.

Something like the uncompiled below should do the trick.

Thanks,

        tglx
---
--- a/include/linux/irqdesc.h
+++ b/include/linux/irqdesc.h
@@ -38,7 +38,8 @@ struct pt_regs;
  * @affinity_notify:	context for notification of affinity changes
  * @pending_mask:	pending rebalanced interrupts
  * @threads_oneshot:	bitfield to handle shared oneshot threads
- * @threads_active:	number of irqaction threads currently running
+ * @threads_active:	number of irqaction threads currently activated
+ * @threads_running:	number of irqaction threads currently running
  * @wait_for_threads:	wait queue for sync_irq to wait for threaded handlers
  * @nr_actions:		number of installed actions on this descriptor
  * @no_suspend_depth:	number of irqactions on a irq descriptor with
@@ -80,6 +81,7 @@ struct irq_desc {
 #endif
 	unsigned long		threads_oneshot;
 	atomic_t		threads_active;
+	atomic_t		threads_running;
 	wait_queue_head_t       wait_for_threads;
 #ifdef CONFIG_PM_SLEEP
 	unsigned int		nr_actions;
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -1194,9 +1194,11 @@ irq_forced_thread_fn(struct irq_desc *de
 	local_bh_disable();
 	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
 		local_irq_disable();
+	atomic_inc(&desc->threads_running);
 	ret = action->thread_fn(action->irq, action->dev_id);
 	if (ret == IRQ_HANDLED)
 		atomic_inc(&desc->threads_handled);
+	atomic_dec(&desc->threads_running);
 
 	irq_finalize_oneshot(desc, action);
 	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
--- a/kernel/irq/spurious.c
+++ b/kernel/irq/spurious.c
@@ -350,6 +350,12 @@ void note_interrupt(struct irq_desc *des
 				desc->threads_handled_last = handled;
 			} else {
 				/*
+				 * Avoid false positives when there is
+				 * actually a thread running.
+				 */
+				if (atomic_read(&desc->threads_running))
+					return;
+				/*
 				 * None of the threaded handlers felt
 				 * responsible for the last interrupt
 				 *

