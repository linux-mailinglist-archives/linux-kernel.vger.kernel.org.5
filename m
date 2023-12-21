Return-Path: <linux-kernel+bounces-7872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F09B781AE89
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 06:56:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BEDF1C221EE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 05:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D2C0B642;
	Thu, 21 Dec 2023 05:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="puWWaEl1"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80503AD51
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 05:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20231221055631epoutp017a01ef3f920f7a7ea6c414dd34c6a3a5~iwyl1ercM2672226722epoutp01X
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 05:56:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20231221055631epoutp017a01ef3f920f7a7ea6c414dd34c6a3a5~iwyl1ercM2672226722epoutp01X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1703138191;
	bh=PfgH9IEjjrpOGSzq5Vmy1Ag86e6ztIeWWXYEJNjG/qE=;
	h=Subject:Reply-To:From:To:Date:References:From;
	b=puWWaEl1EtVkmQ6HsrvozLo8tvF/f6d1ezD+lycEJ/S3k4wkwfcyxFnLQiBn+GgBO
	 XYA0zfqyfLNlOxe0hUw0giGFV8zwon0tOfBWizG58AZpFKy4kWrNKRVeWybCQ5CZdM
	 YTRjlgssO49WD0611Y0S5xk2sjzohetvnsPh/Suc=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas2p4.samsung.com (KnoxPortal) with ESMTP id
	20231221055631epcas2p46732e2dbd5148bfa9d0e8f80e943252b~iwylN-CtQ1320913209epcas2p4n;
	Thu, 21 Dec 2023 05:56:31 +0000 (GMT)
