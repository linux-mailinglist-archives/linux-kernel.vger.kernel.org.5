Return-Path: <linux-kernel+bounces-10271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7472681D1F4
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 04:39:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 134011F2428E
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 03:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32DBF63DF;
	Sat, 23 Dec 2023 03:39:16 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC0210F4;
	Sat, 23 Dec 2023 03:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Sxqf32qmVz4f3jJF;
	Sat, 23 Dec 2023 11:39:07 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id CB3131A08E7;
	Sat, 23 Dec 2023 11:39:08 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgD3Rg1aVoZl1dePEQ--.1070S5;
	Sat, 23 Dec 2023 11:39:08 +0800 (CST)
From: linan666@huaweicloud.com
To: song@kernel.org,
	axboe@kernel.dk
Cc: linux-raid@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linan666@huaweicloud.com,
	yukuai3@huawei.com,
	yi.zhang@huawei.com,
	houtao1@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH v3 1/2] md: Fix overflow in is_mddev_idle
Date: Sat, 23 Dec 2023 11:37:02 +0800
Message-Id: <20231223033703.2949831-2-linan666@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231223033703.2949831-1-linan666@huaweicloud.com>
References: <20231223033703.2949831-1-linan666@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgD3Rg1aVoZl1dePEQ--.1070S5
X-Coremail-Antispam: 1UD129KBjvJXoWxXF45Zw1xGw1fur1kXw43ZFb_yoW5Ar43pF
	WUJFyakrWUJr4j9w4DZ3yDua4rK34ay3y3KrW7C34aqFySg3ZIqF48GFyYqF1DZFW8ZFW2
	q34UKFZ0va40qrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmK14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
	x26xkF7I0E14v26r1I6r4UM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAa
	c4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzV
	Aqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S
	6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxw
	ACI402YVCY1x02628vn2kIc2xKxwAKzVCY07xG64k0F24l42xK82IYc2Ij64vIr41l4I8I
	3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxV
	WUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAF
	wI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcI
	k0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j
	6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUeYL9UUUUU
X-CM-SenderInfo: polqt0awwwqx5xdzvxpfor3voofrz/

From: Li Nan <linan122@huawei.com>

UBSAN reports this problem:

  UBSAN: Undefined behaviour in drivers/md/md.c:8175:15
  signed integer overflow:
  -2147483291 - 2072033152 cannot be represented in type 'int'
  Call trace:
   dump_backtrace+0x0/0x310
   show_stack+0x28/0x38
   dump_stack+0xec/0x15c
   ubsan_epilogue+0x18/0x84
   handle_overflow+0x14c/0x19c
   __ubsan_handle_sub_overflow+0x34/0x44
   is_mddev_idle+0x338/0x3d8
   md_do_sync+0x1bb8/0x1cf8
   md_thread+0x220/0x288
   kthread+0x1d8/0x1e0
   ret_from_fork+0x10/0x18

'curr_events' will overflow when stat accum or 'sync_io' is greater than
INT_MAX.

Fix it by changing sync_io, last_events and curr_events to 64bit.

Signed-off-by: Li Nan <linan122@huawei.com>
---
 drivers/md/md.h        | 4 ++--
 include/linux/blkdev.h | 2 +-
 drivers/md/md.c        | 7 ++++---
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/md/md.h b/drivers/md/md.h
index ade83af123a2..1a4f976951c1 100644
--- a/drivers/md/md.h
+++ b/drivers/md/md.h
@@ -50,7 +50,7 @@ struct md_rdev {
 
 	sector_t sectors;		/* Device size (in 512bytes sectors) */
 	struct mddev *mddev;		/* RAID array if running */
-	int last_events;		/* IO event timestamp */
+	long long last_events;		/* IO event timestamp */
 
 	/*
 	 * If meta_bdev is non-NULL, it means that a separate device is
@@ -584,7 +584,7 @@ extern void mddev_unlock(struct mddev *mddev);
 
 static inline void md_sync_acct(struct block_device *bdev, unsigned long nr_sectors)
 {
-	atomic_add(nr_sectors, &bdev->bd_disk->sync_io);
+	atomic64_add(nr_sectors, &bdev->bd_disk->sync_io);
 }
 
 static inline void md_sync_acct_bio(struct bio *bio, unsigned long nr_sectors)
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 3f8a21cd9233..d28b98adf457 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -170,7 +170,7 @@ struct gendisk {
 	struct list_head slave_bdevs;
 #endif
 	struct timer_rand_state *random;
-	atomic_t sync_io;		/* RAID */
+	atomic64_t sync_io;		/* RAID */
 	struct disk_events *ev;
 
 #ifdef CONFIG_BLK_DEV_ZONED
diff --git a/drivers/md/md.c b/drivers/md/md.c
index c94373d64f2c..a6829ea5b560 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -8496,14 +8496,15 @@ static int is_mddev_idle(struct mddev *mddev, int init)
 {
 	struct md_rdev *rdev;
 	int idle;
-	int curr_events;
+	long long curr_events;
 
 	idle = 1;
 	rcu_read_lock();
 	rdev_for_each_rcu(rdev, mddev) {
 		struct gendisk *disk = rdev->bdev->bd_disk;
-		curr_events = (int)part_stat_read_accum(disk->part0, sectors) -
-			      atomic_read(&disk->sync_io);
+		curr_events =
+			(long long)part_stat_read_accum(disk->part0, sectors) -
+			atomic64_read(&disk->sync_io);
 		/* sync IO will cause sync_io to increase before the disk_stats
 		 * as sync_io is counted when a request starts, and
 		 * disk_stats is counted when it completes.
-- 
2.39.2


