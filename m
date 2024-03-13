Return-Path: <linux-kernel+bounces-101937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19D2687ACDD
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:20:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BC0B1C21B89
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0556134429;
	Wed, 13 Mar 2024 16:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZpO/pLa7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12D1134414;
	Wed, 13 Mar 2024 16:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348082; cv=none; b=PtLP1AlnADMqboPJjnL051HYtcUGmgUuAtKOy7miSVDo46L2cYNhLRi2a5/SnnpdGw/NMXeCkTaZbGHd5FKMhacsj4TmAyT8Aes9BCzLCR3zwLOT6w3Z2naUcVEpxrrsxVykPsARPPU2FHVyUk6lRvZqja2oE7kwJsKkZF8yDto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348082; c=relaxed/simple;
	bh=j0muwogAkB3HXR0/me7RsmXqv1/xwYSYRgyLfqqgNyk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pn03WaqeUAN8KPdue2mUB4wvOPSfYkaAvvmricBZ3A1MumdHpJYypq2gOHESpWbkgaRE02u23lVEnHT+6J15Z3E3e63gArRh6OIegtmGetOaloxOYK0bPds9ciScM37ic+cQGC/a2XlR2tJMS0XDc39vMGZ6OigRXafczqa3CLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZpO/pLa7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D64B8C433F1;
	Wed, 13 Mar 2024 16:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710348081;
	bh=j0muwogAkB3HXR0/me7RsmXqv1/xwYSYRgyLfqqgNyk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZpO/pLa7zsjQB4cUpBO95+XOfIZhTXYJW5rG4l8lEWiHxhefOijVlkdPLWDHZpVF/
	 ItoxHZRjYOc1PEhRWgX2o242NPgPrYV3e+rU8dKSJWp04AMkVHfNzakEKw1t7XmCkH
	 mwJcOO3Zeq9u7UV8v0Yh2GYK/HOJhSucdZuLMXHOkKsiLqt/H4KpL1jsNuRoMu8HQh
	 bhWZhB+hzdiG2EvoPGG3jLw9oSjSrwutWD3SgdXXLp/R6xQIhesYqtiC2JR+7zD6BV
	 g82LPVZvnqE1YG6rZOVP10rmvvbwvLGPnFJPVU2haw5CyBA7LhCFNF5D8tQw4+xyAc
	 tQ3b6YXO1UsCw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Yu Kuai <yukuai3@huawei.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 69/71] blk-wbt: fix that wbt can't be disabled by default
Date: Wed, 13 Mar 2024 12:39:55 -0400
Message-ID: <20240313163957.615276-70-sashal@kernel.org>
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

[ Upstream commit 8a2b20a997a3779ae9fcae268f2959eb82ec05a1 ]

commit b11d31ae01e6 ("blk-wbt: remove unnecessary check in
wbt_enable_default()") removes the checking of CONFIG_BLK_WBT_MQ by
mistake, which is used to control enable or disable wbt by default.

Fix the problem by adding back the checking. This patch also do a litter
cleanup to make related code more readable.

Fixes: b11d31ae01e6 ("blk-wbt: remove unnecessary check in wbt_enable_default()")
Reported-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Link: https://lore.kernel.org/lkml/CAKXUXMzfKq_J9nKHGyr5P5rvUETY4B-fxoQD4sO+NYjFOfVtZA@mail.gmail.com/t/
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Link: https://lore.kernel.org/r/20230522121854.2928880-1-yukuai1@huaweicloud.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/blk-wbt.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/block/blk-wbt.c b/block/blk-wbt.c
index fcacdff8af93b..526fb12c3e4cf 100644
--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -640,14 +640,16 @@ void wbt_enable_default(struct gendisk *disk)
 {
 	struct request_queue *q = disk->queue;
 	struct rq_qos *rqos;
-	bool disable_flag = q->elevator &&
-		    test_bit(ELEVATOR_FLAG_DISABLE_WBT, &q->elevator->flags);
+	bool enable = IS_ENABLED(CONFIG_BLK_WBT_MQ);
+
+	if (q->elevator &&
+	    test_bit(ELEVATOR_FLAG_DISABLE_WBT, &q->elevator->flags))
+		enable = false;
 
 	/* Throttling already enabled? */
 	rqos = wbt_rq_qos(q);
 	if (rqos) {
-		if (!disable_flag &&
-		    RQWB(rqos)->enable_state == WBT_STATE_OFF_DEFAULT)
+		if (enable && RQWB(rqos)->enable_state == WBT_STATE_OFF_DEFAULT)
 			RQWB(rqos)->enable_state = WBT_STATE_ON_DEFAULT;
 		return;
 	}
@@ -656,7 +658,7 @@ void wbt_enable_default(struct gendisk *disk)
 	if (!blk_queue_registered(q))
 		return;
 
-	if (queue_is_mq(q) && !disable_flag)
+	if (queue_is_mq(q) && enable)
 		wbt_init(disk);
 }
 EXPORT_SYMBOL_GPL(wbt_enable_default);
-- 
2.43.0


