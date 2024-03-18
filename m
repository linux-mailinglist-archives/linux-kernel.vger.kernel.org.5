Return-Path: <linux-kernel+bounces-106302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7812B87EC29
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 16:28:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F783281B37
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 15:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C7284F214;
	Mon, 18 Mar 2024 15:28:35 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62C74F200
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 15:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710775714; cv=none; b=ntp14qBuytHGoX558daineCrnAAf1deWLMq/BYJx/zcj6a4hQbkSCSHu0ciL9moSSqUFK0dEm2ze67WgSzbCT8b2U/t0qDTZir7txufS4Vz537fxHb2ftzl4FHcEAACraXg92UztQ6puPVYKScQa0KSqi8B1pITTAtTboCWREbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710775714; c=relaxed/simple;
	bh=cesoN5LrQO2lw73x5MpjoTR1Qb8KG91ktWn+qjMYN+o=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=OdyDceATefNJ65MOhJncPHtTHpIBJ2GFsYF22FgUk6/p+bIjANt9nsgrTl8gT19wbAA5OnzHHH80ZXJugyoPdEupFO188gAPN7PXJ+CaYgdM0FEbvfwxKGXbokYyd4+50HxlqoGKWR7i+GNjdo+/+V+eQy2+U/A3QbGDhyeISZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2C3AC433F1;
	Mon, 18 Mar 2024 15:28:32 +0000 (UTC)
Date: Mon, 18 Mar 2024 11:30:53 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Alison Schofield <alison.schofield@intel.com>, Beau Belgrave
 <beaub@linux.microsoft.com>, Huang Yiwei <quic_hyiwei@quicinc.com>, John
 Garry <john.g.garry@oracle.com>, Randy Dunlap <rdunlap@infradead.org>,
 Thorsten Blum <thorsten.blum@toblux.com>, Vincent Donnefort
 <vdonnefort@google.com>, linke li <lilinke99@qq.com>
Subject: [GIT PULL v2] tracing: Updates for v6.9
Message-ID: <20240318113053.7f87ce7f@gandalf.local.home>
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
  I rebased my entire queue on top of the last pull request you took from
  me. This made it so that I didn't need to do a merge with commits in that
  branch. It also included fixes needed for the __assign_str() update.

  The rebase removed the ring buffer user space mmapping and that will be
  worked on later to fix the issues you had with it, and hopefully that can
  go into the next merge window. Preparations for mapping are still there
  like zeroing out the pages (that should be done anyway) and the snapshot
  accounting.

  I added the __string() and __assign_str() checks with fixes to users that
  had that broken. The second parameter of __assign_str() is no longer used
  but it is now checked to make sure that its the same as what is passed into
  __string() so that the next merge window than second parameter can be
  removed without causing regressions.
]

Tracing updates for 6.9:

Main user visible change:

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

- Added checks to make sure that the source of __string() is also the
  source of __assign_str() so that it can be safely removed in the next
  merge window.

  Included fixes that the above check found.

- Other minor clean ups and fixes


Please pull the latest trace-v6.9-2 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace-v6.9-2

Tag SHA1: f40626f0ff0f9241d1d565a355c3375c8a007c69
Head SHA1: 7604256cecef34a82333d9f78262d3180f4eb525


Alison Schofield (1):
      cxl/trace: Properly initialize cxl_poison region name

Beau Belgrave (4):
      tracing/user_events: Prepare find/delete for same name events
      tracing/user_events: Introduce multi-format events
      selftests/user_events: Test multi-format events
      tracing/user_events: Document multi-format flag

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
      ring-buffer: Make wake once of ring_buffer_wait() more robust
      NFSD: Fix nfsd_clid_class use of __string_len() macro
      drm/i915: Add missing ; to __assign_str() macros in tracepoint code
      net: hns3: tracing: fix hclgevf trace event strings
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
      tracing: Use strcmp() in __assign_str() WARN_ON() check
      tracing: Add __string_src() helper to help compilers not to get confused

Thorsten Blum (1):
      tracing: Use div64_u64() instead of do_div()

Vincent Donnefort (2):
      ring-buffer: Zero ring-buffer sub-buffers
      tracing: Add snapshot refcount

linke li (1):
      ring-buffer: use READ_ONCE() to read cpu_buffer->commit_page in concurrent environment

----
 Documentation/admin-guide/kernel-parameters.txt    |  26 +-
 Documentation/admin-guide/sysctl/kernel.rst        |  30 +-
 Documentation/trace/user_events.rst                |  27 +-
 drivers/cxl/core/trace.h                           |  14 +-
 drivers/gpu/drm/i915/display/intel_display_trace.h |   6 +-
 .../ethernet/hisilicon/hns3/hns3pf/hclge_trace.h   |   8 +-
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_trace.h |   8 +-
 fs/nfsd/trace.h                                    |  10 +-
 fs/tracefs/event_inode.c                           |  70 +-
 fs/tracefs/internal.h                              |   2 -
 include/linux/ftrace.h                             |   4 +-
 include/linux/kernel.h                             |   1 +
 include/linux/trace_events.h                       |   3 +
 include/linux/tracepoint.h                         |   6 +-
 include/trace/events/sunrpc.h                      |  12 +-
 include/trace/stages/stage2_data_offsets.h         |   4 +-
 include/trace/stages/stage5_get_offsets.h          |  25 +-
 include/trace/stages/stage6_event_callback.h       |  29 +-
 include/uapi/linux/user_events.h                   |   6 +-
 kernel/sysctl.c                                    |   4 +-
 kernel/trace/ftrace.c                              |  90 +--
 kernel/trace/ring_buffer.c                         |  45 +-
 kernel/trace/trace.c                               | 768 ++++++---------------
 kernel/trace/trace.h                               |  18 +-
 kernel/trace/trace_benchmark.c                     |   5 +-
 kernel/trace/trace_events_trigger.c                |  63 +-
 kernel/trace/trace_events_user.c                   | 209 ++++--
 kernel/trace/trace_sched_switch.c                  | 515 ++++++++++++++
 kernel/trace/trace_selftest.c                      |   2 +-
 samples/trace_events/trace-events-sample.h         |  18 +-
 tools/testing/selftests/user_events/abi_test.c     | 134 ++++
 31 files changed, 1363 insertions(+), 799 deletions(-)
---------------------------

