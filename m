Return-Path: <linux-kernel+bounces-104260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FDCA87CB5A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 11:29:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B64131F225AA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 10:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41E3018AED;
	Fri, 15 Mar 2024 10:29:04 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7F51863E;
	Fri, 15 Mar 2024 10:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710498543; cv=none; b=up4H9MCdF+4d28NmCHdgjcxcYIs27gfbxYi82vymR8LWs72kjiB6Ze/0iNzBYjQpHZkppStWQM1GjMF/BtcTtPvQMDB+6AClEC3KsQA52It/obQO98F17SyEBWXWh3IKlnuKnhjQtRoj3Femx8h2QGVBVRCDu6VTfby5HjAU9cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710498543; c=relaxed/simple;
	bh=3WPoU2IRaRoNJzkW982b30ioNCQ2MJj4TJ2/Ua8+G5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=RecVqOeKdY1syKIyn57PcqgD49Ojy3Kl6R7bIRlM6zkFSaZPMTJ36sq35TyGQ2FrDmyCQTCUYXcpaHEg4l+gmSoRX5kHT3lLeLl0cjDhFx8J5TgZlnrwczs8+MD/pXzUrdS1eM2mIdNc5zCzoP1S3xdJJxfVHhJQnj/I6qBY8nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCD7EC433C7;
	Fri, 15 Mar 2024 10:29:02 +0000 (UTC)
Date: Fri, 15 Mar 2024 06:31:15 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>
Subject: [PATCH] ring-buffer: Make wake once of ring_buffer_wait() more
 robust
Message-ID: <20240315063115.6cb5d205@gandalf.local.home>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

The default behavior of ring_buffer_wait() when passed a NULL "cond"
parameter is to exit the function the first time it is woken up. The
current implementation uses a counter that starts at zero and when it is
greater than one it exits the wait_event_interruptible().

But this relies on the internal working of wait_event_interruptible() as
that code basically has:

  if (cond)
    return;
  prepare_to_wait();
  if (!cond)
    schedule();
  finish_wait();

That is, cond is called twice before it sleeps. The default cond of
ring_buffer_wait() needs to account for that and wait for its counter to
increment twice before exiting.

Instead, use the seq/atomic_inc logic that is used by the tracing code
that calls this function. Add an atomic_t seq to rb_irq_work and when cond
is NULL, have the default callback take a descriptor as its data that
holds the rbwork and the value of the seq when it started.

The wakeups will now increment the rbwork->seq and the cond callback will
simply check if that number is different, and no longer have to rely on
the implementation of wait_event_interruptible().

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer.c | 34 +++++++++++++++++++++-------------
 1 file changed, 21 insertions(+), 13 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index f0f3577339b3..c8ff71d16a6e 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -388,6 +388,7 @@ struct rb_irq_work {
 	struct irq_work			work;
 	wait_queue_head_t		waiters;
 	wait_queue_head_t		full_waiters;
+	atomic_t			seq;
 	bool				waiters_pending;
 	bool				full_waiters_pending;
 	bool				wakeup_full;
@@ -763,6 +764,9 @@ static void rb_wake_up_waiters(struct irq_work *work)
 {
 	struct rb_irq_work *rbwork = container_of(work, struct rb_irq_work, work);
 
+	/* For waiters waiting for the first wake up */
+	(void)atomic_fetch_inc_release(&rbwork->seq);
+
 	wake_up_all(&rbwork->waiters);
 	if (rbwork->full_waiters_pending || rbwork->wakeup_full) {
 		/* Only cpu_buffer sets the above flags */
@@ -891,20 +895,21 @@ rb_wait_cond(struct rb_irq_work *rbwork, struct trace_buffer *buffer,
 	return false;
 }
 
+struct rb_wait_data {
+	struct rb_irq_work		*irq_work;
+	int				seq;
+};
+
 /*
  * The default wait condition for ring_buffer_wait() is to just to exit the
  * wait loop the first time it is woken up.
  */
 static bool rb_wait_once(void *data)
 {
-	long *once = data;
+	struct rb_wait_data *rdata = data;
+	struct rb_irq_work *rbwork = rdata->irq_work;
 
-	/* wait_event() actually calls this twice before scheduling*/
-	if (*once > 1)
-		return true;
-
-	(*once)++;
-	return false;
+	return atomic_read_acquire(&rbwork->seq) != rdata->seq;
 }
 
 /**
@@ -925,14 +930,9 @@ int ring_buffer_wait(struct trace_buffer *buffer, int cpu, int full,
 	struct ring_buffer_per_cpu *cpu_buffer;
 	struct wait_queue_head *waitq;
 	struct rb_irq_work *rbwork;
-	long once = 0;
+	struct rb_wait_data rdata;
 	int ret = 0;
 
-	if (!cond) {
-		cond = rb_wait_once;
-		data = &once;
-	}
-
 	/*
 	 * Depending on what the caller is waiting for, either any
 	 * data in any cpu buffer, or a specific buffer, put the
@@ -954,6 +954,14 @@ int ring_buffer_wait(struct trace_buffer *buffer, int cpu, int full,
 	else
 		waitq = &rbwork->waiters;
 
+	/* Set up to exit loop as soon as it is woken */
+	if (!cond) {
+		cond = rb_wait_once;
+		rdata.irq_work = rbwork;
+		rdata.seq = atomic_read_acquire(&rbwork->seq);
+		data = &rdata;
+	}
+
 	ret = wait_event_interruptible((*waitq),
 				rb_wait_cond(rbwork, buffer, cpu, full, cond, data));
 
-- 
2.43.0


