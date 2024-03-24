Return-Path: <linux-kernel+bounces-115167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41D7B88932E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:23:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB65F1F30194
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 192121C881C;
	Mon, 25 Mar 2024 01:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RIUpUvU4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A503A291B7C;
	Sun, 24 Mar 2024 23:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324238; cv=none; b=tpBemvVAliVXyie77DUi4ZxOW4HqoUCc2QAZ0Q4oOm6kaUQOQ0T68VMGRACNNQhGF0JDriIKA9xT8V3sL7aH6BQM3RjC15RnjjxxbnpT/wxXnNPhSznjss9gVAWLV9353IPojFqyunOuRvH7Oxd0lU4Wo6IIOk2KS0hjDKr5XRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324238; c=relaxed/simple;
	bh=2K95XuFUUlB5s66cKWmbhLkdOpfBkjlpzMybXLaXRhE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K5kenHCtgl94YQHz/VDtR3J8itykHzxKE1C9VPYYh5/4lXhsqG64+ERXh1fPo3a7CB+nR9+ynn4rhb8pGz1pHLcXvbTZEEsG9ePZHj0r+O7FLLT5njrb4qZsXwm7OzZYF7h4rJP6Ia/e7Hz7r0OSE+EBJnz47za4uKo6IMH1Uws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RIUpUvU4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D31D1C43399;
	Sun, 24 Mar 2024 23:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324237;
	bh=2K95XuFUUlB5s66cKWmbhLkdOpfBkjlpzMybXLaXRhE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RIUpUvU4GlLWp/tdZl17isLU250oHTLZ/tCpToygpS45eK4veiWUvDlG6DgS41S6Q
	 1WtwOpF2vxNhndIs2cCWYgNJarQueUUZOXVlgyBHkAbDm7rGSiPSYgTynoiMVxrU08
	 6v7yMli51f9AQ2thAq0U079oqoVOc3Yn3YscS50v/dzhFsHYKsqQtklDcS3E1QhwT1
	 3B1hkOzCJnhx9nbZa+8SYaPqzvr4DTtZ54wl3axsbmRVspMk0VG2NqkmtZba8cnq2W
	 lzrYCw9EfMJd62i6da9SBSNjLYUmD7rfQGPj6xpwJsdcIJOHeYHjpAL8M1KIzjxxpv
	 +vTSJM1Uo9+7w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 020/148] md: switch to ->check_events for media change notifications
Date: Sun, 24 Mar 2024 19:48:04 -0400
Message-ID: <20240324235012.1356413-21-sashal@kernel.org>
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

[ Upstream commit a564e23f0f99759f453dbefcb9160dec6d99df96 ]

md is the last driver using the legacy media_changed method.  Switch
it over to (not so) new ->clear_events approach, which also removes the
need for the ->revalidate_disk method.

Signed-off-by: Christoph Hellwig <hch@lst.de>
[axboe: remove unused 'bdops' variable in disk_clear_events()]
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Stable-dep-of: 9674f54e41ff ("md: Don't clear MD_CLOSING when the raid is about to stop")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Documentation/filesystems/Locking |  4 +---
 block/genhd.c                     |  8 +-------
 drivers/md/md.c                   | 19 ++++++++-----------
 include/linux/blkdev.h            |  2 --
 4 files changed, 10 insertions(+), 23 deletions(-)

diff --git a/Documentation/filesystems/Locking b/Documentation/filesystems/Locking
index efea228ccd8af..da300708404d1 100644
--- a/Documentation/filesystems/Locking
+++ b/Documentation/filesystems/Locking
@@ -404,7 +404,6 @@ prototypes:
 	int (*compat_ioctl) (struct block_device *, fmode_t, unsigned, unsigned long);
 	int (*direct_access) (struct block_device *, sector_t, void **,
 				unsigned long *);
