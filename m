Return-Path: <linux-kernel+bounces-12659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4D9681F88F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 14:02:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A873287505
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 13:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78633125BF;
	Thu, 28 Dec 2023 12:58:26 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9638A107B9;
	Thu, 28 Dec 2023 12:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4T17pv6tjlz4f3jYr;
	Thu, 28 Dec 2023 20:58:15 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 82C891A017B;
	Thu, 28 Dec 2023 20:58:17 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgBHlQvmcI1lvcx3Ew--.36075S6;
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
Subject: [PATCH -next 2/3] md: remove redundant md_wakeup_thread()
Date: Thu, 28 Dec 2023 20:55:52 +0800
Message-Id: <20231228125553.2697765-3-yukuai1@huaweicloud.com>
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
X-CM-TRANSID:cCh0CgBHlQvmcI1lvcx3Ew--.36075S6
X-Coremail-Antispam: 1UD129KBjvJXoW3XF13Aw18XrWkZr48Gw1fXrb_yoW7Xw18pa
	yfJF98Cr45A34fAFsrKa4DGa45Zr1jqFWDtrW3u3yrJ3WfKw4SgFyY9FyDJ3yvyaykZw45
	Xa1rGF48Za4xWF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9m14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
	x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF04k20xvY0x0EwIxGrwCFx2
	IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v2
	6r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67
	AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IY
	s7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr
	0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUc6pPUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

On the one hand, mddev_unlock() will call md_wakeup_thread()
unconditionally; on the other hand, md_check_recovery() can't make
progress if 'reconfig_mutex' can't be grabbed. Hence, it really doesn't
make sense to wake up daemon thread while 'reconfig_mutex' is still
grabbed.

Remove all the md_wakup_thread() for 'mddev->thread' while
'reconfig_mtuex' is still grabbed.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/md.c | 20 ++------------------
 1 file changed, 2 insertions(+), 18 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 2208eed3baac..60f99768a1a9 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -2904,7 +2904,6 @@ static int add_bound_rdev(struct md_rdev *rdev)
 		set_bit(MD_RECOVERY_RECOVER, &mddev->recovery);
 	set_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
 	md_new_event();
-	md_wakeup_thread(mddev->thread);
 	return 0;
 }
 
@@ -3019,10 +3018,8 @@ state_store(struct md_rdev *rdev, const char *buf, size_t len)
 
 			if (err == 0) {
 				md_kick_rdev_from_array(rdev);
-				if (mddev->pers) {
+				if (mddev->pers)
 					set_bit(MD_SB_CHANGE_DEVS, &mddev->sb_flags);
-					md_wakeup_thread(mddev->thread);
-				}
 				md_new_event();
 			}
 		}
@@ -3052,7 +3049,6 @@ state_store(struct md_rdev *rdev, const char *buf, size_t len)
 		clear_bit(BlockedBadBlocks, &rdev->flags);
 		wake_up(&rdev->blocked_wait);
 		set_bit(MD_RECOVERY_NEEDED, &rdev->mddev->recovery);
-		md_wakeup_thread(rdev->mddev->thread);
 
 		err = 0;
 	} else if (cmd_match(buf, "insync") && rdev->raid_disk == -1) {
@@ -3090,7 +3086,6 @@ state_store(struct md_rdev *rdev, const char *buf, size_t len)
 		    !test_bit(Replacement, &rdev->flags))
 			set_bit(WantReplacement, &rdev->flags);
 		set_bit(MD_RECOVERY_NEEDED, &rdev->mddev->recovery);
-		md_wakeup_thread(rdev->mddev->thread);
 		err = 0;
 	} else if (cmd_match(buf, "-want_replacement")) {
 		/* Clearing 'want_replacement' is always allowed.
@@ -3220,7 +3215,6 @@ slot_store(struct md_rdev *rdev, const char *buf, size_t len)
 		if (rdev->raid_disk >= 0)
 			return -EBUSY;
 		set_bit(MD_RECOVERY_NEEDED, &rdev->mddev->recovery);
-		md_wakeup_thread(rdev->mddev->thread);
 	} else if (rdev->mddev->pers) {
 		/* Activating a spare .. or possibly reactivating
 		 * if we ever get bitmaps working here.
@@ -6166,7 +6160,6 @@ int do_md_run(struct mddev *mddev)
 	/* run start up tasks that require md_thread */
 	md_start(mddev);
 
-	md_wakeup_thread(mddev->thread);
 	md_wakeup_thread(mddev->sync_thread); /* possibly kick off a reshape */
 
 	set_capacity_and_notify(mddev->gendisk, mddev->array_sectors);
@@ -6187,7 +6180,6 @@ int md_start(struct mddev *mddev)
 
 	if (mddev->pers->start) {
 		set_bit(MD_RECOVERY_WAIT, &mddev->recovery);
-		md_wakeup_thread(mddev->thread);
 		ret = mddev->pers->start(mddev);
 		clear_bit(MD_RECOVERY_WAIT, &mddev->recovery);
 		md_wakeup_thread(mddev->sync_thread);
@@ -6232,7 +6224,6 @@ static int restart_array(struct mddev *mddev)
 	pr_debug("md: %s switched to read-write mode.\n", mdname(mddev));
 	/* Kick recovery or resync if necessary */
 	set_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
-	md_wakeup_thread(mddev->thread);
 	md_wakeup_thread(mddev->sync_thread);
 	sysfs_notify_dirent_safe(mddev->sysfs_state);
 	return 0;
@@ -6376,7 +6367,6 @@ static int md_set_readonly(struct mddev *mddev, struct block_device *bdev)
 	if (!test_bit(MD_RECOVERY_FROZEN, &mddev->recovery)) {
 		did_freeze = 1;
 		set_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
-		md_wakeup_thread(mddev->thread);
 	}
 
 	stop_sync_thread(mddev, false, false);
@@ -6408,7 +6398,6 @@ static int md_set_readonly(struct mddev *mddev, struct block_device *bdev)
 	if ((mddev->pers && !err) || did_freeze) {
 		clear_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
 		set_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
-		md_wakeup_thread(mddev->thread);
 		sysfs_notify_dirent_safe(mddev->sysfs_state);
 	}
 
@@ -6430,7 +6419,6 @@ static int do_md_stop(struct mddev *mddev, int mode,
 	if (!test_bit(MD_RECOVERY_FROZEN, &mddev->recovery)) {
 		did_freeze = 1;
 		set_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
-		md_wakeup_thread(mddev->thread);
 	}
 
 	stop_sync_thread(mddev, true, false);
@@ -6444,7 +6432,6 @@ static int do_md_stop(struct mddev *mddev, int mode,
 		if (did_freeze) {
 			clear_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
 			set_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
-			md_wakeup_thread(mddev->thread);
 		}
 		return -EBUSY;
 	}
@@ -6985,9 +6972,7 @@ static int hot_remove_disk(struct mddev *mddev, dev_t dev)
 
 	md_kick_rdev_from_array(rdev);
 	set_bit(MD_SB_CHANGE_DEVS, &mddev->sb_flags);
-	if (mddev->thread)
-		md_wakeup_thread(mddev->thread);
-	else
+	if (!mddev->thread)
 		md_update_sb(mddev, 1);
 	md_new_event();
 
@@ -7069,7 +7054,6 @@ static int hot_add_disk(struct mddev *mddev, dev_t dev)
 	 * array immediately.
 	 */
 	set_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
-	md_wakeup_thread(mddev->thread);
 	md_new_event();
 	return 0;
 
-- 
2.39.2


