Return-Path: <linux-kernel+bounces-114895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 512A4889281
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:08:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8293D1C2D63D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C2802D02D8;
	Mon, 25 Mar 2024 00:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BuCANUz/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C69521D126;
	Sun, 24 Mar 2024 23:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323551; cv=none; b=J1aeFHcday8otyCwXFahcrpjv2YOnAXZsGY9BIvg8dy/oBwFyPZd5cHvu6Bhu2jBYQ+MdcfOTLkviJEw2bkNUvWeh5CUTkwYwFTLD8qflY5aMb5HVBSaRzQtO7ZWXoj6tz7U5OQ3ngROtAIvOgaS3wplrRi2OcL0wHOJ2LkRo08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323551; c=relaxed/simple;
	bh=uiqPJg8auQcg76ESCu0NC3QK9mTOBml9r1ZYFqMNJT0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NoJM2rzhW6OSsTp1puYF65EpRiWU/bYIA8qrxazxep51HLH0MCZ0jUQ2k2VubUqFJ2r0HJAdOqKslfVoEKByOJrXBsduBeRopzJbWBaoo10xcBhgn1KxXg9LvsrUgs9Zmc7SIySCpv4Wy9ggu8jNLaYVAGmwstn8ACmN/i9kkhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BuCANUz/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FDB4C433B2;
	Sun, 24 Mar 2024 23:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323551;
	bh=uiqPJg8auQcg76ESCu0NC3QK9mTOBml9r1ZYFqMNJT0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BuCANUz//9wR8CCT/bDgbMLPWaK8tOq76c78/XITjTFDWvjVaen+8UjYepLnC9N2n
	 E6pObbtCMlRdMlNMdZp5mDHMpzzArk9wjxH/5XaA1WxSlSsqnUTHP14z3Roec2bLiG
	 S0L+V+X4Ge8o7YR3jX3KZK5wAVHYMlkEdeJiyTO90m0KNjKLm+z5WFkWUc+WcEAXei
	 tu/YKyqssHPMW/expulDh2zJw2UXu7vAhoyl0oNzFHBXNaNNH4wQ75ELueBXSIm5yp
	 ft3nQ4d4dthzSlRojbs1Gp1aJ3TUE+8E+3uZVFLhRwvJm2mMaYVBweh2gzEzMUkzrE
	 vg7JRfCRiNzlA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	Hyeong-Jun Kim <hj514.kim@samsung.com>,
	Chao Yu <chao.yu@oppo.com>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 258/317] f2fs: fix to invalidate META_MAPPING before DIO write
Date: Sun, 24 Mar 2024 19:33:58 -0400
Message-ID: <20240324233458.1352854-259-sashal@kernel.org>
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

[ Upstream commit 67ca06872eb02944b4c6f92cffa9242e92c63109 ]

Quoted from commit e3b49ea36802 ("f2fs: invalidate META_MAPPING before
IPU/DIO write")

"
Encrypted pages during GC are read and cached in META_MAPPING.
However, due to cached pages in META_MAPPING, there is an issue where
newly written pages are lost by IPU or DIO writes.

Thread A - f2fs_gc()            Thread B
/* phase 3 */
down_write(i_gc_rwsem)
ra_data_block()       ---- (a)
up_write(i_gc_rwsem)
                                f2fs_direct_IO() :
                                 - down_read(i_gc_rwsem)
                                 - __blockdev_direct_io()
                                 - get_data_block_dio_write()
                                 - f2fs_dio_submit_bio()  ---- (b)
                                 - up_read(i_gc_rwsem)
/* phase 4 */
down_write(i_gc_rwsem)
move_data_block()     ---- (c)
up_write(i_gc_rwsem)

(a) In phase 3 of f2fs_gc(), up-to-date page is read from storage and
    cached in META_MAPPING.
(b) In thread B, writing new data by IPU or DIO write on same blkaddr as
    read in (a). cached page in META_MAPPING become out-dated.
(c) In phase 4 of f2fs_gc(), out-dated page in META_MAPPING is copied to
    new blkaddr. In conclusion, the newly written data in (b) is lost.

To address this issue, invalidating pages in META_MAPPING before IPU or
DIO write.
"

In previous commit, we missed to cover extent cache hit case, and passed
wrong value for parameter @end of invalidate_mapping_pages(), fix both
issues.

Fixes: 6aa58d8ad20a ("f2fs: readahead encrypted block during GC")
Fixes: e3b49ea36802 ("f2fs: invalidate META_MAPPING before IPU/DIO write")
Cc: Hyeong-Jun Kim <hj514.kim@samsung.com>
Signed-off-by: Chao Yu <chao.yu@oppo.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Stable-dep-of: fd244524c2cf ("f2fs: compress: fix to cover normal cluster write with cp_rwsem")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/data.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 19b595488a27b..222af7d5f91b7 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1496,9 +1496,12 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
 			*map->m_next_extent = pgofs + map->m_len;
 
 		/* for hardware encryption, but to avoid potential issue in future */
-		if (flag == F2FS_GET_BLOCK_DIO)
+		if (flag == F2FS_GET_BLOCK_DIO) {
 			f2fs_wait_on_block_writeback_range(inode,
 						map->m_pblk, map->m_len);
+			invalidate_mapping_pages(META_MAPPING(sbi),
+				map->m_pblk, map->m_pblk + map->m_len - 1);
+		}
 
 		if (map->m_multidev_dio) {
 			block_t blk_addr = map->m_pblk;
@@ -1712,7 +1715,7 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
 		f2fs_wait_on_block_writeback_range(inode,
 						map->m_pblk, map->m_len);
 		invalidate_mapping_pages(META_MAPPING(sbi),
-						map->m_pblk, map->m_pblk);
+				map->m_pblk, map->m_pblk + map->m_len - 1);
 
 		if (map->m_multidev_dio) {
 			block_t blk_addr = map->m_pblk;
-- 
2.43.0


