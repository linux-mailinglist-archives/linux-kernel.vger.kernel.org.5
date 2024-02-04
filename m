Return-Path: <linux-kernel+bounces-51337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 804488489EF
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 02:18:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC49A1C227FA
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 01:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8948517E9;
	Sun,  4 Feb 2024 01:18:05 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11574EDC;
	Sun,  4 Feb 2024 01:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707009485; cv=none; b=NkRkt+qp3P09AQziykOwHkM4Dl7yM+BP72yB9LvQsyARvrWux0OB+Jltq2FY34AsvAJiaWssEQ6mY93O7Yd692aJfxUOOOoeLA0ZNZQEGG1fLSWpP/qODwPUb/8DjvavRCZSpq7/c6ARMM40O1bJ1pydfvpx6K2N59XlJgLc+Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707009485; c=relaxed/simple;
	bh=UIUs6LlmDxawNhDuxl933sxIjJLLNea2CmPMN12Js7M=;
	h=Message-ID:Date:From:To:Cc:Subject; b=leaNx/jRj0dvIAaIYhH4V/HeJDrvlgjoRP0DgWn5GQLJVHt+HtqsMyRqlIGGC3EXriOfZ4Yw8+Zi003my7pYB10DbTZT3JF8+5clwOf+wyBbX6oCzlkeD0CgcYnRUFswDw1MDhpo7i4b5YwN3J0ew9qbAOYkW5esJcRJcqCsnQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93041C433C7;
	Sun,  4 Feb 2024 01:18:04 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1rWR9P-00000006OkL-07kK;
	Sat, 03 Feb 2024 20:18:27 -0500
Message-ID: <20240204011615.703023949@goodmis.org>
User-Agent: quilt/0.67
Date: Sat, 03 Feb 2024 20:16:15 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sasha Levin <sashal@kernel.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [v6.7][PATCH 00/23] eventfs: Linus's updates for 6.7
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

