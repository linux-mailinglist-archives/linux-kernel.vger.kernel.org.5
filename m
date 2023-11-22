Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B90077F3BDB
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 03:37:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343547AbjKVChU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 21:37:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343530AbjKVChQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 21:37:16 -0500
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 290DB195;
        Tue, 21 Nov 2023 18:37:12 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.93.142])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4SZlkp5X9Dz4f3kk1;
        Wed, 22 Nov 2023 10:37:06 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
        by mail.maildlp.com (Postfix) with ESMTP id 74DB21A01AB;
        Wed, 22 Nov 2023 10:37:09 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP1 (Coremail) with SMTP id cCh0CgBXWhBSaV1lNClcBg--.32716S6;
        Wed, 22 Nov 2023 10:37:09 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     ming.lei@redhat.com, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com,
        yangerkun@huawei.com
Subject: [PATCH v3 2/3] block: introduce new field bd_flags in block_device
Date:   Wed, 22 Nov 2023 18:31:02 +0800
Message-Id: <20231122103103.1104589-3-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231122103103.1104589-1-yukuai1@huaweicloud.com>
References: <20231122103103.1104589-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgBXWhBSaV1lNClcBg--.32716S6
X-Coremail-Antispam: 1UD129KBjvJXoW3GrykGrW8KF1rAr4rArW5Wrg_yoW3uF4kpF
        Z8GFyYk3yUWr4fWan7Ka17J3WSgw10yw1xA3y3C34akrW3trn2vF1kJryjv39a9rW8CFW7
        XFn8CFW5CFyUua7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUPab4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
        8IrcIa0xkI8VA2jI8067AKxVWUXwA2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK
        0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4
        x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJr0_GcWl84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2
        z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4
        xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v2
        6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6I
        AqYI8I648v4I1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAq
        x4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r
        43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF
        7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxV
        WUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjTR
        QNVDUUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        KHOP_HELO_FCRDNS,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

There are multiple switches in struct block_device, use separate bool
fields for them is not gracefully. Add a new field bd_flags and replace
swithes to a bit, there are no functional changes, and prepare to add
a new switch in the next patch. In order to keep bd_flags in the first
cacheline and prevent layout to be affected, define it as u16.

Also add new helpers to set/clear/test each bit like 'bio->bi_flags'.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/bdev.c              | 15 ++++++++-------
 block/blk-core.c          |  7 ++++---
 block/genhd.c             | 15 +++++++++++----
 block/ioctl.c             |  6 +++++-
 include/linux/blk_types.h | 27 +++++++++++++++++++++------
 include/linux/blkdev.h    |  5 +++--
 6 files changed, 52 insertions(+), 23 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index e4cfb7adb645..10f524a7416c 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -402,10 +402,10 @@ struct block_device *bdev_alloc(struct gendisk *disk, u8 partno)
 	bdev->bd_partno = partno;
 	bdev->bd_inode = inode;
 	bdev->bd_queue = disk->queue;
-	if (partno)
-		bdev->bd_has_submit_bio = disk->part0->bd_has_submit_bio;
+	if (partno && bdev_flagged(disk->part0, BD_FLAG_HAS_SUBMIT_BIO))
+		bdev_set_flag(bdev, BD_FLAG_HAS_SUBMIT_BIO);
 	else
-		bdev->bd_has_submit_bio = false;
+		bdev_clear_flag(bdev, BD_FLAG_HAS_SUBMIT_BIO);
 	bdev->bd_stats = alloc_percpu(struct disk_stats);
 	if (!bdev->bd_stats) {
 		iput(inode);
@@ -606,7 +606,7 @@ static void bd_end_claim(struct block_device *bdev, void *holder)
 		bdev->bd_holder = NULL;
 		bdev->bd_holder_ops = NULL;
 		mutex_unlock(&bdev->bd_holder_lock);
-		if (bdev->bd_write_holder)
+		if (bdev_flagged(bdev, BD_FLAG_WRITE_HOLDER))
 			unblock = true;
 	}
 	if (!whole->bd_holders)
