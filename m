Return-Path: <linux-kernel+bounces-54876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B92184B4AE
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 13:14:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 076F2288A25
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 12:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B32B1350E9;
	Tue,  6 Feb 2024 12:09:19 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF2F134CC5;
	Tue,  6 Feb 2024 12:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707221358; cv=none; b=dbfukuDFwqqWtzjqQbxWNVnQozv7EG3wI5rG9pNz4JM8AyVBAYoz3c0hTIQLkIMjBg1laDRdMq0Z3wrWrQFIWUvXYUqYYYfjPhaXZfWSjJ8imF3+uCOUnjsK+VfzjssUIFkwtJfpcxuYXYintwCJxPinIo5oOebM+Rvdcpgn/as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707221358; c=relaxed/simple;
	bh=gK6jjiAyijKsJjFYwtbUn3rDMvepH/FqNdSWld2WLNM=;
	h=Message-ID:Date:From:To:Cc:Subject; b=dRYBn/ZVssEZ6HQtn1R2/AWawq7JUNn8PLOKeGsp25H/u0rXUTOJKNssu/5U5DptuqeqB1lS667Bt/8FeU2yibitoypslm3kybqLA+Vf75wz36Zj/WVud2mEYua17VHic5LYPOu5f1xEu44P4n2yDiMki3OcmpyMXWTzimciXTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DE5EC43390;
	Tue,  6 Feb 2024 12:09:18 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@rostedt.homelinux.com>)
	id 1rXKGo-00000006b1P-27ws;
	Tue, 06 Feb 2024 07:09:46 -0500
Message-ID: <20240206120905.570408983@rostedt.homelinux.com>
User-Agent: quilt/0.67
Date: Tue, 06 Feb 2024 07:09:05 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sasha Levin <sashal@kernel.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [v6.6][PATCH 00/57] eventfs: Linus's updates for 6.6
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>


This is a backport of all the work that lead up to the work that Linus made
on eventfs. I trust Linus's version more so than the versions in 6.6 and
6.7. There may be plenty of hidden issues due to the design.

This is the update for 6.6. It includes Linus's updates as well as all the
patches leading up to them. As the eventfs work went in in two parts, half
went in in 6.6 and the other in 6.7, there were 6 backports that were done
custom to 6.6 as the bugs found in 6.7 were in 6.6 but implemented
differently. This series starts with reverting those 6 backports and then
applying the updated patches to get to Linus's simplification.

I ran these through my full test suite that I use before sending anything to
Linus, although I did not run my "bisect" test that walks through the
patches. The tests were just run on the end result.

This was created with the following command against v6.6.15, after reverting
the 6 patches:

git log --reverse --no-merges --pretty=oneline v6.6..origin/master fs/tracefs/ | cut -d' ' -f1 |
   while read a; do if ! git cherry-pick -x $a; then break; fi ; done

Which adds -x to the cherry pick to add the upstream commit SHAs.

There was one patch in tracefs that didn't need to be backported and I removed
that one.

Beau Belgrave (1):
      eventfs: Fix events beyond NAME_MAX blocking tasks

Erick Archer (1):
      eventfs: Use kcalloc() instead of kzalloc()

Jiapeng Chong (1):
      tracefs/eventfs: Modify mismatched function name

Linus Torvalds (7):
      tracefs: remove stale 'update_gid' code
      eventfs: Initialize the tracefs inode properly
      tracefs: Avoid using the ei->dentry pointer unnecessarily
      tracefs: dentry lookup crapectomy
      eventfs: Remove unused d_parent pointer field
      eventfs: Clean up dentry ops and add revalidate function
      eventfs: Get rid of dentry pointers without refcounts

Nathan Chancellor (1):
      eventfs: Use ERR_CAST() in eventfs_create_events_dir()

Steven Rostedt (Google) (46):
      Revert "eventfs: Do not allow NULL parent to eventfs_start_creating()"
      Revert "eventfs: Check for NULL ef in eventfs_set_attr()"
      Revert "eventfs: Use simple_recursive_removal() to clean up dentries"
      Revert "eventfs: Delete eventfs_inode when the last dentry is freed"
      Revert "eventfs: Save ownership and mode"
      Revert "eventfs: Remove "is_freed" union with rcu head"
      eventfs: Remove eventfs_file and just use eventfs_inode
      eventfs: Use eventfs_remove_events_dir()
      eventfs: Fix failure path in eventfs_create_events_dir()
      eventfs: Fix WARN_ON() in create_file_dentry()
      eventfs: Fix typo in eventfs_inode union comment
      eventfs: Remove extra dget() in eventfs_create_events_dir()
      eventfs: Fix kerneldoc of eventfs_remove_rec()
      eventfs: Remove "is_freed" union with rcu head
      eventfs: Have a free_ei() that just frees the eventfs_inode
      eventfs: Test for ei->is_freed when accessing ei->dentry
      eventfs: Save ownership and mode
      eventfs: Hold eventfs_mutex when calling callback functions
      eventfs: Delete eventfs_inode when the last dentry is freed
      eventfs: Remove special processing of dput() of events directory
      eventfs: Use simple_recursive_removal() to clean up dentries
      eventfs: Remove expectation that ei->is_freed means ei->dentry == NULL
      eventfs: Do not invalidate dentry in create_file/dir_dentry()
      eventfs: Use GFP_NOFS for allocation when eventfs_mutex is held
      eventfs: Move taking of inode_lock into dcache_dir_open_wrapper()
      eventfs: Do not allow NULL parent to eventfs_start_creating()
      eventfs: Make sure that parent->d_inode is locked in creating files/dirs
      eventfs: Have event files and directories default to parent uid and gid
      eventfs: Fix file and directory uid and gid ownership
      tracefs: Check for dentry->d_inode exists in set_gid()
      eventfs: Fix bitwise fields for "is_events"
      eventfs: Remove "lookup" parameter from create_dir/file_dentry()
      eventfs: Stop using dcache_readdir() for getdents()
      tracefs/eventfs: Use root and instance inodes as default ownership
      eventfs: Have eventfs_iterate() stop immediately if ei->is_freed is set
      eventfs: Do ctx->pos update for all iterations in eventfs_iterate()
      eventfs: Read ei->entries before ei->children in eventfs_iterate()
      eventfs: Shortcut eventfs_iterate() by skipping entries already read
      eventfs: Have the inodes all for files and directories all be the same
      eventfs: Do not create dentries nor inodes in iterate_shared
      eventfs: Save directory inodes in the eventfs_inode structure
      tracefs: Zero out the tracefs_inode when allocating it
      eventfs: Warn if an eventfs_inode is freed without is_freed being set
      eventfs: Restructure eventfs_inode structure to be more condensed
      eventfs: Remove fsnotify*() functions from lookup()
      eventfs: Keep all directory links at 1

----
 fs/tracefs/event_inode.c     | 1250 +++++++++++++++++++-----------------------
 fs/tracefs/inode.c           |  276 +++++-----
 fs/tracefs/internal.h        |   60 +-
 include/linux/trace_events.h |    2 +-
 include/linux/tracefs.h      |   73 ++-
 kernel/trace/trace.c         |    7 +-
 kernel/trace/trace.h         |    4 +-
 kernel/trace/trace_events.c  |  311 +++++++----
 8 files changed, 1029 insertions(+), 954 deletions(-)

