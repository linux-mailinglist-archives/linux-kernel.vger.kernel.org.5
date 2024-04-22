Return-Path: <linux-kernel+bounces-152787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FAD58AC433
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 08:29:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAF801F21539
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 06:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34C85405EB;
	Mon, 22 Apr 2024 06:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AgsuSRaa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 168E23FB1E
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 06:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713767362; cv=none; b=uzE/vrf6W5jj6NY3W5sLAp63o3TACnfGECnYrP0v2DTruBYgmN8joPOjalYBirCoiNn12m8YhIquJ/eCu6ynJcfToSdmmPePXTu780XhFLAxaTdfr/lE4Vad2KxldWr8k2wlj/ZRFfxPSfEZnL1mTRUQxRRsEDudsYwtzx5PLOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713767362; c=relaxed/simple;
	bh=LCIIPIFf23sbYCB3f/82w9xqSY7YR4k+GO2xT5qhe9A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RIIPTKmV4lwKbO4H/SDoseRA9CSO9aAXA5g2/17j4z+Ns7xRq6OxbmQvYKOUiPImZiLsSsSa9VZU8aaksQ6npZ/iHCvuzyvZHSwL4/dBXcpanJ7hUhc1KkgSSU7CfYwICcCEx3yJaBHWWqXXL+fWND8JCIK5L+H4qSQYDt9bgV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AgsuSRaa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 145F8C113CC;
	Mon, 22 Apr 2024 06:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713767361;
	bh=LCIIPIFf23sbYCB3f/82w9xqSY7YR4k+GO2xT5qhe9A=;
	h=From:To:Cc:Subject:Date:From;
	b=AgsuSRaa3toLEXAU8iNHAtTGdPj9HY1adFlIhe7N9g368a2q4UAxzk0MAPMRM+q3k
	 VoxGOUuv7YI6q6WFfPuvzTR71YeohHsNIfs/tzY2EEYb6fCzjUiWhNt+xyNjmhLOov
	 PBm1iUsDgdLVaNVyoRwDt+V9wodtPJRrVRLbZr9shv1x7oOeTNQAQjZrWAsgK+7KEJ
	 UWB+VbgprsXtaoPEoIAeq936141feNoIF90sGE+n0em8ylqMk60QMlbYhHsxtsZf51
	 DaLo+r/oSzdTEhidSrU+q32+983xfo4PQq8D8ae4i63EqmA7Wpu7OgxE6ujlOvXSdO
	 WBgrKUlttBidg==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>,
	Daeho Jeong <daeho43@gmail.com>,
	Daeho Jeong <daehojeong@google.com>
Subject: [PATCH v5] f2fs: zone: don't block IO if there is remained open zone
Date: Mon, 22 Apr 2024 14:29:02 +0800
Message-Id: <20240422062902.2423227-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

max open zone may be larger than log header number of f2fs, for
such case, it doesn't need to wait last IO in previous zone, let's
introduce available_open_zone semaphore, and reduce it once we
submit first write IO in a zone, and increase it after completion
of last IO in the zone.

Cc: Daeho Jeong <daeho43@gmail.com>
Signed-off-by: Chao Yu <chao@kernel.org>
Reviewed-by: Daeho Jeong <daehojeong@google.com>
---
v5:
- fix `openned` typo pointed out by Juhyung Park
 fs/f2fs/data.c    | 105 ++++++++++++++++++++++++++++++----------------
 fs/f2fs/f2fs.h    |  31 +++++++++++---
 fs/f2fs/iostat.c  |   7 ++++
 fs/f2fs/iostat.h  |   2 +
 fs/f2fs/segment.c |  37 +++++++++++++++-
 fs/f2fs/segment.h |   3 +-
 fs/f2fs/super.c   |   2 +
 7 files changed, 143 insertions(+), 44 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index d01345af5f3e..657579358498 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -373,11 +373,10 @@ static void f2fs_write_end_io(struct bio *bio)
 #ifdef CONFIG_BLK_DEV_ZONED
 static void f2fs_zone_write_end_io(struct bio *bio)
 {
-	struct f2fs_bio_info *io = (struct f2fs_bio_info *)bio->bi_private;
+	struct f2fs_sb_info *sbi = iostat_get_bio_private(bio);
 
-	bio->bi_private = io->bi_private;
-	complete(&io->zone_wait);
 	f2fs_write_end_io(bio);
+	up(&sbi->available_open_zones);
 }
 #endif
 
