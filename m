Return-Path: <linux-kernel+bounces-55693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D1EC84C019
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 23:33:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03846288F77
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 22:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB0B31CD26;
	Tue,  6 Feb 2024 22:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DSFz46fx"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E401C694
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 22:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707258790; cv=none; b=E9OqfTWT1WqlUSWOX8W+Gxvv3kfclLKV65rMMmlX+HeZqV3H35veewRAqUKQMNO6QlvrTU48UFDb9ervok/c1Cwn+o7afPpvNSovPM7G+ElYsPpRVH1qjM2L9FhhJwdATjhXdOMd99TV8Aa3nT4+cFcjwV9ytW7Y3k56L1oPNQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707258790; c=relaxed/simple;
	bh=VPLzgYSU/JVdj5M5bhzldmNLypV0tiHKJ2uCNlyny0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rXsNtcRnCTkHvnbo/11fpZCFgrZx0u/WbuZWAQxTW2qewpmP8c/cBWcm4RV4dhdtefgM2YfQfiGpYRrNOVZTGpj9v/FBFfYb0Xz7Z8VZgWydl8Kc0Vz+c4HdYIfA2B83ZyMhROzXd1F+yAGj6ao9wmR3Utbx5vaDoSvZWuILFFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DSFz46fx; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1d71cb97937so246965ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 14:33:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707258787; x=1707863587; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wX4f3WxNax0yrGD3k4jTwh/vCGQc2wn1RTN07jtNKD0=;
        b=DSFz46fxEkyrlL98sGiICCWHGTkY4gRRgDBUOCQ89IFJ4W8ElymPsqvMTFReUKlWnu
         IACO9JLCepWYHDcEqxDMohcsu0wglNvTAa9u9Q72L6Y261zHQNPqO8nxIOdSd0zDNlGj
         M/rU4d+LPgeYZWljAP/1/VgD68UL6hJvuso/wJfnQOktBFPlmZdIscHNendMr/j8b20+
         HI/ZaXWszb35RsUt0y1tbYKbzg7PT7E628Zb6e5t1icwZHAAGofakjC77I/q1Ep7T3Ep
         NqbfvvtXxbG1fSDPj64qHOD2kEGvAOIz9pte7Ua3JByi5kt6w8P5iengPCx25ab6AMiR
         Xc7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707258787; x=1707863587;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wX4f3WxNax0yrGD3k4jTwh/vCGQc2wn1RTN07jtNKD0=;
        b=Q60qiNC6OHlR/a/JnLxIZ5YGPv3C+GPXiPjuk/ZMf7oM01GUA4TNJ/7nEyIcmvPjFO
         tAQets+JaGaYWV4UoatkSbfg2EUuXgNSWq5mkWA6HPAP3fU7EMVqvuVThX+7oqSxgfVU
         SIq5ivXnlBLZFX/fJ4Au3Frucq5Y9wv0SjO94j2LRO14xHzm5y6Dru4tdQQBb4wRSHuz
         Q+MapjgLGgz+rKPnS4nQVCbyLhGZ2YtAtE4yKS37BG5tNpZPIbq6SvNigTx7wRMu6Fad
         WpGZPECrHgAdJi4eF98GqM/+ykK/pRgvvNdpSBJPquIPKT4q4w8LCoYZeD9dn4TWWFaC
         toig==
X-Gm-Message-State: AOJu0YyngGU9fSd2kzn/hoL2HlmnVdDwpJIB1sf8c0xrzuG49xkHWQIa
	Sj6C6k2m0v+eJO+p/UT+V1F07HWxmnF8+VgzXsk6/Q1ZeYaTKc3ZBtxkpv7z
X-Google-Smtp-Source: AGHT+IHfgJmvmNrZmd4aXfeVQ89FIAnMw/1SID/bJpZjM5E3+xKmKxuoA6/aiTxv2qPGZnjPba45gw==
X-Received: by 2002:a17:903:2384:b0:1d9:8082:4577 with SMTP id v4-20020a170903238400b001d980824577mr3344088plh.17.1707258787618;
        Tue, 06 Feb 2024 14:33:07 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWNOpv8rOlo8TCfKwGJroovU1eMRu/KL1OCxn0n6wFaqz2gpI03/r7Ik9ituO9iOkDmBfExo3HmdF8WGKPcQlzMfLaUKv2vKHK0FNi2YE712lJG3vIPdR2lz8FWF9XBbyAsJDN4/lSxOkQiHWVPb9smRXq3yc5MitIO5BvQiwkX8yBcfg==
Received: from daehojeong-desktop.mtv.corp.google.com ([2620:0:1000:8411:6e38:9e6f:4818:7d04])
        by smtp.gmail.com with ESMTPSA id n3-20020a170902dc8300b001d6f091ca04sm32371pld.13.2024.02.06.14.33.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 14:33:07 -0800 (PST)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	kernel-team@android.com
Cc: Daeho Jeong <daehojeong@google.com>,
	Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 3/3] f2fs: support swap file pinning for zoned devices
Date: Tue,  6 Feb 2024 14:32:57 -0800
Message-ID: <20240206223257.3461359-3-daeho43@gmail.com>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
In-Reply-To: <20240206223257.3461359-1-daeho43@gmail.com>
References: <20240206223257.3461359-1-daeho43@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Daeho Jeong <daehojeong@google.com>

Support swap file pinning for zoned devices

