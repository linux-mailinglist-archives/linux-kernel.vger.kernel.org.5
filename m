Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00318802BD6
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 08:04:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234595AbjLDHE3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 02:04:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234535AbjLDHEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 02:04:25 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F13DB3;
        Sun,  3 Dec 2023 23:04:31 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.163.216])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4SkF5g2Pncz4f3lfx;
        Mon,  4 Dec 2023 15:04:23 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
        by mail.maildlp.com (Postfix) with ESMTP id 00F341A0E29;
        Mon,  4 Dec 2023 15:04:27 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP1 (Coremail) with SMTP id cCh0CgDX2hD5eW1lTQvKCg--.62157S5;
        Mon, 04 Dec 2023 15:04:27 +0800 (CST)
From:   linan666@huaweicloud.com
To:     song@kernel.org
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        linan122@huawei.com, yukuai3@huawei.com, yi.zhang@huawei.com,
        houtao1@huawei.com, yangerkun@huawei.com
Subject: [PATCH 1/2] md: factor out a helper exceed_read_errors() to check read_errors
Date:   Mon,  4 Dec 2023 15:03:26 +0800
Message-Id: <20231204070327.3150356-2-linan666@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231204070327.3150356-1-linan666@huaweicloud.com>
References: <20231204070327.3150356-1-linan666@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgDX2hD5eW1lTQvKCg--.62157S5
X-Coremail-Antispam: 1UD129KBjvJXoW3AFW8tryxKw4xXw4DArWkZwb_yoW7Gw4fpa
        13AasxJr4UJry7ArnrJFWqya4Fv34SyayjyrWxJa1xWwn5Jrn8tFy5WFy0g348GF9xAw15
        XFZ8Grs8CF4kKFUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBlb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
        A2048vs2IY020Ec7CjxVAFwI0_JFI_Gr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
        6rxl6s0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrV
        ACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWU
        JVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lw4CEc2x0rVAKj4xxMx
        AIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_
        Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwI
        xGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWx
        JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcV
        C2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU858n5UUUUU==
X-CM-SenderInfo: polqt0awwwqx5xdzvxpfor3voofrz/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Li Nan <linan122@huawei.com>

Move check_decay_read_errors() to raid1-10.c and factor out a helper
exceed_read_errors() to check if read_errors exceeds the limit, so that
raid1 can also use it. There are no functional changes.

Signed-off-by: Li Nan <linan122@huawei.com>
---
 drivers/md/raid1-10.c | 54 +++++++++++++++++++++++++++++++++++++++++++
 drivers/md/raid10.c   | 47 +------------------------------------
 2 files changed, 55 insertions(+), 46 deletions(-)

diff --git a/drivers/md/raid1-10.c b/drivers/md/raid1-10.c
index 3f22edec70e7..9e17eab915f5 100644
--- a/drivers/md/raid1-10.c
+++ b/drivers/md/raid1-10.c
@@ -173,3 +173,57 @@ static inline void raid1_prepare_flush_writes(struct bitmap *bitmap)
 	else
 		md_bitmap_unplug(bitmap);
 }
