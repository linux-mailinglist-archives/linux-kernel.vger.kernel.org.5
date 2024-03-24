Return-Path: <linux-kernel+bounces-113475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22A4588849E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:46:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D09E5289689
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDBFF1B453C;
	Sun, 24 Mar 2024 22:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XAQlU5zX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6611B451D;
	Sun, 24 Mar 2024 22:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320276; cv=none; b=hktePxPw74v9ut0r4f8XYplYtAt6nV2jxEiK03pJ6+aCRXRafFkTVCzNZrzDq0exSCqPZv9DJFR6IfZPvvWEqLBwsXF79Hl6mPnSeqQQrjJ+edpSpkCCXhAnlmrlXF8MOr9u8BkK46sXPTi3/1EEKzJq6MAoZKDyg3+bD/Jsro8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320276; c=relaxed/simple;
	bh=fUnQXr8oT1mgR9zFLdI1sldD79+N3ZhKlzqbNo5/iwE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=in04VhWIacl+QrdaG/mjynNZZOHK/ylFHAyvn0KQUM3jXdurYrH8sgJncHh2mffea/VEi0qMYzOKtD/P3coO0nHtO6wnhxlNID52847OK/RR31JWEzvNxeUeSIwjWpJnjrf8jZq3qjW3pjY1Sm6Cr/JwMnbchs+iWGzH9bzbUTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XAQlU5zX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60316C433F1;
	Sun, 24 Mar 2024 22:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320276;
	bh=fUnQXr8oT1mgR9zFLdI1sldD79+N3ZhKlzqbNo5/iwE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XAQlU5zXMD8hgi+WqNmF3TxgKnIgrN8Qy+oOZJvydD84IJyxwr9c3pG0kARe5QFlU
	 pjB9iEKz2rqRs75leYui8+x5NIK6Km58LS1NMpw/hZsDaCMNVkeloCJHwHf4lwrX3d
	 2+eoODFCp+u+rel8beZec6RFj2msP2BhExly93mrYVmPitz9rxjd/kTdWlSvjsvEPS
	 2ry7147Mk3PkIb7zT+KHpzMgLC70lez/+prYYu7YPvN/MXtVoYf1jwHEKR8G99kJaJ
	 TkkhnWj3EO0Js4ywmUlznsGYsdZrfVe+YJFVkrlGLHcRCfT5t7INq8kpN93I3nJ4kW
	 p4uneFjsxkG2Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 584/715] f2fs: ro: compress: fix to avoid caching unaligned extent
Date: Sun, 24 Mar 2024 18:32:43 -0400
Message-ID: <20240324223455.1342824-585-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
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

[ Upstream commit 4b99ecd304290c4ef55666a62c89dfb2dbf0b2cd ]

Mapping info from dump.f2fs:
i_addr[0x2d] cluster flag    		[0xfffffffe : 4294967294]
i_addr[0x2e]                 		[0x   10428 : 66600]
i_addr[0x2f]                 		[0x   10429 : 66601]
i_addr[0x30]                 		[0x   1042a : 66602]

f2fs_io fiemap 37 1 /mnt/f2fs/disk-58390c8c.raw

Previsouly, it missed to align fofs and ofs_in_node to cluster_size,
result in adding incorrect read extent cache, fix it.

Before:
f2fs_update_read_extent_tree_range: dev = (253,48), ino = 5, pgofs = 37, len = 4, blkaddr = 66600, c_len = 3

After:
f2fs_update_read_extent_tree_range: dev = (253,48), ino = 5, pgofs = 36, len = 4, blkaddr = 66600, c_len = 3

