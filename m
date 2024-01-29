Return-Path: <linux-kernel+bounces-42387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BE128400A3
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 09:55:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEF32283A8B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 08:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A6B054F8E;
	Mon, 29 Jan 2024 08:55:00 +0000 (UTC)
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102A454F82
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 08:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706518500; cv=none; b=tumjvvdtgEep9ai6MwRA93/k22tWKJ/i6cEXq1MkEC2q3KXkfcsSJ6HYsOk+qnR1kFFQ9fGP6+JXJsc+PcmuzzatR620RymH5decBEAF2zgF4mfU5vSTiBa5lpxmgbV/6knNIJ405eDzMZQXXQJVRXeps//NH8vgsYpi2MGQChc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706518500; c=relaxed/simple;
	bh=Ey0T0NpVcUZVPAB7X0i7MndAEhRfLqJyUuHr9Wwueak=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PVVCCh2oDVV2QdoS7HZ4j+Whk9A8jQm8LHmO6yeMJBLstuM+vbMZHJt5GazGRCwtsuEbbwWgrSawxw8H/BMCWpTXinFbjACHLpvph6XpIfx0xL4FJUdjF9uDc6AdC+FWU4JJM76kpmri4fChSRYFJAMtH2bxOZ82fNjdQeH0L8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 40T8quam034189;
	Mon, 29 Jan 2024 16:52:56 +0800 (+08)
	(envelope-from Yi.Sun@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4TNhhL73qlz2S36N9;
	Mon, 29 Jan 2024 16:45:22 +0800 (CST)
Received: from tj10379pcu.spreadtrum.com (10.5.32.15) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Mon, 29 Jan 2024 16:52:53 +0800
From: Yi Sun <yi.sun@unisoc.com>
To: <stefanha@redhat.com>, <mst@redhat.com>, <jasowang@redhat.com>,
        <axboe@kernel.dk>
CC: <yi.sun@unisoc.com>, <sunyibuaa@gmail.com>, <hongyu.jin@unisoc.com>,
        <zhiguo.niu@unisoc.com>, <xuanzhuo@linux.alibaba.com>,
        <pbonzini@redhat.com>, <virtualization@lists.linux.dev>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH V2] virtio-blk: Ensure no requests in virtqueues before deleting vqs.
Date: Mon, 29 Jan 2024 16:52:50 +0800
Message-ID: <20240129085250.1550594-1-yi.sun@unisoc.com>
X-Mailer: git-send-email 2.25.1
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
X-MAIL:SHSQR01.spreadtrum.com 40T8quam034189

Ensure no remaining requests in virtqueues before resetting vdev and
deleting virtqueues. Otherwise these requests will never be completed.
It may cause the system to become unresponsive.

Function blk_mq_quiesce_queue() can ensure that requests have become
in_flight status, but it cannot guarantee that requests have been
processed by the device. Virtqueues should never be deleted before
all requests become complete status.

Function blk_mq_freeze_queue() ensure that all requests in virtqueues
become complete status. And no requests can enter in virtqueues.

Signed-off-by: Yi Sun <yi.sun@unisoc.com>
---
 drivers/block/virtio_blk.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 3b6b9abb8ce1..14ecc14ce8db 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -1595,14 +1595,15 @@ static int virtblk_freeze(struct virtio_device *vdev)
 {
 	struct virtio_blk *vblk = vdev->priv;
 
+	/* Ensure no requests in virtqueues before deleting vqs. */
+	blk_mq_freeze_queue(vblk->disk->queue);
+
 	/* Ensure we don't receive any more interrupts */
 	virtio_reset_device(vdev);
 
 	/* Make sure no work handler is accessing the device. */
 	flush_work(&vblk->config_work);
 
-	blk_mq_quiesce_queue(vblk->disk->queue);
-
 	vdev->config->del_vqs(vdev);
 	kfree(vblk->vqs);
 
@@ -1620,7 +1621,7 @@ static int virtblk_restore(struct virtio_device *vdev)
 
 	virtio_device_ready(vdev);
 
-	blk_mq_unquiesce_queue(vblk->disk->queue);
+	blk_mq_unfreeze_queue(vblk->disk->queue);
 	return 0;
 }
 #endif
-- 
2.25.1


