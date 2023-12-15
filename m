Return-Path: <linux-kernel+bounces-372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A24A8814026
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 03:44:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C1BD2882F0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 02:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4FB711192;
	Fri, 15 Dec 2023 02:40:36 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FEF3FC11;
	Fri, 15 Dec 2023 02:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Srtk46TN9z4f3jqV;
	Fri, 15 Dec 2023 10:40:28 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 2EC4E1A0188;
	Fri, 15 Dec 2023 10:40:30 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgDn6hCbvHtlSqe4Dg--.24310S5;
	Fri, 15 Dec 2023 10:40:30 +0800 (CST)
From: linan666@huaweicloud.com
To: song@kernel.org
Cc: linux-raid@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linan666@huaweicloud.com,
	yukuai3@huawei.com,
	yi.zhang@huawei.com,
	houtao1@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH v2 1/2] md: factor out a helper exceed_read_errors() to check read_errors
Date: Fri, 15 Dec 2023 10:38:51 +0800
Message-Id: <20231215023852.3478228-2-linan666@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231215023852.3478228-1-linan666@huaweicloud.com>
References: <20231215023852.3478228-1-linan666@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgDn6hCbvHtlSqe4Dg--.24310S5
X-Coremail-Antispam: 1UD129KBjvJXoWxuw1xWFWftFykZr4rZr43ZFb_yoW7try7pa
	n8AasxJr4UJrW3AwnrJFyqya4Fv34SkayjyryxJa1xuwn3Jrn8tFy5WFy09ry8GF98Aw15
	XFZ8Grs8CF4UtFUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPv14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
	x26xkF7I0E14v26r1I6r4UM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAa
	c4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzV
	Aqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S
	6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxw
	AKzVCY07xG64k0F24l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2Iq
	xVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r
	1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY
	6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67
	AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuY
	vjfUeYL9UUUUU
X-CM-SenderInfo: polqt0awwwqx5xdzvxpfor3voofrz/

From: Li Nan <linan122@huawei.com>

Move check_decay_read_errors() to raid1-10.c and factor out a helper
exceed_read_errors() to check if read_errors exceeds the limit, so that
raid1 can also use it. There are no functional changes.

Signed-off-by: Li Nan <linan122@huawei.com>
---
 drivers/md/raid1-10.c | 54 +++++++++++++++++++++++++++++++++++++++++++
 drivers/md/raid1.c    |  1 +
 drivers/md/raid10.c   | 49 +++------------------------------------
 3 files changed, 58 insertions(+), 46 deletions(-)

diff --git a/drivers/md/raid1-10.c b/drivers/md/raid1-10.c
index 3f22edec70e7..512746551f36 100644
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
+		pr_notice("md/"RAID_1_10_NAME":%s: %pg: Raid device exceeded read_error threshold [cur %d:max %d]\n",
+			  mdname(mddev), rdev->bdev, read_errors, max_read_errors);
+		pr_notice("md/"RAID_1_10_NAME":%s: %pg: Failing raid device\n",
+			  mdname(mddev), rdev->bdev);
+		md_error(mddev, rdev);
+		return true;
+	}
+
+	return false;
+}
diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index 35d12948e0a9..156b81de49fc 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -49,6 +49,7 @@ static void lower_barrier(struct r1conf *conf, sector_t sector_nr);
 #define raid1_log(md, fmt, args...)				\
 	do { if ((md)->queue) blk_add_trace_msg((md)->queue, "raid1 " fmt, ##args); } while (0)
 
+#define RAID_1_10_NAME "raid1"
 #include "raid1-10.c"
 
 #define START(node) ((node)->start)
diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index a5927e98dc67..35fc63cd7e46 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -19,6 +19,8 @@
 #include <linux/raid/md_p.h>
 #include <trace/events/block.h>
 #include "md.h"
+
+#define RAID_1_10_NAME "raid10"
 #include "raid10.h"
 #include "raid0.h"
 #include "md-bitmap.h"
@@ -2655,42 +2657,6 @@ static void recovery_request_write(struct mddev *mddev, struct r10bio *r10_bio)
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
@@ -2728,7 +2694,6 @@ static void fix_read_error(struct r10conf *conf, struct mddev *mddev, struct r10
 	int sect = 0; /* Offset from r10_bio->sector */
 	int sectors = r10_bio->sectors, slot = r10_bio->read_slot;
 	struct md_rdev *rdev;
-	int max_read_errors = atomic_read(&mddev->max_corr_read_errors);
 	int d = r10_bio->devs[slot].devnum;
 
 	/* still own a reference to this rdev, so it cannot
@@ -2741,15 +2706,7 @@ static void fix_read_error(struct r10conf *conf, struct mddev *mddev, struct r10
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


