Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB9507F219F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 00:52:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232666AbjKTXvr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 18:51:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232590AbjKTXvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 18:51:42 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 842F0C7
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 15:51:39 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25666C433C8;
        Mon, 20 Nov 2023 23:51:39 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97-RC3)
        (envelope-from <rostedt@goodmis.org>)
        id 1r5E3W-00000002Po8-2Nff;
        Mon, 20 Nov 2023 18:51:54 -0500
Message-ID: <20231120235154.422970988@goodmis.org>
User-Agent: quilt/0.67
Date:   Mon, 20 Nov 2023 18:51:07 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Linux Kernel Functional Testing <lkft@linaro.org>
Subject: [PATCH 2/2] eventfs: Do not invalidate dentry in create_file/dir_dentry()
References: <20231120235105.834774147@goodmis.org>
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

With the call to simple_recursive_removal() on the entire eventfs sub
system when the directory is removed, it performs the d_invalidate on all
the dentries when it is removed. There's no need to do clean ups when a
dentry is being created while the directory is being deleted.

As dentries are cleaned up by the simpler_recursive_removal(), trying to
do d_invalidate() in these functions will cause the dentry to be
invalidated twice, and crash the kernel.

Link: https://lore.kernel.org/all/20231116123016.140576-1-naresh.kamboju@linaro.org/

Fixes: 407c6726ca71 ("eventfs: Use simple_recursive_removal() to clean up dentries")
Reported-by: Mark Rutland <mark.rutland@arm.com>
Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
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
2.42.0


