Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5CE77735A0
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 03:00:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbjHHBAc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 21:00:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbjHHBA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 21:00:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5369F171E
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 18:00:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D00446234B
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 01:00:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E035C433CB;
        Tue,  8 Aug 2023 01:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691456427;
        bh=v2WFjogDNIPmUy2EpPZym8LF3FTEbIlRfs+cOXw1AAg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kPwZrX7/jcz3Hc4kW80CJmDQphEXqxBdPSdXaCDaMKk3EnccDpYIvGtVllsZSxu8v
         k/xFx3c7ij6ydMDdbddnPk0sLR8XmtOfknZUq8JQfOQuI1Qj+vzx5PHmCCwBTvv8JE
         1rOYuFlY1bIhE3UB3lyVHveVc9f+pGMqPVbupdCGLP1zcffmqMBNZcO7sKxg4Cy831
         Xkfyr6BR9g5DJkB9+ucoD48FkbEwPaSR9D7nHF0zTwB7M1VprpC4km1nwHe7/tKg/e
         R9ObDYrWwR0BjgQs8CHeW++qDAIuSre/YsS0nbiNMmRNsutmH2u6GIH6J7p/rMtaA+
         Xh1YUbvL6gYYw==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>
Subject: [PATCH 2/2] f2fs: fix to account cp stats correctly
Date:   Tue,  8 Aug 2023 08:59:49 +0800
Message-Id: <20230808005949.1790839-2-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230808005949.1790839-1-chao@kernel.org>
References: <20230808005949.1790839-1-chao@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cp_foreground_calls sysfs entry shows total CP call count rather than
foreground CP call count, fix it.

Fixes: fc7100ea2a52 ("f2fs: Add f2fs stats to sysfs")
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/checkpoint.c |  2 +-
 fs/f2fs/debug.c      |  9 ++++++++-
 fs/f2fs/f2fs.h       | 25 ++++++++++++++-----------
 fs/f2fs/gc.c         |  5 +++++
 fs/f2fs/recovery.c   |  1 +
 fs/f2fs/segment.c    |  3 ++-
 fs/f2fs/super.c      |  8 +++++++-
 fs/f2fs/sysfs.c      | 14 ++++++++++++--
 8 files changed, 50 insertions(+), 17 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 8fd3b7f9fb88..b0597a539fc5 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -1701,9 +1701,9 @@ int f2fs_write_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 	}
 
 	f2fs_restore_inmem_curseg(sbi);
+	stat_inc_cp_count(sbi);
 stop:
 	unblock_operations(sbi);
-	stat_inc_cp_count(sbi->stat_info);
 
 	if (cpc->reason & CP_RECOVERY)
 		f2fs_notice(sbi, "checkpoint: version = %llx", ckpt_ver);
diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
index c7cf453dce83..fdbf994f1271 100644
--- a/fs/f2fs/debug.c
+++ b/fs/f2fs/debug.c
@@ -215,6 +215,9 @@ static void update_general_status(struct f2fs_sb_info *sbi)
 		si->valid_blks[type] += blks;
 	}
 
+	for (i = 0; i < MAX_CALL_TYPE; i++)
+		si->cp_call_count[i] = atomic_read(&sbi->cp_call_count[i]);
+
 	for (i = 0; i < 2; i++) {
 		si->segment_count[i] = sbi->segment_count[i];
 		si->block_count[i] = sbi->block_count[i];
@@ -497,7 +500,9 @@ static int stat_show(struct seq_file *s, void *v)
 		seq_printf(s, "  - Prefree: %d\n  - Free: %d (%d)\n\n",
 			   si->prefree_count, si->free_segs, si->free_secs);
 		seq_printf(s, "CP calls: %d (BG: %d)\n",
-				si->cp_count, si->bg_cp_count);
+			   si->cp_call_count[TOTAL_CALL],
+			   si->cp_call_count[BACKGROUND]);
+		seq_printf(s, "CP count: %d\n", si->cp_count);
 		seq_printf(s, "  - cp blocks : %u\n", si->meta_count[META_CP]);
 		seq_printf(s, "  - sit blocks : %u\n",
 				si->meta_count[META_SIT]);
