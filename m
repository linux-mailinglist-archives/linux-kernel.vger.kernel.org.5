Return-Path: <linux-kernel+bounces-104625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA2C487D12C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 17:27:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98F90283872
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 16:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B32745945;
	Fri, 15 Mar 2024 16:27:24 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3381773D
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 16:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710520043; cv=none; b=fhITW1NhiX1ep5GqBU5yJ6f+5BUxIrNIxYqB5lPUg62OpP3np95PnPHYsCk4yFtD/C+We0ZYpfxtTH1d28bvdy0kZ1Ir8oHv127++R9IWz+EcvCdsGdZzBA+8gMDCMvWgn9ufmV60bdnDQvcw3VJnN+SNAcuTYEYRu1uYXbv+VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710520043; c=relaxed/simple;
	bh=ftEfPZBQqYmruG8lnCPGQ1AE2O9QyJ/hNwO8Qq/LsdM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=bMUeS4S3Q0ViqY8wxZ7mEUOT2lEe7URo+Z+C3fQY/77GvEkksn3awPXZWoOzJ1ClobARNRoslvmatehOaqOZmgSKPFjzNlmBQdlC+WYxQtk1wFcZpFCeFx+LEAwvLhkP1sOWPjviORQ7CTPQ9QYVz1Ecp2nThL7qCNOsM35OZ00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B86C0C433F1;
	Fri, 15 Mar 2024 16:27:21 +0000 (UTC)
Date: Fri, 15 Mar 2024 12:29:34 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Beau Belgrave <beaub@linux.microsoft.com>, Chengming Zhou
 <zhouchengming@bytedance.com>, Huang Yiwei <quic_hyiwei@quicinc.com>, John
 Garry <john.g.garry@oracle.com>, Randy Dunlap <rdunlap@infradead.org>,
 Thorsten Blum <thorsten.blum@toblux.com>, Vincent Donnefort
 <vdonnefort@google.com>, linke li <lilinke99@qq.com>, Daniel Bristot de
 Oliveira <bristot@redhat.com>
Subject: [GIT PULL] tracing: Updates for v6.9
Message-ID: <20240315122934.1d3231ce@gandalf.local.home>
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
   Note, the last fixes you pulled from me needed to change the
   ring_buffer_wait() function that added two new parameters to it.
   This branch added a new instance of ring_buffer_wait() but does not have
   the two new parameters. I merged my urgent branch to this one and added
   the two parameters (both being NULL) in the merge commit (with the
   proper change log) so that the merge commit will still compile.

   I also found a better way to handle the new ring_buffer_wait() default
   code (with the two NULL parameters) and added that change on top.

   This is the first time I'm requesting a pull request that contains a merge.
   I'm hoping that my scripts created a proper diffstat for you.

   I also have two commits that I'm not including in this pull request
   because they add checks to the usage of __string() and __assign_str()
   and will fail the build if they are not done properly. This found three
   existing bugs. One fix is included in this pull request, but there's two
   more. One fix has already been pulled by you. The other I'm waiting to
   see if I can pull it because my checks will not compile without it.

   Those two other fixes are:
      https://lore.kernel.org/all/20240229143432.273b4871@gandalf.local.home/
      https://lore.kernel.org/all/20240314201217.2112644-1-alison.schofield@intel.com/
]

Tracing updates for 6.9:

Main user visible change:

- Add ring_buffer memory mappings

  The tracing ring buffer was created based on being mostly used with the
  splice system call. It is broken up into page ordered sub-buffers and the
  reader swaps a new sub-buffer with an existing sub-buffer that's part
  of the write buffer. It then has total access to the swapped out
  sub-buffer and can do copyless movements of the memory into other mediums
  (file system, network, etc).

  The buffer is great for passing around the ring buffer contents in the
  kernel, but is not so good for when the consumer is the user space task
  itself.

  A new interface is added that allows user space to memory map the ring
  buffer. It will get all the write sub-buffers as well as reader sub-buffer
  (that is not written to). It can send an ioctl to change which sub-buffer
  is the new reader sub-buffer.

  The ring buffer is read only to user space. It only needs to call the
  ioctl when it is finished with a sub-buffer and needs a new sub-buffer
  that the writer will not write over.

  A self test program was also created for testing and can be used as
  an example for the interface to user space. The libtracefs (external
  to the kernel) also has code that interacts with this, although it is
  disabled until the interface is in a official release. It can be enabled
  by compiling the library with a special flag. This was used for testing
  applications that perform better with the buffer being mapped.

  Memory mapped buffers have limitations. The main one is that it can not be
  used with the snapshot logic. If the buffer is mapped, snapshots will be
  disabled. If any logic is set to trigger snapshots on a buffer, that
  buffer will not be allowed to be mapped.

