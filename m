Return-Path: <linux-kernel+bounces-41097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F043F83EBD4
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 08:54:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CF5FB2399F
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 07:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D89E2231B;
	Sat, 27 Jan 2024 07:52:34 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3117210EC;
	Sat, 27 Jan 2024 07:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706341953; cv=none; b=Kk6w4zcJ4wq1DiKmPhckeZF1NQMrSPhTLRTWgg69fqEcIvlNJxpo5UALg0XYCquW4UWtE7UGWN7M9AgxhhAApYs4SGmwgAze6/2M2VsnnNka6Q/WUtj2W97yTf+XYdVCouXMLDm3G+8zRiL9x9sHoPIucmOAfz8tO7A/8nwxgZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706341953; c=relaxed/simple;
	bh=dZCpGLgs1JsjUcuAOwp41TG3RiXfam80H98EBcaCbRk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uK/a+kiFmEFuhirwz1WUa5smlH+IMubcU2pinKo5rvT95iuElVOhWXGFI47aQIxDYkmSdWmSDN5SONYSfgH/lBoFh87N/NXPvZhe7sTBDoSGTjGVBI8VrMbDzlU0f0Q6GydHhBkkDZv0/U+B3GEFHTCRB4JMs6ZAgACmF5lXAQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4TMRc75wMKz4f3jYL;
	Sat, 27 Jan 2024 15:52:23 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id CF7681A0232;
	Sat, 27 Jan 2024 15:52:27 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgDHlxAetrRlWjeACA--.31980S8;
	Sat, 27 Jan 2024 15:52:25 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: mpatocka@redhat.com,
	heinzm@redhat.com,
	xni@redhat.com,
	agk@redhat.com,
	snitzer@kernel.org,
	dm-devel@lists.linux.dev,
	song@kernel.org,
	yukuai3@huawei.com,
	jbrassow@f14.redhat.com,
	neilb@suse.de,
	shli@fb.com,
	akpm@osdl.org
Cc: linux-kernel@vger.kernel.org,
	linux-raid@vger.kernel.org,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH v3 04/12] md: don't register sync_thread for reshape directly
Date: Sat, 27 Jan 2024 15:47:46 +0800
Message-Id: <20240127074754.2380890-5-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240127074754.2380890-1-yukuai1@huaweicloud.com>
References: <20240127074754.2380890-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgDHlxAetrRlWjeACA--.31980S8
X-Coremail-Antispam: 1UD129KBjvJXoW3Xry3Kw4kuF1xAry3KryrCrg_yoW7KF1fpa
	yfKF9xJr48A343ZrWUta4DXFW5uw1jqrWqyry3W3s5A3ZYyrZ3JFy5uFyUJFWkAa4kta15
	ta45tFWDZFyFgw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUP214x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
	W8JwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7VUbmZ
	X7UUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

Currently, if reshape is interrupted, then reassemble the array will
register sync_thread directly from pers->run(), in this case
'MD_RECOVERY_RUNNING' is set directly, however, there is no guarantee
that md_do_sync() will be executed, hence stop_sync_thread() will hang
because 'MD_RECOVERY_RUNNING' can't be cleared.

Last patch make sure that md_do_sync() will set MD_RECOVERY_DONE,
however, following hang can still be triggered by dm-raid test
shell/lvconvert-raid-reshape.sh occasionally:

[root@fedora ~]# cat /proc/1982/stack
[<0>] stop_sync_thread+0x1ab/0x270 [md_mod]
[<0>] md_frozen_sync_thread+0x5c/0xa0 [md_mod]
[<0>] raid_presuspend+0x1e/0x70 [dm_raid]
[<0>] dm_table_presuspend_targets+0x40/0xb0 [dm_mod]
[<0>] __dm_destroy+0x2a5/0x310 [dm_mod]
[<0>] dm_destroy+0x16/0x30 [dm_mod]
[<0>] dev_remove+0x165/0x290 [dm_mod]
[<0>] ctl_ioctl+0x4bb/0x7b0 [dm_mod]
[<0>] dm_ctl_ioctl+0x11/0x20 [dm_mod]
[<0>] vfs_ioctl+0x21/0x60
[<0>] __x64_sys_ioctl+0xb9/0xe0
[<0>] do_syscall_64+0xc6/0x230
[<0>] entry_SYSCALL_64_after_hwframe+0x6c/0x74

Meanwhile mddev->recovery is:
MD_RECOVERY_RUNNING |
MD_RECOVERY_INTR |
MD_RECOVERY_RESHAPE |
MD_RECOVERY_FROZEN

Fix this problem by remove the code to register sync_thread directly
from raid10 and raid5. And let md_check_recovery() to register
sync_thread.

