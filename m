Return-Path: <linux-kernel+bounces-62741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E50FF85251B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 02:07:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97A911F21762
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 01:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDC5528DB7;
	Tue, 13 Feb 2024 00:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="grv68P33"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F30D912D767;
	Tue, 13 Feb 2024 00:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707783860; cv=none; b=ck9owwryqBj4oi1rBv7ADRh/vVobE4zLddG9BOkThQC+KVYYfT57iZRNqzKZ9w/8F/1y6wWX2Zp5kt9aGs1zXhJ3yZ61+LYVPxJVq0aAV3nrn8UtMnZ0wCp5Vm2FGsMofP5bDiUkS/YLh7kaDji/IPJ3sWWhW2HqC8I+UwO3rXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707783860; c=relaxed/simple;
	bh=2mJR77cck9kn+VOxlHplT8gY5hst9Ugn7jOmNihCpxQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=upq/d9purSuRE+thzor4aH6IZGmRE4t+xbatUioLdFLmfAXp70CgqbdPz7bV5nFCf+0fxfCF+1aqncsgqBS63/fMjeECZP4BTIQc5UrOFB446szZZDAY/2YGxYaC/5/noL4x/gKW1+2sNrnoj5oyN91IMB449g88MVD6TQ1luoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=grv68P33; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 384F2C43609;
	Tue, 13 Feb 2024 00:24:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707783859;
	bh=2mJR77cck9kn+VOxlHplT8gY5hst9Ugn7jOmNihCpxQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=grv68P33V82secXx5wOSwNsNDHGJTE9LzPKBOrwDXMpD/CeKAe3T+v1CJIkveLm/F
	 LKnVhkRd/WO++SETq4WrpAne+mfN68yUij6JTCvp/KK+ShVm0bHJr74svRuvptMjgU
	 F/GSvCO94aCE8yuNY0ceewesZwBZ/FCVlseJTcCSy9l9fOPGE5weLy2CmcZwubdMkC
	 mZSHa+TJ5sGUiVpjMLUr1Z5U1OUZJwJaA6RAspyn6j86u3s2u3zrRATvyfSuLTIddS
	 BZbNI4fU9/yhWZWl9W2XD99LPcxqVgXLAFP7WzxPMmQtkJ70j6qVspyOWcH9t66zl+
	 SyytO0MMhYqnA==
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
Subject: [PATCH AUTOSEL 5.10 6/6] virtio-blk: Ensure no requests in virtqueues before deleting vqs.
Date: Mon, 12 Feb 2024 19:24:08 -0500
Message-ID: <20240213002409.673084-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213002409.673084-1-sashal@kernel.org>
References: <20240213002409.673084-1-sashal@kernel.org>
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
index 9b54eec9b17e..7eae3f373233 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -952,14 +952,15 @@ static int virtblk_freeze(struct virtio_device *vdev)
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
 
@@ -977,7 +978,7 @@ static int virtblk_restore(struct virtio_device *vdev)
 
 	virtio_device_ready(vdev);
 
-	blk_mq_unquiesce_queue(vblk->disk->queue);
+	blk_mq_unfreeze_queue(vblk->disk->queue);
 	return 0;
 }
 #endif
-- 
2.43.0


