Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A31A7ED862
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 01:10:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbjKPAIF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 19:08:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbjKPAID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 19:08:03 -0500
Received: from smtp01.aussiebb.com.au (smtp01.aussiebb.com.au [IPv6:2403:5800:3:25::1001])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B10AA19E;
        Wed, 15 Nov 2023 16:07:56 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by smtp01.aussiebb.com.au (Postfix) with ESMTP id 8D4B6100382;
        Thu, 16 Nov 2023 11:07:51 +1100 (AEDT)
X-Virus-Scanned: Debian amavisd-new at smtp01.aussiebb.com.au
Received: from smtp01.aussiebb.com.au ([127.0.0.1])
        by localhost (smtp01.aussiebb.com.au [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id iXf2Fp4tVd8S; Thu, 16 Nov 2023 11:07:51 +1100 (AEDT)
Received: by smtp01.aussiebb.com.au (Postfix, from userid 116)
        id 82227100369; Thu, 16 Nov 2023 11:07:51 +1100 (AEDT)
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
Received: from donald.themaw.com (2403-580f-7fe0--101a.ip6.aussiebb.net [IPv6:2403:580f:7fe0::101a])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: ian146@aussiebb.com.au)
        by smtp01.aussiebb.com.au (Postfix) with ESMTPSA id C1732100290;
        Thu, 16 Nov 2023 11:07:49 +1100 (AEDT)
From:   Ian Kent <raven@themaw.net>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Cc:     Bill O'Donnell <billodo@redhat.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        autofs mailing list <autofs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Ian Kent <raven@themaw.net>,
        syzbot+662f87a8ef490f45fa64@syzkaller.appspotmail.com
Subject: [PATCH] autofs: add: new_inode check in autofs_fill_super()
Date:   Thu, 16 Nov 2023 08:07:46 +0800
Message-ID: <20231116000746.7359-1-raven@themaw.net>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing NULL check of root_inode in autofs_fill_super().

While we are at it simplify the logic by taking advantage of the VFS
cleanup procedures and get rid of the goto error handling, as suggested
by Al Viro.

Signed-off-by: Ian Kent <raven@themaw.net>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Bill O'Donnell <billodo@redhat.com>
Reported-by: syzbot+662f87a8ef490f45fa64@syzkaller.appspotmail.com
---
 fs/autofs/inode.c | 50 ++++++++++++++++++-----------------------------
 1 file changed, 19 insertions(+), 31 deletions(-)

diff --git a/fs/autofs/inode.c b/fs/autofs/inode.c
index a5083d447a62..d5dd4223b461 100644
--- a/fs/autofs/inode.c
+++ b/fs/autofs/inode.c
@@ -311,7 +311,6 @@ static int autofs_fill_super(struct super_block *s, struct fs_context *fc)
 	struct inode *root_inode;
 	struct dentry *root;
 	struct autofs_info *ino;
-	int ret = -ENOMEM;
 
 	pr_debug("starting up, sbi = %p\n", sbi);
 
@@ -328,56 +327,45 @@ static int autofs_fill_super(struct super_block *s, struct fs_context *fc)
 	 */
 	ino = autofs_new_ino(sbi);
 	if (!ino)
-		goto fail;
+		goto -ENOMEM;
 
 	root_inode = autofs_get_inode(s, S_IFDIR | 0755);
-	root_inode->i_uid = ctx->uid;
-	root_inode->i_gid = ctx->gid;
-
-	root = d_make_root(root_inode);
-	if (!root)
-		goto fail_ino;
-
-	root->d_fsdata = ino;
+	if (root_inode) {
+		root_inode->i_uid = ctx->uid;
+		root_inode->i_gid = ctx->gid;
+		root_inode->i_fop = &autofs_root_operations;
+		root_inode->i_op = &autofs_dir_inode_operations;
+	}
+	s->s_root = d_make_root(root_inode);
+	if (unlikely(!s->s_root)) {
+		autofs_free_ino(ino);
+		return -ENOMEM;
+	}
+	s->s_root->d_fsdata = ino;
 
 	if (ctx->pgrp_set) {
 		sbi->oz_pgrp = find_get_pid(ctx->pgrp);
 		if (!sbi->oz_pgrp) {
 			ret = invalf(fc, "Could not find process group %d",
 				     ctx->pgrp);
-			goto fail_dput;
+			return ret;
 		}
 	} else {
 		sbi->oz_pgrp = get_task_pid(current, PIDTYPE_PGID);
 	}
 
 	if (autofs_type_trigger(sbi->type))
-		__managed_dentry_set_managed(root);
-
-	root_inode->i_fop = &autofs_root_operations;
-	root_inode->i_op = &autofs_dir_inode_operations;
+		/* s->s_root won't be contended so there's little to
+		 * be gained by not taking the d_lock when setting
+		 * d_flags, even when a lot mounts are being done.
+		 */
+		managed_dentry_set_managed(s->s_root);
 
 	pr_debug("pipe fd = %d, pgrp = %u\n",
 		 sbi->pipefd, pid_nr(sbi->oz_pgrp));
 
 	sbi->flags &= ~AUTOFS_SBI_CATATONIC;
-
-	/*
-	 * Success! Install the root dentry now to indicate completion.
-	 */
-	s->s_root = root;
 	return 0;
-
-	/*
-	 * Failure ... clean up.
-	 */
-fail_dput:
-	dput(root);
-	goto fail;
-fail_ino:
-	autofs_free_ino(ino);
-fail:
-	return ret;
 }
 
 /*
-- 
2.41.0

