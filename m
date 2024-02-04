Return-Path: <linux-kernel+bounces-51396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55BF4848AC5
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 04:11:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB55A289492
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 03:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6E5115BF;
	Sun,  4 Feb 2024 03:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nZL3VzbJ"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21B410EB
	for <linux-kernel@vger.kernel.org>; Sun,  4 Feb 2024 03:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707016281; cv=none; b=lsTitqEG2C+zVSyby65m0v0vgn+ULagOjOlWUEB13phLvv+D3U/zst1o4ofr65aUeuSCJLTltJYy1r29JVHalnQ6P+1nlUoyoBbjGKPAJxTT06BDyY7QLpJh12w+tKIG196Ur4J8J6u4vJF8Sx8XCvMAA7Oy/3fQs2l/6gO9Hlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707016281; c=relaxed/simple;
	bh=Rg/Q7uvffcTHZcJlhEx+89mKvetaAH1fSbnyGWrBPAA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XFjShDEiwvSoSrOvR3R0If+RiT0RncFYoaCkD7a3bDDLh4DoripJ1z0z6pOOLn94doBxywOyvzlWtBPaKAV8E1k1Q5W4C3TYqu6StdwnyrVm2+nFoLQupK3dkq9K4/6n2iRkeQ2JBHG6nRGuEIAnluO1IM1rTKXeeROgxOWjPwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nZL3VzbJ; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-295f9a4a656so2751875a91.1
        for <linux-kernel@vger.kernel.org>; Sat, 03 Feb 2024 19:11:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707016279; x=1707621079; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+usYO9kmYXbpy+mniJppEmKl5G0Ak9hnYSfizal5zIo=;
        b=nZL3VzbJV/rXQ0FX/JKmvjNuzxnUnitafz+mDtTnLXt7PnLA7u5aaX30h52BV5JeCw
         2QQp4/s/+vugWhZTqgRJUdXA3/KsGdgIh7sxVN4ARSgmyiPgAc7ktqslWTI/lnWnDUQv
         5B3JsY+4rLO3UxGJHfe756BnDxHELgu6qZfYHvjnW49w06BQvHpSQR8q+8nVBBo6BLWy
         ku5tsYeE/gm0wjSOneUbWcjoHmzNpnAHg0SBKRpBOX5SadIzFtVoGv2as2Baec3mzq5O
         munPtu3JP5ctRNL14yeNw6wRA27CwRtX3qtnDPp7cp6E4Zc48hQ/2Uu0F2cv81Daw8w/
         TklA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707016279; x=1707621079;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+usYO9kmYXbpy+mniJppEmKl5G0Ak9hnYSfizal5zIo=;
        b=A8WLAfX4YnYlDl7dD0a2zAgrbw4UEA//27WskYxMxw2HY2ojgYpWDVb1ZfJSGdPvPy
         c58Ue9piu+jl3OD34/jLCsfOanfn/ewnO2JOXo6RUKLq91cn+1gM0yDEyv4LXCtO21Ch
         dyqeO0nFYB0/bMIFkcWdtQG1UmIcTreLOvSFC6Cl3ZWVz5nF803OsTZQYnjrM0EFmWQK
         xSfDTlQgD8fU0BUXg7yZ+VH1j5u9PD9eam5aMtHmeyfIb7oNhS3NHrUOEyARg0bpt3K5
         TlhJN+qa9qByf/aEGPV3oSO4I3KqX+ijkaoFG//4qzHjp1MUU4NjzEaNDYZxNpQm9E0g
         bE5g==
X-Gm-Message-State: AOJu0Yx8lvlIjMqt8LsByFUD+Yopt/MInkWizu2Ig0R6ZQkYYfVCuwbB
	E8jrBe3bQ24THRS14I57bOQRMZ55Lj0lB83nzO+WeolBGdlu0KGd
