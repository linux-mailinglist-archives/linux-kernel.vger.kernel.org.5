Return-Path: <linux-kernel+bounces-112925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F1AEA887FCC
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:44:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81792B2231F
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 22:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88AC771B2D;
	Sun, 24 Mar 2024 22:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mEKdGbum"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B011771747;
	Sun, 24 Mar 2024 22:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319737; cv=none; b=R5jrZKEuQw7LvtusPXf/8gGf26kTw38Z9taZUdUdQqPBj1vcGVhrXztS4fWaDPKWXhoPbVzEJnnm2//n6RulndbBB6FO3hEsu+tU4HrYhjTWmxbRzFMmzpZzTa87rWD4MFhR9HLbofQ6/N/zVfvi6AjRMHKEdorIMClniBzZYF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319737; c=relaxed/simple;
	bh=DnHkSY9plbk9r7wPX12P8m0EHcoLpjUbPAbBxvt2Jqg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RgRUFQ4HAfLhb2qYc9wku4vYb/nr1DYkhkbRlwoCFFFfknQvWUcvwC0bRUZhZXiRNO4ejMSY7djnUDkeCoLq8FluYnr8h+j41lRSGtfS2IJx+p4kTAvRqzqB+zFKmXFaeO0nzEvd6OsJMbqzllCXp/sUWlmy/ChdidMgolHeAiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mEKdGbum; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B701CC433A6;
	Sun, 24 Mar 2024 22:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319737;
	bh=DnHkSY9plbk9r7wPX12P8m0EHcoLpjUbPAbBxvt2Jqg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mEKdGbum5vA/Mm8IrkbvMxJ2bSeLEqH9MNVU2bWrsmlLz1A3876hmqwpUrQ2xv4yw
	 kLCa5oe2Q6i68riiG4CrEwjVM5yw3Hocr+ftekexRumP1k5P1NyEhjwPO0qcowfwlT
	 Zrw2MjdiuW4RSVpJa45hnNZ4cZtW5p+M6nqQvXiDK1FMrv/fux/wp024SJnSESsod+
	 /DKCUdT7mEz9NKUyomk9U8Nm2WBebiQNOfadFxwdSCWot+zKdDwWOaCzLLGY3VIL9q
	 JVlvKQaF0Z7ldOW83w2BXkyb9L2i6vJG3qwtrVVfCObEYEAu9+n8eShiQumggHBAwF
	 fiM3zsyZ7YOqA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Yu Kuai <yukuai3@huawei.com>,
	Paul Luse <paul.e.luse@linux.intel.com>,
	Xiao Ni <xni@redhat.com>,
	Song Liu <song@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 038/715] md/raid1: fix choose next idle in read_balance()
Date: Sun, 24 Mar 2024 18:23:37 -0400
Message-ID: <20240324223455.1342824-39-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
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

[ Upstream commit 257ac239ffcfd097a9a0732bf5095fb00164f334 ]

Commit 12cee5a8a29e ("md/raid1: prevent merging too large request") add
the case choose next idle in read_balance():

read_balance:
 for_each_rdev
  if(next_seq_sect == this_sector || dist == 0)
  -> sequential reads
   best_disk = disk;
   if (...)
    choose_next_idle = 1
    continue;

 for_each_rdev
 -> iterate next rdev
  if (pending == 0)
   best_disk = disk;
   -> choose the next idle disk
   break;

  if (choose_next_idle)
   -> keep using this rdev if there are no other idle disk
   contine

However, commit 2e52d449bcec ("md/raid1: add failfast handling for reads.")
remove the code:

-               /* If device is idle, use it */
-               if (pending == 0) {
-                       best_disk = disk;
-                       break;
-               }

Hence choose next idle will never work now, fix this problem by
following:

1) don't set best_disk in this case, read_balance() will choose the best
   disk after iterating all the disks;