Fixes: f67055780caa ("[PATCH] md: Checkpoint and allow restart of raid5 reshape")
Fixes: f52f5c71f3d4 ("md: fix stopping sync thread")
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/md.c     |  5 ++++-
 drivers/md/raid10.c | 16 ++--------------
 drivers/md/raid5.c  | 29 ++---------------------------
 3 files changed, 8 insertions(+), 42 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index c65dfd156090..6c5d0a372927 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -9372,6 +9372,7 @@ static void md_start_sync(struct work_struct *ws)
 	struct mddev *mddev = container_of(ws, struct mddev, sync_work);
 	int spares = 0;
 	bool suspend = false;
+	char *name;
 
 	if (md_spares_need_change(mddev))
 		suspend = true;
@@ -9404,8 +9405,10 @@ static void md_start_sync(struct work_struct *ws)
 	if (spares)
 		md_bitmap_write_all(mddev->bitmap);
 
+	name = test_bit(MD_RECOVERY_RESHAPE, &mddev->recovery) ?
+			"reshape" : "resync";
 	rcu_assign_pointer(mddev->sync_thread,
-			   md_register_thread(md_do_sync, mddev, "resync"));
+			   md_register_thread(md_do_sync, mddev, name));
 	if (!mddev->sync_thread) {
 		pr_warn("%s: could not start resync thread...\n",
 			mdname(mddev));
diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index 7412066ea22c..a5f8419e2df1 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -4175,11 +4175,7 @@ static int raid10_run(struct mddev *mddev)
 		clear_bit(MD_RECOVERY_SYNC, &mddev->recovery);
 		clear_bit(MD_RECOVERY_CHECK, &mddev->recovery);
 		set_bit(MD_RECOVERY_RESHAPE, &mddev->recovery);
-		set_bit(MD_RECOVERY_RUNNING, &mddev->recovery);
-		rcu_assign_pointer(mddev->sync_thread,
-			md_register_thread(md_do_sync, mddev, "reshape"));
-		if (!mddev->sync_thread)
-			goto out_free_conf;
+		set_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
 	}
 
 	return 0;
@@ -4573,16 +4569,8 @@ static int raid10_start_reshape(struct mddev *mddev)
 	clear_bit(MD_RECOVERY_CHECK, &mddev->recovery);
 	clear_bit(MD_RECOVERY_DONE, &mddev->recovery);
 	set_bit(MD_RECOVERY_RESHAPE, &mddev->recovery);
-	set_bit(MD_RECOVERY_RUNNING, &mddev->recovery);
-
-	rcu_assign_pointer(mddev->sync_thread,
-			   md_register_thread(md_do_sync, mddev, "reshape"));
-	if (!mddev->sync_thread) {
-		ret = -EAGAIN;
-		goto abort;
-	}
+	set_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
 	conf->reshape_checkpoint = jiffies;
-	md_wakeup_thread(mddev->sync_thread);
 	md_new_event();
 	return 0;
 
diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 8497880135ee..6a7a32f7fb91 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -7936,11 +7936,7 @@ static int raid5_run(struct mddev *mddev)
 		clear_bit(MD_RECOVERY_SYNC, &mddev->recovery);
 		clear_bit(MD_RECOVERY_CHECK, &mddev->recovery);
 		set_bit(MD_RECOVERY_RESHAPE, &mddev->recovery);
-		set_bit(MD_RECOVERY_RUNNING, &mddev->recovery);
-		rcu_assign_pointer(mddev->sync_thread,
-			md_register_thread(md_do_sync, mddev, "reshape"));
-		if (!mddev->sync_thread)
-			goto abort;
+		set_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
 	}
 
 	/* Ok, everything is just fine now */
@@ -8506,29 +8502,8 @@ static int raid5_start_reshape(struct mddev *mddev)
 	clear_bit(MD_RECOVERY_CHECK, &mddev->recovery);
 	clear_bit(MD_RECOVERY_DONE, &mddev->recovery);
 	set_bit(MD_RECOVERY_RESHAPE, &mddev->recovery);
-	set_bit(MD_RECOVERY_RUNNING, &mddev->recovery);
-	rcu_assign_pointer(mddev->sync_thread,
-			   md_register_thread(md_do_sync, mddev, "reshape"));
-	if (!mddev->sync_thread) {
-		mddev->recovery = 0;
-		spin_lock_irq(&conf->device_lock);
-		write_seqcount_begin(&conf->gen_lock);
-		mddev->raid_disks = conf->raid_disks = conf->previous_raid_disks;
-		mddev->new_chunk_sectors =
-			conf->chunk_sectors = conf->prev_chunk_sectors;
-		mddev->new_layout = conf->algorithm = conf->prev_algo;
-		rdev_for_each(rdev, mddev)
-			rdev->new_data_offset = rdev->data_offset;
-		smp_wmb();
-		conf->generation --;
-		conf->reshape_progress = MaxSector;
-		mddev->reshape_position = MaxSector;
-		write_seqcount_end(&conf->gen_lock);
-		spin_unlock_irq(&conf->device_lock);
-		return -EAGAIN;
-	}
+	set_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
 	conf->reshape_checkpoint = jiffies;
-	md_wakeup_thread(mddev->sync_thread);
 	md_new_event();
 	return 0;
 }
-- 
2.39.2


