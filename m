Return-Path: <linux-kernel+bounces-166885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D43AA8BA15D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 22:08:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D7AC1C20F49
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 20:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C1BA18133C;
	Thu,  2 May 2024 20:08:19 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE3F42AB6;
	Thu,  2 May 2024 20:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714680498; cv=none; b=Oq44gHZLc0MZi+SqL1RMc5gxSJq9j4cNKgFRBGqYileZKvIdFVaKJ4c9cCS8eNr2JKih3y+t94NyPlKETFi6reSs3PQ9sE4XLAJp+II5eRAGLFpC57lEKed89ggZA1NKGuyA8ZT27M/CUfVMBLJLcUQNda1g0YYrsn97FQJ7Ar8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714680498; c=relaxed/simple;
	bh=mtOY0FxS6TmoUWd76Ap0uN34f4D/HhldA0YNKPDAG+4=;
	h=Message-ID:Date:From:To:Cc:Subject; b=gB54PbKu2Hq4q+X2uiG655oANQmgwtwq94b9qvj+Yv1/9rRICZIQDPloW7tgmnKXdDzADp2m+31LMjj/AIz3uLMmxb6+oNRoME9EwqosHKv804W7wWEPCSwi+I7BpNISoFcOnbRHYiCdG0aRugjbFsfmFJFzsWNRtDjOcDHdVGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75717C113CC;
	Thu,  2 May 2024 20:08:18 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1s2cjp-00000003M3E-1QlV;
	Thu, 02 May 2024 16:09:05 -0400
Message-ID: <20240502200821.125580570@goodmis.org>
User-Agent: quilt/0.67
Date: Thu, 02 May 2024 16:08:21 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v3 0/6] tracefs/eventfs: Fix inconsistent permissions
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The tracefs and eventfs permissions are created dynamically based
on what the mount point inode has or the instances directory inode has.
But the way it worked had some inconsistencies that could lead to
security issues as the file system is not behaving like admins would
expect.

The files and directories could ignore the remount option that changes
the gid or uid ownerships, leaving files susceptable to access that
is not expected. This happens if a file had its value changed previously
and then a remount changed all the files permissions. The one that
was changed previously would not be affected.

This change set resolves these inconsistencies.

This also fixes the test_ownership.tc test as it would pass on the
first time it is run, but fail on the second time, because of the
inconsistant state of the permissions. Now you can run that test
multiple times and it will always pass.

Changes since v2: https://lore.kernel.org/linux-trace-kernel/20240502151547.973653253@goodmis.org/

- The eventfs_inode freeing was incorrect. The kref_put() would call
  release_ei() that freed the contents of the eventfs_inode then
  call kfree_rcu() on the eventfs_inode itself. The contents of the
  eventfs_inode needs to be freed after the RCU synchronization as
  well. The patches here add even more cases where that's a requirement.

- Add a iput callback for the tracefs_inode to clear the TRACEFS_EVENT_INODE
  flag. This will prevent the clearing of flags in remount to go into
  the eventfs_remount() function. A RCU grace cycle happens between
  the clearing of this flag and where the eventfs_inode is freed, so
  it is OK if the iteration is happening at the same time, as it is
  done under rcu_read_lock().

Changes since v1: https://lore.kernel.org/linux-trace-kernel/20240502030024.062275408@goodmis.org/

- Testing showed that taking a mutex when freeing the tracefs_inode
  caused a lockdep splat as it can happen in the RCU softirq context.
  Convert the mutex to a spinlock for adding and removing the node
  from the link list, and free the node via call_rcu() so that the
  iteration of the list only needs to be protected by rcu_read_lock().


Steven Rostedt (Google) (6):
      eventfs: Free all of the eventfs_inode after RCU
      tracefs: Reset permissions on remount if permissions are options
      tracefs: Still use mount point as default permissions for instances
      eventfs: Do not differentiate the toplevel events directory
      eventfs: Do not treat events directory different than other directories
      eventfs: Have "events" directory get permissions from its parent

----
 fs/tracefs/event_inode.c | 127 ++++++++++++++++++++++++++++-------------------
 fs/tracefs/inode.c       |  92 ++++++++++++++++++++++++++++++++--
 fs/tracefs/internal.h    |  14 ++++--
 3 files changed, 175 insertions(+), 58 deletions(-)

