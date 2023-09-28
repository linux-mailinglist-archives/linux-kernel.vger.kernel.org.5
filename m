Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9B667B12B5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 08:22:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230504AbjI1GWs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 02:22:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230375AbjI1GWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 02:22:19 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E0A4AF;
        Wed, 27 Sep 2023 23:22:06 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Rx3Kj605gz4f3mHk;
        Thu, 28 Sep 2023 14:22:01 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgAnvdyCGxVl3v1WBg--.22861S21;
        Thu, 28 Sep 2023 14:22:03 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     xni@redhat.com, agk@redhat.com, snitzer@kernel.org,
        dm-devel@redhat.com, song@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com,
        yangerkun@huawei.com
Subject: [PATCH -next v3 17/25] md/raid5: replace suspend with quiesce() callback
Date:   Thu, 28 Sep 2023 14:15:35 +0800
Message-Id: <20230928061543.1845742-18-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230928061543.1845742-1-yukuai1@huaweicloud.com>
References: <20230928061543.1845742-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAnvdyCGxVl3v1WBg--.22861S21
X-Coremail-Antispam: 1UD129KBjvJXoWxWFykZr18Cry7tr1kGFWfZrb_yoW5Xr4Dpw
        s0gFsrXr4UWF9xu34DZa1kWFyrK3yUKrWkKryxW39Yva47Gr4kurWfJw45ZFy7G34FyFs7
        t3y5J34kZFWvqrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUPI14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
        kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
        z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
        4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
        3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
        IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
        M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
        kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
        14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIx
        kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAF
        wI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr
        0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUQ
        SdkUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

raid5 is the only personality to suspend array in check_reshape() and
start_reshape() callback, suspend and quiesce() callback can both wait
for all normal io to be done, and prevent new io to be dispatched, the
difference is that suspend is implemented in common layer, and quiesce()
callback is implemented in raid5.

In order to cleanup all the usage of mddev_suspend(), the new apis
__mddev_suspend() need to be called before 'reconfig_mutex' is held,
and it's not good to affect all the personalities in common layer just
for raid5. Hence replace suspend with quiesce() callaback, prepare to
reomove all the users of mddev_suspend().

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/raid5.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index e6b8c0145648..d6de084a85e5 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -70,6 +70,8 @@ MODULE_PARM_DESC(devices_handle_discard_safely,
 		 "Set to Y if all devices in each array reliably return zeroes on reads from discarded regions");
 static struct workqueue_struct *raid5_wq;
 
+static void raid5_quiesce(struct mddev *mddev, int quiesce);
+
 static inline struct hlist_head *stripe_hash(struct r5conf *conf, sector_t sect)
 {
 	int hash = (sect >> RAID5_STRIPE_SHIFT(conf)) & HASH_MASK;
@@ -2492,15 +2494,12 @@ static int resize_chunks(struct r5conf *conf, int new_disks, int new_sectors)
 	unsigned long cpu;
 	int err = 0;
 
-	/*
-	 * Never shrink. And mddev_suspend() could deadlock if this is called
-	 * from raid5d. In that case, scribble_disks and scribble_sectors
-	 * should equal to new_disks and new_sectors
-	 */
+	/* Never shrink. */
 	if (conf->scribble_disks >= new_disks &&
 	    conf->scribble_sectors >= new_sectors)
 		return 0;
-	mddev_suspend(conf->mddev);
+
+	raid5_quiesce(conf->mddev, true);
 	cpus_read_lock();
 
 	for_each_present_cpu(cpu) {
@@ -2514,7 +2513,8 @@ static int resize_chunks(struct r5conf *conf, int new_disks, int new_sectors)
 	}
 
 	cpus_read_unlock();
-	mddev_resume(conf->mddev);
+	raid5_quiesce(conf->mddev, false);
+
 	if (!err) {
 		conf->scribble_disks = new_disks;
 		conf->scribble_sectors = new_sectors;
@@ -8551,8 +8551,8 @@ static int raid5_start_reshape(struct mddev *mddev)
 	 * the reshape wasn't running - like Discard or Read - have
 	 * completed.
 	 */
-	mddev_suspend(mddev);
-	mddev_resume(mddev);
+	raid5_quiesce(mddev, true);
+	raid5_quiesce(mddev, false);
 
 	/* Add some new drives, as many as will fit.
 	 * We know there are enough to make the newly sized array work.
-- 
2.39.2

