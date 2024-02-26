Return-Path: <linux-kernel+bounces-80677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1583A866B1B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 08:41:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADC0F1F22063
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 07:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B81E1D532;
	Mon, 26 Feb 2024 07:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xa7ptxQB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945EA1C695
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 07:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708932946; cv=none; b=L13hOgSOfHykqIlhaxTmzg/nwSXHg8jd223Ze1XosLMsKhXKSxhgKboKeZCrrRggbsv3kkTzSKtnjLsp4AlOP/ToML4IESu3+YnXE2EJsdif4zYH8nWxyhuVfkx7ZRXvrNbTPuFBSxdCr07BHFJnhyqjmW4DyMDiVxqkP8APCN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708932946; c=relaxed/simple;
	bh=xYW4vWigmlTDvWjBbKDHIv6Pc+z/yoRDygV1eUyCs3s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pBwgBwc9WSr4k/WuNWhm758MZXSx/b56zXJS1g0SIOUFvjH6+gedPs22nTCBxqL9xLMC996oXR6frrxUUfLXthxOyZh1PhQNWoiR1ItkQD39IGe2eaj3KoKF3IWouwVjwDEqEkCUeOZjSTxNYhCnn1KDXVIjpBwdY3+ViKqxV3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xa7ptxQB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BAF0C43390;
	Mon, 26 Feb 2024 07:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708932945;
	bh=xYW4vWigmlTDvWjBbKDHIv6Pc+z/yoRDygV1eUyCs3s=;
	h=From:To:Cc:Subject:Date:From;
	b=Xa7ptxQB7eVKCaBz+kFs8H+z7DLqwuPctA+AeKlsNaiFrv8t3/L5MS6DC2ogMVQKU
	 fRFMU95DpzuU2UkSVvoAtyMVWWwm3ZLhJD9uzvyjoYGhb4CtbptUmqApgi9IZGwadZ
	 SygTwNGQWG9BzOCywONdVGxk+fm9PpOTqukLesEZVh9+l2dojQR9j/6IxA3+QXywvo
	 f9jVeYxRcOceEb7rdkuIMJ4IjViJiXhtxEgQAUUFO6h8gSIURMT3G/HN9FcSGHYyxi
	 TJANZ9ZO1xm3fwXVJRRQGocuKpVfyEREn06qnV0bvSRqSrT157YcnSfz0ZGS4OTEQ7
	 GQLZE7t3BmFrQ==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH 1/2] f2fs: ro: compress: fix to avoid caching unaligned extent
Date: Mon, 26 Feb 2024 15:35:38 +0800
Message-Id: <20240226073539.2509926-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
---
 fs/f2fs/compress.c | 10 ++++++----
 fs/f2fs/f2fs.h     |  6 ++++--
 fs/f2fs/node.c     | 20 ++++++++++++++------
 3 files changed, 24 insertions(+), 12 deletions(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index f821681886b8..21f03d119d4d 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -1841,16 +1841,18 @@ void f2fs_put_page_dic(struct page *page, bool in_task)
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
index 51701fc66200..33fd02716cf3 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -4307,7 +4307,8 @@ struct decompress_io_ctx *f2fs_alloc_dic(struct compress_ctx *cc);
 void f2fs_decompress_end_io(struct decompress_io_ctx *dic, bool failed,
 				bool in_task);
 void f2fs_put_page_dic(struct page *page, bool in_task);
-unsigned int f2fs_cluster_blocks_are_contiguous(struct dnode_of_data *dn);
+unsigned int f2fs_cluster_blocks_are_contiguous(struct dnode_of_data *dn,
+						unsigned int ofs_in_node);
 int f2fs_init_compress_ctx(struct compress_ctx *cc);
 void f2fs_destroy_compress_ctx(struct compress_ctx *cc, bool reuse);
 void f2fs_init_compress_info(struct f2fs_sb_info *sbi);
@@ -4364,7 +4365,8 @@ static inline void f2fs_put_page_dic(struct page *page, bool in_task)
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
index 51241996b9ec..b3de6d6cdb02 100644
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
2.40.1