@@ -533,6 +532,24 @@ static void __submit_merged_bio(struct f2fs_bio_info *io)
 	if (!io->bio)
 		return;
 
+#ifdef CONFIG_BLK_DEV_ZONED
+	if (io->open_zone) {
+		/*
+		 * if there is no open zone, it will wait for last IO in
+		 * previous zone before submitting new IO.
+		 */
+		down(&fio->sbi->available_open_zones);
+		io->open_zone = false;
+		io->zone_opened = true;
+	}
+
+	if (io->close_zone) {
+		io->bio->bi_end_io = f2fs_zone_write_end_io;
+		io->zone_opened = false;
+		io->close_zone = false;
+	}
+#endif
+
 	if (is_read_io(fio->op)) {
 		trace_f2fs_prepare_read_bio(io->sbi->sb, fio->type, io->bio);
 		f2fs_submit_read_bio(io->sbi, io->bio, fio->type);
@@ -603,9 +620,9 @@ int f2fs_init_write_merge_io(struct f2fs_sb_info *sbi)
 			INIT_LIST_HEAD(&sbi->write_io[i][j].bio_list);
 			init_f2fs_rwsem(&sbi->write_io[i][j].bio_list_lock);
 #ifdef CONFIG_BLK_DEV_ZONED
-			init_completion(&sbi->write_io[i][j].zone_wait);
-			sbi->write_io[i][j].zone_pending_bio = NULL;
-			sbi->write_io[i][j].bi_private = NULL;
+			sbi->write_io[i][j].open_zone = false;
+			sbi->write_io[i][j].zone_opened = false;
+			sbi->write_io[i][j].close_zone = false;
 #endif
 		}
 	}
@@ -636,6 +653,31 @@ static void __f2fs_submit_merged_write(struct f2fs_sb_info *sbi,
 	f2fs_up_write(&io->io_rwsem);
 }
 
+void f2fs_blkzoned_submit_merged_write(struct f2fs_sb_info *sbi, int type)
+{
+#ifdef CONFIG_BLK_DEV_ZONED
+	struct f2fs_bio_info *io;
+
+	if (!f2fs_sb_has_blkzoned(sbi))
+		return;
+
+	io = sbi->write_io[PAGE_TYPE(type)] + type_to_temp(type);
+
+	f2fs_down_write(&io->io_rwsem);
+	if (io->zone_opened) {
+		if (io->bio) {
+			io->close_zone = true;
+			__submit_merged_bio(io);
+		} else {
+			up(&sbi->available_open_zones);
+			io->zone_opened = false;
+		}
+	}
+	f2fs_up_write(&io->io_rwsem);
+#endif
+
+}
+
 static void __submit_merged_write_cond(struct f2fs_sb_info *sbi,
 				struct inode *inode, struct page *page,
 				nid_t ino, enum page_type type, bool force)
@@ -920,22 +962,16 @@ int f2fs_merge_page_bio(struct f2fs_io_info *fio)
 }
 
 #ifdef CONFIG_BLK_DEV_ZONED
-static bool is_end_zone_blkaddr(struct f2fs_sb_info *sbi, block_t blkaddr)
+static bool is_blkaddr_zone_boundary(struct f2fs_sb_info *sbi,
+					block_t blkaddr, bool start)
 {
-	int devi = 0;
+	if (!f2fs_blkaddr_in_seqzone(sbi, blkaddr))
+		return false;
+
+	if (start)
+		return (blkaddr % sbi->blocks_per_blkz) == 0;
+	return (blkaddr % sbi->blocks_per_blkz == sbi->blocks_per_blkz - 1);
 
-	if (f2fs_is_multi_device(sbi)) {
-		devi = f2fs_target_device_index(sbi, blkaddr);
-		if (blkaddr < FDEV(devi).start_blk ||
-		    blkaddr > FDEV(devi).end_blk) {
-			f2fs_err(sbi, "Invalid block %x", blkaddr);
-			return false;
-		}
-		blkaddr -= FDEV(devi).start_blk;
-	}
-	return bdev_is_zoned(FDEV(devi).bdev) &&
-		f2fs_blkz_is_seq(sbi, devi, blkaddr) &&
-		(blkaddr % sbi->blocks_per_blkz == sbi->blocks_per_blkz - 1);
 }
 #endif
 
