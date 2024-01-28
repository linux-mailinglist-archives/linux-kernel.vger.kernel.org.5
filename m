Return-Path: <linux-kernel+bounces-41831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E46783F82F
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 17:50:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0B231C21E39
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 16:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12EDC2E633;
	Sun, 28 Jan 2024 16:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KFToCTJe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE5F524A2;
	Sun, 28 Jan 2024 16:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706458636; cv=none; b=HjLCPTpVkZTQmUGcsicA1xdGj7tpDhDQfzDRD5qAPFF0c2Hzfp2wPQ4JrVKrHeZwoM4oWUB1raY1tD7qXWPGLT7Sgps06xMl7ycmpD1JTfVsN/X2CRJrwYMpm3uAmYhybcnRhJ0N/dH6jXMrf3jzPKV6lyrX/vBt3R/M2IwYlCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706458636; c=relaxed/simple;
	bh=76J1OpPZEDhDhLfl2S4BMXsylw8T+SlH2hIp+v1g98c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iEJyFqeVDW8PAH9GvU+vXEhJkZTDRify+Mum5rXGbEp5f8i+Aw1rH0NN+0287Uvra4dVjDS4lwKJfrVj7ADVc3s1zJaty634oeVuP60dnRJ5dqIIKgOzed17Zl2cUI6JbH21Fnio1apFxyEIoa3JunmSN4PyHW27yVpQC3+kdJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KFToCTJe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23DB4C43390;
	Sun, 28 Jan 2024 16:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706458636;
	bh=76J1OpPZEDhDhLfl2S4BMXsylw8T+SlH2hIp+v1g98c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KFToCTJeuLVqmoH/C2p6JrS//BhyqliuGeobjfA6SdjsoGz4rvKz86ykX2cHg11vC
	 PGB3cIpIZ0MqadPQ7h6Rpw4fTfTFvM9IL7HEYaDAbU2quFE9vNh86L9rUtZtSlFQFc
	 bBAZUQxCOf+sEAGqx4B6HdEwo703O7uylKXm7fUmrR0X2CkfzMZXc1yD/Tow5LJB/q
	 vpSCcrwKgYhE2DV9Ps/urozkizAJjh0gDVp0iF50K5iRT4RTQ1UotcxeuNrPbe7Pgu
	 a6DC4L8yqz75NEpwrQT5iqoGTCkRlZedISpA+J6g54mm4GybOMn+Padfl2IiGf98yG
	 EyTVn6Fw7zXrg==
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
Subject: [PATCH AUTOSEL 4.19 6/8] blk-mq: fix IO hang from sbitmap wakeup race
Date: Sun, 28 Jan 2024 11:16:57 -0500
Message-ID: <20240128161704.205756-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240128161704.205756-1-sashal@kernel.org>
References: <20240128161704.205756-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.306
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
index ae70b4809bec..0cb559d63998 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1064,6 +1064,22 @@ static bool blk_mq_mark_tag_wait(struct blk_mq_hw_ctx *hctx,
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


