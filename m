Return-Path: <linux-kernel+bounces-101921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13EA087ACBC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:15:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94F441F3001F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3506712BF22;
	Wed, 13 Mar 2024 16:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="is349ZVj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B5E12BEB2;
	Wed, 13 Mar 2024 16:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348062; cv=none; b=Kbzaq4hHeC5Ux9yOgcUexhPeXJnyEQlcgR6Wzr61IyHGroL3DJVQyLO/EYYegcH8JnmlY4ztW/IM+rVGribVCZ//Q7b2eYs3rQtQyi2abugqpkxoAoDF08jeMufZNzGj3g4AbTihEZd7NfWqHzFoP0fQtWtKfcifS6oJu8JB1y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348062; c=relaxed/simple;
	bh=PowxuJQcK0zXz7vu+ktPazmRv9F90wojoKT9raPpi44=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HnKynGVt7xBwL9QZeSITYqngWzTIFtBLPgS2HO8KpJIyJQZnJS0fASg9FKnECMEn2kocUyEyk9PI1cXnZ8xMOQ6zv/R1+j1EwdwkyZRa5IofDz2e/R9t+bhB97PPe95fo7UEp3vmjZMQpgf3aUFr8QglrLdwuaNYLods0k7yqJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=is349ZVj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4714BC433F1;
	Wed, 13 Mar 2024 16:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710348062;
	bh=PowxuJQcK0zXz7vu+ktPazmRv9F90wojoKT9raPpi44=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=is349ZVjlnH6IoeZuAox0CumiC3/OVBchpI8PFs1Xx6kPkyNVNbP97Gn58uxmiJfu
	 v7IVwlDI9EFzb7gSMfzXfOLCC9weRv98kDTxI2qjI782MWgAnZsMybK0f19KyXZ0Ff
	 xs5jkf6A2+G9YOLwWq90bw+tLO7fqTEgyapIw8n2sFsytOYFWjdj7c+EKOPGCPVPcI
	 bGposp1lGk0zaTMmVSJ1rOkLE+2MQL2fukKuP5uLYXL1KGWlduUTA4z/POP9PSPV8I
	 SshfpuwuYo8uSW/nKBVW4GYL50y67dWjKIBXQSPw0+2RxCen2b7vd8Jr/E+M+Wjpfi
	 /fy+2XDizI+AQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	Andreas Herrmann <aherrmann@suse.de>,
	Tejun Heo <tj@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 53/71] blk-wbt: pass a gendisk to wbt_{enable,disable}_default
Date: Wed, 13 Mar 2024 12:39:39 -0400
Message-ID: <20240313163957.615276-54-sashal@kernel.org>
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

[ Upstream commit 04aad37be1a88de6a1919996a615437ac74de479 ]

Pass a gendisk to wbt_enable_default and wbt_disable_default to
prepare for phasing out usage of the request_queue in the blk-cgroup
code.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Andreas Herrmann <aherrmann@suse.de>
Acked-by: Tejun Heo <tj@kernel.org>
Link: https://lore.kernel.org/r/20230203150400.3199230-9-hch@lst.de
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Stable-dep-of: f814bdda774c ("blk-wbt: Fix detection of dirty-throttled tasks")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/bfq-iosched.c | 4 ++--
 block/blk-iocost.c  | 4 ++--
 block/blk-sysfs.c   | 2 +-
 block/blk-wbt.c     | 7 ++++---
 block/blk-wbt.h     | 8 ++++----
 5 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index e4699291aee23..84b4763b2b223 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -7060,7 +7060,7 @@ static void bfq_exit_queue(struct elevator_queue *e)
 
 	blk_stat_disable_accounting(bfqd->queue);
 	clear_bit(ELEVATOR_FLAG_DISABLE_WBT, &e->flags);
-	wbt_enable_default(bfqd->queue);
+	wbt_enable_default(bfqd->queue->disk);
 
 	kfree(bfqd);
 }
