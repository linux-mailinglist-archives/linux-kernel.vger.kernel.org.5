Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 587D278D9DE
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:35:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234867AbjH3SeV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:34:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242769AbjH3Jdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 05:33:39 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FA121A1;
        Wed, 30 Aug 2023 02:33:36 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RbJy43C8pz4f3pHy;
        Wed, 30 Aug 2023 17:33:32 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgD3hqnrDO9kkRu9Bw--.49032S5;
        Wed, 30 Aug 2023 17:33:33 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     song@kernel.org, xni@redhat.com
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com,
        yangerkun@huawei.com
Subject: [PATCH -next 1/2] md: factor out helpers to grab and put 'active_io'
Date:   Wed, 30 Aug 2023 17:29:01 +0800
Message-Id: <20230830092902.1236950-2-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230830092902.1236950-1-yukuai1@huaweicloud.com>
References: <20230830092902.1236950-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgD3hqnrDO9kkRu9Bw--.49032S5
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr47Kr4xtryDurWxtrW3GFg_yoW8uryxpa
        yIqa90yrWDJrZxKw43JFyDWa4rWr1vgFZ7KrWxGa4fA3W2vr95Ka1Yga10qrn5Cayfuwnx
        Aw1vqF17GF1xArUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9m14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
        x26xkF7I0E14v26r1I6r4UM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
        A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
        0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
        IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
        Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF04k20xvY0x0EwIxGrwCFx2
        IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v2
        6r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67
        AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IY
        s7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr
        0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUqAp5UUUUU=
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

There are no functional changes, prepare to fix a problem that 'sb_wait'
is not woke up while 'active_io' is decreased to 0.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/md.c | 33 +++++++++++++++++++++++++++------
 1 file changed, 27 insertions(+), 6 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 0fe7ab6e8ab9..0d69b1a2e2d5 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -368,16 +368,18 @@ static bool is_suspended(struct mddev *mddev, struct bio *bio)
 	return true;
 }
 
-void md_handle_request(struct mddev *mddev, struct bio *bio)
+static bool md_array_enter(struct mddev *mddev, struct bio *bio)
 {
 check_suspended:
 	if (is_suspended(mddev, bio)) {
 		DEFINE_WAIT(__wait);
+
 		/* Bail out if REQ_NOWAIT is set for the bio */
 		if (bio->bi_opf & REQ_NOWAIT) {
 			bio_wouldblock_error(bio);
-			return;
+			return false;
 		}
+
 		for (;;) {
 			prepare_to_wait(&mddev->sb_wait, &__wait,
 					TASK_UNINTERRUPTIBLE);
@@ -387,15 +389,34 @@ void md_handle_request(struct mddev *mddev, struct bio *bio)
 		}
 		finish_wait(&mddev->sb_wait, &__wait);
 	}
+
 	if (!percpu_ref_tryget_live(&mddev->active_io))
 		goto check_suspended;
 
+	return true;
+}
+
+static void md_array_exit(struct mddev *mddev)
+{
+	percpu_ref_put(&mddev->active_io);
+}
+
+void md_handle_request(struct mddev *mddev, struct bio *bio)
+{
+retry:
+	if (!md_array_enter(mddev, bio))
+		return;
+
 	if (!mddev->pers->make_request(mddev, bio)) {
-		percpu_ref_put(&mddev->active_io);
-		goto check_suspended;
+		md_array_exit(mddev);
+		goto retry;
 	}
 
-	percpu_ref_put(&mddev->active_io);
+	/*
+	 * pers->make_request() will grab additional reference until bio is
+	 * done.
+	 */
+	md_array_exit(mddev);
 }
 EXPORT_SYMBOL(md_handle_request);
 
@@ -8667,7 +8688,7 @@ static void md_end_clone_io(struct bio *bio)
 
 	bio_put(bio);
 	bio_endio(orig_bio);
-	percpu_ref_put(&mddev->active_io);
+	md_array_exit(mddev);
 }
 
 static void md_clone_bio(struct mddev *mddev, struct bio **bio)
-- 
2.39.2