Received: from epsmgec2p1.samsung.com (unknown [182.195.36.97]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4SwfnV4mJrz4x9Q6; Thu, 21 Dec
	2023 05:56:30 +0000 (GMT)
X-AuditID: b6c32a43-4b3ff700000021c8-2f-6583d38e89e9
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
	epsmgec2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
	5F.A5.08648.E83D3856; Thu, 21 Dec 2023 14:56:30 +0900 (KST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: [PATCH v3] f2fs: New victim selection for GC
Reply-To: yonggil.song@samsung.com
Sender: Yonggil Song <yonggil.song@samsung.com>
From: Yonggil Song <yonggil.song@samsung.com>
To: "jaegeuk@kernel.org" <jaegeuk@kernel.org>, "chao@kernel.org"
	<chao@kernel.org>, "linux-f2fs-devel@lists.sourceforge.net"
	<linux-f2fs-devel@lists.sourceforge.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Seokhwan Kim <sukka.kim@samsung.com>, Daejun
	Park <daejun7.park@samsung.com>, Siwoo Jung <siu.jung@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20231221055630epcms2p25ae1ac5e4509d5c8ba7f338b51592e53@epcms2p2>
Date: Thu, 21 Dec 2023 14:56:30 +0900
X-CMS-MailID: 20231221055630epcms2p25ae1ac5e4509d5c8ba7f338b51592e53
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
X-CPGSPASS: Y
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjk+LIzCtJLcpLzFFi42LZdljTVLfvcnOqwafZyhanp55lsnh5SNNi
	1YNwiyfrZzFbXFrkbnF51xw2i/MTXzNZrOqYy2gx9fwRJgdOj02rOtk8di/4zOTRt2UVo8fn
	TXIBLFHZNhmpiSmpRQqpecn5KZl56bZK3sHxzvGmZgaGuoaWFuZKCnmJuam2Si4+AbpumTlA
	hygplCXmlAKFAhKLi5X07WyK8ktLUhUy8otLbJVSC1JyCswL9IoTc4tL89L18lJLrAwNDIxM
	gQoTsjOW3pct+O9UsfHHHJYGxh0mXYycHBICJhK3f31j62Lk4hAS2MEo0f/uN3sXIwcHr4Cg
	xN8dwiA1wgKmEnMabzOC2EICShLXDvSyQMT1JTYvXsYOYrMJ6Er83bAczBYRuMsk0dftDjGf
	V2JG+1MWCFtaYvvyrYwQtobEj2W9zBC2qMTN1W/ZYez3x+ZD1YhItN47C1UjKPHg526ouKTE
	okPnmSDsfIm/K66zQdg1Elsb2qDi+hLXOjaC7eUV8JWYM6MVzGYRUJX4PWcNK0SNi8SDFRDz
	mQXkJba/ncMM8jqzgKbE+l36IKaEgLLEkVssEBV8Eh2H/7LDfNWw8TdW9o55T6AuUJPYvGkz
	1CYZiQuP26Cu95DYs/Qv0wRGxVmIcJ6F5IZZCDcsYGRexSiWWlCcm56abFRgCI/Z5PzcTYzg
	BKnlvIPxyvx/eocYmTgYDzFKcDArifDu7WxKFeJNSaysSi3Kjy8qzUktPsRoCvT9RGYp0eR8
	YIrOK4k3NLE0MDEzMzQ3MjUwVxLnvdc6N0VIID2xJDU7NbUgtQimj4mDU6qBqW/jRe/P31IO
	xv2Qexz815GHQ/zb6rX/na5LsQRW7Jz6LSLbL1fyg4OXhKpJt0j2k60nmW8Xueb7/hVea3Xj
	7PKOREafOW/Weew5Hs1Xoi8QkLOM4+1xNoH/xcHCT3cwa3LYKDLvO/vnoeultTlrlbX3HAmQ
	/XC3aN99w/4E152/V/G/qPsT1trZc3XHjlLv8uXPHn9NNRPaJ7YvbIviW2unK7VsxibZLZsn
	x5ibTv6k2fr4UsleZoPax/FmW7+tSj139ULJPmnbpXe5U1sLjjsHRQutLFr4+Nc+55rM443V
	uyxmT18rMbtj0yIXXoNw8bsKSqff/XU2mTsvmK012qLttcHMs4uOfWXc23BDTYmlOCPRUIu5
	qDgRAHf4dDoZBAAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231221055630epcms2p25ae1ac5e4509d5c8ba7f338b51592e53
References: <CGME20231221055630epcms2p25ae1ac5e4509d5c8ba7f338b51592e53@epcms2p2>

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
 fs/f2fs/f2fs.h |   1 +
 fs/f2fs/gc.c   | 102 +++++++++++++++++++++++++++++++++++++++----------
 fs/f2fs/gc.h   |   6 +++
 3 files changed, 88 insertions(+), 21 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 9043cedfa12b..578d57f6022f 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1649,6 +1649,7 @@ struct f2fs_sb_info {
 	struct f2fs_mount_info mount_opt;	/* mount options */
 
 	/* for cleaning operations */
+	bool need_node_clean;			/* need to clean dirty nodes */
 	struct f2fs_rwsem gc_lock;		/*
 						 * semaphore for GC, avoid
 						 * race between GC and GC or CP
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index f550cdeaa663..da963765e087 100644
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
+	if (is_skip(sbi, segno))
+		return UINT_MAX;
+
 	for (i = 0; i < usable_segs_per_sec; i++)
 		mtime += get_seg_entry(sbi, start + i)->mtime;
 	vblocks = get_valid_blocks(sbi, segno, true);
@@ -369,10 +377,27 @@ static inline unsigned int get_gc_cost(struct f2fs_sb_info *sbi,
 		return get_seg_entry(sbi, segno)->ckpt_valid_blocks;
 
 	/* alloc_mode == LFS */
-	if (p->gc_mode == GC_GREEDY)
-		return get_valid_blocks(sbi, segno, true);
-	else if (p->gc_mode == GC_CB)
+	if (p->gc_mode == GC_GREEDY) {
+		unsigned int weight = 0;
+		unsigned int no_need = sbi->need_node_clean ? 0 : 1;
+		bool is_node =
+			IS_NODESEG(get_seg_entry(sbi, segno)->type);
+
+		/*
+		 * If the data block that the node block pointed to is GCed,
+		 * the node block is invalidated. For this reason, we add a
+		 * weight to cost of node victims to give priority to data
+		 * victims during the gc process. However, in a situation
+		 * where we run out of free sections, we remove the weight
+		 * because we need to clean up node blocks.
+		 */
+		weight = is_node ?
+			no_need * (sbi->blocks_per_seg * sbi->segs_per_sec) : 0;
+
+		return (get_valid_blocks(sbi, segno, true) + weight);
+	} else if (p->gc_mode == GC_CB) {
 		return get_cb_cost(sbi, segno);
+	}
 
 	f2fs_bug_on(sbi, 1);
 	return 0;
@@ -557,6 +582,14 @@ static void atgc_lookup_victim(struct f2fs_sb_info *sbi,
 	if (ve->mtime >= max_mtime || ve->mtime < min_mtime)
 		goto skip;
 
+	/*
+	 * When BG_GC selects victims based on age, it prevents node victims
+	 * from being selected. This is because node blocks can be invalidated
+	 * by moving data blocks.
+	 */
+	if (is_skip(sbi, ve->segno))
+		goto skip;
+
 	/* age = 10000 * x% * 60 */
 	age = div64_u64(accu * (max_mtime - ve->mtime), total_time) *
 								age_weight;
@@ -913,7 +946,22 @@ int f2fs_get_victim(struct f2fs_sb_info *sbi, unsigned int *result,
 		goto retry;
 	}
 
+
 	if (p.min_segno != NULL_SEGNO) {
+		if (sbi->need_node_clean &&
+		    IS_DATASEG(get_seg_entry(sbi, p.min_segno)->type)) {
+			 /*
+			  * We need to clean node sections. but, data victim
+			  * cost is the lowest. If free sections are enough,
+			  * stop cleaning node victim. If not, it goes on
+			  * by GCing data victims.
+			  */
+			if (has_enough_free_secs(sbi, prefree_segments(sbi), 0)) {
+				sbi->need_node_clean = false;
+				p.min_segno = NULL_SEGNO;
+				goto out;
+			}
+		}
 got_it:
 		*result = (p.min_segno / p.ofs_unit) * p.ofs_unit;
 got_result:
@@ -1830,8 +1878,27 @@ int f2fs_gc(struct f2fs_sb_info *sbi, struct f2fs_gc_control *gc_control)
 		goto stop;
 	}
 
+	__get_secs_required(sbi, NULL, &upper_secs, NULL);
+
+	/*
+	 * Write checkpoint to reclaim prefree segments.
+	 * We need more three extra sections for writer's data/node/dentry.
+	 */
+	if (free_sections(sbi) <= upper_secs + NR_GC_CHECKPOINT_SECS) {
+		sbi->need_node_clean = true;
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
@@ -1882,7 +1949,13 @@ int f2fs_gc(struct f2fs_sb_info *sbi, struct f2fs_gc_control *gc_control)
 			if (!gc_control->no_bg_gc &&
 			    total_sec_freed < gc_control->nr_free_secs)
 				goto go_gc_more;
-			goto stop;
+			/*
+			 * If need_node_clean flag is set even though there
+			 * are enough free sections, node cleaning will
+			 * continue.
+			 */
+			if (!sbi->need_node_clean)
+				goto stop;
 		}
 		if (sbi->skipped_gc_rwsem)
 			skipped_round++;
@@ -1897,21 +1970,6 @@ int f2fs_gc(struct f2fs_sb_info *sbi, struct f2fs_gc_control *gc_control)
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
@@ -1920,8 +1978,10 @@ int f2fs_gc(struct f2fs_sb_info *sbi, struct f2fs_gc_control *gc_control)
 	SIT_I(sbi)->last_victim[ALLOC_NEXT] = 0;
 	SIT_I(sbi)->last_victim[FLUSH_DEVICE] = gc_control->victim_segno;
 
-	if (gc_type == FG_GC)
+	if (gc_type == FG_GC) {
 		f2fs_unpin_all_sections(sbi, true);
+		sbi->need_node_clean = false;
+	}
 
 	trace_f2fs_gc_end(sbi->sb, ret, total_freed, total_sec_freed,
 				get_pages(sbi, F2FS_DIRTY_NODES),
diff --git a/fs/f2fs/gc.h b/fs/f2fs/gc.h
index 28a00942802c..b0af7c086b66 100644
--- a/fs/f2fs/gc.h
+++ b/fs/f2fs/gc.h
@@ -166,3 +166,9 @@ static inline bool has_enough_invalid_blocks(struct f2fs_sb_info *sbi)
 		free_user_blocks(sbi) <
 			limit_free_user_blocks(invalid_user_blocks));
 }
+
+static inline bool is_skip(struct f2fs_sb_info *sbi, unsigned int segno)
+{
+	return (IS_NODESEG(get_seg_entry(sbi, segno)->type) &&
+		!sbi->need_node_clean);
+}
-- 
2.34.1