Signed-off-by: Daeho Jeong <daehojeong@google.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/data.c | 54 ++++++++++++++++++++++++++++++++------------------
 1 file changed, 35 insertions(+), 19 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 05158f89ef32..5d8ee6e73dbe 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -3905,28 +3905,40 @@ static int f2fs_migrate_blocks(struct inode *inode, block_t start_blk,
 							unsigned int blkcnt)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
+	struct f2fs_map_blocks map = { .m_next_pgofs = NULL,
+		.m_next_extent = NULL, .m_seg_type = CURSEG_COLD_DATA_PINNED,
+		.m_may_create = true };
 	unsigned int blkofs;
 	unsigned int blk_per_sec = BLKS_PER_SEC(sbi);
 	unsigned int secidx = start_blk / blk_per_sec;
-	unsigned int end_sec = secidx + blkcnt / blk_per_sec;
+	unsigned int end_sec;
 	int ret = 0;
 
+	if (!blkcnt)
+		return 0;
+	end_sec = secidx + (blkcnt - 1) / blk_per_sec;
+
 	f2fs_down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
 	filemap_invalidate_lock(inode->i_mapping);
 
 	set_inode_flag(inode, FI_ALIGNED_WRITE);
 	set_inode_flag(inode, FI_OPU_WRITE);
 
-	for (; secidx < end_sec; secidx++) {
+	for (; secidx <= end_sec; secidx++) {
+		unsigned int blkofs_end = secidx == end_sec ?
+			(blkcnt - 1) % blk_per_sec : blk_per_sec - 1;
+
 		f2fs_down_write(&sbi->pin_sem);
 
-		f2fs_lock_op(sbi);
-		f2fs_allocate_new_section(sbi, CURSEG_COLD_DATA_PINNED, false);
-		f2fs_unlock_op(sbi);
+		ret = f2fs_allocate_pinning_section(sbi);
+		if (ret) {
+			f2fs_up_write(&sbi->pin_sem);
+			break;
+		}
 
 		set_inode_flag(inode, FI_SKIP_WRITES);
 
-		for (blkofs = 0; blkofs < blk_per_sec; blkofs++) {
+		for (blkofs = 0; blkofs <= blkofs_end; blkofs++) {
 			struct page *page;
 			unsigned int blkidx = secidx * blk_per_sec + blkofs;
 
@@ -3944,6 +3956,12 @@ static int f2fs_migrate_blocks(struct inode *inode, block_t start_blk,
 		clear_inode_flag(inode, FI_SKIP_WRITES);
 
 		ret = filemap_fdatawrite(inode->i_mapping);
+		if (!ret && blkofs != blk_per_sec) {
+			map.m_lblk = secidx * blk_per_sec + blkofs;
+			map.m_len = blk_per_sec - blkofs;
+			ret = f2fs_map_blocks(inode, &map,
+					F2FS_GET_BLOCK_PRE_DIO);
+		}
 
 		f2fs_up_write(&sbi->pin_sem);
 
@@ -4015,19 +4033,17 @@ static int check_swap_activate(struct swap_info_struct *sis,
 		nr_pblocks = map.m_len;
 
 		if ((pblock - SM_I(sbi)->main_blkaddr) & sec_blks_mask ||
-				nr_pblocks & sec_blks_mask) {
+				nr_pblocks & sec_blks_mask ||
+				!f2fs_valid_pinned_area(sbi, pblock)) {
 			not_aligned++;
 
 			nr_pblocks = roundup(nr_pblocks, blks_per_sec);
 			if (cur_lblock + nr_pblocks > sis->max)
 				nr_pblocks -= blks_per_sec;
 
-			if (!nr_pblocks) {
-				/* this extent is last one */
-				nr_pblocks = map.m_len;
-				f2fs_warn(sbi, "Swapfile: last extent is not aligned to section");
-				goto next;
-			}
+			/* this extent is last one */
+			if (!nr_pblocks)
+				nr_pblocks = last_lblock - cur_lblock;
 
 			ret = f2fs_migrate_blocks(inode, cur_lblock,
 							nr_pblocks);
@@ -4035,7 +4051,7 @@ static int check_swap_activate(struct swap_info_struct *sis,
 				goto out;
 			goto retry;
 		}
-next:
+
 		if (cur_lblock + nr_pblocks >= sis->max)
 			nr_pblocks = sis->max - cur_lblock;
 
@@ -4073,17 +4089,17 @@ static int f2fs_swap_activate(struct swap_info_struct *sis, struct file *file,
 				sector_t *span)
 {
 	struct inode *inode = file_inode(file);
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	int ret;
 
 	if (!S_ISREG(inode->i_mode))
 		return -EINVAL;
 
-	if (f2fs_readonly(F2FS_I_SB(inode)->sb))
+	if (f2fs_readonly(sbi->sb))
 		return -EROFS;
 
-	if (f2fs_lfs_mode(F2FS_I_SB(inode))) {
-		f2fs_err(F2FS_I_SB(inode),
-			"Swapfile not supported in LFS mode");
+	if (f2fs_lfs_mode(sbi) && !f2fs_sb_has_blkzoned(sbi)) {
+		f2fs_err(sbi, "Swapfile not supported in LFS mode");
 		return -EINVAL;
 	}
 
@@ -4102,7 +4118,7 @@ static int f2fs_swap_activate(struct swap_info_struct *sis, struct file *file,
 
 	stat_inc_swapfile_inode(inode);
 	set_inode_flag(inode, FI_PIN_FILE);
-	f2fs_update_time(F2FS_I_SB(inode), REQ_TIME);
+	f2fs_update_time(sbi, REQ_TIME);
 	return ret;
 }
 
-- 
2.43.0.594.gd9cf4e227d-goog


