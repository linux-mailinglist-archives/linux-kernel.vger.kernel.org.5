Return-Path: <linux-kernel+bounces-97542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A89B876BB1
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 21:22:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA7961C2148E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 20:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8EBB5DF0D;
	Fri,  8 Mar 2024 20:22:34 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EBB95B5B6;
	Fri,  8 Mar 2024 20:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709929354; cv=none; b=n6aPU0I4UGoUmTVgIow5I7QTLYxBw20mIEnx3kLsLCpsMJkk9KRuwPhYeQ0In5M8jWZbYO6HLb9Y5iXhZg+XH28jjHgE80LQiNiiVh3WkBFRLtzAA5xrmxadlx6MEaL+m7wuaNHAfwQLYjxaVDLiwpcQ3HZ0XhoMcFfEsHl3wxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709929354; c=relaxed/simple;
	bh=SQZPmEU5CwKqztEWl21VXR8GE8WnQcVyo6qkErwEmPA=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=Eq0kEj6+Eda1DDrPNycZ/M/fgMhc+VxSPVCGzw1VhjQFuqRjw71Cn1BkjKdtfuRnt/GF6OUgrGLO9Pohgu6TaTaClmixtySlvUuHOk+y3mg6PgjlbkZPnmNAnobNJ0cSmOEG0DzMI/hxC+meexK/fNPrENgXf9GKNrkXTQA03+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 235DDC433A6;
	Fri,  8 Mar 2024 20:22:34 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1riglc-00000000yr9-0Mxd;
	Fri, 08 Mar 2024 15:24:32 -0500
Message-ID: <20240308202431.948914369@goodmis.org>
User-Agent: quilt/0.67
Date: Fri, 08 Mar 2024 15:24:04 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 joel@joelfernandes.org,
 linke li <lilinke99@qq.com>,
 Rabin Vincent <rabin@rab.in>,
 stable@vger.kernel.org
Subject: [PATCH v2 2/6] ring-buffer: Fix resetting of shortest_full
References: <20240308202402.234176464@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

The "shortest_full" variable is used to keep track of the waiter that is
waiting for the smallest amount on the ring buffer before being woken up.
When a tasks waits on the ring buffer, it passes in a "full" value that is
a percentage. 0 means wake up on any data. 1-100 means wake up from 1% to
100% full buffer.

As all waiters are on the same wait queue, the wake up happens for the
waiter with the smallest percentage.

The problem is that the smallest_full on the cpu_buffer that stores the
smallest amount doesn't get reset when all the waiters are woken up. It
does get reset when the ring buffer is reset (echo > /sys/kernel/tracing/trace).

This means that tasks may be woken up more often then when they want to
be. Instead, have the shortest_full field get reset just before waking up
all the tasks. If the tasks wait again, they will update the shortest_full
before sleeping.

Also add locking around setting of shortest_full in the poll logic, and
change "work" to "rbwork" to match the variable name for rb_irq_work
structures that are used in other places.

Link: https://lore.kernel.org/linux-trace-kernel/20240308184007.485732758@goodmis.org

Cc: stable@vger.kernel.org
Fixes: 2c2b0a78b3739 ("ring-buffer: Add percentage of ring buffer full to wake up reader")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer.c | 30 +++++++++++++++++++++++-------
 1 file changed, 23 insertions(+), 7 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 3400f11286e3..aa332ace108b 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -755,8 +755,19 @@ static void rb_wake_up_waiters(struct irq_work *work)
 
 	wake_up_all(&rbwork->waiters);
 	if (rbwork->full_waiters_pending || rbwork->wakeup_full) {
+		/* Only cpu_buffer sets the above flags */
+		struct ring_buffer_per_cpu *cpu_buffer =
+			container_of(rbwork, struct ring_buffer_per_cpu, irq_work);
+
+		/* Called from interrupt context */
+		raw_spin_lock(&cpu_buffer->reader_lock);
 		rbwork->wakeup_full = false;
 		rbwork->full_waiters_pending = false;
+
+		/* Waking up all waiters, they will reset the shortest full */
+		cpu_buffer->shortest_full = 0;
+		raw_spin_unlock(&cpu_buffer->reader_lock);
+
 		wake_up_all(&rbwork->full_waiters);
 	}
 }
@@ -934,28 +945,33 @@ __poll_t ring_buffer_poll_wait(struct trace_buffer *buffer, int cpu,
 			  struct file *filp, poll_table *poll_table, int full)
 {
 	struct ring_buffer_per_cpu *cpu_buffer;
-	struct rb_irq_work *work;
+	struct rb_irq_work *rbwork;
 
 	if (cpu == RING_BUFFER_ALL_CPUS) {
-		work = &buffer->irq_work;
+		rbwork = &buffer->irq_work;
 		full = 0;
 	} else {
 		if (!cpumask_test_cpu(cpu, buffer->cpumask))
 			return EPOLLERR;
 
 		cpu_buffer = buffer->buffers[cpu];
-		work = &cpu_buffer->irq_work;
+		rbwork = &cpu_buffer->irq_work;
 	}
 
 	if (full) {
-		poll_wait(filp, &work->full_waiters, poll_table);
-		work->full_waiters_pending = true;
+		unsigned long flags;
+
+		poll_wait(filp, &rbwork->full_waiters, poll_table);
+
+		raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
+		rbwork->full_waiters_pending = true;
 		if (!cpu_buffer->shortest_full ||
 		    cpu_buffer->shortest_full > full)
 			cpu_buffer->shortest_full = full;
+		raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
 	} else {
-		poll_wait(filp, &work->waiters, poll_table);
-		work->waiters_pending = true;
+		poll_wait(filp, &rbwork->waiters, poll_table);
+		rbwork->waiters_pending = true;
 	}
 
 	/*
-- 
2.43.0



