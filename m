Return-Path: <linux-kernel+bounces-100278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 15C738794F0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 14:18:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F411B235F6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 13:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08FDC7A700;
	Tue, 12 Mar 2024 13:17:47 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD1C56450;
	Tue, 12 Mar 2024 13:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710249466; cv=none; b=tAA03XVtL72nBhYMqU6yd6y79rn819vwTOZU9J9d1lP0e0rGkXs6B5Xr/7HwC5jIx8XOrVvjXvHnFDTfyD87LXn5lFA7G8yrMTLqtUK7ZMRpAwgDMKq+2d9n1OhW+2zy4WAMPDnuW215MSATf3zzoepe3MCqYqHC6FwNoF6J+HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710249466; c=relaxed/simple;
	bh=ZxzRKcmZnQql0doYFZDuFsF2/FgMRMj5ACaz7Xr6ezk=;
	h=Message-ID:Date:From:To:Cc:Subject; b=RHmO5cae/jx4XwnOH7I7Ubf37ZBclS716WQRfNMXqoubHlMFoA1lDZ3+1R/PpqXGnDkI/EOA5Q1QPwBP4BqIpPGUFXX4CW0mTune3gdf7GUvnQrjNYM4TXh8kbqPWsbDruZ1YvF8qPIQLybRydAyExCJkLvboIOjaPkWz2im4n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F8D6C433F1;
	Tue, 12 Mar 2024 13:17:46 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1rk22q-00000001vJH-2WED;
	Tue, 12 Mar 2024 09:19:52 -0400
Message-ID: <20240312131919.314231457@goodmis.org>
User-Agent: quilt/0.67
Date: Tue, 12 Mar 2024 09:19:19 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2 0/2] ring-buffer: Fix poll wakeup logic
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

Changes since v1: https://lore.kernel.org/all/20240312115455.666920175@goodmis.org/

- Removed unused 'flags' in ring_buffer_poll_wait() as the spin_lock
  is now in rb_watermark_hit().


Steven Rostedt (Google) (2):
      ring-buffer: Fix full_waiters_pending in poll
      ring-buffer: Reuse rb_watermark_hit() for the poll logic

----
 kernel/trace/ring_buffer.c | 32 +++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)

