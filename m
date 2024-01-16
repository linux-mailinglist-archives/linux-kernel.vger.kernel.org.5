Return-Path: <linux-kernel+bounces-28204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20BCD82FB8C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:58:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 256C41C26BD4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 311D6167AEB;
	Tue, 16 Jan 2024 20:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BhlkdH3b"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DDDD46541;
	Tue, 16 Jan 2024 20:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705435439; cv=none; b=Z+CRoDLqpZgzf0SFE8w5hJ9KbajhKqkgP52crGH4x5XuHSElVD/8lzTs2UVy49t0F46L/tMPCwpnGxTovKIfqXgStPUOfEFo7LISqiKDDS0jiEdg7tMt9gzKEGuHq0iP4+CI5zUDRBUpmTeCFs2R3dl4l5D76U2gzAefBMtCflU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705435439; c=relaxed/simple;
	bh=bgIZ/LM5ecZycuvyZGeGCyGT7ptvx1lcQAv87wpJdNY=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=FyX0sjgjObvHYAfeXO2b/IF/lB3BP+4v4rLNnJgWLAD6Fls3Ua0BC+o7Shxp8rG4nVfi3EU95TKWfLF2HLZt7X2XXBzcm3WtFGjEJ8C4pvXqYCFLsvVu0s9DK+o58CtW9wINvHkKw70vEt3L5VPq1ZSM9ju4vmXI2iV6MEdAYBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BhlkdH3b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 640ECC433C7;
	Tue, 16 Jan 2024 20:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705435439;
	bh=bgIZ/LM5ecZycuvyZGeGCyGT7ptvx1lcQAv87wpJdNY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BhlkdH3bdN3632bQYHN4oaBgRmYHsEIJ1nk1ExJoNh2x+L75LQAaQDLAP1YTzlOF2
	 H+QrE7/dXfuf8qvqVvgkdThhUX9OqY52O3Y3msS83zqohpKrXn37PBS092o14MhnYr
	 NH2LKzFnLZ6DD1jsDsy3/S0Zj++nZl6mVZhFQdK7zJJ/xlxYzmIzpq02PVUmkEGlSf
	 jIUCzPmzmdGWeVNuSVhfC8XvF03fLqKNIsIzmeoTJr62gAlNMXzoX8xOXKrlrjv8n/
	 vPFVo3FVRag43b6ezJpdeZ88WH4OVKNSLsAhNrz2zHkUnp6DKd6jYXKjPfsXXy6EZl
	 7uLEupDdpcjvQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alex Lyakas <alex.lyakas@zadara.com>,
	Song Liu <song@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-raid@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 24/31] md: Whenassemble the array, consult the superblock of the freshest device
Date: Tue, 16 Jan 2024 15:02:33 -0500
Message-ID: <20240116200310.259340-24-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116200310.259340-1-sashal@kernel.org>
References: <20240116200310.259340-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.267
Content-Transfer-Encoding: 8bit

From: Alex Lyakas <alex.lyakas@zadara.com>

[ Upstream commit dc1cc22ed58f11d58d8553c5ec5f11cbfc3e3039 ]

Upon assembling the array, both kernel and mdadm allow the devices to have event
counter difference of 1, and still consider them as up-to-date.
However, a device whose event count is behind by 1, may in fact not be up-to-date,
and array resync with such a device may cause data corruption.
To avoid this, consult the superblock of the freshest device about the status
of a device, whose event counter is behind by 1.

Signed-off-by: Alex Lyakas <alex.lyakas@zadara.com>
Signed-off-by: Song Liu <song@kernel.org>
Link: https://lore.kernel.org/r/1702470271-16073-1-git-send-email-alex.lyakas@zadara.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/md.c | 54 ++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 44 insertions(+), 10 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index a006f3a9554b..61c3e8df1b55 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -1098,6 +1098,7 @@ struct super_type  {
 					  struct md_rdev *refdev,
 					  int minor_version);
 	int		    (*validate_super)(struct mddev *mddev,
+					      struct md_rdev *freshest,
 					      struct md_rdev *rdev);
 	void		    (*sync_super)(struct mddev *mddev,
 					  struct md_rdev *rdev);
