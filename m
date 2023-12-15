Return-Path: <linux-kernel+bounces-1476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 84F23814F48
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 18:55:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 088D11F2170B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 17:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D19082EF2;
	Fri, 15 Dec 2023 17:54:54 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B17783013B;
	Fri, 15 Dec 2023 17:54:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 829E1C433C8;
	Fri, 15 Dec 2023 17:54:53 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1rECPX-00000002wNJ-1hFB;
	Fri, 15 Dec 2023 12:55:43 -0500
Message-ID: <20231215175502.106587604@goodmis.org>
User-Agent: quilt/0.67
Date: Fri, 15 Dec 2023 12:55:02 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
 Vincent Donnefort <vdonnefort@google.com>,
 Kent Overstreet <kent.overstreet@gmail.com>
Subject: [PATCH v4 00/15] ring-buffer/tracing: Allow ring buffer to have bigger sub buffers
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>


[
  Nothing changed since v3, just a rebase on trace/core
]

Note, this has been on my todo list since the ring buffer was created back
in 2008.

Tzvetomir last worked on this in 2021 and I need to finally get it in.

His last series was:

  https://lore.kernel.org/linux-trace-devel/20211213094825.61876-1-tz.stoyanov@gmail.com/

With the description of:

   Currently the size of one sub buffer page is global for all buffers and
   it is hard coded to one system page. The patch set introduces configurable
   ring buffer sub page size, per ring buffer. A new user space interface is
   introduced, which allows to change the sub page size of the ftrace buffer,
   per ftrace instance.

I'm pulling in his patches mostly untouched, except that I had to tweak
a few things to forward port them.

The issues I found I added as the last 7 patches to the series, and then
I added documentation and a selftest, and then changed the UI file
from buffer_subbuf_order to buffer_subbuf_size_kb.

Basically, events to the tracing subsystem are limited to just under a
PAGE_SIZE, as the ring buffer is split into "sub buffers" of one page
size, and an event can not be bigger than a sub buffer. This allows users
to change the size of a sub buffer by the order:

  echo 3 > /sys/kernel/tracing/buffer_subbuf_order

[
  last patch updates this to:

  echo 32 > /sys/kernel/tracing/buffer_subbuf_size_kb

]
  

Will make each sub buffer a size of 8 pages (32KB), allowing events to be
almost as big as 8 pages in size (sub buffers do have meta data on them as
well, keeping an event from reaching the same size as a sub buffer).

Changes since v3: https://lore.kernel.org/all/20231213181737.791847466@goodmis.org/

- Rebase on trace/core:

  https://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git/commit/?h=trace/core&id=59c28cc95f0a9f5556561e2416af4ecf86184b71

Changes since v2: https://lore.kernel.org/all/20231213021914.361709558@goodmis.org/

- Fixed up the subbuf tests to ignore multiple spaces after before the
  'buf' string (same fix as was done for the trace_marker test).

- This time include Cc'ing linux-trace-kernel :-p

Changes since v1: https://lore.kernel.org/all/20231210040448.569462486@goodmis.org/

- Add the last patch that changes the ABI from a file called:

  buffer_subbuf_order  to   buffer_subbuf_size_kb

  That is, I kept the old interface the same, but then added the last
  patch that converts the interface into the one that makes more sense.
  I like keeping this in the git history, especially because of the
  way the implemantion is.

- I rebased on top of trace/core in the:

    git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git

- I made the tests a bit more advanced. Still a smoke test, but it
  now checks if the string written is the same as the string read.


Steven Rostedt (Google) (10):
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

Tzvetomir Stoyanov (VMware) (5):
      ring-buffer: Refactor ring buffer implementation
      ring-buffer: Page size per ring buffer
      ring-buffer: Add interface for configuring trace sub buffer size
      ring-buffer: Set new size of the ring buffer sub page
      ring-buffer: Read and write to ring buffers with custom sub buffer size

----
 Documentation/trace/ftrace.rst                     |  21 ++
 include/linux/ring_buffer.h                        |  17 +-
 kernel/trace/ring_buffer.c                         | 409 ++++++++++++++++-----
 kernel/trace/ring_buffer_benchmark.c               |  10 +-
 kernel/trace/trace.c                               | 155 +++++++-
 kernel/trace/trace.h                               |   1 +
 kernel/trace/trace_events.c                        |  59 ++-
 .../test.d/00basic/ringbuffer_subbuf_size.tc       |  95 +++++
 8 files changed, 647 insertions(+), 120 deletions(-)
 create mode 100644 tools/testing/selftests/ftrace/test.d/00basic/ringbuffer_subbuf_size.tc

