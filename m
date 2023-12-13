Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C5A7810819
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 03:19:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378311AbjLMCTW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 21:19:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378298AbjLMCTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 21:19:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEC6CBE
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 18:19:24 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0772C433C7;
        Wed, 13 Dec 2023 02:19:24 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
        (envelope-from <rostedt@goodmis.org>)
        id 1rDEr2-00000002Tkj-0vcQ;
        Tue, 12 Dec 2023 21:20:08 -0500
Message-ID: <20231213021914.361709558@goodmis.org>
User-Agent: quilt/0.67
Date:   Tue, 12 Dec 2023 21:19:14 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
        Vincent Donnefort <vdonnefort@google.com>,
        Kent Overstreet <kent.overstreet@gmail.com>
Subject: [PATCH v2 00/15] ring-buffer/tracing: Allow ring buffer to have bigger sub buffers
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
I added documentation and a selftest.

Basically, events to the tracing subsystem are limited to just under a
PAGE_SIZE, as the ring buffer is split into "sub buffers" of one page
size, and an event can not be bigger than a sub buffer. This allows users
to change the size of a sub buffer by the order:

  echo 3 > /sys/kernel/tracing/buffer_subbuf_order

Will make each sub buffer a size of 8 pages, allowing events to be almost
as big as 8 pages in size (sub buffers do have meta data on them as
well, keeping an event from reaching the same size as a sub buffer).

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
