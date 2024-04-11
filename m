Return-Path: <linux-kernel+bounces-139618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 518E18A056E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 03:26:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CCB55B2494B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 01:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAF9A62171;
	Thu, 11 Apr 2024 01:26:26 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0329463;
	Thu, 11 Apr 2024 01:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712798786; cv=none; b=TJbQ2EH6RnQg49VrmDrBbINZDVjiKYNOLPkJYrzEIe+yDd50lmOe7zM5T5+4QVdIjs9e+mdfx/oJx8NmpvfwCk5x1Q0eMDNZHmW74sU1TQPX98XMwoQGfCvBvtWGqzb6SnidXYb/D3PpIfO7qDXEjq25nFmUpMvN2YPahpcFphg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712798786; c=relaxed/simple;
	bh=IlPKCSnTXcWRdfMJfl+v4+6ZAFaukIF1oqLA7Iz3tPQ=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=dgFNw6jujPlUW0MTFLiGqZTkvg4jE2Dohzj/AbDKs8SlJovOeJd8o7KNRyM8PGMwxIHYt+9Cl2yiG/uHzc3Y30qqoPYsHjKXqYH7oyUhqFavhoCb3xn9imMLrHi0Fsv3W5qDpKizIX1ec7efzgIO3RZY+JzzejPTdO46Zj1Fx0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F270DC433C7;
	Thu, 11 Apr 2024 01:26:25 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1rujFQ-00000000nUT-1Z1D;
	Wed, 10 Apr 2024 21:29:04 -0400
Message-ID: <20240411012904.237435058@goodmis.org>
User-Agent: quilt/0.67
Date: Wed, 10 Apr 2024 21:25:42 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Vincent Donnefort <vdonnefort@google.com>,
 Joel Fernandes <joel@joelfernandes.org>,
 Daniel Bristot de Oliveira <bristot@redhat.com>,
 Ingo Molnar <mingo@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 suleiman@google.com,
 Thomas Gleixner <tglx@linutronix.de>,
 Vineeth Pillai <vineeth@bitbyteword.org>,
 Youssef Esmat <youssefesmat@google.com>,
 Beau Belgrave <beaub@linux.microsoft.com>,
 Alexander Graf <graf@amazon.com>,
 Baoquan He <bhe@redhat.com>,
 Borislav Petkov <bp@alien8.de>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 David Howells <dhowells@redhat.com>
Subject: [PATCH v2 01/11] ring-buffer: Allow mapped field to be set without mapping
References: <20240411012541.285904543@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

In preparation for having the ring buffer mapped to a dedicated location,
which will have the same restrictions as user space memory mapped buffers,
allow it to use the "mapped" field of the ring_buffer_per_cpu structure
without having the user space meta page mapping.

When this starts using the mapped field, it will need to handle adding a
user space mapping (and removing it) from a ring buffer that is using a
dedicated memory range.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 793ecc454039..44b1d5f1a99a 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -5223,6 +5223,9 @@ static void rb_update_meta_page(struct ring_buffer_per_cpu *cpu_buffer)
 {
 	struct trace_buffer_meta *meta = cpu_buffer->meta_page;
 
+	if (!meta)
+		return;
+
 	meta->reader.read = cpu_buffer->reader_page->read;
 	meta->reader.id = cpu_buffer->reader_page->id;
 	meta->reader.lost_events = cpu_buffer->lost_events;
@@ -6167,7 +6170,7 @@ rb_get_mapped_buffer(struct trace_buffer *buffer, int cpu)
 
 	mutex_lock(&cpu_buffer->mapping_lock);
 
-	if (!cpu_buffer->mapped) {
+	if (!cpu_buffer->mapped || !cpu_buffer->meta_page) {
 		mutex_unlock(&cpu_buffer->mapping_lock);
 		return ERR_PTR(-ENODEV);
 	}
@@ -6345,12 +6348,13 @@ int ring_buffer_map(struct trace_buffer *buffer, int cpu,
 	 */
 	raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
 	rb_setup_ids_meta_page(cpu_buffer, subbuf_ids);
+
 	raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
 
 	err = __rb_map_vma(cpu_buffer, vma);
 	if (!err) {
 		raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
-		cpu_buffer->mapped = 1;
+		cpu_buffer->mapped++;
 		raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
 	} else {
 		kfree(cpu_buffer->subbuf_ids);
@@ -6388,7 +6392,7 @@ int ring_buffer_unmap(struct trace_buffer *buffer, int cpu)
 	mutex_lock(&buffer->mutex);
 	raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
 
-	cpu_buffer->mapped = 0;
+	cpu_buffer->mapped--;
 
 	raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
 
-- 
2.43.0