@@ -619,7 +619,7 @@ static void bd_end_claim(struct block_device *bdev, void *holder)
 	 */
 	if (unblock) {
 		disk_unblock_events(bdev->bd_disk);
-		bdev->bd_write_holder = false;
+		bdev_clear_flag(bdev, BD_FLAG_WRITE_HOLDER);
 	}
 }
 
@@ -805,9 +805,10 @@ struct block_device *blkdev_get_by_dev(dev_t dev, blk_mode_t mode, void *holder,
 		 * writeable reference is too fragile given the way @mode is
 		 * used in blkdev_get/put().
 		 */
-		if ((mode & BLK_OPEN_WRITE) && !bdev->bd_write_holder &&
+		if ((mode & BLK_OPEN_WRITE) &&
+		    !bdev_flagged(bdev, BD_FLAG_WRITE_HOLDER) &&
 		    (disk->event_flags & DISK_EVENT_FLAG_BLOCK_ON_EXCL_WRITE)) {
-			bdev->bd_write_holder = true;
+			bdev_set_flag(bdev, BD_FLAG_WRITE_HOLDER);
 			unblock_events = false;
 		}
 	}
diff --git a/block/blk-core.c b/block/blk-core.c
index fdf25b8d6e78..f9f8b12ba626 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -482,7 +482,8 @@ __setup("fail_make_request=", setup_fail_make_request);
 
 bool should_fail_request(struct block_device *part, unsigned int bytes)
 {
-	return part->bd_make_it_fail && should_fail(&fail_make_request, bytes);
+	return bdev_flagged(part, BD_FLAG_MAKE_IT_FAIL) &&
+		should_fail(&fail_make_request, bytes);
 }
 
 static int __init fail_make_request_debugfs(void)
@@ -595,7 +596,7 @@ static void __submit_bio(struct bio *bio)
 	if (unlikely(!blk_crypto_bio_prep(&bio)))
 		return;
 
-	if (!bio->bi_bdev->bd_has_submit_bio) {
+	if (!bdev_flagged(bio->bi_bdev, BD_FLAG_HAS_SUBMIT_BIO)) {
 		blk_mq_submit_bio(bio);
 	} else if (likely(bio_queue_enter(bio) == 0)) {
 		struct gendisk *disk = bio->bi_bdev->bd_disk;
@@ -703,7 +704,7 @@ void submit_bio_noacct_nocheck(struct bio *bio)
 	 */
 	if (current->bio_list)
 		bio_list_add(&current->bio_list[0], bio);
-	else if (!bio->bi_bdev->bd_has_submit_bio)
+	else if (!bdev_flagged(bio->bi_bdev, BD_FLAG_HAS_SUBMIT_BIO))
 		__submit_bio_noacct_mq(bio);
 	else
 		__submit_bio_noacct(bio);
diff --git a/block/genhd.c b/block/genhd.c
index c9d06f72c587..57f96c0c8da0 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -413,7 +413,8 @@ int __must_check device_add_disk(struct device *parent, struct gendisk *disk,
 	elevator_init_mq(disk->queue);
 
 	/* Mark bdev as having a submit_bio, if needed */
-	disk->part0->bd_has_submit_bio = disk->fops->submit_bio != NULL;
+	if (disk->fops->submit_bio)
+		bdev_set_flag(disk->part0, BD_FLAG_HAS_SUBMIT_BIO);
 
 	/*
 	 * If the driver provides an explicit major number it also must provide
@@ -1062,7 +1063,8 @@ static DEVICE_ATTR(diskseq, 0444, diskseq_show, NULL);
 ssize_t part_fail_show(struct device *dev,
 		       struct device_attribute *attr, char *buf)
 {
-	return sprintf(buf, "%d\n", dev_to_bdev(dev)->bd_make_it_fail);
+	return sprintf(buf, "%d\n",
+		       bdev_flagged(dev_to_bdev(dev), BD_FLAG_MAKE_IT_FAIL));
 }
 
 ssize_t part_fail_store(struct device *dev,
@@ -1071,8 +1073,13 @@ ssize_t part_fail_store(struct device *dev,
 {
 	int i;
 
-	if (count > 0 && sscanf(buf, "%d", &i) > 0)
-		dev_to_bdev(dev)->bd_make_it_fail = i;
+	if (count > 0 && sscanf(buf, "%d", &i) > 0) {
+		if (!i)
+			bdev_clear_flag(dev_to_bdev(dev), BD_FLAG_MAKE_IT_FAIL);
+		else
+			bdev_set_flag(dev_to_bdev(dev), BD_FLAG_MAKE_IT_FAIL);
+
+	}
 
 	return count;
 }
diff --git a/block/ioctl.c b/block/ioctl.c
index 4160f4e6bd5b..a64440f4c96b 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -394,7 +394,11 @@ static int blkdev_roset(struct block_device *bdev, unsigned cmd,
 		if (ret)
 			return ret;
 	}
-	bdev->bd_read_only = n;
+
+	if (!n)
+		bdev_clear_flag(bdev, BD_FLAG_READ_ONLY);
+	else
+		bdev_set_flag(bdev, BD_FLAG_READ_ONLY);
 	return 0;
 }
 
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index f7d40692dd94..de652045111b 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -37,6 +37,11 @@ struct bio_crypt_ctx;
 #define PAGE_SECTORS		(1 << PAGE_SECTORS_SHIFT)
 #define SECTOR_MASK		(PAGE_SECTORS - 1)
 
+#define BD_FLAG_READ_ONLY	0 /* read-only-policy */
+#define BD_FLAG_WRITE_HOLDER	1
+#define BD_FLAG_HAS_SUBMIT_BIO	2
+#define BD_FLAG_MAKE_IT_FAIL	3
+
 struct block_device {
 	sector_t		bd_start_sect;
 	sector_t		bd_nr_sectors;
@@ -44,10 +49,8 @@ struct block_device {
 	struct request_queue *	bd_queue;
 	struct disk_stats __percpu *bd_stats;
 	unsigned long		bd_stamp;
-	bool			bd_read_only;	/* read-only policy */
+	unsigned short		bd_flags;
 	u8			bd_partno;
-	bool			bd_write_holder;
-	bool			bd_has_submit_bio;
 	dev_t			bd_dev;
 	struct inode		*bd_inode;	/* will die */
 
@@ -67,9 +70,6 @@ struct block_device {
 	struct super_block	*bd_fsfreeze_sb;
 
 	struct partition_meta_info *bd_meta_info;
-#ifdef CONFIG_FAIL_MAKE_REQUEST
-	bool			bd_make_it_fail;
-#endif
 	/*
 	 * keep this out-of-line as it's both big and not needed in the fast
 	 * path
@@ -86,6 +86,21 @@ struct block_device {
 #define bdev_kobj(_bdev) \
 	(&((_bdev)->bd_device.kobj))
 
+static inline bool bdev_flagged(struct block_device *bdev, unsigned int bit)
+{
+	return bdev->bd_flags & (1U << bit);
+}
+
+static inline void bdev_set_flag(struct block_device *bdev, unsigned int bit)
+{
+	bdev->bd_flags |= (1U << bit);
+}
+
+static inline void bdev_clear_flag(struct block_device *bdev, unsigned int bit)
+{
+	bdev->bd_flags &= ~(1U << bit);
+}
+
 /*
  * Block error status values.  See block/blk-core:blk_errors for the details.
  * Alpha cannot write a byte atomically, so we need to use 32-bit value.
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 51fa7ffdee83..fc1d55ef5107 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -741,13 +741,14 @@ void disk_uevent(struct gendisk *disk, enum kobject_action action);
 
 static inline int get_disk_ro(struct gendisk *disk)
 {
-	return disk->part0->bd_read_only ||
+	return bdev_flagged(disk->part0, BD_FLAG_READ_ONLY) ||
 		test_bit(GD_READ_ONLY, &disk->state);
 }
 
 static inline int bdev_read_only(struct block_device *bdev)
 {
-	return bdev->bd_read_only || get_disk_ro(bdev->bd_disk);
+	return bdev_flagged(bdev, BD_FLAG_READ_ONLY) ||
+		get_disk_ro(bdev->bd_disk);
 }
 
 bool set_capacity_and_notify(struct gendisk *disk, sector_t size);
-- 
2.39.2

