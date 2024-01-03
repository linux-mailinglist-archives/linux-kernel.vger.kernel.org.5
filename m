Return-Path: <linux-kernel+bounces-15059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 865128226C3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 03:06:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47AFF1C21CF1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 02:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0FD615B0;
	Wed,  3 Jan 2024 02:06:31 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99DB8136B
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 02:06:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 891A0C433C9;
	Wed,  3 Jan 2024 02:06:30 +0000 (UTC)
Date: Tue, 2 Jan 2024 21:07:31 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [GIT PULL] tracing: Final fixes for v6.7
Message-ID: <20240102210731.1f1c5bf5@gandalf.local.home>
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

tracing fixes for v6.7-rc8:

- Fix a NULL kernel dereference in set_gid() on tracefs mounting.
  When tracefs is mounted with "gid=1000", it will update the existing
  dentries to have the new gid. The tracefs_inode which is retrieved
  by a container_of(dentry->d_inode) has flags to see if the inode
  belongs to the eventfs system.

  The issue that was fixed was if getdents() was called on tracefs
  that was previously mounted, and was not closed. It will leave
  a "cursor dentry" in the subdirs list of the current dentries that
  set_gid() walks. On a remount of tracefs, the container_of(dentry->d_inode)
  will dereference a NULL pointer and cause a crash when referenced.

  Simply have a check for dentry->d_inode to see if it is NULL and if
  so, skip that entry.

- Fix the bits of the eventfs_inode structure. The "is_events" bit
  was taken  from the nr_entries field, but the nr_entries field wasn't
  updated to be 30 bits and was still 31. Including the "is_freed" bit
  this would use 33 bits which would make the structure use another
  integer for just one bit.


Please pull the latest trace-v6.7-rc8 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace-v6.7-rc8

Tag SHA1: 268dc78680a450c2207c0af35e0e367ff07b25eb
Head SHA1: fd56cd5f6d76e93356d9520cf9dabffe1e3d1aa0


Steven Rostedt (Google) (2):
      tracefs: Check for dentry->d_inode exists in set_gid()
      eventfs: Fix bitwise fields for "is_events"

----
 fs/tracefs/inode.c    | 4 ++++
 fs/tracefs/internal.h | 2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)
---------------------------
diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
index 62524b20964e..bc86ffdb103b 100644
--- a/fs/tracefs/inode.c
+++ b/fs/tracefs/inode.c
@@ -215,6 +215,10 @@ static void set_gid(struct dentry *parent, kgid_t gid)
 		struct dentry *dentry = list_entry(tmp, struct dentry, d_child);
 		next = tmp->next;
 
+		/* Note, getdents() can add a cursor dentry with no inode */
+		if (!dentry->d_inode)
+			continue;
+
 		spin_lock_nested(&dentry->d_lock, DENTRY_D_LOCK_NESTED);
 
 		change_gid(dentry, gid);
diff --git a/fs/tracefs/internal.h b/fs/tracefs/internal.h
index 899e447778ac..42bdeb471a07 100644
--- a/fs/tracefs/internal.h
+++ b/fs/tracefs/internal.h
@@ -63,7 +63,7 @@ struct eventfs_inode {
 	};
 	unsigned int			is_freed:1;
 	unsigned int			is_events:1;
-	unsigned int			nr_entries:31;
+	unsigned int			nr_entries:30;
 };
 
 static inline struct tracefs_inode *get_tracefs(const struct inode *inode)

