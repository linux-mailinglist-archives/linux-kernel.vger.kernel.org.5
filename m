Return-Path: <linux-kernel+bounces-62649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67A328523FC
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 01:39:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EB32282462
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 00:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACA066086D;
	Tue, 13 Feb 2024 00:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c0Zw5ALM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A2F60864;
	Tue, 13 Feb 2024 00:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707783674; cv=none; b=KWB+E/D0rCJy7BQgwhnKlojFPOi9T6m/isTcFPRK2mx7/zQc2lWAG107MEnRGALrNagZ2TYYO25OjtmkHpfahgylz2RwIV8sjLt506swtmvIAR+9xpl8HqmtwMCftgaYJR4TgjI3TvsQ4n6HyJPaHyxU5tUELsYEV7fBGZcQku4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707783674; c=relaxed/simple;
	bh=fCHkkV1LGWLnm7tNGwvLLlJtj6f0Czw8Hq/7FKLDUok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tq/Wz5gcEEXIvpDuXDdOsQRgqrJPYwgicBb3z0Ps3KzrAC92d0utbSJ6gK7kpzOVnCmVV8jbcyaTt9i8/BZ5kNz1LOwzFzGa3enQdhhSHJd6My412fUSv5jGoHkRFpqLTRqsjLiVmOdhIYsKWtoI3VhM//EsGrlRMoPnb+xwvNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c0Zw5ALM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADDB8C43394;
	Tue, 13 Feb 2024 00:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707783674;
	bh=fCHkkV1LGWLnm7tNGwvLLlJtj6f0Czw8Hq/7FKLDUok=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c0Zw5ALMAnU+VDU3WZ2U6W9rbhv8HFRXCGCGrtMoTperjc9TuAxm3XH/IxakV31u6
	 x8zjIF2f0ZfIgff63qb5MZA/y4HVqzTcSy8POjRReXGd+W/mRxIIplzDBaYV75f1hd
	 HLTHElt1Put60xnpZMNtScEO0uqPu7CUC0Ce9FfVLQN4ITJ78Au1zMoLNA4U9afzPi
	 kNbnp959pwUwmZ3FCKrrm/l2NpGjifwy2JC+EMAI/OApgx6udnzTjMUKnSh5dOOer+
	 EAjmXiEO/79eAu2252SYpKzUvqHPbjp5Q63aZq4dlqcQgl2n3bTWO6iOICmedfgEQu
	 /0oPOEvCSywiw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Sasha Levin <sashal@kernel.org>,
	ntfs3@lists.linux.dev
Subject: [PATCH AUTOSEL 6.6 18/51] fs/ntfs3: Use i_size_read and i_size_write
Date: Mon, 12 Feb 2024 19:19:55 -0500
Message-ID: <20240213002052.670571-18-sashal@kernel.org>
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

[ Upstream commit 4fd6c08a16d7f1ba10212c9ef7bc73218144b463 ]

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ntfs3/attrib.c  |  4 ++--
 fs/ntfs3/dir.c     |  2 +-
 fs/ntfs3/file.c    | 11 ++++++-----
 fs/ntfs3/frecord.c | 10 +++++-----
 fs/ntfs3/index.c   |  8 ++++----
 fs/ntfs3/inode.c   |  2 +-
 6 files changed, 19 insertions(+), 18 deletions(-)

diff --git a/fs/ntfs3/attrib.c b/fs/ntfs3/attrib.c
index 646e2dad1b75..7aadf5010999 100644
--- a/fs/ntfs3/attrib.c
+++ b/fs/ntfs3/attrib.c
@@ -2084,7 +2084,7 @@ int attr_collapse_range(struct ntfs_inode *ni, u64 vbo, u64 bytes)
 
 	/* Update inode size. */
 	ni->i_valid = valid_size;
-	ni->vfs_inode.i_size = data_size;
+	i_size_write(&ni->vfs_inode, data_size);
 	inode_set_bytes(&ni->vfs_inode, total_size);
 	ni->ni_flags |= NI_FLAG_UPDATE_PARENT;
 	mark_inode_dirty(&ni->vfs_inode);
