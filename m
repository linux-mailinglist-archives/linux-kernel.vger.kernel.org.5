Return-Path: <linux-kernel+bounces-134218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FA0589AF1E
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 09:21:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 603EA1C21AB6
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 07:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DBA417578;
	Sun,  7 Apr 2024 07:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SQ+0NAeL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75BBC171D2
	for <linux-kernel@vger.kernel.org>; Sun,  7 Apr 2024 07:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712474492; cv=none; b=SWRCKCwZEQ/3NT6F0i++7qwbZsdTnvjRDZhzbyEPm/wFSt/GnQJ4ucINjqpQbmiKh0/41iq/PzRi67/Za+TySWo+Nq2qfdlynUT75W52PwnXXU8E/dS/6NvNF3oY+dwQ0jwpETBwVLUhOYuUi6TzvyvpbHJ29FJ/01nTZbSLte0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712474492; c=relaxed/simple;
	bh=sTsz2yC68gF80nOn+mrSl6qAbn+Ba4y6BK10ybpuh4M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ozWRZ+dvGmz9yGizY7nG2m/Cy6YTpoCBOD/7wkxpF0XK9PlLm1aNZ5Hy3I2ZYpj+agi5gTO+JQvHNFSSgqv1VACyR8pHyd4TzUUHy3wMVhtq3MPQGalW5jjp5Mg/NFfgRc9mIrd/SKCnQzi3HIqDZx72PjWgkn/btLc/Tr8gn08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SQ+0NAeL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7155AC433F1;
	Sun,  7 Apr 2024 07:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712474492;
	bh=sTsz2yC68gF80nOn+mrSl6qAbn+Ba4y6BK10ybpuh4M=;
	h=From:To:Cc:Subject:Date:From;
	b=SQ+0NAeLk4GLSCbVM8kSPhXchCX7IyQRx8jlpHKFJxRan3nFoITvLbWB5ywR/k5Xd
	 /iQNI3d3k3VzZNOOxx+QXSlbMhSYqJMleRi1k7iATKo3Ntt8SjBqc5Trvj6YZawavH
	 J9Ck3otcNhWdMN4mW6bOZ05JaXqDkwp3yzvQUQwSve4z12aOSe0Pq78VjCWZhObMnZ
	 z7cONDgKUtMVHn0YAJKWAYGi6Wu1i0xDcB7Lkekwkm4j4fUs16QkiLVha1Z4YB/j5n
	 +6Zv1CtpY+6GODRK5dfOCWwWA0HdUqGMMPyJXi37zDkWwQAZVGfxsXLWcBHyQ8ULmj
	 RDrwmUQrzEWJw==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Wenjie Qi <qwjhust@gmail.com>,
	Chao Yu <chao@kernel.org>
Subject: [PATCH v7] f2fs: fix zoned block device information initialization
Date: Sun,  7 Apr 2024 15:21:23 +0800
Message-Id: <20240407072123.3484300-1-chao@kernel.org>
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
v7:
- check f2fs_sb_has_blkzoned() instead of multiple-device condition
in f2fs_remount().
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
index ba6288e870c5..fdf358c7f808 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2324,6 +2324,17 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 	if (err)
 		goto restore_opts;
 
+#ifdef CONFIG_BLK_DEV_ZONED
+	if (f2fs_sb_has_blkzoned(sbi) &&
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
 
@@ -3866,11 +3877,24 @@ static int init_blkz_info(struct f2fs_sb_info *sbi, int devi)
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
@@ -4191,6 +4215,9 @@ static int f2fs_scan_devices(struct f2fs_sb_info *sbi)
 
 	logical_blksize = bdev_logical_block_size(sbi->sb->s_bdev);
 	sbi->aligned_blksize = true;
+#ifdef CONFIG_BLK_DEV_ZONED
+	sbi->max_open_zones = UINT_MAX;
+#endif
 
 	for (i = 0; i < max_devices; i++) {
 		if (i == 0)
-- 
2.40.1


