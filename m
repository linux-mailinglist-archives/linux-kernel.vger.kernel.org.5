Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34A2677359F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 03:00:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbjHHBA3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 21:00:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjHHBA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 21:00:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8708E1715
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 18:00:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2597B62014
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 01:00:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F2A9C433C7;
        Tue,  8 Aug 2023 01:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691456425;
        bh=8fbOC1RNM7Metqi7oi86OG1orlHD3l0fscd54g2j7pY=;
        h=From:To:Cc:Subject:Date:From;
        b=AjCWBKKfMZmvHeKS59yejVH25Ekv5/BEjjpMA4ychQkhyoO+F4r9JDaWLTa+bGj/u
         0kQjEuc03Gps9Fso+JpOV0ZCbER4baFVKNOgQYLIe+exGdjbEjmYE9pzmZZ8JJfs2U
         za8HLcarczPq75WdPz3O5nWmDZyr04sexe6rOh3LBzuIDqS9zqI3kXGzPFj2swFg2K
         N1BJGycGAVoxWFTtphTbAVrgedsKk4xUAWmiDKJT/1W99Ytmkl3Xq9kzXE4Re6ScA5
         20fT9Oc27Sjkv0x3GLOjTTxsv3L7X5wEFk/50MgMg6pJ5cYGdEjOPGbT85bd1JmBcH
         9AJcP36nM6uWg==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>
Subject: [PATCH 1/2] f2fs: fix to account gc stats correctly
Date:   Tue,  8 Aug 2023 08:59:48 +0800
Message-Id: <20230808005949.1790839-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As reported, status debugfs entry shows inconsistent GC stats as below:

GC calls: 6008 (BG: 6161)
  - data segments : 3053 (BG: 3053)
  - node segments : 2955 (BG: 2955)

Total GC calls is larger than BGGC calls, the reason is:
- f2fs_stat_info.call_count accounts total migrated section count
by f2fs_gc()
- f2fs_stat_info.bg_gc accounts total call times of f2fs_gc() from
background gc_thread

Another issue is gc_foreground_calls sysfs entry shows total GC call
count rather than FGGC call count.

This patch changes as below for fix:
- account GC calls and migrated segment count separately
- support to account migrated section count if it enables large section
mode
- fix to show correct value in gc_foreground_calls sysfs entry

Fixes: fc7100ea2a52 ("f2fs: Add f2fs stats to sysfs")
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/debug.c   | 24 ++++++++++++++++++------
 fs/f2fs/f2fs.h    | 42 +++++++++++++++++++++---------------------
 fs/f2fs/file.c    |  4 ++++
 fs/f2fs/gc.c      | 13 +++++++------
 fs/f2fs/segment.c |  1 +
 fs/f2fs/super.c   |  1 +
 fs/f2fs/sysfs.c   |  4 ++--
 7 files changed, 54 insertions(+), 35 deletions(-)

diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
index 61c35b59126e..c7cf453dce83 100644
--- a/fs/f2fs/debug.c
+++ b/fs/f2fs/debug.c
@@ -511,12 +511,24 @@ static int stat_show(struct seq_file *s, void *v)
 		seq_printf(s, "  - Total : %4d\n", si->nr_total_ckpt);
 		seq_printf(s, "  - Cur time : %4d(ms)\n", si->cur_ckpt_time);
 		seq_printf(s, "  - Peak time : %4d(ms)\n", si->peak_ckpt_time);
