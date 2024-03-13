Return-Path: <linux-kernel+bounces-101927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82EDC87ACC9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:17:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9B581C20CAD
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55A1612DDA5;
	Wed, 13 Mar 2024 16:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E9/dr+Nm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0F012D745;
	Wed, 13 Mar 2024 16:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348069; cv=none; b=A+NMrKC9ggnPtTz67aaxr6aDds0ACrxHEDltD32ccQS2hDaLKKY8q/WteoeTLxNeDGF7drW0Hf/0aIh+ljaclJxaSP77LSXj8nUhSv003EnloXfix+2x5XA3JuVqUhWMpvxvPS4iz0vdSYJTS6xGCS6mZP5rf0n4R67HAoDxDWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348069; c=relaxed/simple;
	bh=DN3jbkUSdSzhiWrF7jKInj8iLR8glCi14pG4IdJnnLE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OdjqDooZX28gtF66eWI5eX4BXrhwqcJpZPG97MJF/s3LYBVX/aw6C9jm9BXQJhpK6r2/wda0ANPjTHOAZcVfPEVvYHSLbt3GhMMOg/7hV9nHwzJevUW5P5DYSpOhh3Cqya7mNMuDO4qLLnh9G/MMy1Z5L+oDa79FdvurmvEW8mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E9/dr+Nm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A04F0C433C7;
	Wed, 13 Mar 2024 16:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710348069;
	bh=DN3jbkUSdSzhiWrF7jKInj8iLR8glCi14pG4IdJnnLE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E9/dr+NmJlYdlyGtz6RlMybpigPTBB1v1fB587+hRoGTUwmZ/j8gpUFq22P1TCrd4
	 Mb6t1ev1Zom5TiSvefsNTyYV9qmmF96xDX59E7RUJA0MHEfcey2mMVPHsYKSDYkA3o
	 vzDpoelN01tSvkQRjnMcnEgRUpm0wKcWC8WfquDgTnDmpesDFmastQjL3h0a/Gv+NR
	 D83DxLJNSOyjvZxMCG5RTfQu6gR4jXOUnhpl0KbbaVMvY5gB30KqOKdO8cX9/OH7+z
	 VMkI5OylhxhDtLdE+dcYqL8pn6agB1h+zoCJPyj4oNzdhIQuv/7rFRiHT+PG8i1R4z
	 yY7WWtbUAW+CA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 59/71] blk-wbt: Fix detection of dirty-throttled tasks
Date: Wed, 13 Mar 2024 12:39:45 -0400
Message-ID: <20240313163957.615276-60-sashal@kernel.org>
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

From: Jan Kara <jack@suse.cz>

[ Upstream commit f814bdda774c183b0cc15ec8f3b6e7c6f4527ba5 ]

The detection of dirty-throttled tasks in blk-wbt has been subtly broken
since its beginning in 2016. Namely if we are doing cgroup writeback and
the throttled task is not in the root cgroup, balance_dirty_pages() will
set dirty_sleep for the non-root bdi_writeback structure. However
blk-wbt checks dirty_sleep only in the root cgroup bdi_writeback
structure. Thus detection of recently throttled tasks is not working in
this case (we noticed this when we switched to cgroup v2 and suddently
writeback was slow).

Since blk-wbt has no easy way to get to proper bdi_writeback and
furthermore its intention has always been to work on the whole device
rather than on individual cgroups, just move the dirty_sleep timestamp
from bdi_writeback to backing_dev_info. That fixes the checking for
recently throttled task and saves memory for everybody as a bonus.

CC: stable@vger.kernel.org
Fixes: b57d74aff9ab ("writeback: track if we're sleeping on progress in balance_dirty_pages()")
Signed-off-by: Jan Kara <jack@suse.cz>
Link: https://lore.kernel.org/r/20240123175826.21452-1-jack@suse.cz
[axboe: fixup indentation errors]
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/blk-wbt.c                  | 4 ++--
 include/linux/backing-dev-defs.h | 7 +++++--
 mm/backing-dev.c                 | 2 +-
 mm/page-writeback.c              | 2 +-
 4 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/block/blk-wbt.c b/block/blk-wbt.c
index e9206b1406e76..fcacdff8af93b 100644
--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -98,9 +98,9 @@ static void wb_timestamp(struct rq_wb *rwb, unsigned long *var)
  */
 static bool wb_recent_wait(struct rq_wb *rwb)
 {
-	struct bdi_writeback *wb = &rwb->rqos.disk->bdi->wb;
+	struct backing_dev_info *bdi = rwb->rqos.disk->bdi;
 
-	return time_before(jiffies, wb->dirty_sleep + HZ);
+	return time_before(jiffies, bdi->last_bdp_sleep + HZ);
 }
 
 static inline struct rq_wait *get_rq_wait(struct rq_wb *rwb,
diff --git a/include/linux/backing-dev-defs.h b/include/linux/backing-dev-defs.h
index ae12696ec492c..2ad261082bba5 100644
--- a/include/linux/backing-dev-defs.h
+++ b/include/linux/backing-dev-defs.h
@@ -141,8 +141,6 @@ struct bdi_writeback {
 	struct delayed_work dwork;	/* work item used for writeback */
 	struct delayed_work bw_dwork;	/* work item used for bandwidth estimate */
 
-	unsigned long dirty_sleep;	/* last wait */
-
 	struct list_head bdi_node;	/* anchored at bdi->wb_list */
 
 #ifdef CONFIG_CGROUP_WRITEBACK
@@ -179,6 +177,11 @@ struct backing_dev_info {
 	 * any dirty wbs, which is depended upon by bdi_has_dirty().
 	 */
 	atomic_long_t tot_write_bandwidth;
+	/*
+	 * Jiffies when last process was dirty throttled on this bdi. Used by
+	 * blk-wbt.
+	 */
+	unsigned long last_bdp_sleep;
 
 	struct bdi_writeback wb;  /* the root writeback info for this bdi */
 	struct list_head wb_list; /* list of all wbs */
diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index bf5525c2e561a..c070ff9ef9cf3 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -305,7 +305,6 @@ static int wb_init(struct bdi_writeback *wb, struct backing_dev_info *bdi,
 	INIT_LIST_HEAD(&wb->work_list);
 	INIT_DELAYED_WORK(&wb->dwork, wb_workfn);
 	INIT_DELAYED_WORK(&wb->bw_dwork, wb_update_bandwidth_workfn);
-	wb->dirty_sleep = jiffies;
 
 	err = fprop_local_init_percpu(&wb->completions, gfp);
 	if (err)
@@ -793,6 +792,7 @@ int bdi_init(struct backing_dev_info *bdi)
 	INIT_LIST_HEAD(&bdi->bdi_list);
 	INIT_LIST_HEAD(&bdi->wb_list);
 	init_waitqueue_head(&bdi->wb_waitq);
+	bdi->last_bdp_sleep = jiffies;
 
 	return cgwb_bdi_init(bdi);
 }
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index d3e9d12860b9f..9046d1f1b408e 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -1809,7 +1809,7 @@ static int balance_dirty_pages(struct bdi_writeback *wb,
 			break;
 		}
 		__set_current_state(TASK_KILLABLE);
-		wb->dirty_sleep = now;
+		bdi->last_bdp_sleep = jiffies;
 		io_schedule_timeout(pause);
 
 		current->dirty_paused_when = now + pause;
-- 
2.43.0