2) add 'pending' so that other idle disk will be chosen;
3) add a new local variable 'sequential_disk' to record the disk, and if
   there is no other idle disk, 'sequential_disk' will be chosen;

Fixes: 2e52d449bcec ("md/raid1: add failfast handling for reads.")
Co-developed-by: Paul Luse <paul.e.luse@linux.intel.com>
Signed-off-by: Paul Luse <paul.e.luse@linux.intel.com>
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Reviewed-by: Xiao Ni <xni@redhat.com>
Signed-off-by: Song Liu <song@kernel.org>
Link: https://lore.kernel.org/r/20240229095714.926789-5-yukuai1@huaweicloud.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/raid1.c | 32 ++++++++++++++++++++++----------
 1 file changed, 22 insertions(+), 10 deletions(-)

diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index 456d745eb93b3..82c9bb404ccca 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -601,13 +601,12 @@ static int read_balance(struct r1conf *conf, struct r1bio *r1_bio, int *max_sect
 	const sector_t this_sector = r1_bio->sector;
 	int sectors;
 	int best_good_sectors;
-	int best_disk, best_dist_disk, best_pending_disk;
+	int best_disk, best_dist_disk, best_pending_disk, sequential_disk;
 	int disk;
 	sector_t best_dist;
 	unsigned int min_pending;
 	struct md_rdev *rdev;
 	int choose_first;
-	int choose_next_idle;
 
 	/*
 	 * Check if we can balance. We can balance on the whole
@@ -618,11 +617,11 @@ static int read_balance(struct r1conf *conf, struct r1bio *r1_bio, int *max_sect
 	sectors = r1_bio->sectors;
 	best_disk = -1;
 	best_dist_disk = -1;
+	sequential_disk = -1;
 	best_dist = MaxSector;
 	best_pending_disk = -1;
 	min_pending = UINT_MAX;
 	best_good_sectors = 0;
-	choose_next_idle = 0;
 	clear_bit(R1BIO_FailFast, &r1_bio->state);
 
 	if ((conf->mddev->recovery_cp < this_sector + sectors) ||
@@ -715,7 +714,6 @@ static int read_balance(struct r1conf *conf, struct r1bio *r1_bio, int *max_sect
 			int opt_iosize = bdev_io_opt(rdev->bdev) >> 9;
 			struct raid1_info *mirror = &conf->mirrors[disk];
 
-			best_disk = disk;
 			/*
 			 * If buffered sequential IO size exceeds optimal
 			 * iosize, check if there is idle disk. If yes, choose
@@ -734,15 +732,22 @@ static int read_balance(struct r1conf *conf, struct r1bio *r1_bio, int *max_sect
 			    mirror->next_seq_sect > opt_iosize &&
 			    mirror->next_seq_sect - opt_iosize >=
 			    mirror->seq_start) {
-				choose_next_idle = 1;
-				continue;
+				/*
+				 * Add 'pending' to avoid choosing this disk if
+				 * there is other idle disk.
+				 */
+				pending++;
+				/*
+				 * If there is no other idle disk, this disk
+				 * will be chosen.
+				 */
+				sequential_disk = disk;
+			} else {
+				best_disk = disk;
+				break;
 			}
-			break;
 		}
 
-		if (choose_next_idle)
-			continue;
-
 		if (min_pending > pending) {
 			min_pending = pending;
 			best_pending_disk = disk;
@@ -754,6 +759,13 @@ static int read_balance(struct r1conf *conf, struct r1bio *r1_bio, int *max_sect
 		}
 	}
 
+	/*
+	 * sequential IO size exceeds optimal iosize, however, there is no other
+	 * idle disk, so choose the sequential disk.
+	 */
+	if (best_disk == -1 && min_pending != 0)
+		best_disk = sequential_disk;
+
 	/*
 	 * If all disks are rotational, choose the closest disk. If any disk is
 	 * non-rotational, choose the disk with less pending request even the
-- 
2.43.0