X-Google-Smtp-Source: AGHT+IGx2qqIW96Pfh8jonNWQmOXBn1OWquAQPwRPRYif17747FkB7bAA3tCN3Te7DS2ydaz7PcPxQ==
X-Received: by 2002:a17:90a:17e2:b0:296:3779:813c with SMTP id q89-20020a17090a17e200b002963779813cmr6504495pja.4.1707016278986;
        Sat, 03 Feb 2024 19:11:18 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVzR7hi5WM5nw9LaiP+Ix1SnjAyaZWBh8NaFdwA6BLv2FwdR/AUj/+M5eCWX0EQVYaPyN39+RXrUfByI0ST/ePJETynEugUz4p5XLd5USeD2fjh0VFfPkup7Jug8KdywlviXnNuiBzWbOaUTyVrrWdQBrSu+v9HnnK4fR9hrakRzRVA0Ni9RPnVTCoG6/J5mP+wGIM++byp8K74lCXM+rqaQSqDcKePM58DRq2IrSSM6A==
Received: from localhost.localdomain ([112.38.163.83])
        by smtp.gmail.com with ESMTPSA id n9-20020a170902d0c900b001d8f82c61cdsm7312pln.231.2024.02.03.19.11.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Feb 2024 19:11:18 -0800 (PST)
From: Wenjie Qi <qwjhust@gmail.com>
To: jaegeuk@kernel.org,
	chao@kernel.org,
	yangyongpeng1@oppo.com,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Cc: hustqwj@hust.edu.cn,
	Wenjie Qi <qwjhust@gmail.com>
Subject: [PATCH v5] f2fs: fix zoned block device information initialization
Date: Sun,  4 Feb 2024 11:10:22 +0800
Message-ID: <20240204031022.1189-1-qwjhust@gmail.com>
X-Mailer: git-send-email 2.43.0.windows.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the max open zones of zoned devices are less than
the active logs of F2FS, the device may error due to
insufficient zone resources when multiple active logs
are being written at the same time.

Signed-off-by: Wenjie Qi <qwjhust@gmail.com>
---
 fs/f2fs/f2fs.h  |  1 +
 fs/f2fs/super.c | 24 ++++++++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 543898482f8b..161107f2d3bd 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1558,6 +1558,7 @@ struct f2fs_sb_info {
 
 #ifdef CONFIG_BLK_DEV_ZONED
 	unsigned int blocks_per_blkz;		/* F2FS blocks per zone */
+	unsigned int max_open_zones;		/* max open zone resources of the zoned device */
 #endif
 
 	/* for node-related operations */
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 1b718bebfaa1..c6709efbc294 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2388,6 +2388,16 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 	if (err)
 		goto restore_opts;
 
+#ifdef CONFIG_BLK_DEV_ZONED
+	if (sbi->max_open_zones < F2FS_OPTION(sbi).active_logs) {
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
 
@@ -3930,11 +3940,22 @@ static int init_blkz_info(struct f2fs_sb_info *sbi, int devi)
 	sector_t nr_sectors = bdev_nr_sectors(bdev);
 	struct f2fs_report_zones_args rep_zone_arg;
 	u64 zone_sectors;
+	unsigned int max_open_zones;
 	int ret;
 
 	if (!f2fs_sb_has_blkzoned(sbi))
 		return 0;
 
+	max_open_zones = bdev_max_open_zones(bdev);
+	if (max_open_zones && (max_open_zones < sbi->max_open_zones))
+		sbi->max_open_zones = max_open_zones;
+	if (sbi->max_open_zones < F2FS_OPTION(sbi).active_logs) {
+		f2fs_err(sbi,
+			"zoned: max open zones %u is too small, need at least %u open zones",
+				 sbi->max_open_zones, F2FS_OPTION(sbi).active_logs);
+		return -EINVAL;
+	}
+
 	zone_sectors = bdev_zone_sectors(bdev);
 	if (!is_power_of_2(zone_sectors)) {
 		f2fs_err(sbi, "F2FS does not support non power of 2 zone sizes\n");
@@ -4253,6 +4274,9 @@ static int f2fs_scan_devices(struct f2fs_sb_info *sbi)
 
 	logical_blksize = bdev_logical_block_size(sbi->sb->s_bdev);
 	sbi->aligned_blksize = true;
+#ifdef CONFIG_BLK_DEV_ZONED
+	sbi->max_open_zones = UINT_MAX;
+#endif
 
 	for (i = 0; i < max_devices; i++) {
 		if (i == 0)
-- 
2.34.1


