Return-Path: <linux-kernel+bounces-123019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6590F89011E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 15:06:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB922B23635
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 14:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD0FF126F3F;
	Thu, 28 Mar 2024 14:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lidp2c3m"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D818626A
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 14:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711634789; cv=none; b=BfDHXVcC37uUxh0va1fUSBbVICws5m5LQtikIIX4T5Co86JDiaK0NOFtjIe/r5goN/3lENdVDrWVpghi5TsQG86l3ePpv0WSvQWfpHtGCu7g6qV5dTJXe1R4GNUD9C+sTtYzvK3hOVcnqiD5Ok3W5u/ribzjBA9FTIWYnVINDAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711634789; c=relaxed/simple;
	bh=FnvcZevTYWNurW3Uxd3UuYe/1VH10eeybkvsPFACC18=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pKYcU3zQQt4pkGD8iaXHInX74dqsxgNmvWsCkZKlqAKYTAbrJ00y2BwFE8bKZ5jGZMAs949TgIRtORzruj6NqoYljKhiRDfLs5UqQI02fgjkInGSaoMYcHVNREEt9anqpvF67aGZ8pSJ2qKwyhXh1bgIVjuUeldOlCoOj2ko+YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lidp2c3m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E366C433F1;
	Thu, 28 Mar 2024 14:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711634788;
	bh=FnvcZevTYWNurW3Uxd3UuYe/1VH10eeybkvsPFACC18=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lidp2c3mTu2L+6vPQU0+t3T4RO7WW6KYloriGSzeh6hJ4lanRjXS2zbFyZ5c4egtR
	 7RHevo+rOeSp/m1mPTaUHfjHnEBTooB1q8yjwOwHIQcJm6E25WeWCmAF/jnVPu5nGI
	 6lBc+CyooIipfrlD6nn8jm7QUdVYgLrrUSRgqTieoMI/DU0Gn9UdArSJfLbDeVV5YP
	 KESo4caEY31tC6fTqj/+azy3m68f6Ti5G3FU4CojpSJB7giJ9nqSTlrAY/GMhOj9BR
	 XNm+xagVWsvXVEq5AII4DJj2GgxEutHKVQE/0zrPptXBvyo7pxxoN2yXcDn5JWr6M7
	 tg8USbC4P2ESw==
From: Arnd Bergmann <arnd@kernel.org>
To: linux-kernel@vger.kernel.org,
	Mike Marshall <hubcap@omnibond.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Martin Brandenburg <martin@omnibond.com>,
	Jeff Layton <jlayton@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Christian Brauner <brauner@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	devel@lists.orangefs.org
Subject: [PATCH 04/11] orangefs: convert strncpy() to strscpy()
Date: Thu, 28 Mar 2024 15:04:48 +0100
Message-Id: <20240328140512.4148825-5-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240328140512.4148825-1-arnd@kernel.org>
References: <20240328140512.4148825-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

gcc warns about a truncated string copy with a 255 byte string getting
copied to a buffer of the same length, losing the 0-termination:

In function 'orangefs_unmount',
    inlined from 'orangefs_kill_sb' at arm-soc/fs/orangefs/super.c:619:6:
fs/orangefs/super.c:406:9: error: 'strncpy' output may be truncated copying 255 bytes from a string of length 255 [-Werror=stringop-truncation]
  406 |         strncpy(op->upcall.req.fs_umount.orangefs_config_server,
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  407 |             devname, ORANGEFS_MAX_SERVER_ADDR_LEN - 1);
      |             ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

I see that most string copies in orangefs are for the upcalls and use
a buffer that is one short to get the implied termination from the
zero-filled buffer, but some other instances lack the '-1' part.

Convert from strncpy() to strscpy() to avoids both the warning about
the buffer size and the need for the explicit padding, since strscpy
guarantees a zero-terminated buffer.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/orangefs/dcache.c |  4 ++--
 fs/orangefs/namei.c  | 33 +++++++++++++++------------------
 fs/orangefs/super.c  | 16 +++++++---------
 3 files changed, 24 insertions(+), 29 deletions(-)

