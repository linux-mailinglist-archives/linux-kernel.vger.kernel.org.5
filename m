Return-Path: <linux-kernel+bounces-101922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8A2287ACBE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:16:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2E1128FFEF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47A9612C531;
	Wed, 13 Mar 2024 16:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oFWMwYJA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8644B12BF2D;
	Wed, 13 Mar 2024 16:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348063; cv=none; b=f/XVcq8CC1vqrzPOBitZZBgwRyWSdKvsclU2gNIKm7n9K4KfEJCmSF8UgkG9aaQGRiyWxMO3OPFMe4ckD4z9WC6Tj+TW9rnxbQbKK/q08R0Bm1agcXuxWwVMCyzJtgsu2oCK/tlSA+IycJ4eV9KQ/qoi0RyTTymPGgVXexDT6Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348063; c=relaxed/simple;
	bh=qyYMg1voX87ZOIy7J2Hx7EeoBLpGryqBylptNPu1ZyM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UYNxcCYF4STk8yfWBUHaPcin6dcdZrUiQyOnVE/lZ9uRUN4tvBCDN9bKemCaP25TjqyjOM0ToTI1gZc/s2iI9zG09MUeKGGflou3udSE0vgWomBL/IOtBNYAkOzMjEEN0vxcDSCe3ZVxKmgh9fpZYzfxQRQANC+kQk3xoqQjdVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oFWMwYJA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B588C43390;
	Wed, 13 Mar 2024 16:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710348063;
	bh=qyYMg1voX87ZOIy7J2Hx7EeoBLpGryqBylptNPu1ZyM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oFWMwYJAlToEoE33GcnFHNrpI37iMEegEExUZMrxcgBe5yadRBa9IBNjgH7bneycY
	 UrO4SfMcyFgW5S7TKbeou6nXUNlpPWHll7Xr37t1Qa5tNL4zF6iYR974FMEnExk1pP
	 6cFpQBidv69QWbTX0t/c/K1LWFcUEOeNL01C/3Qe3tFjAvPhYM3MmA6iHt3D5jdHVR
	 VSO4yEAE0aPc8qG1iZw/sJ+km8eenhdH6Dn/Ind8kgXz5i7iWDzrERcEFflNynZw2p
	 hJFwHylqrU0q3y4xfE2r9cWhoSIPH51KCHnyqEsv9Z83BVPuEYo4Uj9rJEIyeaH/yZ
	 EDg0TMUdVbHYg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	Andreas Herrmann <aherrmann@suse.de>,
	Tejun Heo <tj@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 54/71] blk-wbt: pass a gendisk to wbt_init
Date: Wed, 13 Mar 2024 12:39:40 -0400
Message-ID: <20240313163957.615276-55-sashal@kernel.org>
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

[ Upstream commit 958f29654747a54f2272eb478e493eb97f492e06 ]

Pass a gendisk to wbt_init to prepare for phasing out usage of the
request_queue in the blk-cgroup code.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Andreas Herrmann <aherrmann@suse.de>
Acked-by: Tejun Heo <tj@kernel.org>
Link: https://lore.kernel.org/r/20230203150400.3199230-10-hch@lst.de
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Stable-dep-of: f814bdda774c ("blk-wbt: Fix detection of dirty-throttled tasks")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/blk-sysfs.c | 2 +-
 block/blk-wbt.c   | 5 +++--
 block/blk-wbt.h   | 4 ++--
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index c59c4d3ee7a27..31f53ef01982d 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -488,7 +488,7 @@ static ssize_t queue_wb_lat_store(struct request_queue *q, const char *page,
 
 	rqos = wbt_rq_qos(q);
 	if (!rqos) {
-		ret = wbt_init(q);
+		ret = wbt_init(q->disk);
 		if (ret)
 			return ret;
 	}
diff --git a/block/blk-wbt.c b/block/blk-wbt.c
index 8d4f075f13e2f..95bec9244e9f3 100644
--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -658,7 +658,7 @@ void wbt_enable_default(struct gendisk *disk)
 		return;
 
 	if (queue_is_mq(q) && !disable_flag)
-		wbt_init(q);
+		wbt_init(disk);
 }
 EXPORT_SYMBOL_GPL(wbt_enable_default);
 
@@ -822,8 +822,9 @@ static struct rq_qos_ops wbt_rqos_ops = {
 #endif
 };
 
-int wbt_init(struct request_queue *q)
+int wbt_init(struct gendisk *disk)
 {
+	struct request_queue *q = disk->queue;
 	struct rq_wb *rwb;
 	int i;
 	int ret;
diff --git a/block/blk-wbt.h b/block/blk-wbt.h
index 58c226fe33d48..8170439b89d6e 100644
--- a/block/blk-wbt.h
+++ b/block/blk-wbt.h
@@ -88,7 +88,7 @@ static inline unsigned int wbt_inflight(struct rq_wb *rwb)
 
 #ifdef CONFIG_BLK_WBT
 
-int wbt_init(struct request_queue *);
+int wbt_init(struct gendisk *disk);
 void wbt_disable_default(struct gendisk *disk);
 void wbt_enable_default(struct gendisk *disk);
 
@@ -101,7 +101,7 @@ u64 wbt_default_latency_nsec(struct request_queue *);
 
 #else
 
-static inline int wbt_init(struct request_queue *q)
+static inline int wbt_init(struct gendisk *disk)
 {
 	return -EINVAL;
 }
-- 
2.43.0


