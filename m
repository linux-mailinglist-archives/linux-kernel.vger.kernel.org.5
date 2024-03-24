Return-Path: <linux-kernel+bounces-116127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A667888997B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:11:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CA301F3220D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 854833AD1B0;
	Mon, 25 Mar 2024 03:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FugA5Sbl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2D717A398;
	Sun, 24 Mar 2024 23:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323661; cv=none; b=rMILPbreeaebUe3AmFoW2CLk/dhwqmL82ltzpDhaD/w8K/S3dAkn5FQyn/HrLVVs7Yc9MGXlbKZU0GIgFQ9BP8H+FXfZtDVOOAB6/tnVQEZoapsIOeVcYhi5BBziBMJ29uhrmhsLCChdLztMuWdk0YBe+pGhIko3fhVzE5SzBLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323661; c=relaxed/simple;
	bh=xUEq0/4SeP+e6cmHTvV6rwqLU4gsCa5EQBlGBnER0Z4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XKQ9lUz7uehjG207TdFrYRRTGgr5yzkWMt6CU0sUIc2ME65TDSZngZVSDroQJXZf8SEHzbgF/edQK9yUozWyM2rIcQZpl8JfVdgelHUdTpExU/DyBLYTv+WYHWIfeVA7YPNeG8O2ZoAiHLh47dqD/5hVOQBNZFhAxkVy0iBh7YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FugA5Sbl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE1B8C433C7;
	Sun, 24 Mar 2024 23:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323661;
	bh=xUEq0/4SeP+e6cmHTvV6rwqLU4gsCa5EQBlGBnER0Z4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FugA5SblT3WEMvXBuNECePtQdjbuqsM6eez8QeYyVgeozsSrtddfCz4aYMykrQhqr
	 FbpZC3fA4UOp/28wmIhg1cG2fDd0CZb2hHQs7d3h+H11nNG6aAO2rGt+VA4DNGRY1Q
	 nvuCXXPOVgJOShHETFlH9KoTpqFrwVoB1zJWxQJNl4/bNJWldFmye3CbIzV1qiNeCk
	 aYWTZ1CI0dJUIv5CPpq/svjPP5UCZEje61JQQ8wRmr0bHzu2kRqEhg6t19Bs4xj/2f
	 DDh6zZuutd6y44olQJGzAH6uBF9/dcNz/OR+6D5M9n6bfZcL2X8yqezf7D/OX7aR24
	 Bne615vq1cehg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	Song Liu <song@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 033/238] md: implement ->set_read_only to hook into BLKROSET processing
Date: Sun, 24 Mar 2024 19:37:01 -0400
Message-ID: <20240324234027.1354210-34-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234027.1354210-1-sashal@kernel.org>
References: <20240324234027.1354210-1-sashal@kernel.org>
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
index 03d2e31dda2f6..d6f12338cb989 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -7536,7 +7536,6 @@ static inline bool md_ioctl_valid(unsigned int cmd)
 {
 	switch (cmd) {
 	case ADD_NEW_DISK:
-	case BLKROSET:
 	case GET_ARRAY_INFO:
 	case GET_BITMAP_FILE:
 	case GET_DISK_INFO:
@@ -7563,7 +7562,6 @@ static int md_ioctl(struct block_device *bdev, fmode_t mode,
 	int err = 0;
 	void __user *argp = (void __user *)arg;
 	struct mddev *mddev = NULL;
-	int ro;
 	bool did_set_md_closing = false;
 
 	if (!md_ioctl_valid(cmd))
@@ -7746,35 +7744,6 @@ static int md_ioctl(struct block_device *bdev, fmode_t mode,
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
@@ -7868,6 +7837,36 @@ static int md_compat_ioctl(struct block_device *bdev, fmode_t mode,
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
@@ -7944,6 +7943,7 @@ const struct block_device_operations md_fops =
 #endif
 	.getgeo		= md_getgeo,
 	.check_events	= md_check_events,
+	.set_read_only	= md_set_read_only,
 };
 
 static int md_thread(void *arg)
-- 
2.43.0