-	int (*media_changed) (struct gendisk *);
 	void (*unlock_native_capacity) (struct gendisk *);
 	int (*revalidate_disk) (struct gendisk *);
 	int (*getgeo)(struct block_device *, struct hd_geometry *);
@@ -417,13 +416,12 @@ release:		yes
 ioctl:			no
 compat_ioctl:		no
 direct_access:		no
-media_changed:		no
 unlock_native_capacity:	no
 revalidate_disk:	no
 getgeo:			no
 swap_slot_free_notify:	no	(see below)
 
-media_changed, unlock_native_capacity and revalidate_disk are called only from
+unlock_native_capacity and revalidate_disk are called only from
 check_disk_change().
 
 swap_slot_free_notify is called with swap_lock and sometimes the page lock
diff --git a/block/genhd.c b/block/genhd.c
index 27a410d310870..d2502e175aca0 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1771,18 +1771,12 @@ void disk_flush_events(struct gendisk *disk, unsigned int mask)
  */
 unsigned int disk_clear_events(struct gendisk *disk, unsigned int mask)
 {
-	const struct block_device_operations *bdops = disk->fops;
 	struct disk_events *ev = disk->ev;
 	unsigned int pending;
 	unsigned int clearing = mask;
 
-	if (!ev) {
-		/* for drivers still using the old ->media_changed method */
-		if ((mask & DISK_EVENT_MEDIA_CHANGE) &&
-		    bdops->media_changed && bdops->media_changed(disk))
-			return DISK_EVENT_MEDIA_CHANGE;
+	if (!ev)
 		return 0;
-	}
 
 	disk_block_events(disk);
 
diff --git a/drivers/md/md.c b/drivers/md/md.c
index 3cc28b2836078..a137f8b4a0541 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -5455,6 +5455,7 @@ static int md_alloc(dev_t dev, char *name)
 	 * remove it now.
 	 */
 	disk->flags |= GENHD_FL_EXT_DEVT;
+	disk->events |= DISK_EVENT_MEDIA_CHANGE;
 	mddev->gendisk = disk;
 	add_disk(disk);
 
@@ -7565,20 +7566,17 @@ static void md_release(struct gendisk *disk, fmode_t mode)
 	mddev_put(mddev);
 }
 
-static int md_media_changed(struct gendisk *disk)
-{
-	struct mddev *mddev = disk->private_data;
-
-	return mddev->changed;
-}
-
-static int md_revalidate(struct gendisk *disk)
+static unsigned int md_check_events(struct gendisk *disk, unsigned int clearing)
 {
 	struct mddev *mddev = disk->private_data;
+	unsigned int ret = 0;
 
+	if (mddev->changed)
+		ret = DISK_EVENT_MEDIA_CHANGE;
 	mddev->changed = 0;
-	return 0;
+	return ret;
 }
+
 static const struct block_device_operations md_fops =
 {
 	.owner		= THIS_MODULE,
@@ -7589,8 +7587,7 @@ static const struct block_device_operations md_fops =
 	.compat_ioctl	= md_compat_ioctl,
 #endif
 	.getgeo		= md_getgeo,
-	.media_changed  = md_media_changed,
-	.revalidate_disk= md_revalidate,
+	.check_events	= md_check_events,
 };
 
 static int md_thread(void *arg)
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 56fe682d9beb4..ac407c1d4d40f 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1994,8 +1994,6 @@ struct block_device_operations {
 	int (*compat_ioctl) (struct block_device *, fmode_t, unsigned, unsigned long);
 	unsigned int (*check_events) (struct gendisk *disk,
 				      unsigned int clearing);
-	/* ->media_changed() is DEPRECATED, use ->check_events() instead */
-	int (*media_changed) (struct gendisk *);
 	void (*unlock_native_capacity) (struct gendisk *);
 	int (*revalidate_disk) (struct gendisk *);
 	int (*getgeo)(struct block_device *, struct hd_geometry *);
-- 
2.43.0


