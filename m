Return-Path: <linux-kernel+bounces-100862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC227879E5B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 23:20:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30CFB284B7E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 22:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A88F5144027;
	Tue, 12 Mar 2024 22:20:16 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EFAC143753
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 22:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710282016; cv=none; b=Nibs4i4DUrqrBCHnLc0j7DXyF1/qmpvWu9A54KJFjJvuesvElbnCirMHWGRhfeWM+lazuUCgcRwOEhVkvgNjDU41Kzk8o76hH/G2yxFJsX622Sw5qKWmAoB4/HJNSG6lPGExCh3XffdDL+ECUue5AeTg7WTOcdT++4eC1aCn+Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710282016; c=relaxed/simple;
	bh=A8PvxD8p2YWdWoF8iZckuZl+Q4BMXNJr/9JH+5/H4dI=;
	h=Message-ID:Date:From:To:Cc:Subject; b=nQqe6hUcgryXgWcG1Hh9US8QV2J8fgabSHmZJ1Kx61zdj29y6r5xA/TOMgAG0KTn8HlmrQm2KmoyOV1U1wLIqLLtUrNzIT+Ng3qOmDtHdkyv7Vv9XUdLISyOqFM3thq12ZHlFYuaFl+JggqqG6upuwsPnjPelZLjqyS7+pwzSQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA510C433F1;
	Tue, 12 Mar 2024 22:20:15 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1rkAVr-000000022JW-0bSP;
	Tue, 12 Mar 2024 18:22:23 -0400
Message-ID: <20240312222059.823191689@goodmis.org>
User-Agent: quilt/0.67
Date: Tue, 12 Mar 2024 18:20:59 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [for-linus][PATCH 0/5] tracing/ring-buffer: Updates that should have made it for 6.8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>


Tracing/ring-buffer fixes for 6.8 (to be applied in 6.9-rc):

- Do not update shortest_full in rb_watermark_hit() if the watermark
  is hit. The shortest_full field was being updated regardless if
  the task was going to wait or not. If the watermark is hit, then
  the task is not going to wait, so do not update the shortest_full
  field (used by the waker).

- Update shortest_full field before setting the full_waiters_pending flag

  In the poll logic, the full_waiters_pending flag was being set
  before the shortest_full field was set. If the full_waiters_pending
  flag is set, writers will check the shortest_full field which has
  the least percentage of data that the ring buffer needs to be
  filled before waking up. The writer will check shortest_full if
  full_waiters_pending is set, and if the ring buffer percentage filled
  is greater than shortest full, then it will call the irq_work to
  wake up the waiters.

  The problem was that the poll logic set the full_waiters_pending flag
  before updating shortest_full, which when zero will always trigger
  the writer to call the irq_work to wake up the waiters. The irq_work
  will reset the shortest_full field back to zero as the woken waiters
  is suppose to reset it.

- There's some optimized logic in the rb_watermark_hit() that is used
  in ring_buffer_wait(). Use that helper function to the poll logic
  as well.

- Restructure ring_buffer_wait() to use wait_event_interruptible()

  The logic to wake up pending readers when the file descriptor is
  closed is racy. Restructure ring_buffer_wait() to allow callers
  to pass in conditions besides the ring buffer having enough data
  in it by using wait_event_interruptible().

- Update the tracing_wait_on_pipe() to call ring_buffer_wait() with
  its own conditions to exit the wait loop.

Steven Rostedt (Google) (5):
      ring-buffer: Do not set shortest_full when full target is hit
      ring-buffer: Fix full_waiters_pending in poll
      ring-buffer: Reuse rb_watermark_hit() for the poll logic
      ring-buffer: Use wait_event_interruptible() in ring_buffer_wait()
      tracing/ring-buffer: Fix wait_on_pipe() race

----
 include/linux/ring_buffer.h  |   4 +-
 include/linux/trace_events.h |   5 +-
 kernel/trace/ring_buffer.c   | 158 +++++++++++++++++++++++++------------------
 kernel/trace/trace.c         |  43 ++++++++----
 4 files changed, 132 insertions(+), 78 deletions(-)

