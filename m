Return-Path: <linux-kernel+bounces-113640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F33438885CC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:16:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9D6F28B62F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BE5414389E;
	Sun, 24 Mar 2024 22:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XSDYEDoX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4E71D448F;
	Sun, 24 Mar 2024 22:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320554; cv=none; b=ae1T0qWYGeKegA5t/mAvLaFZPO8MfqQmdmH+YPvjOea+51NYJs9Zu/LHDfPis7INj/YcDHYPQUzt9kF/4P4qTG42ImUIk0dH4xECVjC5AzFMRxTN7M6dXJtlPxJwmjQPgl/nhIRHgeWo4LFlTgBFOlEAqORKm9opfYC/FMSXd6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320554; c=relaxed/simple;
	bh=gNibVN+d8uudqfIkLgv4WRr3iXmjBMOjk75vTW9te9E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nCJT+VjoR6h30Q8LT1dJ5x2U8FMiD93k6ObBWYYUNYDzwliNVcbllA9pwjlLurKC0k76Yie1/fF2nzQUQetM2PRqgDh9+7AiZpQrCJrv8nO5xKHf9EcuXlinRAf5oF77cAGHv60I1GN4K+Ht4TRKRHqEiNdu+FOxGrvvEtnSqx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XSDYEDoX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEBBCC433A6;
	Sun, 24 Mar 2024 22:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320553;
	bh=gNibVN+d8uudqfIkLgv4WRr3iXmjBMOjk75vTW9te9E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XSDYEDoXWrbfTnCACEGAPyuDX6XGpZ753uoPrVxPW6us6soNnXnvMZxH/Jh+LPJYb
	 leqGucn9mmNRBdNnJPKVupOWBAsNlSsb5X074igJG8T6V6mE5H43W85qSwcQ7svxVA
	 SpqT6HRNnq8c3McwF0qCE050BtLbGPLgFqSQwyPquwtfCrszeN9hFJHL0e7BrNG9ME
	 Bf9PFeRfHFPjcVWGYQrdZcqax1A4Mhz56v4OUYYlAPZgcZYsS0g0YLoCyn+kVb5XcH
	 VoLn/B32u6pBHU0zymEX9D9ONFROT3Rx5/HIWHj4dQmrbUxAeYqeti/NC8YnqSdsom
	 JNdcZPCE2HpsQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Yu Kuai <yukuai3@huawei.com>,
	Song Liu <song@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 114/713] md/raid1: factor out helpers to add rdev to conf
Date: Sun, 24 Mar 2024 18:37:20 -0400
Message-ID: <20240324224720.1345309-115-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Yu Kuai <yukuai3@huawei.com>

[ Upstream commit 969d6589abcb369d53d84ec7c9c37f4b23ec1ad9 ]

There are no functional changes, just make code cleaner and prepare to
record disk non-rotational information while adding and removing rdev to
conf

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Signed-off-by: Song Liu <song@kernel.org>
Link: https://lore.kernel.org/r/20240229095714.926789-3-yukuai1@huaweicloud.com
Stable-dep-of: 257ac239ffcf ("md/raid1: fix choose next idle in read_balance()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/raid1.c | 85 +++++++++++++++++++++++++++++-----------------
 1 file changed, 53 insertions(+), 32 deletions(-)

diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index 71bd372c14e2c..57e2487a03507 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -1761,6 +1761,44 @@ static int raid1_spare_active(struct mddev *mddev)
 	return count;
 }
 
