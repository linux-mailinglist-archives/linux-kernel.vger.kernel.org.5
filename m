Return-Path: <linux-kernel+bounces-74366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E374985D31D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 10:11:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11A771C2254D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 09:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 386EA3D56F;
	Wed, 21 Feb 2024 09:07:30 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14EF33D576;
	Wed, 21 Feb 2024 09:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708506445; cv=none; b=O78TAYCRh69oZIy+LQJudGI10j7Fe/rXGtQ9a6oGcaSQlf6Gn2wTppcLXyq0lshY/plvLhVlT795BJg08hBXeSmiZTS97rg5Fa5DYSW9D1IkUzvYKCVQ8H5ZNl0An71HkTKtwlBJb/LTU3k4lPQC5kmapxaQJl08A+L3Wr2G/PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708506445; c=relaxed/simple;
	bh=YYB5LvmnN6Hst4z0XRzNTIaIeLr1z5XlifL/wMlc+bo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QgaFjnS929WYrvAqRIGPUbkTHb/6JmFnl3fiowSgxhGBMxcdhVVnkOTfnk0HWvT7Bn3pOlSONXbbXT3sJJWenmC4zY/Sxziw9IaSJbRiZD00/SWVSX5vu/2j7Gw5pvU/GHNa7hYZGqIoVjZ1Lu3dBdCq1HIuwAQmQ5pY3cJmsYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Tfr4d34rCz4f3jdL;
	Wed, 21 Feb 2024 17:06:57 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 653541A0568;
	Wed, 21 Feb 2024 17:07:02 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgDHlxAsvdVlKPi+Eg--.18486S4;
	Wed, 21 Feb 2024 17:06:54 +0800 (CST)
From: linan666@huaweicloud.com
To: axboe@kernel.dk,
	song@kernel.org,
	yukuai3@huawei.com
Cc: linux-raid@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linan666@huaweicloud.com,
	yi.zhang@huawei.com,
	houtao1@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH v2] block: fix deadlock between bd_link_disk_holder and partition scan
Date: Wed, 21 Feb 2024 17:01:22 +0800
Message-Id: <20240221090122.1281868-1-linan666@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgDHlxAsvdVlKPi+Eg--.18486S4
X-Coremail-Antispam: 1UD129KBjvJXoWxZFy8KF45WF43KryfXFyftFb_yoW5uF48pF
	Z8KFWktry8tF4DuF4Dt3y7ur4UKw18Wa1xJr97KrWS9rZrAr4v9Fy2yFy7uFy8KrWIyFWD
	tF1UX3yYva10k3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBj14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
	F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r
	4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I
	648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lw4CEc2x0rVAKj4xxMxAIw28IcxkI7VAKI4
	8JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xv
	wVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjx
	v20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20E
	Y4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
	0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0JUBSoJUUUUU=
X-CM-SenderInfo: polqt0awwwqx5xdzvxpfor3voofrz/

From: Li Nan <linan122@huawei.com>

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
---
v2: add a blk_ prefix to 'holder_mutex'.

 block/holder.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/block/holder.c b/block/holder.c
index 37d18c13d958..791091a7eac2 100644
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
2.39.2


