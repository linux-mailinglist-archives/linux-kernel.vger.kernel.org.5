Return-Path: <linux-kernel+bounces-116311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AFB58895E6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:42:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C73B1C2C521
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14F633D2316;
	Mon, 25 Mar 2024 03:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RaZQbhPr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A083291B81;
	Sun, 24 Mar 2024 23:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324240; cv=none; b=QNUJYdt13jc5SxYV+SUapGz61ZYvO3ZPYkfrJl5sVGpU79i9orR186HFA0YbRN/Zycjz55jLxl9voXat7RBEwVlXuXBknKm4utaJLx3tXO0oz41+y2Q00370jOIE3bq1KhNw2QPDJZiMXOAfFWhj2uqRmEyLo5aoshJwkmiD0Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324240; c=relaxed/simple;
	bh=so3jRYMGbySBRs2qMRh+Igr+9lA6q80jvIqCKMuk8bc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B05bocf2QJ9uO0fmMUM7mA7SqwbQTVbZ/n1p7bPEJHIgPT5vCwffJeL5iiKK4rZp0Z5A5RUqT0kjyMCIRMeCHHWeCXDehJEzzyszCcX6Rwnu+GmzfnAR48BfMNEzjBZpabHh7KeXcqkhKQxtRzBT+1yBd38XoN8dq6GPBOm7mUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RaZQbhPr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9917C433F1;
	Sun, 24 Mar 2024 23:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324239;
	bh=so3jRYMGbySBRs2qMRh+Igr+9lA6q80jvIqCKMuk8bc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RaZQbhPrCBWEYs7QSceJr3g8ReJAn6BahZ7BHRHfJtTzyi7Outae4SqGUnFHTO7eu
	 2g0GJyIAn1LGV32w2gronUOFF+I8qHQTM8viIu0JO28yQprM+89sVGpITu9+KP9UMU
	 sSQrN7rkwZRxxjMzMBZxFIDLfiIhyyv0mHkDBs0UDag4ZxRdbN/z3MAYVEBVxeBJOe
	 9LY9qTci39RaQDZopYBzq0zdvGmsp8KsDkWSlMocCCkx/fzgbyQkucjESWWqz81cBn
	 8Bbx1PXDHLDx8blSNaF1CmgkB9dFvftepcV0j82YTgjXrLOiiGqY3peOHAtiC6Y1MR
	 yF0YQMg8errUQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	Song Liu <song@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 022/148] md: implement ->set_read_only to hook into BLKROSET processing
Date: Sun, 24 Mar 2024 19:48:06 -0400
Message-ID: <20240324235012.1356413-23-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324235012.1356413-1-sashal@kernel.org>
References: <20240324235012.1356413-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Christoph Hellwig <hch@lst.de>

[ Upstream commit 118cf084adb3964d06e1667cf7d702e56e5cd2c5 ]

Implement the ->set_read_only method instead of parsing the actual
ioctl command.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Song Liu <song@kernel.org>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Stable-dep-of: 9674f54e41ff ("md: Don't clear MD_CLOSING when the raid is about to stop")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/md.c | 62 ++++++++++++++++++++++++-------------------------
 1 file changed, 31 insertions(+), 31 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index a137f8b4a0541..8123c44de7dc8 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -7172,7 +7172,6 @@ static inline bool md_ioctl_valid(unsigned int cmd)
 {
 	switch (cmd) {
 	case ADD_NEW_DISK:
-	case BLKROSET:
 	case GET_ARRAY_INFO:
 	case GET_BITMAP_FILE:
 	case GET_DISK_INFO:
@@ -7200,7 +7199,6 @@ static int md_ioctl(struct block_device *bdev, fmode_t mode,
 	int err = 0;
 	void __user *argp = (void __user *)arg;
 	struct mddev *mddev = NULL;
-	int ro;
 	bool did_set_md_closing = false;
 
 	if (!md_ioctl_valid(cmd))
@@ -7391,35 +7389,6 @@ static int md_ioctl(struct block_device *bdev, fmode_t mode,
 			goto unlock;
 		}
 		break;
-
-	case BLKROSET:
-		if (get_user(ro, (int __user *)(arg))) {
-			err = -EFAULT;
-			goto unlock;
-		}
-		err = -EINVAL;
-
-		/* if the bdev is going readonly the value of mddev->ro
-		 * does not matter, no writes are coming
-		 */
-		if (ro)
-			goto unlock;
-
-		/* are we are already prepared for writes? */
-		if (mddev->ro != 1)
-			goto unlock;
-
-		/* transitioning to readauto need only happen for
-		 * arrays that call md_write_start
-		 */
-		if (mddev->pers) {
-			err = restart_array(mddev);
-			if (err == 0) {
-				mddev->ro = 2;
-				set_disk_ro(mddev->gendisk, 0);
-			}
-		}
-		goto unlock;
 	}
 
 	/*
@@ -7513,6 +7482,36 @@ static int md_compat_ioctl(struct block_device *bdev, fmode_t mode,
 }
 #endif /* CONFIG_COMPAT */
 
+static int md_set_read_only(struct block_device *bdev, bool ro)
+{
+	struct mddev *mddev = bdev->bd_disk->private_data;
+	int err;
+
+	err = mddev_lock(mddev);
+	if (err)
+		return err;
+
+	if (!mddev->raid_disks && !mddev->external) {
+		err = -ENODEV;
+		goto out_unlock;
+	}
+
+	/*
+	 * Transitioning to read-auto need only happen for arrays that call
+	 * md_write_start and which are not ready for writes yet.
+	 */
+	if (!ro && mddev->ro == 1 && mddev->pers) {
+		err = restart_array(mddev);
+		if (err)
+			goto out_unlock;
+		mddev->ro = 2;
+	}
+
+out_unlock:
+	mddev_unlock(mddev);
+	return err;
+}
+
 static int md_open(struct block_device *bdev, fmode_t mode)
 {
 	/*
@@ -7588,6 +7587,7 @@ static const struct block_device_operations md_fops =
 #endif
 	.getgeo		= md_getgeo,
 	.check_events	= md_check_events,
+	.set_read_only	= md_set_read_only,
 };
 
 static int md_thread(void *arg)
-- 
2.43.0


