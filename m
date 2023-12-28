Return-Path: <linux-kernel+bounces-12467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B41281F528
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 07:45:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50E40281861
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 06:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C8AB3C15;
	Thu, 28 Dec 2023 06:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="IJHkBY5W"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5CD23C07
	for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 06:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20231228064510epoutp0427ce082741806070205af7ba6727d9bb~k6_DjHYAf1778917789epoutp04O
	for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 06:45:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20231228064510epoutp0427ce082741806070205af7ba6727d9bb~k6_DjHYAf1778917789epoutp04O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1703745910;
	bh=X7yZK13nwyDzs58dDzp+M/6sU3bq6c/zRPLxOpxegOI=;
	h=Subject:Reply-To:From:To:CC:Date:References:From;
	b=IJHkBY5WyqB6axb1bqsEQY1N8ajAp2leRpgNyuDlDk4mWvJaF5qK1ns/yIukeireD
	 6RTFOr6Uche5EFNZ8tPg2D+ULLV5Eu3xwD2VD5UNOPrD9zgiodDAGED0g0wwlYYJPI
	 K025CVjVzWoVej31kk6NDfLGs9atKR9lH+qTekjA=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas2p1.samsung.com (KnoxPortal) with ESMTP id
	20231228064509epcas2p1016b4762c56f044319ce2fc190e755db~k6_DJIUwX3025530255epcas2p1M;
	Thu, 28 Dec 2023 06:45:09 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.70]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4T0zXP0P87z4x9Pv; Thu, 28 Dec
	2023 06:45:09 +0000 (GMT)