+
+/*
+ * Used by fix_read_error() to decay the per rdev read_errors.
+ * We halve the read error count for every hour that has elapsed
+ * since the last recorded read error.
+ */
+static inline void check_decay_read_errors(struct mddev *mddev, struct md_rdev *rdev)
+{
+	long cur_time_mon;
+	unsigned long hours_since_last;
+	unsigned int read_errors = atomic_read(&rdev->read_errors);
+
+	cur_time_mon = ktime_get_seconds();
+
+	if (rdev->last_read_error == 0) {
+		/* first time we've seen a read error */
+		rdev->last_read_error = cur_time_mon;
+		return;
+	}
+
+	hours_since_last = (long)(cur_time_mon -
+			    rdev->last_read_error) / 3600;
+
+	rdev->last_read_error = cur_time_mon;
+
+	/*
+	 * if hours_since_last is > the number of bits in read_errors
+	 * just set read errors to 0. We do this to avoid
+	 * overflowing the shift of read_errors by hours_since_last.
+	 */
+	if (hours_since_last >= 8 * sizeof(read_errors))
+		atomic_set(&rdev->read_errors, 0);
+	else
+		atomic_set(&rdev->read_errors, read_errors >> hours_since_last);
+}
+
+static inline bool exceed_read_errors(struct mddev *mddev, struct md_rdev *rdev)
+{
+	int max_read_errors = atomic_read(&mddev->max_corr_read_errors);
+	int read_errors;
+
+	check_decay_read_errors(mddev, rdev);
+	read_errors =  atomic_inc_return(&rdev->read_errors);
+	if (read_errors > max_read_errors) {
+		pr_notice("md:%s: %pg: Raid device exceeded read_error threshold [cur %d:max %d]\n",
+			  mdname(mddev), rdev->bdev, read_errors, max_read_errors);
+		pr_notice("md:%s: %pg: Failing raid device\n",
+			  mdname(mddev), rdev->bdev);
+		md_error(mddev, rdev);
+		return true;
+	}
+
+	return false;
+}
diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index 375c11d6159f..8ea4974fb91c 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -2592,42 +2592,6 @@ static void recovery_request_write(struct mddev *mddev, struct r10bio *r10_bio)
 	}
 }
 
-/*
- * Used by fix_read_error() to decay the per rdev read_errors.
- * We halve the read error count for every hour that has elapsed
- * since the last recorded read error.
- *
- */
-static void check_decay_read_errors(struct mddev *mddev, struct md_rdev *rdev)
-{
-	long cur_time_mon;
-	unsigned long hours_since_last;
-	unsigned int read_errors = atomic_read(&rdev->read_errors);
-
-	cur_time_mon = ktime_get_seconds();
-
-	if (rdev->last_read_error == 0) {
-		/* first time we've seen a read error */
-		rdev->last_read_error = cur_time_mon;
-		return;
-	}
-
-	hours_since_last = (long)(cur_time_mon -
-			    rdev->last_read_error) / 3600;
-
-	rdev->last_read_error = cur_time_mon;
-
-	/*
-	 * if hours_since_last is > the number of bits in read_errors
-	 * just set read errors to 0. We do this to avoid
-	 * overflowing the shift of read_errors by hours_since_last.
-	 */
-	if (hours_since_last >= 8 * sizeof(read_errors))
-		atomic_set(&rdev->read_errors, 0);
-	else
-		atomic_set(&rdev->read_errors, read_errors >> hours_since_last);
-}
-
 static int r10_sync_page_io(struct md_rdev *rdev, sector_t sector,
 			    int sectors, struct page *page, enum req_op op)
 {
@@ -2665,7 +2629,6 @@ static void fix_read_error(struct r10conf *conf, struct mddev *mddev, struct r10
 	int sect = 0; /* Offset from r10_bio->sector */
 	int sectors = r10_bio->sectors, slot = r10_bio->read_slot;
 	struct md_rdev *rdev;
-	int max_read_errors = atomic_read(&mddev->max_corr_read_errors);
 	int d = r10_bio->devs[slot].devnum;
 
 	/* still own a reference to this rdev, so it cannot
@@ -2678,15 +2641,7 @@ static void fix_read_error(struct r10conf *conf, struct mddev *mddev, struct r10
 		   more fix_read_error() attempts */
 		return;
 
-	check_decay_read_errors(mddev, rdev);
-	atomic_inc(&rdev->read_errors);
-	if (atomic_read(&rdev->read_errors) > max_read_errors) {
-		pr_notice("md/raid10:%s: %pg: Raid device exceeded read_error threshold [cur %d:max %d]\n",
-			  mdname(mddev), rdev->bdev,
-			  atomic_read(&rdev->read_errors), max_read_errors);
-		pr_notice("md/raid10:%s: %pg: Failing raid device\n",
-			  mdname(mddev), rdev->bdev);
-		md_error(mddev, rdev);
+	if (exceed_read_errors(mddev, rdev)) {
 		r10_bio->devs[slot].bio = IO_BLOCKED;
 		return;
 	}
-- 
2.39.2

