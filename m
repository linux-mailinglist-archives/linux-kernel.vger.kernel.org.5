Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FAF27AE3F0
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 05:05:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231775AbjIZDFD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 23:05:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbjIZDFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 23:05:00 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42315F3;
        Mon, 25 Sep 2023 20:04:54 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Rvl2k3G1dz4f3n6N;
        Tue, 26 Sep 2023 11:04:30 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgDnfd0+ShJlShWjBQ--.31625S5;
        Tue, 26 Sep 2023 11:04:32 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     mariusz.tkaczyk@linux.intel.com, xni@redhat.com, song@kernel.org
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com,
        yangerkun@huawei.com
Subject: [PATCH v2 1/2] md: factor out a new helper to put mddev
Date:   Tue, 26 Sep 2023 10:58:26 +0800
Message-Id: <20230926025827.671407-2-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230926025827.671407-1-yukuai1@huaweicloud.com>
References: <20230926025827.671407-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgDnfd0+ShJlShWjBQ--.31625S5
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr47Kr4xtrykurWUWr1kGrg_yoW8XF1fpa
        1Sga98CrWUXFZaq3yUCa9ru3W5J3WvkrWDtryxG393ZFy3Kr1DWw1Fqa1UXr15Ga4fZFsI
        va1jqF1Uur18XrUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9v14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
        x26xkF7I0E14v26r1I6r4UM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr1j6rxdM2
        8EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AI
        xVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20x
        vE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xv
        r2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxAIw28IcxkI7VAKI48JMxC20s
        026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_
        JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14
        v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xva
        j40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JV
        W8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbec_DUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

There are no functional changes, the new helper will still hold
'all_mddevs_lock' after putting mddev, and it will be used to simplify
md_seq_ops.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/md.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 10cb4dfbf4ae..a5ef6f7da8ec 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -616,10 +616,15 @@ static inline struct mddev *mddev_get(struct mddev *mddev)
 
 static void mddev_delayed_delete(struct work_struct *ws);
 
-void mddev_put(struct mddev *mddev)
+static void __mddev_put(struct mddev *mddev, bool locked)
 {
-	if (!atomic_dec_and_lock(&mddev->active, &all_mddevs_lock))
+	if (locked) {
+		spin_lock(&all_mddevs_lock);
+		if (!atomic_dec_and_test(&mddev->active))
+			return;
+	} else if (!atomic_dec_and_lock(&mddev->active, &all_mddevs_lock))
 		return;
+
 	if (!mddev->raid_disks && list_empty(&mddev->disks) &&
 	    mddev->ctime == 0 && !mddev->hold_active) {
 		/* Array is not configured at all, and not held active,
@@ -633,7 +638,14 @@ void mddev_put(struct mddev *mddev)
 		 */
 		queue_work(md_misc_wq, &mddev->del_work);
 	}
-	spin_unlock(&all_mddevs_lock);
+
+	if (!locked)
+		spin_unlock(&all_mddevs_lock);
+}
+
+void mddev_put(struct mddev *mddev)
+{
+	__mddev_put(mddev, false);
 }
 
 static void md_safemode_timeout(struct timer_list *t);
-- 
2.39.2

