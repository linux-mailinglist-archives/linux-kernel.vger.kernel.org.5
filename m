Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D058B78A46E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 04:06:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbjH1CFf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 22:05:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbjH1CE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 22:04:58 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27503D8;
        Sun, 27 Aug 2023 19:04:56 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RYv5J2Y5Bz4f3nKN;
        Mon, 28 Aug 2023 10:04:52 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgAnBai7AOxk9qcCBw--.25880S23;
        Mon, 28 Aug 2023 10:04:53 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     agk@redhat.com, snitzer@kernel.org, dm-devel@redhat.com,
        song@kernel.org, xni@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com,
        yangerkun@huawei.com
Subject: [PATCH -next v2 19/28] md: use new apis to suspend array for ioctls involed array reconfiguration
Date:   Mon, 28 Aug 2023 10:00:12 +0800
Message-Id: <20230828020021.2489641-20-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230828020021.2489641-1-yukuai1@huaweicloud.com>
References: <20230828020021.2489641-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAnBai7AOxk9qcCBw--.25880S23
X-Coremail-Antispam: 1UD129KBjvJXoWxGF13Cw43KryDXr1rJFWkZwb_yoW5CF4Dpr
        WxtanYkr45tFy3WrWUJa4v9a4Fqwn7KrZFyrWxu343GF1fJrnxuF1rWF1rXr1093s3JFn8
        Jw4Yka48Ca1UWFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUPI14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
        kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
        z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
        4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
        3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
        IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
        M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
        kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
        14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIx
        kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAF
        wI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr
        0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUQ
        SdkUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.3 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
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
 drivers/md/md.c | 29 ++++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 3343767882bb..81c7b9d1cc36 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -7179,7 +7179,6 @@ static int set_bitmap_file(struct mddev *mddev, int fd)
 			struct bitmap *bitmap;
 
 			bitmap = md_bitmap_create(mddev, -1);
-			mddev_suspend(mddev);
 			if (!IS_ERR(bitmap)) {
 				mddev->bitmap = bitmap;
 				err = md_bitmap_load(mddev);
@@ -7189,11 +7188,8 @@ static int set_bitmap_file(struct mddev *mddev, int fd)
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
@@ -7482,7 +7478,6 @@ static int update_array_info(struct mddev *mddev, mdu_array_info_t *info)
 			mddev->bitmap_info.space =
 				mddev->bitmap_info.default_space;
 			bitmap = md_bitmap_create(mddev, -1);
-			mddev_suspend(mddev);
 			if (!IS_ERR(bitmap)) {
 				mddev->bitmap = bitmap;
 				rv = md_bitmap_load(mddev);
@@ -7490,7 +7485,6 @@ static int update_array_info(struct mddev *mddev, mdu_array_info_t *info)
 				rv = PTR_ERR(bitmap);
 			if (rv)
 				md_bitmap_destroy(mddev);
-			mddev_resume(mddev);
 		} else {
 			/* remove the bitmap */
 			if (!mddev->bitmap) {
@@ -7515,9 +7509,7 @@ static int update_array_info(struct mddev *mddev, mdu_array_info_t *info)
 				module_put(md_cluster_mod);
 				mddev->safemode_delay = DEFAULT_SAFEMODE_DELAY;
 			}
-			mddev_suspend(mddev);
 			md_bitmap_destroy(mddev);
-			mddev_resume(mddev);
 			mddev->bitmap_info.offset = 0;
 		}
 	}
@@ -7588,6 +7580,20 @@ static inline bool md_ioctl_valid(unsigned int cmd)
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
@@ -7720,7 +7726,8 @@ static int md_ioctl(struct block_device *bdev, blk_mode_t mode,
 	if (!md_is_rdwr(mddev))
 		flush_work(&mddev->sync_work);
 
-	err = mddev_lock(mddev);
+	err = md_ioctl_need_suspend(cmd) ? mddev_suspend_and_lock(mddev) :
+					   mddev_lock(mddev);
 	if (err) {
 		pr_debug("md: ioctl lock interrupted, reason %d, cmd %d\n",
 			 err, cmd);
@@ -7848,7 +7855,11 @@ static int md_ioctl(struct block_device *bdev, blk_mode_t mode,
 	if (mddev->hold_active == UNTIL_IOCTL &&
 	    err != -EINVAL)
 		mddev->hold_active = 0;
+
 	mddev_unlock(mddev);
+	if (md_ioctl_need_suspend(cmd))
+		__mddev_resume(mddev);
+
 out:
 	if(did_set_md_closing)
 		clear_bit(MD_CLOSING, &mddev->flags);
-- 
2.39.2

