Return-Path: <linux-kernel+bounces-139540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04E708A0420
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 01:39:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42D79B24C81
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 23:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B2D23F8D0;
	Wed, 10 Apr 2024 23:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kx8m2IxU"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB5C3E497
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 23:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712792378; cv=none; b=qZHZBeaGGgpdHFGMfKmeC6wAycvDfpzkDVZNHt4OJmutxz4tGrsDYaJHusKSMscyPmgxYUKMTjNHC5woxSgF1SLDvTmAzT9/VOLCnI0Y28Fm9/kuEJcugn4Yu9IsONLl4heIyaA6bJgmtGkjBn+xwGnEhKlPN1I73IrqTP7ZCpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712792378; c=relaxed/simple;
	bh=rpYZhj4751iWbkVepEs/ADveztaFsyk2diT8Tk66Dy0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ih4XQSeHbgmAvVryjcb2CYcFKDlG5MIyG/u0TysAsr3fKIji2fNRtmyjq9KADN7TV+83580zr4x6MqXNIGRiJYeneSLOqzOLtFCeSaUM/siOCZDBc81HEbKnjkFIcQFHNT4fp3BewE1z9d5DPeCH8d4Vl61qLKSOzYzMmE+UTAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--saranyamohan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kx8m2IxU; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--saranyamohan.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-610c23abd1fso135698837b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 16:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712792376; x=1713397176; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4SMTAjGOOgSyZL6SAfk/454jWeVGNPsPzFKYN6I+I2A=;
        b=kx8m2IxUksslaQsy0EuQP+yrHMQCYJn/aEUuDYyaZfu2w0pARGuVX8kj/O5NNoMGqN
         ilAiDIQriwnNEtaK+/zup1xZa3v5T5+Vj0Psntc/Sv7owWQj6Vsoz4+7bpupSIWbd3jD
         v/EWFyNZpMDM1ay3VHkjm00o+LIljuVK18fCwxzK9PHDzUHokSbJqLA4zXXqVc/qc7v8
         cKttfTywVHgsKtRtt3hruXUMkF2yBSrlu4Qs3+X3urdGLpJi6yHq5fxZjcExxklMql0d
         5mR+ATlj5Ds5tx918pOA0tE/vlHG0Of4PWPZPKgFf+RHC9LiB/QlK0QilqrapHXCICki
         dMzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712792376; x=1713397176;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4SMTAjGOOgSyZL6SAfk/454jWeVGNPsPzFKYN6I+I2A=;
        b=HmEo/xtbDv7TguNW1raYO7Mj4Q9flSNgnwv6gz8J4NaGOAsbm4sqdLoUvL1WT/1J6t
         WZAHmYgDcQUAqr2FU4Qwj1mV70LsHn99UwK/eFHJ7jdMLESGBwOZPZ39OCoCL3NrDwXY
         kz1Mx6m+JMzwbWL+XwAumq6cepe+Bgjerl5kPxLNz3XUYuanqu3Uiz1fwqXfKUldQSq1
         pS+0C4IvFhtEDsodBlA1LlLa2xVorCJ5b36KYFKPOSpfON35MmDsQB7pTMdHiqnrPEg8
         roROUi8Yi57k1mS67Nodlo7UmrT/4Ayim1KznLI+LP97rvcRsg6RMcDcj4eJKGTfdEqy
         se/A==
X-Forwarded-Encrypted: i=1; AJvYcCXORem7jFPmiYKYZb06CPH/fAmmnIypdLoE57rOl7S9mAho09VCxadtZiO57e2sd2F3R5l6IN2tMDTX1EC8H9ko2ca+T2G6ZiShXXA5
X-Gm-Message-State: AOJu0YwC5IFZL4XDaaxVGpyHCzl0wEAUGsmTGzfCbHGjCbBWT/QDRfWL
	1eiWbdsiysy7v3rSrgiSYBFWeq+W2WkAEnVQoHCTcQv30oq2TrI5ENd6YgDc6ZRn8bMdKKnHbmG
	EM4+eZKOsUKoianYka1qgBSpdsA==
X-Google-Smtp-Source: AGHT+IEz3DEzce0uPqJwVjrnNB+uWNZ2eHAiKT/SqxfCbrlmeL0MxREerG5nMJtsvzRK08jbC1D4o/ccDyC6C0/RRHM=
X-Received: from srnym.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2728])
 (user=saranyamohan job=sendgmr) by 2002:a05:6902:20c6:b0:de1:2220:862b with
 SMTP id dj6-20020a05690220c600b00de12220862bmr1000286ybb.12.1712792375931;
 Wed, 10 Apr 2024 16:39:35 -0700 (PDT)
