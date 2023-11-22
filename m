Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F02F7F50C3
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 20:37:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344543AbjKVThM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 14:37:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344421AbjKVTg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 14:36:59 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D47A1AE;
        Wed, 22 Nov 2023 11:36:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=rNmpOBKWoYfvVrhEukRAAHBSo1Q96GuxaczyMAbV7AU=; b=pG8jo4TPLP4OImKO1wWH4A1imn
        jY0RlChB5b9gcRdaSNvfTTygnHegbVfpY3EmJWx5Z6c1WUqI/Io1RU5pcNeH22yLPk54ZUe2T4eCf
        o7jGAJSzH3FksmBNhRWpSPA56egeiD7tUjiBFz/FIk6xNOI0PDTRmIgwzQqwuGaNueXaYKsGdKZgX
        LTNxN7fbMbs0T4dweEgv9ND+T8geZzkwX3NNjV1vAmzeCHrfSl3wL38z8I5eEhr/8ri0PHe5NfpVf
        tZwIHghZnX3G1D5CBeRIaW52QlCUgo4GEXaw/XBli2BF+5eLGwQU6PjNGOGHOtOm66D50TaHNVpnG
        ukkxBUZw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1r5t1o-001l1i-2l;
        Wed, 22 Nov 2023 19:36:52 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mo Zou <lostzoumo@gmail.com>, Jan Kara <jack@suse.cz>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/9] udf_rename(): only access the child content on cross-directory rename
Date:   Wed, 22 Nov 2023 19:36:46 +0000
Message-Id: <20231122193652.419091-3-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231122193652.419091-1-viro@zeniv.linux.org.uk>
References: <20231122193028.GE38156@ZenIV>
 <20231122193652.419091-1-viro@zeniv.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We can't really afford locking the source on same-directory rename;
currently vfs_rename() tries to do that, but it will have to be
changed.  The logics in udf_rename() is lazy and goes looking for
".." in source even in same-directory case.  It's not hard to get
rid of that, leaving that behaviour only for cross-directory case;
that VFS can get locks safely (and will keep doing that after the
coming changes).

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/udf/namei.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/udf/namei.c b/fs/udf/namei.c
index 3508ac484da3..fac806a7a8d4 100644
--- a/fs/udf/namei.c
+++ b/fs/udf/namei.c
@@ -766,7 +766,7 @@ static int udf_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 	struct inode *old_inode = d_inode(old_dentry);
 	struct inode *new_inode = d_inode(new_dentry);
 	struct udf_fileident_iter oiter, niter, diriter;
-	bool has_diriter = false;
+	bool has_diriter = false, is_dir = false;
 	int retval;
 	struct kernel_lb_addr tloc;
 
@@ -789,6 +789,9 @@ static int udf_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 			if (!empty_dir(new_inode))
 				goto out_oiter;
 		}
+		is_dir = true;
+	}
+	if (is_dir && old_dir != new_dir) {
 		retval = udf_fiiter_find_entry(old_inode, &dotdot_name,
 					       &diriter);
 		if (retval == -ENOENT) {
@@ -878,7 +881,9 @@ static int udf_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 			       udf_dir_entry_len(&diriter.fi));
 		udf_fiiter_write_fi(&diriter, NULL);
 		udf_fiiter_release(&diriter);
+	}
 
+	if (is_dir) {
 		inode_dec_link_count(old_dir);
 		if (new_inode)
 			inode_dec_link_count(new_inode);
-- 
2.39.2

