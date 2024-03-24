Return-Path: <linux-kernel+bounces-115733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14691889750
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:13:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2AC429C729
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DF841F0941;
	Mon, 25 Mar 2024 02:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dVInhzR7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7913B2197D8;
	Sun, 24 Mar 2024 23:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321810; cv=none; b=hJl24WKOorSdSY3x6V2GxCfgoMqS0SD81p/wdQFt2WVf3Dpv5iSunt7/kOf72DfrnPiD3+utNSMlMoB6BPqITMuV1+LMmEQt5gnNkt8BwmDvYzXHZRf5ySeOtjwwE0ZcPF3tDMb6cc0u8sE89SLDm2JZIWZDzVJB/CEnNaeTbZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321810; c=relaxed/simple;
	bh=GO2fC8zPeV/fqzrSgnMiqqZl+QzQKu1vQQTDzD4a9oI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j9pDpyOekYPAouP9a1OcYuQbPzheNzVL5d7HNSie4K0EvTtD4S+X0ugRNuuqFcw2DB1tQpurTVyp93dFIXPdJp5bQdQxqXYza52aVAqTBO591E30jG6R8D/YXTnNOUy1RBdsLE0o2jihqgU9cDcQEFT9izzmMwu2Vx4p6aOP7fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dVInhzR7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85F63C433C7;
	Sun, 24 Mar 2024 23:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321810;
	bh=GO2fC8zPeV/fqzrSgnMiqqZl+QzQKu1vQQTDzD4a9oI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dVInhzR7D+voSPr0Ktj05103F++/EGPxcF7bDNd4PiEQzlYXOrMElseHVeZnRFgO9
	 QqRZ9JgMz1fhWzW7K4zRZzeW1RHHsmUK2bLOBG25z9pLkyHBeuqBqN9DC2K9j3D90K
	 N+ujxLltZFmq63H2r2oM+gJmSrYE4h524FrJQTfLtj+F5hnIVmCLinU4VJrysOlfb9
	 wHqka1uo7vk738CwoiUTF9ojQxIecjQcUO90lCBqucIq+MS+23LqVQkp9tf/BWG9go
	 Xoj8ZBJXwOa3QS7t22AOO1GLuR0F3WPQMqMcBqwk3jxbJfEHi+ZganD2ltflNEXcgh
	 MVPf3CwNGo9jQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 538/638] f2fs: ro: compress: fix to avoid caching unaligned extent
Date: Sun, 24 Mar 2024 18:59:35 -0400
Message-ID: <20240324230116.1348576-539-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
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
index 8093d2f2a174f..a7037644b9324 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -1810,16 +1810,18 @@ void f2fs_put_page_dic(struct page *page, bool in_task)
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
index e6c22a392cdb0..54311765df373 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -4288,7 +4288,8 @@ struct decompress_io_ctx *f2fs_alloc_dic(struct compress_ctx *cc);
 void f2fs_decompress_end_io(struct decompress_io_ctx *dic, bool failed,
 				bool in_task);
 void f2fs_put_page_dic(struct page *page, bool in_task);
-unsigned int f2fs_cluster_blocks_are_contiguous(struct dnode_of_data *dn);
+unsigned int f2fs_cluster_blocks_are_contiguous(struct dnode_of_data *dn,
+						unsigned int ofs_in_node);
 int f2fs_init_compress_ctx(struct compress_ctx *cc);
 void f2fs_destroy_compress_ctx(struct compress_ctx *cc, bool reuse);
 void f2fs_init_compress_info(struct f2fs_sb_info *sbi);
@@ -4345,7 +4346,8 @@ static inline void f2fs_put_page_dic(struct page *page, bool in_task)
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
index 9e00932770d8a..cdd890dbd5e34 100644
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


