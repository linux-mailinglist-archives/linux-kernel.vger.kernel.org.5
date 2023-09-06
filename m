Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0712F79388A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 11:42:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234727AbjIFJme (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 05:42:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237074AbjIFJmb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 05:42:31 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9722510F8;
        Wed,  6 Sep 2023 02:42:17 -0700 (PDT)
Received: from dggpeml500003.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Rgcmq2v8Cz1M93f;
        Wed,  6 Sep 2023 17:40:27 +0800 (CST)
Received: from huawei.com (10.175.104.67) by dggpeml500003.china.huawei.com
 (7.185.36.200) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 6 Sep
 2023 17:42:14 +0800
From:   Li Nan <linan122@huawei.com>
To:     <song@kernel.org>
CC:     <linux-raid@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linan122@huawei.com>, <yukuai3@huawei.com>, <yi.zhang@huawei.com>,
        <houtao1@huawei.com>, <yangerkun@huawei.com>
Subject: [PATCH] md/raid1: only update stack limits with the device in use
Date:   Wed, 6 Sep 2023 17:37:20 +0800
Message-ID: <20230906093720.1070929-1-linan122@huawei.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.67]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500003.china.huawei.com (7.185.36.200)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Spare device affects array stack limits is unreasonable. For example,
create a raid1 with two 512 byte devices, the logical_block_size of array
will be 512. But after add a 4k devcie as spare, logical_block_size of
array will change as follows.

  mdadm -C /dev/md0 -n 2 -l 10 /dev/sd[ab]	//sd[ab] is 512
  //logical_block_size of md0: 512

  mdadm --add /dev/md0 /dev/sdc			//sdc is 4k
  //logical_block_size of md0: 512

  mdadm -S /dev/md0
  mdadm -A /dev/md0 /dev/sd[ab]
  //logical_block_size of md0: 4k

This will confuse users, as nothing has been changed, why did the
logical_block_size of array change?

Now, only update logical_block_size of array with the device in use.

Signed-off-by: Li Nan <linan122@huawei.com>
---
 drivers/md/raid1.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index 95504612b7e2..d75c5dd89e86 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -3140,19 +3140,16 @@ static int raid1_run(struct mddev *mddev)
 	if (mddev->queue)
 		blk_queue_max_write_zeroes_sectors(mddev->queue, 0);
 
-	rdev_for_each(rdev, mddev) {
-		if (!mddev->gendisk)
-			continue;
-		disk_stack_limits(mddev->gendisk, rdev->bdev,
-				  rdev->data_offset << 9);
-	}
-
 	mddev->degraded = 0;
-	for (i = 0; i < conf->raid_disks; i++)
-		if (conf->mirrors[i].rdev == NULL ||
-		    !test_bit(In_sync, &conf->mirrors[i].rdev->flags) ||
-		    test_bit(Faulty, &conf->mirrors[i].rdev->flags))
+	for (i = 0; i < conf->raid_disks; i++) {
+		rdev = conf->mirrors[i].rdev;
+		if (rdev && mddev->gendisk)
+			disk_stack_limits(mddev->gendisk, rdev->bdev,
+					  rdev->data_offset << 9);
+		if (!rdev || !test_bit(In_sync, &rdev->flags) ||
+		    test_bit(Faulty, &rdev->flags))
 			mddev->degraded++;
+	}
 	/*
 	 * RAID1 needs at least one disk in active
 	 */
-- 
2.39.2

