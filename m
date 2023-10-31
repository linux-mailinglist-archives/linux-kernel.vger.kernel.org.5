Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 374477DD646
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 19:47:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233281AbjJaSrN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 14:47:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231676AbjJaSrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 14:47:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DCCB8E
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 11:47:09 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B737C433C7;
        Tue, 31 Oct 2023 18:47:08 +0000 (UTC)
Date:   Tue, 31 Oct 2023 14:47:03 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ajay Kaher <akaher@vmware.com>
Subject: [PATCH] eventfs: Process deletion of dentry more thoroughly
Message-ID: <20231031144703.71eef3a0@gandalf.local.home>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

Looking at how dentry is removed via the tracefs system, I found that
eventfs does not do everything that it did under tracefs. The tracefs
removal of a dentry calls simple_recursive_removal() that does a lot more
than a simple d_invalidate().

Have the same done on eventfs dentry:

 1. Set S_DEAD for directories
 2. Call clear_nlink() on the dentry inode
 3. Call any notifiers about the dentry removal

Cc: stable@vger.kernel.org
Fixes: 5bdcd5f5331a2 ("eventfs: Implement removal of meta data from eventfs")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 fs/tracefs/event_inode.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index 4d2da7480e5f..ab807edaf538 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -856,6 +856,7 @@ static void unhook_dentry(struct dentry **dentry, struct dentry **list)
 		*dentry = NULL;
 	}
 }
+
 /**
  * eventfs_remove_dir - remove eventfs dir or file from list
  * @ei: eventfs_inode to be removed.
@@ -868,6 +869,7 @@ void eventfs_remove_dir(struct eventfs_inode *ei)
 	LIST_HEAD(ei_del_list);
 	struct dentry *dentry_list = NULL;
 	struct dentry *dentry;
+	struct inode *inode;
 	int i;
 
 	if (!ei)
@@ -891,7 +893,28 @@ void eventfs_remove_dir(struct eventfs_inode *ei)
 		ptr = (unsigned long)dentry->d_fsdata & ~1UL;
 		dentry_list = (struct dentry *)ptr;
 		dentry->d_fsdata = NULL;
+
+		inode = dentry->d_inode;
+		inode_lock(inode);
+		if (d_is_dir(dentry))
+			inode->i_flags |= S_DEAD;
+		clear_nlink(inode);
+		inode_unlock(inode);
+
+		inode = dentry->d_parent->d_inode;
+		inode_lock(inode);
+
+		/* Remove its visibility */
 		d_invalidate(dentry);
+		if (d_is_dir(dentry))
+			fsnotify_rmdir(inode, dentry);
+		else
+			fsnotify_unlink(inode, dentry);
+
+		if (d_is_dir(dentry))
+			drop_nlink(inode);
+		inode_unlock(inode);
+
 		mutex_lock(&eventfs_mutex);
 		/* dentry should now have at least a single reference */
 		WARN_ONCE((int)d_count(dentry) < 1,
-- 
2.42.0

