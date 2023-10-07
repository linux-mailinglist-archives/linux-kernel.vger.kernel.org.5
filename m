Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F04737BC45F
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 05:24:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343509AbjJGDYl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 23:24:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234091AbjJGDYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 23:24:39 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0D98BD;
        Fri,  6 Oct 2023 20:24:37 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4S2Vyl6DkHz4f3m6r;
        Sat,  7 Oct 2023 11:24:31 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgD3jd1tzyBlo9pRCQ--.28427S4;
        Sat, 07 Oct 2023 11:24:32 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     song@kernel.org
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com,
        yangerkun@huawei.com
Subject: [PATCH -next] md/raid1: don't split discard io for write behind
Date:   Sat,  7 Oct 2023 19:21:05 +0800
Message-Id: <20231007112105.407449-1-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgD3jd1tzyBlo9pRCQ--.28427S4
X-Coremail-Antispam: 1UD129KBjvJXoW7try8AF18Ar4rXw4DJr4fXwb_yoW8Ww1rp3
        yqgFWYyr9rXr12yr1DXa4DZFyrtasFqrW7KrWfX3y7Zr13XFyUXa1ktas5Jr1kCrZ3ury3
        Zr4qyrW8ua4UXrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvF14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK62vIxIIY0VWUZVW8XwA2ocxC64kIII
        0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xv
        wVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4
        x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG
        64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r
        1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAq
        YI8I648v4I1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
        xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1D
        MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
        0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv67AK
        xVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvj
        TRNgAwUUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

Currently, discad io is treated the same as normal write io, and for
write behind case, io size is limited to:

BIO_MAX_VECS * (PAGE_SIZE >> 9)

For 0.5KB sector size and 4KB PAGE_SIZE, this is just 1MB. For
consequence, if 'WriteMostly' is set to one of the underlying disks,
then diskcard io will be splited into 1MB and it will take a long time
for the diskcard to finish.

Fix this problem by disable write behind for discard io.

Reported-by: Roman Mamedov <rm@romanrm.net>
Closes: https://lore.kernel.org/all/6a1165f7-c792-c054-b8f0-1ad4f7b8ae01@ultracoder.org/
Reported-and-tested-by: Kirill Kirilenko <kirill@ultracoder.org>
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/raid1.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index 3a78f79ee6d5..35d12948e0a9 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -1345,6 +1345,7 @@ static void raid1_write_request(struct mddev *mddev, struct bio *bio,
 	int first_clone;
 	int max_sectors;
 	bool write_behind = false;
+	bool is_discard = (bio_op(bio) == REQ_OP_DISCARD);
 
 	if (mddev_is_clustered(mddev) &&
 	     md_cluster_ops->area_resyncing(mddev, WRITE,
@@ -1405,7 +1406,7 @@ static void raid1_write_request(struct mddev *mddev, struct bio *bio,
 		 * write-mostly, which means we could allocate write behind
 		 * bio later.
 		 */
-		if (rdev && test_bit(WriteMostly, &rdev->flags))
+		if (!is_discard && rdev && test_bit(WriteMostly, &rdev->flags))
 			write_behind = true;
 
 		if (rdev && unlikely(test_bit(Blocked, &rdev->flags))) {
-- 
2.39.2