-		seq_printf(s, "GC calls: %d (BG: %d)\n",
-			   si->call_count, si->bg_gc);
-		seq_printf(s, "  - data segments : %d (%d)\n",
-				si->data_segs, si->bg_data_segs);
-		seq_printf(s, "  - node segments : %d (%d)\n",
-				si->node_segs, si->bg_node_segs);
+		seq_printf(s, "GC calls: %d (gc_thread: %d)\n",
+			   si->gc_call_count[BACKGROUND] +
+			   si->gc_call_count[FOREGROUND],
+			   si->gc_call_count[BACKGROUND]);
+		if (__is_large_section(sbi)) {
+			seq_printf(s, "  - data sections : %d (BG: %d)\n",
+					si->gc_secs[DATA][BG_GC] + si->gc_secs[DATA][FG_GC],
+					si->gc_secs[DATA][BG_GC]);
+			seq_printf(s, "  - node sections : %d (BG: %d)\n",
+					si->gc_secs[NODE][BG_GC] + si->gc_secs[NODE][FG_GC],
+					si->gc_secs[NODE][BG_GC]);
+		}
+		seq_printf(s, "  - data segments : %d (BG: %d)\n",
+				si->gc_segs[DATA][BG_GC] + si->gc_segs[DATA][FG_GC],
+				si->gc_segs[DATA][BG_GC]);
+		seq_printf(s, "  - node segments : %d (BG: %d)\n",
+				si->gc_segs[NODE][BG_GC] + si->gc_segs[NODE][FG_GC],
+				si->gc_segs[NODE][BG_GC]);
 		seq_puts(s, "  - Reclaimed segs :\n");
 		seq_printf(s, "    - Normal : %d\n", sbi->gc_reclaimed_segs[GC_NORMAL]);
 		seq_printf(s, "    - Idle CB : %d\n", sbi->gc_reclaimed_segs[GC_IDLE_CB]);
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index da02e120e5ea..9c99c608787a 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3860,6 +3860,12 @@ void f2fs_destroy_recovery_cache(void);
 /*
  * debug.c
  */
