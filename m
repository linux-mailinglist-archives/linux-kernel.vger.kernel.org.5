Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DBBE7F656B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 18:30:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345557AbjKWRaU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 12:30:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbjKWRaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 12:30:11 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E1651BE
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 09:30:17 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4202FC433CC;
        Thu, 23 Nov 2023 17:30:17 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97-RC3)
        (envelope-from <rostedt@goodmis.org>)
        id 1r6DX8-0000000366d-3kxu;
        Thu, 23 Nov 2023 12:30:34 -0500
Message-ID: <20231123173034.759631168@goodmis.org>
User-Agent: quilt/0.67
Date:   Thu, 23 Nov 2023 12:25:41 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [for-linus][PATCH 2/5] eventfs: Move taking of inode_lock into dcache_dir_open_wrapper()
References: <20231123172539.582640797@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

The both create_file_dentry() and create_dir_dentry() takes a boolean
parameter "lookup", as on lookup the inode_lock should already be taken,
but for dcache_dir_open_wrapper() it is not taken.

There's no reason that the dcache_dir_open_wrapper() can't take the
inode_lock before calling these functions. In fact, it's better if it
does, as the lock can be held throughout both directory and file
creations.

This also simplifies the code, and possibly prevents unexpected race
conditions when the lock is released.

Link: https://lkml.kernel.org/r/20231121231112.528544825@goodmis.org

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Fixes: 5790b1fb3d672 ("eventfs: Remove eventfs_file and just use eventfs_inode")
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 fs/tracefs/event_inode.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index 56d192f0ead8..590e8176449b 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -347,15 +347,8 @@ create_file_dentry(struct eventfs_inode *ei, int idx,
 
 	mutex_unlock(&eventfs_mutex);
 
-	/* The lookup already has the parent->d_inode locked */
-	if (!lookup)
-		inode_lock(parent->d_inode);
-
 	dentry = create_file(name, mode, attr, parent, data, fops);
 
-	if (!lookup)
-		inode_unlock(parent->d_inode);
-
 	mutex_lock(&eventfs_mutex);
 
 	if (IS_ERR_OR_NULL(dentry)) {
@@ -453,15 +446,8 @@ create_dir_dentry(struct eventfs_inode *pei, struct eventfs_inode *ei,
 	}
 	mutex_unlock(&eventfs_mutex);
 
-	/* The lookup already has the parent->d_inode locked */
-	if (!lookup)
-		inode_lock(parent->d_inode);
-
 	dentry = create_dir(ei, parent);
 
-	if (!lookup)
-		inode_unlock(parent->d_inode);
-
 	mutex_lock(&eventfs_mutex);
 
 	if (IS_ERR_OR_NULL(dentry) && !ei->is_freed) {
@@ -693,6 +679,7 @@ static int dcache_dir_open_wrapper(struct inode *inode, struct file *file)
 		return -ENOMEM;
 	}
 
+	inode_lock(parent->d_inode);
 	list_for_each_entry_srcu(ei_child, &ei->children, list,
 				 srcu_read_lock_held(&eventfs_srcu)) {
 		d = create_dir_dentry(ei, ei_child, parent, false);
@@ -725,6 +712,7 @@ static int dcache_dir_open_wrapper(struct inode *inode, struct file *file)
 			cnt++;
 		}
 	}
+	inode_unlock(parent->d_inode);
 	srcu_read_unlock(&eventfs_srcu, idx);
 	ret = dcache_dir_open(inode, file);
 
-- 
2.42.0


