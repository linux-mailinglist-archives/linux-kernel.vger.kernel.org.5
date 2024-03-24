Return-Path: <linux-kernel+bounces-113917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B14F5888755
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:57:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2E5D1C2665F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2D00212D27;
	Sun, 24 Mar 2024 23:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HEjsG2lf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88672149C7F;
	Sun, 24 Mar 2024 22:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321010; cv=none; b=hJiOXNQm8/AbElXE7DsSy7kzNwLSK0tPPYsyhQ+/lnMUBOVgl2WI7i4gsjXaiVNg0nhn07dZaQ0wrB1F8XWk0BLbKi/OGGYGtqcNh0PMQ4nr1RI5TSmMZE/9nB7UdISMNJFGQ2PqaUrSahVcwwNP14aXHgtubZhqR1Rt3IBudGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321010; c=relaxed/simple;
	bh=B/AVMGh7eQKn9bz3Bma04jW373t+bzbmFrmRminmKaw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OeRlk+HCF8Zlde4y//AKSMRVCAxxtp6KIiXj3eB0HTIH3rOqX0oQb6lqoXT0D/6djcIWBjaroGKLGBpRd+BrSzN/ly1+uG46M56evkr4YFaEaapEajG18HU2Nx1ZrLMdmfxAtNgvEuAg+pNUM7vqRtS8adQbmZ0yu44/DJ2dfxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HEjsG2lf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA6B8C43390;
	Sun, 24 Mar 2024 22:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321010;
	bh=B/AVMGh7eQKn9bz3Bma04jW373t+bzbmFrmRminmKaw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HEjsG2lf1pfHBqSxtsuCEXjvHVSwIxrITqWMWAMTC3aKAfFSvJhy2+YAZXF1dpX6N
	 bbK3qGVWsNGVRNtmW9x8oGRJxQiihbhICAfD1UO8oI82eQR4fBtju5xjOu+ke2moXQ
	 45QOVpqm5bLZCo6YXzivGGHkr4hYNfQZjIt2V+lI6Nlj95DoJ3FqMe4C385i0Dyzyb
	 pmYHJnOBGyebowWf+OQV5s4seVc6ObxByM6FSz0+9hXU9UEQHX+ZfaNBSvstNWgG0v
	 6OZr1Fvt75MBQqtpl9jNvlgcbL8brvz1pZOsMroGsigh4Ez5o5Lw6p5dUAzD5d3qt4
	 j+PWUS9NYYYIg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 573/713] f2fs: update blkaddr in __set_data_blkaddr() for cleanup
Date: Sun, 24 Mar 2024 18:44:59 -0400
Message-ID: <20240324224720.1345309-574-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
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
index d1cccfded001b..88cdbb815880a 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1180,10 +1180,11 @@ static int f2fs_submit_page_read(struct inode *inode, struct page *page,
 	return 0;
 }
 
-static void __set_data_blkaddr(struct dnode_of_data *dn)
+static void __set_data_blkaddr(struct dnode_of_data *dn, block_t blkaddr)
 {
 	__le32 *addr = get_dnode_addr(dn->inode, dn->node_page);
 
+	dn->data_blkaddr = blkaddr;
 	addr[dn->ofs_in_node] = cpu_to_le32(dn->data_blkaddr);
 }
 
@@ -1193,18 +1194,17 @@ static void __set_data_blkaddr(struct dnode_of_data *dn)
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
 
@@ -1231,8 +1231,7 @@ int f2fs_reserve_new_blocks(struct dnode_of_data *dn, blkcnt_t count)
 		block_t blkaddr = f2fs_data_blkaddr(dn);
 
 		if (blkaddr == NULL_ADDR) {
-			dn->data_blkaddr = NEW_ADDR;
-			__set_data_blkaddr(dn);
+			__set_data_blkaddr(dn, NEW_ADDR);
 			count--;
 		}
 	}
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index fa38de60c716c..a05816556552c 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3817,7 +3817,7 @@ void f2fs_submit_page_write(struct f2fs_io_info *fio);
 struct block_device *f2fs_target_device(struct f2fs_sb_info *sbi,
 		block_t blk_addr, sector_t *sector);
 int f2fs_target_device_index(struct f2fs_sb_info *sbi, block_t blkaddr);
-void f2fs_set_data_blkaddr(struct dnode_of_data *dn);
+void f2fs_set_data_blkaddr(struct dnode_of_data *dn, block_t blkaddr);
 void f2fs_update_data_blkaddr(struct dnode_of_data *dn, block_t blkaddr);
 int f2fs_reserve_new_blocks(struct dnode_of_data *dn, blkcnt_t count);
 int f2fs_reserve_new_block(struct dnode_of_data *dn);
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 4f07fb0097965..2ea1ddd4e941f 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -582,8 +582,7 @@ void f2fs_truncate_data_blocks_range(struct dnode_of_data *dn, int count)
 		if (blkaddr == NULL_ADDR)
 			continue;
 
-		dn->data_blkaddr = NULL_ADDR;
-		f2fs_set_data_blkaddr(dn);
+		f2fs_set_data_blkaddr(dn, NULL_ADDR);
 
 		if (__is_valid_data_blkaddr(blkaddr)) {
 			if (!f2fs_is_valid_blkaddr(sbi, blkaddr,
@@ -1479,8 +1478,7 @@ static int f2fs_do_zero_range(struct dnode_of_data *dn, pgoff_t start,
 		}
 
 		f2fs_invalidate_blocks(sbi, dn->data_blkaddr);
-		dn->data_blkaddr = NEW_ADDR;
-		f2fs_set_data_blkaddr(dn);
+		f2fs_set_data_blkaddr(dn, NEW_ADDR);
 	}
 
 	f2fs_update_read_extent_cache_range(dn, start, 0, index - start);
@@ -3460,8 +3458,7 @@ static int release_compress_blocks(struct dnode_of_data *dn, pgoff_t count)
 			if (blkaddr != NEW_ADDR)
 				continue;
 
-			dn->data_blkaddr = NULL_ADDR;
-			f2fs_set_data_blkaddr(dn);
+			f2fs_set_data_blkaddr(dn, NULL_ADDR);
 		}
 
 		f2fs_i_compr_blocks_update(dn->inode, compr_blocks, false);
@@ -3633,8 +3630,7 @@ static int reserve_compress_blocks(struct dnode_of_data *dn, pgoff_t count)
 				continue;
 			}
 
-			dn->data_blkaddr = NEW_ADDR;
-			f2fs_set_data_blkaddr(dn);
+			f2fs_set_data_blkaddr(dn, NEW_ADDR);
 		}
 
 		reserved = cluster_size - compr_blocks;
-- 
2.43.0


