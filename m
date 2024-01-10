Return-Path: <linux-kernel+bounces-22892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3300582A4FF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 00:40:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DEDEB26DE3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 23:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97A714F8A2;
	Wed, 10 Jan 2024 23:40:16 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD583EA74
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 23:40:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD0F1C433F1;
	Wed, 10 Jan 2024 23:40:14 +0000 (UTC)
Date: Wed, 10 Jan 2024 18:41:15 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Mark Rutland <mark.rutland@arm.com>, Andrew Morton
 <akpm@linux-foundation.org>, "Tzvetomir Stoyanov (VMware)"
 <tz.stoyanov@gmail.com>
Subject: [GIT PULL] tracing: Updates for 6.8
Message-ID: <20240110184115.78c13944@gandalf.local.home>
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

[
  Note that this does not include the eventfs changes of that pull request:
  https://lore.kernel.org/all/20240107180924.38e25155@rorschach.local.home/
]

tracing updates for 6.8:

- Allow kernel trace instance creation to specify what events are created
  Inside the kernel, a subsystem may create a tracing instance that it can
  use to send events to user space. This sub-system may not care about the
  thousands of events that exist in eventfs. Allow the sub-system to specify
  what sub-systems of events it cares about, and only those events are exposed
  to this instance.

- Allow the ring buffer to be broken up into bigger sub-buffers than just the
  architecture page size. A new tracefs file called "buffer_subbuf_size_kb"
  is created. The user can now specify a minimum size the sub-buffer may be
  in kilobytes. Note, that the implementation currently make the sub-buffer
  size a power of 2 pages (1, 2, 4, 8, 16, ...) but the user only writes in
  kilobyte size, and the sub-buffer will be updated to the next size that
  it will can accommodate it. If the user writes in 10, it will change the
  size to be 4 pages on x86 (16K), as that is the next available size that
  can hold 10K pages.

- Update the debug output when a corrupt time is detected in the ring buffer.
  If the ring buffer detects inconsistent timestamps, there's a debug config
  options that will dump the contents of the meta data of the sub-buffer that
  is used for debugging. Add some more information to this dump that helps
  with debugging.

- Add more timestamp debugging checks (only triggers when the config is enabled)

- Increase the trace_seq iterator to 2 page sizes.

- Allow strings written into tracefs_marker to be larger. Up to just under
  2 page sizes (based on what trace_seq can hold).

- Increase the trace_maker_raw write to be as big as a sub-buffer can hold.

- Remove 32 bit time stamp logic, now that the rb_time_cmpxchg() has been
  removed.

- More selftests were added.

- Some code clean ups as well.


Please pull the latest trace-v6.8 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace-v6.8

Tag SHA1: 577284de33036626715651a94a195b6fe6d7f527
Head SHA1: 25742aeb135c4a44e92fb347e037adaa145b9484


Steven Rostedt (Google) (24):
      tracing: Allow creating instances with specified system events
      ring-buffer: Add offset of events in dump on mismatch
      tracing: Allow for max buffer data size trace_marker writes
      trace_seq: Increase the buffer size to almost two pages
      tracing: Have trace_marker break up by lines by size of trace_seq
      tracing: Increase size of trace_marker_raw to max ring buffer entry
      tracing/selftests: Add test to test the trace_marker
      ring-buffer: Remove 32bit timestamp logic
      ring-buffer: Add interrupt information to dump of data sub-buffer
      ring-buffer: Check if absolute timestamp goes backwards
      ring-buffer: Clear pages on error in ring_buffer_subbuf_order_set() failure
      ring-buffer: Do no swap cpu buffers if order is different
      ring-buffer: Make sure the spare sub buffer used for reads has same size
      tracing: Update snapshot order along with main buffer order
      tracing: Stop the tracing while changing the ring buffer subbuf size
      ring-buffer: Keep the same size when updating the order
      ring-buffer: Just update the subbuffers when changing their allocation order
      ring-buffer: Add documentation on the buffer_subbuf_order file
      ringbuffer/selftest: Add basic selftest to test changing subbuf order
      tracing: Update subbuffer with kilobytes not page order
      ring-buffer: Use subbuf_order for buffer page masking
      tracing/selftests: Remove exec permissions from trace_marker.tc test
      tracing histograms: Simplify parse_actions() function
      ring-buffer: Remove stale comment from ring_buffer_size()

Tzvetomir Stoyanov (VMware) (5):
      ring-buffer: Have ring_buffer_print_page_header() be able to access ring_buffer_iter
      ring-buffer: Page size per ring buffer
      ring-buffer: Add interface for configuring trace sub buffer size
      ring-buffer: Set new size of the ring buffer sub page
      ring-buffer: Read and write to ring buffers with custom sub buffer size

----
 Documentation/trace/ftrace.rst                     |  21 +
 drivers/scsi/qla2xxx/qla_os.c                      |   2 +-
 include/linux/ring_buffer.h                        |  18 +-
 include/linux/trace.h                              |   4 +-
 include/linux/trace_seq.h                          |   9 +-
 kernel/trace/ring_buffer.c                         | 733 +++++++++++++--------
 kernel/trace/ring_buffer_benchmark.c               |  10 +-
 kernel/trace/trace.c                               | 234 +++++--
 kernel/trace/trace.h                               |   2 +
 kernel/trace/trace_boot.c                          |   2 +-
 kernel/trace/trace_events.c                        | 107 ++-
 kernel/trace/trace_events_hist.c                   |  49 +-
 kernel/trace/trace_seq.c                           |   3 -
 samples/ftrace/sample-trace-array.c                |   2 +-
 .../test.d/00basic/ringbuffer_subbuf_size.tc       |  95 +++
 .../ftrace/test.d/00basic/trace_marker.tc          |  82 +++
 16 files changed, 999 insertions(+), 374 deletions(-)
 create mode 100644 tools/testing/selftests/ftrace/test.d/00basic/ringbuffer_subbuf_size.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/00basic/trace_marker.tc
---------------------------