@@ -2499,7 +2499,7 @@ int attr_insert_range(struct ntfs_inode *ni, u64 vbo, u64 bytes)
 	mi_b->dirty = true;
 
 done:
-	ni->vfs_inode.i_size += bytes;
+	i_size_write(&ni->vfs_inode, ni->vfs_inode.i_size + bytes);
 	ni->ni_flags |= NI_FLAG_UPDATE_PARENT;
 	mark_inode_dirty(&ni->vfs_inode);
 
diff --git a/fs/ntfs3/dir.c b/fs/ntfs3/dir.c
index 726122ecd39b..2c73ca469d51 100644
--- a/fs/ntfs3/dir.c
+++ b/fs/ntfs3/dir.c
@@ -517,7 +517,7 @@ static int ntfs_dir_count(struct inode *dir, bool *is_empty, size_t *dirs,
 	u32 e_size, off, end;
 	size_t drs = 0, fles = 0, bit = 0;
 	struct indx_node *node = NULL;
-	size_t max_indx = ni->vfs_inode.i_size >> ni->dir.index_bits;
+	size_t max_indx = i_size_read(&ni->vfs_inode) >> ni->dir.index_bits;
 
 	if (is_empty)
 		*is_empty = true;
diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
index a5bbf7b5775a..0f6a78aef90f 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -646,7 +646,7 @@ static long ntfs_fallocate(struct file *file, int mode, loff_t vbo, loff_t len)
 			if (err)
 				goto out;
 		} else if (new_size > i_size) {
-			inode->i_size = new_size;
+			i_size_write(inode, new_size);
 		}
 	}
 
@@ -696,7 +696,7 @@ int ntfs3_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 			goto out;
 		}
 		inode_dio_wait(inode);
-		oldsize = inode->i_size;
+		oldsize = i_size_read(inode);
 		newsize = attr->ia_size;
 
 		if (newsize <= oldsize)
@@ -708,7 +708,7 @@ int ntfs3_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 			goto out;
 
 		ni->ni_flags |= NI_FLAG_UPDATE_PARENT;
-		inode->i_size = newsize;
+		i_size_write(inode, newsize);
 	}
 
 	setattr_copy(idmap, inode, attr);
@@ -847,7 +847,7 @@ static ssize_t ntfs_compress_write(struct kiocb *iocb, struct iov_iter *from)
 	size_t count = iov_iter_count(from);
 	loff_t pos = iocb->ki_pos;
 	struct inode *inode = file_inode(file);
-	loff_t i_size = inode->i_size;
+	loff_t i_size = i_size_read(inode);
 	struct address_space *mapping = inode->i_mapping;
 	struct ntfs_inode *ni = ntfs_i(inode);
 	u64 valid = ni->i_valid;
@@ -1177,7 +1177,8 @@ static int ntfs_file_release(struct inode *inode, struct file *file)
 		down_write(&ni->file.run_lock);
 
 		err = attr_set_size(ni, ATTR_DATA, NULL, 0, &ni->file.run,
-				    inode->i_size, &ni->i_valid, false, NULL);
+				    i_size_read(inode), &ni->i_valid, false,
+				    NULL);
 
 		up_write(&ni->file.run_lock);
 		ni_unlock(ni);
diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
index a918d7283aca..61c51650266e 100644
--- a/fs/ntfs3/frecord.c
+++ b/fs/ntfs3/frecord.c
@@ -2099,7 +2099,7 @@ int ni_readpage_cmpr(struct ntfs_inode *ni, struct page *page)
 	gfp_t gfp_mask;
 	struct page *pg;
 