+enum {
+	BACKGROUND,
+	FOREGROUND,
+	MAX_CALL_TYPE
+};
+
 #ifdef CONFIG_F2FS_STAT_FS
 struct f2fs_stat_info {
 	struct list_head stat_list;
@@ -3885,7 +3891,7 @@ struct f2fs_stat_info {
 	int nats, dirty_nats, sits, dirty_sits;
 	int free_nids, avail_nids, alloc_nids;
 	int total_count, utilization;
-	int bg_gc, nr_wb_cp_data, nr_wb_data;
+	int nr_wb_cp_data, nr_wb_data;
 	int nr_rd_data, nr_rd_node, nr_rd_meta;
 	int nr_dio_read, nr_dio_write;
 	unsigned int io_skip_bggc, other_skip_bggc;
@@ -3905,9 +3911,11 @@ struct f2fs_stat_info {
 	int rsvd_segs, overp_segs;
 	int dirty_count, node_pages, meta_pages, compress_pages;
 	int compress_page_hit;
-	int prefree_count, call_count, cp_count, bg_cp_count;
-	int tot_segs, node_segs, data_segs, free_segs, free_secs;
-	int bg_node_segs, bg_data_segs;
+	int prefree_count, free_segs, free_secs;
+	int cp_count, bg_cp_count;
+	int gc_call_count[MAX_CALL_TYPE];
+	int gc_segs[2][2];
+	int gc_secs[2][2];
 	int tot_blks, data_blks, node_blks;
 	int bg_data_blks, bg_node_blks;
 	int curseg[NR_CURSEG_TYPE];
@@ -3931,8 +3939,6 @@ static inline struct f2fs_stat_info *F2FS_STAT(struct f2fs_sb_info *sbi)
 
 #define stat_inc_cp_count(si)		((si)->cp_count++)
 #define stat_inc_bg_cp_count(si)	((si)->bg_cp_count++)
-#define stat_inc_call_count(si)		((si)->call_count++)
-#define stat_inc_bggc_count(si)		((si)->bg_gc++)
 #define stat_io_skip_bggc_count(sbi)	((sbi)->io_skip_bggc++)
 #define stat_other_skip_bggc_count(sbi)	((sbi)->other_skip_bggc++)
 #define stat_inc_dirty_inode(sbi, type)	((sbi)->ndirty_inode[type]++)
@@ -4017,18 +4023,12 @@ static inline struct f2fs_stat_info *F2FS_STAT(struct f2fs_sb_info *sbi)
 		if (cur > max)						\
 			atomic_set(&F2FS_I_SB(inode)->max_aw_cnt, cur);	\
 	} while (0)
-#define stat_inc_seg_count(sbi, type, gc_type)				\
-	do {								\
-		struct f2fs_stat_info *si = F2FS_STAT(sbi);		\
-		si->tot_segs++;						\
-		if ((type) == SUM_TYPE_DATA) {				\
-			si->data_segs++;				\
-			si->bg_data_segs += (gc_type == BG_GC) ? 1 : 0;	\
-		} else {						\
-			si->node_segs++;				\
-			si->bg_node_segs += (gc_type == BG_GC) ? 1 : 0;	\
-		}							\
-	} while (0)
+#define stat_inc_gc_call_count(sbi, foreground)				\
+		(F2FS_STAT(sbi)->gc_call_count[(foreground)]++)
+#define stat_inc_gc_sec_count(sbi, type, gc_type)			\
+		(F2FS_STAT(sbi)->gc_secs[(type)][(gc_type)]++)
+#define stat_inc_gc_seg_count(sbi, type, gc_type)			\
+		(F2FS_STAT(sbi)->gc_segs[(type)][(gc_type)]++)
 
 #define stat_inc_tot_blk_count(si, blks)				\
 	((si)->tot_blks += (blks))
@@ -4057,8 +4057,6 @@ void f2fs_update_sit_info(struct f2fs_sb_info *sbi);
 #else
 #define stat_inc_cp_count(si)				do { } while (0)
 #define stat_inc_bg_cp_count(si)			do { } while (0)
-#define stat_inc_call_count(si)				do { } while (0)
-#define stat_inc_bggc_count(si)				do { } while (0)
 #define stat_io_skip_bggc_count(sbi)			do { } while (0)
 #define stat_other_skip_bggc_count(sbi)			do { } while (0)
 #define stat_inc_dirty_inode(sbi, type)			do { } while (0)
@@ -4086,7 +4084,9 @@ void f2fs_update_sit_info(struct f2fs_sb_info *sbi);
 #define stat_inc_seg_type(sbi, curseg)			do { } while (0)
 #define stat_inc_block_count(sbi, curseg)		do { } while (0)
 #define stat_inc_inplace_blocks(sbi)			do { } while (0)
-#define stat_inc_seg_count(sbi, type, gc_type)		do { } while (0)
+#define stat_inc_gc_call_count(sbi, foreground)		do { } while (0)
+#define stat_inc_gc_sec_count(sbi, type, gc_type)	do { } while (0)
+#define stat_inc_gc_seg_count(sbi, type, gc_type)	do { } while (0)
 #define stat_inc_tot_blk_count(si, blks)		do { } while (0)
 #define stat_inc_data_blk_count(sbi, blks, gc_type)	do { } while (0)
 #define stat_inc_node_blk_count(sbi, blks, gc_type)	do { } while (0)
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 74f79e7c8c02..ff5494c255f6 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1728,6 +1728,7 @@ static int f2fs_expand_inode_data(struct inode *inode, loff_t offset,
 		if (has_not_enough_free_secs(sbi, 0,
 			GET_SEC_FROM_SEG(sbi, overprovision_segments(sbi)))) {
 			f2fs_down_write(&sbi->gc_lock);
+			stat_inc_gc_call_count(sbi, FOREGROUND);
 			err = f2fs_gc(sbi, &gc_control);
 			if (err && err != -ENODATA)
 				goto out_err;
@@ -2476,6 +2477,7 @@ static int f2fs_ioc_gc(struct file *filp, unsigned long arg)
 
 	gc_control.init_gc_type = sync ? FG_GC : BG_GC;
 	gc_control.err_gc_skipped = sync;
+	stat_inc_gc_call_count(sbi, FOREGROUND);
 	ret = f2fs_gc(sbi, &gc_control);
 out:
 	mnt_drop_write_file(filp);
@@ -2519,6 +2521,7 @@ static int __f2fs_ioc_gc_range(struct file *filp, struct f2fs_gc_range *range)
 	}
 
 	gc_control.victim_segno = GET_SEGNO(sbi, range->start);
+	stat_inc_gc_call_count(sbi, FOREGROUND);
 	ret = f2fs_gc(sbi, &gc_control);
 	if (ret) {
 		if (ret == -EBUSY)
@@ -3001,6 +3004,7 @@ static int f2fs_ioc_flush_device(struct file *filp, unsigned long arg)
 		sm->last_victim[ALLOC_NEXT] = end_segno + 1;
 
 		gc_control.victim_segno = start_segno;
+		stat_inc_gc_call_count(sbi, FOREGROUND);
 		ret = f2fs_gc(sbi, &gc_control);
 		if (ret == -EAGAIN)
 			ret = 0;
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 01effd3fcb6c..68c3250fb3d2 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -121,8 +121,8 @@ static int gc_thread_func(void *data)
 		else
 			increase_sleep_time(gc_th, &wait_ms);
 do_gc:
-		if (!foreground)
-			stat_inc_bggc_count(sbi->stat_info);
+		stat_inc_gc_call_count(sbi, foreground ?
+					FOREGROUND : BACKGROUND);
 
 		sync_mode = F2FS_OPTION(sbi).bggc_mode == BGGC_MODE_SYNC;
 
@@ -1685,6 +1685,7 @@ static int do_garbage_collect(struct f2fs_sb_info *sbi,
 	int seg_freed = 0, migrated = 0;
 	unsigned char type = IS_DATASEG(get_seg_entry(sbi, segno)->type) ?
 						SUM_TYPE_DATA : SUM_TYPE_NODE;
+	unsigned char data_type = (type == SUM_TYPE_DATA) ? DATA : NODE;
 	int submitted = 0;
 
 	if (__is_large_section(sbi))
@@ -1766,7 +1767,7 @@ static int do_garbage_collect(struct f2fs_sb_info *sbi,
 							segno, gc_type,
 							force_migrate);
 
-		stat_inc_seg_count(sbi, type, gc_type);
+		stat_inc_gc_seg_count(sbi, data_type, gc_type);
 		sbi->gc_reclaimed_segs[sbi->gc_mode]++;
 		migrated++;
 
@@ -1783,12 +1784,12 @@ static int do_garbage_collect(struct f2fs_sb_info *sbi,
 	}
 
 	if (submitted)
-		f2fs_submit_merged_write(sbi,
-				(type == SUM_TYPE_NODE) ? NODE : DATA);
+		f2fs_submit_merged_write(sbi, data_type);
 
 	blk_finish_plug(&plug);
 
-	stat_inc_call_count(sbi->stat_info);
+	if (migrated)
+		stat_inc_gc_sec_count(sbi, data_type, gc_type);
 
 	return seg_freed;
 }
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 1f0a25011687..b7971bdc39e1 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -435,6 +435,7 @@ void f2fs_balance_fs(struct f2fs_sb_info *sbi, bool need)
 			.err_gc_skipped = false,
 			.nr_free_secs = 1 };
 		f2fs_down_write(&sbi->gc_lock);
+		stat_inc_gc_call_count(sbi, FOREGROUND);
 		f2fs_gc(sbi, &gc_control);
 	}
 }
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 30883beb750a..9446a4c1fd53 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2206,6 +2206,7 @@ static int f2fs_disable_checkpoint(struct f2fs_sb_info *sbi)
 			.nr_free_secs = 1 };
 
 		f2fs_down_write(&sbi->gc_lock);
+		stat_inc_gc_call_count(sbi, FOREGROUND);
 		err = f2fs_gc(sbi, &gc_control);
 		if (err == -ENODATA) {
 			err = 0;
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index 48b7e0073884..95a301581b91 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -974,8 +974,8 @@ F2FS_SBI_GENERAL_RO_ATTR(unusable_blocks_per_sec);
 #ifdef CONFIG_F2FS_STAT_FS
 STAT_INFO_RO_ATTR(cp_foreground_calls, cp_count);
 STAT_INFO_RO_ATTR(cp_background_calls, bg_cp_count);
-STAT_INFO_RO_ATTR(gc_foreground_calls, call_count);
-STAT_INFO_RO_ATTR(gc_background_calls, bg_gc);
+STAT_INFO_RO_ATTR(gc_foreground_calls, gc_call_count[FOREGROUND]);
+STAT_INFO_RO_ATTR(gc_background_calls, gc_call_count[BACKGROUND]);
 #endif
 
 /* FAULT_INFO ATTR */
-- 
2.40.1

