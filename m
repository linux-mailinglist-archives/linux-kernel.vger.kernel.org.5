Return-Path: <linux-kernel+bounces-100192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B05887935C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 12:53:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26B77281624
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 11:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D383A79DD5;
	Tue, 12 Mar 2024 11:53:37 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6958978B4E;
	Tue, 12 Mar 2024 11:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710244417; cv=none; b=pAP+2Et6KGZvGPCnXvaBddMfebBCPbEA4rGG7F4XjH7GkTFF1rGsryfNrnRQ1ayx0+BTXqfZvBSBt+B0NEw0VxWNtm9ClpBFP/+sny7ATGjDvFdtvq8LYZnXtKuXFbzHW8p84sY46SQokqlqnqj0tOsDGbcM6bkpl6bF2lGHJZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710244417; c=relaxed/simple;
	bh=rZyhSi8bE+0iYHTmktYi/EfkEm5OdGcjGh0/xqml6bs=;
	h=Message-ID:Date:From:To:Cc:Subject; b=BPnxKCB28QX0ADoLcnvXFISdxwaP6DF3tPxF65njCM93V0uZGB8PVPCd46XBXW0HhPgT3EL1CnlkASIx6DHEif0b5TQxMw6WI/pqBL6pUNBB/tDrg2POxW847tLiVJvsNaN6VQz9AfIGElNeCG9ZKLYwc5LAoIXkeP3ICsRBqTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 055B1C433F1;
	Tue, 12 Mar 2024 11:53:37 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1rk0jP-00000001u5w-1HqH;
	Tue, 12 Mar 2024 07:55:43 -0400
Message-ID: <20240312115455.666920175@goodmis.org>
User-Agent: quilt/0.67
Date: Tue, 12 Mar 2024 07:54:55 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 0/2] ring-buffer: Fix poll wakeup logic
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>


After making a slight change to wakeups in ring_buffer_wait()
the system would hang. Spending several hours going on a wild goose
chase I found that the change only triggered the bug because it
changed the timings. The bug was there before the update but never
was triggered.

The poll code has:

  rbwork->full_waiters_pending = true;
  if (!cpu_buffer->shortest_full ||
      cpu_buffer->shortest_full > full)
         cpu_buffer->shortest_full = full;

The writer will see full_waiters_pending and check if the ring buffer is
filled over the percentage of the shortest_full value. If it is, it calls
an irq_work to wake up all the waiters.

But the code could get into a circular loop:

        CPU 0                                   CPU 1
        -----                                   -----
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

The race was triggered when running:

  trace-cmd record -p function -m 5000

Which enables function tracing and then creates two files it is writing
into where each is 2500K in size. The -m is a "max file size". When
trace-cmd writes 2500K to one file it then switches to the other, erasing
the old data. To do this, trace-cmd switches between both poll and
the reader using both methods of wake up. The change to the reader wakeup
was able to change the way the poll was woken to trigger this bug.

The second patch is a clean up and also a way to consolidate the logic
of the shortest_full. The read wakeup uses rb_watermark_hit for both
full wakeups and !full wakeups. But since poll uses the same logic for
full wakeups it can just call that function with full set.


Steven Rostedt (Google) (2):
      ring-buffer: Fix full_waiters_pending in poll
      ring-buffer: Reuse rb_watermark_hit() for the poll logic

----
 kernel/trace/ring_buffer.c | 30 +++++++++++++++++++-----------
 1 file changed, 19 insertions(+), 11 deletions(-)

