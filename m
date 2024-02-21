Return-Path: <linux-kernel+bounces-75015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3346685E190
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 16:41:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56ECF1C244CD
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 15:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFAF280C06;
	Wed, 21 Feb 2024 15:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZblUllhk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OJnOGZeE"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE4D28063C;
	Wed, 21 Feb 2024 15:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708530085; cv=none; b=g/Vl4M6EKMo8W7buzeKaMvXfic2MHAfvc5O+zlhwcKqCQe8Pbs9oUG6qoXpUsFx/jW1SWsb7XmosZyklJkzwfwpBrIQzgNCpfX+Md0KnQ15t/NioFKv//AqLduqYRYIR17wSdLgDVxl1Om8wfKJuff7wSlEUsF7Yz/+5bHKLfPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708530085; c=relaxed/simple;
	bh=4WpiUaYI+0VESJus3SFDYesW7a2uVC3cvmvJ5OG3Lko=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=awaKMMgELeA4e1QWo4uWp8j3RloWmmSCkL1Qepg26Sp8H73I9n2PEtFJB9BfiZTWDPlNJszwan3qFhYofY3yk181l/djq6hSiw3qT3dGAyWtSrlLOMO0bwB6HfkPmCB7tCNO291hPx/NGXVyo4qduFTMHo3qI8I2JoeD+VIDTls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZblUllhk; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OJnOGZeE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708530080;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fqlpy9KL3u0uJLsW4Cc4qf151yuYzQL09JO0sHcv9PQ=;
	b=ZblUllhkt5YbGRE7ZfwS5niAPcBNQUrIIIdB1BmNeA3kyCbQCM2TMEgnIiPfMYTzTu6l6Q
	BMcayDQNzJpUZwpsUB+dwzHrlg4LAD8yOKf7taTauwcukKULKRnuhTWd5/WaKJ5l7AwpDK
	J+Gq/mmsxtqBrwBJuajODVkrNuZ2oHNjpRV0/r23C5x3an1HMR5UFd7PPrUmHJ+44osCgD
	s+CdUMOp/kruCfv9MeyiiCJRme9k6oowDv09t33I4u0RPvkhkn7xDWQ6+bWpzWbta3trCL
	BXWrqG0th0mjJFfQGE26uVdbuZuqELhi/QIVMp3jfh9JHUrs5nRT3ycxzEXn9A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708530080;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fqlpy9KL3u0uJLsW4Cc4qf151yuYzQL09JO0sHcv9PQ=;
	b=OJnOGZeEd2tKraVHqyoXE6MrUjcGLpty9CQg6vVNwFIc572sjh+EOcPUB8tJM4j2szW3e7
	xdKfCdXf6Tg/41DQ==
To: Leonardo Bras <leobras@redhat.com>
Cc: Leonardo Bras <leobras@redhat.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, Tony
 Lindgren <tony@atomide.com>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, John Ogness
 <john.ogness@linutronix.de>, Ilpo =?utf-8?Q?J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?=
 <u.kleine-koenig@pengutronix.de>, Florian Fainelli
 <florian.fainelli@broadcom.com>, Shanker Donthineni
 <sdonthineni@nvidia.com>, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org
Subject: Re: [RFC PATCH v2 3/4] irq: Introduce IRQ_HANDLED_MANY
In-Reply-To: <ZdWMja3BfCZsbF_q@LeoBras>
References: <20240216075948.131372-2-leobras@redhat.com>
 <20240216075948.131372-5-leobras@redhat.com> <87zfvwai62.ffs@tglx>
 <87v86kaf84.ffs@tglx> <ZdWMja3BfCZsbF_q@LeoBras>
Date: Wed, 21 Feb 2024 16:41:20 +0100
Message-ID: <87edd5hljz.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Feb 21 2024 at 02:39, Leonardo Bras wrote:
> On Mon, Feb 19, 2024 at 12:03:07PM +0100, Thomas Gleixner wrote:
>> >> Is scenarios where there is no need to keep track of IRQ handled, convert
>> >> it back to IRQ_HANDLED.
>> >
>> > That's not really workable as you'd have to update tons of drivers just
>> > to deal with that corner case. That's error prone and just extra
>> > complexity all over the place.
>
> I agree, that's a downside of this implementation. 

A serious one which is not really workable. See below.

> I agree the above may be able to solve the issue, but it would make 2 extra 
> atomic ops necessary in the thread handling the IRQ, as well as one extra 
> atomic operation in note_interrupt(), which could increase latency on this 
> IRQ deferring the handler to a thread.
>
> I mean, yes, the cpu running note_interrupt() would probably already have 
> exclusiveness for this cacheline, but it further increases cacheline 
> bouncing and also adds the mem barriers that incur on atomic operations, 
> even if we use an extra bit from threads_handled instead of allocate a new 
> field for threads_running.

I think that's a strawman. Atomic operations can of course be more
expensive than non-atomic ones, but they only start to make a difference
when the cache line is contended. That's not the case here for the
normal operations.

Interrupts and their threads are strictly targeted to a single CPU and
the cache line is already hot and had to be made exclusive because of
other write operations to it.

There is usually no concurrency at all, except for administrative
operations like enable/disable or affinity changes. Those administrative
operations are not high frequency and the resulting cache line bouncing
is unavoidable even without that change. But does it matter in the
larger picture? I don't think so.

> On top of that, let's think on a scenario where the threaded handler will 
> solve a lot of requests, but not necessarily spend a lot of time doing so.
> This allows the thread to run for little time while solving a lot of 
> requests.
>
> In this scenario, note_interrupt() could return without incrementing 
> irqs_unhandled for those IRQ that happen while the brief thread is running, 
> but every other IRQ would cause note_interrupt() to increase 
> irqs_unhandled, which would cause the bug to still reproduce.

