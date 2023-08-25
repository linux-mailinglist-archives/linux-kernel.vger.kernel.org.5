Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58734787E2D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 05:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236213AbjHYDAB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 23:00:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239151AbjHYC7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 22:59:52 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC9851991;
        Thu, 24 Aug 2023 19:59:49 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4RX4Ry5Nzjz4f4XWf;
        Fri, 25 Aug 2023 10:59:42 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgAHl6kfGehkow4WBg--.35864S6;
        Fri, 25 Aug 2023 10:59:46 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     song@kernel.org, yukuai3@huawei.com
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai1@huaweicloud.com, yi.zhang@huawei.com, yangerkun@huawei.com
Subject: [PATCH -next 2/2] md: fix warning for holder mismatch from export_rdev()
Date:   Fri, 25 Aug 2023 10:55:32 +0800
Message-Id: <20230825025532.1523008-3-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230825025532.1523008-1-yukuai1@huaweicloud.com>
References: <20230825025532.1523008-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAHl6kfGehkow4WBg--.35864S6
X-Coremail-Antispam: 1UD129KBjvJXoWxCrWDAFW8Aw1xCrWUJryfCrg_yoWrAr4xpF
        4SyFWftr4fG3W7XanrXa18WFyYq3WayrWxAFyS93yfAa90vr1UKF18JFy5Zr95GFWrZFs5
        JF1UGayxZw1kuw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9v14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
        x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UM2
        8EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AI
        xVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20x
        vE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xv
        r2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxAIw28IcxkI7VAKI48JMxC20s
        026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_
        JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14
        v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xva
        j40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JV
        W8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUjYiiDUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

Commit a1d767191096 ("md: use mddev->external to select holder in
export_rdev()") fix the problem that 'claim_rdev' is used for
blkdev_get_by_dev() while 'rdev' is used for blkdev_put().

However, if mddev->external is changed from 0 to 1, then 'rdev' is used
for blkdev_get_by_dev() while 'claim_rdev' is used for blkdev_put(). And
this problem can be reporduced reliably by following:

New file: mdadm/tests/23rdev-lifetime

devname=${dev0##*/}
devt=`cat /sys/block/$devname/dev`
pid=""
runtime=2

clean_up_test() {
        pill -9 $pid
        echo clear > /sys/block/md0/md/array_state
}

trap 'clean_up_test' EXIT

add_by_sysfs() {
        while true; do
                echo $devt > /sys/block/md0/md/new_dev
        done
}

remove_by_sysfs(){
        while true; do
                echo remove > /sys/block/md0/md/dev-${devname}/state
        done
}

echo md0 > /sys/module/md_mod/parameters/new_array || die "create md0 failed"

add_by_sysfs &
pid="$pid $!"

remove_by_sysfs &
pid="$pid $!"

sleep $runtime
exit 0

Test cmd:

./test --save-logs --logdir=/tmp/ --keep-going --dev=loop --tests=23rdev-lifetime

Test result:

------------[ cut here ]------------
WARNING: CPU: 0 PID: 960 at block/bdev.c:618 blkdev_put+0x27c/0x330
Modules linked in: multipath md_mod loop
CPU: 0 PID: 960 Comm: test Not tainted 6.5.0-rc2-00121-g01e55c376936-dirty #50
RIP: 0010:blkdev_put+0x27c/0x330
Call Trace:
 <TASK>
 export_rdev.isra.23+0x50/0xa0 [md_mod]
 mddev_unlock+0x19d/0x300 [md_mod]
 rdev_attr_store+0xec/0x190 [md_mod]
 sysfs_kf_write+0x52/0x70
 kernfs_fop_write_iter+0x19a/0x2a0
 vfs_write+0x3b5/0x770
 ksys_write+0x74/0x150
 __x64_sys_write+0x22/0x30
 do_syscall_64+0x40/0x90
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Fix the problem by recording if 'rdev' is used as holder.

Fixes: a1d767191096 ("md: use mddev->external to select holder in export_rdev()")
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/md.c | 15 ++++++++++++---
 drivers/md/md.h |  3 +++
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 3bb0d9ce0d28..278a6e9aad93 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -2494,7 +2494,8 @@ static void export_rdev(struct md_rdev *rdev, struct mddev *mddev)
 	if (test_bit(AutoDetected, &rdev->flags))
 		md_autodetect_dev(rdev->bdev->bd_dev);
 #endif
-	blkdev_put(rdev->bdev, mddev->external ? &claim_rdev : rdev);
+	blkdev_put(rdev->bdev,
+		   test_bit(Holder, &rdev->flags) ? rdev : &claim_rdev);
 	rdev->bdev = NULL;
 	kobject_put(&rdev->kobj);
 }
@@ -3674,6 +3675,7 @@ EXPORT_SYMBOL_GPL(md_rdev_init);
 static struct md_rdev *md_import_device(dev_t newdev, int super_format, int super_minor)
 {
 	struct md_rdev *rdev;
+	struct md_rdev *holder;
 	sector_t size;
 	int err;
 
@@ -3688,8 +3690,15 @@ static struct md_rdev *md_import_device(dev_t newdev, int super_format, int supe
 	if (err)
 		goto out_clear_rdev;
 
+	if (super_format == -2) {
+		holder = &claim_rdev;
+	} else {
+		holder = rdev;
+		set_bit(Holder, &rdev->flags);
+	}
+
 	rdev->bdev = blkdev_get_by_dev(newdev, BLK_OPEN_READ | BLK_OPEN_WRITE,
-			super_format == -2 ? &claim_rdev : rdev, NULL);
+				       holder, NULL);
 	if (IS_ERR(rdev->bdev)) {
 		pr_warn("md: could not open device unknown-block(%u,%u).\n",
 			MAJOR(newdev), MINOR(newdev));
@@ -3726,7 +3735,7 @@ static struct md_rdev *md_import_device(dev_t newdev, int super_format, int supe
 	return rdev;
 
 out_blkdev_put:
-	blkdev_put(rdev->bdev, super_format == -2 ? &claim_rdev : rdev);
+	blkdev_put(rdev->bdev, holder);
 out_clear_rdev:
 	md_rdev_clear(rdev);
 out_free_rdev:
diff --git a/drivers/md/md.h b/drivers/md/md.h
index b365226a4183..b628c292506e 100644
--- a/drivers/md/md.h
+++ b/drivers/md/md.h
@@ -211,6 +211,9 @@ enum flag_bits {
 				 * check if there is collision between raid1
 				 * serial bios.
 				 */
+	Holder,			/* rdev is used as holder while opening
+				 * underlying disk exclusively.
+				 */
 };
 
 static inline int is_badblock(struct md_rdev *rdev, sector_t s, int sectors,
-- 
2.39.2

