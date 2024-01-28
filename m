Return-Path: <linux-kernel+bounces-41823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3215F83F819
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 17:48:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 645B11C20B45
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 16:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE1CF1468FF;
	Sun, 28 Jan 2024 16:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VE6KKh2V"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06351145B0C;
	Sun, 28 Jan 2024 16:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706458614; cv=none; b=a/Yc1PBT+CNSxNsvauhQ/K3CmmipjQIRK5z607Pzvw7XPAxc7K664ITLYl5uZ1WAkXchCUDUm0cg46LUJBkj5IkWSQoKvcNEbZTOgQ6aTq6yh5u0yp/nHWdHmazQedmgo8D6oqlUKp6BGIdHiqcSuuN+4/DrFzvnG5+dXHnpGcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706458614; c=relaxed/simple;
	bh=gXzRJQ4w6HfLqaPZkW+lGLcft4nQixwtOobti51FVwk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gPoznyuxtmrCNC5zXSgwbPEAbf14xmItG7n0uHUrdhPl2bmd418+81SFxKerktnnBG6nbsELEzI8a4zoZqPwF0nZdsqxTopr/93FBDzzb4t1g7UBPNmvPKPoU7F14F0vdIp3ynh1Hia7YAhcdpnKV8VNvK/5GzYhoCQnsIkJAJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VE6KKh2V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 985F6C433C7;
	Sun, 28 Jan 2024 16:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706458613;
	bh=gXzRJQ4w6HfLqaPZkW+lGLcft4nQixwtOobti51FVwk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VE6KKh2V+eQS2+PMJEofjYieS5jCqGoasVH8//yjxAYoPXUiIYhvMP+BnZ2xCnbHI
	 FN3XWLnn/bQdwyxCUHaTF0Erhy1ZRByCn1XXaLsQyJgIoid4zdr35Uq/LKhVnYEuaB
	 QHstIJMRUfHoy9onMLPofSp/b9T33FoE7BAKMpPWet3YQE6//YVWvMpWXB/pHRIV6r
	 sZ8ai+bNtG67YJIJX4sy7f2Vau/+N5oxJ+R6c7oB6IbMANFZMioU0YnDs3r1sgfD1k
	 0yPVZAbwKgeT1rWGJhjCHET9uLBbzNdXNsLI8xq3NE4zhG7crntzClxuJeZ+Heo4ux
	 qfKPcJKeAzcEw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ming Lei <ming.lei@redhat.com>,
	Jan Kara <jack@suse.cz>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Changhui Zhong <czhong@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>,
	linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 09/11] blk-mq: fix IO hang from sbitmap wakeup race
Date: Sun, 28 Jan 2024 11:16:30 -0500
Message-ID: <20240128161637.205509-9-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240128161637.205509-1-sashal@kernel.org>
References: <20240128161637.205509-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.268
Content-Transfer-Encoding: 8bit

From: Ming Lei <ming.lei@redhat.com>

[ Upstream commit 5266caaf5660529e3da53004b8b7174cab6374ed ]

In blk_mq_mark_tag_wait(), __add_wait_queue() may be re-ordered
with the following blk_mq_get_driver_tag() in case of getting driver
tag failure.

Then in __sbitmap_queue_wake_up(), waitqueue_active() may not observe
the added waiter in blk_mq_mark_tag_wait() and wake up nothing, meantime
blk_mq_mark_tag_wait() can't get driver tag successfully.

This issue can be reproduced by running the following test in loop, and
fio hang can be observed in < 30min when running it on my test VM
in laptop.

	modprobe -r scsi_debug
	modprobe scsi_debug delay=0 dev_size_mb=4096 max_queue=1 host_max_queue=1 submit_queues=4
	dev=`ls -d /sys/bus/pseudo/drivers/scsi_debug/adapter*/host*/target*/*/block/* | head -1 | xargs basename`
	fio --filename=/dev/"$dev" --direct=1 --rw=randrw --bs=4k --iodepth=1 \
       		--runtime=100 --numjobs=40 --time_based --name=test \
        	--ioengine=libaio

Fix the issue by adding one explicit barrier in blk_mq_mark_tag_wait(), which
is just fine in case of running out of tag.

Cc: Jan Kara <jack@suse.cz>
Cc: Kemeng Shi <shikemeng@huaweicloud.com>
Reported-by: Changhui Zhong <czhong@redhat.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
Link: https://lore.kernel.org/r/20240112122626.4181044-1-ming.lei@redhat.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/blk-mq.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 325a5944b4cb..03f4eb37dfc7 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1153,6 +1153,22 @@ static bool blk_mq_mark_tag_wait(struct blk_mq_hw_ctx *hctx,
 	wait->flags &= ~WQ_FLAG_EXCLUSIVE;
 	__add_wait_queue(wq, wait);
 
+	/*
+	 * Add one explicit barrier since blk_mq_get_driver_tag() may
+	 * not imply barrier in case of failure.
+	 *
+	 * Order adding us to wait queue and allocating driver tag.
+	 *
+	 * The pair is the one implied in sbitmap_queue_wake_up() which
+	 * orders clearing sbitmap tag bits and waitqueue_active() in
+	 * __sbitmap_queue_wake_up(), since waitqueue_active() is lockless
+	 *
+	 * Otherwise, re-order of adding wait queue and getting driver tag
+	 * may cause __sbitmap_queue_wake_up() to wake up nothing because
+	 * the waitqueue_active() may not observe us in wait queue.
+	 */
+	smp_mb();
+
 	/*
 	 * It's possible that a tag was freed in the window between the
 	 * allocation failure and adding the hardware queue to the wait
-- 
2.43.0


