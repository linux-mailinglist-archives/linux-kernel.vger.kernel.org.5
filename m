Return-Path: <linux-kernel+bounces-62752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ECB5C852543
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 02:09:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B5541C2404D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 01:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4428E131E40;
	Tue, 13 Feb 2024 00:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S1gUXy5l"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C44912FF9F;
	Tue, 13 Feb 2024 00:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707783874; cv=none; b=MMF1q11CdVHRzoeXCDwfx7T3lB3czQ3U3gnMv7pJftmOGlCqZlTb9j6sDkc/t8SOmiC2mKDDifWvAHCm/iDP79eDJAT7wdd+zePD+EK6+J2kiPYg0tyZhmd/SN8f+IyNxNKGpY7wXDnJ1xgCdRsIZtv/wbROEefg64QYTM34PKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707783874; c=relaxed/simple;
	bh=rhuXYerQHZC6UdHTJf1qEji2BMPpaTsxTWmwvNQMbHk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hSgAOhjizfoFQyZxkB42xLaul7KmaVDg0acqqPJCgpelLUywOYYep++Zho9fTaDgFWMy5zR0ofUcrqHwR5+w2yhvZOu0+3yxXGFjUeajPGFoDRfV1elVJBnkqXcF0z+FrsbIhKNEX0hwmqPRe956QNtHcz+T0xgtEuCgUhpx4Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S1gUXy5l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40C9BC43394;
	Tue, 13 Feb 2024 00:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707783873;
	bh=rhuXYerQHZC6UdHTJf1qEji2BMPpaTsxTWmwvNQMbHk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S1gUXy5lOylZdSHvxcfIf2aVxOjtEx73dhjU2zGH1g9Lb9gtj0WWNQ6t7RHtgf4AL
	 +E13ZpiikSKofvZBkhZOBtH35VWKwuEEsnG6J8GJBT6TsJhLOZ03KP5L6CvsBEVisS
	 BoseR6CUlIXvGCSzihlNoRXgIAiZPrLHYtbjHi7WDtD05pfa6GDUKG/jMUihnuy/C+
	 AA4wZgws/TQypi+KI/qiQMbK+ed27jw08si4762tYhtQn0TmqzZjIjhVKVNbjxWqSv
	 NZWLnG5FqtmqcBmKdL+zFFMnWfrLocWp/JA3iPQCPJoYepfgtlA5UZMLww51SoBkZ0
	 ui6DNZax7xf3Q==
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
Subject: [PATCH AUTOSEL 4.19 3/3] virtio-blk: Ensure no requests in virtqueues before deleting vqs.
Date: Mon, 12 Feb 2024 19:24:27 -0500
Message-ID: <20240213002428.673310-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213002428.673310-1-sashal@kernel.org>
References: <20240213002428.673310-1-sashal@kernel.org>
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
index 8b3bf11329ba..8e4c431efc6c 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -943,14 +943,15 @@ static int virtblk_freeze(struct virtio_device *vdev)
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
 
@@ -968,7 +969,7 @@ static int virtblk_restore(struct virtio_device *vdev)
 
 	virtio_device_ready(vdev);
 
-	blk_mq_unquiesce_queue(vblk->disk->queue);
+	blk_mq_unfreeze_queue(vblk->disk->queue);
 	return 0;
 }
 #endif
-- 
2.43.0


