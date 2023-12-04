Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F54B802A92
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 04:45:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbjLDDSF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 22:18:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjLDDSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 22:18:03 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B32C7E6;
        Sun,  3 Dec 2023 19:18:08 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.163.235])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Sk84X1Pq3z4f3jql;
        Mon,  4 Dec 2023 11:18:04 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
        by mail.maildlp.com (Postfix) with ESMTP id 355A01A0D34;
        Mon,  4 Dec 2023 11:18:05 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP1 (Coremail) with SMTP id cCh0CgDX2hDoRG1l06W7Cg--.50821S4;
        Mon, 04 Dec 2023 11:18:02 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     agk@redhat.com, snitzer@kernel.org, mpatocka@redhat.com,
        dm-devel@lists.linux.dev, song@kernel.org, yukuai3@huawei.com
Cc:     janpieter.sollie@edpnet.be, linux-kernel@vger.kernel.org,
        linux-raid@vger.kernel.org, yukuai1@huaweicloud.com,
        yi.zhang@huawei.com, yangerkun@huawei.com
Subject: [PATCH -next] md: split MD_RECOVERY_NEEDED out of mddev_resume
Date:   Mon,  4 Dec 2023 11:17:03 +0800
Message-Id: <20231204031703.3102254-1-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgDX2hDoRG1l06W7Cg--.50821S4
X-Coremail-Antispam: 1UD129KBjvJXoW3Jw4xtry3ZrWDZw4xJw43Wrg_yoW7Xw1Dpa
        97Jas3uw47WFWrXrWDAF1qga45Aw4jgrZFyrW3u3s7AFy5t34fuF15WFyqqrZ5ta4kAFW5
        Xw15JFs7ZryIgr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvY14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
        Y2ka0xkIwI1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
        xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
        MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
        0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v2
        6r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0J
        UdHUDUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

New mddev_resume() calls are added to synchroniza IO with array
reconfiguration, however, this introduce a regression while adding it in
md_start_sync():

1) someone set MD_RECOVERY_NEEDED first;
2) daemon thread grab reconfig_mutex, then clear MD_RECOVERY_NEEDED and
   queue a new sync work;
3) daemon thread release reconfig_mutex;
4) in md_start_sync
   a) check that there are spares that can be added/removed, then suspend
      the array;
   b) remove_and_add_spares may not be called, or called without really
      add/remove spares;
   c) resume the array, then set MD_RECOVERY_NEEDED again!

Loop between 2 - 4, then mddev_suspend() will be called quite often, for
consequence, normal IO will be quite slow.

Fix this problem by spliting MD_RECOVERY_NEEDED out of mddev_resume(), so
that md_start_sync() won't set such flag and hence the loop will be broken.

Fixes: bc08041b32ab ("md: suspend array in md_start_sync() if array need reconfiguration")
Reported-and-tested-by: Janpieter Sollie <janpieter.sollie@edpnet.be>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218200
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/dm-raid.c   | 1 +
 drivers/md/md-bitmap.c | 2 ++
 drivers/md/md.c        | 6 +++++-
 drivers/md/raid5.c     | 4 ++++
 4 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/md/dm-raid.c b/drivers/md/dm-raid.c
index eb009d6bb03a..e9c0d70f7fe5 100644
--- a/drivers/md/dm-raid.c
+++ b/drivers/md/dm-raid.c
@@ -4059,6 +4059,7 @@ static void raid_resume(struct dm_target *ti)
 		clear_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
 		mddev->ro = 0;
 		mddev->in_sync = 0;
+		set_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
 		mddev_unlock_and_resume(mddev);
 	}
 }
diff --git a/drivers/md/md-bitmap.c b/drivers/md/md-bitmap.c
index 9672f75c3050..16112750ee64 100644
--- a/drivers/md/md-bitmap.c
+++ b/drivers/md/md-bitmap.c
@@ -2428,6 +2428,7 @@ location_store(struct mddev *mddev, const char *buf, size_t len)
 	}
 	rv = 0;
 out:
+	set_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
 	mddev_unlock_and_resume(mddev);
 	if (rv)
 		return rv;
@@ -2571,6 +2572,7 @@ backlog_store(struct mddev *mddev, const char *buf, size_t len)
 	if (old_mwb != backlog)
 		md_bitmap_update_sb(mddev->bitmap);
 
+	set_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
 	mddev_unlock_and_resume(mddev);
 	return len;
 }
diff --git a/drivers/md/md.c b/drivers/md/md.c
index 4b1e8007dd15..48a1b12f3c2c 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -515,7 +515,6 @@ void mddev_resume(struct mddev *mddev)
 	percpu_ref_resurrect(&mddev->active_io);
 	wake_up(&mddev->sb_wait);
 
-	set_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
 	md_wakeup_thread(mddev->thread);
 	md_wakeup_thread(mddev->sync_thread); /* possibly kick off a reshape */
 
@@ -4146,6 +4145,7 @@ level_store(struct mddev *mddev, const char *buf, size_t len)
 	md_new_event();
 	rv = len;
 out_unlock:
+	set_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
 	mddev_unlock_and_resume(mddev);
 	return rv;
 }
@@ -4652,6 +4652,8 @@ new_dev_store(struct mddev *mddev, const char *buf, size_t len)
  out:
 	if (err)
 		export_rdev(rdev, mddev);
+	else
+		set_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
 	mddev_unlock_and_resume(mddev);
 	if (!err)
 		md_new_event();
@@ -5533,6 +5535,7 @@ serialize_policy_store(struct mddev *mddev, const char *buf, size_t len)
 		mddev_destroy_serial_pool(mddev, NULL);
 	mddev->serialize_policy = value;
 unlock:
+	set_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
 	mddev_unlock_and_resume(mddev);
 	return err ?: len;
 }
@@ -6593,6 +6596,7 @@ static void autorun_devices(int part)
 					export_rdev(rdev, mddev);
 			}
 			autorun_array(mddev);
+			set_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
 			mddev_unlock_and_resume(mddev);
 		}
 		/* on success, candidates will be empty, on error
diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 42ba3581cfea..f88f92517a18 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -6989,6 +6989,7 @@ raid5_store_stripe_size(struct mddev  *mddev, const char *page, size_t len)
 	mutex_unlock(&conf->cache_size_mutex);
 
 out_unlock:
+	set_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
 	mddev_unlock_and_resume(mddev);
 	return err ?: len;
 }
@@ -7090,6 +7091,7 @@ raid5_store_skip_copy(struct mddev *mddev, const char *page, size_t len)
 		else
 			blk_queue_flag_clear(QUEUE_FLAG_STABLE_WRITES, q);
 	}
+	set_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
 	mddev_unlock_and_resume(mddev);
 	return err ?: len;
 }
@@ -7169,6 +7171,7 @@ raid5_store_group_thread_cnt(struct mddev *mddev, const char *page, size_t len)
 			kfree(old_groups);
 		}
 	}
+	set_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
 	mddev_unlock_and_resume(mddev);
 
 	return err ?: len;
@@ -8920,6 +8923,7 @@ static int raid5_change_consistency_policy(struct mddev *mddev, const char *buf)
 	if (!err)
 		md_update_sb(mddev, 1);
 
+	set_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
 	mddev_unlock_and_resume(mddev);
 
 	return err;
-- 
2.39.2

