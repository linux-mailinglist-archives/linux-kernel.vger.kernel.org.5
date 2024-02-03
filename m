Return-Path: <linux-kernel+bounces-51147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BCE8848717
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 16:25:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DA871C20F3A
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 15:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FCDE5F546;
	Sat,  3 Feb 2024 15:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cTe+wfru"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A21A5F54A
	for <linux-kernel@vger.kernel.org>; Sat,  3 Feb 2024 15:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706973917; cv=none; b=occrMhtY1+zuo2GGxTayU7vIo2QKruZSlkmiIY5xU6W2zarmvn5lLQ53uGMoZPU5LqfGjNd4M7xHZZR9umc5z5MgCNO8nT737XHFm2FprKM/syqH0w3Ita6Vioh/8X4iGUn8nQGKwmuqRTCWFqaq4/pbhloEdRZji0N2AZWuYPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706973917; c=relaxed/simple;
	bh=RtPXT9uJnRvUvzMIpDyqdjM8D8hOXa06jLXqA6g599Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kWXkJvik8h4l6KCvDo6AyQ6SiJiuUfrXOWwhWENSmBlGN7EKgDd/epd5gCo6k71cr5uJXe3XSGv1Od7NIYBLGVzemIQ2y0dOJneEpMY4jp8mJZNGM66g/oFSGmQjDPJin0Gl3vC3G9JtTG/26mLC+8APF/Kz50PKj92U4rMx3o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cTe+wfru; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1d731314e67so22269155ad.1
        for <linux-kernel@vger.kernel.org>; Sat, 03 Feb 2024 07:25:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706973914; x=1707578714; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=c88lqSxqRhgcdBuXBMm8xLbio2cc1M+G+N4XYcCvLJA=;
        b=cTe+wfruQLdKJbG6YOQ+7xocjo9XFeQcdGZ7TrMkJHKMevUuJvAMj6lo8jLfzXhX7m
         rcd1eyLuvgM5c7GZCvbcZlB++TgmvLDu+uZd0mPM79xKG0+3s+Fwij5R38nyY7/nm6kQ
         2Cyf2s/YRQjVAdgbkNzeHXQdmxyJMHnYJpu/eBQcJia4U2XebUAHsAyysaVUIfLxOvtI
         831tYbz/oNZ0mO5zc6tfzbeXIsizICmYmEOesdcz/dUTen1zNecWzDYQRsKloZwEv6kY
         8aoM5uohQA9UdvxS+991A0YozN0moGBgbttna7FOYm9z+sgm2gNsh918gFoIu7WwNvMi
         6XNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706973914; x=1707578714;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c88lqSxqRhgcdBuXBMm8xLbio2cc1M+G+N4XYcCvLJA=;
        b=n8txYki2oPjYnjhYPIkjSO1GGvpgkNOoDMtGwqlai42ZnsDlsRCfx86SR/2q6+Wib8
         Fv61xP9zxoZPWDSNWVIZ9jh1wyy8piP07uIFKoAkI80UwsvDy7/TOZR6IfkuymNXLt4W
         vUJXQmMNolJJuvnjmsZ4iMP0yxBedrZphfLHlkW6qh9kr4samxC+WRTF99nZ05hzrhJ/
         lH/XeOdcgObqiDj/07TB26egqS9s+uXcusesRmTi//LPP2cmmeYto92zbNe68hQG/56H
         02vbuVbd2eqXjB5NK8cmVHmcI67RTvmXzTJzeNRIIsvaFrxtCAchP4ciLz27/H8Zw5kc
         yIxQ==
X-Gm-Message-State: AOJu0YyXs4Web3nAEJKW/2X1/AhrnnB+Clz/8xuUMVtUDkmvnR/gLP1s
	5yvOpXvhe8qyvPoOY9DtqjJZrqhynRxACvRoeh/2Z/GjXgIYfldb
X-Google-Smtp-Source: AGHT+IG+kFYkVfFa0+0Ujxvkv+4qhG9681TjiX9T+aWgsnpdHjM1XP2I2bR9X6WyjKDoVmH6dQgTfQ==
X-Received: by 2002:a17:902:f545:b0:1d9:5d65:c1b with SMTP id h5-20020a170902f54500b001d95d650c1bmr7436906plf.41.1706973914367;
        Sat, 03 Feb 2024 07:25:14 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUnaJiN3/oUVmOaXrf8A7R+Oc/J9rdZuq2hqa3OkuWuLiIUbcBwBO2NnGovu7VXgDk8iR2QXDi+ypeB0NGiZSA3yIp4tXmywVL5r/ZL7AeQPPOF9AAP5sZ3daQly/5/NcFpotuBCFavYnKgvhVGHiZxt96+cjL75gHi0HVp3fH+jb9RNNEBWut2/bo7ZxjWxr9QW2kqKsCCiiTSEZ8IHtZO9XnAb8VoAa6rZrEMfcF3Qg==
Received: from localhost.localdomain ([112.38.163.83])
        by smtp.gmail.com with ESMTPSA id ku12-20020a170903288c00b001d7284b9461sm3370081plb.128.2024.02.03.07.25.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Feb 2024 07:25:14 -0800 (PST)
From: Wenjie Qi <qwjhust@gmail.com>
To: jaegeuk@kernel.org,
	chao@kernel.org,
	yangyongpeng1@oppo.com,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Cc: hustqwj@hust.edu.cn,
	Wenjie Qi <qwjhust@gmail.com>
Subject: [PATCH v4] f2fs: fix zoned block device information initialization
Date: Sat,  3 Feb 2024 23:24:36 +0800
Message-ID: <20240203152436.1352-1-qwjhust@gmail.com>
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
insufficient zone resources when multiple active logs are
being written at the same time. If this value is 0,
there is no limit.

Signed-off-by: Wenjie Qi <qwjhust@gmail.com>
---
 fs/f2fs/f2fs.h  |  1 +
 fs/f2fs/super.c | 21 +++++++++++++++++++++
 2 files changed, 22 insertions(+)

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
index 1b718bebfaa1..45e82d6016fc 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2388,6 +2388,16 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 	if (err)
 		goto restore_opts;
 
+#ifdef CONFIG_BLK_DEV_ZONED
+	if (sbi->max_open_zones && sbi->max_open_zones < F2FS_OPTION(sbi).active_logs) {
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
+	if (max_open_zones && (max_open_zones < sbi->max_open_zones || !sbi->max_open_zones))
+		sbi->max_open_zones = max_open_zones;
+	if (sbi->max_open_zones && sbi->max_open_zones < F2FS_OPTION(sbi).active_logs) {
+		f2fs_err(sbi,
+			"zoned: max open zones %u is too small, need at least %u open zones",
+				 sbi->max_open_zones, F2FS_OPTION(sbi).active_logs);
+		return -EINVAL;
+	}
+
 	zone_sectors = bdev_zone_sectors(bdev);
 	if (!is_power_of_2(zone_sectors)) {
 		f2fs_err(sbi, "F2FS does not support non power of 2 zone sizes\n");
-- 
2.34.1


