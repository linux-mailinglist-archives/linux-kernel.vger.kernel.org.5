Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 742747D0F09
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 13:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377210AbjJTLqk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 07:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377216AbjJTLqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 07:46:30 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4598610E5
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 04:46:07 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C851A2F4;
        Fri, 20 Oct 2023 04:46:47 -0700 (PDT)
Received: from [192.168.1.89] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 62CC23F5A1;
        Fri, 20 Oct 2023 04:46:06 -0700 (PDT)
Message-ID: <7aab63e2-b133-49ec-ab8b-36ebec685de2@arm.com>
Date:   Fri, 20 Oct 2023 12:46:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To:     dm-devel@lists.linux.dev, agk@redhat.com, agk@redhat.com,
        linux-kernel@vger.kernel.org
From:   Christian Loehle <christian.loehle@arm.com>
Subject: [PATCHv2] dm: delay: use kthread instead of timers and wq
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current design of timers and wq to realize the delays
is insufficient especially for delays below ~50ms.
The design is enhanced with a kthread to flush the expired delays,
trading some CPU time (in some cases) for better delay accuracy and
delays closer to what the user requested for smaller delays.
The new design is chosen as long as all the delays are below 50ms.

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
Theoretical maximum: 100 IOPS
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
v2:
	- Keep the timer wq and delay design for longer delays
	- Address the rest of Mike's minor comments

 drivers/md/dm-delay.c | 106 ++++++++++++++++++++++++++++++++++++------
 1 file changed, 91 insertions(+), 15 deletions(-)

diff --git a/drivers/md/dm-delay.c b/drivers/md/dm-delay.c
index 7433525e5985..18f4adf11713 100644
--- a/drivers/md/dm-delay.c
+++ b/drivers/md/dm-delay.c
@@ -13,6 +13,7 @@
 #include <linux/blkdev.h>
 #include <linux/bio.h>
 #include <linux/slab.h>
+#include <linux/kthread.h>
 
 #include <linux/device-mapper.h>
 
@@ -31,6 +32,7 @@ struct delay_c {
 	struct workqueue_struct *kdelayd_wq;
 	struct work_struct flush_expired_bios;
 	struct list_head delayed_bios;
+	struct task_struct *worker;
 	atomic_t may_delay;
 
 	struct delay_class read;
@@ -48,6 +50,7 @@ struct dm_delay_info {
 };
 
 static DEFINE_MUTEX(delayed_bios_lock);
+static void flush_delayed_bios_fast(struct delay_c *dc, bool flush_all);
 
 static void handle_delayed_timer(struct timer_list *t)
 {
@@ -56,6 +59,27 @@ static void handle_delayed_timer(struct timer_list *t)
 	queue_work(dc->kdelayd_wq, &dc->flush_expired_bios);
 }
 
+static inline int delay_is_fast(struct delay_c *dc)
+{
+	return !!dc->worker;
+}
+
+static int flush_worker_fn(void *data)
+{
+	struct delay_c *dc = data;
+
+	while (1) {
+		flush_delayed_bios_fast(dc, 0);
+		if (unlikely(list_empty(&dc->delayed_bios))) {
+			set_current_state(TASK_INTERRUPTIBLE);
+			schedule();
+		} else
+			cond_resched();
+	}
+
+	return 0;
+}
+
 static void queue_timeout(struct delay_c *dc, unsigned long expires)
 {
 	mutex_lock(&dc->timer_lock);
@@ -66,6 +90,23 @@ static void queue_timeout(struct delay_c *dc, unsigned long expires)
 	mutex_unlock(&dc->timer_lock);
 }
 
+static void flush_delayed_bios_fast(struct delay_c *dc, bool flush_all)
+{
+	struct dm_delay_info *delayed, *next;
+
+	mutex_lock(&delayed_bios_lock);
+	list_for_each_entry_safe(delayed, next, &dc->delayed_bios, list) {
+		if (flush_all || time_after_eq(jiffies, delayed->expires)) {
+			struct bio *bio = dm_bio_from_per_bio_data(delayed,
+						sizeof(struct dm_delay_info));
+			list_del(&delayed->list);
+			dm_submit_bio_remap(bio, NULL);
+			delayed->class->ops--;
+		}
+	}
+	mutex_unlock(&delayed_bios_lock);
+}
+
 static void flush_bios(struct bio *bio)
 {
 	struct bio *n;
@@ -78,7 +119,7 @@ static void flush_bios(struct bio *bio)
 	}
 }
 
-static struct bio *flush_delayed_bios(struct delay_c *dc, int flush_all)
+static struct bio *flush_delayed_bios(struct delay_c *dc, bool flush_all)
 {
 	struct dm_delay_info *delayed, *next;
 	unsigned long next_expires = 0;
@@ -93,7 +134,6 @@ static struct bio *flush_delayed_bios(struct delay_c *dc, int flush_all)
 			list_del(&delayed->list);
 			bio_list_add(&flush_bios, bio);
 			delayed->class->ops--;
-			continue;
 		}
 
 		if (!start_timer) {
@@ -110,12 +150,17 @@ static struct bio *flush_delayed_bios(struct delay_c *dc, int flush_all)
 	return bio_list_get(&flush_bios);
 }
 
