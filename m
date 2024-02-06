Return-Path: <linux-kernel+bounces-54929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EA1284B51D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 13:26:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5C94B253EC
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 12:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11EEF14FF82;
	Tue,  6 Feb 2024 12:09:39 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F19613BE82;
	Tue,  6 Feb 2024 12:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707221367; cv=none; b=madVwKdpydAolG+Hk4HHDzQjFbMnAZHzdKbz0V47OKeN+iG1uMICistydMskwJxW2gdskAhdHjwzdGj4J9mxyw8I8cCG2BypSUmS5vCrWRAzmoLnY3ivc5C4tqpkuZkbe7Myv1XVyMrQuMN+YAEyOwKRLwt5Yn4wrZCSQsw6e6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707221367; c=relaxed/simple;
	bh=TqvI80mt2ZF0Gnam5nEwnKCPn9ZXmcExO8VO54BJ8Dg=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=e66sEhClnVpO7/FtNIgYch6DT/ROVjWLF2fb4UsZ5m3zIIO0osSt8gZW22LNEMR1UurEpLlrtUXUfQPAA6gIUGY1VQ5pghvqvHfMummGG9dvTAHeAAzRBYAI4lk7tTQfs5+xJEFHt3iqlkaZzIS2LyTJEklP5Mmgyd/vB4y0wyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6ADAC43394;
	Tue,  6 Feb 2024 12:09:26 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@rostedt.homelinux.com>)
	id 1rXKGx-00000006bSL-1Jh7;
	Tue, 06 Feb 2024 07:09:55 -0500
Message-ID: <20240206120955.173872948@rostedt.homelinux.com>
User-Agent: quilt/0.67
Date: Tue, 06 Feb 2024 07:09:59 -0500
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
 Ajay Kaher <ajay.kaher@broadcom.com>
Subject: [v6.6][PATCH 54/57] eventfs: Warn if an eventfs_inode is freed without is_freed being set
References: <20240206120905.570408983@rostedt.homelinux.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

There should never be a case where an evenfs_inode is being freed without
is_freed being set. Add a WARN_ON_ONCE() if it ever happens. That would
mean there was one too many put_ei()s.

Link: https://lore.kernel.org/linux-trace-kernel/20240201161616.843551963@goodmis.org

Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Al Viro <viro@ZenIV.linux.org.uk>
Cc: Ajay Kaher <ajay.kaher@broadcom.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
(cherry picked from commit 5a49f996046ba947466bc7461e4b19c4d1daf978)
---
 fs/tracefs/event_inode.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index 515fdace1eea..ca7daee7c811 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -73,6 +73,9 @@ enum {
 static void release_ei(struct kref *ref)
 {
 	struct eventfs_inode *ei = container_of(ref, struct eventfs_inode, kref);
+
+	WARN_ON_ONCE(!ei->is_freed);
+
 	kfree(ei->entry_attrs);
 	kfree_const(ei->name);
 	kfree_rcu(ei, rcu);
@@ -84,6 +87,14 @@ static inline void put_ei(struct eventfs_inode *ei)
 		kref_put(&ei->kref, release_ei);
 }
 
+static inline void free_ei(struct eventfs_inode *ei)
+{
+	if (ei) {
+		ei->is_freed = 1;
+		put_ei(ei);
+	}
+}
+
 static inline struct eventfs_inode *get_ei(struct eventfs_inode *ei)
 {
 	if (ei)
@@ -679,7 +690,7 @@ struct eventfs_inode *eventfs_create_dir(const char *name, struct eventfs_inode
 
 	/* Was the parent freed? */
 	if (list_empty(&ei->list)) {
-		put_ei(ei);
+		free_ei(ei);
 		ei = NULL;
 	}
 	return ei;
@@ -770,7 +781,7 @@ struct eventfs_inode *eventfs_create_events_dir(const char *name, struct dentry
 	return ei;
 
  fail:
-	put_ei(ei);
+	free_ei(ei);
 	tracefs_failed_creating(dentry);
 	return ERR_PTR(-ENOMEM);
 }
@@ -801,9 +812,8 @@ static void eventfs_remove_rec(struct eventfs_inode *ei, int level)
 	list_for_each_entry(ei_child, &ei->children, list)
 		eventfs_remove_rec(ei_child, level + 1);
 
-	ei->is_freed = 1;
 	list_del(&ei->list);
-	put_ei(ei);
+	free_ei(ei);
 }
 
 /**
-- 
2.43.0



