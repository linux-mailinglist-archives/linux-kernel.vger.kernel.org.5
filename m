Return-Path: <linux-kernel+bounces-101925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93EE387ACC4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:16:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7C2D1C2011E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ACFB12CDA3;
	Wed, 13 Mar 2024 16:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cr74Aw6s"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD1612CD88;
	Wed, 13 Mar 2024 16:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348067; cv=none; b=iNgBhtwuMgbE7079P7jAj/KkNbuUM8LCTzX8NSjhqzLppcV2jV3LT/3/6WQMUKGG8aJ6hpsLlXT9Krr0q6ZamQgark0vfvijYrjfk9FFy8kZldQ2JZDw45YAZVd0D9NLTvCkL0JX0roAWaT2aGInZtXsC4fnLhtmFwvBRR1jmok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348067; c=relaxed/simple;
	bh=fHtrCpdtktd+cqT0GOK6+m1Ip4s0/AVhSgzSJdPA8Gc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fKQhhnPj5WaXyrS8tLnDXSpouSm8BJ8cd8QGOwOSKyOJ9fi/VjlwAkTpZo+3aGsc8cfcmWL1U8No45Ky1rFs01ecRKFMPp5g9JvKurnTqv/cdGZgVJKpF7C3n444JrnQUaacXPHHgWQ2wVFykkWVajyZQdqLTMKxI3QNHIlhOks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cr74Aw6s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 225CBC433A6;
	Wed, 13 Mar 2024 16:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710348067;
	bh=fHtrCpdtktd+cqT0GOK6+m1Ip4s0/AVhSgzSJdPA8Gc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Cr74Aw6sJ6o7Ub+isjOj3jbPrcvb8x0k80nJH/+yDmY6X7fnqK9EbnHEf7A6/Wk6v
	 8wPzW/Ey02WuREHpq/68wV3UPgkxMoFRroVWSLey9akUvNAIC7n0hZaRspkAM7DmUC
	 mGGFSlqQuMtnhJu707hJCO7EbtMwwIZ0wYFYHm7h4LLEQhEqX6BlGNQP2mQUZyCdhK
	 7esXzGUyrBvyeGOkitdd+fmQXNT06Z9gDo1CzXggY2Hr6ppR6W6hQVGeXAZJTfBP/6
	 Q2cE91pSaTpA+DWxYgl58dEkkUw1vP6a6YJjWdEO+P8uda3peZYn6+b+4/ZcsPNKPf
	 RRDDDVv6tZu1w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	Andreas Herrmann <aherrmann@suse.de>,
	Tejun Heo <tj@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 57/71] blk-rq-qos: constify rq_qos_ops
Date: Wed, 13 Mar 2024 12:39:43 -0400
Message-ID: <20240313163957.615276-58-sashal@kernel.org>
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

[ Upstream commit 3963d84df7974b6687cb34bce3b9e0b2686f839c ]

These op vectors are constant, so mark them const.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Andreas Herrmann <aherrmann@suse.de>
Acked-by: Tejun Heo <tj@kernel.org>
Link: https://lore.kernel.org/r/20230203150400.3199230-15-hch@lst.de
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Stable-dep-of: f814bdda774c ("blk-wbt: Fix detection of dirty-throttled tasks")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/blk-iocost.c    | 2 +-
 block/blk-iolatency.c | 2 +-
 block/blk-rq-qos.c    | 2 +-
 block/blk-rq-qos.h    | 4 ++--
 block/blk-wbt.c       | 2 +-
 5 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index a8a7d2ce927b9..78958c5bece08 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -2836,7 +2836,7 @@ static void ioc_rqos_exit(struct rq_qos *rqos)
 	kfree(ioc);
 }
 
-static struct rq_qos_ops ioc_rqos_ops = {
+static const struct rq_qos_ops ioc_rqos_ops = {
 	.throttle = ioc_rqos_throttle,
 	.merge = ioc_rqos_merge,
 	.done_bio = ioc_rqos_done_bio,
diff --git a/block/blk-iolatency.c b/block/blk-iolatency.c
index c64cfec34ac37..b0f8550f87cd2 100644
--- a/block/blk-iolatency.c
+++ b/block/blk-iolatency.c
@@ -651,7 +651,7 @@ static void blkcg_iolatency_exit(struct rq_qos *rqos)
 	kfree(blkiolat);
 }
 
-static struct rq_qos_ops blkcg_iolatency_ops = {
+static const struct rq_qos_ops blkcg_iolatency_ops = {
 	.throttle = blkcg_iolatency_throttle,
 	.done_bio = blkcg_iolatency_done_bio,
 	.exit = blkcg_iolatency_exit,
diff --git a/block/blk-rq-qos.c b/block/blk-rq-qos.c
index 14bee1bd76136..8e83734cfe8db 100644
--- a/block/blk-rq-qos.c
+++ b/block/blk-rq-qos.c
@@ -296,7 +296,7 @@ void rq_qos_exit(struct request_queue *q)
 }
 
 int rq_qos_add(struct rq_qos *rqos, struct gendisk *disk, enum rq_qos_id id,
-		struct rq_qos_ops *ops)
+		const struct rq_qos_ops *ops)
 {
 	struct request_queue *q = disk->queue;
 
diff --git a/block/blk-rq-qos.h b/block/blk-rq-qos.h
index 22552785aa31e..2b7b668479f71 100644
--- a/block/blk-rq-qos.h
+++ b/block/blk-rq-qos.h
@@ -25,7 +25,7 @@ struct rq_wait {
 };
 
 struct rq_qos {
-	struct rq_qos_ops *ops;
+	const struct rq_qos_ops *ops;
 	struct request_queue *q;
 	enum rq_qos_id id;
 	struct rq_qos *next;
@@ -86,7 +86,7 @@ static inline void rq_wait_init(struct rq_wait *rq_wait)
 }
 
 int rq_qos_add(struct rq_qos *rqos, struct gendisk *disk, enum rq_qos_id id,
-		struct rq_qos_ops *ops);
+		const struct rq_qos_ops *ops);
 void rq_qos_del(struct rq_qos *rqos);
 
 typedef bool (acquire_inflight_cb_t)(struct rq_wait *rqw, void *private_data);
diff --git a/block/blk-wbt.c b/block/blk-wbt.c
index aec4e37c89c4a..d9398347b08d8 100644
--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -808,7 +808,7 @@ static const struct blk_mq_debugfs_attr wbt_debugfs_attrs[] = {
 };
 #endif
 
-static struct rq_qos_ops wbt_rqos_ops = {
+static const struct rq_qos_ops wbt_rqos_ops = {
 	.throttle = wbt_wait,
 	.issue = wbt_issue,
 	.track = wbt_track,
-- 
2.43.0


