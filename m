Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C2967CD8D5
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 12:09:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230398AbjJRKI5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 06:08:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjJRKI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 06:08:56 -0400
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6539410A;
        Wed, 18 Oct 2023 03:08:53 -0700 (PDT)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4S9RQ70LnDz8XrRC;
        Wed, 18 Oct 2023 18:08:47 +0800 (CST)
Received: from szxlzmapp05.zte.com.cn ([10.5.230.85])
        by mse-fl2.zte.com.cn with SMTP id 39IA8ghC093171;
        Wed, 18 Oct 2023 18:08:42 +0800 (+08)
        (envelope-from cheng.lin130@zte.com.cn)
Received: from mapi (szxlzmapp04[null])
        by mapi (Zmail) with MAPI id mid14;
        Wed, 18 Oct 2023 18:08:45 +0800 (CST)
Date:   Wed, 18 Oct 2023 18:08:45 +0800 (CST)
X-Zmail-TransId: 2b06652faeadffffffffbf8-6e3ce
X-Mailer: Zmail v1.0
Message-ID: <202310181808454230330@zte.com.cn>
Mime-Version: 1.0
From:   <cheng.lin130@zte.com.cn>
To:     <brauner@kernel.org>, <viro@zeniv.linux.org.uk>,
        <djwong@kernel.org>
Cc:     <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <david@fromorbit.com>, <hch@infradead.org>,
        <jiang.yong5@zte.com.cn>, <wang.liang82@zte.com.cn>,
        <liu.dong3@zte.com.cn>
Subject: =?UTF-8?B?W1JGQyBQQVRDSCB2Ml0gZnM6IGludHJvZHVjZSBjaGVjayBmb3IgaW5vZGUgbmxpbmsgd2hlbiBkZWxldGU=?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 39IA8ghC093171
X-Fangmail-Gw-Spam-Type: 0
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 652FAEAF.000/4S9RQ70LnDz8XrRC
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cheng Lin <cheng.lin130@zte.com.cn>

Do not delete inode which nlink already zero to avoid
inode nlink underflow.

Signed-off-by: Cheng Lin <cheng.lin130@zte.com.cn>
---
 fs/namei.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/namei.c b/fs/namei.c
index e56ff39a7..30bc0d0a6 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4197,6 +4197,11 @@ int vfs_rmdir(struct mnt_idmap *idmap, struct inode *dir,
 	if (error)
 		goto out;

+	if (unlikely(dir->i_nlink == 0) ||
+	    unlikely(dentry->d_inode->i_nlink == 0)) {
+		error = -EUCLEAN;
+		goto out;
+	}
 	error = dir->i_op->rmdir(dir, dentry);
 	if (error)
 		goto out;
@@ -4326,6 +4331,10 @@ int vfs_unlink(struct mnt_idmap *idmap, struct inode *dir,
 			error = try_break_deleg(target, delegated_inode);
 			if (error)
 				goto out;
+			if (unlikely(target->i_nlink == 0)) {
+				error = -EUCLEAN;
+				goto out;
+			}
 			error = dir->i_op->unlink(dir, dentry);
 			if (!error) {
 				dont_mount(dentry);
-- 
2.18.1
