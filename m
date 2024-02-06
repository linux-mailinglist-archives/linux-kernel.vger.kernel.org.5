Return-Path: <linux-kernel+bounces-54901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8D0584B4FF
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 13:20:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E925F1C23DD8
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 12:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1185013C1E4;
	Tue,  6 Feb 2024 12:09:28 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72662137C5C;
	Tue,  6 Feb 2024 12:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707221362; cv=none; b=ppSRaLASj5elmipnamstQanNqnqFDpgUrJ5AQlwnhR5gj1Vj8hRCopzLwfnit2FVKSblBhjn1YUF3T8HSuFUhXG843lrIuXONn9RD4Za1nZRvQGd+S1FtTkCROc8pRe+qGWiYPBqAqpDys/ZY7OKWDBrBa1Mrfg4NIR2khaHwio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707221362; c=relaxed/simple;
	bh=zEAElJsFmiyF2k5GDTno69bAq8vWad8f06dz1WGJBYo=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=KOcGJJgj7tn1KzqiUiFauouZc/8OC8t1HczsTXMinbrj0MyNiWx/ut/23cjL0FRPczquUHTot1eOtEHeXb1Nkh9qMqPIvfVpeL1bgaTRuDwO20velV+kS5Nql5f77YG4AJ/HDX/RV+nmvfz5LfYAkcBt2Vt7Z+a4bCacs7bcOT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 236CAC433B2;
	Tue,  6 Feb 2024 12:09:22 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@rostedt.homelinux.com>)
	id 1rXKGs-00000006bDq-2TH9;
	Tue, 06 Feb 2024 07:09:50 -0500
Message-ID: <20240206120950.446963304@rostedt.homelinux.com>
User-Agent: quilt/0.67
Date: Tue, 06 Feb 2024 07:09:30 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sasha Levin <sashal@kernel.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Naresh Kamboju <naresh.kamboju@linaro.org>,
 Linux Kernel Functional Testing <lkft@linaro.org>
Subject: [v6.6][PATCH 25/57] eventfs: Do not invalidate dentry in create_file/dir_dentry()
References: <20240206120905.570408983@rostedt.homelinux.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

With the call to simple_recursive_removal() on the entire eventfs sub
system when the directory is removed, it performs the d_invalidate on all
the dentries when it is removed. There's no need to do clean ups when a
dentry is being created while the directory is being deleted.

As dentries are cleaned up by the simpler_recursive_removal(), trying to
do d_invalidate() in these functions will cause the dentry to be
invalidated twice, and crash the kernel.

Link: https://lore.kernel.org/all/20231116123016.140576-1-naresh.kamboju@linaro.org/
Link: https://lkml.kernel.org/r/20231120235154.422970988@goodmis.org

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Fixes: 407c6726ca71 ("eventfs: Use simple_recursive_removal() to clean up dentries")
Reported-by: Mark Rutland <mark.rutland@arm.com>
Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
(cherry picked from commit 71cade82f2b553a74d046c015c986f2df165696f)
---
 fs/tracefs/event_inode.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index f239b2b507a4..3eb6c622a74d 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -326,7 +326,6 @@ create_file_dentry(struct eventfs_inode *ei, int idx,
 	struct eventfs_attr *attr = NULL;
 	struct dentry **e_dentry = &ei->d_children[idx];
 	struct dentry *dentry;
-	bool invalidate = false;
 
 	mutex_lock(&eventfs_mutex);
 	if (ei->is_freed) {
@@ -389,17 +388,14 @@ create_file_dentry(struct eventfs_inode *ei, int idx,
 		 * Otherwise it means two dentries exist with the same name.
 		 */
 		WARN_ON_ONCE(!ei->is_freed);
-		invalidate = true;
+		dentry = NULL;
 	}
 	mutex_unlock(&eventfs_mutex);
 
-	if (invalidate)
-		d_invalidate(dentry);
-
-	if (lookup || invalidate)
+	if (lookup)
 		dput(dentry);
 
-	return invalidate ? NULL : dentry;
+	return dentry;
 }
 
 /**
@@ -439,7 +435,6 @@ static struct dentry *
 create_dir_dentry(struct eventfs_inode *pei, struct eventfs_inode *ei,
 		  struct dentry *parent, bool lookup)
 {
-	bool invalidate = false;
 	struct dentry *dentry = NULL;
 
 	mutex_lock(&eventfs_mutex);
@@ -495,16 +490,14 @@ create_dir_dentry(struct eventfs_inode *pei, struct eventfs_inode *ei,
 		 * Otherwise it means two dentries exist with the same name.
 		 */
 		WARN_ON_ONCE(!ei->is_freed);
-		invalidate = true;
+		dentry = NULL;
 	}
 	mutex_unlock(&eventfs_mutex);
-	if (invalidate)
-		d_invalidate(dentry);
 
-	if (lookup || invalidate)
+	if (lookup)
 		dput(dentry);
 
-	return invalidate ? NULL : dentry;
+	return dentry;
 }
 
 /**
-- 
2.43.0