Fixes: 94afd6d6e525 ("f2fs: extent cache: support unaligned extent")
Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/compress.c | 10 ++++++----
 fs/f2fs/f2fs.h     |  6 ++++--
 fs/f2fs/node.c     | 20 ++++++++++++++------
 3 files changed, 24 insertions(+), 12 deletions(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index ff26b49c0d71f..15f330d8fdb93 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -1817,16 +1817,18 @@ void f2fs_put_page_dic(struct page *page, bool in_task)
  * check whether cluster blocks are contiguous, and add extent cache entry
  * only if cluster blocks are logically and physically contiguous.
  */
-unsigned int f2fs_cluster_blocks_are_contiguous(struct dnode_of_data *dn)
+unsigned int f2fs_cluster_blocks_are_contiguous(struct dnode_of_data *dn,
+						unsigned int ofs_in_node)
 {
-	bool compressed = f2fs_data_blkaddr(dn) == COMPRESS_ADDR;
+	bool compressed = data_blkaddr(dn->inode, dn->node_page,
+					ofs_in_node) == COMPRESS_ADDR;
 	int i = compressed ? 1 : 0;
 	block_t first_blkaddr = data_blkaddr(dn->inode, dn->node_page,
-						dn->ofs_in_node + i);
+							ofs_in_node + i);
 
 	for (i += 1; i < F2FS_I(dn->inode)->i_cluster_size; i++) {
 		block_t blkaddr = data_blkaddr(dn->inode, dn->node_page,
-						dn->ofs_in_node + i);
+							ofs_in_node + i);
 
 		if (!__is_valid_data_blkaddr(blkaddr))
 			break;
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index eb12d1f6cd96f..585559ea71557 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -4298,7 +4298,8 @@ struct decompress_io_ctx *f2fs_alloc_dic(struct compress_ctx *cc);
 void f2fs_decompress_end_io(struct decompress_io_ctx *dic, bool failed,
 				bool in_task);
 void f2fs_put_page_dic(struct page *page, bool in_task);
-unsigned int f2fs_cluster_blocks_are_contiguous(struct dnode_of_data *dn);
+unsigned int f2fs_cluster_blocks_are_contiguous(struct dnode_of_data *dn,
+						unsigned int ofs_in_node);
 int f2fs_init_compress_ctx(struct compress_ctx *cc);
 void f2fs_destroy_compress_ctx(struct compress_ctx *cc, bool reuse);
 void f2fs_init_compress_info(struct f2fs_sb_info *sbi);
@@ -4355,7 +4356,8 @@ static inline void f2fs_put_page_dic(struct page *page, bool in_task)
 {
 	WARN_ON_ONCE(1);
 }
-static inline unsigned int f2fs_cluster_blocks_are_contiguous(struct dnode_of_data *dn) { return 0; }
+static inline unsigned int f2fs_cluster_blocks_are_contiguous(
+			struct dnode_of_data *dn, unsigned int ofs_in_node) { return 0; }
 static inline bool f2fs_sanity_check_cluster(struct dnode_of_data *dn) { return false; }
 static inline int f2fs_init_compress_inode(struct f2fs_sb_info *sbi) { return 0; }
 static inline void f2fs_destroy_compress_inode(struct f2fs_sb_info *sbi) { }
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 9b546fd210100..2ea9c99e7dcb7 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -852,21 +852,29 @@ int f2fs_get_dnode_of_data(struct dnode_of_data *dn, pgoff_t index, int mode)
 
 	if (is_inode_flag_set(dn->inode, FI_COMPRESSED_FILE) &&
 					f2fs_sb_has_readonly(sbi)) {
-		unsigned int c_len = f2fs_cluster_blocks_are_contiguous(dn);
+		unsigned int cluster_size = F2FS_I(dn->inode)->i_cluster_size;
+		unsigned int ofs_in_node = dn->ofs_in_node;
+		pgoff_t fofs = index;
+		unsigned int c_len;
 		block_t blkaddr;
 
+		/* should align fofs and ofs_in_node to cluster_size */
+		if (fofs % cluster_size) {
+			fofs = round_down(fofs, cluster_size);
+			ofs_in_node = round_down(ofs_in_node, cluster_size);
+		}
+
+		c_len = f2fs_cluster_blocks_are_contiguous(dn, ofs_in_node);
 		if (!c_len)
 			goto out;
 
-		blkaddr = f2fs_data_blkaddr(dn);
+		blkaddr = data_blkaddr(dn->inode, dn->node_page, ofs_in_node);
 		if (blkaddr == COMPRESS_ADDR)
 			blkaddr = data_blkaddr(dn->inode, dn->node_page,
-						dn->ofs_in_node + 1);
+						ofs_in_node + 1);
 
 		f2fs_update_read_extent_tree_range_compressed(dn->inode,
-					index, blkaddr,
-					F2FS_I(dn->inode)->i_cluster_size,
-					c_len);
+					fofs, blkaddr, cluster_size, c_len);
 	}
 out:
 	return 0;
-- 
2.43.0


