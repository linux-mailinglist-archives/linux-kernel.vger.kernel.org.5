Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C1517B12C0
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 08:23:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230484AbjI1GXW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 02:23:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230335AbjI1GWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 02:22:20 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FD9CDD;
        Wed, 27 Sep 2023 23:22:07 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Rx3Kl6Q4Sz4f3kkS;
        Thu, 28 Sep 2023 14:22:03 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgAnvdyCGxVl3v1WBg--.22861S23;
        Thu, 28 Sep 2023 14:22:04 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     xni@redhat.com, agk@redhat.com, snitzer@kernel.org,
        dm-devel@redhat.com, song@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com,
        yangerkun@huawei.com
Subject: [PATCH -next v3 19/25] md: use new apis to suspend array for adding/removing rdev from state_store()
Date:   Thu, 28 Sep 2023 14:15:37 +0800
Message-Id: <20230928061543.1845742-20-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230928061543.1845742-1-yukuai1@huaweicloud.com>
References: <20230928061543.1845742-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAnvdyCGxVl3v1WBg--.22861S23
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr4kXFWftFWfGw1kAF15CFg_yoW8tr43pw
        47ta4rury7Jw43Gw45Zw4kua45twn7KrWqyrZ3uw1fA3WxGw13Gw15tr1kJFyFvasI9r15
        Jw4jgw45G348JFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUP214x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
        kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
        z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr1j6r
        xdM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0D
        M2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjx
        v20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1l
        F7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2
        IY04v7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
        wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc4
        0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267AK
        xVW8Jr0_Cr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JV
        WxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7VUbmZ
        X7UUUUU==
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

User can write 'remove' and 're-add' to trigger array reconfiguration
through sysfs, suspend array in this case so that io won't concurrent
with array reconfiguration.

And now that all the caller of add_bound_rdev() alread suspend the
array, remove mddev_suspend/resume() from add_bound_rdev() as well.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/md.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 957813b7d7e5..c5fb75b066b5 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -2940,11 +2940,7 @@ static int add_bound_rdev(struct md_rdev *rdev)
 		 */
 		super_types[mddev->major_version].
 			validate_super(mddev, rdev);
-		if (add_journal)
-			mddev_suspend(mddev);
 		err = mddev->pers->hot_add_disk(mddev, rdev);
-		if (add_journal)
-			mddev_resume(mddev);
 		if (err) {
 			md_kick_rdev_from_array(rdev);
 			return err;
@@ -3697,6 +3693,7 @@ rdev_attr_store(struct kobject *kobj, struct attribute *attr,
 	struct rdev_sysfs_entry *entry = container_of(attr, struct rdev_sysfs_entry, attr);
 	struct md_rdev *rdev = container_of(kobj, struct md_rdev, kobj);
 	struct kernfs_node *kn = NULL;
+	bool suspend = false;
 	ssize_t rv;
 	struct mddev *mddev = rdev->mddev;
 
@@ -3704,17 +3701,23 @@ rdev_attr_store(struct kobject *kobj, struct attribute *attr,
 		return -EIO;
 	if (!capable(CAP_SYS_ADMIN))
 		return -EACCES;
+	if (!mddev)
+		return -ENODEV;
 
-	if (entry->store == state_store && cmd_match(page, "remove"))
-		kn = sysfs_break_active_protection(kobj, attr);
+	if (entry->store == state_store) {
+		if (cmd_match(page, "remove"))
+			kn = sysfs_break_active_protection(kobj, attr);
+		if (cmd_match(page, "remove") || cmd_match(page, "re-add"))
+			suspend = true;
+	}
 
-	rv = mddev ? mddev_lock(mddev) : -ENODEV;
+	rv = suspend ? mddev_suspend_and_lock(mddev) : mddev_lock(mddev);
 	if (!rv) {
 		if (rdev->mddev == NULL)
 			rv = -ENODEV;
 		else
 			rv = entry->store(rdev, page, length);
-		mddev_unlock(mddev);
+		suspend ? mddev_unlock_and_resume(mddev) : mddev_unlock(mddev);
 	}
 
 	if (kn)
-- 
2.39.2

