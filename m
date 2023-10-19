Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B52A7CF68C
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 13:21:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345331AbjJSLVW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 07:21:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233051AbjJSLVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 07:21:21 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 771EABE
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 04:21:18 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BE4452F4;
        Thu, 19 Oct 2023 04:21:58 -0700 (PDT)
Received: from [10.57.35.228] (unknown [10.57.35.228])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 14CC43F762;
        Thu, 19 Oct 2023 04:21:15 -0700 (PDT)
Message-ID: <d90adee6-0b7f-4658-8eb3-84ad38d6ab93@arm.com>
Date:   Thu, 19 Oct 2023 12:21:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To:     agk@redhat.com, snitzer@kernel.org, dm-devel@lists.linux.dev,
        linux-kernel@vger.kernel.org
From:   Christian Loehle <christian.loehle@arm.com>
Subject: [PATCH] dm: delay: use kthread instead of timers and wq
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current design of timers and wq to realize the delays
is insufficient especially for delays below ~50ms.
The design is replaced with a kthread to flush the expired delays,
trading some CPU time (in some cases) for better delay accuracy and
delays closer to what the user requested for smaller delays.

Since bios can't be completed in interrupt context using a kthread
is probably the most reasonable way to approach this.

Testing with
echo "0 2097152 zero" | dmsetup create dm-zeros
for i in $(seq 0 20);
do
  echo "0 2097152 delay /dev/mapper/dm-zeros 0 $i" | dmsetup create dm-delay-${i}ms;
done

Some performance numbers for comparison
beaglebone black (single core) CONFIG_HZ_1000=y:
fio --name=1msread --rw=randread --bs=4k --runtime=60 --time_based --filename=/dev/mapper/dm-delay-1ms
Theoretical maximum: 1000 IOPS
Previous: 250 IOPS
Kthread: 500 IOPS
fio --name=10msread --rw=randread --bs=4k --runtime=60 --time_based --filename=/dev/mapper/dm-delay-10ms
Theoretical maximum: 1000 IOPS
Previous: 45 IOPS
Kthread: 50 IOPS
fio --name=1mswrite --rw=randwrite --direct=1 --bs=4k --runtime=60 --time_based --filename=/dev/mapper/dm-delay-1ms
Theoretical maximum: 1000 IOPS
Previous: 498 IOPS
Kthread: 1000 IOPS
fio --name=10mswrite --rw=randwrite --direct=1 --bs=4k --runtime=60 --time_based --filename=/dev/mapper/dm-delay-10ms
Theoretical maximum: 100 IOPS
Previous: 90 IOPS
Kthread: 100 IOPS
fio --name=10mswriteasync --rw=randwrite --direct=1 --bs=4k --runtime=60 --time_based --filename=/dev/mapper/dm-delay-10ms --numjobs=32 --iodepth=64 --ioengine=libaio --group_reporting
Previous: 13.3k IOPS
Kthread: 13.3k IOPS
(This one is just to prove the new design isn't impacting throughput,
not really about delays)

Signed-off-by: Christian Loehle <christian.loehle@arm.com>
---
 drivers/md/dm-delay.c | 83 ++++++++++++-------------------------------
 1 file changed, 22 insertions(+), 61 deletions(-)

diff --git a/drivers/md/dm-delay.c b/drivers/md/dm-delay.c
index 7433525e5985..a37f28294f7e 100644
--- a/drivers/md/dm-delay.c
+++ b/drivers/md/dm-delay.c
@@ -13,6 +13,7 @@
 #include <linux/blkdev.h>
 #include <linux/bio.h>
 #include <linux/slab.h>
+#include <linux/kthread.h>
 
 #include <linux/device-mapper.h>
 
