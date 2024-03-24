Return-Path: <linux-kernel+bounces-112911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE845887FAF
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:41:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76B67B212FE
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 22:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2224C6BB39;
	Sun, 24 Mar 2024 22:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L1Bcpp1v"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7E167A0E;
	Sun, 24 Mar 2024 22:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319722; cv=none; b=k2Vf3epMh4KJv3qGd6U4gUvqFKiTBmgHxmeIUQLZuPSy0KTUuMiTmaDUjn3I6sHZH2jloOhPhGyUgQB3LjP/vSdADY1cXZ4IEffxnxRmC8eybVJRL/BJEwYnny3vw/f1Jxppo3Ap75rObGrGlduj7x4sXxiC9jYbTtscwVkwpVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319722; c=relaxed/simple;
	bh=XOYrKTWco8HiIB6DZWLSwMFHj0pkQP8UMX5FuLWZT+E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gbMXPxfq2AZTNwd9jD28/bIGUmz8GAi+0BU6mDeEIQHxOt/9kNw9zxgnPZT+OYDqUVb8u4NJ/JJZIAdtvjZcifjnEtGiDlFDPrT0SuMO7k3bPpHQKsqOb0lZAy65xnm35RmDjkO5t+rA9DCITf8MAn8S+rb+THKZgYLfK783H8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L1Bcpp1v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54CA2C43390;
	Sun, 24 Mar 2024 22:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319722;
	bh=XOYrKTWco8HiIB6DZWLSwMFHj0pkQP8UMX5FuLWZT+E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L1Bcpp1vwc34Mu5u5YKDWt8bF0LmhngwLMF7c0qvDQB5b7yZQLQ8UJIRjeoaFj9hO
	 qCkcQ++Hk7qXJf+Y8fTv177YE/ev/DCEMdqjSx/JUGhDio79kxhD0jIterw9pKFDrQ
	 DAylzTVef9OG9SASkHiEMaae3veCTkGSqFA4iywFSGzzQFOZdlKf9EJWNgwyHb3wMo
	 JEKhs60KB9AJ7tGrAfn70d/Xcakq6tjZyPAlvrwP8e23BiF1P+/Y60Jo2AiujscFqd
	 Pwoot/KCxzdpUac3+f8bXd51i7ZU2a2mc7f/gJLycKpdakNzmzlw28fKZbLaa0YNlf
	 Je8+9PSdJqaRA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Li Nan <linan122@huawei.com>,
	mgperkow@gmail.com,
	Christoph Hellwig <hch@lst.de>,
	Yu Kuai <yukuai3@huawei.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 024/715] block: fix deadlock between bd_link_disk_holder and partition scan
Date: Sun, 24 Mar 2024 18:23:23 -0400
Message-ID: <20240324223455.1342824-25-sashal@kernel.org>
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