X-AuditID: b6c32a45-3ebfd70000002716-da-658d19740c43
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
	epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
	C1.6C.10006.4791D856; Thu, 28 Dec 2023 15:45:08 +0900 (KST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: [PATCH v4] f2fs: New victim selection for GC
Reply-To: yonggil.song@samsung.com
Sender: Yonggil Song <yonggil.song@samsung.com>
From: Yonggil Song <yonggil.song@samsung.com>
To: "jaegeuk@kernel.org" <jaegeuk@kernel.org>, "chao@kernel.org"
	<chao@kernel.org>, "linux-f2fs-devel@lists.sourceforge.net"
	<linux-f2fs-devel@lists.sourceforge.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Seokhwan Kim <sukka.kim@samsung.com>, Daejun
	Park <daejun7.park@samsung.com>, Siwoo Jung <siu.jung@samsung.com>
CC: Yonggil Song <yonggil.song@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20231228064508epcms2p1f74a30f7b615716d678950c0d5bc0748@epcms2p1>
Date: Thu, 28 Dec 2023 15:45:08 +0900
X-CMS-MailID: 20231228064508epcms2p1f74a30f7b615716d678950c0d5bc0748
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpik+LIzCtJLcpLzFFi42LZdljTTLdEsjfVoGWhhcXpqWeZLFY9CLd4
	sn4Ws8WlRe4Wl3fNYbM4P/E1ULhjLqPF1PNHmBw4PDat6mTz2L3gM5NH35ZVjB6fN8kFsERl
	22SkJqakFimk5iXnp2TmpdsqeQfHO8ebmhkY6hpaWpgrKeQl5qbaKrn4BOi6ZeYAHaGkUJaY
	UwoUCkgsLlbSt7Mpyi8tSVXIyC8usVVKLUjJKTAv0CtOzC0uzUvXy0stsTI0MDAyBSpMyM7Y
	++c1c8Eb54obK84zNzAuMO1i5OSQEDCRODdvJWMXIxeHkMAORonzO7YDORwcvAKCEn93CIPU
	CAuYSuy72soCYgsJKElcO9DLAhHXl9i8eBk7iM0moCvxd8NyMFtE4C6TRF+3O4jNLKAtsXH2
	WSaIXbwSM9qfskDY0hLbl29lhLA1JH4s62WGsEUlbq5+yw5jvz82H6pGRKL13lmoGkGJBz93
	Q8UlJRYdOg81P1/i74rrbBB2jcTWhjaouL7EtY6NYHt5BXwl3n+dD/Yii4CqxJIJqRAlLhLf
	7x9ngzhZXmL72znMICXMApoS63fpg5gSAsoSR26xQFTwSXQc/ssO89SOeU+gFqlJbN60mRXC
	lpG48LgN6kgPiT0T/7BDAjBQ4uyDN4wTGBVmIYJ5FpK9sxD2LmBkXsUollpQnJueWmxUYAiP
	2eT83E2M4MSo5bqDcfLbD3qHGJk4GA8xSnAwK4nwHhftSRXiTUmsrEotyo8vKs1JLT7EaAr0
	8ERmKdHkfGBqziuJNzSxNDAxMzM0NzI1MFcS573XOjdFSCA9sSQ1OzW1ILUIpo+Jg1OqgUnt
	lyybZdajI90rpE3m2+ifDIyLEF6x687p7RKrCsQzX68OubVBdQXXultm95iFw/2D7rxn2i3m
	rM7YNdXEOm6V7xJpocqdf/bbTX4kq/6o6bz0++czL/65PXNviFu9aWPlqaiZbzIi3fceXptZ
	Lh3LZFHl6hGx9PF0U89wWaVrXCI+2p7vQ5o+TKxN0Xv+JJhNxvv6xg6W7Y/N1whWvNDcYtck
	VXSQK6tlb7SB+XvdJbyf7r4/ImD8iCt5a8Fyw4frPjocPXR42Zxp8aHR3Vd8j89lmslQdkjJ
	eJO/XrC/1P+Jm+axrHj7evru+HsF/9sEDlbzLWjPlrfOSGPzurZz1pxjVxpfyccc2bbAqEqJ
	pTgj0VCLuag4EQDf7lbKFQQAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231228064508epcms2p1f74a30f7b615716d678950c0d5bc0748
References: <CGME20231228064508epcms2p1f74a30f7b615716d678950c0d5bc0748@epcms2p1>

From d08b97183bc830779c82b83d94f8b75ad11cb29a Mon Sep 17 00:00:00 2001
From: Yonggil Song <yonggil.song@samsung.com>
Date: Thu, 7 Dec 2023 16:34:38 +0900
Subject: [PATCH v4] f2fs: New victim selection for GC

Overview
========

This patch introduces a new way to preference data sections when selecting
GC victims. Migration of data blocks causes invalidation of node blocks.
Therefore, in situations where GC is frequent, selecting data blocks as
victims can reduce unnecessary block migration by invalidating node blocks.
For exceptional situations where free sections are insufficient, node blocks
are selected as victims instead of data blocks to get extra free sections.

Problem
=======

If the total amount of nodes is larger than the size of one section, nodes
occupy multiple sections, and node victims are often selected because the
gc cost is lowered by data block migration in GC. Since moving the data
section causes frequent node victim selection, victim threshing occurs in
the node section. This results in an increase in WAF.

Experiment
==========

Test environment is as follows.

        System info
          - 3.6GHz, 16 core CPU
          - 36GiB Memory
        Device info
          - a conventional null_blk with 228MiB
          - a sequential null_blk with 4068 zones of 8MiB
        Format
          - mkfs.f2fs <conv null_blk> -c <seq null_blk> -m -Z 8 -o 3.89
        Mount
          - mount <conv null_blk> <mount point>
        Fio script
	  - fio --rw=randwrite --bs=4k --ba=4k --filesize=31187m --norandommap --overwrite=1 --name=job1 --filename=./mnt/sustain --io_size=128g
	WAF calculation
	  - (IOs on conv. null_blk + IOs on seq. null_blk) / random write IOs

Conclusion
==========

This experiment showed that the WAF was reduced by 29% (18.75 -> 13.3) when
the data section was selected first when selecting GC victims. This was
achieved by reducing the migration of the node blocks by 69.4%
(253,131,743 blks -> 77,463,278 blks). It is possible to achieve low WAF
performance with the GC victim selection method in environments where the
section size is relatively small.

Signed-off-by: Yonggil Song <yonggil.song@samsung.com>
---
 fs/f2fs/f2fs.h |  1 +
 fs/f2fs/gc.c   | 99 +++++++++++++++++++++++++++++++++++++++-----------
 fs/f2fs/gc.h   |  6 +++
 3 files changed, 85 insertions(+), 21 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 9043cedfa12b..b2c0adfb2704 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1649,6 +1649,7 @@ struct f2fs_sb_info {
 	struct f2fs_mount_info mount_opt;	/* mount options */
 
 	/* for cleaning operations */
+	bool require_node_gc;			/* flag for node GC */
 	struct f2fs_rwsem gc_lock;		/*
 						 * semaphore for GC, avoid
 						 * race between GC and GC or CP
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index f550cdeaa663..d8a81a6ed325 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -341,6 +341,14 @@ static unsigned int get_cb_cost(struct f2fs_sb_info *sbi, unsigned int segno)
 	unsigned int i;
 	unsigned int usable_segs_per_sec = f2fs_usable_segs_in_sec(sbi, segno);
 
+	/*
+	 * When BG_GC selects victims based on age, it prevents node victims
+	 * from being selected. This is because node blocks can be invalidated
+	 * by moving data blocks.
+	 */
+	if (__skip_node_gc(sbi, segno))
+		return UINT_MAX;
+
 	for (i = 0; i < usable_segs_per_sec; i++)
 		mtime += get_seg_entry(sbi, start + i)->mtime;
 	vblocks = get_valid_blocks(sbi, segno, true);
@@ -369,10 +377,24 @@ static inline unsigned int get_gc_cost(struct f2fs_sb_info *sbi,
 		return get_seg_entry(sbi, segno)->ckpt_valid_blocks;
 
 	/* alloc_mode == LFS */
-	if (p->gc_mode == GC_GREEDY)
-		return get_valid_blocks(sbi, segno, true);
-	else if (p->gc_mode == GC_CB)
+	if (p->gc_mode == GC_GREEDY) {
+		/*
+		 * If the data block that the node block pointed to is GCed,
+		 * the node block is invalidated. For this reason, we add a
+		 * weight to cost of node victims to give priority to data
+		 * victims during the gc process. However, in a situation
+		 * where we run out of free sections, we remove the weight
+		 * because we need to clean up node blocks.
+		 */
+		unsigned int cost = get_valid_blocks(sbi, segno, true);
+
+		if (__skip_node_gc(sbi, segno))
+			return cost +
+				(sbi->segs_per_sec << sbi->log_blocks_per_seg);
+		return cost;
+	} else if (p->gc_mode == GC_CB) {
 		return get_cb_cost(sbi, segno);
+	}
 
 	f2fs_bug_on(sbi, 1);
 	return 0;
@@ -557,6 +579,14 @@ static void atgc_lookup_victim(struct f2fs_sb_info *sbi,
 	if (ve->mtime >= max_mtime || ve->mtime < min_mtime)
 		goto skip;
 
+	/*
+	 * When BG_GC selects victims based on age, it prevents node victims
+	 * from being selected. This is because node blocks can be invalidated
+	 * by moving data blocks.
+	 */
+	if (__skip_node_gc(sbi, ve->segno))
+		goto skip;
+
 	/* age = 10000 * x% * 60 */
 	age = div64_u64(accu * (max_mtime - ve->mtime), total_time) *
 								age_weight;
@@ -913,7 +943,22 @@ int f2fs_get_victim(struct f2fs_sb_info *sbi, unsigned int *result,
 		goto retry;
 	}
 
+
 	if (p.min_segno != NULL_SEGNO) {
+		if (sbi->require_node_gc &&
+		    IS_DATASEG(get_seg_entry(sbi, p.min_segno)->type)) {
+			 /*
+			  * We need to clean node sections. but, data victim
+			  * cost is the lowest. If free sections are enough,
+			  * stop cleaning node victim. If not, it goes on
+			  * by GCing data victims.
+			  */
+			if (has_enough_free_secs(sbi, prefree_segments(sbi), 0)) {
+				sbi->require_node_gc = false;
+				p.min_segno = NULL_SEGNO;
+				goto out;
+			}
+		}
 got_it:
 		*result = (p.min_segno / p.ofs_unit) * p.ofs_unit;
 got_result:
@@ -1830,8 +1875,27 @@ int f2fs_gc(struct f2fs_sb_info *sbi, struct f2fs_gc_control *gc_control)
 		goto stop;
 	}
 
+	__get_secs_required(sbi, NULL, &upper_secs, NULL);
+
+	/*
+	 * Write checkpoint to reclaim prefree segments.
+	 * We need more three extra sections for writer's data/node/dentry.
+	 */
+	if (free_sections(sbi) <= upper_secs + NR_GC_CHECKPOINT_SECS) {
+		sbi->require_node_gc = true;
+
+		if (prefree_segments(sbi)) {
+			stat_inc_cp_call_count(sbi, TOTAL_CALL);
+			ret = f2fs_write_checkpoint(sbi, &cpc);
+			if (ret)
+				goto stop;
+			/* Reset due to checkpoint */
+			sec_freed = 0;
+		}
+	}
+
 	/* Let's run FG_GC, if we don't have enough space. */
-	if (has_not_enough_free_secs(sbi, 0, 0)) {
+	if (gc_type == BG_GC && has_not_enough_free_secs(sbi, 0, 0)) {
 		gc_type = FG_GC;
 
 		/*
@@ -1882,7 +1946,13 @@ int f2fs_gc(struct f2fs_sb_info *sbi, struct f2fs_gc_control *gc_control)
 			if (!gc_control->no_bg_gc &&
 			    total_sec_freed < gc_control->nr_free_secs)
 				goto go_gc_more;
-			goto stop;
+			/*
+			 * If require_node_gc flag is set even though there
+			 * are enough free sections, node cleaning will
+			 * continue.
+			 */
+			if (!sbi->require_node_gc)
+				goto stop;
 		}
 		if (sbi->skipped_gc_rwsem)
 			skipped_round++;
@@ -1897,21 +1967,6 @@ int f2fs_gc(struct f2fs_sb_info *sbi, struct f2fs_gc_control *gc_control)
 		goto stop;
 	}
 
-	__get_secs_required(sbi, NULL, &upper_secs, NULL);
-
-	/*
-	 * Write checkpoint to reclaim prefree segments.
-	 * We need more three extra sections for writer's data/node/dentry.
-	 */
-	if (free_sections(sbi) <= upper_secs + NR_GC_CHECKPOINT_SECS &&
-				prefree_segments(sbi)) {
-		stat_inc_cp_call_count(sbi, TOTAL_CALL);
-		ret = f2fs_write_checkpoint(sbi, &cpc);
-		if (ret)
-			goto stop;
-		/* Reset due to checkpoint */
-		sec_freed = 0;
-	}
 go_gc_more:
 	segno = NULL_SEGNO;
 	goto gc_more;
@@ -1920,8 +1975,10 @@ int f2fs_gc(struct f2fs_sb_info *sbi, struct f2fs_gc_control *gc_control)
 	SIT_I(sbi)->last_victim[ALLOC_NEXT] = 0;
 	SIT_I(sbi)->last_victim[FLUSH_DEVICE] = gc_control->victim_segno;
 
-	if (gc_type == FG_GC)
+	if (gc_type == FG_GC) {
 		f2fs_unpin_all_sections(sbi, true);
+		sbi->require_node_gc = false;
+	}
 
 	trace_f2fs_gc_end(sbi->sb, ret, total_freed, total_sec_freed,
 				get_pages(sbi, F2FS_DIRTY_NODES),
diff --git a/fs/f2fs/gc.h b/fs/f2fs/gc.h
index 28a00942802c..cd07bf125177 100644
--- a/fs/f2fs/gc.h
+++ b/fs/f2fs/gc.h
@@ -166,3 +166,9 @@ static inline bool has_enough_invalid_blocks(struct f2fs_sb_info *sbi)
 		free_user_blocks(sbi) <
 			limit_free_user_blocks(invalid_user_blocks));
 }
+
+static inline bool __skip_node_gc(struct f2fs_sb_info *sbi, unsigned int segno)
+{
+	return (IS_NODESEG(get_seg_entry(sbi, segno)->type) &&
+		!sbi->require_node_gc);
+}
-- 
2.34.1


