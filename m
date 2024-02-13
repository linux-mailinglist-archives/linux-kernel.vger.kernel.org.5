Return-Path: <linux-kernel+bounces-62711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3001F8524AB
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 01:57:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C51E2B26E2B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 00:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B79A284FB0;
	Tue, 13 Feb 2024 00:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ESADVmR4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB7084A2B;
	Tue, 13 Feb 2024 00:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707783803; cv=none; b=S4CiE+0NNlA8tp5pGIFnx2hnG5MEtgV14cW3s/0aTLMXxLvqwUzwO+9Lqpa2guLWhLTOKnTutQDbCQynoFPiNIctO5CxcHFUZlM0mb/+8FqbxULXKRXmHWvXXJ7cjPgI03mdUX0+CaMozu8S/vZg5ZQ0ni7iTjnJ07CooBv2jpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707783803; c=relaxed/simple;
	bh=ee/Eq08r7U8onjKVLB5ysFDesQFgbqc77E/WGIAnGyA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CQxfMv4qF4DNhM+yiFtUGNPlBYRrUzP0n7JAVPVfY3m96ZxPwqmcuZAZWfMyUHvDo+WxC9pXffuvLveEPv3CYBQnuvL7h4o5y79Cq4moCBEyppJU4jocpbVy2GLt5AerKKhk7q33ZMx+tg9bKhj5jPowc72gMQou5smKI2/ci/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ESADVmR4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A965C43390;
	Tue, 13 Feb 2024 00:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707783802;
	bh=ee/Eq08r7U8onjKVLB5ysFDesQFgbqc77E/WGIAnGyA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ESADVmR492P/YybK+D+ARZhXlNd60MCBNhqESBdzgiI67NQa2BhBxHC4x+ZE/LEmj
	 +OHruH46JW8WO3KszXq+KZcJTUnvKIb5GBmVR4wZHtgPViAmzymhoMNlvE2Iv3bAKR
	 nMkQlxDHD1Uv98lB0GQG5E2PbdTgaqkaP5qRqhkH/9nAFUn+cZxxNpRP+Q+wgkOFQV
	 qilX/ZRmZEKzGKCgSdN4k3VgqhRIeaCs3p4ZBBpcIAwcV8Vfjt71C1cnDXDCWuCCXZ
	 tVrsqzP9R1qwW+Yqu1AOydj2uXGt/gpJZzbwPX8rHU4ZkDh7ffktX/hkpHBEU0wNCz
	 FEjOxgiOrMwqQ==
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
Subject: [PATCH AUTOSEL 6.1 27/28] virtio-blk: Ensure no requests in virtqueues before deleting vqs.
Date: Mon, 12 Feb 2024 19:22:25 -0500
Message-ID: <20240213002235.671934-27-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213002235.671934-1-sashal@kernel.org>
References: <20240213002235.671934-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.77
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
index 3124837aa406..505026f0025c 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -1206,14 +1206,15 @@ static int virtblk_freeze(struct virtio_device *vdev)
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
 
@@ -1231,7 +1232,7 @@ static int virtblk_restore(struct virtio_device *vdev)
 
 	virtio_device_ready(vdev);
 
-	blk_mq_unquiesce_queue(vblk->disk->queue);
+	blk_mq_unfreeze_queue(vblk->disk->queue);
 	return 0;
 }
 #endif
-- 
2.43.0


