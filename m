Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48DE77E84D4
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 22:00:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346134AbjKJU5i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 15:57:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235873AbjKJU5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 15:57:23 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2E15244BB;
        Fri, 10 Nov 2023 01:34:00 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.163.235])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4SRYYG1c8Yz4f4PNq;
        Fri, 10 Nov 2023 17:33:54 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
        by mail.maildlp.com (Postfix) with ESMTP id 17CDD1A0173;
        Fri, 10 Nov 2023 17:33:58 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP1 (Coremail) with SMTP id cCh0CgA3iA4E+U1l0pQlAg--.33627S6;
        Fri, 10 Nov 2023 17:33:57 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     song@kernel.org, xni@redhat.com, yukuai3@huawei.com, neilb@suse.de
Cc:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        yukuai1@huaweicloud.com, yi.zhang@huawei.com, yangerkun@huawei.com
Subject: [PATCH -next 2/8] md: use interruptible apis in idle/frozen_sync_thread()
Date:   Sat, 11 Nov 2023 01:28:28 +0800
Message-Id: <20231110172834.3939490-3-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231110172834.3939490-1-yukuai1@huaweicloud.com>
References: <20231110172834.3939490-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgA3iA4E+U1l0pQlAg--.33627S6
X-Coremail-Antispam: 1UD129KBjvJXoW7Kw4UWr1xur17ArW8Ar1UKFg_yoW8CF1Up3
        yxGF98Ar45ArsxZ347J3WDZa4rZw1j9ayqyrW3Wa1fJwn3tr42gF109FyUZFykWayfCr4U
        Ja4rtFW3ZFy8Gw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBE14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK62vIxIIY0VWUZVW8XwA2048vs2IY02
        0E87I2jVAFwI0_Jryl82xGYIkIc2x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2
        F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjx
        v20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2
        z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0V
        AKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1l
        Ox8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErc
        IFxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v2
        6r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2
        Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_
        Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMI
        IF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0pRY2NJUUUUU
        =
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

Before refactoring idle and frozen from action_store, interruptible apis
is used so that hungtask warning won't be triggered if it takes too long
to finish indle/frozen sync_thread. So change to use interruptible apis.

Fixes: 130443d60b1b ("md: refactor idle/frozen_sync_thread() to fix deadlock")
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Signed-off-by: Yu Kuai <yukuai1@huaweicloud.com>
---
 drivers/md/md.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 1701e2fb219f..5c9387369de1 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -4882,11 +4882,14 @@ static void idle_sync_thread(struct mddev *mddev)
 {
 	int sync_seq = atomic_read(&mddev->sync_seq);
 
-	mutex_lock(&mddev->sync_mutex);
+	if (mutex_lock_interruptible(&mddev->sync_mutex))
+		return;
+
 	clear_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
 	stop_sync_thread(mddev);
 
-	wait_event(resync_wait, sync_seq != atomic_read(&mddev->sync_seq) ||
+	wait_event_interruptible(resync_wait,
+			sync_seq != atomic_read(&mddev->sync_seq) ||
 			!test_bit(MD_RECOVERY_RUNNING, &mddev->recovery));
 
 	mutex_unlock(&mddev->sync_mutex);
@@ -4894,11 +4897,13 @@ static void idle_sync_thread(struct mddev *mddev)
 
 static void frozen_sync_thread(struct mddev *mddev)
 {
-	mutex_lock(&mddev->sync_mutex);
+	if (mutex_lock_interruptible(&mddev->sync_mutex))
+		return;
+
 	set_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
 	stop_sync_thread(mddev);
 
-	wait_event(resync_wait, mddev->sync_thread == NULL &&
+	wait_event_interruptible(resync_wait, mddev->sync_thread == NULL &&
 			!test_bit(MD_RECOVERY_RUNNING, &mddev->recovery));
 
 	mutex_unlock(&mddev->sync_mutex);
-- 
2.39.2

