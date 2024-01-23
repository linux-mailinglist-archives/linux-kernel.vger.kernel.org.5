Return-Path: <linux-kernel+bounces-34617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24830838400
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 03:31:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 474701C2A038
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 02:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CF78664C1;
	Tue, 23 Jan 2024 01:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="R6l4XHZv"
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 519134F212
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 01:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705975191; cv=none; b=bRmKlX9oXi7qPWKxY11cobKwns5gKjdJfvpDO8f9EjzTN7TbTnh4Z/HfkEKrJoShc4+QUoRAt2+KIVwogvQS+cz4TNcY8IjirF9SMcKyK+VvEEMwytvNxs0htzTEj2Xx47RRDexFuero/qQNX8cEyVqsZ+54oCrcNsAtpCRMvio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705975191; c=relaxed/simple;
	bh=jI0D5I09Ebk4cJGo2aYlRoO24V0wfZin3X4tXvqqrB8=;
	h=Mime-Version:Subject:From:To:CC:Message-ID:Date:Content-Type:
	 References; b=cSIJ4dxOtUwn0tYV2ddoJaJCmNWC3glvV4LiSMHUo68LuMKa3Ie1eaYTcGnsDF5xV6LvWayf0WmOMS3QITr/SBC3fadnoNZcLh3sQ/MJa0eULcZTKHqmJa6tDQZENSpf7AvlUtVV+7liGGpdndt9FW5MF5UP9W+4JVdXBMA8hfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=R6l4XHZv; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20240123015945epoutp0225175af7cd8fd6ab50112f7100aa6dc4~s12ScSu7H0688106881epoutp02X
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 01:59:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20240123015945epoutp0225175af7cd8fd6ab50112f7100aa6dc4~s12ScSu7H0688106881epoutp02X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1705975186;
	bh=NbV57ub5RxC2cw5lolUDPU7EviU8ooY1FLIH2oklQbc=;
	h=Subject:Reply-To:From:To:CC:Date:References:From;
	b=R6l4XHZvTM6YhcRFcqJGAQrmPnsvuoQsPkSSi8lIOCsmHk1Ydud2CRHnZHVelebwd
	 3+MsscnfkC91JeIQNTYxwr07HN28IsVM2fXFf512Wcahmv5smr2WCjPIbydoGdG4O6
	 d6nMA4jt81EzEraXHtuvxGvmRXmiWR9fDhkb7Hu0=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas2p3.samsung.com (KnoxPortal) with ESMTP id
	20240123015945epcas2p3799d3e57f3a2eb4ebfd830da3fa3b3c8~s12SG7_tW2662726627epcas2p3h;
	Tue, 23 Jan 2024 01:59:45 +0000 (GMT)