+static bool raid1_add_conf(struct r1conf *conf, struct md_rdev *rdev, int disk,
+			   bool replacement)
+{
+	struct raid1_info *info = conf->mirrors + disk;
+
+	if (replacement)
+		info += conf->raid_disks;
+
+	if (info->rdev)
+		return false;
+
+	rdev->raid_disk = disk;
+	info->head_position = 0;
+	info->seq_start = MaxSector;
+	WRITE_ONCE(info->rdev, rdev);
+
+	return true;
+}
+
+static bool raid1_remove_conf(struct r1conf *conf, int disk)
+{
+	struct raid1_info *info = conf->mirrors + disk;
+	struct md_rdev *rdev = info->rdev;
+
+	if (!rdev || test_bit(In_sync, &rdev->flags) ||
+	    atomic_read(&rdev->nr_pending))
+		return false;
+
+	/* Only remove non-faulty devices if recovery is not possible. */
+	if (!test_bit(Faulty, &rdev->flags) &&
+	    rdev->mddev->recovery_disabled != conf->recovery_disabled &&
+	    rdev->mddev->degraded < conf->raid_disks)
+		return false;
+
+	WRITE_ONCE(info->rdev, NULL);
+	return true;
+}
+
 static int raid1_add_disk(struct mddev *mddev, struct md_rdev *rdev)
 {
 	struct r1conf *conf = mddev->private;
@@ -1796,15 +1834,13 @@ static int raid1_add_disk(struct mddev *mddev, struct md_rdev *rdev)
 				disk_stack_limits(mddev->gendisk, rdev->bdev,
 						  rdev->data_offset << 9);
 
-			p->head_position = 0;
-			rdev->raid_disk = mirror;
+			raid1_add_conf(conf, rdev, mirror, false);
 			err = 0;
 			/* As all devices are equivalent, we don't need a full recovery
 			 * if this was recently any drive of the array
 			 */
 			if (rdev->saved_raid_disk < 0)
 				conf->fullsync = 1;
-			WRITE_ONCE(p->rdev, rdev);
 			break;
 		}
 		if (test_bit(WantReplacement, &p->rdev->flags) &&
@@ -1814,13 +1850,11 @@ static int raid1_add_disk(struct mddev *mddev, struct md_rdev *rdev)
 
 	if (err && repl_slot >= 0) {
 		/* Add this device as a replacement */
-		p = conf->mirrors + repl_slot;
 		clear_bit(In_sync, &rdev->flags);
 		set_bit(Replacement, &rdev->flags);
-		rdev->raid_disk = repl_slot;
+		raid1_add_conf(conf, rdev, repl_slot, true);
 		err = 0;
 		conf->fullsync = 1;
-		WRITE_ONCE(p[conf->raid_disks].rdev, rdev);
 	}
 
 	print_conf(conf);
@@ -1837,27 +1871,20 @@ static int raid1_remove_disk(struct mddev *mddev, struct md_rdev *rdev)
 	if (unlikely(number >= conf->raid_disks))
 		goto abort;
 
-	if (rdev != p->rdev)
-		p = conf->mirrors + conf->raid_disks + number;
+	if (rdev != p->rdev) {
+		number += conf->raid_disks;
+		p = conf->mirrors + number;
+	}
 
 	print_conf(conf);
 	if (rdev == p->rdev) {
-		if (test_bit(In_sync, &rdev->flags) ||
-		    atomic_read(&rdev->nr_pending)) {
-			err = -EBUSY;
-			goto abort;
-		}
-		/* Only remove non-faulty devices if recovery
-		 * is not possible.
-		 */
-		if (!test_bit(Faulty, &rdev->flags) &&
-		    mddev->recovery_disabled != conf->recovery_disabled &&
-		    mddev->degraded < conf->raid_disks) {
+		if (!raid1_remove_conf(conf, number)) {
 			err = -EBUSY;
 			goto abort;
 		}
-		WRITE_ONCE(p->rdev, NULL);
-		if (conf->mirrors[conf->raid_disks + number].rdev) {
+
+		if (number < conf->raid_disks &&
+		    conf->mirrors[conf->raid_disks + number].rdev) {
 			/* We just removed a device that is being replaced.
 			 * Move down the replacement.  We drain all IO before
 			 * doing this to avoid confusion.
@@ -3000,23 +3027,17 @@ static struct r1conf *setup_conf(struct mddev *mddev)
 
 	err = -EINVAL;
 	spin_lock_init(&conf->device_lock);
+	conf->raid_disks = mddev->raid_disks;
 	rdev_for_each(rdev, mddev) {
 		int disk_idx = rdev->raid_disk;
-		if (disk_idx >= mddev->raid_disks
-		    || disk_idx < 0)
+
+		if (disk_idx >= conf->raid_disks || disk_idx < 0)
 			continue;
-		if (test_bit(Replacement, &rdev->flags))
-			disk = conf->mirrors + mddev->raid_disks + disk_idx;
-		else
-			disk = conf->mirrors + disk_idx;
 
-		if (disk->rdev)
+		if (!raid1_add_conf(conf, rdev, disk_idx,
+				    test_bit(Replacement, &rdev->flags)))
 			goto abort;
-		disk->rdev = rdev;
-		disk->head_position = 0;
-		disk->seq_start = MaxSector;
 	}
-	conf->raid_disks = mddev->raid_disks;
 	conf->mddev = mddev;
 	INIT_LIST_HEAD(&conf->retry_list);
 	INIT_LIST_HEAD(&conf->bio_end_io_list);
-- 
2.43.0


