Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 768427E530D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 11:07:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344022AbjKHKHh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 05:07:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235502AbjKHKHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 05:07:35 -0500
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBA691728;
        Wed,  8 Nov 2023 02:07:31 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.93.142])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4SQLNv0lyNz4f3l7g;
        Wed,  8 Nov 2023 18:07:27 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
        by mail.maildlp.com (Postfix) with ESMTP id 2F9731A0199;
        Wed,  8 Nov 2023 18:07:28 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP1 (Coremail) with SMTP id cCh0CgDX2xHeXUtlKTpyAQ--.15863S4;
        Wed, 08 Nov 2023 18:07:27 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     xni@redhat.com, song@kernel.org, maan@systemlinux.org,
        neilb@suse.de
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com,
        yangerkun@huawei.com
Subject: [PATCH -next] md: synchronize flush io with array reconfiguration
Date:   Thu,  9 Nov 2023 02:02:10 +0800
Message-Id: <20231108180210.3657203-1-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgDX2xHeXUtlKTpyAQ--.15863S4
X-Coremail-Antispam: 1UD129KBjvJXoWxWry8uFW5Kw1DZw4xZr1UZFb_yoW5XFy7p3
        yFq3Zxtr4UJFW3KwsxJaykGr1rWw1jvay0yFW3u347uw13Xrn8G3yftF95Xry5AFyfC3y3
        ur1qgw4Dua4jqFUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9S14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK62vIxIIY0VWUZVW8XwA2ocxC64kIII
        0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xv
        wVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4
        x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG
        64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r
        1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAq
        YI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij64vIr41l4I8I3I0E4I
        kC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWU
        WwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr
        0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWr
        Zr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr
        1UYxBIdaVFxhVjvjDU0xZFpf9x0pRQo7tUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
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
 drivers/md/md.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 4ee4593c874a..eb3e455bcbae 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -529,6 +529,9 @@ static void md_end_flush(struct bio *bio)
 	rdev_dec_pending(rdev, mddev);
 
 	if (atomic_dec_and_test(&mddev->flush_pending)) {
+		/* The pair is percpu_ref_tryget() from md_flush_request() */
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
@@ -617,6 +615,17 @@ bool md_flush_request(struct mddev *mddev, struct bio *bio)
 	/* new request after previous flush is completed */
 	if (ktime_after(req_start, mddev->prev_flush_start)) {
 		WARN_ON(mddev->flush_bio);
+		/*
+		 * Grab a reference to make sure mddev_suspend() will wait for
+		 * this flush to be done.
+		 *
+		 * md_flush_reqeust() is called under md_handle_request() and
+		 * 'active_io' is already grabbed, hence percpu_ref_tryget()
+		 * won't fail, percpu_ref_tryget_live() can't be used because
+		 * percpu_ref_kill() can be called by mddev_suspend()
+		 * concurrently.
+		 */
+		percpu_ref_tryget(&mddev->active_io);
 		mddev->flush_bio = bio;
 		bio = NULL;
 	}
-- 
2.39.2

