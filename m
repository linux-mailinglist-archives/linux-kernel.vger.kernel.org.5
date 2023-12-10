Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF56680BD61
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 22:38:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232102AbjLJVfe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 16:35:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjLJVfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 16:35:33 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D7EE7CF;
        Sun, 10 Dec 2023 13:35:39 -0800 (PST)
Received: from localhost.localdomain (unknown [4.155.48.117])
        by linux.microsoft.com (Postfix) with ESMTPSA id 0B1F620B74C0;
        Sun, 10 Dec 2023 13:35:39 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0B1F620B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1702244139;
        bh=AwLPxkWSQ+xItqIkFFnflTbsJwcL70eHM305+He6/Pg=;
        h=From:To:Cc:Subject:Date:From;
        b=Q0yqQ06DL6j6eJXGiMYqLMRzH0Z35EwyGtwfYeQo39pIavtQQswP9U9W+Y2C4mnK5
         4DOQl4iBwB/Fdjj1Twp+REAOorZvSpve6dVXFD+7rnWCyPFshu2X+bO0PC3bT60Jod
         +u8XHr4jdJl+or4ylxmDlOSB7qLan3taIGygsXug=
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     rostedt@goodmis.org
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: [PATCH] eventfs: Fix events beyond NAME_MAX blocking tasks
Date:   Sun, 10 Dec 2023 21:35:34 +0000
Message-Id: <20231210213534.497-1-beaub@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-17.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eventfs uses simple_lookup(), however, it will fail if the name of the
entry is beyond NAME_MAX length. When this error is encountered, eventfs
still tries to create dentries instead of skipping the dentry creation.
When the dentry is attempted to be created in this state d_wait_lookup()
will loop forever, waiting for the lookup to be removed.

Fix eventfs to return the error in simple_lookup() back to the caller
instead of continuing to try to create the dentry.

Fixes: 63940449555e ("eventfs: Implement eventfs lookup, read, open functions")
Link: https://lore.kernel.org/linux-trace-kernel/20231208183601.GA46-beaub@linux.microsoft.com/
Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
---
Please note the fixes tag is the first add of simple_lookup logic, there
have been other changes beyond that may be a better fit to targetting.

 fs/tracefs/event_inode.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index f8a594a50ae6..d2c06ba26db4 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -561,6 +561,8 @@ static struct dentry *eventfs_root_lookup(struct inode *dir,
 		if (strcmp(ei_child->name, name) != 0)
 			continue;
 		ret = simple_lookup(dir, dentry, flags);
+		if (IS_ERR(ret))
+			goto out;
 		create_dir_dentry(ei, ei_child, ei_dentry, true);
 		created = true;
 		break;
@@ -583,6 +585,8 @@ static struct dentry *eventfs_root_lookup(struct inode *dir,
 			if (r <= 0)
 				continue;
 			ret = simple_lookup(dir, dentry, flags);
+			if (IS_ERR(ret))
+				goto out;
 			create_file_dentry(ei, i, ei_dentry, name, mode, cdata,
 					   fops, true);
 			break;
-- 
2.34.1

