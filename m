Return-Path: <linux-kernel+bounces-115743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 037FC88975C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:14:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABAF51F383A8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E18C25F09B;
	Mon, 25 Mar 2024 02:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LGsKbzye"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA52156862;
	Sun, 24 Mar 2024 23:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321880; cv=none; b=ujWoLzacoFUW+Ccj68IM3cWjQgpLMdRyJ1yUoJG7wbdTkPPM4rgEQ/vIXjJdwQMIbo7USi4zTujX1SGIqnWtpXeRhPDFY87K7Qx40u5ghGTw++uf1D83tlyfpON5T6BNzLNTIgCAPG6Oyc4NrLEgJe3AdZrtNh7yinWKVkGrO5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321880; c=relaxed/simple;
	bh=rbPa+Ctn/YI4xgNS41/BQYk1owmjhkNPLW58UozUyrQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JCIu835tg94Dj8mMlb9HPEG6UyeSjYvhCQs26AIcm4O49HtTNwRZSRDRASefgx9fCRc5Xzg9/onxAHY4ZJK171XO4aqHiXXb9gKSXVD0dr3hMYSzeAzEj8S0FGyPkqHRVoEyKuvWK+MOCZAOXWmi3PT45YCvmJXPdo5MHRkwXgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LGsKbzye; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D678C433F1;
	Sun, 24 Mar 2024 23:11:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321880;
	bh=rbPa+Ctn/YI4xgNS41/BQYk1owmjhkNPLW58UozUyrQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LGsKbzyeb7frF48g5njNLnK9/XS0EAq7Nm2PJ7r4YI6F0LudB+OzDXJT4NiazUFa8
	 jGWsyOPVHS6VcW7i39taxewBaqbryWXRfE21mREmPIGf2AyqQ0bW02M0cIMYAkfJ2g
	 FKx96slEGmBT3D5p5cxaqmVpOOC9xB/qcF9skRM7gBSsQrfVWtrjwzI40ZCdr9CcSq
	 jkPiAGnhTCSC/7m+dQ4yoLwLC/8CUvObRYwciSo3tnH2ZZExI+ZUPhuE3IxvKRUNPp
	 6ZBc8Hq3pw6HEWNFQN3A+UJHMX7DtjhR0/fVPlZLybwo5mFCxt7t17DhKG54Jgr0lx
	 GTovLAiWAvReA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 608/638] virtio: packed: fix unmap leak for indirect desc table
Date: Sun, 24 Mar 2024 19:00:45 -0400
Message-ID: <20240324230116.1348576-609-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

[ Upstream commit d5c0ed17fea60cca9bc3bf1278b49ba79242bbcd ]

When use_dma_api and premapped are true, then the do_unmap is false.

Because the do_unmap is false, vring_unmap_extra_packed is not called by
detach_buf_packed.

  if (unlikely(vq->do_unmap)) {
                curr = id;
                for (i = 0; i < state->num; i++) {
                        vring_unmap_extra_packed(vq,
                                                 &vq->packed.desc_extra[curr]);
                        curr = vq->packed.desc_extra[curr].next;
                }
  }

So the indirect desc table is not unmapped. This causes the unmap leak.

So here, we check vq->use_dma_api instead. Synchronously, dma info is
updated based on use_dma_api judgment

This bug does not occur, because no driver use the premapped with
indirect.

Fixes: b319940f83c2 ("virtio_ring: skip unmap for premapped")
Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Message-Id: <20240223071833.26095-1-xuanzhuo@linux.alibaba.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/virtio/virtio_ring.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 49299b1f9ec74..6f7e5010a6735 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -1340,7 +1340,7 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
 				sizeof(struct vring_packed_desc));
 	vq->packed.vring.desc[head].id = cpu_to_le16(id);
 
-	if (vq->do_unmap) {
+	if (vq->use_dma_api) {
 		vq->packed.desc_extra[id].addr = addr;
 		vq->packed.desc_extra[id].len = total_sg *
 				sizeof(struct vring_packed_desc);
@@ -1481,7 +1481,7 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
 			desc[i].len = cpu_to_le32(sg->length);
 			desc[i].id = cpu_to_le16(id);
 
-			if (unlikely(vq->do_unmap)) {
+			if (unlikely(vq->use_dma_api)) {
 				vq->packed.desc_extra[curr].addr = addr;
 				vq->packed.desc_extra[curr].len = sg->length;
 				vq->packed.desc_extra[curr].flags =
@@ -1615,7 +1615,7 @@ static void detach_buf_packed(struct vring_virtqueue *vq,
 	vq->free_head = id;
 	vq->vq.num_free += state->num;
 
-	if (unlikely(vq->do_unmap)) {
+	if (unlikely(vq->use_dma_api)) {
 		curr = id;
 		for (i = 0; i < state->num; i++) {
 			vring_unmap_extra_packed(vq,
-- 
2.43.0


