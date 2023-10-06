Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 875207BC2D7
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 01:12:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233889AbjJFXMm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 19:12:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233627AbjJFXMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 19:12:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 436B19C
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 16:12:39 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D88A1C433C8;
        Fri,  6 Oct 2023 23:12:38 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1qou11-005rOB-1q;
        Fri, 06 Oct 2023 19:13:51 -0400
Message-ID: <20231006231351.389766059@goodmis.org>
User-Agent: quilt/0.66
Date:   Fri, 06 Oct 2023 19:13:25 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kernel test robot <lkp@intel.com>
Subject: [for-next][PATCH 1/2] eventfs: Use eventfs_remove_events_dir()
References: <20231006231324.646666118@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

The update to removing the eventfs_file changed the way the events top
level directory was handled. Instead of returning a dentry, it now returns
the eventfs_inode. In this changed, the removing of the events top level
directory is not much different than removing any of the other
directories. Because of this, the removal just called eventfs_remove_dir()
instead of eventfs_remove_events_dir().

Although eventfs_remove_dir() does the clean up, it misses out on the
dget() of the ei->dentry done in eventfs_create_events_dir(). It makes
more sense to match eventfs_create_events_dir() with a specific function
eventfs_remove_events_dir() and this specific function can then perform
the dput() to the dentry that had the dget() when it was created.

Fixes: 5790b1fb3d67 ("eventfs: Remove eventfs_file and just use eventfs_inode")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202310051743.y9EobbUr-lkp@intel.com/
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 fs/tracefs/event_inode.c    | 19 +++++++------------
 include/linux/tracefs.h     |  1 +
 kernel/trace/trace_events.c |  2 +-
 3 files changed, 9 insertions(+), 13 deletions(-)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index eab18b157ef5..1ccd100bc565 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -901,22 +901,17 @@ void eventfs_remove_dir(struct eventfs_inode *ei)
 }
 
 /**
- * eventfs_remove_events_dir - remove eventfs dir or file from list
- * @dentry: events's dentry to be removed.
+ * eventfs_remove_events_dir - remove the top level eventfs directory
+ * @ei: the event_inode returned by eventfs_create_events_dir().
  *
- * This function remove events main directory
+ * This function removes the events main directory
  */
-void eventfs_remove_events_dir(struct dentry *dentry)
+void eventfs_remove_events_dir(struct eventfs_inode *ei)
 {
-	struct tracefs_inode *ti;
-
-	if (!dentry || !dentry->d_inode)
-		return;
+	struct dentry *dentry = ei->dentry;
 
-	ti = get_tracefs(dentry->d_inode);
-	if (!ti || !(ti->flags & TRACEFS_EVENT_INODE))
-		return;
+	eventfs_remove_dir(ei);
 
-	d_invalidate(dentry);
+	/* Matches the dget() from eventfs_create_events_dir() */
 	dput(dentry);
 }
diff --git a/include/linux/tracefs.h b/include/linux/tracefs.h
index 0c39704455d9..13359b1a35d1 100644
--- a/include/linux/tracefs.h
+++ b/include/linux/tracefs.h
@@ -41,6 +41,7 @@ struct eventfs_inode *eventfs_create_dir(const char *name, struct eventfs_inode
 					 const struct eventfs_entry *entries,
 					 int size, void *data);
 
+void eventfs_remove_events_dir(struct eventfs_inode *ei);
 void eventfs_remove_dir(struct eventfs_inode *ei);
 
 struct dentry *tracefs_create_file(const char *name, umode_t mode,
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index a3b9d9423824..0e3a1c70e410 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -3872,7 +3872,7 @@ int event_trace_del_tracer(struct trace_array *tr)
 
 	down_write(&trace_event_sem);
 	__trace_remove_event_dirs(tr);
-	eventfs_remove_dir(tr->event_dir);
+	eventfs_remove_events_dir(tr->event_dir);
 	up_write(&trace_event_sem);
 
 	tr->event_dir = NULL;
-- 
2.40.1