@@ -7206,7 +7206,7 @@ static int bfq_init_queue(struct request_queue *q, struct elevator_type *e)
 	blk_queue_flag_set(QUEUE_FLAG_SQ_SCHED, q);
 
 	set_bit(ELEVATOR_FLAG_DISABLE_WBT, &eq->flags);
-	wbt_disable_default(q);
+	wbt_disable_default(q->disk);
 	blk_stat_enable_accounting(q);
 
 	return 0;
diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 3788774a7b729..72ca07f24b3c0 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -3281,11 +3281,11 @@ static ssize_t ioc_qos_write(struct kernfs_open_file *of, char *input,
 		blk_stat_enable_accounting(disk->queue);
 		blk_queue_flag_set(QUEUE_FLAG_RQ_ALLOC_TIME, disk->queue);
 		ioc->enabled = true;
-		wbt_disable_default(disk->queue);
+		wbt_disable_default(disk);
 	} else {
 		blk_queue_flag_clear(QUEUE_FLAG_RQ_ALLOC_TIME, disk->queue);
 		ioc->enabled = false;
-		wbt_enable_default(disk->queue);
+		wbt_enable_default(disk);
 	}
 
 	if (user) {
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index a82bdec923b21..c59c4d3ee7a27 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -837,7 +837,7 @@ int blk_register_queue(struct gendisk *disk)
 		goto put_dev;
 
 	blk_queue_flag_set(QUEUE_FLAG_REGISTERED, q);
-	wbt_enable_default(q);
+	wbt_enable_default(disk);
 	blk_throtl_register(disk);
 
 	/* Now everything is ready and send out KOBJ_ADD uevent */
diff --git a/block/blk-wbt.c b/block/blk-wbt.c
index afb1782b4255e..8d4f075f13e2f 100644
--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -637,8 +637,9 @@ void wbt_set_write_cache(struct request_queue *q, bool write_cache_on)
 /*
  * Enable wbt if defaults are configured that way
  */
-void wbt_enable_default(struct request_queue *q)
+void wbt_enable_default(struct gendisk *disk)
 {
+	struct request_queue *q = disk->queue;
 	struct rq_qos *rqos;
 	bool disable_flag = q->elevator &&
 		    test_bit(ELEVATOR_FLAG_DISABLE_WBT, &q->elevator->flags);
@@ -705,9 +706,9 @@ static void wbt_exit(struct rq_qos *rqos)
 /*
  * Disable wbt, if enabled by default.
  */
-void wbt_disable_default(struct request_queue *q)
+void wbt_disable_default(struct gendisk *disk)
 {
-	struct rq_qos *rqos = wbt_rq_qos(q);
+	struct rq_qos *rqos = wbt_rq_qos(disk->queue);
 	struct rq_wb *rwb;
 	if (!rqos)
 		return;
diff --git a/block/blk-wbt.h b/block/blk-wbt.h
index 7e44eccc676dd..58c226fe33d48 100644
--- a/block/blk-wbt.h
+++ b/block/blk-wbt.h
@@ -89,8 +89,8 @@ static inline unsigned int wbt_inflight(struct rq_wb *rwb)
 #ifdef CONFIG_BLK_WBT
 
 int wbt_init(struct request_queue *);
-void wbt_disable_default(struct request_queue *);
-void wbt_enable_default(struct request_queue *);
+void wbt_disable_default(struct gendisk *disk);
+void wbt_enable_default(struct gendisk *disk);
 
 u64 wbt_get_min_lat(struct request_queue *q);
 void wbt_set_min_lat(struct request_queue *q, u64 val);
@@ -105,10 +105,10 @@ static inline int wbt_init(struct request_queue *q)
 {
 	return -EINVAL;
 }
-static inline void wbt_disable_default(struct request_queue *q)
+static inline void wbt_disable_default(struct gendisk *disk)
 {
 }
-static inline void wbt_enable_default(struct request_queue *q)
+static inline void wbt_enable_default(struct gendisk *disk)
 {
 }
 static inline void wbt_set_write_cache(struct request_queue *q, bool wc)
-- 
2.43.0