@@ -26,11 +27,9 @@ struct delay_class {
 };
 
 struct delay_c {
-	struct timer_list delay_timer;
-	struct mutex timer_lock;
-	struct workqueue_struct *kdelayd_wq;
 	struct work_struct flush_expired_bios;
 	struct list_head delayed_bios;
+	struct task_struct *worker;
 	atomic_t may_delay;
 
 	struct delay_class read;
@@ -48,42 +47,25 @@ struct dm_delay_info {
 };
 
 static DEFINE_MUTEX(delayed_bios_lock);
+static void flush_delayed_bios(struct delay_c *dc, int flush_all);
 
-static void handle_delayed_timer(struct timer_list *t)
+static int flush_worker_fn(void *data)
 {
-	struct delay_c *dc = from_timer(dc, t, delay_timer);
+	struct delay_c *dc = (struct delay_c *)data;
 
-	queue_work(dc->kdelayd_wq, &dc->flush_expired_bios);
-}
-
-static void queue_timeout(struct delay_c *dc, unsigned long expires)
-{
-	mutex_lock(&dc->timer_lock);
-
-	if (!timer_pending(&dc->delay_timer) || expires < dc->delay_timer.expires)
-		mod_timer(&dc->delay_timer, expires);
-
-	mutex_unlock(&dc->timer_lock);
-}
-
-static void flush_bios(struct bio *bio)
-{
-	struct bio *n;
-
-	while (bio) {
-		n = bio->bi_next;
-		bio->bi_next = NULL;
-		dm_submit_bio_remap(bio, NULL);
-		bio = n;
+	while (1) {
+		flush_delayed_bios(dc, 0);
+		if (unlikely(list_empty(&dc->delayed_bios)))
+			set_current_state(TASK_INTERRUPTIBLE);
+		schedule();
 	}
+
+	return 0;
 }
 
-static struct bio *flush_delayed_bios(struct delay_c *dc, int flush_all)
+static void flush_delayed_bios(struct delay_c *dc, int flush_all)
 {
 	struct dm_delay_info *delayed, *next;
-	unsigned long next_expires = 0;
-	unsigned long start_timer = 0;
-	struct bio_list flush_bios = { };
 
 	mutex_lock(&delayed_bios_lock);
 	list_for_each_entry_safe(delayed, next, &dc->delayed_bios, list) {
@@ -91,23 +73,12 @@ static struct bio *flush_delayed_bios(struct delay_c *dc, int flush_all)
 			struct bio *bio = dm_bio_from_per_bio_data(delayed,
 						sizeof(struct dm_delay_info));
 			list_del(&delayed->list);
-			bio_list_add(&flush_bios, bio);
+			dm_submit_bio_remap(bio, NULL);
 			delayed->class->ops--;
-			continue;
 		}
-
-		if (!start_timer) {
-			start_timer = 1;
-			next_expires = delayed->expires;
-		} else
-			next_expires = min(next_expires, delayed->expires);
 	}
 	mutex_unlock(&delayed_bios_lock);
 
-	if (start_timer)
-		queue_timeout(dc, next_expires);
-
-	return bio_list_get(&flush_bios);
 }
 
 static void flush_expired_bios(struct work_struct *work)
@@ -115,24 +86,21 @@ static void flush_expired_bios(struct work_struct *work)
 	struct delay_c *dc;
 
 	dc = container_of(work, struct delay_c, flush_expired_bios);
-	flush_bios(flush_delayed_bios(dc, 0));
+	flush_delayed_bios(dc, 0);
 }
 
 static void delay_dtr(struct dm_target *ti)
 {
 	struct delay_c *dc = ti->private;
 
-	if (dc->kdelayd_wq)
-		destroy_workqueue(dc->kdelayd_wq);
-
 	if (dc->read.dev)
 		dm_put_device(ti, dc->read.dev);
 	if (dc->write.dev)
 		dm_put_device(ti, dc->write.dev);
 	if (dc->flush.dev)
 		dm_put_device(ti, dc->flush.dev);
-
-	mutex_destroy(&dc->timer_lock);
+	if (dc->worker)
+		kthread_stop(dc->worker);
 
 	kfree(dc);
 }
@@ -188,10 +156,11 @@ static int delay_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 	}
 
 	ti->private = dc;
-	timer_setup(&dc->delay_timer, handle_delayed_timer, 0);
 	INIT_WORK(&dc->flush_expired_bios, flush_expired_bios);
 	INIT_LIST_HEAD(&dc->delayed_bios);
-	mutex_init(&dc->timer_lock);
+	dc->worker = kthread_create(&flush_worker_fn, dc, "dm-delay-flush-worker");
+	if (!dc->worker)
+		goto bad;
 	atomic_set(&dc->may_delay, 1);
 	dc->argc = argc;
 
@@ -224,13 +193,6 @@ static int delay_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 		goto bad;
 
 out:
-	dc->kdelayd_wq = alloc_workqueue("kdelayd", WQ_MEM_RECLAIM, 0);
-	if (!dc->kdelayd_wq) {
-		ret = -EINVAL;
-		DMERR("Couldn't start kdelayd");
-		goto bad;
-	}
-
 	ti->num_flush_bios = 1;
 	ti->num_discard_bios = 1;
 	ti->accounts_remapped_io = true;
@@ -260,7 +222,7 @@ static int delay_bio(struct delay_c *dc, struct delay_class *c, struct bio *bio)
 	list_add_tail(&delayed->list, &dc->delayed_bios);
 	mutex_unlock(&delayed_bios_lock);
 
-	queue_timeout(dc, expires);
+	wake_up_process(dc->worker);
 
 	return DM_MAPIO_SUBMITTED;
 }
@@ -270,8 +232,7 @@ static void delay_presuspend(struct dm_target *ti)
 	struct delay_c *dc = ti->private;
 
 	atomic_set(&dc->may_delay, 0);
-	del_timer_sync(&dc->delay_timer);
-	flush_bios(flush_delayed_bios(dc, 1));
+	flush_delayed_bios(dc, 1);
 }
 
 static void delay_resume(struct dm_target *ti)
-- 
2.34.1

