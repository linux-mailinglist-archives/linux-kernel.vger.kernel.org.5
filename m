Return-Path: <linux-kernel+bounces-101924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7921687ACC2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:16:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AB591C20A9E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AE7012CD86;
	Wed, 13 Mar 2024 16:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="slxCIAAB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3A412C7FE;
	Wed, 13 Mar 2024 16:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348066; cv=none; b=KJSWsiqzYQPwBumNRv/ka2GI/Rswof7heI0vimDd/ZJt9DP/ufoq9U+Ga40Zg4x/pcVg5gg++gRtNUmp2gQNqBdINkJbmKgMGPk66q6SQyGjT0zSBt/iTRxJH0MJDMl4oIVKe4ZxGr9W+NJkO5m9Kgo6DJ2lPF+3bpnq44Y/T54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348066; c=relaxed/simple;
	bh=eiAD2CvC4DIoiFY8zwzWQKEdhagd4ZgfVOxBR0skl5s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ty3zfupvkdVtuDAnzu5wCFYgcgvgqffMp+jIxh7kZt5Ob9kRsYxrwgXu99QnQwhdUMlOIP0gbdvhADHvICHmwfIyglagJCKvT+dfuv9fxRWJL83xIjVqx7u+dBhus4bJlpOC8f/f0IN2ynQHp/MoY2PExqp7ZKnNEyKY5aNao64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=slxCIAAB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1370C43394;
	Wed, 13 Mar 2024 16:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710348065;
	bh=eiAD2CvC4DIoiFY8zwzWQKEdhagd4ZgfVOxBR0skl5s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=slxCIAAB4xurQLP2erClfPzQga5DAwxnLsNUWE4RznAGfEOZnJhwkiaxQtukV4P16
	 M1XRrVIQUy0NAFU1opke79HK1p02dDzIDaCGFIaRlKYEg3ZC27+cVsBMlau8L2w4YB
	 JPhGUklZSFzJdjbzTs6f3suF75AtpZYVg2tkSfmZEhit64x9N7lT0lcRwtP3ezX6AD
	 DRbriNfi7mboHv+qb+FPLVyXeEloDyN+2o6wVh2gOsAb72eRPvZknnPpb5GIR/1YHF
	 06iPC4GHydErRJkbbhr8LZqAmy4fSgX0c+NAVjQSuzbZjuAamklA3OI7tFVcs36QKj
	 TxcCmO+MzG2Jw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	Andreas Herrmann <aherrmann@suse.de>,
	Tejun Heo <tj@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 56/71] blk-rq-qos: make rq_qos_add and rq_qos_del more useful
Date: Wed, 13 Mar 2024 12:39:42 -0400
Message-ID: <20240313163957.615276-57-sashal@kernel.org>
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

[ Upstream commit ce57b558604e68277d31ca5ce49ec4579a8618c5 ]

