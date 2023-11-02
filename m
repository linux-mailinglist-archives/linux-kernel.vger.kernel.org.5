Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06AD47DF266
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 13:29:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347275AbjKBM3s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 08:29:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346859AbjKBM3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 08:29:45 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 958D7DE
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 05:29:41 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 598F0C433C7;
        Thu,  2 Nov 2023 12:29:39 +0000 (UTC)
Date:   Thu, 2 Nov 2023 08:29:36 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Beau Belgrave <beaub@linux.microsoft.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Uros Bizjak <ubizjak@gmail.com>,
        Zheng Yejian <zhengyejian1@huawei.com>
Subject: [GIT PULL] tracing: Updates for v6.7
Message-ID: <20231102082936.077e6193@gandalf.local.home>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

[
   There's a conflict with selftests file tools/testing/selftests/user_events/abi_test.c
   I have the solution to the conflict at:
      git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
           fixup-trace-v6.7

   Sorry for the late pull request, I had a bunch of error reports on
   linux-next come in over the weekend :-p
]

Tracing updates for v6.7:

- Remove eventfs_file descriptor

  This is the biggest change, and the second part of making eventfs
  create its files dynamically.

  In 6.6 the first part was added, and that maintained a one to one
  mapping between eventfs meta descriptors and the directories and
  file inodes and dentries that were dynamically created. The
  directories were represented by a eventfs_inode and the files
  were represented by a eventfs_file.

  In v6.7 the eventfs_file is removed. As all events have the same
  directory make up (sched_switch has an "enable", "id", "format",
  etc files), the handing of what files are underneath each leaf
  eventfs directory is moved back to the tracing subsystem via a
  callback. When a event is added to the eventfs, it registers
  an array of evenfs_entry's. These hold the names of the files and
  the callbacks to call when the file is referenced. The callback gets
  the name so that the same callback may be used by multiple files.
  The callback then supplies the filesystem_operations structure needed
  to create this file.

  This has brought the memory footprint of creating multiple eventfs
  instances down by 2 megs each!

- User events now has persistent events that are not associated
  to a single processes. These are privileged events that hang around
  even if no process is attached to them.

- Clean up of seq_buf.
  There's talk about using seq_buf more to replace strscpy() and friends.
  But this also requires some minor modifications of seq_buf to be
  able to do this.

- Expand instance ring buffers individually
  Currently if boot up creates an instance, and a trace event is
  enabled on that instance, the ring buffer for that instance and the
  top level ring buffer are expanded (1.4 MB per CPU). This wastes
  memory as this happens when nothing is using the top level instance.

- Other minor clean ups and fixes.


Please pull the latest trace-v6.7 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace-v6.7

Tag SHA1: 3c5df74769e123082ae186f0f5ee77c62eebaf2d
Head SHA1: 70a9affa930c7aeba27893c7d402ef1294f43aa2


Beau Belgrave (3):
      tracing/user_events: Allow events to persist for perfmon_capable users
      selftests/user_events: Test persist flag cases
      tracing/user_events: Document persist event flags

Christophe JAILLET (3):
      tracing/histograms: Simplify last_cmd_set()
      seq_buf: Export seq_buf_putc()
      seq_buf: Export seq_buf_puts()

Dan Carpenter (1):
      tracing: Fix a NULL vs IS_ERR() bug in event_subsystem_dir()

Jiapeng Chong (1):
      tracefs/eventfs: Modify mismatched function name

Jonathan Corbet (1):
      seq_buf: fix a misleading comment

Kees Cook (1):
      seq_buf: Introduce DECLARE_SEQ_BUF and seq_buf_str()

Matthew Wilcox (Oracle) (2):
      tracing: Move readpos from seq_buf to trace_seq
      powerpc: Remove initialisation of readpos

Nathan Chancellor (1):
      eventfs: Use ERR_CAST() in eventfs_create_events_dir()

Steven Rostedt (Google) (19):
      eventfs: Remove eventfs_file and just use eventfs_inode
      tracing/selftests: Update kprobe args char/string to match new functions
      eventfs: Use eventfs_remove_events_dir()
      tracing: Make system_callback() function static
      eventfs: Fix failure path in eventfs_create_events_dir()
      eventfs: Fix WARN_ON() in create_file_dentry()
      eventfs: Fix typo in eventfs_inode union comment
      tracing: Have trace_event_file have ref counters
      eventfs: Remove extra dget() in eventfs_create_events_dir()
      tracing: Have the user copy of synthetic event address use correct context
      eventfs: Fix kerneldoc of eventfs_remove_rec()
      eventfs: Remove "is_freed" union with rcu head
      eventfs: Have a free_ei() that just frees the eventfs_inode
      eventfs: Test for ei->is_freed when accessing ei->dentry
      eventfs: Save ownership and mode
      eventfs: Hold eventfs_mutex when calling callback functions
      eventfs: Delete eventfs_inode when the last dentry is freed
      eventfs: Remove special processing of dput() of events directory
      eventfs: Use simple_recursive_removal() to clean up dentries

Uros Bizjak (1):
      ring_buffer: Use try_cmpxchg instead of cmpxchg in rb_insert_pages

Zheng Yejian (1):
      tracing: Expand all ring buffers individually

----
 Documentation/trace/user_events.rst                |   21 +-
 arch/powerpc/kernel/setup-common.c                 |    1 -
 fs/tracefs/event_inode.c                           | 1093 ++++++++++++--------
 fs/tracefs/inode.c                                 |    2 +-
 fs/tracefs/internal.h                              |   54 +-
 include/linux/seq_buf.h                            |   28 +-
 include/linux/trace_events.h                       |    6 +-
 include/linux/trace_seq.h                          |    2 +
 include/linux/tracefs.h                            |   73 +-
 include/uapi/linux/user_events.h                   |   11 +-
 kernel/trace/ring_buffer.c                         |    8 +-
 kernel/trace/trace.c                               |   90 +-
 kernel/trace/trace.h                               |   16 +-
 kernel/trace/trace_events.c                        |  362 +++++--
 kernel/trace/trace_events_filter.c                 |    3 +
 kernel/trace/trace_events_hist.c                   |   11 +-
 kernel/trace/trace_events_synth.c                  |    2 +-
 kernel/trace/trace_events_user.c                   |   36 +-
 kernel/trace/trace_seq.c                           |    6 +-
 lib/seq_buf.c                                      |   28 +-
 .../ftrace/test.d/kprobe/kprobe_args_char.tc       |    4 +-
 .../ftrace/test.d/kprobe/kprobe_args_string.tc     |    4 +-
 tools/testing/selftests/user_events/abi_test.c     |   55 +-
 tools/testing/selftests/user_events/dyn_test.c     |   54 +-
 24 files changed, 1278 insertions(+), 692 deletions(-)
---------------------------
