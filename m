Return-Path: <linux-kernel+bounces-114892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38873889207
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:56:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA674285FC1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C67BA1BD03D;
	Mon, 25 Mar 2024 00:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JFje+3Ny"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9F727CBFA;
	Sun, 24 Mar 2024 23:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323548; cv=none; b=W/0MtnPdzT3e3H/whKjQJQC8J0M4EnE3gHXwEfmWqMifHUqOEpPabTAum8PMWs/oNLZfcCILFO24pvfWhE2aK2M9/Auhl+gL0F0s5rhUWyyw+H3GIapE1z8m4fMG3/oX1wTHGKom0LSpucP+TWwZQQc1sJ5JTGE5ncC3tbY5OEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323548; c=relaxed/simple;
	bh=+AcsBaoLxVGI1t3c7qV6EmV93CHa8arYmEj6shoLuck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A2QELzeIvhMDuImEL0v/TG9I26HHVb0YaT3tkmIl1hBuDXlMhiOEhiNWbqchGMnRUHTKUADObx2GjajYUriz/tPXmJsCOn4D6Q2FZKKFt9NqHgE9yk7B9+Aa/CLol/zyVu2JaUptNoKL6L5YkT3iIxizc5SFE+pH05VCo3BC/VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JFje+3Ny; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42D5AC43394;
	Sun, 24 Mar 2024 23:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323546;
	bh=+AcsBaoLxVGI1t3c7qV6EmV93CHa8arYmEj6shoLuck=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JFje+3NypJnbx09IJChJ0kgKjfo8w/s1ifEGz4/0HR7bqkpO4XhKrtPXM7dmAaHUJ
	 Ji/AOCmq9JQI0F9ppbbmQr1Al/xfWt02YThYNKMFZ/UAjNOuUI3nrpOIVoT2Efeazs
	 q0Ot1F+W/hTVi4v3reKz6V4MdGOI2y1jeIYl3ZUOs9XATB4KKlSX0XAet8Oksd8SdF
	 L2XzbEx1icJ4X3Psn4vbksHkshzN03XT8Kh9l8bGVXFoSN2WNf4WCfnoCKJ18NpXbF
	 /iWgTJ3L6gYHxrPYawS/VpIXjRXRZPLl8HqYOIT3vOU8SwBAyS+6i6cLSD1gRGUZuw
	 Fy6D0DqEXEPWA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 255/317] f2fs: multidevice: support direct IO
Date: Sun, 24 Mar 2024 19:33:55 -0400
Message-ID: <20240324233458.1352854-256-sashal@kernel.org>
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

[ Upstream commit 71f2c8206202584c644eef5ca7efe91fc8305c1f ]

Commit 3c62be17d4f5 ("f2fs: support multiple devices") missed
to support direct IO for multiple device feature, this patch
adds to support the missing part of multidevice feature.

In addition, for multiple device image, we should be aware of
any issued direct write IO rather than just buffered write IO,
so that fsync and syncfs can issue a preflush command to the
device where direct write IO goes, to persist user data for
posix compliant.

Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Stable-dep-of: fd244524c2cf ("f2fs: compress: fix to cover normal cluster write with cp_rwsem")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/data.c              | 57 +++++++++++++++++++++++++++++++++++--
 fs/f2fs/f2fs.h              | 25 ++++++++++++++--
 fs/f2fs/segment.c           | 35 ++++++++++++++---------
 fs/f2fs/super.c             |  7 +++++
 include/trace/events/f2fs.h | 21 ++++++++++----
 5 files changed, 120 insertions(+), 25 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 5766a9f0773b1..e005f97fd273e 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1468,10 +1468,15 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
 	struct extent_info ei = {0, };
 	block_t blkaddr;
 	unsigned int start_pgofs;
+	int bidx = 0;
 
 	if (!maxblocks)
 		return 0;
 
+	map->m_bdev = inode->i_sb->s_bdev;
+	map->m_multidev_dio =
+		f2fs_allow_multi_device_dio(F2FS_I_SB(inode), flag);
+
 	map->m_len = 0;
 	map->m_flags = 0;
 
@@ -1494,6 +1499,21 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
 		if (flag == F2FS_GET_BLOCK_DIO)
 			f2fs_wait_on_block_writeback_range(inode,
 						map->m_pblk, map->m_len);
+
+		if (map->m_multidev_dio) {
+			block_t blk_addr = map->m_pblk;
+
+			bidx = f2fs_target_device_index(sbi, map->m_pblk);
+
+			map->m_bdev = FDEV(bidx).bdev;
+			map->m_pblk -= FDEV(bidx).start_blk;
+			map->m_len = min(map->m_len,
+				FDEV(bidx).end_blk + 1 - map->m_pblk);
+
+			if (map->m_may_create)
+				f2fs_update_device_state(sbi, inode->i_ino,
+							blk_addr, map->m_len);
+		}
 		goto out;
 	}
 
