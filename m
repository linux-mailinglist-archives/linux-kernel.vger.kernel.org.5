Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4DC07DE786
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 22:46:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346297AbjKAViY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 17:38:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345815AbjKAViH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 17:38:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52643123
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 14:38:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0284CC433CB;
        Wed,  1 Nov 2023 21:38:05 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1qyIua-00Edc9-0O;
        Wed, 01 Nov 2023 17:38:04 -0400
Message-ID: <20231101213803.934710766@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 01 Nov 2023 17:37:29 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ajay Kaher <akaher@vmware.com>
Subject: [for-next][PATCH 11/12] eventfs: Remove special processing of dput() of events directory
References: <20231101213718.381015321@goodmis.org>
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

The top level events directory is no longer special with regards to how it
should be delete. Remove the extra processing for it in
eventfs_set_ei_status_free().

Link: https://lkml.kernel.org/r/20231101172650.340876747@goodmis.org

Cc: Ajay Kaher <akaher@vmware.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 fs/tracefs/event_inode.c | 19 ++-----------------
 1 file changed, 2 insertions(+), 17 deletions(-)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index 0a04ae0ca8c8..0087a3f455f1 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -274,28 +274,11 @@ static void free_ei(struct eventfs_inode *ei)
  */
 void eventfs_set_ei_status_free(struct tracefs_inode *ti, struct dentry *dentry)
 {
-	struct tracefs_inode *ti_parent;
 	struct eventfs_inode *ei;
 	int i;
 
-	/* The top level events directory may be freed by this */
-	if (unlikely(ti->flags & TRACEFS_EVENT_TOP_INODE)) {
-		mutex_lock(&eventfs_mutex);
-		ei = ti->private;
-		/* Nothing should access this, but just in case! */
-		ti->private = NULL;
-		mutex_unlock(&eventfs_mutex);
-
-		free_ei(ei);
-		return;
-	}
-
 	mutex_lock(&eventfs_mutex);
 
-	ti_parent = get_tracefs(dentry->d_parent->d_inode);
-	if (!ti_parent || !(ti_parent->flags & TRACEFS_EVENT_INODE))
-		goto out;
-
 	ei = dentry->d_fsdata;
 	if (!ei)
 		goto out;
@@ -920,6 +903,8 @@ struct eventfs_inode *eventfs_create_events_dir(const char *name, struct dentry
 	inode->i_op = &eventfs_root_dir_inode_operations;
 	inode->i_fop = &eventfs_file_operations;
 
+	dentry->d_fsdata = ei;
+
 	/* directory inodes start off with i_nlink == 2 (for "." entry) */
 	inc_nlink(inode);
 	d_instantiate(dentry, inode);
-- 
2.42.0
