Return-Path: <linux-kernel+bounces-62642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A43F8523EE
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 01:38:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F83B1F225DB
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 00:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BD586024E;
	Tue, 13 Feb 2024 00:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tR7B0Ftb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8B05FF14;
	Tue, 13 Feb 2024 00:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707783666; cv=none; b=rTi6xceT7B39qQ+KJJBnEeAKRG0scYGdO2jQsTDg/tCn77U0nQFwO85660jAynR9k8muQXxzJMGnGGfUV66c3VIEAnHCsI/o79c7wNUTmqAP3Fl17Uxn1RDtS97YFfueWL9+BgpZNbeqJuyBx2M5ODgtkvz9hgtJHuZJD/ieMlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707783666; c=relaxed/simple;
	bh=RuZiMLZJtJIBLNXTODyKZEHXjxzK+RqIpsO62lcS9Lk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h/8ut67JJtiYdBOIfI3JmekvrZAyfKANkEG7tq3fdWkDsDY4cd63HtkVRCX+4DJhy20Sqs+8hO0fH4PRMXMBb7BK+Q+eijN6VV1JnX387Q0dTNqjFfB0M4ubabEw1mx91nfJKNyNg8QyANBKSFRdW26d4qRHFTWuI4M1hCYvOK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tR7B0Ftb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D95CC433C7;
	Tue, 13 Feb 2024 00:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707783665;
	bh=RuZiMLZJtJIBLNXTODyKZEHXjxzK+RqIpsO62lcS9Lk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tR7B0FtbjqEMpJD0kdPulJflMAkoCMLd69PR0N8Qo5ra1L6R8RTCIwASWOnaUug7Q
	 vo/NbGUlF8jmalG1Klm2ZyeIJTvy/Gl3zM/71bp0FOI8bE9Es9+oO9Z7JLtFFxs3I4
	 HLdq32zfgtIiUJWOt8iz1RwuNrU12f92tRq8FfCRvZMnstkm8mao9kBTLEzDz06nQ/
	 cKdhUi2L4JvHNi2T00qB2GUPFDUcTzG2GOvZcMqNVWRC8WEgMUwqLxpiWVTpaYyo9l
	 FwHGonqsBPX3Mm4ZAgqyrv1atklYjehRnR+AP3zHEEjvVw+HIValAYX9TlqCkU7fWr
	 SK5GDqf7Ek+4Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Sasha Levin <sashal@kernel.org>,
	ntfs3@lists.linux.dev
Subject: [PATCH AUTOSEL 6.6 11/51] fs/ntfs3: Implement super_operations::shutdown
Date: Mon, 12 Feb 2024 19:19:48 -0500
Message-ID: <20240213002052.670571-11-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213002052.670571-1-sashal@kernel.org>
References: <20240213002052.670571-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.16
Content-Transfer-Encoding: 8bit

From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>

[ Upstream commit 6c3684e703837d2116b5cf4beb37aa7145a66b60 ]

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ntfs3/file.c    | 18 ++++++++++++++++++
 fs/ntfs3/frecord.c |  3 +++
 fs/ntfs3/inode.c   | 21 +++++++++++++++++++--
 fs/ntfs3/namei.c   | 12 ++++++++++++
 fs/ntfs3/ntfs_fs.h |  9 ++++++++-
 fs/ntfs3/super.c   | 12 ++++++++++++
 fs/ntfs3/xattr.c   |  3 +++
 7 files changed, 75 insertions(+), 3 deletions(-)

diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
index 5530b4cf1ee5..a5bbf7b5775a 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -260,6 +260,9 @@ static int ntfs_file_mmap(struct file *file, struct vm_area_struct *vma)
 	bool rw = vma->vm_flags & VM_WRITE;
 	int err;
 
