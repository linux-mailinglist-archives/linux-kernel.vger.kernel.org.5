Return-Path: <linux-kernel+bounces-101920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 556E187ACBA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:15:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9B221F2FFC8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4935B12BEB1;
	Wed, 13 Mar 2024 16:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NQfm4if/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69BFF12B171;
	Wed, 13 Mar 2024 16:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348061; cv=none; b=S0v7Dw+gymPYBJbNn8VEhMPQuEu32ER3hECg3UlbhH4rcPyH93+lV7yqG9m9WgunXoKmlRZI1uXpgdpgs+tkCKE4ygMuXfBEr4AW/0wwfeAT96NlRMrjeQlMgcjHOxQpIPrnBfl4KZY1r5FqfExf12j27an73UPMYBJY5uNaSDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348061; c=relaxed/simple;
	bh=FQ9ySN2hzptFwOZ1J9UfqsQazctQpPU3WtQqRnlwbQk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aLK6DVPxrbJyOwbhAy8rz/zAbNoA6kCHVWrRqKPNl7bBg1O71gIIOKsUNQOPlM65D8rGo4yZP5nPVMZgDtJ98W6n8EaICb2rCceHGcd5z8nwT6T8bwo6uULfBIMd/sU1xJ3ZZ21fMuiCz8AX/IFufzqARNuibkBQG50Sd5uji0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NQfm4if/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24A49C43394;
	Wed, 13 Mar 2024 16:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710348061;
	bh=FQ9ySN2hzptFwOZ1J9UfqsQazctQpPU3WtQqRnlwbQk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NQfm4if/oQNYl7JNf4lKvZJjFsti+KgB4HgyLAs8pa/g1h/pzgOmWX2fs6yDTFJdG
	 vBfsUUFWo1lVZd0U0+AugGK6D/iPnYx5HO9aqQhJ6vPS6e7AWwZyKtVE7ad3LxuS5J
	 D4G5e/Q9cibfV+aelnnTZjrHkDydNgs4K+TYmP761Ohq2cGLCLLtZ25BTfIcmdnO9Z
	 Rlex1CDL1BCpRXTTrmw2ENLTNDmzlHI0gl8C49o9NIlYOK395MkJB7/lZSgBGxwlOT
	 85wMseA6hpzHNlPpGCGhwR4wDLImeS3yTivccRV2fm2CzBd/h1d0a2/hwTx9ooO4wf
	 HTzk/734YW4/w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Yu Kuai <yukuai3@huawei.com>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 52/71] blk-wbt: don't enable throttling if default elevator is bfq
Date: Wed, 13 Mar 2024 12:39:38 -0400
Message-ID: <20240313163957.615276-53-sashal@kernel.org>
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

From: Yu Kuai <yukuai3@huawei.com>

[ Upstream commit 671fae5e51297fc76b3758ca2edd514858734a6a ]

Commit b5dc5d4d1f4f ("block,bfq: Disable writeback throttling") tries to
disable wbt for bfq, it's done by calling wbt_disable_default() in
bfq_init_queue(). However, wbt is still enabled if default elevator is
bfq:

device_add_disk
 elevator_init_mq
  bfq_init_queue
   wbt_disable_default -> done nothing

 blk_register_queue
  wbt_enable_default -> wbt is enabled

Fix the problem by adding a new flag ELEVATOR_FLAG_DISBALE_WBT, bfq
will set the flag in bfq_init_queue, and following wbt_enable_default()
won't enable wbt while the flag is set.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Link: https://lore.kernel.org/r/20221019121518.3865235-7-yukuai1@huaweicloud.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Stable-dep-of: f814bdda774c ("blk-wbt: Fix detection of dirty-throttled tasks")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/bfq-iosched.c |  2 ++
 block/blk-wbt.c     | 11 ++++++++---
 block/elevator.h    |  3 ++-
 3 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 52eb79d60a3f3..e4699291aee23 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -7059,6 +7059,7 @@ static void bfq_exit_queue(struct elevator_queue *e)
 #endif
 
 	blk_stat_disable_accounting(bfqd->queue);
+	clear_bit(ELEVATOR_FLAG_DISABLE_WBT, &e->flags);
 	wbt_enable_default(bfqd->queue);
 
 	kfree(bfqd);
@@ -7204,6 +7205,7 @@ static int bfq_init_queue(struct request_queue *q, struct elevator_type *e)
 	/* We dispatch from request queue wide instead of hw queue */
 	blk_queue_flag_set(QUEUE_FLAG_SQ_SCHED, q);
 
+	set_bit(ELEVATOR_FLAG_DISABLE_WBT, &eq->flags);
 	wbt_disable_default(q);
 	blk_stat_enable_accounting(q);
 
diff --git a/block/blk-wbt.c b/block/blk-wbt.c
index c5a8c10028a08..afb1782b4255e 100644
--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -27,6 +27,7 @@
 
 #include "blk-wbt.h"
 #include "blk-rq-qos.h"
+#include "elevator.h"
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/wbt.h>
@@ -638,11 +639,15 @@ void wbt_set_write_cache(struct request_queue *q, bool write_cache_on)
  */
 void wbt_enable_default(struct request_queue *q)
 {
-	struct rq_qos *rqos = wbt_rq_qos(q);
+	struct rq_qos *rqos;
+	bool disable_flag = q->elevator &&
+		    test_bit(ELEVATOR_FLAG_DISABLE_WBT, &q->elevator->flags);
 
 	/* Throttling already enabled? */
+	rqos = wbt_rq_qos(q);
 	if (rqos) {
-		if (RQWB(rqos)->enable_state == WBT_STATE_OFF_DEFAULT)
+		if (!disable_flag &&
+		    RQWB(rqos)->enable_state == WBT_STATE_OFF_DEFAULT)
 			RQWB(rqos)->enable_state = WBT_STATE_ON_DEFAULT;
 		return;
 	}
@@ -651,7 +656,7 @@ void wbt_enable_default(struct request_queue *q)
 	if (!blk_queue_registered(q))
 		return;
 
-	if (queue_is_mq(q))
+	if (queue_is_mq(q) && !disable_flag)
 		wbt_init(q);
 }
 EXPORT_SYMBOL_GPL(wbt_enable_default);
diff --git a/block/elevator.h b/block/elevator.h
index ed574bf3e629e..75382471222d1 100644
--- a/block/elevator.h
+++ b/block/elevator.h
@@ -104,7 +104,8 @@ struct elevator_queue
 	DECLARE_HASHTABLE(hash, ELV_HASH_BITS);
 };
 
-#define ELEVATOR_FLAG_REGISTERED 0
+#define ELEVATOR_FLAG_REGISTERED	0
+#define ELEVATOR_FLAG_DISABLE_WBT	1
 
 /*
  * block elevator interface
-- 
2.43.0


