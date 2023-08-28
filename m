Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D28EA78A44A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 04:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbjH1CFU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 22:05:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbjH1CEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 22:04:51 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BFBD127;
        Sun, 27 Aug 2023 19:04:49 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4RYv572xghz4f3nqr;
        Mon, 28 Aug 2023 10:04:43 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgAnBai7AOxk9qcCBw--.25880S8;
        Mon, 28 Aug 2023 10:04:46 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     agk@redhat.com, snitzer@kernel.org, dm-devel@redhat.com,
        song@kernel.org, xni@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com,
        yangerkun@huawei.com
Subject: [PATCH -next v2 04/28] md: add new helpers to suspend/resume and lock/unlock array
Date:   Mon, 28 Aug 2023 09:59:57 +0800
Message-Id: <20230828020021.2489641-5-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230828020021.2489641-1-yukuai1@huaweicloud.com>
References: <20230828020021.2489641-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAnBai7AOxk9qcCBw--.25880S8
X-Coremail-Antispam: 1UD129KBjvJXoW7Zry5AF17tryDtw4ftF1DWrg_yoW8Aw4Upr
        W2qFWrGr4UtFWfWrW3Jan7Ca45Aw10grZFyrW3Jwn7Ca43J347GF15Wr1UJrn5KayfXF1D
        Ja1Yqa48CrWUGrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUPF14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
        kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
        z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
        4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
        3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
        IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
        M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
        kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
        14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIx
        kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
        wI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
        W8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUOBTY
        UUUUU
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

The new helpers suspend the array first and then lock the array,

Prepare to refactor from:

mddev_lock/trylock/lock_nointr
mddev_suspend
...
mddev_resuem
mddev_lock

With:

mddev_suspend_and_lock/trylock/lock_nointr
...
mddev_unlock_and_resume

After all the use cases is refactored, mddev_suspend/resume() will be
removed.

And mddev_suspend_and_lock() will also replace mddev_lock() for the case
that the array will be reconfigured, in order to synchronize with io to
prevent problems in many corner cases.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/md.h | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/drivers/md/md.h b/drivers/md/md.h
index 1103e6b08ad9..07496179084a 100644
--- a/drivers/md/md.h
+++ b/drivers/md/md.h
@@ -858,6 +858,42 @@ static inline void mddev_check_write_zeroes(struct mddev *mddev, struct bio *bio
 		mddev->queue->limits.max_write_zeroes_sectors = 0;
 }
 
+static inline int mddev_suspend_and_lock(struct mddev *mddev)
+{
+	int ret;
+
+	__mddev_suspend(mddev);
+	ret = mddev_lock(mddev);
+	if (ret)
+		__mddev_resume(mddev);
+
+	return ret;
+}
+
+static inline void mddev_suspend_and_lock_nointr(struct mddev *mddev)
+{
+	__mddev_suspend(mddev);
+	mutex_lock(&mddev->reconfig_mutex);
+}
+
+static inline int mddev_suspend_and_trylock(struct mddev *mddev)
+{
+	int ret;
+
+	__mddev_suspend(mddev);
+	ret = mutex_trylock(&mddev->reconfig_mutex);
+	if (ret)
+		__mddev_resume(mddev);
+
+	return ret;
+}
+
+static inline void mddev_unlock_and_resume(struct mddev *mddev)
+{
+	mddev_unlock(mddev);
+	__mddev_resume(mddev);
+}
+
 struct mdu_array_info_s;
 struct mdu_disk_info_s;
 
-- 
2.39.2

