Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B3927F891D
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 09:16:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231808AbjKYIQj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 03:16:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231752AbjKYIQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 03:16:31 -0500
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0AE11B2;
        Sat, 25 Nov 2023 00:16:37 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.93.142])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Scl743PtPz4f3jZH;
        Sat, 25 Nov 2023 16:16:32 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
        by mail.maildlp.com (Postfix) with ESMTP id 3FA661A0424;
        Sat, 25 Nov 2023 16:16:35 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP1 (Coremail) with SMTP id cCh0CgCnqxFfrWFlP8KIBw--.32848S9;
        Sat, 25 Nov 2023 16:16:35 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     song@kernel.org
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com,
        yangerkun@huawei.com
Subject: [PATCH -next v3 5/5] md/md-multipath: remove rcu protection to access rdev from conf
Date:   Sat, 25 Nov 2023 16:16:04 +0800
Message-Id: <20231125081604.3939938-6-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231125081604.3939938-1-yukuai1@huaweicloud.com>
References: <20231125081604.3939938-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgCnqxFfrWFlP8KIBw--.32848S9
X-Coremail-Antispam: 1UD129KBjvJXoWxXw1kJF4UCw1UKw1DJrykAFb_yoW5Zr4xpa
        yaqasxtr48XFy3trnFya1Uua4Skw43tayIkryfG3yIvan8Gr95XF4Fqry5JF95AF95AF45
        ZFn8K3yDAFyxGaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9C14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
        kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
        z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
        4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
        3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
        IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
        M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF04k20xvY0x0EwIxGrw
        CFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE
        14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2
        IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxK
        x2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI
        0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUQSdkUUUUU=
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

Because it's safe to accees rdev from conf:
 - If any spinlock is held, because synchronize_rcu() from
   md_kick_rdev_from_array() will prevent 'rdev' to be freed until
   spinlock is released;
 - If there is normal IO inflight, because mddev_suspend() will prevent
   rdev to be added or removed from array;

And these will cover all the scenarios in md-multipath.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/md-multipath.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/md/md-multipath.c b/drivers/md/md-multipath.c
index aa77133f3188..19c8625ea642 100644
--- a/drivers/md/md-multipath.c
+++ b/drivers/md/md-multipath.c
@@ -32,17 +32,15 @@ static int multipath_map (struct mpconf *conf)
 	 * now we use the first available disk.
 	 */
 
-	rcu_read_lock();
 	for (i = 0; i < disks; i++) {
-		struct md_rdev *rdev = rcu_dereference(conf->multipaths[i].rdev);
+		struct md_rdev *rdev = conf->multipaths[i].rdev;
+
 		if (rdev && test_bit(In_sync, &rdev->flags) &&
 		    !test_bit(Faulty, &rdev->flags)) {
 			atomic_inc(&rdev->nr_pending);
-			rcu_read_unlock();
 			return i;
 		}
 	}
-	rcu_read_unlock();
 
 	pr_crit_ratelimited("multipath_map(): no more operational IO paths?\n");
 	return (-1);
@@ -137,14 +135,16 @@ static void multipath_status(struct seq_file *seq, struct mddev *mddev)
 	struct mpconf *conf = mddev->private;
 	int i;
 
+	lockdep_assert_held(&mddev->lock);
+
 	seq_printf (seq, " [%d/%d] [", conf->raid_disks,
 		    conf->raid_disks - mddev->degraded);
-	rcu_read_lock();
 	for (i = 0; i < conf->raid_disks; i++) {
-		struct md_rdev *rdev = rcu_dereference(conf->multipaths[i].rdev);
-		seq_printf (seq, "%s", rdev && test_bit(In_sync, &rdev->flags) ? "U" : "_");
+		struct md_rdev *rdev = READ_ONCE(conf->multipaths[i].rdev);
+
+		seq_printf(seq, "%s",
+			   rdev && test_bit(In_sync, &rdev->flags) ? "U" : "_");
 	}
-	rcu_read_unlock();
 	seq_putc(seq, ']');
 }
 
@@ -182,7 +182,7 @@ static void multipath_error (struct mddev *mddev, struct md_rdev *rdev)
 	       conf->raid_disks - mddev->degraded);
 }
 
-static void print_multipath_conf (struct mpconf *conf)
+static void print_multipath_conf(struct mpconf *conf)
 {
 	int i;
 	struct multipath_info *tmp;
@@ -195,6 +195,7 @@ static void print_multipath_conf (struct mpconf *conf)
 	pr_debug(" --- wd:%d rd:%d\n", conf->raid_disks - conf->mddev->degraded,
 		 conf->raid_disks);
 
+	lockdep_assert_held(&conf->mddev->reconfig_mutex);
 	for (i = 0; i < conf->raid_disks; i++) {
 		tmp = conf->multipaths + i;
 		if (tmp->rdev)
@@ -231,7 +232,7 @@ static int multipath_add_disk(struct mddev *mddev, struct md_rdev *rdev)
 			rdev->raid_disk = path;
 			set_bit(In_sync, &rdev->flags);
 			spin_unlock_irq(&conf->device_lock);
-			rcu_assign_pointer(p->rdev, rdev);
+			WRITE_ONCE(p->rdev, rdev);
 			err = 0;
 			break;
 		}
@@ -257,7 +258,7 @@ static int multipath_remove_disk(struct mddev *mddev, struct md_rdev *rdev)
 			err = -EBUSY;
 			goto abort;
 		}
-		p->rdev = NULL;
+		WRITE_ONCE(p->rdev, NULL);
 		err = md_integrity_register(mddev);
 	}
 abort:
-- 
2.39.2