@@ -699,6 +704,8 @@ int f2fs_build_stats(struct f2fs_sb_info *sbi)
 	atomic_set(&sbi->inplace_count, 0);
 	for (i = META_CP; i < META_MAX; i++)
 		atomic_set(&sbi->meta_count[i], 0);
+	for (i = 0; i < MAX_CALL_TYPE; i++)
+		atomic_set(&sbi->cp_call_count[i], 0);
 
 	atomic_set(&sbi->max_aw_cnt, 0);
 
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 9c99c608787a..2afc90e2152a 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1383,6 +1383,13 @@ enum errors_option {
 	MOUNT_ERRORS_PANIC,	/* panic on errors */
 };
 
+enum {
+	BACKGROUND,
+	FOREGROUND,
+	MAX_CALL_TYPE,
+	TOTAL_CALL = FOREGROUND,
+};
+
 static inline int f2fs_test_bit(unsigned int nr, char *addr);
 static inline void f2fs_set_bit(unsigned int nr, char *addr);
 static inline void f2fs_clear_bit(unsigned int nr, char *addr);
@@ -1695,6 +1702,7 @@ struct f2fs_sb_info {
 	unsigned int io_skip_bggc;		/* skip background gc for in-flight IO */
 	unsigned int other_skip_bggc;		/* skip background gc for other reasons */
 	unsigned int ndirty_inode[NR_INODE_TYPE];	/* # of dirty inodes */
+	atomic_t cp_call_count[MAX_CALL_TYPE];	/* # of cp call */
 #endif
 	spinlock_t stat_lock;			/* lock for stat operations */
 
@@ -3860,12 +3868,6 @@ void f2fs_destroy_recovery_cache(void);
 /*
  * debug.c
  */
-enum {
-	BACKGROUND,
-	FOREGROUND,
-	MAX_CALL_TYPE
-};
-
 #ifdef CONFIG_F2FS_STAT_FS
 struct f2fs_stat_info {
 	struct list_head stat_list;
@@ -3912,7 +3914,7 @@ struct f2fs_stat_info {
 	int dirty_count, node_pages, meta_pages, compress_pages;
 	int compress_page_hit;
 	int prefree_count, free_segs, free_secs;
-	int cp_count, bg_cp_count;
+	int cp_call_count[MAX_CALL_TYPE], cp_count;
 	int gc_call_count[MAX_CALL_TYPE];
 	int gc_segs[2][2];
 	int gc_secs[2][2];
@@ -3937,8 +3939,9 @@ static inline struct f2fs_stat_info *F2FS_STAT(struct f2fs_sb_info *sbi)
 	return (struct f2fs_stat_info *)sbi->stat_info;
 }
 
-#define stat_inc_cp_count(si)		((si)->cp_count++)
-#define stat_inc_bg_cp_count(si)	((si)->bg_cp_count++)
+#define stat_inc_cp_call_count(sbi, foreground)				\
+		atomic_inc(&sbi->cp_call_count[(foreground)])
+#define stat_inc_cp_count(si)		(F2FS_STAT(sbi)->cp_count++)
 #define stat_io_skip_bggc_count(sbi)	((sbi)->io_skip_bggc++)
 #define stat_other_skip_bggc_count(sbi)	((sbi)->other_skip_bggc++)
 #define stat_inc_dirty_inode(sbi, type)	((sbi)->ndirty_inode[type]++)
@@ -4055,8 +4058,8 @@ void __init f2fs_create_root_stats(void);
 void f2fs_destroy_root_stats(void);
 void f2fs_update_sit_info(struct f2fs_sb_info *sbi);
 #else
-#define stat_inc_cp_count(si)				do { } while (0)
-#define stat_inc_bg_cp_count(si)			do { } while (0)
+#define stat_inc_cp_call_count(sbi, foreground)		do { } while (0)
+#define stat_inc_cp_count(sbi)				do { } while (0)
 #define stat_io_skip_bggc_count(sbi)			do { } while (0)
 #define stat_other_skip_bggc_count(sbi)			do { } while (0)
 #define stat_inc_dirty_inode(sbi, type)			do { } while (0)
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 68c3250fb3d2..6690323fff83 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -1840,6 +1840,7 @@ int f2fs_gc(struct f2fs_sb_info *sbi, struct f2fs_gc_control *gc_control)
 		 * secure free segments which doesn't need fggc any more.
 		 */
 		if (prefree_segments(sbi)) {
+			stat_inc_cp_call_count(sbi, TOTAL_CALL);
 			ret = f2fs_write_checkpoint(sbi, &cpc);
 			if (ret)
 				goto stop;
@@ -1888,6 +1889,7 @@ int f2fs_gc(struct f2fs_sb_info *sbi, struct f2fs_gc_control *gc_control)
 		round++;
 		if (skipped_round > MAX_SKIP_GC_COUNT &&
 				skipped_round * 2 >= round) {
+			stat_inc_cp_call_count(sbi, TOTAL_CALL);
 			ret = f2fs_write_checkpoint(sbi, &cpc);
 			goto stop;
 		}
@@ -1903,6 +1905,7 @@ int f2fs_gc(struct f2fs_sb_info *sbi, struct f2fs_gc_control *gc_control)
 	 */
 	if (free_sections(sbi) <= upper_secs + NR_GC_CHECKPOINT_SECS &&
 				prefree_segments(sbi)) {
+		stat_inc_cp_call_count(sbi, TOTAL_CALL);
 		ret = f2fs_write_checkpoint(sbi, &cpc);
 		if (ret)
 			goto stop;
@@ -2030,6 +2033,7 @@ static int free_segment_range(struct f2fs_sb_info *sbi,
 	if (gc_only)
 		goto out;
 
+	stat_inc_cp_call_count(sbi, TOTAL_CALL);
 	err = f2fs_write_checkpoint(sbi, &cpc);
 	if (err)
 		goto out;
@@ -2222,6 +2226,7 @@ int f2fs_resize_fs(struct file *filp, __u64 block_count)
 	clear_sbi_flag(sbi, SBI_IS_RESIZEFS);
 	set_sbi_flag(sbi, SBI_IS_DIRTY);
 
+	stat_inc_cp_call_count(sbi, TOTAL_CALL);
 	err = f2fs_write_checkpoint(sbi, &cpc);
 	if (err) {
 		update_fs_metadata(sbi, secs);
diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index 4e7d4ceeb084..e91f4619aa5b 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -924,6 +924,7 @@ int f2fs_recover_fsync_data(struct f2fs_sb_info *sbi, bool check_only)
 			struct cp_control cpc = {
 				.reason = CP_RECOVERY,
 			};
+			stat_inc_cp_call_count(sbi, TOTAL_CALL);
 			err = f2fs_write_checkpoint(sbi, &cpc);
 		}
 	}
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index b7971bdc39e1..ad609c7c75f6 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -513,8 +513,8 @@ void f2fs_balance_fs_bg(struct f2fs_sb_info *sbi, bool from_bg)
 
 		mutex_unlock(&sbi->flush_lock);
 	}
+	stat_inc_cp_call_count(sbi, BACKGROUND);
 	f2fs_sync_fs(sbi->sb, 1);
-	stat_inc_bg_cp_count(sbi->stat_info);
 }
 
 static int __submit_flush_wait(struct f2fs_sb_info *sbi,
@@ -3231,6 +3231,7 @@ int f2fs_trim_fs(struct f2fs_sb_info *sbi, struct fstrim_range *range)
 		goto out;
 
 	f2fs_down_write(&sbi->gc_lock);
+	stat_inc_cp_call_count(sbi, TOTAL_CALL);
 	err = f2fs_write_checkpoint(sbi, &cpc);
 	f2fs_up_write(&sbi->gc_lock);
 	if (err)
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 9446a4c1fd53..7f0cb2fa0fc8 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1601,6 +1601,7 @@ static void f2fs_put_super(struct super_block *sb)
 		struct cp_control cpc = {
 			.reason = CP_UMOUNT,
 		};
+		stat_inc_cp_call_count(sbi, TOTAL_CALL);
 		err = f2fs_write_checkpoint(sbi, &cpc);
 	}
 
@@ -1610,6 +1611,7 @@ static void f2fs_put_super(struct super_block *sb)
 		struct cp_control cpc = {
 			.reason = CP_UMOUNT | CP_TRIMMED,
 		};
+		stat_inc_cp_call_count(sbi, TOTAL_CALL);
 		err = f2fs_write_checkpoint(sbi, &cpc);
 	}
 
@@ -1706,8 +1708,10 @@ int f2fs_sync_fs(struct super_block *sb, int sync)
 	if (unlikely(is_sbi_flag_set(sbi, SBI_POR_DOING)))
 		return -EAGAIN;
 
-	if (sync)
+	if (sync) {
+		stat_inc_cp_call_count(sbi, TOTAL_CALL);
 		err = f2fs_issue_checkpoint(sbi);
+	}
 
 	return err;
 }
