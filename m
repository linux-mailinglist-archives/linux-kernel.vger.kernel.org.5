Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE51D78F0BE
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 17:56:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344809AbjHaP4r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 11:56:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231980AbjHaP4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 11:56:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 092541A3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 08:56:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B6A27B8233E
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 15:56:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49CAEC433C8;
        Thu, 31 Aug 2023 15:56:38 +0000 (UTC)
Date:   Thu, 31 Aug 2023 11:56:35 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ajay Kaher <akaher@vmware.com>,
        Eric Vaughn <ervaughn@linux.microsoft.com>,
        Sishuai Gong <sishuai.system@gmail.com>,
        Uros Bizjak <ubizjak@gmail.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Yue Haibing <yuehaibing@huawei.com>,
        Zhang Zekun <zhangzekun11@huawei.com>,
        Zheng Yejian <zhengyejian1@huawei.com>
Subject: [GIT PULL] tracing: Updates for 6.6
Message-ID: <20230831115635.1bdea0d7@rorschach.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

[ Note, there's a minor conflict which should be fixed by:
        mutex_lock(&trace_types_lock);
-       if (unlikely(tr->current_trace && iter->trace->name != tr->current_trace->name)) {
+       if (unlikely(tr->current_trace != iter->trace))
 +              /* Close iter->trace before switching to the new current tracer */
 +              if (iter->trace->close)
 +                      iter->trace->close(iter);
-               *iter->trace = *tr->current_trace;
+               iter->trace = tr->current_trace;
 +              /* Reopen the new current tracer */
 +              if (iter->trace->open)
 +                      iter->trace->open(iter);
 +      }
        mutex_unlock(&trace_types_lock);
]

Tracing updates for 6.6:

 User visible changes:

  - Added a way to easier filter with cpumasks:
     # echo 'cpumask & CPUS{17-42}' > /sys/kernel/tracing/events/ipi_send_cpumask/filter

  - Show actual size of ring buffer after modifying the ring buffer size via
    buffer_size_kb. Currently it just returns what was written, but the actual
    size rounds up to the sub buffer size. Show that real size instead.

 Major changes:

  - Added "eventfs". This is the code that handles the inodes and dentries of
    tracefs/events directory. As there are thousands of events, and each event
    has several inodes and dentries that currently exist even when tracing is
    never used, they take up precious memory. Instead, eventfs will allocate
    the inodes and dentries in a JIT way (similar to what procfs does). There
    is now metadata that handles the events and subdirectories, and will create
    the inodes and dentries when they are used.

    Note, I also have patches that remove the subdirectory meta data, but will
    wait till the next merge window before applying them. It's a little more
    complex, and I want to make sure the dynamic code works properly before
    adding more complexity, making it easier to revert if need be.

 Minor changes:

  - Optimization to user event list traversal.

  - Remove intermediate permission of tracefs files (note the intermediate
    permission removes all access to the files so it is not a security concern,
    but just a clean up.)

  - Add the complex fix to FORTIFY_SOURCE to the kernel stack event logic.

  - Other minor clean ups.


Please pull the latest trace-v6.6 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace-v6.6

Tag SHA1: 1065c0c85cfdb141b5cc2064b6e379fd564f0779
Head SHA1: 8c96b70171584f38940eb2ba65b84eee38b549ba


Ajay Kaher (9):
      eventfs: Implement tracefs_inode_cache
      tracefs: Rename and export some tracefs functions
      eventfs: Implement eventfs dir creation functions
      eventfs: Implement eventfs file add functions
      eventfs: Implement eventfs lookup, read, open functions
      eventfs: Implement functions to create files and dirs when accessed
      eventfs: Implement removal of meta data from eventfs
      eventfs: Move tracing/events to eventfs
      test: ftrace: Fix kprobe test for eventfs

Eric Vaughn (1):
      tracing/user_events: Optimize safe list traversals

Sishuai Gong (1):
      tracefs: Avoid changing i_mode to a temp value

Steven Rostedt (Google) (5):
      tracing: Add back FORTIFY_SOURCE logic to kernel_stack event structure
      tracing: Remove unnecessary copying of tr->current_trace
      tracing: Add free_trace_iter_content() helper function
      tracing: Require all trace events to have a TRACE_SYSTEM
      tracefs: Remove kerneldoc from struct eventfs_file

Uros Bizjak (1):
      ring_buffer: Use try_cmpxchg instead of cmpxchg

Valentin Schneider (9):
      tracing/filters: Dynamically allocate filter_pred.regex
      tracing/filters: Enable filtering a cpumask field by another cpumask
      tracing/filters: Enable filtering a scalar field by a cpumask
      tracing/filters: Enable filtering the CPU common field by a cpumask
      tracing/filters: Optimise cpumask vs cpumask filtering when user mask is a single CPU
      tracing/filters: Optimise scalar vs cpumask filtering when the user mask is a single CPU
      tracing/filters: Optimise CPU vs cpumask filtering when the user mask is a single CPU
      tracing/filters: Further optimise scalar vs cpumask comparison
      tracing/filters: Document cpumask filtering

Yue Haibing (1):
      tracing: Remove unused function declarations

Zhang Zekun (1):
      ftrace: Remove empty declaration ftrace_enable_daemon() and ftrace_disable_daemon()

Zheng Yejian (1):
      tracing: Set actual size after ring buffer resize

----
 Documentation/trace/events.rst                     |  14 +
 fs/tracefs/Makefile                                |   1 +
 fs/tracefs/event_inode.c                           | 807 +++++++++++++++++++++
 fs/tracefs/inode.c                                 | 157 +++-
 fs/tracefs/internal.h                              |  29 +
 include/linux/ftrace.h                             |   5 -
 include/linux/trace_events.h                       |   2 +
 include/linux/tracefs.h                            |  23 +
 kernel/trace/ring_buffer.c                         |  20 +-
 kernel/trace/trace.c                               |  99 +--
 kernel/trace/trace.h                               |  14 +-
 kernel/trace/trace_entries.h                       |   2 +-
 kernel/trace/trace_events.c                        |  76 +-
 kernel/trace/trace_events_filter.c                 | 302 +++++++-
 kernel/trace/trace_events_user.c                   |  15 +-
 kernel/trace/trace_export.c                        |   9 +
 .../ftrace/test.d/kprobe/kprobe_args_char.tc       |   9 +-
 .../ftrace/test.d/kprobe/kprobe_args_string.tc     |   9 +-
 18 files changed, 1424 insertions(+), 169 deletions(-)
 create mode 100644 fs/tracefs/event_inode.c
 create mode 100644 fs/tracefs/internal.h
---------------------------
