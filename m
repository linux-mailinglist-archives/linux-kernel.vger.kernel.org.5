Return-Path: <linux-kernel+bounces-97540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8B8C876BB0
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 21:22:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 551CAB21480
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 20:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D219F5D8EE;
	Fri,  8 Mar 2024 20:22:34 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605542D60B;
	Fri,  8 Mar 2024 20:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709929354; cv=none; b=R9FANjdopi8SDLS8vImykYCTjV02/cNPhGi3YVgR+0dGtMhwqtcHA44iSRPL37EscEuec9PXCbo7JQFv5Dqvs2/3DFbqrJw+5wbB4k2IZ9p8+nzq3T/NMvaJRbhu1tSwjr2ZL5RWBFieZrMJ4KAgjOUxve6DpJ2Ox6AcgwvnS30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709929354; c=relaxed/simple;
	bh=Bfcz+ch/WDp/CnGyCAsW9l/B8/ERIAXXzUoqKYlPxBU=;
	h=Message-ID:Date:From:To:Cc:Subject; b=oVGmeSgnGk4VdGS51nFuHDlx8+B4LCRZOzNwznGnn4pB+ulFzc5AC42pdm25BinOsXmFD14SLctSVjSu/4T/uBnsyr1pkV1sSOHxf0sxoYkuTsDcWGUK+2peZ+wqneGy7mFPjwcTrQhMRxV7ascrzXwBwh6noc365m819Y/yxuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7190C433C7;
	Fri,  8 Mar 2024 20:22:33 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1riglb-00000000yq9-3DuL;
	Fri, 08 Mar 2024 15:24:31 -0500
Message-ID: <20240308202402.234176464@goodmis.org>
User-Agent: quilt/0.67
Date: Fri, 08 Mar 2024 15:24:02 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 joel@joelfernandes.org,
 linke li <lilinke99@qq.com>,
 Rabin Vincent <rabin@rab.in>
Subject: [PATCH v2 0/6] tracing/ring-buffer: Fix wakeup of ring buffer waiters
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>


A patch was sent to "fix" the wait_index variable that is used to help with
waking of waiters on the ring buffer. The patch was rejected, but I started
looking at associated code. Discussing it on IRC with Mathieu Desnoyers
we discovered a design flaw.

The waiter reads "wait_index" then enters a "wait loop". After adding
itself to the wait queue, if the buffer is filled or a signal is pending
it will exit out. If wait_index is different, it will also exit out.
(Note, I noticed that the check for wait_index was after the schedule()
call and should have been before it, but that's besides the point).

The race is what happens if the waker updates the wait_index,
a new waiter comes in and reads the updated wait_index before it adds
itself to the queue, it will miss the update!

This is a series of changes to fix the design, and other bugs found
along the way.

1) Remove the wait loop in the ring_buffer_wait() code. It doesn't
   have enough context to know if it should continue to wait.

2) Fix "shortest_full" accounting. When zero, it gets set to the
   smallest percentage requested of the buffer before the writers need to
   start waking up waiters. But after waiters are all woken up,
   it never gets reset, so the smallest value will always be the
   smallest value until the buffer itself is reset.

3) The wake up of readers on close was incorrectly added to the
   .release() callback and not the .flush(). That is, waiters
   in the .read() call, will never be woken up because .release()
   isn't called until all .read()s have finished. Move the wakeup
   to .flush() which is called immediately by close().

4) Add a "waking" field to the trace iterator that gets set when a
   waker wants to wake up the readers. For the .flush() callback,
   it is set and never cleared to make sure new readers do not block.

5/6) Break up ring_buffer_wait() into three functions:

  ring_buffer_prepare_to_wait()
  ring_buffer_wait()
  ring_buffer_finish_wait()

    This allows the caller to add itself to the wait queue, check
    if its own condition has been set (in this case: iter->waking)
    and then sleep. Follows the same semantics as any other wait logic.


Changes since v1: https://lore.kernel.org/lkml/20240308183816.676883229@goodmis.org/

- My tests triggered a warning about calling a mutex_lock() after a
  prepare_to_wait() that changed the task's state. Convert the affected
  mutex over to a spinlock.

Steven Rostedt (Google) (6):
      ring-buffer: Fix waking up ring buffer readers
      ring-buffer: Fix resetting of shortest_full
      tracing: Use .flush() call to wake up readers
      tracing: Fix waking up tracing readers
      ring-buffer: Restructure ring_buffer_wait() to prepare for updates
      tracing/ring-buffer: Fix wait_on_pipe() race

----
 include/linux/ring_buffer.h  |   4 +
 include/linux/trace_events.h |   3 +-
 kernel/trace/ring_buffer.c   | 251 +++++++++++++++++++++++++++----------------
 kernel/trace/trace.c         | 131 ++++++++++++++++++----
 4 files changed, 272 insertions(+), 117 deletions(-)

