Return-Path: <linux-kernel+bounces-12661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C19E181F897
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 14:02:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 368AB1F24226
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 13:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3287E12E4A;
	Thu, 28 Dec 2023 12:58:27 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F8210946;
	Thu, 28 Dec 2023 12:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4T17pr3CZQz4f3lDJ;
	Thu, 28 Dec 2023 20:58:12 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id DDF2B1A017F;
	Thu, 28 Dec 2023 20:58:17 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgBHlQvmcI1lvcx3Ew--.36075S7;
	Thu, 28 Dec 2023 20:58:17 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: song@kernel.org,
	yukuai3@huawei.com,
	neilb@suse.de
Cc: linux-raid@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH -next 3/3] md: use interruptible apis in idle/frozen_sync_thread()
Date: Thu, 28 Dec 2023 20:55:53 +0800
Message-Id: <20231228125553.2697765-4-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231228125553.2697765-1-yukuai1@huaweicloud.com>
References: <20231228125553.2697765-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBHlQvmcI1lvcx3Ew--.36075S7
X-Coremail-Antispam: 1UD129KBjvJXoW3JFyrKFyfAFW3Aw13Jr4Utwb_yoWxury3p3
	yIgF98Ar45JrZ3Zr4DK3WkAayrZw1IqayDtry7Wa4fJw1fKrsrKFyY9a4UZFykCa4rAw4U
	Ja1rJF4fCFZ7Wr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9m14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JrWl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF04k20xvY0x0EwIxGrwCFx2
	IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v2
	6r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67
	AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IY
	s7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr
	0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUd8n5UUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

Before refactoring idle and frozen from action_store, interruptible apis
is used so that hungtask warning won't be triggered if it takes too long
to finish idle/frozen sync_thread. So change to use interruptible apis.

In order not to make stop_sync_thread() more complicated, factor out a
helper prepare_to_stop_sync_thread() to replace stop_sync_thread().

Also return error to user if idle/frozen_sync_thread() failed, otherwise
user will be misleaded.

Fixes: 130443d60b1b ("md: refactor idle/frozen_sync_thread() to fix deadlock")
Fixes: 8e8e2518fcec ("md: Close race when setting 'action' to 'idle'.")
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/md.c | 105 ++++++++++++++++++++++++++++++------------------
 1 file changed, 67 insertions(+), 38 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 60f99768a1a9..9ea05de79fe4 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -4846,26 +4846,34 @@ action_show(struct mddev *mddev, char *page)
 	return sprintf(page, "%s\n", type);
 }
 
+static bool sync_thread_stopped(struct mddev *mddev, int *sync_seq)
+{
+	if (!test_bit(MD_RECOVERY_RUNNING, &mddev->recovery))
+		return true;
+
+	if (sync_seq && *sync_seq != atomic_read(&mddev->sync_seq))
+		return true;
+
+	return false;
+}
+
 /**
- * stop_sync_thread() - wait for sync_thread to stop if it's running.
+ * prepare_to_stop_sync_thread() - prepare to stop sync_thread if it's running.
  * @mddev:	the array.
- * @locked:	if set, reconfig_mutex will still be held after this function
- *		return; if not set, reconfig_mutex will be released after this
- *		function return.
- * @check_seq:	if set, only wait for curent running sync_thread to stop, noted
- *		that new sync_thread can still start.
+ * @unlock:	whether or not caller want to release reconfig_mutex if
+ *		sync_thread is not running.
+ *
+ * Return true if sync_thread is running, release reconfig_mutex and do
+ * preparatory work to stop sync_thread, caller should wait for
+ * sync_thread_stopped() to return true. Return false if sync_thread is not
+ * running, reconfig_mutex will be released if @unlock is set.
  */
-static void stop_sync_thread(struct mddev *mddev, bool locked, bool check_seq)
+static bool prepare_to_stop_sync_thread(struct mddev *mddev, bool unlock)
 {
-	int sync_seq;
-
-	if (check_seq)
-		sync_seq = atomic_read(&mddev->sync_seq);
-
 	if (!test_bit(MD_RECOVERY_RUNNING, &mddev->recovery)) {
-		if (!locked)
+		if (unlock)
 			mddev_unlock(mddev);
-		return;
+		return false;
 	}
 
 	mddev_unlock(mddev);
@@ -4879,53 +4887,67 @@ static void stop_sync_thread(struct mddev *mddev, bool locked, bool check_seq)
 	if (work_pending(&mddev->sync_work))
 		flush_work(&mddev->sync_work);
 
-	wait_event(resync_wait,
-		   !test_bit(MD_RECOVERY_RUNNING, &mddev->recovery) ||
-		   (check_seq && sync_seq != atomic_read(&mddev->sync_seq)));
-
-	if (locked)
-		mddev_lock_nointr(mddev);
+	return true;
 }
 
