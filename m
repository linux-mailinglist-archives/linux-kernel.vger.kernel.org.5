Return-Path: <linux-kernel+bounces-114609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A468888B4B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:45:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBB461C293F9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0862915E1F7;
	Sun, 24 Mar 2024 23:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HpCvQj4V"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF3D233CCE;
	Sun, 24 Mar 2024 23:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322278; cv=none; b=VQU1ak4Qdzo0rMxC0ZmSNX8kEwPYW3dx+CZ+Nq2qqLfdgfl0nBDqNPca7SbTvlnzYpASEpmvar5nr00klkv8bW7m889/3ngerb+UF+WnPFJzEi0BbWyxS7AjJfyI2AgivS4udd7nj5SZd6hvOM3SnQCZAzLgNZsU1e0boOfpJ4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322278; c=relaxed/simple;
	bh=SP2diwHtIieff6iAqt0+0OuTDEDGXkBIwrGVubuaFXk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lAypX3YvSRl7odHmB6K5rlE4E0nau5wP9Z2wiJix+F3q4oF4a0WX2QoM28TvJ3DNNvLt/as1t2x2c1Jok+WFgInVpH3Dbyj8ZuvuUjIVYPRPnHrP72OkYhdqavt1HE7PQRRzJIV41G1l94uccMdis1KGdrkkVFNcvNXfjPcck2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HpCvQj4V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA5FAC43390;
	Sun, 24 Mar 2024 23:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322277;
	bh=SP2diwHtIieff6iAqt0+0OuTDEDGXkBIwrGVubuaFXk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HpCvQj4V8ZNfcjTLn8C0+fm7Mmao70mxI3kEg5+EzHWiTwyFPBdmehdgxMR1rSbcf
	 ihWziXT16P6IaUvZMDYWokSluw9F2epdJV76GA7CJdB/ZwvjLZfhalc1gCyWr1ZGp0
	 n+piWT6wkN6Iii0uAhSlyPS7Q+LFQJCbbK7NK2/OKEovBdSqbLsCbrXhL179ipQCxX
	 d+yw8e5lzXWJybD/fdFQS8+W2rbX2IFFH48e8aaNkMT19wU7TjH0T4kailgG21lVOU
	 gotP4M5epxIMSnk4h6cZpBtqeBqg+fH3JN+HWFDdqFYhYuhCvZr2lPxzKhsAAtYENT
	 v+FUE5ywfHmxg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 360/451] f2fs: update blkaddr in __set_data_blkaddr() for cleanup
Date: Sun, 24 Mar 2024 19:10:36 -0400
Message-ID: <20240324231207.1351418-361-sashal@kernel.org>
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

[ Upstream commit 59d0d4c3eae0f3dd8886ed59f89f21fa09e324f5 ]

This patch allows caller to pass blkaddr to f2fs_set_data_blkaddr()
and let __set_data_blkaddr() inside f2fs_set_data_blkaddr() to update
dn->data_blkaddr w/ last value of blkaddr.

Just cleanup, no logic changes.

Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Stable-dep-of: 54607494875e ("f2fs: compress: fix to avoid inconsistence bewteen i_blocks and dnode")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/data.c | 13 ++++++-------
 fs/f2fs/f2fs.h |  2 +-
 fs/f2fs/file.c | 12 ++++--------
 3 files changed, 11 insertions(+), 16 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 65b69d38f332c..1aa7d443cf364 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1103,10 +1103,11 @@ static int f2fs_submit_page_read(struct inode *inode, struct page *page,
 	return 0;
 }
 
-static void __set_data_blkaddr(struct dnode_of_data *dn)
+static void __set_data_blkaddr(struct dnode_of_data *dn, block_t blkaddr)
 {
 	__le32 *addr = get_dnode_addr(dn->inode, dn->node_page);
 
+	dn->data_blkaddr = blkaddr;
 	addr[dn->ofs_in_node] = cpu_to_le32(dn->data_blkaddr);
 }
 
@@ -1116,18 +1117,17 @@ static void __set_data_blkaddr(struct dnode_of_data *dn)
  *  ->node_page
  *    update block addresses in the node page
  */
