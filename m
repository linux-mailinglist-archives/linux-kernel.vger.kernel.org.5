Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 623577E8074
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 19:11:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344724AbjKJSLu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 13:11:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345348AbjKJSLA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 13:11:00 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 717452BE2D;
        Fri, 10 Nov 2023 01:34:04 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.163.235])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4SRYYJ4VLMz4f4Q4J;
        Fri, 10 Nov 2023 17:33:56 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
        by mail.maildlp.com (Postfix) with ESMTP id 7C2BB1A0176;
        Fri, 10 Nov 2023 17:34:00 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP1 (Coremail) with SMTP id cCh0CgA3iA4E+U1l0pQlAg--.33627S12;
        Fri, 10 Nov 2023 17:34:00 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     song@kernel.org, xni@redhat.com, yukuai3@huawei.com, neilb@suse.de
Cc:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        yukuai1@huaweicloud.com, yi.zhang@huawei.com, yangerkun@huawei.com
Subject: [PATCH -next 8/8] dm-raid: fix a deadlock in md_stop()
Date:   Sat, 11 Nov 2023 01:28:34 +0800
Message-Id: <20231110172834.3939490-9-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231110172834.3939490-1-yukuai1@huaweicloud.com>
References: <20231110172834.3939490-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgA3iA4E+U1l0pQlAg--.33627S12
X-Coremail-Antispam: 1UD129KBjvJXoW7tFWUurWUtw17JrW5Zry7ZFb_yoW8Zw45p3
        yFqrWayr4UX3yUXayDGw1kuFyYq3ZYgrWqyrW3Ca4rZayayryxWw1rKa1vgrZ8JF9Iqan0
        vF4qgas8W34jyFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

After commit db5e653d7c9f ("md: delay choosing sync action to
md_start_sync()"), md_start_sync() will hold 'reconfig_mutex', however,
in order to make sure event_work is done, __md_stop() will flush
workqueue with reconfig_mutex grabbed, hence if sync_work is still
pending, deadlock will be triggered.

md_stop			md_start_sync
			 mddev_lock
 mddev_lock
 flush_workqueue -> deadlock

Currently, __md_stop() is the only place to flush workqueue with
'reconfig_mutex' grabbed, and event_work is only used for dm-raid, instead
of split sync_work out of the workqueue, fix this problem the easy way by
moving flush_workqueue to dm-raid where 'reconfig_mutex' is not held, this
is safe because do_table_event() doesn't relate to mdadm and can be called
after md_stop().

Fixes: db5e653d7c9f ("md: delay choosing sync action to md_start_sync()")
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Signed-off-by: Yu Kuai <yukuai1@huaweicloud.com>
---
 drivers/md/dm-raid.c | 3 +++
 drivers/md/md.c      | 3 ---
 2 files changed, 3 insertions(+), 3 deletions(-)

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
index 35f3dd7db369..8f5df249448d 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -6378,9 +6378,6 @@ static void __md_stop(struct mddev *mddev)
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

