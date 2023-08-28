Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A12DE78A46D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 04:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbjH1CFd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 22:05:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbjH1CE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 22:04:58 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79A7ADA;
        Sun, 27 Aug 2023 19:04:56 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4RYv5G4dzWz4f3nqG;
        Mon, 28 Aug 2023 10:04:50 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgAnBai7AOxk9qcCBw--.25880S24;
        Mon, 28 Aug 2023 10:04:53 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     agk@redhat.com, snitzer@kernel.org, dm-devel@redhat.com,
        song@kernel.org, xni@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com,
        yangerkun@huawei.com
Subject: [PATCH -next v2 20/28] md: use new apis to suspend array for adding/removing rdev from state_store()
Date:   Mon, 28 Aug 2023 10:00:13 +0800
Message-Id: <20230828020021.2489641-21-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230828020021.2489641-1-yukuai1@huaweicloud.com>
References: <20230828020021.2489641-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAnBai7AOxk9qcCBw--.25880S24
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr4kXFWfAF4DCr48AFW5ZFb_yoW8ZF1kpF
        47ta4rWrWxJw45Gw4rZa1kuas0qw1vkrWqyrWagw1fZ3WxGwnrGFy5tr4DAF9Yv3ya9r43
        Xw4UK3y5GryfArDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUPI14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
        kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
        z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
        4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
        3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
        IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
        M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
        kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
        14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIx
        kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW5JVW7JwCI42IY6xIIjxv20xvEc7CjxVAF
        wI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr
        0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUQ
        SdkUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.3 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=no
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

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/md.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 81c7b9d1cc36..0f1006197afd 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -2918,11 +2918,7 @@ static int add_bound_rdev(struct md_rdev *rdev)
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
@@ -3675,6 +3671,7 @@ rdev_attr_store(struct kobject *kobj, struct attribute *attr,
 	struct rdev_sysfs_entry *entry = container_of(attr, struct rdev_sysfs_entry, attr);
 	struct md_rdev *rdev = container_of(kobj, struct md_rdev, kobj);
 	struct kernfs_node *kn = NULL;
+	bool suspended = false;
 	ssize_t rv;
 	struct mddev *mddev = rdev->mddev;
 
@@ -3683,8 +3680,14 @@ rdev_attr_store(struct kobject *kobj, struct attribute *attr,
 	if (!capable(CAP_SYS_ADMIN))
 		return -EACCES;
 
-	if (entry->store == state_store && cmd_match(page, "remove"))
-		kn = sysfs_break_active_protection(kobj, attr);
+	if (entry->store == state_store) {
+		if (cmd_match(page, "remove"))
+			kn = sysfs_break_active_protection(kobj, attr);
+		if (cmd_match(page, "remove") || cmd_match(page, "re-add")) {
+			__mddev_suspend(mddev);
+			suspended = true;
+		}
+	}
 
 	rv = mddev ? mddev_lock(mddev) : -ENODEV;
 	if (!rv) {
@@ -3693,6 +3696,9 @@ rdev_attr_store(struct kobject *kobj, struct attribute *attr,
 		else
 			rv = entry->store(rdev, page, length);
 		mddev_unlock(mddev);
+
+		if (suspended)
+			__mddev_resume(mddev);
 	}
 
 	if (kn)
-- 
2.39.2

