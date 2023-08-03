Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8E2976EAB5
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 15:36:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236435AbjHCNfb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 09:35:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236257AbjHCNd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 09:33:56 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D19004EE2;
        Thu,  3 Aug 2023 06:32:39 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RGqXL4pj7z4f3lVY;
        Thu,  3 Aug 2023 21:32:34 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgAHuKtqrMtkWHLlPQ--.49699S26;
        Thu, 03 Aug 2023 21:32:35 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     song@kernel.org, xni@redhat.com
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com,
        yangerkun@huawei.com
Subject: [PATCH -next 22/29] md: use new apis to suspend array related to serial pool in state_store()
Date:   Thu,  3 Aug 2023 21:29:23 +0800
Message-Id: <20230803132930.2742286-23-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230803132930.2742286-1-yukuai1@huaweicloud.com>
References: <20230803132930.2742286-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAHuKtqrMtkWHLlPQ--.49699S26
X-Coremail-Antispam: 1UD129KBjvJXoW7ZF13Zw47Xw1xWFy7GFy5CFg_yoW8WFyfp3
        y7KFWYgryxAw1UJws09a1DuFy5KF4qqrZFk347uw4fu3W5G3s3Krs5Ka95Jr98Zasaqr4Y
        q3WUua95Aw1fGFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBj14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
        kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
        z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
        4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
        3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
        IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4U
        M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF04k20xvY0x0EwIxGrw
        CFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE
        14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2
        IY67AKxVW7JVWDJwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20E
        Y4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267
        AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUqiihUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        MAY_BE_FORGED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

mddev_create/destroy_serial_pool() will be called from state_store() if
user write 'writemostly'/'-writemostly', and mddev_suspend() will be
called later.

Prepare to remove the mddev_suspend() from
mddev_create/destroy_serial_pool().

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/md.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index ca1fe1d17ec1..d5c061c87b2e 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -3067,11 +3067,11 @@ state_store(struct md_rdev *rdev, const char *buf, size_t len)
 		err = remove_rdev(rdev);
 	} else if (cmd_match(buf, "writemostly")) {
 		set_bit(WriteMostly, &rdev->flags);
-		mddev_create_serial_pool(rdev->mddev, rdev, false);
+		mddev_create_serial_pool(rdev->mddev, rdev, true);
 		need_update_sb = true;
 		err = 0;
 	} else if (cmd_match(buf, "-writemostly")) {
-		mddev_destroy_serial_pool(rdev->mddev, rdev, false);
+		mddev_destroy_serial_pool(rdev->mddev, rdev, true);
 		clear_bit(WriteMostly, &rdev->flags);
 		need_update_sb = true;
 		err = 0;
@@ -3695,7 +3695,9 @@ rdev_attr_store(struct kobject *kobj, struct attribute *attr,
 	if (entry->store == state_store) {
 		if (cmd_match(page, "remove"))
 			kn = sysfs_break_active_protection(kobj, attr);
-		if (cmd_match(page, "remove") || cmd_match(page, "re-add")) {
+		if (cmd_match(page, "remove") || cmd_match(page, "re-add") ||
+		    cmd_match(page, "writemostly") ||
+		    cmd_match(page, "-writemostly")) {
 			__mddev_suspend(mddev);
 			suspended = true;
 		}
-- 
2.39.2

