Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BC177BF445
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 09:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442541AbjJJHYc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 03:24:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442485AbjJJHXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 03:23:45 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3440A9;
        Tue, 10 Oct 2023 00:23:43 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4S4S7H5L7mz4f3kpc;
        Tue, 10 Oct 2023 15:23:39 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgDHXd31+yRl1AZbCg--.36859S16;
        Tue, 10 Oct 2023 15:23:41 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     song@kernel.org, xni@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com,
        yangerkun@huawei.com
Subject: [PATCH -next v4 12/19] md: use new apis to suspend array for ioctls involed array reconfiguration
Date:   Tue, 10 Oct 2023 23:19:51 +0800
Message-Id: <20231010151958.145896-13-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231010151958.145896-1-yukuai1@huaweicloud.com>
References: <20231010151958.145896-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgDHXd31+yRl1AZbCg--.36859S16
X-Coremail-Antispam: 1UD129KBjvJXoWxGF13Cw43KryDJw43GrWrGrg_yoW5Cw1fpr
        Wftan5Kr45tFy3WrWUJa4v9a4Fqwn7KrZFyryxW3s8G3WxArnxuF1ruF18Ar1093s7JFn8
        Jw4Yka48Ca17WFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUPI14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK62vIxIIY0VWUZVW8XwA2048vs2IY02
        0E87I2jVAFwI0_JF0E3s1l82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0
        rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6x
        IIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xv
        wVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFc
        xC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_
        Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2
        IErcIFxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
        14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIx
        kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAF
        wI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr
        0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0pRv
        JPtUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

'reconfig_mutex' will be grabbed before these ioctls, suspend array
before holding the lock, so that io won't concurrent with array
reconfiguration through ioctls.

This is not hot path, so performance is not concerned.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/md.c | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 56523bac5140..ee20e6a4b998 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -7215,7 +7215,6 @@ static int set_bitmap_file(struct mddev *mddev, int fd)
 			struct bitmap *bitmap;
 
 			bitmap = md_bitmap_create(mddev, -1);
-			mddev_suspend(mddev);
 			if (!IS_ERR(bitmap)) {
 				mddev->bitmap = bitmap;
 				err = md_bitmap_load(mddev);
@@ -7225,11 +7224,8 @@ static int set_bitmap_file(struct mddev *mddev, int fd)
 				md_bitmap_destroy(mddev);
 				fd = -1;
 			}
-			mddev_resume(mddev);
 		} else if (fd < 0) {
-			mddev_suspend(mddev);
 			md_bitmap_destroy(mddev);
-			mddev_resume(mddev);
 		}
 	}
 	if (fd < 0) {
@@ -7518,7 +7514,6 @@ static int update_array_info(struct mddev *mddev, mdu_array_info_t *info)
 			mddev->bitmap_info.space =
 				mddev->bitmap_info.default_space;
 			bitmap = md_bitmap_create(mddev, -1);
-			mddev_suspend(mddev);
 			if (!IS_ERR(bitmap)) {
 				mddev->bitmap = bitmap;
 				rv = md_bitmap_load(mddev);
@@ -7526,7 +7521,6 @@ static int update_array_info(struct mddev *mddev, mdu_array_info_t *info)
 				rv = PTR_ERR(bitmap);
 			if (rv)
 				md_bitmap_destroy(mddev);
-			mddev_resume(mddev);
 		} else {
 			/* remove the bitmap */
 			if (!mddev->bitmap) {
@@ -7551,9 +7545,7 @@ static int update_array_info(struct mddev *mddev, mdu_array_info_t *info)
 				module_put(md_cluster_mod);
 				mddev->safemode_delay = DEFAULT_SAFEMODE_DELAY;
 			}
-			mddev_suspend(mddev);
 			md_bitmap_destroy(mddev);
-			mddev_resume(mddev);
 			mddev->bitmap_info.offset = 0;
 		}
 	}
@@ -7624,6 +7616,20 @@ static inline bool md_ioctl_valid(unsigned int cmd)
 	}
 }
 
+static bool md_ioctl_need_suspend(unsigned int cmd)
+{
+	switch (cmd) {
+	case ADD_NEW_DISK:
+	case HOT_ADD_DISK:
+	case HOT_REMOVE_DISK:
+	case SET_BITMAP_FILE:
+	case SET_ARRAY_INFO:
+		return true;
+	default:
+		return false;
+	}
+}
+
 static int __md_set_array_info(struct mddev *mddev, void __user *argp)
 {
 	mdu_array_info_t info;
@@ -7756,7 +7762,8 @@ static int md_ioctl(struct block_device *bdev, blk_mode_t mode,
 	if (!md_is_rdwr(mddev))
 		flush_work(&mddev->sync_work);
 
-	err = mddev_lock(mddev);
+	err = md_ioctl_need_suspend(cmd) ? mddev_suspend_and_lock(mddev) :
+					   mddev_lock(mddev);
 	if (err) {
 		pr_debug("md: ioctl lock interrupted, reason %d, cmd %d\n",
 			 err, cmd);
@@ -7884,7 +7891,10 @@ static int md_ioctl(struct block_device *bdev, blk_mode_t mode,
 	if (mddev->hold_active == UNTIL_IOCTL &&
 	    err != -EINVAL)
 		mddev->hold_active = 0;
-	mddev_unlock(mddev);
+
+	md_ioctl_need_suspend(cmd) ? mddev_unlock_and_resume(mddev) :
+				     mddev_unlock(mddev);
+
 out:
 	if(did_set_md_closing)
 		clear_bit(MD_CLOSING, &mddev->flags);
-- 
2.39.2

