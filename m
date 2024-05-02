Return-Path: <linux-kernel+bounces-166619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A9098B9D21
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 17:15:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A93B31C21B75
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 15:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB66515B15B;
	Thu,  2 May 2024 15:15:34 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2165D15AACA;
	Thu,  2 May 2024 15:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714662934; cv=none; b=T3/ZMbvlY51AoCaa/Y0Arx0C5zWFrQXvVIJmUJj0qxUlS6SHzqaZGA1jyj4Qfw2Kluid3FNmb+hQsBVS5eIt0Pd5SoJI1/YI0iiWBeJQuI8rb4Tn46KVTMIrenarbjaAW4Ki45zKc+HcJoSZOsJNpyev/X7BfalAbqIC36P4syw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714662934; c=relaxed/simple;
	bh=mn51M/aLYne7AuxEoxbC4ggK7clEUPSjzRG+mNeu3yI=;
	h=Message-ID:Date:From:To:Cc:Subject; b=HamstQ73OEG4+h9WV+JPm0ndoS1+QJ8o+OaRFUaFIiNnxKjPwYs/4ihzPCgeqJW+OVlZSzdZZgtm6sgRG2mxQzq3YH0/03crx/voTW4nbGruv1rgqqr/LlJf9gUzRHm8jjpd9y9VpPzQ33BqIYoSnpwGAyHNXPsLQe/wMReM2DE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCE46C113CC;
	Thu,  2 May 2024 15:15:33 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1s2YAW-00000003ISF-1Zdr;
	Thu, 02 May 2024 11:16:20 -0400
Message-ID: <20240502151547.973653253@goodmis.org>
User-Agent: quilt/0.67
Date: Thu, 02 May 2024 11:15:47 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2 0/5] tracefs/eventfs: Fix inconsistent permissions
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

Changes since v1: https://lore.kernel.org/linux-trace-kernel/20240502030024.062275408@goodmis.org/

- Testing showed that taking a mutex when freeing the tracefs_inode
  caused a lockdep splat as it can happen in the RCU softirq context.
  Convert the mutex to a spinlock for adding and removing the node
  from the link list, and free the node via call_rcu() so that the
  iteration of the list only needs to be protected by rcu_read_lock().


Steven Rostedt (Google) (5):
      tracefs: Reset permissions on remount if permissions are options
      tracefs: Still use mount point as default permissions for instances
      eventfs: Do not differentiate the toplevel events directory
      eventfs: Do not treat events directory different than other directories
      eventfs: Have "events" directory get permissions from its parent

----
 fs/tracefs/event_inode.c | 102 ++++++++++++++++++++++++++++-------------------
 fs/tracefs/inode.c       |  77 +++++++++++++++++++++++++++++++++--
 fs/tracefs/internal.h    |  14 ++++---
 3 files changed, 144 insertions(+), 49 deletions(-)

