Return-Path: <linux-kernel+bounces-54552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1C8384B09A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 10:02:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 265D41F238AA
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 09:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8053212F59C;
	Tue,  6 Feb 2024 09:00:02 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8ECE12DDB4;
	Tue,  6 Feb 2024 08:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707210001; cv=none; b=A1nk8TnDqB2OnbjvCNwuwOqSigSV886cZGPgETIDgV7oqaLZN3yuzl3MFNhlTfAqdKHVH01ixNqCWjY8Wydqm2XKRqho+18rJfiJgWpHBcdPRLcnPiILTw9NHDB2NrNsq73E+EfevFb5PeWIncIrkGY484pIzg8etFwsAqldebA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707210001; c=relaxed/simple;
	bh=0nXUeGguJuzk+QCYWlm2HVHhWdjhdiMjANKTPaOvan4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Hgtfh9FBcsHZ65PvjrPGsM8orprE4zZhFyMfW6bZUH9ihoUSgIqh58NYBrdASWx0VpzA2DVcaFhV56qT+IkEWdrIxWxjOexa6gFUaKEmtRm9V7h0NI1c8tOIL6pMe66N6ca6p+of67iwX1h4rZv929pb4vXou9Ii3XiaFmXOjb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4TTcdM53Znz4f3knd;
	Tue,  6 Feb 2024 16:59:51 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 236AA1A027B;
	Tue,  6 Feb 2024 16:59:56 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgCXaBEG9cFldA+QDA--.34552S12;
	Tue, 06 Feb 2024 16:59:55 +0800 (CST)
From: linan666@huaweicloud.com
To: song@kernel.org,
	mariusz.tkaczyk@linux.intel.com,
	shli@fb.com,
	neilb@suse.com
Cc: linux-raid@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linan666@huaweicloud.com,
	yukuai3@huawei.com,
	yi.zhang@huawei.com,
	houtao1@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH v6 8/9] md: clean up openers check in do_md_stop() and md_set_readonly()
Date: Tue,  6 Feb 2024 16:55:10 +0800
Message-Id: <20240206085511.2841555-9-linan666@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240206085511.2841555-1-linan666@huaweicloud.com>
References: <20240206085511.2841555-1-linan666@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgCXaBEG9cFldA+QDA--.34552S12
X-Coremail-Antispam: 1UD129KBjvJXoWxCw1UWw1xuF1DCr1xJrW3trb_yoWrtw47p3
	yIqas8Gr4UX3sIqF4UGFWku3WYvw18KFyktry3C3yruF1ftrnrWFyFgF18Ary8Kas7Awn8
	Xa1YyFyUuFy7GrUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQY14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0V
	AKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1l
	Ox8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErc
	IFxwACI402YVCY1x02628vn2kIc2xKxwAKzVCY07xG64k0F24l42xK82IYc2Ij64vIr41l
	4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67
	AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8I
	cVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4
	v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AK
	xVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbxR67UUUUU==
X-CM-SenderInfo: polqt0awwwqx5xdzvxpfor3voofrz/

From: Li Nan <linan122@huawei.com>

Before stopping or setting readonly, mddev_set_closing_and_sync_blockdev()
is always called to check the openers. So no longer need to check it again
in do_md_stop() and md_set_readonly(). Clean it up.

Signed-off-by: Li Nan <linan122@huawei.com>
---
 drivers/md/md.c | 38 ++++++++++++++------------------------
 1 file changed, 14 insertions(+), 24 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 200410a8adf3..adb821626d66 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -4475,8 +4475,8 @@ array_state_show(struct mddev *mddev, char *page)
 	return sprintf(page, "%s\n", array_states[st]);
 }
 
-static int do_md_stop(struct mddev *mddev, int ro, struct block_device *bdev);
-static int md_set_readonly(struct mddev *mddev, struct block_device *bdev);
+static int do_md_stop(struct mddev *mddev, int ro);
+static int md_set_readonly(struct mddev *mddev);
 static int restart_array(struct mddev *mddev);
 
 static ssize_t
@@ -4537,14 +4537,14 @@ array_state_store(struct mddev *mddev, const char *buf, size_t len)
 	case inactive:
 		/* stop an active array, return 0 otherwise */
 		if (mddev->pers)
-			err = do_md_stop(mddev, 2, NULL);
+			err = do_md_stop(mddev, 2);
 		break;
 	case clear:
-		err = do_md_stop(mddev, 0, NULL);
+		err = do_md_stop(mddev, 0);
 		break;
 	case readonly:
 		if (mddev->pers)