diff --git a/fs/orangefs/dcache.c b/fs/orangefs/dcache.c
index 8bbe9486e3a6..96ed9900f7a9 100644
--- a/fs/orangefs/dcache.c
+++ b/fs/orangefs/dcache.c
@@ -33,9 +33,9 @@ static int orangefs_revalidate_lookup(struct dentry *dentry)
 
 	new_op->upcall.req.lookup.sym_follow = ORANGEFS_LOOKUP_LINK_NO_FOLLOW;
 	new_op->upcall.req.lookup.parent_refn = parent->refn;
-	strncpy(new_op->upcall.req.lookup.d_name,
+	strscpy(new_op->upcall.req.lookup.d_name,
 		dentry->d_name.name,
-		ORANGEFS_NAME_MAX - 1);
+		ORANGEFS_NAME_MAX);
 
 	gossip_debug(GOSSIP_DCACHE_DEBUG,
 		     "%s:%s:%d interrupt flag [%d]\n",
diff --git a/fs/orangefs/namei.c b/fs/orangefs/namei.c
index c9dfd5c6a097..5e46d3bdcb05 100644
--- a/fs/orangefs/namei.c
+++ b/fs/orangefs/namei.c
@@ -41,8 +41,8 @@ static int orangefs_create(struct mnt_idmap *idmap,
 	fill_default_sys_attrs(new_op->upcall.req.create.attributes,
 			       ORANGEFS_TYPE_METAFILE, mode);
 
-	strncpy(new_op->upcall.req.create.d_name,
-		dentry->d_name.name, ORANGEFS_NAME_MAX - 1);
+	strscpy(new_op->upcall.req.create.d_name,
+		dentry->d_name.name, ORANGEFS_NAME_MAX);
 
 	ret = service_operation(new_op, __func__, get_interruptible_flag(dir));
 
@@ -137,8 +137,8 @@ static struct dentry *orangefs_lookup(struct inode *dir, struct dentry *dentry,
 		     &parent->refn.khandle);
 	new_op->upcall.req.lookup.parent_refn = parent->refn;
 
-	strncpy(new_op->upcall.req.lookup.d_name, dentry->d_name.name,
-		ORANGEFS_NAME_MAX - 1);
+	strscpy(new_op->upcall.req.lookup.d_name, dentry->d_name.name,
+		ORANGEFS_NAME_MAX);
 
 	gossip_debug(GOSSIP_NAME_DEBUG,
 		     "%s: doing lookup on %s under %pU,%d\n",
@@ -192,8 +192,8 @@ static int orangefs_unlink(struct inode *dir, struct dentry *dentry)
 		return -ENOMEM;
 
 	new_op->upcall.req.remove.parent_refn = parent->refn;
-	strncpy(new_op->upcall.req.remove.d_name, dentry->d_name.name,
-		ORANGEFS_NAME_MAX - 1);
+	strscpy(new_op->upcall.req.remove.d_name, dentry->d_name.name,
+		ORANGEFS_NAME_MAX);
 
 	ret = service_operation(new_op, "orangefs_unlink",
 				get_interruptible_flag(inode));
@@ -247,10 +247,9 @@ static int orangefs_symlink(struct mnt_idmap *idmap,
 			       ORANGEFS_TYPE_SYMLINK,
 			       mode);
 
-	strncpy(new_op->upcall.req.sym.entry_name,
-		dentry->d_name.name,
-		ORANGEFS_NAME_MAX - 1);
-	strncpy(new_op->upcall.req.sym.target, symname, ORANGEFS_NAME_MAX - 1);
+	strscpy(new_op->upcall.req.sym.entry_name,
+		dentry->d_name.name, ORANGEFS_NAME_MAX);
+	strscpy(new_op->upcall.req.sym.target, symname, ORANGEFS_NAME_MAX);
 
 	ret = service_operation(new_op, __func__, get_interruptible_flag(dir));
 
@@ -324,8 +323,8 @@ static int orangefs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 	fill_default_sys_attrs(new_op->upcall.req.mkdir.attributes,
 			      ORANGEFS_TYPE_DIRECTORY, mode);
 
-	strncpy(new_op->upcall.req.mkdir.d_name,
-		dentry->d_name.name, ORANGEFS_NAME_MAX - 1);
+	strscpy(new_op->upcall.req.mkdir.d_name,
+		dentry->d_name.name, ORANGEFS_NAME_MAX);
 
 	ret = service_operation(new_op, __func__, get_interruptible_flag(dir));
 
@@ -405,12 +404,10 @@ static int orangefs_rename(struct mnt_idmap *idmap,
 	new_op->upcall.req.rename.old_parent_refn = ORANGEFS_I(old_dir)->refn;
 	new_op->upcall.req.rename.new_parent_refn = ORANGEFS_I(new_dir)->refn;
 
-	strncpy(new_op->upcall.req.rename.d_old_name,
-		old_dentry->d_name.name,
-		ORANGEFS_NAME_MAX - 1);
-	strncpy(new_op->upcall.req.rename.d_new_name,
-		new_dentry->d_name.name,
-		ORANGEFS_NAME_MAX - 1);
+	strscpy(new_op->upcall.req.rename.d_old_name,
+		old_dentry->d_name.name, ORANGEFS_NAME_MAX);
+	strscpy(new_op->upcall.req.rename.d_new_name,
+		new_dentry->d_name.name, ORANGEFS_NAME_MAX);
 
 	ret = service_operation(new_op,
 				"orangefs_rename",
diff --git a/fs/orangefs/super.c b/fs/orangefs/super.c
index d990f4356b30..c714380ab38b 100644
--- a/fs/orangefs/super.c
+++ b/fs/orangefs/super.c
@@ -256,7 +256,7 @@ int orangefs_remount(struct orangefs_sb_info_s *orangefs_sb)
 	new_op = op_alloc(ORANGEFS_VFS_OP_FS_MOUNT);
 	if (!new_op)
 		return -ENOMEM;
-	strncpy(new_op->upcall.req.fs_mount.orangefs_config_server,
+	strscpy(new_op->upcall.req.fs_mount.orangefs_config_server,
 		orangefs_sb->devname,
 		ORANGEFS_MAX_SERVER_ADDR_LEN);
 
@@ -403,8 +403,8 @@ static int orangefs_unmount(int id, __s32 fs_id, const char *devname)
 		return -ENOMEM;
 	op->upcall.req.fs_umount.id = id;
 	op->upcall.req.fs_umount.fs_id = fs_id;
-	strncpy(op->upcall.req.fs_umount.orangefs_config_server,
-	    devname, ORANGEFS_MAX_SERVER_ADDR_LEN - 1);
+	strscpy(op->upcall.req.fs_umount.orangefs_config_server,
+	    devname, ORANGEFS_MAX_SERVER_ADDR_LEN);
 	r = service_operation(op, "orangefs_fs_umount", 0);
 	/* Not much to do about an error here. */
 	if (r)
@@ -497,9 +497,8 @@ struct dentry *orangefs_mount(struct file_system_type *fst,
 	if (!new_op)
 		return ERR_PTR(-ENOMEM);
 
-	strncpy(new_op->upcall.req.fs_mount.orangefs_config_server,
-		devname,
-		ORANGEFS_MAX_SERVER_ADDR_LEN - 1);
+	strscpy(new_op->upcall.req.fs_mount.orangefs_config_server,
+		devname, ORANGEFS_MAX_SERVER_ADDR_LEN);
 
 	gossip_debug(GOSSIP_SUPER_DEBUG,
 		     "Attempting ORANGEFS Mount via host %s\n",
@@ -546,9 +545,8 @@ struct dentry *orangefs_mount(struct file_system_type *fst,
 	 * on successful mount, store the devname and data
 	 * used
 	 */
-	strncpy(ORANGEFS_SB(sb)->devname,
-		devname,
-		ORANGEFS_MAX_SERVER_ADDR_LEN - 1);
+	strscpy(ORANGEFS_SB(sb)->devname, devname,
+		ORANGEFS_MAX_SERVER_ADDR_LEN);
 
 	/* mount_pending must be cleared */
 	ORANGEFS_SB(sb)->mount_pending = 0;
-- 
2.39.2


