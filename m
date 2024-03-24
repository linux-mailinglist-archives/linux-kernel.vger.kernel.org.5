Return-Path: <linux-kernel+bounces-115352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96446889B10
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:43:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 049E028BC57
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 798FB1EC4A4;
	Mon, 25 Mar 2024 02:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ufk0EqLy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32FF41422A7;
	Sun, 24 Mar 2024 22:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320543; cv=none; b=cvFqLEH42s6HWdm/owRSOvoJ7BB00dDsUKWo/Fn6aEehfe2AtRupsZqho8+5gO1Iaw/jrt2qIBYv/tJCMKMoBPv1D6LBGImLgR710dTg2AJPIk946voo4F4f+zU8Y9SzZJgHpbE/DJqJRJYJzO1+X7GhC1iphj6cK/p5EVR+dk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320543; c=relaxed/simple;
	bh=XOYrKTWco8HiIB6DZWLSwMFHj0pkQP8UMX5FuLWZT+E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rCVESlKVtD7txpYj6a7VaP0oO3da7zv1WzmA18+HHiEcs9Xsxz1DyJ7pudxR4Sib7GlzYqiROro/QCn2gVTqQhi9M4yWkXvujcp60J2abvRKANryyFwrxPW6jsxihbuoDl6QP5C1hgj/kNcULLeXR8NhaF4LAfxfAsGYuz6qd/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ufk0EqLy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B0BFC433C7;
	Sun, 24 Mar 2024 22:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320542;
	bh=XOYrKTWco8HiIB6DZWLSwMFHj0pkQP8UMX5FuLWZT+E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ufk0EqLy47YI1XjhjNSFGELxXH1u9A+L5C4TEnHUoFKexnV85wXZYZYXcFLwi04qG
	 rmjHsmmoD/JzJ+pb+hL6qkBiDhei8gPfvgnoJD6Db3pz/5JHYQz23b/KUiduxKrTop
	 vWluBzM4GMTvEW+Ysxch7AN7IsR2YdO/WhfOO1AXjI652fohLnxoYp/aBzdBJtdzE5
	 kLQkPEnQxeean6RZB6QRzY5pMYAGVmm/m529mn/9Sa4GPKJjfuQ1PoXTrodKUZ7/RP
	 lLC/ahauQvbE+B+KP4tW8LWTzdJy+yNIwDUJRONxv+W7O9O5D1tEq1g+OJyRuhZn0v
	 PCfQ9LM26UXkQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Li Nan <linan122@huawei.com>,
	mgperkow@gmail.com,
	Christoph Hellwig <hch@lst.de>,
	Yu Kuai <yukuai3@huawei.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 103/713] block: fix deadlock between bd_link_disk_holder and partition scan
Date: Sun, 24 Mar 2024 18:37:09 -0400
Message-ID: <20240324224720.1345309-104-sashal@kernel.org>
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

From: Li Nan <linan122@huawei.com>

[ Upstream commit 03f12122b20b6e6028e9ed69030a49f9cffcbb75 ]

'open_mutex' of gendisk is used to protect open/close block devices. But
in bd_link_disk_holder(), it is used to protect the creation of symlink
between holding disk and slave bdev, which introduces some issues.

When bd_link_disk_holder() is called, the driver is usually in the process
of initialization/modification and may suspend submitting io. At this
time, any io hold 'open_mutex', such as scanning partitions, can cause
deadlocks. For example, in raid:

T1                              T2
bdev_open_by_dev
 lock open_mutex [1]
 ...
  efi_partition
  ...
   md_submit_bio
				md_ioctl mddev_syspend
				  -> suspend all io
				 md_add_new_disk
				  bind_rdev_to_array
				   bd_link_disk_holder
				    try lock open_mutex [2]
    md_handle_request
     -> wait mddev_resume

T1 scan partition, T2 add a new device to raid. T1 waits for T2 to resume
mddev, but T2 waits for open_mutex held by T1. Deadlock occurs.

Fix it by introducing a local mutex 'blk_holder_mutex' to replace
'open_mutex'.

Fixes: 1b0a2d950ee2 ("md: use new apis to suspend array for ioctls involed array reconfiguration")
Reported-by: mgperkow@gmail.com
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218459
Signed-off-by: Li Nan <linan122@huawei.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Yu Kuai <yukuai3@huawei.com>
Link: https://lore.kernel.org/r/20240221090122.1281868-1-linan666@huaweicloud.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/holder.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/block/holder.c b/block/holder.c
index 37d18c13d9581..791091a7eac23 100644
--- a/block/holder.c
+++ b/block/holder.c
@@ -8,6 +8,8 @@ struct bd_holder_disk {
 	int			refcnt;
 };
 
+static DEFINE_MUTEX(blk_holder_mutex);
+
 static struct bd_holder_disk *bd_find_holder_disk(struct block_device *bdev,
 						  struct gendisk *disk)
 {
@@ -80,7 +82,7 @@ int bd_link_disk_holder(struct block_device *bdev, struct gendisk *disk)
 	kobject_get(bdev->bd_holder_dir);
 	mutex_unlock(&bdev->bd_disk->open_mutex);
 
-	mutex_lock(&disk->open_mutex);
+	mutex_lock(&blk_holder_mutex);
 	WARN_ON_ONCE(!bdev->bd_holder);
 
 	holder = bd_find_holder_disk(bdev, disk);
@@ -108,7 +110,7 @@ int bd_link_disk_holder(struct block_device *bdev, struct gendisk *disk)
 		goto out_del_symlink;
 	list_add(&holder->list, &disk->slave_bdevs);
 
-	mutex_unlock(&disk->open_mutex);
+	mutex_unlock(&blk_holder_mutex);
 	return 0;
 
 out_del_symlink:
@@ -116,7 +118,7 @@ int bd_link_disk_holder(struct block_device *bdev, struct gendisk *disk)
 out_free_holder:
 	kfree(holder);
 out_unlock:
-	mutex_unlock(&disk->open_mutex);
+	mutex_unlock(&blk_holder_mutex);
 	if (ret)
 		kobject_put(bdev->bd_holder_dir);
 	return ret;
@@ -140,7 +142,7 @@ void bd_unlink_disk_holder(struct block_device *bdev, struct gendisk *disk)
 	if (WARN_ON_ONCE(!disk->slave_dir))
 		return;
 
-	mutex_lock(&disk->open_mutex);
+	mutex_lock(&blk_holder_mutex);
 	holder = bd_find_holder_disk(bdev, disk);
 	if (!WARN_ON_ONCE(holder == NULL) && !--holder->refcnt) {
 		del_symlink(disk->slave_dir, bdev_kobj(bdev));
@@ -149,6 +151,6 @@ void bd_unlink_disk_holder(struct block_device *bdev, struct gendisk *disk)
 		list_del_init(&holder->list);
 		kfree(holder);
 	}
-	mutex_unlock(&disk->open_mutex);
+	mutex_unlock(&blk_holder_mutex);
 }
 EXPORT_SYMBOL_GPL(bd_unlink_disk_holder);
-- 
2.43.0


