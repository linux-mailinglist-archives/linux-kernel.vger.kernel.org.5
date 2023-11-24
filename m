Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF5857F6D9B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 09:03:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344777AbjKXIDZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 03:03:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234814AbjKXIDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 03:03:01 -0500
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C31DF448E;
        Fri, 24 Nov 2023 00:00:24 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.163.216])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Sc6pq4zTcz4f3mJW;
        Fri, 24 Nov 2023 16:00:19 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
        by mail.maildlp.com (Postfix) with ESMTP id 6D6AB1A0BC0;
        Fri, 24 Nov 2023 16:00:21 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP1 (Coremail) with SMTP id cCh0CgDX2xERWGBlUnAqBw--.22901S10;
        Fri, 24 Nov 2023 16:00:21 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     song@kernel.org, yukuai3@huawei.com, xni@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        yukuai1@huaweicloud.com, yi.zhang@huawei.com, yangerkun@huawei.com
Subject: [PATCH v2 6/6] dm-raid: delay flushing event_work() after reconfig_mutex is released
Date:   Fri, 24 Nov 2023 15:59:53 +0800
Message-Id: <20231124075953.1932764-7-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231124075953.1932764-1-yukuai1@huaweicloud.com>
References: <20231124075953.1932764-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgDX2xERWGBlUnAqBw--.22901S10
X-Coremail-Antispam: 1UD129KBjvJXoW7tFWUurWUtw4rCrWfAFy7Wrg_yoW8Kw15pa
        yYq3yavr4UJ3yUXFZ8G3yv9FyYg3ZagrWDtryfCw1rZ3W5Ar9xWan3KayqvrZ8XFZxJFs0
        yFWFqa98Wayjvr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9K14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
        kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
        z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
        4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
        3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
        IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
        M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF04k20xvY0x0EwIxGrw
        CFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE
        14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2
        IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAv
        wI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14
        v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUOBTYUUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

After commit db5e653d7c9f ("md: delay choosing sync action to
md_start_sync()"), md_start_sync() will hold 'reconfig_mutex', however,
in order to make sure event_work is done, __md_stop() will flush
workqueue with reconfig_mutex grabbed, hence if sync_work is still
pending, deadlock will be triggered.

Fortunately, former pacthes to fix stopping sync_thread already make sure
all sync_work is done already, hence such deadlock is not possible
anymore. However, in order not to cause confusions for people by this
implicit dependency, delay flushing event_work to dm-raid where
'reconfig_mutex' is not held, and add some comments to emphasize that
the workqueue can't be flushed with 'reconfig_mutex'.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/dm-raid.c |  3 +++
 drivers/md/md.c      | 11 ++++++++---
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/md/dm-raid.c b/drivers/md/dm-raid.c
index a4692f8f98ee..51f15c20f621 100644
--- a/drivers/md/dm-raid.c
+++ b/drivers/md/dm-raid.c
@@ -3317,6 +3317,9 @@ static void raid_dtr(struct dm_target *ti)
 	mddev_lock_nointr(&rs->md);
 	md_stop(&rs->md);
 	mddev_unlock(&rs->md);
+
+	if (work_pending(&rs->md.event_work))
+		flush_work(&rs->md.event_work);
 	raid_set_free(rs);
 }
 
diff --git a/drivers/md/md.c b/drivers/md/md.c
index fb8a7d1eebee..86efc9c2ae56 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -82,6 +82,14 @@ static struct module *md_cluster_mod;
 
 static DECLARE_WAIT_QUEUE_HEAD(resync_wait);
 static struct workqueue_struct *md_wq;
+
+/*
+ * This workqueue is used for sync_work to register new sync_thread, and for
+ * del_work to remove rdev, and for event_work that is only set by dm-raid.
+ *
+ * Noted that sync_work will grab reconfig_mutex, hence never flush this
+ * workqueue whith reconfig_mutex grabbed.
+ */
 static struct workqueue_struct *md_misc_wq;
 struct workqueue_struct *md_bitmap_wq;
 
@@ -6328,9 +6336,6 @@ static void __md_stop(struct mddev *mddev)
 	struct md_personality *pers = mddev->pers;
 	md_bitmap_destroy(mddev);
 	mddev_detach(mddev);
-	/* Ensure ->event_work is done */
-	if (mddev->event_work.func)
-		flush_workqueue(md_misc_wq);
 	spin_lock(&mddev->lock);
 	mddev->pers = NULL;
 	spin_unlock(&mddev->lock);
-- 
2.39.2

