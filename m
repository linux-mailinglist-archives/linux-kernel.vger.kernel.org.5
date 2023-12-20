Return-Path: <linux-kernel+bounces-6960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F071819FD2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 14:30:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8891FB250B0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 13:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 371622D634;
	Wed, 20 Dec 2023 13:30:00 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA6382D638;
	Wed, 20 Dec 2023 13:29:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AAEBC433C8;
	Wed, 20 Dec 2023 13:29:58 +0000 (UTC)
Date: Wed, 20 Dec 2023 08:30:58 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Dongliang Cui <dongliang.cui@unisoc.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, <linux-kernel@vger.kernel.org>,
 <linux-trace-kernel@vger.kernel.org>, Dongliang Cui
 <cuidongliang390@gmail.com>, Hongyu Jin <hongyu.jin@unisoc.com>
Subject: Re: [PATCH]eventfs: Apply the gid in the mounting parameters to all
 files
Message-ID: <20231220083058.09196546@gandalf.local.home>
In-Reply-To: <1703063706-30539-1-git-send-email-dongliang.cui@unisoc.com>
References: <1703063706-30539-1-git-send-email-dongliang.cui@unisoc.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 20 Dec 2023 17:15:06 +0800
Dongliang Cui <dongliang.cui@unisoc.com> wrote:

> I found that in the latest version, the nodes of 
> tracefs have been changed to dynamically created.
> 
> This has caused me to encounter a problem where 
> the gid I specified in the mounting parameters 
> cannot apply to all files, as in the following
> situation:
> 
> /data/tmp/events # mount | grep tracefs
> tracefs on /data/tmp type tracefs (rw,seclabel,relatime,gid=3012)
> 
> gid 3012 = readtracefs
> 
> /data/tmp # ls -lh
> total 0
> -r--r-----   1 root readtracefs 0 1970-01-01 08:00 README
> -r--r-----   1 root readtracefs 0 1970-01-01 08:00 available_events
> 
> ums9621_1h10:/data/tmp/events # ls -lh
> total 0
> drwxr-xr-x 2 root root 0 2023-12-19 00:56 alarmtimer
> drwxr-xr-x 2 root root 0 2023-12-19 00:56 asoc
> 
> It will prevent certain applications from accessing
> tracefs properly, I try to avoid this issue by making 
> the following modifications.
> 
> Signed-off-by: Dongliang Cui <dongliang.cui@unisoc.com>


Thanks for the report, can you try this fix instead?

-- Steve

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

