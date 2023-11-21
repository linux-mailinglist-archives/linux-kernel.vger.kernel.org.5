Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 668F47F24AC
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 04:36:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233341AbjKUDZl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 22:25:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbjKUDZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 22:25:36 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FB40D9;
        Mon, 20 Nov 2023 19:25:31 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.163.216])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4SZ8s04Trmz4f3m7b;
        Tue, 21 Nov 2023 11:25:24 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
        by mail.maildlp.com (Postfix) with ESMTP id D0E441A07AC;
        Tue, 21 Nov 2023 11:25:28 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP1 (Coremail) with SMTP id cCh0CgDX2xEmI1xlv3EABg--.26174S5;
        Tue, 21 Nov 2023 11:25:28 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     ming.lei@redhat.com, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com,
        yangerkun@huawei.com
Subject: [PATCH v2 1/2] block: introduce new field flags in block_device
Date:   Tue, 21 Nov 2023 19:19:26 +0800
Message-Id: <20231121111927.2021846-2-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231121111927.2021846-1-yukuai1@huaweicloud.com>
References: <20231121111927.2021846-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgDX2xEmI1xlv3EABg--.26174S5
X-Coremail-Antispam: 1UD129KBjvJXoW3GryDCFy5trW8Gw18try7Jrb_yoW3uw1fpF
        Z8JFy5K3yUWr4fWan7Ga17JF1Sgw10kw1xA3y3C34akrW3trn2vF1kJryjy39a9rWxCFW7
        XFn8CFW5CFy7ua7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBE14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK62vIxIIY0VWUZVW8XwA2048vs2IY02
        0E87I2jVAFwI0_Jr4l82xGYIkIc2x26xkF7I0E14v26r1I6r4UM28lY4IEw2IIxxk0rwA2
        F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjx
        v20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2
        z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0V
        AKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1l
        Ox8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErc
        IFxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v2
        6r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2
        Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_
        Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMI
        IF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0pRxhLUUUUUU
        =
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

There are multiple switches in struct block_device, use separate bool
fields for them is not gracefully. Add a new field flags and replace
swithes to a bit, there are no functional changes, and preare to add
a new switch in the next patch.

In order to keep flags in the first cacheline, define it as u32 and add
new helpers to set/clear/test each bit like 'bio->bi_flags'.

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
index fc8d28d77495..6b420cbd4f3d 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -408,10 +408,10 @@ struct block_device *bdev_alloc(struct gendisk *disk, u8 partno)
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
@@ -612,7 +612,7 @@ static void bd_end_claim(struct block_device *bdev, void *holder)
 		bdev->bd_holder = NULL;
 		bdev->bd_holder_ops = NULL;
 		mutex_unlock(&bdev->bd_holder_lock);
-		if (bdev->bd_write_holder)
+		if (bdev_flagged(bdev, BD_FLAG_WRITE_HOLDER))
 			unblock = true;
 	}
 	if (!whole->bd_holders)
@@ -625,7 +625,7 @@ static void bd_end_claim(struct block_device *bdev, void *holder)
 	 */
 	if (unblock) {
 		disk_unblock_events(bdev->bd_disk);
-		bdev->bd_write_holder = false;
+		bdev_clear_flag(bdev, BD_FLAG_WRITE_HOLDER);
 	}
 }
 
@@ -878,9 +878,10 @@ struct bdev_handle *bdev_open_by_dev(dev_t dev, blk_mode_t mode, void *holder,
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
index 52e264d5a830..f7a7965eeb25 100644
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
+	unsigned int		bd_flags;
 	u8			bd_partno;
-	bool			bd_write_holder;
-	bool			bd_has_submit_bio;
 	dev_t			bd_dev;
 	atomic_t		bd_openers;
 	spinlock_t		bd_size_lock; /* for bd_inode->i_size updates */
@@ -63,9 +66,6 @@ struct block_device {
 	struct mutex		bd_fsfreeze_mutex; /* serialize freeze/thaw */
 
 	struct partition_meta_info *bd_meta_info;
-#ifdef CONFIG_FAIL_MAKE_REQUEST
-	bool			bd_make_it_fail;
-#endif
 	int			bd_writers;
 	/*
 	 * keep this out-of-line as it's both big and not needed in the fast
@@ -83,6 +83,21 @@ struct block_device {
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
index 9f6c3373f9fc..be1a39c0f8db 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -743,13 +743,14 @@ void disk_uevent(struct gendisk *disk, enum kobject_action action);
 
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

