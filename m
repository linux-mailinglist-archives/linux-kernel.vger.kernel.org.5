Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26A8175E844
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 03:39:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232040AbjGXBjW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 21:39:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbjGXBiq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 21:38:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D888FE46;
        Sun, 23 Jul 2023 18:34:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4DF4C60FAC;
        Mon, 24 Jul 2023 01:32:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 265C5C433C8;
        Mon, 24 Jul 2023 01:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690162344;
        bh=HrUrldwtVX/tddCm7qDMDc6GixHAwNtkvVtRwqsJXAI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nF2CBjqclMkMV9L9RBasXUZySQ4WgAJHWfAED2tnVGvHavkEzjX7Heu494MxMQkiY
         n889C+8hpBXlKP6PFzelnUWZgaJDOgvOXgzWAcYWYmHDAfzZowRoIH7tq/I3xAo2gO
         uoaPWay9k041AtNXpFYszoVvbuF0GNuTgmtUwarYqcWcWOli+b4wWVzmahckJjGv2p
         f+70rxGTH6j55cy9pBuaXndlXHk8TiZNsv/7MC6kZBCHlHFK7XRVrpBLR3k6OaP34t
         ZNNGhgPB/b3lAMOLHO3dgUTbKF1spGkm1n2XQwi5Uo1UdH+CgAz6GIDFAgJq5/Gcdo
         iCc7X7xuwGO8w==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 6.4 32/40] fs/ntfs3: Alternative boot if primary boot is corrupted
Date:   Sun, 23 Jul 2023 21:31:32 -0400
Message-Id: <20230724013140.2327815-32-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230724013140.2327815-1-sashal@kernel.org>
References: <20230724013140.2327815-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.4.5
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>

[ Upstream commit 6a4cd3ea7d771be17177d95ff67d22cfa2a38b50 ]

Some code refactoring added also.

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ntfs3/super.c | 98 +++++++++++++++++++++++++++++++++++-------------
 1 file changed, 71 insertions(+), 27 deletions(-)

diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index 5158dd31fd97f..ecf899d571d83 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -724,6 +724,8 @@ static int ntfs_init_from_boot(struct super_block *sb, u32 sector_size,
 	struct MFT_REC *rec;
 	u16 fn, ao;
 	u8 cluster_bits;
+	u32 boot_off = 0;
+	const char *hint = "Primary boot";
 
 	sbi->volume.blocks = dev_size >> PAGE_SHIFT;
 
@@ -731,11 +733,12 @@ static int ntfs_init_from_boot(struct super_block *sb, u32 sector_size,
 	if (!bh)
 		return -EIO;
 
+check_boot:
 	err = -EINVAL;
-	boot = (struct NTFS_BOOT *)bh->b_data;
+	boot = (struct NTFS_BOOT *)Add2Ptr(bh->b_data, boot_off);
 
 	if (memcmp(boot->system_id, "NTFS    ", sizeof("NTFS    ") - 1)) {
-		ntfs_err(sb, "Boot's signature is not NTFS.");
+		ntfs_err(sb, "%s signature is not NTFS.", hint);
 		goto out;
 	}
 
@@ -748,14 +751,16 @@ static int ntfs_init_from_boot(struct super_block *sb, u32 sector_size,
 			   boot->bytes_per_sector[0];
 	if (boot_sector_size < SECTOR_SIZE ||
 	    !is_power_of_2(boot_sector_size)) {
-		ntfs_err(sb, "Invalid bytes per sector %u.", boot_sector_size);
+		ntfs_err(sb, "%s: invalid bytes per sector %u.", hint,
+			 boot_sector_size);
 		goto out;
 	}
 
 	/* cluster size: 512, 1K, 2K, 4K, ... 2M */
 	sct_per_clst = true_sectors_per_clst(boot);
 	if ((int)sct_per_clst < 0 || !is_power_of_2(sct_per_clst)) {
-		ntfs_err(sb, "Invalid sectors per cluster %u.", sct_per_clst);
+		ntfs_err(sb, "%s: invalid sectors per cluster %u.", hint,
+			 sct_per_clst);
 		goto out;
 	}
 
@@ -771,8 +776,8 @@ static int ntfs_init_from_boot(struct super_block *sb, u32 sector_size,
 	if (mlcn * sct_per_clst >= sectors || mlcn2 * sct_per_clst >= sectors) {
 		ntfs_err(
 			sb,
-			"Start of MFT 0x%llx (0x%llx) is out of volume 0x%llx.",
-			mlcn, mlcn2, sectors);
+			"%s: start of MFT 0x%llx (0x%llx) is out of volume 0x%llx.",
+			hint, mlcn, mlcn2, sectors);
 		goto out;
 	}
 
@@ -784,7 +789,7 @@ static int ntfs_init_from_boot(struct super_block *sb, u32 sector_size,
 
 	/* Check MFT record size. */
 	if (record_size < SECTOR_SIZE || !is_power_of_2(record_size)) {
-		ntfs_err(sb, "Invalid bytes per MFT record %u (%d).",
+		ntfs_err(sb, "%s: invalid bytes per MFT record %u (%d).", hint,
 			 record_size, boot->record_size);
 		goto out;
 	}
@@ -801,13 +806,13 @@ static int ntfs_init_from_boot(struct super_block *sb, u32 sector_size,
 
 	/* Check index record size. */
 	if (sbi->index_size < SECTOR_SIZE || !is_power_of_2(sbi->index_size)) {
-		ntfs_err(sb, "Invalid bytes per index %u(%d).", sbi->index_size,
-			 boot->index_size);
+		ntfs_err(sb, "%s: invalid bytes per index %u(%d).", hint,
+			 sbi->index_size, boot->index_size);
 		goto out;
 	}
 
 	if (sbi->index_size > MAXIMUM_BYTES_PER_INDEX) {
-		ntfs_err(sb, "Unsupported bytes per index %u.",
+		ntfs_err(sb, "%s: unsupported bytes per index %u.", hint,
 			 sbi->index_size);
 		goto out;
 	}
@@ -834,7 +839,7 @@ static int ntfs_init_from_boot(struct super_block *sb, u32 sector_size,
 
 	/* Compare boot's cluster and sector. */
 	if (sbi->cluster_size < boot_sector_size) {
-		ntfs_err(sb, "Invalid bytes per cluster (%u).",
+		ntfs_err(sb, "%s: invalid bytes per cluster (%u).", hint,
 			 sbi->cluster_size);
 		goto out;
 	}
@@ -930,7 +935,46 @@ static int ntfs_init_from_boot(struct super_block *sb, u32 sector_size,
 
 	err = 0;
 
+	if (bh->b_blocknr && !sb_rdonly(sb)) {
+		/*
+	 	 * Alternative boot is ok but primary is not ok.
+	 	 * Update primary boot.
+		 */
+		struct buffer_head *bh0 = sb_getblk(sb, 0);
+		if (bh0) {
+			if (buffer_locked(bh0))
+				__wait_on_buffer(bh0);
+
+			lock_buffer(bh0);
+			memcpy(bh0->b_data, boot, sizeof(*boot));
+			set_buffer_uptodate(bh0);
+			mark_buffer_dirty(bh0);
+			unlock_buffer(bh0);
+			if (!sync_dirty_buffer(bh0))
+				ntfs_warn(sb, "primary boot is updated");
+			put_bh(bh0);
+		}
+	}
+
 out:
+	if (err == -EINVAL && !bh->b_blocknr && dev_size > PAGE_SHIFT) {
+		u32 block_size = min_t(u32, sector_size, PAGE_SIZE);
+		u64 lbo = dev_size - sizeof(*boot);
+
+		/*
+	 	 * Try alternative boot (last sector)
+		 */
+		brelse(bh);
+
+		sb_set_blocksize(sb, block_size);
+		bh = ntfs_bread(sb, lbo >> blksize_bits(block_size));
+		if (!bh)
+			return -EINVAL;
+
+		boot_off = lbo & (block_size - 1);
+		hint = "Alternative boot";
+		goto check_boot;
+	}
 	brelse(bh);
 
 	return err;
@@ -955,6 +999,7 @@ static int ntfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	struct ATTR_DEF_ENTRY *t;
 	u16 *shared;
 	struct MFT_REF ref;
+	bool ro = sb_rdonly(sb);
 
 	ref.high = 0;
 
@@ -1035,6 +1080,10 @@ static int ntfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	sbi->volume.minor_ver = info->minor_ver;
 	sbi->volume.flags = info->flags;
 	sbi->volume.ni = ni;
+	if (info->flags & VOLUME_FLAG_DIRTY) {
+		sbi->volume.real_dirty = true;
+		ntfs_info(sb, "It is recommened to use chkdsk.");
+	}
 
 	/* Load $MFTMirr to estimate recs_mirr. */
 	ref.low = cpu_to_le32(MFT_REC_MIRR);
@@ -1069,21 +1118,16 @@ static int ntfs_fill_super(struct super_block *sb, struct fs_context *fc)
 
 	iput(inode);
 
-	if (sbi->flags & NTFS_FLAGS_NEED_REPLAY) {
-		if (!sb_rdonly(sb)) {
-			ntfs_warn(sb,
-				  "failed to replay log file. Can't mount rw!");
-			err = -EINVAL;
-			goto out;
-		}
-	} else if (sbi->volume.flags & VOLUME_FLAG_DIRTY) {
-		if (!sb_rdonly(sb) && !options->force) {
-			ntfs_warn(
-				sb,
-				"volume is dirty and \"force\" flag is not set!");
-			err = -EINVAL;
-			goto out;
-		}
+	if ((sbi->flags & NTFS_FLAGS_NEED_REPLAY) && !ro) {
+		ntfs_warn(sb, "failed to replay log file. Can't mount rw!");
+		err = -EINVAL;
+		goto out;
+	}
+
+	if ((sbi->volume.flags & VOLUME_FLAG_DIRTY) && !ro && !options->force) {
+		ntfs_warn(sb, "volume is dirty and \"force\" flag is not set!");
+		err = -EINVAL;
+		goto out;
 	}
 
 	/* Load $MFT. */
@@ -1173,7 +1217,7 @@ static int ntfs_fill_super(struct super_block *sb, struct fs_context *fc)
 
 		bad_len += len;
 		bad_frags += 1;
-		if (sb_rdonly(sb))
+		if (ro)
 			continue;
 
 		if (wnd_set_used_safe(&sbi->used.bitmap, lcn, len, &tt) || tt) {
-- 
2.39.2

