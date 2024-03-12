Return-Path: <linux-kernel+bounces-100280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39BFA8794F2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 14:18:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 610071C21BAA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 13:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3577B7A710;
	Tue, 12 Mar 2024 13:17:47 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE5F6997E;
	Tue, 12 Mar 2024 13:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710249466; cv=none; b=Gp1/EnvxFFvlREGs/oAyN9IufrVAKCEnkkzk1AqvUtpTu5CG8jeo2uMQXc2j0N1bbX9ppDpOdjhu4X+eIuRAlfflvlRj5nIEiXvYxxLJqNGPVVchnJEdWzIlJfP1TEsGFlQ4elQ2zI4tDt7DVX5jPHgwkXAlN6slDGS90C8I7xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710249466; c=relaxed/simple;
	bh=AA3vT42uXJUTEwQhKXY70OTOE0y5XchQ4pdvFf+D2J4=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=ahtqkF8ODKclxngUPIYTsVlOo3jmThWqJPcWVV/3q8a+doMvlt3xuRQCSf5136pia9gQzAQzYAxoIH0NExa+xNYMWO854nUm92dly3DEaH4KTK/rGM0gnpxDiYB3obI6luQd2v99bzWAJRqiYA465/xyTfXtMlas01U6xye6sXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F4C3C43390;
	Tue, 12 Mar 2024 13:17:46 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1rk22q-00000001vJn-3HFz;
	Tue, 12 Mar 2024 09:19:52 -0400
Message-ID: <20240312131952.630922155@goodmis.org>
User-Agent: quilt/0.67
Date: Tue, 12 Mar 2024 09:19:20 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org
Subject: [PATCH v2 1/2] ring-buffer: Fix full_waiters_pending in poll
References: <20240312131919.314231457@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

If a reader of the ring buffer is doing a poll, and waiting for the ring
buffer to hit a specific watermark, there could be a case where it gets
into an infinite ping-pong loop.

The poll code has:

  rbwork->full_waiters_pending = true;
  if (!cpu_buffer->shortest_full ||
      cpu_buffer->shortest_full > full)
         cpu_buffer->shortest_full = full;

The writer will see full_waiters_pending and check if the ring buffer is
filled over the percentage of the shortest_full value. If it is, it calls
an irq_work to wake up all the waiters.

But the code could get into a circular loop:

	CPU 0					CPU 1
	-----					-----
 [ Poll ]
   [ shortest_full = 0 ]
   rbwork->full_waiters_pending = true;
					  if (rbwork->full_waiters_pending &&
					      [ buffer percent ] > shortest_full) {
					         rbwork->wakeup_full = true;
					         [ queue_irqwork ]

   cpu_buffer->shortest_full = full;

					  [ IRQ work ]
					  if (rbwork->wakeup_full) {
					        cpu_buffer->shortest_full = 0;
					        wakeup poll waiters;
  [woken]
   if ([ buffer percent ] > full)
      break;
   rbwork->full_waiters_pending = true;
					  if (rbwork->full_waiters_pending &&
					      [ buffer percent ] > shortest_full) {
					         rbwork->wakeup_full = true;
					         [ queue_irqwork ]

   cpu_buffer->shortest_full = full;

					  [ IRQ work ]
					  if (rbwork->wakeup_full) {
					        cpu_buffer->shortest_full = 0;
					        wakeup poll waiters;
  [woken]

 [ Wash, rinse, repeat! ]

In the poll, the shortest_full needs to be set before the
full_pending_waiters, as once that is set, the writer will compare the
current shortest_full (which is incorrect) to decide to call the irq_work,
which will reset the shortest_full (expecting the readers to update it).

Also move the setting of full_waiters_pending after the check if the ring
buffer has the required percentage filled. There's no reason to tell the
writer to wake up waiters if there are no waiters.

Cc: stable@vger.kernel.org
Fixes: 42fb0a1e84ff5 ("tracing/ring-buffer: Have polling block on watermark")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer.c | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index aa332ace108b..adfe603a769b 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -964,16 +964,32 @@ __poll_t ring_buffer_poll_wait(struct trace_buffer *buffer, int cpu,
 		poll_wait(filp, &rbwork->full_waiters, poll_table);
 
 		raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
-		rbwork->full_waiters_pending = true;
 		if (!cpu_buffer->shortest_full ||
 		    cpu_buffer->shortest_full > full)
 			cpu_buffer->shortest_full = full;
 		raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
-	} else {
-		poll_wait(filp, &rbwork->waiters, poll_table);
-		rbwork->waiters_pending = true;
+		if (full_hit(buffer, cpu, full))
+			return EPOLLIN | EPOLLRDNORM;
+		/*
+		 * Only allow full_waiters_pending update to be seen after
+		 * the shortest_full is set. If the writer sees the
+		 * full_waiters_pending flag set, it will compare the
+		 * amount in the ring buffer to shortest_full. If the amount
+		 * in the ring buffer is greater than the shortest_full
+		 * percent, it will call the irq_work handler to wake up
+		 * this list. The irq_handler will reset shortest_full
+		 * back to zero. That's done under the reader_lock, but
+		 * the below smp_mb() makes sure that the update to
+		 * full_waiters_pending doesn't leak up into the above.
+		 */
+		smp_mb();
+		rbwork->full_waiters_pending = true;
+		return 0;
 	}
 
+	poll_wait(filp, &rbwork->waiters, poll_table);
+	rbwork->waiters_pending = true;
+
 	/*
 	 * There's a tight race between setting the waiters_pending and
 	 * checking if the ring buffer is empty.  Once the waiters_pending bit
@@ -989,9 +1005,6 @@ __poll_t ring_buffer_poll_wait(struct trace_buffer *buffer, int cpu,
 	 */
 	smp_mb();
 
-	if (full)
-		return full_hit(buffer, cpu, full) ? EPOLLIN | EPOLLRDNORM : 0;
-
 	if ((cpu == RING_BUFFER_ALL_CPUS && !ring_buffer_empty(buffer)) ||
 	    (cpu != RING_BUFFER_ALL_CPUS && !ring_buffer_empty_cpu(buffer, cpu)))
 		return EPOLLIN | EPOLLRDNORM;
-- 
2.43.0