+	if (unlikely(ntfs3_forced_shutdown(inode->i_sb)))
+		return -EIO;
+
 	if (is_encrypted(ni)) {
 		ntfs_inode_warn(inode, "mmap encrypted not supported");
 		return -EOPNOTSUPP;
@@ -677,6 +680,9 @@ int ntfs3_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 	umode_t mode = inode->i_mode;
 	int err;
 
+	if (unlikely(ntfs3_forced_shutdown(inode->i_sb)))
+		return -EIO;
+
 	err = setattr_prepare(idmap, dentry, attr);
 	if (err)
 		goto out;
@@ -732,6 +738,9 @@ static ssize_t ntfs_file_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 	struct inode *inode = file->f_mapping->host;
 	struct ntfs_inode *ni = ntfs_i(inode);
 
+	if (unlikely(ntfs3_forced_shutdown(inode->i_sb)))
+		return -EIO;
+
 	if (is_encrypted(ni)) {
 		ntfs_inode_warn(inode, "encrypted i/o not supported");
 		return -EOPNOTSUPP;
@@ -766,6 +775,9 @@ static ssize_t ntfs_file_splice_read(struct file *in, loff_t *ppos,
 	struct inode *inode = in->f_mapping->host;
 	struct ntfs_inode *ni = ntfs_i(inode);
 
+	if (unlikely(ntfs3_forced_shutdown(inode->i_sb)))
+		return -EIO;
+
 	if (is_encrypted(ni)) {
 		ntfs_inode_warn(inode, "encrypted i/o not supported");
 		return -EOPNOTSUPP;
@@ -1058,6 +1070,9 @@ static ssize_t ntfs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	int err;
 	struct ntfs_inode *ni = ntfs_i(inode);
 
+	if (unlikely(ntfs3_forced_shutdown(inode->i_sb)))
+		return -EIO;
+
 	if (is_encrypted(ni)) {
 		ntfs_inode_warn(inode, "encrypted i/o not supported");
 		return -EOPNOTSUPP;
@@ -1118,6 +1133,9 @@ int ntfs_file_open(struct inode *inode, struct file *file)
 {
 	struct ntfs_inode *ni = ntfs_i(inode);
 
+	if (unlikely(ntfs3_forced_shutdown(inode->i_sb)))
+		return -EIO;
+
 	if (unlikely((is_compressed(ni) || is_encrypted(ni)) &&
 		     (file->f_flags & O_DIRECT))) {
 		return -EOPNOTSUPP;
diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
index dad976a68985..86b43051f39c 100644
--- a/fs/ntfs3/frecord.c
+++ b/fs/ntfs3/frecord.c
@@ -3259,6 +3259,9 @@ int ni_write_inode(struct inode *inode, int sync, const char *hint)
 	if (is_bad_inode(inode) || sb_rdonly(sb))
 		return 0;
 
+	if (unlikely(ntfs3_forced_shutdown(sb)))
+		return -EIO;
+
 	if (!ni_trylock(ni)) {
 		/* 'ni' is under modification, skip for now. */
 		mark_inode_dirty_sync(inode);
diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index fb0466c11504..012dbc8ac5ec 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -851,9 +851,13 @@ static int ntfs_resident_writepage(struct folio *folio,
 				   struct writeback_control *wbc, void *data)
 {
 	struct address_space *mapping = data;
-	struct ntfs_inode *ni = ntfs_i(mapping->host);
+	struct inode *inode = mapping->host;
+	struct ntfs_inode *ni = ntfs_i(inode);
 	int ret;
 
+	if (unlikely(ntfs3_forced_shutdown(inode->i_sb)))
+		return -EIO;
+
 	ni_lock(ni);
 	ret = attr_data_write_resident(ni, &folio->page);
 	ni_unlock(ni);
@@ -867,7 +871,12 @@ static int ntfs_resident_writepage(struct folio *folio,
 static int ntfs_writepages(struct address_space *mapping,
 			   struct writeback_control *wbc)
 {
-	if (is_resident(ntfs_i(mapping->host)))
+	struct inode *inode = mapping->host;
+
+	if (unlikely(ntfs3_forced_shutdown(inode->i_sb)))
+		return -EIO;
+
+	if (is_resident(ntfs_i(inode)))
 		return write_cache_pages(mapping, wbc, ntfs_resident_writepage,
 					 mapping);
 	return mpage_writepages(mapping, wbc, ntfs_get_block);
@@ -887,6 +896,9 @@ int ntfs_write_begin(struct file *file, struct address_space *mapping,
 	struct inode *inode = mapping->host;
 	struct ntfs_inode *ni = ntfs_i(inode);
 
+	if (unlikely(ntfs3_forced_shutdown(inode->i_sb)))
+		return -EIO;
+
 	*pagep = NULL;
 	if (is_resident(ni)) {
 		struct page *page =
@@ -1303,6 +1315,11 @@ struct inode *ntfs_create_inode(struct mnt_idmap *idmap, struct inode *dir,
 		goto out1;
 	}
 
+	if (unlikely(ntfs3_forced_shutdown(sb))) {
+		err = -EIO;
+		goto out2;
+	}
+
 	/* Mark rw ntfs as dirty. it will be cleared at umount. */
 	ntfs_set_state(sbi, NTFS_DIRTY_DIRTY);
 
diff --git a/fs/ntfs3/namei.c b/fs/ntfs3/namei.c
index eedacf94edd8..b5687d74b449 100644
--- a/fs/ntfs3/namei.c
+++ b/fs/ntfs3/namei.c
@@ -181,6 +181,9 @@ static int ntfs_unlink(struct inode *dir, struct dentry *dentry)
 	struct ntfs_inode *ni = ntfs_i(dir);
 	int err;
 
+	if (unlikely(ntfs3_forced_shutdown(dir->i_sb)))
+		return -EIO;
+
 	ni_lock_dir(ni);
 
 	err = ntfs_unlink_inode(dir, dentry);
@@ -199,6 +202,9 @@ static int ntfs_symlink(struct mnt_idmap *idmap, struct inode *dir,
 	u32 size = strlen(symname);
 	struct inode *inode;
 
+	if (unlikely(ntfs3_forced_shutdown(dir->i_sb)))
+		return -EIO;
+
 	inode = ntfs_create_inode(idmap, dir, dentry, NULL, S_IFLNK | 0777, 0,
 				  symname, size, NULL);
 
@@ -227,6 +233,9 @@ static int ntfs_rmdir(struct inode *dir, struct dentry *dentry)
 	struct ntfs_inode *ni = ntfs_i(dir);
 	int err;
 
+	if (unlikely(ntfs3_forced_shutdown(dir->i_sb)))
+		return -EIO;
+
 	ni_lock_dir(ni);
 
 	err = ntfs_unlink_inode(dir, dentry);
@@ -264,6 +273,9 @@ static int ntfs_rename(struct mnt_idmap *idmap, struct inode *dir,
 		      1024);
 	static_assert(PATH_MAX >= 4 * 1024);
 
+	if (unlikely(ntfs3_forced_shutdown(sb)))
+		return -EIO;
+
 	if (flags & ~RENAME_NOREPLACE)
 		return -EINVAL;
 
diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
index 0e6a2777870c..414913232eae 100644
--- a/fs/ntfs3/ntfs_fs.h
+++ b/fs/ntfs3/ntfs_fs.h
@@ -61,6 +61,8 @@ enum utf16_endian;
 
 /* sbi->flags */
 #define NTFS_FLAGS_NODISCARD		0x00000001
+/* ntfs in shutdown state. */
+#define NTFS_FLAGS_SHUTDOWN		0x00000002
 /* Set when LogFile is replaying. */
 #define NTFS_FLAGS_LOG_REPLAYING	0x00000008
 /* Set when we changed first MFT's which copy must be updated in $MftMirr. */
@@ -226,7 +228,7 @@ struct ntfs_sb_info {
 	u64 maxbytes; // Maximum size for normal files.
 	u64 maxbytes_sparse; // Maximum size for sparse file.
 
-	u32 flags; // See NTFS_FLAGS_XXX.
+	unsigned long flags; // See NTFS_FLAGS_
 
 	CLST zone_max; // Maximum MFT zone length in clusters
 	CLST bad_clusters; // The count of marked bad clusters.
@@ -999,6 +1001,11 @@ static inline struct ntfs_sb_info *ntfs_sb(struct super_block *sb)
 	return sb->s_fs_info;
 }
 
+static inline bool ntfs3_forced_shutdown(struct super_block *sb)
+{
+	return test_bit(NTFS_FLAGS_SHUTDOWN, &ntfs_sb(sb)->flags);
+}
+
 /*
  * ntfs_up_cluster - Align up on cluster boundary.
  */
diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index aa3b2c262ab6..a313b4ddee16 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -714,6 +714,14 @@ static int ntfs_show_options(struct seq_file *m, struct dentry *root)
 	return 0;
 }
 
+/*
+ * ntfs_shutdown - super_operations::shutdown
+ */
+static void ntfs_shutdown(struct super_block *sb)
+{
+	set_bit(NTFS_FLAGS_SHUTDOWN, &ntfs_sb(sb)->flags);
+}
+
 /*
  * ntfs_sync_fs - super_operations::sync_fs
  */
@@ -724,6 +732,9 @@ static int ntfs_sync_fs(struct super_block *sb, int wait)
 	struct ntfs_inode *ni;
 	struct inode *inode;
 
+	if (unlikely(ntfs3_forced_shutdown(sb)))
+		return -EIO;
+
 	ni = sbi->security.ni;
 	if (ni) {
 		inode = &ni->vfs_inode;
@@ -763,6 +774,7 @@ static const struct super_operations ntfs_sops = {
 	.put_super = ntfs_put_super,
 	.statfs = ntfs_statfs,
 	.show_options = ntfs_show_options,
+	.shutdown = ntfs_shutdown,
 	.sync_fs = ntfs_sync_fs,
 	.write_inode = ntfs3_write_inode,
 };
diff --git a/fs/ntfs3/xattr.c b/fs/ntfs3/xattr.c
index 4920548192a0..838a79157fb9 100644
--- a/fs/ntfs3/xattr.c
+++ b/fs/ntfs3/xattr.c
@@ -744,6 +744,9 @@ static int ntfs_getxattr(const struct xattr_handler *handler, struct dentry *de,
 	int err;
 	struct ntfs_inode *ni = ntfs_i(inode);
 
+	if (unlikely(ntfs3_forced_shutdown(inode->i_sb)))
+		return -EIO;
+
 	/* Dispatch request. */
 	if (!strcmp(name, SYSTEM_DOS_ATTRIB)) {
 		/* system.dos_attrib */
-- 
2.43.0


