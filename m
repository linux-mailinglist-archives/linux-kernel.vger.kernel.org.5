Return-Path: <linux-kernel+bounces-2043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4984F815746
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 05:22:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB7611F25643
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 04:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D99ED10A32;
	Sat, 16 Dec 2023 04:21:51 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8054510A00
	for <linux-kernel@vger.kernel.org>; Sat, 16 Dec 2023 04:21:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 046B8C433C7;
	Sat, 16 Dec 2023 04:21:51 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1rEMCH-00000002yAG-3YvW;
	Fri, 15 Dec 2023 23:22:41 -0500
Message-ID: <20231216042214.905262999@goodmis.org>
User-Agent: quilt/0.67
Date: Fri, 15 Dec 2023 23:22:14 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [for-linus][PATCH 00/15] tracing: Fixes for 6.7-rc5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>


Tracing fixes for v6.7-rc5:

- Fix eventfs to check creating new files for events with names greater than
  NAME_MAX. The eventfs lookup needs to check the return result of
  simple_lookup().

- Fix the ring buffer to check the proper max data size. Events must be able to
  fit on the ring buffer sub-buffer, if it cannot, then it fails to be written
  and the logic to add the event is avoided. The code to check if an event can
  fit failed to add the possible absolute timestamp which may make the event
  not be able to fit. This causes the ring buffer to go into an infinite loop
  trying to find a sub-buffer that would fit the event. Luckily, there's a check
  that will bail out if it looped over a 1000 times and it also warns.

  The real fix is not to add the absolute timestamp to an event that is
  starting at the beginning of a sub-buffer because it uses the sub-buffer
  timestamp. By avoiding the timestamp at the start of the sub-buffer allows
  events that pass the first check to always find a sub-buffer that it can fit
  on.

- Have large events that do not fit on a trace_seq to print "LINE TOO BIG" like
  it does for the trace_pipe instead of what it does now which is to silently
  drop the output.

- Fix a memory leak of forgetting to free the spare page that is saved by a
  trace instance.

- Update the size of the snapshot buffer when the main buffer is updated if the
  snapshot buffer is allocated.

- Fix ring buffer timestamp logic by removing all the places that tried to put
  the before_stamp back to the write stamp so that the next event doesn't add
  an absolute timestamp. But each of these updates added a race where by making
  the two timestamp equal, it was validating the write_stamp so that it can be
  incorrectly used for calculating the delta of an event.

- There's a temp buffer used for printing the event that was using the event
  data size for allocation when it needed to use the size of the entire event
  (meta-data and payload data)

- For hardening, use "%.*s" for printing the trace_marker output, to limit the
  amount that is printed by the size of the event. This was discovered by
  development that added a bug that truncated the '\0' and caused a crash.

- Fix a use-after-free bug in the use of the histogram files when an instance
  is being removed.

- Remove a useless update in the rb_try_to_discard of the write_stamp. The
  before_stamp was already changed to force the next event to add an absolute
  timestamp that the write_stamp is not used. But the write_stamp is modified
  again using an unneeded 64-bit cmpxchg.

- Fix several races in the 32-bit implementation of the rb_time_cmpxchg() that
  does a 64-bit cmpxchg.

- While looking at fixing the 64-bit cmpxchg, I noticed that because the ring
  buffer uses normal cmpxchg, and this can be done in NMI context, there's some
  architectures that do not have a working cmpxchg in NMI context. For these
  architectures, fail recording events that happen in NMI context.
  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace/urgent

Head SHA1: 712292308af2265cd9b126aedfa987f10f452a33


Beau Belgrave (1):
      eventfs: Fix events beyond NAME_MAX blocking tasks

Mathieu Desnoyers (1):
      ring-buffer: Fix 32-bit rb_time_read() race with rb_time_cmpxchg()

Steven Rostedt (Google) (12):
      ring-buffer: Fix writing to the buffer with max_data_size
      tracing: Have large events show up as '[LINE TOO BIG]' instead of nothing
      ring-buffer: Fix memory leak of free page
      tracing: Update snapshot buffer on resize if it is allocated
      ring-buffer: Do not update before stamp when switching sub-buffers
      ring-buffer: Have saved event hold the entire event
      tracing: Add size check when printing trace_marker output
      ring-buffer: Do not try to put back write_stamp
      ring-buffer: Remove useless update to write_stamp in rb_try_to_discard()
      ring-buffer: Fix a race in rb_time_cmpxchg() for 32 bit archs
      ring-buffer: Have rb_time_cmpxchg() set the msb counter too
      ring-buffer: Do not record in NMI if the arch does not support cmpxchg in NMI

Zheng Yejian (1):
      tracing: Fix uaf issue when open the hist or hist_debug file

----
 fs/tracefs/event_inode.c         |   4 ++
 kernel/trace/ring_buffer.c       | 115 ++++++++++++++-------------------------
 kernel/trace/trace.c             |  16 +++++-
 kernel/trace/trace.h             |   1 +
 kernel/trace/trace_events_hist.c |  12 ++--
 kernel/trace/trace_output.c      |   6 +-
 6 files changed, 72 insertions(+), 82 deletions(-)

