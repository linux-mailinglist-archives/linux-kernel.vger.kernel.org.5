Return-Path: <linux-kernel+bounces-114617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A033C88908A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:21:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A671291D9D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E7142A356D;
	Sun, 24 Mar 2024 23:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pk6zm/vH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 972AF233CCF;
	Sun, 24 Mar 2024 23:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322276; cv=none; b=qh5xmYsYye6wTmiC19eGxcTNDQ9IND8iCj0RqgxUS0WVmO1XQKu3n7dJYBl2Iy3XLAOLHf1I5SN3uo+bFlvyl2N7udJBVf7jzxvqI4xHdW5GkYpoxcb8Wd52wtG49eiRo95NrY1S50x8Mpfsozp72Zszm8pvqaD7ysJ0/4qGAds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322276; c=relaxed/simple;
	bh=RGDQ8vXDDQ2xStrfPkg+xbYIiGXPXdhbbeeYn1QIhaE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EUAru4jCrtdq8RamBNo2V5DoKNb1ZQV/UUKvfgYmHPW1EXrhMBwN3KdcgWmXQ+CEyMZFgEZFXoqdaBhVRTf0N4ozpbq8o7UkbU070yB+nBtYzNPviyW2eDFpNn7DmlZQiQxUfem5wWSrqYlFI3Bobv4L/gM568qOY6MAUBsinrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pk6zm/vH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCBE0C43390;
	Sun, 24 Mar 2024 23:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322276;
	bh=RGDQ8vXDDQ2xStrfPkg+xbYIiGXPXdhbbeeYn1QIhaE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pk6zm/vHwxkJwCxJ3xkUQxIdVYLK6eB3mpQ3bJVwaoHnLCuONahjV65mTJL6I5FTC
	 mtIH+nvrpJkaCCD3yBDkGD+i35r2eiW1SKuRnhh6wYLdZnY1BRcPGHE81ood1xbcuo
	 XcVzJiycTl2VRGM7ff1wN6KRJS+TnKhLAK5zGw5RiaqtU2BqWRYufly1Q+K5ZG3Wk6
	 7ky7F4pC4kVm3G9SR1L6+yVMnHVub/ZVXMNBTwwiLinVv3zfoyEQaVHJyWp4JnN18S
	 7zNb6Rroiar0PQlTUb1BTXMIDbYnY5BeHDtFPHUNVNR0c+EQ9ZW36FjOHxZ7SQByh1
	 Zv8Q2N5gIMYRw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 359/451] f2fs: introduce get_dnode_addr() to clean up codes
Date: Sun, 24 Mar 2024 19:10:35 -0400
Message-ID: <20240324231207.1351418-360-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Chao Yu <chao@kernel.org>

[ Upstream commit 2020cd48e41cb8470bb1ca0835033d13d3178425 ]

Just cleanup, no logic changes.

Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Stable-dep-of: 54607494875e ("f2fs: compress: fix to avoid inconsistence bewteen i_blocks and dnode")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/data.c  | 11 ++---------
 fs/f2fs/f2fs.h  | 18 +++++++++++++++---
 fs/f2fs/file.c  |  8 +-------
 fs/f2fs/inode.c | 32 ++++++++++++++------------------
 4 files changed, 32 insertions(+), 37 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index a5d0d0b892875..65b69d38f332c 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1105,16 +1105,9 @@ static int f2fs_submit_page_read(struct inode *inode, struct page *page,
 
 static void __set_data_blkaddr(struct dnode_of_data *dn)
 {
-	struct f2fs_node *rn = F2FS_NODE(dn->node_page);
-	__le32 *addr_array;
-	int base = 0;
+	__le32 *addr = get_dnode_addr(dn->inode, dn->node_page);
 
-	if (IS_INODE(dn->node_page) && f2fs_has_extra_attr(dn->inode))
-		base = get_extra_isize(dn->inode);
-
-	/* Get physical address of data block */
-	addr_array = blkaddr_in_node(rn);
-	addr_array[base + dn->ofs_in_node] = cpu_to_le32(dn->data_blkaddr);
+	addr[dn->ofs_in_node] = cpu_to_le32(dn->data_blkaddr);
 }
 
 /*
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 0f7193a0ab422..108ba10679da2 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3246,12 +3246,13 @@ static inline bool f2fs_is_cow_file(struct inode *inode)
 	return is_inode_flag_set(inode, FI_COW_FILE);
 }
 
+static inline __le32 *get_dnode_addr(struct inode *inode,
+					struct page *node_page);
 static inline void *inline_data_addr(struct inode *inode, struct page *page)
 {
-	struct f2fs_inode *ri = F2FS_INODE(page);
-	int extra_size = get_extra_isize(inode);
+	__le32 *addr = get_dnode_addr(inode, page);
 
-	return (void *)&(ri->i_addr[extra_size + DEF_INLINE_RESERVED_SIZE]);
+	return (void *)(addr + DEF_INLINE_RESERVED_SIZE);
 }
 
 static inline int f2fs_has_inline_dentry(struct inode *inode)
@@ -3386,6 +3387,17 @@ static inline int get_inline_xattr_addrs(struct inode *inode)
 	return F2FS_I(inode)->i_inline_xattr_size;
 }
 
+static inline __le32 *get_dnode_addr(struct inode *inode,
+					struct page *node_page)
+{
+	int base = 0;
+
+	if (IS_INODE(node_page) && f2fs_has_extra_attr(inode))
+		base = get_extra_isize(inode);
+
+	return blkaddr_in_node(F2FS_NODE(node_page)) + base;
+}
+
 #define f2fs_get_inode_mode(i) \
 	((is_inode_flag_set(i, FI_ACL_MODE)) ? \
 	 (F2FS_I(i)->i_acl_mode) : ((i)->i_mode))
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 4d634b5b6011f..9a81d51ddf9e2 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -560,20 +560,14 @@ static int f2fs_file_open(struct inode *inode, struct file *filp)
 void f2fs_truncate_data_blocks_range(struct dnode_of_data *dn, int count)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(dn->inode);
-	struct f2fs_node *raw_node;
 	int nr_free = 0, ofs = dn->ofs_in_node, len = count;
 	__le32 *addr;
-	int base = 0;
 	bool compressed_cluster = false;
 	int cluster_index = 0, valid_blocks = 0;
 	int cluster_size = F2FS_I(dn->inode)->i_cluster_size;
 	bool released = !atomic_read(&F2FS_I(dn->inode)->i_compr_blocks);
 
-	if (IS_INODE(dn->node_page) && f2fs_has_extra_attr(dn->inode))
-		base = get_extra_isize(dn->inode);
-
-	raw_node = F2FS_NODE(dn->node_page);
-	addr = blkaddr_in_node(raw_node) + base + ofs;
+	addr = get_dnode_addr(dn->inode, dn->node_page) + ofs;
 
 	/* Assumption: truncateion starts with cluster */
 	for (; count > 0; count--, addr++, dn->ofs_in_node++, cluster_index++) {
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index f0f2584fed66e..869bb6ec107cc 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -59,35 +59,31 @@ void f2fs_set_inode_flags(struct inode *inode)
 			S_ENCRYPTED|S_VERITY|S_CASEFOLD);
 }
 
