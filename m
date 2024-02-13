Return-Path: <linux-kernel+bounces-62745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BDDE85252D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 02:08:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67D2F1C23F1E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 01:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ACEC12EBD5;
	Tue, 13 Feb 2024 00:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mWwZ6cRf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F65D12F380;
	Tue, 13 Feb 2024 00:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707783867; cv=none; b=Hajq6SyCtxfuX5tioCSkmCMKMXWoC7Lsj1OkF0omCD/Y8W35RCOCY4tcZ7UD2zM6NVg1TU+gIJMaiyoZnjZgSSpz5nrklz1qydVbmBee+H7D/j/FjPDRz63aBJRLpyx1onYUJ3AZrxYfoWCwv71tM9HaiA9G+9PCaZK0vSmWUaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707783867; c=relaxed/simple;
	bh=OhKIQUuRvOy0Ab3y4ndKW6oIXyn1TWNkCN+IvJ96nh4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=icvWtviVzPxztpgl45aW9uCS5/2FpocvgPMTZd45gBM9ZkCLX6MqT6o2pMmdSrSRA7Phdw+idlDVu6nE1VqJ14Hh29iSyw6hSZpaHyD6NLtYpLA0+KJA7l3u3Bx6H2hlZfgyrbKOkN+wxqivCEA7s/jB8RK9UICpBwP6IYFYuXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mWwZ6cRf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F9BCC433F1;
	Tue, 13 Feb 2024 00:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707783867;
	bh=OhKIQUuRvOy0Ab3y4ndKW6oIXyn1TWNkCN+IvJ96nh4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mWwZ6cRffKbKkAsFsJWZ06ADX3HHsRcHUYJ+wriFefhM7ImOXwsCVB21dy9jF4PWs
	 43RqLDlPXjph7MiE5vPV0ReWqz6bU9e1tONdbubeIPm+7DMdYFZP0FdcclZLKktrhD
	 a1FtgUdHpV2IiCXM/+LFZhhOOsx9GyYT7d17n1QeMyAV5rc1bIox4An6sSYytvSfOc
	 juursVCXbj8gKoG9xOVEEr32RPatlEmF+ckW1QEhJ2zV6nMfJEHD2lIXDhzbpXNB65
	 zgWJjeZf5c4pNvg8r+a3KtSdnFpiHsafCW6dXuOEmPO136fdDifIUCtIH8p74k1o29
	 fzfQkvY+AyS0w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Yi Sun <yi.sun@unisoc.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>,
	mst@redhat.com,
	jasowang@redhat.com,
	virtualization@lists.linux.dev,
	linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 4/4] virtio-blk: Ensure no requests in virtqueues before deleting vqs.
Date: Mon, 12 Feb 2024 19:24:19 -0500
Message-ID: <20240213002420.673218-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213002420.673218-1-sashal@kernel.org>
References: <20240213002420.673218-1-sashal@kernel.org>
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

From: Yi Sun <yi.sun@unisoc.com>

[ Upstream commit 4ce6e2db00de8103a0687fb0f65fd17124a51aaa ]

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
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Link: https://lore.kernel.org/r/20240129085250.1550594-1-yi.sun@unisoc.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/virtio_blk.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 9b3ea86c20e5..3afc07b59477 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -1063,14 +1063,15 @@ static int virtblk_freeze(struct virtio_device *vdev)
 {
 	struct virtio_blk *vblk = vdev->priv;
 
+	/* Ensure no requests in virtqueues before deleting vqs. */
+	blk_mq_freeze_queue(vblk->disk->queue);
+
 	/* Ensure we don't receive any more interrupts */
 	vdev->config->reset(vdev);
 
 	/* Make sure no work handler is accessing the device. */
 	flush_work(&vblk->config_work);
 
-	blk_mq_quiesce_queue(vblk->disk->queue);
-
 	vdev->config->del_vqs(vdev);
 	kfree(vblk->vqs);
 
@@ -1088,7 +1089,7 @@ static int virtblk_restore(struct virtio_device *vdev)
 
 	virtio_device_ready(vdev);
 
-	blk_mq_unquiesce_queue(vblk->disk->queue);
+	blk_mq_unfreeze_queue(vblk->disk->queue);
 	return 0;
 }
 #endif
-- 
2.43.0


