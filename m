Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA297787E7E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 05:21:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238674AbjHYDVH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 23:21:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230358AbjHYDUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 23:20:40 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FC1E19AD;
        Thu, 24 Aug 2023 20:20:38 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RX4w25Tssz4f3mVv;
        Fri, 25 Aug 2023 11:20:34 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgDHoqUBHuhkPT4XBg--.14533S6;
        Fri, 25 Aug 2023 11:20:35 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     song@kernel.org, xni@redhat.com
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com,
        yangerkun@huawei.com
Subject: [PATCH -next v4 2/7] md: factor out a helper to choose sync action from md_check_recovery()
Date:   Fri, 25 Aug 2023 11:16:17 +0800
Message-Id: <20230825031622.1530464-3-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230825031622.1530464-1-yukuai1@huaweicloud.com>
References: <20230825031622.1530464-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgDHoqUBHuhkPT4XBg--.14533S6
X-Coremail-Antispam: 1UD129KBjvJXoWxur1UJF1Dur1kZr4DZw4DXFb_yoWrJrWUpa
        1fJFn8CrWUAayfArW7t3WDX3y5ur18tryDtFy3W3s5AFn0yF1fCa45W3W7A34DGas2qa12
        qw4kJFW7uF1Y9wUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9C14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
        x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
        A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
        0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
        IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
        Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF04k20xvY0x0EwIxGrwCFx2
        IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v2
        6r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67
        AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v2
        0xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxV
        W8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUfwIDUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

There are no functional changes, on the one hand make the code cleaner,
on the other hand prevent following checkpatch error in the next patch to
delay choosing sync action to md_start_sync().

ERROR: do not use assignment in if condition
+       } else if ((spares = remove_and_add_spares(mddev, NULL))) {

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Reviewed-by: Xiao Ni <xni@redhat.com>
---
 drivers/md/md.c | 70 +++++++++++++++++++++++++++++++------------------
 1 file changed, 45 insertions(+), 25 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 90815be1e80f..0cb9fa703a0c 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -9246,6 +9246,50 @@ static int remove_and_add_spares(struct mddev *mddev,
 	return spares;
 }
 
+static bool md_choose_sync_action(struct mddev *mddev, int *spares)
+{
+	/* Check if reshape is in progress first. */
+	if (mddev->reshape_position != MaxSector) {
+		if (mddev->pers->check_reshape == NULL ||
+		    mddev->pers->check_reshape(mddev) != 0)
+			return false;
+
+		set_bit(MD_RECOVERY_RESHAPE, &mddev->recovery);
+		clear_bit(MD_RECOVERY_RECOVER, &mddev->recovery);
+		return true;
+	}
+
+	/*
+	 * Remove any failed drives, then add spares if possible. Spares are
+	 * also removed and re-added, to allow the personality to fail the
+	 * re-add.
+	 */
+	*spares = remove_and_add_spares(mddev, NULL);
+	if (*spares) {
+		clear_bit(MD_RECOVERY_SYNC, &mddev->recovery);
+		clear_bit(MD_RECOVERY_CHECK, &mddev->recovery);
+		clear_bit(MD_RECOVERY_REQUESTED, &mddev->recovery);
+
+		/* Start new recovery. */
+		set_bit(MD_RECOVERY_RECOVER, &mddev->recovery);
+		return true;
+	}
+
+	/* Check if recovery is in progress. */
+	if (mddev->recovery_cp < MaxSector) {
+		set_bit(MD_RECOVERY_SYNC, &mddev->recovery);
+		clear_bit(MD_RECOVERY_RECOVER, &mddev->recovery);
+		return true;
+	}
+
+	/* Delay to choose resync/check/repair in md_do_sync(). */
+	if (test_bit(MD_RECOVERY_SYNC, &mddev->recovery))
+		return true;
+
+	/* Nothing to be done */
+	return false;
+}
+
 static void md_start_sync(struct work_struct *ws)
 {
 	struct mddev *mddev = container_of(ws, struct mddev, sync_work);
@@ -9427,32 +9471,8 @@ void md_check_recovery(struct mddev *mddev)
 		if (!test_and_clear_bit(MD_RECOVERY_NEEDED, &mddev->recovery) ||
 		    test_bit(MD_RECOVERY_FROZEN, &mddev->recovery))
 			goto not_running;
-		/* no recovery is running.
-		 * remove any failed drives, then
-		 * add spares if possible.
-		 * Spares are also removed and re-added, to allow
-		 * the personality to fail the re-add.
-		 */
-
-		if (mddev->reshape_position != MaxSector) {
-			if (mddev->pers->check_reshape == NULL ||
-			    mddev->pers->check_reshape(mddev) != 0)
-				/* Cannot proceed */
-				goto not_running;
-			set_bit(MD_RECOVERY_RESHAPE, &mddev->recovery);
-			clear_bit(MD_RECOVERY_RECOVER, &mddev->recovery);
-		} else if ((spares = remove_and_add_spares(mddev, NULL))) {
-			clear_bit(MD_RECOVERY_SYNC, &mddev->recovery);
-			clear_bit(MD_RECOVERY_CHECK, &mddev->recovery);
-			clear_bit(MD_RECOVERY_REQUESTED, &mddev->recovery);
-			set_bit(MD_RECOVERY_RECOVER, &mddev->recovery);
-		} else if (mddev->recovery_cp < MaxSector) {
-			set_bit(MD_RECOVERY_SYNC, &mddev->recovery);
-			clear_bit(MD_RECOVERY_RECOVER, &mddev->recovery);
-		} else if (!test_bit(MD_RECOVERY_SYNC, &mddev->recovery))
-			/* nothing to be done ... */
+		if (!md_choose_sync_action(mddev, &spares))
 			goto not_running;
-
 		if (mddev->pers->sync_request) {
 			if (spares) {
 				/* We are adding a device or devices to an array
-- 
2.39.2

