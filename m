Return-Path: <linux-kernel+bounces-114896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22767889282
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:08:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1A0D29B4BB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 714202D02DB;
	Mon, 25 Mar 2024 00:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="do1fOi+4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83786178883;
	Sun, 24 Mar 2024 23:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323552; cv=none; b=i/gE2FKimHOoivv+FwgWY4lTDJzj/F6UAPCBKqTL76Ky9qVmiW/4sbnqkdga7Tfb37gMvYhyMw8Bvo7LeYNdpouzkqDMAm1nA6gogYf9YRZIv/kWQXiZ5WwTYi3Pv2nmZiHAI3huICLMTr/Rw93rr8HM+3lyuiTT7Lo54VqMdfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323552; c=relaxed/simple;
	bh=UBPDZAOjr12Ddguq/hvTmroDK+Um32lqBNnBh/Wk5lc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xd9smGGlK7tnLzn9aLK27u2p/IsiPspILJ2h+z1sk3lBc69klQJ7Sox9c4gtCzGioqm95WiAaiEdRM/lGT7TXWdh5xiaY5RVoNXdiYVq2wIcMq/4Iee0JxOYLudkbxAv1+8mUjS0xzYcjuNUrb48+Rbai6XDQHJaChG3z1fF0EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=do1fOi+4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0A59C43394;
	Sun, 24 Mar 2024 23:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323552;
	bh=UBPDZAOjr12Ddguq/hvTmroDK+Um32lqBNnBh/Wk5lc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=do1fOi+4r78LLnuc+kPBswb0WPd7CsKFzTvON0Pj0dO02m0SGqaKCpW1y372+HBzO
	 K9iR8mMF643jfMqDfAg2CyUMM6n+ON+FA7/XwHOp1qEGZI0EmoJGMGHxMPhC9mxJ1o
	 9IeUFC6ViMnBY4jn1FKCo6jCiyj04ZikBiJvy5jfmskCrU0W4XiV3L6u75BAtQOdTD
	 nFthSXnso7WcmNPQAFNbHYqI01wEluCU2cazKhzS2hO/XT/3aFPIIp1Pl6y13gfi4x
	 Ok5iyr6tQxILQXCS0Chs9kVfbdZVRXKOYg1N7BwaaR1HbgkVpXftuQ218nVUDp7869
	 XINefFaJhld9A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	Chao Yu <chao.yu@oppo.com>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 259/317] f2fs: invalidate meta pages only for post_read required inode
Date: Sun, 24 Mar 2024 19:33:59 -0400
Message-ID: <20240324233458.1352854-260-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324233458.1352854-1-sashal@kernel.org>
References: <20240324233458.1352854-1-sashal@kernel.org>
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

[ Upstream commit 0d5b9d8156396bbe1c982708b38ab9e188c45ec9 ]

After commit e3b49ea36802 ("f2fs: invalidate META_MAPPING before
IPU/DIO write"), invalidate_mapping_pages() will be called to
avoid race condition in between IPU/DIO and readahead for GC.

However, readahead flow is only used for post_read required inode,
so this patch adds check condition to avoids unnecessary page cache
invalidating for non-post_read inode.

Signed-off-by: Chao Yu <chao.yu@oppo.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Stable-dep-of: fd244524c2cf ("f2fs: compress: fix to cover normal cluster write with cp_rwsem")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/data.c    | 8 ++------
 fs/f2fs/f2fs.h    | 1 +
 fs/f2fs/segment.c | 9 ++++++++-
 3 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 222af7d5f91b7..4f122a806cf88 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1496,12 +1496,9 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
 			*map->m_next_extent = pgofs + map->m_len;
 
 		/* for hardware encryption, but to avoid potential issue in future */
-		if (flag == F2FS_GET_BLOCK_DIO) {
+		if (flag == F2FS_GET_BLOCK_DIO)
 			f2fs_wait_on_block_writeback_range(inode,
 						map->m_pblk, map->m_len);
-			invalidate_mapping_pages(META_MAPPING(sbi),
-				map->m_pblk, map->m_pblk + map->m_len - 1);
-		}
 
 		if (map->m_multidev_dio) {
 			block_t blk_addr = map->m_pblk;
@@ -1714,8 +1711,6 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
 		 */
 		f2fs_wait_on_block_writeback_range(inode,
 						map->m_pblk, map->m_len);
-		invalidate_mapping_pages(META_MAPPING(sbi),
-				map->m_pblk, map->m_pblk + map->m_len - 1);
 
 		if (map->m_multidev_dio) {
 			block_t blk_addr = map->m_pblk;
@@ -2808,6 +2803,7 @@ int f2fs_write_single_data_page(struct page *page, int *submitted,
 		.submitted = false,
 		.compr_blocks = compr_blocks,
 		.need_lock = LOCK_RETRY,
+		.post_read = f2fs_post_read_required(inode),
 		.io_type = io_type,
 		.io_wbc = wbc,
 		.bio = bio,
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index dfaee211f6133..d961a2779b6e7 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1177,6 +1177,7 @@ struct f2fs_io_info {
 	bool retry;		/* need to reallocate block address */
 	int compr_blocks;	/* # of compressed block addresses */
 	bool encrypted;		/* indicate file is encrypted */
+	bool post_read;		/* require post read */
 	enum iostat_type io_type;	/* io type */
 	struct writeback_control *io_wbc; /* writeback control */
 	struct bio **bio;		/* bio for ipu */
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index cbdd8d0ec8960..43fabd17bb4e7 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -3620,7 +3620,8 @@ int f2fs_inplace_write_data(struct f2fs_io_info *fio)
 		goto drop_bio;
 	}
 
-	invalidate_mapping_pages(META_MAPPING(sbi),
+	if (fio->post_read)
+		invalidate_mapping_pages(META_MAPPING(sbi),
 				fio->new_blkaddr, fio->new_blkaddr);
 
 	stat_inc_inplace_blocks(fio->sbi);
@@ -3803,10 +3804,16 @@ void f2fs_wait_on_block_writeback(struct inode *inode, block_t blkaddr)
 void f2fs_wait_on_block_writeback_range(struct inode *inode, block_t blkaddr,
 								block_t len)
 {
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	block_t i;
 
+	if (!f2fs_post_read_required(inode))
+		return;
+
 	for (i = 0; i < len; i++)
 		f2fs_wait_on_block_writeback(inode, blkaddr + i);
+
+	invalidate_mapping_pages(META_MAPPING(sbi), blkaddr, blkaddr + len - 1);
 }
 
 static int read_compacted_summaries(struct f2fs_sb_info *sbi)
-- 
2.43.0


