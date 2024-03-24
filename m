Return-Path: <linux-kernel+bounces-113989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3EF08887BF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:09:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 538E21F26331
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43D92156C57;
	Sun, 24 Mar 2024 23:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="naQFo45X"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5DAF1F30A7;
	Sun, 24 Mar 2024 22:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321118; cv=none; b=VV9Y/5mExe+Q1S/qyIbMIUgSAPF3ZaIijIwXIiwr8aGYmPCB9i4AAYrCajjU0mL8Jtvrw3KQ6IxrWd2A8I4hKVl0WMxEU0BIzINdJjSNd66SmnnafZMD0jJlwkft0l2Cza4/ZJhU33upfTc+8yEFbg+dBDVF1j1aLaVjGKO2nS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321118; c=relaxed/simple;
	bh=rbPa+Ctn/YI4xgNS41/BQYk1owmjhkNPLW58UozUyrQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NqozQHUUqE0Js7XnI/SlKy2NJ/CXyo4qyuCihPyAIGpl6nT+5lBV51Jw9aeBLxhH+rnDS8oWaqJDSNt+P33stD/iEUuCi+JGXg7vS0e2pwBFuZrBFMgrpyrzGSgpRjzzeJu+NLATf3MbwEMtezV809d2cutO8mMDhHIQjXWKED0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=naQFo45X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 034F2C433C7;
	Sun, 24 Mar 2024 22:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321117;
	bh=rbPa+Ctn/YI4xgNS41/BQYk1owmjhkNPLW58UozUyrQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=naQFo45XMN9xe/Tx6qhw+t7NesoY0H+EJyHW5i26QtpKOUOaDUL8ASKNjzzKpcTqL
	 DED5xw0geAkoEkNWT5vMt80Pj4Dy6fA/r3x/ahq6qtZQaC2o/0udbFquIWdIRycV5M
	 CXjPl5Xvzk3y/BVwpF8DHp4majxWDNey65Nnil291pr6i2Mn52a6+ybyY4U/OKxNzg
	 Foid6kT4XnVr5+KkOzqPpf+6nnSTNQzW6fhI4sjQhYBhuEfMjmersVO21ckNIWQgwk
	 s2iu82Nr7EvDi4hsCg2xOJs9dbe4qDvVSdUqg7XpNLlM5a9pMsHWwKx4R6tA37C2De
	 z6E77XjpOWHeg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 679/713] virtio: packed: fix unmap leak for indirect desc table
Date: Sun, 24 Mar 2024 18:46:45 -0400
Message-ID: <20240324224720.1345309-680-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
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


