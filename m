Return-Path: <linux-kernel+bounces-5929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BAA08191A3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 21:38:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C98AC1F250CA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 20:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59B0039AD7;
	Tue, 19 Dec 2023 20:38:28 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECEC91DFEF;
	Tue, 19 Dec 2023 20:38:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC630C433C8;
	Tue, 19 Dec 2023 20:38:26 +0000 (UTC)
Date: Tue, 19 Dec 2023 15:39:24 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Vincent Donnefort <vdonnefort@google.com>
Cc: mhiramat@kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v8 0/2] Introducing trace buffer mapping by user-space
Message-ID: <20231219153924.2ff9c132@gandalf.local.home>
In-Reply-To: <20231219184556.1552951-1-vdonnefort@google.com>
References: <20231219184556.1552951-1-vdonnefort@google.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 19 Dec 2023 18:45:54 +0000
Vincent Donnefort <vdonnefort@google.com> wrote:

> The tracing ring-buffers can be stored on disk or sent to network
> without any copy via splice. However the later doesn't allow real time
> processing of the traces. A solution is to give userspace direct access
> to the ring-buffer pages via a mapping. An application can now become a
> consumer of the ring-buffer, in a similar fashion to what trace_pipe
> offers.
> 
> Attached to this cover letter an example of consuming read for a
> ring-buffer, using libtracefs.
> 

I'm still testing this, but I needed to add this patch to fix two bugs. One
is that you are calling rb_wakeup_waiters() for both the buffer and the
cpu_buffer, and it needs to know which one to use the container_of() macro.

The other is a "goto unlock" that unlocks two locks where only one was taken.

-- Steve

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 35f3736f660b..987ad7bd1e8b 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -389,6 +389,7 @@ struct rb_irq_work {
 	bool				waiters_pending;
 	bool				full_waiters_pending;
 	bool				wakeup_full;
+	bool				is_cpu_buffer;
 };
 
 /*
@@ -771,10 +772,20 @@ static void rb_update_meta_page(struct ring_buffer_per_cpu *cpu_buffer)
 static void rb_wake_up_waiters(struct irq_work *work)
 {
 	struct rb_irq_work *rbwork = container_of(work, struct rb_irq_work, work);
-	struct ring_buffer_per_cpu *cpu_buffer =
-		container_of(rbwork, struct ring_buffer_per_cpu, irq_work);
+	struct ring_buffer_per_cpu *cpu_buffer;
+	struct trace_buffer *buffer;
+	int cpu;
 
-	rb_update_meta_page(cpu_buffer);
+	if (rbwork->is_cpu_buffer) {
+		cpu_buffer = container_of(rbwork, struct ring_buffer_per_cpu, irq_work);
+		rb_update_meta_page(cpu_buffer);
+	} else {
+		buffer = container_of(rbwork, struct trace_buffer, irq_work);
+		for_each_buffer_cpu(buffer, cpu) {
+			cpu_buffer = buffer->buffers[cpu];
+			rb_update_meta_page(cpu_buffer);
+		}
+	}
 
 	wake_up_all(&rbwork->waiters);
 	if (rbwork->full_waiters_pending || rbwork->wakeup_full) {
@@ -1569,6 +1580,7 @@ rb_allocate_cpu_buffer(struct trace_buffer *buffer, long nr_pages, int cpu)
 	init_waitqueue_head(&cpu_buffer->irq_work.waiters);
 	init_waitqueue_head(&cpu_buffer->irq_work.full_waiters);
 	mutex_init(&cpu_buffer->mapping_lock);
+	cpu_buffer->irq_work.is_cpu_buffer = true;
 
 	bpage = kzalloc_node(ALIGN(sizeof(*bpage), cache_line_size()),
 			    GFP_KERNEL, cpu_to_node(cpu));
@@ -6209,7 +6221,8 @@ int ring_buffer_map(struct trace_buffer *buffer, int cpu)
 
 	if (cpu_buffer->mapped) {
 		WRITE_ONCE(cpu_buffer->mapped, cpu_buffer->mapped + 1);
-		goto unlock;
+		mutex_unlock(&cpu_buffer->mapping_lock);
+		return 0;
 	}
 
 	/* prevent another thread from changing buffer sizes */

