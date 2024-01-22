Return-Path: <linux-kernel+bounces-32868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42A9D836120
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 12:21:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75DB71C24A9B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 11:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAC3B3D545;
	Mon, 22 Jan 2024 11:08:12 +0000 (UTC)
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A2973D0CD
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 11:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705921692; cv=none; b=eJFbTRvlyREZ00TMUJ2XMWc0l97MEMv+6XmVqlbL++56uvJ6HYE7TURUUJDhhQvaFi67kECYVddVUWy16bwvbd1n/PkwU6poPRzWAnm20VHWYSy1xgJ04yV3NvQQeSLcfRLIASJRQ4L4jvd07QPGKRaiwEC5RYsLejZd8ZnBqzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705921692; c=relaxed/simple;
	bh=rWMK0pbuU1ZlChY6naEC8iRYEsHXpak4RN0IB7hiFh0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VnBvw5QNSJeZJWLb7SkIOYzu+Y4N4X6n6tU7TbQ7zv8FIJRyZwJxQYh38omM2abeg8Os01ig+2ZRNqzYJzYjXA5TYTUCyzb23WS4qIKeNBonClk+vZQTSlb+vUoC4GK2GW/PkkuLMubVS1TRNYSc+eoSSEcohNzM8OyTdCNe6Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 40MB7RJT062284;
	Mon, 22 Jan 2024 19:07:27 +0800 (+08)
	(envelope-from Yi.Sun@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4TJS1431Ncz2S70L7;
	Mon, 22 Jan 2024 19:00:08 +0800 (CST)
Received: from tj10379pcu.spreadtrum.com (10.5.32.15) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Mon, 22 Jan 2024 19:07:26 +0800
From: Yi Sun <yi.sun@unisoc.com>
To: <axboe@kernel.dk>, <mst@redhat.com>, <jasowang@redhat.com>
CC: <xuanzhuo@linux.alibaba.com>, <pbonzini@redhat.com>, <stefanha@redhat.com>,
        <virtualization@lists.linux.dev>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yi.sun@unisoc.com>,
        <zhiguo.niu@unisoc.com>, <hongyu.jin@unisoc.com>,
        <sunyibuaa@gmail.com>
Subject: [PATCH 1/2] blk-mq: introduce blk_mq_tagset_wait_request_completed()
Date: Mon, 22 Jan 2024 19:07:21 +0800
Message-ID: <20240122110722.690223-2-yi.sun@unisoc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240122110722.690223-1-yi.sun@unisoc.com>
References: <20240122110722.690223-1-yi.sun@unisoc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL:SHSQR01.spreadtrum.com 40MB7RJT062284

In some cases, it is necessary to wait for all requests to become complete
status before performing other operations. Otherwise, these requests will never
be processed successfully.

For example, when the virtio device is in hibernation, the virtqueues
will be deleted. It must be ensured that virtqueue is not in use before being deleted.
Otherwise the requests in the virtqueue will be lost. This function can ensure
that all requests have been taken out of the virtqueues.

Prepare for fixing this kind of issue by introducing
blk_mq_tagset_wait_request_completed().

Signed-off-by: Yi Sun <yi.sun@unisoc.com>
---
 block/blk-mq-tag.c     | 29 +++++++++++++++++++++++++++++
 include/linux/blk-mq.h |  1 +
 2 files changed, 30 insertions(+)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index cc57e2dd9a0b..cb0ef5f66c61 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -479,6 +479,35 @@ void blk_mq_tagset_wait_completed_request(struct blk_mq_tag_set *tagset)
 }
 EXPORT_SYMBOL(blk_mq_tagset_wait_completed_request);
 
+static bool blk_mq_tagset_count_inflight_rqs(struct request *rq, void *data)
+{
+	unsigned int *count = data;
+
+	if (blk_mq_request_started(rq) && !blk_mq_request_completed(rq))
+		(*count)++;
+	return true;
+}
+
+/**
+ * blk_mq_tagset_wait_request_completed - Wait for all inflight requests
+ * to become completed.
+ *
+ * Note: This function has to be run after all IO queues are shutdown.
+ */
+void blk_mq_tagset_wait_request_completed(struct blk_mq_tag_set *tagset)
+{
+	while (true) {
+		unsigned int count = 0;
+
+		blk_mq_tagset_busy_iter(tagset,
+				blk_mq_tagset_count_inflight_rqs, &count);
+		if (!count)
+			break;
+		msleep(20);
+	}
+}
+EXPORT_SYMBOL(blk_mq_tagset_wait_request_completed);
+
 /**
  * blk_mq_queue_tag_busy_iter - iterate over all requests with a driver tag
  * @q:		Request queue to examine.
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index a676e116085f..17768e154193 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -891,6 +891,7 @@ void blk_mq_run_hw_queues(struct request_queue *q, bool async);
 void blk_mq_delay_run_hw_queues(struct request_queue *q, unsigned long msecs);
 void blk_mq_tagset_busy_iter(struct blk_mq_tag_set *tagset,
 		busy_tag_iter_fn *fn, void *priv);
+void blk_mq_tagset_wait_request_completed(struct blk_mq_tag_set *tagset);
 void blk_mq_tagset_wait_completed_request(struct blk_mq_tag_set *tagset);
 void blk_mq_freeze_queue(struct request_queue *q);
 void blk_mq_unfreeze_queue(struct request_queue *q);
-- 
2.25.1


