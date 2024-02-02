Return-Path: <linux-kernel+bounces-49093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13EC68465CF
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 03:30:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD7741F2507B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 02:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F009C2D7;
	Fri,  2 Feb 2024 02:30:05 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978B1BE45
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 02:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706841004; cv=none; b=EleVUKC9AnVBTAkOfAgn+U8+nEI+So+QsXcawcsZfSbVSH5qJgZNtiK+OsaGMRgAaQaCOG/qTOtDJSTD2jLJOPwtdAVB1VCfJxOwMq8Nx6Sp/rBBv3w64RYJlSToI59mOrWBg7R1/Z18QxEfIzyp1lqJtfT1uTw1HzVjxNHRB6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706841004; c=relaxed/simple;
	bh=L7UKyYj5KjMqGT1j6b5MsTl6o7rGSW9N6vE3FK5am6w=;
	h=Message-ID:Date:From:To:Cc:Subject; b=QBURq5qhI+khKx5nC2TPaZGo1MJWMxs7TSkSfT0ZYLtWwhKfky4fF61cMnTie/JVvXUxoPnGzu2eHlGiZTKW8nNo8WwlcXuaWJp17J8tGSJXagJaTVSw5SMwl1SM5/WeEs5LqziHgrv/BgfCVbau+68wUlJdcyGNYoztQ/pCxgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F74FC433F1;
	Fri,  2 Feb 2024 02:30:04 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1rVjJu-00000005k5e-0FPZ;
	Thu, 01 Feb 2024 21:30:22 -0500
Message-ID: <20240202022959.515961549@goodmis.org>
User-Agent: quilt/0.67
Date: Thu, 01 Feb 2024 21:29:59 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [for-linus][PATCH 00/13] tracing/eventfs: Updates for v6.8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>


Tracing and eventfs fixes for v6.8:

- Fix the return code for ring_buffer_poll_wait()
  It was returing a -EINVAL instead of EPOLLERR.

- Zero out the tracefs_inode so that all fields are initialized.
  The ti->private could have had stale data, but instead of
  jus initializing it to NULL, clear out the entire structure
  when it is allocated.

- Fix a crash in timerlat
  The hrtimer was initialized at read and not open, but is
  canceled at close. If the file was opened and never read
  the close will pass a NULL pointer to hrtime_cancel().

- Rewrite of eventfs.
  Linus wrote a patch series to remove the dentry references in the
  eventfs_inode and to use ref counting and more of proper VFS
  interfaces to make it work.

- Add warnin to put_ei() if ei is not set to free. That means
  something is about to free it when it shouldn't.

- Restructure the eventfs_inode to make it more compact, and remove
  the unused llist field.

- Remove the fsnotify*() funtions for when the inodes were being created
  in the lookup code. It doesn't make sense to notify about creation
  just because something is being looked up.

- The inode hard link count was not accurate. It was being updated
  when a file was looked up. The inodes of directories were updating
  their parent inode hard link count every time the inode was created.
  That means if memory reclaim cleaned a stale directory inode and
  the inode was lookup up again, it would increment the parent inode
  again as well. Al Viro said to just have all eventfs directories
  have a hard link count of 1. That tells user space not to trust it.

Daniel Bristot de Oliveira (1):
      tracing/timerlat: Move hrtimer_init to timerlat_fd open()

Linus Torvalds (6):
      eventfs: Initialize the tracefs inode properly
      tracefs: Avoid using the ei->dentry pointer unnecessarily
      tracefs: dentry lookup crapectomy
      eventfs: Remove unused d_parent pointer field
      eventfs: Clean up dentry ops and add revalidate function
      eventfs: Get rid of dentry pointers without refcounts

Steven Rostedt (Google) (5):
      tracefs: Zero out the tracefs_inode when allocating it
      eventfs: Warn if an eventfs_inode is freed without is_freed being set
      eventfs: Restructure eventfs_inode structure to be more condensed
      eventfs: Remove fsnotify*() functions from lookup()
      eventfs: Keep all directory links at 1

Vincent Donnefort (1):
      ring-buffer: Clean ring_buffer_poll_wait() error return

----
 fs/tracefs/event_inode.c     | 568 ++++++++++++-------------------------------
 fs/tracefs/inode.c           | 102 ++------
 fs/tracefs/internal.h        |  43 ++--
 kernel/trace/ring_buffer.c   |   2 +-
 kernel/trace/trace_osnoise.c |   6 +-
 5 files changed, 195 insertions(+), 526 deletions(-)

