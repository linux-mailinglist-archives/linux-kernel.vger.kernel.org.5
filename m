Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB03B7F3A19
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 00:11:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234895AbjKUXLI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 18:11:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbjKUXLA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 18:11:00 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 347C2191
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 15:10:57 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D1B0C433CA;
        Tue, 21 Nov 2023 23:10:56 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97-RC3)
        (envelope-from <rostedt@goodmis.org>)
        id 1r5Ztg-00000002dEb-3Uvn;
        Tue, 21 Nov 2023 18:11:12 -0500
Message-ID: <20231121231112.693841807@goodmis.org>
User-Agent: quilt/0.67
Date:   Tue, 21 Nov 2023 18:10:06 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 3/4] eventfs: Do not allow NULL parent to eventfs_start_creating()
References: <20231121231003.516999942@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

The eventfs directory is dynamically created via the meta data supplied by
the existing trace events. All files and directories in eventfs has a
parent. Do not allow NULL to be passed into eventfs_start_creating() as
the parent because that should never happen. Warn if it does.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 fs/tracefs/inode.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
index 5b54948514fe..ae648deed019 100644
--- a/fs/tracefs/inode.c
+++ b/fs/tracefs/inode.c
@@ -509,20 +509,15 @@ struct dentry *eventfs_start_creating(const char *name, struct dentry *parent)
 	struct dentry *dentry;
 	int error;
 
+	/* Must always have a parent. */
+	if (WARN_ON_ONCE(!parent))
+		return ERR_PTR(-EINVAL);
+
 	error = simple_pin_fs(&trace_fs_type, &tracefs_mount,
 			      &tracefs_mount_count);
 	if (error)
 		return ERR_PTR(error);
 
-	/*
-	 * If the parent is not specified, we create it in the root.
-	 * We need the root dentry to do this, which is in the super
-	 * block. A pointer to that is in the struct vfsmount that we
-	 * have around.
-	 */
-	if (!parent)
-		parent = tracefs_mount->mnt_root;
-
 	if (unlikely(IS_DEADDIR(parent->d_inode)))
 		dentry = ERR_PTR(-ENOENT);
 	else
-- 
2.42.0


