Return-Path: <linux-kernel+bounces-13236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8580982018D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 22:13:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B80A81C22374
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 21:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AF1C14A97;
	Fri, 29 Dec 2023 21:12:47 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 315761428E
	for <linux-kernel@vger.kernel.org>; Fri, 29 Dec 2023 21:12:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9933FC433C8;
	Fri, 29 Dec 2023 21:12:46 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1rJKAk-00000000Mbp-36dI;
	Fri, 29 Dec 2023 16:13:38 -0500
Message-ID: <20231229211314.081907608@goodmis.org>
User-Agent: quilt/0.67
Date: Fri, 29 Dec 2023 16:13:14 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Jiri Olsa <jolsa@kernel.org>
Subject: [for-linus][PATCH 0/3] tracing: Fixes for v6.7-rc7
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>



tracing fixes for v6.7-rc7:

- Fix readers on blocked on the ring buffer when buffer_percent is
  100%. They are supposed to wake up when the buffer is full, but
  because the sub-buffer that the writer is on is never considered
  "dirty" in the calculation, dirty pages will never equal nr_page.
  Add +1 to the dirty count in order to count for the sub-buffer that
  the writer is on.

- When a reader is blocked on the "snapshot_raw" file, it is to be
  woken up when a snapshot is done and be able to read the snapshot
  buffer. But because the snapshot swaps the buffers (the main one
  with the snapshot one), and the snapshot reader is waiting on the
  old snapshot buffer, it was not woken up (because it is now on
  the main buffer after the swap). Worse yet, when it reads the buffer
  after a snapshot, it's not reading the snapshot buffer, it's reading
  the live active main buffer.

  Fix this by forcing a wakeup of all readers on the snapshot buffer when
  a new snapshot happens, and then update the buffer that the reader
  is reading to be back on the snapshot buffer.

- Fix the modification of the direct_function hash. There was a race
  when new functions were added to the direct_function hash as when
  it moved function entries from the old hash to the new one, a direct
  function trace could be hit and not see its entry.

  This is fixed by allocating the new hash, copy all the old entries
  onto it as well as the new entries, and then use rcu_assign_pointer()
  to update the new direct_function hash with it.

  This also fixes a memory leak in that code.

Steven Rostedt (Google) (3):
      ring-buffer: Fix wake ups when buffer_percent is set to 100
      tracing: Fix blocked reader of snapshot buffer
      ftrace: Fix modification of direct_function hash while in use

----
 kernel/trace/ftrace.c      | 100 +++++++++++++++++++++------------------------
 kernel/trace/ring_buffer.c |  12 ++++--
 kernel/trace/trace.c       |  20 +++++++--
 3 files changed, 73 insertions(+), 59 deletions(-)

