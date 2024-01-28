Return-Path: <linux-kernel+bounces-41811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EC0783F7F6
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 17:45:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E200B21196
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 16:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A866513F00C;
	Sun, 28 Jan 2024 16:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PFZo/C3x"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58B913F014;
	Sun, 28 Jan 2024 16:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706458583; cv=none; b=rocPlSWUqvS/frsgmkaelaxhnSArHu5jAqB44ZNxdExwsaZ04CPCd+eKVEPrs6UFQrSzlFrkd8s6XMg9kyDsr33irgoG5Am31fcy7mYL6PSEpRUzFiGpI0PgK63EjEVyfKMT5xu9uDCqDonzqFk1CMN8TtURClr4SsBE3bfLtpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706458583; c=relaxed/simple;
	bh=0ujvYYxX0KeDNDaoU4XLyQqmECiurI/N8D3XbwxYNWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nNcbHDwuF6JxrBoQW5+tKF93jR5a5MafbDdxIk5ojYYcTXLLQAqlJsTLI/Glro2NJc8+gb1DqUdvtGiAo4FytKHZ+Djmfnfy7N6CKpPTYn4JAL1FrphyxcQa6My5vM+BUZQNgqIevBbREg8/owNhdD6D5vToTbms2Q/r3BSMcyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PFZo/C3x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6CF7C43390;
	Sun, 28 Jan 2024 16:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706458583;
	bh=0ujvYYxX0KeDNDaoU4XLyQqmECiurI/N8D3XbwxYNWQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PFZo/C3xzxNMHdFPtd+sH2Zes185ewXmLcLOr3Z5yqCrWU3x+2agpPuM59NuOmhKW
	 wPg3BRl4RfzWFAocCUZU3AkSmMdPRQLxyFpVsK18RM/jPjsLK4BBx1oeu8X0r/XXcp
	 3WDfG9DZLi8Wr9R6FAWJ33udsZv7xgXvfg8PZpQDE04EL5zTOCHKmF3T+ZhOPVCa6y
	 KgK4rdW6mxwW46SWUnrhD3FADVnzRmagfH2l9EMlNCFDujsv7K0jnzj42qJ01hegZ3
	 EIBklXScQS0GZic0iWN/1gn7SIsBQHrS72lNEKY3pUV8Ap6TwsYP3w9Sjl3VRCE8Ng
	 tQa1N/ZA20Ybg==
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
Subject: [PATCH AUTOSEL 5.10 10/13] blk-mq: fix IO hang from sbitmap wakeup race
Date: Sun, 28 Jan 2024 11:15:56 -0500
Message-ID: <20240128161606.205221-10-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240128161606.205221-1-sashal@kernel.org>
References: <20240128161606.205221-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.209
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
index e153a36c9ba3..a7a31d7090ae 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1188,6 +1188,22 @@ static bool blk_mq_mark_tag_wait(struct blk_mq_hw_ctx *hctx,
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


