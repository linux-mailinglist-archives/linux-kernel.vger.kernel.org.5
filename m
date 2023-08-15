Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5623077C647
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 05:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234438AbjHODPZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 23:15:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234187AbjHODOH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 23:14:07 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 320DF198D;
        Mon, 14 Aug 2023 20:13:38 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4RPxDY13jkz4f3jXy;
        Tue, 15 Aug 2023 11:13:33 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgAXp6ld7dpknET3Ag--.64666S6;
        Tue, 15 Aug 2023 11:13:36 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     xni@redhat.com, song@kernel.org
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com,
        yangerkun@huawei.com
Subject: [PATCH -next v2 2/7] md: factor out a helper to choose sync direction from md_check_recovery()
Date:   Tue, 15 Aug 2023 11:09:52 +0800
Message-Id: <20230815030957.509535-3-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230815030957.509535-1-yukuai1@huaweicloud.com>
References: <20230815030957.509535-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAXp6ld7dpknET3Ag--.64666S6
X-Coremail-Antispam: 1UD129KBjvJXoWxur1UJF1Dur1kCw18KF4fGrg_yoW5Kr43pa
        1fJFn8Cr4UJayfAr42q3WDXrW5Cr48trWDtFy3W34kAFn0yF1fGa45W3W7AryDGas2qa12
        qw4kJFZrur1YgwUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9m14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
        x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr1j6rxdM2
        8EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AI
        xVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20x
        vE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xv
        r2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxAIw28IcxkI7VAKI48JMxC20s
        026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_
        JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14
        v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xva
        j40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr
        0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUc6pPUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
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
delay choosing sync direction to md_start_sync().

ERROR: do not use assignment in if condition
+       } else if ((spares = remove_and_add_spares(mddev, NULL))) {

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/md.c | 68 +++++++++++++++++++++++++++++++------------------
 1 file changed, 43 insertions(+), 25 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 90815be1e80f..4846ff6d25b0 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -9246,6 +9246,48 @@ static int remove_and_add_spares(struct mddev *mddev,
 	return spares;
 }
 
+static bool md_choose_sync_direction(struct mddev *mddev, int *spares)
+{
+	/* check reshape first */
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
+	 * remove any failed drives, then add spares if possible. Spares are
+	 * also removed and re-added, to allow the personality to fail the
+	 * re-add.
+	 */
+	*spares = remove_and_add_spares(mddev, NULL);
+	if (*spares) {
+		clear_bit(MD_RECOVERY_SYNC, &mddev->recovery);
+		clear_bit(MD_RECOVERY_CHECK, &mddev->recovery);
+		clear_bit(MD_RECOVERY_REQUESTED, &mddev->recovery);
+		set_bit(MD_RECOVERY_RECOVER, &mddev->recovery);
+		return true;
+	}
+
+	/* check recovery */
+	if (mddev->recovery_cp < MaxSector) {
+		set_bit(MD_RECOVERY_SYNC, &mddev->recovery);
+		clear_bit(MD_RECOVERY_RECOVER, &mddev->recovery);
+		return true;
+	}
+
+	/* check resync */
+	if (test_bit(MD_RECOVERY_SYNC, &mddev->recovery))
+		return true;
+
+	/* nothing to be done */
+	return false;
+}
+
 static void md_start_sync(struct work_struct *ws)
 {
 	struct mddev *mddev = container_of(ws, struct mddev, sync_work);
@@ -9427,32 +9469,8 @@ void md_check_recovery(struct mddev *mddev)
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
+		if (!md_choose_sync_direction(mddev, &spares))
 			goto not_running;
-
 		if (mddev->pers->sync_request) {
 			if (spares) {
 				/* We are adding a device or devices to an array
-- 
2.39.2

