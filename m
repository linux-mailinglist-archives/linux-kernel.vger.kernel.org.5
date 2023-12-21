Return-Path: <linux-kernel+bounces-8658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5352781BAB6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 16:27:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1071328D4AF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 15:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAE9B59926;
	Thu, 21 Dec 2023 15:26:01 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA345991F
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 15:26:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20E2FC433C7;
	Thu, 21 Dec 2023 15:26:00 +0000 (UTC)
Date: Thu, 21 Dec 2023 10:27:03 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Randy Dunlap
 <rdunlap@infradead.org>, Alexander Graf <graf@amazon.com>
Subject: [GIT PULL] tracing: A few more fixes for 6.7
Message-ID: <20231221102703.08dc1273@gandalf.local.home>
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

Tracing fixes for 6.7:

- Fix another kerneldoc warning

- Fix eventfs files to inherit the ownership of its parent directory.
  The dynamic creating of dentries in eventfs did not take into
  account if the tracefs file system was mounted with a gid/uid,
  and would still default to the gid/uid of root. This is a regression.

- Fix warning when synthetic event testing is enabled along with
  startup event tracing testing is enabled


Please pull the latest trace-v6.7-rc6-2 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace-v6.7-rc6-2

Tag SHA1: 075832106638b57ad8e9b24891fec6d49aec5258
Head SHA1: 88b30c7f5d27e1594d70dc2bd7199b18f2b57fa9


Randy Dunlap (1):
      tracing/synthetic: fix kernel-doc warnings

Steven Rostedt (Google) (2):
      eventfs: Have event files and directories default to parent uid and gid
      tracing / synthetic: Disable events after testing in synth_event_gen_test_init()

----
 fs/tracefs/event_inode.c            | 12 +++++++++---
 kernel/trace/synth_event_gen_test.c | 11 +++++++++++
 kernel/trace/trace_events_synth.c   |  4 ++--
 3 files changed, 22 insertions(+), 5 deletions(-)
---------------------------
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
diff --git a/kernel/trace/synth_event_gen_test.c b/kernel/trace/synth_event_gen_test.c
index 8dfe85499d4a..354c2117be43 100644
--- a/kernel/trace/synth_event_gen_test.c
+++ b/kernel/trace/synth_event_gen_test.c
@@ -477,6 +477,17 @@ static int __init synth_event_gen_test_init(void)
 
 	ret = test_trace_synth_event();
 	WARN_ON(ret);
+
+	/* Disable when done */
+	trace_array_set_clr_event(gen_synth_test->tr,
+				  "synthetic",
+				  "gen_synth_test", false);
+	trace_array_set_clr_event(empty_synth_test->tr,
+				  "synthetic",
+				  "empty_synth_test", false);
+	trace_array_set_clr_event(create_synth_test->tr,
+				  "synthetic",
+				  "create_synth_test", false);
  out:
 	return ret;
 }
diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
index 846e02c0fb59..e7af286af4f1 100644
--- a/kernel/trace/trace_events_synth.c
+++ b/kernel/trace/trace_events_synth.c
@@ -1137,7 +1137,7 @@ EXPORT_SYMBOL_GPL(synth_event_add_fields);
  * @cmd: A pointer to the dynevent_cmd struct representing the new event
  * @name: The name of the synthetic event
  * @mod: The module creating the event, NULL if not created from a module
- * @args: Variable number of arg (pairs), one pair for each field
+ * @...: Variable number of arg (pairs), one pair for each field
  *
  * NOTE: Users normally won't want to call this function directly, but
  * rather use the synth_event_gen_cmd_start() wrapper, which
@@ -1695,7 +1695,7 @@ __synth_event_trace_end(struct synth_event_trace_state *trace_state)
  * synth_event_trace - Trace a synthetic event
  * @file: The trace_event_file representing the synthetic event
  * @n_vals: The number of values in vals
- * @args: Variable number of args containing the event values
+ * @...: Variable number of args containing the event values
  *
  * Trace a synthetic event using the values passed in the variable
  * argument list.

