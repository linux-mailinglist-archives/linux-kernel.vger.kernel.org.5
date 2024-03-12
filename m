Return-Path: <linux-kernel+bounces-100194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C19287935E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 12:53:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5787B28180E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 11:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF61E7A120;
	Tue, 12 Mar 2024 11:53:37 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8104279B9F;
	Tue, 12 Mar 2024 11:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710244417; cv=none; b=PJStqaoFdqHbWi8gK5x67FKXrEw1KyHiujavo5TXQgz+obyOF3xjvxCHa7Fg+BgEwab1JhHx0urkMp3GQoXJzYbj7yTBv5D2Osfddl3twvhjObbDdU8s6UduoR2pLflf1uM/AEQpVeuMYlKHexhxu04ZMsyXHwGzEPAHi2OlT1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710244417; c=relaxed/simple;
	bh=OFWQHarI5fCAkqHhPKoFup+10oTzUofGo9Ywf9n4jY4=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=pCGBp+A9lRbloSf35JLhKhGVYyIxYVPzXpJUcjVtNs8ZQ9Q7ekeYbpsoP1TZxfcGBiQri5G6i2ubXszwFUeu4VKitKn5Cuo25YcnO7xQX1qaZtINUlIj5oqYhbpsXSVjIACXH+5iruPWJZbgueH84JleQlYvbdgcTX89JG3nUvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2600BC433C7;
	Tue, 12 Mar 2024 11:53:37 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1rk0jP-00000001u6w-2fLz;
	Tue, 12 Mar 2024 07:55:43 -0400
Message-ID: <20240312115543.500445373@goodmis.org>
User-Agent: quilt/0.67
Date: Tue, 12 Mar 2024 07:54:57 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 2/2] ring-buffer: Reuse rb_watermark_hit() for the poll logic
References: <20240312115455.666920175@goodmis.org>
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
 kernel/trace/ring_buffer.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index adfe603a769b..6ef763f57c66 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -963,21 +963,16 @@ __poll_t ring_buffer_poll_wait(struct trace_buffer *buffer, int cpu,
 
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



