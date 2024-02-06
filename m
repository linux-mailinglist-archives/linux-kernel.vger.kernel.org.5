Return-Path: <linux-kernel+bounces-54794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5774A84B3D4
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 12:46:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D248CB21EF8
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 11:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F9A51353F8;
	Tue,  6 Feb 2024 11:33:34 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BFA2133996;
	Tue,  6 Feb 2024 11:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707219211; cv=none; b=XxSnr0bpili+3m3l2kYGdd/SBb5v06Q1/5JcFNyj/EGHk/6/U4XTkqkLINLoD+7Qhul4A4nluRugVbe9WYHQbBybbzXtzQVmfmnbLRCQ4WZdm0s2ViHLYQgZH4laPxJO+TUViYJXoYJ6UM8XT8mJFU/idmnHDXjM62NUPpDFIHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707219211; c=relaxed/simple;
	bh=YUUc7FFaa9HA/Wrq9PqkW6ZnyUXTUbapztqNh4bOejI=;
	h=Message-ID:Date:From:To:Cc:Subject; b=mAGs714cPzI7rFtDmRGajJ7gEuRkb0YCPXnRzMO1kFBwG0+CERhYAIfz11LlEf752stk98h1tn8rtIAgUsbm4MZyvSXh12DySgLW5di0Mx3QTmrdRfCInXeMIywWI/LfdgDZeGToFJnbTZ0Ig++RqCNfbvDooyduIedqOIN8HMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49120C32788;
	Tue,  6 Feb 2024 11:33:30 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@rostedt.homelinux.com>)
	id 1rXJiA-00000006aGP-0r6z;
	Tue, 06 Feb 2024 06:33:58 -0500
Message-ID: <20240206113158.822006147@rostedt.homelinux.com>
User-Agent: quilt/0.67
Date: Tue, 06 Feb 2024 06:31:58 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sasha Levin <sashal@kernel.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [v6.7][PATCH v2 00/23] eventfs: Linus's updates for 6.7
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>


This is a backport of all the work that lead up to the work that Linus made
on eventfs. I trust Linus's version more so than the versions in 6.6 and
6.7. There may be plenty of hidden issues due to the design.

This is the update for 6.7. It includes Linus's updates as well as all the
patches leading up to them.

I ran these through my full test suite that I use before sending anyting to
Linus, althouh I did not run my "bisect" test that walks through the
patches. The tests were just run on the end result. I'm currently running my
6.6 version through my tests.

This was created with the following command against v6.7.3:

git log --reverse --no-merges --pretty=oneline v6.7..origin/master fs/tracefs/ | cut -d' ' -f1 |
   while read a; do if ! git cherry-pick -x $a; then break; fi ; done

Which adds -x to the cherry pick to add the upstream commit SHAs.


Erick Archer (1):
      eventfs: Use kcalloc() instead of kzalloc()

Linus Torvalds (7):
      tracefs: remove stale 'update_gid' code
      eventfs: Initialize the tracefs inode properly
      tracefs: Avoid using the ei->dentry pointer unnecessarily
      tracefs: dentry lookup crapectomy
      eventfs: Remove unused d_parent pointer field
      eventfs: Clean up dentry ops and add revalidate function
      eventfs: Get rid of dentry pointers without refcounts

Steven Rostedt (Google) (15):
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
 fs/tracefs/event_inode.c | 905 ++++++++++++++++-------------------------------
 fs/tracefs/inode.c       | 286 +++++++--------
 fs/tracefs/internal.h    |  48 ++-
 3 files changed, 451 insertions(+), 788 deletions(-)