-static void idle_sync_thread(struct mddev *mddev)
+static int idle_sync_thread(struct mddev *mddev)
 {
-	mutex_lock(&mddev->sync_mutex);
+	int sync_seq = atomic_read(&mddev->sync_seq);
+	int err = mutex_lock_interruptible(&mddev->sync_mutex);
+
+	if (err)
+		return err;
 	clear_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
 
-	if (mddev_lock(mddev)) {
+	err = mddev_lock(mddev);
+	if (err) {
 		mutex_unlock(&mddev->sync_mutex);
-		return;
+		return err;
 	}
 
-	stop_sync_thread(mddev, false, true);
+	if (prepare_to_stop_sync_thread(mddev, true))
+		err = wait_event_interruptible(resync_wait,
+			   sync_thread_stopped(mddev, &sync_seq));
+
 	mutex_unlock(&mddev->sync_mutex);
+
+	return err;
 }
 
-static void frozen_sync_thread(struct mddev *mddev)
+static int frozen_sync_thread(struct mddev *mddev)
 {
-	mutex_lock(&mddev->sync_mutex);
+	int err = mutex_lock_interruptible(&mddev->sync_mutex);
+
+	if (err)
+		return err;
 	set_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
 
-	if (mddev_lock(mddev)) {
+	err = mddev_lock(mddev);
+	if (err) {
 		mutex_unlock(&mddev->sync_mutex);
-		return;
+		return err;
 	}
 
-	stop_sync_thread(mddev, false, false);
+	if (prepare_to_stop_sync_thread(mddev, true))
+		err = wait_event_interruptible(resync_wait,
+			   sync_thread_stopped(mddev, NULL));
 	mutex_unlock(&mddev->sync_mutex);
+
+	return err;
 }
 
 static ssize_t
 action_store(struct mddev *mddev, const char *page, size_t len)
 {
+	int err = 0;
+
 	if (!mddev->pers || !mddev->pers->sync_request)
 		return -EINVAL;
 
-
 	if (cmd_match(page, "idle"))
-		idle_sync_thread(mddev);
+		err = idle_sync_thread(mddev);
 	else if (cmd_match(page, "frozen"))
-		frozen_sync_thread(mddev);
+		err = frozen_sync_thread(mddev);
 	else if (test_bit(MD_RECOVERY_RUNNING, &mddev->recovery))
 		return -EBUSY;
 	else if (cmd_match(page, "resync"))
@@ -4934,7 +4956,6 @@ action_store(struct mddev *mddev, const char *page, size_t len)
 		clear_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
 		set_bit(MD_RECOVERY_RECOVER, &mddev->recovery);
 	} else if (cmd_match(page, "reshape")) {
-		int err;
 		if (mddev->pers->start_reshape == NULL)
 			return -EINVAL;
 		err = mddev_lock(mddev);
@@ -4980,7 +5001,7 @@ action_store(struct mddev *mddev, const char *page, size_t len)
 	set_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
 	md_wakeup_thread(mddev->thread);
 	sysfs_notify_dirent_safe(mddev->sysfs_action);
-	return len;
+	return err ? err : len;
 }
 
 static struct md_sysfs_entry md_scan_mode =
@@ -6280,7 +6301,11 @@ static void md_clean(struct mddev *mddev)
 
 static void __md_stop_writes(struct mddev *mddev)
 {
-	stop_sync_thread(mddev, true, false);
+	if (prepare_to_stop_sync_thread(mddev, false)) {
+		wait_event(resync_wait, sync_thread_stopped(mddev, NULL));
+		mddev_lock_nointr(mddev);
+	}
+
 	del_timer_sync(&mddev->safemode_timer);
 
 	if (mddev->pers && mddev->pers->quiesce) {
@@ -6369,7 +6394,8 @@ static int md_set_readonly(struct mddev *mddev, struct block_device *bdev)
 		set_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
 	}
 
-	stop_sync_thread(mddev, false, false);
+	if (prepare_to_stop_sync_thread(mddev, true))
+		wait_event(resync_wait, sync_thread_stopped(mddev, NULL));
 	wait_event(mddev->sb_wait,
 		   !test_bit(MD_SB_CHANGE_PENDING, &mddev->sb_flags));
 	mddev_lock_nointr(mddev);
@@ -6421,7 +6447,10 @@ static int do_md_stop(struct mddev *mddev, int mode,
 		set_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
 	}
 
-	stop_sync_thread(mddev, true, false);
+	if (prepare_to_stop_sync_thread(mddev, false)) {
+		wait_event(resync_wait, sync_thread_stopped(mddev, NULL));
+		mddev_lock_nointr(mddev);
+	}
 
 	mutex_lock(&mddev->open_mutex);
 	if ((mddev->pers && atomic_read(&mddev->openers) > !!bdev) ||
-- 
2.39.2


