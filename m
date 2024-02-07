Return-Path: <linux-kernel+bounces-56224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0A1C84C795
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 10:37:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C4041F29F90
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 09:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7A954596F;
	Wed,  7 Feb 2024 09:32:54 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EACF20DFA;
	Wed,  7 Feb 2024 09:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707298374; cv=none; b=tzSbRHUNkc1Gt9RoQYIC8V/T+mAZPCsMXqTClxtPUqLkhRzZq/62pM8wIygUQfTUlSB+yIheLTS+iit2Aj+RepSdAXSRDNcVmfF/amB8gNjphF0DG7VNDFPNKQaIoTBjsxbdIpaIaxLi5cGHlwTGff9ibmFIaxcYES/A0i301hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707298374; c=relaxed/simple;
	bh=7u+z3q+4Hs3vIsnTCgfHn67LCKeRoHsrK3+hSZEaDt0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kHfmuE0nCQe9eIW5fU+oYG2Wgo9bSpVVlAOVuqadVQI0gaGRrh1paPv1OW5UxHQTeM8dKEofRixX6UBz9hhOh916lI122Cr9a3cGTpAwjUo14YIXI0uWFCPh4HZ6VWW7zCcx+JXcM4PgJ9hz4OZLeJxu4vtJHo8GQ6BcCFps58Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4TVFJh5RQmz4f3jsm;
	Wed,  7 Feb 2024 17:32:36 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 394401A0A9A;
	Wed,  7 Feb 2024 17:32:41 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgDHlxA3TsNl4_n7DA--.43370S4;
	Wed, 07 Feb 2024 17:32:41 +0800 (CST)
From: linan666@huaweicloud.com
To: axboe@kernel.dk
Cc: linux-raid@vger.kernel.org,
	song@kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linan666@huaweicloud.com,
	yukuai3@huawei.com,
	yi.zhang@huawei.com,
	houtao1@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH] block: fix deadlock between bd_link_disk_holder and partition scan
Date: Wed,  7 Feb 2024 17:27:56 +0800
Message-Id: <20240207092756.2087888-1-linan666@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgDHlxA3TsNl4_n7DA--.43370S4
X-Coremail-Antispam: 1UD129KBjvJXoWxZFy8KF45WF43KryfWr4rKrg_yoW5Cr4fpF
	Z0gFZ7try8ta1Dur4Dt3y7Zr4UKw18Wa1xJr97KFy29rZrArs29r12yFy7uFy8KrWIyF4D
	tF1UX3yYvF40k3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9E14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
	0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr
	1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IE
	rcIFxwACI402YVCY1x02628vn2kIc2xKxwAKzVCY07xG64k0F24l42xK82IYc2Ij64vIr4
	1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK
	67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI
	8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAv
	wI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxV
	AFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7VUbSApUUUUUU==
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

Fix it by introducing a local mutex 'holder_mutex' to replace 'open_mutex'.

Signed-off-by: Li Nan <linan122@huawei.com>
---
 block/holder.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/block/holder.c b/block/holder.c
index 37d18c13d958..5bfb0a674cc7 100644
--- a/block/holder.c
+++ b/block/holder.c
@@ -8,6 +8,8 @@ struct bd_holder_disk {
 	int			refcnt;
 };
 
+static DEFINE_MUTEX(holder_mutex);
+
 static struct bd_holder_disk *bd_find_holder_disk(struct block_device *bdev,
 						  struct gendisk *disk)
 {
@@ -80,7 +82,7 @@ int bd_link_disk_holder(struct block_device *bdev, struct gendisk *disk)
 	kobject_get(bdev->bd_holder_dir);
 	mutex_unlock(&bdev->bd_disk->open_mutex);
 
-	mutex_lock(&disk->open_mutex);
+	mutex_lock(&holder_mutex);
 	WARN_ON_ONCE(!bdev->bd_holder);
 
 	holder = bd_find_holder_disk(bdev, disk);
@@ -108,7 +110,7 @@ int bd_link_disk_holder(struct block_device *bdev, struct gendisk *disk)
 		goto out_del_symlink;
 	list_add(&holder->list, &disk->slave_bdevs);
 
-	mutex_unlock(&disk->open_mutex);
+	mutex_unlock(&holder_mutex);
 	return 0;
 
 out_del_symlink:
@@ -116,7 +118,7 @@ int bd_link_disk_holder(struct block_device *bdev, struct gendisk *disk)
 out_free_holder:
 	kfree(holder);
 out_unlock:
-	mutex_unlock(&disk->open_mutex);
+	mutex_unlock(&holder_mutex);
 	if (ret)
 		kobject_put(bdev->bd_holder_dir);
 	return ret;
@@ -140,7 +142,7 @@ void bd_unlink_disk_holder(struct block_device *bdev, struct gendisk *disk)
 	if (WARN_ON_ONCE(!disk->slave_dir))
 		return;
 
-	mutex_lock(&disk->open_mutex);
+	mutex_lock(&holder_mutex);
 	holder = bd_find_holder_disk(bdev, disk);
 	if (!WARN_ON_ONCE(holder == NULL) && !--holder->refcnt) {
 		del_symlink(disk->slave_dir, bdev_kobj(bdev));
@@ -149,6 +151,6 @@ void bd_unlink_disk_holder(struct block_device *bdev, struct gendisk *disk)
 		list_del_init(&holder->list);
 		kfree(holder);
 	}
-	mutex_unlock(&disk->open_mutex);
+	mutex_unlock(&holder_mutex);
 }
 EXPORT_SYMBOL_GPL(bd_unlink_disk_holder);
-- 
2.39.2