-void f2fs_set_data_blkaddr(struct dnode_of_data *dn)
+void f2fs_set_data_blkaddr(struct dnode_of_data *dn, block_t blkaddr)
 {
 	f2fs_wait_on_page_writeback(dn->node_page, NODE, true, true);
-	__set_data_blkaddr(dn);
+	__set_data_blkaddr(dn, blkaddr);
 	if (set_page_dirty(dn->node_page))
 		dn->node_changed = true;
 }
 
 void f2fs_update_data_blkaddr(struct dnode_of_data *dn, block_t blkaddr)
 {
-	dn->data_blkaddr = blkaddr;
-	f2fs_set_data_blkaddr(dn);
+	f2fs_set_data_blkaddr(dn, blkaddr);
 	f2fs_update_read_extent_cache(dn);
 }
 
@@ -1154,8 +1154,7 @@ int f2fs_reserve_new_blocks(struct dnode_of_data *dn, blkcnt_t count)
 		block_t blkaddr = f2fs_data_blkaddr(dn);
 
 		if (blkaddr == NULL_ADDR) {
-			dn->data_blkaddr = NEW_ADDR;
-			__set_data_blkaddr(dn);
+			__set_data_blkaddr(dn, NEW_ADDR);
 			count--;
 		}
 	}
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 108ba10679da2..7f34c7d0d156e 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3781,7 +3781,7 @@ void f2fs_submit_page_write(struct f2fs_io_info *fio);
 struct block_device *f2fs_target_device(struct f2fs_sb_info *sbi,
 		block_t blk_addr, sector_t *sector);
 int f2fs_target_device_index(struct f2fs_sb_info *sbi, block_t blkaddr);
-void f2fs_set_data_blkaddr(struct dnode_of_data *dn);
+void f2fs_set_data_blkaddr(struct dnode_of_data *dn, block_t blkaddr);
 void f2fs_update_data_blkaddr(struct dnode_of_data *dn, block_t blkaddr);
 int f2fs_reserve_new_blocks(struct dnode_of_data *dn, blkcnt_t count);
 int f2fs_reserve_new_block(struct dnode_of_data *dn);
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 9a81d51ddf9e2..aa3ded9825f0c 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -585,8 +585,7 @@ void f2fs_truncate_data_blocks_range(struct dnode_of_data *dn, int count)
 		if (blkaddr == NULL_ADDR)
 			continue;
 
-		dn->data_blkaddr = NULL_ADDR;
-		f2fs_set_data_blkaddr(dn);
+		f2fs_set_data_blkaddr(dn, NULL_ADDR);
 
 		if (__is_valid_data_blkaddr(blkaddr)) {
 			if (!f2fs_is_valid_blkaddr(sbi, blkaddr,
@@ -1488,8 +1487,7 @@ static int f2fs_do_zero_range(struct dnode_of_data *dn, pgoff_t start,
 		}
 
 		f2fs_invalidate_blocks(sbi, dn->data_blkaddr);
-		dn->data_blkaddr = NEW_ADDR;
-		f2fs_set_data_blkaddr(dn);
+		f2fs_set_data_blkaddr(dn, NEW_ADDR);
 	}
 
 	f2fs_update_read_extent_cache_range(dn, start, 0, index - start);
@@ -3440,8 +3438,7 @@ static int release_compress_blocks(struct dnode_of_data *dn, pgoff_t count)
 			if (blkaddr != NEW_ADDR)
 				continue;
 
-			dn->data_blkaddr = NULL_ADDR;
-			f2fs_set_data_blkaddr(dn);
+			f2fs_set_data_blkaddr(dn, NULL_ADDR);
 		}
 
 		f2fs_i_compr_blocks_update(dn->inode, compr_blocks, false);
@@ -3611,8 +3608,7 @@ static int reserve_compress_blocks(struct dnode_of_data *dn, pgoff_t count)
 				continue;
 			}
 
-			dn->data_blkaddr = NEW_ADDR;
-			f2fs_set_data_blkaddr(dn);
+			f2fs_set_data_blkaddr(dn, NEW_ADDR);
 		}
 
 		reserved = cluster_size - compr_blocks;
-- 
2.43.0


