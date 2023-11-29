Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A9857FCC7B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 03:03:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376737AbjK2CDQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 21:03:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbjK2CDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 21:03:14 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E9ED198D;
        Tue, 28 Nov 2023 18:03:19 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.163.235])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Sg2fT1Hrhz4f3jZB;
        Wed, 29 Nov 2023 10:03:13 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
        by mail.maildlp.com (Postfix) with ESMTP id 0CB171A0C0D;
        Wed, 29 Nov 2023 10:03:16 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP1 (Coremail) with SMTP id cCh0CgDHyhDim2ZlfZTmCA--.8717S4;
        Wed, 29 Nov 2023 10:03:15 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     song@kernel.org, neilb@suse.de, maan@systemlinux.org
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com,
        yangerkun@huawei.com
Subject: [PATCH v3] md: synchronize flush io with array reconfiguration
Date:   Wed, 29 Nov 2023 10:02:34 +0800
Message-Id: <20231129020234.1586910-1-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgDHyhDim2ZlfZTmCA--.8717S4
X-Coremail-Antispam: 1UD129KBjvJXoWxWry8uFW5Kw1DZw4xtr1UWrg_yoW5AFy3p3
        yFq3Zxtr4UXFZ8KwsxJa1kGr1rWa1jvFW0yay3Z343Zw13Xrn8G3yfKF95Xr98CFyfu3y3
        ur4qgw4Dua4jqFUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyK14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1l42xK82IYc2Ij64vI
        r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
        xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0
        cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8V
        AvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF
        7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUoOJ5UUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

Currently rcu is used to protect iterating rdev from submit_flushes():

submit_flushes			remove_and_add_spares
				synchronize_rcu
				pers->hot_remove_disk()
 rcu_read_lock()
 rdev_for_each_rcu
  if (rdev->raid_disk >= 0)
				rdev->radi_disk = -1;
   atomic_inc(&rdev->nr_pending)
   rcu_read_unlock()
   bi = bio_alloc_bioset()
   bi->bi_end_io = md_end_flush
   bi->private = rdev
   submit_bio
   // issue io for removed rdev

Fix this problem by grabbing 'acive_io' before iterating rdev, make sure
that remove_and_add_spares() won't concurrent with submit_flushes().

Fixes: a2826aa92e2e ("md: support barrier requests on all personalities.")
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
Changes in v3:
 - use WARN_ON(percpu_ref_is_zero()) and use percpu_ref_get().
Changes in v2:
 - Add WARN_ON in case md_flush_request() is not called from
 md_handle_request() in future.
 drivers/md/md.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 05902e36db66..75ff96d53266 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -529,6 +529,9 @@ static void md_end_flush(struct bio *bio)
 	rdev_dec_pending(rdev, mddev);
 
 	if (atomic_dec_and_test(&mddev->flush_pending)) {
+		/* The pair is percpu_ref_get() from md_flush_request() */
+		percpu_ref_put(&mddev->active_io);
+
 		/* The pre-request flush has finished */
 		queue_work(md_wq, &mddev->flush_work);
 	}
@@ -548,12 +551,8 @@ static void submit_flushes(struct work_struct *ws)
 	rdev_for_each_rcu(rdev, mddev)
 		if (rdev->raid_disk >= 0 &&
 		    !test_bit(Faulty, &rdev->flags)) {
-			/* Take two references, one is dropped
-			 * when request finishes, one after
-			 * we reclaim rcu_read_lock
-			 */
 			struct bio *bi;
-			atomic_inc(&rdev->nr_pending);
+
 			atomic_inc(&rdev->nr_pending);
 			rcu_read_unlock();
 			bi = bio_alloc_bioset(rdev->bdev, 0,
@@ -564,7 +563,6 @@ static void submit_flushes(struct work_struct *ws)
 			atomic_inc(&mddev->flush_pending);
 			submit_bio(bi);
 			rcu_read_lock();
-			rdev_dec_pending(rdev, mddev);
 		}
 	rcu_read_unlock();
 	if (atomic_dec_and_test(&mddev->flush_pending))
@@ -617,6 +615,18 @@ bool md_flush_request(struct mddev *mddev, struct bio *bio)
 	/* new request after previous flush is completed */
 	if (ktime_after(req_start, mddev->prev_flush_start)) {
 		WARN_ON(mddev->flush_bio);
+		/*
+		 * Grab a reference to make sure mddev_suspend() will wait for
+		 * this flush to be done.
+		 *
+		 * md_flush_reqeust() is called under md_handle_request() and
+		 * 'active_io' is already grabbed, hence percpu_ref_is_zero()
+		 * won't pass, percpu_ref_tryget_live() can't be used because
+		 * percpu_ref_kill() can be called by mddev_suspend()
+		 * concurrently.
+		 */
+		WARN_ON(percpu_ref_is_zero(&mddev->active_io));
+		percpu_ref_get(&mddev->active_io);
 		mddev->flush_bio = bio;
 		bio = NULL;
 	}
-- 
2.39.2

