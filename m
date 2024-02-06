Return-Path: <linux-kernel+bounces-54905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF9E984B505
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 13:20:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E5791F21876
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 12:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CE6713DBB3;
	Tue,  6 Feb 2024 12:09:29 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 360F21386AA;
	Tue,  6 Feb 2024 12:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707221363; cv=none; b=N7VLx7rxtb9fnnoEKNl661W3SUGL04KlFsqTUebZudYL1rFp/WZIKU/7ahZm7n3QBIGHSArM0Xga4MwXuDrfHfmhIkRSnAzHepoBOoYSGKoJYdJk9RpByc+XO2wuPRLO/2Uj7cMo+9YKny+k6VuM7vyZWNkKox1M3tvpJ43ZAag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707221363; c=relaxed/simple;
	bh=AUJA/mt2ARUFiCQkvFXc/lpdvePIFrv+PiQkEn2vk7s=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=HnzRYATPuzty+jJVLuf8Z7j12shbJamMTWRsKF0JnkICEZlvaLG3gwJuN4FKrPoUkB/NTrtCHoi3VIlJYtnjltzub3lW9kG7CvGErajPTtsmdMbTwPBJ3MHqjpAZC6zmgnj7RhVV3BYmZhgmeU+SY7TEkAlsdvaQ2KhuNuf/few=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22E34C43399;
	Tue,  6 Feb 2024 12:09:23 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@rostedt.homelinux.com>)
	id 1rXKGt-00000006bGq-2KvK;
	Tue, 06 Feb 2024 07:09:51 -0500
Message-ID: <20240206120951.415245327@rostedt.homelinux.com>
User-Agent: quilt/0.67
Date: Tue, 06 Feb 2024 07:09:36 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sasha Levin <sashal@kernel.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Hongyu Jin <hongyu.jin@unisoc.com>,
 Dongliang Cui <cuidongliang390@gmail.com>
Subject: [v6.6][PATCH 31/57] eventfs: Have event files and directories default to parent uid and
 gid
References: <20240206120905.570408983@rostedt.homelinux.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

Dongliang reported:

  I found that in the latest version, the nodes of tracefs have been
  changed to dynamically created.

  This has caused me to encounter a problem where the gid I specified in
  the mounting parameters cannot apply to all files, as in the following
  situation:

  /data/tmp/events # mount | grep tracefs
  tracefs on /data/tmp type tracefs (rw,seclabel,relatime,gid=3012)

  gid 3012 = readtracefs

  /data/tmp # ls -lh
  total 0
  -r--r-----   1 root readtracefs 0 1970-01-01 08:00 README
  -r--r-----   1 root readtracefs 0 1970-01-01 08:00 available_events

  ums9621_1h10:/data/tmp/events # ls -lh
  total 0
  drwxr-xr-x 2 root root 0 2023-12-19 00:56 alarmtimer
  drwxr-xr-x 2 root root 0 2023-12-19 00:56 asoc

  It will prevent certain applications from accessing tracefs properly, I
  try to avoid this issue by making the following modifications.

To fix this, have the files created default to taking the ownership of
the parent dentry unless the ownership was previously set by the user.

Link: https://lore.kernel.org/linux-trace-kernel/1703063706-30539-1-git-send-email-dongliang.cui@unisoc.com/
Link: https://lore.kernel.org/linux-trace-kernel/20231220105017.1489d790@gandalf.local.home

Cc: stable@vger.kernel.org
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Hongyu Jin  <hongyu.jin@unisoc.com>
Fixes: 28e12c09f5aa0 ("eventfs: Save ownership and mode")
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Reported-by: Dongliang Cui <cuidongliang390@gmail.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
(cherry picked from commit 0dfc852b6fe3cbecbea67332a0dce2bebeba540d)
---
 fs/tracefs/event_inode.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index 43e237864a42..2ccc849a5bda 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -148,7 +148,8 @@ static const struct file_operations eventfs_file_operations = {
 	.release	= eventfs_release,
 };
 
-static void update_inode_attr(struct inode *inode, struct eventfs_attr *attr, umode_t mode)
+static void update_inode_attr(struct dentry *dentry, struct inode *inode,
+			      struct eventfs_attr *attr, umode_t mode)
 {
 	if (!attr) {
 		inode->i_mode = mode;
@@ -162,9 +163,13 @@ static void update_inode_attr(struct inode *inode, struct eventfs_attr *attr, um
 
 	if (attr->mode & EVENTFS_SAVE_UID)
 		inode->i_uid = attr->uid;
+	else
+		inode->i_uid = d_inode(dentry->d_parent)->i_uid;
 
 	if (attr->mode & EVENTFS_SAVE_GID)
 		inode->i_gid = attr->gid;
+	else
+		inode->i_gid = d_inode(dentry->d_parent)->i_gid;
 }
 
 /**
@@ -206,7 +211,7 @@ static struct dentry *create_file(const char *name, umode_t mode,
 		return eventfs_failed_creating(dentry);
 
 	/* If the user updated the directory's attributes, use them */
-	update_inode_attr(inode, attr, mode);
+	update_inode_attr(dentry, inode, attr, mode);
 
 	inode->i_op = &eventfs_file_inode_operations;
 	inode->i_fop = fop;
@@ -242,7 +247,8 @@ static struct dentry *create_dir(struct eventfs_inode *ei, struct dentry *parent
 		return eventfs_failed_creating(dentry);
 
 	/* If the user updated the directory's attributes, use them */
-	update_inode_attr(inode, &ei->attr, S_IFDIR | S_IRWXU | S_IRUGO | S_IXUGO);
+	update_inode_attr(dentry, inode, &ei->attr,
+			  S_IFDIR | S_IRWXU | S_IRUGO | S_IXUGO);
 
 	inode->i_op = &eventfs_root_dir_inode_operations;
 	inode->i_fop = &eventfs_file_operations;
-- 
2.43.0