Date: Wed, 10 Apr 2024 23:39:32 +0000
In-Reply-To: <tnqg4la2bhbhfbty3aa74uorkfhz76v5sntd3md44lfctjhjb7@7qbx5z2o7hzm>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <tnqg4la2bhbhfbty3aa74uorkfhz76v5sntd3md44lfctjhjb7@7qbx5z2o7hzm>
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
Message-ID: <20240410233932.256871-1-saranyamohan@google.com>
Subject: [PATCH] block: Fix BLKRRPART regression
From: Saranya Muruganandam <saranyamohan@google.com>
To: shinichiro.kawasaki@wdc.com
Cc: axboe@kernel.dk, hch@lst.de, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, saranyamohan@google.com, stable@vger.kernel.org, 
	tj@kernel.org, yukuai1@huaweicloud.com
Content-Type: text/plain; charset="UTF-8"

The BLKRRPART ioctl used to report errors such as EIO before we changed
the blkdev_reread_part() logic.

Add a flag and capture the errors returned by bdev_disk_changed()
when the flag is set. Set this flag for the BLKRRPART path when we
want the errors to be reported when rereading partitions on the disk.

Link: https://lore.kernel.org/all/20240320015134.GA14267@lst.de/
Suggested-by: Christoph Hellwig <hch@lst.de>
Tested: Tested by simulating failure to the block device and will
propose a new test to blktests.
Fixes: 4601b4b130de ("block: reopen the device in blkdev_reread_part")
Reported-by: Saranya Muruganandam <saranyamohan@google.com>
Signed-off-by: Saranya Muruganandam <saranyamohan@google.com>

Change-Id: Idf3d97390ed78061556f8468d10d6cab24ae20b1
---
 block/bdev.c           | 29 +++++++++++++++++++----------
 block/ioctl.c          |  3 ++-
 include/linux/blkdev.h |  2 ++
 3 files changed, 23 insertions(+), 11 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index 7a5f611c3d2e3..cea51dca87531 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -652,6 +652,14 @@ static void blkdev_flush_mapping(struct block_device *bdev)
 	bdev_write_inode(bdev);
 }
 
+static void blkdev_put_whole(struct block_device *bdev)
+{
+	if (atomic_dec_and_test(&bdev->bd_openers))
+		blkdev_flush_mapping(bdev);
+	if (bdev->bd_disk->fops->release)
+		bdev->bd_disk->fops->release(bdev->bd_disk);
+}
+
 static int blkdev_get_whole(struct block_device *bdev, blk_mode_t mode)
 {
 	struct gendisk *disk = bdev->bd_disk;
@@ -670,20 +678,21 @@ static int blkdev_get_whole(struct block_device *bdev, blk_mode_t mode)
 
 	if (!atomic_read(&bdev->bd_openers))
 		set_init_blocksize(bdev);
-	if (test_bit(GD_NEED_PART_SCAN, &disk->state))
-		bdev_disk_changed(disk, false);
 	atomic_inc(&bdev->bd_openers);
+	if (test_bit(GD_NEED_PART_SCAN, &disk->state)) {
+		/*
+		 * Only return scanning errors if we are called from contexts
+		 * that explicitly want them, e.g. the BLKRRPART ioctl.
+		 */
+		ret = bdev_disk_changed(disk, false);
+		if (ret && (mode & BLK_OPEN_STRICT_SCAN)) {
+			blkdev_put_whole(bdev);
+			return ret;
+		}
+	}
 	return 0;
 }
 
-static void blkdev_put_whole(struct block_device *bdev)
-{
-	if (atomic_dec_and_test(&bdev->bd_openers))
-		blkdev_flush_mapping(bdev);
-	if (bdev->bd_disk->fops->release)
-		bdev->bd_disk->fops->release(bdev->bd_disk);
-}
-
 static int blkdev_get_part(struct block_device *part, blk_mode_t mode)
 {
 	struct gendisk *disk = part->bd_disk;
diff --git a/block/ioctl.c b/block/ioctl.c
index 0c76137adcaaa..128f503828cee 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -562,7 +562,8 @@ static int blkdev_common_ioctl(struct block_device *bdev, blk_mode_t mode,
 			return -EACCES;
 		if (bdev_is_partition(bdev))
 			return -EINVAL;
-		return disk_scan_partitions(bdev->bd_disk, mode);
+		return disk_scan_partitions(bdev->bd_disk,
+				mode | BLK_OPEN_STRICT_SCAN);
 	case BLKTRACESTART:
 	case BLKTRACESTOP:
 	case BLKTRACETEARDOWN:
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index c3e8f7cf96be9..d16320852c4ba 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -128,6 +128,8 @@ typedef unsigned int __bitwise blk_mode_t;
 #define BLK_OPEN_WRITE_IOCTL	((__force blk_mode_t)(1 << 4))
 /* open is exclusive wrt all other BLK_OPEN_WRITE opens to the device */
 #define BLK_OPEN_RESTRICT_WRITES	((__force blk_mode_t)(1 << 5))
+/* return partition scanning errors */
+#define BLK_OPEN_STRICT_SCAN	((__force blk_mode_t)(1 << 6))
 
 struct gendisk {
 	/*
-- 
2.44.0.683.g7961c838ac-goog


