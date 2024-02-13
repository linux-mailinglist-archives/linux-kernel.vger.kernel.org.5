Return-Path: <linux-kernel+bounces-62628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A1128523CE
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 01:34:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 759A61C233F9
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 00:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18649881F;
	Tue, 13 Feb 2024 00:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A8CWwym0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5494D5D749;
	Tue, 13 Feb 2024 00:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707783623; cv=none; b=OGkmniUeo7v183iq2FwV87FAvarMhJcichqWeCv6eVVDHapLhLGfRwT7TwjJbPGmkltPhricLdD0rebFQXchwq1JP7AnKIHdux0TydvO8jWbVJrr9fypqerPchCF2Dl1j62ZptAEo2zKnECZ/3lmah5H4u1FYv0qHZ4hf7d3GNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707783623; c=relaxed/simple;
	bh=RUw+Lrn+hYakxPwf2kpbwf2NH6esgFNh3V7fQji7uFQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I6n/YCXob+E2GLMn44yQRD6euByrUkbVq/6Sb6XMym/KxIq/ul042M64rNZBoeXWmo9xLqukftiho9iBTrkUI+sBqO0zzj02OScxwUg2LKWN2ZKegXphVy6d8SiZ7925Z38KSqPNah23cagTNlJChKJCj78mHiwyMuZ5gZqvjPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A8CWwym0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0628C43394;
	Tue, 13 Feb 2024 00:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707783622;
	bh=RUw+Lrn+hYakxPwf2kpbwf2NH6esgFNh3V7fQji7uFQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A8CWwym008fmnj57m0CtB5CyxwO3EKoB1wxEslaT7a1H+3GvHgtB2E1zwlzoFnPxI
	 EvqR3zFJnR37ek/Xm1YJz+rZgiM1Ofs9nhtJxB0QgqVTpsmsxUIrlEgAOAkeFVwEcY
	 R+x1tTwPrVYf8wqzVD4lIFRQviMrrzWifkAtTdG0LKsmk26G+FXskfRV20meauvF6w
	 FvUQALT0oWJooiwJw1NUJMs0dUnyIpcABkAoatKoDjH3V6buxImF2ibGtWM/qLXQOi
	 IE8Rnq9gdYhnPNDQcglSuMAJG7OmaX2N14ETtTu1bN6ywIVyUg3KjWv4ThzPPnaJmi
	 rcNx02NJ8P7RQ==
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
Subject: [PATCH AUTOSEL 6.7 55/58] virtio-blk: Ensure no requests in virtqueues before deleting vqs.
Date: Mon, 12 Feb 2024 19:18:01 -0500
Message-ID: <20240213001837.668862-55-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213001837.668862-1-sashal@kernel.org>
References: <20240213001837.668862-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.4
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
index 47556d8ccc32..2c846eed5a2a 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -1627,14 +1627,15 @@ static int virtblk_freeze(struct virtio_device *vdev)
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
 
@@ -1652,7 +1653,7 @@ static int virtblk_restore(struct virtio_device *vdev)
 
 	virtio_device_ready(vdev);
 
-	blk_mq_unquiesce_queue(vblk->disk->queue);
+	blk_mq_unfreeze_queue(vblk->disk->queue);
 	return 0;
 }
 #endif
-- 
2.43.0


