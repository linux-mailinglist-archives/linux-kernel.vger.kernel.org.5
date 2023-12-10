Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D37680B8B6
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 05:04:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231494AbjLJEEH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 23:04:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjLJEEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 23:04:06 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4594DB4
        for <linux-kernel@vger.kernel.org>; Sat,  9 Dec 2023 20:04:12 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C25C3C433C7;
        Sun, 10 Dec 2023 04:04:11 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
        (envelope-from <rostedt@goodmis.org>)
        id 1rCB3g-000000021LJ-21zR;
        Sat, 09 Dec 2023 23:04:48 -0500
Message-ID: <20231210035404.053677508@goodmis.org>
User-Agent: quilt/0.67
Date:   Sat, 09 Dec 2023 22:54:04 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
        Vincent Donnefort <vdonnefort@google.com>,
        Kent Overstreet <kent.overstreet@gmail.com>
Subject: [PATCH 00/14] ring-buffer/tracing: Allow ring buffer to have bigger sub buffers
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Note, this has been on my todo list since the ring buffer was created back
in 2008.

Tzvetomir last worked on this in 2020 and I need to finally get it in.

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



Steven Rostedt (Google) (9):
      ring-buffer: Clear pages on error in ring_buffer_subbuf_order_set() failure
      ring-buffer: Do no swap cpu buffers if order is different
      ring-buffer: Make sure the spare sub buffer used for reads has same size
      tracing: Update snapshot order along with main buffer order
      tracing: Stop the tracing while changing the ring buffer subbuf size
      ring-buffer: Keep the same size when updating the order
      ring-buffer: Just update the subbuffers when changing their allocation order
      ring-buffer: Add documentation on the buffer_subbuf_order file
      ringbuffer/selftest: Add basic selftest to test chaning subbuf order

Tzvetomir Stoyanov (VMware) (5):
      ring-buffer: Refactor ring buffer implementation
      ring-buffer: Page size per ring buffer
      ring-buffer: Add interface for configuring trace sub buffer size
      ring-buffer: Set new size of the ring buffer sub page
      ring-buffer: Read and write to ring buffers with custom sub buffer size

----
 Documentation/trace/ftrace.rst                     |  27 ++
 include/linux/ring_buffer.h                        |  17 +-
 kernel/trace/ring_buffer.c                         | 406 ++++++++++++++++-----
 kernel/trace/ring_buffer_benchmark.c               |  10 +-
 kernel/trace/trace.c                               | 143 +++++++-
 kernel/trace/trace.h                               |   1 +
 kernel/trace/trace_events.c                        |  59 ++-
 .../ftrace/test.d/00basic/ringbuffer_order.tc      |  46 +++
 8 files changed, 588 insertions(+), 121 deletions(-)
 create mode 100644 tools/testing/selftests/ftrace/test.d/00basic/ringbuffer_order.tc
