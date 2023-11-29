Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 639EA7FE276
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 22:51:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234746AbjK2VvU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 16:51:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234576AbjK2Vuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 16:50:54 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55E1910D0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 13:51:00 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 184BAC4166B;
        Wed, 29 Nov 2023 21:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701294658;
        bh=sdaoEg9ciUZftk2H34h2y651gj0bEkfe58vTpkMB1yM=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=u8qp9bnx716v5Vigy7mjHUsLCuMP8nLpRUBvItevXMcTOsgzUh/C15VxsDAxnHLnl
         bQ/sevGtoOzwHAK/P6s1Zo18UovQyWcEFbX4W76SZ8q1P0JyTEMu+xmk04h5oRQsLK
         06M8qxJdHM4mde8Q6t2YQNgR9nAKjPfaB6DSpXKDonVoDRjJq/sx1Gv+d8WEOkdpWW
         VXg97Wqp3HWq5G0Xo2/Bm+N6G9GP7uibWBcYYDa/vf4CnGyXnXB78uoWIqTZD3uveb
         K19pyeiRxf6KprihD3McCPOWmlf2ePuYGIzQfzSjw6Ga7CdcMCWHF9fGJWv2mFzxcG
         3wjNU9f6+udRQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id 09728C4167B;
        Wed, 29 Nov 2023 21:50:58 +0000 (UTC)
From:   "Seth Forshee (DigitalOcean)" <sforshee@kernel.org>
Date:   Wed, 29 Nov 2023 15:50:30 -0600
Subject: [PATCH 12/16] ovl: use vfs_{get,set}_fscaps() for copy-up
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231129-idmap-fscap-refactor-v1-12-da5a26058a5b@kernel.org>
References: <20231129-idmap-fscap-refactor-v1-0-da5a26058a5b@kernel.org>
In-Reply-To: <20231129-idmap-fscap-refactor-v1-0-da5a26058a5b@kernel.org>
To:     Christian Brauner <brauner@kernel.org>,
        Serge Hallyn <serge@hallyn.com>,
        Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@redhat.com>,
        James Morris <jmorris@namei.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Amir Goldstein <amir73il@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, audit@vger.kernel.org,
        linux-unionfs@vger.kernel.org,
        "Seth Forshee (DigitalOcean)" <sforshee@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=4000; i=sforshee@kernel.org;
 h=from:subject:message-id; bh=sdaoEg9ciUZftk2H34h2y651gj0bEkfe58vTpkMB1yM=; 
 =?utf-8?q?b=3DowEBbQGS/pANAwAKAVMDma7l9DHJAcsmYgBlZ7I7nj2pDM1Swf1xxfWdnQF14?=
 =?utf-8?q?2gaU0cjaKHbr9wa_IfaLDx2JATMEAAEKAB0WIQSQnt+rKAvnETy4Hc9TA5mu5fQxy?=
 =?utf-8?q?QUCZWeyOwAKCRBTA5mu5fQxyagzB/_9p+FECwvuMkt4XpREQZadycge188mmaG0Bd?=
 =?utf-8?q?TCbVb2BetQ3LKBPtUkg4sx9fWHrGjDqMTmYASWswk8w_ZxaDGEGJ4Hu1GJI6t42C5?=
 =?utf-8?q?f0v6yLIm3xXZa54SVpbW6saMAY4YcZBAHtg+Lq5zJqjHxSy/WWSI3lNco_7/L9wXs?=
 =?utf-8?q?aUPMpHWuiy8v7p4EhXAxCjGiNTCHLkM/2FnayolmIwXVgBMiQ7PSU+KwElFmf/JHB?=
 =?utf-8?q?mc/CXJ_qy3Ibx41A7h81JLGZSY+rnHq7KdXnC0tbY7F1bbXdlD5Sr0pkfDOA7r7Rp?=
 =?utf-8?q?laqTUtg48HD5m1hJ7hp5?= YxnKnn+lyAuSXl8IlHlrpCCrEeLE8U
X-Developer-Key: i=sforshee@kernel.org; a=openpgp;
 fpr=2ABCA7498D83E1D32D51D3B5AB4800A62DB9F73A
X-Endpoint-Received: by B4 Relay for sforshee@kernel.org/default with auth_id=103
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using vfs_{get,set}xattr() for fscaps will be blocked in a future
commit, so convert ovl to use the new interfaces. Also remove the now
unused ovl_getxattr_value().

Signed-off-by: Seth Forshee (DigitalOcean) <sforshee@kernel.org>
---
 fs/overlayfs/copy_up.c | 72 ++++++++++++++++++++++++++------------------------
 1 file changed, 37 insertions(+), 35 deletions(-)

diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index 4382881b0709..b43af5ce4b21 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -73,6 +73,23 @@ static int ovl_copy_acl(struct ovl_fs *ofs, const struct path *path,
 	return err;
 }
 
+static int ovl_copy_fscaps(struct ovl_fs *ofs, const struct path *oldpath,
+			   struct dentry *new)
+{
+	struct vfs_caps capability;
+	int err;
+
+	err = vfs_get_fscaps(mnt_idmap(oldpath->mnt), oldpath->dentry,
+			     &capability);
+	if (err) {
+		if (err == -ENODATA || err == -EOPNOTSUPP)
+			return 0;
+		return err;
+	}
+
+	return vfs_set_fscaps(ovl_upper_mnt_idmap(ofs), new, &capability, 0);
+}
+
 int ovl_copy_xattr(struct super_block *sb, const struct path *oldpath, struct dentry *new)
 {
 	struct dentry *old = oldpath->dentry;
@@ -130,6 +147,14 @@ int ovl_copy_xattr(struct super_block *sb, const struct path *oldpath, struct de
 			break;
 		}
 
+		if (!strcmp(name, XATTR_NAME_CAPS)) {
+			error = ovl_copy_fscaps(OVL_FS(sb), oldpath, new);
+			if (!error)
+				continue;
+			/* fs capabilities must be copied */
+			break;
+		}
+
 retry:
 		size = ovl_do_getxattr(oldpath, name, value, value_size);
 		if (size == -ERANGE)
@@ -1006,61 +1031,40 @@ static bool ovl_need_meta_copy_up(struct dentry *dentry, umode_t mode,
 	return true;
 }
 
-static ssize_t ovl_getxattr_value(const struct path *path, char *name, char **value)
-{
-	ssize_t res;
-	char *buf;
-
-	res = ovl_do_getxattr(path, name, NULL, 0);
-	if (res == -ENODATA || res == -EOPNOTSUPP)
-		res = 0;
-
-	if (res > 0) {
-		buf = kzalloc(res, GFP_KERNEL);
-		if (!buf)
-			return -ENOMEM;
-
-		res = ovl_do_getxattr(path, name, buf, res);
-		if (res < 0)
-			kfree(buf);
-		else
-			*value = buf;
-	}
-	return res;
-}
-
 /* Copy up data of an inode which was copied up metadata only in the past. */
 static int ovl_copy_up_meta_inode_data(struct ovl_copy_up_ctx *c)
 {
 	struct ovl_fs *ofs = OVL_FS(c->dentry->d_sb);
 	struct path upperpath;
 	int err;
-	char *capability = NULL;
-	ssize_t cap_size;
+	struct vfs_caps capability;
+	bool has_capability = false;
 
 	ovl_path_upper(c->dentry, &upperpath);
 	if (WARN_ON(upperpath.dentry == NULL))
 		return -EIO;
 
 	if (c->stat.size) {
-		err = cap_size = ovl_getxattr_value(&upperpath, XATTR_NAME_CAPS,
-						    &capability);
-		if (cap_size < 0)
+		err = vfs_get_fscaps(mnt_idmap(upperpath.mnt), upperpath.dentry,
+				     &capability);
+		if (!err)
+			has_capability = 1;
+		else if (err != -ENODATA && err != EOPNOTSUPP)
 			goto out;
 	}
 
 	err = ovl_copy_up_data(c, &upperpath);
 	if (err)
-		goto out_free;
+		goto out;
 
 	/*
 	 * Writing to upper file will clear security.capability xattr. We
 	 * don't want that to happen for normal copy-up operation.
 	 */
 	ovl_start_write(c->dentry);
-	if (capability) {
-		err = ovl_do_setxattr(ofs, upperpath.dentry, XATTR_NAME_CAPS,
-				      capability, cap_size, 0);
+	if (has_capability) {
+		err = vfs_set_fscaps(mnt_idmap(upperpath.mnt), upperpath.dentry,
+				     &capability, 0);
 	}
 	if (!err) {
 		err = ovl_removexattr(ofs, upperpath.dentry,
@@ -1068,13 +1072,11 @@ static int ovl_copy_up_meta_inode_data(struct ovl_copy_up_ctx *c)
 	}
 	ovl_end_write(c->dentry);
 	if (err)
-		goto out_free;
+		goto out;
 
 	ovl_clear_flag(OVL_HAS_DIGEST, d_inode(c->dentry));
 	ovl_clear_flag(OVL_VERIFIED_DIGEST, d_inode(c->dentry));
 	ovl_set_upperdata(d_inode(c->dentry));
-out_free:
-	kfree(capability);
 out:
 	return err;
 }

-- 
2.43.0