-			err = md_set_readonly(mddev, NULL);
+			err = md_set_readonly(mddev);
 		else {
 			mddev->ro = MD_RDONLY;
 			set_disk_ro(mddev->gendisk, 1);
@@ -4554,7 +4554,7 @@ array_state_store(struct mddev *mddev, const char *buf, size_t len)
 	case read_auto:
 		if (mddev->pers) {
 			if (md_is_rdwr(mddev))
-				err = md_set_readonly(mddev, NULL);
+				err = md_set_readonly(mddev);
 			else if (mddev->ro == MD_RDONLY)
 				err = restart_array(mddev);
 			if (err == 0) {
@@ -6412,7 +6412,7 @@ void md_stop(struct mddev *mddev)
 
 EXPORT_SYMBOL_GPL(md_stop);
 
-static int md_set_readonly(struct mddev *mddev, struct block_device *bdev)
+static int md_set_readonly(struct mddev *mddev)
 {
 	int err = 0;
 	int did_freeze = 0;
@@ -6440,9 +6440,7 @@ static int md_set_readonly(struct mddev *mddev, struct block_device *bdev)
 		   !test_bit(MD_SB_CHANGE_PENDING, &mddev->sb_flags));
 	mddev_lock_nointr(mddev);
 
-	mutex_lock(&mddev->open_mutex);
-	if ((mddev->pers && atomic_read(&mddev->openers) > !!bdev) ||
-	    mddev->sync_thread ||
+	if (mddev->sync_thread ||
 	    test_bit(MD_RECOVERY_RUNNING, &mddev->recovery)) {
 		pr_warn("md: %s still in use.\n",mdname(mddev));
 		if (did_freeze) {
@@ -6468,7 +6466,6 @@ static int md_set_readonly(struct mddev *mddev, struct block_device *bdev)
 		err = 0;
 	}
 out:
-	mutex_unlock(&mddev->open_mutex);
 	return err;
 }
 
@@ -6476,8 +6473,7 @@ static int md_set_readonly(struct mddev *mddev, struct block_device *bdev)
  *   0 - completely stop and dis-assemble array
  *   2 - stop but do not disassemble array
  */
-static int do_md_stop(struct mddev *mddev, int mode,
-		      struct block_device *bdev)
+static int do_md_stop(struct mddev *mddev, int mode)
 {
 	struct gendisk *disk = mddev->gendisk;
 	struct md_rdev *rdev;
@@ -6503,13 +6499,9 @@ static int do_md_stop(struct mddev *mddev, int mode,
 					   &mddev->recovery)));
 	mddev_lock_nointr(mddev);
 
-	mutex_lock(&mddev->open_mutex);
-	if ((mddev->pers && atomic_read(&mddev->openers) > !!bdev) ||
-	    mddev->sysfs_active ||
-	    mddev->sync_thread ||
+	if (mddev->sysfs_active || mddev->sync_thread ||
 	    test_bit(MD_RECOVERY_RUNNING, &mddev->recovery)) {
 		pr_warn("md: %s still in use.\n",mdname(mddev));
-		mutex_unlock(&mddev->open_mutex);
 		if (did_freeze) {
 			clear_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
 			set_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
@@ -6532,13 +6524,11 @@ static int do_md_stop(struct mddev *mddev, int mode,
 				sysfs_unlink_rdev(mddev, rdev);
 
 		set_capacity_and_notify(disk, 0);
-		mutex_unlock(&mddev->open_mutex);
 		mddev->changed = 1;
 
 		if (!md_is_rdwr(mddev))
 			mddev->ro = MD_RDWR;
-	} else
-		mutex_unlock(&mddev->open_mutex);
+	}
 	/*
 	 * Free resources if final stop
 	 */
@@ -6584,7 +6574,7 @@ static void autorun_array(struct mddev *mddev)
 	err = do_md_run(mddev);
 	if (err) {
 		pr_warn("md: do_md_run() returned %d\n", err);
-		do_md_stop(mddev, 0, NULL);
+		do_md_stop(mddev, 0);
 	}
 }
 
@@ -7758,11 +7748,11 @@ static int md_ioctl(struct block_device *bdev, blk_mode_t mode,
 		goto unlock;
 
 	case STOP_ARRAY:
-		err = do_md_stop(mddev, 0, bdev);
+		err = do_md_stop(mddev, 0);
 		goto unlock;
 
 	case STOP_ARRAY_RO:
-		err = md_set_readonly(mddev, bdev);
+		err = md_set_readonly(mddev);
 		goto unlock;
 
 	case HOT_REMOVE_DISK:
-- 
2.39.2


