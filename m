Return-Path: <linux-kernel+bounces-122493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC9B188F87B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 08:21:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A23E1C247CA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 07:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A48851C3E;
	Thu, 28 Mar 2024 07:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lifRrg5Q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0AD64F5F2
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 07:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711610506; cv=none; b=ts0irAAxRClD/FIz+gT+U9dE7KvifY+UwSmlZNbhaa+LHFtLbJLLFn0Gfibdu++ROsu8CraNYlWe0bLhpNz3aSw5Zz/FG4cjTx2ssLNtjFq/AMBk3X8iwB3NNjnL+IDygwLdfRyxbpr6KkSrRgA8BFf8X6ZNvQ3oW5HYpoTz5Z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711610506; c=relaxed/simple;
	bh=+c2g+QOTgg3995dvAWPf1MaHsDGDdMPE+6RXTZkhIfU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=neEnPif2gEKHDtUkcpoHovz8z32ZiuNAB1EO9wXwtofb7AcAvFJfB9Zd6dZqhmkA7TZCJOZJFFRD+7TkNtP4p1YA+5xW9Jc1ay/1mM5Qi3KiUZ8WGgNlGS9StiPmBVsnu54ifriODBe/MdMtL6GczBxVYhDgwKK3TXFVxBat1ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lifRrg5Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDBE2C433F1;
	Thu, 28 Mar 2024 07:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711610506;
	bh=+c2g+QOTgg3995dvAWPf1MaHsDGDdMPE+6RXTZkhIfU=;
	h=From:To:Cc:Subject:Date:From;
	b=lifRrg5QafFFOULEjnABkBHqjSe3HGSscym8oS9j8noUEpXmokgf5nu5DkPvMfv1e
	 KnSKru2ZKysI2Td1Zlj9qUtsow7d/Qtd0JD1/Idy8JteuuLfdR4TrTNCM5OAaZ8Qsa
	 8nh6NGByrO7433qrcNrszUCD/6GZ84aeJwlaIEy3VlaN3BSOGh5xwxmLLm4cUgEZN3
	 nLEik4Ll6Nn9ZyKPipX4MvpUyRBHHNRG9kmlpYc64k0fI0rC+BvuR6i8N+ZVUvJASQ
	 XeAOB5QOFiTsFxLdrecXzj5ijVMNnGtm+6bqqFwroDqo6BcHLV6Z5qCiutJAdKjk0g
	 0BWix70blxtgA==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Wenjie Qi <qwjhust@gmail.com>,
	Chao Yu <chao@kernel.org>
Subject: [PATCH v6] f2fs: fix zoned block device information initialization
Date: Thu, 28 Mar 2024 15:21:36 +0800
Message-Id: <20240328072136.3023135-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wenjie Qi <qwjhust@gmail.com>

If the max open zones of zoned devices are less than
the active logs of F2FS, the device may error due to
insufficient zone resources when multiple active logs
are being written at the same time.

Signed-off-by: Wenjie Qi <qwjhust@gmail.com>
Signed-off-by: Chao Yu <chao@kernel.org>
---
v6:
- add check condition to avoid remount failure.
 fs/f2fs/f2fs.h  |  1 +
 fs/f2fs/super.c | 27 +++++++++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 0550929dc6e5..694f8a52cb84 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1559,6 +1559,7 @@ struct f2fs_sb_info {
 
 #ifdef CONFIG_BLK_DEV_ZONED
 	unsigned int blocks_per_blkz;		/* F2FS blocks per zone */
+	unsigned int max_open_zones;		/* max open zone resources of the zoned device */
 #endif
 
 	/* for node-related operations */
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 7c45929671ad..642540782471 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2326,6 +2326,17 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 	if (err)
 		goto restore_opts;
 
+#ifdef CONFIG_BLK_DEV_ZONED
+	if (f2fs_is_multi_device(sbi) &&
+		sbi->max_open_zones < F2FS_OPTION(sbi).active_logs) {
+		f2fs_err(sbi,
+			"zoned: max open zones %u is too small, need at least %u open zones",
+				 sbi->max_open_zones, F2FS_OPTION(sbi).active_logs);
+		err = -EINVAL;
+		goto restore_opts;
+	}
+#endif
+
 	/* flush outstanding errors before changing fs state */
 	flush_work(&sbi->s_error_work);
 
@@ -3868,11 +3879,24 @@ static int init_blkz_info(struct f2fs_sb_info *sbi, int devi)
 	sector_t nr_sectors = bdev_nr_sectors(bdev);
 	struct f2fs_report_zones_args rep_zone_arg;
 	u64 zone_sectors;
+	unsigned int max_open_zones;
 	int ret;
 
 	if (!f2fs_sb_has_blkzoned(sbi))
 		return 0;
 
+	if (bdev_is_zoned(FDEV(devi).bdev)) {
+		max_open_zones = bdev_max_open_zones(bdev);
+		if (max_open_zones && (max_open_zones < sbi->max_open_zones))
+			sbi->max_open_zones = max_open_zones;
+		if (sbi->max_open_zones < F2FS_OPTION(sbi).active_logs) {
+			f2fs_err(sbi,
+				"zoned: max open zones %u is too small, need at least %u open zones",
+				sbi->max_open_zones, F2FS_OPTION(sbi).active_logs);
+			return -EINVAL;
+		}
+	}
+
 	zone_sectors = bdev_zone_sectors(bdev);
 	if (sbi->blocks_per_blkz && sbi->blocks_per_blkz !=
 				SECTOR_TO_BLOCK(zone_sectors))
@@ -4186,6 +4210,9 @@ static int f2fs_scan_devices(struct f2fs_sb_info *sbi)
 
 	logical_blksize = bdev_logical_block_size(sbi->sb->s_bdev);
 	sbi->aligned_blksize = true;
+#ifdef CONFIG_BLK_DEV_ZONED
+	sbi->max_open_zones = UINT_MAX;
+#endif
 
 	for (i = 0; i < max_devices; i++) {
 		if (i == 0)
-- 
2.40.1


