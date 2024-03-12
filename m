Return-Path: <linux-kernel+bounces-100279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37B458794F1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 14:18:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D14DA1F23501
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 13:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C3887A70A;
	Tue, 12 Mar 2024 13:17:47 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE9A78298;
	Tue, 12 Mar 2024 13:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710249466; cv=none; b=Sf/w579CSUTawWiL21W+0f7P57+bAYeni8V0ITogeh+fVgXprxvrfTGMuW9eWPfadvdtVYBMDgIhwMjx83Xil+DnkoAh2jakZLRz3kV6F4LJv6vhAnb/0ll4AMHVuSyDleY7Ho0xvdEXE1gy+phivkUq+yw/QopGbzszScu06bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710249466; c=relaxed/simple;
	bh=k+JLL4d00L0L7gdEpBMiVzQAbItjP94VG3eK06sexSw=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=kKJaoKKgeodY1NC6EV5QZ5KgmSHSmSlmZ0yk8Psut75SL6jv/KwUwVKhKh8TvVlNdOKy2tEJTRpudC0XqfwZaImprSZVogy8yFJ9AoMnUvHg4ugb3tcB3iGo83x7HMQTBRiZA6v+zwa8GGVrZ/VurzDs3DZckau58Hb8gJg43Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A5F8C43394;
	Tue, 12 Mar 2024 13:17:46 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1rk22q-00000001vKH-3vb1;
	Tue, 12 Mar 2024 09:19:52 -0400
Message-ID: <20240312131952.802267543@goodmis.org>
User-Agent: quilt/0.67
Date: Tue, 12 Mar 2024 09:19:21 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2 2/2] ring-buffer: Reuse rb_watermark_hit() for the poll logic
References: <20240312131919.314231457@goodmis.org>
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

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index adfe603a769b..857803e8cf07 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -959,25 +959,18 @@ __poll_t ring_buffer_poll_wait(struct trace_buffer *buffer, int cpu,
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