-	if (vbo >= ni->vfs_inode.i_size) {
+	if (vbo >= i_size_read(&ni->vfs_inode)) {
 		SetPageUptodate(page);
 		err = 0;
 		goto out;
@@ -2173,7 +2173,7 @@ int ni_decompress_file(struct ntfs_inode *ni)
 {
 	struct ntfs_sb_info *sbi = ni->mi.sbi;
 	struct inode *inode = &ni->vfs_inode;
-	loff_t i_size = inode->i_size;
+	loff_t i_size = i_size_read(inode);
 	struct address_space *mapping = inode->i_mapping;
 	gfp_t gfp_mask = mapping_gfp_mask(mapping);
 	struct page **pages = NULL;
@@ -2457,6 +2457,7 @@ int ni_read_frame(struct ntfs_inode *ni, u64 frame_vbo, struct page **pages,
 	struct ATTR_LIST_ENTRY *le = NULL;
 	struct runs_tree *run = &ni->file.run;
 	u64 valid_size = ni->i_valid;
+	loff_t i_size = i_size_read(&ni->vfs_inode);
 	u64 vbo_disk;
 	size_t unc_size;
 	u32 frame_size, i, npages_disk, ondisk_size;
@@ -2548,7 +2549,7 @@ int ni_read_frame(struct ntfs_inode *ni, u64 frame_vbo, struct page **pages,
 			}
 		}
 
-		frames = (ni->vfs_inode.i_size - 1) >> frame_bits;
+		frames = (i_size - 1) >> frame_bits;
 
 		err = attr_wof_frame_info(ni, attr, run, frame64, frames,
 					  frame_bits, &ondisk_size, &vbo_data);
@@ -2556,8 +2557,7 @@ int ni_read_frame(struct ntfs_inode *ni, u64 frame_vbo, struct page **pages,
 			goto out2;
 
 		if (frame64 == frames) {
-			unc_size = 1 + ((ni->vfs_inode.i_size - 1) &
-					(frame_size - 1));
+			unc_size = 1 + ((i_size - 1) & (frame_size - 1));
 			ondisk_size = attr_size(attr) - vbo_data;
 		} else {
 			unc_size = frame_size;
diff --git a/fs/ntfs3/index.c b/fs/ntfs3/index.c
index cf92b2433f7a..daabaad63aaf 100644
--- a/fs/ntfs3/index.c
+++ b/fs/ntfs3/index.c
@@ -1462,7 +1462,7 @@ static int indx_create_allocate(struct ntfs_index *indx, struct ntfs_inode *ni,
 		goto out2;
 
 	if (in->name == I30_NAME) {
-		ni->vfs_inode.i_size = data_size;
+		i_size_write(&ni->vfs_inode, data_size);
 		inode_set_bytes(&ni->vfs_inode, alloc_size);
 	}
 
@@ -1544,7 +1544,7 @@ static int indx_add_allocate(struct ntfs_index *indx, struct ntfs_inode *ni,
 	}
 
 	if (in->name == I30_NAME)
-		ni->vfs_inode.i_size = data_size;
+		i_size_write(&ni->vfs_inode, data_size);
 
 	*vbn = bit << indx->idx2vbn_bits;
 
@@ -2090,7 +2090,7 @@ static int indx_shrink(struct ntfs_index *indx, struct ntfs_inode *ni,
 		return err;
 
 	if (in->name == I30_NAME)
-		ni->vfs_inode.i_size = new_data;
+		i_size_write(&ni->vfs_inode, new_data);
 
 	bpb = bitmap_size(bit);
 	if (bpb * 8 == nbits)
@@ -2576,7 +2576,7 @@ int indx_delete_entry(struct ntfs_index *indx, struct ntfs_inode *ni,
 		err = attr_set_size(ni, ATTR_ALLOC, in->name, in->name_len,
 				    &indx->alloc_run, 0, NULL, false, NULL);
 		if (in->name == I30_NAME)
-			ni->vfs_inode.i_size = 0;
+			i_size_write(&ni->vfs_inode, 0);
 
 		err = ni_remove_attr(ni, ATTR_ALLOC, in->name, in->name_len,
 				     false, NULL);
diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index 012dbc8ac5ec..34f2e16f3f5b 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -983,7 +983,7 @@ int ntfs_write_end(struct file *file, struct address_space *mapping, loff_t pos,
 		}
 
 		if (pos + err > inode->i_size) {
-			inode->i_size = pos + err;
+			i_size_write(inode, pos + err);
 			dirty = true;
 		}
 
-- 
2.43.0