+
+
 static void flush_expired_bios(struct work_struct *work)
 {
 	struct delay_c *dc;
 
 	dc = container_of(work, struct delay_c, flush_expired_bios);
-	flush_bios(flush_delayed_bios(dc, 0));
+	if (delay_is_fast(dc))
+		flush_delayed_bios_fast(dc, 0);
+	else
+		flush_bios(flush_delayed_bios(dc, 0));
 }
 
 static void delay_dtr(struct dm_target *ti)
@@ -131,8 +176,11 @@ static void delay_dtr(struct dm_target *ti)
 		dm_put_device(ti, dc->write.dev);
 	if (dc->flush.dev)
 		dm_put_device(ti, dc->flush.dev);
+	if (dc->worker)
+		kthread_stop(dc->worker);
 
-	mutex_destroy(&dc->timer_lock);
+	if (!delay_is_fast(dc))
+		mutex_destroy(&dc->timer_lock);
 
 	kfree(dc);
 }
@@ -175,6 +223,7 @@ static int delay_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 {
 	struct delay_c *dc;
 	int ret;
+	unsigned int max_delay;
 
 	if (argc != 3 && argc != 6 && argc != 9) {
 		ti->error = "Requires exactly 3, 6 or 9 arguments";
@@ -188,16 +237,14 @@ static int delay_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 	}
 
 	ti->private = dc;
-	timer_setup(&dc->delay_timer, handle_delayed_timer, 0);
-	INIT_WORK(&dc->flush_expired_bios, flush_expired_bios);
 	INIT_LIST_HEAD(&dc->delayed_bios);
-	mutex_init(&dc->timer_lock);
 	atomic_set(&dc->may_delay, 1);
 	dc->argc = argc;
 
 	ret = delay_class_ctr(ti, &dc->read, argv);
 	if (ret)
 		goto bad;
+	max_delay = dc->read.delay;
 
 	if (argc == 3) {
 		ret = delay_class_ctr(ti, &dc->write, argv);
@@ -206,6 +253,10 @@ static int delay_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 		ret = delay_class_ctr(ti, &dc->flush, argv);
 		if (ret)
 			goto bad;
+		if (max_delay < dc->write.delay)
+			max_delay = dc->write.delay;
+		if (max_delay < dc->flush.delay)
+			max_delay = dc->flush.delay;
 		goto out;
 	}
 
@@ -216,19 +267,36 @@ static int delay_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 		ret = delay_class_ctr(ti, &dc->flush, argv + 3);
 		if (ret)
 			goto bad;
+		if (max_delay < dc->flush.delay)
+			max_delay = dc->flush.delay;
 		goto out;
 	}
 
 	ret = delay_class_ctr(ti, &dc->flush, argv + 6);
 	if (ret)
 		goto bad;
+	if (max_delay < dc->flush.delay)
+		max_delay = dc->flush.delay;
 
 out:
-	dc->kdelayd_wq = alloc_workqueue("kdelayd", WQ_MEM_RECLAIM, 0);
-	if (!dc->kdelayd_wq) {
-		ret = -EINVAL;
-		DMERR("Couldn't start kdelayd");
-		goto bad;
+	if (max_delay < 50) {
+		/*
+		 * In case of small requested delays, use kthread instead of
+		 * timers and workqueue to achieve better latency.
+		 */
+		dc->worker = kthread_create(&flush_worker_fn, dc,
+				"dm-delay-flush-worker");
+		if (!dc->worker)
+			goto bad;
+	} else {
+		INIT_WORK(&dc->flush_expired_bios, flush_expired_bios);
+		timer_setup(&dc->delay_timer, handle_delayed_timer, 0);
+		dc->kdelayd_wq = alloc_workqueue("kdelayd", WQ_MEM_RECLAIM, 0);
+		if (!dc->kdelayd_wq) {
+			ret = -EINVAL;
+			DMERR("Couldn't start kdelayd");
+			goto bad;
+		}
 	}
 
 	ti->num_flush_bios = 1;
@@ -260,7 +328,10 @@ static int delay_bio(struct delay_c *dc, struct delay_class *c, struct bio *bio)
 	list_add_tail(&delayed->list, &dc->delayed_bios);
 	mutex_unlock(&delayed_bios_lock);
 
-	queue_timeout(dc, expires);
+	if (delay_is_fast(dc))
+		wake_up_process(dc->worker);
+	else
+		queue_timeout(dc, expires);
 
 	return DM_MAPIO_SUBMITTED;
 }
@@ -270,8 +341,13 @@ static void delay_presuspend(struct dm_target *ti)
 	struct delay_c *dc = ti->private;
 
 	atomic_set(&dc->may_delay, 0);
-	del_timer_sync(&dc->delay_timer);
-	flush_bios(flush_delayed_bios(dc, 1));
+
+	if (delay_is_fast(dc))
+		flush_delayed_bios_fast(dc, 1);
+	else {
+		del_timer_sync(&dc->delay_timer);
+		flush_bios(flush_delayed_bios(dc, 1));
+	}
 }
 
 static void delay_resume(struct dm_target *ti)
-- 
2.34.1