- User events can now have "multi formats"

  The current user events have a single format. If another event is created
  with a different format, it will fail to be created. That is, once an
  event name is used, it cannot be used again with a different format. This
  can cause issues if a library is using an event and updates its format.
  An application using the older format will prevent an application using
  the new library from registering its event.

  A task could also DOS another application if it knows the event names, and
  it creates events with different formats.

  The multi-format event is in a different name space from the single
  format. Both the event name and its format are the unique identifier.
  This will allow two different applications to use the same user event name
  but with different payloads.

- Added support to have ftrace_dump_on_oops dump out instances and
  not just the main top level tracing buffer.

Other changes:

- Add eventfs_root_inode

  Only the root inode has a dentry that is static (never goes away) and
  stores it upon creation. There's no reason that the thousands of other
  eventfs inodes should have a pointer that never gets set in its
  descriptor. Create a eventfs_root_inode desciptor that has a eventfs_inode
  descriptor and a dentry pointer, and only the root inode will use this.

- Added WARN_ON()s in eventfs

  There's some conditionals remaining in eventfs that should never be hit,
  but instead of removing them, add WARN_ON() around them to make sure that
  they are never hit.

- Have saved_cmdlines allocation also include the map_cmdline_to_pid array

  The saved_cmdlines structure allocates a large amount of data to hold its
  mappings. Within it, it has three arrays. Two are already apart of it:
  map_pid_to_cmdline[] and saved_cmdlines[]. More memory can be saved by
  also including the map_cmdline_to_pid[] array as well.

- Restructure __string() and __assign_str() macros used in TRACE_EVENT().

  Dynamic strings in TRACE_EVENT() are declared with:

      __string(name, source)

  And assigned with:

     __assign_str(name, source)

  In the tracepoint callback of the event, the __string() is used to get the
  size needed to allocate on the ring buffer and __assign_str() is used to
  copy the string into the ring buffer. There's a helper structure that is
  created in the TRACE_EVENT() macro logic that will hold the string length
  and its position in the ring buffer which is created by __string().

  There are several trace events that have a function to create the string
  to save. This function is executed twice. Once for __string() and again
  for __assign_str(). There's no reason for this. The helper structure could
  also save the string it used in __string() and simply copy that into
  __assign_str() (it also already has its length).

  By using the structure to store the source string for the assignment, it
  means that the second argument to __assign_str() is no longer needed.

  It will be removed in the next merge window, but for now add a warning if
  the source string given to __string() is different than the source string
  given to __assign_str(), as the source to __assign_str() isn't even used
  and will be going away.

- Other minor clean ups and fixes


Please pull the latest trace-v6.9 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace-v6.9

Tag SHA1: 37235a011c5cae307bc758909eeb9deb09523b16
Head SHA1: 2fd814ad5713b6069912c4f1662fbc74de2c4741


Beau Belgrave (4):
      tracing/user_events: Prepare find/delete for same name events
      tracing/user_events: Introduce multi-format events
      selftests/user_events: Test multi-format events
      tracing/user_events: Document multi-format flag

Chengming Zhou (1):
      tracefs: Remove SLAB_MEM_SPREAD flag usage

Huang Yiwei (1):
      tracing: Support to dump instance traces by ftrace_dump_on_oops

John Garry (1):
      tracing: Use init_utsname()->release

Randy Dunlap (1):
      ftrace: Fix most kernel-doc warnings