-static void __get_inode_rdev(struct inode *inode, struct f2fs_inode *ri)
+static void __get_inode_rdev(struct inode *inode, struct page *node_page)
 {
-	int extra_size = get_extra_isize(inode);
+	__le32 *addr = get_dnode_addr(inode, node_page);
 
 	if (S_ISCHR(inode->i_mode) || S_ISBLK(inode->i_mode) ||
 			S_ISFIFO(inode->i_mode) || S_ISSOCK(inode->i_mode)) {
-		if (ri->i_addr[extra_size])
-			inode->i_rdev = old_decode_dev(
-				le32_to_cpu(ri->i_addr[extra_size]));
+		if (addr[0])
+			inode->i_rdev = old_decode_dev(le32_to_cpu(addr[0]));
 		else
-			inode->i_rdev = new_decode_dev(
-				le32_to_cpu(ri->i_addr[extra_size + 1]));
+			inode->i_rdev = new_decode_dev(le32_to_cpu(addr[1]));
 	}
 }
 
-static void __set_inode_rdev(struct inode *inode, struct f2fs_inode *ri)
+static void __set_inode_rdev(struct inode *inode, struct page *node_page)
 {
-	int extra_size = get_extra_isize(inode);
+	__le32 *addr = get_dnode_addr(inode, node_page);
 
 	if (S_ISCHR(inode->i_mode) || S_ISBLK(inode->i_mode)) {
 		if (old_valid_dev(inode->i_rdev)) {
-			ri->i_addr[extra_size] =
-				cpu_to_le32(old_encode_dev(inode->i_rdev));
-			ri->i_addr[extra_size + 1] = 0;
+			addr[0] = cpu_to_le32(old_encode_dev(inode->i_rdev));
+			addr[1] = 0;
 		} else {
-			ri->i_addr[extra_size] = 0;
-			ri->i_addr[extra_size + 1] =
-				cpu_to_le32(new_encode_dev(inode->i_rdev));
-			ri->i_addr[extra_size + 2] = 0;
+			addr[0] = 0;
+			addr[1] = cpu_to_le32(new_encode_dev(inode->i_rdev));
+			addr[2] = 0;
 		}
 	}
 }
@@ -400,7 +396,7 @@ static int do_read_inode(struct inode *inode)
 	}
 
 	/* get rdev by using inline_info */
-	__get_inode_rdev(inode, ri);
+	__get_inode_rdev(inode, node_page);
 
 	if (!f2fs_need_inode_block_update(sbi, inode->i_ino))
 		fi->last_disk_size = inode->i_size;
@@ -672,7 +668,7 @@ void f2fs_update_inode(struct inode *inode, struct page *node_page)
 		}
 	}
 
-	__set_inode_rdev(inode, ri);
+	__set_inode_rdev(inode, node_page);
 
 	/* deleted inode */
 	if (inode->i_nlink == 0)
-- 
2.43.0


