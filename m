Return-Path: <linux-kernel+bounces-101926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5D1987ACC7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:17:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DC3F1C20AC0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 972B912D74F;
	Wed, 13 Mar 2024 16:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jeDxtCCU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A2212CDAC;
	Wed, 13 Mar 2024 16:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348068; cv=none; b=Yi+3c6jwggTitsXxB3baElHqN3LqH6yFibDjjKFfX4usuRufG5lQAieE2ndKpCws+jmEBGYsUCqz1yPc06RF6fws8JufeTIgexmvYL4zrSmnXn0KBVh9emeQd16YusUkSsoPQYJ4hXGCh9U//Cre0EJU3x3+F1UpGo5K2efZ2Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348068; c=relaxed/simple;
	bh=c2aIatCguzaQk8xaax3bneRSs0ZkDIlGzeM4Yi73sMg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aaRhAA3T/ZHpNnUNrSWGGBIDLSgFnzOPZOrRREcIs11xG2ZSvgkqSo2JyOEHcIr3sSaq8AA97kM39MAsMtueNPWLaIicuxf2KxGJ8IIZZ+rfpOFn6tB3l7BiP7go1EH9JmkdG5bxwOOKnPQeJ+4Dt3wZWU7gFjXlpa9JnbyTsu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jeDxtCCU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64A51C43394;
	Wed, 13 Mar 2024 16:41:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710348068;
	bh=c2aIatCguzaQk8xaax3bneRSs0ZkDIlGzeM4Yi73sMg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jeDxtCCUpQBJTgFe4zu7KAAQ/AhfgiOg1ifmHIfhMXKTYJb+uS654Rh4kB0XsI8zK
	 eaiZRSQ5i8+rsYjdDmiHe0tr46R2wDq8UQ5UTIeYgEPBAgAtfujd48s5ZKSuyjNQgu
	 Q14AY/bIpqgOSMz5boZU0lfOu4319MyZQl6e+jQaGMnqu/H+GWlT8m3MX8SWc5JTCB
	 QOJOn0sS280pHz8vJxuMyYD03nPp1AlIJRSRyyePDtvhkCyHxQPebPG1pXAnZaP2JY
	 IzUVXr3TCqcvhgqf0wfGG6CJZrwyqaIELTQWIVbo6G9ZGDcNYODli5VY9kRyVXJrKR
	 z8vlGFpEqF2eg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	Andreas Herrmann <aherrmann@suse.de>,
	Tejun Heo <tj@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 58/71] blk-rq-qos: store a gendisk instead of request_queue in struct rq_qos
Date: Wed, 13 Mar 2024 12:39:44 -0400
Message-ID: <20240313163957.615276-59-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313163957.615276-1-sashal@kernel.org>
References: <20240313163957.615276-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.82-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.1.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.1.82-rc1
X-KernelTest-Deadline: 2024-03-15T16:39+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Christoph Hellwig <hch@lst.de>

[ Upstream commit ba91c849fa50dbc6519cf7808177b3a9b7f6bc97 ]

