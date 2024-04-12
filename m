Return-Path: <linux-kernel+bounces-142727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ABE18A2F6A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 15:29:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2036F1F21C0F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 13:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60B33839EA;
	Fri, 12 Apr 2024 13:29:33 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1386824B3;
	Fri, 12 Apr 2024 13:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712928572; cv=none; b=nhydOyVvhSK3ecvIdtpvFqXCebYqroD0iHlb29F7uvp4snknKzJUTBhxEWq9d2fYejElllXm8N+cbliZOanJBizkq71dnMCBiPyFXKL+jn8oT9kwLzE2FcmRxNC/yQFFMSIOBGBBGdwSmhnHAZaVGzbJ1yewAjgM8CqtG0FT8yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712928572; c=relaxed/simple;
	bh=u8dMeeeKnX/l6l8EK0qzPoKX+NXDcA9+9DlJCRADEYA=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=MsGnacRSfQqEDLfrJACznESvKKDLG8bMq7ZmLTOTBcaLpwgRZ+3SgWIoCH8hTC7kpcUxyvOfLaW/AlTZBrMy+1JF2RINpazhiePUBeg/6DPpZ7dawgcFCPCEEcS6IwAjQFN90RGyC4BIrg4tZGpqMU6nPFNCc+4vP+1n8iNdy3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A7FCC4AF07;
	Fri, 12 Apr 2024 13:29:32 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1rvH0o-000000012qu-1r4T;
	Fri, 12 Apr 2024 09:32:14 -0400
Message-ID: <20240412133214.307818654@goodmis.org>
User-Agent: quilt/0.67
Date: Fri, 12 Apr 2024 09:31:56 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org
Subject: [for-linus][PATCH 4/4] ring-buffer: Only update pages_touched when a new page is touched
References: <20240412133152.723632549@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

The "buffer_percent" logic that is used by the ring buffer splice code to
only wake up the tasks when there's no data after the buffer is filled to
the percentage of the "buffer_percent" file is dependent on three
variables that determine the amount of data that is in the ring buffer:

 1) pages_read - incremented whenever a new sub-buffer is consumed
 2) pages_lost - incremented every time a writer overwrites a sub-buffer
 3) pages_touched - incremented when a write goes to a new sub-buffer

The percentage is the calculation of:

  (pages_touched - (pages_lost + pages_read)) / nr_pages

Basically, the amount of data is the total number of sub-bufs that have been
touched, minus the number of sub-bufs lost and sub-bufs consumed. This is
divided by the total count to give the buffer percentage. When the
percentage is greater than the value in the "buffer_percent" file, it
wakes up splice readers waiting for that amount.

It was observed that over time, the amount read from the splice was
constantly decreasing the longer the trace was running. That is, if one
asked for 60%, it would read over 60% when it first starts tracing, but
then it would be woken up at under 60% and would slowly decrease the
amount of data read after being woken up, where the amount becomes much
less than the buffer percent.

This was due to an accounting of the pages_touched incrementation. This
value is incremented whenever a writer transfers to a new sub-buffer. But
the place where it was incremented was incorrect. If a writer overflowed
the current sub-buffer it would go to the next one. If it gets preempted
by an interrupt at that time, and the interrupt performs a trace, it too
will end up going to the next sub-buffer. But only one should increment
the counter. Unfortunately, that was not the case.

Change the cmpxchg() that does the real switch of the tail-page into a
try_cmpxchg(), and on success, perform the increment of pages_touched. This
will only increment the counter once for when the writer moves to a new
sub-buffer, and not when there's a race and is incremented for when a
writer and its preempting writer both move to the same new sub-buffer.

Link: https://lore.kernel.org/linux-trace-kernel/20240409151309.0d0e5056@gandalf.local.home

Cc: stable@vger.kernel.org
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Fixes: 2c2b0a78b3739 ("ring-buffer: Add percentage of ring buffer full to wake up reader")
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 25476ead681b..6511dc3a00da 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -1393,7 +1393,6 @@ static void rb_tail_page_update(struct ring_buffer_per_cpu *cpu_buffer,
 	old_write = local_add_return(RB_WRITE_INTCNT, &next_page->write);
 	old_entries = local_add_return(RB_WRITE_INTCNT, &next_page->entries);
 
-	local_inc(&cpu_buffer->pages_touched);
 	/*
 	 * Just make sure we have seen our old_write and synchronize
 	 * with any interrupts that come in.
@@ -1430,8 +1429,9 @@ static void rb_tail_page_update(struct ring_buffer_per_cpu *cpu_buffer,
 		 */
 		local_set(&next_page->page->commit, 0);
 
-		/* Again, either we update tail_page or an interrupt does */
-		(void)cmpxchg(&cpu_buffer->tail_page, tail_page, next_page);
+		/* Either we update tail_page or an interrupt does */
+		if (try_cmpxchg(&cpu_buffer->tail_page, &tail_page, next_page))
+			local_inc(&cpu_buffer->pages_touched);
 	}
 }
 
-- 
2.43.0



