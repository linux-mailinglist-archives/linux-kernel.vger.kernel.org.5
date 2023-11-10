Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 033EB7E7FCE
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 18:59:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234972AbjKJR7A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 12:59:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234606AbjKJRzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 12:55:38 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22226244BF;
        Fri, 10 Nov 2023 01:34:02 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.163.216])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4SRYYH31MLz4f4PNh;
        Fri, 10 Nov 2023 17:33:55 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
        by mail.maildlp.com (Postfix) with ESMTP id 4A8781A0181;
        Fri, 10 Nov 2023 17:33:59 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP1 (Coremail) with SMTP id cCh0CgA3iA4E+U1l0pQlAg--.33627S9;
        Fri, 10 Nov 2023 17:33:59 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     song@kernel.org, xni@redhat.com, yukuai3@huawei.com, neilb@suse.de
Cc:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        yukuai1@huaweicloud.com, yi.zhang@huawei.com, yangerkun@huawei.com
Subject: [PATCH -next 5/8] md: don't leave 'MD_RECOVERY_FROZEN' in error path of md_set_readonly()
Date:   Sat, 11 Nov 2023 01:28:31 +0800
Message-Id: <20231110172834.3939490-6-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231110172834.3939490-1-yukuai1@huaweicloud.com>
References: <20231110172834.3939490-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgA3iA4E+U1l0pQlAg--.33627S9
X-Coremail-Antispam: 1UD129KBjvJXoW7uFWkXryrtw18CrWfXryDtrb_yoW8Kr4fp3
        yftF98Cry8Jry3Ar4Dt3WDXa45Zw12q3yqkFy3u34rJF1ftrZxCFyF9348JrWktas2v345
        Xa1rGFW7u3W2gaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUPF14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK62vIxIIY0VWUZVW8XwA2048vs2IY02
        0E87I2jVAFwI0_JF0E3s1l82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0
        rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6x
        IIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xv
        wVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFc
        xC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_
        Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2
        IErcIFxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
        14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIx
        kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAF
        wI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
        W8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjTRi4SO
        UUUUU
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

If md_set_readonly() failed, the array could still be read-write, however
'MD_RECOVERY_FROZEN' could still be set, which leave the array in an
abnormal state that sync or recovery can't continue anymore.
Hence make sure the flag is cleared after md_set_readonly() returns.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Signed-off-by: Yu Kuai <yukuai1@huaweicloud.com>
---
 drivers/md/md.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index a0ec01048ede..c0f2bdafe46a 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -6394,6 +6394,9 @@ static int md_set_readonly(struct mddev *mddev, struct block_device *bdev)
 	int err = 0;
 	int did_freeze = 0;
 
+	if (mddev->external && test_bit(MD_SB_CHANGE_PENDING, &mddev->sb_flags))
+		return -EBUSY;
+
 	if (!test_bit(MD_RECOVERY_FROZEN, &mddev->recovery)) {
 		did_freeze = 1;
 		set_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
@@ -6407,8 +6410,6 @@ static int md_set_readonly(struct mddev *mddev, struct block_device *bdev)
 	 */
 	md_wakeup_thread_directly(mddev->sync_thread);
 
-	if (mddev->external && test_bit(MD_SB_CHANGE_PENDING, &mddev->sb_flags))
-		return -EBUSY;
 	mddev_unlock(mddev);
 	wait_event(resync_wait, !test_bit(MD_RECOVERY_RUNNING,
 					  &mddev->recovery));
@@ -6421,27 +6422,26 @@ static int md_set_readonly(struct mddev *mddev, struct block_device *bdev)
 	    mddev->sync_thread ||
 	    test_bit(MD_RECOVERY_RUNNING, &mddev->recovery)) {
 		pr_warn("md: %s still in use.\n",mdname(mddev));
-		if (did_freeze) {
-			clear_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
-			set_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
-		}
 		err = -EBUSY;
 		goto out;
 	}
 	if (mddev->pers) {
 		__md_stop_writes(mddev);
 
-		err  = -ENXIO;
-		if (mddev->ro == MD_RDONLY)
+		if (mddev->ro == MD_RDONLY) {
+			err  = -ENXIO;
 			goto out;
+		}
 		mddev->ro = MD_RDONLY;
 		set_disk_ro(mddev->gendisk, 1);
+	}
+out:
+	if ((mddev->pers && !err) || did_freeze) {
 		clear_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
 		set_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
 		sysfs_notify_dirent_safe(mddev->sysfs_state);
-		err = 0;
 	}
-out:
+
 	mutex_unlock(&mddev->open_mutex);
 	return err;
 }
-- 
2.39.2

