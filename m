Return-Path: <linux-kernel+bounces-75760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6893485EE8B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 02:16:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 971031C20F98
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 01:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CDA111C8B;
	Thu, 22 Feb 2024 01:16:29 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7B98F45
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 01:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708564589; cv=none; b=jHfyNI8XoYqxRk6bRqfq95PgB4QMlYaQ42xWz2f85XNnNpKFxaJaDgS5dMShDQ2cpKCkZpU/M6x1oHSTugc99YZNzOJBKXURSCTKHXnDDs+BfBfrBtHbfkkLIrP+lbMEaFcEm7J7/BRp2bIgZF50qgG0ANWujqi2bPARYr3WRZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708564589; c=relaxed/simple;
	bh=5PcQB9L/FhYvOc8Hm0xI1evh+ow1XK07hQOhd9zsYEw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=O5BeDLJOubWdn57XbdBwc2n9B9ZjaxxYibsvS2X/WF2DYL/sr5LH6jmLhuWgbr/rxXmN5CWRWDq3a/PoA9aUKxNVyfGr2Qn0ajFebtnzXooTO+hugEhdRY/WNr9oz7sxDyi10lDYHMjZrXBarlVH4Z1BEgrAFlF7rCANPByFkgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE06CC433F1;
	Thu, 22 Feb 2024 01:16:27 +0000 (UTC)
Date: Wed, 21 Feb 2024 20:18:16 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [GIT PULL] tracing: Add ring buffer sub-buffer size check
Message-ID: <20240221201816.0d1e7829@gandalf.local.home>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit



Linus,

Tracing fix for v6.8:

- While working on the ring buffer I noticed that the counter used
  for knowing where the end of the data is on a sub-buffer was not
  a full "int" but just 20 bits. It was masked out to 0xfffff.
  With the new code that allows the user to change the size of the
  sub-buffer, it is theoretically possible to ask for a size
  bigger than 2^20. If that happens, unexpected results may
  occur as there's no code checking if the counter overflowed the
  20 bits of the write mask. There are other checks to make sure
  events fit in the sub-buffer, but if the sub-buffer itself is
  too big, that is not checked.

  Add a check in the resize of the sub-buffer to make sure that it
  never goes beyond the size of the counter that holds how much
  data is on it.


Please pull the latest trace-v6.8-rc5 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace-v6.8-rc5

Tag SHA1: 2ff328f136698ef4a0b8660ed372017d338f9435
Head SHA1: e78fb4eac817308027da88d02e5d0213462a7562


Steven Rostedt (Google) (1):
      ring-buffer: Do not let subbuf be bigger than write mask

----
 kernel/trace/ring_buffer.c | 4 ++++
 1 file changed, 4 insertions(+)
---------------------------
commit e78fb4eac817308027da88d02e5d0213462a7562
Author: Steven Rostedt (Google) <rostedt@goodmis.org>
Date:   Tue Feb 20 09:51:12 2024 -0500

    ring-buffer: Do not let subbuf be bigger than write mask
    
    The data on the subbuffer is measured by a write variable that also
    contains status flags. The counter is just 20 bits in length. If the
    subbuffer is bigger than then counter, it will fail.
    
    Make sure that the subbuffer can not be set to greater than the counter
    that keeps track of the data on the subbuffer.
    
    Link: https://lore.kernel.org/linux-trace-kernel/20240220095112.77e9cb81@gandalf.local.home
    
    Cc: Masami Hiramatsu <mhiramat@kernel.org>
    Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
    Fixes: 2808e31ec12e5 ("ring-buffer: Add interface for configuring trace sub buffer size")
    Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index fd4bfe3ecf01..0699027b4f4c 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -5877,6 +5877,10 @@ int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order)
 	if (psize <= BUF_PAGE_HDR_SIZE)
 		return -EINVAL;
 
+	/* Size of a subbuf cannot be greater than the write counter */
+	if (psize > RB_WRITE_MASK + 1)
+		return -EINVAL;
+
 	old_order = buffer->subbuf_order;
 	old_size = buffer->subbuf_size;
 

