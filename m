Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 741CE7F2143
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 00:16:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230221AbjKTXQZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 18:16:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjKTXQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 18:16:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA1D8C9
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 15:16:15 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96A77C433C8;
        Mon, 20 Nov 2023 23:16:15 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97-RC3)
        (envelope-from <rostedt@goodmis.org>)
        id 1r5DVG-00000002Obr-37eR;
        Mon, 20 Nov 2023 18:16:30 -0500
Message-ID: <20231120231630.606101643@goodmis.org>
User-Agent: quilt/0.67
Date:   Mon, 20 Nov 2023 18:15:54 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-linus][PATCH 1/2] eventfs: Remove expectation that ei->is_freed means ei->dentry ==
 NULL
References: <20231120231553.374392736@goodmis.org>
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

The logic to free the eventfs_inode (ei) use to set is_freed and clear the
"dentry" field under the eventfs_mutex. But that changed when a race was
found where the ei->dentry needed to be cleared when the last dput() was
called on it. But there was still logic that checked if ei->dentry was not
NULL and is_freed is set, and would warn if it was.

But since that situation was changed and the ei->dentry isn't cleared
until the last dput() is called on it while the ei->is_freed is set, do
not test for that condition anymore, and change the comments to reflect
that.

Fixes: 020010fbfa20 ("eventfs: Delete eventfs_inode when the last dentry is freed")
Reported-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 fs/tracefs/event_inode.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index f8a594a50ae6..f239b2b507a4 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -27,16 +27,16 @@
 /*
  * eventfs_mutex protects the eventfs_inode (ei) dentry. Any access
  * to the ei->dentry must be done under this mutex and after checking
- * if ei->is_freed is not set. The ei->dentry is released under the
- * mutex at the same time ei->is_freed is set. If ei->is_freed is set
- * then the ei->dentry is invalid.
+ * if ei->is_freed is not set. When ei->is_freed is set, the dentry
+ * is on its way to being freed after the last dput() is made on it.
  */
 static DEFINE_MUTEX(eventfs_mutex);
 
 /*
  * The eventfs_inode (ei) itself is protected by SRCU. It is released from
  * its parent's list and will have is_freed set (under eventfs_mutex).
- * After the SRCU grace period is over, the ei may be freed.
+ * After the SRCU grace period is over and the last dput() is called
+ * the ei is freed.
  */
 DEFINE_STATIC_SRCU(eventfs_srcu);
 
@@ -365,12 +365,14 @@ create_file_dentry(struct eventfs_inode *ei, int idx,
 		 * created the dentry for this e_dentry. In which case
 		 * use that one.
 		 *
-		 * Note, with the mutex held, the e_dentry cannot have content
-		 * and the ei->is_freed be true at the same time.
+		 * If ei->is_freed is set, the e_dentry is currently on its
+		 * way to being freed, don't return it. If e_dentry is NULL
+		 * it means it was already freed.
 		 */
-		dentry = *e_dentry;
-		if (WARN_ON_ONCE(dentry && ei->is_freed))
+		if (ei->is_freed)
 			dentry = NULL;
+		else
+			dentry = *e_dentry;
 		/* The lookup does not need to up the dentry refcount */
 		if (dentry && !lookup)
 			dget(dentry);
@@ -473,8 +475,8 @@ create_dir_dentry(struct eventfs_inode *pei, struct eventfs_inode *ei,
 		 * created the dentry for this e_dentry. In which case
 		 * use that one.
 		 *
-		 * Note, with the mutex held, the e_dentry cannot have content
-		 * and the ei->is_freed be true at the same time.
+		 * If ei->is_freed is set, the e_dentry is currently on its
+		 * way to being freed.
 		 */
 		dentry = ei->dentry;
 		if (dentry && !lookup)
-- 
2.42.0