This is what about half of the users already want, and it's only going to
grow more.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Andreas Herrmann <aherrmann@suse.de>
Acked-by: Tejun Heo <tj@kernel.org>
Link: https://lore.kernel.org/r/20230203150400.3199230-16-hch@lst.de
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Stable-dep-of: f814bdda774c ("blk-wbt: Fix detection of dirty-throttled tasks")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/blk-iocost.c     | 12 ++++++------
 block/blk-iolatency.c  | 14 +++++++-------
 block/blk-mq-debugfs.c | 10 ++++------
 block/blk-rq-qos.c     |  4 ++--
 block/blk-rq-qos.h     |  2 +-
 block/blk-wbt.c        | 16 +++++++---------
 6 files changed, 27 insertions(+), 31 deletions(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 78958c5bece08..ab5830ba23e0f 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -670,7 +670,7 @@ static struct ioc *q_to_ioc(struct request_queue *q)
 
 static const char __maybe_unused *ioc_name(struct ioc *ioc)
 {
-	struct gendisk *disk = ioc->rqos.q->disk;
+	struct gendisk *disk = ioc->rqos.disk;
 
 	if (!disk)
 		return "<unknown>";
@@ -809,11 +809,11 @@ static int ioc_autop_idx(struct ioc *ioc)
 	u64 now_ns;
 
 	/* rotational? */
-	if (!blk_queue_nonrot(ioc->rqos.q))
+	if (!blk_queue_nonrot(ioc->rqos.disk->queue))
 		return AUTOP_HDD;
 
 	/* handle SATA SSDs w/ broken NCQ */
-	if (blk_queue_depth(ioc->rqos.q) == 1)
+	if (blk_queue_depth(ioc->rqos.disk->queue) == 1)
 		return AUTOP_SSD_QD1;
 
 	/* use one of the normal ssd sets */
@@ -2653,7 +2653,7 @@ static void ioc_rqos_throttle(struct rq_qos *rqos, struct bio *bio)
 	if (use_debt) {
 		iocg_incur_debt(iocg, abs_cost, &now);
 		if (iocg_kick_delay(iocg, &now))
-			blkcg_schedule_throttle(rqos->q->disk,
+			blkcg_schedule_throttle(rqos->disk,
 					(bio->bi_opf & REQ_SWAP) == REQ_SWAP);
 		iocg_unlock(iocg, ioc_locked, &flags);
 		return;
@@ -2754,7 +2754,7 @@ static void ioc_rqos_merge(struct rq_qos *rqos, struct request *rq,
 	if (likely(!list_empty(&iocg->active_list))) {
 		iocg_incur_debt(iocg, abs_cost, &now);
 		if (iocg_kick_delay(iocg, &now))
-			blkcg_schedule_throttle(rqos->q->disk,
+			blkcg_schedule_throttle(rqos->disk,
 					(bio->bi_opf & REQ_SWAP) == REQ_SWAP);
 	} else {
 		iocg_commit_bio(iocg, bio, abs_cost, cost);
@@ -2825,7 +2825,7 @@ static void ioc_rqos_exit(struct rq_qos *rqos)
 {
 	struct ioc *ioc = rqos_to_ioc(rqos);
 
-	blkcg_deactivate_policy(rqos->q, &blkcg_policy_iocost);
+	blkcg_deactivate_policy(rqos->disk->queue, &blkcg_policy_iocost);
 
 	spin_lock_irq(&ioc->lock);
 	ioc->running = IOC_STOP;
diff --git a/block/blk-iolatency.c b/block/blk-iolatency.c
index b0f8550f87cd2..268e6653b5a62 100644
--- a/block/blk-iolatency.c
+++ b/block/blk-iolatency.c
@@ -292,7 +292,7 @@ static void __blkcg_iolatency_throttle(struct rq_qos *rqos,
 	unsigned use_delay = atomic_read(&lat_to_blkg(iolat)->use_delay);
 
 	if (use_delay)
-		blkcg_schedule_throttle(rqos->q->disk, use_memdelay);
+		blkcg_schedule_throttle(rqos->disk, use_memdelay);
 
 	/*
 	 * To avoid priority inversions we want to just take a slot if we are
@@ -330,7 +330,7 @@ static void scale_cookie_change(struct blk_iolatency *blkiolat,
 				struct child_latency_info *lat_info,
 				bool up)
 {
-	unsigned long qd = blkiolat->rqos.q->nr_requests;
+	unsigned long qd = blkiolat->rqos.disk->queue->nr_requests;
 	unsigned long scale = scale_amount(qd, up);
 	unsigned long old = atomic_read(&lat_info->scale_cookie);
 	unsigned long max_scale = qd << 1;
@@ -370,7 +370,7 @@ static void scale_cookie_change(struct blk_iolatency *blkiolat,
  */
 static void scale_change(struct iolatency_grp *iolat, bool up)
 {
-	unsigned long qd = iolat->blkiolat->rqos.q->nr_requests;
+	unsigned long qd = iolat->blkiolat->rqos.disk->queue->nr_requests;
 	unsigned long scale = scale_amount(qd, up);
 	unsigned long old = iolat->rq_depth.max_depth;
 
@@ -647,7 +647,7 @@ static void blkcg_iolatency_exit(struct rq_qos *rqos)
 
 	del_timer_sync(&blkiolat->timer);
 	flush_work(&blkiolat->enable_work);
-	blkcg_deactivate_policy(rqos->q, &blkcg_policy_iolatency);
+	blkcg_deactivate_policy(rqos->disk->queue, &blkcg_policy_iolatency);
 	kfree(blkiolat);
 }
 
@@ -666,7 +666,7 @@ static void blkiolatency_timer_fn(struct timer_list *t)
 
 	rcu_read_lock();
 	blkg_for_each_descendant_pre(blkg, pos_css,
-				     blkiolat->rqos.q->root_blkg) {
+				     blkiolat->rqos.disk->queue->root_blkg) {
 		struct iolatency_grp *iolat;
 		struct child_latency_info *lat_info;
 		unsigned long flags;
@@ -750,9 +750,9 @@ static void blkiolatency_enable_work_fn(struct work_struct *work)
 	 */
 	enabled = atomic_read(&blkiolat->enable_cnt);
 	if (enabled != blkiolat->enabled) {
-		blk_mq_freeze_queue(blkiolat->rqos.q);
+		blk_mq_freeze_queue(blkiolat->rqos.disk->queue);
 		blkiolat->enabled = enabled;
-		blk_mq_unfreeze_queue(blkiolat->rqos.q);
+		blk_mq_unfreeze_queue(blkiolat->rqos.disk->queue);
 	}
 }
 
diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 7675e663df365..c152276736832 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -813,9 +813,9 @@ static const char *rq_qos_id_to_name(enum rq_qos_id id)
 
 void blk_mq_debugfs_unregister_rqos(struct rq_qos *rqos)
 {
-	lockdep_assert_held(&rqos->q->debugfs_mutex);
+	lockdep_assert_held(&rqos->disk->queue->debugfs_mutex);
 
-	if (!rqos->q->debugfs_dir)
+	if (!rqos->disk->queue->debugfs_dir)
 		return;
 	debugfs_remove_recursive(rqos->debugfs_dir);
 	rqos->debugfs_dir = NULL;
@@ -823,7 +823,7 @@ void blk_mq_debugfs_unregister_rqos(struct rq_qos *rqos)
 
 void blk_mq_debugfs_register_rqos(struct rq_qos *rqos)
 {
-	struct request_queue *q = rqos->q;
+	struct request_queue *q = rqos->disk->queue;
 	const char *dir_name = rq_qos_id_to_name(rqos->id);
 
 	lockdep_assert_held(&q->debugfs_mutex);
@@ -835,9 +835,7 @@ void blk_mq_debugfs_register_rqos(struct rq_qos *rqos)
 		q->rqos_debugfs_dir = debugfs_create_dir("rqos",
 							 q->debugfs_dir);
 
-	rqos->debugfs_dir = debugfs_create_dir(dir_name,
-					       rqos->q->rqos_debugfs_dir);
-
+	rqos->debugfs_dir = debugfs_create_dir(dir_name, q->rqos_debugfs_dir);
 	debugfs_create_files(rqos->debugfs_dir, rqos, rqos->ops->debugfs_attrs);
 }
 
diff --git a/block/blk-rq-qos.c b/block/blk-rq-qos.c
index 8e83734cfe8db..d8cc820a365e3 100644
--- a/block/blk-rq-qos.c
+++ b/block/blk-rq-qos.c
@@ -300,7 +300,7 @@ int rq_qos_add(struct rq_qos *rqos, struct gendisk *disk, enum rq_qos_id id,
 {
 	struct request_queue *q = disk->queue;
 
-	rqos->q = q;
+	rqos->disk = disk;
 	rqos->id = id;
 	rqos->ops = ops;
 
@@ -337,7 +337,7 @@ int rq_qos_add(struct rq_qos *rqos, struct gendisk *disk, enum rq_qos_id id,
 
 void rq_qos_del(struct rq_qos *rqos)
 {
-	struct request_queue *q = rqos->q;
+	struct request_queue *q = rqos->disk->queue;
 	struct rq_qos **cur;
 
 	/*
diff --git a/block/blk-rq-qos.h b/block/blk-rq-qos.h
index 2b7b668479f71..b02a1a3d33a89 100644
--- a/block/blk-rq-qos.h
+++ b/block/blk-rq-qos.h
@@ -26,7 +26,7 @@ struct rq_wait {
 
 struct rq_qos {
 	const struct rq_qos_ops *ops;
-	struct request_queue *q;
+	struct gendisk *disk;
 	enum rq_qos_id id;
 	struct rq_qos *next;
 #ifdef CONFIG_BLK_DEBUG_FS
diff --git a/block/blk-wbt.c b/block/blk-wbt.c
index d9398347b08d8..e9206b1406e76 100644
--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -98,7 +98,7 @@ static void wb_timestamp(struct rq_wb *rwb, unsigned long *var)
  */
 static bool wb_recent_wait(struct rq_wb *rwb)
 {
-	struct bdi_writeback *wb = &rwb->rqos.q->disk->bdi->wb;
+	struct bdi_writeback *wb = &rwb->rqos.disk->bdi->wb;
 
 	return time_before(jiffies, wb->dirty_sleep + HZ);
 }
@@ -235,7 +235,7 @@ enum {
 
 static int latency_exceeded(struct rq_wb *rwb, struct blk_rq_stat *stat)
 {
-	struct backing_dev_info *bdi = rwb->rqos.q->disk->bdi;
+	struct backing_dev_info *bdi = rwb->rqos.disk->bdi;
 	struct rq_depth *rqd = &rwb->rq_depth;
 	u64 thislat;
 
@@ -288,7 +288,7 @@ static int latency_exceeded(struct rq_wb *rwb, struct blk_rq_stat *stat)
 
 static void rwb_trace_step(struct rq_wb *rwb, const char *msg)
 {
-	struct backing_dev_info *bdi = rwb->rqos.q->disk->bdi;
+	struct backing_dev_info *bdi = rwb->rqos.disk->bdi;
 	struct rq_depth *rqd = &rwb->rq_depth;
 
 	trace_wbt_step(bdi, msg, rqd->scale_step, rwb->cur_win_nsec,
@@ -358,13 +358,12 @@ static void wb_timer_fn(struct blk_stat_callback *cb)
 	unsigned int inflight = wbt_inflight(rwb);
 	int status;
 
-	if (!rwb->rqos.q->disk)
+	if (!rwb->rqos.disk)
 		return;
 
 	status = latency_exceeded(rwb, cb->stat);
 
-	trace_wbt_timer(rwb->rqos.q->disk->bdi, status, rqd->scale_step,
-			inflight);
+	trace_wbt_timer(rwb->rqos.disk->bdi, status, rqd->scale_step, inflight);
 
 	/*
 	 * If we exceeded the latency target, step down. If we did not,
@@ -689,16 +688,15 @@ static int wbt_data_dir(const struct request *rq)
 
 static void wbt_queue_depth_changed(struct rq_qos *rqos)
 {
-	RQWB(rqos)->rq_depth.queue_depth = blk_queue_depth(rqos->q);
+	RQWB(rqos)->rq_depth.queue_depth = blk_queue_depth(rqos->disk->queue);
 	wbt_update_limits(RQWB(rqos));
 }
 
 static void wbt_exit(struct rq_qos *rqos)
 {
 	struct rq_wb *rwb = RQWB(rqos);
-	struct request_queue *q = rqos->q;
 
-	blk_stat_remove_callback(q, rwb->cb);
+	blk_stat_remove_callback(rqos->disk->queue, rwb->cb);
 	blk_stat_free_callback(rwb->cb);
 	kfree(rwb);
 }
-- 
2.43.0