@@ -2232,6 +2236,7 @@ static int f2fs_disable_checkpoint(struct f2fs_sb_info *sbi)
 	f2fs_down_write(&sbi->gc_lock);
 	cpc.reason = CP_PAUSE;
 	set_sbi_flag(sbi, SBI_CP_DISABLED);
+	stat_inc_cp_call_count(sbi, TOTAL_CALL);
 	err = f2fs_write_checkpoint(sbi, &cpc);
 	if (err)
 		goto out_unlock;
@@ -4868,6 +4873,7 @@ static void kill_f2fs_super(struct super_block *sb)
 			struct cp_control cpc = {
 				.reason = CP_UMOUNT,
 			};
+			stat_inc_cp_call_count(sbi, TOTAL_CALL);
 			f2fs_write_checkpoint(sbi, &cpc);
 		}
 
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index 95a301581b91..417fae96890f 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -356,6 +356,16 @@ static ssize_t f2fs_sbi_show(struct f2fs_attr *a,
 	if (!strcmp(a->attr.name, "revoked_atomic_block"))
 		return sysfs_emit(buf, "%llu\n", sbi->revoked_atomic_block);
 
+#ifdef CONFIG_F2FS_STAT_FS
+	if (!strcmp(a->attr.name, "cp_foreground_calls"))
+		return sysfs_emit(buf, "%d\n",
+				atomic_read(&sbi->cp_call_count[TOTAL_CALL]) -
+				atomic_read(&sbi->cp_call_count[BACKGROUND]));
+	if (!strcmp(a->attr.name, "cp_background_calls"))
+		return sysfs_emit(buf, "%d\n",
+				atomic_read(&sbi->cp_call_count[BACKGROUND]));
+#endif
+
 	ui = (unsigned int *)(ptr + a->offset);
 
 	return sysfs_emit(buf, "%u\n", *ui);
@@ -972,8 +982,8 @@ F2FS_SBI_GENERAL_RO_ATTR(unusable_blocks_per_sec);
 
 /* STAT_INFO ATTR */
 #ifdef CONFIG_F2FS_STAT_FS
-STAT_INFO_RO_ATTR(cp_foreground_calls, cp_count);
-STAT_INFO_RO_ATTR(cp_background_calls, bg_cp_count);
+STAT_INFO_RO_ATTR(cp_foreground_calls, cp_call_count[FOREGROUND]);
+STAT_INFO_RO_ATTR(cp_background_calls, cp_call_count[BACKGROUND]);
 STAT_INFO_RO_ATTR(gc_foreground_calls, gc_call_count[FOREGROUND]);
 STAT_INFO_RO_ATTR(gc_background_calls, gc_call_count[BACKGROUND]);
 #endif
-- 
2.40.1