In theory yes. Does it happen in practice?

But that exposes a flaw in the actual detection code. The code is
unconditionally accumulating if there is an unhandled interrupt within
100ms after the last unhandled one. IOW, if there is a periodic
unhandled one every 50ms, the interrupt will be shut down after 100000 *
50ms = 5000s ~= 83.3m ~= 1.4h. And it neither cares about the number of
actually handled interrupts.

The spurious detector is really about runaway interrupts which hog a CPU
completely, but the above is not what we want to protect against.

> I understand my suggested change increases irq_return complexity, but it
> should not increase much of the overhead in both IRQ deferring and IRQ 
> thread handling. Also, since it accounts for every IRQ actually handled, it 
> does not matter how long the handler thread runs, it still avoids the
> bug.

I'm not worried about the extra complexity in note_interrupt(). That's
fine and I don't have a strong opinion whether using your patch 2/4 or
the simpler one I suggested.

> As you previously noted, the main issue in my suggestion is about changing 
> drivers' code. But while this change is optional, I wonder how many 
> drivers handle IRQs that:
> - use edge type interrupts, and

It's not up to the driver to decide that. That's a platform property and
the driver does not even know and they should not care because all what
matters for the driver is that it gets the interrupts and does not lose
anything.

> - can trigger really fast, many many times, and

That's a hardware or emulation property and I don't know how many
devices would expose this behaviour.

> - can run in force-thread mode, and

Almost all drivers.

> - have handlers that are able to deal with multiple IRQs per call.

Pretty much every driver which has to deal with queues, FIFOs
etc. That's a lot of them.

> About solving it directly in generic code, I agree it would be the ideal 
> scenario. That's why I suggested that in RFCv1: if the thread handles a 
> single IRQ, we reset irqs_unhandled to zero. That's a good pointer on the 
> thread being stuck, and TBH I don't think this is too far away from the 
> current 100/100k if we consider some of those handlers can handle multiple 
> IRQs at once.

It has the downside that a scenario where there is a spurious interrupt
flood with an occasional one inbetween which is handled by the thread
will not be detected anymore. The accumulation and time period tracking
are there for a reason.

But as I pointed out above the detection logic is flawed due to the
unconditional accumulation. Can you give the uncompiled below a test
ride with your scenario?

Thanks,

        tglx
---
 include/linux/irqdesc.h |    2 ++
 kernel/irq/spurious.c   |   33 +++++++++++++++++++++++++++++----
 2 files changed, 31 insertions(+), 4 deletions(-)

--- a/include/linux/irqdesc.h
+++ b/include/linux/irqdesc.h
@@ -29,6 +29,7 @@ struct pt_regs;
  * @wake_depth:		enable depth, for multiple irq_set_irq_wake() callers
  * @tot_count:		stats field for non-percpu irqs
  * @irq_count:		stats field to detect stalled irqs
+ * @first_unhandled:	Timestamp of the first unhandled interrupt
  * @last_unhandled:	aging timer for unhandled count
  * @irqs_unhandled:	stats field for spurious unhandled interrupts
  * @threads_handled:	stats field for deferred spurious detection of threaded handlers
@@ -64,6 +65,7 @@ struct irq_desc {
 	unsigned int		wake_depth;	/* nested wake enables */
 	unsigned int		tot_count;
 	unsigned int		irq_count;	/* For detecting broken IRQs */
+	unsigned long		first_unhandled;
 	unsigned long		last_unhandled;	/* Aging timer for unhandled count */
 	unsigned int		irqs_unhandled;
 	atomic_t		threads_handled;
--- a/kernel/irq/spurious.c
+++ b/kernel/irq/spurious.c
@@ -390,9 +390,14 @@ void note_interrupt(struct irq_desc *des
 		 * working systems
 		 */
 		if (time_after(jiffies, desc->last_unhandled + HZ/10))
-			desc->irqs_unhandled = 1;
-		else
-			desc->irqs_unhandled++;
+			desc->irqs_unhandled = 0;
+
+		if (!desc->irqs_unhandled) {
+			desc->irq_count = 0;
+			desc->first_unhandled = jiffies;
+		}
+
+		desc->irqs_unhandled++;
 		desc->last_unhandled = jiffies;
 	}
 
@@ -411,9 +416,27 @@ void note_interrupt(struct irq_desc *des
 	if (likely(desc->irq_count < 100000))
 		return;
 
-	desc->irq_count = 0;
 	if (unlikely(desc->irqs_unhandled > 99900)) {
 		/*
+		 * Validate that this is actually an interrupt storm, which
+		 * happens to:
+		 *
+		 *  - increment the unhandled count to ~100k within 10 seconds
+		 *    which means there is an spurious interrupt every 50us
+		 *  - have an unhandled to handled ratio > 2
+		 *
+		 * Otherwise reset the detector and start over. This also
+		 * covers the case where a threaded handler consumes
+		 * several hard interrupts in one go which would otherwise
+		 * accumulate to 99900 over time and trigger a false positive.
+		 */
+		unsigned long td = desc->last_unhandled - desc->first_unhandled;
+		unsigned int handled = desc->irq_count - desc->irqs_unhandled;
+
+		if (td > 5 * HZ || desc->irqs_unhandled / handled < 3)
+			goto out;
+
+		/*
 		 * The interrupt is stuck
 		 */
 		__report_bad_irq(desc, action_ret);
@@ -428,7 +451,9 @@ void note_interrupt(struct irq_desc *des
 		mod_timer(&poll_spurious_irq_timer,
 			  jiffies + POLL_SPURIOUS_IRQ_INTERVAL);
 	}
+out:
 	desc->irqs_unhandled = 0;
+	desc->irq_count = 0;
 }
 
 bool noirqdebug __read_mostly;

