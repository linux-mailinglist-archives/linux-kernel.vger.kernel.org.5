Return-Path: <linux-kernel+bounces-7921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 489AE81AF35
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 08:13:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6CDD1F23688
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 07:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09FCA1429F;
	Thu, 21 Dec 2023 07:13:14 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C59D2FF;
	Thu, 21 Dec 2023 07:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4SwhTp3YVcz4f3l1R;
	Thu, 21 Dec 2023 15:13:02 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id B3AF31A49B8;
	Thu, 21 Dec 2023 15:13:07 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgCn9QuB5YNlzFboEA--.31997S5;
	Thu, 21 Dec 2023 15:13:07 +0800 (CST)
From: linan666@huaweicloud.com
To: song@kernel.org,
	yukuai3@huawei.com
Cc: linux-raid@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linan666@huaweicloud.com,
	yi.zhang@huawei.com,
	houtao1@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH 1/2] md: fix WARN_ON if create symlink fail in bind_rdev_to_array()
Date: Thu, 21 Dec 2023 15:11:08 +0800
Message-Id: <20231221071109.1562530-2-linan666@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231221071109.1562530-1-linan666@huaweicloud.com>
References: <20231221071109.1562530-1-linan666@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgCn9QuB5YNlzFboEA--.31997S5
X-Coremail-Antispam: 1UD129KBjvJXoW7WFyfKw1xJFWruFy5uFyfWFg_yoW8ZFWUp3
	yfWFy3Gr45Aw13ur4UJ34UGFyYq3W8KFW8try7u3ya9a45Jrn0kw1kWFy7XFyDWF9xZF47
	X3WUJw4Du3W09r7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPv14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
	x26xkF7I0E14v26r1I6r4UM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
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

Removing a device can trigger WARN_ON in bd_unlink_disk_holder() if creating
symlink failed while adding device.

  WARNING: CPU: 0 PID: 742 at block/holder.c:145 bd_unlink_disk_holder+0x17b/0x1a0

Fix it by adding the flag 'SymlinkCreated', which only be set after
creating symlink success.

Signed-off-by: Li Nan <linan122@huawei.com>
---
 drivers/md/md.h | 3 +++
 drivers/md/md.c | 8 ++++++--
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/md/md.h b/drivers/md/md.h
index 8d881cc59799..427d17713a8c 100644
--- a/drivers/md/md.h
+++ b/drivers/md/md.h
@@ -207,6 +207,9 @@ enum flag_bits {
 				 * check if there is collision between raid1
 				 * serial bios.
 				 */
+	SymlinkCreated,		/* This device has created the symlink
+				 * with gendisk.
+				 */
 };
 
 static inline int is_badblock(struct md_rdev *rdev, sector_t s, int sectors,
diff --git a/drivers/md/md.c b/drivers/md/md.c
index e05858653a41..d6612b922c76 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -2526,7 +2526,8 @@ static int bind_rdev_to_array(struct md_rdev *rdev, struct mddev *mddev)
 		sysfs_get_dirent_safe(rdev->kobj.sd, "bad_blocks");
 
 	list_add_rcu(&rdev->same_set, &mddev->disks);
-	bd_link_disk_holder(rdev->bdev, mddev->gendisk);
+	if (!bd_link_disk_holder(rdev->bdev, mddev->gendisk))
+		set_bit(SymlinkCreated, &rdev->flags);
 
 	/* May as well allow recovery to be retried once */
 	mddev->recovery_disabled++;
@@ -2561,7 +2562,10 @@ static void md_kick_rdev_from_array(struct md_rdev *rdev)
 {
 	struct mddev *mddev = rdev->mddev;
 
-	bd_unlink_disk_holder(rdev->bdev, rdev->mddev->gendisk);
+	if (test_bit(SymlinkCreated, &rdev->flags)) {
+		bd_unlink_disk_holder(rdev->bdev, rdev->mddev->gendisk);
+		clear_bit(SymlinkCreated, &rdev->flags);
+	}
 	list_del_rcu(&rdev->same_set);
 	pr_debug("md: unbind<%pg>\n", rdev->bdev);
 	mddev_destroy_serial_pool(rdev->mddev, rdev);
-- 
2.39.2


