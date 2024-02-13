Return-Path: <linux-kernel+bounces-62581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A76E085233A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 01:21:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 174A61F219CF
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 00:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D1F71B59F;
	Tue, 13 Feb 2024 00:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RpRQvN8h"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6911947B;
	Tue, 13 Feb 2024 00:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707783533; cv=none; b=jozs9zbVncM5H0PZHQEGqQqObvEeYWfreiGElCNkLlUIzSMjJtxISglYQqhQmoiFkIDi7XaShVv21LHCFklFdiIpiVIpRMMIVew2+5UPt4+blHqBjEhHVljGhYV6rf59st/ZAnYOFRlY53NBqVRxUJZmubUf+X1nkxHClS9br6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707783533; c=relaxed/simple;
	bh=yHIsAv16z6CcOamlg00HeIC/NT/OwNZmif+2niBpdP4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KoFJ8Zj2eOYKmZHDaoY42MeuMNOawEMoF1V5ksT3qwna2kZEHGUn1Sh+EucKNalEFYvuYX9h1a5sRRA7xWbx123LI9PHSVXsNC9YyV8JA+8/GHyKlPcJBZ0sfgc7kYueYMBn8w91TrlAIBJ5Qd/NZG92oxggIATI0+zJ63P8gPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RpRQvN8h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6677CC433C7;
	Tue, 13 Feb 2024 00:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707783533;
	bh=yHIsAv16z6CcOamlg00HeIC/NT/OwNZmif+2niBpdP4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RpRQvN8h58kZ4C3tE21CJ3I12/EEkYBsuJqRYp0McBN39x1AtNBOXk6LlqPnXveqo
	 xRdNEssDslgEfK6p8ZpMsJsW43/bk97oPZ8X8tX+Ps6N/cUOOb/p1aG30Z4PX56W1a
	 zHzLwOPsed9uVRRHeIt7QxcndkZjjbOJnwSE+ICFo2vA1uirJGyJCpWe3v8qzL/KDt
	 zpwshJiqLX4TBGOkaI+ZHitKMCEh84u6yMMXuyOeAlyXoSpERhsCu/y4kVBMoV7MV3
	 /15DBnh9NlfUw3eU7UV0AuCJVSDUenJGYWXlqaAhiYDy5b0WjcGZrU+4wad/qPw27O
	 pY0UqqM5XgBeA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Sasha Levin <sashal@kernel.org>,
	ntfs3@lists.linux.dev
Subject: [PATCH AUTOSEL 6.7 12/58] fs/ntfs3: Implement super_operations::shutdown
Date: Mon, 12 Feb 2024 19:17:18 -0500
Message-ID: <20240213001837.668862-12-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213001837.668862-1-sashal@kernel.org>
References: <20240213001837.668862-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.4
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
index 0ff5d3af2889..07ed3d946e7c 100644
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
index 3df2d9e34b91..8744ba36d422 100644
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
index bba0208c4afd..85452a6b1d40 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -852,9 +852,13 @@ static int ntfs_resident_writepage(struct folio *folio,
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
@@ -868,7 +872,12 @@ static int ntfs_resident_writepage(struct folio *folio,
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
@@ -888,6 +897,9 @@ int ntfs_write_begin(struct file *file, struct address_space *mapping,
 	struct inode *inode = mapping->host;
 	struct ntfs_inode *ni = ntfs_i(inode);
 
+	if (unlikely(ntfs3_forced_shutdown(inode->i_sb)))
+		return -EIO;
+
 	*pagep = NULL;
 	if (is_resident(ni)) {
 		struct page *page =
@@ -1305,6 +1317,11 @@ struct inode *ntfs_create_inode(struct mnt_idmap *idmap, struct inode *dir,
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
index ee3093be5170..cae41db0aaa7 100644
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
index f6706143d14b..d40bc7669ae5 100644
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
index 09d61c6c90aa..af8521a6ed95 100644
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
index 4274b6f31cfa..071356d096d8 100644
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