@@ -1236,8 +1237,9 @@ static int super_90_load(struct md_rdev *rdev, struct md_rdev *refdev, int minor
 
 /*
  * validate_super for 0.90.0
+ * note: we are not using "freshest" for 0.9 superblock
  */
-static int super_90_validate(struct mddev *mddev, struct md_rdev *rdev)
+static int super_90_validate(struct mddev *mddev, struct md_rdev *freshest, struct md_rdev *rdev)
 {
 	mdp_disk_t *desc;
 	mdp_super_t *sb = page_address(rdev->sb_page);
@@ -1752,7 +1754,7 @@ static int super_1_load(struct md_rdev *rdev, struct md_rdev *refdev, int minor_
 	return ret;
 }
 
-static int super_1_validate(struct mddev *mddev, struct md_rdev *rdev)
+static int super_1_validate(struct mddev *mddev, struct md_rdev *freshest, struct md_rdev *rdev)
 {
 	struct mdp_superblock_1 *sb = page_address(rdev->sb_page);
 	__u64 ev1 = le64_to_cpu(sb->events);
@@ -1848,13 +1850,15 @@ static int super_1_validate(struct mddev *mddev, struct md_rdev *rdev)
 		}
 	} else if (mddev->pers == NULL) {
 		/* Insist of good event counter while assembling, except for
-		 * spares (which don't need an event count) */
-		++ev1;
+		 * spares (which don't need an event count).
+		 * Similar to mdadm, we allow event counter difference of 1
+		 * from the freshest device.
+		 */
 		if (rdev->desc_nr >= 0 &&
 		    rdev->desc_nr < le32_to_cpu(sb->max_dev) &&
 		    (le16_to_cpu(sb->dev_roles[rdev->desc_nr]) < MD_DISK_ROLE_MAX ||
 		     le16_to_cpu(sb->dev_roles[rdev->desc_nr]) == MD_DISK_ROLE_JOURNAL))
-			if (ev1 < mddev->events)
+			if (ev1 + 1 < mddev->events)
 				return -EINVAL;
 	} else if (mddev->bitmap) {
 		/* If adding to array with a bitmap, then we can accept an
@@ -1875,8 +1879,38 @@ static int super_1_validate(struct mddev *mddev, struct md_rdev *rdev)
 		    rdev->desc_nr >= le32_to_cpu(sb->max_dev)) {
 			role = MD_DISK_ROLE_SPARE;
 			rdev->desc_nr = -1;
-		} else
+		} else if (mddev->pers == NULL && freshest && ev1 < mddev->events) {
+			/*
+			 * If we are assembling, and our event counter is smaller than the
+			 * highest event counter, we cannot trust our superblock about the role.
+			 * It could happen that our rdev was marked as Faulty, and all other
+			 * superblocks were updated with +1 event counter.
+			 * Then, before the next superblock update, which typically happens when
+			 * remove_and_add_spares() removes the device from the array, there was
+			 * a crash or reboot.
+			 * If we allow current rdev without consulting the freshest superblock,
+			 * we could cause data corruption.
+			 * Note that in this case our event counter is smaller by 1 than the
+			 * highest, otherwise, this rdev would not be allowed into array;
+			 * both kernel and mdadm allow event counter difference of 1.
+			 */
+			struct mdp_superblock_1 *freshest_sb = page_address(freshest->sb_page);
+			u32 freshest_max_dev = le32_to_cpu(freshest_sb->max_dev);
+
+			if (rdev->desc_nr >= freshest_max_dev) {
+				/* this is unexpected, better not proceed */
+				pr_warn("md: %s: rdev[%pg]: desc_nr(%d) >= freshest(%pg)->sb->max_dev(%u)\n",
+						mdname(mddev), rdev->bdev, rdev->desc_nr,
+						freshest->bdev, freshest_max_dev);
+				return -EUCLEAN;
+			}
+
+			role = le16_to_cpu(freshest_sb->dev_roles[rdev->desc_nr]);
+			pr_debug("md: %s: rdev[%pg]: role=%d(0x%x) according to freshest %pg\n",
+				     mdname(mddev), rdev->bdev, role, role, freshest->bdev);
+		} else {
 			role = le16_to_cpu(sb->dev_roles[rdev->desc_nr]);
+		}
 		switch(role) {
 		case MD_DISK_ROLE_SPARE: /* spare */
 			break;
@@ -2780,7 +2814,7 @@ static int add_bound_rdev(struct md_rdev *rdev)
 		 * and should be added immediately.
 		 */
 		super_types[mddev->major_version].
-			validate_super(mddev, rdev);
+			validate_super(mddev, NULL/*freshest*/, rdev);
 		if (add_journal)
 			mddev_suspend(mddev);
 		err = mddev->pers->hot_add_disk(mddev, rdev);
@@ -3690,7 +3724,7 @@ static int analyze_sbs(struct mddev *mddev)
 	}
 
 	super_types[mddev->major_version].
-		validate_super(mddev, freshest);
+		validate_super(mddev, NULL/*freshest*/, freshest);
 
 	i = 0;
 	rdev_for_each_safe(rdev, tmp, mddev) {
@@ -3705,7 +3739,7 @@ static int analyze_sbs(struct mddev *mddev)
 		}
 		if (rdev != freshest) {
 			if (super_types[mddev->major_version].
-			    validate_super(mddev, rdev)) {
+			    validate_super(mddev, freshest, rdev)) {
 				pr_warn("md: kicking non-fresh %s from array!\n",
 					bdevname(rdev->bdev,b));
 				md_kick_rdev_from_array(rdev);
@@ -6610,7 +6644,7 @@ static int add_new_disk(struct mddev *mddev, mdu_disk_info_t *info)
 			rdev->saved_raid_disk = rdev->raid_disk;
 		} else
 			super_types[mddev->major_version].
-				validate_super(mddev, rdev);
+				validate_super(mddev, NULL/*freshest*/, rdev);
 		if ((info->state & (1<<MD_DISK_SYNC)) &&
 		     rdev->raid_disk != info->raid_disk) {
 			/* This was a hot-add request, but events doesn't
-- 
2.43.0


