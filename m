Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3AD67FE271
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 22:51:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234906AbjK2Vv2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 16:51:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234591AbjK2Vuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 16:50:54 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1638F10D3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 13:51:01 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 41392C2BCFE;
        Wed, 29 Nov 2023 21:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701294658;
        bh=fGkhj5/NF9UPawvhqYtWeLh70xVuDREL8YeiOyAcAQA=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=IB53PCzW++dHYvwKAxy9kOqiyPyUek3biP1aF4qO+xxCiRDBxWIsvoQgfusBoAUhC
         yPGQL94ljCFqKIBx4pBRDlJDGJJC8pzejcgg7fwE7cYMmyR5VIO6kgDA8G0tKWFDaE
         bbFuPFjpreoMnn5mME0Y8Tuqs20jJ+Hd35oXKkVxID942x3Q4rW2JEJbO7adRrm0Ls
         cGcoDHR3+4Zo/1+djNBX8tcKchb8aotvtqjnkt3ZYxbRVbtRpmndCnwzlAsXB7pY99
         MZytrt3cW9mz5QqWcWmbRIJeZo89PVPFo/z8rRENvBWkvZteNZ/dyBKmFDFXxqH8Ov
         6EW1MI9msi4YQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id 32624C4167B;
        Wed, 29 Nov 2023 21:50:58 +0000 (UTC)
From:   "Seth Forshee (DigitalOcean)" <sforshee@kernel.org>
Date:   Wed, 29 Nov 2023 15:50:34 -0600
Subject: [PATCH 16/16] vfs: return -EOPNOTSUPP for fscaps from vfs_*xattr()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231129-idmap-fscap-refactor-v1-16-da5a26058a5b@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1541; i=sforshee@kernel.org;
 h=from:subject:message-id; bh=fGkhj5/NF9UPawvhqYtWeLh70xVuDREL8YeiOyAcAQA=; 
 =?utf-8?q?b=3DowEBbQGS/pANAwAKAVMDma7l9DHJAcsmYgBlZ7I+wlKgt++JWupSZaBp9QGfd?=
 =?utf-8?q?Bkmz7IEI8ioxj4s_f1+aQbyJATMEAAEKAB0WIQSQnt+rKAvnETy4Hc9TA5mu5fQxy?=
 =?utf-8?q?QUCZWeyPgAKCRBTA5mu5fQxyTvfB/_9YWexz1iQXD9/hl9qna/DWzl4zGo/SAzZV9?=
 =?utf-8?q?yU+WAg1lMJqq4GFg0sAtqm2p8er4jQP8TEmJ1gfT+Rp_OwnKnhV4uu4HWyEr7dNuR?=
 =?utf-8?q?ZPmxzAryHGI1rMeQqZmBuQ6oItUJeIE00YEKRTgMVm18qFcraMmUQVYcD_o8vPfg2?=
 =?utf-8?q?zw4i4XaDyCATxBE4yxIWmTjTHvJxdui3jxNCN1DDq9wMrXGKX2OZsyeCDw9VhgdNL?=
 =?utf-8?q?6EYyF2_xIHyfPKGASENkIpB05s2Aq3zudSepjo7YMWyfxSC3ghhvdqjksN1MMdM8J?=
 =?utf-8?q?Ff8oAsfPKxEyobr3TadT?= DOjWk90F22+U7CvJPhBxhcP09S5qxG
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

Now that the new vfs-level interfaces are fully supported and all code
has been converted to use them, stop permitting use of the top-level vfs
xattr interfaces for capabilities xattrs. Unlike with ACLs we still need
to be able to work with fscaps xattrs using lower-level interfaces in a
handful of places, so only use of the top-level xattr interfaces is
restricted.

Signed-off-by: Seth Forshee (DigitalOcean) <sforshee@kernel.org>
---
 fs/xattr.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/xattr.c b/fs/xattr.c
index 372644b15457..4b779779ad8c 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -540,6 +540,9 @@ vfs_setxattr(struct mnt_idmap *idmap, struct dentry *dentry,
 	const void  *orig_value = value;
 	int error;
 
+	if (!strcmp(name, XATTR_NAME_CAPS))
+		return -EOPNOTSUPP;
+
 retry_deleg:
 	inode_lock(inode);
 	error = __vfs_setxattr_locked(idmap, dentry, name, value, size,
@@ -655,6 +658,9 @@ vfs_getxattr(struct mnt_idmap *idmap, struct dentry *dentry,
 	struct inode *inode = dentry->d_inode;
 	int error;
 
+	if (!strcmp(name, XATTR_NAME_CAPS))
+		return -EOPNOTSUPP;
+
 	error = xattr_permission(idmap, inode, name, MAY_READ);
 	if (error)
 		return error;
@@ -794,6 +800,9 @@ vfs_removexattr(struct mnt_idmap *idmap, struct dentry *dentry,
 	struct inode *delegated_inode = NULL;
 	int error;
 
+	if (!strcmp(name, XATTR_NAME_CAPS))
+		return -EOPNOTSUPP;
+
 retry_deleg:
 	inode_lock(inode);
 	error = __vfs_removexattr_locked(idmap, dentry,

-- 
2.43.0

