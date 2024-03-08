Return-Path: <linux-kernel+bounces-97479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C269876ADD
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 19:40:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 109941F20F42
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 18:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A46BC5F847;
	Fri,  8 Mar 2024 18:38:12 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E4A5A7BE;
	Fri,  8 Mar 2024 18:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709923090; cv=none; b=Eh8Q2ly/1d26hkh+n+097AWh0fw38l/dSUV8HRgEdkH/sXkNIEiM3QCC5BDocLOfxxHgJLf/IfU/9Q28i0R75C2vZUs+hTwhz91f1GoGCk3yQUcHlv/UTfAJlUty/vDOQerOsmuStjwoztGEMm9Umvi/Vblj4Cu99U9XkxcZxZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709923090; c=relaxed/simple;
	bh=fW3JUSq5PL2CmpW5Ijv9y1jq7wjI2I2L+cGV/dlor0Y=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=hZAAS6V1F20zRTDXSvLCP4iqsMW54s4M8ly3iWJ8N5UhUQErQYEf2jd/TkYi8jHi1/FpyF7nHC1bG3GbbBnHgjoPYZ2caugK57T5N53wYj1QXVfHb82s3G33FplOCI0/U4kKzryDBWhjbePxby8xjImwLvF6b4hqaQQxu2OCKnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BCCEC43609;
	Fri,  8 Mar 2024 18:38:10 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1rif8a-00000000xYC-0Q93;
	Fri, 08 Mar 2024 13:40:08 -0500
Message-ID: <20240308184007.965786478@goodmis.org>
User-Agent: quilt/0.67
Date: Fri, 08 Mar 2024 13:38:21 -0500
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
Subject: [PATCH 5/6] ring-buffer: Restructure ring_buffer_wait() to prepare for updates
References: <20240308183816.676883229@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

The ring_buffer_wait() needs to be broken into three functions for proper
synchronization from the context of the callers:

  ring_buffer_prepare_to_wait()
  ring_buffer_wait()
  ring_buffer_finish_wait()

To simplify the process, pull out the logic for getting the right work
queue to wait on, as it will be needed for the above functions.

There are three work queues depending on the cpu value.

If cpu == RING_BUFFER_ALL_CPUS, then the main "buffer->irq_work" is used.

Otherwise, the cpu_buffer representing the CPU buffer's irq_work is used.

Create a rb_get_work_queue() helper function to retrieve the proper queue.

Also rename "work" to "rbwork" as the variable point to struct rb_irq_work,
and to be more consistent with the variable naming elsewhere in the file.

Link: https://lore.kernel.org/all/CAHk-=whs5MdtNjzFkTyaUy=vHi=qwWgPi0JgTe6OYUYMNSRZfg@mail.gmail.com/

Cc: stable@vger.kernel.org
Fixes: f3ddb74ad0790 ("tracing: Wake up ring buffer waiters on closing of the file")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer.c | 58 +++++++++++++++++++++++---------------
 1 file changed, 35 insertions(+), 23 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index aa332ace108b..856d0e5b0da5 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -842,6 +842,31 @@ static bool rb_watermark_hit(struct trace_buffer *buffer, int cpu, int full)
 	return ret;
 }
 
+static struct rb_irq_work *
+rb_get_work_queue(struct trace_buffer *buffer, int cpu, int *full)
+{
+	struct ring_buffer_per_cpu *cpu_buffer;
+	struct rb_irq_work *rbwork;
+
+	/*
+	 * Depending on what the caller is waiting for, either any
+	 * data in any cpu buffer, or a specific buffer, put the
+	 * caller on the appropriate wait queue.
+	 */
+	if (cpu == RING_BUFFER_ALL_CPUS) {
+		rbwork = &buffer->irq_work;
+		/* Full only makes sense on per cpu reads */
+		*full = 0;
+	} else {
+		if (!cpumask_test_cpu(cpu, buffer->cpumask))
+			return ERR_PTR(-ENODEV);
+		cpu_buffer = buffer->buffers[cpu];
+		rbwork = &cpu_buffer->irq_work;
+	}
+
+	return rbwork;
+}
+
 /**
  * ring_buffer_wait - wait for input to the ring buffer
  * @buffer: buffer to wait on
@@ -854,31 +879,18 @@ static bool rb_watermark_hit(struct trace_buffer *buffer, int cpu, int full)
  */
 int ring_buffer_wait(struct trace_buffer *buffer, int cpu, int full)
 {
-	struct ring_buffer_per_cpu *cpu_buffer;
+	struct rb_irq_work *rbwork;
 	DEFINE_WAIT(wait);
-	struct rb_irq_work *work;
 	int ret = 0;
 
-	/*
-	 * Depending on what the caller is waiting for, either any
-	 * data in any cpu buffer, or a specific buffer, put the
-	 * caller on the appropriate wait queue.
-	 */
-	if (cpu == RING_BUFFER_ALL_CPUS) {
-		work = &buffer->irq_work;
-		/* Full only makes sense on per cpu reads */
-		full = 0;
-	} else {
-		if (!cpumask_test_cpu(cpu, buffer->cpumask))
-			return -ENODEV;
-		cpu_buffer = buffer->buffers[cpu];
-		work = &cpu_buffer->irq_work;
-	}
+	rbwork = rb_get_work_queue(buffer, cpu, &full);
+	if (IS_ERR(rbwork))
+		return PTR_ERR(rbwork);
 
 	if (full)
-		prepare_to_wait(&work->full_waiters, &wait, TASK_INTERRUPTIBLE);
+		prepare_to_wait(&rbwork->full_waiters, &wait, TASK_INTERRUPTIBLE);
 	else
-		prepare_to_wait(&work->waiters, &wait, TASK_INTERRUPTIBLE);
+		prepare_to_wait(&rbwork->waiters, &wait, TASK_INTERRUPTIBLE);
 
 	/*
 	 * The events can happen in critical sections where
@@ -901,9 +913,9 @@ int ring_buffer_wait(struct trace_buffer *buffer, int cpu, int full)
 	 * a task has been queued. It's OK for spurious wake ups.
 	 */
 	if (full)
-		work->full_waiters_pending = true;
+		rbwork->full_waiters_pending = true;
 	else
-		work->waiters_pending = true;
+		rbwork->waiters_pending = true;
 
 	if (rb_watermark_hit(buffer, cpu, full))
 		goto out;
@@ -916,9 +928,9 @@ int ring_buffer_wait(struct trace_buffer *buffer, int cpu, int full)
 	schedule();
  out:
 	if (full)
-		finish_wait(&work->full_waiters, &wait);
+		finish_wait(&rbwork->full_waiters, &wait);
 	else
-		finish_wait(&work->waiters, &wait);
+		finish_wait(&rbwork->waiters, &wait);
 
 	if (!ret && !rb_watermark_hit(buffer, cpu, full) && signal_pending(current))
 		ret = -EINTR;
-- 
2.43.0



