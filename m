Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 754DB7B12BB
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 08:23:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231180AbjI1GXG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 02:23:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbjI1GWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 02:22:20 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3714121;
        Wed, 27 Sep 2023 23:22:08 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Rx3Kn218tz4f3jq5;
        Thu, 28 Sep 2023 14:22:05 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgAnvdyCGxVl3v1WBg--.22861S26;
        Thu, 28 Sep 2023 14:22:06 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     xni@redhat.com, agk@redhat.com, snitzer@kernel.org,
        dm-devel@redhat.com, song@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com,
        yangerkun@huawei.com
Subject: [PATCH -next v3 22/25] md/md-linear: cleanup linear_add()
Date:   Thu, 28 Sep 2023 14:15:40 +0800
Message-Id: <20230928061543.1845742-23-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230928061543.1845742-1-yukuai1@huaweicloud.com>
References: <20230928061543.1845742-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAnvdyCGxVl3v1WBg--.22861S26
X-Coremail-Antispam: 1UD129KBjvdXoWrKF17uw18ur13CFWUCrW8tFb_yoWktrbE9F
        4Du397Ar1UXry7Zr1Yvw4SvF90qryDWw1kZFySgr9aya48Xw1xAr95Jr45A3srZayfGay5
        Kryxtw4ftr48tjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbq8FF20E14v26rWj6s0DM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAVCq3wA2048vs2
        IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28E
        F7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJr0_Gc
        Wl84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1l
        e2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI
        8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwAC
        jcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0x
        kIwI1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AK
        xVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrx
        kI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Xr0_Ar1lIxAIcVC0I7IYx2IY6xkF7I0E14v2
        6r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F
        4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjfUOBTY
        UUUUU
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

Now that caller already suspend the array, there is no need to suspend
array in liner_add().

Note that mddev_suspend/resume() is not used anymore.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/md-linear.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/md/md-linear.c b/drivers/md/md-linear.c
index ae2826e9645b..8eca7693b793 100644
--- a/drivers/md/md-linear.c
+++ b/drivers/md/md-linear.c
@@ -183,7 +183,6 @@ static int linear_add(struct mddev *mddev, struct md_rdev *rdev)
 	 * in linear_congested(), therefore kfree_rcu() is used to free
 	 * oldconf until no one uses it anymore.
 	 */
-	mddev_suspend(mddev);
 	oldconf = rcu_dereference_protected(mddev->private,
 			lockdep_is_held(&mddev->reconfig_mutex));
 	mddev->raid_disks++;
@@ -192,7 +191,6 @@ static int linear_add(struct mddev *mddev, struct md_rdev *rdev)
 	rcu_assign_pointer(mddev->private, newconf);
 	md_set_array_sectors(mddev, linear_size(mddev, 0, 0));
 	set_capacity_and_notify(mddev->gendisk, mddev->array_sectors);
-	mddev_resume(mddev);
 	kfree_rcu(oldconf, rcu);
 	return 0;
 }
-- 
2.39.2