Received: from epsmgec2p1-new.samsung.com (unknown [182.195.36.98]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4TJqz507Clz4x9QG; Tue, 23 Jan
	2024 01:59:45 +0000 (GMT)
X-AuditID: b6c32a4d-9f7ff70000004a32-6f-65af1d8f08b1
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
	epsmgec2p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	46.AC.18994.F8D1FA56; Tue, 23 Jan 2024 10:59:43 +0900 (KST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: [PATCH v5] f2fs: New victim selection for GC
Reply-To: yonggil.song@samsung.com
Sender: Yonggil Song <yonggil.song@samsung.com>
From: Yonggil Song <yonggil.song@samsung.com>
To: "jaegeuk@kernel.org" <jaegeuk@kernel.org>, "chao@kernel.org"
	<chao@kernel.org>, "linux-f2fs-devel@lists.sourceforge.net"
	<linux-f2fs-devel@lists.sourceforge.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: Dongjin Kim <dongjin_.kim@samsung.com>, Daejun Park
	<daejun7.park@samsung.com>, Siwoo Jung <siu.jung@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20240123015943epcms2p3adba8a5ad6cb8f01d1265f269f8cb607@epcms2p3>
Date: Tue, 23 Jan 2024 10:59:43 +0900
X-CMS-MailID: 20240123015943epcms2p3adba8a5ad6cb8f01d1265f269f8cb607
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmphk+LIzCtJLcpLzFFi42LZdljTVLdfdn2qwaoVihanp55lslj1INzi
	x0kTiyfrZzFbXFrkbnF51xw2i/MTXzNZTD1/hMmBw2PTqk42j90LPjN59G1ZxejxeZNcAEtU
	tk1GamJKapFCal5yfkpmXrqtkndwvHO8qZmBoa6hpYW5kkJeYm6qrZKLT4CuW2YO0A1KCmWJ
	OaVAoYDE4mIlfTubovzSklSFjPziElul1IKUnALzAr3ixNzi0rx0vbzUEitDAwMjU6DChOyM
	77+msBUccqz4u4yrgfGwcRcjJ4eEgInE4c2zWbsYuTiEBPYwStw/+QjI4eDgFRCU+LtDGKRG
	WMBU4vfWJcwgtpCAksS1A70sEHF9ic2Ll7GD2GwCuhJ/NywHs0UEXjFKnFktCmIzC5RLLLu4
	jh1iF6/EjPanLBC2tMT25VsZIWwNiR/LepkhbFGJm6vfssPY74/Nh6oRkWi9dxaqRlDiwc/d
	UHFJiUWHzjNB2PkSf1dcZ4OwayS2NrRBxfUlrnVsZIF4y1fi4a0okDCLgKrEvdNToM5xkbj8
	uZ0N4mR5ie1v5zCDlDMLaEqs36UPYkoIKEscucUCUcEn0XH4L9xTO+Y9gVqkJrF502ZWCFtG
	4sLjNqgjPSQWvV7FDgnAQIkfG6YxTWBUmIUI5llI9s5C2LuAkXkVo1RqQXFuemqyUYGhbl5q
	OTxyk/NzNzGCk6OW7w7G1+v/6h1iZOJgPMQowcGsJMJ7Q3JdqhBvSmJlVWpRfnxRaU5q8SFG
	U6CvJzJLiSbnA9NzXkm8oYmlgYmZmaG5kamBuZI4773WuSlCAumJJanZqakFqUUwfUwcnFIN
	TF6XHjJ+/C3/vW1NYsLsjn9a+3c8vJ3moKL1JlfqeR/Xo3of/2v2vVf0I64drzoSXbiRs2br
	+fLuynMumhOi76x50dXqVz0pK5Lnc0D8oS1Cl/hu1Hu9i+0O2JTA287yyXXG2tZZXNkvflRL
	Ryb8u9xULPt1+RvnxJ0OalWP5kzvk+lVNbQ7W67FuPCjho3j6WBbv8oa5W2/FEXvSZjf3P7r
	RGftge4K8cw7/yemrXn6uur7lPZb3YXT4pdej5vaNLtD8lOv8ArphLoT18Su3dmu8Cpj5YHd
	D+LOJJuJnZpfOEHUPCTfQPFXwbdXEhfn9gtY/VvR7PO22f6g5Uehm54P/9gk/Nj5PdJOa4Ki
	mBJLcUaioRZzUXEiAGDGZlkXBAAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240123015943epcms2p3adba8a5ad6cb8f01d1265f269f8cb607
References: <CGME20240123015943epcms2p3adba8a5ad6cb8f01d1265f269f8cb607@epcms2p3>

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
 fs/f2fs/gc.c   | 96 +++++++++++++++++++++++++++++++++++++++-----------
 fs/f2fs/gc.h   |  6 ++++
 3 files changed, 82 insertions(+), 21 deletions(-)

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
index f550cdeaa663..ae1e960eaf5a 100644
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
+		unsigned int weight = 0;
+
+		if (__skip_node_gc(sbi, segno))
+			weight = sbi->segs_per_sec << sbi->log_blocks_per_seg;
+
+		return get_valid_blocks(sbi, segno, true) + weight;
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
@@ -1830,8 +1860,27 @@ int f2fs_gc(struct f2fs_sb_info *sbi, struct f2fs_gc_control *gc_control)
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
@@ -1866,6 +1915,18 @@ int f2fs_gc(struct f2fs_sb_info *sbi, struct f2fs_gc_control *gc_control)
 		goto stop;
 	}
 
+	if (sbi->require_node_gc &&
+	    IS_DATASEG(get_seg_entry(sbi, segno)->type)) {
+		/*
+		 * We need to clean node sections. but, data victim
+		 * cost is the lowest. If free sections are enough,
+		 * stop cleaning node victim. If not, it goes on
+		 * by GCing data victims.
+		 */
+		if (has_enough_free_secs(sbi, sec_freed, 0))
+			goto stop;
+	}
+
 	seg_freed = do_garbage_collect(sbi, segno, &gc_list, gc_type,
 				gc_control->should_migrate_blocks);
 	total_freed += seg_freed;
@@ -1882,7 +1943,13 @@ int f2fs_gc(struct f2fs_sb_info *sbi, struct f2fs_gc_control *gc_control)
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
@@ -1897,21 +1964,6 @@ int f2fs_gc(struct f2fs_sb_info *sbi, struct f2fs_gc_control *gc_control)
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
@@ -1920,8 +1972,10 @@ int f2fs_gc(struct f2fs_sb_info *sbi, struct f2fs_gc_control *gc_control)
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


