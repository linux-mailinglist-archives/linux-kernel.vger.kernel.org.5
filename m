Return-Path: <linux-kernel+bounces-168378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3D248BB7BF
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 00:50:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F3B628611F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 22:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CC9B83CB8;
	Fri,  3 May 2024 22:50:35 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A369B2C684
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 22:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714776634; cv=none; b=AqmAdCbKX9pWS5XfrtnhVmFHn1vQwKeIs+XZPwGtqFQyx+hLulqueoYYFEgW5FDQ7zgwjiPfcfG2lZrcxPC5mtK0oL2oSSLcyViycB55j0fe34e9MOt9lV6tMBxj/2ldqO6e+/8uUFzKF5ZOVJ24odSBie8CK/WEcO+GO9NA9QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714776634; c=relaxed/simple;
	bh=GgGd6BxfSHSE9DBK7jRaV5E3q40w3KLayIN6yovNB74=;
	h=Message-ID:Date:From:To:Cc:Subject; b=OYVDgc05Rwtt+q2B65jz/Xs3N1FeMYdDzp9TxJmBP4Ndum0YdBsucUOQPlAwSD0937+SQx6jm6IfoiAl0HvMrvaEzwAokqsAWqCu9WZLR4z44PAg2e607CQmwZo7qOacMOZ0XqcHGl8gnNECRuptk8dffpT9t+Jq4YapsO2LFMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BE13C116B1;
	Fri,  3 May 2024 22:50:34 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1s31jd-00000000NJd-2NuG;
	Fri, 03 May 2024 18:50:33 -0400
Message-ID: <20240503225013.519028385@goodmis.org>
User-Agent: quilt/0.68
Date: Fri, 03 May 2024 18:50:13 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [for-linus][PATCH 0/9] tracing/tracefs: Fixes for v6.9
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tracing and tracefs fixes for v6.9

- Minor fix for user_events interface
  The ABI of creating a user event states that the fields
  are separated by semicolons, and spaces should be ignored.
  But the parsing expected at least one space to be there (which was incorrect).
  Fix the reading of the string to handle fields separated by
  semicolons but no space between them.

- Add test to user event selftests for no spaces between fields.

- Fix RCU callback of freeing an eventfs_inode.
  The freeing of the eventfs_inode from the kref going to zero
  freed the contents of the eventfs_inode and then used kfree_rcu()
  to free the inode itself. But the contents should also be protected
  by RCU. Switch to a call_rcu() that calls a function to free all
  of the eventfs_inode after the RCU synchronization.

- The tracefs maps its own descriptor to a file represented by
  eventfs. The freeing of this descriptor needs to know when the
  last reference of an eventfs_inode is released, but currently
  there is no interface for that. Add a "release" callback to
  the eventfs_inode entry array that allows for freeing of data
  that can be referenced by the eventfs_inode being opened.
  Then increment the ref counter for this descriptor when the
  eventfs_inode file is created, and decrement/free it when the
  last reference to the eventfs_inode is released and the file
  is removed.

- Fix the permission processing of eventfs.
  The change to make the permissions of eventfs default to the mount
  point but keep track of when changes were made had a side effect
  that could cause security concerns. When the tracefs is remounted
  with a given gid or uid, all the files within it should inherit
  that gid or uid. But if the admin had changed the permission of
  some file within the tracefs file system, it would not get updated
  by the remount. This caused the kselftest of file permissions
  to fail the second time it is run. The first time, all changes
  would look fine, but the second time, because the changes were
  "saved", the remount did not reset them.

  Create a link list of all existing tracefs inodes, and clear the
  saved flags on them on a remount if the remount changes the
  corresponding gid or uid fields.

  This also simplifies the code by removing the distinction between the
  toplevel eventfs and an instance eventfs. They should both act the
  same. They were different because of a misconception due to the
  remount not resetting the flags. Now that remount resets all the
  files and directories to default to the root node if a uid/gid is
  specified, it makes the logic simpler to implement.


Beau Belgrave (2):
      tracing/user_events: Fix non-spaced field matching
      selftests/user_events: Add non-spacing separator check

Steven Rostedt (Google) (7):
      eventfs/tracing: Add callback for release of an eventfs_inode
      eventfs: Free all of the eventfs_inode after RCU
      tracefs: Reset permissions on remount if permissions are options
      tracefs: Still use mount point as default permissions for instances
      eventfs: Do not differentiate the toplevel events directory
      eventfs: Do not treat events directory different than other directories
      eventfs: Have "events" directory get permissions from its parent

----
 fs/tracefs/event_inode.c                          | 148 ++++++++++++++--------
 fs/tracefs/inode.c                                |  92 +++++++++++++-
 fs/tracefs/internal.h                             |  14 +-
 include/linux/tracefs.h                           |   3 +
 kernel/trace/trace_events.c                       |  12 ++
 kernel/trace/trace_events_user.c                  |  76 ++++++++++-
 tools/testing/selftests/user_events/ftrace_test.c |   8 ++
 7 files changed, 293 insertions(+), 60 deletions(-)

