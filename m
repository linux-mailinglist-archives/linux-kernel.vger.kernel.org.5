Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AA04804026
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 21:38:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346332AbjLDUij (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 15:38:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346415AbjLDUiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 15:38:08 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D089418A
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 12:35:38 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83702C433CA;
        Mon,  4 Dec 2023 20:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701722138;
        bh=JoQKvsKwAx4AEsqDIDNCaa8l0yzT8lOSnPJsdDEaA/Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cVlUqEAG2z8M+w3pZ5hQQuKkljXtDq4BeWB+ARarqNUXpQcqd8L6FGSy48dz8rac1
         InZbyMYDpo74yYfaLZMCQdyqgaKTauRG62cPnoLcZ9io3Jv/WiRkpQruUOw6/QZlAe
         zksMmrib1y3J0LVkCBaf//jYe0atXb5yLedvOgEtXTwKM1u0Zrmi5c+NJbJ3ekTOHz
         c18SZbvEmUK/mPvvtcpPAkBS82HDfXqWxCew1UeOY3rKwJT9G9xJYoXzL2gMDED+kO
         cLHeop5R9Hs7aa3caWZd8AQm6uZpEMwFxU8CFmfgP3wbVTub1s6A+PJbunJgPW610v
         eU5AAz7ZTg10A==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 6.1 08/17] debugfs: fix automount d_fsdata usage
Date:   Mon,  4 Dec 2023 15:34:53 -0500
Message-ID: <20231204203514.2093855-8-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231204203514.2093855-1-sashal@kernel.org>
References: <20231204203514.2093855-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.65
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit 0ed04a1847a10297595ac24dc7d46b35fb35f90a ]

debugfs_create_automount() stores a function pointer in d_fsdata,
but since commit 7c8d469877b1 ("debugfs: add support for more
elaborate ->d_fsdata") debugfs_release_dentry() will free it, now
conditionally on DEBUGFS_FSDATA_IS_REAL_FOPS_BIT, but that's not
set for the function pointer in automount. As a result, removing
an automount dentry would attempt to free the function pointer.
Luckily, the only user of this (tracing) never removes it.

Nevertheless, it's safer if we just handle the fsdata in one way,
namely either DEBUGFS_FSDATA_IS_REAL_FOPS_BIT or allocated. Thus,
change the automount to allocate it, and use the real_fops in the
data to indicate whether or not automount is filled, rather than
adding a type tag. At least for now this isn't actually needed,
but the next changes will require it.

Also check in debugfs_file_get() that it gets only called
on regular files, just to make things clearer.

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/debugfs/file.c     |  8 ++++++++
 fs/debugfs/inode.c    | 27 ++++++++++++++++++++-------
 fs/debugfs/internal.h | 10 ++++++++--
 3 files changed, 36 insertions(+), 9 deletions(-)

diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
index b54f470e0d031..b38304b444764 100644
--- a/fs/debugfs/file.c
+++ b/fs/debugfs/file.c
@@ -84,6 +84,14 @@ int debugfs_file_get(struct dentry *dentry)
 	struct debugfs_fsdata *fsd;
 	void *d_fsd;
 
+	/*
+	 * This could only happen if some debugfs user erroneously calls
+	 * debugfs_file_get() on a dentry that isn't even a file, let
+	 * them know about it.
+	 */
+	if (WARN_ON(!d_is_reg(dentry)))
+		return -EINVAL;
+
 	d_fsd = READ_ONCE(dentry->d_fsdata);
 	if (!((unsigned long)d_fsd & DEBUGFS_FSDATA_IS_REAL_FOPS_BIT)) {
 		fsd = d_fsd;
diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
index 2e8e112b19930..08ef685167ec5 100644
--- a/fs/debugfs/inode.c
+++ b/fs/debugfs/inode.c
@@ -237,17 +237,19 @@ static const struct super_operations debugfs_super_operations = {
 
 static void debugfs_release_dentry(struct dentry *dentry)
 {
-	void *fsd = dentry->d_fsdata;
+	struct debugfs_fsdata *fsd = dentry->d_fsdata;
 
-	if (!((unsigned long)fsd & DEBUGFS_FSDATA_IS_REAL_FOPS_BIT))
-		kfree(dentry->d_fsdata);
+	if ((unsigned long)fsd & DEBUGFS_FSDATA_IS_REAL_FOPS_BIT)
+		return;
+
+	kfree(fsd);
 }
 
 static struct vfsmount *debugfs_automount(struct path *path)
 {
-	debugfs_automount_t f;
-	f = (debugfs_automount_t)path->dentry->d_fsdata;
-	return f(path->dentry, d_inode(path->dentry)->i_private);
+	struct debugfs_fsdata *fsd = path->dentry->d_fsdata;
+
+	return fsd->automount(path->dentry, d_inode(path->dentry)->i_private);
 }
 
 static const struct dentry_operations debugfs_dops = {
@@ -635,13 +637,23 @@ struct dentry *debugfs_create_automount(const char *name,
 					void *data)
 {
 	struct dentry *dentry = start_creating(name, parent);
+	struct debugfs_fsdata *fsd;
 	struct inode *inode;
 
 	if (IS_ERR(dentry))
 		return dentry;
 
+	fsd = kzalloc(sizeof(*fsd), GFP_KERNEL);
+	if (!fsd) {
+		failed_creating(dentry);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	fsd->automount = f;
+
 	if (!(debugfs_allow & DEBUGFS_ALLOW_API)) {
 		failed_creating(dentry);
+		kfree(fsd);
 		return ERR_PTR(-EPERM);
 	}
 
@@ -649,13 +661,14 @@ struct dentry *debugfs_create_automount(const char *name,
 	if (unlikely(!inode)) {
 		pr_err("out of free dentries, can not create automount '%s'\n",
 		       name);
+		kfree(fsd);
 		return failed_creating(dentry);
 	}
 
 	make_empty_dir_inode(inode);
 	inode->i_flags |= S_AUTOMOUNT;
 	inode->i_private = data;
-	dentry->d_fsdata = (void *)f;
+	dentry->d_fsdata = fsd;
 	/* directory inodes start off with i_nlink == 2 (for "." entry) */
 	inc_nlink(inode);
 	d_instantiate(dentry, inode);
diff --git a/fs/debugfs/internal.h b/fs/debugfs/internal.h
index 92af8ae313134..f7c489b5a368c 100644
--- a/fs/debugfs/internal.h
+++ b/fs/debugfs/internal.h
@@ -17,8 +17,14 @@ extern const struct file_operations debugfs_full_proxy_file_operations;
 
 struct debugfs_fsdata {
 	const struct file_operations *real_fops;
-	refcount_t active_users;
-	struct completion active_users_drained;
+	union {
+		/* automount_fn is used when real_fops is NULL */
+		debugfs_automount_t automount;
+		struct {
+			refcount_t active_users;
+			struct completion active_users_drained;
+		};
+	};
 };
 
 /*
-- 
2.42.0