@@ -1612,6 +1632,9 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
 	if (flag == F2FS_GET_BLOCK_PRE_AIO)
 		goto skip;
 
+	if (map->m_multidev_dio)
+		bidx = f2fs_target_device_index(sbi, blkaddr);
+
 	if (map->m_len == 0) {
 		/* preallocated unwritten block should be mapped for fiemap. */
 		if (blkaddr == NEW_ADDR)
@@ -1620,10 +1643,15 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
 
 		map->m_pblk = blkaddr;
 		map->m_len = 1;
+
+		if (map->m_multidev_dio)
+			map->m_bdev = FDEV(bidx).bdev;
 	} else if ((map->m_pblk != NEW_ADDR &&
 			blkaddr == (map->m_pblk + ofs)) ||
 			(map->m_pblk == NEW_ADDR && blkaddr == NEW_ADDR) ||
 			flag == F2FS_GET_BLOCK_PRE_DIO) {
+		if (map->m_multidev_dio && map->m_bdev != FDEV(bidx).bdev)
+			goto sync_out;
 		ofs++;
 		map->m_len++;
 	} else {
@@ -1676,11 +1704,31 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
 
 sync_out:
 
-	/* for hardware encryption, but to avoid potential issue in future */
-	if (flag == F2FS_GET_BLOCK_DIO && map->m_flags & F2FS_MAP_MAPPED)
+	if (flag == F2FS_GET_BLOCK_DIO && map->m_flags & F2FS_MAP_MAPPED) {
+		/*
+		 * for hardware encryption, but to avoid potential issue
+		 * in future
+		 */
 		f2fs_wait_on_block_writeback_range(inode,
 						map->m_pblk, map->m_len);
 
+		if (map->m_multidev_dio) {
+			block_t blk_addr = map->m_pblk;
+
+			bidx = f2fs_target_device_index(sbi, map->m_pblk);
+
+			map->m_bdev = FDEV(bidx).bdev;
+			map->m_pblk -= FDEV(bidx).start_blk;
+
+			if (map->m_may_create)
+				f2fs_update_device_state(sbi, inode->i_ino,
+							blk_addr, map->m_len);
+
+			f2fs_bug_on(sbi, blk_addr + map->m_len >
+						FDEV(bidx).end_blk + 1);
+		}
+	}
+
 	if (flag == F2FS_GET_BLOCK_PRECACHE) {
 		if (map->m_flags & F2FS_MAP_MAPPED) {
 			unsigned int ofs = start_pgofs - map->m_lblk;
@@ -1699,7 +1747,7 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
 		f2fs_balance_fs(sbi, dn.node_changed);
 	}
 out:
-	trace_f2fs_map_blocks(inode, map, err);
+	trace_f2fs_map_blocks(inode, map, create, flag, err);
 	return err;
 }
 
@@ -1758,6 +1806,9 @@ static int __get_data_block(struct inode *inode, sector_t iblock,
 		map_bh(bh, inode->i_sb, map.m_pblk);
 		bh->b_state = (bh->b_state & ~F2FS_MAP_FLAGS) | map.m_flags;
 		bh->b_size = blks_to_bytes(inode, map.m_len);
+
+		if (map.m_multidev_dio)
+			bh->b_bdev = map.m_bdev;
 	}
 	return err;
 }
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 4cabc37c20b90..e326e7efea391 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -622,6 +622,7 @@ struct extent_tree {
 				F2FS_MAP_UNWRITTEN)
 
 struct f2fs_map_blocks {
+	struct block_device *m_bdev;	/* for multi-device dio */
 	block_t m_pblk;
 	block_t m_lblk;
 	unsigned int m_len;
@@ -630,6 +631,7 @@ struct f2fs_map_blocks {
 	pgoff_t *m_next_extent;		/* point to next possible extent */
 	int m_seg_type;
 	bool m_may_create;		/* indicate it is from write path */
+	bool m_multidev_dio;		/* indicate it allows multi-device dio */
 };
 
 /* for flag in get_data_block */
@@ -1736,12 +1738,15 @@ struct f2fs_sb_info {
 
 	/* For shrinker support */
 	struct list_head s_list;
+	struct mutex umount_mutex;
+	unsigned int shrinker_run_no;
+
+	/* For multi devices */
 	int s_ndevs;				/* number of devices */
 	struct f2fs_dev_info *devs;		/* for device list */
 	unsigned int dirty_device;		/* for checkpoint data flush */
 	spinlock_t dev_lock;			/* protect dirty_device */
-	struct mutex umount_mutex;
-	unsigned int shrinker_run_no;
+	bool aligned_blksize;			/* all devices has the same logical blksize */
 
 	/* For write statistics */
 	u64 sectors_written_start;
@@ -3517,6 +3522,8 @@ void f2fs_allocate_data_block(struct f2fs_sb_info *sbi, struct page *page,
 			block_t old_blkaddr, block_t *new_blkaddr,
 			struct f2fs_summary *sum, int type,
 			struct f2fs_io_info *fio);
+void f2fs_update_device_state(struct f2fs_sb_info *sbi, nid_t ino,
+					block_t blkaddr, unsigned int blkcnt);
 void f2fs_wait_on_page_writeback(struct page *page,
 			enum page_type type, bool ordered, bool locked);
 void f2fs_wait_on_block_writeback(struct inode *inode, block_t blkaddr);
@@ -4335,6 +4342,16 @@ static inline int block_unaligned_IO(struct inode *inode,
 	return align & blocksize_mask;
 }
 
+static inline bool f2fs_allow_multi_device_dio(struct f2fs_sb_info *sbi,
+								int flag)
+{
+	if (!f2fs_is_multi_device(sbi))
+		return false;
+	if (flag != F2FS_GET_BLOCK_DIO)
+		return false;
+	return sbi->aligned_blksize;
+}
+
 static inline bool f2fs_force_buffered_io(struct inode *inode,
 				struct kiocb *iocb, struct iov_iter *iter)
 {
@@ -4343,7 +4360,9 @@ static inline bool f2fs_force_buffered_io(struct inode *inode,
 
 	if (f2fs_post_read_required(inode))
 		return true;
-	if (f2fs_is_multi_device(sbi))
+
+	/* disallow direct IO if any of devices has unaligned blksize */
+	if (f2fs_is_multi_device(sbi) && !sbi->aligned_blksize)
 		return true;
 	/*
 	 * for blkzoned device, fallback direct IO to buffered IO, so
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 79ad696cddec0..25d53617a50e6 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -3490,24 +3490,30 @@ void f2fs_allocate_data_block(struct f2fs_sb_info *sbi, struct page *page,
 	up_read(&SM_I(sbi)->curseg_lock);
 }
 
-static void update_device_state(struct f2fs_io_info *fio)
+void f2fs_update_device_state(struct f2fs_sb_info *sbi, nid_t ino,
+					block_t blkaddr, unsigned int blkcnt)
 {
-	struct f2fs_sb_info *sbi = fio->sbi;
-	unsigned int devidx;
-
 	if (!f2fs_is_multi_device(sbi))
 		return;
 
-	devidx = f2fs_target_device_index(sbi, fio->new_blkaddr);
+	while (1) {
+		unsigned int devidx = f2fs_target_device_index(sbi, blkaddr);
+		unsigned int blks = FDEV(devidx).end_blk - blkaddr + 1;
 
-	/* update device state for fsync */
-	f2fs_set_dirty_device(sbi, fio->ino, devidx, FLUSH_INO);
+		/* update device state for fsync */
+		f2fs_set_dirty_device(sbi, ino, devidx, FLUSH_INO);
 
-	/* update device state for checkpoint */
-	if (!f2fs_test_bit(devidx, (char *)&sbi->dirty_device)) {
-		spin_lock(&sbi->dev_lock);
-		f2fs_set_bit(devidx, (char *)&sbi->dirty_device);
-		spin_unlock(&sbi->dev_lock);
+		/* update device state for checkpoint */
+		if (!f2fs_test_bit(devidx, (char *)&sbi->dirty_device)) {
+			spin_lock(&sbi->dev_lock);
+			f2fs_set_bit(devidx, (char *)&sbi->dirty_device);
+			spin_unlock(&sbi->dev_lock);
+		}
+
+		if (blkcnt <= blks)
+			break;
+		blkcnt -= blks;
+		blkaddr += blks;
 	}
 }
 
@@ -3534,7 +3540,7 @@ static void do_write_page(struct f2fs_summary *sum, struct f2fs_io_info *fio)
 		goto reallocate;
 	}
 
-	update_device_state(fio);
+	f2fs_update_device_state(fio->sbi, fio->ino, fio->new_blkaddr, 1);
 
 	if (keep_order)
 		up_read(&fio->sbi->io_order_lock);
@@ -3623,7 +3629,8 @@ int f2fs_inplace_write_data(struct f2fs_io_info *fio)
 	else
 		err = f2fs_submit_page_bio(fio);
 	if (!err) {
-		update_device_state(fio);
+		f2fs_update_device_state(fio->sbi, fio->ino,
+						fio->new_blkaddr, 1);
 		f2fs_update_iostat(fio->sbi, fio->io_type, F2FS_BLKSIZE);
 	}
 
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index d4a76c2deb806..5160bf4f4a3ec 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -3831,6 +3831,7 @@ static int f2fs_scan_devices(struct f2fs_sb_info *sbi)
 {
 	struct f2fs_super_block *raw_super = F2FS_RAW_SUPER(sbi);
 	unsigned int max_devices = MAX_DEVICES;
+	unsigned int logical_blksize;
 	int i;
 
 	/* Initialize single device information */
@@ -3851,6 +3852,9 @@ static int f2fs_scan_devices(struct f2fs_sb_info *sbi)
 	if (!sbi->devs)
 		return -ENOMEM;
 
+	logical_blksize = bdev_logical_block_size(sbi->sb->s_bdev);
+	sbi->aligned_blksize = true;
+
 	for (i = 0; i < max_devices; i++) {
 
 		if (i > 0 && !RDEV(i).path[0])
@@ -3887,6 +3891,9 @@ static int f2fs_scan_devices(struct f2fs_sb_info *sbi)
 		/* to release errored devices */
 		sbi->s_ndevs = i + 1;
 
+		if (logical_blksize != bdev_logical_block_size(FDEV(i).bdev))
+			sbi->aligned_blksize = false;
+
 #ifdef CONFIG_BLK_DEV_ZONED
 		if (bdev_zoned_model(FDEV(i).bdev) == BLK_ZONED_HM &&
 				!f2fs_sb_has_blkzoned(sbi)) {
diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
index 6033eaddcb749..8670adaa23f91 100644
--- a/include/trace/events/f2fs.h
+++ b/include/trace/events/f2fs.h
@@ -570,9 +570,10 @@ TRACE_EVENT(f2fs_file_write_iter,
 );
 
 TRACE_EVENT(f2fs_map_blocks,
-	TP_PROTO(struct inode *inode, struct f2fs_map_blocks *map, int ret),
+	TP_PROTO(struct inode *inode, struct f2fs_map_blocks *map,
+				int create, int flag, int ret),
 
-	TP_ARGS(inode, map, ret),
+	TP_ARGS(inode, map, create, flag, ret),
 
 	TP_STRUCT__entry(
 		__field(dev_t,	dev)
@@ -583,11 +584,14 @@ TRACE_EVENT(f2fs_map_blocks,
 		__field(unsigned int,	m_flags)
 		__field(int,	m_seg_type)
 		__field(bool,	m_may_create)
+		__field(bool,	m_multidev_dio)
+		__field(int,	create)
+		__field(int,	flag)
 		__field(int,	ret)
 	),
 
 	TP_fast_assign(
-		__entry->dev		= inode->i_sb->s_dev;
+		__entry->dev		= map->m_bdev->bd_dev;
 		__entry->ino		= inode->i_ino;
 		__entry->m_lblk		= map->m_lblk;
 		__entry->m_pblk		= map->m_pblk;
@@ -595,12 +599,16 @@ TRACE_EVENT(f2fs_map_blocks,
 		__entry->m_flags	= map->m_flags;
 		__entry->m_seg_type	= map->m_seg_type;
 		__entry->m_may_create	= map->m_may_create;
+		__entry->m_multidev_dio	= map->m_multidev_dio;
+		__entry->create		= create;
+		__entry->flag		= flag;
 		__entry->ret		= ret;
 	),
 
 	TP_printk("dev = (%d,%d), ino = %lu, file offset = %llu, "
-		"start blkaddr = 0x%llx, len = 0x%llx, flags = %u,"
-		"seg_type = %d, may_create = %d, err = %d",
+		"start blkaddr = 0x%llx, len = 0x%llx, flags = %u, "
+		"seg_type = %d, may_create = %d, multidevice = %d, "
+		"create = %d, flag = %d, err = %d",
 		show_dev_ino(__entry),
 		(unsigned long long)__entry->m_lblk,
 		(unsigned long long)__entry->m_pblk,
@@ -608,6 +616,9 @@ TRACE_EVENT(f2fs_map_blocks,
 		__entry->m_flags,
 		__entry->m_seg_type,
 		__entry->m_may_create,
+		__entry->m_multidev_dio,
+		__entry->create,
+		__entry->flag,
 		__entry->ret)
 );
 
-- 
2.43.0