Steven Rostedt (Google) (22):
      eventfs: Add WARN_ON_ONCE() to checks in eventfs_root_lookup()
      eventfs: Create eventfs_root_inode to store dentry
      tracing: Have saved_cmdlines arrays all in one allocation
      tracing: Move open coded processing of tgid_map into helper function
      tracing: Move saved_cmdline code into trace_sched_switch.c
      NFSD: Fix nfsd_clid_class use of __string_len() macro
      drm/i915: Add missing ; to __assign_str() macros in tracepoint code
      tracing: Rework __assign_str() and __string() to not duplicate getting the string
      tracing: Do not calculate strlen() twice for __string() fields
      tracing: Use ? : shortcut in trace macros
      tracing: Use EVENT_NULL_STR macro instead of open coding "(null)"
      tracing: Fix snapshot counter going between two tracers that use it
      tracing: Decrement the snapshot if the snapshot trigger fails to register
      tracing: Remove __assign_str_len()
      tracing: Add __string_len() example
      tracing: Add warning if string in __assign_str() does not match __string()
      tracing: Remove second parameter to __assign_rel_str()
      tracepoints: Use WARN() and not WARN_ON() for warnings
      ring-buffer: Have mmapped ring buffer keep track of missed events
      net: hns3: tracing: fix hclgevf trace event strings
      tracing: merge trace/urgent into trace/core
      ring-buffer: Make wake once of ring_buffer_wait() more robust

Thorsten Blum (1):
      tracing: Use div64_u64() instead of do_div()

Vincent Donnefort (6):
      ring-buffer: Zero ring-buffer sub-buffers
      ring-buffer: Introducing ring-buffer mapping functions
      tracing: Add snapshot refcount
      tracing: Allow user-space mapping of the ring-buffer
      Documentation: tracing: Add ring-buffer mapping
      ring-buffer/selftest: Add ring-buffer mapping test

linke li (1):
      ring-buffer: use READ_ONCE() to read cpu_buffer->commit_page in concurrent environment

----
 Documentation/admin-guide/kernel-parameters.txt    |  26 +-
 Documentation/admin-guide/sysctl/kernel.rst        |  30 +-
 Documentation/trace/index.rst                      |   1 +
 Documentation/trace/ring-buffer-map.rst            | 106 +++
 Documentation/trace/user_events.rst                |  27 +-
 drivers/gpu/drm/i915/display/intel_display_trace.h |   6 +-
 .../ethernet/hisilicon/hns3/hns3pf/hclge_trace.h   |   8 +-
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_trace.h |   8 +-
 fs/nfsd/trace.h                                    |  10 +-
 fs/tracefs/event_inode.c                           |  70 +-
 fs/tracefs/inode.c                                 |   1 -
 fs/tracefs/internal.h                              |   2 -
 include/linux/ftrace.h                             |   4 +-
 include/linux/kernel.h                             |   1 +
 include/linux/ring_buffer.h                        |   7 +
 include/linux/trace_events.h                       |   3 +
 include/linux/tracepoint.h                         |   6 +-
 include/trace/events/sunrpc.h                      |  12 +-
 include/trace/stages/stage2_data_offsets.h         |   4 +-
 include/trace/stages/stage5_get_offsets.h          |  15 +-
 include/trace/stages/stage6_event_callback.h       |  27 +-
 include/uapi/linux/trace_mmap.h                    |  48 ++
 include/uapi/linux/user_events.h                   |   6 +-
 kernel/sysctl.c                                    |   4 +-
 kernel/trace/ftrace.c                              |  90 +-
 kernel/trace/ring_buffer.c                         | 472 ++++++++++-
 kernel/trace/trace.c                               | 904 ++++++++-------------
 kernel/trace/trace.h                               |  19 +-
 kernel/trace/trace_benchmark.c                     |   5 +-
 kernel/trace/trace_events_trigger.c                |  63 +-
 kernel/trace/trace_events_user.c                   | 209 +++--
 kernel/trace/trace_sched_switch.c                  | 515 ++++++++++++
 kernel/trace/trace_selftest.c                      |   2 +-
 samples/trace_events/trace-events-sample.h         |  18 +-
 tools/testing/selftests/ring-buffer/Makefile       |   8 +
 tools/testing/selftests/ring-buffer/config         |   2 +
 tools/testing/selftests/ring-buffer/map_test.c     | 273 +++++++
 tools/testing/selftests/user_events/abi_test.c     | 134 +++
 38 files changed, 2341 insertions(+), 805 deletions(-)
 create mode 100644 Documentation/trace/ring-buffer-map.rst
 create mode 100644 include/uapi/linux/trace_mmap.h
 create mode 100644 tools/testing/selftests/ring-buffer/Makefile
 create mode 100644 tools/testing/selftests/ring-buffer/config
 create mode 100644 tools/testing/selftests/ring-buffer/map_test.c
---------------------------