Switch to passing a gendisk, and make rq_qos_add initialize all required
fields and drop the not required q argument from rq_qos_del.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Andreas Herrmann <aherrmann@suse.de>
Acked-by: Tejun Heo <tj@kernel.org>
Link: https://lore.kernel.org/r/20230203150400.3199230-14-hch@lst.de
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Stable-dep-of: f814bdda774c ("blk-wbt: Fix detection of dirty-throttled tasks")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/blk-iocost.c    | 13 +++----------
 block/blk-iolatency.c | 14 ++++----------
 block/blk-rq-qos.c    | 13 ++++++++++---
 block/blk-rq-qos.h    |  5 +++--
 block/blk-wbt.c       |  5 +----
 5 files changed, 21 insertions(+), 29 deletions(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 72ca07f24b3c0..a8a7d2ce927b9 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -2847,9 +2847,7 @@ static struct rq_qos_ops ioc_rqos_ops = {
 
 static int blk_iocost_init(struct gendisk *disk)
 {
-	struct request_queue *q = disk->queue;
 	struct ioc *ioc;
-	struct rq_qos *rqos;
 	int i, cpu, ret;
 
 	ioc = kzalloc(sizeof(*ioc), GFP_KERNEL);
@@ -2872,11 +2870,6 @@ static int blk_iocost_init(struct gendisk *disk)
 		local64_set(&ccs->rq_wait_ns, 0);
 	}
 
-	rqos = &ioc->rqos;
-	rqos->id = RQ_QOS_COST;
-	rqos->ops = &ioc_rqos_ops;
-	rqos->q = q;
-
 	spin_lock_init(&ioc->lock);
 	timer_setup(&ioc->timer, ioc_timer_fn, 0);
 	INIT_LIST_HEAD(&ioc->active_iocgs);
@@ -2900,17 +2893,17 @@ static int blk_iocost_init(struct gendisk *disk)
 	 * called before policy activation completion, can't assume that the
 	 * target bio has an iocg associated and need to test for NULL iocg.
 	 */
-	ret = rq_qos_add(q, rqos);
+	ret = rq_qos_add(&ioc->rqos, disk, RQ_QOS_COST, &ioc_rqos_ops);
 	if (ret)
 		goto err_free_ioc;
 
-	ret = blkcg_activate_policy(q, &blkcg_policy_iocost);
+	ret = blkcg_activate_policy(disk->queue, &blkcg_policy_iocost);
 	if (ret)
 		goto err_del_qos;
 	return 0;
 
 err_del_qos:
-	rq_qos_del(q, rqos);
+	rq_qos_del(&ioc->rqos);
 err_free_ioc:
 	free_percpu(ioc->pcpu_stat);
 	kfree(ioc);
diff --git a/block/blk-iolatency.c b/block/blk-iolatency.c
index 571fa95aafe96..c64cfec34ac37 100644
--- a/block/blk-iolatency.c
+++ b/block/blk-iolatency.c
@@ -758,24 +758,18 @@ static void blkiolatency_enable_work_fn(struct work_struct *work)
 
 int blk_iolatency_init(struct gendisk *disk)
 {
-	struct request_queue *q = disk->queue;
 	struct blk_iolatency *blkiolat;
-	struct rq_qos *rqos;
 	int ret;
 
 	blkiolat = kzalloc(sizeof(*blkiolat), GFP_KERNEL);
 	if (!blkiolat)
 		return -ENOMEM;
 
-	rqos = &blkiolat->rqos;
-	rqos->id = RQ_QOS_LATENCY;
-	rqos->ops = &blkcg_iolatency_ops;
-	rqos->q = q;
-
-	ret = rq_qos_add(q, rqos);
+	ret = rq_qos_add(&blkiolat->rqos, disk, RQ_QOS_LATENCY,
+			 &blkcg_iolatency_ops);
 	if (ret)
 		goto err_free;
-	ret = blkcg_activate_policy(q, &blkcg_policy_iolatency);
+	ret = blkcg_activate_policy(disk->queue, &blkcg_policy_iolatency);
 	if (ret)
 		goto err_qos_del;
 
@@ -785,7 +779,7 @@ int blk_iolatency_init(struct gendisk *disk)
 	return 0;
 
 err_qos_del:
-	rq_qos_del(q, rqos);
+	rq_qos_del(&blkiolat->rqos);
 err_free:
 	kfree(blkiolat);
 	return ret;
diff --git a/block/blk-rq-qos.c b/block/blk-rq-qos.c
index aae98dcb01ebe..14bee1bd76136 100644
--- a/block/blk-rq-qos.c
+++ b/block/blk-rq-qos.c
@@ -295,8 +295,15 @@ void rq_qos_exit(struct request_queue *q)
 	}
 }
 
-int rq_qos_add(struct request_queue *q, struct rq_qos *rqos)
+int rq_qos_add(struct rq_qos *rqos, struct gendisk *disk, enum rq_qos_id id,
+		struct rq_qos_ops *ops)
 {
+	struct request_queue *q = disk->queue;
+
+	rqos->q = q;
+	rqos->id = id;
+	rqos->ops = ops;
+
 	/*
 	 * No IO can be in-flight when adding rqos, so freeze queue, which
 	 * is fine since we only support rq_qos for blk-mq queue.
@@ -326,11 +333,11 @@ int rq_qos_add(struct request_queue *q, struct rq_qos *rqos)
 	spin_unlock_irq(&q->queue_lock);
 	blk_mq_unfreeze_queue(q);
 	return -EBUSY;
-
 }
 
-void rq_qos_del(struct request_queue *q, struct rq_qos *rqos)
+void rq_qos_del(struct rq_qos *rqos)
 {
+	struct request_queue *q = rqos->q;
 	struct rq_qos **cur;
 
 	/*
diff --git a/block/blk-rq-qos.h b/block/blk-rq-qos.h
index 805eee8b031d0..22552785aa31e 100644
--- a/block/blk-rq-qos.h
+++ b/block/blk-rq-qos.h
@@ -85,8 +85,9 @@ static inline void rq_wait_init(struct rq_wait *rq_wait)
 	init_waitqueue_head(&rq_wait->wait);
 }
 
-int rq_qos_add(struct request_queue *q, struct rq_qos *rqos);
-void rq_qos_del(struct request_queue *q, struct rq_qos *rqos);
+int rq_qos_add(struct rq_qos *rqos, struct gendisk *disk, enum rq_qos_id id,
+		struct rq_qos_ops *ops);
+void rq_qos_del(struct rq_qos *rqos);
 
 typedef bool (acquire_inflight_cb_t)(struct rq_wait *rqw, void *private_data);
 typedef void (cleanup_cb_t)(struct rq_wait *rqw, void *private_data);
diff --git a/block/blk-wbt.c b/block/blk-wbt.c
index 95bec9244e9f3..aec4e37c89c4a 100644
--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -842,9 +842,6 @@ int wbt_init(struct gendisk *disk)
 	for (i = 0; i < WBT_NUM_RWQ; i++)
 		rq_wait_init(&rwb->rq_wait[i]);
 
-	rwb->rqos.id = RQ_QOS_WBT;
-	rwb->rqos.ops = &wbt_rqos_ops;
-	rwb->rqos.q = q;
 	rwb->last_comp = rwb->last_issue = jiffies;
 	rwb->win_nsec = RWB_WINDOW_NSEC;
 	rwb->enable_state = WBT_STATE_ON_DEFAULT;
@@ -857,7 +854,7 @@ int wbt_init(struct gendisk *disk)
 	/*
 	 * Assign rwb and add the stats callback.
 	 */
-	ret = rq_qos_add(q, &rwb->rqos);
+	ret = rq_qos_add(&rwb->rqos, disk, RQ_QOS_WBT, &wbt_rqos_ops);
 	if (ret)
 		goto err_free;
 
-- 
2.43.0


