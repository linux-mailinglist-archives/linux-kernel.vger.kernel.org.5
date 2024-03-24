Return-Path: <linux-kernel+bounces-115722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFE9E889744
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:12:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19BE31C2D514
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28412218743;
	Mon, 25 Mar 2024 02:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vR8yrIqK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81DBC21852E;
	Sun, 24 Mar 2024 23:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321788; cv=none; b=JHTSOe9zFw1o/so+1v68ZAAETnhxZ5B79WtAWlcl6NokBqJL33kT8NxhYtmSVK4d/B4l134ZlsGnsqAGHqiOLldQm6UDintxSmB495U5MZhOVoSm7ojvfaNxgc8NO+enXgDNN1NBHzERCuBCei5TdMrPPVkG1wrrEG450Msln80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321788; c=relaxed/simple;
	bh=q4s74LRAulqbBGBVjJ/MODzsiqmDvD3V81+Owdlc6Is=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ahf8RLbMW6cTKizL+tzeaOXb+UYmM9RXdo5z040eIAm1//oQyeifNCJPehEY5f7VzCa5HcOKbDPc1BM6zccfbPvK7jwYLHKBZXgkFbY9reHeKI/3K77yT8gJgfURlp0czpYYEr+mNGcBk2Zy1b+Xf3N6wK19pb5HiqZknHQ5ryg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vR8yrIqK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFF64C433C7;
	Sun, 24 Mar 2024 23:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321787;
	bh=q4s74LRAulqbBGBVjJ/MODzsiqmDvD3V81+Owdlc6Is=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vR8yrIqK4m7HCZinkRbbrz/djVG39INQAOwDQ3taOIuzTt0CxAHwxMmVy9yv3SSFi
	 3AjG2t6GtJ/FenAjvDSTe+T+/jt8VqHSoY40jDLS655PSf1vX6Qe0flTvDR3udBQgZ
	 xhJOJjXOCWVEtEhTIDgwTYykV1HtlDwQIklKn2MKh2oBqJ6GcPg4gr6ndTFDRvpQFg
	 vCga1cMnodU4GWwJ4fqolZMzPAnMkZRbo9oB2GZlB8gJIWNFpFre9i6wCPginNWugJ
	 mmGOL3jU9MSPCt2eSF80mpC0XEq7a+uMCEPWa/ctmEvGhbKQHZ8ztiNCSLY1Hml+++
	 x0xd0GXlWKUYg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 515/638] f2fs: update blkaddr in __set_data_blkaddr() for cleanup
Date: Sun, 24 Mar 2024 18:59:12 -0400
Message-ID: <20240324230116.1348576-516-sashal@kernel.org>
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
index ec5088f814cab..a961288daafcb 100644
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
index 1155790892b13..a768722f26b65 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3814,7 +3814,7 @@ void f2fs_submit_page_write(struct f2fs_io_info *fio);
 struct block_device *f2fs_target_device(struct f2fs_sb_info *sbi,
 		block_t blk_addr, sector_t *sector);
 int f2fs_target_device_index(struct f2fs_sb_info *sbi, block_t blkaddr);
-void f2fs_set_data_blkaddr(struct dnode_of_data *dn);
+void f2fs_set_data_blkaddr(struct dnode_of_data *dn, block_t blkaddr);
 void f2fs_update_data_blkaddr(struct dnode_of_data *dn, block_t blkaddr);
 int f2fs_reserve_new_blocks(struct dnode_of_data *dn, blkcnt_t count);
 int f2fs_reserve_new_block(struct dnode_of_data *dn);
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 9cfb0bce52c4b..73e1df8d584fb 100644
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


