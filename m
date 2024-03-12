Return-Path: <linux-kernel+bounces-100864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A31F9879E5E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 23:20:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EE3D284C2F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 22:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6F76144048;
	Tue, 12 Mar 2024 22:20:16 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D7C143C6F
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 22:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710282016; cv=none; b=q9PQmpkGA8F0Fdhcl+MJR/FR7jI8LdwJYqoLF/Rke5wWU94Z/mZRzMlF5FZJsC8eAyxhseuZtz+HwkskW4v0hZfX9BeTx7K4LfsaK5MRmIqns6s8g5Dd+litRwe+KWDPPoEx0rccAYheIsVLVH8jetkX6Uil7ASAnBdyn0w3zQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710282016; c=relaxed/simple;
	bh=Fn4AJ/vrIiVdY+JUXJRLI5EIHGywgJFTV5iUg9TbdC8=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=nOD9TZ0dLHPtPBnL7/hYw96LZb72A9k4FLket3SjBzJn+UIPkQ7fCd8e68vb41IKHzEXdXhwSMBoRBsCszA4WHYpw/K74sHf9qloCpr04dkrqFQqa8yEShzQQuJER9+mQ54p4pZXo3S3pSs5ijIriWpq52WSg0tXNFUBx31olXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29DD6C43399;
	Tue, 12 Mar 2024 22:20:16 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1rkAVr-000000022L0-2etg;
	Tue, 12 Mar 2024 18:22:23 -0400
Message-ID: <20240312222223.494701270@goodmis.org>
User-Agent: quilt/0.67
Date: Tue, 12 Mar 2024 18:21:02 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [for-linus][PATCH 3/5] ring-buffer: Reuse rb_watermark_hit() for the poll logic
References: <20240312222059.823191689@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

The check for knowing if the poll should wait or not is basically the
exact same logic as rb_watermark_hit(). The only difference is that
rb_watermark_hit() also handles the !full case. But for the full case, the
logic is the same. Just call that instead of duplicating the code in
ring_buffer_poll_wait().

Link: https://lore.kernel.org/linux-trace-kernel/20240312131952.802267543@goodmis.org

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 99fdda29ce4e..8c3730a88662 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -960,25 +960,18 @@ __poll_t ring_buffer_poll_wait(struct trace_buffer *buffer, int cpu,
 	}
 
 	if (full) {
-		unsigned long flags;
-
 		poll_wait(filp, &rbwork->full_waiters, poll_table);
 
-		raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
-		if (!cpu_buffer->shortest_full ||
-		    cpu_buffer->shortest_full > full)
-			cpu_buffer->shortest_full = full;
-		raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
-		if (full_hit(buffer, cpu, full))
+		if (rb_watermark_hit(buffer, cpu, full))
 			return EPOLLIN | EPOLLRDNORM;
 		/*
 		 * Only allow full_waiters_pending update to be seen after
-		 * the shortest_full is set. If the writer sees the
-		 * full_waiters_pending flag set, it will compare the
-		 * amount in the ring buffer to shortest_full. If the amount
-		 * in the ring buffer is greater than the shortest_full
-		 * percent, it will call the irq_work handler to wake up
-		 * this list. The irq_handler will reset shortest_full
+		 * the shortest_full is set (in rb_watermark_hit). If the
+		 * writer sees the full_waiters_pending flag set, it will
+		 * compare the amount in the ring buffer to shortest_full.
+		 * If the amount in the ring buffer is greater than the
+		 * shortest_full percent, it will call the irq_work handler
+		 * to wake up this list. The irq_handler will reset shortest_full
 		 * back to zero. That's done under the reader_lock, but
 		 * the below smp_mb() makes sure that the update to
 		 * full_waiters_pending doesn't leak up into the above.
-- 
2.43.0



