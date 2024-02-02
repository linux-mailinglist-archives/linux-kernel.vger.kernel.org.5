Return-Path: <linux-kernel+bounces-49103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 852108465E0
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 03:31:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A4901F272B1
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 02:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0351171BA;
	Fri,  2 Feb 2024 02:30:07 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3719EAFB
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 02:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706841005; cv=none; b=bhgowyBESenmgL4XlXCD+Jbea/pnTBTQDjwbalAqlIVN6XIJWmO99gVD8tS9f5sq5tl/Wa/HhHntwXK53VzK8AhnKTot8cqDuaZwANvEjCLD5h8vO7CLisvdNQuIHuXWbWXMFJ6KuOnvdjELJtQDeiutqO+L4Tz73zKVtv4w9j4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706841005; c=relaxed/simple;
	bh=bzFVFZX6ZxTI6abHrIBPqY91OKE0skzJprX6xWIWAm4=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=UE5OrY9dgpRb9mdx61g19Y/NjqWQJRXz2iIMItkhdj4qU9DRouqEx7SdUYqSsT/URFOAE/1jf59N0xObuIiwAhqbkEja6U2uurUEiHg3jSn8qf1bCmAkap4RDGLBjBO+NaisYwv95dELm7Mi9Clv3A/Jh1VaoB0vx8dB4bRnWLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84E8DC43601;
	Fri,  2 Feb 2024 02:30:05 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1rVjJv-00000005kAa-2jFi;
	Thu, 01 Feb 2024 21:30:23 -0500
Message-ID: <20240202023023.512233945@goodmis.org>
User-Agent: quilt/0.67
Date: Thu, 01 Feb 2024 21:30:09 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Christian Brauner <brauner@kernel.org>,
 Al Viro <viro@ZenIV.linux.org.uk>,
 Ajay Kaher <ajay.kaher@broadcom.com>
Subject: [for-linus][PATCH 10/13] eventfs: Warn if an eventfs_inode is freed without is_freed being set
References: <20240202022959.515961549@goodmis.org>
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



