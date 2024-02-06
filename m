Return-Path: <linux-kernel+bounces-54930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4507A84B51F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 13:26:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 023532818EB
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 12:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFF0314FFB6;
	Tue,  6 Feb 2024 12:09:39 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A94B13BEA8;
	Tue,  6 Feb 2024 12:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707221367; cv=none; b=iDedLZV81DB0aW4gB97tnVwrNINqAd2iy1h7ZdYAIS13AhH8nWrh4Ebty+1gHc5/ou12aK54oHxxwVJ4VOORc/G07hmbEbgUICQ6PPyhVdB8OZZzuRJFAx+ID0YtdYwMjmFaggA+xy1CQBUBN6OJd6EaInD19FS+WhtKYlmWU5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707221367; c=relaxed/simple;
	bh=5yqaMUzsL24Xo1kXlS9YCQkGhNmG85TgGVOtLxrgq1g=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=Zww4dqfKknUfiTMIry+SARhCEVqPEwGS08GrtuJX0dUpcBL8GihkBr+BebVe+7/MrOfbCUJOlMBiNATcA35UHWGDWXVsSYtpsmKk4kMCakdy1CBSBRPz3tX2QJu7B/5vxFpjG7G84ac3ln8U4SkvsjZqfvt0zIW0oRZFwxr6iyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32E20C43390;
	Tue,  6 Feb 2024 12:09:27 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@rostedt.homelinux.com>)
	id 1rXKGx-00000006bTL-2hfg;
	Tue, 06 Feb 2024 07:09:55 -0500
Message-ID: <20240206120955.500466790@rostedt.homelinux.com>
User-Agent: quilt/0.67
Date: Tue, 06 Feb 2024 07:10:01 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sasha Levin <sashal@kernel.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Christian Brauner <brauner@kernel.org>,
 Al Viro <viro@ZenIV.linux.org.uk>,
 Ajay Kaher <ajay.kaher@broadcom.com>,
 Al Viro <viro@zeniv.linux.org.uk>
Subject: [v6.6][PATCH 56/57] eventfs: Remove fsnotify*() functions from lookup()
References: <20240206120905.570408983@rostedt.homelinux.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

The dentries and inodes are created when referenced in the lookup code.
There's no reason to call fsnotify_*() functions when they are created by
a reference. It doesn't make any sense.

Link: https://lore.kernel.org/linux-trace-kernel/20240201002719.GS2087318@ZenIV/
Link: https://lore.kernel.org/linux-trace-kernel/20240201161617.166973329@goodmis.org

Cc: stable@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Al Viro <viro@ZenIV.linux.org.uk>
Cc: Ajay Kaher <ajay.kaher@broadcom.com>
Fixes: a376007917776 ("eventfs: Implement functions to create files and dirs when accessed");
Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
(cherry picked from commit 12d823b31fadf47c8f36ecada7abac5f903cac33)
---
 fs/tracefs/event_inode.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index ca7daee7c811..9e031e5a2713 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -366,7 +366,6 @@ static struct dentry *lookup_file(struct eventfs_inode *parent_ei,
 	dentry->d_fsdata = get_ei(parent_ei);
 
 	d_add(dentry, inode);
-	fsnotify_create(dentry->d_parent->d_inode, dentry);
 	return NULL;
 };
 
@@ -408,7 +407,6 @@ static struct dentry *lookup_dir_entry(struct dentry *dentry,
 	inc_nlink(inode);
 	d_add(dentry, inode);
 	inc_nlink(dentry->d_parent->d_inode);
-	fsnotify_mkdir(dentry->d_parent->d_inode, dentry);
 	return NULL;
 }
 
-- 
2.43.0