@@ -946,20 +982,14 @@ void f2fs_submit_page_write(struct f2fs_io_info *fio)
 	struct f2fs_bio_info *io = sbi->write_io[btype] + fio->temp;
 	struct page *bio_page;
 	enum count_type type;
+#ifdef CONFIG_BLK_DEV_ZONED
+	bool blkzoned = f2fs_sb_has_blkzoned(sbi) && btype < META;
+#endif
 
 	f2fs_bug_on(sbi, is_read_io(fio->op));
 
 	f2fs_down_write(&io->io_rwsem);
 next:
-#ifdef CONFIG_BLK_DEV_ZONED
-	if (f2fs_sb_has_blkzoned(sbi) && btype < META && io->zone_pending_bio) {
-		wait_for_completion_io(&io->zone_wait);
-		bio_put(io->zone_pending_bio);
-		io->zone_pending_bio = NULL;
-		io->bi_private = NULL;
-	}
-#endif
-
 	if (fio->in_list) {
 		spin_lock(&io->io_lock);
 		if (list_empty(&io->io_list)) {
@@ -987,6 +1017,11 @@ void f2fs_submit_page_write(struct f2fs_io_info *fio)
 	type = WB_DATA_TYPE(bio_page, fio->compressed_page);
 	inc_page_count(sbi, type);
 
+#ifdef CONFIG_BLK_DEV_ZONED
+	if (blkzoned && is_blkaddr_zone_boundary(sbi, fio->new_blkaddr, true))
+		io->open_zone = true;
+#endif
+
 	if (io->bio &&
 	    (!io_is_mergeable(sbi, io->bio, io, fio, io->last_block_in_bio,
 			      fio->new_blkaddr) ||
@@ -1012,15 +1047,11 @@ void f2fs_submit_page_write(struct f2fs_io_info *fio)
 	io->last_block_in_bio = fio->new_blkaddr;
 
 	trace_f2fs_submit_page_write(fio->page, fio);
+
 #ifdef CONFIG_BLK_DEV_ZONED
-	if (f2fs_sb_has_blkzoned(sbi) && btype < META &&
-			is_end_zone_blkaddr(sbi, fio->new_blkaddr)) {
-		bio_get(io->bio);
-		reinit_completion(&io->zone_wait);
-		io->bi_private = io->bio->bi_private;
-		io->bio->bi_private = io;
-		io->bio->bi_end_io = f2fs_zone_write_end_io;
-		io->zone_pending_bio = io->bio;
+	if (blkzoned &&
+		is_blkaddr_zone_boundary(sbi, fio->new_blkaddr, false)) {
+		io->close_zone = true;
 		__submit_merged_bio(io);
 	}
 #endif
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index a0ae99bcca39..120b4002f7ca 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1232,16 +1232,16 @@ struct f2fs_bio_info {
 	struct bio *bio;		/* bios to merge */
 	sector_t last_block_in_bio;	/* last block number */
 	struct f2fs_io_info fio;	/* store buffered io info. */
-#ifdef CONFIG_BLK_DEV_ZONED
-	struct completion zone_wait;	/* condition value for the previous open zone to close */
-	struct bio *zone_pending_bio;	/* pending bio for the previous zone */
-	void *bi_private;		/* previous bi_private for pending bio */
-#endif
 	struct f2fs_rwsem io_rwsem;	/* blocking op for bio */
 	spinlock_t io_lock;		/* serialize DATA/NODE IOs */
 	struct list_head io_list;	/* track fios */
 	struct list_head bio_list;	/* bio entry list head */
 	struct f2fs_rwsem bio_list_lock;	/* lock to protect bio entry list */
+#ifdef CONFIG_BLK_DEV_ZONED
+	bool open_zone;			/* open a zone */
+	bool zone_opened;		/* zone has been opened */
+	bool close_zone;		/* close a zone */
+#endif
 };
 
 #define FDEV(i)				(sbi->devs[i])
@@ -1558,6 +1558,7 @@ struct f2fs_sb_info {
 #ifdef CONFIG_BLK_DEV_ZONED
 	unsigned int blocks_per_blkz;		/* F2FS blocks per zone */
 	unsigned int max_open_zones;		/* max open zone resources of the zoned device */
+	struct semaphore available_open_zones;	/* available open zones */
 #endif
 
 	/* for node-related operations */
@@ -3823,6 +3824,7 @@ void f2fs_destroy_bio_entry_cache(void);
 void f2fs_submit_read_bio(struct f2fs_sb_info *sbi, struct bio *bio,
 			  enum page_type type);
 int f2fs_init_write_merge_io(struct f2fs_sb_info *sbi);
+void f2fs_blkzoned_submit_merged_write(struct f2fs_sb_info *sbi, int type);
 void f2fs_submit_merged_write(struct f2fs_sb_info *sbi, enum page_type type);
 void f2fs_submit_merged_write_cond(struct f2fs_sb_info *sbi,
 				struct inode *inode, struct page *page,
@@ -4470,6 +4472,25 @@ static inline bool f2fs_blkz_is_seq(struct f2fs_sb_info *sbi, int devi,
 
 	return test_bit(zno, FDEV(devi).blkz_seq);
 }
+
+static inline bool f2fs_blkaddr_in_seqzone(struct f2fs_sb_info *sbi,
+							block_t blkaddr)
+{
+	int devi = 0;
+
+	if (f2fs_is_multi_device(sbi)) {
+		devi = f2fs_target_device_index(sbi, blkaddr);
+		if (blkaddr < FDEV(devi).start_blk ||
+		    blkaddr > FDEV(devi).end_blk) {
+			f2fs_err(sbi, "Invalid block %x", blkaddr);
+			return false;
+		}
+		blkaddr -= FDEV(devi).start_blk;
+	}
+
+	return bdev_is_zoned(FDEV(devi).bdev) &&
+		f2fs_blkz_is_seq(sbi, devi, blkaddr);
+}
 #endif
 
 static inline int f2fs_bdev_index(struct f2fs_sb_info *sbi,
diff --git a/fs/f2fs/iostat.c b/fs/f2fs/iostat.c
index f8703038e1d8..a8626e297876 100644
--- a/fs/f2fs/iostat.c
+++ b/fs/f2fs/iostat.c
@@ -237,6 +237,13 @@ static inline void __update_iostat_latency(struct bio_iostat_ctx *iostat_ctx,
 	spin_unlock_irqrestore(&sbi->iostat_lat_lock, flags);
 }
 
+void *iostat_get_bio_private(struct bio *bio)
+{
+	struct bio_iostat_ctx *iostat_ctx = bio->bi_private;
+
+	return iostat_ctx->sbi;
+}
+
 void iostat_update_and_unbind_ctx(struct bio *bio)
 {
 	struct bio_iostat_ctx *iostat_ctx = bio->bi_private;
diff --git a/fs/f2fs/iostat.h b/fs/f2fs/iostat.h
index eb99d05cf272..9006c3d41590 100644
--- a/fs/f2fs/iostat.h
+++ b/fs/f2fs/iostat.h
@@ -58,6 +58,7 @@ static inline struct bio_post_read_ctx *get_post_read_ctx(struct bio *bio)
 	return iostat_ctx->post_read_ctx;
 }
 
+extern void *iostat_get_bio_private(struct bio *bio);
 extern void iostat_update_and_unbind_ctx(struct bio *bio);
 extern void iostat_alloc_and_bind_ctx(struct f2fs_sb_info *sbi,
 		struct bio *bio, struct bio_post_read_ctx *ctx);
@@ -68,6 +69,7 @@ extern void f2fs_destroy_iostat(struct f2fs_sb_info *sbi);
 #else
 static inline void f2fs_update_iostat(struct f2fs_sb_info *sbi, struct inode *inode,
 		enum iostat_type type, unsigned long long io_bytes) {}
+static inline void *iostat_get_bio_private(struct bio *bio) { return bio->bi_private; }
 static inline void iostat_update_and_unbind_ctx(struct bio *bio) {}
 static inline void iostat_alloc_and_bind_ctx(struct f2fs_sb_info *sbi,
 		struct bio *bio, struct bio_post_read_ctx *ctx) {}
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 0161840917c2..dc0b4c967dbf 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -3148,6 +3148,9 @@ static int __allocate_new_segment(struct f2fs_sb_info *sbi, int type,
 		return err;
 	stat_inc_seg_type(sbi, curseg);
 	locate_dirty_segment(sbi, old_segno);
+
+	f2fs_blkzoned_submit_merged_write(sbi, type);
+
 	return 0;
 }
 
@@ -3538,7 +3541,6 @@ static int __get_segment_type(struct f2fs_io_info *fio)
 	}
 
 	fio->temp = f2fs_get_segment_temp(type);
-
 	return type;
 }
 
@@ -4206,6 +4208,27 @@ static int restore_curseg_summaries(struct f2fs_sb_info *sbi)
 		return -EINVAL;
 	}
 
+#ifdef CONFIG_BLK_DEV_ZONED
+	if (f2fs_sb_has_blkzoned(sbi)) {
+		for (type = 0; type < NR_PERSISTENT_LOG; type++) {
+			struct curseg_info *curseg = CURSEG_I(sbi, type);
+			enum page_type ptype;
+			enum temp_type temp;
+
+			if (!(curseg->next_blkoff % sbi->blocks_per_blkz))
+				continue;
+
+			if (!f2fs_blkaddr_in_seqzone(sbi,
+					START_BLOCK(sbi, curseg->segno)))
+				continue;
+
+			ptype = PAGE_TYPE(type);
+			temp = type_to_temp(type);
+			down(&sbi->available_open_zones);
+			sbi->write_io[ptype][temp].zone_opened = true;
+		}
+	}
+#endif
 	return 0;
 }
 
@@ -5533,6 +5556,18 @@ static void destroy_curseg(struct f2fs_sb_info *sbi)
 		kfree(array[i].sum_blk);
 		kfree(array[i].journal);
 		kfree(array[i].target_map);
+
+#ifdef CONFIG_BLK_DEV_ZONED
+		if (f2fs_sb_has_blkzoned(sbi)) {
+			enum page_type ptype = PAGE_TYPE(i);
+			enum temp_type temp = type_to_temp(i);
+
+			if (sbi->write_io[ptype][temp].zone_opened) {
+				up(&sbi->available_open_zones);
+				sbi->write_io[ptype][temp].zone_opened = false;
+			}
+		}
+#endif
 	}
 	kfree(array);
 }
diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index 71131a0b00d7..64a342d1c89d 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -24,7 +24,8 @@
 
 #define IS_DATASEG(t)	((t) <= CURSEG_COLD_DATA)
 #define IS_NODESEG(t)	((t) >= CURSEG_HOT_NODE && (t) <= CURSEG_COLD_NODE)
-#define SE_PAGETYPE(se)	((IS_NODESEG((se)->type) ? NODE : DATA))
+#define PAGE_TYPE(t)	(IS_NODESEG(t) ? NODE : DATA)
+#define SE_PAGETYPE(se)	(PAGE_TYPE((se)->type))
 
 static inline void sanity_check_seg_type(struct f2fs_sb_info *sbi,
 						unsigned short seg_type)
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index ef673f853366..32aa6d6fa871 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -3893,6 +3893,8 @@ static int init_blkz_info(struct f2fs_sb_info *sbi, int devi)
 				sbi->max_open_zones, F2FS_OPTION(sbi).active_logs);
 			return -EINVAL;
 		}
+
+		sema_init(&sbi->available_open_zones, sbi->max_open_zones);
 	}
 
 	zone_sectors = bdev_zone_sectors(bdev);
-- 
2.40.1


