Return-Path: <linux-kernel+bounces-116088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B093889D74
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:44:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64003B290E2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB74B28CC88;
	Mon, 25 Mar 2024 03:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hOc3OLQe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F22F1782FC;
	Sun, 24 Mar 2024 23:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323549; cv=none; b=VWZoz2oEHGUk6Yjz7UE6DxISwv75BMMcRO6A96NO+QhcBAaXPg9/m766+mUnW8LC/I1z5IipZR6SoiX746184HKVzbqUOLeuG7f74MIyzYojVh49GE17EZRKIjKWBWwh0GKCx91FTVGOqmRX8i9kFoAfFznoZRDAjXYZHJRBth0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323549; c=relaxed/simple;
	bh=8/0jLhDjPtorYrmIR3Yy6n8JS/uhDpyE+yyZiYhj6VQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nX6gTaWFNRjIWTBOP/IMlgqW3F4novTwhR49kgfelgHL62l3afcavOU/5vPu7Bqw2139gp/aYrN4w9t3EC1McTDNNlWsn7rDz4hKcZqJBHY51LIIZaG+CUkNZt7/9UFRE06A7ew2dbmTfTbL2+w3KtQbDNAqbGz48AhWWwDwZLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hOc3OLQe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E4C1C433A6;
	Sun, 24 Mar 2024 23:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323547;
	bh=8/0jLhDjPtorYrmIR3Yy6n8JS/uhDpyE+yyZiYhj6VQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hOc3OLQeoVcJocon90MIZKPsgGvZ7iO6EsktDwe0WAaStGoP8/CRtbMKKZINigzi1
	 fEmyHkg2GDTT+DnC7mkZWU34urRlN6Dg2M2iGGPSMERKTBqf6rL/FlmckwhsGKtM74
	 eKTRznswtNcvFhfKQjPrllKT1pATmIj0BoFkTW6O06WA9Lj8VmDA7usCBNvZ5BisGw
	 LJde8LWdq3oMvSqMPFif3ewl3N07si1uhfSVBR8c0U+uT4IzUF+manUKaOZvZq/q8d
	 1z8bYPe7t+7hJNj111q1BwFJkLcqUqFivtq/GZcyV+hoA7/hCcM5ZmUjcGC5rjNkKo
	 tXGFR2SDzwqtw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hyeong-Jun Kim <hj514.kim@samsung.com>,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 256/317] f2fs: invalidate META_MAPPING before IPU/DIO write
Date: Sun, 24 Mar 2024 19:33:56 -0400
Message-ID: <20240324233458.1352854-257-sashal@kernel.org>
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

From: Hyeong-Jun Kim <hj514.kim@samsung.com>

[ Upstream commit e3b49ea36802053f312013fd4ccb6e59920a9f76 ]

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

Fixes: 6aa58d8ad20a ("f2fs: readahead encrypted block during GC")
Signed-off-by: Hyeong-Jun Kim <hj514.kim@samsung.com>
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Stable-dep-of: fd244524c2cf ("f2fs: compress: fix to cover normal cluster write with cp_rwsem")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/data.c    | 2 ++
 fs/f2fs/segment.c | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index e005f97fd273e..25dafd1261d71 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1711,6 +1711,8 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
 		 */
 		f2fs_wait_on_block_writeback_range(inode,
 						map->m_pblk, map->m_len);
+		invalidate_mapping_pages(META_MAPPING(sbi),
+						map->m_pblk, map->m_pblk);
 
 		if (map->m_multidev_dio) {
 			block_t blk_addr = map->m_pblk;
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 25d53617a50e6..5eca50e50e16b 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -3622,6 +3622,9 @@ int f2fs_inplace_write_data(struct f2fs_io_info *fio)
 		goto drop_bio;
 	}
 
+	invalidate_mapping_pages(META_MAPPING(sbi),
+				fio->new_blkaddr, fio->new_blkaddr);
+
 	stat_inc_inplace_blocks(fio->sbi);
 
 	if (fio->bio && !(SM_I(sbi)->ipu_policy & (1 << F2FS_IPU_NOCACHE)))
-- 
2.43.0


