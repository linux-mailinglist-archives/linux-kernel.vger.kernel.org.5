Return-Path: <linux-kernel+bounces-101916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33E9887ACB2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:14:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B94C828E956
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4142686277;
	Wed, 13 Mar 2024 16:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cgpk2K8B"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C25C6168A;
	Wed, 13 Mar 2024 16:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348056; cv=none; b=UN79Oi+CcIRwPqRVySTeC6UlrybAuX/j58S1GE2l4rSXP2o0mB3J2z94fpp+bTIHVVCVec5T/XJTK/n6S1VRGr6C3NzgL/XvIfnWe6p0TLnXtD0nSHMWCLdZbyNiKU1GUAKPMXMJ5qFQwvg8wzWbBiRm/54W0p63uzwx+nm46CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348056; c=relaxed/simple;
	bh=CaMNA1CPG/CLbl0+AMv8sEX54UXwJGSXM39ncBAlxSY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kMRezm2zHs9FjA0LV6Oqsa5PeCRte5LXAQbU53rxF/Z2OyX2LCWbzA0fmI4p2Kg+YFpwNL2qUkBkYO/KfM5YWqZt6J8YprmWzdYHxqUMRYE9QJGKqJw+11IyG9pLnBFjsHLhHg5/CX+Jx61crFOPxbxYIaFi9E2YyloJ3CwZw68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cgpk2K8B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88923C433C7;
	Wed, 13 Mar 2024 16:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710348056;
	bh=CaMNA1CPG/CLbl0+AMv8sEX54UXwJGSXM39ncBAlxSY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Cgpk2K8B8f8sY1BPYYvfWfnMbp6p53c1xNezhMEwzpGxons4pv2AuuqNx9xGE7hAW
	 vmdSD8E8jF2Rur5TOkhhEQ9y3a5d8x82nndI7LEQtBDQpaqI3svAymZBeiyPaE7CtN
	 oDG9/P7dx4d5CVvzDOFYMIlXldXUY4s3mYgBCVtsKKS19lbCWkgn1d4ItJnsYVkLyV
	 CVqkuScLVc/QJc/G6yrz33DwA2CZ95FUsMAnNrFcpds1tNbvmgfs1Bpmh+sW1/pISQ
	 KHeKqmaVCOu9TsX8wcylRzb+G0aUgiWqnZwm/bX0nIAhzLm+fJD4SU/zE2YTY9xM2X
	 SsKyfZa0s8aGw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Yu Kuai <yukuai3@huawei.com>,
	Tejun Heo <tj@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 48/71] blk-iocost: disable writeback throttling
Date: Wed, 13 Mar 2024 12:39:34 -0400
Message-ID: <20240313163957.615276-49-sashal@kernel.org>
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

[ Upstream commit 8796acbc9a0eceeddd99eaef833bdda1241d39b9 ]

Commit b5dc5d4d1f4f ("block,bfq: Disable writeback throttling") disable
wbt for bfq, because different write-throttling heuristics should not
work together.

For the same reason, wbt and iocost should not work together as well,
unless admin really want to do that, dispite that performance is
affected.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Acked-by: Tejun Heo <tj@kernel.org>
Link: https://lore.kernel.org/r/20221012094035.390056-2-yukuai1@huaweicloud.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Stable-dep-of: f814bdda774c ("blk-wbt: Fix detection of dirty-throttled tasks")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/blk-iocost.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index e6557024e3da8..3788774a7b729 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -3281,9 +3281,11 @@ static ssize_t ioc_qos_write(struct kernfs_open_file *of, char *input,
 		blk_stat_enable_accounting(disk->queue);
 		blk_queue_flag_set(QUEUE_FLAG_RQ_ALLOC_TIME, disk->queue);
 		ioc->enabled = true;
+		wbt_disable_default(disk->queue);
 	} else {
 		blk_queue_flag_clear(QUEUE_FLAG_RQ_ALLOC_TIME, disk->queue);
 		ioc->enabled = false;
+		wbt_enable_default(disk->queue);
 	}
 
 	if (user) {
-- 
2.43.0


