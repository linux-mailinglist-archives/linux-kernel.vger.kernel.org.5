Return-Path: <linux-kernel+bounces-100226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8177E8793B7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 13:07:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38B6A1F2109A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 12:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BC417A730;
	Tue, 12 Mar 2024 12:01:36 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9336558207;
	Tue, 12 Mar 2024 12:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710244895; cv=none; b=cvBUZGdHnicjJdwAmCe0zzI7tNX0+7C+tzeolAlcLv3q709SGlZhKxOsuuoiUeifYW7a5rtQ0kmpVoGHcpkKGqjeM8AEbKKeeqrzwlh6CeHghtcAx+pomFBeWnWJQTGEghlbbtP2pQHNkbSgvxlJ3MZxNFGi4rgHQBuE99Yv+PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710244895; c=relaxed/simple;
	bh=PyhcmeEqpMLLpLqlTJwAk+iqEAYM+edKPATKaLpLegc=;
	h=Message-ID:Date:From:To:Cc:Subject; b=JxkP+5a7UVK0owum23m4ulFiQS/77RddAeYoKnrwScB0QuZPmrq/T+Efr/OmKYLrunjfaFwLaWFAWbtoJ2DhyD86iOunnpNy7+mgiUU2eLScimlEpdyr7lVu5J9Ky6VFdaO2WRWW5LctOtTyedy7Ea0dhZcC8t5/o52MAWMgceU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AB35C433C7;
	Tue, 12 Mar 2024 12:01:35 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1rk0r7-00000001uGd-2Jkx;
	Tue, 12 Mar 2024 08:03:41 -0400
Message-ID: <20240312120252.998983805@goodmis.org>
User-Agent: quilt/0.67
Date: Tue, 12 Mar 2024 08:02:53 -0400
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
Subject: [PATCH v3 0/2] tracing/ring-buffer: Fix wakeup of ring buffer waiters
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

These patches fix the design by converting the ring_buffer_wait()
to use the wait_event_interruptible() interface.

Then the wait_to_pipe() caller will pass its own condition into
the ring_buffer_wait() to be checked by the wait_event_interruptible().

- The first patch restructures the ring_buffer_wait() to use the
  wait_event_interruptible() logic. It does not change the interface,
  but adds a local "cond" condition callback function that will be
  what it defaults to in the second patch if NULL is passed in.

  The default cond function is just a "wait once" function. That
  is, the first time it is called (before the wait_event_interruptible()
  calls schedule) will set the "once" variable to one and return
  false. The next time it is called (after wait_event_interruptible()
  wakes up) it will return true to break out of the loop.

- The second patch changes the ring_buffer_wait() interface to allow
  the caller to define its own "cond" callback. That will be checked
  in wait_event_interruptible() along with checking if the proper
  amount of data in the ring buffer has been hit.

Changes since v2: https://lore.kernel.org/all/20240308202402.234176464@goodmis.org/

- Patches 1-3 of v2 have been accepted.

- Instead of breaking ring_buffer_wait() into three functions that do
  a prepare_to_wait(), wait() and finish_wait(), have ring_buffer_wait()
  take a condition callback function and a data parameter.

  The ring_buffer_wait() now uses a wait_event_interruptible() code,
  and added a helper function to do check its own conditions, and also
  to call the passed in condition function and allow the caller to
  specify other conditions to break out of the event loop.

Changes since v1: https://lore.kernel.org/lkml/20240308183816.676883229@goodmis.org/

- My tests triggered a warning about calling a mutex_lock() after a
  prepare_to_wait() that changed the task's state. Convert the affected
  mutex over to a spinlock.



Steven Rostedt (Google) (2):
      ring-buffer: Use wait_event_interruptible() in ring_buffer_wait()
      tracing/ring-buffer: Fix wait_on_pipe() race

----
 include/linux/ring_buffer.h  |   4 +-
 include/linux/trace_events.h |   5 +-
 kernel/trace/ring_buffer.c   | 117 +++++++++++++++++++++++++------------------
 kernel/trace/trace.c         |  43 +++++++++++-----
 4 files changed, 107 insertions(+), 62 deletions(-)

